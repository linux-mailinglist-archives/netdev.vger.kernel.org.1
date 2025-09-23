Return-Path: <netdev+bounces-225476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F0B93F3F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 04:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB94F18A5B7A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6ED288C0E;
	Tue, 23 Sep 2025 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wogl13CX"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D0286427
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593260; cv=none; b=gC8XR7y4uylO8pL/kUZuslLQFovTxRVhOhtgT5RoZMhvnRXy/c3KufnTWsZoTpMknd1rzh2htEH0OtBd8HCtTx7sV6ZD7QLsKayUcPjSGYtOkOI3WcXFsR4n3oGoZu4ZbKSOAFGawP/sFPv76xrc+EY2cOsC4ZnHvS3pcNG/WOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593260; c=relaxed/simple;
	bh=5Wb9m62FfFTrECQZbqRXPoInZRSGH+uaxVzcuR6tqDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXAD3sADyWPpf0a3r791JwBoIrL5eLOb9K+hi58dQLBAQJxtkVgCQhMeq0PcfMszYIYulnyGtkIBkLYKSim6xNbLhwwJ47tFFObHiq7uOQv1LUihl4QPKFPyTnhyLGacObmGkNxLDbx2eHnWwKku2F8ZyoDRPxlhA93e+Sujiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wogl13CX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c90e37cf-82a5-4c31-abe1-1fca8bfc8867@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758593252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPHHDyBu7fbsLMcBrmfdxFEmohUKJ5Cry6I2TtdMTBk=;
	b=wogl13CXH1rjboajAXBQOwoINEWo2XXVMxMc/RzM3HScEE03NeSeFyE2siP2h4DBUDqZql
	klYfumSOpw73HacB0e3dNm3LXSLLQqkBDYYqmAY46pYCEe1Tq0lTzO7oeHWEbQ6AiUHucp
	q/ibrbzYYfH+czxMqsHbot3XoJOIkiQ=
Date: Tue, 23 Sep 2025 10:07:28 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUDaYX5ZQN+EYL3q4yeu0Ni2cqNODEY--Wb-2+yY650Mbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/23 08:45, Kuniyuki Iwashima 写道:
> On Sat, Sep 20, 2025 at 4:00 AM <xuanqiang.luo@linux.dev> wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Since ehash lookups are lockless, if another CPU is converting sk to tw
>> concurrently, fetching the newly inserted tw with tw->tw_refcnt == 0 cause
>> lookup failure.
>>
>> The call trace map is drawn as follows:
>>     CPU 0                                CPU 1
>>     -----                                -----
>>                                       inet_twsk_hashdance_schedule()
>>                                       spin_lock()
>>                                       inet_twsk_add_node_rcu(tw, ...)
>> __inet_lookup_established()
>> (find tw, failure due to tw_refcnt = 0)
>>                                       __sk_nulls_del_node_init_rcu(sk)
>>                                       refcount_set(&tw->tw_refcnt, 3)
>>                                       spin_unlock()
>>
>> By replacing sk with tw atomically via hlist_nulls_replace_init_rcu() after
>> setting tw_refcnt, we ensure that tw is either fully initialized or not
>> visible to other CPUs, eliminating the race.
>>
>> It's worth noting that we replace under lock_sock(), so no need to check if sk
>> is hashed. Thanks to Kuniyuki Iwashima!
>>
>> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> This is not needed.  A pure review does not deserve Suggested-by.
> This is used when someone suggests changing the core idea of
> the patch.

Got it, but still really appreciate your detailed
and patient review!

>
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   net/ipv4/inet_timewait_sock.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
>> index 5b5426b8ee92..bb98888584a8 100644
>> --- a/net/ipv4/inet_timewait_sock.c
>> +++ b/net/ipv4/inet_timewait_sock.c
>> @@ -116,7 +116,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>          spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
>>          struct inet_bind_hashbucket *bhead, *bhead2;
>>
>> -       /* Step 1: Put TW into bind hash. Original socket stays there too.
>> +       /* Put TW into bind hash. Original socket stays there too.
>>             Note, that any socket with inet->num != 0 MUST be bound in
>>             binding cache, even if it is closed.
>>           */
>> @@ -140,14 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>
>>          spin_lock(lock);
>>
>> -       /* Step 2: Hash TW into tcp ehash chain */
>> -       inet_twsk_add_node_rcu(tw, &ehead->chain);
>> -
>> -       /* Step 3: Remove SK from hash chain */
>> -       if (__sk_nulls_del_node_init_rcu(sk))
>> -               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> -
>> -
>>          /* Ensure above writes are committed into memory before updating the
>>           * refcount.
>>           * Provides ordering vs later refcount_inc().
>> @@ -162,6 +154,9 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>           */
>>          refcount_set(&tw->tw_refcnt, 3);
> I discussed this series with Eric last week, and he pointed out
> (thanks!) that we need to be careful here about memory barrier.
>
> refcount_set() is just WRITE_ONCE() and thus can be reordered,
> and twsk could be published with 0 refcnt, resulting in another RST.
>
Thanks for Eric's pointer!

Could you let me know if my modification here works?

That is, moving smp_wmb() to after the refcount update:

@@ -140,19 +140,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,

         spin_lock(lock);

-       /* Step 2: Hash TW into tcp ehash chain */
-       inet_twsk_add_node_rcu(tw, &ehead->chain);
-
-       /* Step 3: Remove SK from hash chain */
-       if (__sk_nulls_del_node_init_rcu(sk))
-               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-
-
-       /* Ensure above writes are committed into memory before updating the
-        * refcount.
-        * Provides ordering vs later refcount_inc().
-        */
-       smp_wmb();
         /* tw_refcnt is set to 3 because we have :
          * - one reference for bhash chain.
          * - one reference for ehash chain.
@@ -162,6 +149,14 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
          */
         refcount_set(&tw->tw_refcnt, 3);

+       /* Ensure tw_refcnt has been set before tw is published by
+        * necessary memory barrier.
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

>> +       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
>> +       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> +
>>          inet_twsk_schedule(tw, timeo);
>>
>>          spin_unlock(lock);
>> --
>> 2.25.1
>>

