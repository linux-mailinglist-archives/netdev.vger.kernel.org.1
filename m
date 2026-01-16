Return-Path: <netdev+bounces-250441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B6ED2B3BB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83972300E04A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799CF344024;
	Fri, 16 Jan 2026 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVTxhiAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A920C00C
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536843; cv=none; b=LqCsytFbKgrtlBITRlYE3tyTIDlagvZOHHh1nMVD/j8VTEQwyEY64OraBZ9YoE0M26UOfwhMF3+suAggQyJ5Ub1AKLFS55i5f+NoJ+xqzCEmkI7UZzBFEHwS9u5ueMj5broFZ9g2NJqKXgGL+imXkz53LTlmysGPTOHhnyU2jl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536843; c=relaxed/simple;
	bh=4o/uaAFPuJGOQ86ztiKSsBNXMV2lOU7T2tK+N0piHQI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m719LwfG+4mqe602JDh/2Xo6X7LoYT4u265nMYw+JhL6NTJpP5NlvigSSGegDdSFodWiiStCLs1EXvtztWF7sJP6lIiQNGUTAUYHok08WUN3Fx9o5lrw6RITcNBAtNze9SdwgJ6X3sF6sXueBJ+5BeLz3FOYc+8zvyanH1vHBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVTxhiAc; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88a34f64f5eso39960276d6.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 20:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768536841; x=1769141641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fwepwJWydDxztOV4RWcgsi7nz+Ho3WV67aM8SWgP8dk=;
        b=YVTxhiAcku2q65C9+Ar0x3mPTpZQZCB2MjWACZJpA2rV83rbRnoZnHezIlNpHqrNIw
         oOqVAen4pyNGtd8nmaZqSb9E9lSBHEicJNyuKdWBG+Gjv+ACHzBhOhbEM8IPqLwGjnoa
         VW3n52s1q72eVjOBvr1MhnlnHhmapiyMXCwy9Vf49BcQKkCrdMcpDItcqtrtLpD5zxmf
         SV/sgk4pJgCrFDHuMEhgtyBOr6yqC36vo8/r2iIQaOzfF/CUf0T1u1IYbuZCzRRMYG+v
         klEW/eVh2XDqBf/DjxfNWdO9KdP7mAy5aVQodMIF4c6oiA/VCwqteUGNjr/oSQd3H5D6
         bD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768536841; x=1769141641;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwepwJWydDxztOV4RWcgsi7nz+Ho3WV67aM8SWgP8dk=;
        b=QE8ZWp15FCKtf7ul5P0pcoWvmGLphYlEX/THufoC8+3G8KeEx5Yed4WcmrYYv1BtgG
         QEaJPLo5aV9wJOe+pRn4LIdvsQFxLs+V93fe56lhEFJLIs6HWaJQcJrvxKj6LcZUZaRk
         PShvq4rxbfn6iUfQ4+KXAEF6OV9xqcMARwE4GT7bn5Gxroznv2Zz5vAN8sei8bzyQcEi
         ecZFGCt4Ft41F5UG6cTfNDTlgi5ZQPnppIyDzBreMg0/cWrXce8Ht5frB63alAAMrXbf
         Dsi447CfeZbkuLP8HN8545AAoUbsEDUbyLhY8/JZ0gYBxBDmCio76tmn07vY43cydOtX
         Eq7g==
X-Forwarded-Encrypted: i=1; AJvYcCXd6Rsq2YEQrBMSaSXIYIH+L2oNtqpMqlzJKvjasJSYirMqpvF1qEGtrLbF0dYdh0lZRuMfGK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfz2aueEfS4TVoDB4RuMRfNJX69fESu8DIDOoRtNB7Vy3vmCd
	cLXavdzyqTGAb54xSkoQZxn+d6rwSvxbHWpLAsGdZ3ghM4FibUXEdMc+1uHwqgrg2Qk1RNfLvkn
	+SfSJ6/tcXLtSng==
X-Received: from qvbok32.prod.google.com ([2002:a05:6214:3ca0:b0:888:7fd1:62e8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:226b:b0:87f:fffb:b7af with SMTP id 6a1803df08f44-8942d5f7c7bmr28632836d6.1.1768536840773;
 Thu, 15 Jan 2026 20:14:00 -0800 (PST)
Date: Fri, 16 Jan 2026 04:13:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116041359.181104-1-edumazet@google.com>
Subject: [PATCH RESEND net-next] net: split kmalloc_reserve() to allow inlining
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

This makes __alloc_skb() faster :

- kmalloc_reserve() is now automatically inlined by both gcc and clang.
- No more expensive RMW (skb->pfmemalloc = pfmemalloc).
- No more expensive stack canary (for CONFIG_STACKPROTECTOR_STRONG=y).
- Removal of two prefetches that were coming too late for modern cpus.

Text size increase is quite small compared to the cpu savings (~0.7 %)

$ size net/core/skbuff.clang.before.o net/core/skbuff.clang.after.o
   text	   data	    bss	    dec	    hex	filename
  72507	   5897	      0	  78404	  13244	net/core/skbuff.clang.before.o
  72681	   5897	      0	  78578	  132f2	net/core/skbuff.clang.after.o

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c29677f7857c504720c4c4d57c7395ad68318484..f2367818c130bcd3095e9bd78fbc9f9a0ac83d4b 100644
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

base-commit: 74ecff77dace0f9aead6aac852b57af5d4ad3b85
-- 
2.52.0.457.g6b5491de43-goog


