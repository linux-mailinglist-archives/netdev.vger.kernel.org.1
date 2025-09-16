Return-Path: <netdev+bounces-223327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB3BB58B97
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6CF77B34DE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9071F03FB;
	Tue, 16 Sep 2025 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pQn9diBX"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5A1A295
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987877; cv=none; b=VoqhoXSb+fdwocsCS2w/Cv3j73s56yYBAvkJoRgnbNBX42PzUUJ79Q9DsR9eIgvTsFE6ryRanhzyAMaGWhOOYVJE/qf030BeeWHnEDu2LY4OyYGD3DbWTQxIw/ViPNXBDRI9dxbQaswthLGPQ8mZYODGSEIIZMyCXIo8Tptl70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987877; c=relaxed/simple;
	bh=4fx+ZXvKgOMtyAtFyFowgIuYG6EmfZfJmkR+PF7R+FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VevrOcEwTSo9xZXcIKm1jJTNH3vI8oc5hgXjeTtXStMIaOF9lCwN/BTVAKM/ldKxvKyNZG9hXBruy5uloy02kU/kHIU4njtocZ2u3ss+nJtikNY83ZDrqXr0+fXVsyb55T8/kNqW8Ehyt4jmcZD36akTjLuachq7w2vGWOtj3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pQn9diBX; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fdaa51d5-a196-4910-bfea-ba554d95623b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTSzsuMLoU3dLC27Dm2FEh3qLwscY79OGbX0h/Jt114=;
	b=pQn9diBXOXprK0bJEbtVnt8GkUNI9U+ECh1eHHycPXxTMTAdH69DJ/1UwnVy+MUDNv6ToX
	lg3p3oNAG0neoi5IEs5pzjCaNKY752vhbSR2iIiwW11/76MDZWoG0/MARggzrzzIEmeCS8
	oOztfvjN6hZ85CiiV1keHjSSJBGZCs4=
Date: Tue, 16 Sep 2025 09:57:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 2/3] inet: Avoid ehash lookup race in
 inet_ehash_insert()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
 <20250915070308.111816-3-xuanqiang.luo@linux.dev>
 <CAAVpQUDHF_=gdXSr4TX=11gn7_-NObqN156x_rtQMPitL+YUTg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUDHF_=gdXSr4TX=11gn7_-NObqN156x_rtQMPitL+YUTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/16 07:00, Kuniyuki Iwashima 写道:
> On Mon, Sep 15, 2025 at 12:04 AM <xuanqiang.luo@linux.dev> wrote:
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
>> If sk_nulls_replace_node_init_rcu() fails, it indicates osk is either
>> hlist_unhashed or hlist_nulls_unhashed. The former returns false; the
>> latter performs insertion without deletion.
>>
>> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   include/net/sock.h         | 23 +++++++++++++++++++++++
>>   net/ipv4/inet_hashtables.c |  7 +++++++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 896bec2d2176..26dacf7bc93e 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -859,6 +859,29 @@ static inline bool sk_nulls_del_node_init_rcu(struct sock *sk)
>>          return rc;
>>   }
>>
>> +static inline bool __sk_nulls_replace_node_init_rcu(struct sock *old,
>> +                                                   struct sock *new)
>> +{
>> +       if (sk_hashed(old) &&
>> +           hlist_nulls_replace_init_rcu(&old->sk_nulls_node,
>> +                                        &new->sk_nulls_node))
>> +               return true;
>> +
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
>> +               __sock_put(old);
>> +       }
>> +       return rc;
>> +}
>> +
>>   static inline void __sk_add_node(struct sock *sk, struct hlist_head *list)
>>   {
>>          hlist_add_head(&sk->sk_node, list);
>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>> index ef4ccfd46ff6..7803fd3cc8e9 100644
>> --- a/net/ipv4/inet_hashtables.c
>> +++ b/net/ipv4/inet_hashtables.c
>> @@ -685,6 +685,12 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
>>          spin_lock(lock);
>>          if (osk) {
>>                  WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
>> +               /* Since osk and sk should be in the same ehash bucket, try
>> +                * direct replacement to avoid lookup gaps. On failure, no
>> +                * changes. sk_nulls_del_node_init_rcu() will handle the rest.
> Both sk_nulls_replace_node_init_rcu() and
> sk_nulls_del_node_init_rcu() return true only when
> sk_hashed(osk) == true.
>
> Only thing sk_nulls_del_node_init_rcu() does is to
> set ret to false.
>
>
>> +                */
>> +               if (sk_nulls_replace_node_init_rcu(osk, sk))
>> +                       goto unlock;
>>                  ret = sk_nulls_del_node_init_rcu(osk);
> So, should we simply do
>
> ret = sk_nulls_replace_node_init_rcu(osk, sk);
> goto unlock;
>
> ?

sk_nulls_replace_node_init_rcu() only returns true if both 
sk_hashed(osk) == true and hlist_nulls_unhashed(old) == false.
However, in the original sk_nulls_del_node_init_rcu() logic, when 
sk_hashed(osk) == true, it always performs __sock_put(sk) regardless of 
the hlist_nulls_unhashed(old) check. Therefore, if 
sk_nulls_replace_node_init_rcu() fails, we can safely let ret or 
__sock_put(sk) be handled by the subsequent 
sk_nulls_del_node_init_rcu(osk) call. Thanks Xuanqiang.

>
>>          } else if (found_dup_sk) {
>>                  *found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
>> @@ -695,6 +701,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
>>          if (ret)
>>                  __sk_nulls_add_node_rcu(sk, list);
>>
>> +unlock:
>>          spin_unlock(lock);
>>
>>          return ret;
>> --
>> 2.27.0
>>

