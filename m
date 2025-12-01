Return-Path: <netdev+bounces-243062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0ACC99244
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD84E119D
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C732620E5;
	Mon,  1 Dec 2025 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io+tdXYE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DD2080C8
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623571; cv=none; b=DA5aXLEvJs55UxGa23ebM1GID6paIFp008UuK+2P+moDhUgASodZU/QDqu0gPy+8iukelP7go7NXcMYBQ+ghwTsiIofx0PrNLpLqF8JbVITb5zIdMXWc1JFW2/DBzcQj36tQDlgDLifx5PDIR7OvqdX0/WFkrpPUwIihjethslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623571; c=relaxed/simple;
	bh=0rZU5rbLCk0QXTqCbMkwhA9hd3Qo2OrdSqFyP6G8ycs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T061dMX3d2/94SzqrpcJwD6JsD7Vbzj904R6XYafNH5SsoK1CxpmsXyfotDh3IOi3WcpREGL2idU23YJbCFZCUzwoEShXJ0HOM3DjCwh/RrEg5H6jCE2IHh5xbfG7TnGA/azkMUN20Zx+CJ1VDo8uPlFdXHco36gwJuhJAiqcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io+tdXYE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42e2ddb8a13so780272f8f.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764623567; x=1765228367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tsupm17v1Khrg4SRa2yaf5j3zqWM4nzTj4+3xsoo3uQ=;
        b=Io+tdXYEyS5a8RajygDrFQ6wWX9q3oib1UxtQ30jPnyl+BhmEWZZBWgzytmdbWFDaS
         EaxVqZkuTn702XpWAYfl008X4xscwf4Mmtyjnk9iYSXBzDRafI6xjHGh91xtf/TOKFV5
         fYh4Mn54mLXZDzeJuOW/RtywYQvvAAj0HvdvYp6aJN09qyJFsisCRQeSFURINNH2RxgP
         Yh29OPpeKQ2p4TpMPiQSprxwnKSFgTfb/0OJpNLnvydghJN/R7MKkRCHSXTG65j0p69L
         asKJCpkDo67tY1b6bdrIAWuuomPd2j+r7+iJrCNGWQXRt7gMTWb3BYxn1AAtOcWxqgsq
         A1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764623567; x=1765228367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tsupm17v1Khrg4SRa2yaf5j3zqWM4nzTj4+3xsoo3uQ=;
        b=euNJMuwMdpD1itdJivcvyAKWXhgFSd+zv9gbBX9spEo5jMbH1jYzvGqleKFcrQZtkf
         TNE7mSt1zbMfObK5a+z4EbE3tEnWoRGO1GCTxqyPfhxxRFye2dPBlmNWFyBVSnNWIGK/
         vM0TV9iIoH/kdBs1mfWKoqMYQ54nCJxqS9sL3Gy2Ospz+El8h47vAY0ikB+oPGiGeYVM
         UQG5ebIDe3M6eyqEWOXG9W6jQim9lLBDPjyJ7D9y2F5qm2g+sVZC4zhMnxKxZ6inXgkF
         gi/UdYN88GS4KkW7Kb95wrzhYETz5uZs68JClr9rB32Bv2CX90wiBdzWqXCWmGEtf8w6
         LWvw==
X-Gm-Message-State: AOJu0YxzEDd1fTp4XP+rC5LVK/naFSMNcGCBMshRG9L+wgZOHgjmWB1K
	DN65F1orx2P5p9R7sQu85UMvkD5e+MTCucFPd2Maza+R4MwcCyOc1/1qaYSa045v/r4=
X-Gm-Gg: ASbGncsdhAKsfN5xJGRCln11JovnyRuSdxiPy1Z8jaw/DzdeJJB1fKYr/oGsXbKfhi9
	pi/CNX8PqfIG66LOJk/5mqGqiunJlvhKfyFDj2ZbSUNIR6z2aca2Ldbqt3MTGBnA/aCqQYKSRWN
	b/kHFL/aSe/EImbZcgIys91nEOK+Eq5+GgbZYyIdNYZ2WMtqfjVD1aKULR0tbZ3o8EROjlO9wMD
	WdGgSg5ncC4AjWlwoO1A+sfNWXlH7HFAH2XZCWGuZ41LzCdCwsXrrwcfdGnbVJNlHH6BtKSWAZ1
	MMiZH7WMyjpzhZwGRU+9tkb7jtxNn8LYV2kPseD+DXwOH6ZOX2uUBYinNlTbhDIAhNvUVvbBzNb
	yKbEPTZnJ4XTslYqDBt8iT05o4m0ARjZpg9ydPtQK8/q3Lx3uV8wkBmMKFzYBD19Yc0UhiDCVJC
	p+LGmG+t/m739fWOaemO9qQTO+14C59Bf/b8hBpK/U986PPj+V7byZPAOldD+DilUezKY9XnEZq
	MlT/H66ShsD/9lFPo3dVC0yWCHI//OGlqt7jZwpSC/iG+Tccrq/JJuKn0tzF/mI
X-Google-Smtp-Source: AGHT+IERerbNOeu3oMGX6eq3TRtjpewGC2697Avz5VwWy/TawekKPTLFGzvyZ+Fbv9FP1xuOLfnS/A==
X-Received: by 2002:a05:6000:3102:b0:429:d565:d7df with SMTP id ffacd0b85a97d-42cc1d0ce28mr41914039f8f.42.1764623567003;
        Mon, 01 Dec 2025 13:12:47 -0800 (PST)
Received: from ?IPV6:2003:ea:8f22:2e00:255f:6a3a:f305:e725? (p200300ea8f222e00255f6a3af305e725.dip0.t-ipconnect.de. [2003:ea:8f22:2e00:255f:6a3a:f305:e725])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d6277sm28229734f8f.17.2025.12.01.13.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 13:12:46 -0800 (PST)
Message-ID: <76d62393-0ec5-44c9-9f5c-9ab872053e95@gmail.com>
Date: Mon, 1 Dec 2025 22:12:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com
References: <20251201.201706.660956838646693149.rene@exactco.de>
 <8bee22b7-ed4c-43d1-9bf2-d8397b5e01e5@gmail.com>
 <B31500F7-12DF-4460-B3D5-063436A215E4@exactco.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <B31500F7-12DF-4460-B3D5-063436A215E4@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/1/2025 9:31 PM, René Rebe wrote:
> Hi
> 
>> On 1. Dec 2025, at 21:15, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 12/1/2025 8:17 PM, René Rebe wrote:
>>> Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro WS
>>> X570-ACE with RTL8168fp/RTL8117.
>>>
>>> Fix by not returning early in rtl_prepare_power_down when dash_enabled.
>> Good
>>
>>> While this fixes WOL, it still kills the OOB RTL8117 remote management
>>> BMC connection. Fix by not calling rtl8168_driver_stop if wol is enabled.
>>>
>> You mean remote management whilst system is powered down and waiting
>> for a WoL packet? Note that link speed is reduced to a minimum then,
>> and DMA is disabled. Who would drive the MAC?
>> Realtek doesn't provide any chip documentation, therefore it's hard to
>> say what is expected from the MAC driver in DASH case.
> 
> This RTL8117 has a 250 or 400 MHz MIPS cpu inside that runs
> a out-of-band linux kernel. Pretty sketchy low-quality setup unfortunately:
> 
> 	https://www.youtube.com/watch?v=YqEa8Gd1c2I&t=1695s
>>
>>> While at it, enable wake on magic packet by default, like most other
>>> Linux drivers do.
>>>
>> It's by intent that WoL is disabled per default. Most users don't use WoL
>> and would suffer from higher power consumption if system is suspended
>> or powered down.
> 
> It was just a suggestion, I can use ethtool, it is the only driver that does
> not have it on by default in all the systems I have.
> 
>> Which benefit would you see if WoL would be enabled by default
>> (in DASH and non-DASH case)?
> 
> So it just works when pro-sumers want to wake it up, not the most
> important detail of the patch.
> 
>>> Signed-off-by: René Rebe <rene@exactco.de>
>>
>> Your patch apparently is meant to be a fix. Therefore please add Fixes
>> tag and address to net tree.
>> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.rst
>> And please add all netdev maintainers when re-submitting.
>> scripts/get_maintainer.pl provides all needed info.
> 
> Yes, I realized after sending. The only Fixes: would be the original
> change adding the DASH support I assume?
> 
> Any opinion re not stopping DASH on if down? IMHO taking a
> link down should not break the remote management connection.
> 
I have no clue how the OOB BMC interacts with MAC/PHY, and I have no
hw supporting DASH to test. So not really a basis for an opinion.
However: DASH has been existing on Realtek hw for at least 15 yrs,
and I'm not aware of any complaint related to what you mention.
So it doesn't seem to be a common use case.

There are different generations of DASH in RTL8168DP, RTL8168EP,
RTL8117, variants of RTL8125, RTL8127 etc. Having said that,
there's a certain chance of a regression, even if the patch works
correctly on your system. Therefore I'd prefer to handle any additional
changes in separate patches, to facilitate bisecting in case of a
regression.

> I probably would need to single step thru the driver init to find out
> what reset stops the out of band traffic there, too.
> 
> 	René
> 
>>> ---
>>>
>>> There is still another issue that should be fixed: the dirver init
>>> kills the OOB BMC connection until if up, too. We also should probaly
>>> not even conditionalize rtl8168_driver_stop on wol_enabled as the BMC
>>> should always be accessible. IMHO even on module unload.
>>>
>>> ---
>>> drivers/net/ethernet/realtek/r8169_main.c | 9 +++++----
>>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 853aabedb128..e2f9b9027fe2 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
>>>
>>> static void rtl_prepare_power_down(struct rtl8169_private *tp)
>>> {
>>> - if (tp->dash_enabled)
>>> - return;
>>> -
>>> if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
>>>    tp->mac_version == RTL_GIGA_MAC_VER_33)
>>> rtl_ephy_write(tp, 0x19, 0xff64);
>>> @@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>>> rtl_disable_exit_l1(tp);
>>> rtl_prepare_power_down(tp);
>>>
>>> - if (tp->dash_type != RTL_DASH_NONE)
>>> + if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
>>> rtl8168_driver_stop(tp);
>>> }
>>>
>>> @@ -5406,6 +5403,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>> tp->pci_dev = pdev;
>>> tp->supports_gmii = ent->driver_data == RTL_CFG_NO_GBIT ? 0 : 1;
>>> tp->ocp_base = OCP_STD_PHY_BASE;
>>> + tp->saved_wolopts = WAKE_MAGIC;
>>>
>>> raw_spin_lock_init(&tp->mac_ocp_lock);
>>> mutex_init(&tp->led_lock);
>>> @@ -5565,6 +5563,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>> if (rc)
>>> return rc;
>>>
>>> + if (tp->saved_wolopts)
>>> + __rtl8169_set_wol(tp, tp->saved_wolopts);
>>> +
>>> rc = register_netdev(dev);
>>> if (rc)
>>> return rc;
>>
> 


