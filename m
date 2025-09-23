Return-Path: <netdev+bounces-225485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E2CB942CC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 06:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5541B7AE2B7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 04:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138627381F;
	Tue, 23 Sep 2025 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVC4Dsy5"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D480AD5A
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758600748; cv=none; b=ZHzupYWBud1Lf0PGWWZdqVYUzRKunlCn6y72fE1QQsSk7ZrCZ1fw+H1Gc+0Jru6G+hCXTyPM5qUfl+5n/ISboq6t1z5AE28EERQKGF98b3d9C85mC2P1HUwSf1zjRc5eEUD6UfSFo6nofszHV/uanyODLivxmwBvMxGDTMompk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758600748; c=relaxed/simple;
	bh=E8un3FXROc70m9PsRsQtm/sFi8qoAHR+suCsO+66rsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8uRsRMNSvUSXb1IAE1Azathk5ixuiJILvuz8wklnYrRiX76ATvL3jAhhaheGS7soqRxp7448gQY7Gbsof56+YrU3D6t40PzINGqk1kHcKUxwawQW/qqCqlQpB+uoMfOVC2ImdoHmLkMwK9aw92ncInQ0FHYlVJ3yCqPozhFqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YVC4Dsy5; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0c60711f-31d4-463d-a1c9-92cad9ba79f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758600744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDZT2wqQKVoy7pxqLv2KOoKQ5wh5mlqNeK0H1aieLw8=;
	b=YVC4Dsy5Nk9uBqxKcz2kOh4PSxGTelCwT5Fo2nfKkovJTZo3TOxMQYf9Xmj5E6Qvsg0Bwm
	zQgYiUbuViw+s4YZ7YUmNtPZ2rdcSxmtnCazwrstYhzRIM4yhnIIu9ehfmGS+9/opiDz1n
	wYcM1nN630msg7IQnhAHhkx73a0n5S8=
Date: Tue, 23 Sep 2025 12:11:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/3] inet: Avoid ehash lookup race in
 inet_twsk_hashdance_schedule()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
 <20250920105945.538042-4-xuanqiang.luo@linux.dev>
 <CAAVpQUDaYX5ZQN+EYL3q4yeu0Ni2cqNODEY--Wb-2+yY650Mbw@mail.gmail.com>
 <c90e37cf-82a5-4c31-abe1-1fca8bfc8867@linux.dev>
 <CAAVpQUBqiSkPGSGLqDweeOifGUPVx6TvyYcy2BoxKSY2qrtOPg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUBqiSkPGSGLqDweeOifGUPVx6TvyYcy2BoxKSY2qrtOPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/23 11:56, Kuniyuki Iwashima 写道:
> On Mon, Sep 22, 2025 at 7:07 PM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>
>> 在 2025/9/23 08:45, Kuniyuki Iwashima 写道:
>>> On Sat, Sep 20, 2025 at 4:00 AM <xuanqiang.luo@linux.dev> wrote:
>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>
>>>> Since ehash lookups are lockless, if another CPU is converting sk to tw
>>>> concurrently, fetching the newly inserted tw with tw->tw_refcnt == 0 cause
>>>> lookup failure.
>>>>
>>>> The call trace map is drawn as follows:
>>>>      CPU 0                                CPU 1
>>>>      -----                                -----
>>>>                                        inet_twsk_hashdance_schedule()
>>>>                                        spin_lock()
>>>>                                        inet_twsk_add_node_rcu(tw, ...)
>>>> __inet_lookup_established()
>>>> (find tw, failure due to tw_refcnt = 0)
>>>>                                        __sk_nulls_del_node_init_rcu(sk)
>>>>                                        refcount_set(&tw->tw_refcnt, 3)
>>>>                                        spin_unlock()
>>>>
>>>> By replacing sk with tw atomically via hlist_nulls_replace_init_rcu() after
>>>> setting tw_refcnt, we ensure that tw is either fully initialized or not
>>>> visible to other CPUs, eliminating the race.
>>>>
>>>> It's worth noting that we replace under lock_sock(), so no need to check if sk
>>>> is hashed. Thanks to Kuniyuki Iwashima!
>>>>
>>>> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> This is not needed.  A pure review does not deserve Suggested-by.
>>> This is used when someone suggests changing the core idea of
>>> the patch.
>> Got it, but still really appreciate your detailed
>> and patient review!
>>
>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>> ---
>>>>    net/ipv4/inet_timewait_sock.c | 13 ++++---------
>>>>    1 file changed, 4 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
>>>> index 5b5426b8ee92..bb98888584a8 100644
>>>> --- a/net/ipv4/inet_timewait_sock.c
>>>> +++ b/net/ipv4/inet_timewait_sock.c
>>>> @@ -116,7 +116,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>>>           spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
>>>>           struct inet_bind_hashbucket *bhead, *bhead2;
>>>>
>>>> -       /* Step 1: Put TW into bind hash. Original socket stays there too.
>>>> +       /* Put TW into bind hash. Original socket stays there too.
>>>>              Note, that any socket with inet->num != 0 MUST be bound in
>>>>              binding cache, even if it is closed.
>>>>            */
>>>> @@ -140,14 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>>>
>>>>           spin_lock(lock);
>>>>
>>>> -       /* Step 2: Hash TW into tcp ehash chain */
>>>> -       inet_twsk_add_node_rcu(tw, &ehead->chain);
>>>> -
>>>> -       /* Step 3: Remove SK from hash chain */
>>>> -       if (__sk_nulls_del_node_init_rcu(sk))
>>>> -               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>>>> -
>>>> -
>>>>           /* Ensure above writes are committed into memory before updating the
>>>>            * refcount.
>>>>            * Provides ordering vs later refcount_inc().
>>>> @@ -162,6 +154,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>>>            */
>>>>           refcount_set(&tw->tw_refcnt, 3);
>>> I discussed this series with Eric last week, and he pointed out
>>> (thanks!) that we need to be careful here about memory barrier.
>>>
>>> refcount_set() is just WRITE_ONCE() and thus can be reordered,
>>> and twsk could be published with 0 refcnt, resulting in another RST.
>>>
>> Thanks for Eric's pointer!
>>
>> Could you let me know if my modification here works?
>>
>> That is, moving smp_wmb() to after the refcount update:
> I think this should be fine, small comment below
>
>> @@ -140,19 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>
>>           spin_lock(lock);
>>
>> -       /* Step 2: Hash TW into tcp ehash chain */
>> -       inet_twsk_add_node_rcu(tw, &ehead->chain);
>> -
>> -       /* Step 3: Remove SK from hash chain */
>> -       if (__sk_nulls_del_node_init_rcu(sk))
>> -               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> -
>> -
>> -       /* Ensure above writes are committed into memory before updating the
>> -        * refcount.
>> -        * Provides ordering vs later refcount_inc().
>> -        */
>> -       smp_wmb();
>>           /* tw_refcnt is set to 3 because we have :
>>            * - one reference for bhash chain.
>>            * - one reference for ehash chain.
>> @@ -162,6 +149,14 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>            */
>>           refcount_set(&tw->tw_refcnt, 3);
>>
>> +       /* Ensure tw_refcnt has been set before tw is published by
>> +        * necessary memory barrier.
> This sounds like tw is published by memory barrier,
> perhaps remove after 'by' ?  It's obvious that the comment
> is for smp_wmb() below.

I'm sorry for the confusion caused by my poor English.

I will express it more clearly in the next version,
like the following:

@@ -162,6 +149,15 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
          */
         refcount_set(&tw->tw_refcnt, 3);

+       /* Ensure tw_refcnt has been set before tw is published.
+        * smp_wmb() provides the necessary memory barrier to enforce this
+        * ordering.
+        */
+       smp_wmb();
+
+       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
+       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+
         inet_twsk_schedule(tw, timeo);
         spin_unlock(lock);

Thanks!
Xuanqiang

>
>
>> +        */
>> +       smp_wmb();
>> +
>> +       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
>> +       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> +
>>           inet_twsk_schedule(tw, timeo);
>>
>>           spin_unlock(lock);
>>
>> Thanks!
>> Xuanqiang
>>
>>>> +       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
>>>> +       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>>>> +
>>>>           inet_twsk_schedule(tw, timeo);
>>>>
>>>>           spin_unlock(lock);
>>>> --
>>>> 2.25.1
>>>>

