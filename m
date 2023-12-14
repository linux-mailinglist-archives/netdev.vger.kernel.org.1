Return-Path: <netdev+bounces-57349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA773812EB5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295921C20956
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0593FE5B;
	Thu, 14 Dec 2023 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="A6seMXsI"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22255118
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:36:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2785820891;
	Thu, 14 Dec 2023 12:36:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrFG9lPvB4Jl; Thu, 14 Dec 2023 12:36:56 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6D87B20882;
	Thu, 14 Dec 2023 12:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6D87B20882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1702553816;
	bh=kAA2KuQ4TXzVcspwzJ9tPkpQGc/eJx99OOgT3/xpf0c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=A6seMXsIL/ljNoSs20efaP+gv3QAjdW3fTc+qHlnj7PrKA2dvCeyXPef0BUQ7d3Js
	 GC6qKtiSPd+CuI+X7TDJygkCtabz+WgoDlt/Dwon4ZDPnXKZmV84p40PpM9NDHXsBd
	 W8HzYa+Wh1clnJ7i59jA2QIFdYtgy7EBHCqs00TE0t2aofY6OdPmwCB2Cn+8nCgh8a
	 7jWAc8V0EuzABI3ZIc9qLm4BJm2yWXgYUjyXpU/Qx9CezI/29FpD6r5M3HTlx++2+j
	 L3U8oAApGU92/JVSw8dLi4sRfydL86q9642d/dPRJhmiocsUAVf9GAnnIcM4jJ79Sr
	 zJCEOMBBnk9uA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 603AA80004A;
	Thu, 14 Dec 2023 12:36:56 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 12:36:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 12:36:55 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7744931807DA; Thu, 14 Dec 2023 12:36:55 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH RFC ipsec-next 2/3] xfrm: Cache used outbound xfrm states at the policy.
Date: Thu, 14 Dec 2023 12:36:44 +0100
Message-ID: <20231214113645.2416005-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214113645.2416005-1-steffen.klassert@secunet.com>
References: <20231214113645.2416005-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Now that we can have percpu xfrm states, the number of active
states might increase. To get a better lookup performance,
we cache the used xfrm states at the policy for outbound
IPsec traffic.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     |  3 +++
 net/xfrm/xfrm_policy.c | 12 ++++++++++
 net/xfrm/xfrm_state.c  | 54 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 8c5ea1802fda..5c4d67d0a4de 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -179,6 +179,7 @@ struct xfrm_state {
 	struct hlist_node	bysrc;
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
+	struct hlist_node	state_cache;
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
@@ -522,6 +523,8 @@ struct xfrm_policy {
 	struct hlist_node	bydst;
 	struct hlist_node	byidx;
 
+	struct hlist_head	state_cache_list;
+
 	/* This lock only affects elements except for entry. */
 	rwlock_t		lock;
 	refcount_t		refcnt;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c13dc3ef7910..4f0b2892195b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -409,6 +409,7 @@ struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp)
 	if (policy) {
 		write_pnet(&policy->xp_net, net);
 		INIT_LIST_HEAD(&policy->walk.all);
+		INIT_HLIST_HEAD(&policy->state_cache_list);
 		INIT_HLIST_NODE(&policy->bydst_inexact_list);
 		INIT_HLIST_NODE(&policy->bydst);
 		INIT_HLIST_NODE(&policy->byidx);
@@ -451,6 +452,9 @@ EXPORT_SYMBOL(xfrm_policy_destroy);
 
 static void xfrm_policy_kill(struct xfrm_policy *policy)
 {
+	struct net *net = xp_net(policy);
+	struct xfrm_state *x;
+
 	write_lock_bh(&policy->lock);
 	policy->walk.dead = 1;
 	write_unlock_bh(&policy->lock);
@@ -464,6 +468,13 @@ static void xfrm_policy_kill(struct xfrm_policy *policy)
 	if (del_timer(&policy->timer))
 		xfrm_pol_put(policy);
 
+	/* XXX: Flush state cache */
+	spin_lock_bh(&net->xfrm.xfrm_state_lock);
+	hlist_for_each_entry_rcu(x, &policy->state_cache_list, state_cache) {
+		hlist_del_init_rcu(&x->state_cache);
+	}
+	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+
 	xfrm_pol_put(policy);
 }
 
@@ -3250,6 +3261,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 		dst_release(dst);
 		dst = dst_orig;
 	}
+
 ok:
 	xfrm_pols_put(pols, drop_pols);
 	if (dst && dst->xfrm &&
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index b5caac4678f7..416d08f15568 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -663,6 +663,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		refcount_set(&x->refcnt, 1);
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->km.all);
+		INIT_HLIST_NODE(&x->state_cache);
 		INIT_HLIST_NODE(&x->bydst);
 		INIT_HLIST_NODE(&x->bysrc);
 		INIT_HLIST_NODE(&x->byspi);
@@ -707,12 +708,15 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 	if (x->km.state != XFRM_STATE_DEAD) {
 		x->km.state = XFRM_STATE_DEAD;
+
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		list_del(&x->km.all);
 		hlist_del_rcu(&x->bydst);
 		hlist_del_rcu(&x->bysrc);
 		if (x->km.seq)
 			hlist_del_rcu(&x->byseq);
+		if (!hlist_unhashed(&x->state_cache))
+			hlist_del_rcu(&x->state_cache);
 		if (x->id.spi)
 			hlist_del_rcu(&x->byspi);
 		net->xfrm.state_num--;
@@ -1160,6 +1164,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	unsigned short encap_family = tmpl->encap_family;
 	unsigned int sequence;
 	struct km_event c;
+	bool cached = false;
 	unsigned int pcpu_id = get_cpu();
 	put_cpu();
 
@@ -1168,6 +1173,45 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
 
 	rcu_read_lock();
+	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
+		if (x->props.family == encap_family &&
+		    x->props.reqid == tmpl->reqid &&
+		    (mark & x->mark.m) == x->mark.v &&
+		    x->if_id == if_id &&
+		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
+		    xfrm_state_addr_check(x, daddr, saddr, encap_family) &&
+		    tmpl->mode == x->props.mode &&
+		    tmpl->id.proto == x->id.proto &&
+		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
+			xfrm_state_look_at(pol, x, fl, encap_family,
+					   &best, &acquire_in_progress, &error);
+	}
+
+	if (best)
+		goto cached;
+
+	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
+		if (x->props.family == encap_family &&
+		    x->props.reqid == tmpl->reqid &&
+		    (mark & x->mark.m) == x->mark.v &&
+		    x->if_id == if_id &&
+		    !(x->props.flags & XFRM_STATE_WILDRECV) &&
+		    xfrm_addr_equal(&x->id.daddr, daddr, encap_family) &&
+		    tmpl->mode == x->props.mode &&
+		    tmpl->id.proto == x->id.proto &&
+		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
+			xfrm_state_look_at(pol, x, fl, family,
+					   &best, &acquire_in_progress, &error);
+	}
+
+cached:
+	if (best)
+		goto found;
+	else if (error)
+		best = NULL;
+	else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
+		WARN_ON(1);
+
 	h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
 	hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1317,6 +1361,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			XFRM_STATE_INSERT(bysrc, &x->bysrc,
 					  net->xfrm.state_bysrc + h,
 					  x->xso.type);
+			INIT_HLIST_NODE(&x->state_cache);
 			if (x->id.spi) {
 				h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
 				XFRM_STATE_INSERT(byspi, &x->byspi,
@@ -1363,6 +1408,15 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	} else {
 		*err = acquire_in_progress ? -EAGAIN : error;
 	}
+
+	if (x && x->km.state == XFRM_STATE_VALID && !cached &&
+	    (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) || x->pcpu_num == pcpu_id)) {
+		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		if (hlist_unhashed(&x->state_cache))
+			hlist_add_head_rcu(&x->state_cache, &pol->state_cache_list);
+		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	}
+
 	rcu_read_unlock();
 	if (to_put)
 		xfrm_state_put(to_put);
-- 
2.34.1


