Return-Path: <netdev+bounces-50324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB27F55E0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E6E1C20B7D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB81382;
	Thu, 23 Nov 2023 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DBonZYRR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649FD10C
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700702861; x=1732238861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTXVYsjHlXxS4ygF6uxrwNsUA9p+2KM2DEkM38vXuYc=;
  b=DBonZYRR/+C4l82sjY+83nmDKPOLLlDfHB0KHobYVmjY4zgEX5Di+MA6
   9UKfrtN/p+EjAa+U0Nz6auO/4lJv9m9p1RCSbSY3offwKQgIamfDgdImc
   ZP3hhgGGd5b45tLEdVwaZx8H7Qu3TO9v6tNpkY+mYvD0N9Gz6sXrxQQE5
   g=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="685939780"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:27:35 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id 95701943B3;
	Thu, 23 Nov 2023 01:27:32 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:62389]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.176:2525] with esmtp (Farcaster)
 id 36927f5b-4000-43b3-a7ae-0490f1847519; Thu, 23 Nov 2023 01:27:31 +0000 (UTC)
X-Farcaster-Flow-ID: 36927f5b-4000-43b3-a7ae-0490f1847519
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:27:31 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Thu, 23 Nov 2023 01:27:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/8] tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
Date: Wed, 22 Nov 2023 17:25:18 -0800
Message-ID: <20231123012521.62841-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

When we create a full socket from SYN Cookie, we initialise
tcp_sk(sk)->tsoffset redundantly in tcp_get_cookie_sock() as
the field is inherited from tcp_rsk(req)->ts_off.

  cookie_v[46]_check
  |- treq->ts_off = 0
  `- tcp_get_cookie_sock
     |- tcp_v[46]_syn_recv_sock
     |  `- tcp_create_openreq_child
     |	   `- newtp->tsoffset = treq->ts_off
     `- tcp_sk(child)->tsoffset = tsoff

Let's initialise tcp_rsk(req)->ts_off with the correct offset
and remove the second initialisation of tcp_sk(sk)->tsoffset.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/syncookies.c | 7 +++----
 net/ipv6/syncookies.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2b2c79c7bbcd..cc7143a781da 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -490,7 +490,7 @@ void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb);
 /* From syncookies.c */
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
-				 struct dst_entry *dst, u32 tsoff);
+				 struct dst_entry *dst);
 int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index c08428d63d11..de051eb08db8 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -204,7 +204,7 @@ EXPORT_SYMBOL_GPL(__cookie_v4_check);
 
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
-				 struct dst_entry *dst, u32 tsoff)
+				 struct dst_entry *dst)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct sock *child;
@@ -214,7 +214,6 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 						 NULL, &own_req);
 	if (child) {
 		refcount_set(&req->rsk_refcnt, 1);
-		tcp_sk(child)->tsoffset = tsoff;
 		sock_rps_save_rxhash(child, skb);
 
 		if (rsk_drop_req(req)) {
@@ -386,7 +385,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	treq = tcp_rsk(req);
 	treq->rcv_isn		= ntohl(th->seq) - 1;
 	treq->snt_isn		= ntohl(th->ack_seq) - 1;
-	treq->ts_off		= 0;
+	treq->ts_off		= tsoff;
 	treq->txhash		= net_tx_rndhash();
 	req->mss		= mss;
 	ireq->ir_num		= ntohs(th->dest);
@@ -452,7 +451,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	ireq->rcv_wscale  = rcv_wscale;
 	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, &rt->dst);
 
-	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst, tsoff);
+	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4cd26c481168..18c2e3c1677b 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -215,7 +215,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->snt_synack	= 0;
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
-	treq->ts_off = 0;
+	treq->ts_off = tsoff;
 	treq->txhash = net_tx_rndhash();
 
 	l3index = l3mdev_master_ifindex_by_index(net, ireq->ir_iif);
@@ -264,7 +264,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, dst);
 
-	ret = tcp_get_cookie_sock(sk, skb, req, dst, tsoff);
+	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 out:
 	return ret;
 out_free:
-- 
2.30.2


