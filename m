Return-Path: <netdev+bounces-224746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF27B891EF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6512356015E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66AE306B3D;
	Fri, 19 Sep 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BTrXgGg9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7E2FC00E;
	Fri, 19 Sep 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278643; cv=none; b=ZJJ8pKyr0P37umyIw9mNpmle4Wmue/mZjxlwnv5OVyCakxTb9n4ZL1yAPjMWDZpRwl/yIZWoruQcit8fn2ZjblVW75MQgMpZDfYdsh+vNxzYHxK5V9KgOXxNsC85X0D66OH/pfLQnqjMOon47w+Ftc2shqZsyQuCPgfjyQ7t+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278643; c=relaxed/simple;
	bh=BKc0RV63M01nDICcQC4Seg91lRcjgZLaxntdBg7rOEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1Kd+Wo1DOV1vdIETB6B5mUvTel/n14uiDGLLva/s+9c5Kxt6d1QpmS5PBVvUE1HzULWIWidI5RX8zC9oDt4GnZ49BJcBjv9Lx8Wlnr53iPfD95P82AgmonRrVo6Z3ersYSGWGklWxUEAKQaFpFPXxVNHrncxVewEm/Ewlh6f9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BTrXgGg9; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1758278601;
	bh=Qv1s8asVMEW5x6w8IorhBj9KoQ6wD+O5/7GCyGnzbF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BTrXgGg9idgWHfH+nVgLVrN8JGrYHxSWAZzLhSMM0xS4VbPaXYbK6tBvWMVN6bKzV
	 PmbMWAu0Qc1DqsvKMICe4dcFSeZXdI0hSmGIV7gGq7WHBGx6S+hNMs6xtuPypIuRm3
	 Qqc83wL3cmMkZPTUvIcCUjzY+lJzpPD2VYRYUc14=
X-QQ-mid: zesmtpip4t1758278592tfadf4112
X-QQ-Originating-IP: HAnf7Dh6ql7JkLITPtSnyaxuR/+TN2ZRzHmTRtspLSw=
Received: from [IPV6:2408:8670:2e0:408::113:10 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Sep 2025 18:43:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12644434262634922181
Message-ID: <72E78CF484B0D2A0+60b60a00-5d02-4dc5-8b4d-3b3e7a7db241@uniontech.com>
Date: Fri, 19 Sep 2025 18:43:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcp: fix connection reset due to tw hashdance race.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, edumazet@google.com,
 duanmuquan@baidu.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
References: <CANn89iK8snOz8TYOhhwfimC7ykYA78GA3Nyv8x06SZYa1nKdyA@mail.gmail.com>
 <20230619170314.42333-1-kuniyu@amazon.com>
Reply-To: 20230619170314.42333-1-kuniyu@amazon.com
From: Gou Hao <gouhao@uniontech.com>
In-Reply-To: <20230619170314.42333-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NMjxIHxwvoj+B8TErUYSMU7k6fx+wxstEDpkOt/PChYrXoX+zOT7gP0X
	YXO17hO9JmtsPMumLqGih7JvHwHO3y/K/rILJyMYA8kIc8hneNKOljWMGTy4PToy3Hgw4LY
	WwuETYp5uLEAKtCQ2D/MsvB4HGzdxfcMXBjgLRKAbyau/JWnib5t4igWcgIsosXs1Oati2h
	DKLD6rlrXULgCXfEIm/X1/RJcmgnQscvT4A95QmRTWQicOy51uFKbKRPmD8mCDjA8msddVL
	FfgNEQepsZQwY4WrpdJCnObPWF251F/UFBA/aaYpYC/HSdqHZj77elBn7EhpnjgYFD1mOXm
	w+xRA11Cx+/lvwpkJvJQQFjUCJrAorN6qcGR9KtcH6Jx2onf17mBT58SpINhihEQrHea/Y+
	bWZRURaiiMyjs9HgCqmHJElem2U8R4mgvd7wBKqdCAEkfkZ0aGLoErCLSir4aZuscLp78Qd
	tf10M9h+emELaXmctZttpFsr1DLqIeoQldQUb03jJPGJb9jHaZiOkBCP7N+7A7l/UuuZuiW
	jJcNa+0MbbXENY35DyC2QhrtfA7P5xTb5dPa2qSMJxoX0t+u2PKJdSOpFKv1lBdmBeAoPdq
	3o3y1T7J7r8HnM8Md36ItEzcaDoenDlf4g2HOk7ydIBIVkJg+7+fHek4Mmxennl8QeO7nM8
	JHHHReYOIQ/tGAfM+fuxa2WRjWxMhZLPZ0xjNGj0nozw1lvVvDamcz//Mn3LJhuDfFW3VHl
	cmdOWKe2hKA0TdeJhndIBhMt8jGsfFJH/nHM7i2jGioODtK8Ovf1KttZEEnRnUta9iostXo
	RPXEz/XR3nZ7xdtkLQJLb9lqAITxKZmEnok87Ty1N1cSFSSuPtomIjy/dxOH4PjO1FJjW8Q
	isk94WrRBTBClkhWhZVj/UPu4TALUFiG9qQqYJr0MYhTMpVOeOcYPNdD1L5VHqJlriHe4CJ
	ImUXA/RJhTXzvb3OlLF2Cna0+AenTn3eoWZoOYrH5L199WS7h90G1fpu4nbh9Zq7zLsCe5v
	2nEkyxF6lnAs84rNjoVSPF0L+lDQY6VVxGAD+FDUyK4Mi6UPs3HaSvkKckMlqu4i8/ZWsjv
	l6VNf1KWUr+ZdDaB+6fTxNAxRmcJd1vzQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0


On 2023/6/20 01:03, Kuniyuki Iwashima wrote:
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 8 Jun 2023 08:35:20 +0200
>> On Thu, Jun 8, 2023 at 7:48 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>> From: Eric Dumazet <edumazet@google.com>
>>> Date: Wed, 7 Jun 2023 15:32:57 +0200
>>>> On Wed, Jun 7, 2023 at 1:59 PM Duan,Muquan <duanmuquan@baidu.com> wrote:
>>>>> Hi, Eric,
>>>>>
>>>>>   Thanks for your comments!
>>>>>
>>>>>   About the second lookup, I am sorry that I did not give enough explanations about it. Here are some details:
>>>>>
>>>>>   1.  The second lookup can find the tw sock and avoid the connection refuse error on userland applications:
>>>>>
>>>>> If the original sock is found, but when validating its refcnt, it has been destroyed and sk_refcnt has become 0 after decreased by tcp_time_wait()->tcp_done()->inet_csk_destory_sock()->sock_put().The validation for refcnt fails and the lookup process gets a listener sock.
>>>>>
>>>>> When this case occurs, the hashdance has definitely finished，because tcp_done() is executed after inet_twsk_hashdance(). Then if look up the ehash table again, hashdance has already finished, tw sock will be found.
>>>>>
>>>>>   With this fix, logically we can solve the connection reset issue completely when no established sock is found due to hashdance race.In my reproducing environment, the connection refuse error will occur about every 6 hours with only the fix of bad case (2). But with both of the 2 fixes, I tested it many times, the longest test continues for 10 days, it does not occur again,
>>>>>
>>>>>
>>>>>
>>>>> 2. About the performance impact:
>>>>>
>>>>>       A similar scenario is that __inet_lookup_established() will do inet_match() check for the second time, if fails it will look up    the list again. It is the extra effort to reduce the race impact without using reader lock. inet_match() failure occurs with about the same probability with refcnt validation failure in my test environment.
>>>>>
>>>>>   The second lookup will only be done in the condition that FIN segment gets a listener sock.
>>>>>
>>>>>    About the performance impact:
>>>>>
>>>>> 1)  Most of the time, this condition will not met, the added codes introduces at most 3 comparisons for each segment.
>>>>>
>>>>> The second inet_match() in __inet_lookup_established()  does least 3 comparisons for each segmet.
>>>>>
>>>>>
>>>>> 2)  When this condition is met, the probability is very small. The impact is similar to the second try due to inet_match() failure. Since tw sock can definitely be found in the second try, I think this cost is worthy to avoid connection reused error on userland applications.
>>>>>
>>>>>
>>>>>
>>>>> My understanding is, current philosophy is avoiding the reader lock by tolerating the minor defect which occurs in a small probability.For example, if the FIN from passive closer is dropped due to the found sock is destroyed, a retransmission can be tolerated, it only makes the connection termination slower. But I think the bottom line is that it does not affect the userland applications’ functionality. If application fails to connect due to the hashdance race, it can’t be tolerated. In fact, guys from product department push hard on the connection refuse error.
>>>>>
>>>>>
>>>>> About bad case (2):
>>>>>
>>>>>   tw sock is found, but its tw_refcnt has not been set to 3, it is still 0, validating for sk_refcnt will fail.
>>>>>
>>>>> I do not know the reason why setting tw_refcnt after adding it into list, could anyone help point out the reason? It adds  extra race because the new added tw sock may be found and checked in other CPU concurrently before ƒsetting tw_refcnt to 3.
>>>>>
>>>>> By setting tw_refcnt to 3 before adding it into list, this case will be solved, and almost no cost. In my reproducing environment, it occurs more frequently than bad case (1), it appears about every 20 minutes, bad case (1) appears about every 6 hours.
>>>>>
>>>>>
>>>>>
>>>>> About the bucket spinlock, the original established sock and tw sock are stored in the ehash table, I concern about the performance when there are lots of short TCP connections, the reader lock may affect the performance of connection creation and termination. Could you share some details of your idea? Thanks in advance.
>>>>>
>>>>>
>>>> Again, you can write a lot of stuff, the fact is that your patch does
>>>> not solve the issue.
>>>>
>>>> You could add 10 lookups, and still miss some cases, because they are
>>>> all RCU lookups with no barriers.
>>>>
>>>> In order to solve the issue of packets for the same 4-tuple being
>>>> processed by many cpus, the only way to solve races is to add mutual
>>>> exclusion.
>>>>
>>>> Note that we already have to lock the bucket spinlock every time we
>>>> transition a request socket to socket, a socket to timewait, or any
>>>> insert/delete.
>>>>
>>>> We need to expand the scope of this lock, and cleanup things that we
>>>> added in the past, because we tried too hard to 'detect races'
>>> How about this ?  This is still a workaround though, retry sounds
>>> better than expanding the scope of the lock given the race is rare.
>> The chance of two cpus having to hold the same spinlock is rather small.
>>
>> Algo is the following:
>>
>> Attempt a lockless/RCU lookup.
>>
>> 1) Socket is found, we are good to go. Fast path is still fast.
>>
>> 2) Socket  is not found in ehash
>>     - We lock the bucket spinlock.
>>     - We retry the lookup
>>     - If socket found, continue with it (release the spinlock when
>> appropriate, after all write manipulations in the bucket are done)
>>     - If socket still not found, we lookup a listener.
>>        We insert a TCP_NEW_SYN_RECV ....
>>         Again, we release the spinlock when appropriate, after all
>> write manipulations in the bucket are done)
>>
>> No more races, and the fast path is the same.
> I was looking around the issue this weekend.  Is this what you were
> thinking ?  I'm wondering if you were also thinking another races like
> found_dup_sk/own_req things. e.g.) acquire ehash lock when we start to
> process reqsk ?
>
> Duan, could you test the diff below ?
>
> If this resolves the FIN issue, we can also revert 3f4ca5fafc08 ("tcp:
> avoid the lookup process failing to get sk in ehash table").


We encountered the same situation in our actual business: due to lookup 
failure, the client received RST packets.

We tested this patch and it solved our problem, Thank you!

Will this patch be merged into the mainline later?

-- 
thanks,
Gou Hao

> ---8<---
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 56f1286583d3..bb8e49a6e80f 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -48,6 +48,11 @@ struct sock *__inet6_lookup_established(struct net *net,
>   					const u16 hnum, const int dif,
>   					const int sdif);
>   
> +struct sock *__inet6_lookup_established_lock(struct net *net, struct inet_hashinfo *hashinfo,
> +					     const struct in6_addr *saddr, const __be16 sport,
> +					     const struct in6_addr *daddr, const u16 hnum,
> +					     const int dif, const int sdif);
> +
>   struct sock *inet6_lookup_listener(struct net *net,
>   				   struct inet_hashinfo *hashinfo,
>   				   struct sk_buff *skb, int doff,
> @@ -70,9 +75,15 @@ static inline struct sock *__inet6_lookup(struct net *net,
>   	struct sock *sk = __inet6_lookup_established(net, hashinfo, saddr,
>   						     sport, daddr, hnum,
>   						     dif, sdif);
> -	*refcounted = true;
> -	if (sk)
> +
> +	if (!sk)
> +		sk = __inet6_lookup_established_lock(net, hashinfo, saddr, sport,
> +						     daddr, hnum, dif, sdif);
> +	if (sk) {
> +		*refcounted = true;
>   		return sk;
> +	}
> +
>   	*refcounted = false;
>   	return inet6_lookup_listener(net, hashinfo, skb, doff, saddr, sport,
>   				     daddr, hnum, dif, sdif);
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 99bd823e97f6..ad97fec63d7a 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -379,6 +379,12 @@ struct sock *__inet_lookup_established(struct net *net,
>   				       const __be32 daddr, const u16 hnum,
>   				       const int dif, const int sdif);
>   
> +struct sock *__inet_lookup_established_lock(struct net *net,
> +					    struct inet_hashinfo *hashinfo,
> +					    const __be32 saddr, const __be16 sport,
> +					    const __be32 daddr, const u16 hnum,
> +					    const int dif, const int sdif);
> +
>   static inline struct sock *
>   	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
>   				const __be32 saddr, const __be16 sport,
> @@ -402,9 +408,14 @@ static inline struct sock *__inet_lookup(struct net *net,
>   
>   	sk = __inet_lookup_established(net, hashinfo, saddr, sport,
>   				       daddr, hnum, dif, sdif);
> -	*refcounted = true;
> -	if (sk)
> +	if (!sk)
> +		sk = __inet_lookup_established_lock(net, hashinfo, saddr, sport,
> +						    daddr, hnum, dif, sdif);
> +	if (sk) {
> +		*refcounted = true;
>   		return sk;
> +	}
> +
>   	*refcounted = false;
>   	return __inet_lookup_listener(net, hashinfo, skb, doff, saddr,
>   				      sport, daddr, hnum, dif, sdif);
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index e7391bf310a7..1eeadaf1c9f9 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -514,6 +514,41 @@ struct sock *__inet_lookup_established(struct net *net,
>   }
>   EXPORT_SYMBOL_GPL(__inet_lookup_established);
>   
> +struct sock *__inet_lookup_established_lock(struct net *net, struct inet_hashinfo *hashinfo,
> +					    const __be32 saddr, const __be16 sport,
> +					    const __be32 daddr, const u16 hnum,
> +					    const int dif, const int sdif)
> +{
> +	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
> +	INET_ADDR_COOKIE(acookie, saddr, daddr);
> +	const struct hlist_nulls_node *node;
> +	struct inet_ehash_bucket *head;
> +	unsigned int hash;
> +	spinlock_t *lock;
> +	struct sock *sk;
> +
> +	hash = inet_ehashfn(net, daddr, hnum, saddr, sport);
> +	head = inet_ehash_bucket(hashinfo, hash);
> +	lock = inet_ehash_lockp(hashinfo, hash);
> +
> +	spin_lock(lock);
> +	sk_nulls_for_each(sk, node, &head->chain) {
> +		if (sk->sk_hash != hash)
> +			continue;
> +
> +		if (unlikely(!inet_match(net, sk, acookie, ports, dif, sdif)))
> +			continue;
> +
> +		sock_hold(sk);
> +		spin_unlock(lock);
> +		return sk;
> +	}
> +	spin_unlock(lock);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(__inet_lookup_established_lock);
> +
>   /* called with local bh disabled */
>   static int __inet_check_established(struct inet_timewait_death_row *death_row,
>   				    struct sock *sk, __u16 lport,
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b64b49012655..1b2c971859c0 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -89,6 +89,40 @@ struct sock *__inet6_lookup_established(struct net *net,
>   }
>   EXPORT_SYMBOL(__inet6_lookup_established);
>   
> +struct sock *__inet6_lookup_established_lock(struct net *net, struct inet_hashinfo *hashinfo,
> +					     const struct in6_addr *saddr, const __be16 sport,
> +					     const struct in6_addr *daddr, const u16 hnum,
> +					     const int dif, const int sdif)
> +{
> +	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
> +	const struct hlist_nulls_node *node;
> +	struct inet_ehash_bucket *head;
> +	unsigned int hash;
> +	spinlock_t *lock;
> +	struct sock *sk;
> +
> +	hash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
> +	head = inet_ehash_bucket(hashinfo, hash);
> +	lock = inet_ehash_lockp(hashinfo, hash);
> +
> +	spin_lock(lock);
> +	sk_nulls_for_each(sk, node, &head->chain) {
> +		if (sk->sk_hash != hash)
> +			continue;
> +
> +		if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, dif, sdif)))
> +			continue;
> +
> +		sock_hold(sk);
> +		spin_unlock(lock);
> +		return sk;
> +	}
> +	spin_unlock(lock);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(__inet6_lookup_established_lock);
> +
>   static inline int compute_score(struct sock *sk, struct net *net,
>   				const unsigned short hnum,
>   				const struct in6_addr *daddr,
> ---8<---



