Return-Path: <netdev+bounces-157914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FFEA0C4A0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F3A7A0447
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2901F943C;
	Mon, 13 Jan 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3Lv/Qww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74081F9433
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807162; cv=none; b=LksbueuAYPut0mdSN/9U4+0NSkna+oTOlX4uNVaRXaBhFbPWXLu2OoRsmKQr9U778A56Lg3ejG4/ngWl9XKFqVJGCFftGdbWeHlqAEzdaV75s5XuJeKSaAta10ZEoCeIFi453lue+hoi2yN2zueJuVI1Do4r8Rn2GCqlJ3zQ1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807162; c=relaxed/simple;
	bh=CbsnfJp4pE5L1BnuiQA2nAeeATjCyEzVZaOEPmmlFRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdyJ6LoOyRr+8XGUVyoPcJm63lyC4//TqwW1l8L6GxIRKiAmyLlVCDo4zVbCdp2eydagB7aOng67azXOJKj+l1aG0xp+HT/jkMQmRxBGbwAe9v29RJcOSseZmW26HdwW7aZs4X0M7vbdGbAPKPcPc28xDz1PBfrF/q9Ds2XZ+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3Lv/Qww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0B4C4CEE3;
	Mon, 13 Jan 2025 22:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736807162;
	bh=CbsnfJp4pE5L1BnuiQA2nAeeATjCyEzVZaOEPmmlFRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K3Lv/Qww3/tpXwno8K51KFNEdDzgQy0sL7ARgROkLLrxncNi10qi4/Y6rDzUeyrGW
	 xsaliAMAwJwH7YVCEOIWgvB07yVhQB3qMcne/Y8aV6I6jwpYOyrF/xWTt82+xhJbYS
	 ud0Q0gInl/w+RUllaoS+8wcm5fLzFRBP/iMHZU650XGFyi3oZc5rHdrBFXzvoubRe1
	 2R4DOgS/YAuTE56MQ1/XdfYf4vto1DqNpDhRQ4roHbjyQ9Z6OFCZknhmIw8XJb2Y1+
	 l1U2PdZFlRVHSZAUaU1pThE6b+GVSay0t9l/AHrGmtd9LRKRHhBBmdnHAVrQe3HFy6
	 7BJKASkp5SCyQ==
Date: Mon, 13 Jan 2025 14:26:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 ast@fiberby.net, Shuang Li <shuali@redhat.com>
Subject: Re: [PATCHv2 net] net: sched: refine software bypass handling in
 tc_run
Message-ID: <20250113142600.6712511f@kernel.org>
In-Reply-To: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
References: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 13:42:55 -0500 Xin Long wrote:
> This patch addresses issues with filter counting in block (tcf_block),
> particularly for software bypass scenarios, by introducing a more
> accurate mechanism using useswcnt.

I think this is causing:

[   35.565404][  T350] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
[   35.565956][  T350] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 350, name: tc
[   35.566288][  T350] preempt_count: 1, expected: 0
[   35.566529][  T350] RCU nest depth: 0, expected: 0
[   35.566753][  T350] 2 locks held by tc/350:
[   35.566922][  T350]  #0: ffffffff9d1e7e88 (rtnl_mutex){+.+.}-{4:4}, at: tc_new_tfilter+0x902/0x1c90
[   35.567325][  T350]  #1: ffff88800a377b90 (&tp->lock){+.+.}-{3:3}, at: tc_new_tfilter+0x9d1/0x1c90
[   35.567707][  T350] CPU: 2 UID: 0 PID: 350 Comm: tc Not tainted 6.13.0-rc7-virtme #1
[   35.568006][  T350] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   35.568259][  T350] Call Trace:
[   35.568414][  T350]  <TASK>
[   35.568520][  T350]  dump_stack_lvl+0xb0/0xd0
[   35.568745][  T350]  __might_resched+0x2f8/0x530
[   35.568945][  T350]  ? tc_new_tfilter+0x9d1/0x1c90
[   35.569151][  T350]  cpus_read_lock+0x1b/0xe0
[   35.569349][  T350]  static_key_slow_inc+0x13/0x30
[   35.569547][  T350]  tc_new_tfilter+0x1523/0x1c90
[   35.569757][  T350]  ? mark_lock+0x38/0x3e0
[   35.569918][  T350]  ? __pfx_tc_new_tfilter+0x10/0x10
[   35.570142][  T350]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   35.570555][  T350]  ? rtnetlink_rcv_msg+0x6ef/0xc10
[   35.570767][  T350]  ? __pfx_tc_new_tfilter+0x10/0x10
[   35.570968][  T350]  rtnetlink_rcv_msg+0x712/0xc10
[   35.571174][  T350]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   35.571393][  T350]  ? hlock_class+0x4e/0x130
[   35.571591][  T350]  ? mark_lock+0x38/0x3e0
[   35.571749][  T350]  ? __lock_acquire+0xb9a/0x1680
[   35.571951][  T350]  netlink_rcv_skb+0x130/0x360
[   35.572153][  T350]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   35.572353][  T350]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   35.572571][  T350]  ? netlink_deliver_tap+0x13e/0x340
[   35.572772][  T350]  ? netlink_deliver_tap+0xc3/0x340
[   35.572982][  T350]  netlink_unicast+0x44b/0x710
[   35.573188][  T350]  ? __pfx_netlink_unicast+0x10/0x10
[   35.573387][  T350]  ? find_held_lock+0x2c/0x110
[   35.573591][  T350]  netlink_sendmsg+0x723/0xbe0
[   35.573796][  T350]  ? __pfx_netlink_sendmsg+0x10/0x10
[   35.574006][  T350]  ____sys_sendmsg+0x7ac/0xa10
[   35.574207][  T350]  ? __pfx_____sys_sendmsg+0x10/0x10
[   35.574407][  T350]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[   35.574668][  T350]  ___sys_sendmsg+0xee/0x170
[   35.574866][  T350]  ? __debug_check_no_obj_freed+0x253/0x520
[   35.575114][  T350]  ? __pfx____sys_sendmsg+0x10/0x10
[   35.575318][  T350]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
[   35.575565][  T350]  ? __pfx_free_object_rcu+0x10/0x10
[   35.575766][  T350]  ? trace_rcu_segcb_stats+0x36/0x1e0
[   35.575973][  T350]  ? lockdep_hardirqs_on_prepare+0x275/0x410
[   35.576225][  T350]  ? kmem_cache_free+0xf8/0x330
[   35.576423][  T350]  ? do_sys_openat2+0x141/0x160
[   35.576620][  T350]  ? do_sys_openat2+0x10a/0x160
[   35.576821][  T350]  ? do_sys_openat2+0x10a/0x160
[   35.577027][  T350]  __sys_sendmsg+0x109/0x1a0
[   35.577226][  T350]  ? __pfx___sys_sendmsg+0x10/0x10
[   35.577448][  T350]  do_syscall_64+0xc1/0x1d0
[   35.577648][  T350]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   35.577892][  T350] RIP: 0033:0x7f539e60b9a7
[   35.578106][  T350] Code: Unable to access opcode bytes at 0x7f539e60b97d.
[   35.578359][  T350] RSP: 002b:00007ffd917a3fc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   35.578670][  T350] RAX: ffffffffffffffda RBX: 000000000047dbc0 RCX: 00007f539e60b9a7
[   35.578979][  T350] RDX: 0000000000000000 RSI: 00007ffd917a4030 RDI: 0000000000000005
[   35.579271][  T350] RBP: 000000000000dd86 R08: 0000000000000000 R09: 0000000000000000
[   35.579567][  T350] R10: 00007f539e4c4708 R11: 0000000000000246 R12: 00007ffd917a9973
[   35.579862][  T350] R13: 00000000678583dc R14: 0000000000483b60 R15: 00007ffd917a9977
[   35.580179][  T350]  </TASK>
-- 
pw-bot: cr

