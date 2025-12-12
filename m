Return-Path: <netdev+bounces-244515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C9FCB946B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 648C8300A298
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C352C376B;
	Fri, 12 Dec 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="p+tjROxs"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6A2C21D5;
	Fri, 12 Dec 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557435; cv=none; b=TKjD2dgT6ERpZsdMaH5RIQSmqdAMHlRwqRAt75K+UcAzbED8MqSv0vtUeI/cfk2wy6bJDGeaDMMRtE8fKZAZsO0qbzLInMh6ou69IjZXclJgYVLDAQmSztjW/fviTzNEQZCkcVZ/i2M4Zs1Cpqtc02kJV+NLO9uOMlV5gIySh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557435; c=relaxed/simple;
	bh=3KmXsye2LDiCvKUJfGRQ6RO+7hR4BbRIhF0zssNDRTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N10P4/50B5/rUsKQTnINN17aNABFtEnlD0jf130fhQnMGAcB9/wQuaypijH2479baEK2FnVPcpnJ0go11x8T+IbZjSK76G8HDSCStxzJyKmaNERfpCC9WmkweQCXjnm259Z2YrPSGIg7ZcEixBWK6zIPOEMK/J+d47/Gkc1sYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=p+tjROxs; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557430; bh=3KmXsye2LDiCvKUJfGRQ6RO+7hR4BbRIhF0zssNDRTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+tjROxswvdhWnHWsODiqWeSUZycESQf2Lqv62s1ALVOd1OYH7czjbb4yQzMmYqIF
	 eZhWmipkjQfXay5B7f+12hzbUWM6gGQWdHpn3lgOuKe+8Y4lUvN6hH89eYULWLAY/p
	 njNnhpuagPSQxuxF52U9ZhA4/Xi5Ef1byw3dFEMCqeqFxJk6x4rUmtIl6mW4haldAI
	 JQiVj1u8F14EbVY7rsih8J4KzbQJzgwnJttyax4X3UEfYU49TY7xycT90tsBUOAH0l
	 gpYtkDNhYVbCA6TaHQB+RZjI+yGPnbq7zda5yLihT/5wurL8/pdaeFEK08asoSNIJ1
	 gWIX/AZLx2zLw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 82BBC12548F;
	Fri, 12 Dec 2025 17:37:10 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 6/8] selftests/landlock: Add tests for UDP sendmsg
Date: Fri, 12 Dec 2025 17:37:02 +0100
Message-Id: <20251212163704.142301-7-matthieu@buffet.re>
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

Add tests specific to UDP sendmsg(), orthogonal to whether the process
is allowed to bind()/connect(). Make this part of the protocol_*
variants to ensure behaviour is consistent across AF_INET, AF_INET6 and
AF_UNIX.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/net_test.c | 306 +++++++++++++++++++-
 1 file changed, 299 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 977d82eb9934..79ce52907ef3 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -268,9 +268,68 @@ static int connect_variant(const int sock_fd,
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
+			errno = -EAFNOSUPPORT;
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
 FIXTURE(protocol)
 {
-	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
+	struct service_fixture srv0, srv1, srv2;
+	struct service_fixture unspec_any0, unspec_srv0, unspec_srv1;
 };
 
 FIXTURE_VARIANT(protocol)
@@ -292,6 +351,7 @@ FIXTURE_SETUP(protocol)
 	ASSERT_EQ(0, set_service(&self->srv2, variant->prot, 2));
 
 	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
+	ASSERT_EQ(0, set_service(&self->unspec_srv1, prot_unspec, 1));
 
 	ASSERT_EQ(0, set_service(&self->unspec_any0, prot_unspec, 0));
 	self->unspec_any0.ipv4_addr.sin_addr.s_addr = htonl(INADDR_ANY);
@@ -1075,6 +1135,185 @@ TEST_F(protocol, connect_unspec)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+TEST_F(protocol, sendmsg)
+{
+	/* Arbitrary value just to not block other tests indefinitely. */
+	const struct timeval read_timeout = {
+		.tv_sec = 0,
+		.tv_usec = 100000,
+	};
+	const bool sandboxed = variant->sandbox == UDP_SANDBOX &&
+			       (variant->prot.domain == AF_INET ||
+				variant->prot.domain == AF_INET6);
+	int res, srv1_fd, srv0_fd, client_fd;
+	char read_buf[1] = { 0 };
+
+	if (variant->prot.type != SOCK_DGRAM)
+		return;
+
+	disable_caps(_metadata);
+
+	/* Prepare server on port #0 to be denied */
+	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
+	srv0_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, srv0_fd);
+	ASSERT_EQ(0, bind_variant(srv0_fd, &self->srv0));
+
+	/* And another server on port #1 to be allowed */
+	ASSERT_EQ(0, set_service(&self->srv1, variant->prot, 1));
+	srv1_fd = socket_variant(&self->srv1);
+	ASSERT_LE(0, srv1_fd);
+	ASSERT_EQ(0, bind_variant(srv1_fd, &self->srv1));
+
+	EXPECT_EQ(0, setsockopt(srv0_fd, SOL_SOCKET, SO_RCVTIMEO, &read_timeout,
+				sizeof(read_timeout)));
+	EXPECT_EQ(0, setsockopt(srv1_fd, SOL_SOCKET, SO_RCVTIMEO, &read_timeout,
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
+	/* No connect(), NULL address */
+	EXPECT_EQ(-1, write(client_fd, "A", 1));
+	if (variant->prot.domain == AF_UNIX) {
+		EXPECT_EQ(ENOTCONN, errno);
+	} else {
+		EXPECT_EQ(EDESTADDRREQ, errno);
+	}
+
+	/* No connect(), non-NULL but too small explicit address */
+	EXPECT_EQ(-EINVAL,
+		  sendto_variant_addrlen(client_fd, &self->srv0,
+					 get_addrlen(&self->srv0, true) - 1,
+					 "B", 1, 0));
+
+	/* No connect(), explicit denied port */
+	res = sendto_variant(client_fd, &self->srv0, "C", 1, 0);
+	if (sandboxed) {
+		EXPECT_EQ(-EACCES, res);
+	} else {
+		EXPECT_EQ(0, res);
+		EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+		EXPECT_EQ(read_buf[0], 'C');
+	}
+
+	/* No connect(), explicit allowed port */
+	EXPECT_EQ(0, sendto_variant(client_fd, &self->srv1, "D", 1, 0));
+	EXPECT_EQ(1, read(srv1_fd, read_buf, 1));
+	EXPECT_EQ(read_buf[0], 'D');
+
+	/* Explicit AF_UNSPEC address but truncated */
+	EXPECT_EQ(-EINVAL, sendto_variant_addrlen(
+				   client_fd, &self->unspec_srv0,
+				   get_addrlen(&self->unspec_srv0, true) - 1,
+				   "E", 1, 0));
+
+	/* Explicit AF_UNSPEC address, should always be denied */
+	res = sendto_variant(client_fd, &self->unspec_srv1, "F", 1, 0);
+	if (sandboxed) {
+		EXPECT_EQ(-EACCES, res);
+	} else {
+		if (variant->prot.domain == AF_INET) {
+			/* IPv4 sockets treat AF_UNSPEC as AF_INET */
+			EXPECT_EQ(0, res);
+			EXPECT_EQ(1, read(srv1_fd, read_buf, 1))
+			{
+				TH_LOG("read() failed: %s", strerror(errno));
+			}
+			EXPECT_EQ(read_buf[0], 'F');
+		} else if (variant->prot.domain == AF_INET6) {
+			/* IPv6 sockets treat AF_UNSPEC as a NULL address */
+			EXPECT_EQ(-EDESTADDRREQ, res);
+		} else {
+			/* Unix sockets don't accept AF_UNSPEC */
+			EXPECT_EQ(-EINVAL, res);
+		}
+	}
+
+	/* With connect() on an allowed explicit port, no explicit address */
+	ASSERT_EQ(0, connect_variant(client_fd, &self->srv1));
+	EXPECT_EQ(0, sendto_variant(client_fd, NULL, "G", 1, 0));
+	EXPECT_EQ(1, read(srv1_fd, read_buf, 1));
+	EXPECT_EQ(read_buf[0], 'G');
+
+	/* With connect() on a denied explicit port, no explicit address */
+	ASSERT_EQ(0, connect_variant(client_fd, &self->srv0));
+	EXPECT_EQ(0, sendto_variant(client_fd, NULL, "H", 1, 0));
+	EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+	EXPECT_EQ(read_buf[0], 'H');
+
+	/* Explicit AF_UNSPEC minimal address (just the sa_family_t field) */
+	res = sendto_variant_addrlen(client_fd, &self->unspec_srv0,
+				     get_addrlen(&self->unspec_srv0, true), "I",
+				     1, 0);
+	if (sandboxed) {
+		EXPECT_EQ(-EACCES, res);
+	} else if (variant->prot.domain == AF_INET6) {
+		/*
+		 * IPv6 sockets treat AF_UNSPEC as a NULL address,
+		 * falling back to the connected address
+		 */
+		EXPECT_EQ(0, res);
+		EXPECT_EQ(1, read(srv0_fd, read_buf, 1));
+		EXPECT_EQ(read_buf[0], 'I');
+	} else {
+		/*
+		 * IPv4 socket will expect a struct sockaddr_in, our address
+		 * is considered truncated.
+		 * And Unix sockets don't accept AF_UNSPEC at all.
+		 */
+		EXPECT_EQ(-EINVAL, res);
+	}
+
+	/* Explicit AF_UNSPEC address, should always be denied */
+	res = sendto_variant(client_fd, &self->unspec_srv1, "J", 1, 0);
+	if (sandboxed) {
+		EXPECT_EQ(-EACCES, res);
+	} else if (variant->prot.domain == AF_INET ||
+		   variant->prot.domain == AF_INET6) {
+		int read_fd;
+
+		EXPECT_EQ(0, res);
+		if (variant->prot.domain == AF_INET) {
+			/* IPv4 sockets treat AF_UNSPEC as AF_INET */
+			read_fd = srv1_fd;
+		} else {
+			/*
+			 * IPv6 sockets treat AF_UNSPEC as a NULL address,
+			 * falling back to the connected address
+			 */
+			read_fd = srv0_fd;
+		}
+		EXPECT_EQ(1, read(read_fd, read_buf, 1))
+		{
+			TH_LOG("read failed: %s", strerror(errno));
+		}
+		EXPECT_EQ(read_buf[0], 'J');
+	} else {
+		/* Unix sockets don't accept AF_UNSPEC */
+		EXPECT_EQ(-EINVAL, res);
+	}
+}
+
 FIXTURE(ipv4)
 {
 	struct service_fixture srv0, srv1;
@@ -1470,13 +1709,14 @@ FIXTURE_TEARDOWN(mini)
 
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
 
@@ -2078,19 +2318,26 @@ static int matches_log_prot(const int audit_fd, const char *const blockers,
 			    const char *const dir_addr, const char *const addr,
 			    const char *const dir_port)
 {
-	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+	static const char tmpl_with_addr_port[] = REGEX_LANDLOCK_PREFIX
 		" blockers=%s %s=%s %s=1024$";
+	static const char tmpl_no_addr_port[] = REGEX_LANDLOCK_PREFIX
+		" blockers=%s$";
 	/*
 	 * Max strlen(blockers): 16
 	 * Max strlen(dir_addr): 5
 	 * Max strlen(addr): 12
 	 * Max strlen(dir_port): 4
 	 */
-	char log_match[sizeof(log_template) + 37];
+	char log_match[sizeof(tmpl_with_addr_port) + 37];
 	int log_match_len;
 
-	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
-				 blockers, dir_addr, addr, dir_port);
+	if (addr != NULL)
+		log_match_len = snprintf(log_match, sizeof(log_match), tmpl_with_addr_port,
+					 blockers, dir_addr, addr, dir_port);
+	else
+		log_match_len = snprintf(log_match, sizeof(log_match), tmpl_no_addr_port,
+					 blockers);
+
 	if (log_match_len > sizeof(log_match))
 		return -E2BIG;
 
@@ -2101,6 +2348,7 @@ static int matches_log_prot(const int audit_fd, const char *const blockers,
 FIXTURE(audit)
 {
 	struct service_fixture srv0;
+	struct service_fixture unspec_srv0;
 	struct audit_filter audit_filter;
 	int audit_fd;
 };
@@ -2153,7 +2401,13 @@ FIXTURE_VARIANT_ADD(audit, ipv6_udp) {
 
 FIXTURE_SETUP(audit)
 {
+	struct protocol_variant prot_unspec = variant->prot;
+
+	prot_unspec.domain = AF_UNSPEC;
+
 	ASSERT_EQ(0, set_service(&self->srv0, variant->prot, 0));
+	ASSERT_EQ(0, set_service(&self->unspec_srv0, prot_unspec, 0));
+
 	setup_loopback(_metadata);
 
 	set_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -2241,4 +2495,42 @@ TEST_F(audit, connect)
 	EXPECT_EQ(0, close(sock_fd));
 }
 
+TEST_F(audit, sendmsg)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_SENDTO_UDP,
+	};
+	struct audit_records records;
+	int ruleset_fd, sock_fd;
+
+	if (variant->prot.type != SOCK_DGRAM)
+		return;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	sock_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, sock_fd);
+	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv0, "A", 1, 0));
+	EXPECT_EQ(0, matches_log_prot(self->audit_fd, "net.sendto_udp", "daddr",
+				      variant->addr, "dest"));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->unspec_srv0, "B", 1, 0));
+	EXPECT_EQ(0, matches_log_prot(self->audit_fd, "net.sendto_udp", "daddr",
+				      NULL, "dest"));
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
2.47.3


