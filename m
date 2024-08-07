Return-Path: <netdev+bounces-116337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B9094A128
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83F21C22E21
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFACE1BA892;
	Wed,  7 Aug 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="E6ZeFJBy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00101B8E93
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013698; cv=none; b=ZuJvO4Tmq1FNabB9z0qGPunZZ/F7YYk/jIZKkJhCz0Mp9uxGx9ndeCmZmyExJjfncDrhKKXnSaOmVx5BYBrwkVEk16euVvF5J1lAUfSAnJHkLbORCrEbvKkAUENPs7fJm6haThk+oXuFqUqtMSwPLp5oxXUPtYxvb7ADscqMUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013698; c=relaxed/simple;
	bh=eNz4X/kQP8DA5Oey7uZecDNsO7CVuG0+uGJ3KLFBM/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4EUzJT4RZeJQs9z7IFnAZOjtSJJOAi4oRfXHgZAY4sz4fqFSpV3Kp76Wg1UQMI6MXru/TXV4az4F98oGf3ySSGT51q/+FmedVxF4G46U/MRF5WYDTYtH4duiuoDqy+18U4+JKstE2gOpRKo4VsdQ/6j9IfXSGnIbZCZV2ROymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=E6ZeFJBy; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 04BD97DD07;
	Wed,  7 Aug 2024 07:54:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013695; bh=eNz4X/kQP8DA5Oey7uZecDNsO7CVuG0+uGJ3KLFBM/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org|Subject:=20[PATCH=20v2=20net-next=206/9]=20l2tp:=20use=20get_
	 next=20APIs=20for=20management=20requests=20and=20procfs/debugfs|D
	 ate:=20Wed,=20=207=20Aug=202024=2007:54:49=20+0100|Message-Id:=20<
	 0ed95752e184f213260e84b4ff3ee4f4bedeed9e.1723011569.git.jchapman@k
	 atalix.com>|In-Reply-To:=20<cover.1723011569.git.jchapman@katalix.
	 com>|References:=20<cover.1723011569.git.jchapman@katalix.com>|MIM
	 E-Version:=201.0;
	b=E6ZeFJByBnb7xBTOLQz9ZU1llPdNYMC1C+iwKLuDk2Z9P14X4ylOBa1zwbB5lrvya
	 +g3etBUf1SKViJWAymcQWoO/qaj/zYmkpQbzmBH2q+ppg6C1mhqUuj7r/gy9pgyVpX
	 DHYcZcmzmWTjRZmLE8nMi4nCCvdUWJ1dG4/k2hpUSmTRT+AoLUqlzsq+nSbqsV1OcX
	 MsLIvR5CSdRhxijNN206EHyZyZVnKs/WXMKpiuzusNMJHqjS5pT2k6Mh09axlM7qeB
	 T4BJHF255hH7HQ9yV5q0CGPFGkWSO9/+9gzhcnOFlLOOepWDlQ8LBZVFOqDMMHpnWb
	 GyLlk/xjGw0Gg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org
Subject: [PATCH v2 net-next 6/9] l2tp: use get_next APIs for management requests and procfs/debugfs
Date: Wed,  7 Aug 2024 07:54:49 +0100
Message-Id: <0ed95752e184f213260e84b4ff3ee4f4bedeed9e.1723011569.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723011569.git.jchapman@katalix.com>
References: <cover.1723011569.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp netlink and procfs/debugfs iterate over tunnel and session lists
to obtain data. They currently use very inefficient get_nth functions
to do so. Replace these with get_next.

For netlink, use nl cb->ctx[] for passing state instead of the
obsolete cb->args[].

l2tp_tunnel_get_nth and l2tp_session_get_nth are no longer used so
they can be removed.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c    | 40 ----------------------------------------
 net/l2tp/l2tp_core.h    |  2 --
 net/l2tp/l2tp_debugfs.c | 16 +++++++++-------
 net/l2tp/l2tp_netlink.c | 34 +++++++++++++++++++++-------------
 net/l2tp/l2tp_ppp.c     | 16 +++++++++-------
 5 files changed, 39 insertions(+), 69 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index c3d6aa5309c7..c0d525fc85e1 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -236,27 +236,6 @@ struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id)
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_get);
 
-struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth)
-{
-	struct l2tp_net *pn = l2tp_pernet(net);
-	unsigned long tunnel_id, tmp;
-	struct l2tp_tunnel *tunnel;
-	int count = 0;
-
-	rcu_read_lock_bh();
-	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
-		if (tunnel && ++count > nth &&
-		    refcount_inc_not_zero(&tunnel->ref_count)) {
-			rcu_read_unlock_bh();
-			return tunnel;
-		}
-	}
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_get_nth);
-
 struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
@@ -350,25 +329,6 @@ struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, in
 }
 EXPORT_SYMBOL_GPL(l2tp_session_get);
 
-struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth)
-{
-	struct l2tp_session *session;
-	int count = 0;
-
-	rcu_read_lock_bh();
-	list_for_each_entry_rcu(session, &tunnel->session_list, list) {
-		if (++count > nth) {
-			l2tp_session_inc_refcount(session);
-			rcu_read_unlock_bh();
-			return session;
-		}
-	}
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_session_get_nth);
-
 static struct l2tp_session *l2tp_v2_session_get_next(const struct net *net,
 						     u16 tid,
 						     unsigned long *key)
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index cc464982a7d9..0fabacffc3f3 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -219,14 +219,12 @@ void l2tp_session_dec_refcount(struct l2tp_session *session);
  * the caller must ensure that the reference is dropped appropriately.
  */
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
-struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
 struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key);
 
 struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
 struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
 struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
 				      u32 tunnel_id, u32 session_id);
-struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
 struct l2tp_session *l2tp_session_get_next(const struct net *net, struct sock *sk, int pver,
 					   u32 tunnel_id, unsigned long *key);
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index 8755ae521154..b2134b57ed18 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -34,8 +34,8 @@ static struct dentry *rootdir;
 struct l2tp_dfs_seq_data {
 	struct net	*net;
 	netns_tracker	ns_tracker;
-	int tunnel_idx;			/* current tunnel */
-	int session_idx;		/* index of session within current tunnel */
+	unsigned long tkey;		/* lookup key of current tunnel */
+	unsigned long skey;		/* lookup key of current session */
 	struct l2tp_tunnel *tunnel;
 	struct l2tp_session *session;	/* NULL means get next tunnel */
 };
@@ -46,8 +46,8 @@ static void l2tp_dfs_next_tunnel(struct l2tp_dfs_seq_data *pd)
 	if (pd->tunnel)
 		l2tp_tunnel_dec_refcount(pd->tunnel);
 
-	pd->tunnel = l2tp_tunnel_get_nth(pd->net, pd->tunnel_idx);
-	pd->tunnel_idx++;
+	pd->tunnel = l2tp_tunnel_get_next(pd->net, &pd->tkey);
+	pd->tkey++;
 }
 
 static void l2tp_dfs_next_session(struct l2tp_dfs_seq_data *pd)
@@ -56,11 +56,13 @@ static void l2tp_dfs_next_session(struct l2tp_dfs_seq_data *pd)
 	if (pd->session)
 		l2tp_session_dec_refcount(pd->session);
 
-	pd->session = l2tp_session_get_nth(pd->tunnel, pd->session_idx);
-	pd->session_idx++;
+	pd->session = l2tp_session_get_next(pd->net, pd->tunnel->sock,
+					    pd->tunnel->version,
+					    pd->tunnel->tunnel_id, &pd->skey);
+	pd->skey++;
 
 	if (!pd->session) {
-		pd->session_idx = 0;
+		pd->skey = 0;
 		l2tp_dfs_next_tunnel(pd);
 	}
 }
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index fc43ecbd128c..0598b97a0bca 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -491,14 +491,20 @@ static int l2tp_nl_cmd_tunnel_get(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+struct l2tp_nl_cb_data {
+	unsigned long tkey;
+	unsigned long skey;
+};
+
 static int l2tp_nl_cmd_tunnel_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	int ti = cb->args[0];
+	struct l2tp_nl_cb_data *cbd = (void *)&cb->ctx[0];
+	unsigned long key = cbd->tkey;
 	struct l2tp_tunnel *tunnel;
 	struct net *net = sock_net(skb->sk);
 
 	for (;;) {
-		tunnel = l2tp_tunnel_get_nth(net, ti);
+		tunnel = l2tp_tunnel_get_next(net, &key);
 		if (!tunnel)
 			goto out;
 
@@ -510,11 +516,11 @@ static int l2tp_nl_cmd_tunnel_dump(struct sk_buff *skb, struct netlink_callback
 		}
 		l2tp_tunnel_dec_refcount(tunnel);
 
-		ti++;
+		key++;
 	}
 
 out:
-	cb->args[0] = ti;
+	cbd->tkey = key;
 
 	return skb->len;
 }
@@ -832,25 +838,27 @@ static int l2tp_nl_cmd_session_get(struct sk_buff *skb, struct genl_info *info)
 
 static int l2tp_nl_cmd_session_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	struct l2tp_nl_cb_data *cbd = (void *)&cb->ctx[0];
 	struct net *net = sock_net(skb->sk);
 	struct l2tp_session *session;
 	struct l2tp_tunnel *tunnel = NULL;
-	int ti = cb->args[0];
-	int si = cb->args[1];
+	unsigned long tkey = cbd->tkey;
+	unsigned long skey = cbd->skey;
 
 	for (;;) {
 		if (!tunnel) {
-			tunnel = l2tp_tunnel_get_nth(net, ti);
+			tunnel = l2tp_tunnel_get_next(net, &tkey);
 			if (!tunnel)
 				goto out;
 		}
 
-		session = l2tp_session_get_nth(tunnel, si);
+		session = l2tp_session_get_next(net, tunnel->sock, tunnel->version,
+						tunnel->tunnel_id, &skey);
 		if (!session) {
-			ti++;
+			tkey++;
 			l2tp_tunnel_dec_refcount(tunnel);
 			tunnel = NULL;
-			si = 0;
+			skey = 0;
 			continue;
 		}
 
@@ -863,12 +871,12 @@ static int l2tp_nl_cmd_session_dump(struct sk_buff *skb, struct netlink_callback
 		}
 		l2tp_session_dec_refcount(session);
 
-		si++;
+		skey++;
 	}
 
 out:
-	cb->args[0] = ti;
-	cb->args[1] = si;
+	cbd->tkey = tkey;
+	cbd->skey = skey;
 
 	return skb->len;
 }
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index c25dd8e36074..8459e5159430 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1397,8 +1397,8 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 
 struct pppol2tp_seq_data {
 	struct seq_net_private p;
-	int tunnel_idx;			/* current tunnel */
-	int session_idx;		/* index of session within current tunnel */
+	unsigned long tkey;		/* lookup key of current tunnel */
+	unsigned long skey;		/* lookup key of current session */
 	struct l2tp_tunnel *tunnel;
 	struct l2tp_session *session;	/* NULL means get next tunnel */
 };
@@ -1410,8 +1410,8 @@ static void pppol2tp_next_tunnel(struct net *net, struct pppol2tp_seq_data *pd)
 		l2tp_tunnel_dec_refcount(pd->tunnel);
 
 	for (;;) {
-		pd->tunnel = l2tp_tunnel_get_nth(net, pd->tunnel_idx);
-		pd->tunnel_idx++;
+		pd->tunnel = l2tp_tunnel_get_next(net, &pd->tkey);
+		pd->tkey++;
 
 		/* Only accept L2TPv2 tunnels */
 		if (!pd->tunnel || pd->tunnel->version == 2)
@@ -1427,11 +1427,13 @@ static void pppol2tp_next_session(struct net *net, struct pppol2tp_seq_data *pd)
 	if (pd->session)
 		l2tp_session_dec_refcount(pd->session);
 
-	pd->session = l2tp_session_get_nth(pd->tunnel, pd->session_idx);
-	pd->session_idx++;
+	pd->session = l2tp_session_get_next(net, pd->tunnel->sock,
+					    pd->tunnel->version,
+					    pd->tunnel->tunnel_id, &pd->skey);
+	pd->skey++;
 
 	if (!pd->session) {
-		pd->session_idx = 0;
+		pd->skey = 0;
 		pppol2tp_next_tunnel(net, pd);
 	}
 }
-- 
2.34.1


