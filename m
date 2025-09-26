Return-Path: <netdev+bounces-226581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C89BA24BC
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 05:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824A91C00338
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 03:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4B25BF14;
	Fri, 26 Sep 2025 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hmM1Trj7"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DDE1FCFEF
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857119; cv=none; b=nGiyqUAK06Jsf9+f/K7dF06m2O7otwjHPVdnX4KY/nWeTLupk3I+5/0nyRRIDnqmLhZ6mVH1mOfTq8KT8reXKHOZyeuz9PK+efXzuDbJXJJqkGavwkYVOJ0xI8z47QDpdInNNiuzqMViIMnil+iKwiiBA4YqjqgP6OIeqk6UHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857119; c=relaxed/simple;
	bh=Ncssy4AkzPwn8Z03xiHcrI2HWhjdXnKEtHqsEDI0b9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFtMBWLKUICdPbVgr4uZQwgotSoNBZ6GLA9DoRzDLC3uycQo5EhCCaGoJD7W3VnlkA06VicyawIua4AgmslUR7B5dWZbh6HWK5Mv+tGpwaq1deDtHiP3VJkSMEboOCAaqmFNzNXJvxHkwSAOkiAlG2S0xDTXhiB7dd1neLtIbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hmM1Trj7; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bdfab970-192e-4802-907f-f7374df8aca3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758857113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl+WqpSCg1XARZeX4GTBopyTsBcCEIoLBS5qZmtk2zc=;
	b=hmM1Trj72Uz+CI+7VltmAS7xbnaK8ht3llRhlHK3cblWxyfcJRYjAH/lUgkexZbwawgFXg
	I+WszwbJKrPtMnCmENGmM0DZ0PPq6i9aIVFKEGJHcB/J/Tj+ZXk8RndE3HZ7D64T978jWh
	0yEKmbpn9hjdo3kbzQpk4QBKQ2yrOMQ=
Date: Fri, 26 Sep 2025 11:24:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 2/3] inet: Avoid ehash lookup race in
 inet_ehash_insert()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev>
 <20250925021628.886203-3-xuanqiang.luo@linux.dev>
 <CAAVpQUBKLzVWs_gNZ-KUn9zjkyck5NBGQWsD+Am7kK7s3LZTWA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUBKLzVWs_gNZ-KUn9zjkyck5NBGQWsD+Am7kK7s3LZTWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/26 02:00, Kuniyuki Iwashima 写道:
> On Wed, Sep 24, 2025 at 7:18 PM <xuanqiang.luo@linux.dev> wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Since ehash lookups are lockless, if one CPU performs a lookup while
>> another concurrently deletes and inserts (removing reqsk and inserting sk),
>> the lookup may fail to find the socket, an RST may be sent.
>>
>> The call trace map is drawn as follows:
>>     CPU 0                           CPU 1
>>     -----                           -----
>>                                  inet_ehash_insert()
>>                                  spin_lock()
>>                                  sk_nulls_del_node_init_rcu(osk)
>> __inet_lookup_established()
>>          (lookup failed)
>>                                  __sk_nulls_add_node_rcu(sk, list)
>>                                  spin_unlock()
>>
>> As both deletion and insertion operate on the same ehash chain, this patch
>> introduces a new sk_nulls_replace_node_init_rcu() helper functions to
>> implement atomic replacement.
>>
>> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   include/net/sock.h         | 14 ++++++++++++++
>>   net/ipv4/inet_hashtables.c |  4 +++-
>>   2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 0fd465935334..5d67f5cbae52 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -854,6 +854,20 @@ static inline bool sk_nulls_del_node_init_rcu(struct sock *sk)
>>          return rc;
>>   }
>>
>> +static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
>> +                                                 struct sock *new)
>> +{
>> +       if (sk_hashed(old)) {
>> +               hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
>> +                                            &new->sk_nulls_node);
>> +               DEBUG_NET_WARN_ON_ONCE(refcount_read(&old->sk_refcnt) == 1);
>> +               __sock_put(old);
>> +               return true;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>>   static inline void __sk_add_node(struct sock *sk, struct hlist_head *list)
>>   {
>>          hlist_add_head(&sk->sk_node, list);
>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>> index ef4ccfd46ff6..83c9ec625419 100644
>> --- a/net/ipv4/inet_hashtables.c
>> +++ b/net/ipv4/inet_hashtables.c
>> @@ -685,7 +685,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
>>          spin_lock(lock);
>>          if (osk) {
>>                  WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
>> -               ret = sk_nulls_del_node_init_rcu(osk);
>> +               ret = sk_nulls_replace_node_init_rcu(osk, sk);
>> +               goto unlock;
>>          } else if (found_dup_sk) {
> As you need another iteration, remove else here since
> we bail out above with goto:
>
>      goto unlock;
> }
>
> if (found_dup_sk) {
>
> Other than that
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thanks!
>
Thank you for the review!

I'll fix it in the next version.

>>                  *found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
>>                  if (*found_dup_sk)
>> @@ -695,6 +696,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
>>          if (ret)
>>                  __sk_nulls_add_node_rcu(sk, list);
>>
>> +unlock:
>>          spin_unlock(lock);
>>
>>          return ret;
>> --
>> 2.25.1
>>

