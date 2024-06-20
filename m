Return-Path: <netdev+bounces-105220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE189910288
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE4BB21735
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D5F1AB8FA;
	Thu, 20 Jun 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="d5Qa72nQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1021AB534
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883042; cv=none; b=H41ZEizkM5hMjpia6Ri+7Y3s3w3J+KO3S6Co+qY99PyoJlqw/OKrCUTe94Has4RoSB7vZmEUwEzgqyAg+X44JQrbi66inTz/55pp/OeFwl6TyVtLhrLwDHGsWaNxFA/QDwJQMu6m7egyCWKzR/epbD6Ch/UfRoVyuP0fs6PZMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883042; c=relaxed/simple;
	bh=pSTqX7xN8jS98GwHp6k21Bs6AZHGIE0ehY8MZEnCffM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iE0yPhNy37uy3ai+magMQwqBhYlQMOypHfLf56DMLLxe5lUQx4fo2A92b8EaUsuP9QPSajpqZyeE6ZOstXk5iQhR8Rvfm9Gh7cErUpOn6dfGV0XzV4cSqfJFFqhsU5wFpFjsIYbXss/mLEfe/I94ikm9P66vAPrrY9uO6uYWIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=d5Qa72nQ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 90FF07DA88;
	Thu, 20 Jun 2024 12:22:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882565; bh=pSTqX7xN8jS98GwHp6k21Bs6AZHGIE0ehY8MZEnCffM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=203/8]=20l2tp:=20store=20l2tpv2=20sessions=20in=20p
	 er-net=20IDR|Date:=20Thu,=2020=20Jun=202024=2012:22:39=20+0100|Mes
	 sage-Id:=20<efd2d6f1479ae42ee867fae3119af1bc80ea23ed.1718877398.gi
	 t.jchapman@katalix.com>|In-Reply-To:=20<cover.1718877398.git.jchap
	 man@katalix.com>|References:=20<cover.1718877398.git.jchapman@kata
	 lix.com>|MIME-Version:=201.0;
	b=d5Qa72nQPOV/EcC7efeTW3OdutSEe08ls6OKxG8lU8Gs/krhQGVOBuGJAGOo7wbwj
	 VZdJCbBa6ecyYxhYfhtPN2OSZqSOgdBscKi54SznU1KD/LtORR1XWFL8U+gupDl9Fq
	 2x5jg6SlQMt4pCcE5R3+mXe7ZObcfVabLjLcTkVNSEbUOztgY+FqySwJqJ1NXaqajD
	 /D3nmpa60Hejmbi3+XDxl4s5OujXGQmb8yfFjfx0kB/l7/Qf0OtHLypTDObyZe24Y3
	 FoGizXdosrizra15LSkus9tKLjFmfyo056XjCe/SZtwtwGqED7a/jb0zVUs6RP8JEj
	 kAcaJPaE3IJvw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 3/8] l2tp: store l2tpv2 sessions in per-net IDR
Date: Thu, 20 Jun 2024 12:22:39 +0100
Message-Id: <efd2d6f1479ae42ee867fae3119af1bc80ea23ed.1718877398.git.jchapman@katalix.com>
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

L2TPv2 sessions are currently kept in a per-tunnel hashlist, keyed by
16-bit session_id. When handling received L2TPv2 packets, we need to
first derive the tunnel using the 16-bit tunnel_id or sock, then
lookup the session in a per-tunnel hlist using the 16-bit session_id.

We want to avoid using sk_user_data in the datapath and double lookups
on every packet. So instead, use a per-net IDR to hold L2TPv2
sessions, keyed by a 32-bit value derived from the 16-bit tunnel_id
and session_id. This will allow the L2TPv2 UDP receive datapath to
lookup a session with a single lookup without deriving the tunnel
first.

L2TPv2 sessions are held in their own IDR to avoid potential
key collisions with L2TPv3 sessions.

Signed-off-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 70 ++++++++++++++++++++++++++++++++++----------
 net/l2tp/l2tp_core.h |  1 +
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index d6bffdb16466..6f30b347fd46 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -107,12 +107,18 @@ struct l2tp_net {
 	/* Lock for write access to l2tp_tunnel_idr */
 	spinlock_t l2tp_tunnel_idr_lock;
 	struct idr l2tp_tunnel_idr;
-	/* Lock for write access to l2tp_v3_session_idr/htable */
+	/* Lock for write access to l2tp_v[23]_session_idr/htable */
 	spinlock_t l2tp_session_idr_lock;
+	struct idr l2tp_v2_session_idr;
 	struct idr l2tp_v3_session_idr;
 	struct hlist_head l2tp_v3_session_htable[16];
 };
 
+static inline u32 l2tp_v2_session_key(u16 tunnel_id, u16 session_id)
+{
+	return ((u32)tunnel_id) << 16 | session_id;
+}
+
 static inline unsigned long l2tp_v3_session_hashkey(struct sock *sk, u32 session_id)
 {
 	return ((unsigned long)sk) + session_id;
@@ -292,6 +298,24 @@ struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(l2tp_v3_session_get);
 
+struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id)
+{
+	u32 session_key = l2tp_v2_session_key(tunnel_id, session_id);
+	const struct l2tp_net *pn = l2tp_pernet(net);
+	struct l2tp_session *session;
+
+	rcu_read_lock_bh();
+	session = idr_find(&pn->l2tp_v2_session_idr, session_key);
+	if (session && refcount_inc_not_zero(&session->ref_count)) {
+		rcu_read_unlock_bh();
+		return session;
+	}
+	rcu_read_unlock_bh();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(l2tp_v2_session_get);
+
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth)
 {
 	int hash;
@@ -477,23 +501,32 @@ int l2tp_session_register(struct l2tp_session *session,
 			err = l2tp_session_collision_add(pn, session, session2);
 		}
 		spin_unlock_bh(&pn->l2tp_session_idr_lock);
-		if (err == -ENOSPC)
-			err = -EEXIST;
+	} else {
+		session_key = l2tp_v2_session_key(tunnel->tunnel_id,
+						  session->session_id);
+		spin_lock_bh(&pn->l2tp_session_idr_lock);
+		err = idr_alloc_u32(&pn->l2tp_v2_session_idr, NULL,
+				    &session_key, session_key, GFP_ATOMIC);
+		spin_unlock_bh(&pn->l2tp_session_idr_lock);
 	}
 
-	if (err)
+	if (err) {
+		if (err == -ENOSPC)
+			err = -EEXIST;
 		goto err_tlock;
+	}
 
 	l2tp_tunnel_inc_refcount(tunnel);
 
 	hlist_add_head_rcu(&session->hlist, head);
 	spin_unlock_bh(&tunnel->hlist_lock);
 
-	if (tunnel->version == L2TP_HDR_VER_3) {
-		spin_lock_bh(&pn->l2tp_session_idr_lock);
+	spin_lock_bh(&pn->l2tp_session_idr_lock);
+	if (tunnel->version == L2TP_HDR_VER_3)
 		idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
-		spin_unlock_bh(&pn->l2tp_session_idr_lock);
-	}
+	else
+		idr_replace(&pn->l2tp_v2_session_idr, session, session_key);
+	spin_unlock_bh(&pn->l2tp_session_idr_lock);
 
 	trace_register_session(session);
 
@@ -1321,25 +1354,30 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 
 	/* Remove the session from core hashes */
 	if (tunnel) {
+		struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
+		struct l2tp_session *removed = session;
+
 		/* Remove from the per-tunnel hash */
 		spin_lock_bh(&tunnel->hlist_lock);
 		hlist_del_init_rcu(&session->hlist);
 		spin_unlock_bh(&tunnel->hlist_lock);
 
-		/* For L2TPv3 we have a per-net IDR: remove from there, too */
+		/* Remove from per-net IDR */
+		spin_lock_bh(&pn->l2tp_session_idr_lock);
 		if (tunnel->version == L2TP_HDR_VER_3) {
-			struct l2tp_net *pn = l2tp_pernet(tunnel->l2tp_net);
-			struct l2tp_session *removed = session;
-
-			spin_lock_bh(&pn->l2tp_session_idr_lock);
 			if (hash_hashed(&session->hlist))
 				l2tp_session_collision_del(pn, session);
 			else
 				removed = idr_remove(&pn->l2tp_v3_session_idr,
 						     session->session_id);
-			WARN_ON_ONCE(removed && removed != session);
-			spin_unlock_bh(&pn->l2tp_session_idr_lock);
+		} else {
+			u32 session_key = l2tp_v2_session_key(tunnel->tunnel_id,
+							      session->session_id);
+			removed = idr_remove(&pn->l2tp_v2_session_idr,
+					     session_key);
 		}
+		WARN_ON_ONCE(removed && removed != session);
+		spin_unlock_bh(&pn->l2tp_session_idr_lock);
 
 		synchronize_rcu();
 	}
@@ -1802,6 +1840,7 @@ static __net_init int l2tp_init_net(struct net *net)
 	idr_init(&pn->l2tp_tunnel_idr);
 	spin_lock_init(&pn->l2tp_tunnel_idr_lock);
 
+	idr_init(&pn->l2tp_v2_session_idr);
 	idr_init(&pn->l2tp_v3_session_idr);
 	spin_lock_init(&pn->l2tp_session_idr_lock);
 
@@ -1825,6 +1864,7 @@ static __net_exit void l2tp_exit_net(struct net *net)
 		flush_workqueue(l2tp_wq);
 	rcu_barrier();
 
+	idr_destroy(&pn->l2tp_v2_session_idr);
 	idr_destroy(&pn->l2tp_v3_session_idr);
 	idr_destroy(&pn->l2tp_tunnel_idr);
 }
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index bfccc4ca2644..d80f15f5b9fc 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -231,6 +231,7 @@ struct l2tp_session *l2tp_tunnel_get_session(struct l2tp_tunnel *tunnel,
 					     u32 session_id);
 
 struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
+struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname);
-- 
2.34.1


