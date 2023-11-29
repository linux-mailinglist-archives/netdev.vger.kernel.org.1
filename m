Return-Path: <netdev+bounces-51973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE07FCCEB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601DEB2144B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B273D7F;
	Wed, 29 Nov 2023 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u9rxID9D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9671735
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701225177; x=1732761177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gbTQejHgmtLtmlMEOZSbZEi7Xs8T0g3VAoeCK3S6KOs=;
  b=u9rxID9D+lE444T3nvQglmEzqPAwBqoB2J1CBzWeJOn6C09X2X/bclrn
   lcftgEFt7I4f6JMa0fTRgzbDzJaAgwxShIzuW6OY9TcbOUGWoKVgjSC/y
   3pmxkVSV2Mn8f6XIuSo4BAR6KILQ1BR6k5NfB0wKb+XjTd9tn7a9KGNn1
   o=;
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="47017287"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:32:55 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id 68AB180857;
	Wed, 29 Nov 2023 02:32:53 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:30647]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id 6f6213fb-0747-4321-b9c4-2bf10c70ffb7; Wed, 29 Nov 2023 02:32:52 +0000 (UTC)
X-Farcaster-Flow-ID: 6f6213fb-0747-4321-b9c4-2bf10c70ffb7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 29 Nov 2023 02:32:45 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:32:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Eric
 Dumazet" <edumazert@google.com>
Subject: [PATCH v3 net-next 7/8] tcp: Factorise cookie-independent fields initialisation in cookie_v[46]_check().
Date: Tue, 28 Nov 2023 18:29:23 -0800
Message-ID: <20231129022924.96156-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF, and then some reqsk fields
are initialised in kfunc, and others are done in cookie_v[46]_check().

This patch factorises the common part as cookie_tcp_reqsk_init() and
calls it in cookie_tcp_reqsk_alloc() to minimise the discrepancy between
cookie_v[46]_check().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazert@google.com>
---
 net/ipv4/syncookies.c | 68 +++++++++++++++++++++++--------------------
 net/ipv6/syncookies.c | 14 ---------
 2 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 1e3783c97e28..f4bcd4822fe0 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -285,10 +285,43 @@ bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
 }
 EXPORT_SYMBOL(cookie_ecn_ok);
 
+static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
+				 struct request_sock *req)
+{
+	struct inet_request_sock *ireq = inet_rsk(req);
+	struct tcp_request_sock *treq = tcp_rsk(req);
+	const struct tcphdr *th = tcp_hdr(skb);
+
+	req->num_retrans = 0;
+
+	ireq->ir_num = ntohs(th->dest);
+	ireq->ir_rmt_port = th->source;
+	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
+	ireq->ir_mark = inet_request_mark(sk, skb);
+
+	if (IS_ENABLED(CONFIG_SMC))
+		ireq->smc_ok = 0;
+
+	treq->snt_synack = 0;
+	treq->tfo_listener = false;
+	treq->txhash = net_tx_rndhash();
+	treq->rcv_isn = ntohl(th->seq) - 1;
+	treq->snt_isn = ntohl(th->ack_seq) - 1;
+	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
+	treq->req_usec_ts = false;
+
+#if IS_ENABLED(CONFIG_MPTCP)
+	treq->is_mptcp = sk_is_mptcp(sk);
+	if (treq->is_mptcp)
+		return mptcp_subflow_init_cookie_req(req, sk, skb);
+#endif
+
+	return 0;
+}
+
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct sock *sk, struct sk_buff *skb)
 {
-	struct tcp_request_sock *treq;
 	struct request_sock *req;
 
 	if (sk_is_mptcp(sk))
@@ -299,22 +332,10 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 	if (!req)
 		return NULL;
 
-	treq = tcp_rsk(req);
-
-	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
-	treq->req_usec_ts = false;
-
-#if IS_ENABLED(CONFIG_MPTCP)
-	treq->is_mptcp = sk_is_mptcp(sk);
-	if (treq->is_mptcp) {
-		int err = mptcp_subflow_init_cookie_req(req, sk, skb);
-
-		if (err) {
-			reqsk_free(req);
-			return NULL;
-		}
+	if (cookie_tcp_reqsk_init(sk, skb, req)) {
+		reqsk_free(req);
+		return NULL;
 	}
-#endif
 
 	return req;
 }
@@ -376,28 +397,15 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
-	treq->rcv_isn		= ntohl(th->seq) - 1;
-	treq->snt_isn		= ntohl(th->ack_seq) - 1;
 	treq->ts_off		= tsoff;
-	treq->txhash		= net_tx_rndhash();
 	req->mss		= mss;
-	ireq->ir_num		= ntohs(th->dest);
-	ireq->ir_rmt_port	= th->source;
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
-	ireq->ir_mark		= inet_request_mark(sk, skb);
 	ireq->snd_wscale	= tcp_opt.snd_wscale;
 	ireq->sack_ok		= tcp_opt.sack_ok;
 	ireq->wscale_ok		= tcp_opt.wscale_ok;
 	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
-	treq->snt_synack	= 0;
-	treq->tfo_listener	= false;
-
-	if (IS_ENABLED(CONFIG_SMC))
-		ireq->smc_ok = 0;
-
-	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
 
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
@@ -409,8 +417,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET);
 
-	req->num_retrans = 0;
-
 	/*
 	 * We need to lookup the route here to get at the correct
 	 * window size. We should better make sure that the window size
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 12b1809245f9..e0a9220d1536 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -178,11 +178,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
-	treq->tfo_listener = false;
 
 	req->mss = mss;
-	ireq->ir_rmt_port = th->source;
-	ireq->ir_num = ntohs(th->dest);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 
@@ -196,31 +193,20 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		ireq->pktopts = skb;
 	}
 
-	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
 	/* So that link locals have meaning */
 	if (!sk->sk_bound_dev_if &&
 	    ipv6_addr_type(&ireq->ir_v6_rmt_addr) & IPV6_ADDR_LINKLOCAL)
 		ireq->ir_iif = tcp_v6_iif(skb);
 
-	ireq->ir_mark = inet_request_mark(sk, skb);
-
-	req->num_retrans = 0;
 	ireq->snd_wscale	= tcp_opt.snd_wscale;
 	ireq->sack_ok		= tcp_opt.sack_ok;
 	ireq->wscale_ok		= tcp_opt.wscale_ok;
 	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
-	treq->snt_synack	= 0;
-	treq->rcv_isn = ntohl(th->seq) - 1;
-	treq->snt_isn = ntohl(th->ack_seq) - 1;
 	treq->ts_off = tsoff;
-	treq->txhash = net_tx_rndhash();
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET6);
 
-	if (IS_ENABLED(CONFIG_SMC))
-		ireq->smc_ok = 0;
-
 	/*
 	 * We need to lookup the dst_entry to get the correct window size.
 	 * This is taken from tcp_v6_syn_recv_sock.  Somebody please enlighten
-- 
2.30.2


