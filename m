Return-Path: <netdev+bounces-82260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC6188CF57
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2525E341244
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49A13D53F;
	Tue, 26 Mar 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eNLk6gTd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424873503
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485994; cv=none; b=qQ+98CN9WPTcx6kc0HyATmlzG/G0u+h8kHR51iJ/GQ/eMLRI5qqfo+x0/M51uuaHL1QvZLF3MKiZz1vo7xSc0nR2MvhTWJwkvzX/p+zuRXpx0rBhy8ga0tt0DAU3gqbTCvJv2kr3q3PMhLrioPnwwkAnn+cb9GYRbPy1cw9frd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485994; c=relaxed/simple;
	bh=3HzDbUDtg/Nta6JF6j8a0V8pzAMx7bEcCMm3N90TXdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUJC44ScRDKmjRf4g4paHulHwWhcfXyhhERA7dVSKlo85qf4RPL3K6fnbr9lG2gvLj2YT/mbpYsJYex0gnejoiBMF8N47jsR2Nhq3hCp/4TKPnVzxd1Sg12/gQL0O7nBGio4hNc1VzXXtjBvkEg5CiiRU0ERj6VbpGc3uzmboj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eNLk6gTd; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711485992; x=1743021992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o0pVgx0fra/mmJ8X8/uHiI2K3FttPMBIucfPEhMOx9Q=;
  b=eNLk6gTd4wdNDZ7YdPhRNvlMnnY7Rtd+ZtIfyXn3VDu1wU8fm+teThVP
   LbY1nD6eXQaP1e0JQ/43zDcNbybob8EhI37EoFvP+GH1aNLq5FYh+N/co
   8d/6Yj07DVT3A5SAdrvkYzvMWDXgFDDrR9AVMqyIfKBc282oWjKRpg9jr
   8=;
X-IronPort-AV: E=Sophos;i="6.07,157,1708387200"; 
   d="scan'208";a="647819772"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:46:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:3806]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.88:2525] with esmtp (Farcaster)
 id 53e3652b-b133-445d-a83f-c2c504789a00; Tue, 26 Mar 2024 20:46:28 +0000 (UTC)
X-Farcaster-Flow-ID: 53e3652b-b133-445d-a83f-c2c504789a00
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:46:27 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:46:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 8/8] selftest: tcp: Add bind() tests for SO_REUSEADDR/SO_REUSEPORT.
Date: Tue, 26 Mar 2024 13:42:51 -0700
Message-ID: <20240326204251.51301-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326204251.51301-1-kuniyu@amazon.com>
References: <20240326204251.51301-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This patch adds two tests using SO_REUSEADDR and SO_REUSEPORT and
defines errno for each test case.

SO_REUSEADDR/SO_REUSEPORT is set for the per-fixture two bind()
calls.

The notable pattern is the pair of v6only [::] and plain [::].
The two sockets are put into the same tb2, where per-bucket v6only
flag would be useless to detect bind() conflict.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 263 +++++++++++++++++++-
 1 file changed, 257 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index 6d7f02441b9d..b7b54d646b93 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -54,6 +54,7 @@ FIXTURE_VARIANT(bind_wildcard)
 	 *   ::ffff:127.0.0.1
 	 */
 	int expected_errno[NR_SOCKETS];
+	int expected_reuse_errno[NR_SOCKETS];
 };
 
 /* (IPv4, IPv4) */
@@ -65,6 +66,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v4_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v4_any)
@@ -75,6 +80,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v4_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 /* (IPv4, IPv6) */
@@ -86,6 +95,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any_only)
@@ -97,6 +110,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any_only)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_local)
@@ -107,6 +124,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_any)
@@ -117,6 +138,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_local)
@@ -127,6 +152,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any)
@@ -137,6 +166,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any_only)
@@ -148,6 +181,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any_only)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_local)
@@ -158,6 +195,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_any)
@@ -168,6 +209,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_local)
@@ -178,6 +223,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 /* (IPv6, IPv4) */
@@ -189,6 +238,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v4_any)
@@ -200,6 +253,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v4_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_local)
@@ -210,6 +267,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v4_local)
@@ -221,6 +282,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v4_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_any)
@@ -231,6 +296,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_local)
@@ -241,6 +310,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v4_any)
@@ -251,6 +324,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v4_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v4_local)
@@ -261,6 +338,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v4_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_any)
@@ -271,6 +352,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_local)
@@ -281,9 +366,72 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 /* (IPv6, IPv6) */
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_any},
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_any},
+	.ipv6_only = {true, false},
+	.expected_errno = {0, EADDRINUSE,
+			   0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_any_only)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_any},
+	.ipv6_only = {false, true},
+	.expected_errno = {0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_any_only)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_any},
+	.ipv6_only = {true, true},
+	.expected_errno = {0, EADDRINUSE,
+			   0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 0, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_local)
 {
 	.family = {AF_INET6, AF_INET6},
@@ -292,6 +440,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_local)
@@ -303,6 +455,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_local)
 			   0, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 0, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_any)
@@ -313,6 +469,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_v4mapped_any)
@@ -324,6 +484,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_v4mapped_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_local)
@@ -334,6 +498,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_v4mapped_local)
@@ -345,6 +513,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_v4mapped_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any)
@@ -355,6 +527,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any)
 			   0, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any_only)
@@ -366,6 +542,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any_only)
 			   0, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 0, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_any)
@@ -376,6 +556,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_local)
@@ -386,6 +570,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_any)
@@ -396,6 +584,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_any_only)
@@ -407,6 +599,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_any_only)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_local)
@@ -417,6 +613,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_v4mapped_local)
@@ -427,6 +627,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_v4mapped_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_any)
@@ -437,6 +641,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_any_only)
@@ -448,6 +656,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_any_only)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_local)
@@ -458,6 +670,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_local)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_v4mapped_any)
@@ -468,6 +684,10 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_v4mapped_any)
 			   EADDRINUSE, EADDRINUSE,
 			   EADDRINUSE, 0,
 			   EADDRINUSE, EADDRINUSE},
+	.expected_reuse_errno = {0, 0,
+				 EADDRINUSE, EADDRINUSE,
+				 EADDRINUSE, 0,
+				 EADDRINUSE, EADDRINUSE},
 };
 
 static void setup_addr(FIXTURE_DATA(bind_wildcard) *self, int i,
@@ -519,7 +739,7 @@ FIXTURE_TEARDOWN(bind_wildcard)
 void bind_socket(struct __test_metadata *_metadata,
 		 FIXTURE_DATA(bind_wildcard) *self,
 		 const FIXTURE_VARIANT(bind_wildcard) *variant,
-		 int i)
+		 int i, int reuse)
 {
 	int ret;
 
@@ -531,14 +751,29 @@ void bind_socket(struct __test_metadata *_metadata,
 		ASSERT_EQ(ret, 0);
 	}
 
+	if (i < 2 && reuse) {
+		ret = setsockopt(self->fd[i], SOL_SOCKET, reuse, &(int){1}, sizeof(int));
+		ASSERT_EQ(ret, 0);
+	}
+
 	self->addr[i].addr4.sin_port = self->addr[0].addr4.sin_port;
 
 	ret = bind(self->fd[i], &self->addr[i].addr, self->addrlen[i]);
-	if (variant->expected_errno[i]) {
-		ASSERT_EQ(ret, -1);
-		ASSERT_EQ(errno, variant->expected_errno[i]);
+
+	if (reuse) {
+		if (variant->expected_reuse_errno[i]) {
+			ASSERT_EQ(ret, -1);
+			ASSERT_EQ(errno, variant->expected_reuse_errno[i]);
+		} else {
+			ASSERT_EQ(ret, 0);
+		}
 	} else {
-		ASSERT_EQ(ret, 0);
+		if (variant->expected_errno[i]) {
+			ASSERT_EQ(ret, -1);
+			ASSERT_EQ(errno, variant->expected_errno[i]);
+		} else {
+			ASSERT_EQ(ret, 0);
+		}
 	}
 
 	if (i == 0) {
@@ -552,7 +787,23 @@ TEST_F(bind_wildcard, plain)
 	int i;
 
 	for (i = 0; i < NR_SOCKETS; i++)
-		bind_socket(_metadata, self, variant, i);
+		bind_socket(_metadata, self, variant, i, 0);
+}
+
+TEST_F(bind_wildcard, reuseaddr)
+{
+	int i;
+
+	for (i = 0; i < NR_SOCKETS; i++)
+		bind_socket(_metadata, self, variant, i, SO_REUSEADDR);
+}
+
+TEST_F(bind_wildcard, reuseport)
+{
+	int i;
+
+	for (i = 0; i < NR_SOCKETS; i++)
+		bind_socket(_metadata, self, variant, i, SO_REUSEPORT);
 }
 
 TEST_HARNESS_MAIN
-- 
2.30.2


