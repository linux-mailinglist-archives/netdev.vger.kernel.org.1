Return-Path: <netdev+bounces-77587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F587239D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AF41C2328F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3112A158;
	Tue,  5 Mar 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Chrmcago"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0C12A154
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654685; cv=none; b=S4YRwhLUd5NwhotePtDnpwv1Meew2rd9fECZHL4tBxEikpI4zPT8d3j6qPOztp2ftd34ZkbqxWIvY4RqDP4w5+TtvYXschVucxd9/PnrnVPntoZszES7aUmEvNZeyk7Hbs6FiWhGsWazZ3vpPNdhNRtp2tpAke+EMSNHiN4kYos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654685; c=relaxed/simple;
	bh=qvJR7RDeGnkkEji13PDzCTJbcfAMtHrb5DFW3Ufc/cc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uXp/TPGXkrU3hdsLelM5Es5AjCwxQvdL0HhKa9UCJu7bmpKJp+kto/pL0gOB1yrrSaEAPkAgDCzLDWV/pToBDTC4oNoFgnx8hyjlP9KvZ5qMd23Alkztd6iamxT/4MaEM9MMzCQE4U2Top5KkpSdNQcNVvamfS/q/zbVTtlqbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Chrmcago; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60971264c48so82452687b3.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654670; x=1710259470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXuzjaWpuPGGuxoMls62ICUjw0KDzzH1deWBD6dbTUc=;
        b=ChrmcagoWrEf9/yxnsC5SLOIl3QbxwmKOYQNESH72p0AIOiNALdXCrhOMc8GMKb0GO
         Xko+1TFH70HVsgGpjH14kK7p7j7wn449QSsi2icMq8+Ms8w+Ic9bMqflAmM8YBr9ece9
         wggnpRsXDY4NAhqzoLgt+ErMgtQIoAknQpBqawHZsvhrs7qMokpECf+XPkxVYw4OCyBM
         evQK7E9aZrOHPga5a0A5n+n1OcPYqZriRewyfpdSTQM5IqLEjIhZn+7xPB8JuP3aevNj
         48F4F10Jy0yx3IWxtGSV79EeI7BshD8YjX4QQVVsD1FWSxaSqlpkxfUSxid8qOlDsjqy
         mGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654670; x=1710259470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXuzjaWpuPGGuxoMls62ICUjw0KDzzH1deWBD6dbTUc=;
        b=hIPm797zpqwBsgGhIw0nbMuUQpoXqriVqbvPN0ya8jCB8fEoPJUA6xn+MWufvHJaZ4
         2/TwY+DP7Cs+pWRZeM+OiDW7ny+Wt+cjRXIzoP3LNmFs3vPuHB+sQ+hnxQumzb8SWiyp
         Afe5N/m/KdjaYosPnJDzrheU9g577B+EQJDi6J3414f27W9JQ8uqfMY99Ugbi+lIdJ5g
         yj+uYcZUCUcorn3wTyBmFHbc2unKc3YR+VJmXLLY4ZDWX2FH/9jLHE0aROmUhrtuHl95
         tfTC0DquJ5rq4ekSyRtt3lpZII9PP5dEkoAbQEYDJnbMsIGlFLVcYmzZvSyr3I7CwUtN
         MtFA==
X-Gm-Message-State: AOJu0Yx+PsCchs1g+sUPmWj/RW99vy8mHcfhVgB9Tgek5K+KIrCnlxkV
	ldn9eTzWnagM2vH4R3vI1aGqK7DD+eZXY/2la3Wvn14QgMUiE5lGMMspXzuRbta++waAVEX5raf
	GgKRS+rbTjA==
X-Google-Smtp-Source: AGHT+IGtrR9iNBnuqRs7p2je6kZyXq3Xvu8AiLbG9RFaPXwLaGjy2u/ewh5fjjfHa8an5/TQf9QLnvA7eG4UFw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1821:b0:dc7:9218:df3b with SMTP
 id cf33-20020a056902182100b00dc79218df3bmr519963ybb.10.1709654670769; Tue, 05
 Mar 2024 08:04:30 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:05 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-11-edumazet@google.com>
Subject: [PATCH net-next 10/18] net: move skbuff_cache(s) to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

skbuff_cache, skbuff_fclone_cache and skb_small_head_cache
are used in rx/tx fast paths.

Move them to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h |  1 -
 include/net/hotdata.h  |  3 +++
 kernel/bpf/cpumap.c    |  4 +++-
 net/bpf/test_run.c     |  4 +++-
 net/core/skbuff.c      | 44 +++++++++++++++++++-----------------------
 net/core/xdp.c         |  5 +++--
 6 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 3013355b63f5f29acfcb0331bfd1c3308aba034d..d0508f90bed50ca66850b29383033e11985dad34 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1271,7 +1271,6 @@ static inline void consume_skb(struct sk_buff *skb)
 
 void __consume_stateless_skb(struct sk_buff *skb);
 void  __kfree_skb(struct sk_buff *skb);
-extern struct kmem_cache *skbuff_cache;
 
 void kfree_skb_partial(struct sk_buff *skb, bool head_stolen);
 bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index f45085eddbc997c2a9686b5b4de9da4cc8c4ede8..728aee1cf07c8f0d85873d912248a99e148f84b1 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -18,6 +18,9 @@ struct net_hotdata {
 #endif
 	struct list_head	offload_base;
 	struct list_head	ptype_all;
+	struct kmem_cache	*skbuff_cache;
+	struct kmem_cache	*skbuff_fclone_cache;
+	struct kmem_cache	*skb_small_head_cache;
 	int			gro_normal_batch;
 	int			netdev_budget;
 	int			netdev_budget_usecs;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8a0bb80fe48a344964e4029fec5e895ee512babf..33f4246cdf0de8232bfbba6a4300f158db3ca9d5 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -24,6 +24,7 @@
 #include <linux/filter.h>
 #include <linux/ptr_ring.h>
 #include <net/xdp.h>
+#include <net/hotdata.h>
 
 #include <linux/sched.h>
 #include <linux/workqueue.h>
@@ -326,7 +327,8 @@ static int cpu_map_kthread_run(void *data)
 		/* Support running another XDP prog on this CPU */
 		nframes = cpu_map_bpf_prog_run(rcpu, frames, xdp_n, &stats, &list);
 		if (nframes) {
-			m = kmem_cache_alloc_bulk(skbuff_cache, gfp, nframes, skbs);
+			m = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+						  gfp, nframes, skbs);
 			if (unlikely(m == 0)) {
 				for (i = 0; i < nframes; i++)
 					skbs[i] = NULL; /* effect: xdp_return_frame */
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 5535f9adc6589d028138026ebff24286098dc46d..61efeadaff8db0529a62d074f441e2a7c35eaa9e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -12,6 +12,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/sched/signal.h>
 #include <net/bpf_sk_storage.h>
+#include <net/hotdata.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/net_namespace.h>
@@ -254,7 +255,8 @@ static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
 	int i, n;
 	LIST_HEAD(list);
 
-	n = kmem_cache_alloc_bulk(skbuff_cache, gfp, nframes, (void **)skbs);
+	n = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp, nframes,
+				  (void **)skbs);
 	if (unlikely(n == 0)) {
 		for (i = 0; i < nframes; i++)
 			xdp_return_frame(frames[i]);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43d7fc150acc9263760162c3f5778fa0a646bcc4..766219011aeaf5782df9d624696d273ef6c1577c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -69,6 +69,7 @@
 #include <net/sock.h>
 #include <net/checksum.h>
 #include <net/gso.h>
+#include <net/hotdata.h>
 #include <net/ip6_checksum.h>
 #include <net/xfrm.h>
 #include <net/mpls.h>
@@ -88,15 +89,10 @@
 #include "dev.h"
 #include "sock_destructor.h"
 
-struct kmem_cache *skbuff_cache __ro_after_init;
-static struct kmem_cache *skbuff_fclone_cache __ro_after_init;
 #ifdef CONFIG_SKB_EXTENSIONS
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #endif
 
-
-static struct kmem_cache *skb_small_head_cache __ro_after_init;
-
 #define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(MAX_TCP_HEADER)
 
 /* We want SKB_SMALL_HEAD_CACHE_SIZE to not be a power of two.
@@ -349,7 +345,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	struct sk_buff *skb;
 
 	if (unlikely(!nc->skb_count)) {
-		nc->skb_count = kmem_cache_alloc_bulk(skbuff_cache,
+		nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
 						      GFP_ATOMIC,
 						      NAPI_SKB_CACHE_BULK,
 						      nc->skb_cache);
@@ -358,7 +354,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	}
 
 	skb = nc->skb_cache[--nc->skb_count];
-	kasan_mempool_unpoison_object(skb, kmem_cache_size(skbuff_cache));
+	kasan_mempool_unpoison_object(skb, kmem_cache_size(net_hotdata.skbuff_cache));
 
 	return skb;
 }
@@ -416,7 +412,7 @@ struct sk_buff *slab_build_skb(void *data)
 	struct sk_buff *skb;
 	unsigned int size;
 
-	skb = kmem_cache_alloc(skbuff_cache, GFP_ATOMIC);
+	skb = kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -467,7 +463,7 @@ struct sk_buff *__build_skb(void *data, unsigned int frag_size)
 {
 	struct sk_buff *skb;
 
-	skb = kmem_cache_alloc(skbuff_cache, GFP_ATOMIC);
+	skb = kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -578,7 +574,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	obj_size = SKB_HEAD_ALIGN(*size);
 	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
 	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
-		obj = kmem_cache_alloc_node(skb_small_head_cache,
+		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
 				flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
 				node);
 		*size = SKB_SMALL_HEAD_CACHE_SIZE;
@@ -586,7 +582,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 			goto out;
 		/* Try again but now we are using pfmemalloc reserves */
 		ret_pfmemalloc = true;
-		obj = kmem_cache_alloc_node(skb_small_head_cache, flags, node);
+		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache, flags, node);
 		goto out;
 	}
 
@@ -649,7 +645,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	u8 *data;
 
 	cache = (flags & SKB_ALLOC_FCLONE)
-		? skbuff_fclone_cache : skbuff_cache;
+		? net_hotdata.skbuff_fclone_cache : net_hotdata.skbuff_cache;
 
 	if (sk_memalloc_socks() && (flags & SKB_ALLOC_RX))
 		gfp_mask |= __GFP_MEMALLOC;
@@ -1095,7 +1091,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
-		kmem_cache_free(skb_small_head_cache, head);
+		kmem_cache_free(net_hotdata.skb_small_head_cache, head);
 	else
 		kfree(head);
 }
@@ -1162,7 +1158,7 @@ static void kfree_skbmem(struct sk_buff *skb)
 
 	switch (skb->fclone) {
 	case SKB_FCLONE_UNAVAILABLE:
-		kmem_cache_free(skbuff_cache, skb);
+		kmem_cache_free(net_hotdata.skbuff_cache, skb);
 		return;
 
 	case SKB_FCLONE_ORIG:
@@ -1183,7 +1179,7 @@ static void kfree_skbmem(struct sk_buff *skb)
 	if (!refcount_dec_and_test(&fclones->fclone_ref))
 		return;
 fastpath:
-	kmem_cache_free(skbuff_fclone_cache, fclones);
+	kmem_cache_free(net_hotdata.skbuff_fclone_cache, fclones);
 }
 
 void skb_release_head_state(struct sk_buff *skb)
@@ -1280,7 +1276,7 @@ static void kfree_skb_add_bulk(struct sk_buff *skb,
 	sa->skb_array[sa->skb_count++] = skb;
 
 	if (unlikely(sa->skb_count == KFREE_SKB_BULK_SIZE)) {
-		kmem_cache_free_bulk(skbuff_cache, KFREE_SKB_BULK_SIZE,
+		kmem_cache_free_bulk(net_hotdata.skbuff_cache, KFREE_SKB_BULK_SIZE,
 				     sa->skb_array);
 		sa->skb_count = 0;
 	}
@@ -1305,7 +1301,7 @@ kfree_skb_list_reason(struct sk_buff *segs, enum skb_drop_reason reason)
 	}
 
 	if (sa.skb_count)
-		kmem_cache_free_bulk(skbuff_cache, sa.skb_count, sa.skb_array);
+		kmem_cache_free_bulk(net_hotdata.skbuff_cache, sa.skb_count, sa.skb_array);
 }
 EXPORT_SYMBOL(kfree_skb_list_reason);
 
@@ -1467,9 +1463,9 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
 		for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
 			kasan_mempool_unpoison_object(nc->skb_cache[i],
-						kmem_cache_size(skbuff_cache));
+						kmem_cache_size(net_hotdata.skbuff_cache));
 
-		kmem_cache_free_bulk(skbuff_cache, NAPI_SKB_CACHE_HALF,
+		kmem_cache_free_bulk(net_hotdata.skbuff_cache, NAPI_SKB_CACHE_HALF,
 				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
 		nc->skb_count = NAPI_SKB_CACHE_HALF;
 	}
@@ -2066,7 +2062,7 @@ struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
 		if (skb_pfmemalloc(skb))
 			gfp_mask |= __GFP_MEMALLOC;
 
-		n = kmem_cache_alloc(skbuff_cache, gfp_mask);
+		n = kmem_cache_alloc(net_hotdata.skbuff_cache, gfp_mask);
 		if (!n)
 			return NULL;
 
@@ -5005,7 +5001,7 @@ static void skb_extensions_init(void) {}
 
 void __init skb_init(void)
 {
-	skbuff_cache = kmem_cache_create_usercopy("skbuff_head_cache",
+	net_hotdata.skbuff_cache = kmem_cache_create_usercopy("skbuff_head_cache",
 					      sizeof(struct sk_buff),
 					      0,
 					      SLAB_HWCACHE_ALIGN|SLAB_PANIC|
@@ -5013,7 +5009,7 @@ void __init skb_init(void)
 					      offsetof(struct sk_buff, cb),
 					      sizeof_field(struct sk_buff, cb),
 					      NULL);
-	skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
+	net_hotdata.skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
 						sizeof(struct sk_buff_fclones),
 						0,
 						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
@@ -5022,7 +5018,7 @@ void __init skb_init(void)
 	 * struct skb_shared_info is located at the end of skb->head,
 	 * and should not be copied to/from user.
 	 */
-	skb_small_head_cache = kmem_cache_create_usercopy("skbuff_small_head",
+	net_hotdata.skb_small_head_cache = kmem_cache_create_usercopy("skbuff_small_head",
 						SKB_SMALL_HEAD_CACHE_SIZE,
 						0,
 						SLAB_HWCACHE_ALIGN | SLAB_PANIC,
@@ -5895,7 +5891,7 @@ void kfree_skb_partial(struct sk_buff *skb, bool head_stolen)
 {
 	if (head_stolen) {
 		skb_release_head_state(skb);
-		kmem_cache_free(skbuff_cache, skb);
+		kmem_cache_free(net_hotdata.skbuff_cache, skb);
 	} else {
 		__kfree_skb(skb);
 	}
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 0e3709a29175baf3ee90fdc9cc2d97d861da11a3..41693154e426f78656cc18fc97ca7e82e648270b 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -16,6 +16,7 @@
 #include <linux/bug.h>
 #include <net/page_pool/helpers.h>
 
+#include <net/hotdata.h>
 #include <net/xdp.h>
 #include <net/xdp_priv.h> /* struct xdp_mem_allocator */
 #include <trace/events/xdp.h>
@@ -589,7 +590,7 @@ EXPORT_SYMBOL_GPL(xdp_warn);
 
 int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
 {
-	n_skb = kmem_cache_alloc_bulk(skbuff_cache, gfp, n_skb, skbs);
+	n_skb = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp, n_skb, skbs);
 	if (unlikely(!n_skb))
 		return -ENOMEM;
 
@@ -658,7 +659,7 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 {
 	struct sk_buff *skb;
 
-	skb = kmem_cache_alloc(skbuff_cache, GFP_ATOMIC);
+	skb = kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.44.0.278.ge034bb2e1d-goog


