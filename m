Return-Path: <netdev+bounces-249944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AB7D2156C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F43130389A9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212736167B;
	Wed, 14 Jan 2026 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOuler+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3D13AF2
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426125; cv=none; b=DTQu1insMG0ENC9i2EQkVvOxA8WLVK7hk3l/+bun0o4cs4ENS16wniX9k77sl6mG69fLUxF3omFEBRJ3y2C6WRhRM7gBREADMRwxoiwNBw4IGRa4ZPedDlK4+40PWrnv8qluVGzCkKRIXboRlXAp4PfO8Ea0VyAHOibJX5TClSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426125; c=relaxed/simple;
	bh=BZq3ESK1UHbwwkYHp6wkglJmwwnOaSqiEnsPw3KlZSw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ya62hSeqI8Dn0UJe2GZAfLszYmOWUI90Fh4WGr7pbXPdJBebfRVK/kfsLZPpAh9YusYpl5JAMog74bj5yFp2Oxv0i26bICd+EYs4o2X4ZLUo80YZuD5x1AlOfdelqyZ7hHmqRekEHVX6bu4/6Ej1SDxuo7Jytmp2N+7V/6pnVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOuler+r; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8888447ffebso6172426d6.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768426122; x=1769030922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vNxYCYHOdNkdCRVlszimGKO2QPG49vop8ftUS49goRs=;
        b=OOuler+r/l2JiBg110F+p2prQA2ibnVS4NPqyAvseVu1a6CZ3dNH2ZaCsjvIBaxlM5
         6BPvE7QLeNCBRnmB4enbJup0PGsMhGYTurn4x9/PJIGn0IJv7lmtUjNUk8Kef1aCa/Uy
         IhgJJ/KyjEDcrIXAbyEJoV/t/4BvE1bCIoBI1CMOdykQ2FTw35lNUEXJkFMAFewPGrCb
         6R84w+/ipc/VkGQKm5tuGTziAVsSjyYGStudgQkOMVqCL+mFQsuZvgQJDYwIdi2pJ3tm
         LEDyk3thLNyfDnIk9OH+YaibgH7cyz1Wj/i52M7bqoFJHIkuQL6SAMcm7skZomRfU+wf
         Cxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426122; x=1769030922;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vNxYCYHOdNkdCRVlszimGKO2QPG49vop8ftUS49goRs=;
        b=YKnkMXyQz6o+T1/lHdbbt9guUf9XdQlIvc+2Au9k+nGU9xWa2MauF5n8/9H/RhnhsZ
         QPdJH9iH2A+iZ8zlal9tvYJq+h25kk2IZFI0gS6cVnXwaSMPS8gWMzb5bdMntWDzJa3f
         DimFuQxjKzLBcK/pKSIdf4bWKw8RKzIwBjuw7gmQkviMivcgdySQKj8f/1s6uABnFvQp
         07zckd8R8bkRFDJhFSaJU1bP2ae1qAFGyYncBeITVpWo8V9FArCrajKWMK2haUgZLkI7
         MaTu1CEBx9jT8m09BUNg5QA1k08gP7jnHrGeicZnfyGsS+JqAy0H+/HfO4n/42WcwgFS
         cPwA==
X-Forwarded-Encrypted: i=1; AJvYcCUnPfPHqOdu23mwP1h5LYn6auxZDLJwG2qOD6XhNGFrEj8wwC43yT9dkRSRbjcH1sOCh1KxDtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtezDTHpwA+fzk6OqfX0YdqarJKgu2aWIOjbhKCyT3IQqZotR
	nCTtjg8hlNF/3K29+kj//m3Whh7GVQmFTy+xlxs5zu5FqLQQVfmAzGP7aET6Ngr/Aytr5qNRScs
	/rof83SeVLLMs/g==
X-Received: from qvbny9.prod.google.com ([2002:a05:6214:3989:b0:888:872b:774d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2b09:b0:890:5719:2697 with SMTP id 6a1803df08f44-89275ae07e9mr42786916d6.5.1768426122379;
 Wed, 14 Jan 2026 13:28:42 -0800 (PST)
Date: Wed, 14 Jan 2026 21:28:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114212840.2511487-1-edumazet@google.com>
Subject: [PATCH net-next] net: split kmalloc_reserve()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

kmalloc_reserve() is too big to be inlined.

Put the slow path in a new out-of-line function : kmalloc_pfmemalloc()

Then let kmalloc_reserve() set skb->pfmemalloc only when/if
the slow path is taken.

This means __alloc_skb() is faster :

- kmalloc_reserve() is now automatically inlined by both gcc and clang.
- No more expensive RMW (skb->pfmemalloc = pfmemalloc).
- No more expensive stack canary (for CONFIG_STACKPROTECTOR_STRONG=y).
- Removal of two prefetches that were coming too late for modern cpus.

Text size increase is quite small compared to the cpu savings (~0.5 %)

$ size net/core/skbuff.clang.before.o net/core/skbuff.clang.after.o
   text	   data	    bss	    dec	    hex	filename
  72507	   5897	      0	  78404	  13244	net/core/skbuff.clang.before.o
  72681	   5897	      0	  78578	  132f2	net/core/skbuff.clang.after.o

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 77508cf7c41e829a11a988d8de3d2673ff1ff121..3dd21f5c1b6c8f49f4673fa2f8a1969583ab6983 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -583,6 +583,16 @@ struct sk_buff *napi_build_skb(void *data, unsigned int frag_size)
 }
 EXPORT_SYMBOL(napi_build_skb);
 
+static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
+{
+	if (!gfp_pfmemalloc_allowed(flags))
+		return NULL;
+	if (!obj_size)
+		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
+					     flags, node);
+	return kmalloc_node_track_caller(obj_size, flags, node);
+}
+
 /*
  * kmalloc_reserve is a wrapper around kmalloc_node_track_caller that tells
  * the caller if emergency pfmemalloc reserves are being used. If it is and
@@ -591,9 +601,8 @@ EXPORT_SYMBOL(napi_build_skb);
  * memory is free
  */
 static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
-			     bool *pfmemalloc)
+			     struct sk_buff *skb)
 {
-	bool ret_pfmemalloc = false;
 	size_t obj_size;
 	void *obj;
 
@@ -604,12 +613,12 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 				flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
 				node);
 		*size = SKB_SMALL_HEAD_CACHE_SIZE;
-		if (obj || !(gfp_pfmemalloc_allowed(flags)))
+		if (likely(obj))
 			goto out;
 		/* Try again but now we are using pfmemalloc reserves */
-		ret_pfmemalloc = true;
-		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache, flags, node);
-		goto out;
+		if (skb)
+			skb->pfmemalloc = true;
+		return kmalloc_pfmemalloc(0, flags, node);
 	}
 
 	obj_size = kmalloc_size_roundup(obj_size);
@@ -625,17 +634,14 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	obj = kmalloc_node_track_caller(obj_size,
 					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
 					node);
-	if (obj || !(gfp_pfmemalloc_allowed(flags)))
+	if (likely(obj))
 		goto out;
 
 	/* Try again but now we are using pfmemalloc reserves */
-	ret_pfmemalloc = true;
-	obj = kmalloc_node_track_caller(obj_size, flags, node);
-
+	if (skb)
+		skb->pfmemalloc = true;
+	obj = kmalloc_pfmemalloc(obj_size, flags, node);
 out:
-	if (pfmemalloc)
-		*pfmemalloc = ret_pfmemalloc;
-
 	return obj;
 }
 
@@ -667,7 +673,6 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 {
 	struct sk_buff *skb = NULL;
 	struct kmem_cache *cache;
-	bool pfmemalloc;
 	u8 *data;
 
 	if (sk_memalloc_socks() && (flags & SKB_ALLOC_RX))
@@ -697,25 +702,21 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 		if (unlikely(!skb))
 			return NULL;
 	}
-	prefetchw(skb);
+	skbuff_clear(skb);
 
 	/* We do our best to align skb_shared_info on a separate cache
 	 * line. It usually works because kmalloc(X > SMP_CACHE_BYTES) gives
 	 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
 	 * Both skb->head and skb_shared_info are cache line aligned.
 	 */
-	data = kmalloc_reserve(&size, gfp_mask, node, &pfmemalloc);
+	data = kmalloc_reserve(&size, gfp_mask, node, skb);
 	if (unlikely(!data))
 		goto nodata;
 	/* kmalloc_size_roundup() might give us more room than requested.
 	 * Put skb_shared_info exactly at the end of allocated zone,
 	 * to allow max possible filling before reallocation.
 	 */
-	prefetchw(data + SKB_WITH_OVERHEAD(size));
-
-	skbuff_clear(skb);
 	__finalize_skb_around(skb, data, size);
-	skb->pfmemalloc = pfmemalloc;
 
 	if (flags & SKB_ALLOC_FCLONE) {
 		struct sk_buff_fclones *fclones;
-- 
2.52.0.457.g6b5491de43-goog


