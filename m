Return-Path: <netdev+bounces-283400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E1eH7fx9WmVQgIAu9opvQ
	(envelope-from <netdev+bounces-283400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:44:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFA4B200C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8C2030088A7
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3FC36CE06;
	Sat,  2 May 2026 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="VC9tbbbL"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311E369998;
	Sat,  2 May 2026 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725876; cv=none; b=VaMf9Gk3b5jMkntb5NuGG9ONkdL57+bwTmpT/TzXpcjG9C639rvRmnxYuGkAdRqL8p7TGT958llFLLgqrbD9q/EAei1p5kAbXc5zEPDIPB4LWETbXuO5D+oly/VTLIMwUzQMgzKk3Jt2ydS0Qgr6VpqSsBOswxVH2rqru5DgQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725876; c=relaxed/simple;
	bh=FsYTb0zN3aUGjLvV5Cmx6QNJD5ALcKsowHd/u3e6vO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X29RNEUJEQp2wxbLn5XEKgYCSZ4yXVAzAjXZ/5iRK1cwgwE7Y0iMG7PC/aKMMWS0CmYmtQf5OkPSE7rL4puLLMg5Y0+m88s/t9xdrNK1kvq314M/SvBeMoll1cDDc77XAB/zYBdd5BG/V4pfCI6YLT56fiaUo/uSauSa09W0dSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=VC9tbbbL; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1777725871; bh=FsYTb0zN3aUGjLvV5Cmx6QNJD5ALcKsowHd/u3e6vO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VC9tbbbLB4tJ7rdyQQ+k5vtB0AU/YMm1ajjcHFtPPXLGE5wU8M4hGcekr2DFXqj6N
	 yje8edYP934FKr/D08gA+hspwdFEwmXbuHLd7fsC2e1nK7KvtXUbu8Cmn3c7favXfA
	 oTUC0FFQwo34TW141/oQtcUsfSPC87jVxCDZT0CagwaDSNgjyff2Blnvq4kNSxnlI2
	 zkOmBdFzvpZOIPSO8ukr/jT1yaxBj/c8oAumQUanNZ1IGGlq3ZsHGkN67HGiQ+P0Sf
	 hHgX8A9pk6iScBl1jbg+eu5cQJs6g86WK/dwBa2E+lFyzQ/ZCHvTH1zz4rsKsMSl2Z
	 /OX+rifwDJgGA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 8075512591B;
	Sat,  2 May 2026 14:44:31 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v4 2/7] landlock: Add UDP connect() access control
Date: Sat,  2 May 2026 14:43:01 +0200
Message-Id: <20260502124306.3975990-3-matthieu@buffet.re>
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
X-Rspamd-Queue-Id: E4DFA4B200C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283400-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add support for a second fine-grained UDP access right.
This first half of LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP controls the
ability to set the remote port of a socket (via connect()). It will be
useful for applications that send datagrams, and for some servers too
(those creating per-client sockets, which want to receive traffic only
from a specific address).

Similarly as for bind(), this access control is performed when
configuring sockets, not in hot code paths.

Include detection of when autobind is about to be required, and check if
the process would be allowed to call bind(0) explicitly. Autobind can
only be performed when sending a first datagram, when connect()ing, and
in some splice() EOF edge case which, afaiu, can only happen after a
remote peer has been set (which is already covered).

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h               | 19 +++++
 security/landlock/audit.c                   |  2 +
 security/landlock/limits.h                  |  2 +-
 security/landlock/net.c                     | 79 +++++++++++++++++----
 tools/testing/selftests/landlock/net_test.c |  5 +-
 5 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 045b251ff1b4..22c8cc63f30e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -378,11 +378,30 @@ struct landlock_net_port_attr {
  *
  * - %LANDLOCK_ACCESS_NET_BIND_UDP: Bind UDP sockets to the given local
  *   port. Support added in Landlock ABI version 10.
+ * - %LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP: Set the remote port of UDP
+ *   sockets to the given port, or send datagrams to the given remote port
+ *   ignoring any destination pre-set on a socket. Support added in
+ *   Landlock ABI version 10.
+ *
+ * .. note:: Setting a remote address or sending a first datagram
+ *   auto-binds UDP sockets to an ephemeral local source port if not
+ *   already bound. To allow this if both %LANDLOCK_ACCESS_NET_BIND_UDP
+ *   and %LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP are handled, you need to
+ *   either:
+ *
+ *   - use a socket already bound to a port before the ruleset started
+ *     being enforced;
+ *   - or grant %LANDLOCK_ACCESS_NET_BIND_UDP on port 0, meaning "any
+ *     port in the ephemeral port range";
+ *   - or grant %LANDLOCK_ACCESS_NET_BIND_UDP on a specific port, and
+ *     call :manpage:`bind(2)` on that port before trying to
+ *     :manpage:`connect(2)` or send datagrams.
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
+#define LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP		(1ULL << 3)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index e676ebffeebe..851647197a01 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -46,6 +46,8 @@ static const char *const net_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_TCP)] = "net.bind_tcp",
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_TCP)] = "net.connect_tcp",
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_UDP)] = "net.bind_udp",
+	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP)] =
+		"net.connect_send_udp",
 };
 
 static_assert(ARRAY_SIZE(net_access_strings) == LANDLOCK_NUM_ACCESS_NET);
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index c0f30a4591b8..a4d908b240a2 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -23,7 +23,7 @@
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
-#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_BIND_UDP
+#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index f9ccb52e7d45..045881f81295 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -68,16 +68,17 @@ static int current_check_access_socket(struct socket *const sock,
 
 	switch (address->sa_family) {
 	case AF_UNSPEC:
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
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
@@ -134,7 +135,8 @@ static int current_check_access_socket(struct socket *const sock,
 		addr4 = (struct sockaddr_in *)address;
 		port = addr4->sin_port;
 
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
 			audit_net.dport = port;
 			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
 		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
@@ -157,7 +159,8 @@ static int current_check_access_socket(struct socket *const sock,
 		addr6 = (struct sockaddr_in6 *)address;
 		port = addr6->sin6_port;
 
-		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
+		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
 			audit_net.dport = port;
 			audit_net.v6info.daddr = addr6->sin6_addr;
 		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
@@ -213,6 +216,50 @@ static int current_check_access_socket(struct socket *const sock,
 	return -EACCES;
 }
 
+static int current_check_autobind_udp_socket(struct socket *const sock)
+{
+	struct sockaddr_storage port0 = { 0 };
+
+	/*
+	 * On UDP sockets, if a local port has not already been bound,
+	 * calling connect() or sending a first datagram has the side
+	 * effect of autobinding an ephemeral port: we also have to check
+	 * that the process would have had the right to bind(0) explicitly.
+	 * Note: socket is not locked, so another thread could do an
+	 * explicit bind(!=0) on this socket, changing inet_num to non-zero
+	 * after we read it, but this would only have us enforce an
+	 * additional bind(0) access check and would not bypass policy.
+	 */
+	if (inet_sk(sock->sk)->inet_num != 0)
+		return 0;
+
+	/*
+	 * Construct a struct sockaddr* with port 0 to pretend the
+	 * process tried to bind() on that address.
+	 */
+	port0.ss_family = sock->sk->__sk_common.skc_family;
+	switch (port0.ss_family) {
+	case AF_INET: {
+		((struct sockaddr_in *)&port0)->sin_port = 0;
+		break;
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6: {
+		((struct sockaddr_in6 *)&port0)->sin6_port = 0;
+		break;
+	}
+#endif /* IS_ENABLED(CONFIG_IPV6) */
+
+	default:
+		return 0;
+	}
+
+	return current_check_access_socket(sock, (struct sockaddr *)&port0,
+					   sizeof(port0),
+					   LANDLOCK_ACCESS_NET_BIND_UDP);
+}
+
 static int hook_socket_bind(struct socket *const sock,
 			    struct sockaddr *const address, const int addrlen)
 {
@@ -234,14 +281,22 @@ static int hook_socket_connect(struct socket *const sock,
 			       const int addrlen)
 {
 	access_mask_t access_request;
+	int ret = 0;
 
 	if (sk_is_tcp(sock->sk))
 		access_request = LANDLOCK_ACCESS_NET_CONNECT_TCP;
+	else if (sk_is_udp(sock->sk))
+		access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
 	else
 		return 0;
 
-	return current_check_access_socket(sock, address, addrlen,
-					   access_request);
+	ret = current_check_access_socket(sock, address, addrlen,
+					  access_request);
+
+	if (ret == 0 && sk_is_udp(sock->sk))
+		ret = current_check_autobind_udp_socket(sock);
+
+	return ret;
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index ec392d971ea3..016c7277e370 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1326,12 +1326,13 @@ FIXTURE_TEARDOWN(mini)
 
 /* clang-format off */
 
-#define ACCESS_LAST LANDLOCK_ACCESS_NET_BIND_UDP
+#define ACCESS_LAST LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP
 
 #define ACCESS_ALL ( \
 	LANDLOCK_ACCESS_NET_BIND_TCP | \
 	LANDLOCK_ACCESS_NET_CONNECT_TCP | \
-	LANDLOCK_ACCESS_NET_BIND_UDP)
+	LANDLOCK_ACCESS_NET_BIND_UDP | \
+	LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP)
 
 /* clang-format on */
 
-- 
2.39.5


