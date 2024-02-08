Return-Path: <netdev+bounces-70107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4184DAA1
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 08:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E4283009
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593D6930E;
	Thu,  8 Feb 2024 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/21lALI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699F69300
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707376740; cv=none; b=P89sHURp4ER62sVi4UCtgP6FSqG49cXeg7wpsPjoJ40SnVxBCcjwDNbjuyWy8vi2ZBJYxmlfBMh4Ew2kjUTy09bwpY9EjElU/eS8mpIwhV8tXepDrAtMOH4QtZsxKcY2qsuZgDKFIz8qm8tlk1XMom/58RB3zfUs71IQ4cO8nvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707376740; c=relaxed/simple;
	bh=9QAu3lGLrIdyqPf0xcygYRns7pEVKEcgD0uXbDPKJBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4STCnS0m+nY9H0Cdbd46M9jT5htz2w5bzvD9Pxsqi+w/O0j96gFJVZ9nq0u6BzAjjFwchi61rIfAfEe7h/kTeUmfrBfQrBvZIJieZGYvm21/AY48hYe2+MEz2MQuwJH6a7+hd4vsSCIw+gYjiZk/H2ZLmRU8jo0vCtskEJNsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/21lALI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1815738a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 23:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707376736; x=1707981536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qS220ucLFz7yjybVo00cSszmE7M1yRhSdFwACDZZ/t8=;
        b=l/21lALIMSDTqeiPQno8X/+dFmj8EFqHJ8srSmzBoNoNQg9KhCssfhW6MCaG7h2L+j
         iKjbf80WsBR/1TB3p3npRvC/ncOqusgUzTtfD0qlhvYe08GYbjgtMDBC765d+/TJUVlN
         UQudUEqyWbd8ELB7TMX1fVIXsRcGWMfuhGtr07Qeybettq3w1XZmUWXW2NR0yCCL/rIF
         hldUQWIIdgZqffOE27nHixn4l7favtPHUe1lCQp45gs0VBlrg6uMsRIsxezCaX96zFBR
         4QQ9jwrG7OdPGJFirmkn8vayGcXUQ8k/jtaixI9ZsdxFJjOY4Nj7TgFqXWNVZYZgOcaG
         QNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707376736; x=1707981536;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qS220ucLFz7yjybVo00cSszmE7M1yRhSdFwACDZZ/t8=;
        b=aYyGDTrcCdThOWSXI7CcFZx7FS+tDnIz/ygHjznOLkfHr5H/Hy0kQmiEUr8skwJPq6
         QJXVp+Zbj+srXiy7sml+o6n23ymBIauc1w8dzpdeuspek1N3phvn3Xlu9LO2s8XK55UB
         u3LJc0rg6D5VtnVkKPfL6ylzMytzjm4OqgqCmLduWMJC9+wWbKUHke8pwHwPaNe8eCqa
         h+p4Fju+9wVePsWwLCY+AaumHiQMC7GXrZbc+69GHIfvQekhpJI3DobRSMCCw5THDc2u
         eqjVLoGTlgQSOuU/HfUASeVVRwQC+xIq+3VzQb93wKBBGxlRoELnv1Y8htiglkcese6q
         1Tzw==
X-Gm-Message-State: AOJu0Yy6EI0XWr/1wp6ctTL+uVOT2XCo1Nz5RQa6rPgFS9w7/15bohYi
	4hd0alq9TQNgkKIWC7sRlpH6ulyBwaG2aeCDAYaZEKy8R/pkyYeq
X-Google-Smtp-Source: AGHT+IHATKDWms81VnMTNkuShZKSV9YgV9dcXHirN8DVvPoiA4g+2hQzZX9Mbp97//JWxqJt5htMpA==
X-Received: by 2002:a05:6402:325:b0:560:de8e:692b with SMTP id q5-20020a056402032500b00560de8e692bmr2859112edw.39.1707376736331;
        Wed, 07 Feb 2024 23:18:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCRZ0v7qH+YVF3X4DhRygbi1QHl4icN2aNsH85j3QVwMOQF1beH9sMTtoWLpzpRkzAUdYwFMUuCK4OQMZuuGiWTNivrB8RV++BcRrHGpjSypR6EW0ICUAaRB7Tf44WTMIEK+hNLosVttc2w+evqn/9iksmeu5pRJkrxQSfRJLSKlb2x6UY0lNNb9CH+bPdTFwc7gpkX4ahlilb+reNPUFo6A5J8KuogM4JcVw=
Received: from ?IPV6:2a01:c23:c599:8500:b13d:dd8f:30c:f16d? (dynamic-2a01-0c23-c599-8500-b13d-dd8f-030c-f16d.c23.pool.telefonica.de. [2a01:c23:c599:8500:b13d:dd8f:30c:f16d])
        by smtp.googlemail.com with ESMTPSA id fi7-20020a056402550700b0056098a293cdsm509596edb.69.2024.02.07.23.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 23:18:55 -0800 (PST)
Message-ID: <8608854b-49b2-4776-ba07-dc0854e75750@gmail.com>
Date: Thu, 8 Feb 2024 08:18:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: use generic MDIO
 constants
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
 <732a70d6-4191-4aae-8862-3716b062aa9e@gmail.com>
 <81779222-dab6-4e11-9fd2-6e447257c0d5@lunn.ch>
 <a4bea8c5-b7d7-41ed-9c10-47d087e7dff8@gmail.com>
 <de75885e-d996-4e23-9ef8-3917fe1160c4@gmail.com>
 <6c5d7946-0776-4129-89db-2602e1874615@gmail.com>
 <05f488ea-2fe5-48b6-b4bf-c6e6d5c69461@gmail.com>
 <40337728-a364-4955-a782-6ce4e178a097@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <40337728-a364-4955-a782-6ce4e178a097@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.02.2024 23:31, Andrew Lunn wrote:
>>>>>>> @@ -674,11 +666,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
>>>>>>>  		return val;
>>>>>>>  
>>>>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>>>>>> -			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
>>>>>>> +			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
>>>>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>>>>>>> -			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
>>>>>>> +			 phydev->supported, val & MDIO_PMA_SPEED_5G);
>>>>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>>>>>>> -			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
>>>>>>> +			 phydev->supported, val & MDIO_SPEED_10G);
>>>>>>
>>>>>> Now that this only using generic constants, should it move into mdio.h
>>>>>> as a shared helper? Is this a standard register defined in 802.3, just
>>>>>> at a different address?
>>>>>>
>>>>> This is register 1.4 (PMA/PMD speed ability), mapped to a vendor-specific
>>>>> register. There's very few users of this register, and nothing where such
>>>>> a helper could be reused.
>>>>>
>>
>> When looking a little closer at creating a helper for it, I stumbled across
>> the following. This register just states that the PHY can operate at a certain
>> speed, it leaves open which mode(s) are supported at that speed.
> 
> O.K, yes, i agree. All it says is speed, nothing more.
> 
> But that also means this driver should not really be doing this. Is
> there a full list of registers which are implemented? Is there a way
> to implement genphy_c45_pma_read_abilities(), or at least the subset
> needed for this device? That appears to be MDIO_MMD_PMAPMD:MDIO_PMA_NG_EXTABLE and
> MDIO_MMD_PMAPMD:MDIO_PMA_EXTABLE?
> 
I don't have access to Realtek datasheets, and AFAIK the datasheets don't document
the mapping of c45 standard registers to vendor-specific registers. But let me
check with my contact at Realtek.

> 	Andrew
Heiner

