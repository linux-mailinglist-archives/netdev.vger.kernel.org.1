Return-Path: <netdev+bounces-99129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038B48D3C75
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269B61C22922
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E719066E;
	Wed, 29 May 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWA0jw6h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QEiQ7ZrZ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1070184118;
	Wed, 29 May 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000177; cv=none; b=q8WVrqvaZumwJiTEvvNoCzgGs3+A2ttYhjTBxcJdJS9y6XLtdLCj228qVZl7g0KgPPCBQIRefw+MK80nZW5PBrt165p+QAfKjRW5qpspNoQ6pDzNipGfxhlPjTRkKbhjGk+Tu4lr/QVGUHXGGeSwIKLV1SV5+8v1xapIQtb/avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000177; c=relaxed/simple;
	bh=zNMqpxBAGQiw9OcL50vy3QVIxWZ4GXc8Kaab9zYXR04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV1oIC6y0RDLmfjlaCwcXyLdQ0Ri746KScTr7nSvUppUD/vK3gwe4FnKQ5tOieMclCouwId0xp+YoZfiqr6i3ZZ+NMQWXWqSyLQs+/qXuquANIWtm0x/Dpkd91LCl++VHeDSKwUNQZVRVpqE+GUBN1JEWfcoCgFuarXTyjrcgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AWA0jw6h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QEiQ7ZrZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717000174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1G2V1ldZthL2oayfOZavDOAUvExZwG7aIqHHf24zyo=;
	b=AWA0jw6hawcnAaXO2VmdzyVirF6lxRwzG2Pyp+n3sdB4Zw+J/OWQlgj7b+E6lWC4gGVeE5
	xzGa6vVYBsmtw5fdY/ErG1kQIQfV2W8W2TSVjXeXO367BWTfNT5p6GeOCeo69JSfL0UXsk
	aMcjbsBKvNzLYSmw/b/I04xLCEv5VzfUce55gA1GGJ8ZJqd7GV6MWfltfPehnCnm0gkO4d
	rflwldxs5Z2DdenTZ7S829K/ksCMLato+mdWocjfPCB3Kk2bshCWu6Vh0l1R8UCsJcHpxn
	b0/0r/Ls9l8IMPnizCpfB89OXNf0HYPiPkftIIX2H4G7hDznWkQbVhALxU/kVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717000174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1G2V1ldZthL2oayfOZavDOAUvExZwG7aIqHHf24zyo=;
	b=QEiQ7ZrZLRUyR4unTdi6ewS+GqCBw9zfAvk0Ja6J2U14eyL8tI7R8H1IaO9vlbQ0LjlyaK
	dBOiUL8pWVvkGQBA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 net-next 04/15] net: Use nested-BH locking for napi_alloc_cache.
Date: Wed, 29 May 2024 18:02:27 +0200
Message-ID: <20240529162927.403425-5-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-1-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

napi_alloc_cache is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Add a local_lock_t to the data structure and use local_lock_nested_bh()
for locking. This change adds only lockdep coverage and does not alter
the functional behaviour for !PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/skbuff.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index dda13fdffb697..b33bae4ba78b6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -277,6 +277,7 @@ static void *page_frag_alloc_1k(struct page_frag_1k *nc=
, gfp_t gfp_mask)
 #endif
=20
 struct napi_alloc_cache {
+	local_lock_t bh_lock;
 	struct page_frag_cache page;
 	struct page_frag_1k page_small;
 	unsigned int skb_count;
@@ -284,7 +285,9 @@ struct napi_alloc_cache {
 };
=20
 static DEFINE_PER_CPU(struct page_frag_cache, netdev_alloc_cache);
-static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache);
+static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 /* Double check that napi_get_frags() allocates skbs with
  * skb->head being backed by slab, not a page fragment.
@@ -308,6 +311,7 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsi=
gned int align_mask)
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
=20
 	fragsz =3D SKB_DATA_ALIGN(fragsz);
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
=20
 	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
 				       align_mask);
@@ -338,6 +342,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
=20
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
 		nc->skb_count =3D kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
 						      GFP_ATOMIC,
@@ -740,9 +745,13 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *=
dev, unsigned int len,
 		pfmemalloc =3D nc->pfmemalloc;
 	} else {
 		local_bh_disable();
+		local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+
 		nc =3D this_cpu_ptr(&napi_alloc_cache.page);
 		data =3D page_frag_alloc(nc, len, gfp_mask);
 		pfmemalloc =3D nc->pfmemalloc;
+
+		local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 		local_bh_enable();
 	}
=20
@@ -806,11 +815,11 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *na=
pi, unsigned int len)
 		goto skb_success;
 	}
=20
-	nc =3D this_cpu_ptr(&napi_alloc_cache);
-
 	if (sk_memalloc_socks())
 		gfp_mask |=3D __GFP_MEMALLOC;
=20
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+	nc =3D this_cpu_ptr(&napi_alloc_cache);
 	if (NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_WITH_OVERHEAD(1024)) {
 		/* we are artificially inflating the allocation size, but
 		 * that is not as bad as it may look like, as:
@@ -832,6 +841,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi=
, unsigned int len)
 		data =3D page_frag_alloc(&nc->page, len, gfp_mask);
 		pfmemalloc =3D nc->page.pfmemalloc;
 	}
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
=20
 	if (unlikely(!data))
 		return NULL;
@@ -1429,6 +1439,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	if (!kasan_mempool_poison_object(skb))
 		return;
=20
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 	nc->skb_cache[nc->skb_count++] =3D skb;
=20
 	if (unlikely(nc->skb_count =3D=3D NAPI_SKB_CACHE_SIZE)) {
--=20
2.45.1


