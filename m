Return-Path: <netdev+bounces-50320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058317F55D7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AB62811C8
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1B10E9;
	Thu, 23 Nov 2023 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q8/v3Xfk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECA10C
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700702766; x=1732238766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0Dzozr/kVc8IJh5icMBhMQjmf7I4hZmQKcdHxwevzc=;
  b=q8/v3Xfky0I3BfAQ09jjqyROD99pd6jcxT3gL37/lmaGQz90xb+oHJEY
   TuvFDC6UUeE8jgEDCGyAJbZoJj7anCd7eLji5JbMJEyw8is6TvtoK+lgC
   KthSLNkiXoLjlXDV7oB6j8ElpLwCyBNM1KJxu/QvYO7SCZ7xs1TnhOZx1
   I=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="314129585"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:25:59 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id A0F6D80492;
	Thu, 23 Nov 2023 01:25:57 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:18421]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id e0a64de1-b249-4856-96a7-adf70e4eafd6; Thu, 23 Nov 2023 01:25:57 +0000 (UTC)
X-Farcaster-Flow-ID: e0a64de1-b249-4856-96a7-adf70e4eafd6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:25:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Thu, 23 Nov 2023 01:25:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/8] tcp: Clean up reverse xmas tree in cookie_v[46]_check().
Date: Wed, 22 Nov 2023 17:25:14 -0800
Message-ID: <20231123012521.62841-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will grow and cut the xmas tree in cookie_v[46]_check().
This patch cleans it up to make later patches tidy.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


