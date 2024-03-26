Return-Path: <netdev+bounces-82256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53F588CF48
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326472865F6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE75BAC1;
	Tue, 26 Mar 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gVTDldcZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488217591
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485917; cv=none; b=c/9Bbc7dArWbnUM/Bl63QyfA7lecVtNFIIYRRzpiZQP13G41XjOMftzP1fIaDcjKBYDyRgn7C9QKQBmwWbrv4xpkKZ6zMU/9c4OLOw5szdS3KLl4bmwflEnA5jxDXGRBQmEN50nLFOXbO1D2GgEKyaQO8aXbHAuhL4jPHE4/BTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485917; c=relaxed/simple;
	bh=RkRd6Y1RDEYuQEERJGFc2/hlLd1t8C+QoB33wplAkgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtJDojViLg/Xtv9PaVrZIsDGNDNFIKbc8SS1iaTTEoeQVZ/5OxbZhD6w2f6DKAX3uUac/7DXu+gao+f13SDSb83Z12aOPKMVxnSLbOawv6Ed2USQ8RaDP5YgZVCOyUAUXzbxZzm2X4i67PTK2wuh3C9HwYy2gREwg0zeJ+IoJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gVTDldcZ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711485916; x=1743021916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ntvH6fPtmbdFNbIsvQYQ8TjXFUeXDa3bnJVDwfL2EtI=;
  b=gVTDldcZBLcFx7zCM/XYuKOcZW8lISwy0tHtIbfozxh0dDPeDLhV0tWq
   CIMNZ74A4qdNqr9FIgujkfn3kmqX+Fhk6dDxU6ZrYsgGpnEfxjIyDLrEL
   UPkJqO0/eCXe/9VzSIS/9xqUdyOW49ZAuSawvRgriEmRxJTldr4kz/MAL
   o=;
X-IronPort-AV: E=Sophos;i="6.07,157,1708387200"; 
   d="scan'208";a="622567292"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:45:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:50782]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.10:2525] with esmtp (Farcaster)
 id 5a60ebf1-8cc2-4314-8c6f-25d22732bffc; Tue, 26 Mar 2024 20:45:12 +0000 (UTC)
X-Farcaster-Flow-ID: 5a60ebf1-8cc2-4314-8c6f-25d22732bffc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:45:12 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:45:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 5/8] selftest: tcp: Add v4-v4 and v6-v6 bind() conflict tests.
Date: Tue, 26 Mar 2024 13:42:48 -0700
Message-ID: <20240326204251.51301-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We don't have bind() conflict tests for the same protocol pairs.

Let's add them except for the same address pair, which will be
covered by the following patch adding 6 more bind() calls for
each test case.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 100 ++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index 143aae383da3..5100dd713a49 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -42,6 +42,21 @@ FIXTURE_VARIANT(bind_wildcard)
 	int expected_errno;
 };
 
+/* (IPv4, IPv4) */
+FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v4_local)
+{
+	.family = {AF_INET, AF_INET},
+	.addr = {&in4addr_any, &in4addr_loopback},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v4_any)
+{
+	.family = {AF_INET, AF_INET},
+	.addr = {&in4addr_loopback, &in4addr_any},
+	.expected_errno = EADDRINUSE,
+};
+
 /* (IPv4, IPv6) */
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any)
 {
@@ -156,6 +171,91 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_local_v4_local)
 	.expected_errno = EADDRINUSE,
 };
 
+/* (IPv6, IPv6) */
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_local)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_loopback},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_v4mapped_any},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_local)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_v4mapped_loopback},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_loopback, &in6addr_any},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_loopback, &in6addr_v4mapped_any},
+	.expected_errno = 0,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_local)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_loopback, &in6addr_v4mapped_loopback},
+	.expected_errno = 0,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_v4mapped_any, &in6addr_any},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_local)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_v4mapped_any, &in6addr_loopback},
+	.expected_errno = 0,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_v4mapped_local)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_v4mapped_any, &in6addr_v4mapped_loopback},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_v4mapped_loopback, &in6addr_any},
+	.expected_errno = EADDRINUSE,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_local)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_v4mapped_loopback, &in6addr_loopback},
+	.expected_errno = 0,
+};
+
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_v4mapped_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_v4mapped_loopback, &in6addr_v4mapped_any},
+	.expected_errno = EADDRINUSE,
+};
+
 static void setup_addr(FIXTURE_DATA(bind_wildcard) *self, int i,
 		       int family, const void *addr_const)
 {
-- 
2.30.2


