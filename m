Return-Path: <netdev+bounces-113704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8693F9A3
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C16B213E1
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219515D5DA;
	Mon, 29 Jul 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="PFWZbrsQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A015ADB2
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267499; cv=none; b=HQ6+9irAjU9Q6oSdr/b9W/h5Lw7ELo8+gCmdTEX8iQ57qD8ocYTjvXPZok8XN0YNdQM3fIRAEEOk+CTkYfmm1Z8pgV8DsDGcjoPqq1sODZIDpOrOgadRBfNNlGKykyexp7kj5x/n4UXNxt1cxe0cuq+cRz29TjVPymAjPgBCj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267499; c=relaxed/simple;
	bh=DN0FCBLErOUKWe9+oA26vb1CyClrbnIdJx1UjjQjigU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDh4t/YnOPbfum+UKf60yE4ylEHPhn2kFdhkkpFH9JPCPw1xMS/MlFnizsz9HFUuys2kqiwPFDMxC5OynoRZfTEMwZ+cyUnPHysQAA4qX/ZuiFQLBu6wfa5tbs3jrBomtr8VIab3JCP/n11NbjanUTTOeCcS6JNthQDSUnJNiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=PFWZbrsQ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id D69547DCF7;
	Mon, 29 Jul 2024 16:38:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267495; bh=DN0FCBLErOUKWe9+oA26vb1CyClrbnIdJx1UjjQjigU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2007/15]=20l2tp:=20simplify=20tunnel=20and=20socket=20clea
	 nup|Date:=20Mon,=2029=20Jul=202024=2016:38:06=20+0100|Message-Id:=
	 20<56813a06aa837737870ce5a8c9c5b7c50d2f3246.1722265212.git.jchapma
	 n@katalix.com>|In-Reply-To:=20<cover.1722265212.git.jchapman@katal
	 ix.com>|References:=20<cover.1722265212.git.jchapman@katalix.com>|
	 MIME-Version:=201.0;
	b=PFWZbrsQPuTs3rT8uqP1FeFQKhoJZdjGNBqp7UxkVejSkMF//DAsbazlSiwOb+6rM
	 0paw4tBGfPIWEbP/EvLRJqjhahVbFr9/q4kbLrENcQ7lfcdcX6e5Agx4kVPrAr2YB7
	 Lr1LiloC5Pn3amGNbQf1w35w9gnUsZzQgsh1MgL+ckApdN1dvWFM+PKs6F+fhOkH0/
	 MVvsA4//SrY4qJuxt0LvVBFZeFd0I8Nq4Yg/kd3Z0EUg/5RM24kg0hFOBMVKFKaV6g
	 tauezLq+XFeZawLK72hfZmwIG+9q0nnmLhwUhmoJfukNs2YI+UgO079W5RBfmgjhhA
	 ml7lOrVQZQ7pg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 07/15] l2tp: simplify tunnel and socket cleanup
Date: Mon, 29 Jul 2024 16:38:06 +0100
Message-Id: <56813a06aa837737870ce5a8c9c5b7c50d2f3246.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the l2tp tunnel socket used sk_user_data to point to its
associated l2tp tunnel, socket and tunnel cleanup had to make use of
the socket's destructor to free the tunnel only when the socket could
no longer be accessed.

Now that sk_user_data is no longer used, we can simplify socket and
tunnel cleanup:

  * If the tunnel closes first, it cleans up and drops its socket ref
    when the tunnel refcount drops to zero. If its socket was provided
    by userspace, the socket is closed and freed asynchronously, when
    userspace closes it. If its socket is a kernel socket, the tunnel
    closes the socket itself during cleanup and drops its socket ref
    when the tunnel's refcount drops to zero.

  * If the socket closes first, we initiate the closing of its
    associated tunnel. For UDP sockets, this is via the socket's
    encap_destroy hook. For L2TPIP sockets, this is via the socket's
    destroy callback. The tunnel holds a socket ref while it
    references the sock. When the tunnel is freed, it drops its socket
    ref and the socket will be cleaned up when its own refcount drops
    to zero, asynchronous to the tunnel free.

  * The tunnel socket destructor is no longer needed since the tunnel
    is no longer freed through the socket destructor.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 82 ++++++++++++--------------------------------
 net/l2tp/l2tp_core.h |  1 -
 2 files changed, 21 insertions(+), 62 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 1ef14f99e78c..a01dd891639b 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -137,9 +137,28 @@ static inline struct l2tp_net *l2tp_pernet(const struct net *net)
 
 static void l2tp_tunnel_free(struct l2tp_tunnel *tunnel)
 {
+	struct sock *sk = tunnel->sock;
+
 	trace_free_tunnel(tunnel);
-	sock_put(tunnel->sock);
-	/* the tunnel is freed in the socket destructor */
+
+	if (sk) {
+		/* Disable udp encapsulation */
+		switch (tunnel->encap) {
+		case L2TP_ENCAPTYPE_UDP:
+			/* No longer an encapsulation socket. See net/ipv4/udp.c */
+			WRITE_ONCE(udp_sk(sk)->encap_type, 0);
+			udp_sk(sk)->encap_rcv = NULL;
+			udp_sk(sk)->encap_destroy = NULL;
+			break;
+		case L2TP_ENCAPTYPE_IP:
+			break;
+		}
+
+		tunnel->sock = NULL;
+		sock_put(sk);
+	}
+
+	kfree_rcu(tunnel, rcu);
 }
 
 static void l2tp_session_free(struct l2tp_session *session)
@@ -150,23 +169,6 @@ static void l2tp_session_free(struct l2tp_session *session)
 	kfree(session);
 }
 
-static struct l2tp_tunnel *__l2tp_sk_to_tunnel(const struct sock *sk)
-{
-	const struct net *net = sock_net(sk);
-	unsigned long tunnel_id, tmp;
-	struct l2tp_tunnel *tunnel;
-	struct l2tp_net *pn;
-
-	WARN_ON_ONCE(!rcu_read_lock_bh_held());
-	pn = l2tp_pernet(net);
-	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
-		if (tunnel && tunnel->sock == sk)
-			return tunnel;
-	}
-
-	return NULL;
-}
-
 struct l2tp_tunnel *l2tp_sk_to_tunnel(const struct sock *sk)
 {
 	const struct net *net = sock_net(sk);
@@ -1235,46 +1237,6 @@ EXPORT_SYMBOL_GPL(l2tp_xmit_skb);
  * Tinnel and session create/destroy.
  *****************************************************************************/
 
-/* Tunnel socket destruct hook.
- * The tunnel context is deleted only when all session sockets have been
- * closed.
- */
-static void l2tp_tunnel_destruct(struct sock *sk)
-{
-	struct l2tp_tunnel *tunnel;
-
-	rcu_read_lock_bh();
-	tunnel = __l2tp_sk_to_tunnel(sk);
-	if (!tunnel)
-		goto end;
-
-	/* Disable udp encapsulation */
-	switch (tunnel->encap) {
-	case L2TP_ENCAPTYPE_UDP:
-		/* No longer an encapsulation socket. See net/ipv4/udp.c */
-		WRITE_ONCE(udp_sk(sk)->encap_type, 0);
-		udp_sk(sk)->encap_rcv = NULL;
-		udp_sk(sk)->encap_destroy = NULL;
-		break;
-	case L2TP_ENCAPTYPE_IP:
-		break;
-	}
-
-	/* Remove hooks into tunnel socket */
-	write_lock_bh(&sk->sk_callback_lock);
-	sk->sk_destruct = tunnel->old_sk_destruct;
-	write_unlock_bh(&sk->sk_callback_lock);
-
-	/* Call the original destructor */
-	if (sk->sk_destruct)
-		(*sk->sk_destruct)(sk);
-
-	kfree_rcu(tunnel, rcu);
-end:
-	rcu_read_unlock_bh();
-	return;
-}
-
 /* Remove an l2tp session from l2tp_core's lists. */
 static void l2tp_session_unhash(struct l2tp_session *session)
 {
@@ -1623,8 +1585,6 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 		setup_udp_tunnel_sock(net, sock, &udp_cfg);
 	}
 
-	tunnel->old_sk_destruct = sk->sk_destruct;
-	sk->sk_destruct = &l2tp_tunnel_destruct;
 	sk->sk_allocation = GFP_ATOMIC;
 	release_sock(sk);
 
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 50107531fe3b..6c62d02a0ae6 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -173,7 +173,6 @@ struct l2tp_tunnel {
 	struct net		*l2tp_net;	/* the net we belong to */
 
 	refcount_t		ref_count;
-	void (*old_sk_destruct)(struct sock *sk);
 	struct sock		*sock;		/* parent socket */
 	int			fd;		/* parent fd, if tunnel socket was created
 						 * by userspace
-- 
2.34.1


