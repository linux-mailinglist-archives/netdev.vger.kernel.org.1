Return-Path: <netdev+bounces-105222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9444191028A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B9283D1B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C41AB90C;
	Thu, 20 Jun 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="rK9htIP1"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF070763F7
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883043; cv=none; b=jdU+gACvgTH4xCZZXGGRctzjbr7Q/6X4U9ZnzCrXD3vmOPb9oyCk9q2i3sbB+pLW3AuaUPP6n4WnCVu2BQPlcJjVyv7CURGHJMqfHYIRhVlSznilMHs1tH2beAG3LQkYDvndwxWYrK83fNOPoObRGIlYCYX8u3bY7gJ0JYaiHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883043; c=relaxed/simple;
	bh=XtS0MkrmuWEfhNl9Ocz4IjyVWLiyyuhdWeun5/a2VJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpZ2So1PFebF77fMADeLO+Huetf8NFEsKru2z4odJ4kZzzbdlKZWGOHCZlbJE6npeBsSCZcS5l4drWxAbDcRhlsxLIE6sY4hDq/IqOYhxtwGc+fz6xu2leqZQTXsR0wj7rEVQlLwJRhdA+RpfsPWHGovBrCd5oYaI2A30BTtTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=rK9htIP1; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 773047DA7E;
	Thu, 20 Jun 2024 12:22:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882565; bh=XtS0MkrmuWEfhNl9Ocz4IjyVWLiyyuhdWeun5/a2VJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=202/8]=20l2tp:=20store=20l2tpv3=20sessions=20in=20p
	 er-net=20IDR|Date:=20Thu,=2020=20Jun=202024=2012:22:38=20+0100|Mes
	 sage-Id:=20<22cdf8d419a6757be449cbeb5b69203d3bb3d2dd.1718877398.gi
	 t.jchapman@katalix.com>|In-Reply-To:=20<cover.1718877398.git.jchap
	 man@katalix.com>|References:=20<cover.1718877398.git.jchapman@kata
	 lix.com>|MIME-Version:=201.0;
	b=rK9htIP1n0ySQLwDbMXk9d0MC9Dk6Oi+ip/5NxTQdsTnKfwb18Sl71vGEajlC+TSy
	 iv66Wo/Gyp8tyMsf7tfO1ue5h9wkvn9p6n6UChpKzauV/08/EtiMfkZ1JBKb3LlNcS
	 6nU3txvRaAp/YCfXfnPGb/St+i0wsHlrsBJQEvpJ2GWDu5MCZIQocvJ25YMfJzapfV
	 Ss7/RC9hV1hgj/SsmXC+Pz3caQqZysoUa+foKowOL9KcMJcUYng3A+Fm3z7XD55nDZ
	 Iz0DqyG5zCIp+36xwwDD/3OI1UILgN0DA/wNStmpWFoBpXM0U3s2Ec42m0BuPqTXYV
	 O7OeoEBL5Il+g==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 2/8] l2tp: store l2tpv3 sessions in per-net IDR
Date: Thu, 20 Jun 2024 12:22:38 +0100
Message-Id: <22cdf8d419a6757be449cbeb5b69203d3bb3d2dd.1718877398.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718877398.git.jchapman@katalix.com>
References: <cover.1718877398.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

L2TPv3 sessions are currently held in one of two fixed-size hash
lists: either a per-net hashlist (IP-encap), or a per-tunnel hashlist
(UDP-encap), keyed by the L2TPv3 32-bit session_id.

In order to lookup L2TPv3 sessions in UDP-encap tunnels efficiently
without finding the tunnel first via sk_user_data, UDP sessions are
now kept in a per-net session list, keyed by session ID. Convert the
existing per-net hashlist to use an IDR for better performance when
there are many sessions and have L2TPv3 UDP sessions use the same IDR.

Although the L2TPv3 RFC states that the session ID alone identifies
the session, our implementation has allowed the same session ID to be
used in different L2TP UDP tunnels. To retain support for this, a new
per-net session hashtable is used, keyed by the sock and session
ID. If on creating a new session, a session already exists with that
ID in the IDR, the colliding sessions are added to the new hashtable
and the existing IDR entry is flagged. When looking up sessions, the
approach is to first check the IDR and if no unflagged match is found,
check the new hashtable. The sock is made available to session getters
where session ID collisions are to be considered. In this way, the new
hashtable is used only for session ID collisions so can be kept small.

For managing session removal, we need a list of colliding sessions
matching a given ID in order to update or remove the IDR entry of the
ID. This is necessary to detect session ID collisions when future
sessions are created. The list head is allocated on first collision
of a given ID and refcounted.

Signed-off-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 240 +++++++++++++++++++++++++++++++------------
 net/l2tp/l2tp_core.h |  18 ++--
 net/l2tp/l2tp_ip.c   |   2 +-
 net/l2tp/l2tp_ip6.c  |   2 +-
 4 files changed, 188 insertions(+), 74 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 69f8c9f5cdc7..d6bffdb16466 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -107,11 +107,17 @@ struct l2tp_net {
 	/* Lock for write access to l2tp_tunnel_idr */
 	spinlock_t l2tp_tunnel_idr_lock;
 	struct idr l2tp_tunnel_idr;
-	struct hlist_head l2tp_session_hlist[L2TP_HASH_SIZE_2];
-	/* Lock for write access to l2tp_session_hlist */
-	spinlock_t l2tp_session_hlist_lock;
+	/* Lock for write access to l2tp_v3_session_idr/htable */
+	spinlock_t l2tp_session_idr_lock;
+	struct idr l2tp_v3_session_idr;
+	struct hlist_head l2tp_v3_session_htable[16];
 };
 
+static inline unsigned long l2tp_v3_session_hashkey(struct sock *sk, u32 session_id)
+{
+	return ((unsigned long)sk) + session_id;
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static bool l2tp_sk_is_v6(struct sock *sk)
 {
@@ -125,17 +131,6 @@ static inline struct l2tp_net *l2tp_pernet(const struct net *net)
 	return net_generic(net, l2tp_net_id);
 }
 
-/* Session hash global list for L2TPv3.
- * The session_id SHOULD be random according to RFC3931, but several
- * L2TP implementations use incrementing session_ids.  So we do a real
- * hash on the session_id, rather than a simple bitmask.
- */
-static inline struct hlist_head *
-l2tp_session_id_hash_2(struct l2tp_net *pn, u32 session_id)
-{
-	return &pn->l2tp_session_hlist[hash_32(session_id, L2TP_HASH_BITS_2)];
-}
-
 /* Session hash list.
  * The session_id SHOULD be random according to RFC2661, but several
  * L2TP implementations (Cisco and Microsoft) use incrementing
@@ -262,26 +257,40 @@ struct l2tp_session *l2tp_tunnel_get_session(struct l2tp_tunnel *tunnel,
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_get_session);
 
-struct l2tp_session *l2tp_session_get(const struct net *net, u32 session_id)
+struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id)
 {
-	struct hlist_head *session_list;
+	const struct l2tp_net *pn = l2tp_pernet(net);
 	struct l2tp_session *session;
 
-	session_list = l2tp_session_id_hash_2(l2tp_pernet(net), session_id);
-
 	rcu_read_lock_bh();
-	hlist_for_each_entry_rcu(session, session_list, global_hlist)
-		if (session->session_id == session_id) {
-			l2tp_session_inc_refcount(session);
-			rcu_read_unlock_bh();
+	session = idr_find(&pn->l2tp_v3_session_idr, session_id);
+	if (session && !hash_hashed(&session->hlist) &&
+	    refcount_inc_not_zero(&session->ref_count)) {
+		rcu_read_unlock_bh();
+		return session;
+	}
 
-			return session;
+	/* If we get here and session is non-NULL, the session_id
+	 * collides with one in another tunnel. If sk is non-NULL,
+	 * find the session matching sk.
+	 */
+	if (session && sk) {
+		unsigned long key = l2tp_v3_session_hashkey(sk, session->session_id);
+
+		hash_for_each_possible_rcu(pn->l2tp_v3_session_htable, session,
+					   hlist, key) {
+			if (session->tunnel->sock == sk &&
+			    refcount_inc_not_zero(&session->ref_count)) {
+				rcu_read_unlock_bh();
+				return session;
+			}
 		}
+	}
 	rcu_read_unlock_bh();
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(l2tp_session_get);
+EXPORT_SYMBOL_GPL(l2tp_v3_session_get);
 
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth)
 {
@@ -313,12 +322,12 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
-	int hash;
+	unsigned long session_id, tmp;
 	struct l2tp_session *session;
 
 	rcu_read_lock_bh();
-	for (hash = 0; hash < L2TP_HASH_SIZE_2; hash++) {
-		hlist_for_each_entry_rcu(session, &pn->l2tp_session_hlist[hash], global_hlist) {
+	idr_for_each_entry_ul(&pn->l2tp_v3_session_idr, session, tmp, session_id) {
+		if (session) {
 			if (!strcmp(session->ifname, ifname)) {
 				l2tp_session_inc_refcount(session);
 				rcu_read_unlock_bh();
@@ -334,13 +343,106 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 }
 EXPORT_SYMBOL_GPL(l2tp_session_get_by_ifname);
 
+static void l2tp_session_coll_list_add(struct l2tp_session_coll_list *clist,
+				       struct l2tp_session *session)
+{
+	l2tp_session_inc_refcount(session);
+	WARN_ON_ONCE(session->coll_list);
+	session->coll_list = clist;
+	spin_lock(&clist->lock);
+	list_add(&session->clist, &clist->list);
+	spin_unlock(&clist->lock);
+}
+
+static int l2tp_session_collision_add(struct l2tp_net *pn,
+				      struct l2tp_session *session1,
+				      struct l2tp_session *session2)
+{
+	struct l2tp_session_coll_list *clist;
+
+	lockdep_assert_held(&pn->l2tp_session_idr_lock);
+
+	if (!session2)
+		return -EEXIST;
+
+	/* If existing session is in IP-encap tunnel, refuse new session */
+	if (session2->tunnel->encap == L2TP_ENCAPTYPE_IP)
+		return -EEXIST;
+
+	clist = session2->coll_list;
+	if (!clist) {
+		/* First collision. Allocate list to manage the collided sessions
+		 * and add the existing session to the list.
+		 */
+		clist = kmalloc(sizeof(*clist), GFP_ATOMIC);
+		if (!clist)
+			return -ENOMEM;
+
+		spin_lock_init(&clist->lock);
+		INIT_LIST_HEAD(&clist->list);
+		refcount_set(&clist->ref_count, 1);
+		l2tp_session_coll_list_add(clist, session2);
+	}
+
+	/* If existing session isn't already in the session hlist, add it. */
+	if (!hash_hashed(&session2->hlist))
+		hash_add(pn->l2tp_v3_session_htable, &session2->hlist,
+			 session2->hlist_key);
+
+	/* Add new session to the hlist and collision list */
+	hash_add(pn->l2tp_v3_session_htable, &session1->hlist,
+		 session1->hlist_key);
+	refcount_inc(&clist->ref_count);
+	l2tp_session_coll_list_add(clist, session1);
+
+	return 0;
+}
+
+static void l2tp_session_collision_del(struct l2tp_net *pn,
+				       struct l2tp_session *session)
+{
+	struct l2tp_session_coll_list *clist = session->coll_list;
+	unsigned long session_key = session->session_id;
+	struct l2tp_session *session2;
+
+	lockdep_assert_held(&pn->l2tp_session_idr_lock);
+
+	hash_del(&session->hlist);
+
+	if (clist) {
+		/* Remove session from its collision list. If there
+		 * are other sessions with the same ID, replace this
+		 * session's IDR entry with that session, otherwise
+		 * remove the IDR entry. If this is the last session,
+		 * the collision list data is freed.
+		 */
+		spin_lock(&clist->lock);
+		list_del_init(&session->clist);
+		session2 = list_first_entry_or_null(&clist->list, struct l2tp_session, clist);
+		if (session2) {
+			void *old = idr_replace(&pn->l2tp_v3_session_idr, session2, session_key);
+
+			WARN_ON_ONCE(IS_ERR_VALUE(old));
+		} else {
+			void *removed = idr_remove(&pn->l2tp_v3_session_idr, session_key);
+
+			WARN_ON_ONCE(removed != session);
+		}
+		session->coll_list = NULL;
+		spin_unlock(&clist->lock);
+		if (refcount_dec_and_test(&clist->ref_count))
+			kfree(clist);
+		l2tp_session_dec_refcount(session);
+	}
+}
+
 int l2tp_session_register(struct l2tp_session *session,
 			  struct l2tp_tunnel *tunnel)
 {
+	struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
 	struct l2tp_session *session_walk;
-	struct hlist_head *g_head;
 	struct hlist_head *head;
-	struct l2tp_net *pn;
+	u32 session_key;
 	int err;
 
 	head = l2tp_session_id_hash(tunnel, session->session_id);
@@ -358,39 +460,45 @@ int l2tp_session_register(struct l2tp_session *session,
 		}
 
 	if (tunnel->version == L2TP_HDR_VER_3) {
-		pn = l2tp_pernet(tunnel->l2tp_net);
-		g_head = l2tp_session_id_hash_2(pn, session->session_id);
-
-		spin_lock_bh(&pn->l2tp_session_hlist_lock);
-
+		session_key = session->session_id;
+		spin_lock_bh(&pn->l2tp_session_idr_lock);
+		err = idr_alloc_u32(&pn->l2tp_v3_session_idr, NULL,
+				    &session_key, session_key, GFP_ATOMIC);
 		/* IP encap expects session IDs to be globally unique, while
-		 * UDP encap doesn't.
+		 * UDP encap doesn't. This isn't per the RFC, which says that
+		 * sessions are identified only by the session ID, but is to
+		 * support existing userspace which depends on it.
 		 */
-		hlist_for_each_entry(session_walk, g_head, global_hlist)
-			if (session_walk->session_id == session->session_id &&
-			    (session_walk->tunnel->encap == L2TP_ENCAPTYPE_IP ||
-			     tunnel->encap == L2TP_ENCAPTYPE_IP)) {
-				err = -EEXIST;
-				goto err_tlock_pnlock;
-			}
+		if (err == -ENOSPC && tunnel->encap == L2TP_ENCAPTYPE_UDP) {
+			struct l2tp_session *session2;
 
-		l2tp_tunnel_inc_refcount(tunnel);
-		hlist_add_head_rcu(&session->global_hlist, g_head);
-
-		spin_unlock_bh(&pn->l2tp_session_hlist_lock);
-	} else {
-		l2tp_tunnel_inc_refcount(tunnel);
+			session2 = idr_find(&pn->l2tp_v3_session_idr,
+					    session_key);
+			err = l2tp_session_collision_add(pn, session, session2);
+		}
+		spin_unlock_bh(&pn->l2tp_session_idr_lock);
+		if (err == -ENOSPC)
+			err = -EEXIST;
 	}
 
+	if (err)
+		goto err_tlock;
+
+	l2tp_tunnel_inc_refcount(tunnel);
+
 	hlist_add_head_rcu(&session->hlist, head);
 	spin_unlock_bh(&tunnel->hlist_lock);
 
+	if (tunnel->version == L2TP_HDR_VER_3) {
+		spin_lock_bh(&pn->l2tp_session_idr_lock);
+		idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
+		spin_unlock_bh(&pn->l2tp_session_idr_lock);
+	}
+
 	trace_register_session(session);
 
 	return 0;
 
-err_tlock_pnlock:
-	spin_unlock_bh(&pn->l2tp_session_hlist_lock);
 err_tlock:
 	spin_unlock_bh(&tunnel->hlist_lock);
 
@@ -1218,13 +1326,19 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 		hlist_del_init_rcu(&session->hlist);
 		spin_unlock_bh(&tunnel->hlist_lock);
 
-		/* For L2TPv3 we have a per-net hash: remove from there, too */
-		if (tunnel->version != L2TP_HDR_VER_2) {
+		/* For L2TPv3 we have a per-net IDR: remove from there, too */
+		if (tunnel->version == L2TP_HDR_VER_3) {
 			struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
-
-			spin_lock_bh(&pn->l2tp_session_hlist_lock);
-			hlist_del_init_rcu(&session->global_hlist);
-			spin_unlock_bh(&pn->l2tp_session_hlist_lock);
+			struct l2tp_session *removed = session;
+
+			spin_lock_bh(&pn->l2tp_session_idr_lock);
+			if (hash_hashed(&session->hlist))
+				l2tp_session_collision_del(pn, session);
+			else
+				removed = idr_remove(&pn->l2tp_v3_session_idr,
+						     session->session_id);
+			WARN_ON_ONCE(removed && removed != session);
+			spin_unlock_bh(&pn->l2tp_session_idr_lock);
 		}
 
 		synchronize_rcu();
@@ -1649,8 +1763,9 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 
 		skb_queue_head_init(&session->reorder_q);
 
+		session->hlist_key = l2tp_v3_session_hashkey(tunnel->sock, session->session_id);
 		INIT_HLIST_NODE(&session->hlist);
-		INIT_HLIST_NODE(&session->global_hlist);
+		INIT_LIST_HEAD(&session->clist);
 
 		if (cfg) {
 			session->pwtype = cfg->pw_type;
@@ -1683,15 +1798,12 @@ EXPORT_SYMBOL_GPL(l2tp_session_create);
 static __net_init int l2tp_init_net(struct net *net)
 {
 	struct l2tp_net *pn = net_generic(net, l2tp_net_id);
-	int hash;
 
 	idr_init(&pn->l2tp_tunnel_idr);
 	spin_lock_init(&pn->l2tp_tunnel_idr_lock);
 
-	for (hash = 0; hash < L2TP_HASH_SIZE_2; hash++)
-		INIT_HLIST_HEAD(&pn->l2tp_session_hlist[hash]);
-
-	spin_lock_init(&pn->l2tp_session_hlist_lock);
+	idr_init(&pn->l2tp_v3_session_idr);
+	spin_lock_init(&pn->l2tp_session_idr_lock);
 
 	return 0;
 }
@@ -1701,7 +1813,6 @@ static __net_exit void l2tp_exit_net(struct net *net)
 	struct l2tp_net *pn = l2tp_pernet(net);
 	struct l2tp_tunnel *tunnel = NULL;
 	unsigned long tunnel_id, tmp;
-	int hash;
 
 	rcu_read_lock_bh();
 	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
@@ -1714,8 +1825,7 @@ static __net_exit void l2tp_exit_net(struct net *net)
 		flush_workqueue(l2tp_wq);
 	rcu_barrier();
 
-	for (hash = 0; hash < L2TP_HASH_SIZE_2; hash++)
-		WARN_ON_ONCE(!hlist_empty(&pn->l2tp_session_hlist[hash]));
+	idr_destroy(&pn->l2tp_v3_session_idr);
 	idr_destroy(&pn->l2tp_tunnel_idr);
 }
 
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 54dfba1eb91c..bfccc4ca2644 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -23,10 +23,6 @@
 #define L2TP_HASH_BITS	4
 #define L2TP_HASH_SIZE	BIT(L2TP_HASH_BITS)
 
-/* System-wide session hash table size */
-#define L2TP_HASH_BITS_2	8
-#define L2TP_HASH_SIZE_2	BIT(L2TP_HASH_BITS_2)
-
 struct sk_buff;
 
 struct l2tp_stats {
@@ -61,6 +57,12 @@ struct l2tp_session_cfg {
 	char			*ifname;
 };
 
+struct l2tp_session_coll_list {
+	spinlock_t lock;	/* for access to list */
+	struct list_head list;
+	refcount_t ref_count;
+};
+
 /* Represents a session (pseudowire) instance.
  * Tracks runtime state including cookies, dataplane packet sequencing, and IO statistics.
  * Is linked into a per-tunnel session hashlist; and in the case of an L2TPv3 session into
@@ -88,8 +90,11 @@ struct l2tp_session {
 	u32			nr_oos;		/* NR of last OOS packet */
 	int			nr_oos_count;	/* for OOS recovery */
 	int			nr_oos_count_max;
-	struct hlist_node	hlist;		/* hash list node */
 	refcount_t		ref_count;
+	struct hlist_node	hlist;		/* per-net session hlist */
+	unsigned long		hlist_key;	/* key for session hlist */
+	struct l2tp_session_coll_list *coll_list; /* session collision list */
+	struct list_head	clist;		/* for coll_list */
 
 	char			name[L2TP_SESSION_NAME_MAX]; /* for logging */
 	char			ifname[IFNAMSIZ];
@@ -102,7 +107,6 @@ struct l2tp_session {
 	int			reorder_skip;	/* set if skip to next nr */
 	enum l2tp_pwtype	pwtype;
 	struct l2tp_stats	stats;
-	struct hlist_node	global_hlist;	/* global hash list node */
 
 	/* Session receive handler for data packets.
 	 * Each pseudowire implementation should implement this callback in order to
@@ -226,7 +230,7 @@ struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
 struct l2tp_session *l2tp_tunnel_get_session(struct l2tp_tunnel *tunnel,
 					     u32 session_id);
 
-struct l2tp_session *l2tp_session_get(const struct net *net, u32 session_id);
+struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname);
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 19c8cc5289d5..e48aa177d74c 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -140,7 +140,7 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 	}
 
 	/* Ok, this is a data packet. Lookup the session. */
-	session = l2tp_session_get(net, session_id);
+	session = l2tp_v3_session_get(net, NULL, session_id);
 	if (!session)
 		goto discard;
 
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 8780ec64f376..d217ff1f229e 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -150,7 +150,7 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 	}
 
 	/* Ok, this is a data packet. Lookup the session. */
-	session = l2tp_session_get(net, session_id);
+	session = l2tp_v3_session_get(net, NULL, session_id);
 	if (!session)
 		goto discard;
 
-- 
2.34.1


