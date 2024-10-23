Return-Path: <netdev+bounces-138181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5323A9AC847
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B823F281660
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B21A7ADD;
	Wed, 23 Oct 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="w2j+6baJ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23551A2C32
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680842; cv=none; b=TrB+HmOPbr8wXfjVhRdliSJ6HAjQALlu0H4VCWEZ1tsBoUhZwKAfvp4Lp2oo/AIh844njCAWOOwrtTAsUrS+1hL9DHZravFlnuRWtXyK8/FlLq05OFnu5nVJEnTBamm102j0Jr6hAz3EFRKcOdjdesdq6xZow/Clp8viFSHxN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680842; c=relaxed/simple;
	bh=/PrQvjIG2QoF3ppPcee53y6F/dKD2f+aSEl8YvEO+qE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGwfnfvKTC76aIv0UCnZfmj9b4s9obziU8yIQv0cSv+558FlbPvQjHRlA+8PEbWih9RIEojsV/TCPuo1w+LDHd91/nQ3j8M2QS+yKlmLyuP4UYzyN8tnhOltuYE2fPwDPpW4f+WcGS8GAw16SNWPsMPThASZP95jW5xcF14hfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=w2j+6baJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B862E20851;
	Wed, 23 Oct 2024 12:53:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MpjvSKXZFXo9; Wed, 23 Oct 2024 12:53:52 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A98B8207D8;
	Wed, 23 Oct 2024 12:53:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A98B8207D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729680831;
	bh=QYvGCHvIchh/8KWWRAZFd3CllSqLWhFosN/CcjWudjs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=w2j+6baJmkiOUfpQFVKH4n4wzVbP4PnnmUgq/JciLE8W3df6u0/mpFGRO9R4QNdUt
	 AUMPXdmW2cwmoC9CWPXrHSPxV4CjYqW950nVQqf72/1QlJDyf/H1G7HV++bo2xj6Pc
	 GhhhM1SPONET7wCWFLjB49WE7ck37Bqf1xGtGR7efPUx7x2pkw/9rDlzSnYZXPgFiY
	 Gqzc4c+nbx+r6/W9GaqsSvBP32oXesekcvtq7lU0HQAy119Z7x0bjHaZtt+ooU2LD4
	 8ZkOORuQwdxtq1Y9HZxzDHU+YWeIyeEYFLrbQHRe+PYDGmKQln8ubwqpWlNjgbPkpA
	 mE7EHaGNx3HvA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 12:53:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:53:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CA0053184D54; Wed, 23 Oct 2024 12:53:50 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>
CC: Steffen Klassert <steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<devel@linux-ipsec.org>
Subject: [PATCH v3 ipsec-next 3/4] xfrm: Add an inbound percpu state cache.
Date: Wed, 23 Oct 2024 12:53:44 +0200
Message-ID: <20241023105345.1376856-4-steffen.klassert@secunet.com>
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
we add a percpu cache to cache the used inbound xfrm states.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/netns/xfrm.h |  1 +
 include/net/xfrm.h       |  5 ++++
 net/ipv4/esp4_offload.c  |  6 ++---
 net/ipv6/esp6_offload.c  |  6 ++---
 net/xfrm/xfrm_input.c    |  2 +-
 net/xfrm/xfrm_state.c    | 57 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index d489d9250bff..4e0702598d52 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -43,6 +43,7 @@ struct netns_xfrm {
 	struct hlist_head	__rcu *state_bysrc;
 	struct hlist_head	__rcu *state_byspi;
 	struct hlist_head	__rcu *state_byseq;
+	struct hlist_head	 __percpu *state_cache_input;
 	unsigned int		state_hmask;
 	unsigned int		state_num;
 	struct work_struct	state_hash_work;
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0710efb8c143..ecc35536853e 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -185,6 +185,7 @@ struct xfrm_state {
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
 	struct hlist_node	state_cache;
+	struct hlist_node	state_cache_input;
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
@@ -1645,6 +1646,10 @@ int xfrm_state_update(struct xfrm_state *x);
 struct xfrm_state *xfrm_state_lookup(struct net *net, u32 mark,
 				     const xfrm_address_t *daddr, __be32 spi,
 				     u8 proto, unsigned short family);
+struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
+					   const xfrm_address_t *daddr,
+					   __be32 spi, u8 proto,
+					   unsigned short family);
 struct xfrm_state *xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 					    const xfrm_address_t *daddr,
 					    const xfrm_address_t *saddr,
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 80c4ea0e12f4..e0d94270da28 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -53,9 +53,9 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 		if (sp->len == XFRM_MAX_DEPTH)
 			goto out_reset;
 
-		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
-				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
-				      spi, IPPROTO_ESP, AF_INET);
+		x = xfrm_input_state_lookup(dev_net(skb->dev), skb->mark,
+					    (xfrm_address_t *)&ip_hdr(skb)->daddr,
+					    spi, IPPROTO_ESP, AF_INET);
 
 		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
 			/* non-offload path will record the error and audit log */
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 919ebfabbe4e..7b41fb4f00b5 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -80,9 +80,9 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		if (sp->len == XFRM_MAX_DEPTH)
 			goto out_reset;
 
-		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
-				      (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
-				      spi, IPPROTO_ESP, AF_INET6);
+		x = xfrm_input_state_lookup(dev_net(skb->dev), skb->mark,
+					    (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
+					    spi, IPPROTO_ESP, AF_INET6);
 
 		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
 			/* non-offload path will record the error and audit log */
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 749e7eea99e4..841a60a6fbfe 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -572,7 +572,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-		x = xfrm_state_lookup(net, mark, daddr, spi, nexthdr, family);
+		x = xfrm_input_state_lookup(net, mark, daddr, spi, nexthdr, family);
 		if (x == NULL) {
 			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index a2047825f6c8..e3266a5d4f90 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -754,6 +754,9 @@ int __xfrm_state_delete(struct xfrm_state *x)
 			hlist_del_rcu(&x->byseq);
 		if (!hlist_unhashed(&x->state_cache))
 			hlist_del_rcu(&x->state_cache);
+		if (!hlist_unhashed(&x->state_cache_input))
+			hlist_del_rcu(&x->state_cache_input);
+
 		if (x->id.spi)
 			hlist_del_rcu(&x->byspi);
 		net->xfrm.state_num--;
@@ -1106,6 +1109,52 @@ static struct xfrm_state *__xfrm_state_lookup(struct net *net, u32 mark,
 	return NULL;
 }
 
+struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
+					   const xfrm_address_t *daddr,
+					   __be32 spi, u8 proto,
+					   unsigned short family)
+{
+	struct hlist_head *state_cache_input;
+	struct xfrm_state *x = NULL;
+	int cpu = get_cpu();
+
+	state_cache_input =  per_cpu_ptr(net->xfrm.state_cache_input, cpu);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(x, state_cache_input, state_cache_input) {
+		if (x->props.family != family ||
+		    x->id.spi       != spi ||
+		    x->id.proto     != proto ||
+		    !xfrm_addr_equal(&x->id.daddr, daddr, family))
+			continue;
+
+		if ((mark & x->mark.m) != x->mark.v)
+			continue;
+		if (!xfrm_state_hold_rcu(x))
+			continue;
+		goto out;
+	}
+
+	x = __xfrm_state_lookup(net, mark, daddr, spi, proto, family);
+
+	if (x && x->km.state == XFRM_STATE_VALID) {
+		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		if (hlist_unhashed(&x->state_cache_input)) {
+			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
+		} else {
+			hlist_del_rcu(&x->state_cache_input);
+			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
+		}
+		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	}
+
+out:
+	rcu_read_unlock();
+	put_cpu();
+	return x;
+}
+EXPORT_SYMBOL(xfrm_input_state_lookup);
+
 static struct xfrm_state *__xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 						     const xfrm_address_t *daddr,
 						     const xfrm_address_t *saddr,
@@ -3079,6 +3128,11 @@ int __net_init xfrm_state_init(struct net *net)
 	net->xfrm.state_byseq = xfrm_hash_alloc(sz);
 	if (!net->xfrm.state_byseq)
 		goto out_byseq;
+
+	net->xfrm.state_cache_input = alloc_percpu(struct hlist_head);
+	if (!net->xfrm.state_cache_input)
+		goto out_state_cache_input;
+
 	net->xfrm.state_hmask = ((sz / sizeof(struct hlist_head)) - 1);
 
 	net->xfrm.state_num = 0;
@@ -3088,6 +3142,8 @@ int __net_init xfrm_state_init(struct net *net)
 			       &net->xfrm.xfrm_state_lock);
 	return 0;
 
+out_state_cache_input:
+	xfrm_hash_free(net->xfrm.state_byseq, sz);
 out_byseq:
 	xfrm_hash_free(net->xfrm.state_byspi, sz);
 out_byspi:
@@ -3117,6 +3173,7 @@ void xfrm_state_fini(struct net *net)
 	xfrm_hash_free(net->xfrm.state_bysrc, sz);
 	WARN_ON(!hlist_empty(net->xfrm.state_bydst));
 	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	free_percpu(net->xfrm.state_cache_input);
 }
 
 #ifdef CONFIG_AUDITSYSCALL
-- 
2.34.1


