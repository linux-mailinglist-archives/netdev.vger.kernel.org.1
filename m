Return-Path: <netdev+bounces-225474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF62CB93ECA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 04:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7275218A4DF8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3026B2D2;
	Tue, 23 Sep 2025 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sBb6cBHk"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A526290
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592843; cv=none; b=k23Jdiucwi0Rbyt5L5iaKWcJe/XsqrcG+nll8I9g6FjE+I0w2P5BqZsSzI6ewgoYfESwC9KUfymYDZ/AvjWFiZ0mGKa0z2xeGdibUlZXFn7rNVS45BhsrkNdHnr0j80wJHMxwydmN4Dl6IUMMd+yJYsQ6TlbRDHiLsLfL2OjNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592843; c=relaxed/simple;
	bh=Lq/JAkV0ptZ78jgebQ3/w2r3VXrwt7OjZR1xCg5hxdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ6e8q3p0lQK43J0tWr3DLb8DAZqEJ5cr5vU71ZWgm7tbsStT5OKEVzgljEf6rs/d6uPHBEQvza+19stXHrh2CZV8aY0Bq0AhZ4rXVPAv3lLnRfq+AOm8X685N2BHSVlKZL2XPzloHQkIIhAQUgEtnzuWWXs6o5Kd5xaNfhMftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sBb6cBHk; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ae81d82-dd07-4cef-a4d5-2fb0efe92485@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758592839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chDaSzGCbbWo08i/agQUfjHPBdLsOBqWyOGlXJ29N0Y=;
	b=sBb6cBHkvkEKTW3juMH3VNc4XfcG4ys+f6Xqyyuj5oUYH/7yn2p7NaJc0kwyR5mX8C04eS
	k39/igeG+3QX1lVusxtgl0SBcGjODNzv10eEl4IcwRyC64GjgyxTT80DNN9b+scVI43ydk
	wQehx98R6/BILndvrzd7fBjvnIkw3Mc=
Date: Tue, 23 Sep 2025 10:00:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/3] inet: Avoid ehash lookup race in
 inet_ehash_insert()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
 <20250920105945.538042-3-xuanqiang.luo@linux.dev>
 <CAAVpQUBTeRk1r1jtxBU3L5Y1S_bcdJxOkhVRO=8a+=ix6-E0ZQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUBTeRk1r1jtxBU3L5Y1S_bcdJxOkhVRO=8a+=ix6-E0ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/23 08:23, Kuniyuki Iwashima 写道:
> On Sat, Sep 20, 2025 at 4:00 AM <xuanqiang.luo@linux.dev> wrote:
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
>> introduces two new sk_nulls_replace_* helper functions to implement atomic
>> replacement.
>>
>> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   include/net/sock.h         | 23 +++++++++++++++++++++++
>>   net/ipv4/inet_hashtables.c |  4 +++-
>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 0fd465935334..e709376eaf0a 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -854,6 +854,29 @@ static inline bool sk_nulls_del_node_init_rcu(struct sock *sk)
>>          return rc;
>>   }
>>
>> +static inline bool __sk_nulls_replace_node_init_rcu(struct sock *old,
>> +                                                   struct sock *new)
> nit: This can be inlined into sk_nulls_replace_node_init_rcu() as
> there is no caller of __sk_nulls_replace_node_init_rcu().
>
>
>> +{
>> +       if (sk_hashed(old)) {
>> +               hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
>> +                                            &new->sk_nulls_node);
>> +               return true;
>> +       }
>> +       return false;
>> +}
>> +
>> +static inline bool sk_nulls_replace_node_init_rcu(struct sock *old,
>> +                                                 struct sock *new)
>> +{
>> +       bool rc = __sk_nulls_replace_node_init_rcu(old, new);
>> +
>> +       if (rc) {
>> +               WARN_ON(refcount_read(&old->sk_refcnt) == 1);
> nit: DEBUG_NET_WARN_ON_ONCE() would be better as
> this is "paranoid" as commented in sk_del_node_init() etc.

Fix in next version! Thanks Kuniyuki!

>
>> +               __sock_put(old);
>> +       }
>> +       return rc;
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

