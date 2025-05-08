Return-Path: <netdev+bounces-188837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D34AAF0A3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8229811E9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5CD1917F0;
	Thu,  8 May 2025 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EkCBBsrs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1771552FA
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667913; cv=none; b=BLjE9JENr1IY15zp1l5Fwh0Gfb75yDmoMUQEhPxtQ2Ndic5Q8UvKdXbpYrtOmHKLlv4sZ2msH52UN3JU1iMr51Tm3ee7WbNUA4WqYUxIgkDl947UuheUdRyVsEmD+PgAERSDWt0HONVLtpgVFSx2yW6HjJwH2eKf+mJVDr3Ns20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667913; c=relaxed/simple;
	bh=IY7+hDJpvNPb9NV1GeiQwTrMC5oH7IsK+0PISfXPJkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psvgvBnryiJIwQNcoJFqZcF27Sp6pVu0VjMbwQnzjSzcdNOKPoy8cqXokugdcVsPDIip0lzk1cIucDihn+tlHOF9bwXjsunrzC7JUDoTcPNP5WF3i9C24g7F6PA0pJXh+Tg4hz0TIonohAFbTQlbfaUATVGi9RnGFip8nM7zLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EkCBBsrs; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746667912; x=1778203912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bs5cuOlU3A/58Pl1GBb0O2qPoZWUq8C8R45DiKXSE2I=;
  b=EkCBBsrsLKsyhiXNGUGSMj9ee5vvzLLKdiJ164UGXBxB3ZUWl9Lfrp32
   bMFCDz35Oron/2d4MIhMEQn5OXmGxtbWThpOtyCf+DFX/AMiiE2T98Ywv
   BbiFj0kmJMMiUXWI8FHC+z8IFShbZgVzcQBj5EoEi6mM/QRiulO2NY6T/
   qs9f1wt7x3ta9NszXpyLZamo4WQPhhW2xEVeE0pl0WtPLulapJoFYUm7/
   GNyhfjJ5wJ2iE1pOkPBoVQXi7uu9B7ufX1tMpFieTUXiMbOqN6gRLN029
   f4lVkHVZDdGqs7RBAjSfKMtUQgFhOUffEveXanmebAOePnI3UuZ+5qQoy
   A==;
X-IronPort-AV: E=Sophos;i="6.15,271,1739836800"; 
   d="scan'208";a="496532733"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:31:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:61666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 063be568-2c82-4761-bc43-2808fde04954; Thu, 8 May 2025 01:31:46 +0000 (UTC)
X-Farcaster-Flow-ID: 063be568-2c82-4761-bc43-2808fde04954
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:31:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:31:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/7] scm: Move scm_recv() from scm.h to scm.c.
Date: Wed, 7 May 2025 18:29:15 -0700
Message-ID: <20250508013021.79654-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508013021.79654-1-kuniyu@amazon.com>
References: <20250508013021.79654-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

scm_recv() has been placed in scm.h since the pre-git era for no
particular reason (I think), which makes the file really fragile.

For example, when you move SOCK_PASSCRED from include/linux/net.h to
enum sock_flags in include/net/sock.h, you will see weird build failure
due to terrible dependency.

The next patch moves SOCK_PASSXXX to sk->sk_flags to better handle the
new flag for SO_PASSRIGHTS.

To avoid the build failure, let's move scm_recv(_unix())? and its
callees to scm.c.

Note that only scm_recv() needs to be exported for Bluetooth.

scm_send() should be moved to scm.c too, but I'll revisit later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/scm.h | 121 ++-------------------------------------------
 net/core/scm.c    | 122 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 117 deletions(-)

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
index 733c0cbd393d..3f756f00e41e 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -404,3 +404,125 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
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
+static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
+{ }
+
+static inline bool scm_has_secdata(struct socket *sock)
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


