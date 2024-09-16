Return-Path: <netdev+bounces-128526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7DA97A223
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1041F22ABE
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FB015531A;
	Mon, 16 Sep 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="ReZ7VU3T"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71918155322;
	Mon, 16 Sep 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489423; cv=none; b=lSbQDQJOxh72h5x8wuB0zOH+hjHu0MdZ18XLH+KyrjKP9LPpFGy++VIldNgjfl309y0Au+eF/Zi7gBSPgmosbcfPAsU7QEeNtLe7+LHPsZadvrV9Ac5APxpnDEq1ifSZEfTY2q2FJ0AiCuSeYhebDgODFERvxHvHQOL2GDhZmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489423; c=relaxed/simple;
	bh=mtHVH+OGaTcfto/jyVO+XrnqeMHRW0ehIN4a5851zhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrKQVk3UdS8C8I4E9khjqW6m6leE8pxyUIfhKq9+0VwXw7ltz1WTvq8N8Xjeu6/rz6ntpRXNpO61aJ81gsNqcMUKxenSEAtnkYbUx2O/RMXFQrOzbk0uqOkK7hkuYA9mK6C/vtjSRD3DOthYF1P1PN85hIyqUS7l49whAzvviAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=ReZ7VU3T; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1726489418; bh=mtHVH+OGaTcfto/jyVO+XrnqeMHRW0ehIN4a5851zhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReZ7VU3Tu+NNqc1cZi9qoemUGzHs8y293gUmvFOQr9FNNGpQaRoErkKg2WtKiQZKB
	 LreJdFpY/j6d5HXgntjq/bajHvWQH1jz66Ak9eqXtJxztf/ZJvYxN1K05YTmUmKrBh
	 yiKkF8ySwyJ47ENSJfK2SS47ymm2q9Q4D4pRaHLfC7Qcz7hb3wR4QbgAJ8FypFvdUC
	 Q10CCvJbfbtHkwjIvNA4VqGHFT0Aa8nYrU1iQOS2iemKC3zCuKGAhq4WKEVoml46qi
	 5dkca5kToir1lOso/eE+qkzGSF4h1UbS3xZyRc8JxcOV1XJNn2nfcV1AcN2WShQS67
	 i+jSRXF5M6NvA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 699341230C2;
	Mon, 16 Sep 2024 14:23:38 +0200 (CEST)
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
Subject: [RFC PATCH v1 3/7] landlock: Add UDP bind+connect access control
Date: Mon, 16 Sep 2024 14:22:26 +0200
Message-Id: <20240916122230.114800-4-matthieu@buffet.re>
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

Add support for two more access rights:

- LANDLOCK_ACCESS_NET_CONNECT_UDP, to gate the possibility to connect()
  an inet SOCK_DGRAM socket. This will be used by some client applications
  (those who want to avoid specifying a destination for each datagram in
  sendmsg), and for a few servers (those creating a socket per-client, who
  want to only receive traffic from each client on these sockets)

- LANDLOCK_ACCESS_NET_BIND_UDP, to gate the possibility to bind() an
  inet SOCK_DGRAM socket. This will be required for most server
  applications (to start listening for datagrams on a non-ephemeral
  port) and can be useful for some client applications (to set the
  source port of future datagrams)

Also bump the ABI version from 5 to 6 so that userland can detect
whether these rights are supported and actually use them.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h | 48 +++++++++++++++++++++++--------
 security/landlock/limits.h    |  2 +-
 security/landlock/net.c       | 54 ++++++++++++++++++++++++++---------
 security/landlock/syscalls.c  |  2 +-
 4 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 2c8dbc74b955..7f9aa1cd2912 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -113,12 +113,15 @@ struct landlock_net_port_attr {
 	 *
 	 * It should be noted that port 0 passed to :manpage:`bind(2)` will bind
 	 * to an available port from the ephemeral port range.  This can be
-	 * configured with the ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl
-	 * (also used for IPv6).
+	 * configured globally with the
+	 * ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl (also used for
+	 * IPv6), and on a per-socket basis using
+	 * ``setsockopt(IP_LOCAL_PORT_RANGE)``.
 	 *
 	 * A Landlock rule with port 0 and the ``LANDLOCK_ACCESS_NET_BIND_TCP``
-	 * right means that requesting to bind on port 0 is allowed and it will
-	 * automatically translate to binding on the related port range.
+	 * or ``LANDLOCK_ACCESS_NET_BIND_UDP`` right means that requesting to
+	 * bind on port 0 is allowed and it will automatically translate to
+	 * binding on the related port range.
 	 */
 	__u64 port;
 };
@@ -261,17 +264,38 @@ struct landlock_net_port_attr {
  * Network flags
  * ~~~~~~~~~~~~~~~~
  *
- * These flags enable to restrict a sandboxed process to a set of network
- * actions. This is supported since the Landlock ABI version 4.
- *
- * The following access rights apply to TCP port numbers:
- *
- * - %LANDLOCK_ACCESS_NET_BIND_TCP: Bind a TCP socket to a local port.
- * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect an active TCP socket to
- *   a remote port.
+ * These flags enable to restrict which network-related actions a sandboxed
+ * process can take. TCP support was added in Landlock ABI version 4, and UDP
+ * support in version 6.
+ *
+ * TCP access rights:
+ * - %LANDLOCK_ACCESS_NET_BIND_TCP: bind sockets to the given local port,
+ *   for servers that will listen on that port
+ * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: connect sockets to the given remote port,
+ *   to establish client connections to servers listening on that port
+ *
+ * UDP access rights:
+ * - %LANDLOCK_ACCESS_NET_BIND_UDP: bind sockets to the given local port,
+ *   either for servers that will listen on that port, or for clients wishing
+ *   to set the source port of datagrams they will send instead of using a
+ *   kernel-assigned random ephemeral port (some protocols require a specific
+ *   source port, e.g. mDNS with UDP/5353)
+ * - %LANDLOCK_ACCESS_NET_CONNECT_UDP: connect sockets to the given remote port,
+ *   either for clients that will send datagrams to that destination (and want
+ *   to send them faster, without specifying an explicit address every time),
+ *   or for servers that want to filter which client address they want to
+ *   receive datagrams from (if you create a client-specific socket for a
+ *   client-specific process, e.g. using the established-over-unconnected
+ *   method)
+ *
+ * Note that ``bind(0)`` means binding to an ephemeral kernel-assigned port,
+ * in the range configured in ``/proc/sys/net/ipv4/ip_local_port_range``
+ * globally (or on a per-socket basis with ``setsockopt(IP_LOCAL_PORT_RANGE)``).
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
+#define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
+#define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
 /* clang-format on */
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 4eb643077a2a..182b6a8d2976 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -22,7 +22,7 @@
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
-#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_TCP
+#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_UDP
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index c8bcd29bde09..becc62c02cc9 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -79,8 +79,8 @@ static int current_check_access_socket(struct socket *const sock,
 	if (WARN_ON_ONCE(dom->num_layers < 1))
 		return -EACCES;
 
-	/* Checks if it's a (potential) TCP socket. */
-	if (sock->type != SOCK_STREAM)
+	/* Checks if it's a (potential) UDP or TCP socket. */
+	if (sock->type != SOCK_STREAM && sock->type != SOCK_DGRAM)
 		return 0;
 
 	/* Checks for minimal header length to safely read sa_family. */
@@ -110,17 +110,18 @@ static int current_check_access_socket(struct socket *const sock,
 	/* Specific AF_UNSPEC handling. */
 	if (address->sa_family == AF_UNSPEC) {
 		/*
-		 * Connecting to an address with AF_UNSPEC dissolves the TCP
-		 * association, which have the same effect as closing the
-		 * connection while retaining the socket object (i.e., the file
-		 * descriptor).  As for dropping privileges, closing
-		 * connections is always allowed.
-		 *
-		 * For a TCP access control system, this request is legitimate.
+		 * Connecting to an address with AF_UNSPEC dissolves the socket
+		 * association. For SOCK_STREAM, it has the same effect as closing
+		 * the connection while retaining the socket object (i.e., the
+		 * file descriptor). For SOCK_DGRAM, it removes any configured
+		 * destination address. Both cases remove accessible resources, so
+		 * they are always legitimate and allowed, like dropping any
+		 * privilege.
 		 * Let the network stack handle potential inconsistencies and
 		 * return -EINVAL if needed.
 		 */
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP)
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP)
 			return 0;
 
 		/*
@@ -134,7 +135,8 @@ static int current_check_access_socket(struct socket *const sock,
 		 * checks, but it is safer to return a proper error and test
 		 * consistency thanks to kselftest.
 		 */
-		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			/* addrlen has already been checked for AF_UNSPEC. */
 			const struct sockaddr_in *const sockaddr =
 				(struct sockaddr_in *)address;
@@ -175,16 +177,42 @@ static int current_check_access_socket(struct socket *const sock,
 static int hook_socket_bind(struct socket *const sock,
 			    struct sockaddr *const address, const int addrlen)
 {
+	access_mask_t access_request;
+
+	/*
+	 * Check if it's a (potential) TCP or UDP socket. These checks could
+	 * match e.g. Unix, netlink, or udplite sockets.
+	 */
+	if (sock->type == SOCK_STREAM)
+		access_request = LANDLOCK_ACCESS_NET_BIND_TCP;
+	else if (sock->type == SOCK_DGRAM)
+		access_request = LANDLOCK_ACCESS_NET_BIND_UDP;
+	else
+		return 0;
+
 	return current_check_access_socket(sock, address, addrlen,
-					   LANDLOCK_ACCESS_NET_BIND_TCP);
+					   access_request);
 }
 
 static int hook_socket_connect(struct socket *const sock,
 			       struct sockaddr *const address,
 			       const int addrlen)
 {
+	access_mask_t access_request;
+
+	/*
+	 * Check if it's a (potential) TCP or UDP socket. These checks could
+	 * match e.g. Unix, netlink, or udplite sockets.
+	 */
+	if (sock->type == SOCK_STREAM)
+		access_request = LANDLOCK_ACCESS_NET_CONNECT_TCP;
+	else if (sock->type == SOCK_DGRAM)
+		access_request = LANDLOCK_ACCESS_NET_CONNECT_UDP;
+	else
+		return 0;
+
 	return current_check_access_socket(sock, address, addrlen,
-					   LANDLOCK_ACCESS_NET_CONNECT_TCP);
+					   access_request);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index ccc8bc6c1584..328198e8a9f5 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -149,7 +149,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 5
+#define LANDLOCK_ABI_VERSION 6
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
-- 
2.39.5


