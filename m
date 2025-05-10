Return-Path: <netdev+bounces-189434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0EAB20EC
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 03:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5CF7AF11D
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC672676F8;
	Sat, 10 May 2025 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VKhcMwNE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923091F03D4
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842381; cv=none; b=sVd0t6fwK+C8Uphy8/rUY9YDMdZf5QuT0v4e0Rc2t3JLST2LX6Uef3EE+Z6mtsn9WV6XUwirU0zVSL7ctavg/zJnAkrX6+nLnQyD2pktxKkqbvKbLlJJkFQLTS1ukzXNzJ/GtqtP7lM56sIphFqSIvQTTSRFA+UJx8wISPIuoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842381; c=relaxed/simple;
	bh=SYibWzwG4TZs2Va37/4onHrxYgnoo2gFJL4y2nULBA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/pCcwMmdXIyLep1o3woOEwf1j828PVv1MtQ3cqw/10Npvwijys1ucQpAd/HrVonTHK8WUsqdZ4iSb/QQ0m8hath8axhqCEEuAfZPSQc2/3rpVjYGdv+4T31kG8Sb415lXYEB2dQ1C0CyeUHFMgoyLvaW4nQgqnuDo4z1gVeu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VKhcMwNE; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842380; x=1778378380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jb8TRJJCqf/aZvCadVc+wz2AWCtCWGnXIpz1PQxuqMI=;
  b=VKhcMwNETfUvnf7iqY5F/kLrmlcDhd3dOW1pU+Wp18VBkVXtnbt8xHn3
   3ROKrhXAXWUTPqtyakWBD5tdEYX8+zJKvh/cyz6AFtQdqtSVqZ617o3b9
   UPnZ8XfL3CNfpaBJyzp4doyt47M4i9r/bjn8WdrQMCvxQyxM4PREz/ADW
   1d93nDc7uftIoFyOXHO6/vFJZMWz1xmy4r7k46LKgrYAF12lbeck0HRwa
   LJVFN7buGd8f4ju/WxiEG0GB6Aj9Ibb4vKzrY01A6wFdN5j7r1ECEpDLh
   0u9JkaDNM6xVGELEVz17nPDywekVb/9qRsQ8Lw2C+yo7oN6WemBm4vS21
   g==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="823417004"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 01:59:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:2363]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.21:2525] with esmtp (Farcaster)
 id 61b1bb38-dd23-4df8-b3af-1fc4418d8616; Sat, 10 May 2025 01:59:33 +0000 (UTC)
X-Farcaster-Flow-ID: 61b1bb38-dd23-4df8-b3af-1fc4418d8616
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:59:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:59:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
Date: Fri, 9 May 2025 18:56:29 -0700
Message-ID: <20250510015652.9931-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250510015652.9931-1-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As explained in the next patch, SO_PASSRIGHTS would have a problem
if we assigned a corresponding bit to socket->flags, so it must be
managed in struct sock.

Mixing socket->flags and sk->sk_flags for similar options will look
confusing, and sk->sk_flags does not have enough space on 32bit system.

Also, as mentioned in commit 16e572626961 ("af_unix: dont send
SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
is known to be slow, and managing the flags in struct socket cannot
avoid that for embryo sockets.

Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.

While at it, other SOCK_XXX flags in net.h are grouped as enum.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/net.h | 15 +++++++--------
 include/net/sock.h  | 13 ++++++++++++-
 net/core/scm.c      | 29 ++++++++++++++---------------
 net/core/sock.c     | 12 ++++++------
 net/unix/af_unix.c  | 18 ++----------------
 5 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 0ff950eecc6b..f8418d6e33e0 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -36,14 +36,13 @@ struct net;
  * in sock->flags, but moved into sk->sk_wq->flags to be RCU protected.
  * Eventually all flags will be in sk->sk_wq->flags.
  */
-#define SOCKWQ_ASYNC_NOSPACE	0
-#define SOCKWQ_ASYNC_WAITDATA	1
-#define SOCK_NOSPACE		2
-#define SOCK_PASSCRED		3
-#define SOCK_PASSSEC		4
-#define SOCK_SUPPORT_ZC		5
-#define SOCK_CUSTOM_SOCKOPT	6
-#define SOCK_PASSPIDFD		7
+enum socket_flags {
+	SOCKWQ_ASYNC_NOSPACE,
+	SOCKWQ_ASYNC_WAITDATA,
+	SOCK_NOSPACE,
+	SOCK_SUPPORT_ZC,
+	SOCK_CUSTOM_SOCKOPT,
+};
 
 #ifndef ARCH_HAS_SOCKET_TYPES
 /**
diff --git a/include/net/sock.h b/include/net/sock.h
index af0719ba331f..036ed7d394ba 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -337,6 +337,10 @@ struct sk_filter;
   *	@sk_txtime_deadline_mode: set deadline mode for SO_TXTIME
   *	@sk_txtime_report_errors: set report errors mode for SO_TXTIME
   *	@sk_txtime_unused: unused txtime flags
+  *	@sk_scm_recv_flags: All flags used by scm_recv()
+  *	@sk_scm_credentials: flagged by SO_PASSCRED to recv SCM_CREDENTIALS
+  *	@sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
+  *	@sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
   *	@ns_tracker: tracker for netns reference
   *	@sk_user_frags: xarray of pages the user is holding a reference on.
   *	@sk_owner: reference to the real owner of the socket that calls
@@ -523,7 +527,14 @@ struct sock {
 #endif
 	int			sk_disconnects;
 
-	u8			sk_txrehash;
+	union {
+		u8		sk_txrehash;
+		u8		sk_scm_recv_flags;
+		u8		sk_scm_credentials : 1,
+				sk_scm_security : 1,
+				sk_scm_pidfd : 1,
+				sk_scm_unused : 5;
+	};
 	u8			sk_clockid;
 	u8			sk_txtime_deadline_mode : 1,
 				sk_txtime_report_errors : 1,
diff --git a/net/core/scm.c b/net/core/scm.c
index 3f756f00e41e..ffc0b917b4e7 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -406,12 +406,12 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 EXPORT_SYMBOL(scm_fp_dup);
 
 #ifdef CONFIG_SECURITY_NETWORK
-static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
+static void scm_passec(struct sock *sk, struct msghdr *msg, struct scm_cookie *scm)
 {
 	struct lsm_context ctx;
 	int err;
 
-	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
+	if (sk->sk_scm_security) {
 		err = security_secid_to_secctx(scm->secid, &ctx);
 
 		if (err >= 0) {
@@ -423,15 +423,15 @@ static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cooki
 	}
 }
 
-static bool scm_has_secdata(struct socket *sock)
+static bool scm_has_secdata(struct sock *sk)
 {
-	return test_bit(SOCK_PASSSEC, &sock->flags);
+	return sk->sk_scm_security;
 }
 #else
-static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
+static inline void scm_passec(struct sock *sk, struct msghdr *msg, struct scm_cookie *scm)
 { }
 
-static inline bool scm_has_secdata(struct socket *sock)
+static inline bool scm_has_secdata(struct sock *sk)
 {
 	return false;
 }
@@ -473,20 +473,19 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 		fd_install(pidfd, pidfd_file);
 }
 
-static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
+static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 			      struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
-		    test_bit(SOCK_PASSPIDFD, &sock->flags) ||
-		    scm->fp || scm_has_secdata(sock))
+		if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
+		    scm->fp || scm_has_secdata(sk))
 			msg->msg_flags |= MSG_CTRUNC;
 
 		scm_destroy(scm);
 		return false;
 	}
 
-	if (test_bit(SOCK_PASSCRED, &sock->flags)) {
+	if (sk->sk_scm_credentials) {
 		struct user_namespace *current_ns = current_user_ns();
 		struct ucred ucreds = {
 			.pid = scm->creds.pid,
@@ -497,7 +496,7 @@ static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
 		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
 	}
 
-	scm_passec(sock, msg, scm);
+	scm_passec(sk, msg, scm);
 
 	if (scm->fp)
 		scm_detach_fds(msg, scm);
@@ -508,7 +507,7 @@ static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
 void scm_recv(struct socket *sock, struct msghdr *msg,
 	      struct scm_cookie *scm, int flags)
 {
-	if (!__scm_recv_common(sock, msg, scm, flags))
+	if (!__scm_recv_common(sock->sk, msg, scm, flags))
 		return;
 
 	scm_destroy_cred(scm);
@@ -518,10 +517,10 @@ EXPORT_SYMBOL(scm_recv);
 void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 		   struct scm_cookie *scm, int flags)
 {
-	if (!__scm_recv_common(sock, msg, scm, flags))
+	if (!__scm_recv_common(sock->sk, msg, scm, flags))
 		return;
 
-	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
+	if (sock->sk->sk_scm_pidfd)
 		scm_pidfd_recv(msg, scm);
 
 	scm_destroy_cred(scm);
diff --git a/net/core/sock.c b/net/core/sock.c
index 1ab59efbafc5..9540cbe3d83e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1224,19 +1224,19 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		if (!sk_may_scm_recv(sk))
 			return -EOPNOTSUPP;
 
-		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
+		sk->sk_scm_security = valbool;
 		return 0;
 	case SO_PASSCRED:
 		if (!sk_may_scm_recv(sk))
 			return -EOPNOTSUPP;
 
-		assign_bit(SOCK_PASSCRED, &sock->flags, valbool);
+		sk->sk_scm_credentials = valbool;
 		return 0;
 	case SO_PASSPIDFD:
 		if (!sk_is_unix(sk))
 			return -EOPNOTSUPP;
 
-		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
+		sk->sk_scm_pidfd = valbool;
 		return 0;
 	case SO_TYPE:
 	case SO_PROTOCOL:
@@ -1865,14 +1865,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_PASSCRED:
 		if (sk_may_scm_recv(sk))
-			v.val = !!test_bit(SOCK_PASSCRED, &sock->flags);
+			v.val = sk->sk_scm_credentials;
 		else
 			v.val = 0;
 		break;
 
 	case SO_PASSPIDFD:
 		if (sk_is_unix(sk))
-			v.val = !!test_bit(SOCK_PASSPIDFD, &sock->flags);
+			v.val = sk->sk_scm_pidfd;
 		else
 			v.val = 0;
 		break;
@@ -1972,7 +1972,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_PASSSEC:
 		if (sk_may_scm_recv(sk))
-			v.val = !!test_bit(SOCK_PASSSEC, &sock->flags);
+			v.val = sk->sk_scm_security;
 		else
 			v.val = 0;
 		break;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a39497fd6e98..83436297b0b3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -767,10 +767,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 static bool unix_may_passcred(const struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
-
-	return test_bit(SOCK_PASSCRED, &sock->flags) ||
-		test_bit(SOCK_PASSPIDFD, &sock->flags);
+	return sk->sk_scm_credentials || sk->sk_scm_pidfd;
 }
 
 static int unix_listen(struct socket *sock, int backlog)
@@ -1713,17 +1710,6 @@ static int unix_socketpair(struct socket *socka, struct socket *sockb)
 	return 0;
 }
 
-static void unix_sock_inherit_flags(const struct socket *old,
-				    struct socket *new)
-{
-	if (test_bit(SOCK_PASSCRED, &old->flags))
-		set_bit(SOCK_PASSCRED, &new->flags);
-	if (test_bit(SOCK_PASSPIDFD, &old->flags))
-		set_bit(SOCK_PASSPIDFD, &new->flags);
-	if (test_bit(SOCK_PASSSEC, &old->flags))
-		set_bit(SOCK_PASSSEC, &new->flags);
-}
-
 static int unix_accept(struct socket *sock, struct socket *newsock,
 		       struct proto_accept_arg *arg)
 {
@@ -1760,7 +1746,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	unix_state_lock(tsk);
 	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
-	unix_sock_inherit_flags(sock, newsock);
+	tsk->sk_scm_recv_flags = sk->sk_scm_recv_flags;
 	sock_graft(tsk, newsock);
 	unix_state_unlock(tsk);
 	return 0;
-- 
2.49.0


