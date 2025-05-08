Return-Path: <netdev+bounces-188835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2594FAAF0A1
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E5A3AA591
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F40813A41F;
	Thu,  8 May 2025 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wgns16XT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A053FD1
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667865; cv=none; b=bK8skbhIa7Y4HygBosyjhsNFZtEKmzbfdRH01qVmcxWI9osMVRObr+Zdg0o600UlSjYm3UEIbtTxPg9JMqdl8Y6+aYCWAHQShN8CVdMf21gTKXvZsT1iBXJTDEkFg8HToG672zVQRlkPaaReE8vs35BHD9kBUhgsJYamnhvsFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667865; c=relaxed/simple;
	bh=3cJpyBW8TsjX4TAMK5mSarNSrdyQFkKT8DR+hA8jTzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYmS2hKUPHb5um+ojYDgrzZY91UgJh++9RSDJUMr4+A5ehk4pxS9XgzG7rj9JfOB9reF2cVVZjQau6NBdTnsPB62+GLU8eOXZ2NGm8k1LpttQ8/D92/MCBJnN1X7vfB0yKWeQeTpQTC9HVJw3VQK+TmNpOVJqzMeYuXBPcDvagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wgns16XT; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746667864; x=1778203864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QK5suJ3jlwER2a4Axjui1vsx8GdEyXWNY8N7StyPO9Y=;
  b=Wgns16XTitj7nJP7G6/jairBX5KBlxn1YPp0UPlQj/6s9+Eheg7tsiFt
   BI38yjeUcBl+qRPx7eYEpnGYjh9AYL55FX48vWJmBrRnOijg3u94gG1B8
   dxwKjCswLFT5ER/bUDfeZ4slGisnXvmlASlwlscurS/4PWA+n+IbCUtgV
   7sRnB7kIKZb0JSt37P8uFkiQDSG/BLyvn7ulViL3Nrvt0bUg3L7IsW32t
   PNoXEv0zIMbBG6L2Quuat48Ut1nUIZl6xlAiaia3dbCtgZeuQhvU8Z68n
   uL/r8VjAlyRYpjfW66WlpjhETvMtUOedUcK6zi0qID4G7Bua8miXI6c1W
   w==;
X-IronPort-AV: E=Sophos;i="6.15,271,1739836800"; 
   d="scan'208";a="17632915"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:30:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:18267]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.6:2525] with esmtp (Farcaster)
 id d1989a47-3e63-4899-b164-a92bc54eda95; Thu, 8 May 2025 01:30:56 +0000 (UTC)
X-Farcaster-Flow-ID: d1989a47-3e63-4899-b164-a92bc54eda95
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:30:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:30:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/7] af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
Date: Wed, 7 May 2025 18:29:13 -0700
Message-ID: <20250508013021.79654-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, the same checks for SOCK_PASSCRED and SOCK_PASSPIDFD
are scattered across many places.

Let's centralise the bit tests to make the following changes cleaner.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2ab20821d6bb..6dbe866f5e24 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -765,6 +765,14 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 	spin_unlock(&sk->sk_peer_lock);
 }
 
+static bool unix_passcred_enabled(const struct sock *sk)
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
+		if (unix_passcred_enabled(sk) && !READ_ONCE(unix_sk(sk)->addr)) {
 			err = unix_autobind(sk);
 			if (err)
 				goto out;
@@ -1531,9 +1537,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (err)
 		goto out;
 
-	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-	    !READ_ONCE(u->addr)) {
+	if (unix_passcred_enabled(sk) && !READ_ONCE(u->addr)) {
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
+	if (unix_passcred_enabled(sock->sk) ||
+	    !other->sk_socket || unix_passcred_enabled(other)) {
 		UNIXCB(skb).pid  = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
@@ -1974,9 +1970,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out;
 	}
 
-	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-	    !READ_ONCE(u->addr)) {
+	if (unix_passcred_enabled(sk) && !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -2846,8 +2840,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			/* Never glue messages from different writers */
 			if (!unix_skb_scm_eq(skb, &scm))
 				break;
-		} else if (test_bit(SOCK_PASSCRED, &sock->flags) ||
-			   test_bit(SOCK_PASSPIDFD, &sock->flags)) {
+		} else if (unix_passcred_enabled(sk)) {
 			/* Copy credentials */
 			scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
 			unix_set_secdata(&scm, skb);
-- 
2.49.0


