Return-Path: <netdev+bounces-81725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A688AE93
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844A01C3B903
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC2B5C89;
	Mon, 25 Mar 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fJXiyTfI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705566FE0A
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390975; cv=none; b=amyPhr3vUINLlHAe8uxjELlRJKPVCF1jVTfH79uVhTenDzAQmlIV66ggt6Tq1tW2uvGLW2ie+/6vfcYN9X1hF+EpCy8itPQ/ETJwwReRee4NDb5h0rnbUG/+xQwlaqnU0EWenGrxsFg5TmXiQsL6LV6AR+5OhrkO2hZ9zpxn2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390975; c=relaxed/simple;
	bh=BrWEnuadGmr9CYsQKCDLIyXhUUvnOIp+PjPDIK98k84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gME5f/x0pUZBMpkBvSQbwIJFsVeSXGwYcJlmzJMtQz7Gku2NeiU8znkuLih9Caex7HoQ0THnP0Sc81rEUK2uB82EhiPcsTxeF26gN2rtJ/FwjBh9yaz72ijS4XrYqwZNNYf97vh2ftsFIq+Bc9VBBv5XnU/1yLgGzvrpye/cyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fJXiyTfI; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711390973; x=1742926973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03pLDkPcckMkP+s5GyRTWOIK62DIsaWRd4o1uthDo+E=;
  b=fJXiyTfIL/NO0/R3c0tDywG+30QmKsOXiOur7ybMpKr08vslULDs3Zc4
   8Ldf/ysj9G0FkUp+dp4oLTsc1Iccuqw4hVpcvau69oQziqHSEWQrNdEbf
   JX9wdPLPIqQMMn0C8Gd9Px3DcX5uBqlGBHS20wPs2wea6HqB9myOCb7YW
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708387200"; 
   d="scan'208";a="76041649"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:22:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:14845]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.239:2525] with esmtp (Farcaster)
 id e7a8ab0e-f25b-4d95-a321-9c23ef00382a; Mon, 25 Mar 2024 18:22:45 +0000 (UTC)
X-Farcaster-Flow-ID: e7a8ab0e-f25b-4d95-a321-9c23ef00382a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:22:41 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:22:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 7/8] selftest: tcp: Add bind() tests for IPV6_V6ONLY.
Date: Mon, 25 Mar 2024 11:19:22 -0700
Message-ID: <20240325181923.48769-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

bhash2 was not well tested for IPv6-only sockets.

This patch adds test cases where we set IPV6_V6ONLY for per-fixture
bind() calls if variant->ipv6_only[i] is true.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 116 ++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index 4ecd3835f33c..6d7f02441b9d 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -42,6 +42,7 @@ FIXTURE_VARIANT(bind_wildcard)
 {
 	sa_family_t family[2];
 	const void *addr[2];
+	bool ipv6_only[2];
 
 	/* 6 bind() calls below follow two bind() for the defined 2 addresses:
 	 *
@@ -87,6 +88,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any_only)
+{
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_any, &in6addr_any},
+	.ipv6_only = {false, true},
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_local)
 {
 	.family = {AF_INET, AF_INET6},
@@ -127,6 +139,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any_only)
+{
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_loopback, &in6addr_any},
+	.ipv6_only = {false, true},
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_local)
 {
 	.family = {AF_INET, AF_INET6},
@@ -168,6 +191,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_any)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v4_any)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_any, &in4addr_any},
+	.ipv6_only = {true, false},
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_local)
 {
 	.family = {AF_INET6, AF_INET},
@@ -178,6 +212,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v4_local)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v4_local)
+{
+	.family = {AF_INET6, AF_INET},
+	.addr = {&in6addr_any, &in4addr_loopback},
+	.ipv6_only = {true, false},
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v4_any)
 {
 	.family = {AF_INET6, AF_INET},
@@ -249,6 +294,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_local)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_local)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_loopback},
+	.ipv6_only = {true, false},
+	.expected_errno = {0, EADDRINUSE,
+			   0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_any)
 {
 	.family = {AF_INET6, AF_INET6},
@@ -259,6 +315,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_any)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_v4mapped_any)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_v4mapped_any},
+	.ipv6_only = {true, false},
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_local)
 {
 	.family = {AF_INET6, AF_INET6},
@@ -269,6 +336,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_v6_v4mapped_local)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_any_only_v6_v4mapped_local)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_any, &in6addr_v4mapped_loopback},
+	.ipv6_only = {true, false},
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any)
 {
 	.family = {AF_INET6, AF_INET6},
@@ -279,6 +357,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_any_only)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_loopback, &in6addr_any},
+	.ipv6_only = {false, true},
+	.expected_errno = {0, EADDRINUSE,
+			   0, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_local_v6_v4mapped_any)
 {
 	.family = {AF_INET6, AF_INET6},
@@ -309,6 +398,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_any)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_any_only)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_v4mapped_any, &in6addr_any},
+	.ipv6_only = {false, true},
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_any_v6_local)
 {
 	.family = {AF_INET6, AF_INET6},
@@ -339,6 +439,17 @@ FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_any)
 			   EADDRINUSE, EADDRINUSE},
 };
 
+FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_any_only)
+{
+	.family = {AF_INET6, AF_INET6},
+	.addr = {&in6addr_v4mapped_loopback, &in6addr_any},
+	.ipv6_only = {false, true},
+	.expected_errno = {0, 0,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE,
+			   EADDRINUSE, EADDRINUSE},
+};
+
 FIXTURE_VARIANT_ADD(bind_wildcard, v6_v4mapped_loopback_v6_local)
 {
 	.family = {AF_INET6, AF_INET6},
@@ -415,6 +526,11 @@ void bind_socket(struct __test_metadata *_metadata,
 	self->fd[i] = socket(self->addr[i].addr.sa_family, SOCK_STREAM, 0);
 	ASSERT_GT(self->fd[i], 0);
 
+	if (i < 2 && variant->ipv6_only[i]) {
+		ret = setsockopt(self->fd[i], SOL_IPV6, IPV6_V6ONLY, &(int){1}, sizeof(int));
+		ASSERT_EQ(ret, 0);
+	}
+
 	self->addr[i].addr4.sin_port = self->addr[0].addr4.sin_port;
 
 	ret = bind(self->fd[i], &self->addr[i].addr, self->addrlen[i]);
-- 
2.30.2


