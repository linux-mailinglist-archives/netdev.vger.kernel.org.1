Return-Path: <netdev+bounces-51967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E857FCCE0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C327B20B8E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247F1FDC;
	Wed, 29 Nov 2023 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ll7FVZeU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC6198D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701225011; x=1732761011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U64QdCan19nCLm4cBJmZwKQzU5fs0gtjxw9c9VSTyTg=;
  b=Ll7FVZeUyfmDcA9au5ESAtzvN7Ne8q0GYeNUpRP75x6Y/5QxRRxU34w0
   QMfeRYiCNwVlT2L+0J9lyWKKWcppCCDpU11hzJ77oDkTG6C8Zm1B79GP5
   i1Ozrrjg1UnVqb1glI6AQBG4l3N70Z532OJFfUbYdNxkRH4A7wV3MZ/uH
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="46926761"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:30:09 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id CB9EB69904;
	Wed, 29 Nov 2023 02:30:06 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:21595]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.6:2525] with esmtp (Farcaster)
 id bc97cf35-f53c-4754-91d2-e304d078dc31; Wed, 29 Nov 2023 02:30:05 +0000 (UTC)
X-Farcaster-Flow-ID: bc97cf35-f53c-4754-91d2-e304d078dc31
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 29 Nov 2023 02:30:04 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:30:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Eric
 Dumazet" <edumazert@google.com>
Subject: [PATCH v3 net-next 1/8] tcp: Clean up reverse xmas tree in cookie_v[46]_check().
Date: Tue, 28 Nov 2023 18:29:17 -0800
Message-ID: <20231129022924.96156-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will grow and cut the xmas tree in cookie_v[46]_check().
This patch cleans it up to make later patches tidy.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazert@google.com>
---
 net/ipv4/syncookies.c | 10 +++++-----
 net/ipv6/syncookies.c | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index d37282c06e3d..a0118ea76734 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -331,18 +331,18 @@ EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 {
 	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
+	const struct tcphdr *th = tcp_hdr(skb);
+	__u32 cookie = ntohl(th->ack_seq) - 1;
 	struct tcp_options_received tcp_opt;
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
-	struct tcp_sock *tp = tcp_sk(sk);
-	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
-	struct sock *ret = sk;
 	struct request_sock *req;
+	struct sock *ret = sk;
 	int full_space, mss;
+	struct flowi4 fl4;
 	struct rtable *rt;
 	__u8 rcv_wscale;
-	struct flowi4 fl4;
 	u32 tsoff = 0;
 	int l3index;
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 12eedc6ca2cc..aa5fb5486cde 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -127,17 +127,17 @@ EXPORT_SYMBOL_GPL(__cookie_v6_check);
 
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 {
+	const struct tcphdr *th = tcp_hdr(skb);
+	__u32 cookie = ntohl(th->ack_seq) - 1;
+	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct tcp_options_received tcp_opt;
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
-	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct tcp_sock *tp = tcp_sk(sk);
-	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
-	struct sock *ret = sk;
 	struct request_sock *req;
-	int full_space, mss;
 	struct dst_entry *dst;
+	struct sock *ret = sk;
+	int full_space, mss;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
 	int l3index;
-- 
2.30.2


