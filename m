Return-Path: <netdev+bounces-82455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB688DE46
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 13:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A8F1F2B310
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876BD13777E;
	Wed, 27 Mar 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ckRe9EAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7991353E1
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541295; cv=none; b=b9dy0VU1vXp9g6wSroKcKVJ2AohisgCsk+bzhJd68tQh3r74wotLQHfBnzzsHxqrUhqFnML/7QYwqIwDx7Vy3XOoINF9fp8ZrqXWTm8KjeSsWSsffKXh2Eyxf6mKfgNzp/yR1K31QPKub99D6NYgUKGSWC7hMjHRFSfdtZLnako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541295; c=relaxed/simple;
	bh=wsJyPEx2+OHIxwu1PDF8iIUG11MmICqv+9NDlJGjClk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JyF1lCTVDS7wleuNp7vZx+fZijya0m26hDyEx48+RnzAch+rT7MKlTgPlqGhtgLa28dGrOVfUJJxAFRZYI6IE5bzu6SyrT84Fg1x1i43AaR0yQX+CnxtNIZ9jKaHSczmOjVqQ4eZw+cN8q1JQaBpocUTAlhWxxHJeqAiLBD5P7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ckRe9EAU; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V4QGy6bSdzCVP;
	Wed, 27 Mar 2024 13:00:42 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V4QGx73kmzDJl;
	Wed, 27 Mar 2024 13:00:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711540842;
	bh=wsJyPEx2+OHIxwu1PDF8iIUG11MmICqv+9NDlJGjClk=;
	h=From:To:Cc:Subject:Date:From;
	b=ckRe9EAUoLoeV6FrsJfCbIK0mRmcQrQC/BMWJyAEuPhGLRsiVC5Qlx+Wzl5fzw+XX
	 CUM2NkPPvQDMwJwZtBmdrwDS16tpVRndjPmTeaCvczBe8xqhxPi9SqRyHEwruemKAX
	 VY4+FtC8oIeHXLY9GKGGP9owvJh63Tz9cA7IJkVg=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH v1 1/2] lsm: Check and handle error priority for socket_bind and socket_connect
Date: Wed, 27 Mar 2024 13:00:33 +0100
Message-ID: <20240327120036.233641-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Because the security_socket_bind and the security_socket_bind hooks are
called before the network stack, it is easy to introduce error code
inconsistencies. Instead of adding new checks to current and future
LSMs, let's fix the related hook instead. The new checks are already
(partially) implemented by SELinux and Landlock, and it should not
change user space behavior but improve error code consistency instead.

The first check is about the minimal sockaddr length according to the
address family. This improves the security of the AF_INET and AF_INET6
sockaddr parsing for current and future LSMs.

The second check is about AF_UNSPEC. This fixes error priority for bind
on PF_INET6 socket when SELinux (and potentially others) is enabled.
Indeed, the IPv6 network stack first checks the sockaddr length (-EINVAL
error) before checking the family (-EAFNOSUPPORT error). See commit
bbf5a1d0e5d0 ("selinux: Fix error priority for bind with AF_UNSPEC on
PF_INET6 socket").

The third check is about consistency between socket family and address
family. Only AF_INET and AF_INET6 are tested (by Landlock tests), so no
other protocols are checked for now.

These new checks should enable to simplify current LSM implementations,
but we may want to first land this patch on all stable branches.

A following patch adds new tests improving AF_UNSPEC test coverage for
Landlock.

Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Günther Noack <gnoack@google.com>
Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Fixes: 20510f2f4e2d ("security: Convert LSM into a static interface")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/security.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/security/security.c b/security/security.c
index 7e118858b545..64fe07a73b14 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,7 +28,9 @@
 #include <linux/xattr.h>
 #include <linux/msg.h>
 #include <linux/overflow.h>
+#include <linux/in.h>
 #include <net/flow.h>
+#include <net/ipv6.h>
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
@@ -4415,6 +4417,82 @@ int security_socket_socketpair(struct socket *socka, struct socket *sockb)
 }
 EXPORT_SYMBOL(security_socket_socketpair);
 
+static int validate_inet_addr(struct socket *sock, struct sockaddr *address,
+			      int addrlen, bool bind)
+{
+	const int sock_family = sock->sk->sk_family;
+
+	/* Checks for minimal header length to safely read sa_family. */
+	if (addrlen < offsetofend(typeof(*address), sa_family))
+		return -EINVAL;
+
+	/* Only handle inet sockets for now. */
+	switch (sock_family) {
+	case PF_INET:
+	case PF_INET6:
+		break;
+	default:
+		return 0;
+	}
+
+	/* Checks minimal address length for inet sockets. */
+	switch (address->sa_family) {
+	case AF_UNSPEC: {
+		const struct sockaddr_in *sa_in;
+
+		/* Cf. inet_dgram_connect(), __inet_stream_connect() */
+		if (!bind)
+			return 0;
+
+		if (sock_family == PF_INET6) {
+			/* Length check from inet6_bind_sk() */
+			if (addrlen < SIN6_LEN_RFC2133)
+				return -EINVAL;
+
+			/* Family check from __inet6_bind() */
+			goto err_af;
+		}
+
+		/* Length check from inet_bind_sk() */
+		if (addrlen < sizeof(struct sockaddr_in))
+			return -EINVAL;
+
+		sa_in = (struct sockaddr_in *)address;
+		if (sa_in->sin_addr.s_addr != htonl(INADDR_ANY))
+			goto err_af;
+
+		return 0;
+	}
+	case AF_INET:
+		/* Length check from inet_bind_sk() */
+		if (addrlen < sizeof(struct sockaddr_in))
+			return -EINVAL;
+		break;
+	case AF_INET6:
+		/* Length check from inet6_bind_sk() */
+		if (addrlen < SIN6_LEN_RFC2133)
+			return -EINVAL;
+		break;
+	}
+
+	/*
+	 * Checks sa_family consistency to not wrongfully return -EACCES
+	 * instead of -EINVAL.  Valid sa_family changes are only (from AF_INET
+	 * or AF_INET6) to AF_UNSPEC.
+	 */
+	if (address->sa_family != sock_family)
+		return -EINVAL;
+
+	return 0;
+
+err_af:
+	/* SCTP services expect -EINVAL, others -EAFNOSUPPORT. */
+	if (sock->sk->sk_protocol == IPPROTO_SCTP)
+		return -EINVAL;
+
+	return -EAFNOSUPPORT;
+}
+
 /**
  * security_socket_bind() - Check if a socket bind operation is allowed
  * @sock: socket
@@ -4425,11 +4503,23 @@ EXPORT_SYMBOL(security_socket_socketpair);
  * and the socket @sock is bound to the address specified in the @address
  * parameter.
  *
+ * For security reasons and to get consistent error code whatever LSM are
+ * enabled, we first do the same sanity checks against sockaddr as the ones
+ * done by the network stack (executed after hook).  Currently only AF_UNSPEC,
+ * AF_INET, and AF_INET6 are handled.  Please add support for other family
+ * specificities when handled by an LSM.
+ *
  * Return: Returns 0 if permission is granted.
  */
 int security_socket_bind(struct socket *sock,
 			 struct sockaddr *address, int addrlen)
 {
+	int err;
+
+	err = validate_inet_addr(sock, address, addrlen, true);
+	if (err)
+		return err;
+
 	return call_int_hook(socket_bind, sock, address, addrlen);
 }
 
@@ -4447,6 +4537,12 @@ int security_socket_bind(struct socket *sock,
 int security_socket_connect(struct socket *sock,
 			    struct sockaddr *address, int addrlen)
 {
+	int err;
+
+	err = validate_inet_addr(sock, address, addrlen, false);
+	if (err)
+		return err;
+
 	return call_int_hook(socket_connect, sock, address, addrlen);
 }
 
-- 
2.44.0


