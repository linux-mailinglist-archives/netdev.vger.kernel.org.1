Return-Path: <netdev+bounces-110898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E492ED60
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 19:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608E9284B20
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443178283;
	Thu, 11 Jul 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P3nLblr1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C105BACF
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717244; cv=none; b=cncabQ/91LQlnwpZ7HgwMXHOPquA1HDcBlPlL7VJCphGsm9Rwvnr4CBP4nDO+BF1J5wINkWUcrc1VBYlU0FzXheEE2cBkmfXaYWuM+tceuhRLkyeXyUvPnGowLeGfPV3CEEuhQUsN8ZZ0h0QbmzBVLRqYv/nDzf2BNxcLo/FUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717244; c=relaxed/simple;
	bh=ujbl78c9j3e31378WGWN17P24pGH5KW/QFpN8Y8cKn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTwuM1QHSroNgmKXLLQJi5OwMYc4CUtYwtYwaxglOZhCxoOctJi7SZkQcRSI4kd6P7yfCx6elEo7lZe6vq99udexpa2rPQS3TLzVN/8Sr9M/laDAESayaY9LB2vEIhN8VBQUwyinujEouN48CIoL+8ukn5kgbVoRw0OKjuGcnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P3nLblr1; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720717242; x=1752253242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nnU7ANMfEcj7RYM975Huq3koBlSSx3QSrXMJ7etirTM=;
  b=P3nLblr1qOd2ZNCtF5elVmp4FgdS3OfpK6e8cAvg+IYxISdmzzsoVwEQ
   7GXGMZd7Sw1oakzB0FBHEaXuU1WywXPLaLwPN2J6OubyT4MH9+U1qJT6v
   b8Bl/xZ458QwGRUK6ahlklfiGg4U8xsK8UkuG3f9Dvp6ox4BMfDmx5AVK
   c=;
X-IronPort-AV: E=Sophos;i="6.09,200,1716249600"; 
   d="scan'208";a="104904033"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 17:00:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:56336]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.144:2525] with esmtp (Farcaster)
 id 652ec3f4-1307-4d38-a50e-a19d6842d5c9; Thu, 11 Jul 2024 17:00:39 +0000 (UTC)
X-Farcaster-Flow-ID: 652ec3f4-1307-4d38-a50e-a19d6842d5c9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 11 Jul 2024 17:00:34 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 11 Jul 2024 17:00:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <heze0908@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] inet: reduce the execution time of getsockname()
Date: Thu, 11 Jul 2024 10:00:23 -0700
Message-ID: <20240711170023.63094-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240711071017.64104-1-348067333@qq.com>
References: <20240711071017.64104-1-348067333@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: heze0908 <heze0908@gmail.com>
Date: Thu, 11 Jul 2024 15:10:17 +0800
> From: Ze He <zanehe@tencent.com>
> 
> Recently, we received feedback regarding an increase
> in the time consumption of getsockname() in production.
> Therefore, we conducted tests based on the
> "getsockname" test item in libmicro. The test results
> indicate that compared to the kernel 5.4, the latest
> kernel indeed has an increased time consumption
> in getsockname().
> The test results are as follows:
> 
> case_name	kernel 5.4	latest kernel	  diff
> ----------	-----------	-------------	--------
> getsockname	  0.12278 	  0.18246	+48.61%
> 
> It was discovered that the introduction of lock_sock() in
> commit 9dfc685e0262 ("inet: remove races in inet{6}_getname()")
> to solve the data race problem between __inet_hash_connect()
> and inet_getname() has led to the increased time consumption.
> This patch attempts to propose a lockless solution to replace
> the spinlock solution.
> 
> We have to solve the race issue without heavy spin lock:
> one reader is reading some members in struct inet_sock
> while the other writer is trying to modify them. Those
> members are "inet_sport" "inet_saddr" "inet_dport"
> "inet_rcv_saddr". Therefore, in the path of getname, we
> use READ_ONCE to read these data, and correspondingly,
> in the path of tcp connect, we use WRITE_ONCE to write
> these data.
> 
> Using this patch, we conducted the getsockname test again,
> and the results are as follows:
> 
> case_name       latest kernel   latest kernel(patched)
> ----------      -----------     ---------------------
> getsockname       0.18246             0.14423
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Signed-off-by: Ze He <zanehe@tencent.com>
> ---
>  include/net/ip.h            |  3 ++-
>  net/ipv4/af_inet.c          | 27 +++++++++++++--------------
>  net/ipv4/inet_hashtables.c  |  8 ++++----
>  net/ipv4/tcp_ipv4.c         |  4 ++--
>  net/ipv6/af_inet6.c         | 22 ++++++++++------------
>  net/ipv6/inet6_hashtables.c |  2 +-
>  net/ipv6/tcp_ipv6.c         |  6 +++---
>  7 files changed, 35 insertions(+), 37 deletions(-)
> 
> diff --git a/include/net/ip.h b/include/net/ip.h
> index c5606cadb1a5..cec1919cfdd0 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -663,7 +663,8 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
>  
>  static __inline__ void inet_reset_saddr(struct sock *sk)
>  {
> -	inet_sk(sk)->inet_rcv_saddr = inet_sk(sk)->inet_saddr = 0;
> +	WRITE_ONCE(inet_sk(sk)->inet_rcv_saddr, 0);
> +	WRITE_ONCE(inet_sk(sk)->inet_saddr, 0);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	if (sk->sk_family == PF_INET6) {
>  		struct ipv6_pinfo *np = inet6_sk(sk);
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index b24d74616637..e8c035f23078 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -803,28 +803,27 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
>  	int sin_addr_len = sizeof(*sin);
>  
>  	sin->sin_family = AF_INET;
> -	lock_sock(sk);
>  	if (peer) {
> -		if (!inet->inet_dport ||
> +		__be16 dport = READ_ONCE(inet->inet_dport);
> +
> +		if (!dport ||
>  		    (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_SYN_SENT)) &&

sk->sk_state will need annotation.


> -		     peer == 1)) {
> -			release_sock(sk);
> +		     peer == 1))
>  			return -ENOTCONN;
> -		}
> -		sin->sin_port = inet->inet_dport;
> +		sin->sin_port = dport;
>  		sin->sin_addr.s_addr = inet->inet_daddr;

READ_ONCE() is needed here, and WRITE_ONCE() in sk_daddr_set().


> -		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
> -				       CGROUP_INET4_GETPEERNAME);
> +		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin, &sin_addr_len,
> +					    CGROUP_INET4_GETPEERNAME, NULL);
>  	} else {
> -		__be32 addr = inet->inet_rcv_saddr;
> +		__be32 addr = READ_ONCE(inet->inet_rcv_saddr);
> +
>  		if (!addr)
> -			addr = inet->inet_saddr;
> -		sin->sin_port = inet->inet_sport;
> +			addr = READ_ONCE(inet->inet_saddr);
> +		sin->sin_port = READ_ONCE(inet->inet_sport);
>  		sin->sin_addr.s_addr = addr;
> -		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
> -				       CGROUP_INET4_GETSOCKNAME);
> +		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin, &sin_addr_len,
> +					    CGROUP_INET4_GETSOCKNAME, NULL);
>  	}
> -	release_sock(sk);
>  	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
>  	return sin_addr_len;
>  }
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 48d0d494185b..9398dbf625b4 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -577,7 +577,7 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
>  	 * in hash table socket with a funny identity.
>  	 */
>  	inet->inet_num = lport;
> -	inet->inet_sport = htons(lport);
> +	WRITE_ONCE(inet->inet_sport, htons(lport));
>  	sk->sk_hash = hash;
>  	WARN_ON(!sk_unhashed(sk));
>  	__sk_nulls_add_node_rcu(sk, &head->chain);
> @@ -877,7 +877,7 @@ inet_bhash2_addr_any_hashbucket(const struct sock *sk, const struct net *net, in
>  static void inet_update_saddr(struct sock *sk, void *saddr, int family)
>  {
>  	if (family == AF_INET) {
> -		inet_sk(sk)->inet_saddr = *(__be32 *)saddr;
> +		WRITE_ONCE(inet_sk(sk)->inet_saddr, *(__be32 *)saddr);
>  		sk_rcv_saddr_set(sk, inet_sk(sk)->inet_saddr);
>  	}
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -1115,7 +1115,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>  	inet_bind_hash(sk, tb, tb2, port);
>  
>  	if (sk_unhashed(sk)) {
> -		inet_sk(sk)->inet_sport = htons(port);
> +		WRITE_ONCE(inet_sk(sk)->inet_sport, htons(port));
>  		inet_ehash_nolisten(sk, (struct sock *)tw, NULL);
>  	}
>  	if (tw)
> @@ -1140,7 +1140,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>  		spin_unlock(lock);
>  
>  		sk->sk_hash = 0;
> -		inet_sk(sk)->inet_sport = 0;
> +		WRITE_ONCE(inet_sk(sk)->inet_sport, 0);
>  		inet_sk(sk)->inet_num = 0;
>  
>  		if (tw)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fd17f25ff288..041a29d8a0fb 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -279,7 +279,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>  			WRITE_ONCE(tp->write_seq, 0);
>  	}
>  
> -	inet->inet_dport = usin->sin_port;
> +	WRITE_ONCE(inet->inet_dport, usin->sin_port);
>  	sk_daddr_set(sk, daddr);
>  
>  	inet_csk(sk)->icsk_ext_hdr_len = 0;
> @@ -348,7 +348,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>  	inet_bhash2_reset_saddr(sk);
>  	ip_rt_put(rt);
>  	sk->sk_route_caps = 0;
> -	inet->inet_dport = 0;
> +	WRITE_ONCE(inet->inet_dport, 0);
>  	return err;
>  }
>  EXPORT_SYMBOL(tcp_v4_connect);
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index e03fb9a1dbeb..241bc6d2d0a2 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -532,32 +532,30 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
>  	sin->sin6_family = AF_INET6;
>  	sin->sin6_flowinfo = 0;
>  	sin->sin6_scope_id = 0;
> -	lock_sock(sk);
>  	if (peer) {
> -		if (!inet->inet_dport ||
> +		__be16 dport = READ_ONCE(inet->inet_dport);
> +
> +		if (!dport ||
>  		    (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_SYN_SENT)) &&
> -		    peer == 1)) {
> -			release_sock(sk);
> +		    peer == 1))
>  			return -ENOTCONN;
> -		}
> -		sin->sin6_port = inet->inet_dport;
> +		sin->sin6_port = dport;
>  		sin->sin6_addr = sk->sk_v6_daddr;

This access is also racy,


>  		if (inet6_test_bit(SNDFLOW, sk))
>  			sin->sin6_flowinfo = np->flow_label;
> -		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
> -				       CGROUP_INET6_GETPEERNAME);
> +		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin, &sin_addr_len,
> +					    CGROUP_INET6_GETPEERNAME, NULL);
>  	} else {
>  		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
>  			sin->sin6_addr = np->saddr;
>  		else
>  			sin->sin6_addr = sk->sk_v6_rcv_saddr;

and same here.


> -		sin->sin6_port = inet->inet_sport;
> -		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
> -				       CGROUP_INET6_GETSOCKNAME);
> +		sin->sin6_port = READ_ONCE(inet->inet_sport);
> +		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin, &sin_addr_len,
> +					    CGROUP_INET6_GETSOCKNAME, NULL);
>  	}
>  	sin->sin6_scope_id = ipv6_iface_scope_id(&sin->sin6_addr,
>  						 sk->sk_bound_dev_if);
> -	release_sock(sk);
>  	return sin_addr_len;
>  }
>  EXPORT_SYMBOL(inet6_getname);
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index 6db71bb1cd30..d5b191db9dfe 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -302,7 +302,7 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
>  	 * in hash table socket with a funny identity.
>  	 */
>  	inet->inet_num = lport;
> -	inet->inet_sport = htons(lport);
> +	WRITE_ONCE(inet->inet_sport, htons(lport));
>  	sk->sk_hash = hash;
>  	WARN_ON(!sk_unhashed(sk));
>  	__sk_nulls_add_node_rcu(sk, &head->chain);
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 200fea92f12f..f78ab704378a 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -293,7 +293,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
>  
>  	/* set the source address */
>  	np->saddr = *saddr;
> -	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
> +	WRITE_ONCE(inet->inet_rcv_saddr, LOOPBACK4_IPV6);
>  
>  	sk->sk_gso_type = SKB_GSO_TCPV6;
>  	ip6_dst_store(sk, dst, NULL, NULL);
> @@ -305,7 +305,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
>  
>  	tp->rx_opt.mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) - sizeof(struct ipv6hdr);
>  
> -	inet->inet_dport = usin->sin6_port;
> +	WRITE_ONCE(inet->inet_dport, usin->sin6_port);
>  
>  	tcp_set_state(sk, TCP_SYN_SENT);
>  	err = inet6_hash_connect(tcp_death_row, sk);
> @@ -340,7 +340,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
>  	tcp_set_state(sk, TCP_CLOSE);
>  	inet_bhash2_reset_saddr(sk);
>  failure:
> -	inet->inet_dport = 0;
> +	WRITE_ONCE(inet->inet_dport, 0);
>  	sk->sk_route_caps = 0;
>  	return err;
>  }
> -- 
> 2.43.5

