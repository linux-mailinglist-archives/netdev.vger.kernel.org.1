Return-Path: <netdev+bounces-81722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E264F88B440
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0FFC21A0D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED86D1C7;
	Mon, 25 Mar 2024 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K2PQttCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546C3DABE6
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390894; cv=none; b=tNSKj/axmJpOVOEtgIHUEvj97BvyHu17kDyOrmpihn5QW+tyNQsr5rolmE3akyvxu8wobi/G0+kcLKlkvyG6eDz6ghI0xyAdO3HMbG3JLU/TkKO/tfL7BeucbfocQgKqFaOVQsnXWTAiyNf8PCZAma0Trzxl8O2tvtUXpmxUu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390894; c=relaxed/simple;
	bh=NY0t+klVvqTZkIAAsks+PhtamoL73DVTpjMCH8ee0lQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIRZuXnlrvI2ffJwq+K8tFqaayKliH8vlJZSX+rW+SwLkv6MLNQIyWsF6+n3tvfCkQL/jmhst5ONEOLdztpzxpTrFm+8yuf7TMR2Z2nfdsLX3go8J9vRFWJ2vy6UbW5P/4obstyODwfGuenValrxDnU10DVGkM+u25Q4+Aym5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K2PQttCs; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711390893; x=1742926893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kC3F5PGjXjKCCI0+CSKQLOjTivUEeC1MTWT6pTQkjOg=;
  b=K2PQttCsHbMYPdjvjgMCl2N4gX5r56KhuXJiBHhCRo0L5S8h4uktzLyj
   GLyY74DN8aQK/AqzBNyUXJowAVz8+h4iCnJ7ph/q2OyMXy4olxncUhFuL
   kJ8TNcRa8mfJE+4GchZ12aikBJWKH166XBUonHufD100NqW2NoeVjfeLL
   w=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708387200"; 
   d="scan'208";a="622227489"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:21:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:9701]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.88:2525] with esmtp (Farcaster)
 id d1c32b11-ca78-4d90-815e-9a972ae578f5; Mon, 25 Mar 2024 18:21:27 +0000 (UTC)
X-Farcaster-Flow-ID: d1c32b11-ca78-4d90-815e-9a972ae578f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:21:27 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:21:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 4/8] selftest: tcp: Define the reverse order bind() tests explicitly.
Date: Mon, 25 Mar 2024 11:19:19 -0700
Message-ID: <20240325181923.48769-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
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


