Return-Path: <netdev+bounces-244514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCFACB9477
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8712C3063387
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520E2C324F;
	Fri, 12 Dec 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="Afyak1ZU"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D12C1595;
	Fri, 12 Dec 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557435; cv=none; b=Y6kNpAiISyDk03DNNdQPCGS2/eUMUcE15YYdig2QQtTDY/HY922UldbSah7k14HqjNOn8Fc6NKbVF3/W275MXbu0MDYlGYpTTTAYAziCXpoQY30Ow9+16QXT1lgIuP56OwHOBlIFF5k6TdED/j5udh4Swca20Lsa0SRkgTaTxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557435; c=relaxed/simple;
	bh=TMrYGEy7EHUCz0sy7NRJVoNRK1P5EOEY6i1X3hKDD3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpAW+khi19XBk4Pds+FXiRN1In8X8KOpa/i463SKUec7Xa17qAEw4WCc1q36rZ8I7BjWil9h6ojDYD+VSEVAHK0wjLtmb6G7vYu+QHvIpCMq8SMWSSnfzRYioZoINBq6LRlprUDPa0wD/YgSA+dn7PeaMUNiiYmn1DEry3vsqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=Afyak1ZU; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557428; bh=TMrYGEy7EHUCz0sy7NRJVoNRK1P5EOEY6i1X3hKDD3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Afyak1ZUWYCRkJRBFIKwQeSPFwCpFdvPHsnm61EL3cSeslio0Yvuuek+NkuYws1zR
	 yaelz3UZcbFbJUUZaT4m3A8LBL09ODwqlUNEX+CVJA5ZvxVh1u59rbsnDNhpVP9VHT
	 iPJIO2lVOCZLM0TTu2U5YgJG2IAlT5cnG9lyeXzw9ariOcyVCXEE7uKnFun1W33QCP
	 KczWCRyiod4XkEpoMyMx+wAsLnCllYmBgDgkYrPBQb+0lorFzyOITNzrDAELJ4+Uo0
	 0LMNzyUCt6x0amq0KHZ93QHqnEZsfQNDSKVFILsvfvVmtCRiLUQ7fGrx/eZMYlTodQ
	 Zot4CRX1CIHqw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 0642212548B;
	Fri, 12 Dec 2025 17:37:07 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 4/8] selftests/landlock: Add UDP bind/connect tests
Date: Fri, 12 Dec 2025 17:37:00 +0100
Message-Id: <20251212163704.142301-5-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251212163704.142301-1-matthieu@buffet.re>
References: <20251212163704.142301-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make basic changes to the existing bind() and connect() test suite to
also encompass testing UDP access control.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/net_test.c  | 389 ++++++++++++++-----
 2 files changed, 303 insertions(+), 88 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 7b69002239d7..f4b1a275d8d9 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index b34b139b3f89..977d82eb9934 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -35,6 +35,7 @@ enum sandbox_type {
 	NO_SANDBOX,
 	/* This may be used to test rules that allow *and* deny accesses. */
 	TCP_SANDBOX,
+	UDP_SANDBOX,
 };
 
 static int set_service(struct service_fixture *const srv,
@@ -93,11 +94,20 @@ static bool prot_is_tcp(const struct protocol_variant *const prot)
 	       (prot->protocol == IPPROTO_TCP || prot->protocol == IPPROTO_IP);
 }
 
+static bool prot_is_udp(const struct protocol_variant *const prot)
+{
+	return (prot->domain == AF_INET || prot->domain == AF_INET6) &&
+	       prot->type == SOCK_DGRAM &&
+	       (prot->protocol == IPPROTO_UDP || prot->protocol == IPPROTO_IP);
+}
+
 static bool is_restricted(const struct protocol_variant *const prot,
 			  const enum sandbox_type sandbox)
 {
 	if (sandbox == TCP_SANDBOX)
 		return prot_is_tcp(prot);
+	else if (sandbox == UDP_SANDBOX)
+		return prot_is_udp(prot);
 	return false;
 }
 
@@ -271,10 +281,9 @@ FIXTURE_VARIANT(protocol)
 
 FIXTURE_SETUP(protocol)
 {
-	const struct protocol_variant prot_unspec = {
-		.domain = AF_UNSPEC,
-		.type = SOCK_STREAM,
-	};
+	struct protocol_variant prot_unspec = variant->prot;
+
+	prot_unspec.domain = AF_UNSPEC;
 
 	disable_caps(_metadata);
 
@@ -510,6 +519,92 @@ FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_datagram) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_ipv4_udp1) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_ipv4_udp2) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+		/* IPPROTO_IP == 0 */
+		.protocol = IPPROTO_IP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_ipv6_udp1) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(protocol, udp_sandbox_with_ipv6_udp2) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+		/* IPPROTO_IP == 0 */
+		.protocol = IPPROTO_IP,
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
@@ -602,7 +697,7 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 		ret = connect_variant(connect_fd, srv);
 		if (deny_connect) {
 			EXPECT_EQ(-EACCES, ret);
-		} else if (deny_bind) {
+		} else if (deny_bind && srv->protocol.type == SOCK_STREAM) {
 			/* No listening server. */
 			EXPECT_EQ(-ECONNREFUSED, ret);
 		} else {
@@ -641,18 +736,25 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 
 TEST_F(protocol, bind)
 {
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const __u64 bind_access =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_BIND_TCP :
+				 LANDLOCK_ACCESS_NET_BIND_UDP);
+		const __u64 connect_access =
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
@@ -664,12 +766,12 @@ TEST_F(protocol, bind)
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
@@ -691,18 +793,25 @@ TEST_F(protocol, bind)
 
 TEST_F(protocol, connect)
 {
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const __u64 bind_access =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_BIND_TCP :
+				 LANDLOCK_ACCESS_NET_BIND_UDP);
+		const __u64 connect_access =
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
@@ -714,12 +823,12 @@ TEST_F(protocol, connect)
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
@@ -737,16 +846,24 @@ TEST_F(protocol, connect)
 
 TEST_F(protocol, bind_unspec)
 {
-	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
-	};
-	const struct landlock_net_port_attr tcp_bind = {
-		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
-		.port = self->srv0.port,
-	};
+	const int bind_access_right = (variant->sandbox == TCP_SANDBOX ?
+					       LANDLOCK_ACCESS_NET_BIND_TCP :
+					       LANDLOCK_ACCESS_NET_BIND_UDP);
 	int bind_fd, ret;
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net = bind_access_right,
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
@@ -754,7 +871,7 @@ TEST_F(protocol, bind_unspec)
 		/* Allows bind. */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind, 0));
+					    &bind, 0));
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
@@ -782,7 +899,11 @@ TEST_F(protocol, bind_unspec)
 	}
 	EXPECT_EQ(0, close(bind_fd));
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net = bind_access_right,
+		};
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -829,10 +950,12 @@ TEST_F(protocol, bind_unspec)
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
@@ -865,7 +988,8 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, ret);
 		}
 
-		if (variant->sandbox == TCP_SANDBOX) {
+		if (variant->sandbox == TCP_SANDBOX ||
+		    variant->sandbox == UDP_SANDBOX) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_attr, sizeof(ruleset_attr), 0);
 			ASSERT_LE(0, ruleset_fd);
@@ -873,7 +997,7 @@ TEST_F(protocol, connect_unspec)
 			/* Allows connect. */
 			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
 						       LANDLOCK_RULE_NET_PORT,
-						       &tcp_connect, 0));
+						       &connect, 0));
 			enforce_ruleset(_metadata, ruleset_fd);
 			EXPECT_EQ(0, close(ruleset_fd));
 		}
@@ -896,7 +1020,8 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, ret);
 		}
 
-		if (variant->sandbox == TCP_SANDBOX) {
+		if (variant->sandbox == TCP_SANDBOX ||
+		    variant->sandbox == UDP_SANDBOX) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_attr, sizeof(ruleset_attr), 0);
 			ASSERT_LE(0, ruleset_fd);
@@ -975,6 +1100,13 @@ FIXTURE_VARIANT_ADD(ipv4, tcp_sandbox_with_tcp) {
 	.type = SOCK_STREAM,
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ipv4, udp_sandbox_with_tcp) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.type = SOCK_STREAM,
+};
+
 /* clang-format off */
 FIXTURE_VARIANT_ADD(ipv4, no_sandbox_with_udp) {
 	/* clang-format on */
@@ -989,6 +1121,13 @@ FIXTURE_VARIANT_ADD(ipv4, tcp_sandbox_with_udp) {
 	.type = SOCK_DGRAM,
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ipv4, udp_sandbox_with_udp) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.type = SOCK_DGRAM,
+};
+
 FIXTURE_SETUP(ipv4)
 {
 	const struct protocol_variant prot = {
@@ -1010,16 +1149,21 @@ FIXTURE_TEARDOWN(ipv4)
 
 TEST_F(ipv4, from_unix_to_inet)
 {
+	const int access_rights =
+		(variant->sandbox == TCP_SANDBOX ?
+			 LANDLOCK_ACCESS_NET_BIND_TCP |
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+			 LANDLOCK_ACCESS_NET_BIND_UDP |
+				 LANDLOCK_ACCESS_NET_CONNECT_UDP);
 	int unix_stream_fd, unix_dgram_fd;
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			.handled_access_net = access_rights,
 		};
-		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr bind_connect_p0 = {
+			.allowed_access = access_rights,
 			.port = self->srv0.port,
 		};
 		int ruleset_fd;
@@ -1032,7 +1176,7 @@ TEST_F(ipv4, from_unix_to_inet)
 		/* Allows connect and bind for srv0.  */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect_p0, 0));
+					    &bind_connect_p0, 0));
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -1326,11 +1470,13 @@ FIXTURE_TEARDOWN(mini)
 
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
 
@@ -1697,7 +1843,7 @@ FIXTURE_VARIANT_ADD(port_specific, no_sandbox_with_ipv4) {
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv4) {
+FIXTURE_VARIANT_ADD(port_specific, tcp_sandbox_with_ipv4) {
 	/* clang-format on */
 	.sandbox = TCP_SANDBOX,
 	.prot = {
@@ -1706,6 +1852,16 @@ FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv4) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(port_specific, udp_sandbox_with_ipv4) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+	},
+};
+
 /* clang-format off */
 FIXTURE_VARIANT_ADD(port_specific, no_sandbox_with_ipv6) {
 	/* clang-format on */
@@ -1717,7 +1873,7 @@ FIXTURE_VARIANT_ADD(port_specific, no_sandbox_with_ipv6) {
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv6) {
+FIXTURE_VARIANT_ADD(port_specific, tcp_sandbox_with_ipv6) {
 	/* clang-format on */
 	.sandbox = TCP_SANDBOX,
 	.prot = {
@@ -1726,6 +1882,16 @@ FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv6) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(port_specific, udp_sandbox_with_ipv6) {
+	/* clang-format on */
+	.sandbox = UDP_SANDBOX,
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+	},
+};
+
 FIXTURE_SETUP(port_specific)
 {
 	disable_caps(_metadata);
@@ -1745,14 +1911,19 @@ TEST_F(port_specific, bind_connect_zero)
 	uint16_t port;
 
 	/* Adds a rule layer with bind and connect actions. */
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const int access_rights =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_BIND_TCP |
+					 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+				 LANDLOCK_ACCESS_NET_BIND_UDP |
+					 LANDLOCK_ACCESS_NET_CONNECT_UDP);
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP
+			.handled_access_net = access_rights,
 		};
 		const struct landlock_net_port_attr tcp_bind_connect_zero = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			.allowed_access = access_rights,
 			.port = 0,
 		};
 		int ruleset_fd;
@@ -1785,11 +1956,13 @@ TEST_F(port_specific, bind_connect_zero)
 	ret = bind_variant(bind_fd, &self->srv0);
 	EXPECT_EQ(0, ret);
 
-	EXPECT_EQ(0, listen(bind_fd, backlog));
+	if (variant->prot.type == SOCK_STREAM) {
+		EXPECT_EQ(0, listen(bind_fd, backlog));
 
-	/* Connects on port 0. */
-	ret = connect_variant(connect_fd, &self->srv0);
-	EXPECT_EQ(-ECONNREFUSED, ret);
+		/* Connects on port 0. */
+		ret = connect_variant(connect_fd, &self->srv0);
+		EXPECT_EQ(-ECONNREFUSED, ret);
+	}
 
 	/* Sets binded port for both protocol families. */
 	port = get_binded_port(bind_fd, &variant->prot);
@@ -1813,21 +1986,25 @@ TEST_F(port_specific, bind_connect_1023)
 	int bind_fd, connect_fd, ret;
 
 	/* Adds a rule layer with bind and connect actions. */
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const int access_rights =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_BIND_TCP |
+					 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+				 LANDLOCK_ACCESS_NET_BIND_UDP |
+					 LANDLOCK_ACCESS_NET_CONNECT_UDP);
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP
+			.handled_access_net = access_rights,
 		};
 		/* A rule with port value less than 1024. */
-		const struct landlock_net_port_attr tcp_bind_connect_low_range = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr bind_connect_low_range = {
+			.allowed_access = access_rights,
 			.port = 1023,
 		};
 		/* A rule with 1024 port. */
-		const struct landlock_net_port_attr tcp_bind_connect = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr bind_connect = {
+			.allowed_access = access_rights,
 			.port = 1024,
 		};
 		int ruleset_fd;
@@ -1838,10 +2015,10 @@ TEST_F(port_specific, bind_connect_1023)
 
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect_low_range, 0));
+					    &bind_connect_low_range, 0));
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect, 0));
+					    &bind_connect, 0));
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -1865,7 +2042,8 @@ TEST_F(port_specific, bind_connect_1023)
 	ret = bind_variant(bind_fd, &self->srv0);
 	clear_cap(_metadata, CAP_NET_BIND_SERVICE);
 	EXPECT_EQ(0, ret);
-	EXPECT_EQ(0, listen(bind_fd, backlog));
+	if (variant->prot.type == SOCK_STREAM)
+		EXPECT_EQ(0, listen(bind_fd, backlog));
 
 	/* Connects on the binded port 1023. */
 	ret = connect_variant(connect_fd, &self->srv0);
@@ -1885,7 +2063,8 @@ TEST_F(port_specific, bind_connect_1023)
 	/* Binds on port 1024. */
 	ret = bind_variant(bind_fd, &self->srv0);
 	EXPECT_EQ(0, ret);
-	EXPECT_EQ(0, listen(bind_fd, backlog));
+	if (variant->prot.type == SOCK_STREAM)
+		EXPECT_EQ(0, listen(bind_fd, backlog));
 
 	/* Connects on the binded port 1024. */
 	ret = connect_variant(connect_fd, &self->srv0);
@@ -1895,9 +2074,9 @@ TEST_F(port_specific, bind_connect_1023)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
-static int matches_log_tcp(const int audit_fd, const char *const blockers,
-			   const char *const dir_addr, const char *const addr,
-			   const char *const dir_port)
+static int matches_log_prot(const int audit_fd, const char *const blockers,
+			    const char *const dir_addr, const char *const addr,
+			    const char *const dir_port)
 {
 	static const char log_template[] = REGEX_LANDLOCK_PREFIX
 		" blockers=%s %s=%s %s=1024$";
@@ -1933,7 +2112,7 @@ FIXTURE_VARIANT(audit)
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(audit, ipv4) {
+FIXTURE_VARIANT_ADD(audit, ipv4_tcp) {
 	/* clang-format on */
 	.addr = "127\\.0\\.0\\.1",
 	.prot = {
@@ -1943,7 +2122,17 @@ FIXTURE_VARIANT_ADD(audit, ipv4) {
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(audit, ipv6) {
+FIXTURE_VARIANT_ADD(audit, ipv4_udp) {
+	/* clang-format on */
+	.addr = "127\\.0\\.0\\.1",
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit, ipv6_tcp) {
 	/* clang-format on */
 	.addr = "::1",
 	.prot = {
@@ -1952,6 +2141,16 @@ FIXTURE_VARIANT_ADD(audit, ipv6) {
 	},
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit, ipv6_udp) {
+	/* clang-format on */
+	.addr = "::1",
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+	},
+};
+
 FIXTURE_SETUP(audit)
 {
 	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
@@ -1972,9 +2171,17 @@ FIXTURE_TEARDOWN(audit)
 
 TEST_F(audit, bind)
 {
+	const char *audit_evt = (variant->prot.type == SOCK_STREAM ?
+					 "net\\.bind_tcp" :
+					 "net\\.bind_udp");
+	const int access_rights =
+		(variant->prot.type == SOCK_STREAM ?
+			 LANDLOCK_ACCESS_NET_BIND_TCP |
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+			 LANDLOCK_ACCESS_NET_BIND_UDP |
+				 LANDLOCK_ACCESS_NET_CONNECT_UDP);
 	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.handled_access_net = access_rights,
 	};
 	struct audit_records records;
 	int ruleset_fd, sock_fd;
@@ -1988,8 +2195,8 @@ TEST_F(audit, bind)
 	sock_fd = socket_variant(&self->srv0);
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv0));
-	EXPECT_EQ(0, matches_log_tcp(self->audit_fd, "net\\.bind_tcp", "saddr",
-				     variant->addr, "src"));
+	EXPECT_EQ(0, matches_log_prot(self->audit_fd, audit_evt, "saddr",
+				      variant->addr, "src"));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
@@ -2000,9 +2207,17 @@ TEST_F(audit, bind)
 
 TEST_F(audit, connect)
 {
+	const char *audit_evt = (variant->prot.type == SOCK_STREAM ?
+					 "net\\.connect_tcp" :
+					 "net\\.connect_udp");
+	const int access_rights =
+		(variant->prot.type == SOCK_STREAM ?
+			 LANDLOCK_ACCESS_NET_BIND_TCP |
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+			 LANDLOCK_ACCESS_NET_BIND_UDP |
+				 LANDLOCK_ACCESS_NET_CONNECT_UDP);
 	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.handled_access_net = access_rights,
 	};
 	struct audit_records records;
 	int ruleset_fd, sock_fd;
@@ -2016,8 +2231,8 @@ TEST_F(audit, connect)
 	sock_fd = socket_variant(&self->srv0);
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv0));
-	EXPECT_EQ(0, matches_log_tcp(self->audit_fd, "net\\.connect_tcp",
-				     "daddr", variant->addr, "dest"));
+	EXPECT_EQ(0, matches_log_prot(self->audit_fd, audit_evt, "daddr",
+				      variant->addr, "dest"));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-- 
2.47.3


