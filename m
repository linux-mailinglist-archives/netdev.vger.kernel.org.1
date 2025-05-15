Return-Path: <netdev+bounces-190802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 375E8AB8E52
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C791BC7173
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE2258CD8;
	Thu, 15 May 2025 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UELPVK1r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45715A864
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331860; cv=none; b=Nuyo0RAsRcaDIpDtYTK14/y25rMmf8KipSteOJDf6rnpg+QZtuoObB23tU99iDXovXfk9i/CNjZzMlVVP1RaY08p9WZBYXLyj510ODk26hVywA1srbpN3FzMNlfYEB93B8A2uS6+Rak8TUQ+UyJ90s0uFBA8tGievtqTjFSk1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331860; c=relaxed/simple;
	bh=pzv6YFSenQOaAPsB+2i1nG1/s1ds1TiyFegcrLYaK8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCe9DiENy0umGWBXw0PuWH/fhngdDc2Ng3mesCvV1rk4ElZu+/mOFbeiAwr+bug5ZjC5DMzpp1UUUgS/3KozAnOJSBDj6Hn5I0BBLvwgSCMxS8x9s2ZlF/qSz8jrh0HQw6rBDuOaITPS6MvzOicgXrU1CiJaviPoDHa1TuDMIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UELPVK1r; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-440685d6afcso13232295e9.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331857; x=1747936657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dA2Sjx7LhWwI6EAba9qm+jloBEOzNOSxZ4JVmkpSgtU=;
        b=UELPVK1r8dvB6MqL4yENAHbYwmHMSFVr6znK5bV8HRZHtSc8xT/q4qUuto8JwJty0h
         MpANyTGBhB7wjru/XZUMcUyKG1PNswsVLsRtTBvc+ONNSWk3cXrZ2ohskRGhVAVGe2um
         kA83GSCs9YIMalByBjU4a/7lpOJCbELy9vwlkj8DgmvVDdIZIRjiOf0airqS3+XCW9IF
         LDruC9WjNRASk0GO1VEEKso6DhhoLo/bkLoysTKLWvOgeYugZLOLrPfjhL65whGDBwvY
         q5XX26/Ow7GsySvmK9Aa69aA4BHHGRphNnzxbFMP/fgjyxW87pITIjzyUv1f4PdaWz+s
         R3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331857; x=1747936657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA2Sjx7LhWwI6EAba9qm+jloBEOzNOSxZ4JVmkpSgtU=;
        b=XW2LD/Jf9yUKEBgtvSMcgaBaeos2wh8XUb97HCUALzTZzDvUz2mJ/Ptaq1pexsZ5nY
         3iDTWWEDzVU0sHnsic4a4q8iQgFWDfB71WiXadX3pNHOyBMJntIyl/wWetrVnoOJO9zT
         e2vAafXc1pi8Hdwy7aRh/qRnaee0tBVsunG1rsNf12Ucg210K/U3UvqvytiCP4oiK+Y3
         RJA+C5NniaR1s6oRdKjpqRCjjetmuKniy6kwYQ//vnG+M4iZiEGSIbiO5CDWKcJ95eW0
         bdBRSqoCwJc9LI9Y54JRNPJQG4gjHTDGFe8tCUxgLpWYI3rpX92CcdPbACHGzsgN9Q+/
         OyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMdtzf8yzaKErm2J4/LWHfkMRmjm16qYgj0gdJhY69FpYoBP53enkaG4F/92YxWmpEFYKM9R0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq57YmMWBIH3wnW3km6KSF61ZFdyhnnMUl+Jou4dgXMIT7b1f1
	/j4WNIaKEyDj182E0s1uLfBY5TnSjaZE5Hv/OOrYDSwiOgKH0NkNo02BR2t5sQ==
X-Gm-Gg: ASbGncs7kTeEOsn2mrdL4cA3HPIDLy6oXSjsIkHcI80rNidpvc1dzAZtciWU/c17FXT
	myJF4BjC6HXdImbgRDezG3wTcDcSyAWK5ria8jNwcF2CnZ/kYw/78bQYw1JufgSUs8x8ZW/X6BX
	4J1XtKbKgmgLdWKrhLY7+UvzR/lO9+ijvx4wtSLmK3DD2vytQRJ7Zoz2N9dUqB/6661GuwxN92v
	jv3xKjqkjk7NrpkXT4+BXL4RCEXGClFkGCHnMVTywtNF4L7QtQrsfrhas6kKs693ahuO/nlvZvu
	pK8Gp/74wYBRST4fcNQDrcbf9dfM4Sk+N2C3prOuYjurhEKGqMsKHw1VdvMd5DadwDxWYWxIA3u
	9o+SiOljmjgFM8977LCJhmrU4q30xMnAtkSBNo+OTeGYttdXRQh8hoMM/+TLyoppC+wN/Vs4Hxk
	O1vHiCCjHuEQ==
X-Google-Smtp-Source: AGHT+IGV5ZOBN6eZnc2jlGVOLg9umyfxazEPPT0XLK0d8LC7jrTgPSO1HkF0FOzHUBL2+gmslW/5/w==
X-Received: by 2002:a05:600c:3b92:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-442fd60869amr5246575e9.3.1747331856392;
        Thu, 15 May 2025 10:57:36 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:2300:ec36:b14d:f12:70b? (p200300ea8f4a2300ec36b14d0f12070b.dip0.t-ipconnect.de. [2003:ea:8f4a:2300:ec36:b14d:f12:70b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f9053b4dsm34950005e9.4.2025.05.15.10.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 10:57:35 -0700 (PDT)
Message-ID: <61d8aaad-1c1e-44e4-a3fd-91ba7c173f7e@gmail.com>
Date: Thu, 15 May 2025 19:58:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: make mdio consumer / device layer a
 separate module
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <9a284c3d-73d4-402c-86ba-c82aabe9c44e@gmail.com>
 <eab0da72-f373-40b1-acb6-3e3e3c3aadf7@gmail.com>
 <20250515063251.24eaa37a@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250515063251.24eaa37a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.05.2025 15:32, Jakub Kicinski wrote:
> On Thu, 15 May 2025 08:26:33 +0200 Heiner Kallweit wrote:
>>>  int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data);
>>>  int phy_ethtool_get_sset_count(struct phy_device *phydev);
>>>  int phy_ethtool_get_stats(struct phy_device *phydev,  
>>
>> Forgot to export mdio_device_bus_match.
> 
> What happened to waiting 24h with the reposts..

I wanted to provide a version for review which at least passes the
automated tests. But right, will wait also in this case.
Thanks for the hint.

