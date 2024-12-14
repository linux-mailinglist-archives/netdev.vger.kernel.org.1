Return-Path: <netdev+bounces-151963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C99F2062
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 19:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752DF167F73
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 18:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083A193094;
	Sat, 14 Dec 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="cRpj9Gxl"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5A194C67;
	Sat, 14 Dec 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202022; cv=none; b=VgmMrWI5dH9n88geR5IsbHcObQaZ/npI5SxS8n8zs5kfdaUsUg+F+RRad9kJeG8xTRVUWiRsGUBjubeCPSeDOkByZm7B8KdWZjgeDvGP60kNx86wzwLNR/1+eggiFce1sGFd15oyZvPxRwtW5H3McgGObDTXJUPZIWT/ovMjBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202022; c=relaxed/simple;
	bh=9wfpgLvCykLDojzmjtn/oAwFupg3MkK6nNo6+mrviIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yhy88YNhVPPjeSefRZlGDH64Pn2AzyAQNBRho4t/wStYT8UAr6/WSTuJYUdjOglN79BVLWF6UhD1VXiMmLIslOBw1boBBV988nsxEDBcoSLh7ZS8iXTWmMV3JeYukH08RCUgadqHro4VyWxE+HMcsAv17QC1TbygNafV8incRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=cRpj9Gxl; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1734202017; bh=9wfpgLvCykLDojzmjtn/oAwFupg3MkK6nNo6+mrviIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRpj9Gxlwc/46SIw3BlVB31i6aRUUg3fWwXv2S7DEIj1E8ooOL3CVhac/ZacMM8rD
	 6rUm73qZIHbiExcyP4Wr0wKpPoKPbHMCf2UxarC9+vL+OfvTbT2R4y7LvqISEDB9tz
	 aqrWfKsIZV57CFGzZfRvhetWX3tbSFvAtAppj8nWdJqm+QBw2QL/Atr3DOgjIR8nEI
	 ejb/WZxpe+cX/GC6sD8LCLuhhw8MUKEEl1l0W6hstjc3Cs4tztB7e3ogUQFnizkUsf
	 6mOlkLUMwaShoF1Z8pdDE45o5oiSke6L8k73jLFCRmp1O+jw7Tk5DNCLsCDvlNOUvR
	 yqt08SPO5SdNg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 26AA31252E6;
	Sat, 14 Dec 2024 19:46:57 +0100 (CET)
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
Subject: [PATCH v2 3/6] landlock: Add UDP sendmsg access control
Date: Sat, 14 Dec 2024 19:45:37 +0100
Message-Id: <20241214184540.3835222-4-matthieu@buffet.re>
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

Add support for a LANDLOCK_ACCESS_NET_SENDTO_UDP access right,
complementing the two previous LANDLOCK_ACCESS_NET_CONNECT_UDP and
LANDLOCK_ACCESS_NET_BIND_UDP.
It allows denying and delegating the right to sendto() datagrams with an
explicit destination address and port, without requiring to connect() the
socket first.

Performance is of course worse if you send many datagrams this way,
compared to just connect() then sending without an address (except if you
use sendmmsg() which caches LSM results). This may still be desired by
applications which send few enough datagrams to different clients that
opening and connecting a socket for each one of them is not worth it.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 include/uapi/linux/landlock.h | 14 ++++++
 security/landlock/limits.h    |  2 +-
 security/landlock/net.c       | 88 +++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 3f7b8e85822d..8b355891e986 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -295,6 +295,19 @@ struct landlock_net_port_attr {
  *   every time), or for servers that want to filter which client address
  *   they want to receive datagrams from (e.g. creating a client-specific
  *   socket)
+ * - %LANDLOCK_ACCESS_NET_SENDTO_UDP: send datagrams with an explicit
+ *   destination address set to the given remote port. This access right
+ *   is checked in sendto(), sendmsg() and sendmmsg() when the destination
+ *   address passed is not NULL. This access right is not required when
+ *   sending datagrams without an explicit destination (via a connected
+ *   socket, e.g. with send()). Sending datagrams with explicit addresses
+ *   induces a non-negligible overhead, so calling connect() once and for
+ *   all should be preferred. When not possible and sending many datagrams,
+ *   using sendmmsg() may reduce the access control overhead.
+ *
+ * Blocking an application from sending UDP traffic requires adding both
+ * %LANDLOCK_ACCESS_NET_SENDTO_UDP and %LANDLOCK_ACCESS_NET_CONNECT_UDP
+ * to the handled access rights list.
  *
  * Note that binding on port 0 means binding to an ephemeral
  * kernel-assigned port, in the range configured in
@@ -306,6 +319,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
 #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
 #define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
+#define LANDLOCK_ACCESS_NET_SENDTO_UDP			(1ULL << 4)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index ca90c1c56458..8d12ca39cf2e 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -22,7 +22,7 @@
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
-#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_UDP
+#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_SENDTO_UDP
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 1c5cf2ddb7c1..0556d8a21d0b 100644
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
@@ -155,6 +157,27 @@ static int current_check_access_socket(struct socket *const sock,
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
@@ -190,9 +213,74 @@ static int hook_socket_connect(struct socket *const sock,
 					   access_request);
 }
 
+static int hook_socket_sendmsg(struct socket *const sock,
+			       struct msghdr *const msg, const int size)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_applicable_domain(landlock_get_current_domain(),
+					       any_net);
+	const struct sockaddr *address = (const struct sockaddr *)msg->msg_name;
+	const int addrlen = msg->msg_namelen;
+	__be16 port;
+
+	if (!dom)
+		return 0;
+	if (WARN_ON_ONCE(dom->num_layers < 1))
+		return -EACCES;
+	/*
+	 * If there is no explicit address in the message, we have no
+	 * policy to enforce here because either:
+	 * - the socket was previously connect()ed, so the appropriate
+	 *   access check has already been done back then;
+	 * - the socket is unconnected, so we can let the networking stack
+	 *   reply -EDESTADDRREQ
+	 */
+	if (!address)
+		return 0;
+
+	if (!sk_is_udp(sock->sk))
+		return 0;
+
+	/* Checks for minimal header length to safely read sa_family. */
+	if (addrlen < offsetofend(typeof(*address), sa_family))
+		return -EINVAL;
+
+	switch (address->sa_family) {
+	case AF_UNSPEC:
+		/*
+		 * Parsed as "no address" in udpv6_sendmsg(), which means
+		 * we fall back into the case checked earlier: policy was
+		 * enforced at connect() time, nothing to enforce here.
+		 */
+		if (sock->sk->sk_prot == &udpv6_prot)
+			return 0;
+		/* Parsed as "AF_INET" in udp_sendmsg() */
+		fallthrough;
+	case AF_INET:
+		if (addrlen < sizeof(struct sockaddr_in))
+			return -EINVAL;
+		port = ((struct sockaddr_in *)address)->sin_port;
+		break;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		if (addrlen < SIN6_LEN_RFC2133)
+			return -EINVAL;
+		port = ((struct sockaddr_in6 *)address)->sin6_port;
+		break;
+#endif /* IS_ENABLED(CONFIG_IPV6) */
+
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	return check_access_port(dom, LANDLOCK_ACCESS_NET_SENDTO_UDP, port);
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
 	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
+	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
 };
 
 __init void landlock_add_net_hooks(void)
-- 
2.39.5


