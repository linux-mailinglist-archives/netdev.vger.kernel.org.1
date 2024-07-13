Return-Path: <netdev+bounces-111172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B9B9302CC
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F35B23511
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DFF748D;
	Sat, 13 Jul 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU7EV15N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4A8F5E;
	Sat, 13 Jul 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831402; cv=none; b=PZcQW5u7L/02OgAhza6cQxdrN1XAlYiw0n9wrx4R0SNT86U5rqsgZTfmAOPWwoMEAyXAfvBVlzck1IJZMkkgX1quFYADe7K4MHwEEp7fINVNqmVu4X16elxu+dRyktnqkz3uiDvYt51QZ47hEJ41FEaEwXwwOWnpdEybs5Lj8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831402; c=relaxed/simple;
	bh=R8JyO3eqqWBetdzBaHSoU9utazIuaOWoUNvGuk9O3GM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Awt1qcHpZnUz8KZZiPA+Iv6sTtA4YAaGgE/lPGp2fJ58rFNBvaFTXk7tpH2xkjvADmAicB6tWB90G6+wO1vRpv/Px8Tfmt9h1LJt0qUe2ITc/TMs2kfBqgn1A3Dz/lhv5gxi3LF3nQO8oFAER90Fgt53SUXvLTB3z3Gm4RmOuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU7EV15N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E910DC32782;
	Sat, 13 Jul 2024 00:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720831402;
	bh=R8JyO3eqqWBetdzBaHSoU9utazIuaOWoUNvGuk9O3GM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IU7EV15NqUZZ1kCxiPvOWkzjimxWfxZ0tJmlJh8H9plJ6HR/hnWONIF0rbWUI/aoV
	 e3zyHnjLGOyhyyVnu0G2Ir2srvw5x5FQ6gzmcJ7oBipDRlt+tpE1vmtvVa8d3SrUYG
	 9ramxz/qPe/Z3sqX11a2CvuBLBEJcHobQbTF5UK6a/+V7de/XYYsTelG6xfBN+/kCs
	 cu2qcMWa1xPh2dpkxMNhlbeuyCcwDoUylr2cF4wzsSL/Z8NJEJpZBNYLPBYh8KzyO7
	 1avBhd86tS4kfkIisBv9GTz8OiCAkK7v8eHeuq21eInEnAnRovyNkMvDguVaONZS5K
	 Kp8dUvf2pW+AA==
Date: Fri, 12 Jul 2024 17:43:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: xiujianfeng <xiujianfeng@huawei.com>, <netdev@vger.kernel.org>, Linux
 kernel mailing list <linux-kernel@vger.kernel.org>, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev
Subject: Re: [BUG REPORT] kernel BUG at lib/dynamic_queue_limits.c:99!
Message-ID: <20240712174321.603b4436@kernel.org>
In-Reply-To: <8036617e-62f3-17cb-f43a-80531e10e241@huawei.com>
References: <08227db9-6ed7-4909-838d-ce9a0233fba3@huawei.com>
	<8036617e-62f3-17cb-f43a-80531e10e241@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

CC: virtio_net maintainers and Jiri who added BQL

On Fri, 12 Jul 2024 10:12:42 +0800 xiujianfeng wrote:
> On 2024/7/12 10:08, xiujianfeng wrote:
> > I found a problem with my QEMU environment, and the log is as follows.
> > 
> > After I did the bisect to locate the issue, I found
> > 8490dd0592e85e0cceefa6b48d66dbdd73df0fb3 is the first bad commit,
> > however this is a merge commit, and I cannot further confirm which
> > specific commit caused this issue.  
> 
> It's on
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git and
> the base commit is f477dd6eede3
> 
> > 
> > ------------[ cut here ]------------
> > kernel BUG at lib/dynamic_queue_limits.c:99!
> > Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 1 UID: 0 PID: 203 Comm: ip Not tainted
> > 6.10.0-rc7-next-20240711-12643-gf477dd6eede3 #613
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> > 04/01/2014
> > RIP: 0010:dql_completed+0x212/0x230
> > Code: 41 1c 01 48 89 57 58 e9 85 fe ff ff 85 ed 40 0f 95 c5 41 39 d8 0f
> > 95 c1 40 84 cd 74 05 45 85 e4 78 0a 44 89 d9 e9 67 fe fe
> > RSP: 0018:ffffc900000f0d70 EFLAGS: 00000213
> > RAX: 0000000000000000 RBX: ffff88800413b800 RCX: ffff888005925240
> > RDX: 0000000000000000 RSI: 0000000081df1116 RDI: ffff888003a0d700
> > RBP: ffff888003a0d600 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: ffff88800a403c90 R12: 0000000000000001
> > R13: ffffc900000f0db0 R14: ffff888003a0d680 R15: ffff88803cc80000
> > FS:  00007fcf4229f1c0(0000) GS:ffff88803cc80000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005596d60d1290 CR3: 00000000093c0000 CR4: 00000000000006f0
> > Call Trace:
> >  <IRQ>
> >  ? die+0x32/0x90
> >  ? do_trap+0xdc/0x100
> >  ? dql_completed+0x212/0x230
> >  ? do_error_trap+0x60/0x80
> >  ? dql_completed+0x212/0x230
> >  ? exc_invalid_op+0x4f/0x70
> >  ? dql_completed+0x212/0x230
> >  ? asm_exc_invalid_op+0x1a/0x20
> >  ? dql_completed+0x212/0x230
> >  __free_old_xmit+0xb2/0x120
> >  free_old_xmit+0x23/0x70
> >  ? _raw_spin_trylock+0x46/0x60
> >  virtnet_poll+0xe0/0x590
> >  ? update_curr+0xf9/0x1c0
> >  ? find_held_lock+0x2b/0x80
> >  __napi_poll+0x25/0x160
> >  net_rx_action+0x177/0x310
> >  ? clockevents_program_event+0x53/0x100
> >  ? lock_release+0xa4/0x1d0
> >  ? ktime_get+0x76/0x100
> >  ? lapic_next_event+0x10/0x20
> >  handle_softirqs+0xd0/0x210
> >  do_softirq+0x3b/0x60
> >  </IRQ>
> >  <TASK>
> >  __local_bh_enable_ip+0x55/0x70
> >  virtnet_open+0xac/0x2d0
> >  __dev_open+0xda/0x190
> >  __dev_change_flags+0x1b3/0x230
> >  ? __pfx_stack_trace_consume_entry+0x10/0x10
> >  ? arch_stack_walk+0x9d/0xf0
> >  dev_change_flags+0x20/0x60
> >  do_setlink+0x27e/0x1120
> >  ? set_track_prepare+0x3b/0x60
> >  ? rtnl_newlink+0x5a/0xa0
> >  ? rtnetlink_rcv_msg+0x199/0x4c0
> >  ? __nla_validate_parse+0x5e/0xed0
> >  ? netlink_sendmsg+0x1e3/0x420
> >  ? __sock_sendmsg+0x5e/0x60
> >  ? ____sys_sendmsg+0x1da/0x210
> >  ? ___sys_sendmsg+0x7b/0xc0
> >  ? __sys_sendmsg+0x50/0x90
> >  ? do_syscall_64+0x4b/0x110
> >  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >  __rtnl_newlink+0x50d/0x990
> >  ? __kmalloc_cache_noprof+0x1a0/0x260
> >  ? __kmalloc_cache_noprof+0x204/0x260
> >  ? rtnetlink_rcv_msg+0x14e/0x4c0
> >  ? rtnl_newlink+0x5a/0xa0
> >  rtnl_newlink+0x73/0xa0
> >  rtnetlink_rcv_msg+0x199/0x4c0
> >  ? find_held_lock+0x2b/0x80
> >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> >  netlink_rcv_skb+0x56/0x100
> >  ? netlink_unicast+0x69/0x3a0
> >  netlink_unicast+0x283/0x3a0
> >  netlink_sendmsg+0x1e3/0x420
> >  __sock_sendmsg+0x5e/0x60
> >  ____sys_sendmsg+0x1da/0x210
> >  ? copy_msghdr_from_user+0x68/0xa0
> >  ___sys_sendmsg+0x7b/0xc0
> >  ? stack_depot_save_flags+0x2e/0x8a0
> >  ? check_bytes_and_report.constprop.0+0x48/0x120
> >  ? check_object+0xb5/0x3a0
> >  ? find_held_lock+0x2b/0x80
> >  __sys_sendmsg+0x50/0x90
> >  do_syscall_64+0x4b/0x110
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7fcf423c7f03
> > Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00
> > 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 08
> > RSP: 002b:00007ffcbfa59528 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcf423c7f03
> > RDX: 0000000000000000 RSI: 00007ffcbfa59590 RDI: 0000000000000003
> > RBP: 0000000066907e78 R08: 0000000000000001 R09: 00007fcf42499be0
> > R10: 0000000000000076 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffcbfa59660 R14: 0000000000000000 R15: 00005596d6088020
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:dql_completed+0x212/0x230
> > Code: 41 1c 01 48 89 57 58 e9 85 fe ff ff 85 ed 40 0f 95 c5 41 39 d8 0f
> > 95 c1 40 84 cd 74 05 45 85 e4 78 0a 44 89 d9 e9 67 fe fe
> > RSP: 0018:ffffc900000f0d70 EFLAGS: 00000213
> > RAX: 0000000000000000 RBX: ffff88800413b800 RCX: ffff888005925240
> > RDX: 0000000000000000 RSI: 0000000081df1116 RDI: ffff888003a0d700
> > RBP: ffff888003a0d600 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: ffff88800a403c90 R12: 0000000000000001
> > R13: ffffc900000f0db0 R14: ffff888003a0d680 R15: ffff88803cc80000
> > FS:  00007fcf4229f1c0(0000) GS:ffff88803cc80000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005596d60d1290 CR3: 00000000093c0000 CR4: 00000000000006f0
> > Kernel panic - not syncing: Fatal exception in interrupt
> > Kernel Offset: disabled
> > ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> >   
> 


