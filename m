Return-Path: <netdev+bounces-267905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCo+N026tmkyGwEAu9opvQ
	(envelope-from <netdev+bounces-267905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:55:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D60E290D2A
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C67D30082B8
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668D32FAC0E;
	Sun, 15 Mar 2026 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uia8jtST"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3573138490
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773582922; cv=none; b=Js7oU6/eQ55xGPqKswnDq40NOedSS9aF8fYJ1LXvCit0PJBHD6ljrHswncWjq0rMgddobLoGQf13Va6HJMrCODP3tuV7DUvyIVO5L3MwVb4BUiNVAzFU9TEp58zda48SvJ4s0/P6pzEX7o7Ty+JcqbJJCR1LdezFHFTkS4qmgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773582922; c=relaxed/simple;
	bh=z7FiUR5K1rtAqBl7jJebTxzzlyAdRPUoHI3Vq3C7u1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8aMtkNEy2saV2D17dX6aIqLtIB4BrT1oA/ZAREJ6bijGWxwNyb4n+l3aNR7DbGw/sM6+YrGVm22sUeMLX7G2MZKus8FdZojKfEvVQqV0Dkyn3L84zC9pUynme8GV+d5im2BuxmvkwW17fSaqtlPUiZ149E0iMoJC76iVplT4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uia8jtST; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48534237460so41173625e9.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773582919; x=1774187719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNaHouuix8eOHOBC4xs7Sjz399Cs8EPkWiCD/FsJRro=;
        b=Uia8jtST+YDctTlSlAJvDLCUz/LZI1WJQ35XyT53B/6UOtjCYFyo3/Gohc/ZcjM7qG
         4KpPtefUg+rom/qURsX+9mdUfDL9rNtPdfN8XV15jKVaDZ6BN3cbzQHOkbB/NEqxjbOL
         qN87XUOqUBkvxhXonLfakFmhCgVHr4eFvz4i/Gb20SZHWFWJTRIUaTtwkgV3AXFADSm7
         fXsATetJ9a2LtABXuS8NRPNjlLXuR7jHKHkY5xGsLxlHbljwxOSIdKhB+lqXeqL6djUq
         8Vt3X+WcABI4dApykBqb8NEndZO+WtCYTokIywn1bJk0GEo8/gEpgSL6sztYJNDdZXGU
         WphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773582919; x=1774187719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNaHouuix8eOHOBC4xs7Sjz399Cs8EPkWiCD/FsJRro=;
        b=Cd2rXMM4KJQ+jsIvjNjya2t/V9MVj1sAFNPRN0tow75Eb0XLZXr/yTudCUqe+coKkE
         RvdvweI58UBUQSU8yb9fKVXdJ5Y1LBH8CXPwZwg/FuXOkaQt/cjhSssp/pzlDMngJj+6
         0dE8EnDmAorBt9o4/S753ZG0DmTtHpjpBFtqtKkZQFe9OHpkf5lBxixWvlRhv3TSF+Aq
         sfSV3jjQ+CmYArNYTRFFFHTBAzVZW2vR+I1WR+NI6tfxLe3sMSMytoG26iBNSuxJ/nx2
         cIMEp5O2bDrAmaOM/KeOOnTQ8pEbfOIeqPQq+DkjwePCcsTGt0UK2efmXOsdXoSNUX+7
         tz8g==
X-Gm-Message-State: AOJu0YxNO3uaHlCyuDeVHg8RQRUkmuE4RjBmdjA2bj9Qx7W2Rs8Qle0W
	Utq4lGSX6FH+Dovxx36QLPupeZXIUh69dnV6Eh7n5IN+fHjPj14bgQY6
X-Gm-Gg: ATEYQzyFIdhamNbm0Km6SX3uMVYNFn5EEhI6jk1H+EBfCmG6MzNT/eWDdbT29MQc7l0
	l+C6QyX66hLGQHG93tM1ZsYVsCj2RSM/cj0XMg736WgB4nsETAvVEqdZVwWCAGlD1+mEHuFpZVK
	MgPS8dNof3pOq6F6CQ948+VjFZDl+zLSfsOxVAOEDio5klYlTb7Klix4m/NvK6plz9pWoChV3U8
	Vrjk9UBO78JXmG8FGE9Zr51kkiWohbmttDUqjDe+d5BtKVLRAf13SYKYsIPaKb/nh30AaNBnR0Q
	CYvpdeivW1JuL/BEdBr9FF7y621UKLuJuNOAjZgdKpQ4uFklKSP+K6U2y+LZddFIfMgWmcRkoC0
	5tsYrfrBybzsvEUampXmXMiBOz/hGAl/B4AQHC/NaSaZNzU51AIYeVKhMOTSSu4vAmVfj/pQ3IA
	D8kQDuaxGqcHibS1vyzFwfgYSZH82Xo60thplJ234fOUtQ7Yhdlua38jtJTcdZNkunE7fiWrVFS
	WJH008THTohmvG+nBvUoQhq5L4So82qtFgT96UV5YrNZcsc+Q9/eD1XOFLj2VIWKg==
X-Received: by 2002:a05:600c:8b72:b0:485:3c2d:d02b with SMTP id 5b1f17b1804b1-485566f7a1bmr148908295e9.22.1773582919104;
        Sun, 15 Mar 2026 06:55:19 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45? (p200300ea8f19c4005d7d7d8bdc1aae45.dip0.t-ipconnect.de. [2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c679c1sm69548665e9.24.2026.03.15.06.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 06:55:17 -0700 (PDT)
Message-ID: <b2f4f1e3-f542-4394-93a3-9023b705e676@gmail.com>
Date: Sun, 15 Mar 2026 14:55:17 +0100
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267905-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D60E290D2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15.03.2026 02:46, Huan Zhao wrote:
> Hardware: Beelink SER8 mini PC
> NIC: Realtek RTL8125B (XID 0x641, RTL_GIGA_MAC_VER_63, rev 05)
> Kernel: 6.19.6-arch1-1
> Driver: r8169 (in-tree)
> CONFIG_R8169_LEDS=y
> CONFIG_LEDS_TRIGGER_NETDEV=m
> 
> Problem:
> The RTL8125B chip restores its LEDSEL registers to hardware default values
> on every Link Up event. The r8169 driver does not reapply the LED
> configuration after Link Up, making it impossible to persistently configure
> LEDs (e.g. disable them) through the standard kernel LED subsystem.
> 
> Details:
> 
> The Link Up path in the driver is:
> 
>   r8169_phylink_handler()       [r8169_main.c:4757]
>     -> rtl_link_chg_patch()     [r8169_main.c:1597]
>     -> rtl_enable_tx_lpi()
>     -> pm_request_resume()
> 
> rtl_link_chg_patch() has no handling for RTL_GIGA_MAC_VER_63 and does not
> touch the LEDSEL registers. Similarly, rtl_hw_start_8125b() and
> rtl_hw_start_8125_common(), which are called on hardware initialization,
> do not write to any LEDSEL register (LEDSEL0=0x18, LEDSEL1=0x86,
> LEDSEL2=0x84, LEDSEL3=0x96).
> 
> The only driver code that writes LEDSEL registers is rtl8125_set_led_mode()
> in r8169_leds.c, called exclusively from the LED classdev hw_control
> callbacks. Therefore, any LED configuration applied via sysfs is silently
> overwritten by the hardware chip's own firmware on every Link Up event,
> before the driver has a chance to reapply it.
> 
> This was verified by observing that:
> 1. Writing 0x0000 to all LEDSEL registers (via BAR0 MMIO) before Link Up
>    successfully turns off all LEDs.
> 2. After Link Up completes, the LEDSEL registers revert to their hardware
>    defaults, turning the LEDs back on.
> 3. Writing 0x0000 to LEDSEL registers immediately after Link Up (via
>    NetworkManager dispatcher triggered on dhcp4-change) successfully keeps
>    the LEDs off persistently.
> 
> Original LEDSEL register values (hardware defaults) on this machine:
>   LEDSEL0 (0x18) = 0x0002  (LINK_100)
>   LEDSEL1 (0x86) = 0x0028  (LINK_2500 + LINK_1000)
>   LEDSEL2 (0x84) = 0x022b  (ACT + LINK_2500 + LINK_1000 + LINK_100 + LINK_10)
>   LEDSEL3 (0x96) = 0x0020  (LINK_2500)
> 
> Secondary issue: CONFIG_LEDS_TRIGGER_NETDEV=m causes silent failure
> 
> On Arch Linux, CONFIG_LEDS_TRIGGER_NETDEV=m (module, not built-in).
> The r8169 driver uses /* ignore errors */ when calling
> led_classdev_register() in rtl8125_setup_led_ldev(). If ledtrig_netdev
> is not loaded when r8169 initializes, the registration fails silently.

No, it doesn't fail. Just that no trigger is assigned by default.
Once you load ledtrig-netdev module and assign netdev trigger to
the LED, you can control LED hw modes.


> The result is that /sys/class/leds/enp2s0-* entries appear to exist but
> are dummy stubs with no hardware control capability. Writing to their
> trigger or brightness attributes has no effect on the physical LEDs.
> 
Setting brightness manually isn't supported by HW.

> This was verified by manually loading ledtrig_netdev before r8169, which
> resulted in functional LED classdev entries. The fix was to add
> ledtrig_netdev to /etc/modules-load.d/ to ensure it loads before r8169.
> 
> However, even with ledtrig_netdev loaded correctly and offloaded=1
> confirmed, the LED configuration is still lost on every Link Up due to
> the hardware reset described above.
> 
> Suggested fix:
> 
> In r8169_phylink_handler(), after Link Up is confirmed, reapply the
> current LED configuration by notifying the LED classdevs. For example:
> 
>   if (netif_carrier_ok(ndev)) {
>       rtl_link_chg_patch(tp);
>       rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
>       /* Reapply LED configuration after hardware resets LEDSEL on Link Up */
>       if (tp->leds)
>           led_classdev_notify_clients(tp->leds);  /* or equivalent */
>       pm_request_resume(d);
>   }
> 
> The exact mechanism for reapplying the LED configuration (whether through
> the LED classdev framework or by directly re-calling rtl8125_set_led_mode()
> with saved values) is left to your discretion.
> 
> Thanks,
> Huan Zhao


