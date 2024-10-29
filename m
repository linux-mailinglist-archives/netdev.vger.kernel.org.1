Return-Path: <netdev+bounces-139988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C159B4EDE
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228961F23C5B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96455198E6E;
	Tue, 29 Oct 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDIImkMI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE7196DB1;
	Tue, 29 Oct 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217956; cv=none; b=Vkh6mc+BQsqsuCvxRM4qy6mXyK02XtUVzhJbNIN2eIRJqPcR0X+ahycDzSqFGPdGiDEnJvP5DCjc+Cz1tdbqoBeSgA84psUazOOud8+n7segn07FjMcvwEIgycyKD4s8mQaUvoVm3Jgtj44cFNZpnhK3wdmODWQAxqafFEGtZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217956; c=relaxed/simple;
	bh=Oqs1DFkDeB+oVDAFNnju+8u4mlvnvqc4EuY913y0JQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOXJlOUM8Y3jCC+dClUpyrkoZHlbxz7NviJ3HrzoR8YnWNFGgTLKQyvSsVNbfX+Vrc0MQ37zPs612PaJ+/RBuuFB3djoiHb8CcAoc6Da5e7NBPLPqTVlUwVTORbaf2n20G0SMg5o8lUNM/hFcaeQF5R7iFI0XqEBH762U47ehKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDIImkMI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b152a23e9aso431495585a.0;
        Tue, 29 Oct 2024 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730217953; x=1730822753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5brSZaOw+9ougvDAl9jlg7R1/aMH3wJP+fv0gISH6So=;
        b=DDIImkMIs25MbZIBqtr93qSdYw68/HA+tZOrl9dNkHxPNfchYSmNgHRK3LWwb3UlWH
         ndTU3tbskaEdwoq31N9s3wKksI3zPsG1W4klZaz9HKdPCGLjnMGjeBAM3dDQsEKHAWE6
         na0/jVjWq3WA3Pbip3gLslgg2XC/vh/W2pcN8LbbPqy2uCah4c5q4o6hZhBk1PO75bHx
         QQP5Eyr4tB0lFHHK3aCyuLdBrh6c5nstwIPY4nc2991dDcAs9lBYmu2rgiQ46QuvA22Z
         UmTXGhp/7gbtxTIOXVwQR9MgQtTojBMZcWlWG6tQKHZVivChFxDu3VVUIcOsAos1btNv
         iYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217953; x=1730822753;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5brSZaOw+9ougvDAl9jlg7R1/aMH3wJP+fv0gISH6So=;
        b=WEVVZgVgk1qsnkjKlcx9u1Q0YTqrH4Su5v0VE1hbedsSJArbuFPuSfuLooJivW+xj0
         Iy39k1qbrfytYn4XEmOKicLh6SD1oiHmzKT1uwSbfbFWT7BZd/3Lrk/4jRP00v6VqhfQ
         MtgoId9lpJfMsmUyWAlFo65Itkwzr44fVB6NT7v5Ahd3SurfKQB6rB0x+uRPK54gbjjl
         4X6r0RMkE+G2P9zIGddtGrl68nlqUzhdvTAUgVi3qnhpsZfHe3y4GgZRiOs4J4Ob+Ray
         UkdxiA7MSsgJoI59zNB+xNpsK6WXzUbVQehiubIclE5grWdnPvD7r+L2jzQyRYeJ33Vv
         Ddrw==
X-Forwarded-Encrypted: i=1; AJvYcCUbWtzkSNJJXJh+v4WVW0YXfiMW5wNkC6q3Z3eiQtvoelQYkifSKbzasqku7ayIEkkTFd0HJKjMnWFD1Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnuZrXfYznHO4awVbUUtc+SQa6mxBpArSoKx82MpNkGXV/XJ4
	CyLxBekk+OSLpfhJmSfG4/fcXo90bT9lUwgn89qkiPZ8acZKpL0M
X-Google-Smtp-Source: AGHT+IH5w/AG4xmtdASign0118O4/Vy2V70Zi0LgjdjsQ9t620Dw7nQQEsQ5WG8UM8tvvABF+DRPdQ==
X-Received: by 2002:a05:620a:4686:b0:7b1:1b47:213c with SMTP id af79cd13be357-7b193ee1bbemr1912180485a.10.1730217953377;
        Tue, 29 Oct 2024 09:05:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d3593e4sm427058085a.129.2024.10.29.09.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 09:05:52 -0700 (PDT)
Message-ID: <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
Date: Tue, 29 Oct 2024 09:05:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Remove self from DSA entry
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
 open list <linux-kernel@vger.kernel.org>
References: <20241029003659.3853796-1-f.fainelli@gmail.com>
 <20241029104946.epsq2sw54ahkvv26@skbuf>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCZtdNBQUJMNWh3gAKCRBhV5kVtWN2DhBgAJ9D8p3pChCfpxunOzIK7lyt
 +uv8dQCgrNubjaY9TotNykglHlGg2NB0iOLOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241029104946.epsq2sw54ahkvv26@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 03:49, Vladimir Oltean wrote:
> On Mon, Oct 28, 2024 at 05:36:58PM -0700, Florian Fainelli wrote:
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   MAINTAINERS | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f39ab140710f..cde4a51fd3a1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16031,7 +16031,6 @@ F:	drivers/net/wireless/
>>   
>>   NETWORKING [DSA]
>>   M:	Andrew Lunn <andrew@lunn.ch>
>> -M:	Florian Fainelli <f.fainelli@gmail.com>
>>   M:	Vladimir Oltean <olteanv@gmail.com>
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/net/dsa/
>> -- 
>> 2.43.0
>>
> 
> This is unexpected. What has happened?

Nothing, and that's the main motivation, most, if not all of my reviews 
of DSA patches have been extremely superficial and mostly an additional 
stamp on top of someone's else review. At this point I don't feel like I 
am contributing anything to the subsystem that warrants me being listed 
as a maintainer of that subsystem. There are other factors like having a 
somewhat different role from when I was working on DSA at the time.
-- 
Florian

