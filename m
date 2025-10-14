Return-Path: <netdev+bounces-229193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F781BD911D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6218118851C1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD330EF8E;
	Tue, 14 Oct 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CqpubiQN"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD030E849
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442073; cv=none; b=YOmDHDD3WXBfm4HhV2jkYKYFjiLJ9h79zg2rPkuhvDK7PCmFw5nG4iNhSEkW0ON3qHzvDoPJvmMWnfxeI8kgEB4KBHveP70gCKV81yZYL2BXZIGMH0ZUbYldgJrzbYal+6cB+kWysTjRH/akGYsP1Vp/1bOxZA2RjZlLFb8fuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442073; c=relaxed/simple;
	bh=9xUZqmihxETKqKTDlvAFKKEI3+P7fKUgl2poMNcOJGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu0BekowVqCZTAnEMNv+tFwFrY/ER9a8iBbfzYMyeFA3oRshTuB2Ifb/f4TjFpVGsKvQULV7VbedKr90ZMyco/dTesFRaWYImh9scFGq35HOnZ24cDxl/gPzj6ZogSxrQ0OEkSOzcAMJ7U34HaLb4tCyiukga9d7CMfI9kgCwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CqpubiQN; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f27bb6dc-b0ac-45aa-b748-4156531ca825@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760442065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcStXxknvZsyZjpDYP5MJ9AC20nneXvaB/PHN3Ol3N8=;
	b=CqpubiQNAXcshcFmSU44m4ZwXe+bvRuvMcHq6obffbQJAOe7BW0iowi60dIRm8GEDO5ED6
	gwsAZCB/S+HCNUgbvdpALwQaEO1niMGZNEwKdIrWhVNRlxE5EuseGC3I+t17p+w4bkkNo4
	Tjq/TbpUS1Q9HVpdZbsbgWDjlOE1Vyw=
Date: Tue, 14 Oct 2025 19:40:13 +0800
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
 <82a04cb1-9451-493c-9b1e-b4a34f2175cd@linux.dev>
 <CANn89iJdXiE3b8x8vQtbOOi2DTC5P9bOO1HsnRwSPC8qQC--8g@mail.gmail.com>
 <7d89cff3-1045-4901-bdd3-f669eecfee97@linux.dev>
 <CANn89iJtMVRhcdfaH3Qz0cLf30cV32jYpAA5YBcL1Auovccdug@mail.gmail.com>
 <5d0df381-5a17-4b90-92dc-0d2976b585e0@linux.dev>
 <CANn89iKa9kTLSPLf+OBR=Tbs9SE=qpSMrR==L9sW9xc=Mgi0Fw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89iKa9kTLSPLf+OBR=Tbs9SE=qpSMrR==L9sW9xc=Mgi0Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/14 18:02, Eric Dumazet 写道:
> On Tue, Oct 14, 2025 at 1:41 AM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>
>> 在 2025/10/14 16:09, Eric Dumazet 写道:
>>> On Tue, Oct 14, 2025 at 1:05 AM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>>> 在 2025/10/14 15:34, Eric Dumazet 写道:
>>>>> On Tue, Oct 14, 2025 at 12:21 AM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>>>>> 在 2025/10/13 17:49, Eric Dumazet 写道:
>>>>>>> On Mon, Oct 13, 2025 at 1:26 AM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>>>>>>> 在 2025/10/13 15:31, Eric Dumazet 写道:
>>>>>>>>> On Fri, Sep 26, 2025 at 12:41 AM <xuanqiang.luo@linux.dev> wrote:
>>>>>>>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>>>>>>>
>>>>>>>>>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>>>>>>>>>
>>>>>>>>>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
>>>>>>>>>> mentioned in the patch below:
>>>>>>>>>> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
>>>>>>>>>> rculist_nulls")
>>>>>>>>>> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
>>>>>>>>>> hlist_nulls")
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>>>>>>> ---
>>>>>>>>>>       include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++++++++++
>>>>>>>>>>       1 file changed, 59 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>>>>>>>>>> index 89186c499dd4..c26cb83ca071 100644
>>>>>>>>>> --- a/include/linux/rculist_nulls.h
>>>>>>>>>> +++ b/include/linux/rculist_nulls.h
>>>>>>>>>> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
>>>>>>>>>>       #define hlist_nulls_next_rcu(node) \
>>>>>>>>>>              (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
>>>>>>>>>>
>>>>>>>>>> +/**
>>>>>>>>>> + * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
>>>>>>>>>> + * @node: element of the list.
>>>>>>>>>> + */
>>>>>>>>>> +#define hlist_nulls_pprev_rcu(node) \
>>>>>>>>>> +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
>>>>>>>>>> +
>>>>>>>>>>       /**
>>>>>>>>>>        * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
>>>>>>>>>>        * @n: the element to delete from the hash list.
>>>>>>>>>> @@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>>>>>>>>>>              n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>> +/**
>>>>>>>>>> + * hlist_nulls_replace_rcu - replace an old entry by a new one
>>>>>>>>>> + * @old: the element to be replaced
>>>>>>>>>> + * @new: the new element to insert
>>>>>>>>>> + *
>>>>>>>>>> + * Description:
>>>>>>>>>> + * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
>>>>>>>>>> + * permitting racing traversals.
>>>>>>>>>> + *
>>>>>>>>>> + * The caller must take whatever precautions are necessary (such as holding
>>>>>>>>>> + * appropriate locks) to avoid racing with another list-mutation primitive, such
>>>>>>>>>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
>>>>>>>>>> + * list.  However, it is perfectly legal to run concurrently with the _rcu
>>>>>>>>>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
>>>>>>>>>> + */
>>>>>>>>>> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
>>>>>>>>>> +                                          struct hlist_nulls_node *new)
>>>>>>>>>> +{
>>>>>>>>>> +       struct hlist_nulls_node *next = old->next;
>>>>>>>>>> +
>>>>>>>>>> +       WRITE_ONCE(new->next, next);
>>>>>>>>>> +       WRITE_ONCE(new->pprev, old->pprev);
>>>>>>>>> I do not think these two WRITE_ONCE() are needed.
>>>>>>>>>
>>>>>>>>> At this point new is not yet visible.
>>>>>>>>>
>>>>>>>>> The following  rcu_assign_pointer() is enough to make sure prior
>>>>>>>>> writes are committed to memory.
>>>>>>>> Dear Eric,
>>>>>>>>
>>>>>>>> I’m quoting your more detailed explanation from the other patch [0], thank
>>>>>>>> you for that!
>>>>>>>>
>>>>>>>> However, regarding new->next, if the new object is allocated with
>>>>>>>> SLAB_TYPESAFE_BY_RCU, would we still encounter the same issue as in commit
>>>>>>>> efd04f8a8b45 (“rcu: Use WRITE_ONCE() for assignments to ->next for
>>>>>>>> rculist_nulls”)?
>>>>>>>>
>>>>>>>> Also, for the WRITE_ONCE() assignments to ->pprev introduced in commit
>>>>>>>> 860c8802ace1 (“rcu: Use WRITE_ONCE() for assignments to ->pprev for
>>>>>>>> hlist_nulls”) within hlist_nulls_add_head_rcu(), is that also unnecessary?
>>>>>>> I forgot sk_unhashed()/sk_hashed() could be called from lockless contexts.
>>>>>>>
>>>>>>> It is a bit weird to annotate the writes, but not the lockless reads,
>>>>>>> even if apparently KCSAN
>>>>>>> is okay with that.
>>>>>>>
>>>>>> Dear Eric,
>>>>>>
>>>>>> I’m sorry—I still haven’t fully grasped the scenario you mentioned where
>>>>>> sk_unhashed()/sk_hashed() can be called from lock‑less contexts. It seems
>>>>>> similar to the race described in commit 860c8802ace1 (“rcu: Use
>>>>>> WRITE_ONCE() for assignments to ->pprev for hlist_nulls”), e.g.: [0].
>>>>>>
>>>>> inet_unhash() does a lockless sk_unhash(sk) call, while no lock is
>>>>> held in some cases (look at tcp_done())
>>>>>
>>>>> void inet_unhash(struct sock *sk)
>>>>> {
>>>>> struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
>>>>>
>>>>> if (sk_unhashed(sk))    // Here no lock is held
>>>>>        return;
>>>>>
>>>>> Relevant lock (depending on (sk->sk_state == TCP_LISTEN)) is acquired
>>>>> a few lines later.
>>>>>
>>>>> Then
>>>>>
>>>>> __sk_nulls_del_node_init_rcu() is called safely, while the bucket lock is held.
>>>>>
>>>> Dear Eric,
>>>>
>>>> Thanks for the quick response!
>>>>
>>>> In the call path:
>>>>            tcp_retransmit_timer()
>>>>                    tcp_write_err()
>>>>                            tcp_done()
>>>>
>>>> tcp_retransmit_timer() already calls lockdep_sock_is_held(sk) to check the
>>>> socket‑lock state.
>>>>
>>>> void tcp_retransmit_timer(struct sock *sk)
>>>> {
>>>>            struct tcp_sock *tp = tcp_sk(sk);
>>>>            struct net *net = sock_net(sk);
>>>>            struct inet_connection_sock *icsk = inet_csk(sk);
>>>>            struct request_sock *req;
>>>>            struct sk_buff *skb;
>>>>
>>>>            req = rcu_dereference_protected(tp->fastopen_rsk,
>>>>                                     lockdep_sock_is_held(sk)); // Check here
>>>>
>>>> Does that mean we’re already protected by lock_sock(sk) or
>>>> bh_lock_sock(sk)?
>>> But the socket lock is not protecting ehash buckets. These are other locks.
>>>
>>> Also, inet_unhash() can be called from other paths, without a socket
>>> lock being held.
>> Dear Eric,
>>
>> I understand the distinction now, but looking at the call stack in [0],
>> both CPUs reach inet_unhash() via the tcp_retransmit_timer() path, so only
>> one of them should pass the check, right?
>>
>> I’m still not clear how this race condition arises.
> Because that is two different sockets. This once again explains why
> holding or not the socket lock is not relevant.
>
> One of them is changing pointers in the chain, messing with
> surrounding pointers.
>
> The second one is reading sk->sk_node.pprev without using
> hlist_unhashed_lockless().
>
> I do not know how to explain this...
>
> Please look at the difference between hlist_unhashed_lockless() and
> hlist_unhashed().

Thank you very much for the patient explanation. :)

I think I understand now!

Best regards!
Xuanqiang.


