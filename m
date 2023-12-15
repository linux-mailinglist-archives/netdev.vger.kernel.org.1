Return-Path: <netdev+bounces-57706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80444813F76
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CCFB21CED
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A82624;
	Fri, 15 Dec 2023 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tMJqbphW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08B10F3
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702605085; x=1734141085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VVRqC07AyHT2rQC8j4OSNYBMB8IKQGcyHhijztHrBuM=;
  b=tMJqbphWp/JiElQ2PyorXrPyDkuMs+pycUbesZrm1HSuSNr9PM9FTrgt
   ns9Wpqnf1uj4SXxOcQaGrUsGyZNpyX///F/P6kI6J9rtmdv2hh5Kqb9WL
   KcVQTWylFuksfmQXFclImO8k8YO9AWrY1srHbdsi8VDEsmVk93Mvfi46w
   I=;
X-IronPort-AV: E=Sophos;i="6.04,277,1695686400"; 
   d="scan'208";a="600739375"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 01:51:18 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id 1600460CA1;
	Fri, 15 Dec 2023 01:51:17 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:1663]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id 5bd78f9a-7d22-44cd-aa05-4a2fbc703fde; Fri, 15 Dec 2023 01:51:16 +0000 (UTC)
X-Farcaster-Flow-ID: 5bd78f9a-7d22-44cd-aa05-4a2fbc703fde
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 01:51:16 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 01:51:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <jakub@cloudflare.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 1/2] inet: returns a bool from inet_sk_get_local_port_range()
Date: Fri, 15 Dec 2023 10:50:58 +0900
Message-ID: <20231215015058.38150-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214192939.1962891-2-edumazet@google.com>
References: <20231214192939.1962891-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 19:29:38 +0000
> Change inet_sk_get_local_port_range() to return a boolean,
> telling the callers if the port range was provided by
> IP_LOCAL_PORT_RANGE socket option.
> 
> Adds documentation while we are at it.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  include/net/ip.h                |  2 +-
>  net/ipv4/inet_connection_sock.c | 21 ++++++++++++++++-----
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/ip.h b/include/net/ip.h
> index b31be912489af8b01cc0393a27ffc80b086feaa0..de0c69c57e3cb7485e3d8473bc0b109e4280d2f6 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -356,7 +356,7 @@ static inline void inet_get_local_port_range(const struct net *net, int *low, in
>  	*low = range & 0xffff;
>  	*high = range >> 16;
>  }
> -void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high);
> +bool inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high);
>  
>  #ifdef CONFIG_SYSCTL
>  static inline bool inet_is_local_reserved_port(struct net *net, unsigned short port)
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 70be0f6fe879ea671bf6686b04edf32bf5e0d4b6..bd325b029dd12c9fad754ded266ae232ee7ec260 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -117,16 +117,25 @@ bool inet_rcv_saddr_any(const struct sock *sk)
>  	return !sk->sk_rcv_saddr;
>  }
>  
> -void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
> +/**
> + *	inet_sk_get_local_port_range - fetch ephemeral ports range
> + *	@sk: socket
> + *	@low: pointer to low port
> + *	@high: pointer to high port
> + *
> + *	Fetch netns port range (/proc/sys/net/ipv4/ip_local_port_range)
> + *	Range can be overridden if socket got IP_LOCAL_PORT_RANGE option.
> + *	Returns true if IP_LOCAL_PORT_RANGE was set on this socket.
> + */
> +bool inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
>  {
> -	const struct inet_sock *inet = inet_sk(sk);
> -	const struct net *net = sock_net(sk);
>  	int lo, hi, sk_lo, sk_hi;
> +	bool local_range = false;
>  	u32 sk_range;
>  
> -	inet_get_local_port_range(net, &lo, &hi);
> +	inet_get_local_port_range(sock_net(sk), &lo, &hi);
>  
> -	sk_range = READ_ONCE(inet->local_port_range);
> +	sk_range = READ_ONCE(inet_sk(sk)->local_port_range);
>  	if (unlikely(sk_range)) {
>  		sk_lo = sk_range & 0xffff;
>  		sk_hi = sk_range >> 16;
> @@ -135,10 +144,12 @@ void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
>  			lo = sk_lo;
>  		if (lo <= sk_hi && sk_hi <= hi)
>  			hi = sk_hi;
> +		local_range = true;
>  	}
>  
>  	*low = lo;
>  	*high = hi;
> +	return local_range;
>  }
>  EXPORT_SYMBOL(inet_sk_get_local_port_range);
>  
> -- 
> 2.43.0.472.g3155946c3a-goog

