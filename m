Return-Path: <netdev+bounces-283407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM3QDuXz9WnwQgIAu9opvQ
	(envelope-from <netdev+bounces-283407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:53:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D982F4B20C2
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC64C300FEE1
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47337FF42;
	Sat,  2 May 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="sALJpfYX"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926428150F;
	Sat,  2 May 2026 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777726429; cv=none; b=AbexrDKMWadFHjwtwOuGFes2NwWncQ5IUUUdDIa3t9MNxMr2TFgv2ORqsyulmXh6yzpswvk/RzL3ZSB5V0OEyA8mKDP07Otvi/Af1vrE64UHWkCrRCAZA8ilVvy1CuH1LJnaxff0imbp3z/Z9Q4HXl3fngKzu5UsJ/yUNwhWf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777726429; c=relaxed/simple;
	bh=8jqAfKX1JijeYbqRW4pw5dyGzYsM2UpCBWNGqsOmQW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9HzA2w/x0VLk82v6aXUMOHhWmURgas8Zu5581SfNtzAhiGhNMPwY46HDARfQvVZZExkq0Yv+/3/FEsr81QFtMPqV4UAPduRSFgbRDlFhEPQZbf/vAb10PkD0nVJwc0HHPiEMvBTl6Fdd0aMVbe8EspMz6+QemoydkVFFDmZit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=sALJpfYX; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1777725866; bh=8jqAfKX1JijeYbqRW4pw5dyGzYsM2UpCBWNGqsOmQW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sALJpfYXksANeN5fR91CCt8h6vbUMXwNhbESfB4pgZpD2MdeiTsailEgjwUs/75nN
	 M7qc/hiVYF+FEy5dIeDWGtKmGZuPOAxXk7Euh+fOwjx1MIxXaZudLg3gki7TM4qDvZ
	 d+K+B9HvG1+Mpslj1CRGKPtG8B+qTQechhggI2GY+i1VzJD82pyXJwsd3eNN1lFwVE
	 +0pvXu1KGBCIvpP80gYNgox4D6st7EvVEiwGVd2z5dkqexho5w8sCvTN+LKxE4894G
	 W1Dqr7UwUQH/Qh4bDVtf15QckNq/ReKiFQGj6vQGyBOOXXyBu+vFs2nmQ+f+2h96Tz
	 kDhsd6jlUxrcA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 548F4125914;
	Sat,  2 May 2026 14:44:26 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v4 1/7] landlock: Add UDP bind() access control
Date: Sat,  2 May 2026 14:43:00 +0200
Message-Id: <20260502124306.3975990-2-matthieu@buffet.re>
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
X-Rspamd-Queue-Id: D982F4B20C2
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
	TAGGED_FROM(0.00)[bounces-283407-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[audit_net.sport:url,buffet.re:email,buffet.re:dkim,buffet.re:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
index c368649985c5..f9ccb52e7d45 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -81,15 +81,17 @@ static int current_check_access_socket(struct socket *const sock,
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
@@ -135,7 +137,8 @@ static int current_check_access_socket(struct socket *const sock,
 		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
 			audit_net.dport = port;
 			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
-		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			audit_net.sport = port;
 			audit_net.v4info.saddr = addr4->sin_addr.s_addr;
 		} else {
@@ -157,7 +160,8 @@ static int current_check_access_socket(struct socket *const sock,
 		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
 			audit_net.dport = port;
 			audit_net.v6info.daddr = addr6->sin6_addr;
-		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			audit_net.sport = port;
 			audit_net.v6info.saddr = addr6->sin6_addr;
 		} else {
@@ -216,6 +220,8 @@ static int hook_socket_bind(struct socket *const sock,
 
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
2.39.5


