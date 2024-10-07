Return-Path: <netdev+bounces-132594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F67F992523
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB87A1F225CC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C676161326;
	Mon,  7 Oct 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jwWddMzg"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B61A15A858
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284046; cv=none; b=qDU2ZGWS/fnwyY+CE9dPmvD577oKtn6Krx46jxq2wOx0S690XuyKcLbmuayNR/9OMtpyd3vA1uROwLuWhPZ/Zf4h0Wi5Z5rcjhMxlRJ3rcGUFI+8/QRoAtdkgZB6aIb1FA6jJmtIfVdqE96qK+BEoPsghpSLqKCIaiIsusqneSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284046; c=relaxed/simple;
	bh=B51ncSr2pUtKRZT6dx7Tv2HVtc/Dw9XGVV6bvvRrMq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXDl+UA7Ubbx9MR03vq8snpdm9arLZCGtBtyT0dZwuQ8sO0xbLcyFmdpaAcSNP+mfkoxuOfeb1oJbtbeJMBykx2sZ8qwK3xRn4XI61cmEdwUZak7nRd++xm3wPmvCgqbyuyFkPMxgo5PZltND/v4IC5NqefEk5iczadoBcA5Boc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jwWddMzg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0B83A207B3;
	Mon,  7 Oct 2024 08:45:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxKOpnRW-paS; Mon,  7 Oct 2024 08:45:18 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EE3592074F;
	Mon,  7 Oct 2024 08:45:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EE3592074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728283518;
	bh=mNacLmCXx4Nt8TZ02HBSDY6sUq0FshP3LKsY3Ir+l7g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=jwWddMzgCIh0+nRXyzxhekSImVNuBdJTGSaqg/Lay5XCW3oee+6gj4PTCu5OJBiQ1
	 ENclSbkImYpSiQ8rExFmIaFxUZhbkIFFQuc80W4+e0SAnoHDXYmJ6aWdl33X/JAXzK
	 OYzlkizCc7IMmPdrL+ndsuEmWI3LH+HOnsYAA38MznXIWg5K5swBxJJSuRX/BbzJgI
	 FsUg8OuXHQ+ADlT1sz4XJ3b+7h/bwbkppgYHLV1m/qQq0Qxoz4V8FzyCdJyd5u7Snu
	 Flsryyy37mu6fV6uQZgOlwSprTBib348FEPoMHIOuubIO7r1r7DopE3l/bQPAjLgcG
	 c25uiEg5VjgTQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 08:45:17 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 08:45:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4567B31807AD; Mon,  7 Oct 2024 08:45:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, <netdev@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, <devel@linux-ipsec.org>
Subject: [PATCH 2/4] xfrm: Cache used outbound xfrm states at the policy.
Date: Mon, 7 Oct 2024 08:44:51 +0200
Message-ID: <20241007064453.2171933-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007064453.2171933-1-steffen.klassert@secunet.com>
References: <20241007064453.2171933-1-steffen.klassert@secunet.com>
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
 net/xfrm/xfrm_policy.c | 12 +++++++++
 net/xfrm/xfrm_state.c  | 55 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e23ad52824e2..17e5edc58b89 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -184,6 +184,7 @@ struct xfrm_state {
 	};
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
+	struct hlist_node	state_cache;
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
@@ -562,6 +563,8 @@ struct xfrm_policy {
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


