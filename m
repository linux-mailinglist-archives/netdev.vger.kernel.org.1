Return-Path: <netdev+bounces-50321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CC7F55D8
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551EE2811EF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F42315A2;
	Thu, 23 Nov 2023 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h1CS+dcY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6ABC1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700702783; x=1732238783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnpxzIipwhSuxYeF76lXOslv74Nh2iQ5cA36l7tkEMQ=;
  b=h1CS+dcY7bzz/mBcnfMbl8W4MatfnFjof51JJx1t2xG1qr4/x9U6enV8
   cF0GyidDTcxzbfZSIj0FEx75OFeLZ7g6wAOS3jVM4K9BnFz+sCFnWxYWQ
   6w3Ba7VLI0k4r60ga4z0pIntT9R4BiyN+IFkyHT7lzMN0KgHl/sb7A7+z
   I=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="254942529"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:26:21 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 49C7E60A43;
	Thu, 23 Nov 2023 01:26:21 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:52507]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id 289b052d-5aad-470d-93c2-a4cab970b1de; Thu, 23 Nov 2023 01:26:20 +0000 (UTC)
X-Farcaster-Flow-ID: 289b052d-5aad-470d-93c2-a4cab970b1de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:26:20 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:26:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/8] tcp: Cache sock_net(sk) in cookie_v[46]_check().
Date: Wed, 22 Nov 2023 17:25:15 -0800
Message-ID: <20231123012521.62841-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

sock_net(sk) is used repeatedly in cookie_v[46]_check().
Let's cache it in a variable.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/syncookies.c | 21 +++++++++++----------
 net/ipv6/syncookies.c | 19 ++++++++++---------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index a0118ea76734..fb41bb18fe6b 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -336,6 +336,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct tcp_options_received tcp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
+	struct net *net = sock_net(sk);
 	struct tcp_request_sock *treq;
 	struct request_sock *req;
 	struct sock *ret = sk;
@@ -346,7 +347,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	u32 tsoff = 0;
 	int l3index;
 
-	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies) ||
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
 		goto out;
 
@@ -355,24 +356,24 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	mss = __cookie_v4_check(ip_hdr(skb), th, cookie);
 	if (mss == 0) {
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
 	}
 
-	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
+	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
 
 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
+	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
-		tsoff = secure_tcp_ts_off(sock_net(sk),
+		tsoff = secure_tcp_ts_off(net,
 					  ip_hdr(skb)->daddr,
 					  ip_hdr(skb)->saddr);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
-	if (!cookie_timestamp_decode(sock_net(sk), &tcp_opt))
+	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
 	ret = NULL;
@@ -406,13 +407,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
 
-	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), ireq->ir_iif);
+	l3index = l3mdev_master_ifindex_by_index(net, ireq->ir_iif);
 	tcp_ao_syncookie(sk, skb, treq, AF_INET, l3index);
 
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
 	 */
-	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(sock_net(sk), skb));
+	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
 	if (security_inet_conn_request(sk, skb, req)) {
 		reqsk_free(req);
@@ -433,7 +434,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   opt->srr ? opt->faddr : ireq->ir_rmt_addr,
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
-	rt = ip_route_output_key(sock_net(sk), &fl4);
+	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
 		reqsk_free(req);
 		goto out;
@@ -453,7 +454,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 				  dst_metric(&rt->dst, RTAX_INITRWND));
 
 	ireq->rcv_wscale  = rcv_wscale;
-	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, sock_net(sk), &rt->dst);
+	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, &rt->dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst, tsoff);
 	/* ip_queue_xmit() depends on our flow being setup
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index aa5fb5486cde..ba394fa73f41 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -133,6 +133,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	struct tcp_options_received tcp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
+	struct net *net = sock_net(sk);
 	struct tcp_request_sock *treq;
 	struct request_sock *req;
 	struct dst_entry *dst;
@@ -142,7 +143,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	u32 tsoff = 0;
 	int l3index;
 
-	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies) ||
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
 		goto out;
 
@@ -151,24 +152,24 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 
 	mss = __cookie_v6_check(ipv6_hdr(skb), th, cookie);
 	if (mss == 0) {
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
 	}
 
-	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
+	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
 
 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
+	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
-		tsoff = secure_tcpv6_ts_off(sock_net(sk),
+		tsoff = secure_tcpv6_ts_off(net,
 					    ipv6_hdr(skb)->daddr.s6_addr32,
 					    ipv6_hdr(skb)->saddr.s6_addr32);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
-	if (!cookie_timestamp_decode(sock_net(sk), &tcp_opt))
+	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
 	ret = NULL;
@@ -217,7 +218,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->ts_off = 0;
 	treq->txhash = net_tx_rndhash();
 
-	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), ireq->ir_iif);
+	l3index = l3mdev_master_ifindex_by_index(net, ireq->ir_iif);
 	tcp_ao_syncookie(sk, skb, treq, AF_INET6, l3index);
 
 	if (IS_ENABLED(CONFIG_SMC))
@@ -243,7 +244,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_uid = sk->sk_uid;
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
-		dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, final_p);
+		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
 		if (IS_ERR(dst))
 			goto out_free;
 	}
@@ -261,7 +262,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 				  dst_metric(dst, RTAX_INITRWND));
 
 	ireq->rcv_wscale = rcv_wscale;
-	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, sock_net(sk), dst);
+	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst, tsoff);
 out:
-- 
2.30.2


