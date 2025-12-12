Return-Path: <netdev+bounces-244523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B579ECB95FD
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 510B43113A1A
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0712D94BD;
	Fri, 12 Dec 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="Lq7rPI/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4F2D8DBB;
	Fri, 12 Dec 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557883; cv=none; b=kqPq4iZ0lH/QW45Keo6lUwG9UZHhStrFvKt9HeG8NeM+bZ+cn6ivYPce0dEPICPxoqrW6kw1dYa7jDR+GgEPRAYAHS2+dsOubTGIHn5rkuzU4UbaFSboYYrtqO3pOxJr6YSe+RC530qSHa04J6KuSBRxf12hlgfyESWxxwV6Tx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557883; c=relaxed/simple;
	bh=BVGKi/ZRioRY7CSv2Aa80YJsF62/2xRvZ8kQFTwhgHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BylJfqiOGckn4ZfCI7+KIPrVvPRADMO9SFNfmF56O98SFxhgwDZRe60JpyTCezfEoUNkhXASU9OBVPrPJ334dFw/NjyvqPj4GvhiPY3q/O0rkhYLt6Q/OKb0RR0vX78EOSkSRFvfXRONLJJTSjQaLxN0SswXdddyo8AhPTR2lJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=Lq7rPI/Y; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557426; bh=BVGKi/ZRioRY7CSv2Aa80YJsF62/2xRvZ8kQFTwhgHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lq7rPI/YBJHWjfF7Fm+8sxh6W/xafDDkHZ+nCof1/jYLfkjdP9kJ3fggQicjjZiF5
	 a7RlT551BKqSQz4xvY5KuIaIOjN3Ts8etLmkayfId6mdS1kUfdIkst+lLJPf+rATRr
	 qlFMBaMLoNDCI3lj9RNN2kkHJpph/QbB3MnRBnyQPFKjLoYTd016DfuPUzORj4I2od
	 qBL0nNjKPnbPTvfxM4VxRddN5+irFcasoniWYuWrk7a1RASNcU6xZVCxjuX09ctnpd
	 k7EzLIubhg6z7aHrOOjrG7XOqNJ5veMttbmdIh9WP2CUIM/gaxjjhgHFzpteEfhZOO
	 +TDocro46YjIw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 81160125488;
	Fri, 12 Dec 2025 17:37:06 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 3/8] landlock: Add UDP bind+connect access control
Date: Fri, 12 Dec 2025 17:36:59 +0100
Message-Id: <20251212163704.142301-4-matthieu@buffet.re>
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

If a process doesn't need to be able to open UDP sockets, it should be
denied the right to create UDP sockets altogether. For processes using
UDP, add support for two more fine-grained access rights:

- LANDLOCK_ACCESS_NET_CONNECT_UDP, to gate the possibility to connect()
  a UDP socket. For client apps (those which want to avoid specifying a
  destination for each datagram they send), and for a few servers (those
  creating per-client sockets, which want to receive traffic only from a
  specific address)

- LANDLOCK_ACCESS_NET_BIND_UDP, to gate the possibility to bind() a UDP
  socket. For most servers (to start receiving datagrams), and some
  clients that need to use a specific source port (e.g. mDNS requires to
  use port 5353)

Access control is only enforced when trying to set the local or remote
end of a UDP socket. So, nothing prevents a client with the right to
send datagrams to use it to get an automatically bound socket and
receive datagrams on an ephemeral port of their choice, without having
LANDLOCK_ACCESS_NET_BIND_UDP. Restricting send/recv semantics is left
for a future patch, as it would require tagging sockets or a netfilter
hook.

Bump ABI to v8 to allow userland to detect and use these new access
rights.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h | 20 ++++++++++++++---
 security/landlock/audit.c     |  2 ++
 security/landlock/limits.h    |  2 +-
 security/landlock/net.c       | 41 ++++++++++++++++++++++-------------
 security/landlock/syscalls.c  |  2 +-
 5 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index efb383af40b2..8f748fcf79dd 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -186,9 +186,9 @@ struct landlock_net_port_attr {
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
@@ -340,10 +340,24 @@ struct landlock_net_port_attr {
  *   port. Support added in Landlock ABI version 4.
  * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect TCP sockets to the given
  *   remote port. Support added in Landlock ABI version 4.
+ *
+ * And similarly for UDP port numbers:
+ *
+ * - %LANDLOCK_ACCESS_NET_BIND_UDP: Bind UDP sockets to the given local
+ *   port. Support added in Landlock ABI version 8.
+ *   Note: this access right is not required if your program sends
+ *   datagrams and just uses the implicitly bound port assigned by the
+ *   kernel to reply. Conversely, denying this right only blocks a
+ *   program from binding to non-ephemeral ports if it can send datagrams.
+ * - %LANDLOCK_ACCESS_NET_CONNECT_UDP: Connect UDP sockets to remote
+ *   addresses with the given remote port. Support added in Landlock ABI
+ *   version 8.
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
+#define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
+#define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index e899995f1fd5..23d8dee320ef 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -44,6 +44,8 @@ static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
 static const char *const net_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_TCP)] = "net.bind_tcp",
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_TCP)] = "net.connect_tcp",
+	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_UDP)] = "net.bind_udp",
+	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_UDP)] = "net.connect_udp",
 };
 
 static_assert(ARRAY_SIZE(net_access_strings) == LANDLOCK_NUM_ACCESS_NET);
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 65b5ff051674..13dd5503e471 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -23,7 +23,7 @@
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
-#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_TCP
+#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_UDP
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 59438285e73b..9bddcf466ce9 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -68,28 +68,31 @@ static int current_check_access_socket(struct socket *const sock,
 
 	switch (address->sa_family) {
 	case AF_UNSPEC:
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP) {
 			/*
 			 * Connecting to an address with AF_UNSPEC dissolves
-			 * the TCP association, which have the same effect as
-			 * closing the connection while retaining the socket
-			 * object (i.e., the file descriptor).  As for dropping
-			 * privileges, closing connections is always allowed.
-			 *
-			 * For a TCP access control system, this request is
-			 * legitimate. Let the network stack handle potential
+			 * the remote association while retaining the socket
+			 * object (i.e., the file descriptor). For TCP, it has
+			 * the same effect as closing the connection. For UDP,
+			 * it removes any preset remote address. As for
+			 * dropping privileges, these actions are always
+			 * allowed.
+			 * Let the network stack handle potential
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
 			 * reject entirely or require
-			 * %LANDLOCK_ACCESS_NET_BIND_TCP for the given port, so
-			 * it cannot be used to bypass the policy.
+			 * %LANDLOCK_ACCESS_NET_BIND_TCP or
+			 * %LANDLOCK_ACCESS_NET_BIND_UDP for the given port,
+			 * so it cannot be used to bypass the policy.
 			 *
 			 * IPv4 sockets map AF_UNSPEC to AF_INET for
 			 * retrocompatibility for bind accesses, only if the
@@ -132,10 +135,12 @@ static int current_check_access_socket(struct socket *const sock,
 		addr4 = (struct sockaddr_in *)address;
 		port = addr4->sin_port;
 
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP) {
 			audit_net.dport = port;
 			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
-		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			audit_net.sport = port;
 			audit_net.v4info.saddr = addr4->sin_addr.s_addr;
 		} else {
@@ -154,10 +159,12 @@ static int current_check_access_socket(struct socket *const sock,
 		addr6 = (struct sockaddr_in6 *)address;
 		port = addr6->sin6_port;
 
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP) {
 			audit_net.dport = port;
 			audit_net.v6info.daddr = addr6->sin6_addr;
-		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
+		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
+			   access_request == LANDLOCK_ACCESS_NET_BIND_UDP) {
 			audit_net.sport = port;
 			audit_net.v6info.saddr = addr6->sin6_addr;
 		} else {
@@ -215,6 +222,8 @@ static int hook_socket_bind(struct socket *const sock,
 
 	if (sk_is_tcp(sock->sk))
 		access_request = LANDLOCK_ACCESS_NET_BIND_TCP;
+	else if (sk_is_udp(sock->sk))
+		access_request = LANDLOCK_ACCESS_NET_BIND_UDP;
 	else
 		return 0;
 
@@ -230,6 +239,8 @@ static int hook_socket_connect(struct socket *const sock,
 
 	if (sk_is_tcp(sock->sk))
 		access_request = LANDLOCK_ACCESS_NET_CONNECT_TCP;
+	else if (sk_is_udp(sock->sk))
+		access_request = LANDLOCK_ACCESS_NET_CONNECT_UDP;
 	else
 		return 0;
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0116e9f93ffe..66fd196be85a 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -161,7 +161,7 @@ static const struct file_operations ruleset_fops = {
  * Documentation/userspace-api/landlock.rst should be updated to reflect the
  * UAPI change.
  */
-const int landlock_abi_version = 7;
+const int landlock_abi_version = 8;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
-- 
2.47.3


