Return-Path: <netdev+bounces-243168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D7C9A646
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 08:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA483A4DE2
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 07:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090621FF35;
	Tue,  2 Dec 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmCLu4rM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B4EEBB
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764659284; cv=none; b=hDs1MNJctR2lo+gxOW01zRsFFRPobc5Q18u4krAZCw5JJuIibrRFxwHIUKUkHkSDgIijwvT4ReB3jAS5QvWO0ZxdZnLQbM/09xcArMvgsdInlbqh5fd2lJpUUN4hRlxA8/kruz12nTwBRL/FTJsb8ufCy9Nh0WvFLRk+brMS1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764659284; c=relaxed/simple;
	bh=D8uF8Oy+tJXtFjZe9Q2+ZuDUmXFP9Bij+ROSqPLUFUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLZG3sSRF+8+fDxMjJ2M8md3pBWOIKYgBTHQVRqS90ASFeKFO8nkLhfFijrVN64jsHHz8pZ2aaidS4kl1FY781yKZqSdeEp6Dch3j6O1QzDA9sHlcypIyyVOjgWgqhJJZ81QMcYfLfHuOjqcSYGbbVoe2NMGpGnWPT45fEhoLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmCLu4rM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47796a837c7so35617735e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 23:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764659280; x=1765264080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kab/tII0HtUw/kL5IZPpGkcoFnQGy5DnT16va8RXXhc=;
        b=TmCLu4rMt4ZMXyydx+UnMYJ19oJ/YBHp/PL/W7kzZBcd1jcJ5suWFHI13XABjjohOM
         XZbFCGKl14r1Gk/045QJFgHVT71afNtWGNlFYDpDiJcxYOnb+kdUoHclTPmFlB88z+aV
         Nl6eCOnGzJFcD3ge0Pzr0f548beJ4Mnmyxj1yPGBvyt5dKBXRea4tTyXyNiiOL+Kyolb
         wCr4HHuvILEYSOXsBa/rqjcg9bVvL5fAl035hEJPfiS8JxSmuErSkWERxKMb2IhiosBj
         u8XKyH0lku/mVxjoIilJZNXw1guQlKXuQMSW9ZuvIRJklM5HP4WJGNxraTX0gVHMY+9w
         sCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764659280; x=1765264080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kab/tII0HtUw/kL5IZPpGkcoFnQGy5DnT16va8RXXhc=;
        b=Y/5MTS1C+c11LOUolTkjd3HCgt+N6CdPBqzRjcO5BaSBIVtjFPMLNy49rjURHLyOHe
         ByZ5vD5Z5ZdO9wk41DFTNRgIapY0rFPT4K6JOipQpVbgH+M87SyRfGEHjtXkpPIpmHG9
         YvW2XKpg3JUGszW7/3x7h3bRjH9Kb/8tyzi6508XqYunorMKCuhXJ9HSDg3xODKsoh3a
         ErAIoDX7WV6ZKXO4wHU2G2WKuayTgF2g5N0WQgSVCK6Nxkp7JV8VwcbIcTS9/KHvNNwJ
         p2XcA3V4HFa3OMk1SfnDqPL6Gankb1cNhEH5GeMGdh6z9XUizQtk74lsEbHQN2mKlyUA
         MLzQ==
X-Gm-Message-State: AOJu0YxInqlv/A6QowNuXwqqqrO38JnrRxLlFB02Z8b3pt5dUR0V3w03
	Txf1C6J7IudNcxivCZwpolP9LXOEyWfTADSmJe6Ctvc30N5QsGNCGzxX
X-Gm-Gg: ASbGncvfVz2Z6+fswE082iB6UU4JqOKIni23jYPMsd7ORFlc2VtWJUZO9XoP5CgzNpx
	XMaFVhaHr2P7GjKH0bkJVFO3jJVK+hdlYdqoqLOiwXJKBsIXh6XQ/zo/k9OLNHAg+Gyiz3sYSA5
	c7pKNacDjjAfwopPX264xn7XY9gq2x2lx4nA1R2hlwHQOEl3DH5CH620AJhOWHd86UKLWIwCBQV
	TSQUsy7iR4cspw9iTYCYW1XszM3A3mzPx9ZRp9EE7lrHNnEOk2UrPWa8HpLvFt8/HZ3/yBcysPR
	pFZu3t6fSwkLkCka8t849FyEcQjcMmLem3xDejwsT7h1HwdP5tWmyTc6JgCQAPZkd7LpZSxP5Lu
	6Z/S9iXfakweFpIfPacnxvvSqu9kEg8QxqLbojyOdxxEQQti9e0Sp+vgOI6aKb4LCm4rB63hdDJ
	Ovyw+nlQOlkKjMNxAm6V5FbU0DAEYZhMsu19rXsKvKn+LYtTFvb8Z7ZKQoM7HKfbbt5PcOBhXHm
	NHIQSxPGiVGbIt/0Ymi7uFjU/qf4R3PsE9IOloiWRLsiAybHUCIqg==
X-Google-Smtp-Source: AGHT+IFp3DSS2hHxzuDHeFk2A9AB0TstgXjtyYvuKE8YTP7nVdKurofFX4/nNxSK4yufEF1x0Qb6Jw==
X-Received: by 2002:a05:600c:3b8d:b0:477:aed0:f3fd with SMTP id 5b1f17b1804b1-477c016de43mr466899635e9.8.1764659279989;
        Mon, 01 Dec 2025 23:07:59 -0800 (PST)
Received: from ?IPV6:2003:ea:8f22:cb00:d13d:782c:2122:d04e? (p200300ea8f22cb00d13d782c2122d04e.dip0.t-ipconnect.de. [2003:ea:8f22:cb00:d13d:782c:2122:d04e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc6f7bsm363142435e9.2.2025.12.01.23.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 23:07:59 -0800 (PST)
Message-ID: <679e6016-64f7-4a50-8497-936db038467e@gmail.com>
Date: Tue, 2 Dec 2025 08:07:59 +0100
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
 <76d62393-0ec5-44c9-9f5c-9ab872053e95@gmail.com>
 <9F5C55F0-84EC-48C2-94E2-7729A569C8CA@exactco.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <9F5C55F0-84EC-48C2-94E2-7729A569C8CA@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/2/2025 12:26 AM, René Rebe wrote:
> Hi,
> 
>> On 1. Dec 2025, at 22:12, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 12/1/2025 9:31 PM, René Rebe wrote:
>>> Hi
>>>
>>>> On 1. Dec 2025, at 21:15, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 12/1/2025 8:17 PM, René Rebe wrote:
>>>>> Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro WS
>>>>> X570-ACE with RTL8168fp/RTL8117.
>>>>>
>>>>> Fix by not returning early in rtl_prepare_power_down when dash_enabled.
>>>> Good
>>>>
>>>>> While this fixes WOL, it still kills the OOB RTL8117 remote management
>>>>> BMC connection. Fix by not calling rtl8168_driver_stop if wol is enabled.
>>>>>
>>>> You mean remote management whilst system is powered down and waiting
>>>> for a WoL packet? Note that link speed is reduced to a minimum then,
>>>> and DMA is disabled. Who would drive the MAC?
>>>> Realtek doesn't provide any chip documentation, therefore it's hard to
>>>> say what is expected from the MAC driver in DASH case.
>>>
>>> This RTL8117 has a 250 or 400 MHz MIPS cpu inside that runs
>>> a out-of-band linux kernel. Pretty sketchy low-quality setup unfortunately:
>>>
>>> https://www.youtube.com/watch?v=YqEa8Gd1c2I&t=1695s
>>>>
>>>>> While at it, enable wake on magic packet by default, like most other
>>>>> Linux drivers do.
>>>>>
>>>> It's by intent that WoL is disabled per default. Most users don't use WoL
>>>> and would suffer from higher power consumption if system is suspended
>>>> or powered down.
>>>
>>> It was just a suggestion, I can use ethtool, it is the only driver that does
>>> not have it on by default in all the systems I have.
>>>
>>>> Which benefit would you see if WoL would be enabled by default
>>>> (in DASH and non-DASH case)?
>>>
>>> So it just works when pro-sumers want to wake it up, not the most
>>> important detail of the patch.
>>>
>>>>> Signed-off-by: René Rebe <rene@exactco.de>
>>>>
>>>> Your patch apparently is meant to be a fix. Therefore please add Fixes
>>>> tag and address to net tree.
>>>> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.rst
>>>> And please add all netdev maintainers when re-submitting.
>>>> scripts/get_maintainer.pl provides all needed info.
>>>
>>> Yes, I realized after sending. The only Fixes: would be the original
>>> change adding the DASH support I assume?
>>>
>>> Any opinion re not stopping DASH on if down? IMHO taking a
>>> link down should not break the remote management connection.
>>>
>> I have no clue how the OOB BMC interacts with MAC/PHY, and I have no
>> hw supporting DASH to test. So not really a basis for an opinion.
>> However: DASH has been existing on Realtek hw for at least 15 yrs,
>> and I'm not aware of any complaint related to what you mention.
>> So it doesn't seem to be a common use case.
> 
> Well the Asus Control Center Express is so bad and barely working
> it does not surprise me nobody is using it. We reversed the protocol
> and wrote some script and hacked VNC client to make it useful for us.
> 
> The Asus GPL compliance code dump for the MIPS Linux BMC system
> has some rtl8168_oob or so BMC side driver for it to learn more details.
> 
Do you have a link to this code?

> Maybe I should backup a fork of it on my GitHub to archive it.
> 
> Given the BMC should be reachable, would be acceptable if I work
> out a patch to not take the phy down and always keep it up even
> for if down and module unload when in “dash” mode?
> 
Yes

>> There are different generations of DASH in RTL8168DP, RTL8168EP,
>> RTL8117, variants of RTL8125, RTL8127 etc. Having said that,
>> there's a certain chance of a regression, even if the patch works
>> correctly on your system. Therefore I'd prefer to handle any additional
>> changes in separate patches, to facilitate bisecting in case of a
>> regression.
> 
> Of course, will sent separate patches for each topic.
> 
> What about defaulting to wol by magic like most other linux
> drivers? IMHO the drivers should all be have similar and not
> all have some other defaults. In theory it could be made
> a tree-wide kconfig if users and distros care enough what the
> global default should be.
> 
I'm not in favor of enabling WoL per default, as it prevents
powering down the PHY if system is suspended / shut down.
This impacts especially users of mobile devices.
"Others do it too" for me is a weak argument, if no one can
explain why it's a good thing what they're doing.

> 	René
> 
>>> I probably would need to single step thru the driver init to find out
>>> what reset stops the out of band traffic there, too.
>>>
>>> René
>>>
>>>>> ---
>>>>>
>>>>> There is still another issue that should be fixed: the dirver init
>>>>> kills the OOB BMC connection until if up, too. We also should probaly
>>>>> not even conditionalize rtl8168_driver_stop on wol_enabled as the BMC
>>>>> should always be accessible. IMHO even on module unload.
>>>>>
>>>>> ---
>>>>> drivers/net/ethernet/realtek/r8169_main.c | 9 +++++----
>>>>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>>> index 853aabedb128..e2f9b9027fe2 100644
>>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>>> @@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
>>>>>
>>>>> static void rtl_prepare_power_down(struct rtl8169_private *tp)
>>>>> {
>>>>> - if (tp->dash_enabled)
>>>>> - return;
>>>>> -
>>>>> if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
>>>>>   tp->mac_version == RTL_GIGA_MAC_VER_33)
>>>>> rtl_ephy_write(tp, 0x19, 0xff64);
>>>>> @@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>>>>> rtl_disable_exit_l1(tp);
>>>>> rtl_prepare_power_down(tp);
>>>>>
>>>>> - if (tp->dash_type != RTL_DASH_NONE)
>>>>> + if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
>>>>> rtl8168_driver_stop(tp);
>>>>> }
>>>>>
>>>>> @@ -5406,6 +5403,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>>> tp->pci_dev = pdev;
>>>>> tp->supports_gmii = ent->driver_data == RTL_CFG_NO_GBIT ? 0 : 1;
>>>>> tp->ocp_base = OCP_STD_PHY_BASE;
>>>>> + tp->saved_wolopts = WAKE_MAGIC;
>>>>>
>>>>> raw_spin_lock_init(&tp->mac_ocp_lock);
>>>>> mutex_init(&tp->led_lock);
>>>>> @@ -5565,6 +5563,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>>> if (rc)
>>>>> return rc;
>>>>>
>>>>> + if (tp->saved_wolopts)
>>>>> + __rtl8169_set_wol(tp, tp->saved_wolopts);
>>>>> +
>>>>> rc = register_netdev(dev);
>>>>> if (rc)
>>>>> return rc;
>>>>
>>>
>>
> 


