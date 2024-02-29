Return-Path: <netdev+bounces-76079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F686C374
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B769C1C215FD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57AC50A6C;
	Thu, 29 Feb 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sIoejb+G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BF4EB38
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195254; cv=none; b=oj21DiDBRG8PizU7c2/EEcPPDw9SgLXDIVOGk/nVnsAML8NIuJGxF4rzAX2K3u00A/eKEdQM7pKIyVqy96Z3nGRYnbJcclmTywxIfz/yKF0OiKaHUb9ZuiGvC1Ew33FOuRk0KSZfAw7opcmfR9s9KZvI4Tr8U7C3RFC19JrzT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195254; c=relaxed/simple;
	bh=bNqWuRmg6gOnPNrGirbIjOeFjR4QErQGDliMfSVM2rQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mj/EFyJvtYP3xWfZpPxVNgsCWMIt7RxK8TsJlHICd8s2LIui1dHTwbL/VNzNpm2m4lz6s4HvxulOxZhVFllIn1VTJhpk5RirgwahLnrfWkowIJpK5jOZress4e928a1Hr8S7hLpaqaTIph7X3lGFZVqsV7WUaiz7nuEgcLwwKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sIoejb+G; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709195253; x=1740731253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzIM+6+IWmLOh0CijYu2hnl+hGhl57cliIH4/Q9AsmM=;
  b=sIoejb+Gi6kM4je/SekiSrrp8TwjAqmSPcOtLlV1WL9KOkyrdKvL0bVp
   Nrzs2o+B+50oRvKb709wropQ9Ef40kie6YMdwYMNGfBx2g18XdMQzQe/n
   gDyXyNH8gFrTx/6cWfm6i16U7OH3D+yaq/e/vmNfCM/4Bf6/3unQhUOce
   s=;
X-IronPort-AV: E=Sophos;i="6.06,192,1705363200"; 
   d="scan'208";a="69631549"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:27:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:58596]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.237:2525] with esmtp (Farcaster)
 id 4c794b31-40cb-4f0c-93dc-fbf87ebbaec9; Thu, 29 Feb 2024 08:27:22 +0000 (UTC)
X-Farcaster-Flow-ID: 4c794b31-40cb-4f0c-93dc-fbf87ebbaec9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 29 Feb 2024 08:27:21 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 29 Feb 2024 08:27:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <bazsi77@gmail.com>
CC: <balazs.scheidler@axoflow.com>, <netdev@vger.kernel.org>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 2/2] net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb
Date: Thu, 29 Feb 2024 00:27:11 -0800
Message-ID: <20240229082711.82153-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cb07bca5faf1fe3c3d4f7629cb45dbf2adb520cb.1709191570.git.balazs.scheidler@axoflow.com>
References: <cb07bca5faf1fe3c3d4f7629cb45dbf2adb520cb.1709191570.git.balazs.scheidler@axoflow.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Balazs Scheidler <bazsi77@gmail.com>
Date: Thu, 29 Feb 2024 08:38:00 +0100
> The udp_fail_queue_rcv_skb() tracepoint lacks any details on the source
> and destination IP/port whereas this information can be critical in case
> of UDP/syslog.
> 
> Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
> ---
>  include/trace/events/udp.h | 33 +++++++++++++++++++++++++++++----
>  net/ipv4/udp.c             |  2 +-
>  net/ipv6/udp.c             |  3 ++-
>  3 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/udp.h b/include/trace/events/udp.h
> index 336fe272889f..cd4ae5c2fad7 100644
> --- a/include/trace/events/udp.h
> +++ b/include/trace/events/udp.h
> @@ -7,24 +7,49 @@
>  
>  #include <linux/udp.h>
>  #include <linux/tracepoint.h>
> +#include <trace/events/net_probe_common.h>
>  
>  TRACE_EVENT(udp_fail_queue_rcv_skb,
>  
> -	TP_PROTO(int rc, struct sock *sk),
> +	TP_PROTO(int rc, struct sock *sk, struct sk_buff *skb),
>  
> -	TP_ARGS(rc, sk),
> +	TP_ARGS(rc, sk, skb),
>  
>  	TP_STRUCT__entry(
>  		__field(int, rc)
>  		__field(__u16, lport)
> +
> +		__field(__u16, sport)
> +		__field(__u16, dport)

duplicating lport just for reusing TP_STORE_ADDR_PORTS_SKB() ?
Then, I think we should define udp-specific macro.


> +		__field(__u16, family)
> +		__array(__u8, saddr, sizeof(struct sockaddr_in6))
> +		__array(__u8, daddr, sizeof(struct sockaddr_in6))
>  	),
>  
>  	TP_fast_assign(
> +		const struct inet_sock *inet = inet_sk(sk);
> +		const struct udphdr *uh = (const struct udphdr *)udp_hdr(skb);
> +		__be32 *p32;
> +
>  		__entry->rc = rc;
> -		__entry->lport = inet_sk(sk)->inet_num;
> +		__entry->lport = inet->inet_num;
> +
> +		__entry->sport = ntohs(uh->source);
> +		__entry->dport = ntohs(uh->dest);
> +		__entry->family = sk->sk_family;
> +
> +		p32 = (__be32 *) __entry->saddr;
> +		*p32 = inet->inet_saddr;
> +
> +		p32 = (__be32 *) __entry->daddr;
> +		*p32 =  inet->inet_daddr;

nit: double space here.


> +
> +		TP_STORE_ADDR_PORTS_SKB(__entry, skb, uh);
>  	),
>  
> -	TP_printk("rc=%d port=%hu", __entry->rc, __entry->lport)
> +	TP_printk("rc=%d port=%hu family=%s src=%pISpc dest=%pISpc", __entry->rc, __entry->lport,
> +		  show_family_name(__entry->family),
> +		  __entry->saddr, __entry->daddr)
>  );
>  
>  #endif /* _TRACE_UDP_H */
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index a8acea17b4e5..d21a85257367 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2051,8 +2051,8 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  			drop_reason = SKB_DROP_REASON_PROTO_MEM;
>  		}
>  		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
> +		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
>  		kfree_skb_reason(skb, drop_reason);
> -		trace_udp_fail_queue_rcv_skb(rc, sk);
>  		return -1;
>  	}
>  
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 3f2249b4cd5f..e5a52c4c934c 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -34,6 +34,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/indirect_call_wrapper.h>
> +#include <trace/events/udp.h>
>  
>  #include <net/addrconf.h>
>  #include <net/ndisc.h>
> @@ -661,8 +662,8 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  			drop_reason = SKB_DROP_REASON_PROTO_MEM;
>  		}
>  		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
> +		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
>  		kfree_skb_reason(skb, drop_reason);
> -		trace_udp_fail_queue_rcv_skb(rc, sk);
>  		return -1;
>  	}
>  
> -- 
> 2.40.1

