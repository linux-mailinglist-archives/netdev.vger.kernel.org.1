Return-Path: <netdev+bounces-244513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1423CB9468
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C863036A00
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD12C21EC;
	Fri, 12 Dec 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="FmTgQoG7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F42C21C4;
	Fri, 12 Dec 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557434; cv=none; b=GWId6sGvR4XfMxZzRnB6X3TMpgVM2afQz+HjjZKZdy6UQDfUdu1iwQa1Jj7+MjCDy12mZ/2RKULa6ceuIldoOBDMMbC1xOiiQDoox3B40mqY1U71fW/ZAu01COFrqVWi59/NKwVewmjurTyRWNiG07wNA67nQTMmkQ1qvhcfhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557434; c=relaxed/simple;
	bh=QxF+FWvBiwqcG0IPVYPwC3xSQsuc85J3w2UiI7IpB84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7JbBAfE08KaEccBJUEZFZzeSIL1Vfs5K1nWnJ1SBVluCwZAL+bEcqj33RPA3TixNHoW7BcwfWcyzSt2hyGnXWplKrPQUV4INtucJqdEWhNCwEBo+KmPEaprY+A6TYW5DqfTRkb77lz0QLty/UQaZ/S0y1pgZi9PQMLmcjXlQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=FmTgQoG7; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557429; bh=QxF+FWvBiwqcG0IPVYPwC3xSQsuc85J3w2UiI7IpB84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmTgQoG71/u7e7IEykqNFaGmN/mzRvQ3ieH9QeKF2A0LU2u9cRFmR799ZWPNjeoM5
	 9CEqX2nJSi3VOgzYHTFh6fZrn+fH9uhJ5jTIh+MTm6bETS4gQFjdw1xFwhADWFY+Cl
	 dwqfdG3mcMsnnm7BDn07dlF72IqtfGSoj3DW4Do3IoSTfD5iN4F+oNq5nH/SfHKDg9
	 JEVE/R/QWQkRG6UXM88nsFmeEz3exnIxBfj522d7+qdvUrktY3IKczjKrE4L08AiUM
	 PEPUVmTrqTV9yGWuzSwyd2jcAAYrSuoM6CAjcxblggTSMKAtsML0R6QxTd1lOPyxdx
	 BjyAjAcg/uUDQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 36A1512548D;
	Fri, 12 Dec 2025 17:37:09 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 5/8] landlock: Add UDP sendmsg access control
Date: Fri, 12 Dec 2025 17:37:01 +0100
Message-Id: <20251212163704.142301-6-matthieu@buffet.re>
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

Add support for a LANDLOCK_ACCESS_NET_SENDTO_UDP access right, providing
control over specifying a UDP datagram's destination address explicitly
in sendto(), sendmsg(), and sendmmsg().
This complements the previous control of connect() via
LANDLOCK_ACCESS_NET_CONNECT_UDP.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h | 13 ++++++++
 security/landlock/audit.c     |  1 +
 security/landlock/limits.h    |  2 +-
 security/landlock/net.c       | 61 +++++++++++++++++++++++++++++++++--
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 8f748fcf79dd..c43586e02216 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -352,12 +352,25 @@ struct landlock_net_port_attr {
  * - %LANDLOCK_ACCESS_NET_CONNECT_UDP: Connect UDP sockets to remote
  *   addresses with the given remote port. Support added in Landlock ABI
  *   version 8.
+ * - %LANDLOCK_ACCESS_NET_SENDTO_UDP: Send datagrams on UDP sockets with
+ *   an explicit destination address set to the given remote port.
+ *   Support added in Landlock ABI version 8. Note: this access right
+ *   does not control sending datagrams with no explicit destination
+ *   (e.g. via :manpage:`send(2)` or ``sendto(..., NULL, 0)``, so this
+ *   access right is not necessary when specifying a destination address
+ *   once and for all in :manpage:`connect(2)`.
+ *
+ *   Note: sending datagrams to an explicit ``AF_UNSPEC`` destination
+ *   address family is not supported. For IPv4 sockets, you will need to
+ *   use an ``AF_INET`` address instead, and for IPv6 sockets, you will
+ *   need to use a ``NULL`` address.
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
 #define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
+#define LANDLOCK_ACCESS_NET_SENDTO_UDP			(1ULL << 4)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 23d8dee320ef..e0c030727dab 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -46,6 +46,7 @@ static const char *const net_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_TCP)] = "net.connect_tcp",
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_UDP)] = "net.bind_udp",
 	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_UDP)] = "net.connect_udp",
+	[BIT_INDEX(LANDLOCK_ACCESS_NET_SENDTO_UDP)] = "net.sendto_udp",
 };
 
 static_assert(ARRAY_SIZE(net_access_strings) == LANDLOCK_NUM_ACCESS_NET);
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 13dd5503e471..b6d26bc5c49e 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -23,7 +23,7 @@
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
-#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_UDP
+#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_SENDTO_UDP
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 9bddcf466ce9..061a531339de 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -121,6 +121,34 @@ static int current_check_access_socket(struct socket *const sock,
 				else
 					return -EAFNOSUPPORT;
 			}
+		} else if (access_request == LANDLOCK_ACCESS_NET_SENDTO_UDP) {
+			/*
+			 * We cannot allow LANDLOCK_ACCESS_NET_SENDTO_UDP on an
+			 * explicit AF_UNSPEC address. That's because semantics
+			 * of AF_UNSPEC change between socket families (e.g.
+			 * IPv6 treat it as "no address" in the sendmsg()
+			 * syscall family, so we should always allow, whilst
+			 * IPv4 treat it as AF_INET, so we should filter based
+			 * on port, and future address families might even do
+			 * something else), and the socket's family can change
+			 * under our feet due to setsockopt(IPV6_ADDRFORM).
+			 */
+			audit_net.family = AF_UNSPEC;
+			landlock_init_layer_masks(subject->domain,
+						  access_request, &layer_masks,
+						  LANDLOCK_KEY_NET_PORT);
+			landlock_log_denial(
+				subject,
+				&(struct landlock_request){
+					.type = LANDLOCK_REQUEST_NET_ACCESS,
+					.audit.type = LSM_AUDIT_DATA_NET,
+					.audit.u.net = &audit_net,
+					.access = access_request,
+					.layer_masks = &layer_masks,
+					.layer_masks_size =
+						ARRAY_SIZE(layer_masks),
+				});
+			return -EACCES;
 		} else {
 			WARN_ON_ONCE(1);
 		}
@@ -136,7 +164,8 @@ static int current_check_access_socket(struct socket *const sock,
 		port = addr4->sin_port;
 
 		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
-		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP) {
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP ||
+		    access_request == LANDLOCK_ACCESS_NET_SENDTO_UDP) {
 			audit_net.dport = port;
 			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
 		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
@@ -160,7 +189,8 @@ static int current_check_access_socket(struct socket *const sock,
 		port = addr6->sin6_port;
 
 		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
-		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP) {
+		    access_request == LANDLOCK_ACCESS_NET_CONNECT_UDP ||
+		    access_request == LANDLOCK_ACCESS_NET_SENDTO_UDP) {
 			audit_net.dport = port;
 			audit_net.v6info.daddr = addr6->sin6_addr;
 		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
@@ -248,9 +278,36 @@ static int hook_socket_connect(struct socket *const sock,
 					   access_request);
 }
 
+static int hook_socket_sendmsg(struct socket *const sock,
+			       struct msghdr *const msg, const int size)
+{
+	struct sockaddr *const address = msg->msg_name;
+	const int addrlen = msg->msg_namelen;
+	access_mask_t access_request;
+
+	/*
+	 * If there is no explicit address in the message, we have no
+	 * policy to enforce here because either:
+	 * - the socket has a remote address assigned, so the appropriate
+	 *   access check has already been done back then at assignment time;
+	 * - or, we can let the networking stack reply -EDESTADDRREQ.
+	 */
+	if (!address)
+		return 0;
+
+	if (sk_is_udp(sock->sk))
+		access_request = LANDLOCK_ACCESS_NET_SENDTO_UDP;
+	else
+		return 0;
+
+	return current_check_access_socket(sock, address, addrlen,
+					   access_request);
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
 	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
+	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
 };
 
 __init void landlock_add_net_hooks(void)
-- 
2.47.3


