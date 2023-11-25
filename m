Return-Path: <netdev+bounces-50993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37A7F876F
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 02:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF7AB213DB
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AB7F9;
	Sat, 25 Nov 2023 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VszCNgpy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0733E19A6
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 17:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700875043; x=1732411043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+F57LN0egy69m354rHOxZPavHdan/FVsjBOr35/608=;
  b=VszCNgpyBRLeAfLBnxRpo7g2XjRu0uA6V9BPMTnXcQkZpJuER0vp+cLT
   L8tR42s9XPI6+TeyuoZmVVVWuMgrnNCaGKu3FLdK3GE+DnyklXDCZbTZD
   UYyk1Sd/57WkPLtlpNi21PTTjy8yalTWftOplOMKDTT72fdCyFv7mBfIa
   0=;
X-IronPort-AV: E=Sophos;i="6.04,224,1695686400"; 
   d="scan'208";a="364820858"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 01:17:22 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id A1F8B4802B;
	Sat, 25 Nov 2023 01:17:19 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:10435]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id fd459c0f-db2f-4b6d-a82d-e9eec59fd7f2; Sat, 25 Nov 2023 01:17:19 +0000 (UTC)
X-Farcaster-Flow-ID: fd459c0f-db2f-4b6d-a82d-e9eec59fd7f2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 25 Nov 2023 01:17:18 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 25 Nov 2023 01:17:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/8] tcp: Clean up reverse xmas tree in cookie_v[46]_check().
Date: Fri, 24 Nov 2023 17:16:31 -0800
Message-ID: <20231125011638.72056-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231125011638.72056-1-kuniyu@amazon.com>
References: <20231125011638.72056-1-kuniyu@amazon.com>
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

We will grow and cut the xmas tree in cookie_v[46]_check().
This patch cleans it up to make later patches tidy.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


