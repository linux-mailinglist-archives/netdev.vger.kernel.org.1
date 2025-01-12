Return-Path: <netdev+bounces-157493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A52A0A723
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16051885B3E
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2171E502;
	Sun, 12 Jan 2025 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B6k+ZKKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CF614293
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655044; cv=none; b=ryyfZdP3tNr3AdHVZKGVfKflveSRcxU++GnkjV7iuLwbE+98dYNaZ1ChbOPZjoRMMK00/9er5RfPK99kgHjWpZWFsMsR16zEX+igP5W4H1zr5Zg+577yfd+ysamzVq6+9rczODey9+B5cg7yaem6S3ocHiaCGD+Cod9FcuWb4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655044; c=relaxed/simple;
	bh=CIDS+Q6aNlIT1yDXhmZ3EAyn1U4O7v2HsaIp3sJV0NM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvQvc+iRV1AH4doQw70iY8Y1DSe0O+8J//5RceI3BcTUF4wvZDWBHDm3M7QfSyeSaJD3zdG1i2CqenYTdTmldrrrJybzNEztsnzAquA8PdYSWljhh6lHjMmM9JswyMEeUdE2kK4cLi/wEDR5ECEVZNOCoMbUAwvq7DgFH9CZdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B6k+ZKKz; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736655044; x=1768191044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mg59p3COVrzPdxR5HSibX8dKEzv7bL6fBavvhjfvC/0=;
  b=B6k+ZKKzglqff9qMC56xgW/2lprzBnaIDpPlpoH7ggeIRDaRJId2YM0d
   B7qJRmLs56Rb259AFi30QhqjT3AdFlqgbcBlr7OcmY7K5TW0ULRepKUVT
   MNmeJWNkRUPq15fwyB/J6KLpj00dJ5Smj816RIsEgf5ir0gqL2NdUDMzq
   E=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="790432412"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:10:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:41064]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.65:2525] with esmtp (Farcaster)
 id ea7ca1a5-3dcc-46f4-8c71-c60689737d03; Sun, 12 Jan 2025 04:10:37 +0000 (UTC)
X-Farcaster-Flow-ID: ea7ca1a5-3dcc-46f4-8c71-c60689737d03
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:10:37 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:10:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/11] af_unix: Set drop reason in unix_stream_connect().
Date: Sun, 12 Jan 2025 13:08:04 +0900
Message-ID: <20250112040810.14145-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

connect() to a SOCK_STREAM socket could fail for various reasons.

Let's set drop reasons respectively:

  * NO_SOCKET      : No listening socket found
  * RCV_SHUTDOWN   : The listening socket called shutdown(SHUT_RD)
  * SOCKET_RCVBUFF : The listening socket's accept queue is full
  * INVALID_STATE  : The client is in TCP_ESTABLISHED or TCP_LISTEN
  * SECURITY_HOOK  : LSM refused connect()

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h |  6 ++++++
 net/unix/af_unix.c            | 22 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 8823de6539d1..1b5e962f7f33 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -8,7 +8,9 @@
 	FN(NO_SOCKET)			\
 	FN(SOCKET_CLOSE)		\
 	FN(SOCKET_FILTER)		\
+	FN(SOCKET_INVALID_STATE)	\
 	FN(SOCKET_RCVBUFF)		\
+	FN(SOCKET_RCV_SHUTDOWN)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
 	FN(UDP_CSUM)			\
@@ -142,8 +144,12 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_CLOSE,
 	/** @SKB_DROP_REASON_SOCKET_FILTER: dropped by socket filter */
 	SKB_DROP_REASON_SOCKET_FILTER,
+	/** @SKB_DROP_REASON_SOCKET_INVALID_STATE: sk->sk_state is invalid. */
+	SKB_DROP_REASON_SOCKET_INVALID_STATE,
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
+	/** @SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN: socket is shutdown(SHUT_RD) */
+	SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 41b99984008a..b190ea8b8e9d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1534,6 +1534,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct sock *sk = sock->sk, *newsk = NULL, *other = NULL;
 	struct unix_sock *u = unix_sk(sk), *newu, *otheru;
 	struct net *net = sock_net(sk);
+	enum skb_drop_reason reason;
 	struct sk_buff *skb = NULL;
 	unsigned char state;
 	long timeo;
@@ -1581,6 +1582,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
 	if (IS_ERR(other)) {
 		err = PTR_ERR(other);
+		reason = SKB_DROP_REASON_NO_SOCKET;
 		goto out_free_skb;
 	}
 
@@ -1593,15 +1595,22 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto restart;
 	}
 
-	if (other->sk_state != TCP_LISTEN ||
-	    other->sk_shutdown & RCV_SHUTDOWN) {
+	if (other->sk_state != TCP_LISTEN) {
 		err = -ECONNREFUSED;
+		reason = SKB_DROP_REASON_NO_SOCKET;
+		goto out_unlock;
+	}
+
+	if (other->sk_shutdown & RCV_SHUTDOWN) {
+		err = -ECONNREFUSED;
+		reason = SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN;
 		goto out_unlock;
 	}
 
 	if (unix_recvq_full_lockless(other)) {
 		if (!timeo) {
 			err = -EAGAIN;
+			reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
 			goto out_unlock;
 		}
 
@@ -1609,8 +1618,10 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		sock_put(other);
 
 		err = sock_intr_errno(timeo);
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
 			goto out_free_skb;
+		}
 
 		goto restart;
 	}
@@ -1621,6 +1632,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	state = READ_ONCE(sk->sk_state);
 	if (unlikely(state != TCP_CLOSE)) {
 		err = state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
+		reason = SKB_DROP_REASON_SOCKET_INVALID_STATE;
 		goto out_unlock;
 	}
 
@@ -1629,12 +1641,14 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (unlikely(sk->sk_state != TCP_CLOSE)) {
 		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
 		unix_state_unlock(sk);
+		reason = SKB_DROP_REASON_SOCKET_INVALID_STATE;
 		goto out_unlock;
 	}
 
 	err = security_unix_stream_connect(sk, other, newsk);
 	if (err) {
 		unix_state_unlock(sk);
+		reason = SKB_DROP_REASON_SECURITY_HOOK;
 		goto out_unlock;
 	}
 
@@ -1699,7 +1713,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	unix_state_unlock(other);
 	sock_put(other);
 out_free_skb:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 out_free_sk:
 	unix_release_sock(newsk, 0);
 out:
-- 
2.39.5 (Apple Git-154)


