Return-Path: <netdev+bounces-116340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5F94A12C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF411F245B9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114D1BC092;
	Wed,  7 Aug 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="LOkYw21b"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306341B8EA3
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013699; cv=none; b=GzC2TvLUJfyLmRDXmDOZ/iea31BWeVKV1gJgIn1iI4HIhKX3CHOh9RM9SpE6+SlND2BtRhmzq2WoJc5oDKF31jRbfIQ11TgjS//u0whBv3uCtdvV2z+z7jaiXjmmb21B4hMsWSOiMwLrNqID1jpCi/cdq0f8E9LcNZgH92006L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013699; c=relaxed/simple;
	bh=q6Ga12TwhQRS97fHiOd9H90aVXJjLW1DwHp7YmP0VuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcvyOLDXeB3kHodlhQnbnBlGFKwdz4S4+ohBX3QGv31kQJgwnjWHzm7zKpNSEh+PmOaijBMAJhMrJPKicrgtxKFOB9UY1La5KCSYiXEflnDi+2GFPQR+ighU6HGyugFd+6JDjgn8OnETG36mub70obn67qpC0aUTByjKAvr1wJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=LOkYw21b; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 264B17DD08;
	Wed,  7 Aug 2024 07:54:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013695; bh=q6Ga12TwhQRS97fHiOd9H90aVXJjLW1DwHp7YmP0VuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org|Subject:=20[PATCH=20v2=20net-next=207/9]=20l2tp:=20improve=20
	 tunnel/session=20refcount=20helpers|Date:=20Wed,=20=207=20Aug=2020
	 24=2007:54:50=20+0100|Message-Id:=20<7007cf4c4f5f1675d3a58b43a7c1b
	 e758f398303.1723011569.git.jchapman@katalix.com>|In-Reply-To:=20<c
	 over.1723011569.git.jchapman@katalix.com>|References:=20<cover.172
	 3011569.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=LOkYw21bizu83sezZcWr2qPmvksjFwCj8wxZNAItUIjeIQ88T7720f8M69GmQrxme
	 oHvc3nUPoOqyCz7OTrGVc0Mql0kT6uPh5o2k/8NvC/5OZPaJuPtBNhFV/laKl5Q2vb
	 m9c3mUzIkYxAKUsFMpn/HaI+ybkl4j4fiRtpZzU/WWNekzt7+CSdZph1781mUXgZiy
	 +1lZdY/higN52n1uOMiGr75s0XUuZ3Ysi5M78ZkluiZFO5dWgQ2hqEFpmhzCEkG7Hk
	 ghdcvjvOXXvc/IjQWV5QQtvwg7g+2OR1JkgO8KV57ZzHPEPPBU6dXyRqAfg6M2XoOJ
	 k8zaFG1KE86nA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org
Subject: [PATCH v2 net-next 7/9] l2tp: improve tunnel/session refcount helpers
Date: Wed,  7 Aug 2024 07:54:50 +0100
Message-Id: <7007cf4c4f5f1675d3a58b43a7c1be758f398303.1723011569.git.jchapman@katalix.com>
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

l2tp_tunnel_inc_refcount and l2tp_session_inc_refcount wrap
refcount_inc. They add no value so just use the refcount APIs directly
and drop l2tp's helpers. l2tp already uses refcount_inc_not_zero
anyway.

Rename l2tp_tunnel_dec_refcount and l2tp_session_dec_refcount to
l2tp_tunnel_put and l2tp_session_put to better match their use pairing
various _get getters.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c    | 52 ++++++++++++++++-------------------------
 net/l2tp/l2tp_core.h    |  6 ++---
 net/l2tp/l2tp_debugfs.c |  8 +++----
 net/l2tp/l2tp_eth.c     | 10 ++++----
 net/l2tp/l2tp_ip.c      |  6 ++---
 net/l2tp/l2tp_ip6.c     |  6 ++---
 net/l2tp/l2tp_netlink.c | 38 +++++++++++++++---------------
 net/l2tp/l2tp_ppp.c     | 46 ++++++++++++++++++------------------
 8 files changed, 79 insertions(+), 93 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index c0d525fc85e1..6ef1c80bb3bf 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -165,7 +165,7 @@ static void l2tp_session_free(struct l2tp_session *session)
 {
 	trace_free_session(session);
 	if (session->tunnel)
-		l2tp_tunnel_dec_refcount(session->tunnel);
+		l2tp_tunnel_put(session->tunnel);
 	kfree_rcu(session, rcu);
 }
 
@@ -192,31 +192,19 @@ struct l2tp_tunnel *l2tp_sk_to_tunnel(const struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(l2tp_sk_to_tunnel);
 
-void l2tp_tunnel_inc_refcount(struct l2tp_tunnel *tunnel)
-{
-	refcount_inc(&tunnel->ref_count);
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_inc_refcount);
-
-void l2tp_tunnel_dec_refcount(struct l2tp_tunnel *tunnel)
+void l2tp_tunnel_put(struct l2tp_tunnel *tunnel)
 {
 	if (refcount_dec_and_test(&tunnel->ref_count))
 		l2tp_tunnel_free(tunnel);
 }
-EXPORT_SYMBOL_GPL(l2tp_tunnel_dec_refcount);
-
-void l2tp_session_inc_refcount(struct l2tp_session *session)
-{
-	refcount_inc(&session->ref_count);
-}
-EXPORT_SYMBOL_GPL(l2tp_session_inc_refcount);
+EXPORT_SYMBOL_GPL(l2tp_tunnel_put);
 
-void l2tp_session_dec_refcount(struct l2tp_session *session)
+void l2tp_session_put(struct l2tp_session *session)
 {
 	if (refcount_dec_and_test(&session->ref_count))
 		l2tp_session_free(session);
 }
-EXPORT_SYMBOL_GPL(l2tp_session_dec_refcount);
+EXPORT_SYMBOL_GPL(l2tp_session_put);
 
 /* Lookup a tunnel. A new reference is held on the returned tunnel. */
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id)
@@ -449,7 +437,7 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 		if (tunnel) {
 			list_for_each_entry_rcu(session, &tunnel->session_list, list) {
 				if (!strcmp(session->ifname, ifname)) {
-					l2tp_session_inc_refcount(session);
+					refcount_inc(&session->ref_count);
 					rcu_read_unlock_bh();
 
 					return session;
@@ -466,7 +454,7 @@ EXPORT_SYMBOL_GPL(l2tp_session_get_by_ifname);
 static void l2tp_session_coll_list_add(struct l2tp_session_coll_list *clist,
 				       struct l2tp_session *session)
 {
-	l2tp_session_inc_refcount(session);
+	refcount_inc(&session->ref_count);
 	WARN_ON_ONCE(session->coll_list);
 	session->coll_list = clist;
 	spin_lock(&clist->lock);
@@ -552,7 +540,7 @@ static void l2tp_session_collision_del(struct l2tp_net *pn,
 		spin_unlock(&clist->lock);
 		if (refcount_dec_and_test(&clist->ref_count))
 			kfree(clist);
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 	}
 }
 
@@ -601,7 +589,7 @@ int l2tp_session_register(struct l2tp_session *session,
 		goto out;
 	}
 
-	l2tp_tunnel_inc_refcount(tunnel);
+	refcount_inc(&tunnel->ref_count);
 	WRITE_ONCE(session->tunnel, tunnel);
 	list_add_rcu(&session->list, &tunnel->session_list);
 
@@ -1084,7 +1072,7 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	if (!session || !session->recv_skb) {
 		if (session)
-			l2tp_session_dec_refcount(session);
+			l2tp_session_put(session);
 
 		/* Not found? Pass to userspace to deal with */
 		goto pass;
@@ -1098,12 +1086,12 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	if (version == L2TP_HDR_VER_3 &&
 	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr)) {
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 		goto invalid;
 	}
 
 	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 0;
 
@@ -1397,7 +1385,7 @@ static void l2tp_udp_encap_destroy(struct sock *sk)
 	tunnel = l2tp_sk_to_tunnel(sk);
 	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
-		l2tp_tunnel_dec_refcount(tunnel);
+		l2tp_tunnel_put(tunnel);
 	}
 }
 
@@ -1432,10 +1420,10 @@ static void l2tp_tunnel_del_work(struct work_struct *work)
 
 	l2tp_tunnel_remove(tunnel->l2tp_net, tunnel);
 	/* drop initial ref */
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 	/* drop workqueue ref */
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 }
 
 /* Create a socket for the tunnel, if one isn't set up by
@@ -1623,7 +1611,7 @@ static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
 
 	tunnel = l2tp_sk_to_tunnel(sk);
 	if (tunnel) {
-		l2tp_tunnel_dec_refcount(tunnel);
+		l2tp_tunnel_put(tunnel);
 		return -EBUSY;
 	}
 
@@ -1715,7 +1703,7 @@ void l2tp_tunnel_delete(struct l2tp_tunnel *tunnel)
 {
 	if (!test_and_set_bit(0, &tunnel->dead)) {
 		trace_delete_tunnel(tunnel);
-		l2tp_tunnel_inc_refcount(tunnel);
+		refcount_inc(&tunnel->ref_count);
 		queue_work(l2tp_wq, &tunnel->del_work);
 	}
 }
@@ -1725,7 +1713,7 @@ void l2tp_session_delete(struct l2tp_session *session)
 {
 	if (!test_and_set_bit(0, &session->dead)) {
 		trace_delete_session(session);
-		l2tp_session_inc_refcount(session);
+		refcount_inc(&session->ref_count);
 		queue_work(l2tp_wq, &session->del_work);
 	}
 }
@@ -1743,10 +1731,10 @@ static void l2tp_session_del_work(struct work_struct *work)
 		(*session->session_close)(session);
 
 	/* drop initial ref */
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	/* drop workqueue ref */
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 }
 
 /* We come here whenever a session's send_seq, cookie_len or
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 0fabacffc3f3..ffd8ced3a51f 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -209,10 +209,8 @@ static inline void *l2tp_session_priv(struct l2tp_session *session)
 }
 
 /* Tunnel and session refcounts */
-void l2tp_tunnel_inc_refcount(struct l2tp_tunnel *tunnel);
-void l2tp_tunnel_dec_refcount(struct l2tp_tunnel *tunnel);
-void l2tp_session_inc_refcount(struct l2tp_session *session);
-void l2tp_session_dec_refcount(struct l2tp_session *session);
+void l2tp_tunnel_put(struct l2tp_tunnel *tunnel);
+void l2tp_session_put(struct l2tp_session *session);
 
 /* Tunnel and session lookup.
  * These functions take a reference on the instances they return, so
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index b2134b57ed18..2d0c8275a3a8 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -44,7 +44,7 @@ static void l2tp_dfs_next_tunnel(struct l2tp_dfs_seq_data *pd)
 {
 	/* Drop reference taken during previous invocation */
 	if (pd->tunnel)
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 
 	pd->tunnel = l2tp_tunnel_get_next(pd->net, &pd->tkey);
 	pd->tkey++;
@@ -54,7 +54,7 @@ static void l2tp_dfs_next_session(struct l2tp_dfs_seq_data *pd)
 {
 	/* Drop reference taken during previous invocation */
 	if (pd->session)
-		l2tp_session_dec_refcount(pd->session);
+		l2tp_session_put(pd->session);
 
 	pd->session = l2tp_session_get_next(pd->net, pd->tunnel->sock,
 					    pd->tunnel->version,
@@ -111,11 +111,11 @@ static void l2tp_dfs_seq_stop(struct seq_file *p, void *v)
 	 * or l2tp_dfs_next_tunnel().
 	 */
 	if (pd->session) {
-		l2tp_session_dec_refcount(pd->session);
+		l2tp_session_put(pd->session);
 		pd->session = NULL;
 	}
 	if (pd->tunnel) {
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 		pd->tunnel = NULL;
 	}
 }
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index cc8a3ce716e9..e94549668e10 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -283,7 +283,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 
 	spriv = l2tp_session_priv(session);
 
-	l2tp_session_inc_refcount(session);
+	refcount_inc(&session->ref_count);
 
 	rtnl_lock();
 
@@ -301,7 +301,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 	if (rc < 0) {
 		rtnl_unlock();
 		l2tp_session_delete(session);
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 		free_netdev(dev);
 
 		return rc;
@@ -312,17 +312,17 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 
 	rtnl_unlock();
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	__module_get(THIS_MODULE);
 
 	return 0;
 
 err_sess_dev:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 	free_netdev(dev);
 err_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 err:
 	return rc;
 }
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index f563c8afd8f3..39f3f1334c4a 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -167,7 +167,7 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 		goto discard_sess;
 
 	l2tp_recv_common(session, skb, ptr, optr, 0, skb->len);
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 0;
 
@@ -200,7 +200,7 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 	return sk_receive_skb(sk, skb, 1);
 
 discard_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 	goto discard;
 
 discard_put:
@@ -265,7 +265,7 @@ static void l2tp_ip_destroy_sock(struct sock *sk)
 	tunnel = l2tp_sk_to_tunnel(sk);
 	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
-		l2tp_tunnel_dec_refcount(tunnel);
+		l2tp_tunnel_put(tunnel);
 	}
 }
 
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index dcec1de2898e..f4c1da070826 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -177,7 +177,7 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 		goto discard_sess;
 
 	l2tp_recv_common(session, skb, ptr, optr, 0, skb->len);
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 0;
 
@@ -210,7 +210,7 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 	return sk_receive_skb(sk, skb, 1);
 
 discard_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 	goto discard;
 
 discard_put:
@@ -276,7 +276,7 @@ static void l2tp_ip6_destroy_sock(struct sock *sk)
 	tunnel = l2tp_sk_to_tunnel(sk);
 	if (tunnel) {
 		l2tp_tunnel_delete(tunnel);
-		l2tp_tunnel_dec_refcount(tunnel);
+		l2tp_tunnel_put(tunnel);
 	}
 }
 
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 0598b97a0bca..284f1dec1b56 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -63,7 +63,7 @@ static struct l2tp_session *l2tp_nl_session_get(struct genl_info *info)
 		if (tunnel) {
 			session = l2tp_session_get(net, tunnel->sock, tunnel->version,
 						   tunnel_id, session_id);
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_tunnel_put(tunnel);
 		}
 	}
 
@@ -242,7 +242,7 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 	if (ret < 0)
 		goto out;
 
-	l2tp_tunnel_inc_refcount(tunnel);
+	refcount_inc(&tunnel->ref_count);
 	ret = l2tp_tunnel_register(tunnel, net, &cfg);
 	if (ret < 0) {
 		kfree(tunnel);
@@ -250,7 +250,7 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 	}
 	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
 				 L2TP_CMD_TUNNEL_CREATE);
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 out:
 	return ret;
@@ -280,7 +280,7 @@ static int l2tp_nl_cmd_tunnel_delete(struct sk_buff *skb, struct genl_info *info
 
 	l2tp_tunnel_delete(tunnel);
 
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 out:
 	return ret;
@@ -308,7 +308,7 @@ static int l2tp_nl_cmd_tunnel_modify(struct sk_buff *skb, struct genl_info *info
 	ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
 				 tunnel, L2TP_CMD_TUNNEL_MODIFY);
 
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 out:
 	return ret;
@@ -479,12 +479,12 @@ static int l2tp_nl_cmd_tunnel_get(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto err_nlmsg_tunnel;
 
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 
 	return genlmsg_unicast(net, msg, info->snd_portid);
 
 err_nlmsg_tunnel:
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 err_nlmsg:
 	nlmsg_free(msg);
 err:
@@ -511,10 +511,10 @@ static int l2tp_nl_cmd_tunnel_dump(struct sk_buff *skb, struct netlink_callback
 		if (l2tp_nl_tunnel_send(skb, NETLINK_CB(cb->skb).portid,
 					cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					tunnel, L2TP_CMD_TUNNEL_GET) < 0) {
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_tunnel_put(tunnel);
 			goto out;
 		}
-		l2tp_tunnel_dec_refcount(tunnel);
+		l2tp_tunnel_put(tunnel);
 
 		key++;
 	}
@@ -647,12 +647,12 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 		if (session) {
 			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
 						  L2TP_CMD_SESSION_CREATE);
-			l2tp_session_dec_refcount(session);
+			l2tp_session_put(session);
 		}
 	}
 
 out_tunnel:
-	l2tp_tunnel_dec_refcount(tunnel);
+	l2tp_tunnel_put(tunnel);
 out:
 	return ret;
 }
@@ -677,7 +677,7 @@ static int l2tp_nl_cmd_session_delete(struct sk_buff *skb, struct genl_info *inf
 		if (l2tp_nl_cmd_ops[pw_type] && l2tp_nl_cmd_ops[pw_type]->session_delete)
 			l2tp_nl_cmd_ops[pw_type]->session_delete(session);
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 out:
 	return ret;
@@ -713,7 +713,7 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	ret = l2tp_session_notify(&l2tp_nl_family, info,
 				  session, L2TP_CMD_SESSION_MODIFY);
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 out:
 	return ret;
@@ -824,14 +824,14 @@ static int l2tp_nl_cmd_session_get(struct sk_buff *skb, struct genl_info *info)
 
 	ret = genlmsg_unicast(genl_info_net(info), msg, info->snd_portid);
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return ret;
 
 err_ref_msg:
 	nlmsg_free(msg);
 err_ref:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 err:
 	return ret;
 }
@@ -856,7 +856,7 @@ static int l2tp_nl_cmd_session_dump(struct sk_buff *skb, struct netlink_callback
 						tunnel->tunnel_id, &skey);
 		if (!session) {
 			tkey++;
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_tunnel_put(tunnel);
 			tunnel = NULL;
 			skey = 0;
 			continue;
@@ -865,11 +865,11 @@ static int l2tp_nl_cmd_session_dump(struct sk_buff *skb, struct netlink_callback
 		if (l2tp_nl_session_send(skb, NETLINK_CB(cb->skb).portid,
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					 session, L2TP_CMD_SESSION_GET) < 0) {
-			l2tp_session_dec_refcount(session);
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_session_put(session);
+			l2tp_tunnel_put(tunnel);
 			break;
 		}
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 
 		skey++;
 	}
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 8459e5159430..53baf2dd5d5d 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -313,12 +313,12 @@ static int pppol2tp_sendmsg(struct socket *sock, struct msghdr *m,
 	l2tp_xmit_skb(session, skb);
 	local_bh_enable();
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return total_len;
 
 error_put_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 error:
 	return error;
 }
@@ -372,12 +372,12 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	l2tp_xmit_skb(session, skb);
 	local_bh_enable();
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 1;
 
 abort_put_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 abort:
 	/* Free the original skb */
 	kfree_skb(skb);
@@ -413,7 +413,7 @@ static void pppol2tp_session_close(struct l2tp_session *session)
 		sock_put(ps->__sk);
 
 		/* drop ref taken when we referenced socket via sk_user_data */
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 	}
 }
 
@@ -444,7 +444,7 @@ static int pppol2tp_release(struct socket *sock)
 	if (session) {
 		l2tp_session_delete(session);
 		/* drop ref taken by pppol2tp_sock_to_session */
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 	}
 
 	release_sock(sk);
@@ -668,7 +668,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 			if (error < 0)
 				return ERR_PTR(error);
 
-			l2tp_tunnel_inc_refcount(tunnel);
+			refcount_inc(&tunnel->ref_count);
 			error = l2tp_tunnel_register(tunnel, net, &tcfg);
 			if (error < 0) {
 				kfree(tunnel);
@@ -684,7 +684,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 
 		/* Error if socket is not prepped */
 		if (!tunnel->sock) {
-			l2tp_tunnel_dec_refcount(tunnel);
+			l2tp_tunnel_put(tunnel);
 			return ERR_PTR(-ENOENT);
 		}
 	}
@@ -774,13 +774,13 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 
 		pppol2tp_session_init(session);
 		ps = l2tp_session_priv(session);
-		l2tp_session_inc_refcount(session);
+		refcount_inc(&session->ref_count);
 
 		mutex_lock(&ps->sk_lock);
 		error = l2tp_session_register(session, tunnel);
 		if (error < 0) {
 			mutex_unlock(&ps->sk_lock);
-			l2tp_session_dec_refcount(session);
+			l2tp_session_put(session);
 			goto end;
 		}
 
@@ -836,8 +836,8 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 			l2tp_tunnel_delete(tunnel);
 	}
 	if (drop_refcnt)
-		l2tp_session_dec_refcount(session);
-	l2tp_tunnel_dec_refcount(tunnel);
+		l2tp_session_put(session);
+	l2tp_tunnel_put(tunnel);
 	release_sock(sk);
 
 	return error;
@@ -877,7 +877,7 @@ static int pppol2tp_session_create(struct net *net, struct l2tp_tunnel *tunnel,
 	return 0;
 
 err_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 err:
 	return error;
 }
@@ -988,7 +988,7 @@ static int pppol2tp_getname(struct socket *sock, struct sockaddr *uaddr,
 
 	error = len;
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 end:
 	return error;
 }
@@ -1038,12 +1038,12 @@ static int pppol2tp_tunnel_copy_stats(struct pppol2tp_ioc_stats *stats,
 		return -EBADR;
 
 	if (session->pwtype != L2TP_PWTYPE_PPP) {
-		l2tp_session_dec_refcount(session);
+		l2tp_session_put(session);
 		return -EBADR;
 	}
 
 	pppol2tp_copy_stats(stats, &session->stats);
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 
 	return 0;
 }
@@ -1261,7 +1261,7 @@ static int pppol2tp_setsockopt(struct socket *sock, int level, int optname,
 		err = pppol2tp_session_setsockopt(sk, session, optname, val);
 	}
 
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 end:
 	return err;
 }
@@ -1382,7 +1382,7 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	err = 0;
 
 end_put_sess:
-	l2tp_session_dec_refcount(session);
+	l2tp_session_put(session);
 end:
 	return err;
 }
@@ -1407,7 +1407,7 @@ static void pppol2tp_next_tunnel(struct net *net, struct pppol2tp_seq_data *pd)
 {
 	/* Drop reference taken during previous invocation */
 	if (pd->tunnel)
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 
 	for (;;) {
 		pd->tunnel = l2tp_tunnel_get_next(net, &pd->tkey);
@@ -1417,7 +1417,7 @@ static void pppol2tp_next_tunnel(struct net *net, struct pppol2tp_seq_data *pd)
 		if (!pd->tunnel || pd->tunnel->version == 2)
 			return;
 
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 	}
 }
 
@@ -1425,7 +1425,7 @@ static void pppol2tp_next_session(struct net *net, struct pppol2tp_seq_data *pd)
 {
 	/* Drop reference taken during previous invocation */
 	if (pd->session)
-		l2tp_session_dec_refcount(pd->session);
+		l2tp_session_put(pd->session);
 
 	pd->session = l2tp_session_get_next(net, pd->tunnel->sock,
 					    pd->tunnel->version,
@@ -1485,11 +1485,11 @@ static void pppol2tp_seq_stop(struct seq_file *p, void *v)
 	 * or pppol2tp_next_tunnel().
 	 */
 	if (pd->session) {
-		l2tp_session_dec_refcount(pd->session);
+		l2tp_session_put(pd->session);
 		pd->session = NULL;
 	}
 	if (pd->tunnel) {
-		l2tp_tunnel_dec_refcount(pd->tunnel);
+		l2tp_tunnel_put(pd->tunnel);
 		pd->tunnel = NULL;
 	}
 }
-- 
2.34.1


