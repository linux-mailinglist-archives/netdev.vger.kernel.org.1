Return-Path: <netdev+bounces-238664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F0BC5D0D0
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3D6A4E51A1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D63128C0;
	Fri, 14 Nov 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucOGyjer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31F3148DF
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122370; cv=none; b=ohS+MoTN2Bo/AthaBBPZsP2r5/6VSzr9Q1dTVoEh8L/x9+jpjrN2GADkYl1I6TpsfhJwE1JQasmOxRIeXtdJSPFLyZTsQmRhgIG4jNakVZuFjw3KZOmzAs5FJyRKoKn2aRy8x7XNZbIcrkPjvDQ5WopbXZ4jd1KMTvJkxbfrP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122370; c=relaxed/simple;
	bh=D5nGjUdj+Z7jIs93m2w6QSJ7eUfL9tYpaZ6lZr44vog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jnU5f3uWJuyc5ChAFoD/BGytVMNYqMmmD6LYtm6IGqbiDXO4zCI+DQ83GWG4N+oLQ2UKbEcaAvYp5V+z04Cu2eh7PUmFdY722N/YgIS+Z0qw0Q50Y988I+9uJiPatw8hwNlIvYb4XCPYxLl3Vs2xOTRUR4y849fWwAIvDcVE7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ucOGyjer; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8824f62b614so51614636d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 04:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763122368; x=1763727168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDFuXutF9ncLY5riEDMM2uP0Czks7Hw72D3AlMQS0bU=;
        b=ucOGyjerke94MQ9V245ARVs4RTP4a2gNFMNetnnBDTgc7vNEDXvpyb6CNt2HyDJYqM
         i+zAiR98Gfix1PktKVVykoHyJXtUNBtCDScdZ/UD7+rZqv68n5AOPLsFI+YOQcJbsUsS
         vlBOkdM3+SpaGlRWiT8vfSMENUkGEceUFesR1qi0aU0JF6FrVzqrm54kzLjIj1zRuHf8
         7NLMViPJj+YXqlBVDWARqblbsAU3lo06YUNEIar8IFCSRtLDCV8qY6Ywg+q5A4/zIJhs
         qP8hr8UXGlvv3thlBo+1Skdkah5mIRs9XeycOvF9DjKblGsLjQOVEEKaS6O/bESv2yFJ
         AaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122368; x=1763727168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDFuXutF9ncLY5riEDMM2uP0Czks7Hw72D3AlMQS0bU=;
        b=c7EG4dHOkM636e5wFHB3qfmOusXke8YerClVKLG63XrzXH7GRYa1N9MmzI8EX0KUP6
         2++jGSeuewpkbjgZHgIngdJ4H6OZN9XObbFd5sEzhFIzMvEpN2RS02hFPdJDRP1K6Fmt
         7VNsXY53fsHHW/ya+ko72cioBFdXhegepmUzBCJqLFXmz/wk8n93gYG0UcWbfUM547yQ
         qRsB8ChLk6fNptPNXTlfsVBXX6Has2f5lvD1+xaeWQuvLR5eI3o6A47TPeGt20NDWXLm
         ctLKV0mkf7Ak456lPv9Z0FunhyFtt3udBb7E+i8am57kzA/dzWz7lFm/fQ7BDBUTbDiv
         DAFg==
X-Forwarded-Encrypted: i=1; AJvYcCVCY+zBk9sWsHIbGqBkxsvGeken3fdIlIBf5HSJxKeEbOeEKnV/69hcv9NyvtSFdK6E/4r7gfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DSPGvb4pRodJUxY4mLwYKaxdBOKqfWn0Xgt1k1lLWETpncr1
	Es7MglvoTqh4+8Mbfxbw/eVv3bV18oiv/LcH8PKfQHfCr9Xy107KV7Jz6jgqYgclDlV5Nkqe3Wd
	g2tAO5qH8ESccPg==
X-Google-Smtp-Source: AGHT+IFNeI+qodJsf61LQYPuhwf50dRAJhRdyu7At01qYyt76HsROsFCIAQ3fZzcxnqhHc0Bkwto/nK0YMZ7zQ==
X-Received: from qvag10.prod.google.com ([2002:a0c:f08a:0:b0:882:4ab2:bc10])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2422:b0:880:4219:62c1 with SMTP id 6a1803df08f44-882925b9025mr32020166d6.15.1763122368193;
 Fri, 14 Nov 2025 04:12:48 -0800 (PST)
Date: Fri, 14 Nov 2025 12:12:42 +0000
In-Reply-To: <20251114121243.3519133-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114121243.3519133-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114121243.3519133-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] net: __alloc_skb() cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch refactors __alloc_skb() to prepare the following one,
and does not change functionality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 88b5530f9c460d86e12c98e410774444367e0404..c6b065c0a2af265159ee6188469936767a295729 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -646,25 +646,31 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 			    int flags, int node)
 {
+	struct sk_buff *skb = NULL;
 	struct kmem_cache *cache;
-	struct sk_buff *skb;
 	bool pfmemalloc;
 	u8 *data;
 
-	cache = (flags & SKB_ALLOC_FCLONE)
-		? net_hotdata.skbuff_fclone_cache : net_hotdata.skbuff_cache;
-
 	if (sk_memalloc_socks() && (flags & SKB_ALLOC_RX))
 		gfp_mask |= __GFP_MEMALLOC;
 
-	/* Get the HEAD */
-	if ((flags & (SKB_ALLOC_FCLONE | SKB_ALLOC_NAPI)) == SKB_ALLOC_NAPI &&
-	    likely(node == NUMA_NO_NODE || node == numa_mem_id()))
+	if (flags & SKB_ALLOC_FCLONE) {
+		cache = net_hotdata.skbuff_fclone_cache;
+		goto fallback;
+	}
+	cache = net_hotdata.skbuff_cache;
+	if (unlikely(node != NUMA_NO_NODE && node != numa_mem_id()))
+		goto fallback;
+
+	if (flags & SKB_ALLOC_NAPI)
 		skb = napi_skb_cache_get(true);
-	else
+
+	if (!skb) {
+fallback:
 		skb = kmem_cache_alloc_node(cache, gfp_mask & ~GFP_DMA, node);
-	if (unlikely(!skb))
-		return NULL;
+		if (unlikely(!skb))
+			return NULL;
+	}
 	prefetchw(skb);
 
 	/* We do our best to align skb_shared_info on a separate cache
-- 
2.52.0.rc1.455.g30608eb744-goog


