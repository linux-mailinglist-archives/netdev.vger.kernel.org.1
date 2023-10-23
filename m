Return-Path: <netdev+bounces-43594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E69F7D3FCA
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2680B20C2E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82C21A07;
	Mon, 23 Oct 2023 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p7AhMwAa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66531219F4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:05:07 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9459100
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698087907; x=1729623907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEZsFLMr4d49tHAsDLwXOTmTJKo8XvUSJCzl/pLSNjE=;
  b=p7AhMwAauyocGeCoGiu/hv7ybg+SsvTFfuOxGtFoWTb1vNYIhzb2LKrr
   ZGd7LjzfVDJhWOJhnvwk3z49RnTwm6pdCBm1N8N1fdXq9fILXA9F/MkyE
   a5jFVkRkJFN46/YVT18kmMFXy2zv90kLIAV0+cUzXr68FrZQO0G3nNo04
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="371782338"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:05:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id B89DF40DBB;
	Mon, 23 Oct 2023 19:04:58 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:53646]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.249:2525] with esmtp (Farcaster)
 id 25a03b7e-74b7-480f-966d-f17627ab2e4b; Mon, 23 Oct 2023 19:04:58 +0000 (UTC)
X-Farcaster-Flow-ID: 25a03b7e-74b7-480f-966d-f17627ab2e4b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:04:46 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 23 Oct 2023 19:04:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/12] tcp: Save address type in inet_bind2_bucket.
Date: Mon, 23 Oct 2023 12:02:47 -0700
Message-ID: <20231023190255.39190-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231023190255.39190-1-kuniyu@amazon.com>
References: <20231023190255.39190-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.77.134]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

inet_bind2_bucket_addr_match() and inet_bind2_bucket_match_addr_any()
are called for each bhash2 bucket to check conflicts.  Thus, we call
ipv6_addr_any() and ipv6_addr_v4mapped() over and over during bind().

Let's avoid calling them by saving the address type in inet_bind2_bucket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet_hashtables.h |  1 +
 net/ipv4/inet_hashtables.c    | 29 +++++++++++++----------------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 171cc235d045..260e673ede22 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -96,6 +96,7 @@ struct inet_bind2_bucket {
 	int			l3mdev;
 	unsigned short		port;
 #if IS_ENABLED(CONFIG_IPV6)
+	unsigned short		addr_type;
 	struct in6_addr		v6_rcv_saddr;
 #define rcv_saddr		v6_rcv_saddr.s6_addr32[3]
 #else
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 58900565c6ed..129e4ab4042b 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -110,10 +110,14 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb,
 	tb->l3mdev    = l3mdev;
 	tb->port      = port;
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6)
+	BUILD_BUG_ON(USHRT_MAX < (IPV6_ADDR_ANY | IPV6_ADDR_MAPPED));
+	if (sk->sk_family == AF_INET6) {
+		tb->addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
 		tb->v6_rcv_saddr = sk->sk_v6_rcv_saddr;
-	else
+	} else {
+		tb->addr_type = IPV6_ADDR_MAPPED;
 		ipv6_addr_set_v4mapped(sk->sk_rcv_saddr, &tb->v6_rcv_saddr);
+	}
 #else
 	tb->rcv_saddr = sk->sk_rcv_saddr;
 #endif
@@ -153,7 +157,7 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
 	if (sk->sk_family == AF_INET6)
 		return ipv6_addr_equal(&tb2->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
 
-	if (!ipv6_addr_v4mapped(&tb2->v6_rcv_saddr))
+	if (tb2->addr_type != IPV6_ADDR_MAPPED)
 		return false;
 #endif
 	return tb2->rcv_saddr == sk->sk_rcv_saddr;
@@ -830,21 +834,14 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 		return false;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6) {
-		if (ipv6_addr_any(&tb->v6_rcv_saddr))
-			return true;
-
-		if (!ipv6_addr_v4mapped(&tb->v6_rcv_saddr))
-			return false;
-
-		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
-			tb->rcv_saddr == 0;
-	}
-
-	if (ipv6_addr_any(&tb->v6_rcv_saddr))
+	if (tb->addr_type == IPV6_ADDR_ANY)
 		return true;
 
-	if (!ipv6_addr_v4mapped(&tb->v6_rcv_saddr))
+	if (tb->addr_type != IPV6_ADDR_MAPPED)
+		return false;
+
+	if (sk->sk_family == AF_INET6 &&
+	    !ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
 		return false;
 #endif
 	return tb->rcv_saddr == 0;
-- 
2.30.2


