Return-Path: <netdev+bounces-58724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D029817EB3
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57441F244FB
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7315C4;
	Tue, 19 Dec 2023 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lSzLOvqr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31262B
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945185; x=1734481185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R+IdGrmzGGiJ8v6i789d2mNWPuaqyPhPID70EzLAnDE=;
  b=lSzLOvqrG74931fWcB/z8H05KCFo4keZOp3P3UXjG5bS8NjudejvDZxp
   6h0tv0DHC6H8NHjg3vScfcimcgsnv/Rz2KOdUtrrlFSGW0t7Prmk/PMej
   zaRA7ZQc3U6hRZA5ywwZOy9+3xbSZV/Itm/Gsf2E2PQhbHX/lZDzgxNhx
   0=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="626306343"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:19:42 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id 96C9FA05D3;
	Tue, 19 Dec 2023 00:19:40 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:41428]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.95:2525] with esmtp (Farcaster)
 id 54b1da52-b083-4978-ad70-565a924d5299; Tue, 19 Dec 2023 00:19:40 +0000 (UTC)
X-Farcaster-Flow-ID: 54b1da52-b083-4978-ad70-565a924d5299
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:19:39 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 19 Dec 2023 00:19:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 02/12] tcp: Rearrange tests in inet_bind2_bucket_(addr_match|match_addr_any)().
Date: Tue, 19 Dec 2023 09:18:23 +0900
Message-ID: <20231219001833.10122-3-kuniyu@amazon.com>
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

The protocol family tests in inet_bind2_bucket_addr_match() and
inet_bind2_bucket_match_addr_any() are ordered as follows.

  if (sk->sk_family != tb2->family)
  else if (sk->sk_family == AF_INET6)
  else

This patch rearranges them so that AF_INET6 socket is handled first
to make the following patch tidy, where tb2->family will be removed.

  if (sk->sk_family == AF_INET6)
  else if (tb2->family == AF_INET6)
  else

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_hashtables.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7e8dbc5cc317..896fcefc06c0 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -149,18 +149,17 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
 					 const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb2->family) {
-		if (sk->sk_family == AF_INET)
-			return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
-				tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
+	if (sk->sk_family == AF_INET6) {
+		if (tb2->family == AF_INET6)
+			return ipv6_addr_equal(&tb2->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
 
 		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
 			sk->sk_v6_rcv_saddr.s6_addr32[3] == tb2->rcv_saddr;
 	}
 
-	if (sk->sk_family == AF_INET6)
-		return ipv6_addr_equal(&tb2->v6_rcv_saddr,
-				       &sk->sk_v6_rcv_saddr);
+	if (tb2->family == AF_INET6)
+		return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
+			tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
 #endif
 	return tb2->rcv_saddr == sk->sk_rcv_saddr;
 }
@@ -836,17 +835,17 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 		return false;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb->family) {
-		if (sk->sk_family == AF_INET)
-			return ipv6_addr_any(&tb->v6_rcv_saddr) ||
-				ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
+	if (sk->sk_family == AF_INET6) {
+		if (tb->family == AF_INET6)
+			return ipv6_addr_any(&tb->v6_rcv_saddr);
 
 		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
 			tb->rcv_saddr == 0;
 	}
 
-	if (sk->sk_family == AF_INET6)
-		return ipv6_addr_any(&tb->v6_rcv_saddr);
+	if (tb->family == AF_INET6)
+		return ipv6_addr_any(&tb->v6_rcv_saddr) ||
+			ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
 #endif
 	return tb->rcv_saddr == 0;
 }
-- 
2.30.2


