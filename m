Return-Path: <netdev+bounces-128178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1F97863B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F44282D46
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D7077F2F;
	Fri, 13 Sep 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inKosYRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108880BFC;
	Fri, 13 Sep 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246410; cv=none; b=KCs7pOJWOnFXJxZ3chuZkq3rhhFSQHx21oaMe1KX5kKIZVIA5fh3pcRotUFBk3YUeQYHbQRG3K3uqkiDJPztiNOdzFAMo4rjfvFNKIZ2rapoJhQ8WZhpmFmVZKw487eGvIVkTnHA6elqaxnwtgcGtEomf6I9j2Vhig/IF78quXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246410; c=relaxed/simple;
	bh=TdlLgZhGO9xImjCmzjx46hes1PZ1LbyBx74FptCBzYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5/JSfEboQyedqsU3S2mwkzzTrPgP2yalNOa+GQNfx1Ro2fCPWcm4Zt+R9SKjePpEoJzgRn34unbf28uEdlvHidQ/Ue2L2Go1G7B+MOmQN1WM1GsvwfwNAsB3Z6Gaa3RRLhhP0Em/4uqzu4ZN6s3CakL5yyhkI1hG0y+KLWmV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inKosYRu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1998106a12.1;
        Fri, 13 Sep 2024 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726246408; x=1726851208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hkVinr6MLPy9cHy7SDa9OE4uUcWlun5U1MjanWu09yo=;
        b=inKosYRuOR2eLbzEb+5JDJuBr7sPJ51MRGpeP9aq4Zj1iVTHScQl5A8MOT5luthF08
         Cu/tPLKVAH5NvrKp3kJzEfALJGgjcaBsj7CIB1MQbKN0VRf5yzXp7DKhuTtz3irl2WBh
         zZmVtoC8eyvvsvNqClAn1Ax9IulCKnN7qoMFbhMxb/ht9siGXd/6Zlopmxx0QaIQT8jA
         48sYUnz/bd9XtHE5ixjGhH5JjLBwj/XuowmUHvhIRbRrQHhEaVemykSwjjhIzFPj+Ie4
         t3AzoSDKBRrJOGlwpqAF1rb5J0NDX6Un/hyo/A1XHHxSXrX8bDfXfosNDU1Adq2xPdaS
         jCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726246408; x=1726851208;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkVinr6MLPy9cHy7SDa9OE4uUcWlun5U1MjanWu09yo=;
        b=A0Y/13vMLkANeaCe0omn2zVfDz0aAQjrOUghEk84Z2QolBg+oc1pA3gvlHo/eIJrr6
         CEK72Yn6mORvcM6g1WIiVW/ED0VLIRMljqgbzSZZsn5lEZfCWkxU1YO1zv4NhPc1Un8h
         C1hRgViiuA//Wu4kzNlE//wsS4Y6Sn6+kfnhP05JS+3I4QL3ALD/Aty7mVXnmSm0ZNNe
         WDHMRIGkriysWgK13my84RIvSsuqWzq1iuBfYm/PFsgYWee4bJdF0XsuhmGPC8JyX+MH
         LBM6Tif1lW+Nv5e146uOLGOTbV7xkEfJicYIig4CxkGIzXoNdcTwEp1vr5fPscEK9A2t
         h5dg==
X-Forwarded-Encrypted: i=1; AJvYcCVEEYfqRJud2Z1arO6vfFMqwaDz/UvTxmNgPO5CO+ra4RsQQspHi/5MQ11LAxYTqNmAkkIh3WVLCt9ezw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvxamzL4y8hsRuaXzaqLA92iV5+fymHZjB46EZDrtRzjF/7Gx
	r869+ZoMtkDC7j0/UFgLyh0GvfUJn8mpC3uLXyi83st22lSHExcV
X-Google-Smtp-Source: AGHT+IHfW0Nb8coci7Dej6GJSv2gE3tg0mxvjob/Vzmllc2i3FmnA/gN6Fx1wNvaNdYG/l1w3J7fbA==
X-Received: by 2002:a05:6a21:2d8b:b0:1cc:d9dc:5637 with SMTP id adf61e73a8af0-1cf758dd608mr11268384637.23.1726246408204;
        Fri, 13 Sep 2024 09:53:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090ad8casm6320441b3a.150.2024.09.13.09.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 09:53:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <153c5be4-158e-421a-83a5-5632a9263e87@roeck-us.net>
Date: Fri, 13 Sep 2024 09:53:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: Add hardware monitoring support
To: Andrew Lunn <andrew@lunn.ch>, Sanman Pradhan <sanmanpradhan@meta.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jdelvare@suse.com, horms@kernel.org,
 mohsin.bashr@gmail.com, linux-hwmon@vger.kernel.org
References: <20240913000633.536687-2-sanmanpradhan@meta.com>
 <29cc431c-0020-4546-8658-6f06d84aa84b@lunn.ch>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <29cc431c-0020-4546-8658-6f06d84aa84b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 06:28, Andrew Lunn wrote:
>> +static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
>> +{
>> +	if (type == hwmon_temp)
>> +		return FBNIC_SENSOR_TEMP;
>> +	if (type == hwmon_in)
>> +		return FBNIC_SENSOR_VOLTAGE;
>> +
>> +	return -EOPNOTSUPP;
>> +}
> 
>> +static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>> +			    u32 attr, int channel, long *val)
>> +{
>> +	struct fbnic_dev *fbd = dev_get_drvdata(dev);
>> +	const struct fbnic_mac *mac = fbd->mac;
>> +	int id;
>> +
>> +	id = fbnic_hwmon_sensor_id(type);
>> +	if (id < 0)
>> +		return -EOPNOTSUPP;
> 
> fbnic_hwmon_sensor_id() itself returns EOPNOTSUPP, so just use it.
> 
>> +void fbnic_hwmon_register(struct fbnic_dev *fbd)
>> +{
>> +	if (!IS_REACHABLE(CONFIG_HWMON))
>> +		return;
>> +
>> +	fbd->hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic",
>> +						     fbd, &fbnic_chip_info,
>> +						     NULL);
>> +	if (IS_ERR(fbd->hwmon)) {
>> +		dev_err(fbd->dev,
>> +			"Cannot register hwmon device %pe, aborting\n",
>> +			fbd->hwmon);
> 
> aborting is probably the wrong word, because you keep going
> independent of it working or not.
> 

I have not seen the original patch, and it doesn't seem to be available
on the networking mailing list, so I can not really comment on the patch
as a whole. For hwmon drivers in drivers/hwmon, I don't accept patches
with dev_err() which is then ignored ... because ignoring the error
means that it is not really an error. This should be dev_warn()
or better dev_notice().

Guenter




