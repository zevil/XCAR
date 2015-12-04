function handler( document )

	ExtratContentMain(document);
	ModifyField(document)

	return true
end

function ModifyField(document)

	B={}
	C={}
	f=io.open("C:/Users/yiwen/Desktop/test1.txt","r")
	local j=0
	for i in f:lines() do
		if j%2==0 then
			table.insert(B,i)
		elseif j%2==1 then
			table.insert(C,i)
		end
		j = j+1
	end
	
	--[[local brand = document:getFieldValue("BRAND")
	if brand ~= nil then
		a,b = string.find(brand, "论坛")
		if a ~= nil then
			brand = string.sub(brand, 1,a-1)
			document:setFieldValue("BRAND", brand)
		end
	end--]]
	
	local s_from = document:getFieldValue("FROM")
	if s_from ~= nil then
		s_from = string.gsub(s_from, "\r", "")
		s_from = string.gsub(s_from, "\n", "")
		s_from = string.gsub(s_from, " ", "")
		s_from = string.gsub(s_from, "<br>", "")
		a,b = string.find(s_from, "|")
		if a ~= nil then
			s_from = string.sub(s_from, 6, a-1)
		end
		document:setFieldValue("FROM", s_from)
	end	
	
	local forum = document:getFieldValue("FORUM")
	if forum ~= nil then
		a,b = string.find(forum, "坛，")
		if a ~= nil then 
			forum = string.sub(forum, 1, a+1)
			document:setFieldValue("FORUM", forum)
		end
	end
	
	local car = document:getFieldValue("CAR")
	if car ~= nil then
		a,b = string.find(car, "论坛")
		if a ~= nil then 
			car = string.sub(car, 1,a-1)
			document:setFieldValue("CAR", car)
			for i = 1, #C do
				a,b = string.find(C[i],car)
				if a ~= nil then
					d=i
					break
				end
			end
			document:addField("BRAND", B[d])
		end

	end
	
	
	
	local property = document:getFieldValue("PROPERTY")
	if property ~= nil then
		property = string.gsub(property, " ", "")
		property = string.sub(property, 6, -1)
		document:setFieldValue("PROPERTY", property)
	end
	
	local r_number = document:getFieldValue("REPLYNUMBER")
	if r_number ~= nil then
		r_number = string.gsub(r_number, "&nbsp", "")
		r_number = string.gsub(r_number, "\n", "")
		r_number = string.gsub(r_number, " ", "")
		r_number = string.gsub(r_number, "\r", "")
		r_number = string.gsub(r_number, "\t", "")
		r_number = string.gsub(r_number, ";", "")
		r_number = string.gsub(r_number, "：", "")
		--document:setFieldValue("REPLYNUMBER", r_number)
		a,b = string.find(r_number, "查看")
		if a ~= nil then
			r_number = string.sub(r_number, 5, a-1)
			document:setFieldValue("REPLYNUMBER", r_number)
		end	
	end
	
	local v_number = document:getFieldValue("VIEWNUMBER")
	if v_number ~= nil then
		v_number = string.gsub(v_number, "&nbsp", "")
		v_number = string.gsub(v_number, "\n", "")
		v_number = string.gsub(v_number, " ", "")
		v_number = string.gsub(v_number, "\r", "")
		v_number = string.gsub(v_number, "\t", "")
		v_number = string.gsub(v_number, ";", "")
		v_number = string.gsub(v_number, "：", "")
		--document:setFieldValue("REPLYNUMBER", r_number)
		a,b = string.find(v_number, "查看")
		if a ~= nil then
			v_number = string.sub(v_number, b+1, -1)
			document:setFieldValue("VIEWNUMBER", v_number)
		end	
	end
	
	local date = document:getFieldValue("POSTDATE")
	if date ~= nil then
		date = date..":07"
		document:setFieldValue("POSTDATE", date)
	end
	
	document:deleteField("ImportErrorCode")
	document:deleteField("ImportErrorDescription")
	
	return true
	
end


function ExtratContentMain(document)
	local content = document:getContent()
	
	content = string.gsub(content, ">760", "")
	--content = string.gsub(content, "\[.+", "")
	--content = string.gsub(content, "\d+\)[^>]*>", "")
	content = string.gsub(content, "&nbsp", "")
	content = string.gsub(content, " ", "")
	content = string.gsub(content, "\r", "")
	content = string.gsub(content, "\n", "")
	content = string.gsub(content, "\t", "")
	content = string.gsub(content,"本楼已被管理员删除查看回贴内容查看操作记录我要申诉用户名操作;","")
	content = string.gsub(content,"本楼已被自动过滤系统删除查看回贴内容查看操作记录我要申诉用户名操作;","")
	content = string.gsub(content,"本楼已被***删除查看回贴内容查看操作记录我要申诉用户名操作;","")
	content = string.gsub(content,"本楼已被管理员删除查看回贴内容查看操作记录我要申诉用户名操作[本帖最后由极度颓废之魂于2015-01-2616:19:43编辑];","")
	content = string.gsub(content, "<[^>]*>", "")
	--content = string.gsub(content, "\[.+", "")
	
--	content = convert_encoding( content, "UTF8")
	document:setContent(content)
	return true
end




