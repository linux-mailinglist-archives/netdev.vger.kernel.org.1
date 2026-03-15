Return-Path: <netdev+bounces-267954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sACXEk/1tmnTKwEAu9opvQ
	(envelope-from <netdev+bounces-267954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 19:07:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E4D291DCE
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D56093013783
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64304379EF0;
	Sun, 15 Mar 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrrQ4neL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFA377EC3
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598023; cv=none; b=BwoLDkbMkJPDu2zNc4lWDLWouw7jV22lKf4pfhmhfQrWra8aDbJBhFI7HXPSghr31j77VqEu/4oZWnRcVKZYz1WOb5luJI7P6S8+UxM3cGhcrUulFEIfAKV6vXEg7ulZ6KYr2ZAFbJCrmyc8/L5/YyRfWPmyNQwBTAbHykSD5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598023; c=relaxed/simple;
	bh=BftRfJXzfFqfC2FLieEMDANX6gygF20kTbh21b0YpAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8C1z2l7XKWrWwdUKIvwF/8hTcvZtTj2crAGZLZcB2vBoANX5sOF1HSF9KT+s3R3l30T3pcM0W99ziJ570NckErxG5CJyfSvK9/4bHQp9AGZORfavGYghxCS+RD/GD/hyljO8wchTg+MPX0kdCXDknKumBnRZ64DI4RRVr9WW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrrQ4neL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso30766555e9.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773598020; x=1774202820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ql/34LxpYRTd6r967aMLxyZ9vnvzKJ6h/Q1dOJk0pTE=;
        b=BrrQ4neL2JnbkJxi/37p4v3qRyNBxbNyIUlLv3n1OmXLLpGoJmcWAJfUmNaorfcrdi
         /ZqCiETo6lRjRY2o3c/YbE9uwu6xJZh1jWuAQXhUT3NNrnbfk3XTRUTdWVS9YRRC9V8V
         aek4WKTfpL6bJYlavJQI7ED1uHE9mqllJAV2Xt/4nhpBV8PWjJUavBaZCCJQhnJtE5Gz
         lv2T6s0jDS4N2sOVsY9IjwtVJjuv9rnFEul8YUtFZ1sl4zVvEzHa4FKfQzn6eXnRXIfv
         H9SxAb5qPvLqEpKgK7S7l7jL6NN2EP4Pa/VbiojpkrwnQ1ajjJShG+uUCNUvD977/aeP
         vfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773598020; x=1774202820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ql/34LxpYRTd6r967aMLxyZ9vnvzKJ6h/Q1dOJk0pTE=;
        b=FB7JPgWqlesMOK6u216nDWoR6zi1EB9RVNYovvlZJ0jKFsoH21VsU7h8azMtYRCqi/
         EG4eFCfcJVi39TbNXOb00+j1hd5RdC4O7xFiXbwUga37/kFM1nXpBZpn5Nkt6Rtk+ntM
         RidYh/wdxCpIaYXVyVJyL5/vfGJsvUfvPlKB4vRSKhNsDL+oR+zIHKA5knrnCXIIYGvu
         qQCOZqMP3leyPBUo0K+xgzMmPA1NH7Cx49qTAYefAGDnSP+RV9CcQjRtfCZhAs3cXLeW
         NkCUntu/5YZuAioFogXGzompO1WiILTDrhqzjFJwVtRJ+JCKgNsMpytLoeOcc+zoeSm5
         wgcg==
X-Gm-Message-State: AOJu0YwYzgUAMtGZLlziD7vEirMOjtJC35YKs8Lbm/ca9K4BgKC5YeLX
	olQZd7Dr1ogaZFL4hcfi2zYProQeZyZKKz025ZJ5Yr5nWXTMpQ5Jzj0cotMfJw==
X-Gm-Gg: ATEYQzy49s5zebNTd4AHLOv+yPWpg29BLPfAQTYMUrQqvBghQovy8cruSCkgQsS4Mlp
	x+97ZusMZAiwS2mc39WOrZ3jLvzec+rLBX8OOnORZxxXv6oDoBcBpNox9HmLpK6yMf1wOwMu7oW
	vlo4NFUM/KxISr2wRG6kM3GdBcVtjonhHIcUKdyYH8s8xVE2oP7cMLLB240XcUEjHPrge6Sbu63
	laU5HMoW2uivqtjejc9BiT+0k3W28J0in5xVr5caOXeLPzpnImEH5AaJo6nimz79ZCUa8z0yuEx
	Y7VB3g+OjAkgQL4+1TuN6uFkZAEdMuXZDWfs+PPRCeOvefQ8QH8lhs+3iVBJOGpq0OwZXUPuj+E
	3ofvy4UM85+Dg4+z86GOsNleLHaRZa9FldHrxifeeQVEI2XyNBXzzI89nZq/YltLXwCGe5LuABd
	RePbXs+n1CBIU+PnwCHjkVxj0nvVyN7pnAtdsGV2NgVhPPy3aAKfrdmlA8Fj/Nf9La5otDlCLfM
	x0MQDSFaW1u9HepdMlIJJguuH3CENDTh5TSONle+OGQ9PdguE2lVIh1lebmhU4LLg==
X-Received: by 2002:a05:600c:8b2c:b0:485:3f65:94a1 with SMTP id 5b1f17b1804b1-48556714b4dmr179867695e9.18.1773598019683;
        Sun, 15 Mar 2026 11:06:59 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45? (p200300ea8f19c4005d7d7d8bdc1aae45.dip0.t-ipconnect.de. [2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c7220dsm71062035e9.30.2026.03.15.11.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 11:06:59 -0700 (PDT)
Message-ID: <67e97f82-1539-4334-8c95-df6b2f01e769@gmail.com>
Date: Sun, 15 Mar 2026 19:06:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: RTL8125B restores default LEDSEL values on Link Up,
 preventing persistent LED configuration
To: Huan Zhao <ms.huan.zhao@gmail.com>
Cc: netdev@vger.kernel.org
References: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
 <b2f4f1e3-f542-4394-93a3-9023b705e676@gmail.com>
 <abbs0Zp-HeOaC_69@ser8.localdomain>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <abbs0Zp-HeOaC_69@ser8.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267954-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6E4D291DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15.03.2026 18:41, Huan Zhao wrote:
> You are correct. I apologize for the incorrect analysis in my previous
> email. Further testing has clarified the actual behavior.
> 
> Summary of findings after additional testing:
> 
> 1. The LEDSEL registers do NOT reset on Link Up.
> 
>    After writing 0x0000 to all LEDSEL registers via BAR0 MMIO and
>    triggering multiple Link Up/Down cycles, the registers retained
>    their zero values throughout. The hardware does not restore any
>    defaults on link state changes.
> 
> 2. The real problem is CONFIG_LEDS_TRIGGER_NETDEV=m on Arch Linux.
> 
>    As you clarified, the LED classdev registers successfully without
>    ledtrig_netdev present — just without a trigger assigned. However,
>    the link_* sysfs files (link_100, link_2500, etc.) do not appear
>    until the netdev trigger is explicitly assigned. Without these
>    files, there is no way to configure the LED modes through the
>    standard interface.
> 
>    The workaround is to ensure ledtrig_netdev loads before r8169
>    via /etc/modules-load.d/.

The netdev trigger module can be loaded also after r8169, and then
be assigned as trigger.

> 
> 3. Persistent LED disable works correctly via the standard interface.
> 
>    With ledtrig_netdev loaded before r8169, the following sequence
>    successfully and persistently disables all LEDs:
> 
>      echo netdev > /sys/class/leds/enp2s0-N::lan/trigger

How is it if you add a small delay here? I'd have check whether
assigning a trigger is fully synchronous.

>      echo 0 > /sys/class/leds/enp2s0-N::lan/link_10
>      echo 0 > /sys/class/leds/enp2s0-N::lan/link_100
>      echo 0 > /sys/class/leds/enp2s0-N::lan/link_1000
>      echo 0 > /sys/class/leds/enp2s0-N::lan/link_2500
>      echo 0 > /sys/class/leds/enp2s0-N::lan/tx
>      echo 0 > /sys/class/leds/enp2s0-N::lan/rx
> 
>    This survives Link Up/Down cycles and network cable
>    insertion/removal without any further intervention.
> 
>    This is implemented as a systemd oneshot service running after
>    network.target, at which point all link_* files are immediately
>    writable with no waiting required.
> 
> 4. Remaining question: udev timing issue.
> 
>    When the same script runs from a udev RUN rule (triggered on
>    ACTION=="move" for the network interface rename), the link_*
>    files are not yet writable at that point, even after
>    trigger=netdev is set. The files only become writable after
>    a delay of up to several seconds. Is there a reliable udev
>    event or sysfs condition that indicates hw_control is fully
>    ready for writing?
> 
> Thanks,
> Huan Zhao
> 
> On Sun, Mar 15, 2026 at 02:55:17PM +0100, Heiner Kallweit wrote:
>> On 15.03.2026 02:46, Huan Zhao wrote:
>>> Hardware: Beelink SER8 mini PC
>>> NIC: Realtek RTL8125B (XID 0x641, RTL_GIGA_MAC_VER_63, rev 05)
>>> Kernel: 6.19.6-arch1-1
>>> Driver: r8169 (in-tree)
>>> CONFIG_R8169_LEDS=y
>>> CONFIG_LEDS_TRIGGER_NETDEV=m
>>>
>>> Problem:
>>> The RTL8125B chip restores its LEDSEL registers to hardware default values
>>> on every Link Up event. The r8169 driver does not reapply the LED
>>> configuration after Link Up, making it impossible to persistently configure
>>> LEDs (e.g. disable them) through the standard kernel LED subsystem.
>>>
>>> Details:
>>>
>>> The Link Up path in the driver is:
>>>
>>>   r8169_phylink_handler()       [r8169_main.c:4757]
>>>     -> rtl_link_chg_patch()     [r8169_main.c:1597]
>>>     -> rtl_enable_tx_lpi()
>>>     -> pm_request_resume()
>>>
>>> rtl_link_chg_patch() has no handling for RTL_GIGA_MAC_VER_63 and does not
>>> touch the LEDSEL registers. Similarly, rtl_hw_start_8125b() and
>>> rtl_hw_start_8125_common(), which are called on hardware initialization,
>>> do not write to any LEDSEL register (LEDSEL0=0x18, LEDSEL1=0x86,
>>> LEDSEL2=0x84, LEDSEL3=0x96).
>>>
>>> The only driver code that writes LEDSEL registers is rtl8125_set_led_mode()
>>> in r8169_leds.c, called exclusively from the LED classdev hw_control
>>> callbacks. Therefore, any LED configuration applied via sysfs is silently
>>> overwritten by the hardware chip's own firmware on every Link Up event,
>>> before the driver has a chance to reapply it.
>>>
>>> This was verified by observing that:
>>> 1. Writing 0x0000 to all LEDSEL registers (via BAR0 MMIO) before Link Up
>>>    successfully turns off all LEDs.
>>> 2. After Link Up completes, the LEDSEL registers revert to their hardware
>>>    defaults, turning the LEDs back on.
>>> 3. Writing 0x0000 to LEDSEL registers immediately after Link Up (via
>>>    NetworkManager dispatcher triggered on dhcp4-change) successfully keeps
>>>    the LEDs off persistently.
>>>
>>> Original LEDSEL register values (hardware defaults) on this machine:
>>>   LEDSEL0 (0x18) = 0x0002  (LINK_100)
>>>   LEDSEL1 (0x86) = 0x0028  (LINK_2500 + LINK_1000)
>>>   LEDSEL2 (0x84) = 0x022b  (ACT + LINK_2500 + LINK_1000 + LINK_100 + LINK_10)
>>>   LEDSEL3 (0x96) = 0x0020  (LINK_2500)
>>>
>>> Secondary issue: CONFIG_LEDS_TRIGGER_NETDEV=m causes silent failure
>>>
>>> On Arch Linux, CONFIG_LEDS_TRIGGER_NETDEV=m (module, not built-in).
>>> The r8169 driver uses /* ignore errors */ when calling
>>> led_classdev_register() in rtl8125_setup_led_ldev(). If ledtrig_netdev
>>> is not loaded when r8169 initializes, the registration fails silently.
>>
>> No, it doesn't fail. Just that no trigger is assigned by default.
>> Once you load ledtrig-netdev module and assign netdev trigger to
>> the LED, you can control LED hw modes.
>>
>>
>>> The result is that /sys/class/leds/enp2s0-* entries appear to exist but
>>> are dummy stubs with no hardware control capability. Writing to their
>>> trigger or brightness attributes has no effect on the physical LEDs.
>>>
>> Setting brightness manually isn't supported by HW.
>>
>>> This was verified by manually loading ledtrig_netdev before r8169, which
>>> resulted in functional LED classdev entries. The fix was to add
>>> ledtrig_netdev to /etc/modules-load.d/ to ensure it loads before r8169.
>>>
>>> However, even with ledtrig_netdev loaded correctly and offloaded=1
>>> confirmed, the LED configuration is still lost on every Link Up due to
>>> the hardware reset described above.
>>>
>>> Suggested fix:
>>>
>>> In r8169_phylink_handler(), after Link Up is confirmed, reapply the
>>> current LED configuration by notifying the LED classdevs. For example:
>>>
>>>   if (netif_carrier_ok(ndev)) {
>>>       rtl_link_chg_patch(tp);
>>>       rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
>>>       /* Reapply LED configuration after hardware resets LEDSEL on Link Up */
>>>       if (tp->leds)
>>>           led_classdev_notify_clients(tp->leds);  /* or equivalent */
>>>       pm_request_resume(d);
>>>   }
>>>
>>> The exact mechanism for reapplying the LED configuration (whether through
>>> the LED classdev framework or by directly re-calling rtl8125_set_led_mode()
>>> with saved values) is left to your discretion.
>>>
>>> Thanks,
>>> Huan Zhao
>>


