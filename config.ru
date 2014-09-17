require 'yaml'
require 'erubis'

infos = YAML.load_file('infos.yml')

eruby = Erubis::Eruby.new(File.read('public/index.eruby')) 

use Rack::Static, 
  :urls => ["/assets"],
  :root => "public"

run lambda { |env|
  [
    200, 
    {
      'Content-Type'  => 'text/html', 
      'Cache-Control' => 'public, max-age=86400' 
    },
    eruby.result(binding())
  ]
}
