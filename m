Return-Path: <netdev+bounces-190869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96201AB9263
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C2E503C47
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC128AB12;
	Thu, 15 May 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="i/rRRtRR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0351F153C
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747349451; cv=none; b=AgzvRXL+vk2yLQ/Zg5JZ1U725owcCQzbBu1RbXJ2Cg65K35pYsauDSN7wwCQMbvYAVH9ScsFbrMr7CW60x3Ej7RYraQdXeROwAnsjHoMbkVuqoxKDPFcBJ75mFrXsBk6Z6r02q9ohFkCl5g0LU4oCiHK3GDy6MZD6xeMdD+9w8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747349451; c=relaxed/simple;
	bh=AXbMIaV6m1W5RIARUuqv7NrfPuo4v3H23iLy4BOTkFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4E1jRPhQgNx33A9GG4Aalbsqlmm7hClqXA5seK8LxCGHlYLTaKEH2+lWMVh3iuHIUXvhQBPbQ74HIZCtsD/qSS3FhRwScfusT2FMhnINGijYRhQpoX2smN6O0P4p7+UolQ/yyqp61Pz+b5b3HarR7cp6dCX5zldpSMMxZN3LnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=i/rRRtRR; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747349449; x=1778885449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FRl5MLplifKSwdoujDL5Z/1KS+G/ZsatrerygfmdQzc=;
  b=i/rRRtRRBKi7T7omg4pn/J+cg/aiLRYkiXb3L0qRMsayrQ6gY/xS2biU
   SiQguczIpKmlrx0c/6K3pBvBGP5CpggKxsIPrjHVz+POldwBMg8S3Fwuw
   TvTTqQIv02uslz9sQgS+7pnSmzvFjkgSa2Qbt3PAVR6I0shNwTfRJJunx
   ODyu3xFqd8x+0tQmoiSB2dRplfzuyd+dIxjm4P25YAFY0cjT8oPjRRMi3
   wvTTvYCrZ2L8v8rEyEQKSh21VgfG7nm6rkW55voosNPntol+7L1fn1eRP
   1FrxRodLN8m+I27By4VG7MMgMVbvQlqit2nidSxrROaTCRmY3p4K7gVVR
   g==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="197342490"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:50:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:61505]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.20:2525] with esmtp (Farcaster)
 id dab894ea-eda2-4e6b-9c57-04d38a5e3309; Thu, 15 May 2025 22:50:47 +0000 (UTC)
X-Farcaster-Flow-ID: dab894ea-eda2-4e6b-9c57-04d38a5e3309
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:50:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:50:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 2/9] af_unix: Don't pass struct socket to maybe_add_creds().
Date: Thu, 15 May 2025 15:49:10 -0700
Message-ID: <20250515224946.6931-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will move SOCK_PASS{CRED,PIDFD,SEC} from struct socket.flags
to struct sock for better handling with SOCK_PASSRIGHTS.

Then, we don't need to access struct socket in maybe_add_creds().

Let's pass struct sock to maybe_add_creds() and its caller
queue_oob().

While at it, we append the unix_ prefix and fix double spaces
around the pid assignment.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/unix/af_unix.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 464e183ffdb8..a39497fd6e98 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1869,7 +1869,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 {
 	int err = 0;
 
-	UNIXCB(skb).pid  = get_pid(scm->pid);
+	UNIXCB(skb).pid = get_pid(scm->pid);
 	UNIXCB(skb).uid = scm->creds.uid;
 	UNIXCB(skb).gid = scm->creds.gid;
 	UNIXCB(skb).fp = NULL;
@@ -1886,15 +1886,15 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
  * We include credentials if source or destination socket
  * asserted SOCK_PASSCRED.
  */
-static void maybe_add_creds(struct sk_buff *skb, const struct socket *sock,
-			    const struct sock *other)
+static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
+				 const struct sock *other)
 {
 	if (UNIXCB(skb).pid)
 		return;
 
-	if (unix_may_passcred(sock->sk) ||
+	if (unix_may_passcred(sk) ||
 	    !other->sk_socket || unix_may_passcred(other)) {
-		UNIXCB(skb).pid  = get_pid(task_tgid(current));
+		UNIXCB(skb).pid = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
 }
@@ -2133,7 +2133,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	if (sock_flag(other, SOCK_RCVTSTAMP))
 		__net_timestamp(skb);
-	maybe_add_creds(skb, sock, other);
+
+	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 	skb_queue_tail(&other->sk_receive_queue, skb);
 	unix_state_unlock(other);
@@ -2161,14 +2162,14 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 #define UNIX_SKB_FRAGS_SZ (PAGE_SIZE << get_order(32768))
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other,
+static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 		     struct scm_cookie *scm, bool fds_sent)
 {
 	struct unix_sock *ousk = unix_sk(other);
 	struct sk_buff *skb;
 	int err;
 
-	skb = sock_alloc_send_skb(sock->sk, 1, msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, 1, msg->msg_flags & MSG_DONTWAIT, &err);
 
 	if (!skb)
 		return err;
@@ -2192,7 +2193,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 		goto out;
 	}
 
-	maybe_add_creds(skb, sock, other);
+	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 
 	spin_lock(&other->sk_receive_queue.lock);
@@ -2308,7 +2309,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		    (other->sk_shutdown & RCV_SHUTDOWN))
 			goto out_pipe_unlock;
 
-		maybe_add_creds(skb, sock, other);
+		unix_maybe_add_creds(skb, sk, other);
 		scm_stat_add(other, skb);
 		skb_queue_tail(&other->sk_receive_queue, skb);
 		unix_state_unlock(other);
@@ -2318,7 +2319,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	if (msg->msg_flags & MSG_OOB) {
-		err = queue_oob(sock, msg, other, &scm, fds_sent);
+		err = queue_oob(sk, msg, other, &scm, fds_sent);
 		if (err)
 			goto out_err;
 		sent++;
-- 
2.49.0


