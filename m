Return-Path: <netdev+bounces-128532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EA097A239
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF0C1F24038
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA115820E;
	Mon, 16 Sep 2024 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="NaABqBJz"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD9157A59;
	Mon, 16 Sep 2024 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489490; cv=none; b=Knj4OgUdPzdRYmjRMbzwe4yImDuc/kh6VvfB96G7L0taFKo1tk6vl064jBKl5P51kcZkS1BdunaRJYpOYvbEA8c+WmD3Zvax9r/mBsK+8f/h/OfMj+QFaSXR4yBsgJYmMFawaiAvyElpJ1HNzv0JWAfqmoQEXJo1aUJF+2QJ9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489490; c=relaxed/simple;
	bh=/nlkhYDvi+9HmkfXRBtJwlHe7UqktCDrqO0xluC8jmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncFKY8J/zxiZbxJdjY/bCcSPwLDNte60pBbYXFRUJNVeiDeFsSmJ/NQ97umLkqdii1vSRmfpQBf0BXwwPqiJ3hC3C4KifzIPHBAVOS+YdCfYskWy0NWW/bIqyEFBZW/MOsitdDlgM5SkKhuWQqGTmRkvof3VFq1JzOUahNLb6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=NaABqBJz; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1726489482; bh=/nlkhYDvi+9HmkfXRBtJwlHe7UqktCDrqO0xluC8jmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaABqBJz2w4jm41sthqemUp58qwbkCYa8yT5nN2RPmNaj3CIkgEyHyPh97oKPLVII
	 jaSpc3BEx9p6M2MBkVepC/ZEeyYchba5jjq/YkDWzLNo0pt5QUT4vbb+bvU1cIyy8Q
	 +Iwrq3DX8VyBo8MIivyC9T07fffdb0JR16vMxDA2zOiinAY9PcyNvdU3xpFEThQjR0
	 0wB/LGA+/vbD+0MCRnOzjfcQyQYqxL6UNERwWYWWsJGbDYvvWXuKUqI/+eqmMnb4Cx
	 QFiYcYH1HTV4VQ5FRsq+nukz8B5bmaoW02hTIEBBGIURlfBASln6+3ha1KA/0ZLcXK
	 BjsM337mXu0pQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id CE5F21230C2;
	Mon, 16 Sep 2024 14:24:41 +0200 (CEST)
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
Subject: [RFC PATCH v1 7/7] selftests/landlock: Add UDP sendmsg/recvmsg tests
Date: Mon, 16 Sep 2024 14:22:30 +0200
Message-Id: <20240916122230.114800-8-matthieu@buffet.re>
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

Add tests specific to send/recv, orthogonal to whether the process
is allowed to bind/connect.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/net_test.c | 373 ++++++++++++++++++++
 1 file changed, 373 insertions(+)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 883e6648e79a..a02307ba069c 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -285,6 +285,29 @@ static int connect_variant(const int sock_fd,
 	return connect_variant_addrlen(sock_fd, srv, get_addrlen(srv, false));
 }
 
+static int get_msg_addr_variant(struct msghdr *msg,
+				const struct service_fixture *const srv)
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
+	msg->msg_namelen = get_addrlen(srv, false);
+	return 0;
+}
+
 FIXTURE(protocol)
 {
 	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
@@ -927,6 +950,356 @@ TEST_F(protocol, connect_unspec)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+FIXTURE(udp_send_recv)
+{
+	struct service_fixture srv_allowed;
+	struct service_fixture srv_denied;
+	struct service_fixture srv_ephemeral;
+	struct service_fixture addr_unspec0, addr_unspec1;
+	int srv_allowed_fd, srv_denied_fd, srv_ephemeral_fd, client_fd;
+	char read_buf[1];
+	struct iovec testmsg_contents;
+	struct msghdr testmsg;
+};
+
+FIXTURE_VARIANT(udp_send_recv)
+{
+	const struct protocol_variant prot;
+};
+
+FIXTURE_SETUP(udp_send_recv)
+{
+	const struct timeval read_timeout = {
+		.tv_sec = 0,
+		.tv_usec = 100000,
+	};
+	const struct protocol_variant prot_unspec = {
+		.domain = AF_UNSPEC,
+		.type = SOCK_STREAM,
+	};
+
+	disable_caps(_metadata);
+
+	ASSERT_EQ(0, set_service(&self->addr_unspec0, prot_unspec, 0));
+	ASSERT_EQ(0, set_service(&self->addr_unspec1, prot_unspec, 1));
+
+	/* Prepare one server socket to be denied */
+	ASSERT_EQ(0, set_service(&self->srv_denied, variant->prot, 0));
+	self->srv_denied_fd = socket_variant(&self->srv_denied);
+	ASSERT_LE(0, self->srv_denied_fd);
+	ASSERT_EQ(0, bind_variant(self->srv_denied_fd, &self->srv_denied));
+
+	/* Prepare one server socket on specific port to be allowed */
+	ASSERT_EQ(0, set_service(&self->srv_allowed, variant->prot, 1));
+	self->srv_allowed_fd = socket_variant(&self->srv_allowed);
+	ASSERT_LE(0, self->srv_allowed_fd);
+	ASSERT_EQ(0, bind_variant(self->srv_allowed_fd, &self->srv_allowed));
+
+	/* Prepare one server socket on ephemeral port to be allowed */
+	ASSERT_EQ(0, set_service(&self->srv_ephemeral, variant->prot, 0));
+	if (variant->prot.domain == AF_INET)
+		self->srv_ephemeral.ipv4_addr.sin_port = 0;
+	else if (variant->prot.domain == AF_INET6)
+		self->srv_ephemeral.ipv6_addr.sin6_port = 0;
+	self->srv_ephemeral_fd  = socket_variant(&self->srv_ephemeral);
+	ASSERT_LE(0, self->srv_ephemeral_fd);
+	ASSERT_EQ(0, bind_variant(self->srv_ephemeral_fd,
+				  &self->srv_ephemeral));
+	self->srv_ephemeral.port = get_binded_port(self->srv_ephemeral_fd,
+						   &variant->prot);
+	ASSERT_NE(0, self->srv_ephemeral.port);
+	if (variant->prot.domain == AF_INET)
+		self->srv_ephemeral.ipv4_addr.sin_port = htons(self->srv_ephemeral.port);
+	else if (variant->prot.domain == AF_INET6)
+		self->srv_ephemeral.ipv6_addr.sin6_port = htons(self->srv_ephemeral.port);
+
+	/* We must absolutely avoid blocking other tests indefinitely */
+	EXPECT_EQ(0, setsockopt(self->srv_allowed_fd, SOL_SOCKET,
+				SO_RCVTIMEO,
+				&read_timeout, sizeof(read_timeout)));
+	EXPECT_EQ(0, setsockopt(self->srv_denied_fd, SOL_SOCKET,
+				SO_RCVTIMEO,
+				&read_timeout, sizeof(read_timeout)));
+	EXPECT_EQ(0, setsockopt(self->srv_ephemeral_fd, SOL_SOCKET,
+				SO_RCVTIMEO,
+				&read_timeout, sizeof(read_timeout)));
+
+	self->client_fd = socket_variant(&self->srv_denied);
+	ASSERT_LE(0, self->client_fd);
+
+	self->read_buf[0] = 0;
+
+	self->testmsg_contents.iov_len = 1;
+	memset(&self->testmsg, 0, sizeof(self->testmsg));
+	self->testmsg.msg_iov = &self->testmsg_contents;
+	self->testmsg.msg_iovlen = 1;
+}
+
+FIXTURE_TEARDOWN(udp_send_recv)
+{
+	EXPECT_EQ(0, close(self->srv_allowed_fd));
+	EXPECT_EQ(0, close(self->srv_denied_fd));
+	EXPECT_EQ(0, close(self->client_fd));
+}
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(udp_send_recv, ipv4) {
+	.prot = {
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+	},
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(udp_send_recv, ipv6) {
+	.prot = {
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+	},
+};
+
+TEST_F(udp_send_recv, sendmsg)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_SENDMSG_UDP,
+	};
+	const struct landlock_net_port_attr allow_one_server = {
+		.allowed_access = LANDLOCK_ACCESS_NET_SENDMSG_UDP,
+		.port = self->srv_allowed.port,
+	};
+	const int ruleset_fd = landlock_create_ruleset(
+		&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+				       LANDLOCK_RULE_NET_PORT,
+				       &allow_one_server, 0));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Send without bind nor explicit address */
+	EXPECT_EQ(-1, write(self->client_fd, "A", 1));
+	EXPECT_EQ(EDESTADDRREQ, errno);
+
+	/* Send with an explicit denied address */
+	self->testmsg_contents.iov_base = "B";
+	EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->srv_denied));
+	EXPECT_EQ(-1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, read(self->srv_denied_fd, self->read_buf, sizeof(self->read_buf)));
+	EXPECT_EQ(EAGAIN, errno);
+
+	/* Send with an explicit allowed address */
+	self->testmsg_contents.iov_base = "C";
+	EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->srv_allowed));
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0))
+	{
+		TH_LOG("sendmsg failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(1, read(self->srv_allowed_fd, self->read_buf, sizeof(self->read_buf)));
+	EXPECT_EQ(self->read_buf[0], 'C');
+
+	/*
+	 * Sending to (AF_UNSPEC, port) should be equivalent to not specifying
+	 * a destination in IPv6, and equivalent to (AF_INET, port) in IPv4.
+	 */
+	if (variant->prot.domain == AF_INET) {
+		self->testmsg_contents.iov_base = "D";
+		EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->addr_unspec0));
+		EXPECT_EQ(-1, sendmsg(self->client_fd, &self->testmsg, 0));
+		EXPECT_EQ(EACCES, errno);
+
+		self->testmsg_contents.iov_base = "E";
+		EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->addr_unspec1));
+		EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0));
+		EXPECT_EQ(1, read(self->srv_allowed_fd, self->read_buf,
+				  sizeof(self->read_buf)));
+		EXPECT_EQ(self->read_buf[0], 'E');
+	} else if (variant->prot.domain == AF_INET6) {
+		EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->addr_unspec0));
+		EXPECT_EQ(-1, sendmsg(self->client_fd, &self->testmsg, 0));
+		EXPECT_EQ(EDESTADDRREQ, errno);
+	}
+
+	/* Send without an address, after connect()ing to an allowed address */
+	self->testmsg.msg_name = NULL;
+	self->testmsg.msg_namelen = 0;
+	self->testmsg_contents.iov_base = "F";
+	ASSERT_EQ(0, connect_variant(self->client_fd, &self->srv_allowed));
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0))
+	{
+		TH_LOG("sendmsg failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(1, read(self->srv_allowed_fd, self->read_buf,
+		  sizeof(self->read_buf)));
+	EXPECT_EQ(self->read_buf[0], 'F');
+
+	/*
+	 * Sending to AF_UNSPEC should be equivalent to not specifying an
+	 * address (in IPv6 only) and falling back to the allowed address.
+	 */
+	if (variant->prot.domain == AF_INET6) {
+		self->testmsg_contents.iov_base = "G";
+		EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->addr_unspec0));
+		EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0)) {
+			TH_LOG("sendmsg failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(1, read(self->srv_allowed_fd, self->read_buf,
+			sizeof(self->read_buf)));
+		EXPECT_EQ(self->read_buf[0], 'G');
+	}
+
+	/* Send without an address, after connect()ing to a denied address */
+	self->testmsg_contents.iov_base = "H";
+	ASSERT_EQ(0, connect_variant(self->client_fd, &self->srv_denied));
+	EXPECT_EQ(-1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, read(self->srv_denied_fd, self->read_buf, sizeof(self->read_buf)));
+	EXPECT_EQ(EAGAIN, errno);
+
+	/*
+	 * Sending to AF_UNSPEC should be equivalent to not specifying an
+	 * address (in IPv6 only) and falling back to the denied address.
+	 */
+	if (variant->prot.domain == AF_INET6) {
+		self->testmsg_contents.iov_base = "I";
+		EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->addr_unspec0));
+		EXPECT_EQ(-1, sendmsg(self->client_fd, &self->testmsg, 0));
+		EXPECT_EQ(EACCES, errno);
+	}
+
+	/* Send with an explicit allowed address, should overrule connect() */
+	self->testmsg_contents.iov_base = "J";
+	ASSERT_EQ(0, connect_variant(self->client_fd, &self->srv_denied));
+	EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->srv_allowed));
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0))
+	{
+		TH_LOG("sendmsg failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(1, read(self->srv_allowed_fd, self->read_buf, sizeof(self->read_buf)));
+	EXPECT_EQ(self->read_buf[0], 'J');
+
+	/* Send with an explicit denied address, should overrule connect() */
+	self->testmsg_contents.iov_base = "K";
+	ASSERT_EQ(0, connect_variant(self->client_fd, &self->srv_allowed));
+	EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->srv_denied));
+	EXPECT_EQ(-1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, read(self->srv_allowed_fd,
+			   self->read_buf, sizeof(self->read_buf)));
+	EXPECT_EQ(EAGAIN, errno);
+	EXPECT_EQ(-1, read(self->srv_denied_fd, self->read_buf, sizeof(self->read_buf)));
+	EXPECT_EQ(EAGAIN, errno);
+}
+
+TEST_F(udp_send_recv, recvmsg_on_fixed_port)
+{
+	struct sockaddr_storage from = {0};
+	socklen_t from_len = sizeof(from);
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_RECVMSG_UDP,
+	};
+	const struct landlock_net_port_attr allow_one_server = {
+		.allowed_access = LANDLOCK_ACCESS_NET_RECVMSG_UDP,
+		.port = self->srv_allowed.port,
+	};
+	const int ruleset_fd = landlock_create_ruleset(
+		&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+					LANDLOCK_RULE_NET_PORT,
+					&allow_one_server, 0));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Receive on an allowed port with read() */
+	EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->srv_allowed));
+	self->testmsg_contents.iov_base = "A";
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(1, read(self->srv_allowed_fd, self->read_buf,
+			  sizeof(self->read_buf))) {
+		TH_LOG("read failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(self->read_buf[0], 'A');
+
+	/* Receive on an allowed port with recv() */
+	self->testmsg_contents.iov_base = "B";
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(1, recv(self->srv_allowed_fd,
+			  self->read_buf, sizeof(self->read_buf), 0)) {
+		TH_LOG("recv failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(self->read_buf[0], 'B');
+
+	/* Receive on an allowed port with recvfrom() */
+	self->testmsg_contents.iov_base = "C";
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(1, recvfrom(self->srv_allowed_fd,
+			      self->read_buf, sizeof(self->read_buf), 0,
+			      (struct sockaddr *)&from, &from_len)) {
+		TH_LOG("recv failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(self->read_buf[0], 'C');
+
+	/* Receive on a denied port with read() */
+	EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg, &self->srv_allowed));
+	self->testmsg_contents.iov_base = "D";
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(-1, read(self->srv_denied_fd, self->read_buf, sizeof(self->read_buf)));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(self->read_buf[0], 'C');
+
+	/* Receive on an denied port with recv() */
+	self->testmsg_contents.iov_base = "B";
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(-1, recv(self->srv_denied_fd, self->read_buf,
+			   sizeof(self->read_buf), 0));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(self->read_buf[0], 'C');
+
+	/* Receive on an denied port with recvfrom() */
+	self->testmsg_contents.iov_base = "C";
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(-1, recvfrom(self->srv_denied_fd, self->read_buf,
+			       sizeof(self->read_buf), 0,
+			       (struct sockaddr *)&from, &from_len));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(self->read_buf[0], 'C');
+}
+
+TEST_F(udp_send_recv, recvmsg_on_ephemeral_port)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_RECVMSG_UDP,
+	};
+	const struct landlock_net_port_attr allow_one_server = {
+		.allowed_access = LANDLOCK_ACCESS_NET_RECVMSG_UDP,
+		.port = 0,
+	};
+	const int ruleset_fd = landlock_create_ruleset(
+		&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+				       LANDLOCK_RULE_NET_PORT,
+				       &allow_one_server, 0));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	EXPECT_EQ(0, get_msg_addr_variant(&self->testmsg,
+					  &self->srv_ephemeral));
+
+	self->testmsg_contents.iov_base = "A";
+	EXPECT_EQ(1, sendmsg(self->client_fd, &self->testmsg, 0));
+	EXPECT_EQ(1, read(self->srv_ephemeral_fd, self->read_buf,
+			  sizeof(self->read_buf))) {
+		TH_LOG("read failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(self->read_buf[0], 'A');
+}
+
 FIXTURE(ipv4)
 {
 	struct service_fixture srv0, srv1;
-- 
2.39.5


