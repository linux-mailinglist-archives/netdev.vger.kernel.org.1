Return-Path: <netdev+bounces-128530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75197A233
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED881B2538C
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46556157481;
	Mon, 16 Sep 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="lqzrk1CO"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0AD154C04;
	Mon, 16 Sep 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489476; cv=none; b=Aytp1gWpIDZcNFePz2m+psQN1L1de6EObbtVwueeLdWvlXs2RTyDdpyJtHDKEDanQpazetTtGB7d+NSWV6UvQCSajbamsz3OsTbUC8FMAqNh6/uzWMV7o5zLKwdmkKUUJHyY1pWc7K1fpssj1IzveVVDCDl0krvNkWcI4oR/xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489476; c=relaxed/simple;
	bh=0XSzSsv5FTNIa+hW5HhWTkOVkKLsf0rI4/LjMS8kzis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3BbLGhqRPGGiN685Uaf+nrfqq8kYGe7GVmb82/c0AnnLNM1DGHuC4d3cKOnMH8EHMBa3iwv9cQPpmJTqviClscZc8dN/E/lu07BKue/aSQoMiUc4cX78VMtgM6biYP5fBVTwQmfcBxUqAzXUIil8mpSqgnnzLuxvdIGo4k1dQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=lqzrk1CO; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1726489467; bh=0XSzSsv5FTNIa+hW5HhWTkOVkKLsf0rI4/LjMS8kzis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqzrk1COSCwSpCEQlNTi/IbpGaD1z0kIYep8S3B9fSjbramtc0cCidNpIDOXNxBkd
	 p2SkdKypOLbcrQQA6wRGNHD37Ob3Zr5OLLc8topiwd6KImz8g3ngPXRrvKXAgajOtb
	 d2elFiiFd7KP0Pmk8ewVpDqLXsXOtMf6d/LJisrnIUabCmO1w7CC/HWz/QY9jp/sQE
	 syRwVfIa+HpPfP0u8q1FWwF/+WfidnL4MwawFBTq5LvOOZAoiMgn1aEBbCV7mVmKVn
	 og4jFc73hjv2KABK3jLP7/q8SLJ1S2pYTWsIR0WQAk62/AqvjoSUjOEENWsoaoNkPO
	 4/RgqutaYF+dA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 5AEE11230C2;
	Mon, 16 Sep 2024 14:24:26 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v1 6/7] selftests/landlock: Adapt existing tests for UDP
Date: Mon, 16 Sep 2024 14:22:29 +0200
Message-Id: <20240916122230.114800-7-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240916122230.114800-1-matthieu@buffet.re>
References: <20240916122230.114800-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make basic changes to the existing bind()/connect() test suite to also
encompass testing UDP access control.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/net_test.c  | 145 ++++++++++++++-----
 2 files changed, 111 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 3b26bf3cf5b9..1bc16fde2e8a 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(6, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index f21cfbbc3638..883e6648e79a 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -34,6 +34,7 @@ enum sandbox_type {
 	NO_SANDBOX,
 	/* This may be used to test rules that allow *and* deny accesses. */
 	TCP_SANDBOX,
+	UDP_SANDBOX,
 };
 
 struct protocol_variant {
@@ -123,6 +124,8 @@ static bool is_restricted(const struct protocol_variant *const prot,
 		switch (prot->type) {
 		case SOCK_STREAM:
 			return sandbox == TCP_SANDBOX;
+		case SOCK_DGRAM:
+			return sandbox == UDP_SANDBOX;
 		}
 		break;
 	}
@@ -438,6 +441,46 @@ FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_datagram) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_ipv4_udp) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_ipv4_tcp) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_ipv6_udp) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_ipv6_tcp) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_STREAM,
+	},
+};
+
 static void test_bind_and_connect(struct __test_metadata *const _metadata,
 				  const struct service_fixture *const srv,
 				  const bool deny_bind, const bool deny_connect)
@@ -530,7 +573,7 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 		ret = connect_variant(connect_fd, srv);
 		if (deny_connect) {
 			EXPECT_EQ(-EACCES, ret);
-		} else if (deny_bind) {
+		} else if (deny_bind && srv->protocol.type == SOCK_STREAM) {
 			/* No listening server. */
 			EXPECT_EQ(-ECONNREFUSED, ret);
 		} else {
@@ -569,18 +612,32 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 
 TEST_F(protocol, bind)
 {
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
+		__u64 bind_access = (variant->sandbox == UDP_SANDBOX ?
+			LANDLOCK_ACCESS_NET_BIND_UDP :
+			LANDLOCK_ACCESS_NET_BIND_TCP);
+		__u64 connect_access = (variant->sandbox == UDP_SANDBOX ?
+			LANDLOCK_ACCESS_NET_CONNECT_UDP :
+			LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		/*
+		 * Rights required to send/recv in addition to bind/connect,
+		 * just to confirm that bind/connect indeed worked.
+		 */
+		if (variant->sandbox == UDP_SANDBOX) {
+			bind_access |= LANDLOCK_ACCESS_NET_RECVMSG_UDP |
+				LANDLOCK_ACCESS_NET_SENDMSG_UDP;
+			connect_access |= LANDLOCK_ACCESS_NET_RECVMSG_UDP |
+				LANDLOCK_ACCESS_NET_SENDMSG_UDP;
+		}
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			.handled_access_net = bind_access | connect_access,
 		};
-		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr bind_connect_p0 = {
+			.allowed_access = bind_access | connect_access,
 			.port = self->srv0.port,
 		};
-		const struct landlock_net_port_attr tcp_connect_p1 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr connect_p1 = {
+			.allowed_access = connect_access,
 			.port = self->srv1.port,
 		};
 		int ruleset_fd;
@@ -589,15 +646,15 @@ TEST_F(protocol, bind)
 						     sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
 
-		/* Allows connect and bind for the first port.  */
+		/* Allows client and server behaviours for the first port */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect_p0, 0));
+					    &bind_connect_p0, 0));
 
-		/* Allows connect and denies bind for the second port. */
+		/* Allows client and deny server behaviour for the second one */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_connect_p1, 0));
+					    &connect_p1, 0));
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -619,18 +676,22 @@ TEST_F(protocol, bind)
 
 TEST_F(protocol, connect)
 {
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
+		__u64 bind_access = (variant->sandbox == UDP_SANDBOX ?
+			LANDLOCK_ACCESS_NET_BIND_UDP :
+			LANDLOCK_ACCESS_NET_BIND_TCP);
+		__u64 connect_access = (variant->sandbox == UDP_SANDBOX ?
+			LANDLOCK_ACCESS_NET_CONNECT_UDP :
+			LANDLOCK_ACCESS_NET_CONNECT_TCP);
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			.handled_access_net = bind_access | connect_access,
 		};
-		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr bind_connect_p0 = {
+			.allowed_access = bind_access | connect_access,
 			.port = self->srv0.port,
 		};
-		const struct landlock_net_port_attr tcp_bind_p1 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		const struct landlock_net_port_attr bind_p1 = {
+			.allowed_access = bind_access,
 			.port = self->srv1.port,
 		};
 		int ruleset_fd;
@@ -642,12 +703,12 @@ TEST_F(protocol, connect)
 		/* Allows connect and bind for the first port. */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect_p0, 0));
+					    &bind_connect_p0, 0));
 
 		/* Allows bind and denies connect for the second port. */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_p1, 0));
+					    &bind_p1, 0));
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -665,16 +726,21 @@ TEST_F(protocol, connect)
 
 TEST_F(protocol, bind_unspec)
 {
-	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
-	};
-	const struct landlock_net_port_attr tcp_bind = {
-		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
-		.port = self->srv0.port,
-	};
 	int bind_fd, ret;
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net = (variant->sandbox == TCP_SANDBOX ?
+				LANDLOCK_ACCESS_NET_BIND_TCP :
+				LANDLOCK_ACCESS_NET_BIND_UDP),
+		};
+		const struct landlock_net_port_attr bind = {
+			.allowed_access = (variant->sandbox == TCP_SANDBOX ?
+				LANDLOCK_ACCESS_NET_BIND_TCP :
+				LANDLOCK_ACCESS_NET_BIND_UDP),
+			.port = self->srv0.port,
+		};
+
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -682,7 +748,7 @@ TEST_F(protocol, bind_unspec)
 		/* Allows bind. */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind, 0));
+					    &bind, 0));
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
@@ -703,7 +769,12 @@ TEST_F(protocol, bind_unspec)
 	}
 	EXPECT_EQ(0, close(bind_fd));
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net = (variant->sandbox == TCP_SANDBOX ?
+				LANDLOCK_ACCESS_NET_BIND_TCP :
+				LANDLOCK_ACCESS_NET_BIND_UDP),
+		};
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -1232,11 +1303,15 @@ FIXTURE_TEARDOWN(mini)
 
 /* clang-format off */
 
-#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_TCP
+#define ACCESS_LAST LANDLOCK_ACCESS_NET_SENDMSG_UDP
 
 #define ACCESS_ALL ( \
 	LANDLOCK_ACCESS_NET_BIND_TCP | \
-	LANDLOCK_ACCESS_NET_CONNECT_TCP)
+	LANDLOCK_ACCESS_NET_CONNECT_TCP | \
+	LANDLOCK_ACCESS_NET_BIND_UDP | \
+	LANDLOCK_ACCESS_NET_CONNECT_UDP | \
+	LANDLOCK_ACCESS_NET_RECVMSG_UDP | \
+	LANDLOCK_ACCESS_NET_SENDMSG_UDP)
 
 /* clang-format on */
 
-- 
2.39.5


