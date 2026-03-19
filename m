Return-Path: <netdev+bounces-269323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HucNoWcu2l0lwIAu9opvQ
	(envelope-from <netdev+bounces-269323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:49:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E892C6E9B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2EA03017DD5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FC363C5C;
	Thu, 19 Mar 2026 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH6EvqdV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18740173
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773902977; cv=none; b=cOtcKyOnYaiE1qVQZlk3Mat49ybVtdNPpOqh5GpsnS2UKNMS99H4uzEbdmAt7cQp12n20/h4og2GiDjOr+wGwnQuKPbNkAZkjftu5dq8SNnFkYKZOTRqVOPug1og0qGBBZnuRl+nX5HBZjDdaiz+qmMmRMjdsLGbQMF0ZGLn73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773902977; c=relaxed/simple;
	bh=1g0cYlgww4N36FHF6rDNUwkoUaog/3Xi3VMSBHDib3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+er004x6cLzkZAuGVoPwu8z8OwE0YfQTcUW5o9aXMqsJvHf3n8x0H4S8K//XZgl17hPJrVsLUA7Uey7um34Wl6iYwhP0XyzLvWjfKfx8mM1awrF+nDhkj6XOT1kj6SubXqKVIsyeXo4dyAKNCb6llhTP2ghtriKQb6yopYdf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH6EvqdV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483487335c2so4061185e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 23:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773902974; x=1774507774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9B9jOq0enmf7dlAFt9aIfhNbnrLS5Hiqukbosj6bm1A=;
        b=UH6EvqdVOxzKMv+nLuz6PfUhiqYXs8R1BJAzjVOellyQMeVqReKHFsCrWN/TfB+y1a
         79TOvt1q/qNmaSDRPGZmHds6aKsJiGkjUitII3o3IpCM9yLY/+Um4T8g7FnTKozeyUeK
         5lUtaxdOe2mw/s9Z30qs3nHeh59BpG7AIYxk2NkfFoC+4VEhFMvz90jPhbYYXQML5Q5T
         ukHp10BV7RfeNi3oB9jlfbQXoUmXEYLBc2aXhyhosZjdeSeY0nor8AG8NuHtBPJF/Qth
         3rTayPjLKLYu9dhhcX1u/J8Q9wrdwOmYuVe8gNsQxiglT+g9bWbGtw4ta3v4LWi9gaqe
         uvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773902974; x=1774507774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9B9jOq0enmf7dlAFt9aIfhNbnrLS5Hiqukbosj6bm1A=;
        b=InNtaFCctWHC3pLdQnHLLRJz+r2THjJhhx9rUT2YGMr9DSCVibZu7eFShdM26Imr8E
         EZ3+Zha1TIcSlkhhEFkc/ON6Iwz+4iV+y7Imjn8D+OVngeBg9u2hVytpFeo6ZzNHHFV1
         RoFsG/2ImE2Ee4FT7HLh+d2YaFGnzn0SwxTpqcRWoJAN2teEn6RiZ2Xs78dXpwkVGWxh
         RNKmZC9g4H5dp7Nzd5Ha24E0/kt9Tn4gpemv+6/3DDgRjp/IZk6Yfm7YH3Ru2HUqdr4H
         O/ocGKncwMYngPZ4P9c+aCJyTGcpfvklICMPGgJLvOUUOPPZUSZP5LJkl6SQXYiCXhiT
         R4oA==
X-Gm-Message-State: AOJu0YyVQioX7/7cBpH+q8u1n9bywJ0D48YQs2n6Vk2XVtoSU+SyHq71
	k7aeTsYipPAbeAaaFzcc+zPf0y8uDb/S1FDd4pvtoVdt2LHiukqNixoP
X-Gm-Gg: ATEYQzxPQvcrmL9X9F832qQWi4N0h88mUSTrVQ/l8L95m41ceAZSNbwPGNediGp1bzc
	NJJUz4sSL0cHGh+aVXmdJaxt0mJWSrBsvhTB95iqIaWqm6EkW4CDfE4MRbnk+XXCz9Fqmk9CSNe
	snIDrdq7g65t0HKwN2uNe3YuGbOSc91sYsAcTZWWhVwm/CvXUKqWAPWZsl7utlxkCZoYcYJrWxi
	lrAdZ+nCET5T23Fb666V3RBfKSHaij9SHPsFHQSdFz9Ont5MZKxoy6TpQ8btjH0mgQPtEIdSBuj
	jkW/qISmcPP9AnRuVt0tiB07q1cFpgSmjM0SQIibMX7g4oDCybrnKF1mKHhq8saXKVaBiOV1gDM
	+G4Shz7XK8D4DSdoigHHisMV9t0N2tYxRamwhsJqi8NFkNTh8ioQ0oae6ObiZYGKZOf6rgbF3sM
	tRj/d2GAPL/qTOsUTSan0LN1OvQvUPKoOmK8fH0D0d5el4pRRtE6yPiuw5JN0GFpTLAb2WDXgwl
	fgCi3k/fEBT1s+8GwG5ps5N63w45lFChGsRv2onlRDNz6sAX9ydMYO2clGpA3uGRPmbIGfanw==
X-Received: by 2002:a05:600c:6994:b0:483:79ad:f3b9 with SMTP id 5b1f17b1804b1-486f445facdmr95488955e9.28.1773902974130;
        Wed, 18 Mar 2026 23:49:34 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2c:400:3937:453f:8db5:e07d? (p200300ea8f2c04003937453f8db5e07d.dip0.t-ipconnect.de. [2003:ea:8f2c:400:3937:453f:8db5:e07d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b94a83sm46791705e9.10.2026.03.18.23.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 23:49:32 -0700 (PDT)
Message-ID: <a614b5f9-6dd7-44b1-8ff4-e0683b283910@gmail.com>
Date: Thu, 19 Mar 2026 07:49:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: RTL8125B restores default LEDSEL values on Link Up,
 preventing persistent LED configuration
To: Javen <javen_xu@realsil.com.cn>, Huan Zhao <ms.huan.zhao@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
 <322ac707-cb11-4543-bd56-d9f7cce4b52f@gmail.com>
 <91926dc60d1145a79090a23b42a1653b@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <91926dc60d1145a79090a23b42a1653b@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269323-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81E892C6E9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19.03.2026 03:35, Javen wrote:
>> On 15.03.2026 02:46, Huan Zhao wrote:
>>> Hardware: Beelink SER8 mini PC
>>> NIC: Realtek RTL8125B (XID 0x641, RTL_GIGA_MAC_VER_63, rev 05)
>>> Kernel: 6.19.6-arch1-1
>>> Driver: r8169 (in-tree)
>>> CONFIG_R8169_LEDS=y
>>> CONFIG_LEDS_TRIGGER_NETDEV=m
>>>
>>> Problem:
>>> The RTL8125B chip restores its LEDSEL registers to hardware default
>>> values on every Link Up event. The r8169 driver does not reapply the
>>> LED configuration after Link Up, making it impossible to persistently
>>> configure LEDs (e.g. disable them) through the standard kernel LED
>> subsystem.
>>>
>>> Details:
>>>
>>> The Link Up path in the driver is:
>>>
>>>   r8169_phylink_handler()       [r8169_main.c:4757]
>>>     -> rtl_link_chg_patch()     [r8169_main.c:1597]
>>>     -> rtl_enable_tx_lpi()
>>>     -> pm_request_resume()
>>>
>>> rtl_link_chg_patch() has no handling for RTL_GIGA_MAC_VER_63 and does
>>> not touch the LEDSEL registers. Similarly, rtl_hw_start_8125b() and
>>> rtl_hw_start_8125_common(), which are called on hardware
>>> initialization, do not write to any LEDSEL register (LEDSEL0=0x18,
>>> LEDSEL1=0x86, LEDSEL2=0x84, LEDSEL3=0x96).
>>>
>>> The only driver code that writes LEDSEL registers is
>>> rtl8125_set_led_mode() in r8169_leds.c, called exclusively from the
>>> LED classdev hw_control callbacks. Therefore, any LED configuration
>>> applied via sysfs is silently overwritten by the hardware chip's own
>>> firmware on every Link Up event, before the driver has a chance to reapply
>> it.
>>>
>>> This was verified by observing that:
>>> 1. Writing 0x0000 to all LEDSEL registers (via BAR0 MMIO) before Link Up
>>>    successfully turns off all LEDs.
>>> 2. After Link Up completes, the LEDSEL registers revert to their hardware
>>>    defaults, turning the LEDs back on.
>>> 3. Writing 0x0000 to LEDSEL registers immediately after Link Up (via
>>>    NetworkManager dispatcher triggered on dhcp4-change) successfully
>> keeps
>>>    the LEDs off persistently.
>>>
>>> Original LEDSEL register values (hardware defaults) on this machine:
>>>   LEDSEL0 (0x18) = 0x0002  (LINK_100)
>>>   LEDSEL1 (0x86) = 0x0028  (LINK_2500 + LINK_1000)
>>>   LEDSEL2 (0x84) = 0x022b  (ACT + LINK_2500 + LINK_1000 + LINK_100 +
>> LINK_10)
>>>   LEDSEL3 (0x96) = 0x0020  (LINK_2500)
>>>
>> Thanks for the report. For preparation of a fix it would be helpful to know
>> whether this behavior is specific to RTL8125B, or whether this applies to all
>> chip variants supported by the driver.
>> A reset to defaults after a deep power-saving state I'd understand, but a reset
>> to power-up defaults on link-up sounds quirky. But maybe it's not power-up
>> defaults, but link speed specific defaults.
>>
>> Hau, Javen: As I don't have access to chip documentation, I'd appreciate a
>> comment from your side. Thanks!
> 
> My platform:
>  Hardware: ASUSTek Z890-PLUS
>  NIC: Realtek RTL8125B (XID 0x641, RTL_GIGA_MAC_VER_63, rev 04)
>  Kernel: 7.0.0-070000rc1-generic
>  Driver: r8169 (in-tree)
> 
> I tried the following steps:
> 1. link up, LEDs on
> 2. link down, LED off
> 3. writing 0x0000 to mmio address through devmem2, link up, LEDS are still off
> 
> 1. link up, LEDs on
> 2. echo 0 | sudo tee /sys/class/leds/enp130s0-2::lan/link_1000, LEDs off
> 3. link down, link up, LEDs are still off
> 
> Original LEDSEL register values ​​on my pc: 
> LEDSEL0 (0x18) = 0x0201 
> LEDSEL1 (0x86) = 0x0202 
> LEDSEL2 (0x84) = 0x0208 
> LEDSEL3 (0x96) = 0x0220
> 
> I can't see the problem on my pc. I want to know if there's anything wrong with the steps I took to reproduce it.
> 
Thanks for having a look at this. In the mean time the original poster admitted
that the report was based on a wrong interpretation of an issue.

> Thanks


