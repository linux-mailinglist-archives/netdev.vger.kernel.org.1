Return-Path: <netdev+bounces-128527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3106197A229
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12F51F2472E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863515624D;
	Mon, 16 Sep 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="O+0D9PWy"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C115153BC1;
	Mon, 16 Sep 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489442; cv=none; b=q1AhkTMFuEAMsVATa44a00FXuS77RRiaHEz8PGI8+N8goQYJaEdLygwrrDJ//QGgL7MCsYvfcDoy8dn8W5OV7om15KbXo+u+MjpIO14/IYwvI4IvUHMDiVb5orrmFRSmFF40fXANtxjSjZAyUF1tmvZ6ILXID4HwAHEA+uNM3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489442; c=relaxed/simple;
	bh=cktMYebcEf4Vqa93W+pdA/xdDVZ5MmjyNXR8lxmsAPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWUybYRH23ISgZLjw1lgWVUeKmaa1eKz44qEowpuxrKIT+K91M56GTlaf9+6jqWD+seG8v6pqqA8WhkBZQwp/8VrfSvZk/mdBu7Acndzhz+OnahtO5hgpFEmZdaUCTgh2Q3sIf4ARlh8wQXIlOvzKkh8erE4sGBpQjTs5kAKRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=O+0D9PWy; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1726489434; bh=cktMYebcEf4Vqa93W+pdA/xdDVZ5MmjyNXR8lxmsAPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+0D9PWyisXibltfJXxiLK09vDJsJEk9q90fJSlTt1uUcv4DAFkL6+JwXf73ZPPIO
	 GEwOU31jEJ5jFYSE1d1QKrr69HGfou2xYd3xZ0UZ8isDogGYd6ekrTRaM9IYYNBIY7
	 pjpK7C5It4tcxKxSx4Fye1RqpZBez3uDmf3EerMG1gvUb1cdvtjkxStFB6v7aEue4u
	 GzDhFtZLm7bSqDGxwft0owxCCh/3aDjgSh8RbUucv/VDPAXh0IvegtZ/MlAd+/4utf
	 k9DSZ4oRxRZW8YBk2PqzmbXg/3B2sesI5PhViQe9ImFQu8EaKiGgWJ06stRBsUCwge
	 xQ71aKLrtfIeA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 817941230C2;
	Mon, 16 Sep 2024 14:23:53 +0200 (CEST)
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
Subject: [RFC PATCH v1 4/7] landlock: Add UDP send+recv access control
Date: Mon, 16 Sep 2024 14:22:27 +0200
Message-Id: <20240916122230.114800-5-matthieu@buffet.re>
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

Add support for two UDP access rights, complementing the two previous
LANDLOCK_ACCESS_NET_CONNECT_UDP and LANDLOCK_ACCESS_NET_BIND_UDP:

- LANDLOCK_ACCESS_NET_RECVMSG_UDP: to prevent a process from receiving
  datagrams. Just removing LANDLOCK_ACCESS_NET_BIND_UDP is not enough:
  it can just send a first datagram or call connect() and get an
  ephemeral port assigned, without ever calling bind(). This access right
  allows blocking a process from receiving UDP datagrams, without
  preventing them to bind() (which may be required to set source ports);

- LANDLOCK_ACCESS_NET_SENDMSG_UDP: to prevent a process from sending
  datagrams. Just removing LANDLOCK_ACCESS_NET_CONNECT_UDP is not enough:
  the process can call sendmsg() with an unconnected socket and an
  arbitrary destination address.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h |  18 ++-
 security/landlock/limits.h    |   2 +-
 security/landlock/net.c       | 205 +++++++++++++++++++++++++++++-----
 3 files changed, 193 insertions(+), 32 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 7f9aa1cd2912..7ea3d1adb8c3 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -287,15 +287,25 @@ struct landlock_net_port_attr {
  *   receive datagrams from (if you create a client-specific socket for a
  *   client-specific process, e.g. using the established-over-unconnected
  *   method)
- *
- * Note that ``bind(0)`` means binding to an ephemeral kernel-assigned port,
- * in the range configured in ``/proc/sys/net/ipv4/ip_local_port_range``
- * globally (or on a per-socket basis with ``setsockopt(IP_LOCAL_PORT_RANGE)``).
+ * - %LANDLOCK_ACCESS_NET_RECVMSG_UDP: receive datagrams on the given local port
+ *   (this is a distinct right from %LANDLOCK_ACCESS_NET_BIND_UDP, because you
+ *   may want to allow a process to set its datagrams source port using bind()
+ *   but not be able to receive datagrams)
+ * - %LANDLOCK_ACCESS_NET_SENDMSG_UDP: send datagrams to the given remote port
+ *   (this is a distinct right from %LANDLOCK_ACCESS_NET_CONNECT_UDP, because
+ *   you may want to allow a process to set which client it wants to receive
+ *   datagrams from using connect(), and not be able to send datagrams)
+ *
+ * Note that ``bind(0)`` has special semantics, meaning bind on any port in the
+ * range configured in ``/proc/sys/net/ipv4/ip_local_port_range`` globally (or
+ * on a per-socket basis with ``setsockopt(IP_LOCAL_PORT_RANGE)``).
  */
 /* clang-format off */
 #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
 #define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
+#define LANDLOCK_ACCESS_NET_RECVMSG_UDP			(1ULL << 4)
+#define LANDLOCK_ACCESS_NET_SENDMSG_UDP			(1ULL << 5)
 /* clang-format on */
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 182b6a8d2976..e2697348310c 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -22,7 +22,7 @@
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
-#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_UDP
+#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_SENDMSG_UDP
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index becc62c02cc9..9a3c44ad3f26 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -10,6 +10,8 @@
 #include <linux/net.h>
 #include <linux/socket.h>
 #include <net/ipv6.h>
+#include <net/transp_v6.h>
+#include <net/ip.h>
 
 #include "common.h"
 #include "cred.h"
@@ -61,6 +63,45 @@ static const struct landlock_ruleset *get_current_net_domain(void)
 	return dom;
 }
 
+static int get_addr_port(const struct sockaddr *address, int addrlen,
+			 bool in_udpv6_sendmsg_ctx, __be16 *port)
+{
+	/* Checks for minimal header length to safely read sa_family. */
+	if (addrlen < offsetofend(typeof(*address), sa_family))
+		return -EINVAL;
+
+	switch (address->sa_family) {
+	case AF_UNSPEC:
+		/*
+		 * Backward compatibility games: AF_UNSPEC is mapped to AF_INET
+		 * by `bind` (v4+v6), `connect` (v4) and `sendmsg` (v4), but
+		 * interpreted as "no address" by `sendmsg` (v6). In that case
+		 * this call must succeed (even if `address` is shorter than a
+		 * `struct sockaddr_in`), and caller must check for this
+		 * condition.
+		 */
+		if (in_udpv6_sendmsg_ctx) {
+			*port = 0;
+			return 0;
+		}
+		fallthrough;
+	case AF_INET:
+		if (addrlen < sizeof(struct sockaddr_in))
+			return -EINVAL;
+		*port = ((struct sockaddr_in *)address)->sin_port;
+		return 0;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		if (addrlen < SIN6_LEN_RFC2133)
+			return -EINVAL;
+		*port = ((struct sockaddr_in6 *)address)->sin6_port;
+		return 0;
+#endif /* IS_ENABLED(CONFIG_IPV6) */
+	}
+
+	return -EAFNOSUPPORT;
+}
+
 static int current_check_access_socket(struct socket *const sock,
 				       struct sockaddr *const address,
 				       const int addrlen,
@@ -73,39 +114,18 @@ static int current_check_access_socket(struct socket *const sock,
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
 	const struct landlock_ruleset *const dom = get_current_net_domain();
+	int err;
 
 	if (!dom)
 		return 0;
 	if (WARN_ON_ONCE(dom->num_layers < 1))
 		return -EACCES;
 
-	/* Checks if it's a (potential) UDP or TCP socket. */
-	if (sock->type != SOCK_STREAM && sock->type != SOCK_DGRAM)
-		return 0;
-
-	/* Checks for minimal header length to safely read sa_family. */
-	if (addrlen < offsetofend(typeof(*address), sa_family))
-		return -EINVAL;
-
-	switch (address->sa_family) {
-	case AF_UNSPEC:
-	case AF_INET:
-		if (addrlen < sizeof(struct sockaddr_in))
-			return -EINVAL;
-		port = ((struct sockaddr_in *)address)->sin_port;
-		break;
-
-#if IS_ENABLED(CONFIG_IPV6)
-	case AF_INET6:
-		if (addrlen < SIN6_LEN_RFC2133)
-			return -EINVAL;
-		port = ((struct sockaddr_in6 *)address)->sin6_port;
-		break;
-#endif /* IS_ENABLED(CONFIG_IPV6) */
-
-	default:
-		return 0;
-	}
+	err = get_addr_port(address, addrlen, false, &port);
+	if (err == -EAFNOSUPPORT)
+		return 0; // restrictions are not applicable to this socket family
+	else if (err != 0)
+		return err;
 
 	/* Specific AF_UNSPEC handling. */
 	if (address->sa_family == AF_UNSPEC) {
@@ -174,6 +194,27 @@ static int current_check_access_socket(struct socket *const sock,
 	return -EACCES;
 }
 
+static int check_access_port(const struct landlock_ruleset *const dom,
+			     access_mask_t access_request, __be16 port)
+{
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
+	const struct landlock_rule *rule;
+	const struct landlock_id id = {
+		.key.data = (__force uintptr_t)port,
+		.type = LANDLOCK_KEY_NET_PORT,
+	};
+	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
+
+	rule = landlock_find_rule(dom, id);
+	access_request = landlock_init_layer_masks(
+		dom, access_request, &layer_masks, LANDLOCK_KEY_NET_PORT);
+	if (landlock_unmask_layers(rule, access_request, &layer_masks,
+				   ARRAY_SIZE(layer_masks)))
+		return 0;
+
+	return -EACCES;
+}
+
 static int hook_socket_bind(struct socket *const sock,
 			    struct sockaddr *const address, const int addrlen)
 {
@@ -215,9 +256,119 @@ static int hook_socket_connect(struct socket *const sock,
 					   access_request);
 }
 
+static int hook_socket_sendmsg(struct socket *const sock,
+			       struct msghdr *const msg, const int size)
+{
+	const struct landlock_ruleset *const dom = get_current_net_domain();
+	const struct sockaddr *address = (const struct sockaddr *)msg->msg_name;
+	int err;
+	__be16 port;
+
+	if (sock->type != SOCK_DGRAM)
+		return 0;
+	if (sock->sk->sk_protocol != IPPROTO_UDP)
+		return 0;
+	if (!dom)
+		return 0;
+	if (WARN_ON_ONCE(dom->num_layers < 1))
+		return -EACCES;
+
+	/*
+	 * Don't mimic all checks udp_sendmsg() and udpv6_sendmsg() do. Just
+	 * read what we need for access control, and fail if we can't (e.g.
+	 * because the input buffer is too short) with the same error codes as
+	 * they do. Selftests enforce that these error codes do not diverge
+	 * with the actual implementation's ones.
+	 */
+
+	/*
+	 * If there is a more specific address in the message, it will take
+	 * precedence over any connect()ed address. Base our access check on it.
+	 */
+	if (address) {
+		const bool in_udpv6_sendmsg =
+			(sock->sk->sk_prot == &udpv6_prot);
+
+		err = get_addr_port(address, msg->msg_namelen, in_udpv6_sendmsg,
+				    &port);
+		if (err != 0)
+			return err;
+
+		/*
+		 * In `udpv6_sendmsg`, AF_UNSPEC is interpreted as "no address".
+		 * In that case, the call above will succeed but without
+		 * returning a port.
+		 */
+		if (in_udpv6_sendmsg && address->sa_family == AF_UNSPEC)
+			address = NULL;
+	}
+
+	/*
+	 * Without a message-specific destination address, the socket must be
+	 * connect()ed to an address, base our access check on that one.
+	 */
+	if (!address) {
+		/*
+		 * We could let this through and count on `udp_sendmsg` and
+		 * `udpv6_sendmsg` to error out, but they could change in the
+		 * future and open a hole here without knowing. Enforce an
+		 * error, and enforce in selftests that we don't diverge in
+		 * behaviours compared to them.
+		 */
+		if (sock->sk->sk_state != TCP_ESTABLISHED)
+			return -EDESTADDRREQ;
+
+		port = inet_sk(sock->sk)->inet_dport;
+	}
+
+	return check_access_port(dom, LANDLOCK_ACCESS_NET_SENDMSG_UDP, port);
+}
+
+static int hook_socket_recvmsg(struct socket *const sock,
+			       struct msghdr *const msg, const int size,
+			       const int flags)
+{
+	const struct landlock_ruleset *const dom = get_current_net_domain();
+	struct sock *sk = sock->sk;
+	int err;
+	__be16 port_bigendian;
+	int ephemeral_low;
+	int ephemeral_high;
+	__u16 port_hostendian;
+
+	if (sk->sk_protocol != IPPROTO_UDP)
+		return 0;
+	if (!dom)
+		return 0;
+	if (WARN_ON_ONCE(dom->num_layers < 1))
+		return -EACCES;
+
+	/* "fast" path: socket is bound to an explicitly allowed port */
+	port_bigendian = inet_sk(sk)->inet_sport;
+	err = check_access_port(dom, LANDLOCK_ACCESS_NET_RECVMSG_UDP,
+				port_bigendian);
+	if (err != -EACCES)
+		return err;
+
+	/*
+	 * Slow path: socket is bound to an ephemeral port. Need a second check
+	 * on port 0 with different semantics ("any ephemeral port").
+	 */
+	inet_sk_get_local_port_range(sk, &ephemeral_low, &ephemeral_high);
+	port_hostendian = ntohs(port_bigendian);
+	if (ephemeral_low <= port_hostendian &&
+	    port_hostendian <= ephemeral_high)
+		return check_access_port(dom, LANDLOCK_ACCESS_NET_RECVMSG_UDP,
+					 0);
+
+	return -EACCES;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
 	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
+	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
+	LSM_HOOK_INIT(socket_recvmsg, hook_socket_recvmsg),
 };
 
 __init void landlock_add_net_hooks(void)
-- 
2.39.5


