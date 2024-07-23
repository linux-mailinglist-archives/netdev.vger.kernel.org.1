Return-Path: <netdev+bounces-112600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1785D93A203
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3975281C76
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECF4154BE3;
	Tue, 23 Jul 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="U5cJgpTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED67A153820
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742715; cv=none; b=dpBPIjboT5a3YVd6rivDHhllyxbGdmX+O6QVT9Vq7I/U2WIH+6NmzvzHkPzKOpi5omAKE2f1KSqtRelD9KroC8L5ieywWErY8rHL+WwvoOWSFaaFhI1ylPUhp755i85Gqk2oHs1kcHkXzrUMZET7MgPX5g2cDqH/iwtDFff0TYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742715; c=relaxed/simple;
	bh=yOCNgNSxHlHoWueXtsVTH9lsj97a3+g38q8BwV9sQOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raAnhYzVi9ZQhkTtZCKIN18fK5IS8moLrkMMk/qWRVLNIChIYwlVZiIXBzZG5956ARQ4vaZqefTTPL2VZZW1bh2s8dCYn7wYM2OK5sar/Y38W7Z/N2e0uwrA0DbPvE69KjBGjpb/+Sjl8/3peru8TqdSZ+4euJ+Gsho2OEkLMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=U5cJgpTL; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id ECE427DCEE;
	Tue, 23 Jul 2024 14:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742706; bh=yOCNgNSxHlHoWueXtsVTH9lsj97a3+g38q8BwV9sQOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2007/15]=20l2tp:=20simplify=20tunnel=20and=20socket=20cleanup|D
	 ate:=20Tue,=2023=20Jul=202024=2014:51:35=20+0100|Message-Id:=20<c2
	 81064c3cab7fb68b97f3b227a1a16b15f1dd6d.1721733730.git.jchapman@kat
	 alix.com>|In-Reply-To:=20<cover.1721733730.git.jchapman@katalix.co
	 m>|References:=20<cover.1721733730.git.jchapman@katalix.com>|MIME-
	 Version:=201.0;
	b=U5cJgpTLJRP5kHE8Vo1AeY4LozClK9njOOSIhKEvCHtxdekH66nkpmD3oRIRctUgO
	 V8rFyjjOUbGrhXQQqaok3opOjSJJ+z0IAInCbj5CbJWYn+AmB+S8psnSwNv37iZKiA
	 raSBueVzzW74Z/H45LLmqPuISJ74I0LuUSjt1E5l85s47HLtZ4ZMuMRKRN9jttS6Br
	 BwrPV3bPY1FcEpThdkWSbR6RldTBse39ntqzZFRF17C32VteaKM81OOEvplT9AVzi2
	 6UGdrOXca3aDtRO7+eya/JofitcTZeRKC0pw48BlNPBHJBfFDWeHMqSC3MwT0Deowt
	 GksEzkW3V1kyA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 07/15] l2tp: simplify tunnel and socket cleanup
Date: Tue, 23 Jul 2024 14:51:35 +0100
Message-Id: <c281064c3cab7fb68b97f3b227a1a16b15f1dd6d.1721733730.git.jchapman@katalix.com>
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


