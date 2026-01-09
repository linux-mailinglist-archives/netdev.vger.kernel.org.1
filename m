Return-Path: <netdev+bounces-248594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C032D0C31D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 21:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB2D3011EE7
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9462C0261;
	Fri,  9 Jan 2026 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfamUWW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D919D8BC
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991119; cv=none; b=fWp5lMGyP2YPyeXxMrYSwVRlK229Nq0rB7d7hkkzZKDs1bfZePDOeRPqkZ2lyTEiIclqsWnMcWRLrfKeK4ifjsSgHtKILKQdo6AUtcyCRmqK1rYNQdIv5+fH1U7X2ewKcK6WBL0tNGq8s3AZpwEpNNiVu6KceEIYYW7gALfOkk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991119; c=relaxed/simple;
	bh=f7+sMrZHlfAsi3+Jv7WOamgyURVsoUvBNgNFKtiO20k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zp6Ei4RBvaNtXRQuq25LRLrQOjrFNJrdb+OJy0BWHGtJ83rKZav1hRctiDr8N74KdqMAIItMdEqobr6cStbQIK1pP0U8y3g0o6/La9EnGwsSjPI6FtVhovmWdOkXM3x1Gkc26UI8eaf0wqGTyrwsyZuLLkF2X2Kl/+j0uFeD7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IfamUWW+; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b17194d321so707942785a.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 12:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767991117; x=1768595917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kh+cz1B920YVvkrGfGEZk1tGntYQ7a/uCSlT0riZRSQ=;
        b=IfamUWW+MyW8nPWgLucD95v4//QhZdyfEz7j0yct3s+uqR5atCn3oPx+9e99ndalAW
         F1u2VIs1cIG8Gq1nsdunnVWlg43uooxMGIN9/lSRj9oiGCptZ3ElfqQn2nz2TZDucesm
         EqiDTXcjh8Yg16UqMkkrBN5bz+lXG3DwEHKvYgyEzSMfmCWmkI3a+7ftri52mG1Qe3Hy
         w8E4Ntrxwn4pHbVocg2eBxGpULki9BqxGKNQKag3k9nWD+N2kkpEf32CDRcQomKVuJpo
         QpwwpW2M2jIQx7lmIK5KQAM8B9qAe4wwx54RTbKFx+eh71SFfEXkVM+fYbIUtY6DZ9Jy
         aKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767991117; x=1768595917;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kh+cz1B920YVvkrGfGEZk1tGntYQ7a/uCSlT0riZRSQ=;
        b=oAqHKf13RPuGOlBebZNn6rgdjOlaAqGEG6dN/dDHpuOnbUUKm9/5XM78bcCPn+KT0F
         T6grWA3lGSFzQebRzNHwN/dB/hfx73HGU+kI31zOFKX6d2StUuNWAdTjBjztZHZTK4hJ
         GMTlY9TVVhGCsRNmIjshjBt/1Ob7OB1yOqVOX2jqktLphMCIchEqFDyey8/+CKv8K7Xk
         XaG58mFMCI1AOPMLeI797oxiFQ2/761eF5SlEWaXaQgkXnJ265zSp/UVv/XbuMRfbeao
         jkHlaaNyPbnexLZiGfL5etjdNprH+eVSPGJlkvvQurSVs3U+8wocR92oNIVcWmGPvJ1z
         I58g==
X-Forwarded-Encrypted: i=1; AJvYcCVQU8L9oJfsUq5gvi/+c913p+ROhE8dwXoeT0tLYu3vThaNr4XcMUQrreZT5yOvDjZy8guD4Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUV+eaRPCi4POC4UpQUJAO002KbqZS66TUGWqB/+kXIUCjVqX3
	MUUi1Ablh4aQw0vGzmJdp3d5tWUOr+G4KRvTmw8xZ27SX4pOE5w9d8fUMGqu2bAnoMv10uEIFxn
	SGJlclcb5ERJh6g==
X-Google-Smtp-Source: AGHT+IH9vLd1SihwHXsfcJK8UUdMdQy8YIWKkK7xUOABzkEkzOe3966hA10ektVOm3BUgEQ4LVMDXsAWXRzv+Q==
X-Received: from qkntw4.prod.google.com ([2002:a05:620a:3ec4:b0:8bb:3a38:851d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a09:b0:8b2:e5cd:fa42 with SMTP id af79cd13be357-8c3891b060cmr1501072385a.0.1767991117162;
 Fri, 09 Jan 2026 12:38:37 -0800 (PST)
Date: Fri,  9 Jan 2026 20:38:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109203836.1667441-1-edumazet@google.com>
Subject: [PATCH net-next] net: add skbuff_clear() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

clang is unable to inline the memset() calls in net/core/skbuff.c
when initializing allocated sk_buff.

memset(skb, 0, offsetof(struct sk_buff, tail));

This is unfortunate, because:

1) calling external memset_orig() helper adds a call/ret and
   typical setup cost.

2) offsetof(struct sk_buff, tail) == 0xb8 = 0x80 + 0x38

   On x86_64, memset_orig() performs two 64 bytes clear,
   then has to loop 7 times to clear the final 56 bytes.

skbuff_clear() makes sure the minimal and optimal code
is generated.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a56133902c0d9c47b45a4a19b228b151456e5051..4887099e8678352a62d805e1b0be2736dc985376 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -307,6 +307,23 @@ static struct sk_buff *napi_skb_cache_get(bool alloc)
 	return skb;
 }
 
+/*
+ * Only clear those fields we need to clear, not those that we will
+ * actually initialise later. Hence, don't put any more fields after
+ * the tail pointer in struct sk_buff!
+ */
+static inline void skbuff_clear(struct sk_buff *skb)
+{
+	/* Replace memset(skb, 0, offsetof(struct sk_buff, tail))
+	 * with two smaller memset(), with a barrier() between them.
+	 * This forces the compiler to inline both calls.
+	 */
+	BUILD_BUG_ON(offsetof(struct sk_buff, tail) <= 128);
+	memset(skb, 0, 128);
+	barrier();
+	memset((void *)skb + 128, 0, offsetof(struct sk_buff, tail) - 128);
+}
+
 /**
  * napi_skb_cache_get_bulk - obtain a number of zeroed skb heads from the cache
  * @skbs: pointer to an at least @n-sized array to fill with skb pointers
@@ -357,7 +374,7 @@ u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
 		skbs[i] = nc->skb_cache[base + i];
 
 		kasan_mempool_unpoison_object(skbs[i], skbuff_cache_size);
-		memset(skbs[i], 0, offsetof(struct sk_buff, tail));
+		skbuff_clear(skbs[i]);
 	}
 
 	nc->skb_count -= n;
@@ -424,7 +441,7 @@ struct sk_buff *slab_build_skb(void *data)
 	if (unlikely(!skb))
 		return NULL;
 
-	memset(skb, 0, offsetof(struct sk_buff, tail));
+	skbuff_clear(skb);
 	data = __slab_build_skb(data, &size);
 	__finalize_skb_around(skb, data, size);
 
@@ -476,7 +493,7 @@ struct sk_buff *__build_skb(void *data, unsigned int frag_size)
 	if (unlikely(!skb))
 		return NULL;
 
-	memset(skb, 0, offsetof(struct sk_buff, tail));
+	skbuff_clear(skb);
 	__build_skb_around(skb, data, frag_size);
 
 	return skb;
@@ -537,7 +554,7 @@ static struct sk_buff *__napi_build_skb(void *data, unsigned int frag_size)
 	if (unlikely(!skb))
 		return NULL;
 
-	memset(skb, 0, offsetof(struct sk_buff, tail));
+	skbuff_clear(skb);
 	__build_skb_around(skb, data, frag_size);
 
 	return skb;
@@ -696,12 +713,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 */
 	prefetchw(data + SKB_WITH_OVERHEAD(size));
 
-	/*
-	 * Only clear those fields we need to clear, not those that we will
-	 * actually initialise below. Hence, don't put any more fields after
-	 * the tail pointer in struct sk_buff!
-	 */
-	memset(skb, 0, offsetof(struct sk_buff, tail));
+	skbuff_clear(skb);
 	__build_skb_around(skb, data, size);
 	skb->pfmemalloc = pfmemalloc;
 
-- 
2.52.0.457.g6b5491de43-goog


