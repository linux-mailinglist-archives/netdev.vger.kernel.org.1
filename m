Return-Path: <netdev+bounces-248701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 830FFD0D75D
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5C88301119F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C213469FC;
	Sat, 10 Jan 2026 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1FqWbyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9847FBA2
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768055319; cv=none; b=u9JIuQr53UUFy6/n6Hg0ONxyB791TRWb4yd2RtsQCE2eJrgjzu8erKCli65lJ3yCzSDyhOq5M8+hjcCXS/vRFTApPZxdBQ0HfS09j5FhUmoftYAsM0Cg9Rp5xK/pvcUUuuPyfX8+CR/s2qRTp1JTgE3lSc+ViKDGYizm/zUlYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768055319; c=relaxed/simple;
	bh=d6lGCZeBAbHolp3KHSWXcTEuK21Cd7GvLg3LdHS0lfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5sUPneNkfQ+6fIDYxPGsmROLilv4Jv2DxKvKkWkHUsVG/mj6NX2SCuOAoBknztlV9duSPPIySzAwW9CQdtKka/wuo4HgunP16gzIizU50UBErCg25Vwbo7FrVmJ8ygsD1Bqyj/FpJOCTYceUMESD96YaV9451wa1prTMoX9c1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1FqWbyi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso30325885e9.2
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768055317; x=1768660117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HKscEfLpjUsn821O8EhAoZL6ejgDYubcUtKXZVxPBU=;
        b=U1FqWbyi9bzUZqqyrhfuG8TCcoS9XPoldx60S50d+R02vrE+1OPDXQimmBdSR5Et4I
         u/mzP3Mf4s3TJEloyI0vEVez+G4208DSsLHNIdBUUJPLOPv+N2c0zRTltRtwJcVqpb6+
         wvphEXLaJx2IgJo2YYNs4pu36SZzgQ+YJPK0i411F+T//HA+v4GqZqs1FPDiJ2AD72iN
         Di8H43Wc4W16FZOCKVVfVMlkHKxhGemjlIY68VC5hwL6tnpTR3Z/m6YTXE1+r++8MLhW
         tcsuf4rys92nGfDz0l9z0yMMmTdEIaXOO9npIkF2QiHoNkCHGp6cpkR7yg2N05w65wEQ
         6dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768055317; x=1768660117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HKscEfLpjUsn821O8EhAoZL6ejgDYubcUtKXZVxPBU=;
        b=llz/80M7Jh390qvLkqMz0spTc64EM/tw1e6CM2lDnlijRVn8WF8gVTybGPW7bmEZAs
         ASbvCYgiy92gnvvXN1jlQOL7J7B1wELBpfpW2hCxb/ka/Ky/H84KI8MkfI1q3LGiRu8n
         sWaLh/JJ8W3KHQN15InCDE0tqIo0f3HeLxDyzBvroo5kdlZkXTmAu8Yp6v3ZnX3Dw/tM
         o4fqAtrz7QkQo3Dd3K1ZPrym/90MizcZTfsGYaOMGD1sQj0QJCNCsAV/VZLdIXxvZiUH
         JhHnYxpBjsqUSkVhn8vbt7T8jJ9AUC5Lka6Slw9ilP+mdmoFAijGVmprcP6UWnZiQ7P/
         myzw==
X-Forwarded-Encrypted: i=1; AJvYcCWpHt3LyyxPcv+F0idt+FrtK/qco9d/9Y3pLglOgSN73/LrqgcbPFEvF9Zzq6yJdO381GraPF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcAMXEEHg5kIHK1mhTyj/BH95mB0BXDMU/E4m5PQe2b2zjnz5
	W+mUQtbHoW+FNjqnZ8qpLKj1Nkm0eghBghcIFNtJ1oo2TCnePbxMmr4G
X-Gm-Gg: AY/fxX7NTiIoVVB8NHc845CCcgJFSdOLfh86Z4aV/ayJFKRowkDdYucMWy1TyqekIBN
	brz9z2K40XBgP/x4j4Ugq6PECZMNju2KF0yo7sgy9h9VEDbA6d1UkMlO+71WGSdWIhCI41tSMs5
	dvHt5SIz5gU28QJbLlG33NH/RbSX2YAdNmw5e5lrfXsMuRor6yAd5j32iak/ZTgji/TXcHMOnEU
	w+vSbUf9/D3ZavWYz8pOTVSqc+cMcpgtSR7v7BwSJqV519uYr7WIATgbPxB493KH8ReQd+T1/hI
	J5Am2adaKvDRiwvPUGsKmoihrlzAbPg5HdUknSnUTOHKWMghAqkRdJyUWsa0HG1i8naJZEmLgHR
	C/nVV7cTuxDEieMMJJa3933KhcLAoXh0t+iEr7QEqiY1igh3gQrTgwwYB/iCLnxkS8yX1+mPT1G
	DOPeQR6fcdQN/MCmi0TjY/zUOMiNTd7rBBzMdUXrl7o6P9t7g8gtWzhoJ8TEUqWywX5b4FZdz32
	T2Epll9U+aptIFSeztsZU71jWR6GyMKsGh9SIB4NIRvisvmfvym+jBeujxEglWl
X-Google-Smtp-Source: AGHT+IFzwNi/gSQQu6QdAYoPp8vk6efFPsgASFrxFAQZeIDNhCk6TnxV/M0/o3ZVX7YAUo57ZuLKYw==
X-Received: by 2002:a05:600c:c0ca:b0:47d:87ac:73b8 with SMTP id 5b1f17b1804b1-47d87ac7a94mr106652105e9.27.1768055316608;
        Sat, 10 Jan 2026 06:28:36 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1c:1800:8cc6:804e:b81b:aa56? (p200300ea8f1c18008cc6804eb81baa56.dip0.t-ipconnect.de. [2003:ea:8f1c:1800:8cc6:804e:b81b:aa56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d286cdecsm14348726f8f.7.2026.01.10.06.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 06:28:36 -0800 (PST)
Message-ID: <9111d6cd-0071-4964-aa7f-221077cd05b7@gmail.com>
Date: Sat, 10 Jan 2026 15:28:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: phy: realtek: reunify C22 and C45
 drivers
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1767926665.git.daniel@makrotopia.org>
 <d8d6265c1555ba2ce766a19a515511753ae208bd.1767926665.git.daniel@makrotopia.org>
 <131c6552-f487-4790-99c6-cd4776875de9@lunn.ch>
 <aWEBviG7gpq3TGUv@makrotopia.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aWEBviG7gpq3TGUv@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2026 2:25 PM, Daniel Golle wrote:
> On Fri, Jan 09, 2026 at 02:18:14PM +0100, Andrew Lunn wrote:
>> On Fri, Jan 09, 2026 at 03:03:33AM +0000, Daniel Golle wrote:
>>> Reunify the split C22/C45 drivers for the RTL8221B-VB-CG 2.5Gbps and
>>> RTL8221B-VM-CG 2.5Gbps PHYs back into a single driver.
>>> This is possible now by using all the driver operations previously used
>>> by the C45 driver, as transparent access to all MMDs including
>>> MDIO_MMD_VEND2 is now possible also over Clause-22 MDIO.
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>  drivers/net/phy/realtek/realtek_main.c | 72 ++++++--------------------
>>>  1 file changed, 16 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
>>> index 886694ff995f6..d07d60bc1ce34 100644
>>> --- a/drivers/net/phy/realtek/realtek_main.c
>>> +++ b/drivers/net/phy/realtek/realtek_main.c
>>> @@ -1879,28 +1879,18 @@ static int rtl8221b_match_phy_device(struct phy_device *phydev,
>>>  	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
>>>  }
>>>  
>>> -static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev,
>>> -					       const struct phy_driver *phydrv)
>>> +static int rtl8221b_vb_cg_match_phy_device(struct phy_device *phydev,
>>> +					   const struct phy_driver *phydrv)
>>>  {
>>> -	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
>>> +	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true) ||
>>> +	       rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
>>
>> Are there any calls left to rtlgen_is_c45_match() which don't || true
>> and false? If not, maybe add another patch which removes the bool
>> parameter?
> 
> At this point it is still used by
> ---
> static int rtl8251b_c45_match_phy_device(struct phy_device *phydev,
>                                          const struct phy_driver *phydrv)
> {
>         return rtlgen_is_c45_match(phydev, RTL_8251B, true);
> }
> ---
> 
> This 5G PHY supposedly supports only C45 mode, I don't know if it
> actually needs the .match_phy_device at all or could also simply use
> PHY_ID_MATCH_EXACT(RTL_8251B) instead, I don't have any device using
> it so I can't test that.

Yes, match_phy_device is needed. This PHY ID also matches the internal PHY
of RTL8126. And RTL8126 doesn't support speaking c45 to its internal PHY.


