Return-Path: <netdev+bounces-298211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BDviEl/hKmriygMAu9opvQ
	(envelope-from <netdev+bounces-298211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:25:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F3673765
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:25:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=buffet.re header.s=mx1 header.b=JhbQ3Cy+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298211-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298211-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=buffet.re;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1E0C3046556
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818442E009;
	Thu, 11 Jun 2026 16:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF103441031;
	Thu, 11 Jun 2026 16:21:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194918; cv=none; b=dyjDD5YqJaxJGqApn4QlqJ0o0UGmMqoh7S2eTY0B4ZM4AKi0eSXX9INtreUzexO3AWTCaINuxxnUulm003Y+tBXez93/MThlqYldfyuuRxpEs9lKLzrmXxiWs13Vs8pYal1iF5XDJRM7hCekuCnnmF391uR1QTzGO6WVrV8991Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194918; c=relaxed/simple;
	bh=azfenzDw4Tvw00iDrPWP6CygXy5Oq0ciYf4lrOpcWTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JC22TX5tOgprDv8CelsWsKBpXcxKqvLxeribkSYgC3rNAvtm0PqYGBp2srJ5strnSr6S7m+UNIw7lPP+GSRtDABjjegvurz0Grj78r5Znli8vdvlBDyuMKynnkbKyxCd9JCSBgihELKhCGbCPipA1uQIi20T5yxW4cKqkMgrn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=JhbQ3Cy+; arc=none smtp.client-ip=51.83.41.69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781194915; bh=azfenzDw4Tvw00iDrPWP6CygXy5Oq0ciYf4lrOpcWTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JhbQ3Cy+5oVKyvqy/WJ8Bo0zBVDTrUWctf+hvKN0NHfhZPk5lxCRpvWPEB0TwmuRc
	 qDm0TShZMMdQC/0UwGyvL6IxiO4OTSompN6XRQY79KTmz6Tna6hPJPWuCOcFUsGC54
	 76nh+7R59Q0dLSVTZhj2WPtIiP6dVvGm72audfKJ88WFC87A/vjf9IDQcVm5kM4zQG
	 kcj7Oe4Q+ize2eEpeewv35mCYLIHqrcjZEnfGAMDVN0LadxtfbFzhMRyncol4VZkwR
	 69Dj9Z2prv+2WcYJxgWqBITFD7z4OFZlexSPmaXvZeelOU04RhiGd7PY4WDGuIVY0C
	 +p1q6q4QoJ89Q==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 99888125977;
	Thu, 11 Jun 2026 18:21:54 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v5 1/6] landlock: Add UDP bind() access control
Date: Thu, 11 Jun 2026 18:21:01 +0200
Message-ID: <20260611162107.49278-2-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611162107.49278-1-matthieu@buffet.re>
References: <20260611162107.49278-1-matthieu@buffet.re>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298211-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mic@digikod.net,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:konstantin.meskhidze@huawei.com,m:m@maowtm.org,m:netdev@vger.kernel.org,m:matthieu@buffet.re,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[buffet.re:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,buffet.re:dkim,buffet.re:email,buffet.re:mid,buffet.re:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D95F3673765

Add support for a first fine-grained UDP access right.
LANDLOCK_ACCESS_NET_BIND_UDP controls the ability to set the local port
of a UDP socket (via bind()). It will be useful for servers (to start
receiving datagrams), and for some clients that need to use a specific
source port (e.g. mDNS requires to use port 5353)

For obvious performance concerns, access control is only enforced when
configuring sockets, not when using them for common send/recv
operations.

Bump ABI to allow userspace to detect and use this new right.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h                | 12 +++++++++---
 security/landlock/audit.c                    |  1 +
 security/landlock/limits.h                   |  2 +-
 security/landlock/net.c                      | 18 ++++++++++++------
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  4 ++--
 tools/testing/selftests/landlock/net_test.c  |  5 +++--
 7 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 10a346e55e95..045b251ff1b4 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -201,9 +201,9 @@ struct landlock_net_port_attr {
 	 * with ``setsockopt(IP_LOCAL_PORT_RANGE)``.
 	 *
 	 * A Landlock rule with port 0 and the %LANDLOCK_ACCESS_NET_BIND_TCP
-	 * right means that requesting to bind on port 0 is allowed and it will
-	 * automatically translate to binding on a kernel-assigned ephemeral
-	 * port.
+	 * or %LANDLOCK_ACCESS_NET_BIND_UDP right means that requesting to bind
+	 * on port 0 is allowed and it will automatically translate to binding
+	 * on a kernel-assigned ephemeral port.
 	 */
 	__u64 port;
 };
@@ -373,10 +373,16 @@ struct landlock_net_port_attr {
  *   port. Support added in Landlock ABI version 4.
  * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect TCP sockets to the given
  *   remote port. Support added in Landlock ABI version 4.
+ *
+ * And similarly for UDP port numbers:
+ *
+ * - %LANDLOCK_ACCESS_NET_BIND_UDP: Bind UDP sockets to the given local
+ *   port. Support added in Landlock ABI version 10.
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
+#define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 8d0edf94037d..e676ebffeebe 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -45,6 +45,7 @@ static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
 static const char *const net_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_TCP)] = "net.bind_tcp",
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_TCP)] = "net.connect_tcp",
+	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_UDP)] = "net.bind_udp",
 };
 
 static_assert(ARRAY_SIZE(net_access_strings) == LANDLOCK_NUM_ACCESS_NET);
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index b454ad73b15e..c0f30a4591b8 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -23,7 +23,7 @@
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
-#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_TCP
+#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_BIND_UDP
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 9eafc1dbf8ff..8da40614c452 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -88,15 +88,17 @@ static int current_check_access_socket(struct socket *const sock,
 			 * inconsistencies and return -EINVAL if needed.
 			 */
 			return 0;
-		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			/*
 			 * Binding to an AF_UNSPEC address is treated
 			 * differently by IPv4 and IPv6 sockets. The socket's
 			 * family may change under our feet due to
 			 * setsockopt(IPV6_ADDRFORM), but that's ok: we either
-			 * reject entirely or require
-			 * %LANDLOCK_ACCESS_NET_BIND_TCP for the given port, so
-			 * it cannot be used to bypass the policy.
+			 * reject entirely for IPv6 or require
+			 * %LANDLOCK_ACCESS_NET_BIND_TCP or
+			 * %LANDLOCK_ACCESS_NET_BIND_UDP for IPv4,
+			 * so it cannot be used to bypass the policy.
 			 *
 			 * IPv4 sockets map AF_UNSPEC to AF_INET for
 			 * retrocompatibility for bind accesses, only if the
@@ -142,7 +144,8 @@ static int current_check_access_socket(struct socket *const sock,
 		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
 			audit_net.dport = port;
 			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
-		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			audit_net.sport = port;
 			audit_net.v4info.saddr = addr4->sin_addr.s_addr;
 		} else {
@@ -164,7 +167,8 @@ static int current_check_access_socket(struct socket *const sock,
 		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
 			audit_net.dport = port;
 			audit_net.v6info.daddr = addr6->sin6_addr;
-		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			audit_net.sport = port;
 			audit_net.v6info.saddr = addr6->sin6_addr;
 		} else {
@@ -224,6 +228,8 @@ static int hook_socket_bind(struct socket *const sock,
 
 	if (sk_is_tcp(sock->sk))
 		access_request = LANDLOCK_ACCESS_NET_BIND_TCP;
+	else if (sk_is_udp(sock->sk))
+		access_request = LANDLOCK_ACCESS_NET_BIND_UDP;
 	else
 		return 0;
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index accfd2e5a0cd..d45469d5d464 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -166,7 +166,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 9;
+const int landlock_abi_version = 10;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 30d37234086c..6c8113c2ded1 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,8 +76,8 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
-					     LANDLOCK_CREATE_RULESET_VERSION));
+	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 4c528154ea92..ec392d971ea3 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1326,11 +1326,12 @@ FIXTURE_TEARDOWN(mini)
 
 /* clang-format off */
 
-#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_TCP
+#define ACCESS_LAST LANDLOCK_ACCESS_NET_BIND_UDP
 
 #define ACCESS_ALL ( \
 	LANDLOCK_ACCESS_NET_BIND_TCP | \
-	LANDLOCK_ACCESS_NET_CONNECT_TCP)
+	LANDLOCK_ACCESS_NET_CONNECT_TCP | \
+	LANDLOCK_ACCESS_NET_BIND_UDP)
 
 /* clang-format on */
 
-- 
2.47.3


