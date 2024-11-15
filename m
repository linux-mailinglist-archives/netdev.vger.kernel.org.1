Return-Path: <netdev+bounces-145197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70C9CDA9A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64FDB22D6F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F718C004;
	Fri, 15 Nov 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="o5AyskLi"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4018A6C5
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659638; cv=none; b=ikS1pBVwBhQ4qAkdK/iW7JFSgOWQdBE2EqzHtUYDPmga4Ulm9nCGCc+LSUB9YHNFPvjg6txXtCFwh26nVC9PuQaE4wB9dss+8JpTcXFOPzNuVmEHXed9VJf/y15y+k1WRNDepwNuQYNFgnNpcsTvAkmBfJsaoH6BKmEeKMNUxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659638; c=relaxed/simple;
	bh=67TCKEXyzrm3B91IZ3Sjvc95H/FTaazkGlvec1Zj1tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLG198zuLYDZmjjEIqE85SvqzcNetxn6vz8IWQOsjsuuXehpbmu2Op6KYddrEDZRDLPkeEdwawFluvDM0iQ3x/PkxzWRLclq/RdhYzU/EcN2TRK6oCVrPl4oqqVMpiFGojaOS9MJXpmscrbtrinEmjEu2gs11ATLSnJifrZN7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=o5AyskLi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 68C8720861;
	Fri, 15 Nov 2024 09:33:54 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dRbUOyFV1Mka; Fri, 15 Nov 2024 09:33:53 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8731B201A1;
	Fri, 15 Nov 2024 09:33:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8731B201A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731659633;
	bh=Cd0I/1edb4VyrYg9jtQLbwr0/8OEjfHEJ4u9sil1pI0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=o5AyskLiYvlEl1ww77eOwGObYpDWpygopmBB5LeNrVdjKAJ3EcppyKp/HHgAv0PRv
	 m/TqvzGD1zsYZGqjkzi83+AhAdEZY8/hywEYLQMMLwgJ3/ZLjiPOt55CK6l6W0a/Dt
	 xIFzQyRR9bCgCA/TAH0Fdb8gkYa3aWSVZyvpjbI93MK78VST05S72UbjXdv4XUAkUR
	 La6SouyL4iURip6HrK6PXVQlL+ynvh7eVNCe1HZRbRqJiH9ntXcbJ5x/snd+BMB3Sb
	 oeNL7rRYawmbf3xd44ULGAmco9HUu4emjFI7CSIvl/kM2hQjXwjZ+nW6uJRznmjsl9
	 /T5HPJa4zVT0g==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:33:53 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:33:53 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B4C8631843F8; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/11] xfrm: Add an inbound percpu state cache.
Date: Fri, 15 Nov 2024 09:33:35 +0100
Message-ID: <20241115083343.2340827-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115083343.2340827-1-steffen.klassert@secunet.com>
References: <20241115083343.2340827-1-steffen.klassert@secunet.com>
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
Tested-by: Antony Antony <antony.antony@secunet.com>
Tested-by: Tobias Brunner <tobias@strongswan.org>
---
 include/net/netns/xfrm.h |  1 +
 include/net/xfrm.h       |  5 ++++
 net/ipv4/esp4_offload.c  |  6 ++---
 net/ipv6/esp6_offload.c  |  6 ++---
 net/xfrm/xfrm_input.c    |  2 +-
 net/xfrm/xfrm_state.c    | 57 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index ae60d6664095..23dd647fe024 100644
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
index 0b394c5fb5f3..2b87999bd5aa 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -185,6 +185,7 @@ struct xfrm_state {
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
 	struct hlist_node	state_cache;
+	struct hlist_node	state_cache_input;
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
@@ -1650,6 +1651,10 @@ int xfrm_state_update(struct xfrm_state *x);
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


