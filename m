Return-Path: <netdev+bounces-82259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B7388CF53
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F81C64D50
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E613D62E;
	Tue, 26 Mar 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s7L9oaDJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD173503
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485971; cv=none; b=HFFUe+NMRkYLcW87uCJbzlxWWtCKsRcV0pD+TvfJn0XZkx0PsHmTeiaMWY6+P3sTtdcrmxzoYORNUCaURh7YHPvDJtDt3EF2ZzhN+JemL0cE3xs6Hp3x84+VlGhOOUzZOFfTWAeibNR14OODi6mM7E2Cp1yqogpFrOlM4/yW8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485971; c=relaxed/simple;
	bh=BrWEnuadGmr9CYsQKCDLIyXhUUvnOIp+PjPDIK98k84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNr7tEcoQ1sCXU5kNNHd2yks25+8eATlYEvjZbgPoAiCiRZ0QYaHd/kAQnscXoqqPk5w+Jmegx792ds3F6PcZ4lOTewgio3Q7Hw+cV6s2GT76uvKtJfKYIJqeEKZhJ6KqlL/SsKRMbNPUvsHWcabGveQRv0Mp35iffWM/iHCKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s7L9oaDJ; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711485967; x=1743021967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03pLDkPcckMkP+s5GyRTWOIK62DIsaWRd4o1uthDo+E=;
  b=s7L9oaDJ1ZmM8Ib5SNkaaW8jt5m+XuHbMTLgHdj2irYyAZHTHl2uStIl
   V3pFs1aoalHpqT+5tsf0Ze3FNPvKEoaDKB9OvMxOWKuCk4HTN/FOJ7A1H
   7iIGOFAnF+GaNohgp0QvhbNqUYxxl1eOQqBFuWsJusdHRtYCy7OKtZGyb
   k=;
X-IronPort-AV: E=Sophos;i="6.07,157,1708387200"; 
   d="scan'208";a="396260164"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:46:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:36886]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.246:2525] with esmtp (Farcaster)
 id f2a0f9fc-e110-4880-b390-d4371bce96df; Tue, 26 Mar 2024 20:46:04 +0000 (UTC)
X-Farcaster-Flow-ID: f2a0f9fc-e110-4880-b390-d4371bce96df
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:46:02 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:45:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 7/8] selftest: tcp: Add bind() tests for IPV6_V6ONLY.
Date: Tue, 26 Mar 2024 13:42:50 -0700
Message-ID: <20240326204251.51301-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
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


