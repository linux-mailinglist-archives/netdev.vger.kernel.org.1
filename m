Return-Path: <netdev+bounces-172443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8DA54A9C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB025188A2ED
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5020B7F7;
	Thu,  6 Mar 2025 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KSNf9NaX"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630820B1E4;
	Thu,  6 Mar 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263878; cv=none; b=lDlLo+f3Z4hOELHHufsn5dFZl1FgFWJoqp3pXCaA+ExSS6cBFXEBzSFmEOBUHEElG2mSHcrBuHpRCLSenoas+9jeMJKvVMJz9zQVJleijeeAMDUJnJ0mMk0un/wkFq/fdjaZfLvzs9RR+z3GknIDbE8HvKGWHwHwzABsbGJVSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263878; c=relaxed/simple;
	bh=TlUDW05wiBr8NQ7PIcGNl2xXhbKOhVFYimd3dlIl6Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mO9eYE8UPkLc1BpfnoZHg2khl/5J1URU9ZJRSn6vm18MdN5bWOspSATf+8dUYLLnwYTCPU6i5jPAnPGGTjXOEXB0vA5fJ0O9+v3ivoXS0GMAttk+EzUQB0Cz/CeI4YD0UIr9OhDjsC//dc1R2vxtv/0d5SoZtji5OjDAGY0z6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KSNf9NaX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 20E2740E0214;
	Thu,  6 Mar 2025 12:24:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id liJDraIwtjRa; Thu,  6 Mar 2025 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741263868; bh=BWyyMK8vDQwsydUw2VxbIvYQKhjrWbAedtXpQPzoiPo=;
	h=Date:From:To:Cc:Subject:From;
	b=KSNf9NaXOQmCIV3Ia3GlVK+bKltSnztdW2kTITlGoN594vzghFUlx9B9OQVf2K+WA
	 e5+RJhi2CaqJlwotm8axqdNOvXMhs+r73orY/zd4upeyBLAt256gP9wtmg7uCyhUYz
	 hSTj3KqXDRP3Ze/TMVlQXnWeUiOHJrdMrjXBOE932FqBoEbJIWtqDeebm0IzwWPEcM
	 gS2uxTpk/pS3WrG2VaGx09F/GtAZ7IS2WZpsXPqQyUdgNUpyhN7VCS7ApMCPySNNYa
	 tBgWLMaCL9qBa7UvZWBC/7hiYRgvuvCXq/YYuQrl0GChP/VTu0tNcB1X/6mz87nyCG
	 ARrW0e27IeosBsFQTA2LObxXRcxaBHjW5v6QTWEdqV9anI7dl5u4nItz8F0s4zjCL/
	 7U8Om8tYOJe9MTw6xpWkfOvJsFce+qdtPJLP+6iEHcZbsLZhlCvAnXp1Jntt5nvYkL
	 527AWFYQpmpqI2KV7LwvhHdU8Yg2t+0svMcYD9XH3ILeviQL1itmrFIj0OlkZZDItt
	 v/KpsV1R6TSoZ6YqFX4GPcpFX2jwlSxBEDBrf4FFIdMPVlAlSS+TpN9gvEDpETnWaG
	 W86iESUptpajCyHSFiAFuF8aldXBVOvRLxXDakxgmZPiH79xxTstOPp/AmIyOaj+8q
	 WlSKlhzTekdtJ+AbNFKAhV8o=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 367EC40E020E;
	Thu,  6 Mar 2025 12:24:19 +0000 (UTC)
Date: Thu, 6 Mar 2025 13:24:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, linux-kernel@vger.kernel.org,
	x86-ml <x86@kernel.org>
Subject: request_irq() with local bh disabled
Message-ID: <20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

this is latest Linus/master + tip/master on a 32-bit x86:

tglx says one cannot request_irq() with local bh disabled.

[   17.354927] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   17.906996] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   17.950874] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   18.034884] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   18.038920] cfg80211: failed to load regulatory.db

[   18.726638] =============================
[   18.726638] [ BUG: Invalid wait context ]
[   18.726638] 6.14.0-rc5+ #1 Not tainted
[   18.726638] -----------------------------
[   18.726638] ip/991 is trying to lock:
[   18.726638] c36a2d64 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq+0x98/0x6cc
[   18.726638] other info that might help us debug this:
[   18.746793] context-{5:5}
[   18.746793] 2 locks held by ip/991:
[   18.746793]  #0: c261f920 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x336/0x9fc
[   18.746793]  #1: c1f56ea0 (local_bh){.+.+}-{1:3}, at: dev_set_rx_mode+0x5/0x80
[   18.746793] stack backtrace:
[   18.746793] CPU: 1 UID: 0 PID: 991 Comm: ip Not tainted 6.14.0-rc5+ #1
[   18.746793] Hardware name: Acer AOA150/, BIOS v0.3309 10/06/2008
[   18.746793] Call Trace:
[   18.746793]  dump_stack_lvl+0x94/0x10c
[   18.746793]  dump_stack+0x13/0x18
[   18.746793]  __lock_acquire+0xa1c/0x2500
[   18.746793]  lock_acquire+0xc3/0x2ac
[   18.746793]  ? __setup_irq+0x98/0x6cc
[   18.746793]  ? debug_smp_processor_id+0x12/0x14
[   18.746793]  ? __mutex_lock+0x54/0xcb8
[   18.746793]  ? __mutex_lock+0x54/0xcb8
[   18.746793]  ? trace_preempt_off+0x2e/0xb4
[   18.746793]  ? __might_sleep+0x35/0x6c
[   18.746793]  ? __mutex_lock+0x54/0xcb8
[   18.746793]  ? preempt_count_add+0x6c/0xd4
[   18.746793]  __mutex_lock+0x82/0xcb8
[   18.746793]  ? __setup_irq+0x98/0x6cc
[   18.746793]  mutex_lock_nested+0x27/0x2c
[   18.746793]  ? __setup_irq+0x98/0x6cc
[   18.746793]  __setup_irq+0x98/0x6cc
[   18.746793]  ? __kmalloc_cache_noprof+0x1b1/0x2d0
[   18.746793]  ? request_threaded_irq+0x84/0x188
[   18.746793]  request_threaded_irq+0xc2/0x188
[   18.746793]  rtl_open+0x33b/0x5e4 [r8169]
[   18.746793]  ? raw_notifier_call_chain+0x20/0x24
[   18.746793]  __dev_open+0xce/0x17c
[   18.746793]  ? dev_set_rx_mode+0x74/0x80
[   18.746793]  __dev_change_flags+0x176/0x1cc
[   18.746793]  dev_change_flags+0x29/0x6c
[   18.746793]  do_setlink.isra.0+0x28f/0x1180
[   18.746793]  ? __mutex_lock+0x107/0xcb8
[   18.746793]  ? __mutex_lock+0x107/0xcb8
[   18.746793]  ? trace_preempt_on+0x2e/0xac
[   18.746793]  ? __mutex_lock+0x107/0xcb8
[   18.746793]  ? preempt_count_sub+0xb1/0x100
[   18.746793]  ? debug_smp_processor_id+0x12/0x14
[   18.746793]  ? __mutex_lock+0x107/0xcb8
[   18.746793]  ? rtnl_newlink+0x336/0x9fc
[   18.746793]  ? __kmalloc_cache_noprof+0x1b1/0x2d0
[   18.746793]  ? do_alloc_pages+0x64/0xbc
[   18.746793]  rtnl_newlink+0x762/0x9fc
[   18.746793]  ? __this_cpu_preempt_check+0xf/0x20
[   18.746793]  ? do_alloc_pages+0x64/0xbc
[   18.746793]  ? do_setlink.isra.0+0x1180/0x1180
[   18.746793]  rtnetlink_rcv_msg+0x3fd/0x584
[   18.746793]  ? rtnetlink_rcv_msg+0x58/0x584
[   18.746793]  ? netlink_deliver_tap.constprop.0+0xe5/0x4ac
[   18.746793]  ? local_clock_noinstr+0x68/0x1c0
[   18.746793]  ? rtnl_fdb_dump+0x370/0x370
[   18.746793]  netlink_rcv_skb+0x42/0xdc
[   18.746793]  ? do_alloc_pages+0x64/0xbc
[   18.746793]  rtnetlink_rcv+0x12/0x14
[   18.746793]  netlink_unicast+0x198/0x2a8
[   18.746793]  netlink_sendmsg+0x1bb/0x3ec
[   18.746793]  ? netlink_unicast+0x2a8/0x2a8
[   18.746793]  ____sys_sendmsg+0x233/0x280
[   18.746793]  ? netlink_unicast+0x2a8/0x2a8
[   18.746793]  ? do_alloc_pages+0x64/0xbc
[   18.746793]  ___sys_sendmsg+0x66/0x9c
[   18.746793]  ? __might_fault+0x3b/0x84
[   18.746793]  ? __might_fault+0x3b/0x84
[   18.746793]  ? local_clock_noinstr+0x68/0x1c0
[   18.746793]  ? do_alloc_pages+0x64/0xbc
[   18.746793]  __sys_sendmsg+0x52/0x88
[   18.746793]  ? _copy_from_user+0x51/0x60
[   18.746793]  __ia32_sys_socketcall+0x30b/0x320
[   18.746793]  ? __might_fault+0x7d/0x84
[   18.746793]  ia32_sys_call+0x2695/0x284c
[   18.746793]  __do_fast_syscall_32+0x67/0xf0
[   18.746793]  do_fast_syscall_32+0x29/0x5c
[   18.746793]  do_SYSENTER_32+0x15/0x18
[   18.746793]  entry_SYSENTER_32+0x98/0xf9
[   18.746793] EIP: 0xb7edd579
[   18.746793] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[   18.746793] EAX: ffffffda EBX: 00000010 ECX: bff4ab70 EDX: 00000000
[   18.746793] ESI: b7e5f000 EDI: 005692a0 EBP: 00000010 ESP: bff4ab60
[   18.746793] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
[   18.874284] hpet: Lost 9 RTC interrupts
[   18.874867] RTL8201CP Ethernet r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
[   18.932445] r8169 0000:02:00.0 eth0: Link is Down
[   19.264574] ath5k 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   19.269295] ath5k 0000:03:00.0: registered as 'phy0'
[   19.827560] ath: EEPROM regdomain: 0x65
[   19.829929] ath: EEPROM indicates we should expect a direct regpair map
[   19.832273] ath: Country alpha2 being used: 00
[   19.834396] ath: Regpair used: 0x65
[   19.837790] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   19.854976] ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x70)
[   20.566012] r8169 0000:02:00.0 eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[   20.966578] NET: Registered PF_INET6 protocol family

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

