Return-Path: <netdev+bounces-102943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B7905971
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937C4281BD4
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEAB183089;
	Wed, 12 Jun 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMp1WpU4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1jscKs3"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649A181D0E;
	Wed, 12 Jun 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211804; cv=none; b=SqgdDtHlJ2dgimdLg3ccCd/kCvnVk/zxIUCQGxkcV/Utb/3dmqrAuXIIeaCKJyBLLeaEiuomdKc9cQy32rhUWQLsQS6oGoHPm+ZlHmMMwP/e8LvvMsbTjPkz75AeZdFWkX5dvIEbZ0exiQXoDUZYRmOBTC6njbqZSBNE31xK9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211804; c=relaxed/simple;
	bh=9NBzbyjp2BHlUdMks9i5h0upbgPiworXpuC3AtsmzIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5OGkp92574bB3vFcc2NY9YFBWwwKqkDLuZo2ytQ2m3H050RuHcDYgZqfZe0e9B6wXALdJfnauMJMSbS5Xd24iSgIionj3/WgSjBSt8BSVTNrSTkcxIoDW/i3p/DltUWCUIQxJOwlOYDcaX1txIcdx8yVIRr52/BppWRbGoSOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMp1WpU4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1jscKs3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718211794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgkErXQQH48qPAOjV1K/j1h7uV83XPXLiYsAGrLFXIE=;
	b=SMp1WpU42PiPB1efr4UKhWt6e1vrc4JJZhGxbue9Ff6iikIOMPKa3HBrL5nk74+wt9b1C7
	qvcTUp/uNBQuoT2iRq3MuiPbgqGCvudZOC6msbeJb2gEJ74vkDV+GxalWs18ifqoidaxsR
	QNhY4QDnqeYIwsRx3KGCtBTdvVsvBrD/y7mawu9GbAYH4PJVjyUtYxg5ozBh2SWWUhZQUj
	xWTrZzVTYjcUrBr8YLeJYMZT9b1qgqmenTmt4CgCI6SFtKVYEK3BHIaPtQ0C30A9J3KUsz
	d89wwXvvB/1h81IFjzEYCW9ppauecDJZgFbUQGYm0FIm5D4p6eMmqOSpGQPadA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718211794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgkErXQQH48qPAOjV1K/j1h7uV83XPXLiYsAGrLFXIE=;
	b=t1jscKs3oOTgnyrjbnvVyDx/HrsKx2u3uGgnOUT4TGE9LARH8RKvxso1q92yBM6HJ+gI1N
	/RNMI2HEBFXq4CCg==
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
Subject: [PATCH v6 net-next 04/15] net: Use nested-BH locking for napi_alloc_cache.
Date: Wed, 12 Jun 2024 18:44:30 +0200
Message-ID: <20240612170303.3896084-5-bigeasy@linutronix.de>
In-Reply-To: <20240612170303.3896084-1-bigeasy@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
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
2.45.1


