Return-Path: <netdev+bounces-64287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C78320FA
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 22:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED5E285BBE
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE42E85E;
	Thu, 18 Jan 2024 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZCfkgdHT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BA2C197
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614250; cv=none; b=p75Ht32hZC2a3nkYRkjq0nrZhfyiQSv28ulMCRcLExqa7LPN64ffU+y2LAs1H83k2Ez5SxdeVgEFDssAc/3IY36IBVtrp6KMXuegpT00WSGasmq+Z2Jx4LrfKP5LSme4eyxyHHiNtcO38xGLzbFdkCykqXW09Cm1huNiwGPCJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614250; c=relaxed/simple;
	bh=LPwNAbt/bN23ehBUr8pH9DBi1tCGWAovoNhs9bw3308=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnPHR4MHJ5jrgsKRa6MuA9ydHwNLJQo2oM+fyNcsDkPJtuZvd2QgfXYLJi397Obp7lOI9f3OCQSqHMNLn9kP18jEnWA5z1MwoEHYI3ey8epoGZp/u2QfmWGZTSgx5ekAgJtuIwP6j9XTSh8IKEQS6wk+t48FfBK9lN2PzOksqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZCfkgdHT; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705614249; x=1737150249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oDJbxFJYLYkzBYaucjpxhzStNLLyO7GujKxTGxIdMZI=;
  b=ZCfkgdHT0Sh6V1Xvd4EnccWwIm0CLsQcMNcVXDBwgy3GhNrZikUZ/yVY
   M2aW/P0h2F4wzmhgzKyKUyNeqIBYPOeBaI4+Tm4qpxUPICXP/u16dXYu+
   uPnA529zX1KgWs1F66kqK7AqtUgjjEL/V3qwM94YxtSe2D9ajBeoxl8Au
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="178943624"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 21:44:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 5B6AD8869D;
	Thu, 18 Jan 2024 21:44:05 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:45730]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.111:2525] with esmtp (Farcaster)
 id 47183dcb-805b-4725-935f-0555fbc5f4a9; Thu, 18 Jan 2024 21:44:04 +0000 (UTC)
X-Farcaster-Flow-ID: 47183dcb-805b-4725-935f-0555fbc5f4a9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 21:44:02 +0000
Received: from 88665a182662.ant.amazon.com (10.88.183.204) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 21:44:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v3 net] udp: fix busy polling
Date: Thu, 18 Jan 2024 13:43:47 -0800
Message-ID: <20240118214347.36109-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240118201749.4148681-1-edumazet@google.com>
References: <20240118201749.4148681-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 20:17:49 +0000
> Generic sk_busy_loop_end() only looks at sk->sk_receive_queue
> for presence of packets.
> 
> Problem is that for UDP sockets after blamed commit, some packets
> could be present in another queue: udp_sk(sk)->reader_queue
> 
> In some cases, a busy poller could spin until timeout expiration,
> even if some packets are available in udp_sk(sk)->reader_queue.
> 
> v3: - make sk_busy_loop_end() nicer (Willem)
> 
> v2: - add a READ_ONCE(sk->sk_family) in sk_is_inet() to avoid KCSAN splats.
>     - add a sk_is_inet() check in sk_is_udp() (Willem feedback)
>     - add a sk_is_inet() check in sk_is_tcp().
> 
> Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

IPPROTO_UDPLITE will have the same issue but not worth
adding sk_is_udp_or_udplite() for a single place given
no one has complained about duplication notice.


> ---
>  include/linux/skmsg.h   |  6 ------
>  include/net/inet_sock.h |  5 -----
>  include/net/sock.h      | 18 +++++++++++++++++-
>  net/core/sock.c         | 11 +++++++++--
>  4 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 888a4b217829fd4d6baf52f784ce35e9ad6bd0ed..e65ec3fd27998a5b82fc2c4597c575125e653056 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -505,12 +505,6 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
>  	return !!psock->saved_data_ready;
>  }
>  
> -static inline bool sk_is_udp(const struct sock *sk)
> -{
> -	return sk->sk_type == SOCK_DGRAM &&
> -	       sk->sk_protocol == IPPROTO_UDP;
> -}
> -
>  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
>  
>  #define BPF_F_STRPARSER	(1UL << 1)
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index aa86453f6b9ba367f772570a7b783bb098be6236..d94c242eb3ed20b2c5b2e5ceea3953cf96341fb7 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -307,11 +307,6 @@ static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
>  #define inet_assign_bit(nr, sk, val)		\
>  	assign_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags, val)
>  
> -static inline bool sk_is_inet(struct sock *sk)
> -{
> -	return sk->sk_family == AF_INET || sk->sk_family == AF_INET6;
> -}
> -
>  /**
>   * sk_to_full_sk - Access to a full socket
>   * @sk: pointer to a socket
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a7f815c7cfdfdf1296be2967fd100efdb10cdd63..54ca8dcbfb4335d657b5cea323aa7d8c4316d49e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2765,9 +2765,25 @@ static inline void skb_setup_tx_timestamp(struct sk_buff *skb, __u16 tsflags)
>  			   &skb_shinfo(skb)->tskey);
>  }
>  
> +static inline bool sk_is_inet(const struct sock *sk)
> +{
> +	int family = READ_ONCE(sk->sk_family);
> +
> +	return family == AF_INET || family == AF_INET6;
> +}
> +
>  static inline bool sk_is_tcp(const struct sock *sk)
>  {
> -	return sk->sk_type == SOCK_STREAM && sk->sk_protocol == IPPROTO_TCP;
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == IPPROTO_TCP;
> +}
> +
> +static inline bool sk_is_udp(const struct sock *sk)
> +{
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_DGRAM &&
> +	       sk->sk_protocol == IPPROTO_UDP;
>  }
>  
>  static inline bool sk_is_stream_unix(const struct sock *sk)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 158dbdebce6a3693deb63e557e856d9cdd7500ae..0a7f46c37f0cfc169e11377107c8342c229da0de 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -107,6 +107,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/poll.h>
>  #include <linux/tcp.h>
> +#include <linux/udp.h>
>  #include <linux/init.h>
>  #include <linux/highmem.h>
>  #include <linux/user_namespace.h>
> @@ -4144,8 +4145,14 @@ bool sk_busy_loop_end(void *p, unsigned long start_time)
>  {
>  	struct sock *sk = p;
>  
> -	return !skb_queue_empty_lockless(&sk->sk_receive_queue) ||
> -	       sk_busy_loop_timeout(sk, start_time);
> +	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
> +		return true;
> +
> +	if (sk_is_udp(sk) &&
> +	    !skb_queue_empty_lockless(&udp_sk(sk)->reader_queue))
> +		return true;
> +
> +	return sk_busy_loop_timeout(sk, start_time);
>  }
>  EXPORT_SYMBOL(sk_busy_loop_end);
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

