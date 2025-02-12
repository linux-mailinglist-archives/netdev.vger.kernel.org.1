Return-Path: <netdev+bounces-165515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3AA326BA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9083A76F5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645A720E31E;
	Wed, 12 Feb 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVJgq2/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9C20E332
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366017; cv=none; b=tdvKy+d7ME6QOfFqmczIbRmugojjnldKqpvH0ZUuY4EhwkQmDzdWCc567oIO96dbrC/OSMFzYte0ULbfomYTGT4W6ixEIJrO4DuLPi3pQ1jX7Z/MOqR5aNpViGfSqx6NgkCe8qetz/vxWKAUmAVWRckH5HtOd6At4hfBOTSZLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366017; c=relaxed/simple;
	bh=VSUoxJXGe14tF3DdmTl+gVJ/A9/G9sdsIdw9GYj2Opk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lA35KAHUeywc+ea54lAtvnWkBOw5fDF/C8fNToMcOyQy5g5LqonfFVfI0Dd0vRP3yflC7n8A2joZwiwl0Qv3ela6RPmRJWxmSSawolWqIvsQLg3qLWNygD0dH8HBKzuhQUMLuJLOi63OvNANkeS6Re8XlYor+SkPYS2kA+0XVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVJgq2/I; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-471b9ccf86dso5339321cf.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366014; x=1739970814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2W3DSQyzKm60sxGI2lx2gpnMLFsJSreBDk/Uk4I4YC4=;
        b=aVJgq2/IsAQzDHzBLbM4lNS+bojlSkqEfXYVs/Iv0+/O6C3kXuwymgC+IQ/VIeyVuO
         FIFoyDUMiS6app9Aq0bx/ufzaZ55zvIJzFqeeeADvBI3nPCyY8RuFZT2y49NF5DA10ia
         YOzQBC+nFFvg9JJAVNaLmqi31EfPcI9U/di+RdDEw2mI2YLPA67AKDWx3xTE9g7J8C0j
         f2uroH+/SboXMG2v5/rd/wtlPbRzYZbN7WTkuA2proUcnPd9YKMibBLLrT5A6KFr4Jzu
         8EAIeY86Q1TlBRNejlFNktsDJC++WMR9u7AyyZxQtFhmMgmSAxsvGQbBePWjNHEM6nPT
         G3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366014; x=1739970814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W3DSQyzKm60sxGI2lx2gpnMLFsJSreBDk/Uk4I4YC4=;
        b=bNKH8fhMuk+4LNovYNm/DSQFB0clBri3KFVMAfMt76UlF1OFB+nn50pARzgm1KdrVs
         nplUWWMZdwdnDUV0H6bizp2KW88gUU1BD3wnrqSAiZ1CjiT4tuSSYx9iVRB6LB19Kh4o
         QsCowXqNswNxcQmK/z0JxlI38FYUssRjp7xnBb/8JE15kQLUxIuf700V5c8Jznnk2pZR
         pAEajPIGsJ4r2Z1w1Atz/vLhatztuE6WSFWpd+7XkVLeK9Ok1a0E0Xo4UE5ahZqtK0HM
         1aoZzNlCl1mh2Gb5OmXPhKYZ9joQuqrfOLxo31Fe2D+u0gk5GvqeaJ21dikJUI4QnNcK
         cAng==
X-Gm-Message-State: AOJu0Yyoi1avV74WqO/2igPw2bh9jmXIkSAgjdIF4EmJTDqY3OOI/p6j
	qVHpukVjbi306OA18H6Am9eUZRe8wZWwvkGnoqBmgPTp2ONb/SjPBe9vKHfT+sl2bjG4tq2XFGd
	mvW6neK6hQw==
X-Google-Smtp-Source: AGHT+IH7WhbTMh/KV2r/stnCMVK8cjhZs3C3XLs2c6E/w3i5qSbcPXlCUeqwfQjPe0GHvCE4J4671kktAcpYtw==
X-Received: from qtbfb16.prod.google.com ([2002:a05:622a:4810:b0:471:919a:e569])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5fd2:0:b0:471:959e:bc13 with SMTP id d75a77b69052e-471afecce0amr39155491cf.40.1739366014366;
 Wed, 12 Feb 2025 05:13:34 -0800 (PST)
Date: Wed, 12 Feb 2025 13:13:28 +0000
In-Reply-To: <20250212131328.1514243-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212131328.1514243-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212131328.1514243-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] inet: consolidate inet_csk_clone_lock()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Current inet_sock_set_state trace from inet_csk_clone_lock() is missing
many details :

... sock:inet_sock_set_state: family=AF_INET6 protocol=IPPROTO_TCP \
    sport=4901 dport=0 \
    saddr=127.0.0.6 daddr=0.0.0.0 \
    saddrv6=:: daddrv6=:: \
    oldstate=TCP_LISTEN newstate=TCP_SYN_RECV

Only the sport gives the listener port, no other parts of the n-tuple are correct.

In this patch, I initialize relevant fields of the new socket before
calling inet_sk_set_state(newsk, TCP_SYN_RECV).

We now have a trace including all the source/destination bits.

... sock:inet_sock_set_state: family=AF_INET6 protocol=IPPROTO_TCP \
    sport=4901 dport=47648 \
    saddr=127.0.0.6 daddr=127.0.0.6 \
    saddrv6=2002:a05:6830:1f85:: daddrv6=2001:4860:f803:65::3 \
    oldstate=TCP_LISTEN newstate=TCP_SYN_RECV

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/dccp/ipv4.c                 |  3 ---
 net/dccp/ipv6.c                 |  9 +++------
 net/ipv4/inet_connection_sock.c | 24 ++++++++++++++++++++----
 net/ipv4/tcp_ipv4.c             |  4 ----
 net/ipv6/tcp_ipv6.c             |  8 ++------
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index be515ba821e2d4d6a7bca973b5e7c2363a2f13cc..bfa529a54acab6abd279c9e4a600e699e8904d8a 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -426,9 +426,6 @@ struct sock *dccp_v4_request_recv_sock(const struct sock *sk,
 
 	newinet		   = inet_sk(newsk);
 	ireq		   = inet_rsk(req);
-	sk_daddr_set(newsk, ireq->ir_rmt_addr);
-	sk_rcv_saddr_set(newsk, ireq->ir_loc_addr);
-	newinet->inet_saddr	= ireq->ir_loc_addr;
 	RCU_INIT_POINTER(newinet->inet_opt, rcu_dereference(ireq->ireq_opt));
 	newinet->mc_index  = inet_iif(skb);
 	newinet->mc_ttl	   = ip_hdr(skb)->ttl;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index d6649246188d72b3df6c74750779b7aa5910dcb7..39ae9d89d7d43fc8730dd2ec20d6e1cf72d20bf3 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -365,6 +365,9 @@ static int dccp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	ireq = inet_rsk(req);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
+	ireq->ir_rmt_addr = LOOPBACK4_IPV6;
+	ireq->ir_loc_addr = LOOPBACK4_IPV6;
+
 	ireq->ireq_family = AF_INET6;
 	ireq->ir_mark = inet_request_mark(sk, skb);
 
@@ -504,10 +507,7 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
-	newsk->sk_v6_daddr	= ireq->ir_v6_rmt_addr;
 	newnp->saddr		= ireq->ir_v6_loc_addr;
-	newsk->sk_v6_rcv_saddr	= ireq->ir_v6_loc_addr;
-	newsk->sk_bound_dev_if	= ireq->ir_iif;
 
 	/* Now IPv6 options...
 
@@ -546,9 +546,6 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 
 	dccp_sync_mss(newsk, dst_mtu(dst));
 
-	newinet->inet_daddr = newinet->inet_saddr = LOOPBACK4_IPV6;
-	newinet->inet_rcv_saddr = LOOPBACK4_IPV6;
-
 	if (__inet_inherit_port(sk, newsk) < 0) {
 		inet_csk_prepare_forced_close(newsk);
 		dccp_done(newsk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1c00069552ccfbf8c0d0d91d14cf951a39711273..bf9ce0c196575910b4b03fca13001979d4326297 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1238,19 +1238,33 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 {
 	struct sock *newsk = sk_clone_lock(sk, priority);
 	struct inet_connection_sock *newicsk;
+	struct inet_request_sock *ireq;
+	struct inet_sock *newinet;
 
 	if (!newsk)
 		return NULL;
 
 	newicsk = inet_csk(newsk);
+	newinet = inet_sk(newsk);
+	ireq = inet_rsk(req);
 
-	inet_sk_set_state(newsk, TCP_SYN_RECV);
 	newicsk->icsk_bind_hash = NULL;
 	newicsk->icsk_bind2_hash = NULL;
 
-	inet_sk(newsk)->inet_dport = inet_rsk(req)->ir_rmt_port;
-	inet_sk(newsk)->inet_num = inet_rsk(req)->ir_num;
-	inet_sk(newsk)->inet_sport = htons(inet_rsk(req)->ir_num);
+	newinet->inet_dport = ireq->ir_rmt_port;
+	newinet->inet_num = ireq->ir_num;
+	newinet->inet_sport = htons(ireq->ir_num);
+
+	newsk->sk_bound_dev_if = ireq->ir_iif;
+
+	newsk->sk_daddr = ireq->ir_rmt_addr;
+	newsk->sk_rcv_saddr = ireq->ir_loc_addr;
+	newinet->inet_saddr = ireq->ir_loc_addr;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
+	newsk->sk_v6_rcv_saddr = ireq->ir_v6_loc_addr;
+#endif
 
 	/* listeners have SOCK_RCU_FREE, not the children */
 	sock_reset_flag(newsk, SOCK_RCU_FREE);
@@ -1270,6 +1284,8 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	memset(&newicsk->icsk_accept_queue, 0,
 	       sizeof(newicsk->icsk_accept_queue));
 
+	inet_sk_set_state(newsk, TCP_SYN_RECV);
+
 	inet_clone_ulp(req, newsk, priority);
 
 	security_inet_csk_clone(newsk, req);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d1fd2128ac6cce9b845b1f8d278a194c511db87b..56949eb289ce330448b771f91d5c3130d6b2ac96 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1769,10 +1769,6 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	newtp		      = tcp_sk(newsk);
 	newinet		      = inet_sk(newsk);
 	ireq		      = inet_rsk(req);
-	sk_daddr_set(newsk, ireq->ir_rmt_addr);
-	sk_rcv_saddr_set(newsk, ireq->ir_loc_addr);
-	newsk->sk_bound_dev_if = ireq->ir_iif;
-	newinet->inet_saddr   = ireq->ir_loc_addr;
 	inet_opt	      = rcu_dereference(ireq->ireq_opt);
 	RCU_INIT_POINTER(newinet->inet_opt, inet_opt);
 	newinet->mc_index     = inet_iif(skb);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2debdf085a3b4d2452b2b316cb5368507b17efc8..a806082602985fd351c5184f52dc3011c71540a9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -798,6 +798,8 @@ static void tcp_v6_init_req(struct request_sock *req,
 
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
+	ireq->ir_rmt_addr = LOOPBACK4_IPV6;
+	ireq->ir_loc_addr = LOOPBACK4_IPV6;
 
 	/* So that link locals have meaning */
 	if ((!sk_listener->sk_bound_dev_if || l3_slave) &&
@@ -1451,10 +1453,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	ip6_dst_store(newsk, dst, NULL, NULL);
 
-	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
-	newsk->sk_v6_rcv_saddr = ireq->ir_v6_loc_addr;
-	newsk->sk_bound_dev_if = ireq->ir_iif;
 
 	/* Now IPv6 options...
 
@@ -1507,9 +1506,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	tcp_initialize_rcv_mss(newsk);
 
-	newinet->inet_daddr = newinet->inet_saddr = LOOPBACK4_IPV6;
-	newinet->inet_rcv_saddr = LOOPBACK4_IPV6;
-
 #ifdef CONFIG_TCP_MD5SIG
 	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), ireq->ir_iif);
 
-- 
2.48.1.502.g6dc24dfdaf-goog


