Return-Path: <netdev+bounces-58721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866F817EAC
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0631C225FC
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB0188;
	Tue, 19 Dec 2023 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GZ3tM4GV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA157F
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945156; x=1734481156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Do7IlZ3HwEHBhSMoyNA18+87H0lCGEUjPjoOtNh6ww=;
  b=GZ3tM4GVJZ/btCidQqACtSR1hGj3hEFakVdwuCf05xNp09rj3WdLKTwy
   Kieu95kRNyXw0be5hp1RYKb4HlsY9OndltNlYjpXwvoOAnfCv+twkSS2u
   iHYbmE68qSzezDUg9JrCJdXN9wBKc8iPaW3UwScS6fuDYzLQw3oACnqJq
   8=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="52179098"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:19:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 15A1340D6A;
	Tue, 19 Dec 2023 00:19:14 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:48759]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id ec16c1f3-634f-498e-8581-ac4d6b22e229; Tue, 19 Dec 2023 00:19:13 +0000 (UTC)
X-Farcaster-Flow-ID: ec16c1f3-634f-498e-8581-ac4d6b22e229
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:19:13 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 19 Dec 2023 00:19:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 01/12] tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.
Date: Tue, 19 Dec 2023 09:18:22 +0900
Message-ID: <20231219001833.10122-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

While checking port availability in bind() or listen(), we used only
bhash for all v4-mapped-v6 addresses.  But there is no good reason not
to use bhash2 for v4-mapped-v6 non-wildcard addresses.

Let's do it by returning true in inet_use_bhash2_on_bind().  Then, we
also need to add a test in inet_bind2_bucket_match_addr_any() so that
::ffff:X.X.X.X will match with 0.0.0.0.

Note that sk->sk_rcv_saddr is initialised for v4-mapped-v6 sk in
__inet6_bind().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 7 +++++--
 net/ipv4/inet_hashtables.c      | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index bd325b029dd1..d48255875f60 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -159,8 +159,11 @@ static bool inet_use_bhash2_on_bind(const struct sock *sk)
 	if (sk->sk_family == AF_INET6) {
 		int addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
 
-		return addr_type != IPV6_ADDR_ANY &&
-			addr_type != IPV6_ADDR_MAPPED;
+		if (addr_type == IPV6_ADDR_ANY)
+			return false;
+
+		if (addr_type != IPV6_ADDR_MAPPED)
+			return true;
 	}
 #endif
 	return sk->sk_rcv_saddr != htonl(INADDR_ANY);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9ff201bc4e6d..7e8dbc5cc317 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -841,7 +841,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 			return ipv6_addr_any(&tb->v6_rcv_saddr) ||
 				ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
 
-		return false;
+		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
+			tb->rcv_saddr == 0;
 	}
 
 	if (sk->sk_family == AF_INET6)
-- 
2.30.2


