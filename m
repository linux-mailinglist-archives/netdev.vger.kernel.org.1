Return-Path: <netdev+bounces-205699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08FCAFFC76
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBEA7B9EFB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CD7233735;
	Thu, 10 Jul 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dgoarWhn"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8F224B14
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136446; cv=none; b=qEBeIw3pU800sAC3d4cyQfqvY2+M/3N8r3UwkUxw2UdGx9q3JfFkx+Es9LZG/Zdf62N4oul0CYUlBIPJ2qvtKSuCo4KFDLFRFNPJ9KRcVsb8+D8/Vr7bLcNI++KM3IPIOyn6lA43unBnt94kyBqzgbnqx33nE7jZmKnWXYxOqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136446; c=relaxed/simple;
	bh=1KyDj7OnnwxRI12gEGtA45U0zFy4CYHRnr2u90ziAkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ipCwCNPHq0Ee4Rv9i8pSFdpHFUQjCO+eTQz8X9TPFU5e7wgYg3UfROFDoJH50L2lOj2ei7aMCGzxwoljJ8O/LJXDc1Phm6eI4HoDTCtTQEDhobkPinaj3vBcvq9klNJivWJlpAt40vfPQq0AcJEdTGHdxY5XPVEacpxp+arIboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dgoarWhn; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250710083402euoutp02797de10e69e040b4bc176b1e55cea960~Q1s_UEART0706007060euoutp02y
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:34:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250710083402euoutp02797de10e69e040b4bc176b1e55cea960~Q1s_UEART0706007060euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752136442;
	bh=vb/sMqUdA6t7ushCPzPW3a6tANqJT3z1wjc44pU7J6Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dgoarWhnDUTIYa4pxC4typ6d/9phKrusza4wUd3IEf/Hw8kO3ZmY0vgzzH7jstipd
	 W8db/vzElKaUE48paV4gGno23+PtnFc4RwskiZbisGw/oLi7tpud4MsZZKe6mbsBo5
	 kQ4OfeJwYzYxteZWLLvW/kKQdFYTbhlE9vy3hsVA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2~Q1s96z-on2284322843eucas1p1D;
	Thu, 10 Jul 2025 08:34:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250710083400eusmtip220e40928c3c1b68f954ef9e23db72b76~Q1s9PryWJ1803318033eusmtip2d;
	Thu, 10 Jul 2025 08:34:00 +0000 (GMT)
Message-ID: <9794af18-4905-46c6-b12c-365ea2f05858@samsung.com>
Date: Thu, 10 Jul 2025 10:34:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
To: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org, Jason Baron <jbaron@akamai.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250704054824.1580222-1-kuniyu@google.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2
X-EPHeader: CA
X-CMS-RootMailID: 20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2
References: <20250704054824.1580222-1-kuniyu@google.com>
	<CGME20250710083401eucas1p1d18e23791e1f22c0c0aaf823a35526a2@eucas1p1.samsung.com>

On 04.07.2025 07:48, Kuniyuki Iwashima wrote:
> Netlink has this pattern in some places
>
>    if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
>    	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
>
> , which has the same problem fixed by commit 5a465a0da13e ("udp:
> Fix multiple wraparounds of sk->sk_rmem_alloc.").
>
> For example, if we set INT_MAX to SO_RCVBUFFORCE, the condition
> is always false as the two operands are of int.
>
> Then, a single socket can eat as many skb as possible until OOM
> happens, and we can see multiple wraparounds of sk->sk_rmem_alloc.
>
> Let's fix it by using atomic_add_return() and comparing the two
> variables as unsigned int.
>
> Before:
>    [root@fedora ~]# ss -f netlink
>    Recv-Q      Send-Q Local Address:Port                Peer Address:Port
>    -1668710080 0               rtnl:nl_wraparound/293               *
>
> After:
>    [root@fedora ~]# ss -f netlink
>    Recv-Q     Send-Q Local Address:Port                Peer Address:Port
>    2147483072 0               rtnl:nl_wraparound/290               *
>    ^
>    `--- INT_MAX - 576
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Jason Baron <jbaron@akamai.com>
> Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@akamai.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

This patch landed recently in linux-next as commit ae8f160e7eb2 
("netlink: Fix wraparounds of sk->sk_rmem_alloc."). In my tests I found 
that it breaks wifi drivers operation on my tests boards (various ARM 
32bit and 64bit ones). Reverting it on top of next-20250709 fixes this 
issue. Here is the log from the failure observed on the Samsung 
Peach-Pit Chromebook:

# dmesg | grep wifi
[   16.174311] mwifiex_sdio mmc2:0001:1: WLAN is not the winner! Skip FW 
dnld
[   16.503969] mwifiex_sdio mmc2:0001:1: WLAN FW is active
[   16.574635] mwifiex_sdio mmc2:0001:1: host_mlme: disable, key_api: 2
[   16.586152] mwifiex_sdio mmc2:0001:1: CMD_RESP: cmd 0x242 error, 
result=0x2
[   16.641184] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 
1.0 (15.68.7.p87)
[   16.649474] mwifiex_sdio mmc2:0001:1: driver_version = mwifiex 1.0 
(15.68.7.p87)
[   25.953285] mwifiex_sdio mmc2:0001:1 wlan0: renamed from mlan0
# ifconfig wlan0 up
# iw wlan0 scan
command failed: No buffer space available (-105)
#

Let me know if You need more information to debug this issue.

> ---
>   net/netlink/af_netlink.c | 81 ++++++++++++++++++++++++----------------
>   1 file changed, 49 insertions(+), 32 deletions(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index e8972a857e51..79fbaf7333ce 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -387,7 +387,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
>   	WARN_ON(skb->sk != NULL);
>   	skb->sk = sk;
>   	skb->destructor = netlink_skb_destructor;
> -	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
>   	sk_mem_charge(sk, skb->truesize);
>   }
>   
> @@ -1212,41 +1211,48 @@ struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast)
>   int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
>   		      long *timeo, struct sock *ssk)
>   {
> +	DECLARE_WAITQUEUE(wait, current);
>   	struct netlink_sock *nlk;
> +	unsigned int rmem;
>   
>   	nlk = nlk_sk(sk);
> +	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
>   
> -	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
> -	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
> -		DECLARE_WAITQUEUE(wait, current);
> -		if (!*timeo) {
> -			if (!ssk || netlink_is_kernel(ssk))
> -				netlink_overrun(sk);
> -			sock_put(sk);
> -			kfree_skb(skb);
> -			return -EAGAIN;
> -		}
> -
> -		__set_current_state(TASK_INTERRUPTIBLE);
> -		add_wait_queue(&nlk->wait, &wait);
> +	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
> +	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
> +		netlink_skb_set_owner_r(skb, sk);
> +		return 0;
> +	}
>   
> -		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
> -		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
> -		    !sock_flag(sk, SOCK_DEAD))
> -			*timeo = schedule_timeout(*timeo);
> +	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
>   
> -		__set_current_state(TASK_RUNNING);
> -		remove_wait_queue(&nlk->wait, &wait);
> +	if (!*timeo) {
> +		if (!ssk || netlink_is_kernel(ssk))
> +			netlink_overrun(sk);
>   		sock_put(sk);
> +		kfree_skb(skb);
> +		return -EAGAIN;
> +	}
>   
> -		if (signal_pending(current)) {
> -			kfree_skb(skb);
> -			return sock_intr_errno(*timeo);
> -		}
> -		return 1;
> +	__set_current_state(TASK_INTERRUPTIBLE);
> +	add_wait_queue(&nlk->wait, &wait);
> +	rmem = atomic_read(&sk->sk_rmem_alloc);
> +
> +	if (((rmem && rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf)) ||
> +	     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
> +	    !sock_flag(sk, SOCK_DEAD))
> +		*timeo = schedule_timeout(*timeo);
> +
> +	__set_current_state(TASK_RUNNING);
> +	remove_wait_queue(&nlk->wait, &wait);
> +	sock_put(sk);
> +
> +	if (signal_pending(current)) {
> +		kfree_skb(skb);
> +		return sock_intr_errno(*timeo);
>   	}
> -	netlink_skb_set_owner_r(skb, sk);
> -	return 0;
> +
> +	return 1;
>   }
>   
>   static int __netlink_sendskb(struct sock *sk, struct sk_buff *skb)
> @@ -1307,6 +1313,7 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
>   	ret = -ECONNREFUSED;
>   	if (nlk->netlink_rcv != NULL) {
>   		ret = skb->len;
> +		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
>   		netlink_skb_set_owner_r(skb, sk);
>   		NETLINK_CB(skb).sk = ssk;
>   		netlink_deliver_tap_kernel(sk, ssk, skb);
> @@ -1383,13 +1390,19 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
>   static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
>   {
>   	struct netlink_sock *nlk = nlk_sk(sk);
> +	unsigned int rmem, rcvbuf;
>   
> -	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
> +	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
> +	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
> +
> +	if ((rmem != skb->truesize || rmem <= rcvbuf) &&
>   	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
>   		netlink_skb_set_owner_r(skb, sk);
>   		__netlink_sendskb(sk, skb);
> -		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
> +		return rmem > (rcvbuf >> 1);
>   	}
> +
> +	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
>   	return -1;
>   }
>   
> @@ -2249,6 +2262,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>   	struct module *module;
>   	int err = -ENOBUFS;
>   	int alloc_min_size;
> +	unsigned int rmem;
>   	int alloc_size;
>   
>   	if (!lock_taken)
> @@ -2258,9 +2272,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>   		goto errout_skb;
>   	}
>   
> -	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
> -		goto errout_skb;
> -
>   	/* NLMSG_GOODSIZE is small to avoid high order allocations being
>   	 * required, but it makes sense to _attempt_ a 32KiB allocation
>   	 * to reduce number of system calls on dump operations, if user
> @@ -2283,6 +2294,12 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>   	if (!skb)
>   		goto errout_skb;
>   
> +	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
> +	if (rmem >= READ_ONCE(sk->sk_rcvbuf)) {
> +		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
> +		goto errout_skb;
> +	}
> +
>   	/* Trim skb to allocated size. User is expected to provide buffer as
>   	 * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
>   	 * netlink_recvmsg())). dump will pack as many smaller messages as

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


