Return-Path: <netdev+bounces-238980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1313C61C3E
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C35BA4E51A4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 20:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6E222578;
	Sun, 16 Nov 2025 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmzBjrSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CAD531
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324842; cv=none; b=Wqm8n6ZdmCnl9qWXaK93HdziaapKy1ay+X7lSHitZlMnogUNgFPX5pXoLQHdNSluMxImshUMwcUGZ8z5Tn01Y3/maKSFc/qUgYC676BUd1nrLrPbNsaeQ9aR79EZe2SUjlQ3yEQsOtSIeVm6TmdP2gowH2L7ShlzUCXWdUNgbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324842; c=relaxed/simple;
	bh=jmhFeM7KUC5lXHxTzGXScPXnvmD60BjarMDkJUmePWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R7xykqM+2ufLMlIW2XbX/pvOPrNpaqSGttUBpx021FmbW2Lj6FJK41gxXEKPwCzqUrNVIv3w1r7q4Bt4HCqj3e/2zAWf1dOKrC9+5WsWG0z/VTKCOW4cgh/JHCv8U7JiXSessGTwsB2XGiGoTmPasrLABxsE3tDJYQgxYc4M19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmzBjrSx; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-880501dcc67so105073686d6.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 12:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763324840; x=1763929640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzd6Qe6zazmrenez7ejtbNEz2gDxYKs98VgwUaUAxSk=;
        b=RmzBjrSxYj1m93+w33Mcmwdxh5S1HbVPDK6VrUfCBvJ6W8WbcXqVOYcs0ev9FE3bYR
         1M3VSmOn7EvNRTxDk3QsNRtn88YBXaC1/aEXT0daxwsz2wkxbXiCOOK4nacyHTGgdzgG
         mmpVrblTA8Ua2hEyjw8oe7dg+ehZrYAAqQHE6+3JhE5Yfb9YAu+hHvpGyZyPhEwTa07o
         fZSRLtF+3UjMk0ul9pmNg64Ssh5SZTP/tb6m8T0o37cjJdO4p+8K3rpYS7A+r5/mxFGd
         zPdFufuXXrwOecBbwmVz7MKENK7dOLih9QcuruQBT2B6DMRuQjSoE76O2O4HyxaLoETz
         xldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763324840; x=1763929640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzd6Qe6zazmrenez7ejtbNEz2gDxYKs98VgwUaUAxSk=;
        b=BYkeYcjiIl38W7AICrMOZte/zXXmZvlZzETFQTo46Qf6kbMAx3BpiFktCij9TTa4VC
         nY/GF9lk6vcUpmRD4uDp8YUMtk2VnMxaCqaHhVEMrgYU5HF2u6TI+9DupNNBotKjRTpc
         82pN6DkphCmP+m89uZF90XCXnwfUOYrQLGSbEELAVtA4h+Itdi/QxeHDlynZPsLy/utC
         ghV7JDd7fkDVGDt4166VtOSBl423LOahyRAzbWBmbKOEQmM4kmV/Z6hsoh7VarteXnZO
         WPYJP/WHfGSD0lmls+j+xiUDMW4hfjDKfHXm7/48WMPBQpAMGoI06P1dbOKzen3Xtr7q
         6/zA==
X-Forwarded-Encrypted: i=1; AJvYcCXsmBsOSmEluiVOiRJasxUuXIKRlK+9yHsoz+1H/bio3aV7qlTaOo+F6YoHt++broVeegHFHko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOdch+pr7zaT1dbo9MhEi7OLGsPYhLr4JPjKJw70GL3TS+nb/
	XRfboEtfPMRJgxoI00eg1m2AWANX5FA4/NDis/fHjX+mo/Y4qZ3gejcyFT3gzEWBP9rUYchqO/T
	+zn5DQeA2sRmYKw==
X-Google-Smtp-Source: AGHT+IE7LxjqeGe//dKkNQX+odABH246j+zWnRO/Mqno0ncjA6sRUlAgc2UIvVHYpuMsVCIHGlxmC9lwz8Qd4w==
X-Received: from qvab8.prod.google.com ([2002:a05:6214:6108:b0:882:3d90:469])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:c28:b0:802:a79d:3132 with SMTP id 6a1803df08f44-8829267c1c6mr145512116d6.47.1763324840099;
 Sun, 16 Nov 2025 12:27:20 -0800 (PST)
Date: Sun, 16 Nov 2025 20:27:15 +0000
In-Reply-To: <20251116202717.1542829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116202717.1542829-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/3] net: add a new @alloc parameter to napi_skb_cache_get()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to be able in the series last patch to get an skb from
napi_skb_cache from process context, if there is one available.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f34372666e67cee5329d3ba1d3c86f8622facac3..88b5530f9c460d86e12c98e410774444367e0404 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -280,17 +280,18 @@ EXPORT_SYMBOL(__netdev_alloc_frag_align);
  */
 static u32 skbuff_cache_size __read_mostly;
 
-static struct sk_buff *napi_skb_cache_get(void)
+static struct sk_buff *napi_skb_cache_get(bool alloc)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
 
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
-		nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
-						      GFP_ATOMIC | __GFP_NOWARN,
-						      NAPI_SKB_CACHE_BULK,
-						      nc->skb_cache);
+		if (alloc)
+			nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+						GFP_ATOMIC | __GFP_NOWARN,
+						NAPI_SKB_CACHE_BULK,
+						nc->skb_cache);
 		if (unlikely(!nc->skb_count)) {
 			local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 			return NULL;
@@ -530,7 +531,7 @@ static struct sk_buff *__napi_build_skb(void *data, unsigned int frag_size)
 {
 	struct sk_buff *skb;
 
-	skb = napi_skb_cache_get();
+	skb = napi_skb_cache_get(true);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -659,7 +660,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	/* Get the HEAD */
 	if ((flags & (SKB_ALLOC_FCLONE | SKB_ALLOC_NAPI)) == SKB_ALLOC_NAPI &&
 	    likely(node == NUMA_NO_NODE || node == numa_mem_id()))
-		skb = napi_skb_cache_get();
+		skb = napi_skb_cache_get(true);
 	else
 		skb = kmem_cache_alloc_node(cache, gfp_mask & ~GFP_DMA, node);
 	if (unlikely(!skb))
-- 
2.52.0.rc1.455.g30608eb744-goog


