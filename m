Return-Path: <netdev+bounces-100648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2FD8FB7BA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073C31F21D85
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD35146A86;
	Tue,  4 Jun 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KJuloIsT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UnP61uO9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859A144303;
	Tue,  4 Jun 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515891; cv=none; b=t+Fj4qQbtNXey/+F20BfcQF7ypYHaV0Dv9eeCviqxTjG4Dhth/0r9nWoniLYplLOW+HJABYppa+5BHaV6AEMTHU2jEloz5xTo9Mm+FV5pvFG3DPVTIokbUpnhMY2N1Lb6IpoggFLERSZu6t/Ym0eG1hJZrfMksQbPdHn7Edo9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515891; c=relaxed/simple;
	bh=zNMqpxBAGQiw9OcL50vy3QVIxWZ4GXc8Kaab9zYXR04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxy02rfKDppRoKKoTqbPWwD9X3vdK8zfs7gYBUn0sWquAWdGpD9hkuex9m0NChHnR5skROjO5UBG423nUedGn7IlyXrnOA7p5mcBT+mrStjkdBM/JwOOTM+aulsbSBKwpMGBHuYZs4GXoOfT7QYdUl1rElYLbenU90tIVwfrTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KJuloIsT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UnP61uO9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717515888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1G2V1ldZthL2oayfOZavDOAUvExZwG7aIqHHf24zyo=;
	b=KJuloIsTLdWcvxAE6qHSOEPq5hacNvfN/b8impy3RgEAeVm29GMuLErDtgnK4346bD1EO5
	EhNszLzlXv8JNqaQ7ypT0GUC9r6a5ROqwmTGOqRVdwX5WwmeQr1Zp7xRUkaFobAJl3jnsG
	qA2DCu/4eNFrww+QGiu7Q+Uxe2UHC+PefVlEhgmxM46erpSjvzNaquFgZEsCBgolxv7npu
	LitafFKOboz4qGEINXGOP+iOFgIUXcDVHs/EwXTxddjIC65a7l3vX5qxRdiyucXD3okNWH
	4rQtHgpZN1nG5jBdI/RtWh9iDppPdGB8K8FkjwmOCq4/JOgSjDocHZ4OIvNbgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717515888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1G2V1ldZthL2oayfOZavDOAUvExZwG7aIqHHf24zyo=;
	b=UnP61uO9srXC2LLYwoFfGmPdgMvRgytQ4yCUKB/mbDK5twZBgUuY7PqWeYUN5vAJzR50oa
	sItgjwJjmrhp5ACg==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: [PATCH v4 net-next 03/14] net: Use nested-BH locking for napi_alloc_cache.
Date: Tue,  4 Jun 2024 17:24:10 +0200
Message-ID: <20240604154425.878636-4-bigeasy@linutronix.de>
In-Reply-To: <20240604154425.878636-1-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
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


