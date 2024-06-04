Return-Path: <netdev+bounces-100690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA608FB99A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F83B27E35
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314E148FFB;
	Tue,  4 Jun 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kLXcAJYZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB4148840
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520041; cv=none; b=tzN0oHVW8orKhqGlgnRceT3Zj2FaEgTMwYNfz4V7JYcMWEIcy+F6x7OWq2PehPmk6rqL96GP9Emq+8WZliLTXinLnUDZjpqktSNiFQlYkmZ2poz2AIzmLWYvA38uUaG499Vqjnl49OVNBXduLVot58mrppVx4qyNp7JRqF5NKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520041; c=relaxed/simple;
	bh=xSCzvZEtsy0INtvDok8NlG1h09pQ4bqKiaIg3a8do0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQMNhqjf2Xt5mvC+j++PRuNXZG3aJcM7PGnYu+vIi7AEUeUCORTql+/FeBi7vK4kVDkFe9awjWtFbH0zuyPo/XjQV1hN44FOCkhSWM0l/fWmfEDhsoBZ6ctfI4lYaSUHsFc2B0499Mv0ZyXnAR/MR+Z1dLSdlB0MNBBz9WyyQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kLXcAJYZ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717520040; x=1749056040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TV3QC62xQwybspneDWE3FYlo39KQQwj5u/AH6EWwSFw=;
  b=kLXcAJYZKuwTnC65CvuRGuQ4EnYcuohldpiXfRnqGTBOH4ZBK5inQvnw
   s2Xgd53SA1DxjsvvYd8/xjum7ucBDsSEgrJxioOBh7OeVSgPU6VA3NOiO
   wYpwd8K18UZFPf1cwTogaG/dSQ9/ofO9L1YGUY1uVjFLSC81qz3HgYaus
   A=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="423763898"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:53:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:29579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.52:2525] with esmtp (Farcaster)
 id 19b34c0d-5f1a-4726-a300-0c2c5f4dcdce; Tue, 4 Jun 2024 16:53:51 +0000 (UTC)
X-Farcaster-Flow-ID: 19b34c0d-5f1a-4726-a300-0c2c5f4dcdce
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:53:42 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:53:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 02/15] af_unix: Annodate data-races around sk->sk_state for writers.
Date: Tue, 4 Jun 2024 09:52:28 -0700
Message-ID: <20240604165241.44758-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604165241.44758-1-kuniyu@amazon.com>
References: <20240604165241.44758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk->sk_state is changed under unix_state_lock(), but it's read locklessly
in many places.

This patch adds WRITE_ONCE() on the writer side.

We will add READ_ONCE() to the lockless readers in the following patches.

Fixes: 83301b5367a9 ("af_unix: Set TCP_ESTABLISHED for datagram sockets too")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b162164b7a42..424d021a4d7d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -616,7 +616,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	state = sk->sk_state;
-	sk->sk_state = TCP_CLOSE;
+	WRITE_ONCE(sk->sk_state, TCP_CLOSE);
 
 	skpair = unix_peer(sk);
 	unix_peer(sk) = NULL;
@@ -738,7 +738,8 @@ static int unix_listen(struct socket *sock, int backlog)
 	if (backlog > sk->sk_max_ack_backlog)
 		wake_up_interruptible_all(&u->peer_wait);
 	sk->sk_max_ack_backlog	= backlog;
-	sk->sk_state		= TCP_LISTEN;
+	WRITE_ONCE(sk->sk_state, TCP_LISTEN);
+
 	/* set credentials so connect can copy them */
 	init_peercred(sk);
 	err = 0;
@@ -1401,7 +1402,8 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		if (err)
 			goto out_unlock;
 
-		sk->sk_state = other->sk_state = TCP_ESTABLISHED;
+		WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
+		WRITE_ONCE(other->sk_state, TCP_ESTABLISHED);
 	} else {
 		/*
 		 *	1003.1g breaking connected state with AF_UNSPEC
@@ -1418,7 +1420,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 
 		unix_peer(sk) = other;
 		if (!other)
-			sk->sk_state = TCP_CLOSE;
+			WRITE_ONCE(sk->sk_state, TCP_CLOSE);
 		unix_dgram_peer_wake_disconnect_wakeup(sk, old_peer);
 
 		unix_state_double_unlock(sk, other);
@@ -1639,7 +1641,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	copy_peercred(sk, other);
 
 	sock->state	= SS_CONNECTED;
-	sk->sk_state	= TCP_ESTABLISHED;
+	WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
 	sock_hold(newsk);
 
 	smp_mb__after_atomic();	/* sock_hold() does an atomic_inc() */
@@ -2050,7 +2052,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			unix_peer(sk) = NULL;
 			unix_dgram_peer_wake_disconnect_wakeup(sk, other);
 
-			sk->sk_state = TCP_CLOSE;
+			WRITE_ONCE(sk->sk_state, TCP_CLOSE);
 			unix_state_unlock(sk);
 
 			unix_dgram_disconnected(sk, other);
-- 
2.30.2


