Return-Path: <netdev+bounces-151211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1D9ED85C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B47282CD1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E541EC4F1;
	Wed, 11 Dec 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUavxQ9e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FA1E9B36
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952038; cv=none; b=ObOHR0PJqSvDE0EH8n+9uUpR+xP3UJ+P3L1lqhR8CZ88JHUVLZZl+eHdRBvnfLlykyXnkkhEdn46/MA9GCrbLY5XlZ/FYpQkfT3GbcmYGNh6nef/RMpgjCS+bxuVEUo0bfrbhq8dyjnmmxAYA4jnMQgz1pNhlKt9Caduhq4cRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952038; c=relaxed/simple;
	bh=inYtJTadn/ilQufeg2hRjROOpb6WnuRJ/R3Eo2kT9Ak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IAwZ9odfhGHPzN9zZ7Hx4f0V9j63pBTX4IoW06Rbaa3n1IbYVJoeIYQL1+lo7Sy3vT8itTOqve5EGwrQLloDnPnwDSR8r/DXBz4n+0ISM5vCQ7m0uRhNF2oFIvifCEC6ezh7RsynaIN/vC3ye/shlSJGVMCp8NOlTgB59OPdnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUavxQ9e; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee8ced572eso7473609a91.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733952036; x=1734556836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rD4fHb5o8v+27TSL8zHXq3Z19Qh3ytPkt3LCpxEoKxE=;
        b=lUavxQ9eRMEmBsI3lEvBBfmHbFKLjv9u0oR1LJycr9qZR/4l+FLLOTEzK5nkeeDPoX
         WmuXZRRrBR84rXRgeqde4QdYXcvSLGAtKNqpBQJ7dAM/JMeaY2Cl8aRtavgFpKc84nK2
         mEeEGWCX60SkfJLqBnENNJSq1R0wnTp/QbZe3Y5o8QGrRxu8JcUE4I90lnRp6I+kLz/B
         nNfGfNYLHYuPiaZmFl/FCi/aghtfdHb/EseZT2ZZGQF4IcfVhww6/6ZqPjd7LYZJGLQ5
         YeoUHSPdLYB7gSMCBVxOa8lveYRLaHTV9hoGiGuml6XcQc0udU6g6VwYN6tJ5PtwQEOm
         1JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952036; x=1734556836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rD4fHb5o8v+27TSL8zHXq3Z19Qh3ytPkt3LCpxEoKxE=;
        b=XN1QRbOULsRqieMk8FnCpayFTPG4n8BNJyZ8Ntoz6yvbyByesZKnYrQNIcbIyZf4pj
         ZUiwjJKUjbQGBBsfRobko8KTw1+ICYBKpDzaoO+ei48t1Oup4BeZGfGS4duufHcZS+qG
         UIkkXqicPwfPIl7S8GCILvww1pDoftFp6H0soO4M148hN+EdEO4ppabGcdAsM8v0XJTc
         PQTofaHtj6Uo19KTmbC7syzI6031e8EGcp0O1jYPNVB6RVKZ1dUa9+Uvwga+BjVTvHOV
         5qh1jmw1P9KD/OsfwABQrBQALD6OJ8pjGCXJONcpTiT/2vBCzi9YhX5riDUDFhrjVobJ
         KbFw==
X-Gm-Message-State: AOJu0Yxej+m0t3UmvcHOQOIQPmZsXSjZq6ss32MJO0QxDxIipA1v0pWB
	B6Fo3ybSX7kGo6WOWPnUSTWNX1tAZDdckiR3MSyX4cbnjMUG5v1WiOuWwPLtwbHrVw4X6975zqK
	aoH8PaL+pJrezs2lQk7bPKDagSnmq3vgc1ypKu9Ly3rE9CTH6ybFchdNoY249NDKv+I5acnpguc
	/7ijh5/y6JPo/Uftk7nECEq7Q5h+UU89Xnz0PIaX5DrmTMCjUhIEC5vYbZS6M=
X-Google-Smtp-Source: AGHT+IHYrU+SD7vPYOEQ3idsKub4yW3CEQ29DrUylYyi6L34qN5kVr/+aOtP9HfJhrQ9YokFfMxe3gTS5yVuZy+J1w==
X-Received: from pjg16.prod.google.com ([2002:a17:90b:3f50:b0:2ea:4a74:ac2])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:510c:b0:2ee:e158:125b with SMTP id 98e67ed59e1d1-2f128032774mr5992885a91.26.1733952036117;
 Wed, 11 Dec 2024 13:20:36 -0800 (PST)
Date: Wed, 11 Dec 2024 21:20:28 +0000
In-Reply-To: <20241211212033.1684197-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211212033.1684197-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211212033.1684197-2-almasrymina@google.com>
Subject: [PATCH net-next v4 1/5] net: page_pool: rename page_pool_alloc_netmem
 to *_netmems
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

page_pool_alloc_netmem (without an s) was the mirror of
page_pool_alloc_pages (with an s), which was confusing.

Rename to page_pool_alloc_netmems so it's the mirror of
page_pool_alloc_pages.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/page_pool/types.h | 2 +-
 net/core/page_pool.c          | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1ea16b0e9c79..bd1170e16cff 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -242,7 +242,7 @@ struct page_pool {
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
-netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp);
+netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp);
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4c85b77cfdac..3c0e19e13e64 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -574,7 +574,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 /* For using page_pool replace: alloc_pages() API calls, but provide
  * synchronization guarantee for allocation side.
  */
-netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
+netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 {
 	netmem_ref netmem;
 
@@ -590,11 +590,11 @@ netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
 		netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
 }
-EXPORT_SYMBOL(page_pool_alloc_netmem);
+EXPORT_SYMBOL(page_pool_alloc_netmems);
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 {
-	return netmem_to_page(page_pool_alloc_netmem(pool, gfp));
+	return netmem_to_page(page_pool_alloc_netmems(pool, gfp));
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
 ALLOW_ERROR_INJECTION(page_pool_alloc_pages, NULL);
@@ -957,7 +957,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	}
 
 	if (!netmem) {
-		netmem = page_pool_alloc_netmem(pool, gfp);
+		netmem = page_pool_alloc_netmems(pool, gfp);
 		if (unlikely(!netmem)) {
 			pool->frag_page = 0;
 			return 0;
-- 
2.47.0.338.g60cca15819-goog


