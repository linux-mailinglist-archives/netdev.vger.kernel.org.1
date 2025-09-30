Return-Path: <netdev+bounces-227367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E924DBAD299
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EE24A23DC
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356324DD09;
	Tue, 30 Sep 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FjaX0TRe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8W4XjaNY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824F1C84DE;
	Tue, 30 Sep 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242191; cv=none; b=rPpaUj/7nFdH+hRcGDVPehhZKBKrEQ6PW1gUP0E5apt5jcthEWkPmxiDqN78IRSphnDzsewNSUuKdzznAYQ86NivXuCA64Lq6Rr/0Xb3TJe9nO1GMcBaBhpy07tS2a4pzi9h3xyvx8Hq9gNJYcBjiWRXdu7sflQCytUsmJzwRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242191; c=relaxed/simple;
	bh=GrPGI+yiog7WNMHggnC50f0/Q852fTmKJEq510AxMGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F7TBdBLKb1v3LFoAmSOZs8Tn9kLRF1JNN16HA7GVi5JHn5dWiV1RXi+w0kNx7XQomQxfZyAz/p8K+imPHT4B8wDiL6C9mbNdegbSwkXcQJuDKD1FiLB+mpDRrFW/IpJzzHkRxWmqesthEvCWCPF07yAOUV/ItqJrpsfa695EYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FjaX0TRe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8W4XjaNY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759242183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/n7nMiXERpgb40T7ZbKDTmup8KjTwQFVnNmM/Ve1kwU=;
	b=FjaX0TRedgyj2vyQrxNPL7AoxU54n3MTzzYUi97ISmAb1KLprsAk88FOl0J/QUZXNFwECd
	CM0MMvVy9spWIsLZgBCAxqx5Hj/MjUUUKEbYvjZroelDNx+g1qSnK8te+AhsOzSkSJ05X7
	jau6QjpRAD3bgM3QfmrMbaJK3toucU2Ypf5sbtII7yqYXBlYdnBzrGVaIQBSZnGIUxVF55
	rrw0UcmgX+GgAVW9ovaNm7yTURUK0bqn8Ll4InT+UL22+/VX0v/lm0rLRK8zA8AT7MtBII
	PANRaSlSE1cndhTLgSVzddDzK9+/6lNNGG9aFt0l2O0JrNXqW6XwA1A2jKfG7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759242183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/n7nMiXERpgb40T7ZbKDTmup8KjTwQFVnNmM/Ve1kwU=;
	b=8W4XjaNYBdxTW2NVNiiGV/nhbibksF0A03DxoI9K2fbFLQj2wy/A2iWwixotyxUJ0iC28u
	G5WvdFsBLTUNDoAA==
To: Calvin Owens <calvin@wbinvd.org>, Breno Leitao <leitao@debian.org>,
    Sebastian Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Mike Galbraith <efault@gmx.de>,
    Simon Horman <horms@kernel.org>, kuba@kernel.org,
    Pavel Begunkov <asml.silence@gmail.com>,
    Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org,
    LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
    boqun.feng@gmail.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
In-Reply-To: <aNvh2Cd2i9MVA1d3@mozart.vkv.me>
References: <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
 <847by65wfj.fsf@jogness.linutronix.de> <aMGVa5kGLQBvTRB9@pathway.suse.cz>
 <oc46gdpmmlly5o44obvmoatfqo5bhpgv7pabpvb6sjuqioymcg@gjsma3ghoz35>
 <aNvh2Cd2i9MVA1d3@mozart.vkv.me>
Date: Tue, 30 Sep 2025 16:29:02 +0206
Message-ID: <84frc4j9yx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(Added Sebastian.)

On 2025-09-30, Calvin Owens <calvin@wbinvd.org> wrote:
> On Wednesday 09/10 at 11:26 -0700, Breno Leitao wrote:
>> On Wed, Sep 10, 2025 at 05:12:43PM +0200, Petr Mladek wrote:
>> > On Wed 2025-09-10 14:28:40, John Ogness wrote:
>> 
>> > > @pmladek: We could introduce a new console flag (NBCON_ATOMIC_UNSAFE) so
>> > > that the callback is only used by nbcon_atomic_flush_unsafe().
>> > 
>> > This might be an acceptable compromise. It would try to emit messages
>> > only at the very end of panic() as the last desperate attempt.
>> > 
>> > Just to be sure, what do you mean with unsafe?
>> > 
>> >     + taking IRQ unsafe locks?
>> 
>> Taking IRQ unsafe locks is the major issue we have in netconsole today.
>> Basically the drivers can implement IRQ unsafe locks in their
>> .ndo_start_xmit() callback, and in some cases those are IRQ unsafe,
>> which doesn't match with .write_atomic(), which expect all the inner
>> locks to be IRQ safe.
>
> Hmm, I'm also hitting the below on next-20250926 with translated=strict,
> the triggering acquisition is here:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/iova.c?id=30d4efb2f5a515a60fe6b0ca85362cbebea21e2f#n832
>
> Naively I'd think the IOMMU code would need to be safe to call with
> interrupts disabled? Do we need raw_spin_lock() in some places there?
>
> I'll have more time to dig and maybe send a patch tomorrow, any quick
> thoughts are appreciated.
>
> [  319.006534][   T16] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [  319.006536][   T16] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 16, name: pr/legacy
> [  319.006537][   T16] preempt_count: 0, expected: 0
> [  319.006537][   T16] RCU nest depth: 3, expected: 3
> [  319.006538][   T16] 8 locks held by pr/legacy/16:
> [  319.006539][   T16]  #0: ffffffff831ffbe0 (console_lock){+.+.}-{0:0}, at: legacy_kthread_func+0x1e/0xc0
> [  319.006546][   T16]  #1: ffffffff831ffc30 (console_srcu){....}-{0:0}, at: console_flush_all+0xf2/0x430
> [  319.006550][   T16]  #2: ffffffff832c3ef8 (target_list_lock){+.+.}-{3:3}, at: write_ext_msg.part.0+0x28/0x4d0
> [  319.006554][   T16]  #3: ffffffff83202720 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xd5/0x1a0
> [  319.006557][   T16]  #4: ffffffff83202720 (rcu_read_lock){....}-{1:3}, at: __netpoll_send_skb+0x4a/0x3c0
> [  319.006561][   T16]  #5: ffff888107c89e98 (_xmit_ETHER#2){+...}-{3:3}, at: __netpoll_send_skb+0x2d6/0x3c0
> [  319.006564][   T16]  #6: ffffffff83202720 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x59/0x130
> [  319.006567][   T16]  #7: ffffe8ffffc06218 (&cpu_rcache->lock){+.+.}-{3:3}, at: alloc_iova_fast+0x70/0x2d0
> [  319.006570][   T16] irq event stamp: 20680
> [  319.006571][   T16] hardirqs last  enabled at (20679): [<ffffffff81ee7c3c>] _raw_spin_unlock_irqrestore+0x3c/0x50
> [  319.006573][   T16] hardirqs last disabled at (20680): [<ffffffff81d37b40>] netpoll_send_skb+0x30/0x70
> [  319.006575][   T16] softirqs last  enabled at (0): [<ffffffff8138970a>] copy_process+0x7aa/0x1940
> [  319.006577][   T16] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  319.006580][   T16] CPU: 0 UID: 0 PID: 16 Comm: pr/legacy Not tainted 6.17.0-rc7-next-20250926 #1 PREEMPT_{RT,LAZY}
> [  319.006582][   T16] Hardware name: ASUSTeK COMPUTER INC. WS C246M PRO Series/WS C246M PRO Series, BIOS 3301 03/23/2020
> [  319.006583][   T16] Call Trace:
> [  319.006584][   T16]  <TASK>
> [  319.006586][   T16]  dump_stack_lvl+0x57/0x80
> [  319.006590][   T16]  __might_resched.cold+0xec/0xfd
> [  319.006592][   T16]  rt_spin_lock+0x52/0x1a0
> [  319.006594][   T16]  ? alloc_iova_fast+0x70/0x2d0
> [  319.006598][   T16]  alloc_iova_fast+0x70/0x2d0
> [  319.006603][   T16]  iommu_dma_alloc_iova+0xca/0x100
> [  319.006606][   T16]  __iommu_dma_map+0x7f/0x170
> [  319.006611][   T16]  iommu_dma_map_phys+0xb7/0x190
> [  319.006615][   T16]  dma_map_phys+0xc9/0x130
> [  319.006619][   T16]  igc_tx_map.isra.0+0x155/0x570
> [  319.006625][   T16]  igc_xmit_frame_ring+0x2f3/0x510
> [  319.006627][   T16]  ? rt_spin_trylock+0x59/0x130
> [  319.006631][   T16]  netpoll_start_xmit+0x11c/0x190
> [  319.006635][   T16]  __netpoll_send_skb+0x32b/0x3c0
> [  319.006640][   T16]  netpoll_send_skb+0x3e/0x70

netpoll_send_skb() is doing local_irq_save(), which is disabling
hardware interrupts. So nothing deeper in the stack may sleep. But
__iova_rcache_get() is performing a spin_lock_irqsave, which for
PREEMPT_RT can sleep.

It would be nice to replace that local_irq_save() with a real lock
type.

@bigeasy: You have some experience cleaning up this class of
problems. Any suggestions?

> [  319.006643][   T16]  write_ext_msg.part.0+0x457/0x4d0
> [  319.006650][   T16]  console_emit_next_record+0xcb/0x1c0
> [  319.006656][   T16]  console_flush_all+0x274/0x430
> [  319.006660][   T16]  ? devkmsg_write+0x110/0x110
> [  319.006663][   T16]  __console_flush_and_unlock+0x34/0xa0
> [  319.006666][   T16]  legacy_kthread_func+0x23/0xc0
> [  319.006669][   T16]  ? swake_up_locked+0x50/0x50
> [  319.006672][   T16]  kthread+0xf9/0x200
> [  319.006675][   T16]  ? kthread_fetch_affinity.isra.0+0x40/0x40
> [  319.006678][   T16]  ret_from_fork+0xff/0x150
> [  319.006681][   T16]  ? kthread_fetch_affinity.isra.0+0x40/0x40
> [  319.006682][   T16]  ? kthread_fetch_affinity.isra.0+0x40/0x40
> [  319.006684][   T16]  ret_from_fork_asm+0x11/0x20
> [  319.006694][   T16]  </TASK>

John Ogness

