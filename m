Return-Path: <netdev+bounces-151961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38C79F205C
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531FA1887F10
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E044C70;
	Sat, 14 Dec 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="X9NbjJ6m"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177E1A0721;
	Sat, 14 Dec 2024 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202004; cv=none; b=htDTPpsEQrWTRCiuoKYamuYBYE/fCm4zHSIhie5Qt7iMmW4FoScYSNfWTineTGVsun3ijZhDZfZuFK4fYkWUElAiZezeyZ7zQ7jxruuCwnxWdXBIaWAO0ix83nbzF1zxpApbNhOyZcDz8QKkyL1r2srH8Xh5nfwBFNGz0x+JnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202004; c=relaxed/simple;
	bh=vOKvRMbY8m00DdlZDc5kSM8azQC0Pu0YHZjQw8q3hIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/QGzCISSYPa2pVyRzTDHaZ+DOyq7yZyzG/Zlz6EyCXe77U977Dvm60qkOOGmnXPaxxv4iIv0AkUkaLZdJBOJlUywPVwo0DPM8R0+svJaJgZhDu5ibTe8VjGpt/LPurd8rMoLZEXsTykSvtGVTPkjWNWFJ09EhD6+78ilom9idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=X9NbjJ6m; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1734201996; bh=vOKvRMbY8m00DdlZDc5kSM8azQC0Pu0YHZjQw8q3hIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9NbjJ6mTx9UgexeernLA5Uk8ALJcmiD7CQK7q5endYEiWNkrfgAzX2RBkMV+bXD1
	 C1K5rvJjW9fiTrkaab3J7coLqgQ7FmQ53VOADdvXZvCDEtbVKs8pG67OkqrAZbaO43
	 e20DMv0T06uPVLQT4zB+aY1Rx6zIQrWGb+HGXvMJQ4wKMjFERKBGoM6O3u7GfcB/yb
	 +aBljJeuelmJJPxyArZb5e2D4LOJECXm44ZhM5SB0Ny0Pj+wJ8mZ3kydu2Dp9grayr
	 o+23m6yhSUKgG3k3kWVIB8GszfivvWJ7nxY5xcyaS+gPPWPcPxAAiEszizGcUktj5r
	 QR12y3bZ0Ly9w==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 8E2A01252E0;
	Sat, 14 Dec 2024 19:46:36 +0100 (CET)
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
Subject: [PATCH v2 1/6] landlock: Add UDP bind+connect access control
Date: Sat, 14 Dec 2024 19:45:35 +0100
Message-Id: <20241214184540.3835222-2-matthieu@buffet.re>
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

If an app doesn't need to be able to open UDP sockets, it should be
denied the right to create UDP sockets altogether (via seccomp and/or
https://github.com/landlock-lsm/linux/issues/6 when it lands).
For apps using UDP, add support for two more fine-grained access rights:

- LANDLOCK_ACCESS_NET_CONNECT_UDP, to gate the possibility to connect()
  a UDP socket. For client apps (those which want to avoid specifying a
  destination for each datagram in sendmsg()), and for a few servers
  (those creating per-client sockets, which want to receive traffic only
  from a specific address)

- LANDLOCK_ACCESS_NET_BIND_UDP, to gate the possibility to bind() a UDP
  socket. For most servers (to start listening for datagrams on a
  non-ephemeral port) and can be useful for some client applications (to
  set the source port of future datagrams, e.g. mDNS requires to use
  source port 5353)

No restriction is enforced on send()/recv() to preserve performance.
The security boundary is to prevent acquiring a bound/connected socket.

Bump ABI to v7 to allow userland to detect and use these new restrictions.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h | 53 ++++++++++++++++++++++++++---------
 security/landlock/limits.h    |  2 +-
 security/landlock/net.c       | 49 ++++++++++++++++++++++----------
 security/landlock/syscalls.c  |  2 +-
 4 files changed, 76 insertions(+), 30 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 33745642f787..3f7b8e85822d 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -119,12 +119,15 @@ struct landlock_net_port_attr {
 	 *
 	 * It should be noted that port 0 passed to :manpage:`bind(2)` will bind
 	 * to an available port from the ephemeral port range.  This can be
-	 * configured with the ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl
-	 * (also used for IPv6).
+	 * configured globally with the
+	 * ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl (also used for
+	 * IPv6), and, within that first range, on a per-socket basis using
+	 * ``setsockopt(IP_LOCAL_PORT_RANGE)``.
 	 *
-	 * A Landlock rule with port 0 and the ``LANDLOCK_ACCESS_NET_BIND_TCP``
-	 * right means that requesting to bind on port 0 is allowed and it will
-	 * automatically translate to binding on the related port range.
+	 * A Landlock rule with port 0 and the %LANDLOCK_ACCESS_NET_BIND_TCP
+	 * or %LANDLOCK_ACCESS_NET_BIND_UDP right means that requesting to
+	 * bind on port 0 is allowed and it will automatically translate to
+	 * binding on the ephemeral port range.
 	 */
 	__u64 port;
 };
@@ -267,18 +270,42 @@ struct landlock_net_port_attr {
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
+ * support in version 7.
+ *
+ * TCP access rights:
+ *
+ * - %LANDLOCK_ACCESS_NET_BIND_TCP: bind sockets to the given local port,
+ *   for servers that will listen() on that port, or for clients that want
+ *   to open connections with that specific source port instead of using a
+ *   kernel-assigned random ephemeral one
+ * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: connect client sockets to servers
+ *   listening on that remote port
+ *
+ * UDP access rights:
+ *
+ * - %LANDLOCK_ACCESS_NET_BIND_UDP: bind sockets to the given local port,
+ *   for servers that will listen() on that port, or for clients that want
+ *   to send datagrams with that specific source port instead of using a
+ *   kernel-assigned random ephemeral one
+ * - %LANDLOCK_ACCESS_NET_CONNECT_UDP: connect sockets to the given remote
+ *   port, either for clients that will send datagrams to that destination
+ *   (and want to send them faster without specifying an explicit address
+ *   every time), or for servers that want to filter which client address
+ *   they want to receive datagrams from (e.g. creating a client-specific
+ *   socket)
+ *
+ * Note that binding on port 0 means binding to an ephemeral
+ * kernel-assigned port, in the range configured in
+ * ``/proc/sys/net/ipv4/ip_local_port_range`` globally (and, within that
+ * range, on a per-socket basis with ``setsockopt(IP_LOCAL_PORT_RANGE)``).
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
+#define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
+#define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 15f7606066c8..ca90c1c56458 100644
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
index d5dcc4407a19..1c5cf2ddb7c1 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -63,10 +63,6 @@ static int current_check_access_socket(struct socket *const sock,
 	if (WARN_ON_ONCE(dom->num_layers < 1))
 		return -EACCES;
 
-	/* Checks if it's a (potential) TCP socket. */
-	if (sock->type != SOCK_STREAM)
-		return 0;
-
 	/* Checks for minimal header length to safely read sa_family. */
 	if (addrlen < offsetofend(typeof(*address), sa_family))
 		return -EINVAL;
@@ -94,17 +90,19 @@ static int current_check_access_socket(struct socket *const sock,
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
+		 * Connecting to an address with AF_UNSPEC dissolves the
+		 * remote association while retaining the socket object
+		 * (i.e., the file descriptor). For TCP, it has the same
+		 * effect as closing the connection. For UDP, it removes
+		 * any preset destination for future datagrams.
+		 * Like dropping privileges, these actions are always
+		 * allowed: access control is performed when bind()ing or
+		 * connect()ing.
 		 * Let the network stack handle potential inconsistencies and
 		 * return -EINVAL if needed.
 		 */
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP)
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP)
 			return 0;
 
 		/*
@@ -118,7 +116,8 @@ static int current_check_access_socket(struct socket *const sock,
 		 * checks, but it is safer to return a proper error and test
 		 * consistency thanks to kselftest.
 		 */
-		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			/* addrlen has already been checked for AF_UNSPEC. */
 			const struct sockaddr_in *const sockaddr =
 				(struct sockaddr_in *)address;
@@ -159,16 +158,36 @@ static int current_check_access_socket(struct socket *const sock,
 static int hook_socket_bind(struct socket *const sock,
 			    struct sockaddr *const address, const int addrlen)
 {
+	access_mask_t access_request;
+
+	/* Checks if it's a (potential) TCP socket. */
+	if (sock->type == SOCK_STREAM)
+		access_request = LANDLOCK_ACCESS_NET_BIND_TCP;
+	else if (sk_is_udp(sock->sk))
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
+	/* Checks if it's a (potential) TCP socket. */
+	if (sock->type == SOCK_STREAM)
+		access_request = LANDLOCK_ACCESS_NET_CONNECT_TCP;
+	else if (sk_is_udp(sock->sk))
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
index c097d356fa45..200f771fa3a4 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -150,7 +150,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 6
+#define LANDLOCK_ABI_VERSION 7
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
-- 
2.39.5


