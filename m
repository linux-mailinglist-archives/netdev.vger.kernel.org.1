Return-Path: <netdev+bounces-226582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E868BA24BF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 05:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459643A76CF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 03:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED9B25EF81;
	Fri, 26 Sep 2025 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jnpt4DWP"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BE1FCFEF
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857125; cv=none; b=SEbCaKlu9vb9U1fJOVeaDvEGM0wQO28D/+jkBYmc4BoA0Ad9QcO17FT8pdORrqOOduigUJqjP5R0fWTPYMtsobCGKR0sAeFegyxxk7BtTx0oV6RRbff+riMuIjpaJWY+GJH/x/gil74en2EyCdHwrDVJR7Q+vHTS4BG2rNu7n7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857125; c=relaxed/simple;
	bh=b/9pJO8xCL8+gZ7x0NMAA6lnkmvXZc/T4bwyWivKvhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VB3IUP3pN79vj9aIdF+cmjB7+ijbu9zceb0MZllpmBIwJREe9bs0QHn6xJSbTe18NH5fQT/Zvl0X5EOdkgoZ4MwbI86LW21segniX24rlN+Tvlo6C91F2LrBf4U0px3M+YsMRowzKYhG6+y93y0V5hORmPtm/GoK2m34DsIsLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jnpt4DWP; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a7f762ba-1505-4dc8-b236-e2b677aa0d50@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758857118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZC6ZIAFSlhuyGbA65PUFrc6pN/4Sah8QwAuSxpB+7vI=;
	b=jnpt4DWPaGP+wnBV+DSZ/343wYhxus0AaQC/5rLPDReQ1mTynCp926lxRtMGn4ldMJZWZV
	Dq3mLJEMfATvf93RmaZ14Lv8vlL/E+1j2eurf2Y5XyTs4yWDOynl26FXxutpA7m4vobjh1
	dgQ5E9Ekm3b/qvGlW+DdRWaOc3gWsB0=
Date: Fri, 26 Sep 2025 11:25:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 3/3] inet: Avoid ehash lookup race in
 inet_twsk_hashdance_schedule()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev>
 <20250925021628.886203-4-xuanqiang.luo@linux.dev>
 <CAAVpQUD7-6hgCSvhP3KL+thgxcyWAJQanfPHS+BQ5LDfrY9-bQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUD7-6hgCSvhP3KL+thgxcyWAJQanfPHS+BQ5LDfrY9-bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/26 02:22, Kuniyuki Iwashima 写道:
> On Wed, Sep 24, 2025 at 7:18 PM <xuanqiang.luo@linux.dev> wrote:
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
>> It's worth noting that we held lock_sock() before the replacement, so
>> there's no need to check if sk is hashed. Thanks to Kuniyuki Iwashima!
>>
>> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   net/ipv4/inet_timewait_sock.c | 31 ++++++++++---------------------
>>   1 file changed, 10 insertions(+), 21 deletions(-)
>>
>> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
>> index 5b5426b8ee92..89dc0a5d7248 100644
>> --- a/net/ipv4/inet_timewait_sock.c
>> +++ b/net/ipv4/inet_timewait_sock.c
>> @@ -87,12 +87,6 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
>>   }
>>   EXPORT_SYMBOL_GPL(inet_twsk_put);
>>
>> -static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
>> -                                  struct hlist_nulls_head *list)
>> -{
>> -       hlist_nulls_add_head_rcu(&tw->tw_node, list);
>> -}
>> -
>>   static void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
>>   {
>>          __inet_twsk_schedule(tw, timeo, false);
>> @@ -112,11 +106,10 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>   {
>>          const struct inet_sock *inet = inet_sk(sk);
>>          const struct inet_connection_sock *icsk = inet_csk(sk);
>> -       struct inet_ehash_bucket *ehead = inet_ehash_bucket(hashinfo, sk->sk_hash);
>>          spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
>>          struct inet_bind_hashbucket *bhead, *bhead2;
>>
>> -       /* Step 1: Put TW into bind hash. Original socket stays there too.
>> +       /* Put TW into bind hash. Original socket stays there too.
>>             Note, that any socket with inet->num != 0 MUST be bound in
>>             binding cache, even if it is closed.
> While at it, could you update the comment style at these 2 line above too ?
>
> /* Put ..
>   * Note, ...
>   * binding ...
>   */
>
> Otherwise looks good, thanks.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
I'll fix the comment style in the next version.

Thanks for the review!

>
>
>>           */
>> @@ -140,19 +133,6 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
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
>> -       /* Ensure above writes are committed into memory before updating the
>> -        * refcount.
>> -        * Provides ordering vs later refcount_inc().
>> -        */
>> -       smp_wmb();
>>          /* tw_refcnt is set to 3 because we have :
>>           * - one reference for bhash chain.
>>           * - one reference for ehash chain.
>> @@ -162,6 +142,15 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>>           */
>>          refcount_set(&tw->tw_refcnt, 3);
>>
>> +       /* Ensure tw_refcnt has been set before tw is published.
>> +        * smp_wmb() provides the necessary memory barrier to enforce this
>> +        * ordering.
>> +        */
>> +       smp_wmb();
>> +
>> +       hlist_nulls_replace_init_rcu(&sk->sk_nulls_node, &tw->tw_node);
>> +       sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> +
>>          inet_twsk_schedule(tw, timeo);
>>
>>          spin_unlock(lock);
>> --
>> 2.25.1
>>

