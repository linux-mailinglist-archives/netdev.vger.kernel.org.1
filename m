Return-Path: <netdev+bounces-223840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9CAB7F6AC
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86865266B6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76052F3C22;
	Wed, 17 Sep 2025 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wFHVRQJU"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60421D596
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079661; cv=none; b=hYs7sbBL/GAvPh8n03yLv8hsIiMdo1cn/aDCrjrmQR3Ieya7y1RjZZAXgSUQmHncuu6cps17cgU5zv0nRos0ESHaMYQ1z8X5JjgCC4RgJFRS01Ffivsp2Neay5RlCWwdMpDmuyxPdvHln2ORxWiUy7L9RUoadB2Mlv6Feer1dLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079661; c=relaxed/simple;
	bh=/exDfsXAQYImhf1ve1EB+Oyy/zzI2sbKBm7luABqx9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHGJUdzFcqlrpP869eT8ysAvmYwxv4nqR4rUb7E6WaWVdKeLhzOufSIT2iQMdxMUiorMbuSFVhKMRiAY5CHgcg5q57Sk4c33tQS/HwpX4iOpSltJcS5xYeCWaXK1OmFhP6JkNqRow8AUVP+51ARwKeGzyBXpyzO7dY7sUG/2M9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wFHVRQJU; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d6b887f-c75c-468b-beaf-a3c7979bd132@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758079657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7681q6EAVxjrEtOyM6YnBHuXGfO0p05G/R5mEeqe4oY=;
	b=wFHVRQJUOnpxeu01FuE9KnzOBkUcBfQ9llut9k2wxh9217Tv+AuEcqs7tM4uu8Fx+Uhsez
	Mk5pYBqoeqNBt3MttylzPpWeIhAv7tkR8eprqUD3DD/XAY/deWz4dYdVQHwWkPH77y53Ek
	sEl+6sm4VwiTuWD1K5pieqMfl5CBgP0=
Date: Wed, 17 Sep 2025 11:26:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/3] inet: Avoid ehash lookup race in
 inet_twsk_hashdance_schedule()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
 <20250916103054.719584-4-xuanqiang.luo@linux.dev>
 <CAAVpQUAEBeTjHxT7nk7qgOL8qmVxqdnSDeg=TKt4GjwNXEPxUA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUAEBeTjHxT7nk7qgOL8qmVxqdnSDeg=TKt4GjwNXEPxUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/17 03:48, Kuniyuki Iwashima 写道:
> On Tue, Sep 16, 2025 at 3:31 AM <xuanqiang.luo@linux.dev> wrote:
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
>> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   net/ipv4/inet_timewait_sock.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
>> index 5b5426b8ee92..1ba20c4cb73b 100644
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
>> @@ -162,6 +154,11 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>           */
>>          refcount_set(&tw->tw_refcnt, 3);
>>
>> +       if (hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node))
>> +               sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> +       else
>> +               inet_twsk_add_node_rcu(tw, &ehead->chain);
> When hlist_nulls_replace_init_rcu() returns false ?

When hlist_nulls_replace_init_rcu() returns false, it means
sk is unhashed, the replacement operation failed, we need
to insert tw, and this doesn't change the original logic.

>
>> +
>>          inet_twsk_schedule(tw, timeo);
>>
>>          spin_unlock(lock);
>> --
>> 2.25.1
>>

