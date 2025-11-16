Return-Path: <netdev+bounces-238982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5AC61C4A
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 21:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C6514E4594
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8A25D53C;
	Sun, 16 Nov 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0cNi9jl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA026B098
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324845; cv=none; b=HSyYFyzojBr8c3dDkYe8YDcxwGwGnmuQ1QjhUODcMUIqJRdy9dyzpglor3DxTypxuGG0QAxNrCNGwgN2RZoVgVe4pkzF+wfKjM9C7DnvcOMNki6dKJDd22aVJ1QkHK4S2pDpqrUXYQXajVS0Y37nnb0bVVdE3Oujhj6RZP3UiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324845; c=relaxed/simple;
	bh=ViNLTiGxYko8PGwMN9iLpI6kqqMRA7t8GOD5lDlrNWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QxOcRPZW1QJg9VNpxfnOPjdndPap3wdGVc5XsLrpbgurm/aY3U/BZgOPzbuunqDM2Tn9rM3rt++fpAyT6/iKpnx8e/CtI4N1CXLZosUFvsP6tbDKE1W3pgOy2jGn54aRv5s0ROi+zCRlQxwBy/9Y8f7le6BFtTgPP+y/4gCto9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0cNi9jl; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88238449415so202414966d6.2
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763324843; x=1763929643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUG+S+zQqmMhHcnQNORKTDA1Jaq2nQyazNTIui+3xa0=;
        b=M0cNi9jlNq7YI+7lt52oyjUUj7elueXY7K/yiyKr9CGxP7cUjCPw3GOydv105LOPMs
         EZAitxroen5RxKFrEJgc9LypEWWZEyVF4IotXdao0Zh2NPlO64HcSstBLbFdb5PW6UaF
         IBg2T3i5GeYV+GNldW1vq2nLA5+XB5cSgPiC2auv29Xy/UPMmJiHLnfnxQt3Pa+jDpum
         rc3MYcF2nXIwqZYIPFo8yjqLkt7PjqrZb1lxh8Xhp8yAcj6KiYD2oZCSzBGZ+eXgUbR4
         /0haAkRnRTqq7zD6BRggJvP3Mou6HVoFal6qUbhmFqQ6YWjESO3xATp0xzrEIeFtYd/Q
         Qz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763324843; x=1763929643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUG+S+zQqmMhHcnQNORKTDA1Jaq2nQyazNTIui+3xa0=;
        b=Y6c5tjT9MPgOPYR3I1g7VoK8clLI2HGcvkEAB9bYpT77wC+FBBjo9UWgvYaLbcdOPx
         pNqX9QsG+F4mj259bjoEe47jCnm6O586BFIpuE7Q2xvzrcWls07+aYqkZ4ty+7qIZHtd
         /unS/2pUVKpvBTsoNPQzzRdbqURZzB483gVY94BggR5/6tvwEXkI/2IPsUmO0rb3I7Jn
         CqWp0QfMxLRbuZJP483RwRSnkCTyIwajD3xm4NMXUrvH+BY9nrt9wzfy+o1Yfn0VtF/j
         oTpdj5KZwSbmdeY6xvlA9CmBBJpEvHl4wCNp5D/RNcLHS3+CMPAdsaJg3cZ5PuJvVY7K
         y51w==
X-Forwarded-Encrypted: i=1; AJvYcCXCTGYE2Rfjysg+gpqK2eAufP0zPJ8oOLS+eG3cjXs//iqgHmZeeHMeucHab3v8LNGTkAa80zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9C7tAsOEBWhKA3PqpHmiFH5VsFK7UFRTr03EinLY0lpNZE2F0
	lZAa7ZuSgXf4x2ncAdty0iuqjtHOL233hptWDsH8xyDJzrt5I0+0CXP1z1aoGWKMsAcEaAcEuXh
	2PzVTwJh3c77IMg==
X-Google-Smtp-Source: AGHT+IHB5B8NPGv8GEL22ROiWLDVOvOCbvUhuQnXzzoliGq+WG8xEGe4FauAVSUC8VpiphHL634JuHYZVQ1r+A==
X-Received: from qvag13.prod.google.com ([2002:a0c:f08d:0:b0:87f:bdac:73a9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:410c:b0:882:49f4:da20 with SMTP id 6a1803df08f44-882926b17ecmr170252646d6.35.1763324842943;
 Sun, 16 Nov 2025 12:27:22 -0800 (PST)
Date: Sun, 16 Nov 2025 20:27:17 +0000
In-Reply-To: <20251116202717.1542829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116202717.1542829-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
with alien skbs").

Now the per-cpu napi_skb_cache is populated from TX completion path,
we can make use of this cache, especially for cpus not used
from a driver NAPI poll (primary user of napi_cache).

We can use the napi_skb_cache only if current context is not from hard irq.

With this patch, I consistently reach 130 Mpps on my UDP tx stress test
and reduce SLUB spinlock contention to smaller values.

Note there is still some SLUB contention for skb->head allocations.

I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
and /sys/kernel/slab/skbuff_small_head/min_partial depending
on the platform taxonomy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8a0a4ca7fa5dbb2fa3044ee45bb0b9c8c3ca85ea..9feea830a4dbb61c1c661e802ed315eaeebcc809 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -666,7 +666,12 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 		skb = napi_skb_cache_get(true);
 		if (unlikely(!skb))
 			return NULL;
+	} else if (!in_hardirq() && !irqs_disabled()) {
+		local_bh_disable();
+		skb = napi_skb_cache_get(false);
+		local_bh_enable();
 	}
+
 	if (!skb) {
 fallback:
 		skb = kmem_cache_alloc_node(cache, gfp_mask & ~GFP_DMA, node);
-- 
2.52.0.rc1.455.g30608eb744-goog


