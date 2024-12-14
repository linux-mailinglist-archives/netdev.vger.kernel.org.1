Return-Path: <netdev+bounces-151964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37A9F2060
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 19:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BDA1888EA6
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32B2194C61;
	Sat, 14 Dec 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="deuaMG/P"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6964C70;
	Sat, 14 Dec 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202032; cv=none; b=qOGPbC0sgkTjSLM7IvFv4RnhfVxoqVAXn65Wjr9Ve1wBZoSnLV2fnNRCs9L0pPO4fBl3EK3Ha+0qkasZbDlIjUwaVNeleEv6Oi3x2YXLBQuD0gFUg9E0O9gfCCwpMkI9WIzIgHjNr8pJhif4b7I32JO7picJGPX1j4XVF1aCmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202032; c=relaxed/simple;
	bh=MuGh5wpI3vhx5OaaXFQyST1d+tnPJJ9ZpRs0BzfQUBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmCBiaKf0jt8i37tFqTD2XPCTt3tzaB97U2ZPy1yN1/rseAYnCLInzSAN51LgSbZ7AQ2bGgh4D3jrHh+Gu4yKI0vIF1r0z0oNA4bi/bQliSasG7khHyuHHflt7PUtYaZUYgBMOr9ds9X0iDr8xUzbodVAAkzn3BvCdCluSEvALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=deuaMG/P; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1734202028; bh=MuGh5wpI3vhx5OaaXFQyST1d+tnPJJ9ZpRs0BzfQUBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deuaMG/PwYWxtcLCTnB1bzNbnDc2l48sxzZjK7DaRNbWL2yZ/RV35pRfklbVx0sE9
	 Dng6JZyW7txb5O+sLjebqs5DU+ADfwHxsz1Z89m6N5SPu51WFqg+ABu/2s8lVJXfJ7
	 6aumdTAfFrG1goX67D3m5kS3kkHO+mXho7IKnHYVgvrGvo3CQlgfcvj7tINmNfYZH4
	 HvRzQJc1NR2PLcJsiT1WJqDe65Bm6eeBSBKCW9nUzkOTy7V7hDHeVB1/J/yi1Z3WqD
	 a6tcte9Ln/c19lfRfnY/yTLnvgPZ22DpTK5a9tBFIkakgOK8T/dTT8ym2ghJOxHSMg
	 /yoVkw4tFU36Q==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 50D751252E0;
	Sat, 14 Dec 2024 19:47:08 +0100 (CET)
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
Subject: [PATCH v2 4/6] selftests/landlock: Add ACCESS_NET_SENDTO_UDP
Date: Sat, 14 Dec 2024 19:45:38 +0100
Message-Id: <20241214184540.3835222-5-matthieu@buffet.re>
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

Add tests specific to UDP sendmsg(), orthogonal to whether the process
is allowed to bind()/connect(). Make these tests part of the protocol_*
variants, to ensure behaviour is consistent across AF_INET, AF_INET6
and AF_UNIX.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/net_test.c | 285 +++++++++++++++++++-
 1 file changed, 282 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 40f66cccce69..05304e6b4d8f 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -256,9 +256,34 @@ static int connect_variant(const int sock_fd,
 	return connect_variant_addrlen(sock_fd, srv, get_addrlen(srv, false));
 }
 
+static int set_msg_dest(struct msghdr *msg,
+			const struct service_fixture *const srv,
+			const bool minimal_addrlen)
+{
+	switch (srv->protocol.domain) {
+	case AF_UNSPEC:
+	case AF_INET:
+		msg->msg_name = (void *)&srv->ipv4_addr;
+		break;
+	case AF_INET6:
+		msg->msg_name = (void *)&srv->ipv6_addr;
+		break;
+	case AF_UNIX:
+		msg->msg_name = (void *)&srv->unix_addr;
+		break;
+	default:
+		errno = -EAFNOSUPPORT;
+		return -errno;
+	}
+
+	msg->msg_namelen = get_addrlen(srv, minimal_addrlen);
+	return 0;
+}
+
 FIXTURE(protocol)
 {
-	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
+	struct service_fixture srv0, srv1, srv2;
+	struct service_fixture unspec_any0, unspec_srv0, unspec_srv1;
 };
 
 FIXTURE_VARIANT(protocol)
@@ -281,6 +306,7 @@ FIXTURE_SETUP(protocol)
 	ASSERT_EQ(0, set_service(&self->srv2, variant->prot, 2));
 
 	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
+	ASSERT_EQ(0, set_service(&self->unspec_srv1, prot_unspec, 1));
 
 	ASSERT_EQ(0, set_service(&self->unspec_any0, prot_unspec, 0));
 	self->unspec_any0.ipv4_addr.sin_addr.s_addr = htonl(INADDR_ANY);
@@ -919,6 +945,258 @@ TEST_F(protocol, connect_unspec)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+TEST_F(protocol, sendmsg)
+{
+	const struct timeval read_timeout = {
+		.tv_sec = 0,
+		.tv_usec = 100000,
+	};
+	const bool sandboxed = variant->sandbox == UDP_SANDBOX &&
+			       variant->prot.type == SOCK_DGRAM &&
+			       (variant->prot.domain == AF_INET ||
+				variant->prot.domain == AF_INET6);
+	int srv1_fd, srv0_fd, client_fd;
+	char read_buf[1] = { 0 };
+	struct iovec testmsg_contents = { 0 };
+	struct msghdr testmsg = { 0 };
+
+	if (variant->prot.type != SOCK_DGRAM)
+		return;
+
+	disable_caps(_metadata);
+
+	/* Prepare one server socket to be denied */
+	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
+	srv0_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, srv0_fd);
+	ASSERT_EQ(0, bind_variant(srv0_fd, &self->srv0));
+
+	/* Prepare one server socket on specific port to be allowed */
+	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
+	srv1_fd = socket_variant(&self->srv1);
+	ASSERT_LE(0, srv1_fd);
+	ASSERT_EQ(0, bind_variant(srv1_fd, &self->srv1));
+
+	/* Arbitrary value just to not block other tests indefinitely */
+	EXPECT_EQ(0, setsockopt(srv1_fd, SOL_SOCKET, SO_RCVTIMEO, &read_timeout,
+				sizeof(read_timeout)));
+	EXPECT_EQ(0, setsockopt(srv0_fd, SOL_SOCKET, SO_RCVTIMEO, &read_timeout,
+				sizeof(read_timeout)));
+
+	client_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, client_fd);
+
+	if (sandboxed) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net = LANDLOCK_ACCESS_NET_SENDTO_UDP |
+					      LANDLOCK_ACCESS_NET_BIND_UDP,
+		};
+		const struct landlock_net_port_attr allow_one_server = {
+			.allowed_access = LANDLOCK_ACCESS_NET_SENDTO_UDP,
+			.port = self->srv1.port,
+		};
+		const int ruleset_fd = landlock_create_ruleset(
+			&ruleset_attr, sizeof(ruleset_attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		ASSERT_EQ(0,
+			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+					    &allow_one_server, 0));
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+	}
+
+	testmsg_contents.iov_len = 1;
+	testmsg.msg_iov = &testmsg_contents;
+	testmsg.msg_iovlen = 1;
+
+	/* Without bind nor explicit address+port */
+	EXPECT_EQ(-1, write(client_fd, "A", 1));
+	if (variant->prot.domain == AF_UNIX) {
+		EXPECT_EQ(ENOTCONN, errno);
+	} else {
+		EXPECT_EQ(EDESTADDRREQ, errno);
+	}
+
+	/* With non-NULL but too small explicit address */
+	testmsg_contents.iov_base = "B";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->srv0, false));
+	testmsg.msg_namelen = get_addrlen(&self->srv0, true) - 1;
+	EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* With minimal explicit address length and denied port */
+	testmsg_contents.iov_base = "C";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->srv0, true));
+	if (self->srv0.protocol.domain == AF_UNIX) {
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(EINVAL, errno);
+	} else if (sandboxed) {
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(EACCES, errno);
+	} else {
+		EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+		EXPECT_EQ(read_buf[0], 'C');
+	}
+
+	/* With minimal explicit address length and allowed port */
+	testmsg_contents.iov_base = "D";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->srv1, true));
+	if (self->srv0.protocol.domain == AF_UNIX) {
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(EINVAL, errno);
+	} else {
+		EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(1, read(srv1_fd, read_buf, 1));
+		EXPECT_EQ(read_buf[0], 'D');
+	}
+
+	/* With explicit denied port */
+	testmsg_contents.iov_base = "E";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->srv0, false));
+	if (sandboxed) {
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(EACCES, errno);
+		EXPECT_EQ(-1, read(srv0_fd, read_buf, 1));
+		EXPECT_EQ(EAGAIN, errno);
+	} else {
+		EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0))
+		{
+			TH_LOG("sendmsg failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+		EXPECT_EQ(read_buf[0], 'E');
+	}
+
+	/* With explicit allowed port */
+	testmsg_contents.iov_base = "F";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->srv1, false));
+	EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0))
+	{
+		TH_LOG("sendmsg failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(1, read(srv1_fd, read_buf, 1));
+	EXPECT_EQ(read_buf[0], 'F');
+
+	/*
+	 * With an explicit (AF_UNSPEC, port), should be equivalent to
+	 * (AF_INET, port) in IPv4, and to not specifying a destination
+	 * in IPv6 (which fails since the socket is not connected).
+	 */
+	testmsg_contents.iov_base = "G";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->unspec_srv0, false));
+	if (sandboxed || variant->prot.domain != AF_INET) {
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		if (variant->prot.domain == AF_INET) {
+			EXPECT_EQ(EACCES, errno);
+		} else if (variant->prot.domain == AF_UNIX) {
+			EXPECT_EQ(EINVAL, errno);
+		} else {
+			EXPECT_EQ(EDESTADDRREQ, errno);
+		}
+	} else {
+		EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0))
+		{
+			TH_LOG("sendmsg failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+		EXPECT_EQ(read_buf[0], 'G');
+	}
+	testmsg_contents.iov_base = "H";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->unspec_srv1, false));
+	if (variant->prot.domain == AF_INET) {
+		EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0))
+		{
+			TH_LOG("sendmsg failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(1, read(srv1_fd, read_buf, 1));
+		EXPECT_EQ(read_buf[0], 'H');
+	} else {
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		if (variant->prot.domain == AF_INET6) {
+			EXPECT_EQ(EDESTADDRREQ, errno);
+		} else {
+			EXPECT_EQ(EINVAL, errno);
+		}
+	}
+
+	/* Without address, connect()ed to an allowed address+port */
+	testmsg.msg_name = NULL;
+	testmsg.msg_namelen = 0;
+	testmsg_contents.iov_base = "I";
+	ASSERT_EQ(0, connect_variant(client_fd, &self->srv1));
+	EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0))
+	{
+		TH_LOG("sendmsg failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(1, read(srv1_fd, read_buf, 1));
+	EXPECT_EQ(read_buf[0], 'I');
+
+	/* Without address, connect()ed to a denied address+port */
+	testmsg.msg_name = NULL;
+	testmsg.msg_namelen = 0;
+	testmsg_contents.iov_base = "J";
+	ASSERT_EQ(0, connect_variant(client_fd, &self->srv0));
+	EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0))
+	{
+		TH_LOG("sendmsg failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+	EXPECT_EQ(read_buf[0], 'J');
+
+	/*
+	 * Sending to AF_UNSPEC should be equivalent to not specifying an
+	 * address (in IPv6 only) and falling back to the connected address
+	 */
+	testmsg_contents.iov_base = "K";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->unspec_srv0, false));
+	if (sandboxed && variant->prot.domain == AF_INET) {
+		/* IPv4 -> parsed as srv0 which is denied */
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(EACCES, errno);
+	} else if (variant->prot.domain == AF_UNIX) {
+		/* Unix socket don't accept AF_UNSPEC */
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(EINVAL, errno);
+	} else {
+		/*
+		 * IPv6 -> parsed as "no address" so it uses the connected
+		 * one srv1 which is allowed
+		 */
+		EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0))
+		{
+			TH_LOG("sendmsg failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+		EXPECT_EQ(read_buf[0], 'K');
+	}
+
+	testmsg_contents.iov_base = "L";
+	EXPECT_EQ(0, set_msg_dest(&testmsg, &self->unspec_srv1, false));
+	if (variant->prot.domain == AF_UNIX) {
+		EXPECT_EQ(-1, sendmsg(client_fd, &testmsg, 0));
+		EXPECT_EQ(EINVAL, errno);
+	} else {
+		EXPECT_EQ(1, sendmsg(client_fd, &testmsg, 0))
+		{
+			TH_LOG("sendmsg failed: %s", strerror(errno));
+		}
+
+		if (variant->prot.domain == AF_INET) {
+			/* IPv4 -> parsed as srv1 */
+			EXPECT_EQ(1, read(srv1_fd, read_buf, 1));
+		} else {
+			/*
+			 * IPv6 -> parsed as "no address" so it uses the
+			 * connected one, srv0
+			 */
+			EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+		}
+
+		EXPECT_EQ(read_buf[0], 'L');
+	}
+}
+
 FIXTURE(ipv4)
 {
 	struct service_fixture srv0, srv1;
@@ -1295,13 +1573,14 @@ FIXTURE_TEARDOWN(mini)
 
 /* clang-format off */
 
-#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_UDP
+#define ACCESS_LAST LANDLOCK_ACCESS_NET_SENDTO_UDP
 
 #define ACCESS_ALL ( \
 	LANDLOCK_ACCESS_NET_BIND_TCP | \
 	LANDLOCK_ACCESS_NET_CONNECT_TCP | \
 	LANDLOCK_ACCESS_NET_BIND_UDP | \
-	LANDLOCK_ACCESS_NET_CONNECT_UDP)
+	LANDLOCK_ACCESS_NET_CONNECT_UDP | \
+	LANDLOCK_ACCESS_NET_SENDTO_UDP)
 
 /* clang-format on */
 
-- 
2.39.5


