Return-Path: <netdev+bounces-96318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718688C4F38
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBA71F21878
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F613D531;
	Tue, 14 May 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulKMXYyj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808857CAE;
	Tue, 14 May 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681191; cv=none; b=CLn+yyGEfVSb7aoDtnpmF6Zo6THQAEqfOy/dHUx4nN/ZobPO3jldsaeZuHdJbo4v4TBlpsPfIo80t3QnFM8tdGfjqzj6lCUJeVuXySXMBN/jZPNXGKSZEjfubNd72GWBm1c0avRvK9iZEUPBAtbJlWFkRC9dLvGHSlb1VmwNZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681191; c=relaxed/simple;
	bh=+6wjo4kETnH0qhES9SSGdfmWsDXL3yIOXHhhvuxL9Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5K5gBuKsbC/zXTpcCkFbrOm/AQIgBFhhYNb5SrnkJfkEW9A6OR/lXYqcGm61+ImnJdIZqA5N7THfhBpMrWFi6/kAJlS77yo9NpZqxwNpK9QVZPa5MvYgeS2aHUdfMZ13ysLELtAoWJh2T0SVhBrK1CLLJittjJWj4tm7XVe/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulKMXYyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A62C2BD10;
	Tue, 14 May 2024 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715681191;
	bh=+6wjo4kETnH0qhES9SSGdfmWsDXL3yIOXHhhvuxL9Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulKMXYyjXhEMqiyGy9Pvq0AKhi3gHswWijNW5YD+MqiYvQKB75V1RHmNaGC/MxbKi
	 c2Dg7RMIZV25/Z9CY8CMxTWIKFBFuUHUob5oAU0JFc8a+tO+KXNiLtCiIZN31/tRrc
	 gRrNjYWbV1UbuR5ZDjCaWBPTdWFY60rPOAhvqhhhokGZsD8/pNX3UOHlDmTs+bShcs
	 PQRMfg5xu8PIvhN0/ZbuHoidmYnkXRzUFBUEzv8HlCVIQhXEAqnrOWP/oeRp6MZMqA
	 dLx3pxPjXtg+CueOT2Wil5oazrRvyAqHHuVjTDZpkq4cZ8lL8/hQDeR19OlMdOildI
	 CZNwWNWPVeqeg==
Date: Tue, 14 May 2024 11:04:29 +0100
From: Simon Horman <horms@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, kuba@kernel.org,
	roopa@nvidia.com, bridge@lists.linux.dev, edumazet@google.com,
	pabeni@redhat.com,
	syzbot+fa04eb8a56fd923fc5d8@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: bridge: mst: fix vlan use-after-free
Message-ID: <20240514100429.GB2787@kernel.org>
References: <20240513110627.770389-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513110627.770389-1-razor@blackwall.org>

On Mon, May 13, 2024 at 02:06:27PM +0300, Nikolay Aleksandrov wrote:
> syzbot reported a suspicious rcu usage[1] in bridge's mst code. While
> fixing it I noticed that nothing prevents a vlan to be freed while
> walking the list from the same path (br forward delay timer). Fix the rcu
> usage and also make sure we are not accessing freed memory by making
> br_mst_vlan_set_state use rcu read lock.
> 
> [1]
>  WARNING: suspicious RCU usage
>  6.9.0-rc6-syzkaller #0 Not tainted
>  -----------------------------
>  net/bridge/br_private.h:1599 suspicious rcu_dereference_protected() usage!
>  ...
>  stack backtrace:
>  CPU: 1 PID: 8017 Comm: syz-executor.1 Not tainted 6.9.0-rc6-syzkaller #0
>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>  Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
>   nbp_vlan_group net/bridge/br_private.h:1599 [inline]
>   br_mst_set_state+0x1ea/0x650 net/bridge/br_mst.c:105
>   br_set_state+0x28a/0x7b0 net/bridge/br_stp.c:47
>   br_forward_delay_timer_expired+0x176/0x440 net/bridge/br_stp_timer.c:88
>   call_timer_fn+0x18e/0x650 kernel/time/timer.c:1793
>   expire_timers kernel/time/timer.c:1844 [inline]
>   __run_timers kernel/time/timer.c:2418 [inline]
>   __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2429
>   run_timer_base kernel/time/timer.c:2438 [inline]
>   run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2448
>   __do_softirq+0x2c6/0x980 kernel/softirq.c:554
>   invoke_softirq kernel/softirq.c:428 [inline]
>   __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
>   </IRQ>
>   <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
>  RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
>  Code: 2b 00 74 08 4c 89 f7 e8 ba d1 84 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
>  RSP: 0018:ffffc90013657100 EFLAGS: 00000206
>  RAX: 0000000000000001 RBX: 1ffff920026cae2c RCX: 0000000000000001
>  RDX: dffffc0000000000 RSI: ffffffff8bcaca00 RDI: ffffffff8c1eaa60
>  RBP: ffffc90013657260 R08: ffffffff92efe507 R09: 1ffffffff25dfca0
>  R10: dffffc0000000000 R11: fffffbfff25dfca1 R12: 1ffff920026cae28
>  R13: dffffc0000000000 R14: ffffc90013657160 R15: 0000000000000246
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Reported-by: syzbot+fa04eb8a56fd923fc5d8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fa04eb8a56fd923fc5d8
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Simon Horman <horms@kernel.org>


