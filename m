Return-Path: <netdev+bounces-104370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9291190C529
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C7A1C2122C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7A615575E;
	Tue, 18 Jun 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WZrmrHQ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vo0QfjUF"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53413A248;
	Tue, 18 Jun 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695536; cv=none; b=EmPvkhLWHrEPrn/vrGnTemkx2BhDWpXMBwdXc6wcCxFJTdj7kb8cpHA22LUGsmJLxTPhzPrAwdNQiO5cU8wDnwhrRLBLKz3J2eaUP6n7hhFCiAiPXF+4J2J6GgG4J21NarFHKwkD4763DdrlL5ArFzxZYFgaPfRqGlMZT/EoOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695536; c=relaxed/simple;
	bh=0tDt6dndm3G+sNUSXkkpHRLf5liVs4gyYGuZT2hGejw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYB/jvf3IlBQ3+TyPE090HbwOgdJj1xIYuX5+5xpDbvce4YUs9WbErZzddzjAWk4A+75xgxjCJ33F0lBgwZiVhRDYrMdXd/SECTRb9QfRW73WkLNEj6vd2mKZ5n8KDVN4oc28wlmkBAYdsrDG+CoJm4Ngy4NspndSFs7PE4H8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WZrmrHQ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vo0QfjUF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718695532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GruW12PU2Ogt+fndrHHiAUjJt1cIYrbQg9Rnf7vvA4s=;
	b=WZrmrHQ5aTkyKU94qJz04MoQ/zU03ZdKYK+rDpDfktAYnNAs2ocd6eFC5kip2zbKsTTC27
	eJ0NVv1NePKLcTgVglrFzWdZRFH2oIG2P+M7GYWXMlIVqKArSwGrYpe+OBch/9U05YCyPt
	PlBp574SUsN1F4RlMnEiLQK3HkPMEb3+/r5UvEYDOLuFZYrVj0BQPrI2i2c/Y4mD8JLGGo
	2ZjVX9Rgj1dU+KU5BZerEM3SZCRgDjWgJURG5zgdRA31zqYUi/S5tXc6hrprji8nBS139n
	YJVHEgN8ssRLSn98PC36iMwR2cOlcjSj3mKmgtk6KGg0myinWWBBmHrFwwEnRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718695532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GruW12PU2Ogt+fndrHHiAUjJt1cIYrbQg9Rnf7vvA4s=;
	b=Vo0QfjUFRT7b8T9YVoNBFsZ477nCErWvRdr7i19VBJiS3PH3yqaA/JRxEBPAsYBSvO3y9D
	t32IFmSIdUtyS5AA==
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
Subject: [PATCH v7 net-next 04/15] net: Use nested-BH locking for napi_alloc_cache.
Date: Tue, 18 Jun 2024 09:13:20 +0200
Message-ID: <20240618072526.379909-5-bigeasy@linutronix.de>
In-Reply-To: <20240618072526.379909-1-bigeasy@linutronix.de>
References: <20240618072526.379909-1-bigeasy@linutronix.de>
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
 net/core/skbuff.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 656b298255c5f..0c13cfa20658f 100644
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
@@ -306,11 +309,16 @@ void napi_get_frags_check(struct napi_struct *napi)
 void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 {
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
+	void *data;
=20
 	fragsz =3D SKB_DATA_ALIGN(fragsz);
=20
-	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+	data =3D __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
 				       align_mask);
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
+	return data;
+
 }
 EXPORT_SYMBOL(__napi_alloc_frag_align);
=20
@@ -338,16 +346,20 @@ static struct sk_buff *napi_skb_cache_get(void)
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
=20
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
 		nc->skb_count =3D kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
 						      GFP_ATOMIC,
 						      NAPI_SKB_CACHE_BULK,
 						      nc->skb_cache);
-		if (unlikely(!nc->skb_count))
+		if (unlikely(!nc->skb_count)) {
+			local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 			return NULL;
+		}
 	}
=20
 	skb =3D nc->skb_cache[--nc->skb_count];
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 	kasan_mempool_unpoison_object(skb, kmem_cache_size(net_hotdata.skbuff_cac=
he));
=20
 	return skb;
@@ -740,9 +752,13 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *=
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
@@ -806,11 +822,11 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *na=
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
@@ -832,6 +848,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi=
, unsigned int len)
 		data =3D page_frag_alloc(&nc->page, len, gfp_mask);
 		pfmemalloc =3D nc->page.pfmemalloc;
 	}
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
=20
 	if (unlikely(!data))
 		return NULL;
@@ -1429,6 +1446,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	if (!kasan_mempool_poison_object(skb))
 		return;
=20
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	nc->skb_cache[nc->skb_count++] =3D skb;
=20
 	if (unlikely(nc->skb_count =3D=3D NAPI_SKB_CACHE_SIZE)) {
@@ -1440,6 +1458,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
 		nc->skb_count =3D NAPI_SKB_CACHE_HALF;
 	}
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 }
=20
 void __napi_kfree_skb(struct sk_buff *skb, enum skb_drop_reason reason)
--=20
2.45.2


