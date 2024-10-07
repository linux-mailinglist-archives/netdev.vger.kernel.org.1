Return-Path: <netdev+bounces-132849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0903B99381C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A770B1F223EC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A21DE886;
	Mon,  7 Oct 2024 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVPlvYVq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745C1DE4FD;
	Mon,  7 Oct 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332508; cv=none; b=iokfQqEoZtg1BM8vJk/rAUCjlRusTVDyO+wyuT9Atfi7gat/2+qIbGBys4tkguJ2Ku7wqUJk4021+891aFGnIKuOnmeEFghdCDhOMdsX9c1OZdY1QxE2j0Snjgj4z1suwg6vPucrdKWodx86Ac/j/ExWeAyRIP8HXD3gKB8GKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332508; c=relaxed/simple;
	bh=bWBoo6hev+A1JdZZ3/T0UgCXV2e5zIWTVjvdL/7brxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmAgeGGKAmpAnX2G93CPoCEL4YN0Am5SIgyg79nxPLgV5B+sLbu9McB8EINPoxx+qe/D09M8EVnoNxmKBqbGNoC8tYl/MNeFuIrkAldxBw84RR+rHMkSVyZvqeNiSZQU3zc3HyrkAmQmutDhW+KDAo7Lh7qg/1uO5YDQtmpuJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVPlvYVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE5CC4CEC6;
	Mon,  7 Oct 2024 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332507;
	bh=bWBoo6hev+A1JdZZ3/T0UgCXV2e5zIWTVjvdL/7brxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVPlvYVqRilZa0oFH76WFqHJOVwVOyU8AduarmW+04ZOW8eaJRWzd6enkxVnoOOy4
	 7RF8RPT/xH1QwBmZbjO1ZSnFNEJw60uWgzqCRkYb1Jv158nh3CvWx6CMS+685D3U8a
	 0qZaLIB4FxhxT0pYQWR2AHc+yHFjjvIhU/LHDjLzSGlr2Xa5CHyMMsofs1pj449c8s
	 bzHn67IM6XGwD0RoPxAke5UodXSz2+NP058dGWdPkEYDmHbAIzlRsnaGOkFhiyofjv
	 AJXuN09Cmd1ujcpKNR+caTeZvM4FTAAGZNpg68607lKF23MixONc2odeSG4/h75Y0j
	 lFnZexEoJ1kYw==
Date: Mon, 7 Oct 2024 22:21:39 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, linux@weissschuh.net,
	judyhsiao@chromium.org, James.Z.Li@dell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: corrupted list in neigh_parms_release
Message-ID: <20241007202139.f5mccuwwuexuvtle@joelS2.panther.com>
References: <CALAgD-7NTOZ-8-uLbRSa35B+wKkXzzmviE1hy6ajLxwU2kfj7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-7NTOZ-8-uLbRSa35B+wKkXzzmviE1hy6ajLxwU2kfj7Q@mail.gmail.com>

On Wed, Aug 28, 2024 at 04:36:00PM -0700, Xingyu Li wrote:
> Hi,
> 
> We found a bug in Linux 6.10 using syzkaller. It is possibly a
> corrupted list  bug.
> The bug report is as follows, but unfortunately there is no generated
> syzkaller reproducer.
Sorry for the late reply. Please resend when you find a reproducer.

> 
> Bug report:
> 
> list_del corruption. next->prev should be ffff88801b3bdc18, but was
> 0000000000000000. (next=ffff88803c7c5018)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:67!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 47298 Comm: kworker/u4:24 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: netns cleanup_net
> RIP: 0010:__list_del_entry_valid_or_report+0x11e/0x120 lib/list_debug.c:65
> Code: 96 06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96
> 06 0f 0b 48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 <0f> 0b
> 80 3d bd 35 c6 0a 00 74 01 c3 31 d2 eb 02 66 90 55 41 57 41
> RSP: 0018:ffffc90002aff6b8 EFLAGS: 00010246
> RAX: 000000000000006d RBX: ffff88803c7c5020 RCX: 1547a0d62a403a00
> RDX: 0000000000000000 RSI: 0000000080000201 RDI: 0000000000000000
> RBP: ffffffff8ee71680 R08: ffffffff8172e30c R09: 1ffff9200055fe78
> R10: dffffc0000000000 R11: fffff5200055fe79 R12: dffffc0000000000
> R13: dffffc0000000000 R14: ffff88803c7c5018 R15: ffff88801b3bdc18
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6cc5e4f360 CR3: 00000000413bc000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __list_del_entry_valid include/linux/list.h:124 [inline]
>  __list_del_entry include/linux/list.h:215 [inline]
>  list_del include/linux/list.h:229 [inline]
>  neigh_parms_release+0x51/0x230 net/core/neighbour.c:1759
>  addrconf_ifdown+0x188c/0x1b50 net/ipv6/addrconf.c:4009
>  addrconf_notify+0x3c4/0x1000
>  notifier_call_chain kernel/notifier.c:93 [inline]
>  raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
>  call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
>  call_netdevice_notifiers net/core/dev.c:2044 [inline]
>  unregister_netdevice_many_notify+0xd65/0x16d0 net/core/dev.c:11219
>  cleanup_net+0x764/0xcd0 net/core/net_namespace.c:635
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
>  worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
>  kthread+0x2eb/0x380 kernel/kthread.c:389
>  ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_del_entry_valid_or_report+0x11e/0x120 lib/list_debug.c:65
> Code: 96 06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96
> 06 0f 0b 48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 <0f> 0b
> 80 3d bd 35 c6 0a 00 74 01 c3 31 d2 eb 02 66 90 55 41 57 41
> RSP: 0018:ffffc90002aff6b8 EFLAGS: 00010246
> RAX: 000000000000006d RBX: ffff88803c7c5020 RCX: 1547a0d62a403a00
> RDX: 0000000000000000 RSI: 0000000080000201 RDI: 0000000000000000
> RBP: ffffffff8ee71680 R08: ffffffff8172e30c R09: 1ffff9200055fe78
> R10: dffffc0000000000 R11: fffff5200055fe79 R12: dffffc0000000000
> R13: dffffc0000000000 R14: ffff88803c7c5018 R15: ffff88801b3bdc18
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6cc5e4f360 CR3: 00000000413bc000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> -- 
> Yours sincerely,
> Xingyu

-- 

Joel Granados

