Return-Path: <netdev+bounces-81724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AE88AE90
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26BD1F38CC9
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288206EB5B;
	Mon, 25 Mar 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hj7XBloT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F841C290
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390943; cv=none; b=TuWe68/8ETexZQT7CaCJ3oTqW6ao10yOw9ScAxsORx3wUkQhKDlxeuSH4HduA9yG/EbFUOYoeERIopk7t+CcUiZf2d7dO/GpbQDC8fu6HUI1JTTvsSGM8/2x2Vbnhcu0whJOoNp0vuh+3v02o4OOwop751NuDjt8OSpztG9F9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390943; c=relaxed/simple;
	bh=zjdXEFrJd5mPDecDwBfuZYMZ7W0CeaOmjzLKkbUy9Zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIYa+tq9WJ0ePtlFBWwBGXs3jurixve1cRz0tiyJJjJhG4Gno3Ue1zvuDSXEJgHci3SS/dqGCqjFSXZ+lcCo9uqmshF5zknuqcCFcsd/Cyt26HlhDB/QlLVKVeJpbcLCL9Ln1pwspG9avXnA/M57V4df5fzIwIfLTllGpXIuYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Hj7XBloT; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711390941; x=1742926941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5wzkI+8sA095MOzJ+c1f/yL0/8VMeMZw+UpsV/RXrCQ=;
  b=Hj7XBloTfvpmDas2fyjCZmpMP0cqjY/iwTqENQ//A+gf2oFzmVTsgFnj
   oxyx7buccobfhTlEDAZGZzo4ObiUPI9+6xeB1ZeFcST58t4nY0YqRo/22
   MNR0S+I9fqAzsdN0zP7ow6r2rWjTt0ObwjQU3kiW19/358o6qyR+ZAtiY
   M=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708387200"; 
   d="scan'208";a="390385225"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:22:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:2232]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.10:2525] with esmtp (Farcaster)
 id b69f516e-ffc5-4037-9a23-7ea561909912; Mon, 25 Mar 2024 18:22:17 +0000 (UTC)
X-Farcaster-Flow-ID: b69f516e-ffc5-4037-9a23-7ea561909912
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:22:16 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:22:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 6/8] selftest: tcp: Add more bind() calls.
Date: Mon, 25 Mar 2024 11:19:21 -0700
Message-ID: <20240325181923.48769-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325181923.48769-1-kuniyu@amazon.com>
References: <20240325181923.48769-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In addtition to the two addresses defined in the fixtures, this patch
add 6 more bind calls():

  * 0.0.0.0
  * 127.0.0.1
  * ::
  * ::1
  * ::ffff:0.0.0.0
  * ::ffff:127.0.0.1

The first two per-fixture bind() calls control how inet_bind2_bucket
is created, and the rest 6 bind() calls cover as many conflicting
patterns as possible.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 225 +++++++++++++++-----
 1 file changed, 166 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index 5100dd713a49..4ecd3835f33c 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -25,21 +25,34 @@ static const struct in6_addr in6addr_v4mapped_loopback = {
 	}
 };
 
+#define NR_SOCKETS 8
+
 FIXTURE(bind_wildcard)
 {
-	socklen_t addrlen[2];
+	int fd[NR_SOCKETS];
+	socklen_t addrlen[NR_SOCKETS];
 	union {
 		struct sockaddr addr;
 		struct sockaddr_in addr4;
 		struct sockaddr_in6 addr6;
-	} addr[2];
+	} addr[NR_SOCKETS];
 };
 
 FIXTURE_VARIANT(bind_wildcard)
 {
 	sa_family_t family[2];
 	const void *addr[2];
-	int expected_errno;
+
+	/* 6 bind() calls below follow two bind() for the defined 2 addresses:
+	 *
+	 *   0.0.0.0
+	 *   127.0.0.1
+	 *   ::
+	 *   ::1
+	 *   ::ffff:0.0.0.0
+	 *   ::ffff:127.0.0.1
+	 */
+	int expected_errno[NR_SOCKETS];
 };
 
 /* (IPv4, IPv4) */
@@ -47,14 +60,20 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v4_local)
 {
 	.family = {AF_INET, AF_INET},
 	.addr = {&in4addr_any, &in4addr_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v4_any)
 {
 	.family = {AF_INET, AF_INET},
 	.addr = {&in4addr_loopback, &in4addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 /* (IPv4, IPv6) */
@@ -62,56 +81,80 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any)
 {
 	.family = {AF_INET, AF_INET6},
 	.addr = {&in4addr_any, &in6addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_local)
 {
 	.family = {AF_INET, AF_INET6},
 	.addr = {&in4addr_any, &in6addr_loopback},
-	.expected_errno = 0,
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_any)
 {
 	.family = {AF_INET, AF_INET6},
 	.addr = {&in4addr_any, &in6addr_v4mapped_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_local)
 {
 	.family = {AF_INET, AF_INET6},
 	.addr = {&in4addr_any, &in6addr_v4mapped_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any)
 {
 	.family = {AF_INET, AF_INET6},
 	.addr = {&in4addr_loopback, &in6addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_local)
 {
 	.family = {AF_INET, AF_INET6},
 	.addr = {&in4addr_loopback, &in6addr_loopback},
-	.expected_errno = 0,
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_any)
 {
 	.family = {AF_INET, AF_INET6},
 	.addr = {&in4addr_loopback, &in6addr_v4mapped_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_local)
 {
 	.family = {AF_INET, AF_INET6},
 	.addr = {&in4addr_loopback, &in6addr_v4mapped_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 /* (IPv6, IPv4) */
@@ -119,56 +162,80 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_any)
 {
 	.family = {AF_INET6, AF_INET},
 	.addr = {&in6addr_any, &in4addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_local)
 {
 	.family = {AF_INET6, AF_INET},
 	.addr = {&in6addr_any, &in4addr_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_any)
 {
 	.family = {AF_INET6, AF_INET},
 	.addr = {&in6addr_loopback, &in4addr_any},
-	.expected_errno = 0,
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_local)
 {
 	.family = {AF_INET6, AF_INET},
 	.addr = {&in6addr_loopback, &in4addr_loopback},
-	.expected_errno = 0,
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v4_any)
 {
 	.family = {AF_INET6, AF_INET},
 	.addr = {&in6addr_v4mapped_any, &in4addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v4_local)
 {
 	.family = {AF_INET6, AF_INET},
 	.addr = {&in6addr_v4mapped_any, &in4addr_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_any)
 {
 	.family = {AF_INET6, AF_INET},
 	.addr = {&in6addr_v4mapped_loopback, &in4addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_local)
 {
 	.family = {AF_INET6, AF_INET},
 	.addr = {&in6addr_v4mapped_loopback, &in4addr_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 /* (IPv6, IPv6) */
@@ -176,84 +243,120 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_local)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_any, &in6addr_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_any)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_any, &in6addr_v4mapped_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_local)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_any, &in6addr_v4mapped_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_loopback, &in6addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_any)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_loopback, &in6addr_v4mapped_any},
-	.expected_errno = 0,
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_local)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_loopback, &in6addr_v4mapped_loopback},
-	.expected_errno = 0,
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_any)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_v4mapped_any, &in6addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_local)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_v4mapped_any, &in6addr_loopback},
-	.expected_errno = 0,
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_v4mapped_local)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_v4mapped_any, &in6addr_v4mapped_loopback},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_any)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_v4mapped_loopback, &in6addr_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_local)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_v4mapped_loopback, &in6addr_loopback},
-	.expected_errno = 0,
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_v4mapped_any)
 {
 	.family = {AF_INET6, AF_INET6},
 	.addr = {&in6addr_v4mapped_loopback, &in6addr_v4mapped_any},
-	.expected_errno = EADDRINUSE,
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, 0,
+			   EADDRINUSE, EADDRINUSE},
 };
 
 static void setup_addr(FIXTURE_DATA(bind_wildcard) *self, int i,
@@ -284,52 +387,56 @@ FIXTURE_SETUP(bind_wildcard)
 {
 	setup_addr(self, 0, variant->family[0], variant->addr[0]);
 	setup_addr(self, 1, variant->family[1], variant->addr[1]);
+
+	setup_addr(self, 2, AF_INET, &in4addr_any);
+	setup_addr(self, 3, AF_INET, &in4addr_loopback);
+
+	setup_addr(self, 4, AF_INET6, &in6addr_any);
+	setup_addr(self, 5, AF_INET6, &in6addr_loopback);
+	setup_addr(self, 6, AF_INET6, &in6addr_v4mapped_any);
+	setup_addr(self, 7, AF_INET6, &in6addr_v4mapped_loopback);
 }
 
 FIXTURE_TEARDOWN(bind_wildcard)
 {
+	int i;
+
+	for (i = 0; i < NR_SOCKETS; i++)
+		close(self->fd[i]);
 }
 
-void bind_sockets(struct __test_metadata *_metadata,
-		  FIXTURE_DATA(bind_wildcard) *self,
-		  int expected_errno,
-		  struct sockaddr *addr1, socklen_t addrlen1,
-		  struct sockaddr *addr2, socklen_t addrlen2)
+void bind_socket(struct __test_metadata *_metadata,
+		 FIXTURE_DATA(bind_wildcard) *self,
+		 const FIXTURE_VARIANT(bind_wildcard) *variant,
+		 int i)
 {
-	int fd[2];
 	int ret;
 
-	fd[0] = socket(addr1->sa_family, SOCK_STREAM, 0);
-	ASSERT_GT(fd[0], 0);
-
-	ret = bind(fd[0], addr1, addrlen1);
-	ASSERT_EQ(ret, 0);
+	self->fd[i] = socket(self->addr[i].addr.sa_family, SOCK_STREAM, 0);
+	ASSERT_GT(self->fd[i], 0);
 
-	ret = getsockname(fd[0], addr1, &addrlen1);
-	ASSERT_EQ(ret, 0);
+	self->addr[i].addr4.sin_port = self->addr[0].addr4.sin_port;
 
-	((struct sockaddr_in *)addr2)->sin_port = ((struct sockaddr_in *)addr1)->sin_port;
-
-	fd[1] = socket(addr2->sa_family, SOCK_STREAM, 0);
-	ASSERT_GT(fd[1], 0);
-
-	ret = bind(fd[1], addr2, addrlen2);
-	if (expected_errno) {
+	ret = bind(self->fd[i], &self->addr[i].addr, self->addrlen[i]);
+	if (variant->expected_errno[i]) {
 		ASSERT_EQ(ret, -1);
-		ASSERT_EQ(errno, expected_errno);
+		ASSERT_EQ(errno, variant->expected_errno[i]);
 	} else {
 		ASSERT_EQ(ret, 0);
 	}
 
-	close(fd[1]);
-	close(fd[0]);
+	if (i == 0) {
+		ret = getsockname(self->fd[0], &self->addr[0].addr, &self->addrlen[0]);
+		ASSERT_EQ(ret, 0);
+	}
 }
 
 TEST_F(bind_wildcard, plain)
 {
-	bind_sockets(_metadata, self, variant->expected_errno,
-		     &self->addr[0].addr, self->addrlen[0],
-		     &self->addr[1].addr, self->addrlen[1]);
+	int i;
+
+	for (i = 0; i < NR_SOCKETS; i++)
+		bind_socket(_metadata, self, variant, i);
 }
 
 TEST_HARNESS_MAIN
-- 
2.30.2


