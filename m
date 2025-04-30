Return-Path: <netdev+bounces-187061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E238EAA4B9F
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E384174417
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627A25DAFC;
	Wed, 30 Apr 2025 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8rWvpeE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZHO91E7M"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D225D210
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017297; cv=none; b=YsA8NSOvFGjvYdI2jz+/4Qy8EqRWlneqRNDHOYxybTLH3AsOzhYxOdxiKapFEuPWIlyjvvm1RoCte0l6DEpgXIoKhyNLPDKyQRxnOIOhFMPkxLH9P+EuDZOd5wtAouDFho2seHIIOUdOshQ0aDTtCYAww9JI3OumJ7V20+WlEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017297; c=relaxed/simple;
	bh=gRe4ZPspDFZzJR8N21uXnucIe/m0pvA34gLSPLKsV4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE32ABfcObVNV6sGc0mE0va2o51ZmTEEp3Sa3P6iCt1N2zURUrP0ktK8cb/a3O7O9YtehWS8OWv/YE+/6cUlkUCInSPNFNKp4LNJ3SaaBV9hzy/I8qLLcyxqRY7iZeQpWU1M7LtY3TBIPuKFuI6Qipk6BYjhRMccUE0nK5Y+Btc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8rWvpeE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZHO91E7M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGtQbz+ZEHxLVxMaYQs85cIy9ohsQuf970dsrW8/7TU=;
	b=U8rWvpeE5IWkEPQlNO5Vy0WFx735Kz4NOxt+tvWUmG+ZzadcUXHIv2kNt1ng8xu9WAIers
	QXe9p0+Z5RDCeK+IZyhCgoBs/ep1eitOCSmUN6B4om9w+qeg8MDcK13JQ3jlK6mZ7d3I0F
	rwsR2bvUc8gHr1Za801AtVEu4y4RJOffXuJDptCqwXEv0UqPbYiBWg7sDCZ2eBK87nK8yM
	jbpjme+QhGxp0DZHPgrlQVltYEgz0oy3XRttD8OSlay8Tt25kVYqoaTMnk7oLPoFno5LJe
	YwX6KIgx9hLZ1BRLfXjrOdg81ZELCp+1gEC0diQ3yPLn7B4HOCIoH8f30ZZaOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGtQbz+ZEHxLVxMaYQs85cIy9ohsQuf970dsrW8/7TU=;
	b=ZHO91E7MQbuwoON2NBzW11/t6IWMrIzvF4JeRcBj5STDgJBmEtIpCqs0LIBOgBZwOFGaiL
	XERb7NQ5i1PfJ4Dw==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for system_page_pool
Date: Wed, 30 Apr 2025 14:47:45 +0200
Message-ID: <20250430124758.1159480-6-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

system_page_pool is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Make a struct with a page_pool member (original system_page_pool) and a
local_lock_t and use local_lock_nested_bh() for locking. This change
adds only lockdep coverage and does not alter the functional behaviour
for !PREEMPT_RT.

Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |  7 ++++++-
 net/core/dev.c            | 15 ++++++++++-----
 net/core/xdp.c            | 11 +++++++++--
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2d11d013cabed..2018e2432cb56 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3502,7 +3502,12 @@ struct softnet_data {
 };
=20
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
-DECLARE_PER_CPU(struct page_pool *, system_page_pool);
+
+struct page_pool_bh {
+	struct page_pool *pool;
+	local_lock_t bh_lock;
+};
+DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
=20
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
diff --git a/net/core/dev.c b/net/core/dev.c
index 1be7cb73a6024..b56becd070bc7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
  * PP consumers must pay attention to run APIs in the appropriate context
  * (e.g. NAPI context).
  */
-DEFINE_PER_CPU(struct page_pool *, system_page_pool);
+DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 #ifdef CONFIG_LOCKDEP
 /*
@@ -5238,7 +5240,10 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, const=
 struct bpf_prog *prog)
 	struct sk_buff *skb =3D *pskb;
 	int err, hroom, troom;
=20
-	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, prog))
+	local_lock_nested_bh(&system_page_pool.bh_lock);
+	err =3D skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, =
prog);
+	local_unlock_nested_bh(&system_page_pool.bh_lock);
+	if (!err)
 		return 0;
=20
 	/* In case we have to go down the path and also linearize,
@@ -12629,7 +12634,7 @@ static int net_page_pool_create(int cpuid)
 		return err;
 	}
=20
-	per_cpu(system_page_pool, cpuid) =3D pp_ptr;
+	per_cpu(system_page_pool.pool, cpuid) =3D pp_ptr;
 #endif
 	return 0;
 }
@@ -12759,13 +12764,13 @@ static int __init net_dev_init(void)
 		for_each_possible_cpu(i) {
 			struct page_pool *pp_ptr;
=20
-			pp_ptr =3D per_cpu(system_page_pool, i);
+			pp_ptr =3D per_cpu(system_page_pool.pool, i);
 			if (!pp_ptr)
 				continue;
=20
 			xdp_unreg_page_pool(pp_ptr);
 			page_pool_destroy(pp_ptr);
-			per_cpu(system_page_pool, i) =3D NULL;
+			per_cpu(system_page_pool.pool, i) =3D NULL;
 		}
 	}
=20
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a7..b2a5c934fe7b7 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -737,10 +737,10 @@ static noinline bool xdp_copy_frags_from_zc(struct sk=
_buff *skb,
  */
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 {
-	struct page_pool *pp =3D this_cpu_read(system_page_pool);
 	const struct xdp_rxq_info *rxq =3D xdp->rxq;
 	u32 len =3D xdp->data_end - xdp->data_meta;
 	u32 truesize =3D xdp->frame_sz;
+	struct page_pool *pp;
 	struct sk_buff *skb;
 	int metalen;
 	void *data;
@@ -748,13 +748,18 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
 	if (!IS_ENABLED(CONFIG_PAGE_POOL))
 		return NULL;
=20
+	local_lock_nested_bh(&system_page_pool.bh_lock);
+	pp =3D this_cpu_read(system_page_pool.pool);
 	data =3D page_pool_dev_alloc_va(pp, &truesize);
-	if (unlikely(!data))
+	if (unlikely(!data)) {
+		local_unlock_nested_bh(&system_page_pool.bh_lock);
 		return NULL;
+	}
=20
 	skb =3D napi_build_skb(data, truesize);
 	if (unlikely(!skb)) {
 		page_pool_free_va(pp, data, true);
+		local_unlock_nested_bh(&system_page_pool.bh_lock);
 		return NULL;
 	}
=20
@@ -773,9 +778,11 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff =
*xdp)
=20
 	if (unlikely(xdp_buff_has_frags(xdp)) &&
 	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
+		local_unlock_nested_bh(&system_page_pool.bh_lock);
 		napi_consume_skb(skb, true);
 		return NULL;
 	}
+	local_unlock_nested_bh(&system_page_pool.bh_lock);
=20
 	xsk_buff_free(xdp);
=20
--=20
2.49.0


