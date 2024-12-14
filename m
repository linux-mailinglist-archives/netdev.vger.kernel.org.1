Return-Path: <netdev+bounces-151962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7539F205E
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B753E7A128D
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 18:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330411A8F7B;
	Sat, 14 Dec 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="DiUKUPSA"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFEE194C67;
	Sat, 14 Dec 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202015; cv=none; b=TBOAmbcmhowCroUPm7rueSzVWF+I3/U3X/k7+ba0atMr/HFlPIHDXn+o8KaUVN5v8NT49Wao65L2mhcEzKD3/C45jvsXer+6EzPmtYxx1oO0ItJTtAqeN6ERhQu6MOfzQYdSIeLF27SiQ/pgNmzXgqUovaMkjvKR6rQljWxk/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202015; c=relaxed/simple;
	bh=9QIBX5F2bTUNkEKE/3jpWMF8FtxDNZOyKmyPPX+qz9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtcZAgRK1tHrySDQKKrln8QdNFFFnZ5vHebTv3JcRxG3wr3Oe/WBLhBzc2k7refJDK4N0CsOEo2qb/cdb0YP/3vqqDRoLmohXer874xui+xsZ4QaGhHjO5l/u2Bd0JszrbvMCgAFXa1KfTCOcoPfNPNzQzD1cY/7ZlnVYLlsJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=DiUKUPSA; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1734202009; bh=9QIBX5F2bTUNkEKE/3jpWMF8FtxDNZOyKmyPPX+qz9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiUKUPSAzmSukfBbF2uKY9qWeslqBfcr0RDxoRbRwLeWmKlioWCpYAe9JgUmSHLz2
	 YesKXsdQ82b4V4EjWaqSUXFkvVmfFBevr7fndiDwJMTjtcHpYwyPoBC5vcBsMiygGF
	 UpkNC3O1V3Np7I5HUSXLEBV2cnDRfjP1iFRa555BV1WXmUxv6782eGGOhsOfLAU1Ky
	 igyY+C8GWaqo6Y8H6tdkXj6VrKiKVqeZDSTOQrAL5Qjpbe8aj506iojusgWeZIztLC
	 tp++mrPqV97PHr3rncQYKmr4Jv5B/iLix/8jdaDxiQJWUa4GuqbgGDDk0si+YOa2sq
	 7pv3s+LHxYwng==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id A4C621252E2;
	Sat, 14 Dec 2024 19:46:49 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: Mickael Salaun <mic@digikod.net>
Cc: Gunther Noack <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 2/6] selftests/landlock: Adapt existing bind/connect for UDP
Date: Sat, 14 Dec 2024 19:45:36 +0100
Message-Id: <20241214184540.3835222-3-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241214184540.3835222-1-matthieu@buffet.re>
References: <20241214184540.3835222-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make basic changes to the existing bind() and connect() test suite
to also encompass testing UDP access control.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/net_test.c  | 174 ++++++++++++++-----
 2 files changed, 135 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 1bc16fde2e8a..fbd687691b3c 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(6, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 4e0aeb53b225..40f66cccce69 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -34,6 +34,7 @@ enum sandbox_type {
 	NO_SANDBOX,
 	/* This may be used to test rules that allow *and* deny accesses. */
 	TCP_SANDBOX,
+	UDP_SANDBOX,
 };
 
 static int set_service(struct service_fixture *const srv,
@@ -94,6 +95,8 @@ static bool is_restricted(const struct protocol_variant *const prot,
 		switch (prot->type) {
 		case SOCK_STREAM:
 			return sandbox == TCP_SANDBOX;
+		case SOCK_DGRAM:
+			return sandbox == UDP_SANDBOX;
 		}
 		break;
 	}
@@ -409,6 +412,66 @@ FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_datagram) {
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
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_unix_stream) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_UNIX,
+		.type = SOCK_STREAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_unix_datagram) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_UNIX,
+		.type = SOCK_DGRAM,
+	},
+};
+
 static void test_bind_and_connect(struct __test_metadata *const _metadata,
 				  const struct service_fixture *const srv,
 				  const bool deny_bind, const bool deny_connect)
@@ -480,7 +543,11 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 	if (deny_bind) {
 		EXPECT_EQ(-EACCES, ret);
 	} else {
-		EXPECT_EQ(0, ret);
+		EXPECT_EQ(0, ret)
+		{
+			TH_LOG("Failed to bind socket: %s",
+			       strerror(errno));
+		}
 
 		/* Creates a listening socket. */
 		if (srv->protocol.type == SOCK_STREAM)
@@ -501,7 +568,7 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 		ret = connect_variant(connect_fd, srv);
 		if (deny_connect) {
 			EXPECT_EQ(-EACCES, ret);
-		} else if (deny_bind) {
+		} else if (deny_bind && srv->protocol.type == SOCK_STREAM) {
 			/* No listening server. */
 			EXPECT_EQ(-ECONNREFUSED, ret);
 		} else {
@@ -540,18 +607,23 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 
 TEST_F(protocol, bind)
 {
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
+		__u64 bind_access = (variant->sandbox == TCP_SANDBOX ?
+					     LANDLOCK_ACCESS_NET_BIND_TCP :
+					     LANDLOCK_ACCESS_NET_BIND_UDP);
+		__u64 connect_access =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+				 LANDLOCK_ACCESS_NET_CONNECT_UDP);
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
@@ -563,12 +635,12 @@ TEST_F(protocol, bind)
 		/* Allows connect and bind for the first port.  */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect_p0, 0));
+					    &bind_connect_p0, 0));
 
 		/* Allows connect and denies bind for the second port. */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_connect_p1, 0));
+					    &connect_p1, 0));
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -590,18 +662,23 @@ TEST_F(protocol, bind)
 
 TEST_F(protocol, connect)
 {
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
+		__u64 bind_access = (variant->sandbox == TCP_SANDBOX ?
+					     LANDLOCK_ACCESS_NET_BIND_TCP :
+					     LANDLOCK_ACCESS_NET_BIND_UDP);
+		__u64 connect_access =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+				 LANDLOCK_ACCESS_NET_CONNECT_UDP);
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
@@ -613,12 +690,12 @@ TEST_F(protocol, connect)
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
@@ -636,16 +713,23 @@ TEST_F(protocol, connect)
 
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
+			.handled_access_net =
+				(variant->sandbox == TCP_SANDBOX ?
+					 LANDLOCK_ACCESS_NET_BIND_TCP :
+					 LANDLOCK_ACCESS_NET_BIND_UDP),
+		};
+		const struct landlock_net_port_attr bind = {
+			.allowed_access =
+				(variant->sandbox == TCP_SANDBOX ?
+					 LANDLOCK_ACCESS_NET_BIND_TCP :
+					 LANDLOCK_ACCESS_NET_BIND_UDP),
+			.port = self->srv0.port,
+		};
+
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -653,7 +737,7 @@ TEST_F(protocol, bind_unspec)
 		/* Allows bind. */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind, 0));
+					    &bind, 0));
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
@@ -674,7 +758,13 @@ TEST_F(protocol, bind_unspec)
 	}
 	EXPECT_EQ(0, close(bind_fd));
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox != NO_SANDBOX) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net =
+				(variant->sandbox == TCP_SANDBOX ?
+					 LANDLOCK_ACCESS_NET_BIND_TCP :
+					 LANDLOCK_ACCESS_NET_BIND_UDP),
+		};
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -718,10 +808,12 @@ TEST_F(protocol, bind_unspec)
 TEST_F(protocol, connect_unspec)
 {
 	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_UDP,
 	};
-	const struct landlock_net_port_attr tcp_connect = {
-		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	const struct landlock_net_port_attr connect = {
+		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP |
+				  LANDLOCK_ACCESS_NET_CONNECT_UDP,
 		.port = self->srv0.port,
 	};
 	int bind_fd, client_fd, status;
@@ -754,7 +846,7 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, ret);
 		}
 
-		if (variant->sandbox == TCP_SANDBOX) {
+		if (variant->sandbox != NO_SANDBOX) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_attr, sizeof(ruleset_attr), 0);
 			ASSERT_LE(0, ruleset_fd);
@@ -762,7 +854,7 @@ TEST_F(protocol, connect_unspec)
 			/* Allows connect. */
 			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
 						       LANDLOCK_RULE_NET_PORT,
-						       &tcp_connect, 0));
+						       &connect, 0));
 			enforce_ruleset(_metadata, ruleset_fd);
 			EXPECT_EQ(0, close(ruleset_fd));
 		}
@@ -785,7 +877,7 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, ret);
 		}
 
-		if (variant->sandbox == TCP_SANDBOX) {
+		if (variant->sandbox != NO_SANDBOX) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_attr, sizeof(ruleset_attr), 0);
 			ASSERT_LE(0, ruleset_fd);
@@ -1203,11 +1295,13 @@ FIXTURE_TEARDOWN(mini)
 
 /* clang-format off */
 
-#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_TCP
+#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_UDP
 
 #define ACCESS_ALL ( \
 	LANDLOCK_ACCESS_NET_BIND_TCP | \
-	LANDLOCK_ACCESS_NET_CONNECT_TCP)
+	LANDLOCK_ACCESS_NET_CONNECT_TCP | \
+	LANDLOCK_ACCESS_NET_BIND_UDP | \
+	LANDLOCK_ACCESS_NET_CONNECT_UDP)
 
 /* clang-format on */
 
-- 
2.39.5


