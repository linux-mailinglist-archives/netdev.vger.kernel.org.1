Return-Path: <netdev+bounces-191645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01C4ABC8C6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA32A1B63A6E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B492135D7;
	Mon, 19 May 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="k5nFUYJD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55D212FA2
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688349; cv=none; b=ce6CQ6z9nGbuTMcOhbNNKSlenINAQwDDiczzLuzgy8wIIYF0ddXZg0Jd/tUVKhUEamsHC+2olazZQTE3d7mTEkKQ3sYwsyUI87rsVT0enmr1DyR8RJNoc8BmwO114apNYoUcLgzrv6IjA1UwjzjDzsKp/1SvyWpl1TLxG79/42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688349; c=relaxed/simple;
	bh=WohNqLNRqZdEv51p7Hvcod9VJVDYptAdxi7klfvEelA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1WJMiApJOoKdHJ92DkhAcRcyLazvzjpyIygxZMXG5a/0VrjuaDr5y0jHyQrl6FZgjhMznXHOihQh6sZCgIL3O/oxaG+hYNbb9cN+bRh6wsa1HVVtz7QGO1/9l46x0uy2MBKopH1rW/HObZcG4nhKymFhUooixwPeKhuvuUfYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=k5nFUYJD; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747688347; x=1779224347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v1XC3AkIq3k+Nhy58enGn5PyEHLqldMQvs9n157DBNw=;
  b=k5nFUYJDHpe0wSr4k0MaRQ/KOzR//zyHDK7PH1AaP01gwLClTlEFfLxS
   a5omeHhQlH6CXMiNHeB2JNmpqMPAKkARYEHXR7ugdAljTfkxoa7DKgk9X
   UxKFvrtSh8tPf+ohEW3Y5nSBC5JzAvFMuDAGudpmqbnb2gVR8992TCOY2
   j6hTWT5BiH7bO+wX4t8a24rEf2rpx7BNLXi3DgOs3aRhHdklNnYsqFiM2
   ud/hCvCvCBtFKkRe9Rz1HT3nz7AwJ/d7leRNXDtuJEDzP0DNmm+qs0wzK
   lsx5UaeKUiY8iwnElUr+GD6sjLmtMonptzB/hJQJZZ1+oYRLaRHgEin+A
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="299457146"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 20:59:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:8195]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.177:2525] with esmtp (Farcaster)
 id 3abf5e94-96eb-4a2e-8f5b-e95eb0085498; Mon, 19 May 2025 20:59:03 +0000 (UTC)
X-Farcaster-Flow-ID: 3abf5e94-96eb-4a2e-8f5b-e95eb0085498
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 20:59:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 20:58:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 1/9] af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
Date: Mon, 19 May 2025 13:57:52 -0700
Message-ID: <20250519205820.66184-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519205820.66184-1-kuniyu@amazon.com>
References: <20250519205820.66184-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, the same checks for SOCK_PASSCRED and SOCK_PASSPIDFD
are scattered across many places.

Let's centralise the bit tests to make the following changes cleaner.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
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


