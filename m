Return-Path: <netdev+bounces-105216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310191026E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35981C21B67
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D91AB8E4;
	Thu, 20 Jun 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="aPImQRbG"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D61AB534
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882574; cv=none; b=E2uOb/c6IoKIZ8ZW5EUohQKBm24cUlkzSOmEAgrSpchwfCdiFspuNwotTkAIn3TubUq/jCnfmiB4y2R4qz255RmccM57hxk5vG9B/16WN8CcWBBmmW8A31TAqIhY2MgJZ8RQQwi+HZOhX9UQKYrTRrD3CQK+gULryHmeuD97y9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882574; c=relaxed/simple;
	bh=43UCE2ocKcBlMCXRQb/OxLBV2Z3a6AE5Dvy717d+f8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTqzjC6m0KyCmk3Ao/mD2H6UjrHT9csAblpxhge3aNPvCkuhz+ARzf2lZSgBAU7/Ii7X7TarqKjr2jn7jA2LKxjVan2eXwxLQvcKvSB2zqomXoJFDxhuP6Efln3NypJRBV2w7IPIK5jthJJdCRNuyrVo4Qe1S5Nt21u6hOs0Stk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=aPImQRbG; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 793FB7DCCB;
	Thu, 20 Jun 2024 12:22:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882566; bh=43UCE2ocKcBlMCXRQb/OxLBV2Z3a6AE5Dvy717d+f8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=208/8]=20l2tp:=20replace=20hlist=20with=20simple=20
	 list=20for=20per-tunnel=20session=20list|Date:=20Thu,=2020=20Jun=2
	 02024=2012:22:44=20+0100|Message-Id:=20<cefb0e91ce427f5bab29ca5808
	 5036329d369ed4.1718877398.git.jchapman@katalix.com>|In-Reply-To:=2
	 0<cover.1718877398.git.jchapman@katalix.com>|References:=20<cover.
	 1718877398.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=aPImQRbGkrrg+0cB9LL/ddLRtarwqOQ3Pm8rR13hwixeaQKi7Tmqy9ZW0KIFKqe7C
	 nmOtOp96LYsoeJZSqSOawFO7R4dHBhdif8axPANNihCE85VKyUpeQPzTTpvmir4TSG
	 LaLWMMQhnqPZWLz84GILhPSWqVyvgb1OdpAqfZZ2Wrd0QzaFn+MJLakFBkkVUYKd8A
	 4GWbwRJOssGkim3X50VJ2985VRnDr18U82jhl8ONY/o9ju+p+KFCKiNzpXmkLrYWTe
	 6Q1QOPzSS6zRoC3XJDw/zxr1o1LlnBJQ9ekavSP3jZiLZvkXaPxOm5BRECz9b1QlEL
	 SlH8vAI/MRfww==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 8/8] l2tp: replace hlist with simple list for per-tunnel session list
Date: Thu, 20 Jun 2024 12:22:44 +0100
Message-Id: <cefb0e91ce427f5bab29ca58085036329d369ed4.1718877398.git.jchapman@katalix.com>
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

The per-tunnel session list is no longer used by the
datapath. However, we still need a list of sessions in the tunnel for
l2tp_session_get_nth, which is used by management code. (An
alternative might be to walk each session IDR list, matching only
sessions of a given tunnel.)

Replace the per-tunnel hlist with a per-tunnel list. In functions
which walk a list of sessions of a tunnel, walk this list instead.

Signed-off-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c    | 109 ++++++++++++++--------------------------
 net/l2tp/l2tp_core.h    |  19 +++----
 net/l2tp/l2tp_debugfs.c |  13 ++---
 3 files changed, 50 insertions(+), 91 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 3ce689331542..be4bcbf291a1 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -39,7 +39,6 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 #include <linux/l2tp.h>
-#include <linux/hash.h>
 #include <linux/sort.h>
 #include <linux/file.h>
 #include <linux/nsproxy.h>
@@ -137,18 +136,6 @@ static inline struct l2tp_net *l2tp_pernet(const struct net *net)
 	return net_generic(net, l2tp_net_id);
 }
 
-/* Session hash list.
- * The session_id SHOULD be random according to RFC2661, but several
- * L2TP implementations (Cisco and Microsoft) use incrementing
- * session_ids.  So we do a real hash on the session_id, rather than a
- * simple bitmask.
- */
-static inline struct hlist_head *
-l2tp_session_id_hash(struct l2tp_tunnel *tunnel, u32 session_id)
-{
-	return &tunnel->session_hlist[hash_32(session_id, L2TP_HASH_BITS)];
-}
-
 static void l2tp_tunnel_free(struct l2tp_tunnel *tunnel)
 {
 	trace_free_tunnel(tunnel);
@@ -306,21 +293,17 @@ EXPORT_SYMBOL_GPL(l2tp_session_get);
 
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth)
 {
-	int hash;
 	struct l2tp_session *session;
 	int count = 0;
 
 	rcu_read_lock_bh();
-	for (hash = 0; hash < L2TP_HASH_SIZE; hash++) {
-		hlist_for_each_entry_rcu(session, &tunnel->session_hlist[hash], hlist) {
-			if (++count > nth) {
-				l2tp_session_inc_refcount(session);
-				rcu_read_unlock_bh();
-				return session;
-			}
+	list_for_each_entry_rcu(session, &tunnel->session_list, list) {
+		if (++count > nth) {
+			l2tp_session_inc_refcount(session);
+			rcu_read_unlock_bh();
+			return session;
 		}
 	}
-
 	rcu_read_unlock_bh();
 
 	return NULL;
@@ -334,21 +317,23 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
-	unsigned long session_id, tmp;
+	unsigned long tunnel_id, tmp;
 	struct l2tp_session *session;
+	struct l2tp_tunnel *tunnel;
 
 	rcu_read_lock_bh();
-	idr_for_each_entry_ul(&pn->l2tp_v3_session_idr, session, tmp, session_id) {
-		if (session) {
-			if (!strcmp(session->ifname, ifname)) {
-				l2tp_session_inc_refcount(session);
-				rcu_read_unlock_bh();
-
-				return session;
+	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
+		if (tunnel) {
+			list_for_each_entry_rcu(session, &tunnel->session_list, list) {
+				if (!strcmp(session->ifname, ifname)) {
+					l2tp_session_inc_refcount(session);
+					rcu_read_unlock_bh();
+
+					return session;
+				}
 			}
 		}
 	}
-
 	rcu_read_unlock_bh();
 
 	return NULL;
@@ -452,25 +437,15 @@ int l2tp_session_register(struct l2tp_session *session,
 			  struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
-	struct l2tp_session *session_walk;
-	struct hlist_head *head;
 	u32 session_key;
 	int err;
 
-	head = l2tp_session_id_hash(tunnel, session->session_id);
-
-	spin_lock_bh(&tunnel->hlist_lock);
+	spin_lock_bh(&tunnel->list_lock);
 	if (!tunnel->acpt_newsess) {
 		err = -ENODEV;
 		goto err_tlock;
 	}
 
-	hlist_for_each_entry(session_walk, head, hlist)
-		if (session_walk->session_id == session->session_id) {
-			err = -EEXIST;
-			goto err_tlock;
-		}
-
 	if (tunnel->version == L2TP_HDR_VER_3) {
 		session_key = session->session_id;
 		spin_lock_bh(&pn->l2tp_session_idr_lock);
@@ -506,8 +481,8 @@ int l2tp_session_register(struct l2tp_session *session,
 
 	l2tp_tunnel_inc_refcount(tunnel);
 
-	hlist_add_head_rcu(&session->hlist, head);
-	spin_unlock_bh(&tunnel->hlist_lock);
+	list_add(&session->list, &tunnel->session_list);
+	spin_unlock_bh(&tunnel->list_lock);
 
 	spin_lock_bh(&pn->l2tp_session_idr_lock);
 	if (tunnel->version == L2TP_HDR_VER_3)
@@ -521,7 +496,7 @@ int l2tp_session_register(struct l2tp_session *session,
 	return 0;
 
 err_tlock:
-	spin_unlock_bh(&tunnel->hlist_lock);
+	spin_unlock_bh(&tunnel->list_lock);
 
 	return err;
 }
@@ -1275,20 +1250,19 @@ static void l2tp_tunnel_destruct(struct sock *sk)
 	return;
 }
 
-/* Remove an l2tp session from l2tp_core's hash lists. */
+/* Remove an l2tp session from l2tp_core's lists. */
 static void l2tp_session_unhash(struct l2tp_session *session)
 {
 	struct l2tp_tunnel *tunnel = session->tunnel;
 
-	/* Remove the session from core hashes */
 	if (tunnel) {
 		struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
 		struct l2tp_session *removed = session;
 
-		/* Remove from the per-tunnel hash */
-		spin_lock_bh(&tunnel->hlist_lock);
-		hlist_del_init_rcu(&session->hlist);
-		spin_unlock_bh(&tunnel->hlist_lock);
+		/* Remove from the per-tunnel list */
+		spin_lock_bh(&tunnel->list_lock);
+		list_del_init(&session->list);
+		spin_unlock_bh(&tunnel->list_lock);
 
 		/* Remove from per-net IDR */
 		spin_lock_bh(&pn->l2tp_session_idr_lock);
@@ -1316,28 +1290,19 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_session *session;
-	int hash;
+	struct list_head __rcu *pos;
+	struct list_head *tmp;
 
-	spin_lock_bh(&tunnel->hlist_lock);
+	spin_lock_bh(&tunnel->list_lock);
 	tunnel->acpt_newsess = false;
-	for (hash = 0; hash < L2TP_HASH_SIZE; hash++) {
-again:
-		hlist_for_each_entry_rcu(session, &tunnel->session_hlist[hash], hlist) {
-			hlist_del_init_rcu(&session->hlist);
-
-			spin_unlock_bh(&tunnel->hlist_lock);
-			l2tp_session_delete(session);
-			spin_lock_bh(&tunnel->hlist_lock);
-
-			/* Now restart from the beginning of this hash
-			 * chain.  We always remove a session from the
-			 * list so we are guaranteed to make forward
-			 * progress.
-			 */
-			goto again;
-		}
+	list_for_each_safe(pos, tmp, &tunnel->session_list) {
+		session = list_entry(pos, struct l2tp_session, list);
+		list_del_init(&session->list);
+		spin_unlock_bh(&tunnel->list_lock);
+		l2tp_session_delete(session);
+		spin_lock_bh(&tunnel->list_lock);
 	}
-	spin_unlock_bh(&tunnel->hlist_lock);
+	spin_unlock_bh(&tunnel->list_lock);
 }
 
 /* Tunnel socket destroy hook for UDP encapsulation */
@@ -1531,8 +1496,9 @@ int l2tp_tunnel_create(int fd, int version, u32 tunnel_id, u32 peer_tunnel_id,
 
 	tunnel->magic = L2TP_TUNNEL_MAGIC;
 	sprintf(&tunnel->name[0], "tunl %u", tunnel_id);
-	spin_lock_init(&tunnel->hlist_lock);
+	spin_lock_init(&tunnel->list_lock);
 	tunnel->acpt_newsess = true;
+	INIT_LIST_HEAD(&tunnel->session_list);
 
 	tunnel->encap = encap;
 
@@ -1732,6 +1698,7 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 		session->hlist_key = l2tp_v3_session_hashkey(tunnel->sock, session->session_id);
 		INIT_HLIST_NODE(&session->hlist);
 		INIT_LIST_HEAD(&session->clist);
+		INIT_LIST_HEAD(&session->list);
 
 		if (cfg) {
 			session->pwtype = cfg->pw_type;
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index bfff69f2e0a2..8ac81bc1bc6f 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -19,10 +19,6 @@
 #define L2TP_TUNNEL_MAGIC	0x42114DDA
 #define L2TP_SESSION_MAGIC	0x0C04EB7D
 
-/* Per tunnel session hash table size */
-#define L2TP_HASH_BITS	4
-#define L2TP_HASH_SIZE	BIT(L2TP_HASH_BITS)
-
 struct sk_buff;
 
 struct l2tp_stats {
@@ -65,8 +61,7 @@ struct l2tp_session_coll_list {
 
 /* Represents a session (pseudowire) instance.
  * Tracks runtime state including cookies, dataplane packet sequencing, and IO statistics.
- * Is linked into a per-tunnel session hashlist; and in the case of an L2TPv3 session into
- * an additional per-net ("global") hashlist.
+ * Is linked into a per-tunnel session list and a per-net ("global") IDR tree.
  */
 #define L2TP_SESSION_NAME_MAX 32
 struct l2tp_session {
@@ -90,6 +85,7 @@ struct l2tp_session {
 	u32			nr_oos;		/* NR of last OOS packet */
 	int			nr_oos_count;	/* for OOS recovery */
 	int			nr_oos_count_max;
+	struct list_head	list;		/* per-tunnel list node */
 	refcount_t		ref_count;
 	struct hlist_node	hlist;		/* per-net session hlist */
 	unsigned long		hlist_key;	/* key for session hlist */
@@ -118,7 +114,7 @@ struct l2tp_session {
 	/* Session close handler.
 	 * Each pseudowire implementation may implement this callback in order to carry
 	 * out pseudowire-specific shutdown actions.
-	 * The callback is called by core after unhashing the session and purging its
+	 * The callback is called by core after unlisting the session and purging its
 	 * reorder queue.
 	 */
 	void (*session_close)(struct l2tp_session *session);
@@ -154,7 +150,7 @@ struct l2tp_tunnel_cfg {
 /* Represents a tunnel instance.
  * Tracks runtime state including IO statistics.
  * Holds the tunnel socket (either passed from userspace or directly created by the kernel).
- * Maintains a hashlist of sessions belonging to the tunnel instance.
+ * Maintains a list of sessions belonging to the tunnel instance.
  * Is linked into a per-net list of tunnels.
  */
 #define L2TP_TUNNEL_NAME_MAX 20
@@ -164,12 +160,11 @@ struct l2tp_tunnel {
 	unsigned long		dead;
 
 	struct rcu_head rcu;
-	spinlock_t		hlist_lock;	/* write-protection for session_hlist */
+	spinlock_t		list_lock;	/* write-protection for session_list */
 	bool			acpt_newsess;	/* indicates whether this tunnel accepts
-						 * new sessions. Protected by hlist_lock.
+						 * new sessions. Protected by list_lock.
 						 */
-	struct hlist_head	session_hlist[L2TP_HASH_SIZE];
-						/* hashed list of sessions, hashed by id */
+	struct list_head	session_list;	/* list of sessions */
 	u32			tunnel_id;
 	u32			peer_tunnel_id;
 	int			version;	/* 2=>L2TPv2, 3=>L2TPv3 */
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index 4595b56d175d..8755ae521154 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -123,17 +123,14 @@ static void l2tp_dfs_seq_tunnel_show(struct seq_file *m, void *v)
 	struct l2tp_tunnel *tunnel = v;
 	struct l2tp_session *session;
 	int session_count = 0;
-	int hash;
 
 	rcu_read_lock_bh();
-	for (hash = 0; hash < L2TP_HASH_SIZE; hash++) {
-		hlist_for_each_entry_rcu(session, &tunnel->session_hlist[hash], hlist) {
-			/* Session ID of zero is a dummy/reserved value used by pppol2tp */
-			if (session->session_id == 0)
-				continue;
+	list_for_each_entry_rcu(session, &tunnel->session_list, list) {
+		/* Session ID of zero is a dummy/reserved value used by pppol2tp */
+		if (session->session_id == 0)
+			continue;
 
-			session_count++;
-		}
+		session_count++;
 	}
 	rcu_read_unlock_bh();
 
-- 
2.34.1


