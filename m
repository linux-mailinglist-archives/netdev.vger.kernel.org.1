Return-Path: <netdev+bounces-188838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC384AAF0A4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194CF4C63F0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43331917F0;
	Thu,  8 May 2025 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ibeNV882"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227552CA8
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667938; cv=none; b=R5I2s6mL6Zf3/AI+tgYWslyFg52QZ3SrxifiG2Om3+jxELVGKHmjiJjakG349UdUbDUh6L37Q84qeO3wP2xXHOBK63EEHCRiIHfq1vURrpvsIjOk8QBfM5BGYPg2Zp7v7NpMCez3/Df3H5cCS7GiT3kbtZ8q0eOKHDscGGXXzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667938; c=relaxed/simple;
	bh=f5lGS4b4JNX7yxSnYzO7H7uM+wcX1tkp6ZfGUGoXe7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdJw4273HLsBfcji5Aclkc/Yw46zfYaOGHozCgh3XQr2H7SKEgOfaQU9gfml46E/aOCh7zHpJ4zwzMicAGlLTyI7swBcwVYjv1MpQvKkwdCePnCXlaegtDkCGrMPg+L4yeHOMJhEBZrZ+O7d1EdK08+qr+yLecTlzsx9WW7HuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ibeNV882; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746667938; x=1778203938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FmmfNZ5djphlyEDVtT6IPurdtOYavkWYEYFEwzIbXiQ=;
  b=ibeNV882NT3robqZs88LBLc0QjtrNLBn+gd656DteDh3gBeQ/at/SGov
   8vlLR+EAtPeRV+FJYezlmUPcf/TAu/duz2rQ/j3zNUTwwyESuzM7MsJoM
   5HXb+Iwik48fQ30DXwr6qzJV69dvCLE+CAc55WjwMJvKVTQDFZBdmGhXY
   q/XQk1yZ0mcxLY8I6DuiZnVw092/xN860PRYf4FUcRiYgBd/i9QLcrszK
   lwhfhfgqO58DyE6w0NZ6ogRSq/I+K+eRmFMXgUPoFBs1wtxYRS3mkBcC5
   KHNFzBRaigTifv299WgEP/+RW3lMRX4xUKw47XFT+8PpuO63nf/q6bAdd
   g==;
X-IronPort-AV: E=Sophos;i="6.15,271,1739836800"; 
   d="scan'208";a="518449552"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:32:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:62142]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.121:2525] with esmtp (Farcaster)
 id fe08ae8c-1841-4863-94c8-756fd93295d8; Thu, 8 May 2025 01:32:11 +0000 (UTC)
X-Farcaster-Flow-ID: fe08ae8c-1841-4863-94c8-756fd93295d8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:32:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:32:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/7] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to sk->sk_flags.
Date: Wed, 7 May 2025 18:29:16 -0700
Message-ID: <20250508013021.79654-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As explained in the next patch, SO_PASSRIGHTS would have a problem
if we assigned a corresponding bit to socket->flags, so it must be
flagged on sk->sk_flags.

Mixing socket->flags and sk->sk_flags for similar options will look
confusing, and sk->sk_flags is unsigned long and has enough space.

Let's move SOCK_PASS{CRED,PIDFD,SEC} to sk->sk_flags.

While at it, BUILD_BUG_ON() is added in sock_set_flag(), and other
SOCK_XXX flags in net.h are grouped as enum.

Now, we can drop unix_sock_inherit_flags() and use sock_copy_flags()
instead to inherit flags from a listener to its embryo socket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/net.h | 15 +++++++--------
 include/net/sock.h  |  5 +++++
 net/core/scm.c      | 14 ++++++++------
 net/core/sock.c     | 12 ++++++------
 net/unix/af_unix.c  | 19 +++----------------
 5 files changed, 29 insertions(+), 36 deletions(-)

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
index f0fabb9fd28a..48b8856e2615 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -964,6 +964,10 @@ enum sock_flags {
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
+	SOCK_PASSCRED, /* Receive SCM_CREDENTIALS ancillary data with packet */
+	SOCK_PASSPIDFD, /* Receive SCM_PIDFD ancillary data with packet */
+	SOCK_PASSSEC, /* Receive SCM_SECURITY ancillary data with packet */
+	SOCK_FLAG_MAX,
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
@@ -981,6 +985,7 @@ static inline void sock_copy_flags(struct sock *nsk, const struct sock *osk)
 
 static inline void sock_set_flag(struct sock *sk, enum sock_flags flag)
 {
+	BUILD_BUG_ON(BYTES_TO_BITS(sizeof(sk->sk_flags)) <= SOCK_FLAG_MAX);
 	__set_bit(flag, &sk->sk_flags);
 }
 
diff --git a/net/core/scm.c b/net/core/scm.c
index 3f756f00e41e..4bf19f6303dd 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -411,7 +411,7 @@ static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cooki
 	struct lsm_context ctx;
 	int err;
 
-	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
+	if (sock_flag(sock->sk, SOCK_PASSSEC)) {
 		err = security_secid_to_secctx(scm->secid, &ctx);
 
 		if (err >= 0) {
@@ -425,7 +425,7 @@ static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cooki
 
 static bool scm_has_secdata(struct socket *sock)
 {
-	return test_bit(SOCK_PASSSEC, &sock->flags);
+	return sock_flag(sock->sk, SOCK_PASSSEC);
 }
 #else
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
@@ -476,9 +476,11 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
 			      struct scm_cookie *scm, int flags)
 {
+	struct sock *sk = sock->sk;
+
 	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
-		    test_bit(SOCK_PASSPIDFD, &sock->flags) ||
+		if (sock_flag(sk, SOCK_PASSCRED) ||
+		    sock_flag(sk, SOCK_PASSPIDFD) ||
 		    scm->fp || scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 
@@ -486,7 +488,7 @@ static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
 		return false;
 	}
 
-	if (test_bit(SOCK_PASSCRED, &sock->flags)) {
+	if (sock_flag(sock->sk, SOCK_PASSCRED)) {
 		struct user_namespace *current_ns = current_user_ns();
 		struct ucred ucreds = {
 			.pid = scm->creds.pid,
@@ -521,7 +523,7 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	if (!__scm_recv_common(sock, msg, scm, flags))
 		return;
 
-	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
+	if (sock_flag(sock->sk, SOCK_PASSPIDFD))
 		scm_pidfd_recv(msg, scm);
 
 	scm_destroy_cred(scm);
diff --git a/net/core/sock.c b/net/core/sock.c
index b64df2463300..a1720c7f9789 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1221,13 +1221,13 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		}
 		return -EPERM;
 	case SO_PASSSEC:
-		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
+		sock_valbool_flag(sk, SOCK_PASSSEC, valbool);
 		return 0;
 	case SO_PASSCRED:
-		assign_bit(SOCK_PASSCRED, &sock->flags, valbool);
+		sock_valbool_flag(sk, SOCK_PASSCRED, valbool);
 		return 0;
 	case SO_PASSPIDFD:
-		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
+		sock_valbool_flag(sk, SOCK_PASSPIDFD, valbool);
 		return 0;
 	case SO_TYPE:
 	case SO_PROTOCOL:
@@ -1853,11 +1853,11 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSCRED:
-		v.val = !!test_bit(SOCK_PASSCRED, &sock->flags);
+		v.val = sock_flag(sk, SOCK_PASSCRED);
 		break;
 
 	case SO_PASSPIDFD:
-		v.val = !!test_bit(SOCK_PASSPIDFD, &sock->flags);
+		v.val = sock_flag(sk, SOCK_PASSPIDFD);
 		break;
 
 	case SO_PEERCRED:
@@ -1954,7 +1954,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSSEC:
-		v.val = !!test_bit(SOCK_PASSSEC, &sock->flags);
+		v.val = sock_flag(sk, SOCK_PASSSEC);
 		break;
 
 	case SO_PEERSEC:
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fa86e8c3aec5..e793e55f6c9b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -767,10 +767,8 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 static bool unix_passcred_enabled(const struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
-
-	return test_bit(SOCK_PASSCRED, &sock->flags) ||
-		test_bit(SOCK_PASSPIDFD, &sock->flags);
+	return sock_flag(sk, SOCK_PASSCRED) ||
+		sock_flag(sk, SOCK_PASSPIDFD);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
@@ -1713,17 +1711,6 @@ static int unix_socketpair(struct socket *socka, struct socket *sockb)
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
@@ -1760,7 +1747,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	unix_state_lock(tsk);
 	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
-	unix_sock_inherit_flags(sock, newsock);
+	sock_copy_flags(tsk, sk);
 	sock_graft(tsk, newsock);
 	unix_state_unlock(tsk);
 	return 0;
-- 
2.49.0


