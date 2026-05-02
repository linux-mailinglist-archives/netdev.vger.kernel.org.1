Return-Path: <netdev+bounces-283403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J+MHG7y9WmVQgIAu9opvQ
	(envelope-from <netdev+bounces-283403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:47:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF744B2059
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46CF9302FAB3
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DB36CE10;
	Sat,  2 May 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="gIOimasH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F930E83A;
	Sat,  2 May 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725882; cv=none; b=vD39uEinkXecpQN02irLNI+PaNPTWtSYwcH1SBEVF4JSHv2PFkvlU93JHOl3x2kCsgczwgKhcrBEvHKahP6jcLzPMOwCYD8eUKMO50Q/mt4BmiLLWQI23azlHq4O7MCQqwxXb3PUhCuiNDMXWEtvUP673fvczBGppKxhZ66p6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725882; c=relaxed/simple;
	bh=01fbAQoKtDbjyosDucSA5StKbVbRt73z+ZcT7dH9r9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T80ACwrkz0hauKb2YnCbDs+cUG3YBCqCqVTy/GbB1wmEef+Gz31vf9Ie3TGqcHqlouPRx2XyHWkZckJdFNa2QKxgJcxVzNtdM1FJdJE0PQgQPjyfVKZSB7tvGS6k7KyUtsaZ+6yeoLkPHrHpk8SZSvdd5s+7xmqHZIyoD1mtZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=gIOimasH; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1777725878; bh=01fbAQoKtDbjyosDucSA5StKbVbRt73z+ZcT7dH9r9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIOimasHheyVBOgQAjI5BGor1P7u5qoH4w3MTo9/T67ZuOpZiyWN1+Td95Bf2M9ur
	 /gJzjBLI/VRmOJNQaei0u0PeD6PG5hw3DZBlzGkexzxscrl/ON1SEsXFaf/7dmgAhF
	 yuk7/VtgDRJ0UKGdzk7if1viMCUrfnSpsHX7BfeBJLp6+vwnzPO7Y6jUAWa0YP7AIt
	 dO603WHyoblosfZD/yE8aL95mAMEt4yg9lKBW2kKoES6FbpMcctcsYdTXPdHaJDQPv
	 TxhCxtwwlvITrw1xOmNZvnAcdTIdonfHtBUisrNkYvjmLFonArwEO+Au9mFweR6TE0
	 zD/y8JudSfJJQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id E9217125922;
	Sat,  2 May 2026 14:44:37 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v4 5/7] selftests/landlock: Add tests for sendmsg()
Date: Sat,  2 May 2026 14:43:04 +0200
Message-Id: <20260502124306.3975990-6-matthieu@buffet.re>
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
X-Rspamd-Queue-Id: EEF744B2059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283403-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,buffet.re:email,buffet.re:dkim,buffet.re:mid]

Add tests specific to UDP sendmsg() in the protocol_* variants to ensure
behaviour is consistent across AF_INET, AF_INET6 and AF_UNIX.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/net_test.c | 652 +++++++++++++++++++-
 1 file changed, 651 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 568a6ed7139c..2c72fda3c606 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -289,9 +289,163 @@ static int connect_variant(const int sock_fd,
 	return connect_variant_addrlen(sock_fd, srv, get_addrlen(srv, false));
 }
 
+static int sendto_variant_addrlen(const int sock_fd,
+				  const struct service_fixture *const srv,
+				  const socklen_t addrlen, void *buf,
+				  size_t len, size_t flags)
+{
+	const struct sockaddr *dst = NULL;
+	ssize_t ret;
+
+	/*
+	 * We never want our processes to be killed by SIGPIPE: we check
+	 * return codes and errno, so that we have actual error messages.
+	 */
+	flags |= MSG_NOSIGNAL;
+
+	if (srv != NULL) {
+		switch (srv->protocol.domain) {
+		case AF_UNSPEC:
+		case AF_INET:
+			dst = (const struct sockaddr *)&srv->ipv4_addr;
+			break;
+
+		case AF_INET6:
+			dst = (const struct sockaddr *)&srv->ipv6_addr;
+			break;
+
+		case AF_UNIX:
+			dst = (const struct sockaddr *)&srv->unix_addr;
+			break;
+
+		default:
+			errno = EAFNOSUPPORT;
+			return -errno;
+		}
+	}
+
+	ret = sendto(sock_fd, buf, len, flags, dst, addrlen);
+	if (ret < 0)
+		return -errno;
+
+	/* errno is not set in cases of partial writes. */
+	if (ret != len)
+		return -EINTR;
+
+	return 0;
+}
+
+static int sendto_variant(const int sock_fd,
+			  const struct service_fixture *const srv, void *buf,
+			  size_t len, size_t flags)
+{
+	socklen_t addrlen = 0;
+
+	if (srv != NULL)
+		addrlen = get_addrlen(srv, false);
+
+	return sendto_variant_addrlen(sock_fd, srv, addrlen, buf, len, flags);
+}
+
+static int test_sendmsg(struct __test_metadata *const _metadata,
+			const struct protocol_variant *prot, int client_fd,
+			int server_fd, const struct service_fixture *srv,
+			bool bind_denied, bool send_denied)
+{
+	int ret;
+	socklen_t opt_len;
+	int sock_type;
+	int addr_family;
+	struct sockaddr_storage peer_addr = { 0 };
+	bool has_remote_port;
+	bool needs_autobind;
+	char read_buf[1] = { 0 };
+
+	/*
+	 * Prepare the test by inspecting the socket type and whether it
+	 * has a local/remote address set (all of which determine the
+	 * expected outcomes).
+	 */
+	opt_len = sizeof(sock_type);
+	ASSERT_EQ(0, getsockopt(client_fd, SOL_SOCKET, SO_TYPE, &sock_type,
+				&opt_len));
+	opt_len = sizeof(addr_family);
+	ASSERT_EQ(0, getsockopt(client_fd, SOL_SOCKET, SO_DOMAIN, &addr_family,
+				&opt_len));
+	opt_len = sizeof(peer_addr);
+	has_remote_port = (getpeername(client_fd, (struct sockaddr *)&peer_addr,
+				       &opt_len) == 0);
+	needs_autobind = (addr_family == AF_INET || addr_family == AF_INET6) &&
+			 get_binded_port(client_fd, prot) == 0;
+
+	/* First, check error code with truncated explicit address. */
+	if (srv != NULL) {
+		ret = sendto_variant_addrlen(
+			client_fd, srv, get_addrlen(srv, true) - 1, "A", 1, 0);
+		if (sock_type == SOCK_STREAM && !has_remote_port) {
+			EXPECT_EQ(-EPIPE, ret)
+			{
+				return -1;
+			}
+		} else if (bind_denied && needs_autobind) {
+			EXPECT_EQ(-EACCES, ret)
+			{
+				return -1;
+			}
+		} else {
+			EXPECT_EQ(-EINVAL, ret)
+			{
+				return -1;
+			}
+		}
+	}
+
+	/* With or without explicit destination address (srv can be NULL). */
+	ret = sendto_variant(client_fd, srv, "B", 1, 0);
+	if (sock_type == SOCK_STREAM && !has_remote_port) {
+		EXPECT_EQ(-EPIPE, ret)
+		{
+			return -1;
+		}
+	} else if ((send_denied && srv != NULL) ||
+		   (bind_denied && needs_autobind)) {
+		ASSERT_EQ(-EACCES, ret)
+		{
+			return -1;
+		}
+	} else if (srv == NULL && !has_remote_port) {
+		if (addr_family == AF_UNIX) {
+			ASSERT_EQ(-ENOTCONN, ret)
+			{
+				return -1;
+			}
+		} else if (sock_type == SOCK_STREAM) {
+			ASSERT_EQ(-EPIPE, ret)
+			{
+				return -1;
+			}
+		} else {
+			ASSERT_EQ(-EDESTADDRREQ, ret)
+			{
+				return -1;
+			}
+		}
+	} else {
+		ASSERT_EQ(0, ret);
+		ASSERT_EQ(1, recv(server_fd, read_buf, 1, 0));
+		ASSERT_EQ(read_buf[0], 'B')
+		{
+			return -1;
+		}
+	}
+
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
@@ -313,6 +467,7 @@ FIXTURE_SETUP(protocol)
 	ASSERT_EQ(0, set_service(&self->srv2, variant->prot, 2));
 
 	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
+	ASSERT_EQ(0, set_service(&self->unspec_srv1, prot_unspec, 1));
 
 	ASSERT_EQ(0, set_service(&self->unspec_any0, prot_unspec, 0));
 	self->unspec_any0.ipv4_addr.sin_addr.s_addr = htonl(INADDR_ANY);
@@ -1119,6 +1274,441 @@ TEST_F(protocol, connect_unspec)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+TEST_F(protocol, sendmsg_stream)
+{
+	int srv0_fd, tmp_fd, client_fd, res;
+	char read_buf[1] = { 0 };
+
+	/*
+	 * Simple test for stream sockets: just deny all connect()/
+	 * send(explicit addr)/bind(), and make sure we don't interfere
+	 * with any operation.
+	 */
+	if (variant->prot.type != SOCK_STREAM)
+		return;
+
+	if (variant->sandbox == UDP_SANDBOX) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net =
+				LANDLOCK_ACCESS_NET_BIND_UDP |
+				LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+		};
+		const int ruleset_fd = landlock_create_ruleset(
+			&ruleset_attr, sizeof(ruleset_attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+	}
+
+	ASSERT_LE(0, client_fd = socket_variant(&self->srv0));
+	ASSERT_LE(0, srv0_fd = socket_variant(&self->srv0));
+	ASSERT_EQ(0, bind_variant(srv0_fd, &self->srv0));
+	ASSERT_EQ(0, listen(srv0_fd, backlog));
+
+	/* Send on a non-connected socket. */
+	res = sendto_variant(client_fd, NULL, "A", 1, 0);
+	if (variant->prot.domain == AF_UNIX) {
+		EXPECT_EQ(-ENOTCONN, res);
+	} else {
+		EXPECT_EQ(-EPIPE, res);
+	}
+
+	/* Send to a truncated (invalid) address on a non-connected socket. */
+	res = sendto_variant_addrlen(client_fd, &self->srv0,
+				     get_addrlen(&self->srv0, true) - 1, "B", 1,
+				     0);
+	if (variant->prot.domain == AF_UNIX) {
+		EXPECT_EQ(-EOPNOTSUPP, res);
+	} else {
+		EXPECT_EQ(-EPIPE, res);
+	}
+
+	/* Connect. */
+	ASSERT_EQ(0, connect_variant(client_fd, &self->srv0));
+	tmp_fd = accept(srv0_fd, NULL, 0);
+	ASSERT_LE(0, tmp_fd);
+	EXPECT_EQ(0, close(srv0_fd));
+	srv0_fd = tmp_fd;
+
+	/* Send without an explicit address. */
+	EXPECT_EQ(0, sendto_variant(client_fd, NULL, "C", 1, 0));
+	EXPECT_EQ(1, recv(srv0_fd, read_buf, 1, 0))
+	{
+		TH_LOG("recv() failed: %s", strerror(errno));
+	}
+	EXPECT_EQ(read_buf[0], 'C');
+
+	/* Send to a truncated (invalid) address. */
+	res = sendto_variant_addrlen(client_fd, &self->srv0,
+				     get_addrlen(&self->srv0, true) - 1, "D", 1,
+				     0);
+	if (variant->prot.domain == AF_UNIX) {
+		EXPECT_EQ(-EISCONN, res);
+	} else {
+		EXPECT_EQ(0, res);
+		EXPECT_EQ(1, recv(srv0_fd, read_buf, 1, 0))
+		{
+			TH_LOG("recv() failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(read_buf[0], 'D');
+	}
+
+	/* Send to a valid but different address. */
+	res = sendto_variant(client_fd, &self->srv1, "E", 1, 0);
+	if (variant->prot.domain == AF_UNIX) {
+		EXPECT_EQ(-EISCONN, res);
+	} else {
+		EXPECT_EQ(0, res);
+		EXPECT_EQ(1, recv(srv0_fd, read_buf, 1, 0))
+		{
+			TH_LOG("recv() failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(read_buf[0], 'E');
+	}
+
+	EXPECT_EQ(0, close(client_fd));
+}
+
+TEST_F(protocol, sendmsg_dgram)
+{
+	const bool restricted = is_restricted(&variant->prot, variant->sandbox);
+	int srv0_fd, srv1_fd, client_fd, child, status, res;
+
+	if (variant->prot.type != SOCK_DGRAM)
+		return;
+
+	/* Prepare server on port #0 to be allowed. */
+	ASSERT_LE(0, srv0_fd = socket_variant(&self->srv0));
+	ASSERT_EQ(0, bind_variant(srv0_fd, &self->srv0));
+
+	/* And another server on port #1 to be denied. */
+	ASSERT_LE(0, srv1_fd = socket_variant(&self->srv1));
+	ASSERT_EQ(0, bind_variant(srv1_fd, &self->srv1));
+
+	/*
+	 * Check that sockets connected before restrictions are not
+	 * impacted in any way.
+	 */
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		ASSERT_LE(0, client_fd = socket_variant(&self->srv0));
+		ASSERT_EQ(0, connect_variant(client_fd, &self->srv0));
+		if (variant->sandbox == UDP_SANDBOX) {
+			/* Deny all connect()/send(explicit addr)/bind(). */
+			const struct landlock_ruleset_attr ruleset_attr = {
+				.handled_access_net =
+					LANDLOCK_ACCESS_NET_BIND_UDP |
+					LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+			};
+			const int ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			ASSERT_LE(0, ruleset_fd);
+			enforce_ruleset(_metadata, ruleset_fd);
+			EXPECT_EQ(0, close(ruleset_fd));
+		}
+		EXPECT_EQ(0,
+			  test_sendmsg(_metadata, &variant->prot, client_fd,
+				       srv0_fd, NULL, restricted, restricted));
+		EXPECT_EQ(0, test_sendmsg(_metadata, &variant->prot, client_fd,
+					  srv0_fd, &self->srv0, restricted,
+					  restricted));
+		EXPECT_EQ(0, test_sendmsg(_metadata, &variant->prot, client_fd,
+					  srv1_fd, &self->srv1, restricted,
+					  restricted));
+		EXPECT_EQ(0, close(client_fd));
+		_exit(_metadata->exit_code);
+	}
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/*
+	 * Restrict connect/send, but not bind(). Then try sending with
+	 * no destination (and no remote peer set), an allowed
+	 * destination, then a denied destination.
+	 */
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		if (variant->sandbox == UDP_SANDBOX) {
+			const struct landlock_ruleset_attr ruleset_attr = {
+				.handled_access_net =
+					LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+			};
+			const struct landlock_net_port_attr send_p0 = {
+				.allowed_access =
+					LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+				.port = self->srv0.port,
+			};
+			const int ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			ASSERT_LE(0, ruleset_fd);
+			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+						       LANDLOCK_RULE_NET_PORT,
+						       &send_p0, 0));
+			enforce_ruleset(_metadata, ruleset_fd);
+			EXPECT_EQ(0, close(ruleset_fd));
+		}
+		ASSERT_LE(0, client_fd = socket_variant(&self->srv0));
+		EXPECT_EQ(0, test_sendmsg(_metadata, &variant->prot, client_fd,
+					  -1, NULL, false, false));
+		EXPECT_EQ(0, test_sendmsg(_metadata, &variant->prot, client_fd,
+					  srv0_fd, &self->srv0, false, false));
+		EXPECT_EQ(0, test_sendmsg(_metadata, &variant->prot, client_fd,
+					  srv1_fd, &self->srv1, false,
+					  restricted));
+		EXPECT_EQ(0, close(client_fd));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/*
+	 * Rest of this test is just for autobind enforcement, which only
+	 * exists in IP sockets.
+	 */
+	if (variant->prot.domain != AF_INET && variant->prot.domain != AF_INET6)
+		return;
+
+	/* Restrict bind() to explicit calls with an arbitrary (non-0) port. */
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		const uint16_t allowed_src_port = 42424;
+		struct service_fixture allowed_src;
+
+		allowed_src = self->srv0;
+		set_port(&allowed_src, allowed_src_port);
+		if (variant->sandbox == UDP_SANDBOX) {
+			const struct landlock_ruleset_attr ruleset_attr = {
+				.handled_access_net =
+					LANDLOCK_ACCESS_NET_BIND_UDP,
+			};
+			const struct landlock_net_port_attr rule = {
+				.allowed_access = LANDLOCK_ACCESS_NET_BIND_UDP,
+				.port = allowed_src_port,
+			};
+			const int ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			ASSERT_LE(0, ruleset_fd);
+			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+						       LANDLOCK_RULE_NET_PORT,
+						       &rule, 0));
+			enforce_ruleset(_metadata, ruleset_fd);
+			EXPECT_EQ(0, close(ruleset_fd));
+		}
+		ASSERT_LE(0, client_fd = socket_variant(&self->srv0));
+
+		/* Check that implicit bind(0) in sendmsg() is denied. */
+		EXPECT_EQ(0, test_sendmsg(_metadata, &variant->prot, client_fd,
+					  srv0_fd, &self->srv0, restricted,
+					  false));
+
+		/* Same thing for autobind in connect(). */
+		res = connect_variant(client_fd, &self->srv0);
+		if (restricted) {
+			EXPECT_EQ(-EACCES, res);
+		} else {
+			EXPECT_EQ(0, res);
+		}
+		EXPECT_EQ(0, close(client_fd));
+
+		/* Make sendmsg() work by explicitly binding to the only allowed port. */
+		ASSERT_LE(0, client_fd = socket_variant(&self->srv0));
+		EXPECT_EQ(0, bind_variant(client_fd, &allowed_src));
+		EXPECT_EQ(0, test_sendmsg(_metadata, &variant->prot, client_fd,
+					  srv0_fd, &self->srv0, restricted,
+					  false));
+		EXPECT_EQ(0, close(client_fd));
+
+		/* Make connect() work by explicitly binding to the only allowed port. */
+		ASSERT_LE(0, client_fd = socket_variant(&self->srv0));
+		EXPECT_EQ(0, bind_variant(client_fd, &allowed_src));
+		EXPECT_EQ(0, connect_variant(client_fd, &self->srv0));
+		EXPECT_EQ(0, close(client_fd));
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/*
+	 * Check that %LANDLOCK_ACCESS_NET_BIND_UDP on port 0 allows
+	 * implicit autobinds.
+	 */
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		if (variant->sandbox == UDP_SANDBOX) {
+			const struct landlock_ruleset_attr ruleset_attr = {
+				.handled_access_net =
+					LANDLOCK_ACCESS_NET_BIND_UDP,
+			};
+			const struct landlock_net_port_attr rule = {
+				.allowed_access = LANDLOCK_ACCESS_NET_BIND_UDP,
+				.port = 0,
+			};
+			const int ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			ASSERT_LE(0, ruleset_fd);
+			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+						       LANDLOCK_RULE_NET_PORT,
+						       &rule, 0));
+			enforce_ruleset(_metadata, ruleset_fd);
+			EXPECT_EQ(0, close(ruleset_fd));
+		}
+		ASSERT_LE(0, client_fd = socket_variant(&self->srv0));
+		EXPECT_EQ(0, test_sendmsg(_metadata, &variant->prot, client_fd,
+					  srv0_fd, &self->srv0, false, false));
+		EXPECT_EQ(0, close(client_fd));
+		_exit(_metadata->exit_code);
+	}
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+}
+
+TEST_F(protocol, sendmsg_unspec)
+{
+	const bool restricted = is_restricted(&variant->prot, variant->sandbox);
+	int client_fd, srv0_fd, srv1_fd, res;
+	char read_buf[1] = { 0 };
+
+	/*
+	 * We already test for the absence of influence on sendmsg for
+	 * other socket types and other address families, there's no
+	 * point in adapting this test for stream sockets too.
+	 */
+	if (variant->prot.type != SOCK_DGRAM)
+		return;
+
+	/* Prepare client of the right family. */
+	ASSERT_LE(0, client_fd = socket_variant(&self->srv0));
+
+	/* Prepare server on port #0 to be allowed. */
+	ASSERT_LE(0, srv0_fd = socket_variant(&self->srv0));
+	ASSERT_EQ(0, bind_variant(srv0_fd, &self->srv0));
+
+	/* And another server on port #1 to be denied. */
+	ASSERT_LE(0, srv1_fd = socket_variant(&self->srv1));
+	ASSERT_EQ(0, bind_variant(srv1_fd, &self->srv1));
+
+	if (variant->sandbox == UDP_SANDBOX) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net =
+				LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+		};
+		const struct landlock_net_port_attr rule = {
+			.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+			.port = self->srv0.port,
+		};
+		const int ruleset_fd = landlock_create_ruleset(
+			&ruleset_attr, sizeof(ruleset_attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		ASSERT_EQ(0,
+			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+					    &rule, 0));
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+	}
+
+	/* Explicit AF_UNSPEC address but truncated. */
+	EXPECT_EQ(-EINVAL, sendto_variant_addrlen(
+				   client_fd, &self->unspec_srv0,
+				   get_addrlen(&self->unspec_srv0, true) - 1,
+				   "A", 1, 0));
+
+	/*
+	 * Explicit AF_UNSPEC address, should be treated as AF_INET by
+	 * IPv4 sockets (and thus map to srv0, allowed), but be denied by
+	 * IPv6 sockets.
+	 */
+	res = sendto_variant(client_fd, &self->unspec_srv0, "B", 1, 0);
+	if (variant->prot.domain == AF_INET6) {
+		if (restricted) {
+			/* Always denied on IPv6 socket. */
+			EXPECT_EQ(-EACCES, res);
+		} else {
+			/* IPv6 sockets treat AF_UNSPEC as a NULL address. */
+			EXPECT_EQ(-EDESTADDRREQ, res);
+		}
+	} else if (variant->prot.domain == AF_INET) {
+		EXPECT_EQ(0, res);
+		EXPECT_EQ(1, read(srv0_fd, read_buf, 1))
+		{
+			TH_LOG("read() failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(read_buf[0], 'B');
+	} else {
+		/* Unix sockets don't accept AF_UNSPEC. */
+		EXPECT_EQ(-EINVAL, res);
+	}
+
+	/*
+	 * Explicit AF_UNSPEC address, should be treated as AF_INET on
+	 * IPv4 sockets (and thus map to srv1, denied), and be denied
+	 * on IPv6 sockets as always.
+	 */
+	res = sendto_variant(client_fd, &self->unspec_srv1, "C", 1, 0);
+	if (variant->prot.domain == AF_INET6) {
+		if (restricted) {
+			/* Always denied on IPv6 socket. */
+			EXPECT_EQ(-EACCES, res);
+		} else {
+			/* IPv6 sockets treat AF_UNSPEC as a NULL address. */
+			EXPECT_EQ(-EDESTADDRREQ, res);
+		}
+	} else if (variant->prot.domain == AF_INET) {
+		if (restricted) {
+			/* Sending to srv1 is not allowed, only srv0. */
+			EXPECT_EQ(-EACCES, res);
+		} else {
+			EXPECT_EQ(0, res);
+			EXPECT_EQ(1, read(srv1_fd, read_buf, 1))
+			{
+				TH_LOG("read() failed: %s", strerror(errno));
+			}
+			EXPECT_EQ(read_buf[0], 'C');
+		}
+	} else {
+		/* Unix sockets don't accept AF_UNSPEC. */
+		EXPECT_EQ(-EINVAL, res);
+	}
+
+	ASSERT_EQ(0, connect_variant(client_fd, &self->srv0));
+
+	/* Minimal explicit AF_UNSPEC address (just the sa_family_t field) */
+	res = sendto_variant_addrlen(client_fd, &self->unspec_srv0,
+				     get_addrlen(&self->unspec_srv0, true), "D",
+				     1, 0);
+	if (variant->prot.domain == AF_INET6) {
+		if (restricted) {
+			/* AF_UNSPEC is always denied in IPv6. */
+			EXPECT_EQ(-EACCES, res);
+		} else {
+			/*
+			 * IPv6 sockets treat AF_UNSPEC as a NULL address,
+			 * falling back to the connected address.
+			 */
+			EXPECT_EQ(0, res);
+			EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+			EXPECT_EQ(read_buf[0], 'D');
+		}
+	} else {
+		/*
+		 * IPv4 socket will expect a struct sockaddr_in, our address
+		 * is considered truncated.
+		 * And Unix sockets don't accept AF_UNSPEC at all.
+		 */
+		EXPECT_EQ(-EINVAL, res);
+	}
+}
+
 FIXTURE(ipv4)
 {
 	struct service_fixture srv0, srv1;
@@ -2183,6 +2773,7 @@ FIXTURE(audit)
 {
 	struct service_fixture srv0;
 	struct service_fixture srv1;
+	struct service_fixture unspec_srv0;
 	struct audit_filter audit_filter;
 	int audit_fd;
 };
@@ -2235,8 +2826,13 @@ FIXTURE_VARIANT_ADD(audit, ipv6_udp) {
 
 FIXTURE_SETUP(audit)
 {
+	struct protocol_variant prot_unspec = variant->prot;
+
+	prot_unspec.domain = AF_UNSPEC;
+
 	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
 	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
+	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
 
 	setup_loopback(_metadata);
 
@@ -2342,4 +2938,58 @@ TEST_F(audit, connect)
 	EXPECT_EQ(0, close(sock_fd));
 }
 
+TEST_F(audit, sendmsg)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP |
+				      LANDLOCK_ACCESS_NET_BIND_UDP,
+	};
+	const struct landlock_net_port_attr rule = {
+		.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+		.port = self->srv1.port,
+	};
+	const int ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	struct audit_records records;
+	int sock_fd;
+
+	/* Sendmsg on stream sockets is never denied. */
+	if (variant->prot.type != SOCK_DGRAM)
+		return;
+
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &rule, 0));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv0, "A", 1, 0));
+	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.connect_send_udp",
+				      "daddr", variant->addr, "dest"));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	/* Check that autobind generates a denied bind event. */
+	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv1, "A", 1, 0));
+	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp", NULL,
+				      NULL, NULL));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(-EACCES,
+		  sendto_variant(sock_fd, &self->unspec_srv0, "B", 1, 0));
+	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.connect_send_udp",
+				      "daddr", NULL, "dest"));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+
+	EXPECT_EQ(0, close(sock_fd));
+}
+
 TEST_HARNESS_MAIN
-- 
2.39.5


