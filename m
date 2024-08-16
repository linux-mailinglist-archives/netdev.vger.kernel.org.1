Return-Path: <netdev+bounces-119343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF779553F0
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7900D1F22EC7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9221448DF;
	Fri, 16 Aug 2024 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tBxQRKRi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B0146017
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852325; cv=none; b=A2b0zL6NV0RpFriIa8TxL0YAMMfy1XDVJ29q+ScF4BWCRqO4IrSyD9O+mWtFcsyJk8urG072TtKp9AUT1NDgk6J8tMNBB8xG/trRZJBdEhuNQQvfq5gL/pAScaYobrQ66OoGKU+ATfqHtQ2u1fJOoeSiBi8toCm6jOaJL5AUGr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852325; c=relaxed/simple;
	bh=2mEb5XYhdDTwuiFSw3s6bMUMsZyPzT1lX3nZNsT4b0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Am4c50PPn3WF3y8G9JlbNAkG+oq4VNPKtw91wZ8656aLvCo9OrbaSQJjcfsVOuX3+iaBQQfVAW2fOdC3GM9Wt3Hvln/rxiL9cGdVgY04qsz1nfwh3IOgVN+9Y0AnuR51sR76ckA3G0HLYDR0tV4Js/erjDEjynEtg2eogwzgADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tBxQRKRi; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723852323; x=1755388323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vSgUSLbmUPeLHMB1BmhfAoDVxrYMIGpAzc5OaS9om5o=;
  b=tBxQRKRirBV6xjX+1Ea8hAN4dgf9tyevRWV2JcM1inJHO4Pih2b7hRfL
   Z7UIB2HqIu7CPFagtPYBtSZ0R8jjGSCkn2+EmtNpe2EQ2aLDdJfOMcUwL
   iLtBvoAnJuuzlRkAogbdaXGVcc9Cop9G6dJ5WmHRsGwOisfZup5SnXbBU
   s=;
X-IronPort-AV: E=Sophos;i="6.10,153,1719878400"; 
   d="scan'208";a="444703107"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 23:51:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:65406]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.118:2525] with esmtp (Farcaster)
 id a5d0e4e1-898c-4950-9b49-8e73fef04ad6; Fri, 16 Aug 2024 23:51:57 +0000 (UTC)
X-Farcaster-Flow-ID: a5d0e4e1-898c-4950-9b49-8e73fef04ad6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 23:49:59 +0000
Received: from 88665a182662.ant.amazon.com (10.88.176.128) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 23:39:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] af_unix: Don't call skb_get() for OOB skb.
Date: Fri, 16 Aug 2024 16:39:21 -0700
Message-ID: <20240816233921.57800-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
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

Since introduced, OOB skb holds an additional reference count with no
special reason and caused many issues.

Also, kfree_skb() and consume_skb() are used to decrement the count,
which is confusing.

Let's drop the unnecessary skb_get() in queue_oob() and corresponding
kfree_skb(), consume_skb(), and skb_unref().

Now unix_sk(sk)->oob_skb is just a pointer to skb in the receive queue,
so special handing is no longer needed in GC.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 27 +++++----------------------
 net/unix/garbage.c | 16 ++--------------
 2 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0be0dcb07f7b..a1894019ebd5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -693,10 +693,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	unix_state_unlock(sk);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	if (u->oob_skb) {
-		kfree_skb(u->oob_skb);
-		u->oob_skb = NULL;
-	}
+	u->oob_skb = NULL;
 #endif
 
 	wake_up_interruptible_all(&u->peer_wait);
@@ -2226,13 +2223,9 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	}
 
 	maybe_add_creds(skb, sock, other);
-	skb_get(skb);
-
 	scm_stat_add(other, skb);
 
 	spin_lock(&other->sk_receive_queue.lock);
-	if (ousk->oob_skb)
-		consume_skb(ousk->oob_skb);
 	WRITE_ONCE(ousk->oob_skb, skb);
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	spin_unlock(&other->sk_receive_queue.lock);
@@ -2640,8 +2633,6 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	if (!(state->flags & MSG_PEEK))
 		WRITE_ONCE(u->oob_skb, NULL);
-	else
-		skb_get(oob_skb);
 
 	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
@@ -2651,8 +2642,6 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 	if (!(state->flags & MSG_PEEK))
 		UNIXCB(oob_skb).consumed += 1;
 
-	consume_skb(oob_skb);
-
 	mutex_unlock(&u->iolock);
 
 	if (chunk < 0)
@@ -2694,12 +2683,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 			if (copied) {
 				skb = NULL;
 			} else if (!(flags & MSG_PEEK)) {
-				if (sock_flag(sk, SOCK_URGINLINE)) {
-					WRITE_ONCE(u->oob_skb, NULL);
-					consume_skb(skb);
-				} else {
+				WRITE_ONCE(u->oob_skb, NULL);
+
+				if (!sock_flag(sk, SOCK_URGINLINE)) {
 					__skb_unlink(skb, &sk->sk_receive_queue);
-					WRITE_ONCE(u->oob_skb, NULL);
 					unlinked_skb = skb;
 					skb = skb_peek(&sk->sk_receive_queue);
 				}
@@ -2710,10 +2697,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 		spin_unlock(&sk->sk_receive_queue.lock);
 
-		if (unlinked_skb) {
-			WARN_ON_ONCE(skb_unref(unlinked_skb));
-			kfree_skb(unlinked_skb);
-		}
+		kfree_skb(unlinked_skb);
 	}
 	return skb;
 }
@@ -2756,7 +2740,6 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		unix_state_unlock(sk);
 
 		if (drop) {
-			WARN_ON_ONCE(skb_unref(skb));
 			kfree_skb(skb);
 			return -EAGAIN;
 		}
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 06d94ad999e9..0068e758be4d 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -337,18 +337,6 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
-static void unix_collect_queue(struct unix_sock *u, struct sk_buff_head *hitlist)
-{
-	skb_queue_splice_init(&u->sk.sk_receive_queue, hitlist);
-
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	if (u->oob_skb) {
-		WARN_ON_ONCE(skb_unref(u->oob_skb));
-		u->oob_skb = NULL;
-	}
-#endif
-}
-
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -371,11 +359,11 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
 				struct sk_buff_head *embryo_queue = &skb->sk->sk_receive_queue;
 
 				spin_lock(&embryo_queue->lock);
-				unix_collect_queue(unix_sk(skb->sk), hitlist);
+				skb_queue_splice_init(embryo_queue, hitlist);
 				spin_unlock(&embryo_queue->lock);
 			}
 		} else {
-			unix_collect_queue(u, hitlist);
+			skb_queue_splice_init(queue, hitlist);
 		}
 
 		spin_unlock(&queue->lock);
-- 
2.30.2


