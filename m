Return-Path: <netdev+bounces-58726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D0817EB5
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2A5B21562
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389907F;
	Tue, 19 Dec 2023 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MrAM30Fj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D70368
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945235; x=1734481235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/PtB2C/qVot9JUrMbt6wAeruRaF9okpfyKcSxn2750c=;
  b=MrAM30FjCclYhIrwTllWBKWPgCUxmhh7UdcTeo/txSdJg8Wfa2/4TIBk
   ca42MZSE1tWSfEqHiCgFq8hgvB0284VMri8mw/3cp5t1u9pMveIhrcKKs
   9/dk6lO12EgEWkahFUR9tiPN/kEsGv9nqomuaXlNvDo4Y7DEb314mPNmW
   E=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="374874788"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:20:34 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 0F6A540D3F;
	Tue, 19 Dec 2023 00:20:32 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:26260]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id f16ed79a-219a-49c6-826a-5932f400aa2c; Tue, 19 Dec 2023 00:20:32 +0000 (UTC)
X-Farcaster-Flow-ID: f16ed79a-219a-49c6-826a-5932f400aa2c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:20:32 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:20:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 04/12] tcp: Save address type in inet_bind2_bucket.
Date: Tue, 19 Dec 2023 09:18:25 +0900
Message-ID: <20231219001833.10122-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231219001833.10122-1-kuniyu@amazon.com>
References: <20231219001833.10122-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
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
index 15594424e9f5..4e39e3f905b4 100644
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


