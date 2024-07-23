Return-Path: <netdev+bounces-112602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CDF93A205
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC93D1C2248D
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F121154BFE;
	Tue, 23 Jul 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="eMQxCsmg"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421DE15383B
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742716; cv=none; b=hSPlGiz49CTTlQKxlAGYcklJD7/IdlfFUK0lQmnl8szsBUj4pJFCzTk3GD2QR6JsA1P4h1ebY648Dc9sOwJ4EvwoWV9/FxiyuEJQK/ahx/OVOztqzVrEijGKuqg0BD79CR661y+uE3WnM9U/IrCacPRzQgVBRV5sZmnhlYLiYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742716; c=relaxed/simple;
	bh=x97VvjHyADsah7+ORbYc9kTAEvcOwluqq+Jss+s6pxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIXYPjZlsypqULn27pymz9YR1whi985Fc0ofGMDOPORjrlbsCKAz+tHzPMkM06/Fvx0mVBeT1SJVOAqRwPHzBCdmDMuuK9IMj7txL+RtJ3/NxrsWJyU8gODKuaPSEOM24V+unux2T9uU2lhwL1sr/953hmtHAeYU7qEWn4ym3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=eMQxCsmg; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 530517DCF1;
	Tue, 23 Jul 2024 14:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742706; bh=x97VvjHyADsah7+ORbYc9kTAEvcOwluqq+Jss+s6pxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2010/15]=20l2tp:=20refactor=20ppp=20socket/session=20relationsh
	 ip|Date:=20Tue,=2023=20Jul=202024=2014:51:38=20+0100|Message-Id:=2
	 0<50d03c0ac3a67542fa876d53812b3d96b62e3594.1721733730.git.jchapman
	 @katalix.com>|In-Reply-To:=20<cover.1721733730.git.jchapman@katali
	 x.com>|References:=20<cover.1721733730.git.jchapman@katalix.com>|M
	 IME-Version:=201.0;
	b=eMQxCsmgIe5z44ryTg3yFRrVvbnmbwPbSptpkaSzTBrLVRX1N02Kef8y4nQru08DX
	 bLmhX1/wW5ULOiGsg+xa3LMvYf0CoHW4WdDsCDZX9uBnNe1e23wzTl2qsl05SWbdOZ
	 Gxdqh+lkxDz65cI9POW205xXiPo6CiB/hjLpJT0P09VdfICSQuVLkBZF8UFBVNgI2V
	 kgDRDMa1fisv9GLdGuWz9cbV9SkgR+rg3qmvEZJqjwy6/qpBEqZmawUOOMioDDl8wA
	 uko7DyZEW+HHntDzQXwQXK5MlSniEqV7W+5jPicws1oL6sjO/dzxjVCKBivSKUf8K/
	 Eio57yJSQS0IA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 10/15] l2tp: refactor ppp socket/session relationship
Date: Tue, 23 Jul 2024 14:51:38 +0100
Message-Id: <50d03c0ac3a67542fa876d53812b3d96b62e3594.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each l2tp ppp session has an associated pppox socket. l2tp_ppp uses
the session's pppox socket refcount to manage session lifetimes; the
pppox socket holds a ref on the session which is dropped by the socket
destructor. This complicates session cleanup.

Given l2tp sessions are refcounted, it makes more sense to reverse
this relationship such that the session keeps the socket alive, not
the other way around. So refactor l2tp_ppp to have the session hold a
ref on its socket while it references it. When the session is closed,
it drops its socket ref when it detaches from its socket. If the
socket is closed first, it initiates the closing of its session, if
one is attached. The socket/session can then be freed asynchronously
when their refcounts drop to 0.

Use the session's session_close callback to detach the pppox socket
since this will be done on the work queue together with the rest of
the session cleanup via l2tp_session_delete.

Also, since l2tp_ppp uses the pppox socket's sk_user_data, use the rcu
sk_user_data access helpers when accessing it and set the socket's
SOCK_RCU_FREE flag to have pppox sockets freed by rcu.
---
 net/l2tp/l2tp_ppp.c | 94 +++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 55 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 0844b86cd0a6..12a0a7162870 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -119,7 +119,6 @@ struct pppol2tp_session {
 	struct mutex		sk_lock;	/* Protects .sk */
 	struct sock __rcu	*sk;		/* Pointer to the session PPPoX socket */
 	struct sock		*__sk;		/* Copy of .sk, for cleanup */
-	struct rcu_head		rcu;		/* For asynchronous release */
 };
 
 static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb);
@@ -157,20 +156,16 @@ static inline struct l2tp_session *pppol2tp_sock_to_session(struct sock *sk)
 	if (!sk)
 		return NULL;
 
-	sock_hold(sk);
-	session = (struct l2tp_session *)(sk->sk_user_data);
-	if (!session) {
-		sock_put(sk);
-		goto out;
-	}
-	if (WARN_ON(session->magic != L2TP_SESSION_MAGIC)) {
-		session = NULL;
-		sock_put(sk);
-		goto out;
+	rcu_read_lock();
+	session = rcu_dereference_sk_user_data(sk);
+	if (session && refcount_inc_not_zero(&session->ref_count)) {
+		rcu_read_unlock();
+		WARN_ON_ONCE(session->magic != L2TP_SESSION_MAGIC);
+		return session;
 	}
+	rcu_read_unlock();
 
-out:
-	return session;
+	return NULL;
 }
 
 /*****************************************************************************
@@ -318,12 +313,12 @@ static int pppol2tp_sendmsg(struct socket *sock, struct msghdr *m,
 	l2tp_xmit_skb(session, skb);
 	local_bh_enable();
 
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 
 	return total_len;
 
 error_put_sess:
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 error:
 	return error;
 }
@@ -377,12 +372,12 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	l2tp_xmit_skb(session, skb);
 	local_bh_enable();
 
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 
 	return 1;
 
 abort_put_sess:
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 abort:
 	/* Free the original skb */
 	kfree_skb(skb);
@@ -393,28 +388,31 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
  * Session (and tunnel control) socket create/destroy.
  *****************************************************************************/
 
-static void pppol2tp_put_sk(struct rcu_head *head)
-{
-	struct pppol2tp_session *ps;
-
-	ps = container_of(head, typeof(*ps), rcu);
-	sock_put(ps->__sk);
-}
-
 /* Really kill the session socket. (Called from sock_put() if
  * refcnt == 0.)
  */
 static void pppol2tp_session_destruct(struct sock *sk)
 {
-	struct l2tp_session *session = sk->sk_user_data;
-
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
+}
 
-	if (session) {
-		sk->sk_user_data = NULL;
-		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
-			return;
+static void pppol2tp_session_close(struct l2tp_session *session)
+{
+	struct pppol2tp_session *ps;
+
+	ps = l2tp_session_priv(session);
+	mutex_lock(&ps->sk_lock);
+	ps->__sk = rcu_dereference_protected(ps->sk,
+					     lockdep_is_held(&ps->sk_lock));
+	RCU_INIT_POINTER(ps->sk, NULL);
+	mutex_unlock(&ps->sk_lock);
+	if (ps->__sk) {
+		/* detach socket */
+		rcu_assign_sk_user_data(ps->__sk, NULL);
+		sock_put(ps->__sk);
+
+		/* drop ref taken when we referenced socket via sk_user_data */
 		l2tp_session_dec_refcount(session);
 	}
 }
@@ -444,30 +442,13 @@ static int pppol2tp_release(struct socket *sock)
 
 	session = pppol2tp_sock_to_session(sk);
 	if (session) {
-		struct pppol2tp_session *ps;
-
 		l2tp_session_delete(session);
-
-		ps = l2tp_session_priv(session);
-		mutex_lock(&ps->sk_lock);
-		ps->__sk = rcu_dereference_protected(ps->sk,
-						     lockdep_is_held(&ps->sk_lock));
-		RCU_INIT_POINTER(ps->sk, NULL);
-		mutex_unlock(&ps->sk_lock);
-		call_rcu(&ps->rcu, pppol2tp_put_sk);
-
-		/* Rely on the sock_put() call at the end of the function for
-		 * dropping the reference held by pppol2tp_sock_to_session().
-		 * The last reference will be dropped by pppol2tp_put_sk().
-		 */
+		/* drop ref taken by pppol2tp_sock_to_session */
+		l2tp_session_dec_refcount(session);
 	}
 
 	release_sock(sk);
 
-	/* This will delete the session context via
-	 * pppol2tp_session_destruct() if the socket's refcnt drops to
-	 * zero.
-	 */
 	sock_put(sk);
 
 	return 0;
@@ -506,6 +487,7 @@ static int pppol2tp_create(struct net *net, struct socket *sock, int kern)
 		goto out;
 
 	sock_init_data(sock, sk);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	sock->state  = SS_UNCONNECTED;
 	sock->ops    = &pppol2tp_ops;
@@ -542,6 +524,7 @@ static void pppol2tp_session_init(struct l2tp_session *session)
 	struct pppol2tp_session *ps;
 
 	session->recv_skb = pppol2tp_recv;
+	session->session_close = pppol2tp_session_close;
 	if (IS_ENABLED(CONFIG_L2TP_DEBUGFS))
 		session->show = pppol2tp_show;
 
@@ -830,12 +813,13 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
-	sk->sk_user_data = session;
+	sock_hold(sk);
+	rcu_assign_sk_user_data(sk, session);
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);
 
 	/* Keep the reference we've grabbed on the session: sk doesn't expect
-	 * the session to disappear. pppol2tp_session_destruct() is responsible
+	 * the session to disappear. pppol2tp_session_close() is responsible
 	 * for dropping it.
 	 */
 	drop_refcnt = false;
@@ -1002,7 +986,7 @@ static int pppol2tp_getname(struct socket *sock, struct sockaddr *uaddr,
 
 	error = len;
 
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 end:
 	return error;
 }
@@ -1274,7 +1258,7 @@ static int pppol2tp_setsockopt(struct socket *sock, int level, int optname,
 		err = pppol2tp_session_setsockopt(sk, session, optname, val);
 	}
 
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 end:
 	return err;
 }
@@ -1395,7 +1379,7 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	err = 0;
 
 end_put_sess:
-	sock_put(sk);
+	l2tp_session_dec_refcount(session);
 end:
 	return err;
 }
-- 
2.34.1


