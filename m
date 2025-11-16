Return-Path: <netdev+bounces-238981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 600FAC61C47
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 21:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7947351E91
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B926B95B;
	Sun, 16 Nov 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dmnuisne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F0265281
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324843; cv=none; b=bLlgMljmH5VwCV9hhzfUn58g+xb1Qw437HtOIgaDk9tWdylnt6ItPrGiilFQu+a4L4kxq2UXSScP/e+POCmccnoE6VeW3u0jd4/GXFMBYoIuympMFWeLMTMHdA01Q5BzhPnXu6rp7HGvz7yIAywJRTYU5qTvlbHhWboJBuFv6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324843; c=relaxed/simple;
	bh=Uu/6iVq9uQb7eDSgxS3B4PPlIe43xrGfouKYkQoRjWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gMuLs+hoMMiSXxv3zYO4GAkIm2x7SazovTBWslPGJ8eIYtEE3E2UgqFVaZ6c7351WrwFrC8wSYfbRpJg9F2DkLXcUmPAdrwHDqgDpcbI/3nR1GJeixzrEKOZEiNH6Us93MhBjxeS0UwNROYYzU+Jvf/D/3xQsTqGIPiI3Yow+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dmnuisne; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88051c72070so89089996d6.1
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 12:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763324841; x=1763929641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDiyyl7/WexcdwZWlySlg+VgEeykJrmudY0yX2cFk5g=;
        b=DmnuisneuS8UC7XyZFc95eDovMT3DZzaIrMkezZihOoCdxaOYu1S8/+ieLNkpFbPaR
         lYT1YCRd4HCyfYyuacDHy8YTfBOzNELHCrAmfMv6q42qhCx2y5lrQklsv4vBs7jxUm5p
         3oLpoT+1k4klHTSnFeM4jVJy9mA2ep+RbBeaGxDkKXsf5eEY6YoVMIUR0v276AQp4p1R
         ogxoyx2reVu5p1MqtFfXFcz4w/ZUn4PYoukbXrUBHLuVRNwM/cw/ThJgRUnrqp1pCGZu
         ugVefKBfoAuFMZ33LbKbtKPyptBcDrLUQV7Mjtr+8CxLP6WAu++ekX8lWwE0EmcKrF5C
         HC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763324841; x=1763929641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDiyyl7/WexcdwZWlySlg+VgEeykJrmudY0yX2cFk5g=;
        b=Zc6JUq0kXCwi47Ac/z0/v7yIgzXjgigVACb0r6B4Qd9jhV4JVKPbUAK/KqLr6RQ6YE
         4+LrRMDCDc+xKo1XjKFZeXM8MGQ7dhy+L1HcBf/haXy3ZY95/NNn3WCDLFrdMCzTvBgx
         Z7bOa84Py9hVNTSTdIeMhSt4YlbTIv/ECT5H54IFgkHqxFSY4s67urvmBXo9Qg+94K7t
         rpejdMD9mkn9Rf+e90IbUUiYB+d/FfGoRzTN6rGuqRrmM7CCqJH8hwiYBlDig/V3uax9
         nnJ092pKrRU85Y3fURwQWc4MeEcMgWc+9n+ZwfwYgoMEPsRLFfgilf+4CJO8huVGpblc
         NDtg==
X-Forwarded-Encrypted: i=1; AJvYcCXA3JaAWWBOnp/t4VJuEWgAcbvmThdUCgecN7wyuO0tMEjoHsrCiXw9ec4beqz9LbCEHZ5qP4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzXbJB+BaeQ6GbYw6zqMQLvNNLGWI0I/T1zaUlcBVLyDCyoa8
	jFnWds1Um2YfXQcnfbxyCn1ZfoQLdn/fX6C4FEdFC/xIjg2QKbOiSOWXBTFiMnF3gykh/mhaNqV
	7PPmfRBHkMa9BhQ==
X-Google-Smtp-Source: AGHT+IEaRYygKThsPQDtLr73t2HeygmCLeXUIl5d+hw/VThXN+wXXDms/8iMMO+mzLEZ651oPoOEsHEg2aU9Rw==
X-Received: from qvab7.prod.google.com ([2002:a05:6214:6107:b0:87c:4bb:5d6c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4ea9:0:b0:87a:903:17bd with SMTP id 6a1803df08f44-88292609861mr124749276d6.20.1763324841362;
 Sun, 16 Nov 2025 12:27:21 -0800 (PST)
Date: Sun, 16 Nov 2025 20:27:16 +0000
In-Reply-To: <20251116202717.1542829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116202717.1542829-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/3] net: __alloc_skb() cleanup
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
 net/core/skbuff.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 88b5530f9c460d86e12c98e410774444367e0404..8a0a4ca7fa5dbb2fa3044ee45bb0b9c8c3ca85ea 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -646,25 +646,33 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
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
+	if (flags & SKB_ALLOC_NAPI) {
 		skb = napi_skb_cache_get(true);
-	else
+		if (unlikely(!skb))
+			return NULL;
+	}
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


