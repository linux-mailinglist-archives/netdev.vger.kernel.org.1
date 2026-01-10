Return-Path: <netdev+bounces-248705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A3D0D7C9
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AF5430094BA
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46033D6E1;
	Sat, 10 Jan 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/5El3dQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC61D5AD4
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057162; cv=none; b=h3Arw+xV4YejsJjr+Utso8u+WaUVYPsunRrUveiwbASDdw/owDtgNHu193fW4vPGUBhDt9NtbRirhHwLyedc0xhkoN6zbFYgJQGFzVp8Dl7bjjcWM/EQjYNIOGkXHHaBtIDpHypEADSBT34l4BTp7wItxOpffiyHOdwElCS/0ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057162; c=relaxed/simple;
	bh=Ttvaoskx8bBtK3a0bpZFsk08baIIDbTrEjcIwjgG9OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcya/Lqm7jfPgNLEUlDF8iX67Ye74/wpddVvAH0gcysBQzgr5btqhjvFUnLv084FoafdVODrSbrGBwCu3I9SW3C5aHEMB+vpg1lc4dvc65e6fA6KXWv9ZRHOrYzCU+QBM8sQ2cUwmWfIfHwKlEs3Id544muM4Un0HLhftA1HGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/5El3dQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47796a837c7so36598105e9.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057159; x=1768661959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJZLWFdR3PFcXLFOqY4AOgMbnDvjR546U/+ZAuTywEw=;
        b=C/5El3dQ9I0Qa1Ozw71xMxAJUiDD04ZzcHkvmLiOA5FOrIReEU31DRlA/bCskN3Y/M
         eyKzeuZmlV2PI1Na5BKNmVyyzFG2TpOPecErKDTFHU9xKpD02ybAz4HSOAazUe60+qWW
         2E5dRz2oqSj8H5V2a65/Q6R+ZoDrXlnmjCFYRTht8RFz/hIsPCAw6QbuExeF3KQkKCuG
         dw3Bw3R6GPGojCR+LyZRpg58QMCbC+2e4at5uQiuSMGPNOLEf56SeF0nbChYMm9Eh/i8
         deYN8ZZiD5Glbbr0DQl2z+cd0YUJppouy5Z8cyDm4XvVEHoEY1XFqHXpfWf/m1nKAgNX
         jEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057159; x=1768661959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJZLWFdR3PFcXLFOqY4AOgMbnDvjR546U/+ZAuTywEw=;
        b=PZjfcZ7trc2Aw2/Jqr3S/KVlr+ZIjhKaIEHG8uKo/HxKrDChIR2jMyynLgwhetlG+d
         KkakZ+yYlU/HQB3xVct3wZnDyHgX7cT6RtUVQBxEYqGzAYCjL7WgHIp9sRpa7laFvY/i
         UADe0Sz2SoTQl8GEU3jgetKYvPmy/IkE1PYvYOZ9BzyVOqPH1Y1OFA0zN9RA+KC4FRII
         9xUfimGz7mwqXdEd+bt3W0hweDfZXBeYQT3ehIiEQsu1MPuIUGHrOUIwRb3FT/S9W5rg
         n6VkXi+Pr5QlNoaVaU3LSCzf9YjIVXRs12GsA2/ZUMsNMV2Krq9DGEfFM+w3XiwK9zUP
         V+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZXgFERXfktTroeZ6JfCgY54M4YVKUdI6yRXe7QHuwaWCNfxJy2Qe7+jHvRJ+mnX2XWAD9ncU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85xFaNdLqNxNgy1iV/PXHL8m84lOpQZSu9MAxotuQQdkAp6Q2
	maVnco67XZ1piJegAbfFD5llqlp96ne3a/4944lHn4HlgVq3cIu31Ei7
X-Gm-Gg: AY/fxX4YuY12MvKgHDHvlHVA9NYxCQme2DjbxJGZYXjexnhCc4fXHQ3zS5GdDiOtDlt
	Pc64SCVxhy3A/Wp8BqOaaSaSZ3kgRKsXqz0Op8CAbsc24CtObhNVrtHkn6LgJnFroMwpNXh3+f1
	dZofpwMzlfwa8YRW5ynYhzlRz3ZQ43OZukXq4GBGwQ4hlwiwuj2oP0rXK8xevLBRfjkhFoJfer+
	197wZF8cmfql5oBLyNxEXCW5AnNmE1eKdCFfJexvF0vo+no/1P8GQCOqHG+0g8THc+lHAgc67KS
	MudeTgOPQ6qyU3X1sP0ZpJRnLEkATYCJXPKOkGr/HrX4kvw9dL/KNhnoZZ45/SyPFWes2ussE+/
	KuY9uWCdeC0WPrjs16Gu8ywedAXdpyzikmSOAf1poJfEhRlj4eGfU9J2JJwhkQF5MDpR+gxBQM/
	aIMYbH5SA1pMM+QssyNRDLImk3gjE68ktecbq6j6Nt5sSUA35i5v77vJcyY6a72mK7trrP4RWBs
	JLj2RO2yqWUQeLeblZZnZKhc7K0Bg9YI7ciq97COIs5QX7T4p65Bw==
X-Google-Smtp-Source: AGHT+IESxHGek3Q48p/B0EDveg9xkIS37NLmmB5ciEiuPx35LxV6yprqAHxrE6o+Xw81LMnPm1A+aQ==
X-Received: by 2002:a05:600c:8b65:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-47d8fbda479mr79686915e9.17.1768057158965;
        Sat, 10 Jan 2026 06:59:18 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1c:1800:8cc6:804e:b81b:aa56? (p200300ea8f1c18008cc6804eb81baa56.dip0.t-ipconnect.de. [2003:ea:8f1c:1800:8cc6:804e:b81b:aa56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6f0e15sm258461215e9.10.2026.01.10.06.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 06:59:18 -0800 (PST)
Message-ID: <5f5410fc-51c0-42cd-8034-5122d8fa762a@gmail.com>
Date: Sat, 10 Jan 2026 15:59:16 +0100
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
I'll leave it like that for now when sending v2 of this series.
Then you can covert it to phy_read(phydev, RTL_PHYSR) as part of
your series.

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
> tl;dr: drivers/net/phy/realtek/ has signed up for some serious
> weight-loss program.


