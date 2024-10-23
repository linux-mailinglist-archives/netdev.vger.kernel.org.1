Return-Path: <netdev+bounces-138180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496AD9AC846
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BB51C20DDD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295C11A4F22;
	Wed, 23 Oct 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AO5CodWH"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DA55896
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680842; cv=none; b=o3UEB5ptpikrHlEvCPKMnMn/tLzpfhWaEMSNykVaWn8gGpgCkMFjNbi1H8YUxHd8SmUT8BMfhIWQ04eIaSOpFgQsvGsvTqT/00/phQzsDacP2lK3UNVoha7E4sLVG5RF5UBvbrr+aOGAAyhK+RntzSi0h+4fdFL+f/Wk8sZJqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680842; c=relaxed/simple;
	bh=cpoX40IbbeLwIC9wg+kztKG9JS1jEJ/19ItkCjaN8ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljbvMqMoNYo0Ek/Ef1HVhG83UwY8iFmg+bG44vKfbdjJTsCtswGecgTacaaD9JF4enhkuzLjQRgNtMBaSiZEMDR9O/XX3NAj0oSH8tK2plKem0khvdJXmEffstLdEbDq9/EywYkFjm09+3Ah2yxThnRKPXP+P+XtCErKFZaBpKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AO5CodWH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3B985207CA;
	Wed, 23 Oct 2024 12:53:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V2FuOwNbKm-8; Wed, 23 Oct 2024 12:53:51 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6639B201E5;
	Wed, 23 Oct 2024 12:53:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6639B201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729680831;
	bh=Oag9hT3JqXn6OKuT6RcUCMlwJzNFkKqDVK/MhrCQ3g0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=AO5CodWH7XJxBFRe6fPJ0ET89TX/Xc0J+dq4bVcx19yUErqsI5GMfzbGX+oJjrv0O
	 FYWiOtWYQG90YjccvPSaayoGAxojwwP037gYTjxPIPr8DcJNCSa8Y50xiUYMrAlDHK
	 J9ELh4o7y8LHpcq6ZXcecJwSbyCnzS/BeTATy/zxNdlQqN0hWjCJJxk+zQOS0rVOM0
	 LRyG0hSt3RZ8du8gR3W/R0178UKdDnXnq2fxf1gVNDi4X4pC4NaVHH+V5H/mcvSgO+
	 U71YIW3kvxM5id7IZkbdECOgYyJQUpaxx9q1CBslX1a2gKXQJ0DqYpFEzQRgYUqfOM
	 AJKI2TCnUUHeg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 12:53:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:53:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C461C3184D3B; Wed, 23 Oct 2024 12:53:50 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>
CC: Steffen Klassert <steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<devel@linux-ipsec.org>
Subject: [PATCH v3 ipsec-next 2/4] xfrm: Cache used outbound xfrm states at the policy.
Date: Wed, 23 Oct 2024 12:53:43 +0200
Message-ID: <20241023105345.1376856-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023105345.1376856-1-steffen.klassert@secunet.com>
References: <20241023105345.1376856-1-steffen.klassert@secunet.com>
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
 include/net/xfrm.h     |  4 +++
 net/xfrm/xfrm_policy.c | 12 +++++++++
 net/xfrm/xfrm_state.c  | 55 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e23ad52824e2..0710efb8c143 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -184,6 +184,7 @@ struct xfrm_state {
 	};
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
+	struct hlist_node	state_cache;
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
@@ -532,6 +533,7 @@ struct xfrm_policy_queue {
  *	@xp_net: network namespace the policy lives in
  *	@bydst: hlist node for SPD hash table or rbtree list
  *	@byidx: hlist node for index hash table
+ *	@state_cache_list: hlist head for policy cached xfrm states
  *	@lock: serialize changes to policy structure members
  *	@refcnt: reference count, freed once it reaches 0
  *	@pos: kernel internal tie-breaker to determine age of policy
@@ -562,6 +564,8 @@ struct xfrm_policy {
 	struct hlist_node	bydst;
 	struct hlist_node	byidx;
 
+	struct hlist_head	state_cache_list;
+
 	/* This lock only affects elements except for entry. */
 	rwlock_t		lock;
 	refcount_t		refcnt;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 914bac03b52a..82d1e0b9be70 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -413,6 +413,7 @@ struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp)
 	if (policy) {
 		write_pnet(&policy->xp_net, net);
 		INIT_LIST_HEAD(&policy->walk.all);
+		INIT_HLIST_HEAD(&policy->state_cache_list);
 		INIT_HLIST_NODE(&policy->bydst);
 		INIT_HLIST_NODE(&policy->byidx);
 		rwlock_init(&policy->lock);
@@ -454,6 +455,9 @@ EXPORT_SYMBOL(xfrm_policy_destroy);
 
 static void xfrm_policy_kill(struct xfrm_policy *policy)
 {
+	struct net *net = xp_net(policy);
+	struct xfrm_state *x;
+
 	xfrm_dev_policy_delete(policy);
 
 	write_lock_bh(&policy->lock);
@@ -469,6 +473,13 @@ static void xfrm_policy_kill(struct xfrm_policy *policy)
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
 
@@ -3249,6 +3260,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 		dst_release(dst);
 		dst = dst_orig;
 	}
+
 ok:
 	xfrm_pols_put(pols, drop_pols);
 	if (dst && dst->xfrm &&
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ebef07b80afa..a2047825f6c8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -665,6 +665,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		refcount_set(&x->refcnt, 1);
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->km.all);
+		INIT_HLIST_NODE(&x->state_cache);
 		INIT_HLIST_NODE(&x->bydst);
 		INIT_HLIST_NODE(&x->bysrc);
 		INIT_HLIST_NODE(&x->byspi);
@@ -744,12 +745,15 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
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
@@ -1222,6 +1226,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	unsigned int sequence;
 	struct km_event c;
 	unsigned int pcpu_id;
+	bool cached = false;
 
 	/* We need the cpu id just as a lookup key,
 	 * we don't require it to be stable.
@@ -1234,6 +1239,46 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
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
+	cached = true;
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
@@ -1383,6 +1428,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			XFRM_STATE_INSERT(bysrc, &x->bysrc,
 					  net->xfrm.state_bysrc + h,
 					  x->xso.type);
+			INIT_HLIST_NODE(&x->state_cache);
 			if (x->id.spi) {
 				h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
 				XFRM_STATE_INSERT(byspi, &x->byspi,
@@ -1431,6 +1477,15 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
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


