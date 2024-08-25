Return-Path: <netdev+bounces-121745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954195E4F3
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 21:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD46E1C2074F
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053014D9FE;
	Sun, 25 Aug 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cmHnKLWb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/1yXIiW8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687E3987D;
	Sun, 25 Aug 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724614706; cv=none; b=LbjqzR7nUrzvhzSCbt1DKZftOtXrYldiHqRF6zyORy8RS7tLC7E3n2MYZDSe+qE/cnAjDLfMk5LaReVwYzTU50j9dcG7TaVfv5jwowPqGILutgdY1LQFXOlmazsGSkZeidil9arlQ6IkJCFtu6o0pfi970zSlLlgMCJGIJfAtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724614706; c=relaxed/simple;
	bh=/HyReDsS/Q6abv3UjVGJuEKWi48E0Jj7lks2zvcH4Xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eIVXCd6UjueWTGYYEYKlU83y6miSEKICp4xhUz4fjRLdNoWhmgzzaIfgxSuQvzQwTgQvP/1vLXqC5P1foPys6640uL2qGcSFlcy4LhXe5RNn0fwodCfNk3q/+44WANeA2GHihfMn/YuZk6LKQ8PT2VkjII037Gw2USyCKPOwTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cmHnKLWb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/1yXIiW8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724614703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJSKvEmkkzKpv96rA25JobqOC+oEXXuQpxCL8IroZqk=;
	b=cmHnKLWbQNXA/+iyZvEpPaoFirFl2niT1BGEyekcbBr/gvn+f0bBxShpXQ+wh2C93kc+IT
	jOnEz+gXvynoIybwJF5SABT3PSeLjMM4/00EwKYsm0yCIRRsrx+2D2dBtynjp1nFpHCOBG
	Qva4hyQSREKxL4Rr+k1PigdH0BDm109IynQB25rfsNMaMxPY/c4tBlAP3DPh+KOU9xJ6pd
	PtQ273g0pscLvX/1Jqplw1ECHZjap1HLfjX/aBO8Tw2N116qknRrUe/sZCRnUOYVCToBOn
	16AxudUM1BzOslAjVq/ekZhwQVyteiXVPhMhYZsRfpI9E85x86wU0/Zdyz8FqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724614703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJSKvEmkkzKpv96rA25JobqOC+oEXXuQpxCL8IroZqk=;
	b=/1yXIiW8Ghqg/98u5IEKBs3qa84ZRMI+Amn6liwCA+ecB6yQkJydjWoqnKhZc+e+hVb56s
	X7LdogQcik1ArxCw==
To: Xingyu Li <xli399@ucr.edu>, anna-maria@linutronix.de,
 frederic@kernel.org, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>
Subject: Re: BUG: general protection fault in hrtimer_try_to_cancel
In-Reply-To: <CALAgD-4F7g=Fqy0KL0t0SaZburRiENsnzm_CYbb8SzbAk1+8oA@mail.gmail.com>
References: <CALAgD-4F7g=Fqy0KL0t0SaZburRiENsnzm_CYbb8SzbAk1+8oA@mail.gmail.com>
Date: Sun, 25 Aug 2024 21:38:22 +0200
Message-ID: <87plpwe6kx.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 24 2024 at 21:50, Xingyu Li wrote:

Cc=: network folks.

> We found a bug in Linux 6.10. It is probably a null pointer dereference bug.
> The reason is probably that in line 1615 of kernel/time/hrtimer.c,
> before "seq = raw_read_seqcount_begin(&base->seq);", there is no null
> pointer check for 'base'.

So something in the network code invokes hrtimer_cancel() in a teardown
operation on a non-initialized hrtimer and hrtimers contrary to the timer
wheel does not check for initialization. That's trivial to fix, see
below.

But that does not explain the actual root cause. That NULL pointer
dereference is just the messenger.

This is gro_cells related:

>  hrtimer_cancel+0x12/0x50 kernel/time/hrtimer.c:1447
>  napi_disable+0x1b6/0x210 net/core/dev.c:6648
>  gro_cells_destroy+0x12a/0x3d0 net/core/gro_cells.c:116

gro_cells_init() invokes netif_napi_add() for each per cpu
cell. netif_napi_add() invokes hrtimer_init().

So how can gro_cells_destroy() have a non-initialized hrtimer?

I defer that question to the network people

Thanks,

        tglx

> The bug report is as follows, but unfortunately there is no generated
> syzkaller reproducer.
>
> bridge0: port 2(bridge_slave_1) entered disabled state
> bridge_slave_0: left allmulticast mode
> bridge_slave_0: left promiscuous mode
> bridge0: port 1(bridge_slave_0) entered disabled state
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 0 PID: 29 Comm: kworker/u4:2 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: netns cleanup_net
> RIP: 0010:__seqprop_raw_spinlock_sequence include/linux/seqlock.h:226 [inline]
> RIP: 0010:hrtimer_active kernel/time/hrtimer.c:1615 [inline]
> RIP: 0010:hrtimer_try_to_cancel+0x7c/0x410 kernel/time/hrtimer.c:1332
> Code: 2f 12 00 48 8b 5c 24 10 48 8b 44 24 08 42 80 3c 30 00 74 08 48
> 89 df e8 02 3b 75 00 4c 8b 3b 4d 8d 67 10 4c 89 e3 48 c1 eb 03 <42> 8a
> 04 33 84 c0 0f 85 f4 00 00 00 41 8b 2c 24 89 ee 83 e6 01 31
> RSP: 0018:ffffc9000080f7a0 EFLAGS: 00010202
> RAX: 1ffffd1ffff88a14 RBX: 0000000000000002 RCX: 1ffffd1ffff88a15
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffc45070
> RBP: ffffe8ffffc45070 R08: ffffc9000080f867 R09: 1ffff92000101f0c
> R10: dffffc0000000000 R11: fffff52000101f0d R12: 0000000000000010
> R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f09772124b0 CR3: 000000001f978000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  hrtimer_cancel+0x12/0x50 kernel/time/hrtimer.c:1447
>  napi_disable+0x1b6/0x210 net/core/dev.c:6648
>  gro_cells_destroy+0x12a/0x3d0 net/core/gro_cells.c:116
>  unregister_netdevice_many_notify+0x10a5/0x16d0 net/core/dev.c:11239
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
> RIP: 0010:__seqprop_raw_spinlock_sequence include/linux/seqlock.h:226 [inline]
> RIP: 0010:hrtimer_active kernel/time/hrtimer.c:1615 [inline]
> RIP: 0010:hrtimer_try_to_cancel+0x7c/0x410 kernel/time/hrtimer.c:1332
> Code: 2f 12 00 48 8b 5c 24 10 48 8b 44 24 08 42 80 3c 30 00 74 08 48
> 89 df e8 02 3b 75 00 4c 8b 3b 4d 8d 67 10 4c 89 e3 48 c1 eb 03 <42> 8a
> 04 33 84 c0 0f 85 f4 00 00 00 41 8b 2c 24 89 ee 83 e6 01 31
> RSP: 0018:ffffc9000080f7a0 EFLAGS: 00010202
> RAX: 1ffffd1ffff88a14 RBX: 0000000000000002 RCX: 1ffffd1ffff88a15
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffc45070
> RBP: ffffe8ffffc45070 R08: ffffc9000080f867 R09: 1ffff92000101f0c
> R10: dffffc0000000000 R11: fffff52000101f0d R12: 0000000000000010
> R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000563cd2cf2058 CR3: 000000001d166000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0: 12 00                 adc    (%rax),%al
>    2: 48 8b 5c 24 10       mov    0x10(%rsp),%rbx
>    7: 48 8b 44 24 08       mov    0x8(%rsp),%rax
>    c: 42 80 3c 30 00       cmpb   $0x0,(%rax,%r14,1)
>   11: 74 08                 je     0x1b
>   13: 48 89 df             mov    %rbx,%rdi
>   16: e8 02 3b 75 00       call   0x753b1d
>   1b: 4c 8b 3b             mov    (%rbx),%r15
>   1e: 4d 8d 67 10           lea    0x10(%r15),%r12
>   22: 4c 89 e3             mov    %r12,%rbx
>   25: 48 c1 eb 03           shr    $0x3,%rbx
> * 29: 42 8a 04 33           mov    (%rbx,%r14,1),%al <-- trapping instruction
>   2d: 84 c0                 test   %al,%al
>   2f: 0f 85 f4 00 00 00     jne    0x129
>   35: 41 8b 2c 24           mov    (%r12),%ebp
>   39: 89 ee                 mov    %ebp,%esi
>   3b: 83 e6 01             and    $0x1,%esi
>   3e: 31                   .byte 0x31

---
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a023946f8558..448bce5e6a05 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -485,6 +485,11 @@ static inline void debug_deactivate(struct hrtimer *timer)
 	trace_hrtimer_cancel(timer);
 }
 
+static inline bool hrtimer_initialized(const struct hrtimer *timer)
+{
+	return timer->base && timer->function;
+}
+
 static struct hrtimer_clock_base *
 __next_base(struct hrtimer_cpu_base *cpu_base, unsigned int *active)
 {
@@ -1285,7 +1290,7 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(!timer->function))
+	if (WARN_ON_ONCE(!hrtimer_initialized(timer)))
 		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
@@ -1612,6 +1617,9 @@ bool hrtimer_active(const struct hrtimer *timer)
 	struct hrtimer_clock_base *base;
 	unsigned int seq;
 
+	if (WARN_ON_ONCE(!hrtimer_initialized(timer)))
+		return false;
+
 	do {
 		base = READ_ONCE(timer->base);
 		seq = raw_read_seqcount_begin(&base->seq);

