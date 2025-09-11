Return-Path: <netdev+bounces-222217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53ECB5393E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BA61C83801
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA935CEB2;
	Thu, 11 Sep 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJtWKHls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8C35AAB9
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608066; cv=none; b=gRmGndti8Lh82JR1Hjj3lDpe9V+IXXiXA1me1pPdLF5Po2dnh04bMVvmb9byaSNT7xLeazFunlAuyEkIMsbkyyjWJSnlgbREetR//kImkzUlSIqALfQ3IJXNJjCUYM5yao6ZSEZau0J/hqQBEimMyX9lbnYnBRO3bHrkBmiO/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608066; c=relaxed/simple;
	bh=TwUk990oB0arNw1DZXZzp2OuVwx4/bKeQidL32+X/sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fv3tBzjy7NCR0iPp3k43XeaAkAuC5K4H30t4MSSz6V14yRyqxD1h5tj0jO9TQYFDbJ5EFHPKxHrVey26WbLamuQtM2mDBzlMYw2gAQi2qiYzixFBZPYA1kH4bYL0Tyrm8cdFtN9Z6ywldxcwdhUFUc3ibJR4hHcKbxSj2iajMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJtWKHls; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso7085465e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757608062; x=1758212862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ID9K2Pz50qvQb969LAhUUpT2ZvtF2+y3oALjyFfijA=;
        b=BJtWKHlsYg2YvnWWggyIB45+Xnb0uoKR/dz3AVX6m8xl/Iu4+rj196sf0NzOJiIfBh
         XtNKbSQTyiNbkI6mdi4BjnI65no8qoHA6+CIuZFZoe4NJ4NaagE/81ZvlQECBkuM2kp3
         vxs4Y2K++TNDrFXsHFkjuydNt1oIVdcTJ5eHlZjNJJKdzPLSJSx3Eg2DmmdSG1KIFx3j
         6/a/FwuHhjkbvMQjvjx+aazUQHxGNuq+nxmLU61FcxG/S9/L8/YWSgfRPEEsviv70T2T
         rN7PU8lmL1cpHXalshncEnVCev6EiBmev+Io71P4966sOOtvdIjMzSkexu1l6/egb8o9
         qxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608062; x=1758212862;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ID9K2Pz50qvQb969LAhUUpT2ZvtF2+y3oALjyFfijA=;
        b=a1jE5yvFK1VnixEIGmRHo+MNzDvNa5zcX380fFeibVNNvaMDvl/ArZTEHTCW8+sKHw
         Hd8L203SAzEoNTLWqOBTN4AapqnYlWyzq2KWMKRH8tbOsjsV5+cPEelYQU+DJc9h1m7I
         2PR0bDupjGk4ue9pVsRPjGyXsnfJZ22qmTSJQafL7np1R5jTASe2UNtfaOq1AS0ReBZT
         kU+X0GD3GgQ1RU+PZl9icpAapOzuQ/gQCgpKrejx2xbnd28pEH+QvcYscWVYzfgyqDFW
         Ipo8VNBMjoalF0mwPLQX6Hpa0Lrgci8bvz0JYSkDl9eif9ajo4xa61IjfwIj/vl55FK5
         jzGw==
X-Gm-Message-State: AOJu0YxCMy2oI5//5PGZlOmox8NP84Td2fWE6Hy+wWLzB1rMAwuZWHPR
	m1JvnZFXqUGw5sD2bQ/iHxmHFVtOGFR1DeKyRkmazqZRhlJS6QXCzkYG
X-Gm-Gg: ASbGncse0RZ3155Kcp8FxdRUI/p0Tj6ZfcJ0oeJPprbPGS8UlK2Thcl40VS/cQuZdch
	L48fEj1ThwF13O8hAje62yDjCm7wEyDr57CTLr8UJZTlDvNQX+viafX6/fXwNSUex+mr+IaVBXS
	bARAGw423mredfbVL0yI/JhO2mcEJHg2MQe1g2+Xax5Iua4K7cAwnmQSvbp92uiKKYEd56ONYV+
	C6yc6Mdsy29s4kksK2DUzqiyx2WNGAust/hGyqloNv0LoIaRdLSJ6/APZJJW2qT/7EtN4/18Ely
	K3FQ4eCks62awreY3i+zTlciTGBm6w15J22ld4eFdm9QCzP7xSwEzmhYmhTtO1+ACDhth69YzeB
	VWl8o60Vy23rCQmFVuy9rY1QWFHm+Mp+P/Ut2hQ3Lgc+hqHJsEclalxH1RzAkPW8Qg2Aajces7y
	x4s0hTIgD6T8K0Xq4I7vTNiGd8opaWrhj8aKG4rVUP7OloyVn/Kj2ouJpA2csIfA==
X-Google-Smtp-Source: AGHT+IHpG+Lo9fvd05RKlmJWiOpN27divHXOE8lnNfa1d6ppWXpWPFE6GbzGC0My0rBHZwg88ZcJjg==
X-Received: by 2002:a05:600c:6b06:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45f211d0795mr843665e9.10.1757608061940;
        Thu, 11 Sep 2025 09:27:41 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4f:5300:1cfa:4708:5a23:4727? (p200300ea8f4f53001cfa47085a234727.dip0.t-ipconnect.de. [2003:ea:8f4f:5300:1cfa:4708:5a23:4727])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7607d7593sm3033783f8f.43.2025.09.11.09.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:27:41 -0700 (PDT)
Message-ID: <bb41943c-991a-46bc-a0de-e2f3f1295dc4@gmail.com>
Date: Thu, 11 Sep 2025 18:28:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: phylink: warn if deprecated array-style
 fixed-link binding is used
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
 <bca6866a-4840-4da0-a735-1a394baadbd8@gmail.com>
 <51e11917-e9c7-4708-a80f-f369874d2ed3@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <51e11917-e9c7-4708-a80f-f369874d2ed3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/2025 8:34 AM, Krzysztof Kozlowski wrote:
> On 09/09/2025 21:16, Heiner Kallweit wrote:
>> The array-style fixed-link binding has been marked deprecated for more
>> than 10 yrs, but still there's a number of users. Print a warning when
>> usage of the deprecated binding is detected.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/phy/phylink.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>> index c7f867b36..d3cb52717 100644
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
>> @@ -700,6 +700,9 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>>  			return -EINVAL;
>>  		}
>>  
>> +		phylink_warn(pl, "%s uses deprecated array-style fixed-link binding!",
>> +			     fwnode_get_name(fwnode));
> Similar comment as for patch #1 - this seems to be going to printk, so
> use proper % format for fwnodes (I think there is as well such).
> 
At least here no format for fwnodes is mentioned.
https://www.kernel.org/doc/Documentation/printk-formats.txt

> Best regards,
> Krzysztof


