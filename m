Return-Path: <netdev+bounces-83691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C83893665
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 01:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996B028206B
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 23:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E314883A;
	Sun, 31 Mar 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dI+fNHc5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527814882D
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711929528; cv=none; b=eQ+yqWrIY7JRsOyfoN4W3d79AJnmUo2sxB+UZ5/Wn6iYeyRJa5+nVX9+m1SJJfBThdN/V1bwGvNMg7UUUR9+MQ4jRGjMyrVp4K1OIZv146RpYql2+FTVsPihlMtc5Gou8rV3J2fuZuvmFT1BYkT1N440vOpwqjpWl3kmJz5LvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711929528; c=relaxed/simple;
	bh=s31TUcPBpRUkYoFes3q8RZddHVBqBT016o74dF7o0tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRvOhGRT0ng2Tjoi1SCh0fRjOpVpS0tHW90qjP5MSKnKgbcSfYfFKBvUIMWhJw9C8+llxJzDEiSWMD9P5+sNAVgBXDw4FipVkaRIlDt2xNaTs3+j3LCIEXISn2WEBs+FO8FX+ioyEqYO+aPS+52+GmRQL9lP7c6raJQTcpJ9bQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dI+fNHc5; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711929526; x=1743465526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O770ag/qSUw9A3C+ZLDw1gOA635Kx+hIL1YEm12uGq0=;
  b=dI+fNHc5gBHEbcZbnaKMdbNfYHPhgHI2DfJbRJ1EycS/nbKYjQh0y/ds
   vAY5wzSICesX4EWJprVGi/orYeLYP26MnNqss6+c3MESQL0zaNeWaj38r
   FRz0wswUT2V3YoePE3S1+7j9J34fC4a5RrcedwUMdYaCryPi8yAqiS8Y/
   0=;
X-IronPort-AV: E=Sophos;i="6.07,171,1708387200"; 
   d="scan'208";a="623536212"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 23:58:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:43225]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.22:2525] with esmtp (Farcaster)
 id 95e86190-6942-4119-83f5-99497d301f64; Sun, 31 Mar 2024 23:58:43 +0000 (UTC)
X-Farcaster-Flow-ID: 95e86190-6942-4119-83f5-99497d301f64
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 31 Mar 2024 23:58:43 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.217.112) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Sun, 31 Mar 2024 23:58:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp/dccp: do not care about families in inet_twsk_purge()
Date: Sun, 31 Mar 2024 16:58:28 -0700
Message-ID: <20240331235828.84714-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240329153203.345203-1-edumazet@google.com>
References: <20240329153203.345203-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 15:32:03 +0000
> We lost ability to unload ipv6 module a long time ago.
> 
> Instead of calling expensive inet_twsk_purge() twice,
> we can handle all families in one round.
> 
> Also remove an extra line added in my prior patch,
> per Kuniyuki Iwashima feedback.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Link: https://lore.kernel.org/netdev/20240327192934.6843-1-kuniyu@amazon.com/

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  include/net/inet_timewait_sock.h | 2 +-
>  include/net/tcp.h                | 2 +-
>  net/dccp/ipv4.c                  | 2 +-
>  net/dccp/ipv6.c                  | 6 ------
>  net/ipv4/inet_timewait_sock.c    | 9 +++------
>  net/ipv4/tcp_ipv4.c              | 2 +-
>  net/ipv4/tcp_minisocks.c         | 6 +++---
>  net/ipv6/tcp_ipv6.c              | 6 ------
>  8 files changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
> index f28da08a37b4e97f366279be47192019c901ed47..2a536eea9424ea4fad65a1321217b07d2346e638 100644
> --- a/include/net/inet_timewait_sock.h
> +++ b/include/net/inet_timewait_sock.h
> @@ -111,7 +111,7 @@ static inline void inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo
>  
>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw);
>  
> -void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family);
> +void inet_twsk_purge(struct inet_hashinfo *hashinfo);
>  
>  static inline
>  struct net *twsk_net(const struct inet_timewait_sock *twsk)
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6ae35199d3b3c159ba029ff74b109c56a7c7d2fc..6eaad953385e15772e8267b94ad7bf8864c18a2d 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -353,7 +353,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>  void tcp_twsk_destructor(struct sock *sk);
> -void tcp_twsk_purge(struct list_head *net_exit_list, int family);
> +void tcp_twsk_purge(struct list_head *net_exit_list);
>  ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
>  			struct pipe_inode_info *pipe, size_t len,
>  			unsigned int flags);
> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index 44b033fe1ef6859df0703c7e580cf20c771ad479..9fc9cea4c251bfb94904f1ba3b42f54fd9195dd0 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -1039,7 +1039,7 @@ static void __net_exit dccp_v4_exit_net(struct net *net)
>  
>  static void __net_exit dccp_v4_exit_batch(struct list_head *net_exit_list)
>  {
> -	inet_twsk_purge(&dccp_hashinfo, AF_INET);
> +	inet_twsk_purge(&dccp_hashinfo);
>  }
>  
>  static struct pernet_operations dccp_v4_ops = {
> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index ded07e09f8135aaf6aaa08f0adcb009d8614223c..c8ca703dc331a1a030e380daba7bcf6d382d79d6 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
> @@ -1119,15 +1119,9 @@ static void __net_exit dccp_v6_exit_net(struct net *net)
>  	inet_ctl_sock_destroy(pn->v6_ctl_sk);
>  }
>  
> -static void __net_exit dccp_v6_exit_batch(struct list_head *net_exit_list)
> -{
> -	inet_twsk_purge(&dccp_hashinfo, AF_INET6);
> -}
> -
>  static struct pernet_operations dccp_v6_ops = {
>  	.init   = dccp_v6_init_net,
>  	.exit   = dccp_v6_exit_net,
> -	.exit_batch = dccp_v6_exit_batch,
>  	.id	= &dccp_v6_pernet_id,
>  	.size   = sizeof(struct dccp_v6_pernet),
>  };
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index b0cc07d9a568c5dc52bd29729862bcb03e5d595d..e28075f0006e333897ad379ebc8c87fc3f9643bd 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -264,7 +264,7 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
>  EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
>  
>  /* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
> -void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
> +void inet_twsk_purge(struct inet_hashinfo *hashinfo)
>  {
>  	struct inet_ehash_bucket *head = &hashinfo->ehash[0];
>  	unsigned int ehash_mask = hashinfo->ehash_mask;
> @@ -273,7 +273,6 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
>  	struct sock *sk;
>  
>  	for (slot = 0; slot <= ehash_mask; slot++, head++) {
> -
>  		if (hlist_nulls_empty(&head->chain))
>  			continue;
>  
> @@ -288,15 +287,13 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
>  					     TCPF_NEW_SYN_RECV))
>  				continue;
>  
> -			if (sk->sk_family != family ||
> -			    refcount_read(&sock_net(sk)->ns.count))
> +			if (refcount_read(&sock_net(sk)->ns.count))
>  				continue;
>  
>  			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>  				continue;
>  
> -			if (unlikely(sk->sk_family != family ||
> -				     refcount_read(&sock_net(sk)->ns.count))) {
> +			if (refcount_read(&sock_net(sk)->ns.count)) {
>  				sock_gen_put(sk);
>  				goto restart;
>  			}
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a22ee58387518ac5ea602d0f66be41dfa0f4c1ee..1e0a9762f92e608c99ef7781dbdaa1ba9479b39d 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3501,7 +3501,7 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
>  {
>  	struct net *net;
>  
> -	tcp_twsk_purge(net_exit_list, AF_INET);
> +	tcp_twsk_purge(net_exit_list);
>  
>  	list_for_each_entry(net, net_exit_list, exit_list) {
>  		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index f0761f060a8376236983a660eea48a6e0ba94de4..5b21a07ddf9aa5593d21cb856f0e0ea2f45b1eef 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -388,7 +388,7 @@ void tcp_twsk_destructor(struct sock *sk)
>  }
>  EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
>  
> -void tcp_twsk_purge(struct list_head *net_exit_list, int family)
> +void tcp_twsk_purge(struct list_head *net_exit_list)
>  {
>  	bool purged_once = false;
>  	struct net *net;
> @@ -396,9 +396,9 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family)
>  	list_for_each_entry(net, net_exit_list, exit_list) {
>  		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
>  			/* Even if tw_refcount == 1, we must clean up kernel reqsk */
> -			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
> +			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo);
>  		} else if (!purged_once) {
> -			inet_twsk_purge(&tcp_hashinfo, family);
> +			inet_twsk_purge(&tcp_hashinfo);
>  			purged_once = true;
>  		}
>  	}
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 3f4cba49e9ee6520987993dcea082e6065b4688b..5ae74f661d25f9328af2a771bd801065a6522308 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2389,15 +2389,9 @@ static void __net_exit tcpv6_net_exit(struct net *net)
>  	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
>  }
>  
> -static void __net_exit tcpv6_net_exit_batch(struct list_head *net_exit_list)
> -{
> -	tcp_twsk_purge(net_exit_list, AF_INET6);
> -}
> -
>  static struct pernet_operations tcpv6_net_ops = {
>  	.init	    = tcpv6_net_init,
>  	.exit	    = tcpv6_net_exit,
> -	.exit_batch = tcpv6_net_exit_batch,
>  };
>  
>  int __init tcpv6_init(void)
> -- 
> 2.44.0.478.gd926399ef9-goog

