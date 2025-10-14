Return-Path: <netdev+bounces-229063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B7EBD7DCA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47BDA4FAD8C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04430F530;
	Tue, 14 Oct 2025 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iqi3Y3Cr"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3130F524
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426489; cv=none; b=qhDVonTsgQZ2ftoEwLk0KSA3UOwbNpNdc5JFA6AFgAXYexu1Nz5Uk+bxG6uQzk1yNLEpcwoC+EDKgFHk1ZZ35USRhaLl+gBunZetUHIXtk3aLkl9G3KCZweaec0FgVUHB/BG6T6E7NokZDIXB1V+GtgLL68BkJk73+vwSF8I+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426489; c=relaxed/simple;
	bh=ADvPgi55U9zPVBuUkqepA8xObimOiBd78pkwR2ObcBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7vtKVnQ47RWSjO4GXbFSboOTCz1foaiKQ8ll2oj6sN+psWP0RrZljnJJNXWItN8bjmHTJxaKV+yNLCQpm0JlUNvXkr6z5AkNxqaODSfdG3a3pPdO8hjpk6fSMhC6CaH7YkkAeX/COnBXxUAPa/00qbCxesMouZdVNdLwovx1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iqi3Y3Cr; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82a04cb1-9451-493c-9b1e-b4a34f2175cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760426485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbqohlNm24jbTP1DHJzizKcT+447zFy5iRcOggZiNG0=;
	b=iqi3Y3Crg4wb/+pdnwi6UH8INy7JBpBYFZJ+58tK+hZAmhsrP7MAYGE+48AowwGll7tM2u
	Q4+6KEqU/GAcsNYo23Bh/3awp3/2FfGBgCKrg5aZIhPCTvrWN6gf4LFpAA1VYpeCzFRoOB
	UIV3xRtyMpEWVlJmZEdlBnCzg3oW8sw=
Date: Tue, 14 Oct 2025 15:20:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, "Paul E. McKenney" <paulmck@kernel.org>,
 kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
 <CANn89iJ15RFYq65t57sW=F1jZigbr5xTbPNLVY53cKtpMKLotA@mail.gmail.com>
 <d6a43fe1-2e00-4df4-b4a8-04facd8f05d4@linux.dev>
 <CANn89iLQMVms1GF_oY1WSCtmxLZaBJrTKaeHnwRo5p9uzFwnVw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89iLQMVms1GF_oY1WSCtmxLZaBJrTKaeHnwRo5p9uzFwnVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/13 17:49, Eric Dumazet 写道:
> On Mon, Oct 13, 2025 at 1:26 AM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>
>> 在 2025/10/13 15:31, Eric Dumazet 写道:
>>> On Fri, Sep 26, 2025 at 12:41 AM <xuanqiang.luo@linux.dev> wrote:
>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>
>>>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>>>
>>>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
>>>> mentioned in the patch below:
>>>> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
>>>> rculist_nulls")
>>>> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
>>>> hlist_nulls")
>>>>
>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>> ---
>>>>    include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 59 insertions(+)
>>>>
>>>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>>>> index 89186c499dd4..c26cb83ca071 100644
>>>> --- a/include/linux/rculist_nulls.h
>>>> +++ b/include/linux/rculist_nulls.h
>>>> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
>>>>    #define hlist_nulls_next_rcu(node) \
>>>>           (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
>>>>
>>>> +/**
>>>> + * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
>>>> + * @node: element of the list.
>>>> + */
>>>> +#define hlist_nulls_pprev_rcu(node) \
>>>> +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
>>>> +
>>>>    /**
>>>>     * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
>>>>     * @n: the element to delete from the hash list.
>>>> @@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>>>>           n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>>>>    }
>>>>
>>>> +/**
>>>> + * hlist_nulls_replace_rcu - replace an old entry by a new one
>>>> + * @old: the element to be replaced
>>>> + * @new: the new element to insert
>>>> + *
>>>> + * Description:
>>>> + * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
>>>> + * permitting racing traversals.
>>>> + *
>>>> + * The caller must take whatever precautions are necessary (such as holding
>>>> + * appropriate locks) to avoid racing with another list-mutation primitive, such
>>>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
>>>> + * list.  However, it is perfectly legal to run concurrently with the _rcu
>>>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
>>>> + */
>>>> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
>>>> +                                          struct hlist_nulls_node *new)
>>>> +{
>>>> +       struct hlist_nulls_node *next = old->next;
>>>> +
>>>> +       WRITE_ONCE(new->next, next);
>>>> +       WRITE_ONCE(new->pprev, old->pprev);
>>> I do not think these two WRITE_ONCE() are needed.
>>>
>>> At this point new is not yet visible.
>>>
>>> The following  rcu_assign_pointer() is enough to make sure prior
>>> writes are committed to memory.
>> Dear Eric,
>>
>> I’m quoting your more detailed explanation from the other patch [0], thank
>> you for that!
>>
>> However, regarding new->next, if the new object is allocated with
>> SLAB_TYPESAFE_BY_RCU, would we still encounter the same issue as in commit
>> efd04f8a8b45 (“rcu: Use WRITE_ONCE() for assignments to ->next for
>> rculist_nulls”)?
>>
>> Also, for the WRITE_ONCE() assignments to ->pprev introduced in commit
>> 860c8802ace1 (“rcu: Use WRITE_ONCE() for assignments to ->pprev for
>> hlist_nulls”) within hlist_nulls_add_head_rcu(), is that also unnecessary?
> I forgot sk_unhashed()/sk_hashed() could be called from lockless contexts.
>
> It is a bit weird to annotate the writes, but not the lockless reads,
> even if apparently KCSAN
> is okay with that.
>
Dear Eric,

I’m sorry—I still haven’t fully grasped the scenario you mentioned where
sk_unhashed()/sk_hashed() can be called from lock‑less contexts. It seems
similar to the race described in commit 860c8802ace1 (“rcu: Use
WRITE_ONCE() for assignments to ->pprev for hlist_nulls”), e.g.: [0].

Two CPUs invoke inet_unhash() from the tcp_retransmit_timer() path on the
same sk, causing a race even though tcp_retransmit_timer() checks
lockdep_sock_is_held(sk).

How does this race happen? I can’t find more details to understand the
situation, so any hints would be greatly appreciated.

My simple understanding is that hlist_nulls_replace_rcu() might have the
same call path as hlist_nulls_add_head_rcu(), so I keep using WRITE_ONCE().

Finally, Kuniyuki Iwashima also raised a similar discussion in the v3
series; here’s the link [1].

[0]:
------------------------------------------------------------------------

BUG: KCSAN: data-race in inet_unhash / inet_unhash

write to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 1:
  __hlist_nulls_del include/linux/list_nulls.h:88 [inline]
  hlist_nulls_del_init_rcu include/linux/rculist_nulls.h:36 [inline]
  __sk_nulls_del_node_init_rcu include/net/sock.h:676 [inline]
  inet_unhash+0x38f/0x4a0 net/ipv4/inet_hashtables.c:612
  tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
  tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
  tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
  tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
  tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
  tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
  call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
  expire_timers kernel/time/timer.c:1449 [inline]
  __run_timers kernel/time/timer.c:1773 [inline]
  __run_timers kernel/time/timer.c:1740 [inline]
  run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
  __do_softirq+0x115/0x33f kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0xbb/0xe0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
  arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
  default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x1af/0x280 kernel/sched/idle.c:263
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
  start_secondary+0x208/0x260 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

read to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 0:
  sk_unhashed include/net/sock.h:607 [inline]
  inet_unhash+0x3d/0x4a0 net/ipv4/inet_hashtables.c:592
  tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
  tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
  tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
  tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
  tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
  tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
  call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
  expire_timers kernel/time/timer.c:1449 [inline]
  __run_timers kernel/time/timer.c:1773 [inline]
  __run_timers kernel/time/timer.c:1740 [inline]
  run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
  __do_softirq+0x115/0x33f kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0xbb/0xe0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
  arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
  default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x1af/0x280 kernel/sched/idle.c:263
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
  rest_init+0xec/0xf6 init/main.c:452
  arch_call_rest_init+0x17/0x37
  start_kernel+0x838/0x85e init/main.c:786
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
  x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011

------------------------------------------------------------------------

[1]: https://lore.kernel.org/all/CAAVpQUCoCizxTm6wRs0+n6_kPK+kgxwszsYKNds3YvuBfBvrhg@mail.gmail.com/

Thanks!


