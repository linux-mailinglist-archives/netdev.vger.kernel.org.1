Return-Path: <netdev+bounces-190868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9330DAB9262
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D5A503C8F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31F725A2C4;
	Thu, 15 May 2025 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mkwhuwno"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75B1F153C
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747349430; cv=none; b=ezqfuLUhfXoTlbf2w2tEjQjLQ67vRa5qYX324aYRiDfg4itCFSEBuf7dL1Eau4jWG5szKN0/OrBiJReLOm+XH3L9XODabWZOdB357BCzPf8i/3kx7Zyl+kSXoFWZUDw92ZGkG3c592DULxUt2aO4W1JjGZMtgb+lXe71pMGGnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747349430; c=relaxed/simple;
	bh=0oLE3qdqCyZ9Jle6bYq8An/niK7qelTPF6+EEgW/vVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Os37/4GnnV+ZuvR22HtRj1Mne5uImtyLQ8ZNCqpVvRNzDTBJOel+WkJo7yy5LCruwOkVZVdr/oQvH9Me+OEQaAPUEb2rB9/1c4NtbsepPQ+ultZ8E0ewPnzqbaJslNUDgNqGqR1+uYFYfb599058FmGVf2AnQ488I8mvzE/MTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mkwhuwno; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747349430; x=1778885430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKYg1aNxce/Mao3wSx23vtqjMuvPL0uO/6o/o5nX0Ds=;
  b=mkwhuwnoT55/Nf/6wa/KVpXkFv+XcuCazGGD6maXQwf1muLOULwhwK2U
   Zwb4MDKoudxhT5ujOdM4I4cWazy0geIC7SJ/PHxg9N+Div8ScB0BYxhiy
   SDiX1vlMW2BX87zYIIoxm9sVaTEY7sj0DJYD4QalyxJe09EBAR09CiU2P
   fY/77jQpIic6tu9WKzX7+0JtufiFH7iTmUsRBlCjw6z4OQ5P1BuhW7x8A
   494vLwkJogsK45TpQU+olXZW35CoRD6Qw41aqsZBbrB9zB2R4rSLUe7wz
   yeJg4wMfS4pgInuXCRjaKnn7T/Zjo7bE9YwNe9QmJ9Eun3H3NOzjpvpiB
   w==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="492733537"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:50:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:28819]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 51674b60-7d37-4e85-9406-16ea4a454fc2; Thu, 15 May 2025 22:50:22 +0000 (UTC)
X-Farcaster-Flow-ID: 51674b60-7d37-4e85-9406-16ea4a454fc2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:50:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:50:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 1/9] af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
Date: Thu, 15 May 2025 15:49:09 -0700
Message-ID: <20250515224946.6931-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515224946.6931-1-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
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


