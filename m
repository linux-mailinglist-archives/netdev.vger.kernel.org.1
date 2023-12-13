Return-Path: <netdev+bounces-56755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7884810C44
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514E71F21175
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE821D694;
	Wed, 13 Dec 2023 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gczyQIty"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084038E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455677; x=1733991677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXDzR6fak07PAmdpZ5tVJz9lpFD0gbO7Exk2RwUrelE=;
  b=gczyQItykXKRpDFX6A/Z8eSSHQtcuSAnL0wbgBS9eyuNFMzxNpycmvK0
   /1m3Vfh7lkwXfo3M/XhLPT1a0An4PhHGdCsMDeJXJKduNMBTrQRfzshPP
   w6ApBjNT9ayjMqVnfTkCYQDbJLuYZUT68ixMc150EwdYr/MBRWwXjMkUL
   U=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="373475299"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:21:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 618E460C2C;
	Wed, 13 Dec 2023 08:21:13 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:36359]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 6d9ec48c-bda3-46af-a104-5bb9ed321c54; Wed, 13 Dec 2023 08:21:12 +0000 (UTC)
X-Farcaster-Flow-ID: 6d9ec48c-bda3-46af-a104-5bb9ed321c54
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:21:12 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:21:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/12] tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.
Date: Wed, 13 Dec 2023 17:20:18 +0900
Message-ID: <20231213082029.35149-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
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
---
 net/ipv4/inet_connection_sock.c | 7 +++++--
 net/ipv4/inet_hashtables.c      | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 70be0f6fe879..e61be2865a39 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -148,8 +148,11 @@ static bool inet_use_bhash2_on_bind(const struct sock *sk)
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
index a532f749e477..8fb58ee32a25 100644
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


