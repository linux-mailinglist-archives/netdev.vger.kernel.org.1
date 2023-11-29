Return-Path: <netdev+bounces-51968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A47FCCE3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9BC2824F0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF580A;
	Wed, 29 Nov 2023 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e0imuRaI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74C1988
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701225038; x=1732761038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WzpLo3zMlqEePuoT8T2oa33TUAMsbOHuNDJWGFj9mUQ=;
  b=e0imuRaIctQJWKO4YaPi1ipTiEyghVrLi1XjkBXs8hZJrRQeAfjR8A9a
   aGKndHbQthreVbgqZJjsNjlwLG/37MhVwuh3U1vP1EaBjDwsH6u5u+iom
   pIkLZ3XsxbQGkDT65paHWM1OQ+0vYqcOUMDzR6XKwOR0kBwTZ64cEQB+b
   E=;
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="255525511"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:30:36 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id CC38381D08;
	Wed, 29 Nov 2023 02:30:32 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:63649]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.133:2525] with esmtp (Farcaster)
 id 49c63cdf-ef37-4971-8a00-fab660c362e2; Wed, 29 Nov 2023 02:30:32 +0000 (UTC)
X-Farcaster-Flow-ID: 49c63cdf-ef37-4971-8a00-fab660c362e2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 29 Nov 2023 02:30:31 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:30:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Eric
 Dumazet" <edumazert@google.com>
Subject: [PATCH v3 net-next 2/8] tcp: Cache sock_net(sk) in cookie_v[46]_check().
Date: Tue, 28 Nov 2023 18:29:18 -0800
Message-ID: <20231129022924.96156-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231129022924.96156-1-kuniyu@amazon.com>
References: <20231129022924.96156-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

sock_net(sk) is used repeatedly in cookie_v[46]_check().
Let's cache it in a variable.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazert@google.com>
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


