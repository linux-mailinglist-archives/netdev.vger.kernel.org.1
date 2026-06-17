Return-Path: <netdev+bounces-300226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BqxpDvvhMmr/6QUAu9opvQ
	(envelope-from <netdev+bounces-300226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E65C769BDB1
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:05:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=buffet.re header.s=mx1 header.b=dr48evYw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300226-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300226-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=buffet.re;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9500430C2AAE
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A7737756C;
	Wed, 17 Jun 2026 18:05:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D0372EFB;
	Wed, 17 Jun 2026 18:05:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719528; cv=none; b=NA5j7FWMyAWDZcUpqA4foeFE0AvQGaR041MjFVHdOK3Lh2AG9ANGN1p6/xtMEx+qlucoI8B8rWi7/vYFuqgfDOJh4HryR15MEEcTOjSD//hdW5BaeF3kPGzswG6GSfjLchxxVsVSkcQ1KiLU0Kh9lj0G5v5RyTZljMriFzHryxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719528; c=relaxed/simple;
	bh=gyiVot9kKEo57ZaPzcVqW92g6sI+gUZmk/M0AqNVRrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmgIBo2Yo1oTuz4X2LYzqjgPX66FJcApXTRHjn9JMm2Qy56RYzFtbnoW7LpGMbsmtWBUADt23wLicoDPiDxZln2cFC/6aEeQVFJub9e86oWr+JhX+tVUGxRsVjpAnZS/kP5xZiY/U7td30TmoQBJp377+ZUcYPAmF25voNFZyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=dr48evYw; arc=none smtp.client-ip=51.83.41.69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781719517; bh=gyiVot9kKEo57ZaPzcVqW92g6sI+gUZmk/M0AqNVRrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dr48evYw6HfsSUa5jugoiGxiQg4HLtn2hWkyYXkdrB9KHblDg+bRkg222WpSrmfbv
	 QRD6n+rmIbW5o/kycRrx8pXHpsHDQ6vmGHeFeTt168Kt8I3Ca7XoU9qL8xxy+Y7jyY
	 ADnUPhCnLiSOzI1n0Am1y1ZvipN7Ezix7k/et0lPALEhrmdWm+w8SYQ64z7IA3YalN
	 ELPE0L+fmRjyyY9HhJJ9UU1QlUNkKpB0s8N7N3Zjx7AlkK7z0JokQ1YyV029raVMqV
	 8Y8dyK01a7zf99F3ZxWZGMe/lBcSaZet6XJynqll7xVm7BLsDpPX08xqnZm07YBCFd
	 8ECgFxplJBgzA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id E15E0126418;
	Wed, 17 Jun 2026 20:05:17 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH 2/2] selftests/landlock: Add test for TCP fast open
Date: Wed, 17 Jun 2026 20:05:24 +0200
Message-ID: <20260617180526.15627-3-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617180526.15627-1-matthieu@buffet.re>
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300226-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:mic@digikod.net,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:matthieu@buffet.re,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[buffet.re:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[buffet.re:dkim,buffet.re:email,buffet.re:mid,buffet.re:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E65C769BDB1

Enforce that TCP Fast Open is controlled by
LANDLOCK_ACCESS_NET_CONNECT_TCP. Semantics of connect() and
sendmsg(MSG_FASTOPEN) should be identical from Landlock's perspective.
Also enforce error code consistency, since UDP sockets ignore
the MSG_FASTOPEN flag while Unix sockets reject it.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/net_test.c | 155 ++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 0c256e7c8675..177ed28e70f6 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -258,6 +258,64 @@ static int connect_variant(const int sock_fd,
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
+        * We never want our processes to be killed by SIGPIPE: we check return
+        * codes and errno, so that we have actual error messages.
+        */
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
 FIXTURE(protocol)
 {
 	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
@@ -950,6 +1008,103 @@ TEST_F(protocol, connect_unspec)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+TEST_F(protocol, tcp_fastopen)
+{
+	const bool restricted = variant->sandbox == TCP_SANDBOX &&
+				variant->prot.type == SOCK_STREAM &&
+				(variant->prot.protocol == IPPROTO_TCP ||
+				 variant->prot.protocol == IPPROTO_IP) &&
+				(variant->prot.domain == AF_INET ||
+				 variant->prot.domain == AF_INET6);
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	int bind_fd, client_fd, status;
+	char buf;
+	pid_t child;
+
+	bind_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, bind_fd);
+	EXPECT_EQ(0, bind_variant(bind_fd, &self->srv0));
+	if (self->srv0.protocol.type == SOCK_STREAM)
+		EXPECT_EQ(0, listen(bind_fd, backlog));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int connect_fd, ret;
+
+		/* Closes listening socket for the child. */
+		EXPECT_EQ(0, close(bind_fd));
+
+		connect_fd = socket_variant(&self->srv0);
+		ASSERT_LE(0, connect_fd);
+
+		if (variant->sandbox == TCP_SANDBOX) {
+			const int ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			ASSERT_LE(0, ruleset_fd);
+
+			enforce_ruleset(_metadata, ruleset_fd);
+			EXPECT_EQ(0, close(ruleset_fd));
+		}
+
+		/* Fast Open with no address. */
+		ret = sendto_variant(connect_fd, NULL, NULL, 0, MSG_FASTOPEN);
+		if (self->srv0.protocol.domain == AF_UNIX) {
+			ASSERT_EQ(-ENOTCONN, ret);
+		} else if (self->srv0.protocol.type == SOCK_DGRAM) {
+			ASSERT_EQ(-EDESTADDRREQ, ret);
+		} else {
+			ASSERT_EQ(-EINVAL, ret);
+		}
+
+		/* Fast Open to a denied address. */
+		ret = sendto_variant(connect_fd, &self->srv0, "A", 1,
+				     MSG_FASTOPEN);
+		if (restricted) {
+			ASSERT_EQ(-EACCES, ret);
+		} else if (self->srv0.protocol.domain == AF_UNIX &&
+			   self->srv0.protocol.type == SOCK_STREAM) {
+			ASSERT_EQ(-EOPNOTSUPP, ret);
+		} else {
+			ASSERT_EQ(0, ret);
+		}
+
+		EXPECT_EQ(0, close(connect_fd));
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	client_fd = bind_fd;
+	if (!restricted && self->srv0.protocol.type == SOCK_STREAM &&
+	    self->srv0.protocol.domain != AF_UNIX) {
+		client_fd = accept(bind_fd, NULL, 0);
+		ASSERT_LE(0, client_fd);
+	}
+
+	if (restricted) {
+		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		EXPECT_EQ(ENOTCONN, errno);
+	} else if (self->srv0.protocol.domain == AF_UNIX &&
+		   self->srv0.protocol.type == SOCK_STREAM) {
+		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		EXPECT_EQ(EINVAL, errno);
+	} else {
+		EXPECT_EQ(1, read(client_fd, &buf, 1));
+		EXPECT_EQ('A', buf);
+	}
+
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	if (client_fd != bind_fd)
+		EXPECT_LE(0, close(client_fd));
+
+	EXPECT_EQ(0, close(bind_fd));
+}
+
 FIXTURE(ipv4)
 {
 	struct service_fixture srv0, srv1;
-- 
2.47.3


