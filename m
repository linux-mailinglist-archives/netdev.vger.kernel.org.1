Return-Path: <netdev+bounces-50325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBA7F55E1
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACDA2812F7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8EF1382;
	Thu, 23 Nov 2023 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mAEUmrdH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F101A5
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700702879; x=1732238879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GE1NGt33UkveFcasoYOwExD3r8TqRfqQ+Y3LDNLMYy8=;
  b=mAEUmrdHCmnuqSOWdmKmT7miO+rwaSUKxoxnCtyM8nBGW5L1GCnjSzkH
   Ma4cp6mFz3QToWMvL8STQGf+VFzwSvsEgVXspFnRUB/cuu0nY0OVBdcyM
   TYW/acQh+zkL6BUxudTDnEZAhRFIau7VVvhA11xSy+YOtmhD4KNqk0QdG
   A=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="617736198"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:27:57 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 9FE4A40D3C;
	Thu, 23 Nov 2023 01:27:56 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:2561]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.6:2525] with esmtp (Farcaster)
 id ce46516c-6fcb-47de-b4fd-dae13c9f26dc; Thu, 23 Nov 2023 01:27:55 +0000 (UTC)
X-Farcaster-Flow-ID: ce46516c-6fcb-47de-b4fd-dae13c9f26dc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:27:55 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:27:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/8] tcp: Move TCP-AO bits from cookie_v[46]_check() to tcp_ao_syncookie().
Date: Wed, 22 Nov 2023 17:25:19 -0800
Message-ID: <20231123012521.62841-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231123012521.62841-1-kuniyu@amazon.com>
References: <20231123012521.62841-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We initialise treq->af_specific in cookie_tcp_reqsk_alloc() so that
we can look up a key later in tcp_create_openreq_child().

Initially, that change was added for MD5 by commit ba5a4fdd63ae ("tcp:
make sure treq->af_specific is initialized"), but it has not been used
since commit d0f2b7a9ca0a ("tcp: Disable header prediction for MD5
flow.").

Now, treq->af_specific is used only by TCP-AO, so, we can move that
initialisation into tcp_ao_syncookie().

In addition to that, l3index in cookie_v[46]_check() is only used for
tcp_ao_syncookie(), so let's move it as well.

While at it, we move down tcp_ao_syncookie() in cookie_v4_check() so
that it will be called after security_inet_conn_request() to make
functions order consistent with cookie_v6_check().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     |  1 -
 include/net/tcp_ao.h  |  6 ++----
 net/ipv4/syncookies.c | 16 ++++------------
 net/ipv4/tcp_ao.c     | 16 ++++++++++++++--
 net/ipv6/syncookies.c |  7 ++-----
 5 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index cc7143a781da..d4d0e9763175 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -494,7 +494,6 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
-					    const struct tcp_request_sock_ops *af_ops,
 					    struct sock *sk, struct sk_buff *skb);
 #ifdef CONFIG_SYN_COOKIES
 
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index b56be10838f0..4d900ef8dfc3 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -265,8 +265,7 @@ void tcp_ao_established(struct sock *sk);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
-		      struct tcp_request_sock *treq,
-		      unsigned short int family, int l3index);
+		      struct request_sock *req, unsigned short int family);
 #else /* CONFIG_TCP_AO */
 
 static inline int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
@@ -277,8 +276,7 @@ static inline int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 }
 
 static inline void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
-				    struct tcp_request_sock *treq,
-				    unsigned short int family, int l3index)
+				    struct request_sock *req, unsigned short int family)
 {
 }
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index de051eb08db8..1e3783c97e28 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -286,9 +286,7 @@ bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
 EXPORT_SYMBOL(cookie_ecn_ok);
 
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
-					    const struct tcp_request_sock_ops *af_ops,
-					    struct sock *sk,
-					    struct sk_buff *skb)
+					    struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_request_sock *treq;
 	struct request_sock *req;
@@ -303,9 +301,6 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 
 	treq = tcp_rsk(req);
 
-	/* treq->af_specific might be used to perform TCP_MD5 lookup */
-	treq->af_specific = af_ops;
-
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 	treq->req_usec_ts = false;
 
@@ -345,7 +340,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct rtable *rt;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
-	int l3index;
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -376,8 +370,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops,
-				     &tcp_request_sock_ipv4_ops, sk, skb);
+	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops, sk, skb);
 	if (!req)
 		goto out_drop;
 
@@ -406,9 +399,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
 
-	l3index = l3mdev_master_ifindex_by_index(net, ireq->ir_iif);
-	tcp_ao_syncookie(sk, skb, treq, AF_INET, l3index);
-
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
 	 */
@@ -417,6 +407,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (security_inet_conn_request(sk, skb, req))
 		goto out_free;
 
+	tcp_ao_syncookie(sk, skb, req, AF_INET);
+
 	req->num_retrans = 0;
 
 	/*
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 7696417d0640..c4cd1e09eb6b 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -844,18 +844,30 @@ static struct tcp_ao_key *tcp_ao_inbound_lookup(unsigned short int family,
 }
 
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
-		      struct tcp_request_sock *treq,
-		      unsigned short int family, int l3index)
+		      struct request_sock *req, unsigned short int family)
 {
+	struct tcp_request_sock *treq = tcp_rsk(req);
 	const struct tcphdr *th = tcp_hdr(skb);
 	const struct tcp_ao_hdr *aoh;
 	struct tcp_ao_key *key;
+	int l3index;
+
+	/* treq->af_specific is used to perform TCP_AO lookup
+	 * in tcp_create_openreq_child().
+	 */
+#if IS_ENABLED(CONFIG_IPV6)
+	if (family == AF_INET6)
+		treq->af_specific = &tcp_request_sock_ipv6_ops;
+	else
+#endif
+		treq->af_specific = &tcp_request_sock_ipv4_ops;
 
 	treq->maclen = 0;
 
 	if (tcp_parse_auth_options(th, NULL, &aoh) || !aoh)
 		return;
 
+	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), inet_rsk(req)->ir_iif);
 	key = tcp_ao_inbound_lookup(family, sk, skb, -1, aoh->keyid, l3index);
 	if (!key)
 		/* Key not found, continue without TCP-AO */
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 18c2e3c1677b..12b1809245f9 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -142,7 +142,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	int full_space, mss;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
-	int l3index;
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -173,8 +172,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops,
-				     &tcp_request_sock_ipv6_ops, sk, skb);
+	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops, sk, skb);
 	if (!req)
 		goto out_drop;
 
@@ -218,8 +216,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->ts_off = tsoff;
 	treq->txhash = net_tx_rndhash();
 
-	l3index = l3mdev_master_ifindex_by_index(net, ireq->ir_iif);
-	tcp_ao_syncookie(sk, skb, treq, AF_INET6, l3index);
+	tcp_ao_syncookie(sk, skb, req, AF_INET6);
 
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok = 0;
-- 
2.30.2


