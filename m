Return-Path: <netdev+bounces-149596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB359E66DB
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949C6284675
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019319644B;
	Fri,  6 Dec 2024 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oD2mLIr/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61B18E03A
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462906; cv=none; b=oQJ1ueGxRDmgogOXqlEneDEPjuVxeiNLWx0Cv2XFDiBWVayFZU02aUQLcJW6DL2PypAjmVOt6vxMRzTJFJEb4oz0ddN/EhrSneJGGx/+3FMG3vm65AslsG6iHS2NPqp13NFMwFLkEBHMcTKu0gfadQcV79kVA1hAiXrguHjdrBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462906; c=relaxed/simple;
	bh=kcR3KFrqGmGJVPV/iGy+4SsTmpQBNrXGJIe7SlIE+58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBHmQYId+Ix9WkpHFd1NxRLv1ouc4GYzIzNYTT0Ycxf3TFebAPE+ntAC+NqHASWLHOWkbrVgMOTpK6uZIIqW7OBog23rqbDvdGLUsa5XB1J19Nu70kbK9d5QiqQ4mvdm7IdKZOM+0FgGFkORtR19ZcJHdRUk7HFLOzZyH0Omq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oD2mLIr/; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462853; x=1764998853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=66iTX9+T9IrlVZsFA9cqR+jvbqaQQVSfcDSSeepDoF4=;
  b=oD2mLIr/I21BMDvvi5lOZIwN4giNNT+UeLWRGLPmQByG3PxwJyRaSh3o
   8aP0Q5b5FVwVuZV90ymWzFxfFRZuDbq/KXkkvXUf1QMgUttOpjJFdsd6q
   AXFO4Lu8JeaXlyQx+bWZ78vwA7oKAoYSHd0/8XU54cCroouG1g/ivoAMo
   0=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="3726987"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:27:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:53093]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.147:2525] with esmtp (Farcaster)
 id e03b068f-c13f-49ae-b2bd-af4513a6584f; Fri, 6 Dec 2024 05:28:22 +0000 (UTC)
X-Farcaster-Flow-ID: e03b068f-c13f-49ae-b2bd-af4513a6584f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:28:22 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:28:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/15] af_unix: Set error only when needed in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:25:58 +0900
Message-ID: <20241206052607.1197-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206052607.1197-1-kuniyu@amazon.com>
References: <20241206052607.1197-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce skb drop reason for AF_UNIX, then we need to
set an errno and a drop reason for each path.

Let's set an error only when it's needed in unix_dgram_sendmsg().

Then, we need not (re)set 0 to err.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7e6241ba7604..e439829efc56 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1978,9 +1978,10 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	wait_for_unix_gc(scm.fp);
 
-	err = -EOPNOTSUPP;
-	if (msg->msg_flags&MSG_OOB)
+	if (msg->msg_flags & MSG_OOB) {
+		err = -EOPNOTSUPP;
 		goto out;
+	}
 
 	if (msg->msg_namelen) {
 		err = unix_validate_addr(sunaddr, msg->msg_namelen);
@@ -1995,10 +1996,11 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out;
 	} else {
 		sunaddr = NULL;
-		err = -ENOTCONN;
 		other = unix_peer_get(sk);
-		if (!other)
+		if (!other) {
+			err = -ENOTCONN;
 			goto out;
+		}
 	}
 
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
@@ -2009,9 +2011,10 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out;
 	}
 
-	err = -EMSGSIZE;
-	if (len > READ_ONCE(sk->sk_sndbuf) - 32)
+	if (len > READ_ONCE(sk->sk_sndbuf) - 32) {
+		err = -EMSGSIZE;
 		goto out;
+	}
 
 	if (len > SKB_MAX_ALLOC) {
 		data_len = min_t(size_t,
@@ -2043,9 +2046,10 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 restart:
 	if (!other) {
-		err = -ECONNRESET;
-		if (sunaddr == NULL)
+		if (!sunaddr) {
+			err = -ECONNRESET;
 			goto out_free;
+		}
 
 		other = unix_find_other(sock_net(sk), sunaddr, msg->msg_namelen,
 					sk->sk_type);
@@ -2065,9 +2069,11 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	sk_locked = 0;
 	unix_state_lock(other);
 restart_locked:
-	err = -EPERM;
-	if (!unix_may_send(sk, other))
+
+	if (!unix_may_send(sk, other)) {
+		err = -EPERM;
 		goto out_unlock;
+	}
 
 	if (unlikely(sock_flag(other, SOCK_DEAD))) {
 		/*
@@ -2080,7 +2086,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (!sk_locked)
 			unix_state_lock(sk);
 
-		err = 0;
 		if (sk->sk_type == SOCK_SEQPACKET) {
 			/* We are here only when racing with unix_release_sock()
 			 * is clearing @other. Never change state to TCP_CLOSE
@@ -2108,9 +2113,10 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto restart;
 	}
 
-	err = -EPIPE;
-	if (other->sk_shutdown & RCV_SHUTDOWN)
+	if (other->sk_shutdown & RCV_SHUTDOWN) {
+		err = -EPIPE;
 		goto out_unlock;
+	}
 
 	if (sk->sk_type != SOCK_SEQPACKET) {
 		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
-- 
2.39.5 (Apple Git-154)


