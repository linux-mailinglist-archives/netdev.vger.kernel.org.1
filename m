Return-Path: <netdev+bounces-82255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8888CF4E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C882B21C9C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4907173B;
	Tue, 26 Mar 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nkiAOtYC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BAB23CB
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485894; cv=none; b=gbrjgWJtTDFxmbWCKvjaz6IB1NAcV1n7rW3VCHDoE8cQstAsG0KINL6yDbly2vnWyUtflftxLplAn2o0ZSmDf9uUdMWlX8stjliUZNl3lbsXrsrd7DznK4h1Cq5D9RIfk42HKH6AJ1C6tq4RVxd8vUbUoYraqz+tHGIIV27DMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485894; c=relaxed/simple;
	bh=NY0t+klVvqTZkIAAsks+PhtamoL73DVTpjMCH8ee0lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQoZvH6cHK9w0ndQ+uAAPLxulgi8y1dpDwGuV4gVvN+BX0DwBGn6XFNbK5U38WnC157PSDUpdOnsAZqRmpD2OlQlAhciXb1mYkcjQvRaRtzycMINhrh3BrPaQUrh7d5TXPant/RMyfpjZf/t5uUXCHKPTqVkgkBDddxt4840RJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nkiAOtYC; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711485894; x=1743021894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kC3F5PGjXjKCCI0+CSKQLOjTivUEeC1MTWT6pTQkjOg=;
  b=nkiAOtYCrZKazsOmpCAMOg3K3NgpvkVarEYUZ5/PZOsuEhpjZQUX6Wdb
   4PoBUKwDryLXuQuLY0XtDv6nrPgH1QhDySEpZKqC8EyfMZLNGqXvoO5Sw
   5BCd51eyggRhWXkxJJrpqmIa145j6KgK29ndbTpQUsxTEfW+/L15aT7u8
   E=;
X-IronPort-AV: E=Sophos;i="6.07,157,1708387200"; 
   d="scan'208";a="194567645"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:44:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:1712]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.85:2525] with esmtp (Farcaster)
 id 44b5d267-f51d-4a68-85ff-6f614850e75d; Tue, 26 Mar 2024 20:44:49 +0000 (UTC)
X-Farcaster-Flow-ID: 44b5d267-f51d-4a68-85ff-6f614850e75d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:44:46 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:44:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 4/8] selftest: tcp: Define the reverse order bind() tests explicitly.
Date: Tue, 26 Mar 2024 13:42:47 -0700
Message-ID: <20240326204251.51301-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, bind_wildcard.c calls bind() twice for two addresses and
checks the pre-defined errno against the 2nd call.  Also, the two
bind() calls are swapped to cover various patterns how bind buckets
are created.

However, only testing two addresses is insufficient to detect regression.
So, we will add more bind() calls, and then, we need to define different
errno for each bind() per test case.

As a prepartion, let's define the reverse order bind() test cases as
fixtures.

No functional changes are intended.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 67 ++++++++++++++++++---
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index d65c3bb6ba13..143aae383da3 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -42,6 +42,7 @@ FIXTURE_VARIANT(bind_wildcard)
 	int expected_errno;
 };
 
+/* (IPv4, IPv6) */
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any)
 {
 	.family = {AF_INET, AF_INET6},
@@ -98,6 +99,63 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_local)
 	.expected_errno = EADDRINUSE,
 };
 
+/* (IPv6, IPv4) */
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_any)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_any, &in4addr_any},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_local)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_any, &in4addr_loopback},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_any)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_loopback, &in4addr_any},
+	.expected_errno = 0,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_local)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_loopback, &in4addr_loopback},
+	.expected_errno = 0,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v4_any)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_v4mapped_any, &in4addr_any},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v4_local)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_v4mapped_any, &in4addr_loopback},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_any)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_v4mapped_loopback, &in4addr_any},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_local)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_v4mapped_loopback, &in4addr_loopback},
+	.expected_errno = EADDRINUSE,
+};
+
 static void setup_addr(FIXTURE_DATA(bind_wildcard) *self, int i,
 		       int family, const void *addr_const)
 {
@@ -167,18 +225,11 @@ void bind_sockets(struct __test_metadata *_metadata,
 	close(fd[0]);
 }
 
-TEST_F(bind_wildcard, v4_v6)
+TEST_F(bind_wildcard, plain)
 {
 	bind_sockets(_metadata, self, variant->expected_errno,
 		     &self->addr[0].addr, self->addrlen[0],
 		     &self->addr[1].addr, self->addrlen[1]);
 }
 
-TEST_F(bind_wildcard, v6_v4)
-{
-	bind_sockets(_metadata, self, variant->expected_errno,
-		     &self->addr[1].addr, self->addrlen[1],
-		     &self->addr[0].addr, self->addrlen[0]);
-}
-
 TEST_HARNESS_MAIN
-- 
2.30.2


