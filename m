Return-Path: <netdev+bounces-157499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E99A0A729
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826C318861C2
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383F71EA73;
	Sun, 12 Jan 2025 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f1zVjC4a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06B6FB0
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655203; cv=none; b=UkqaOBa2Lul8kOgA2mBTqAIyAigtREa3jy6suAHOuuWIzzoUHrs64eTrhlEk241gGl39PcNVHxPQt3Qb5How2HBdoLUGbZoRlPsamxVqggt5DsvwNdcGZK9itJdwzJM6cyEfM/ogA41Yvr0ClfAdqEK4HoQha2Kdgz69K0XoovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655203; c=relaxed/simple;
	bh=pXedfodtMQ5b86MDOA4msamRKRy/hZk0Z4/d/b+cSqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjxKmSFyfNgqeMF/2AG887kS/ww0l+oLLPayvwHRRK8AYP8aJ2v6gYNCSwQT0bVUoeSmxkX4/00Sp/HnzFtu1pt0iLBeRdpGVqD2xnXLj2Pgrau2b0yKr9J8afiB+J9Fgdn3lk3AxIw1FxZuVOFKUhIrWP75Sqyng9xwCdonDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=f1zVjC4a; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736655201; x=1768191201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zd2JHetZDnRohUwDqFlCoTQyO/QYvecNJVFL9toFOwg=;
  b=f1zVjC4aopIflrXl3q2eft0yPn+xpqUHmjVDDAZJtWUeD653gHZuI5+T
   pE6b4AGzRgRl2NfayF2uPHwh8F/2T6LAl3vLDku5MKCzNrBW75ovvjcXT
   4acN/I/F+WSvfPRhRnsPeVBQ7BSM+up3aKJj11VYcKsUdD5G+FpL+Trqq
   s=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="453550818"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:13:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:25929]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.17:2525] with esmtp (Farcaster)
 id bb0e8e45-ebf2-4627-9e15-997b83139498; Sun, 12 Jan 2025 04:13:18 +0000 (UTC)
X-Farcaster-Flow-ID: bb0e8e45-ebf2-4627-9e15-997b83139498
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:13:17 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:13:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/11] af_unix: Set drop reason in unix_dgram_sendmsg().
Date: Sun, 12 Jan 2025 13:08:10 +0900
Message-ID: <20250112040810.14145-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sendmsg() to a SOCK_DGRAM / SOCK_SEQPACKET socket could fail for
various reasons.

Let's set drop reasons respectively.

  * SOCKET_FILTER : BPF filter dropped the skb
  * UNIX_NO_PERM  : the peer connect()ed to another socket

To reproduce UNIX_NO_PERM:

  # echo 1 > /sys/kernel/tracing/events/skb/kfree_skb/enable

  # python3
  >>> from socket import *
  >>> s1, s2 = socketpair(AF_UNIX, SOCK_DGRAM)
  >>> s2.bind('')
  >>> s3 = socket(AF_UNIX, SOCK_DGRAM)
  >>> s3.sendto(b'hello world', s2.getsockname())
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  PermissionError: [Errno 1] Operation not permitted

  # cat /sys/kernel/tracing/trace_pipe
  ...
     python3-196 ... kfree_skb: ... location=unix_dgram_sendmsg+0x3d1/0x970 reason: UNIX_NO_PERM

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h |  6 ++++++
 net/unix/af_unix.c            | 28 +++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 580be34ffa4f..a8db05defa5a 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -13,6 +13,7 @@
 	FN(SOCKET_RCV_SHUTDOWN)		\
 	FN(UNIX_DISCONNECT)		\
 	FN(UNIX_INFLIGHT_FD_LIMIT)	\
+	FN(UNIX_NO_PERM)		\
 	FN(UNIX_SKIP_OOB)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
@@ -164,6 +165,11 @@ enum skb_drop_reason {
 	 * are passed via SCM_RIGHTS but not yet received, reaching RLIMIT_NOFILE.
 	 */
 	SKB_DROP_REASON_UNIX_INFLIGHT_FD_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_UNIX_NO_PERM: the peer socket is already connect()ed
+	 * to another SOCK_DGRAM/SOCK_SEQPACKET socket.
+	 */
+	SKB_DROP_REASON_UNIX_NO_PERM,
 	/**
 	 * @SKB_DROP_REASON_UNIX_SKIP_OOB: Out-Of-Band data is skipped by
 	 * recv() without MSG_OOB so dropped.
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1c374bac7b48..c34a0cd396c2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1991,6 +1991,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk, *other = NULL;
 	struct unix_sock *u = unix_sk(sk);
+	enum skb_drop_reason reason;
 	struct scm_cookie scm;
 	struct sk_buff *skb;
 	int data_len = 0;
@@ -2051,15 +2052,19 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 
 	err = unix_scm_to_skb(&scm, skb, true);
-	if (err < 0)
+	if (err < 0) {
+		reason = unix_scm_err_to_reason(err);
 		goto out_free;
+	}
 
 	skb_put(skb, len - data_len);
 	skb->data_len = data_len;
 	skb->len = len;
 	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, len);
-	if (err)
+	if (err) {
+		reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
 		goto out_free;
+	}
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
@@ -2069,12 +2074,14 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 					msg->msg_namelen, sk->sk_type);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
+			reason = SKB_DROP_REASON_NO_SOCKET;
 			goto out_free;
 		}
 	} else {
 		other = unix_peer_get(sk);
 		if (!other) {
 			err = -ENOTCONN;
+			reason = SKB_DROP_REASON_NO_SOCKET;
 			goto out_free;
 		}
 	}
@@ -2082,6 +2089,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (sk_filter(other, skb) < 0) {
 		/* Toss the packet but do not return any error to the sender */
 		err = len;
+		reason = SKB_DROP_REASON_SOCKET_FILTER;
 		goto out_sock_put;
 	}
 
@@ -2092,6 +2100,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	if (!unix_may_send(sk, other)) {
 		err = -EPERM;
+		reason = SKB_DROP_REASON_UNIX_NO_PERM;
 		goto out_unlock;
 	}
 
@@ -2106,6 +2115,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			 * unlike SOCK_DGRAM wants.
 			 */
 			err = -EPIPE;
+			reason = SKB_DROP_REASON_SOCKET_CLOSE;
 			goto out_sock_put;
 		}
 
@@ -2122,6 +2132,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			unix_dgram_disconnected(sk, other);
 			sock_put(other);
 			err = -ECONNREFUSED;
+			reason = SKB_DROP_REASON_SOCKET_CLOSE;
 			goto out_sock_put;
 		}
 
@@ -2129,6 +2140,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		if (!msg->msg_namelen) {
 			err = -ECONNRESET;
+			reason = SKB_DROP_REASON_SOCKET_CLOSE;
 			goto out_sock_put;
 		}
 
@@ -2137,13 +2149,16 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	if (other->sk_shutdown & RCV_SHUTDOWN) {
 		err = -EPIPE;
+		reason = SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN;
 		goto out_unlock;
 	}
 
 	if (sk->sk_type != SOCK_SEQPACKET) {
 		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
-		if (err)
+		if (err) {
+			reason = SKB_DROP_REASON_SECURITY_HOOK;
 			goto out_unlock;
+		}
 	}
 
 	/* other == sk && unix_peer(other) != sk if
@@ -2157,8 +2172,10 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			timeo = unix_wait_for_peer(other, timeo);
 
 			err = sock_intr_errno(timeo);
-			if (signal_pending(current))
+			if (signal_pending(current)) {
+				reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
 				goto out_sock_put;
+			}
 
 			goto restart;
 		}
@@ -2171,6 +2188,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (unix_peer(sk) != other ||
 		    unix_dgram_peer_wake_me(sk, other)) {
 			err = -EAGAIN;
+			reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
 			sk_locked = 1;
 			goto out_unlock;
 		}
@@ -2202,7 +2220,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 out_sock_put:
 	sock_put(other);
 out_free:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 out:
 	scm_destroy(&scm);
 	return err;
-- 
2.39.5 (Apple Git-154)


