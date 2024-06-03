Return-Path: <netdev+bounces-100250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367D8D8521
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE75B28A0AA
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894DC12CDAE;
	Mon,  3 Jun 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oOueQiG2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963182D8E
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425230; cv=none; b=ERhMdeB6mDb3oquftAleKqidq67a6v6eVEESfaNbudkCmgm7k6WsebW2GSX/HxcfZQql0MBSwKLdNkRa7f9cserr4xBQyLTWxLgkI1Wpxf2HInRtfqZoAYJJ4FhI4hWZwXWssAxvaUibc+4/yTUerMwYXMRmyaQbRacqSFO0V+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425230; c=relaxed/simple;
	bh=AQia+tLPOe8Xd1oYMS5clgux+wtOlffpi1g8dLzpLwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jekmfg+UVq+FVxoxaChn2uxp3YqiTZtNL4Y3i1vNeTjigzBQtWi+qzBvKi9ZGavhrjdPmWg4AOuKDRvwGqK8xaa7jomFCqynfsiG5GB2++olCJv+Y5MQTdwE59kEpgZO40foW/Pv108Ax0eE9YLTdQIc58WbTJx+FliRlCMbpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oOueQiG2; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425229; x=1748961229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oLFF3jA/agqYJ+PJdP2EQhdOKkD4P8T1C0pkMpJ+VjQ=;
  b=oOueQiG2F/EuwAIVsajT6ynmKifnC/MGkKtxxf6nka8x3wWUbesbPGbt
   KhnN+FZpgfpHGgmAiA6+nCUGmc8dmbI4sdb84Ojh4yGDhmA95ft/asHqM
   S19bYF3gMutfBysBQ1LzD8TdsiV/IQWO1V78dZbMXpiXEdakdeiWDdENN
   o=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="93753617"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:33:46 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:35222]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.236:2525] with esmtp (Farcaster)
 id 5a94f394-ef8c-4eab-a424-3b57dcab0560; Mon, 3 Jun 2024 14:33:46 +0000 (UTC)
X-Farcaster-Flow-ID: 5a94f394-ef8c-4eab-a424-3b57dcab0560
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:33:43 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 14:33:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 02/15] af_unix: Annodate data-races around sk->sk_state for writers.
Date: Mon, 3 Jun 2024 07:32:18 -0700
Message-ID: <20240603143231.62085-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603143231.62085-1-kuniyu@amazon.com>
References: <20240603143231.62085-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
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
index 541216382cf5..124ca3af1452 100644
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


