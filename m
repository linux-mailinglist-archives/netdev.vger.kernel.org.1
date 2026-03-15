Return-Path: <netdev+bounces-267897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KLcGbN8tml0CQEAu9opvQ
	(envelope-from <netdev+bounces-267897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 10:32:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32F290567
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 10:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E43B301ECD3
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94123817E;
	Sun, 15 Mar 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV2+rUr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66F7080D
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773567152; cv=none; b=n/PUaxti9lfP3BfbY1UW+L/Em8sXa+Jcd/AgufCE33sBtz1JsqbhY3KEz58ak5YQ48P9HDhFg7Bup1jVAskb+qSF7pyGjMl8tIrHB0E2YzuegPhiAhvRt8gWLqmIGBEu3xhdy0e6poAhTgU2xArfugCqMIqHtKH2K/RW0jPbPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773567152; c=relaxed/simple;
	bh=FmRCycyBIUbm5kiRYkD7w62G9DPkNBhPT9e3rW3AMRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W036fKG0iV92YjlvtJaUdGYvMZcs3W/L0UoFNkxnoXulFvO6ZHK0hUWCj7YqmSijSz1+n16LPm3cM+TUJGWO1BeZV4CcZ/iSc0URKNuuPmD8gnmTG8lKPD3gWd2JbaWeL1dlO9rYr6S9rKyaHXo7ppeHOOqiADjgcNHsME18pZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV2+rUr7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso173094f8f.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773567149; x=1774171949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Anp4aTpFoqEgS8zfJ6ldVdzdk7GNYjztJwdtkYgS9Jw=;
        b=KV2+rUr7JvYMmhOfx3Agv0BZN8ogKF/qh3V5sijrN4Ws8ePnT3hXt0zRUv7S+QEruJ
         br3ugIOF8xypsGQDYucFyCUVqP/8MCj3bIeTrrbhqEZOUrTXVv6hne5+9XIhS1W4ZrSc
         l2uVtToiYFmssxmVtirEFij8pz1cYbnTpY4sd+sza2J0dGuQM7AaeqIeugvKDKvwfcxY
         6lZ/bAwFuJ8eRgkBdu9/bYjBM6mISyLsOz9GG06rigWoo/sH90YIp2ndg6YSY0Lw+ds2
         cz3IMzf/L2eJkfrlwwdqwv40T70mS2VK+5q5mLueRY3HmK0iAxVbKRQGcJ48XACk/4dW
         Nblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773567149; x=1774171949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Anp4aTpFoqEgS8zfJ6ldVdzdk7GNYjztJwdtkYgS9Jw=;
        b=B446S5JfOcyalEMtp9gxySw9fGF5LFztRATN9QzdPSUUSqiB8UoOQwg+jBo/pN4h+3
         BdMThAdWNEvk4Cm88DLQwIwfETSzAWF/dWSsVy2ddWnlGIY9l8B+eRXHGutKRI15hmj7
         VmbWPEuepWODL8aHrjw4+VpwApuhqK/ZW/dW3z0iXqRtg3jorOni587NRHgHy4nDGVSO
         nyv4lSYJ69nKO/0VGsQ5QjNgCAJT4LIhPaL9qM28g7vSIf0JQ4JstlqOanslssz3VEFT
         qd6DAATfg0H1QoRGP8hVbcfydwW2y1dzrVF0hxhaXBQWF0EIKCqTu5oDiB45vX5QfO2l
         PWzw==
X-Gm-Message-State: AOJu0YwnskgLSattFKFN3x8rII5cZRLp9N2G88EpvlRGV5z7hf+7G+H8
	FQITVaMpZZlGxip5tmHU92/PSz8PUHxkAX3u50aiCJz417hsuYfQYco3
X-Gm-Gg: ATEYQzzagldzGAirZsUbVMnTVEhDU6Wk6Ss5A+qijiwY418CQrEE/L1JaysAMKn4DiM
	6BV0xKNdZ9B1DivNmMWJZRUkA+eGxuh1XADG9lHCDcKGs5Apx8LuRyzAaHFpj3PdZ45Z+hfgL/H
	sZc1gP7tWuWZa+1eY3ic0ZIzwuYf9viJye4G+GqDXU5UwykET6Q4WBbmmnVok2wAORcQQJleemt
	FMEYiiRiuwxTvYKYk2ADYVeTsGpp8XP7lF2RcTBhqfusEI1/j3yW6yWLEEIvVnhSQIwkZE3Vco6
	lSXfKaO2KzI6gNSG8R8Rjs1TsD8UdFWcgHC3kNpGEBWUTAmqRfdjE89IB3cWFkXaMsuc6kCYAS4
	heJ4nGTTIdIjTJHVyp2eaSswo4V0QdFvsR+L7/Phffj/wOW/WRk4Ik5caUQaNwW22W9wahClVny
	TdoZ4PeBFxzdmwo/QTTBbTZzzIuJ4RiPF0wWpeqh591aNeicW3kTQoAz7gWaH/Ul3grmg6vgVhx
	mwfUooso/mmn6MzsihPVWHRNigOXNB18x1tv8OKwoM/60zRdEMUNmTl8bFWM4SbkQ==
X-Received: by 2002:a5d:588b:0:b0:439:be4b:6868 with SMTP id ffacd0b85a97d-43a04db4bddmr16701874f8f.47.1773567148874;
        Sun, 15 Mar 2026 02:32:28 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45? (p200300ea8f19c4005d7d7d8bdc1aae45.dip0.t-ipconnect.de. [2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bd9csm32454362f8f.21.2026.03.15.02.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 02:32:28 -0700 (PDT)
Message-ID: <322ac707-cb11-4543-bd56-d9f7cce4b52f@gmail.com>
Date: Sun, 15 Mar 2026 10:32:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: RTL8125B restores default LEDSEL values on Link Up,
 preventing persistent LED configuration
To: Huan Zhao <ms.huan.zhao@gmail.com>, Chun-Hao Lin <hau@realtek.com>,
 Javen <javen_xu@realsil.com.cn>
Cc: netdev@vger.kernel.org
References: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,realsil.com.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF32F290567
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
Thanks for the report. For preparation of a fix it would be helpful to know
whether this behavior is specific to RTL8125B, or whether this applies
to all chip variants supported by the driver.
A reset to defaults after a deep power-saving state I'd understand, but
a reset to power-up defaults on link-up sounds quirky. But maybe it's
not power-up defaults, but link speed specific defaults.

Hau, Javen: As I don't have access to chip documentation, I'd appreciate
a comment from your side. Thanks!


