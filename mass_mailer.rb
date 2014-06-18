require 'rubygems'
require 'csv'
require 'mail'

options = { :address              	=> "mail.domain.co.uk",
            :port                 	=> 587,
            :domain               	=> 'mail.domain.co.uk',
            :user_name            	=> 'user@domain.co.uk',
            :password             	=> 'password1234',
            :authentication       	=> 'login',
            :openssl_verify_mode	=> "none" }

Mail.defaults do
  delivery_method :smtp, options
end

puts "Starting delivery..."

# Takes a CSV where the first column is an email address, and the second column is the first name in order to personalise the email.

CSV.foreach('otc.csv') do |row|
	Mail.deliver do
		to      row[0]
	  	from    'User Name <user@domain.co.uk>'
	  	subject 'Subject Line Here'

	  	text_part do
	      	body "Dear #{row[1]},
	      		Plain text email body here,
	      		Regards,"
	  	end

	  	html_part do
	      	content_type 'text/html; charset=UTF-8'
	      	body "<p>Dear #{row[1]},</p>
	      		<p>HTML email body here.</p>
				<p>Kind Regards,</p>"
	  	end
	end

	puts "- Email sent to contact #{$.} (#{row[0]}) successfully"
end

puts "All emails sent!"