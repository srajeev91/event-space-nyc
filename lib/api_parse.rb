require 'rest-client'
require 'json'
require 'net/http'
require 'active_support'
require 'active_support/core_ext'
require 'pry'


def parse_api(link)
  data ={}
  raw_data = RestClient.get(link)
  data = JSON.parse(raw_data)
  # binding.pry
end


def nyartbeat_parse(geo , free=1)
  link = "http://www.nyartbeat.com/list/event_searchNear?latitude=#{geo['lat']}&longitude=#{geo['lng']}&MaxResults=10&SortOrder=distance&free=#{free}"
  s = Net::HTTP.get_response(URI.parse(link)).body
  # binding.pry
  data = JSON.parse(Hash.from_xml(s).to_json)
end

def address_to_geo(address)
  link = 'https://maps.googleapis.com/maps/api/geocode/json?address='
  key= '&key=AIzaSyB8y9s45xVG7OAhCdYa14p80sQBEiKEgV8'
  address = address.gsub(' ', '+')
  link = link + address + key
  # binding.pry
  data = parse_api(link)
  data['results'][0]['geometry']['location']
end

def geo_to_address(geo)
  link = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='
  key= '&key=AIzaSyB8y9s45xVG7OAhCdYa14p80sQBEiKEgV8'
  link = link + geo['lat'].to_s + ","+ geo['lng'].to_s + key
  data = parse_api(link)
  # binding.pry
  data["results"][0]["formatted_address"]
end

geo= {}
geo['lat'] = 40.719130
geo['lng'] = -73.980000
puts geo_to_address(geo)

puts address_to_geo("flatiron school, manhattan, new york")

# nyartbeat_parse