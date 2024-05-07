Return-Path: <netdev+bounces-94221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB358BEA26
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B432809A5
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A71509AC;
	Tue,  7 May 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RSngC9K6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558A14E2EF
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102000; cv=none; b=NYlMSGTxgac8mO0s+LrfHZgwOzHrWVyIMMAB+CrtX6wNE+4589hwGnOhqyjVhFiwGpdzuOGletYIWA4jHYzFt/w37BfyhfGef2Ta4f5/9i21trYLAhuf/s0aiMI2fQ8cJH8NU3O650cstTrGMdN2iQVunxYGqaOrS++UNbm+Ino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102000; c=relaxed/simple;
	bh=QivldZ57Db1YmZuGlmKJWshI8ElzJ42FM15ZvoMHbMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3GzFaZc/vSWU76CqLaqV4ftMoEjd1Z+rCwHnuxyOJzBAvbiH8qklrkPxv/Wnj7081PqnumLM2sHgbpqZM0dOx082EavatLFy7PoKuaaTx3U+rzR5lp3wYzCjplCjP/9kYnVAYkVWL+6OG3VhhyfjFU7eglZKOzsdjaEEZmYzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RSngC9K6; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715101999; x=1746637999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8o4tAP02W7LQG9ot6gpYBiblx+IuG3F9ZuVamPJXoiM=;
  b=RSngC9K68w4wu1GAAOiy9x0doz9n+kPB/dHEnFnC8i9AXcdryRyvT0lU
   tadALDApBWqoOJVvmoWo8HYcIFSlW5teDPzfoYrLONwxMWUyBpMbII7l9
   w/Tkt88IDPEqZLCpCcWOycdOgqDVeJrkN5Oo1fHDq07EOtCD1LBMezGHA
   A=;
X-IronPort-AV: E=Sophos;i="6.08,142,1712620800"; 
   d="scan'208";a="724907619"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:13:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:1611]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.36:2525] with esmtp (Farcaster)
 id 18e4c548-b5a9-41bc-b85e-0ad02c0a1759; Tue, 7 May 2024 17:13:09 +0000 (UTC)
X-Farcaster-Flow-ID: 18e4c548-b5a9-41bc-b85e-0ad02c0a1759
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 17:13:09 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 17:13:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: get rid of twsk_unique()
Date: Tue, 7 May 2024 10:12:56 -0700
Message-ID: <20240507171256.84281-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240507164140.940547-1-edumazet@google.com>
References: <20240507164140.940547-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue,  7 May 2024 16:41:40 +0000
> DCCP is going away soon, and had no twsk_unique() method.
> 
> We can directly call tcp_twsk_unique() for TCP sockets.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

I had a similar patch that guards if (sk->sk_protocol == IPPROTO_TCP)
with #ifdef CONFIG_DCCP and calls tcp_twsk_unique() directly otherwise,
so that I will not forget removing the if part while removing DCCP.

But anyway we'll review timewait_sock_ops then, so this looks fine :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  include/net/timewait_sock.h | 9 ---------
>  net/ipv4/inet_hashtables.c  | 3 ++-
>  net/ipv4/tcp_ipv4.c         | 1 -
>  net/ipv6/inet6_hashtables.c | 4 +++-
>  net/ipv6/tcp_ipv6.c         | 1 -
>  5 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/timewait_sock.h b/include/net/timewait_sock.h
> index 74d2b463cc95e61baced94ff3e6aea3913b506ee..62b3e9f2aed404ba818f4b57d7f2d3acb8ef73f2 100644
> --- a/include/net/timewait_sock.h
> +++ b/include/net/timewait_sock.h
> @@ -15,18 +15,9 @@ struct timewait_sock_ops {
>  	struct kmem_cache	*twsk_slab;
>  	char		*twsk_slab_name;
>  	unsigned int	twsk_obj_size;
> -	int		(*twsk_unique)(struct sock *sk,
> -				       struct sock *sktw, void *twp);
>  	void		(*twsk_destructor)(struct sock *sk);
>  };
>  
> -static inline int twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
> -{
> -	if (sk->sk_prot->twsk_prot->twsk_unique != NULL)
> -		return sk->sk_prot->twsk_prot->twsk_unique(sk, sktw, twp);
> -	return 0;
> -}
> -
>  static inline void twsk_destructor(struct sock *sk)
>  {
>  	if (sk->sk_prot->twsk_prot->twsk_destructor != NULL)
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index cf88eca5f1b40563e177c6d84dd59416c62c30e5..48d0d494185b19a5e7282ffb6b33051604c28c9f 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -565,7 +565,8 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
>  		if (likely(inet_match(net, sk2, acookie, ports, dif, sdif))) {
>  			if (sk2->sk_state == TCP_TIME_WAIT) {
>  				tw = inet_twsk(sk2);
> -				if (twsk_unique(sk, sk2, twp))
> +				if (sk->sk_protocol == IPPROTO_TCP &&
> +				    tcp_twsk_unique(sk, sk2, twp))
>  					break;
>  			}
>  			goto not_unique;
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 0427deca3e0eb9239558aa124a41a1525df62a04..be0f64fec6840cee3d1734b932ba7c8b1e9bfad2 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2431,7 +2431,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  
>  static struct timewait_sock_ops tcp_timewait_sock_ops = {
>  	.twsk_obj_size	= sizeof(struct tcp_timewait_sock),
> -	.twsk_unique	= tcp_twsk_unique,
>  	.twsk_destructor= tcp_twsk_destructor,
>  };
>  
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index 2e81383b663b71b95719a295fd9629f1193e4225..6db71bb1cd300a9a3d91a8d771db4521978bc5d6 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -21,6 +21,7 @@
>  #include <net/secure_seq.h>
>  #include <net/ip.h>
>  #include <net/sock_reuseport.h>
> +#include <net/tcp.h>
>  
>  u32 inet6_ehashfn(const struct net *net,
>  		  const struct in6_addr *laddr, const u16 lport,
> @@ -289,7 +290,8 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
>  				       dif, sdif))) {
>  			if (sk2->sk_state == TCP_TIME_WAIT) {
>  				tw = inet_twsk(sk2);
> -				if (twsk_unique(sk, sk2, twp))
> +				if (sk->sk_protocol == IPPROTO_TCP &&
> +				    tcp_twsk_unique(sk, sk2, twp))
>  					break;
>  			}
>  			goto not_unique;
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 37201c4fb3931d1eb93fcd6868de7167977bf0a1..7f6693e794bd011371a8a794f703192f400546e5 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2049,7 +2049,6 @@ void tcp_v6_early_demux(struct sk_buff *skb)
>  
>  static struct timewait_sock_ops tcp6_timewait_sock_ops = {
>  	.twsk_obj_size	= sizeof(struct tcp6_timewait_sock),
> -	.twsk_unique	= tcp_twsk_unique,
>  	.twsk_destructor = tcp_twsk_destructor,
>  };
>  
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

