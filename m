Return-Path: <netdev+bounces-190504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82953AB71F4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2263B0ECE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B201F1931;
	Wed, 14 May 2025 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WpMb8WsE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E113DDAA
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241642; cv=none; b=WEzf3nPSy/9sHWjk4RMyvauUbH9Hfe6NRyjpxzp+XCAZPbAEd2/UMOjR1fsGDuKQ5c7mu6QzD4vMNLF25jn9Z9Glo+HdravnxtFdNmE4EFma+HUg+jtltHTUZoHif8KcneSOqvILCNn0c+TlD5V4mLJlJ2IR0VPAEBy2SPZf3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241642; c=relaxed/simple;
	bh=PDvD091LfRjOJtrw1iz9VGRTcVHyrV3DmVJvRrTnlcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWayenMN0nuvm5y2xC+udb3ySWlFkHNrLzbe+J1euc4zld7fFt0+EiuqexOI65oKXsXJf4RE99fDfbPamGPnAa3pjFQqbG2envriej0EVmRbnMNbd8X/VTDooEGd9RceWUy69xLxbOQ4HSWJcS+n4gijsI4+p3fey2lnM8G7kr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WpMb8WsE; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747241641; x=1778777641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JcxTQLj0ekVbtKAdzlZsUKLtF0kxDD5o+d1IvLKKjGg=;
  b=WpMb8WsEbHEPaGMMi0AIfZv0kRoG4xdbMu3K6Y3Owi1yZtNTfTSNpd5w
   Yq3UoYhovk1DXcLy48LsxI08f0BFwCGwX9zN0I5fPO/HN2b1XkkheHoJD
   omjKgG1BNCo83QJj/FldA1tzxs6kb5u/M7JkSDy4NyOkoOdEWzKE3K90i
   kOuHj1+/TEOUk2mUVa1uQPyrDdxmRxbg7u7r6ayraAV57X9+dog4mWruH
   HU9RbgY3Zf/HkbPi0Gc/m3s1T1JGtQRNS+Whp65lUWFJQxZ/ZsUuE0GAo
   ArXLQpUbauikkS5LVz6CFkJ5sJCWZ/7Fhku74J2LgDPnG98KolGoEylna
   A==;
X-IronPort-AV: E=Sophos;i="6.15,288,1739836800"; 
   d="scan'208";a="492264768"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 16:53:53 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:44233]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.52:2525] with esmtp (Farcaster)
 id 2425618c-9b87-4abe-8901-36617d4875e5; Wed, 14 May 2025 16:53:51 +0000 (UTC)
X-Farcaster-Flow-ID: 2425618c-9b87-4abe-8901-36617d4875e5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:53:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:53:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 3/9] scm: Move scm_recv() from scm.h to scm.c.
Date: Wed, 14 May 2025 09:51:46 -0700
Message-ID: <20250514165226.40410-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514165226.40410-1-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

scm_recv() has been placed in scm.h since the pre-git era for no
particular reason (I think), which makes the file really fragile.

For example, when you move SOCK_PASSCRED from include/linux/net.h to
enum sock_flags in include/net/sock.h, you will see weird build failure
due to terrible dependency.

To avoid the build failure in the future, let's move scm_recv(_unix())?
and its callees to scm.c.

Note that only scm_recv() needs to be exported for Bluetooth.

scm_send() should be moved to scm.c too, but I'll revisit later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3: Remove inline in scm.c
---
 include/net/scm.h | 121 ++-------------------------------------------
 net/core/scm.c    | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 117 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 22bb49589fde..84c4707e78a5 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -102,123 +102,10 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
 	return __scm_send(sock, msg, scm);
 }
 
-#ifdef CONFIG_SECURITY_NETWORK
-static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
-{
-	struct lsm_context ctx;
-	int err;
-
-	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &ctx);
-
-		if (err >= 0) {
-			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, ctx.len,
-				 ctx.context);
-			security_release_secctx(&ctx);
-		}
-	}
-}
-
-static inline bool scm_has_secdata(struct socket *sock)
-{
-	return test_bit(SOCK_PASSSEC, &sock->flags);
-}
-#else
-static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
-{ }
-
-static inline bool scm_has_secdata(struct socket *sock)
-{
-	return false;
-}
-#endif /* CONFIG_SECURITY_NETWORK */
-
-static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
-{
-	struct file *pidfd_file = NULL;
-	int len, pidfd;
-
-	/* put_cmsg() doesn't return an error if CMSG is truncated,
-	 * that's why we need to opencode these checks here.
-	 */
-	if (msg->msg_flags & MSG_CMSG_COMPAT)
-		len = sizeof(struct compat_cmsghdr) + sizeof(int);
-	else
-		len = sizeof(struct cmsghdr) + sizeof(int);
-
-	if (msg->msg_controllen < len) {
-		msg->msg_flags |= MSG_CTRUNC;
-		return;
-	}
-
-	if (!scm->pid)
-		return;
-
-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
-
-	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
-		if (pidfd_file) {
-			put_unused_fd(pidfd);
-			fput(pidfd_file);
-		}
-
-		return;
-	}
-
-	if (pidfd_file)
-		fd_install(pidfd, pidfd_file);
-}
-
-static inline bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
-				     struct scm_cookie *scm, int flags)
-{
-	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
-		    test_bit(SOCK_PASSPIDFD, &sock->flags) ||
-		    scm->fp || scm_has_secdata(sock))
-			msg->msg_flags |= MSG_CTRUNC;
-		scm_destroy(scm);
-		return false;
-	}
-
-	if (test_bit(SOCK_PASSCRED, &sock->flags)) {
-		struct user_namespace *current_ns = current_user_ns();
-		struct ucred ucreds = {
-			.pid = scm->creds.pid,
-			.uid = from_kuid_munged(current_ns, scm->creds.uid),
-			.gid = from_kgid_munged(current_ns, scm->creds.gid),
-		};
-		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
-	}
-
-	scm_passec(sock, msg, scm);
-
-	if (scm->fp)
-		scm_detach_fds(msg, scm);
-
-	return true;
-}
-
-static inline void scm_recv(struct socket *sock, struct msghdr *msg,
-			    struct scm_cookie *scm, int flags)
-{
-	if (!__scm_recv_common(sock, msg, scm, flags))
-		return;
-
-	scm_destroy_cred(scm);
-}
-
-static inline void scm_recv_unix(struct socket *sock, struct msghdr *msg,
-				 struct scm_cookie *scm, int flags)
-{
-	if (!__scm_recv_common(sock, msg, scm, flags))
-		return;
-
-	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
-		scm_pidfd_recv(msg, scm);
-
-	scm_destroy_cred(scm);
-}
+void scm_recv(struct socket *sock, struct msghdr *msg,
+	      struct scm_cookie *scm, int flags);
+void scm_recv_unix(struct socket *sock, struct msghdr *msg,
+		   struct scm_cookie *scm, int flags);
 
 static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
 				  unsigned int flags)
diff --git a/net/core/scm.c b/net/core/scm.c
index 733c0cbd393d..66e02b18c359 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -404,3 +404,126 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 	return new_fpl;
 }
 EXPORT_SYMBOL(scm_fp_dup);
+
+#ifdef CONFIG_SECURITY_NETWORK
+static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
+{
+	struct lsm_context ctx;
+	int err;
+
+	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
+		err = security_secid_to_secctx(scm->secid, &ctx);
+
+		if (err >= 0) {
+			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, ctx.len,
+				 ctx.context);
+
+			security_release_secctx(&ctx);
+		}
+	}
+}
+
+static bool scm_has_secdata(struct socket *sock)
+{
+	return test_bit(SOCK_PASSSEC, &sock->flags);
+}
+#else
+static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
+{
+}
+
+static bool scm_has_secdata(struct socket *sock)
+{
+	return false;
+}
+#endif
+
+static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
+{
+	struct file *pidfd_file = NULL;
+	int len, pidfd;
+
+	/* put_cmsg() doesn't return an error if CMSG is truncated,
+	 * that's why we need to opencode these checks here.
+	 */
+	if (msg->msg_flags & MSG_CMSG_COMPAT)
+		len = sizeof(struct compat_cmsghdr) + sizeof(int);
+	else
+		len = sizeof(struct cmsghdr) + sizeof(int);
+
+	if (msg->msg_controllen < len) {
+		msg->msg_flags |= MSG_CTRUNC;
+		return;
+	}
+
+	if (!scm->pid)
+		return;
+
+	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
+
+	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
+		if (pidfd_file) {
+			put_unused_fd(pidfd);
+			fput(pidfd_file);
+		}
+
+		return;
+	}
+
+	if (pidfd_file)
+		fd_install(pidfd, pidfd_file);
+}
+
+static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
+			      struct scm_cookie *scm, int flags)
+{
+	if (!msg->msg_control) {
+		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
+		    test_bit(SOCK_PASSPIDFD, &sock->flags) ||
+		    scm->fp || scm_has_secdata(sock))
+			msg->msg_flags |= MSG_CTRUNC;
+
+		scm_destroy(scm);
+		return false;
+	}
+
+	if (test_bit(SOCK_PASSCRED, &sock->flags)) {
+		struct user_namespace *current_ns = current_user_ns();
+		struct ucred ucreds = {
+			.pid = scm->creds.pid,
+			.uid = from_kuid_munged(current_ns, scm->creds.uid),
+			.gid = from_kgid_munged(current_ns, scm->creds.gid),
+		};
+
+		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
+	}
+
+	scm_passec(sock, msg, scm);
+
+	if (scm->fp)
+		scm_detach_fds(msg, scm);
+
+	return true;
+}
+
+void scm_recv(struct socket *sock, struct msghdr *msg,
+	      struct scm_cookie *scm, int flags)
+{
+	if (!__scm_recv_common(sock, msg, scm, flags))
+		return;
+
+	scm_destroy_cred(scm);
+}
+EXPORT_SYMBOL(scm_recv);
+
+void scm_recv_unix(struct socket *sock, struct msghdr *msg,
+		   struct scm_cookie *scm, int flags)
+{
+	if (!__scm_recv_common(sock, msg, scm, flags))
+		return;
+
+	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
+		scm_pidfd_recv(msg, scm);
+
+	scm_destroy_cred(scm);
+}
-- 
2.49.0


