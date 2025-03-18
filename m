Return-Path: <netdev+bounces-175601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3519DA66A0A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 07:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491B2189C707
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D617A2E5;
	Tue, 18 Mar 2025 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z4YmM4iY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DE25569
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277696; cv=none; b=pv7F974S3lg+xRFuQIUYc6P84Em5hm+YrAR1qqv33Nir49W5/N/qEsxkFWuGvamEKDagk4XAV8atZpegilR0T5SPtV5zdX5QrxF0EfB4ZSQvGW/w0Lhpcn54D7LdEAECDpK7EBwraPBotAMJbu6DqTF14NwVN4KRW5hE0fjioV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277696; c=relaxed/simple;
	bh=HxCkMPWPILauJPgRaYF7HIXuZUllGeMI7eVXEsWsqok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCiuHyWjTYzt2nhutQq3iOMQO6+1YemKZtAAzE6CxyeyTvKdKzVRGQ087F2aDy9tGL0CUnGV4JavkRgZDA+jZDEJl+W8bG+LKh3WrMnz7HGFxGLcj/+uool9aBRZtsWi9AY9kpNd1zSbe5HklpwoRu0yiWHhdBRzEHdVsxd8sJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z4YmM4iY; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742277692; x=1773813692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SRF6gy8iKPIM0L3UHaq1S2aXoczJ38MmTp6q4OtQ3BI=;
  b=Z4YmM4iYzQGYhg1A4DYZEc5KD40KzbBMAE1NguxeaGX+S1C3LfEoIIrp
   HYBlEOnuiYQHHnHF/keCmWirW9VUYb6yvrOxFbk65OXIBci+qn8Kg89I7
   GAUTY3ZDd/yvulykYAdhMXOWwBpVdw44O8nwn4XTZPuChNZDIEMtDopiJ
   Y=;
X-IronPort-AV: E=Sophos;i="6.14,256,1736812800"; 
   d="scan'208";a="503650908"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:01:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:30054]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.151:2525] with esmtp (Farcaster)
 id dc5c8365-ff51-4883-abbd-3c120306887f; Tue, 18 Mar 2025 06:01:24 +0000 (UTC)
X-Farcaster-Flow-ID: dc5c8365-ff51-4883-abbd-3c120306887f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 06:01:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 06:01:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, David Ahern
	<dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] tcp/dccp: Remove inet_connection_sock_af_ops.addr2sockaddr().
Date: Mon, 17 Mar 2025 23:01:07 -0700
Message-ID: <20250318060112.3729-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

inet_connection_sock_af_ops.addr2sockaddr() hasn't been used at all
in the git era.

  $ git grep addr2sockaddr $(git rev-list HEAD | tail -n 1)

Let's remove it.

Note that there was a 4 bytes hole after sockaddr_len and now it's
6 bytes, so the binary layout is not changed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet6_connection_sock.h |  2 --
 include/net/inet_connection_sock.h  |  4 ----
 net/dccp/ipv4.c                     |  2 --
 net/dccp/ipv6.c                     |  4 ----
 net/ipv4/inet_connection_sock.c     | 11 -----------
 net/ipv4/tcp_ipv4.c                 |  2 --
 net/ipv6/inet6_connection_sock.c    | 14 --------------
 net/ipv6/tcp_ipv6.c                 |  4 ----
 8 files changed, 43 deletions(-)

diff --git a/include/net/inet6_connection_sock.h b/include/net/inet6_connection_sock.h
index 025bd8d3c769..745891d2e113 100644
--- a/include/net/inet6_connection_sock.h
+++ b/include/net/inet6_connection_sock.h
@@ -21,8 +21,6 @@ struct sockaddr;
 struct dst_entry *inet6_csk_route_req(const struct sock *sk, struct flowi6 *fl6,
 				      const struct request_sock *req, u8 proto);
 
-void inet6_csk_addr2sockaddr(struct sock *sk, struct sockaddr *uaddr);
-
 int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl);
 
 struct dst_entry *inet6_csk_update_pmtu(struct sock *sk, u32 mtu);
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d9978ffacc97..5a5b30e2cc0e 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -44,12 +44,10 @@ struct inet_connection_sock_af_ops {
 				      struct request_sock *req_unhash,
 				      bool *own_req);
 	u16	    net_header_len;
-	u16	    sockaddr_len;
 	int	    (*setsockopt)(struct sock *sk, int level, int optname,
 				  sockptr_t optval, unsigned int optlen);
 	int	    (*getsockopt)(struct sock *sk, int level, int optname,
 				  char __user *optval, int __user *optlen);
-	void	    (*addr2sockaddr)(struct sock *sk, struct sockaddr *);
 	void	    (*mtu_reduced)(struct sock *sk);
 };
 
@@ -316,8 +314,6 @@ static inline __poll_t inet_csk_listen_poll(const struct sock *sk)
 int inet_csk_listen_start(struct sock *sk);
 void inet_csk_listen_stop(struct sock *sk);
 
-void inet_csk_addr2sockaddr(struct sock *sk, struct sockaddr *uaddr);
-
 /* update the fast reuse flag when adding a socket */
 void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
 			       struct sock *sk);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index bfa529a54aca..2045ddac0fe9 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -934,8 +934,6 @@ static const struct inet_connection_sock_af_ops dccp_ipv4_af_ops = {
 	.net_header_len	   = sizeof(struct iphdr),
 	.setsockopt	   = ip_setsockopt,
 	.getsockopt	   = ip_getsockopt,
-	.addr2sockaddr	   = inet_csk_addr2sockaddr,
-	.sockaddr_len	   = sizeof(struct sockaddr_in),
 };
 
 static int dccp_v4_init_sock(struct sock *sk)
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 39ae9d89d7d4..e24dbffabfc1 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -988,8 +988,6 @@ static const struct inet_connection_sock_af_ops dccp_ipv6_af_ops = {
 	.net_header_len	   = sizeof(struct ipv6hdr),
 	.setsockopt	   = ipv6_setsockopt,
 	.getsockopt	   = ipv6_getsockopt,
-	.addr2sockaddr	   = inet6_csk_addr2sockaddr,
-	.sockaddr_len	   = sizeof(struct sockaddr_in6),
 };
 
 /*
@@ -1004,8 +1002,6 @@ static const struct inet_connection_sock_af_ops dccp_ipv6_mapped = {
 	.net_header_len	   = sizeof(struct iphdr),
 	.setsockopt	   = ipv6_setsockopt,
 	.getsockopt	   = ipv6_getsockopt,
-	.addr2sockaddr	   = inet6_csk_addr2sockaddr,
-	.sockaddr_len	   = sizeof(struct sockaddr_in6),
 };
 
 static void dccp_v6_sk_destruct(struct sock *sk)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e93c66034077..dd5cf8914a28 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1553,17 +1553,6 @@ void inet_csk_listen_stop(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_csk_listen_stop);
 
-void inet_csk_addr2sockaddr(struct sock *sk, struct sockaddr *uaddr)
-{
-	struct sockaddr_in *sin = (struct sockaddr_in *)uaddr;
-	const struct inet_sock *inet = inet_sk(sk);
-
-	sin->sin_family		= AF_INET;
-	sin->sin_addr.s_addr	= inet->inet_daddr;
-	sin->sin_port		= inet->inet_dport;
-}
-EXPORT_SYMBOL_GPL(inet_csk_addr2sockaddr);
-
 static struct dst_entry *inet_csk_rebuild_route(struct sock *sk, struct flowi *fl)
 {
 	const struct inet_sock *inet = inet_sk(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4fa4fbb0ad12..1cd0938d47e0 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2477,8 +2477,6 @@ const struct inet_connection_sock_af_ops ipv4_specific = {
 	.net_header_len	   = sizeof(struct iphdr),
 	.setsockopt	   = ip_setsockopt,
 	.getsockopt	   = ip_getsockopt,
-	.addr2sockaddr	   = inet_csk_addr2sockaddr,
-	.sockaddr_len	   = sizeof(struct sockaddr_in),
 	.mtu_reduced	   = tcp_v4_mtu_reduced,
 };
 EXPORT_IPV6_MOD(ipv4_specific);
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 80043e46117c..dbcf556a35bb 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -56,20 +56,6 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 }
 EXPORT_SYMBOL(inet6_csk_route_req);
 
-void inet6_csk_addr2sockaddr(struct sock *sk, struct sockaddr *uaddr)
-{
-	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *) uaddr;
-
-	sin6->sin6_family = AF_INET6;
-	sin6->sin6_addr = sk->sk_v6_daddr;
-	sin6->sin6_port	= inet_sk(sk)->inet_dport;
-	/* We do not store received flowlabel for TCP */
-	sin6->sin6_flowinfo = 0;
-	sin6->sin6_scope_id = ipv6_iface_scope_id(&sin6->sin6_addr,
-						  sk->sk_bound_dev_if);
-}
-EXPORT_SYMBOL_GPL(inet6_csk_addr2sockaddr);
-
 static inline
 struct dst_entry *__inet6_csk_dst_check(struct sock *sk, u32 cookie)
 {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e182ee0a2330..c134cf1a603a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2068,8 +2068,6 @@ const struct inet_connection_sock_af_ops ipv6_specific = {
 	.net_header_len	   = sizeof(struct ipv6hdr),
 	.setsockopt	   = ipv6_setsockopt,
 	.getsockopt	   = ipv6_getsockopt,
-	.addr2sockaddr	   = inet6_csk_addr2sockaddr,
-	.sockaddr_len	   = sizeof(struct sockaddr_in6),
 	.mtu_reduced	   = tcp_v6_mtu_reduced,
 };
 
@@ -2102,8 +2100,6 @@ static const struct inet_connection_sock_af_ops ipv6_mapped = {
 	.net_header_len	   = sizeof(struct iphdr),
 	.setsockopt	   = ipv6_setsockopt,
 	.getsockopt	   = ipv6_getsockopt,
-	.addr2sockaddr	   = inet6_csk_addr2sockaddr,
-	.sockaddr_len	   = sizeof(struct sockaddr_in6),
 	.mtu_reduced	   = tcp_v4_mtu_reduced,
 };
 
-- 
2.48.1


