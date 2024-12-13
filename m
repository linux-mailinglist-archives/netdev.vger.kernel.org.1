Return-Path: <netdev+bounces-151704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E469F0A79
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEDC16A2FB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED51CCEF6;
	Fri, 13 Dec 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RsFQsN4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162D1C4A17
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088253; cv=none; b=NmaaczAm5E+5uNgUIrO5hsyjtT5rIBr6YCUxNI4NQblVvxRIlk4T/L9KmmgSQLmohA3IS4CTpRT2RQyqM8wO/Vvu5gGPg4IZRJwwqZ63rX58+jwyAMi/AA1cEan1IHmqYhUIiqmRv+GFZevKBBe/pLTbJopoB0yk+jjzE7e4GS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088253; c=relaxed/simple;
	bh=V1BmJ0959HgH8Mo/hNncFukz8f70UdCNr9zGhsVvCfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVQAQGspvc7IyXtoRELjDoivriIPeATVSG4qqZ6aRVrISH4Zk8lCrNw5n30aKMs1jGWVKsb0kzohTZWwskDgZRm6ZpDiQ+kb3Z8Vwiz4VyEV0VMLpdEJOV0LDSEDQOExOpKihb1jNvq+0sVWlQ6mN9wUhs905NZ81Nptn/zjIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RsFQsN4w; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088253; x=1765624253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4GMTsQZIK3e/WTUSGWc1mvucMV2+fa9KW+a8sjwxP0=;
  b=RsFQsN4wtBM343Ouqwspk8718/VvzqkQElydYbqrJI/Fl1+KP09C5HfX
   2qYcihg0qNjgZHxvt4ktdwnXG+EjAHGX69BXe+xygJxKaeLF0xWLPdoj2
   i+4dVBDSJAHNIwOHLIWN4QcvZr7nEexKvBr7rMbwPUXKphnVg2mz3ziyG
   o=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="477825769"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:10:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:2003]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.57:2525] with esmtp (Farcaster)
 id d9ab8184-70b6-4e1c-b513-4404af480f9e; Fri, 13 Dec 2024 11:10:44 +0000 (UTC)
X-Farcaster-Flow-ID: d9ab8184-70b6-4e1c-b513-4404af480f9e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:10:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:10:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/12] af_unix: Set error only when needed in unix_dgram_sendmsg().
Date: Fri, 13 Dec 2024 20:08:43 +0900
Message-ID: <20241213110850.25453-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213110850.25453-1-kuniyu@amazon.com>
References: <20241213110850.25453-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
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
index d30bcd50527e..07d6fba99a7c 100644
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


