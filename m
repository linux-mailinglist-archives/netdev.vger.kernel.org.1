Return-Path: <netdev+bounces-104465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6CD90C9EA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AE61F21D73
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BB7185E79;
	Tue, 18 Jun 2024 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pqBUgYGL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9kzf8PVi"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465361581EF;
	Tue, 18 Jun 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708564; cv=none; b=bHD4MtOWfvFesZT0t6fcQfalTZ1nXG0XS6IK8phHrmaUIFTIBCenqL0oeyPY8bdrKT34wQvTPQuEmnV8i8wqO2gGKfy1o8+q/Eqi2n+vb4u574mEti7AXeP7RgUzHOo8JRdzEgs6KjPN7bsWHQIfxjgBeSz33tMKQHfuG99/uy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708564; c=relaxed/simple;
	bh=y5HsbT5jRNYRTXQM94q8J6xW8lmsgNiQLRDa7hBnciE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MzSV39a7RLNBK2ABgh0GGQfpLzKgTRvJ/MNVVGxB9DPZcbCEHjtyE2pklU185/8x0buO086mdDtKS3SEUK0X3gJ1dbt/0tXKUork1TP8id0IpptxsVZPagIYhFmLvIV4nOl9AJWSQeMHbDCdZ2h6s6mcufEzM9HbHu3pFLV5MX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pqBUgYGL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9kzf8PVi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718708561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrmwcXMzcWaczPV/n3eM3LrRD+UsKzXu3JcMOPGCJqo=;
	b=pqBUgYGL1ioi5qG7fflSY/IuKpF3N/Tii2lkcY5zWBgZWSpsVcU27+Cyn1aqUNeGK+xNRQ
	feAyS6hwLMD6UJBabVntutzPxarSx4b1789rfwlwH/mvmSdZOba7pyXnhojTkjvKO9Nq7k
	e29Vj17pzV+I3W/SpqvcKxv97Sse3BsmuD/waKAPaX/6wY9ooAvCf7r4/iifOuXSPAq1x4
	Ym3tGFLlldzwV+7cpPe+tLlkrLD8fIDbzm2FL8vTLZ8GosQW7INzZMjXjI7VQ1VjPNrzgi
	UTe/K68kUvZi74gVkUZtgBR0fbjpOyzcqp94RuAPJl1Es4XReN3/C0JCTCRhUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718708561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrmwcXMzcWaczPV/n3eM3LrRD+UsKzXu3JcMOPGCJqo=;
	b=9kzf8PViNV38alYXmBbji4vW411yTTAVJbic4aFX/h45kgQc/VDJlK/AcEBLzdiF9eR8+N
	WQl4SxUAg5X3k/Bw==
To: syzbot <syzbot+e620313b27e2be807d3b@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek
 <pmladek@suse.com>, John Ogness <jogness@linutronix.de>
Subject: Re: [syzbot] [kernel?] possible deadlock in hrtimer_try_to_cancel
In-Reply-To: <000000000000d6e3cf061b2531ea@google.com>
References: <000000000000d6e3cf061b2531ea@google.com>
Date: Tue, 18 Jun 2024 13:02:40 +0200
Message-ID: <87r0cuqzsf.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 18 2024 at 00:40, syzbot wrote:
> ------------[ cut here ]------------
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0 Not tainted
> ------------------------------------------------------
> kworker/u32:10/1146 is trying to acquire lock:
> ffffffff8dba3118 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
>
> but task is already holding lock:
> ffff88802c32c9d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
> ffff88802c32c9d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_try_to_cancel+0xa9/0x500 kernel/time/hrtimer.c:1333
>
> which lock already depends on the new lock.

Right. That's caused by this:

> WARNING: CPU: 3 PID: 1146 at lib/timerqueue.c:55 timerqueue_del+0xfe/0x150 lib/timerqueue.c:55

         WARN_ON_ONCE(RB_EMPTY_NODE(&node->node));

The warning is inside the hrtimer base lock held region which is known
to be problematic vs. printk...

> Modules linked in:
> CPU: 3 PID: 1146 Comm: kworker/u32:10 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Workqueue: netns cleanup_net
> RIP: 0010:timerqueue_del+0xfe/0x150 lib/timerqueue.c:55
> Code: 28 9e ff ff 4c 89 e1 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 11 00 75 45 48 89 45 08 e9 7b ff ff ff e8 f3 90 c0 f6 90 <0f> 0b 90 e9 43 ff ff ff 48 89 df e8 a2 c4 1d f7 eb 8a 4c 89 e7 e8
> RSP: 0018:ffffc90007267918 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffe8ffad04d080 RCX: ffffffff8acdfe20
> RDX: ffff88802045a440 RSI: ffffffff8acdfedd RDI: 0000000000000006
> RBP: ffff88802c32ca90 R08: 0000000000000006 R09: ffffe8ffad04d080
> R10: ffffe8ffad04d080 R11: 0000000000000001 R12: ffffe8ffad04d080
> R13: 0000000000000001 R14: ffff88802c32c9c0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000ffeb8c2c CR3: 000000005beb8000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __remove_hrtimer+0x99/0x290 kernel/time/hrtimer.c:1118
>  remove_hrtimer kernel/time/hrtimer.c:1167 [inline]
>  hrtimer_try_to_cancel+0x2a5/0x500 kernel/time/hrtimer.c:1336
>  hrtimer_cancel+0x16/0x40 kernel/time/hrtimer.c:1445
>  napi_disable+0x13a/0x1e0 net/core/dev.c:6648
>  gro_cells_destroy net/core/gro_cells.c:116 [inline]
>  gro_cells_destroy+0x102/0x4d0 net/core/gro_cells.c:106
>  netdev_run_todo+0x775/0x1250 net/core/dev.c:10693
>  cleanup_net+0x591/0xbf0 net/core/net_namespace.c:636
>  process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
>  process_scheduled_works kernel/workqueue.c:3312 [inline]
>  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

IOW, this tries to remove a hrtimer which is not queued, but has
hrtimer::state != HRTIMER_STATE_INACTIVE.

This means the timer is either not initialized or got corrupted.

The circular locking problem is the fallout which cannot be solved due
to the current printk semantics. The upcoming atomic consoles should
handle this nicely.

Thanks,

        tglx

