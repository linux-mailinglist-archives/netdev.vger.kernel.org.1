Return-Path: <netdev+bounces-283402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIlAHrrx9WmVQgIAu9opvQ
	(envelope-from <netdev+bounces-283402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:44:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 220EB4B2016
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 426DA3003D3B
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB936C9D2;
	Sat,  2 May 2026 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="YSLtIgUR"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64136E489;
	Sat,  2 May 2026 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725880; cv=none; b=Czdiwn/byjOD4njwC00uRwlMIvWBD91rHXKkhbi4Nsz0zzdzsaYbt7M+xGhXWztT7hOwOEkPsWMnxNQIiUAhMhnef2z9nB1sYQaA/TYp53nBbIrUaNM20185GXHGOkyro+q7XfkeYD8+FbzLWR9Q7rbBYjoPtzQkk18wlflUAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725880; c=relaxed/simple;
	bh=rqi4pcpYjA34CmDAkSOKcYSG49jY3w5zIwN+hkp/DUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6sGlEAEiBC+/9kmb31jeCKY0fTnCWyZ6Iv3wmKAisJUquDCs1ExZRbOQXS2ISBHDcD+iEETfEoSsoYe51vB2AvZPfLYQ04oVRx6q8JpjKMxYJ0TC1h/WtKEherA3EzbWTV6dXJMDUGOMWrScXdd5bmY7NJy5Z4hX10XJUa1raE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=YSLtIgUR; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1777725876; bh=rqi4pcpYjA34CmDAkSOKcYSG49jY3w5zIwN+hkp/DUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSLtIgURs0eCw+6qFYHTH/d+Ejy+CSRMSAUupfhGYH9cuWUE8wzy1kKPT3PtyqdqY
	 fAYqDvQYh9uBKFy8FuLf6sNWaroBqMqdhjSm8//F4aRVAbowmQo7WCmnHsf7xzLumv
	 LpM3ZwA5IXLPQo70Nm+3+p8qDXjQ53gQjGk1fDm+YQ9Hqomp+Wcsrwvw03iaPydbtr
	 2Febc8oWxZneAiQus76K8Ite8YSylX4DhiCbnOh/azkXFNjLtI46GnZbAtrAZea5gK
	 /ZlQXuTZXeDY0nkWh7Wu31opv8k1EDG0c7IfzQM82O/thBrZXYPE+NkKFmYOwOiHj9
	 /RMQd/BNHRznw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 48A4812591F;
	Sat,  2 May 2026 14:44:36 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v4 4/7] selftests/landlock: Add UDP bind/connect tests
Date: Sat,  2 May 2026 14:43:03 +0200
Message-Id: <20260502124306.3975990-5-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260502124306.3975990-1-matthieu@buffet.re>
References: <20260502124306.3975990-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 220EB4B2016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283402-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[buffet.re:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Make basic changes to the existing bind() and connect() test suite to
cover UDP restriction.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/net_test.c | 488 ++++++++++++++++----
 1 file changed, 401 insertions(+), 87 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 016c7277e370..568a6ed7139c 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -35,6 +35,7 @@ enum sandbox_type {
 	NO_SANDBOX,
 	/* This may be used to test rules that allow *and* deny accesses. */
 	TCP_SANDBOX,
+	UDP_SANDBOX,
 };
 
 static int set_service(struct service_fixture *const srv,
@@ -93,23 +94,53 @@ static bool prot_is_tcp(const struct protocol_variant *const prot)
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
 
 static int socket_variant(const struct service_fixture *const srv)
 {
+	/* Arbitrary value just to not block other tests indefinitely. */
+	const struct timeval timeout = {
+		.tv_sec = 0,
+		.tv_usec = 100000,
+	};
+	int sockfd;
 	int ret;
 
-	ret = socket(srv->protocol.domain, srv->protocol.type | SOCK_CLOEXEC,
-		     srv->protocol.protocol);
-	if (ret < 0)
+	sockfd = socket(srv->protocol.domain, srv->protocol.type | SOCK_CLOEXEC,
+			srv->protocol.protocol);
+	if (sockfd < 0)
 		return -errno;
-	return ret;
+
+	ret = setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &timeout,
+			 sizeof(timeout));
+	if (ret != 0) {
+		ret = -errno;
+		close(sockfd);
+		return ret;
+	}
+	ret = setsockopt(sockfd, SOL_SOCKET, SO_SNDTIMEO, &timeout,
+			 sizeof(timeout));
+	if (ret != 0) {
+		ret = -errno;
+		close(sockfd);
+		return ret;
+	}
+	return sockfd;
 }
 
 #ifndef SIN6_LEN_RFC2133
@@ -271,10 +302,9 @@ FIXTURE_VARIANT(protocol)
 
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
 
@@ -510,6 +540,92 @@ FIXTURE_VARIANT_ADD(protocol, tcp_sandbox_with_unix_datagram) {
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
@@ -602,7 +718,7 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 		ret = connect_variant(connect_fd, srv);
 		if (deny_connect) {
 			EXPECT_EQ(-EACCES, ret);
-		} else if (deny_bind) {
+		} else if (deny_bind && srv->protocol.type == SOCK_STREAM) {
 			/* No listening server. */
 			EXPECT_EQ(-ECONNREFUSED, ret);
 		} else {
@@ -641,18 +757,25 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 
 TEST_F(protocol, bind)
 {
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const __u64 bind_access =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_BIND_TCP :
+				 LANDLOCK_ACCESS_NET_BIND_UDP);
+		const __u64 conn_access =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			.handled_access_net = bind_access | conn_access,
 		};
-		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr bind_connect_p0 = {
+			.allowed_access = bind_access | conn_access,
 			.port = self->srv0.port,
 		};
-		const struct landlock_net_port_attr tcp_connect_p1 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr connect_p1 = {
+			.allowed_access = conn_access,
 			.port = self->srv1.port,
 		};
 		int ruleset_fd;
@@ -664,12 +787,26 @@ TEST_F(protocol, bind)
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
+
+		/*
+		 * For UDP sockets, allows binding to ephemeral ports
+		 * (required to connect or send a first datagram)
+		 */
+		if (variant->sandbox == UDP_SANDBOX) {
+			const struct landlock_net_port_attr bind_ephemeral = {
+				.allowed_access = bind_access,
+				.port = 0,
+			};
+			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+						       LANDLOCK_RULE_NET_PORT,
+						       &bind_ephemeral, 0));
+		}
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -691,18 +828,25 @@ TEST_F(protocol, bind)
 
 TEST_F(protocol, connect)
 {
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const __u64 bind_access =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_BIND_TCP :
+				 LANDLOCK_ACCESS_NET_BIND_UDP);
+		const __u64 conn_access =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			.handled_access_net = bind_access | conn_access,
 		};
-		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr bind_connect_p0 = {
+			.allowed_access = bind_access | conn_access,
 			.port = self->srv0.port,
 		};
-		const struct landlock_net_port_attr tcp_bind_p1 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		const struct landlock_net_port_attr bind_p1 = {
+			.allowed_access = bind_access,
 			.port = self->srv1.port,
 		};
 		int ruleset_fd;
@@ -714,12 +858,26 @@ TEST_F(protocol, connect)
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
+
+		/*
+		 * For UDP sockets, allows binding to ephemeral ports
+		 * (required to connect or send a first datagram)
+		 */
+		if (variant->sandbox == UDP_SANDBOX) {
+			const struct landlock_net_port_attr bind_ephemeral = {
+				.allowed_access = bind_access,
+				.port = 0,
+			};
+			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+						       LANDLOCK_RULE_NET_PORT,
+						       &bind_ephemeral, 0));
+		}
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -737,16 +895,20 @@ TEST_F(protocol, connect)
 
 TEST_F(protocol, bind_unspec)
 {
+	const int bind_access = (variant->sandbox == TCP_SANDBOX ?
+					 LANDLOCK_ACCESS_NET_BIND_TCP :
+					 LANDLOCK_ACCESS_NET_BIND_UDP);
 	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.handled_access_net = bind_access,
 	};
-	const struct landlock_net_port_attr tcp_bind = {
-		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+	const struct landlock_net_port_attr rule_bind = {
+		.allowed_access = bind_access,
 		.port = self->srv0.port,
 	};
 	int bind_fd, ret;
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -754,7 +916,7 @@ TEST_F(protocol, bind_unspec)
 		/* Allows bind. */
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind, 0));
+					    &rule_bind, 0));
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
@@ -782,7 +944,8 @@ TEST_F(protocol, bind_unspec)
 	}
 	EXPECT_EQ(0, close(bind_fd));
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
 		const int ruleset_fd = landlock_create_ruleset(
 			&ruleset_attr, sizeof(ruleset_attr), 0);
 		ASSERT_LE(0, ruleset_fd);
@@ -828,11 +991,15 @@ TEST_F(protocol, bind_unspec)
 
 TEST_F(protocol, connect_unspec)
 {
+	const __u64 connect_right =
+		(variant->sandbox == TCP_SANDBOX ?
+			 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+			 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.handled_access_net = connect_right,
 	};
-	const struct landlock_net_port_attr tcp_connect = {
-		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	const struct landlock_net_port_attr rule_connect = {
+		.allowed_access = connect_right,
 		.port = self->srv0.port,
 	};
 	int bind_fd, client_fd, status;
@@ -865,7 +1032,8 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, ret);
 		}
 
-		if (variant->sandbox == TCP_SANDBOX) {
+		if (variant->sandbox == TCP_SANDBOX ||
+		    variant->sandbox == UDP_SANDBOX) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_attr, sizeof(ruleset_attr), 0);
 			ASSERT_LE(0, ruleset_fd);
@@ -873,7 +1041,7 @@ TEST_F(protocol, connect_unspec)
 			/* Allows connect. */
 			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
 						       LANDLOCK_RULE_NET_PORT,
-						       &tcp_connect, 0));
+						       &rule_connect, 0));
 			enforce_ruleset(_metadata, ruleset_fd);
 			EXPECT_EQ(0, close(ruleset_fd));
 		}
@@ -896,7 +1064,8 @@ TEST_F(protocol, connect_unspec)
 			EXPECT_EQ(0, ret);
 		}
 
-		if (variant->sandbox == TCP_SANDBOX) {
+		if (variant->sandbox == TCP_SANDBOX ||
+		    variant->sandbox == UDP_SANDBOX) {
 			const int ruleset_fd = landlock_create_ruleset(
 				&ruleset_attr, sizeof(ruleset_attr), 0);
 			ASSERT_LE(0, ruleset_fd);
@@ -975,6 +1144,13 @@ FIXTURE_VARIANT_ADD(ipv4, tcp_sandbox_with_tcp) {
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
@@ -989,6 +1165,13 @@ FIXTURE_VARIANT_ADD(ipv4, tcp_sandbox_with_udp) {
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
@@ -1012,14 +1195,19 @@ TEST_F(ipv4, from_unix_to_inet)
 {
 	int unix_stream_fd, unix_dgram_fd;
 
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const int access_rights =
+			(variant->sandbox == TCP_SANDBOX ?
+				 LANDLOCK_ACCESS_NET_BIND_TCP |
+					 LANDLOCK_ACCESS_NET_CONNECT_TCP :
+				 LANDLOCK_ACCESS_NET_BIND_UDP |
+					 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			.handled_access_net = access_rights,
 		};
 		const struct landlock_net_port_attr tcp_bind_connect_p0 = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			.allowed_access = access_rights,
 			.port = self->srv0.port,
 		};
 		int ruleset_fd;
@@ -1680,6 +1868,7 @@ TEST_F(ipv4_tcp, with_fs)
 FIXTURE(port_specific)
 {
 	struct service_fixture srv0;
+	struct service_fixture cli1;
 };
 
 FIXTURE_VARIANT(port_specific)
@@ -1699,7 +1888,7 @@ FIXTURE_VARIANT_ADD(port_specific, no_sandbox_with_ipv4) {
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv4) {
+FIXTURE_VARIANT_ADD(port_specific, tcp_sandbox_with_ipv4) {
 	/* clang-format on */
 	.sandbox = TCP_SANDBOX,
 	.prot = {
@@ -1708,6 +1897,16 @@ FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv4) {
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
@@ -1719,7 +1918,7 @@ FIXTURE_VARIANT_ADD(port_specific, no_sandbox_with_ipv6) {
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv6) {
+FIXTURE_VARIANT_ADD(port_specific, tcp_sandbox_with_ipv6) {
 	/* clang-format on */
 	.sandbox = TCP_SANDBOX,
 	.prot = {
@@ -1728,11 +1927,22 @@ FIXTURE_VARIANT_ADD(port_specific, sandbox_with_ipv6) {
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
 
 	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
+	ASSERT_EQ(0, set_service(&self->cli1, variant->prot, 1));
 
 	setup_loopback(_metadata);
 };
@@ -1747,14 +1957,19 @@ TEST_F(port_specific, bind_connect_zero)
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
+					 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 		const struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-					      LANDLOCK_ACCESS_NET_CONNECT_TCP
+			.handled_access_net = access_rights,
 		};
-		const struct landlock_net_port_attr tcp_bind_connect_zero = {
-			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
-					  LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		const struct landlock_net_port_attr bind_connect_zero = {
+			.allowed_access = access_rights,
 			.port = 0,
 		};
 		int ruleset_fd;
@@ -1766,7 +1981,7 @@ TEST_F(port_specific, bind_connect_zero)
 		/* Checks zero port value on bind and connect actions. */
 		EXPECT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect_zero, 0));
+					    &bind_connect_zero, 0));
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -1787,11 +2002,16 @@ TEST_F(port_specific, bind_connect_zero)
 	ret = bind_variant(bind_fd, &self->srv0);
 	EXPECT_EQ(0, ret);
 
-	EXPECT_EQ(0, listen(bind_fd, backlog));
+	if (variant->prot.type == SOCK_STREAM)
+		EXPECT_EQ(0, listen(bind_fd, backlog));
 
 	/* Connects on port 0. */
 	ret = connect_variant(connect_fd, &self->srv0);
-	EXPECT_EQ(-ECONNREFUSED, ret);
+	if (variant->prot.type == SOCK_STREAM) {
+		EXPECT_EQ(-ECONNREFUSED, ret);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
 
 	/* Sets binded port for both protocol families. */
 	port = get_binded_port(bind_fd, &variant->prot);
@@ -1815,23 +2035,35 @@ TEST_F(port_specific, bind_connect_1023)
 	int bind_fd, connect_fd, ret;
 
 	/* Adds a rule layer with bind and connect actions. */
-	if (variant->sandbox == TCP_SANDBOX) {
+	if (variant->sandbox == TCP_SANDBOX ||
+	    variant->sandbox == UDP_SANDBOX) {
+		const int bind_right = (variant->sandbox == TCP_SANDBOX ?
+						LANDLOCK_ACCESS_NET_BIND_TCP :
+						LANDLOCK_ACCESS_NET_BIND_UDP);
+		const int access_rights =
+			(variant->sandbox == TCP_SANDBOX ?
+				 (LANDLOCK_ACCESS_NET_BIND_TCP |
+				  LANDLOCK_ACCESS_NET_CONNECT_TCP) :
+				 (LANDLOCK_ACCESS_NET_BIND_UDP |
+				  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP));
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
+		/* A rule with cli1's port, to use as source port. */
+		const struct landlock_net_port_attr srcport = {
+			.allowed_access = bind_right,
+			.port = self->cli1.port,
+		};
 		int ruleset_fd;
 
 		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
@@ -1840,10 +2072,15 @@ TEST_F(port_specific, bind_connect_1023)
 
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect_low_range, 0));
+					    &bind_connect_low_range, 0));
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &tcp_bind_connect, 0));
+					    &bind_connect, 0));
+		if (variant->sandbox == UDP_SANDBOX) {
+			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+						       LANDLOCK_RULE_NET_PORT,
+						       &srcport, 0));
+		}
 
 		enforce_ruleset(_metadata, ruleset_fd);
 		EXPECT_EQ(0, close(ruleset_fd));
@@ -1867,8 +2104,19 @@ TEST_F(port_specific, bind_connect_1023)
 	ret = bind_variant(bind_fd, &self->srv0);
 	clear_cap(_metadata, CAP_NET_BIND_SERVICE);
 	EXPECT_EQ(0, ret);
-	EXPECT_EQ(0, listen(bind_fd, backlog));
+	if (variant->prot.type == SOCK_STREAM)
+		EXPECT_EQ(0, listen(bind_fd, backlog));
 
+	connect_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, connect_fd);
+	if (variant->prot.type == SOCK_DGRAM) {
+		/*
+		 * We are about to connect(), but bind() is restricted, so for
+		 * UDP sockets we need to use cli1's port as source port (the
+		 * only one we are allowed to use).
+		 */
+		EXPECT_EQ(0, bind_variant(connect_fd, &self->cli1));
+	}
 	/* Connects on the binded port 1023. */
 	ret = connect_variant(connect_fd, &self->srv0);
 	EXPECT_EQ(0, ret);
@@ -1887,7 +2135,10 @@ TEST_F(port_specific, bind_connect_1023)
 	/* Binds on port 1024. */
 	ret = bind_variant(bind_fd, &self->srv0);
 	EXPECT_EQ(0, ret);
-	EXPECT_EQ(0, listen(bind_fd, backlog));
+	if (variant->prot.type == SOCK_STREAM)
+		EXPECT_EQ(0, listen(bind_fd, backlog));
+	if (variant->prot.type == SOCK_DGRAM)
+		EXPECT_EQ(0, bind_variant(connect_fd, &self->cli1));
 
 	/* Connects on the binded port 1024. */
 	ret = connect_variant(connect_fd, &self->srv0);
@@ -1897,23 +2148,30 @@ TEST_F(port_specific, bind_connect_1023)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
-static int matches_log_tcp(const int audit_fd, const char *const blockers,
-			   const char *const dir_addr, const char *const addr,
-			   const char *const dir_port)
+static int matches_auditlog(const int audit_fd, const char *const blockers,
+			    const char *const dir_addr, const char *const addr,
+			    const char *const dir_port)
 {
-	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+	static const char log_with_addrport_tmpl[] = REGEX_LANDLOCK_PREFIX
 		" blockers=%s %s=%s %s=1024$";
+	static const char log_without_addrport_tmpl[] = REGEX_LANDLOCK_PREFIX
+		" blockers=%s";
 	/*
 	 * Max strlen(blockers): 16
 	 * Max strlen(dir_addr): 5
 	 * Max strlen(addr): 12
 	 * Max strlen(dir_port): 4
 	 */
-	char log_match[sizeof(log_template) + 37];
+	char log_match[sizeof(log_with_addrport_tmpl) + 37];
 	int log_match_len;
 
-	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
-				 blockers, dir_addr, addr, dir_port);
+	if (addr == NULL)
+		log_match_len = snprintf(log_match, sizeof(log_match),
+					 log_without_addrport_tmpl, blockers);
+	else
+		log_match_len = snprintf(log_match, sizeof(log_match),
+					 log_with_addrport_tmpl, blockers,
+					 dir_addr, addr, dir_port);
 	if (log_match_len > sizeof(log_match))
 		return -E2BIG;
 
@@ -1924,6 +2182,7 @@ static int matches_log_tcp(const int audit_fd, const char *const blockers,
 FIXTURE(audit)
 {
 	struct service_fixture srv0;
+	struct service_fixture srv1;
 	struct audit_filter audit_filter;
 	int audit_fd;
 };
@@ -1935,7 +2194,7 @@ FIXTURE_VARIANT(audit)
 };
 
 /* clang-format off */
-FIXTURE_VARIANT_ADD(audit, ipv4) {
+FIXTURE_VARIANT_ADD(audit, ipv4_tcp) {
 	/* clang-format on */
 	.addr = "127\\.0\\.0\\.1",
 	.prot = {
@@ -1945,7 +2204,17 @@ FIXTURE_VARIANT_ADD(audit, ipv4) {
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
@@ -1954,9 +2223,21 @@ FIXTURE_VARIANT_ADD(audit, ipv6) {
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
+	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
+
 	setup_loopback(_metadata);
 
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -1974,9 +2255,17 @@ FIXTURE_TEARDOWN(audit)
 
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
+				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.handled_access_net = access_rights,
 	};
 	struct audit_records records;
 	int ruleset_fd, sock_fd;
@@ -1990,8 +2279,8 @@ TEST_F(audit, bind)
 	sock_fd = socket_variant(&self->srv0);
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv0));
-	EXPECT_EQ(0, matches_log_tcp(self->audit_fd, "net\\.bind_tcp", "saddr",
-				     variant->addr, "src"));
+	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "saddr",
+				      variant->addr, "src"));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
@@ -2002,9 +2291,22 @@ TEST_F(audit, bind)
 
 TEST_F(audit, connect)
 {
+	const char *audit_evt = (variant->prot.type == SOCK_STREAM ?
+					 "net\\.connect_tcp" :
+					 "net\\.connect_send_udp");
+	const int bind_right = (variant->prot.type == SOCK_STREAM ?
+					LANDLOCK_ACCESS_NET_BIND_TCP :
+					LANDLOCK_ACCESS_NET_BIND_UDP);
+	const int conn_right = (variant->prot.type == SOCK_STREAM ?
+					LANDLOCK_ACCESS_NET_CONNECT_TCP :
+					LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+	const int access_rights = bind_right | conn_right;
 	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.handled_access_net = access_rights,
+	};
+	const struct landlock_net_port_attr rule_connect_p1 = {
+		.allowed_access = conn_right,
+		.port = self->srv1.port,
 	};
 	struct audit_records records;
 	int ruleset_fd, sock_fd;
@@ -2012,19 +2314,31 @@ TEST_F(audit, connect)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &rule_connect_p1, 0));
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	sock_fd = socket_variant(&self->srv0);
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv0));
-	EXPECT_EQ(0, matches_log_tcp(self->audit_fd, "net\\.connect_tcp",
-				     "daddr", variant->addr, "dest"));
+	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "daddr",
+				      variant->addr, "dest"));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
+	if (variant->prot.type == SOCK_DGRAM) {
+		/* Check that autobind generates a denied bind event. */
+		EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv1));
+
+		EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp",
+					      NULL, NULL, NULL));
+		EXPECT_EQ(0, records.access);
+		EXPECT_EQ(1, records.domain);
+	}
+
 	EXPECT_EQ(0, close(sock_fd));
 }
 
-- 
2.39.5


