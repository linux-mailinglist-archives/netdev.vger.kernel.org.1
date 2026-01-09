Return-Path: <netdev+bounces-248465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FDD08D5B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 12:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CF73005FEB
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2132333A715;
	Fri,  9 Jan 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCF5QcUG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927933064A
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957024; cv=none; b=JMV5Ty4BHnYZMBfw3qGycdMov1BhKW247ATnLHFgCNwrwunp2jXycwnUOMtv4HzENoK/0gNdl8Ui4CVY5SRRD0fiAWNEa9Ya2IJLs3xEC9AReVJTR3I3HrAfDSZX2VIOepDEIFZabG0OnmYqM21bvLZm+DXMHigxcG5Kfsp7dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957024; c=relaxed/simple;
	bh=r+0Z12qJq7HM4Mn4pu+P2E4mc48HQCSpz8jjJ3ghI+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntG9Jhw2d6KesCqJ1EGfSDRqrFJLAWi+AGdIgGHNLSszZ6ZsyoItsCfYHLaLcK7udfxk3liD2H+3aHDebg6wP5FY9MRNp0dOMT/hB+TyjHz4FvYXSifm7RU9lfezwc1DDHWZGfY/GjjffcviU/AnBl/VhX1tP0b8Eif9lC++gho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCF5QcUG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so39065675e9.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 03:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767957021; x=1768561821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpp4DOv0Cg2Q4Q6/HINreoOsn0VQTtDPL+z83SWbBQY=;
        b=VCF5QcUGBjg3MnOLZ0clRr5MvfCA1azjlIW/baZigIaoCK9Peec0cPOnxD0OnTIh/+
         NfX88XdxBEt0ULTnZ4zILDZlOluSTqR+5RJmYWmC49oh5bhGkvl8/Mzd3A3kgEdr5I+a
         Tgfsfz8+ZIKn/FFKxpqaRqqYLpRUpoiGiFTDWAfZuyTHWiY+5ZICzdZaengK5QsLzb6E
         lTxl1mJy14H7/LYpSDmYOF9oECG7NoAijHp9lUjPchs0oYDel/zQO8DSAEie7l943Tjf
         sWFy6luE1eSr/hiQ3jmyirjIu1jWRB5G4sqq+RPxafIOGSfrJvfYAg+Ehcb9r/ixpdZh
         6K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767957021; x=1768561821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpp4DOv0Cg2Q4Q6/HINreoOsn0VQTtDPL+z83SWbBQY=;
        b=aL32O0N7ok0yElLXInXmC824Vn0Se3WGGVtr6O30Zr927FP8prTi/OrEFb6VcIqRI6
         ocsd+X1eUc9JMegd99/AbvwrJA94xqhihr3nDDNk+uJX6CdjtLj2hyZx+v/zBsRHlEgZ
         UkBh+1X9hXK8iuMalQP0/2QzlUCkQn6wh8g1BZnFBzT8WS73dmpVvbhGpDxtOq3q34Aq
         WnQPutds0KYsFDTwGCD1CtHxoP65snOEx1YVjz80ZYn4MjrCMSlzIgf918cFAH32smEf
         boh0MEdIMA+eDY0a6mKda67lfp3IwLymIf0UKWNjbhBey7EiAbkUtTwsF8iQvxsztPVY
         stTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5Ml29sKk7nNasW/0ZNNzb4WpdUWmLCvXbQ7uVXqAF8pWs1qQ+DGMIFpcSwu9aKFiTVNBxaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQU8O6pQaQUHKVVtIgv5qtBLdufvnuuFu6fGhJTCXF0v3wjvY5
	VDhPSq8z8PHZmbTcPuRmTT7CEpG7hI4F/Xvht8i9PLces2oCCp45mM8G
X-Gm-Gg: AY/fxX4XFQny5w1jhZFGLEZnJ6r1phQUFGhy0POE492SCQ0ix736sA+tcnSDqzGdQlE
	zr/v8SpFt3S6c72vEznSB8ch3DqcESNr1q2xVyU572Q2SSaCBv9tSwqCZ2aZp9f27ZF1TOKx30z
	4EyY329/yanSkuPfyZie4z4jXJ1gCixcivWXlKbeBPjTCr9KmbFYO541eiBnsdZ5oOeFRqHeeNa
	urzIz1BXRTWbSZcHgsfIG/BqgjtifroOhdG3MQw1wVMKWTCxtWKs69tPdHOn9bkfR+LjOSMmW/y
	RFqPp2jtn7J5mET6yAwZX94y7WSH/XAUO8bfUhjQGagiBjefZfRgEOK9S8cKr+LU6rNrg1hrRnB
	1v2d6ETHJArYOohorwZIHyNIMH3vNT1sVRoOsk9PU83P+Le/oL9aMPKo966W9msLnijWd3e79Fg
	7duJFlgVNeqKLkWnQt9OUQpGrYmeF1NZZVxoEuLnT4pH2h2bzhPaztVJfvY29YJ5WpVAVkFzYf+
	a239FISb4SdT4oL4fmNz96NRC9npPdEpDxBrcRnOpJqlWycI7RAOA==
X-Google-Smtp-Source: AGHT+IE8uQ901fPo7M2IEI4Pu5Ps4x88n4mjikIWfPC5RKn3nS1x+QIErQbah+AlLqtZLWUcgJKJEg==
X-Received: by 2002:a05:600c:8b0c:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-47d84b18a9fmr100503565e9.5.1767957020523;
        Fri, 09 Jan 2026 03:10:20 -0800 (PST)
Received: from ?IPV6:2003:ea:8f34:b700:c079:f905:5470:9a28? (p200300ea8f34b700c079f90554709a28.dip0.t-ipconnect.de. [2003:ea:8f34:b700:c079:f905:5470:9a28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c6csm214487725e9.1.2026.01.09.03.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:10:20 -0800 (PST)
Message-ID: <9a21aff5-bbe7-4163-b55b-3e5d4f9496c1@gmail.com>
Date: Fri, 9 Jan 2026 12:10:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
To: Daniel Golle <daniel@makrotopia.org>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
 <aWA2DswjBcFWi8eA@makrotopia.org> <aWA7tSjnH7Kr1GCk@google.com>
 <aWBZKD32SEnZ-UUB@makrotopia.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aWBZKD32SEnZ-UUB@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2026 2:26 AM, Daniel Golle wrote:
> On Thu, Jan 08, 2026 at 11:20:21PM +0000, Fabio Baltieri wrote:
>> On Thu, Jan 08, 2026 at 10:56:14PM +0000, Daniel Golle wrote:
>>>> +static int rtlgen_sfp_read_status(struct phy_device *phydev)
>>>> +{
>>>> +	int val, err;
>>>> +
>>>> +	err = genphy_update_link(phydev);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	if (!phydev->link)
>>>> +		return 0;
>>>> +
>>>> +	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);
>>>
>>> This should be the same as
>>> phy_read(phydev, MII_RESV2); /* on page 0 */
>>> Please try.
>>
>> Tried it on my setup, the two calls do indeed seem to return the same
>> value.
> 
> Thank you for confirming that.
> 
> My understanding at this point is that only register 0x10 to 0x17 are
> actually paged (ie. the 3 bits of freedom in the
> RTL822X_VND2_TO_PAGE_REG apply to all pages), and that seems to apply for
> all 1G, 2.5G and 5G (and 10G?) RealTek PHYs.
> 
Speaking for the internal PHY's (at least for all c45-capabale ones):
There's no actual paging in the PHY. r8169 translates each paged access
to a register in MDIO_MMD_VEND2.

> Hence we do not need to use paged register access for register 0x0...0xf
> and 0x18..0x1e. And the paged operations we do have there right now can
> all be described as registers on MDIO_MMD_VEND2. And maybe that's what
> we should do then, implementing .read_mmd and .write_mmd similar to
> rtl822xb_read_mmd and rtl822xb_write_mmd for all PHYs, with the only
> difference that for older PHYs all MMDs other than MDIO_MMD_VEND2 have
> to be emulated similar to rtlgen_read_mmd and rtl822x_read_mmd.
> 
> The current way we access MDIO_MMD_VEND2 on older PHYs also also fishy
> as it depends on __mdiobus_c45_read as well as the PHY listening to the
> broadcast address 0: Especially for 1GE PHYs not all MDIO controllers
> are capable of Clause-45 access, and listening on address 0 works (at
> best) if there is only one PHY in the bus doing that, and it can be
> disabled via BIT(13) on PHYCR1. For internal PHYs of PCIe NICs this is
> fine, of course, but for standalone PHYs not really.
> 
The access using __mdiobus_c45_read is meant primarily for the internal
PHY's, where the MII bus is provided by r8169, using MAC registers.

> tl;dr: drivers/net/phy/realtek/ has signed up for some serious
> weight-loss program.

Indeed ..

