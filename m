Return-Path: <netdev+bounces-218587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AFCB3D645
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 03:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780373B4FEE
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686A2155326;
	Mon,  1 Sep 2025 01:20:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86A2E401
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756689653; cv=none; b=ns1mrJ04axKMBYSv6sT6PqrXg90COnrCuNWCUgO2hiHl5DBL7/CZGsKIEBN+pcgdnRZdYQTQrnVGNIYD9PVTY0D9SeAaN3rdHboGsxWXLNqG0n5k9e0L/mdZRvg2Om0emMmMdoWTK3XcNa4x5ZkO7zvMtPtddbIvEX2tYrU1izg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756689653; c=relaxed/simple;
	bh=EfYapJmhpgnrzWJ+kL31xRSQCSev8TzTkxBxtd+2gb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eDnrsv3gVxyQadMM1N1zf+eNcKrJAdMo4cWesL4bdetzaSKRfhF0R4esoufEP1nps2XUHq80nsFR3CZsDHQ46UCDmceQo1m8QHatxcK3XDJzN4w1CYpmkrVmW/1JH0s5FQfrRwOyDesEyqPg0Cx6+UXnc1Xg32Bg0SmJfIAcOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cFWCw0kMwzdclw;
	Mon,  1 Sep 2025 09:16:12 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5692E140276;
	Mon,  1 Sep 2025 09:20:40 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 09:20:39 +0800
Message-ID: <66a06737-8052-46d7-be00-777d93c77b01@huawei.com>
Date: Mon, 1 Sep 2025 09:20:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/4] inet: ping: remove ping_hash()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20250829153054.474201-1-edumazet@google.com>
 <20250829153054.474201-3-edumazet@google.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250829153054.474201-3-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/29 23:30, Eric Dumazet wrote:
> There is no point in keeping ping_hash().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---
> v3: Yue Haibing feedback (remove ping_hash() declaration in include/net/ping.h)
> v2: https://lore.kernel.org/netdev/20250828164149.3304323-1-edumazet@google.com/T/#md0f7cce22b5a0ce71c366b75be20db3a528e8e03
> 
>  include/net/ping.h |  1 -
>  net/ipv4/ping.c    | 10 ----------
>  net/ipv6/ping.c    |  1 -
>  3 files changed, 12 deletions(-)
> 
> diff --git a/include/net/ping.h b/include/net/ping.h
> index bc7779262e60350e2748c74731a5d6d71f1b9455..9634b8800814dae4568e86fdf917bbe41d429b4b 100644
> --- a/include/net/ping.h
> +++ b/include/net/ping.h
> @@ -54,7 +54,6 @@ struct pingfakehdr {
>  };
>  
>  int  ping_get_port(struct sock *sk, unsigned short ident);
> -int ping_hash(struct sock *sk);
>  void ping_unhash(struct sock *sk);
>  
>  int  ping_init_sock(struct sock *sk);
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index 74a0beddfcc41d8ba17792a11a9d027c9d590bac..75e1b0f5c697653e79166fde5f312f46b471344a 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -67,7 +67,6 @@ static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
>  	pr_debug("hash(%u) = %u\n", num, res);
>  	return res;
>  }
> -EXPORT_SYMBOL_GPL(ping_hash);
>  
>  static inline struct hlist_head *ping_hashslot(struct ping_table *table,
>  					       struct net *net, unsigned int num)
> @@ -144,14 +143,6 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>  }
>  EXPORT_SYMBOL_GPL(ping_get_port);
>  
> -int ping_hash(struct sock *sk)
> -{
> -	pr_debug("ping_hash(sk->port=%u)\n", inet_sk(sk)->inet_num);
> -	BUG(); /* "Please do not press this button again." */
> -
> -	return 0;
> -}
> -
>  void ping_unhash(struct sock *sk)
>  {
>  	struct inet_sock *isk = inet_sk(sk);
> @@ -1008,7 +999,6 @@ struct proto ping_prot = {
>  	.bind =		ping_bind,
>  	.backlog_rcv =	ping_queue_rcv_skb,
>  	.release_cb =	ip4_datagram_release_cb,
> -	.hash =		ping_hash,
>  	.unhash =	ping_unhash,
>  	.get_port =	ping_get_port,
>  	.put_port =	ping_unhash,
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> index 82b0492923d458213ac7a6f9316158af2191e30f..d7a2cdaa26312b44f1fe502d3d40f3e27f961fa8 100644
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -208,7 +208,6 @@ struct proto pingv6_prot = {
>  	.recvmsg =	ping_recvmsg,
>  	.bind =		ping_bind,
>  	.backlog_rcv =	ping_queue_rcv_skb,
> -	.hash =		ping_hash,
>  	.unhash =	ping_unhash,
>  	.get_port =	ping_get_port,
>  	.put_port =	ping_unhash,

Reviewed-by: Yue Haibing <yuehaibing@huawei.com>

