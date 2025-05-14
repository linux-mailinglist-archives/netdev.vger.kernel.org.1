Return-Path: <netdev+bounces-190503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16723AB71F2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A51D1B67F64
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D327C15B;
	Wed, 14 May 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NjReLkvJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8013DDAA
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241612; cv=none; b=jd13VibjM/0lAuzvG9iHGOv8gOFpiaECqcEyf6O9inLJ8q/n3LXSQyLs4ahV83Z1J141ckOPjHtmr2VMw/jceOKym1vwISk+u4C1/eUzAoqbe1/qdcm++BI+9gAd9mXEBX2bvXN0g9zoe/jUd+AmsdTAM1uhQF5Hmjm2geZ93Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241612; c=relaxed/simple;
	bh=K99J37eW4YetMTBywNuy2krslJsi7+VADpoYhOwNJTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZT102qQuuP/9Qm05wGlWRvKzcHTLe5QoZ5GYoJM/Gq7xEwdPC4Fndq/xbJ+dU37FI0mE6Zb4PrJ4/blLB8S+66AZAY/OxPbw9PwSwId8nCSDNe0KTU2H7GYJocEvNT9HK8F5QA/nCWcp7KpmDxmBy5CUz+RwZQASjPHmliNoAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NjReLkvJ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747241610; x=1778777610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSGIaqLEaroildq83RekUXJ0eeSt8PNFSPl17SmUYxQ=;
  b=NjReLkvJg5Xvv28IqJDi2ETC1yKR+HxeyscanM2jPulWJcjewc+WwtCW
   d/1rEB0oS9JJxJaXbvcb4BSIJm7g9+FtrCMlQZPas3sJ50b/XK6hKehd9
   S1I5OMiD/BZxmzk9vlVAH7yZXoWQi892Kd+Ka05grOZfa54KeSC86Zzrc
   eNVyS6uhzOrqHp+J8vzWvDe1GkRvFHIojZSB9WawIduuISq4o81PfkWI0
   r/NdQG7yS2vQTG+Tx1/E5elM+8miCWRBcl54svqjh6Yd7xzSndlLJ2fpJ
   3SSMi2ELCus+8jpfRptdk01vFMCdLcZHWmnO2EajI50VOf7g2wAbtiwpA
   g==;
X-IronPort-AV: E=Sophos;i="6.15,288,1739836800"; 
   d="scan'208";a="722782833"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 16:53:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:47892]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.176:2525] with esmtp (Farcaster)
 id 48408970-c657-408d-9732-021bb1a4fb72; Wed, 14 May 2025 16:53:26 +0000 (UTC)
X-Farcaster-Flow-ID: 48408970-c657-408d-9732-021bb1a4fb72
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:53:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:53:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 2/9] af_unix: Don't pass struct socket to maybe_add_creds().
Date: Wed, 14 May 2025 09:51:45 -0700
Message-ID: <20250514165226.40410-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514165226.40410-1-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will move SOCK_PASS{CRED,PIDFD,SEC} from struct socket.flags
to struct sock for better handling with SOCK_PASSRIGHTS.

Then, we don't need to access struct socket in maybe_add_creds().

Let's pass struct sock to maybe_add_creds() and its caller
queue_oob().

While at it, we append the unix_ prefix and fix double spaces
around the pid assignment.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


