Return-Path: <netdev+bounces-219472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8FB41752
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F918887C9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6AC2DE6F5;
	Wed,  3 Sep 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="POC3XKuk"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE632E0927
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886131; cv=none; b=D9y4cjhrzgghFUxgNw/5LxCtZTDMZSUyPragt2f/8/FAmKqWe96XkbjsoOYj9my8YWC8m24q3KkvnZ5K9w0bZcVEST7+LUafbVrR8mTszpIOQhenYcAP5MWbBtsku/GFO5PnlFmocHoNdHiZhCoc9sfWo2rmCTJyUQMqEQUAIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886131; c=relaxed/simple;
	bh=g500nRtMnlnY4iqhJIx76GnVFL/Rrge0jIDp+YREYCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izIGx0gj21nDfvO2IqSnTj1DnSWQgKhhbfHEA/0WkAdn3Ls402FmT4ZBWF6xWuP2PCFMqsIgLNqX8eUD3Ctns+pRqJ1ldmY8nIyN49/OsGPORWCx8BUMf0SYOgTkOn4UR0iPQpDr+3zKkPFCHz7ONSxC2elWBl65F9hG0hctX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=POC3XKuk; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ca7ad52-bfd6-4619-abef-93bf5be3969c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756886121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKPfAP7fpF7Kp2xYnUEQ+yluPjtk40mnFtOGQd5osDs=;
	b=POC3XKukB+Vw0YEQ0cxFm+bFk9vDEbpEK/UIhXWXt5SsodyXW3fPo0siifVhjKwuNdbR6X
	pqNIScOSg/QyA3f9BORCi7m+fGaRwiBIuBfCCQp+XjG1mgF76RMrDjWPztMoopUKqcU3to
	3GvVspVu1LbA3MaKbsMb8KCzH2n+dmc=
Date: Wed, 3 Sep 2025 15:54:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 kernelxing@tencent.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
 <CAAVpQUCKDi0aZcraeZaMY4ebuoBoB_Ymdy1RGb1247JznArTJg@mail.gmail.com>
 <CAAVpQUDZFCYNMQ08uRLu388cmggckzPeP=N7WncFyxN-_hgaMw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUDZFCYNMQ08uRLu388cmggckzPeP=N7WncFyxN-_hgaMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/3 13:48, Kuniyuki Iwashima 写道:
> On Tue, Sep 2, 2025 at 10:16 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>> On Tue, Sep 2, 2025 at 7:45 PM Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>
>>> Since the lookup of sk in ehash is lockless, when one CPU is performing a
>>> lookup while another CPU is executing delete and insert operations
>>> (deleting reqsk and inserting sk), the lookup CPU may miss either of
>>> them, if sk cannot be found, an RST may be sent.
>>>
>>> The call trace map is drawn as follows:
>>>     CPU 0                           CPU 1
>>>     -----                           -----
>>>                                  spin_lock()
>>>                                  sk_nulls_del_node_init_rcu(osk)
>>> __inet_lookup_established()
>>>                                  __sk_nulls_add_node_rcu(sk, list)
>>>                                  spin_unlock()
>> This usually does not happen except for local communication, and
>> retrying on the client side is much better than penalising all lookups
>> for SYN.
>>
>>> We can try using spin_lock()/spin_unlock() to wait for ehash updates
>>> (ensuring all deletions and insertions are completed) after a failed
>>> lookup in ehash, then lookup sk again after the update. Since the sk
>>> expected to be found is unlikely to encounter the aforementioned scenario
>>> multiple times consecutively, we only need one update.
>>>
>>> Similarly, an issue occurs in tw hashdance. Try adjusting the order in
>>> which it operates on ehash: remove sk first, then add tw. If sk is missed
>>> during lookup, it will likewise wait for the update to find tw, without
>>> worrying about the skc_refcnt issue that would arise if tw were found
>>> first.
>>>
>>> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>> ---
>>>   net/ipv4/inet_hashtables.c    | 12 ++++++++++++
>>>   net/ipv4/inet_timewait_sock.c |  9 ++++-----
>>>   2 files changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>>> index ceeeec9b7290..4eb3a55b855b 100644
>>> --- a/net/ipv4/inet_hashtables.c
>>> +++ b/net/ipv4/inet_hashtables.c
>>> @@ -505,6 +505,7 @@ struct sock *__inet_lookup_established(const struct net *net,
>>>          unsigned int hash = inet_ehashfn(net, daddr, hnum, saddr, sport);
>>>          unsigned int slot = hash & hashinfo->ehash_mask;
>>>          struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
>>> +       bool try_lock = true;
>>>
>>>   begin:
>>>          sk_nulls_for_each_rcu(sk, node, &head->chain) {
>>> @@ -528,6 +529,17 @@ struct sock *__inet_lookup_established(const struct net *net,
>>>           */
>>>          if (get_nulls_value(node) != slot)
>>>                  goto begin;
>>> +
>>> +       if (try_lock) {
>>> +               spinlock_t *lock = inet_ehash_lockp(hashinfo, hash);
>>> +
>>> +               try_lock = false;
>>> +               spin_lock(lock);
>>> +               /* Ensure ehash ops under spinlock complete. */
>>> +               spin_unlock(lock);
>>> +               goto begin;
>>> +       }
>>> +
>>>   out:
>>>          sk = NULL;
>>>   found:
>>> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
>>> index 875ff923a8ed..a91e02e19c53 100644
>>> --- a/net/ipv4/inet_timewait_sock.c
>>> +++ b/net/ipv4/inet_timewait_sock.c
>>> @@ -139,14 +139,10 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>>
>>>          spin_lock(lock);
>>>
>>> -       /* Step 2: Hash TW into tcp ehash chain */
>>> -       inet_twsk_add_node_rcu(tw, &ehead->chain);
>> You are adding a new RST scenario where the corresponding
>> socket is not found and a listener or no socket is found.
>>
>> The try_lock part is not guaranteed to happen after twsk
>> insertion below.

I'm sorry, I didn't get it. If try_lock can search again, other places 
should have left the spinlock critical section. That means twsk should 
have been inserted already. Or maybe I missed some details. Could you 
please explain more clearly? Your guidance would be really helpful. :)

> Oh no, spin_lock() dance sychronises the threads but I still
> think this is rather harmful for normal cases; now sending
> an unmatched packet can trigger lock dance, which is easily
> abused for DDoS.
>
I agree this scenario is possible. It does make DDoS attacks more 
impactful. Thanks for pointing that out. However, this is the best 
approach I can think of right now. Thanks Xuanqiang

>>
>>> -
>>> -       /* Step 3: Remove SK from hash chain */
>>> +       /* Step 2: Remove SK from hash chain */
>>>          if (__sk_nulls_del_node_init_rcu(sk))
>>>                  sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>>>
>>> -
>>>          /* Ensure above writes are committed into memory before updating the
>>>           * refcount.
>>>           * Provides ordering vs later refcount_inc().
>>> @@ -161,6 +157,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>>           */
>>>          refcount_set(&tw->tw_refcnt, 3);
>>>
>>> +       /* Step 3: Hash TW into tcp ehash chain */
>>> +       inet_twsk_add_node_rcu(tw, &ehead->chain);
>>> +
>>>          inet_twsk_schedule(tw, timeo);
>>>
>>>          spin_unlock(lock);
>>> --
>>> 2.25.1
>>>

