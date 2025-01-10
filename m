Return-Path: <netdev+bounces-157268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC0A09C80
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 21:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C40A7A1486
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D3212B06;
	Fri, 10 Jan 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4fA/o0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EF1E1C01
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736541353; cv=none; b=pWV7XTkBkOujLc53jJ7pxFSRB+HvxJHpAlpbVpdl9OglN+od+GBaZ1ZWEAK02LWFbPWjafR0T5Eib93XpPvRw/HeMrzUtBTk2auhzvDcw94rB/VbfaBSqgp79my1CR0QMp35fm1A7HjC/adJokq0s8S6LlySclemlP+8WVTixD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736541353; c=relaxed/simple;
	bh=sCdMyqYVfA/Lmz76KMVMOhSB4ZojGfthgSuK8VEIp90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtw/GVN1Vu2pmKleHgLd2zGALWMx/Wuq1l7gSeIl9tk92nIpBuA4AtmzNJxBEVaHw3sKuNg+/hzp0Eob16pnd60iZB9ENSL8yz8M+bzbnyKcoveYaLbUXqYCNBb4s4Zu7AfwzgQaFiqfo76ps1ZV0k4DMgnqPLh37YXoTtDb6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4fA/o0c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso18404265e9.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736541350; x=1737146150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VGDNwmViZBJfXn8pnyCvV0Kf8hGhlN7y7SbLMlSWaH4=;
        b=i4fA/o0cTH3ocWr8UnlPjvM4VaqcKG/9oRPNN8fze5bXRH2zegoPg4UYptmWT3VLzU
         As/l8n3S1J1e/akBpEb+gna08EIrc1L4gH6EgubrJfC2tal2v7hwEwkvQZd2U8c+iPDI
         2mTggRuhl1ll0NK3M5Zkwl65P3IOzvf6JjaqoPc5sP8gqdn29SEy/M5iyOl/e69r3JR+
         3GUTgNxhSYPDRjHwvHorzIe2i8gICWpwwwrVmSM4mIYnpVZqY7+86alyKgjSs5K+buGr
         hAg+tAQsnsdbMA0P7j4Mq1uFFCjGmBRpR36EOzwaq4jPq0mE/ybji5aMriYjbAWC9uMb
         inYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736541350; x=1737146150;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGDNwmViZBJfXn8pnyCvV0Kf8hGhlN7y7SbLMlSWaH4=;
        b=vw4LyKpVh2eO2z7j6CJytgK+wNAny4JC3zBdtYeyqQlDZjc/KL88re7sqvXZDqmK5F
         c7Tg/WNT5QGkh00ocl7AD49o5Id0uQlXnQQn5IS//6+B1uyLegCG2tiGQfUgZQUUax2+
         JoBtZF+HjnIMxDzk9B+C6RZalC9pPr72MgXLlJmje8WRFzptxUEWkH7TD1Jv6L/JMe5t
         7kBjD6rqM7VKnF0GCBLVS9Gb6JAVvYYEMmNBpOJjp+jdWWN+CHNxm+fbx7JgDDaIv03i
         yiPu11v2P6DAAKSXrianHeBevIF7F8jDp5J61s7g32IGQsEgBzog0Y1qcgP2jv8zwxmO
         3LMA==
X-Forwarded-Encrypted: i=1; AJvYcCXF1oWtlWROL8vdTUbGlk9wIDmrHEjDL0PRdOemQVWZHqXenscycFWB3ODhoNzcUSKV2dzGE84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymj3cxzEzjfVb/cLbzwvD3ItncsHcwYNbkpnDLE9198xpMXokH
	Zg6XYw6KYh5aF04IuwKW7TC6Jgjzc3o9jq9j90CPcVz0Y4dC6akR
X-Gm-Gg: ASbGncsnuJWtQt9m0eh8PmNFWBSo/F9/3kSGOLC5i+4CumLw4KLDlbtkwinAbhREQ4l
	7f4grtB7q0f0cfBLwQ04gFt3OTnQE3anHZC5hs7xPnXwVzsq71xvKn/+pFygSpujHxdixKMD6W3
	kjpUo99UonpZgweSDnTagC0Pi/GZDoXo2EAbp6v7lSfLk3H6ebWRn2BmaIKNXsatU8W+TD7pQdu
	NvTwqQA+GIRAnKiXW9H3W9CnmCImpGfxC5MBCXwPGpP4r8Nws7w0h+RO4Mx0AtpLNTlRYK3phu1
	2XBMX8UNNc/UrnuPiiyqyoE8O+iXsJkXr5xr9u1FM3R7l58dpyF1kKKDnyjRivg/pkCvMQMqIre
	4nmA8pHw35MrjMQCxfAf4GO6r2hRpj6nNT6YSLx4Hl49IqA==
X-Google-Smtp-Source: AGHT+IF30j5h8cCQAry3DpnsnJXNPflLZZtrZLZbfMvdFVhpZ1ZRBiYf6VDsZCtz35uiljo0wzRSYA==
X-Received: by 2002:a05:600c:354e:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-436e26a175cmr132889395e9.16.1736541349703;
        Fri, 10 Jan 2025 12:35:49 -0800 (PST)
Received: from ?IPV6:2a02:3100:a08a:a100:1e8:1877:1b89:d707? (dynamic-2a02-3100-a08a-a100-01e8-1877-1b89-d707.310.pool.telefonica.de. [2a02:3100:a08a:a100:1e8:1877:1b89:d707])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9dc8826sm62758205e9.11.2025.01.10.12.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 12:35:49 -0800 (PST)
Message-ID: <f9cb9fe0-da31-4824-b452-3c4cfcc454e9@gmail.com>
Date: Fri, 10 Jan 2025 21:35:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: rename realtek.c to
 realtek_main.c
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <b67681db-76f2-46fa-9e87-48603b7ee081@gmail.com>
 <Z4EVLteK6aU10PSr@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Z4EVLteK6aU10PSr@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.01.2025 13:40, Russell King (Oracle) wrote:
> On Fri, Jan 10, 2025 at 12:47:39PM +0100, Heiner Kallweit wrote:
>> In preparation of adding a source file with hwmon support, rename
>> realtek.c to realtek_main.c.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/phy/Makefile                      | 1 +
>>  drivers/net/phy/{realtek.c => realtek_main.c} | 0
>>  2 files changed, 1 insertion(+)
>>  rename drivers/net/phy/{realtek.c => realtek_main.c} (100%)
> 
> Is it worth considering a vendor subdirectory when PHYs end up with
> multiple source files?
> 
> We already have aquantia, mediatek, mscc, and qcom. Should we be
> considering it for this as well?
> 
Yes, I think this would make sense. I'll submit a v2.

