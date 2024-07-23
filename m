Return-Path: <netdev+bounces-112593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104193A1FC
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BFD1C225A8
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C3153582;
	Tue, 23 Jul 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="3L6hj6/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AA1137C34
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742713; cv=none; b=JveQMNchu/H6xubi8WwYM0pbv18LvnMgAa1UqZVdIZUZ6udndvB5JTBHqAZ54IFr8SUbLwXg5ncUgG26yqzv7MQ5oWHRtxjfYrP3A3rcDiPHgr0c3NKgx+a/rQFp3rXnuTdc4nsBOXKOi4x/rPtl9f3eBkNc055b72H4DhbQIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742713; c=relaxed/simple;
	bh=HHt4Rs59ItJk4kyCZ0wktex/LLSJEG72yOzbJlah1tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZVdv3zVfobt+buPGUrXCjY21nG+ETv6rSM4WiVicunvkelcXLxwbM3fePV+wbI2wEoB1mpajHB7E0yaWRT0CYGTHMN6jj8GLbd6B6Ic5wqrrUWJ0VRoaZYuUEjyWBWviyHv4+4eYomKFgxI9Q4VkmaoiHdwumIPZGm6ORVuNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=3L6hj6/I; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 18E187DBBB;
	Tue, 23 Jul 2024 14:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742705; bh=HHt4Rs59ItJk4kyCZ0wktex/LLSJEG72yOzbJlah1tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2001/15]=20l2tp:=20lookup=20tunnel=20from=20socket=20without=20
	 using=20sk_user_data|Date:=20Tue,=2023=20Jul=202024=2014:51:29=20+
	 0100|Message-Id:=20<be825ed1ae6e5756e85dbae8ac0afc6c48ce86fb.17217
	 33730.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1721733730.g
	 it.jchapman@katalix.com>|References:=20<cover.1721733730.git.jchap
	 man@katalix.com>|MIME-Version:=201.0;
	b=3L6hj6/I3H0ZXfo37H+vv51k3yOGRZ8xPQzc13KDq0cN/ClalPJEQ97ujb2wmz/yD
	 4gol+pIMYQv/RxuV1WBW/cqhfBEHmfT6pWwtWUHgpfl7UQmvfzVdhF+i9ymqX9LdF3
	 fpJG6zOk5aGCLeRnxhyrmN1yZp4696Tt3PnRFyUQRGbncusE+QaVDUY39+JLfXzYJa
	 AO5zPqDcsmaXh+WI52VXZrWRiQGaXvhla1h6d4es2fnm8Cm8D48O0PnrvMfSwzbHhP
	 DLSFtzJiezp/4uRwCG6yfs9hrlVC6yMQNhI5cA2CYsRiMYKpciSFJ/fB1CxuYfsweT
	 pdVCsdf4uBtIw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 01/15] l2tp: lookup tunnel from socket without using sk_user_data
Date: Tue, 23 Jul 2024 14:51:29 +0100
Message-Id: <be825ed1ae6e5756e85dbae8ac0afc6c48ce86fb.1721733730.git.jchapman@katalix.com>
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

l2tp_sk_to_tunnel derives the tunnel from sk_user_data. Instead,
lookup the tunnel by walking the tunnel IDR for a tunnel using the
indicated sock. This is slow but l2tp_sk_to_tunnel is not used in
the datapath so performance isn't critical.

l2tp_tunnel_destruct needs a variant of l2tp_sk_to_tunnel which does
not bump the tunnel refcount since the tunnel refcount is already 0.

Change l2tp_sk_to_tunnel sk arg to const since it does not modify sk.
---
 net/l2tp/l2tp_core.c | 52 ++++++++++++++++++++++++++++++++++++--------
 net/l2tp/l2tp_core.h |  5 +----
 net/l2tp/l2tp_ip.c   |  7 ++++--
 net/l2tp/l2tp_ip6.c  |  7 ++++--
 4 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index c80ab3f26084..c97cd0fd8514 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -150,15 +150,43 @@ static void l2tp_session_free(struct l2tp_session *session)
 	kfree(session);
 }
 
-struct l2tp_tunnel *l2tp_sk_to_tunnel(struct sock *sk)
+static struct l2tp_tunnel *__l2tp_sk_to_tunnel(const struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = sk->sk_user_data;
+	const struct net *net = sock_net(sk);
+	unsigned long tunnel_id, tmp;
+	struct l2tp_tunnel *tunnel;
+	struct l2tp_net *pn;
+
+	WARN_ON_ONCE(!rcu_read_lock_bh_held());
+	pn = l2tp_pernet(net);
+	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
+		if (tunnel && tunnel->sock == sk)
+			return tunnel;
+	}
+
+	return NULL;
+}
 
-	if (tunnel)
-		if (WARN_ON(tunnel->magic != L2TP_TUNNEL_MAGIC))
-			return NULL;
+struct l2tp_tunnel *l2tp_sk_to_tunnel(const struct sock *sk)
+{
+	const struct net *net = sock_net(sk);
+	unsigned long tunnel_id, tmp;
+	struct l2tp_tunnel *tunnel;
+	struct l2tp_net *pn;
+
+	rcu_read_lock_bh();
+	pn = l2tp_pernet(net);
+	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
+		if (tunnel &&
+		    tunnel->sock == sk &&
+		    refcount_inc_not_zero(&tunnel->ref_count)) {
+			rcu_read_unlock_bh();
+			return tunnel;
+		}
+	}
+	rcu_read_unlock_bh();
 
-	return tunnel;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(l2tp_sk_to_tunnel);
 
@@ -1213,8 +1241,10 @@ EXPORT_SYMBOL_GPL(l2tp_xmit_skb);
  */
 static void l2tp_tunnel_destruct(struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+	struct l2tp_tunnel *tunnel;
 
+	rcu_read_lock_bh();
+	tunnel = __l2tp_sk_to_tunnel(sk);
 	if (!tunnel)
 		goto end;
 
@@ -1242,6 +1272,7 @@ static void l2tp_tunnel_destruct(struct sock *sk)
 
 	kfree_rcu(tunnel, rcu);
 end:
+	rcu_read_unlock_bh();
 	return;
 }
 
@@ -1308,10 +1339,13 @@ static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 /* Tunnel socket destroy hook for UDP encapsulation */
 static void l2tp_udp_encap_destroy(struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+	struct l2tp_tunnel *tunnel;
 
-	if (tunnel)
+	tunnel = l2tp_sk_to_tunnel(sk);
+	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
+		l2tp_tunnel_dec_refcount(tunnel);
+	}
 }
 
 static void l2tp_tunnel_remove(struct net *net, struct l2tp_tunnel *tunnel)
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 8ac81bc1bc6f..a41cf6795df0 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -273,10 +273,7 @@ void l2tp_nl_unregister_ops(enum l2tp_pwtype pw_type);
 /* IOCTL helper for IP encap modules. */
 int l2tp_ioctl(struct sock *sk, int cmd, int *karg);
 
-/* Extract the tunnel structure from a socket's sk_user_data pointer,
- * validating the tunnel magic feather.
- */
-struct l2tp_tunnel *l2tp_sk_to_tunnel(struct sock *sk);
+struct l2tp_tunnel *l2tp_sk_to_tunnel(const struct sock *sk);
 
 static inline int l2tp_get_l2specific_len(struct l2tp_session *session)
 {
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index e48aa177d74c..78243f993cda 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -235,14 +235,17 @@ static void l2tp_ip_close(struct sock *sk, long timeout)
 
 static void l2tp_ip_destroy_sock(struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+	struct l2tp_tunnel *tunnel;
 	struct sk_buff *skb;
 
 	while ((skb = __skb_dequeue_tail(&sk->sk_write_queue)) != NULL)
 		kfree_skb(skb);
 
-	if (tunnel)
+	tunnel = l2tp_sk_to_tunnel(sk);
+	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
+		l2tp_tunnel_dec_refcount(tunnel);
+	}
 }
 
 static int l2tp_ip_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index d217ff1f229e..3b0465f2d60d 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -246,14 +246,17 @@ static void l2tp_ip6_close(struct sock *sk, long timeout)
 
 static void l2tp_ip6_destroy_sock(struct sock *sk)
 {
-	struct l2tp_tunnel *tunnel = l2tp_sk_to_tunnel(sk);
+	struct l2tp_tunnel *tunnel;
 
 	lock_sock(sk);
 	ip6_flush_pending_frames(sk);
 	release_sock(sk);
 
-	if (tunnel)
+	tunnel = l2tp_sk_to_tunnel(sk);
+	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
+		l2tp_tunnel_dec_refcount(tunnel);
+	}
 }
 
 static int l2tp_ip6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
-- 
2.34.1


