Return-Path: <netdev+bounces-189429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8CAB20E5
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 03:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4C11BA3F36
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5B264FAC;
	Sat, 10 May 2025 01:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rNRhEIYu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964A1DEFE0
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842257; cv=none; b=cqYlGIaFETp7tHMs4G4raeeWQHrO+pPr14wVzwm7lBy0OuAVaWqqexbSu9Ka2ggDGJ+pBu9ukASdNTDs2QEVdEQzMk8QB3IRpk0i4Nksegd+wh0LVX+FnJKa8+kO6BvqpmBAufQWZtsVZCF1UFwdA7qHGdJ7duT7vunvinuoFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842257; c=relaxed/simple;
	bh=0oLE3qdqCyZ9Jle6bYq8An/niK7qelTPF6+EEgW/vVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgCIhDYP+vI6Z+LxDC6TWvL9kKqRc0k/2NMOtXNu+0TtASe+Zbnbs7Ui+WBNQ0N4H+ByCONNQ8nsCnqBIq/uFxg8fubuWmSdxDFkyQUeOFZbBEQUkmO9GGE0G2A4a752xM4XMtBiHCJzj20f5wdl8vj+kAjpTKGG8Mi8rY7L/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rNRhEIYu; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842256; x=1778378256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKYg1aNxce/Mao3wSx23vtqjMuvPL0uO/6o/o5nX0Ds=;
  b=rNRhEIYum4hsvvV49Ewkb+1Pwm2depKvu8AJDAzJb0zEN2h/VHwCmlVl
   9NmZvxV+uF5lf4DudZjzRxYFTV7XT0oJkUzaKIKmZ6lMqHN2DXu+CAE5i
   r3aFigAAGaFhtjmTixcJsm8Xf+wQC/EWQRILNMcm1lmHrM5kZuWvUWic2
   e7Dljpn/jnBVHFojRoFytSR4PJkFOx0k2vjXZyRS46QLutXXVBgL1P5lo
   Mg4grJ66Qzi1Q/l1py6g4Dd87YIopb3192p9GtpdO1m+G/rQLnyHX0u1K
   jQR/795DUMCmva8Egf12xfZyuXZmzuvr5qLxEEue8oktibHI5QQWNk21h
   A==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="18314617"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 01:57:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:9370]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.6:2525] with esmtp (Farcaster)
 id c2bb7065-2653-4eac-b1f5-65e0521bbcd5; Sat, 10 May 2025 01:57:30 +0000 (UTC)
X-Farcaster-Flow-ID: c2bb7065-2653-4eac-b1f5-65e0521bbcd5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:57:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:57:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/9] af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
Date: Fri, 9 May 2025 18:56:24 -0700
Message-ID: <20250510015652.9931-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, the same checks for SOCK_PASSCRED and SOCK_PASSPIDFD
are scattered across many places.

Let's centralise the bit tests to make the following changes cleaner.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2ab20821d6bb..464e183ffdb8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -765,6 +765,14 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 	spin_unlock(&sk->sk_peer_lock);
 }
 
+static bool unix_may_passcred(const struct sock *sk)
+{
+	struct socket *sock = sk->sk_socket;
+
+	return test_bit(SOCK_PASSCRED, &sock->flags) ||
+		test_bit(SOCK_PASSPIDFD, &sock->flags);
+}
+
 static int unix_listen(struct socket *sock, int backlog)
 {
 	int err;
@@ -1411,9 +1419,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		if (err)
 			goto out;
 
-		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-		    !READ_ONCE(unix_sk(sk)->addr)) {
+		if (unix_may_passcred(sk) && !READ_ONCE(unix_sk(sk)->addr)) {
 			err = unix_autobind(sk);
 			if (err)
 				goto out;
@@ -1531,9 +1537,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (err)
 		goto out;
 
-	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-	    !READ_ONCE(u->addr)) {
+	if (unix_may_passcred(sk) && !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -1877,16 +1881,6 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	return err;
 }
 
-static bool unix_passcred_enabled(const struct socket *sock,
-				  const struct sock *other)
-{
-	return test_bit(SOCK_PASSCRED, &sock->flags) ||
-	       test_bit(SOCK_PASSPIDFD, &sock->flags) ||
-	       !other->sk_socket ||
-	       test_bit(SOCK_PASSCRED, &other->sk_socket->flags) ||
-	       test_bit(SOCK_PASSPIDFD, &other->sk_socket->flags);
-}
-
 /*
  * Some apps rely on write() giving SCM_CREDENTIALS
  * We include credentials if source or destination socket
@@ -1897,7 +1891,9 @@ static void maybe_add_creds(struct sk_buff *skb, const struct socket *sock,
 {
 	if (UNIXCB(skb).pid)
 		return;
-	if (unix_passcred_enabled(sock, other)) {
+
+	if (unix_may_passcred(sock->sk) ||
+	    !other->sk_socket || unix_may_passcred(other)) {
 		UNIXCB(skb).pid  = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
@@ -1974,9 +1970,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out;
 	}
 
-	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-	    !READ_ONCE(u->addr)) {
+	if (unix_may_passcred(sk) && !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -2846,8 +2840,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			/* Never glue messages from different writers */
 			if (!unix_skb_scm_eq(skb, &scm))
 				break;
-		} else if (test_bit(SOCK_PASSCRED, &sock->flags) ||
-			   test_bit(SOCK_PASSPIDFD, &sock->flags)) {
+		} else if (unix_may_passcred(sk)) {
 			/* Copy credentials */
 			scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
 			unix_set_secdata(&scm, skb);
-- 
2.49.0


