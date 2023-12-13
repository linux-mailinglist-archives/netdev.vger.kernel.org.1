Return-Path: <netdev+bounces-56758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4F810C47
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DF11F21135
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E004D1D6A5;
	Wed, 13 Dec 2023 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l0XBdzOu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE68E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455758; x=1733991758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aOB8LqG+saSlVcOcndxJa0rEUG9tH1axboCV9PadrMw=;
  b=l0XBdzOuDfnw3mvwgA2xHeERHzALDR6iWFh1FmDlebWywVhJEZnYIoUz
   tqNiGkI9Ibf2zcM/iGO/39WRayVM5AD4kY9e67po/GJC1uaNoRhW3f6SV
   InbnGqSIdwCS2qaywk9ryijzLjYCLqOVeC5bg7OiAtjYUdeeIVqzbMDas
   s=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="600300196"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:22:36 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 0EB9B8062E;
	Wed, 13 Dec 2023 08:22:33 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:30589]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id abf26d4f-e14a-4911-9be9-55f4d79781f6; Wed, 13 Dec 2023 08:22:33 +0000 (UTC)
X-Farcaster-Flow-ID: abf26d4f-e14a-4911-9be9-55f4d79781f6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:22:32 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:22:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 04/12] tcp: Save address type in inet_bind2_bucket.
Date: Wed, 13 Dec 2023 17:20:21 +0900
Message-ID: <20231213082029.35149-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231213082029.35149-1-kuniyu@amazon.com>
References: <20231213082029.35149-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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
index 80d7c8f92d77..465469de19bf 100644
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


