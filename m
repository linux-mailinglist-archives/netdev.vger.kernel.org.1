Return-Path: <netdev+bounces-218591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D206DB3D663
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 03:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 845D54E1535
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 01:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162C1FA272;
	Mon,  1 Sep 2025 01:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72211F5617
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756691857; cv=none; b=ioz2Not135q+u85lZUiO40v/sakrvAaPet288OkNjPWGZEkZC/AwkI0XJ22EchEMPFKnaTknKG7zRucDaAdKHoP59lifutByvqL4ODsdItwfHNAPmqiYsxiC7FYKsHdwnbN0TEi992RCLDpqzHrq+kGlJFNVr7rj6cF/badsKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756691857; c=relaxed/simple;
	bh=lpBqdMf9Ggnu7jjotYrs+s9VNzM8f07q+HY9geGanKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DnzoejMJv/KwFzFuERKsWsM3x78B2tfJ1+ApE+WU/tG5P9BrVaacH6s0Qn8C9mwqKlHBGTdiMC6+3OhIw63U/CYKcFW6Moh/MqueAFWzGxGILJb0kv0MF1xdrqwPWoEjXOeHPb7h68qWTzqHf6+WrJfikpj97VTfAT+9t+cB2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cFX8W5rMPz27jDS;
	Mon,  1 Sep 2025 09:58:19 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F29C140276;
	Mon,  1 Sep 2025 09:57:12 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 09:57:11 +0800
Message-ID: <466c11eb-0fc0-44b3-b0b2-39634fc637b1@huawei.com>
Date: Mon, 1 Sep 2025 09:57:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/4] inet: ping: check sock_net() in
 ping_get_port() and ping_lookup()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20250829153054.474201-1-edumazet@google.com>
 <20250829153054.474201-2-edumazet@google.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250829153054.474201-2-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/29 23:30, Eric Dumazet wrote:
> We need to check socket netns before considering them in ping_get_port().
> Otherwise, one malicious netns could 'consume' all ports.
> 
> Add corresponding check in ping_lookup().
> 
> Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---
> 
> v2: added change to ping_lookup().
> v1: https://lore.kernel.org/netdev/CANn89iKF+DFQQyNJoYA2U-wf4QDPOUG2yNOd8fSu45hQ+TxJ5Q@mail.gmail.com/T/#u
> 
>  net/ipv4/ping.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index f119da68fc301be00719213ad33615b6754e6272..74a0beddfcc41d8ba17792a11a9d027c9d590bac 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -77,6 +77,7 @@ static inline struct hlist_head *ping_hashslot(struct ping_table *table,
>  
>  int ping_get_port(struct sock *sk, unsigned short ident)
>  {
> +	struct net *net = sock_net(sk);
>  	struct inet_sock *isk, *isk2;
>  	struct hlist_head *hlist;
>  	struct sock *sk2 = NULL;
> @@ -90,9 +91,10 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>  		for (i = 0; i < (1L << 16); i++, result++) {
>  			if (!result)
>  				result++; /* avoid zero */
> -			hlist = ping_hashslot(&ping_table, sock_net(sk),
> -					    result);
> +			hlist = ping_hashslot(&ping_table, net, result);
>  			sk_for_each(sk2, hlist) {
> +				if (!net_eq(sock_net(sk2), net))
> +					continue;
>  				isk2 = inet_sk(sk2);
>  
>  				if (isk2->inet_num == result)
> @@ -108,8 +110,10 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>  		if (i >= (1L << 16))
>  			goto fail;
>  	} else {
> -		hlist = ping_hashslot(&ping_table, sock_net(sk), ident);
> +		hlist = ping_hashslot(&ping_table, net, ident);
>  		sk_for_each(sk2, hlist) {
> +			if (!net_eq(sock_net(sk2), net))
> +				continue;
>  			isk2 = inet_sk(sk2);
>  
>  			/* BUG? Why is this reuse and not reuseaddr? ping.c
> @@ -129,7 +133,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>  		pr_debug("was not hashed\n");
>  		sk_add_node_rcu(sk, hlist);
>  		sock_set_flag(sk, SOCK_RCU_FREE);
> -		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> +		sock_prot_inuse_add(net, sk->sk_prot, 1);
>  	}
>  	spin_unlock(&ping_table.lock);
>  	return 0;
> @@ -188,6 +192,8 @@ static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
>  	}
>  
>  	sk_for_each_rcu(sk, hslot) {
> +		if (!net_eq(sock_net(sk), net))
> +			continue;
>  		isk = inet_sk(sk);
>  
>  		pr_debug("iterate\n");

Reviewed-by: Yue Haibing <yuehaibing@huawei.com>

