Return-Path: <netdev+bounces-151212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280F79ED85F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC222830A4
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D771F0E4E;
	Wed, 11 Dec 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWqXVral"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F31EC4FB
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952040; cv=none; b=eUWhouA4BVNVxyqowpW50tBUfOU6nYSbgzHBhSvN21oI/ULUMKhnvxumoBrskNM8AsuwMz4GCM/Y2nbE1dszsogTc16fJ4n2z75SaiTKEcumP/kpoah9nj12O66W2GRCi9uHsMqmm7Fylja5tprlsds7bawQFU5S9Rjce1/83zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952040; c=relaxed/simple;
	bh=3m4AIfXRnx+qjxTq4vCGjNR0f9YLSWQ6fISqEIE0hIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TIybR4F1gyGFns93fwY41A2h+9NxOotJSSTZTmxXtkzY3D3WokuVCUetTl4fxq5SZ32NAiPvtqxs7sT4S8KB8DiYkaXh+YrMzRwMXk3Xo3bxtOftVg/AQ0EeSZ4Wc3XZZQUT6CwvkvG/1e11Pkg9zlFZkMeHhl6QKANBh3sBB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zWqXVral; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fbbb61a67cso4077263a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733952038; x=1734556838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mA8UqtPkSm6GQfXzmIjEK9H6u29hiGHFb3M2KsrojFY=;
        b=zWqXVralWRnHS3P3g7jzVp5qP+IUiFeFJlYBpRDXiwybvAV8q73zgWe1vVLbDgel9u
         P4R/a9dYsIkhiZlFvObIuTis2ZKcNXgzRwaL0m/P+jlsocxyAV87Q/ZV5m+1ZSaJIR4s
         yGGux1DgYQ2n9q6+F9JQY3q8SZVb1gyOvTqLnKS5NPXK3bE6LGsjb0d0+WVFKR+mPTNk
         DaKdFD1x88XTeIjR4JUP/Uc09r5rySZI1ErBNjLPWU72GYgO/8YwnZGVE43m/cOKYkrS
         ISJtPmeZOLqJQq2unVgrXC9cuFj9Rht4UTtEoof2CHTAhFRS/aAC/p3Whh6B/P+1K+ji
         r+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952038; x=1734556838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mA8UqtPkSm6GQfXzmIjEK9H6u29hiGHFb3M2KsrojFY=;
        b=izyO//BV9/oRjlOzWa8Fi0Fulm8T5LQNedQ8PSMyciWLn7pr2+OS8ZnXvDieRPh0vl
         MF28gwUWKQujeUqN122yw5Fzjs4Td1MU9P066Ihivf3wkF5PnfaO48w0oU4Zud4UKl4m
         DqkelCBQWHTePoc5sOd0rcl7EpIx1p3ZWvdm5PEuh3jdnNYrixck86MqKHa4APxI34i9
         GJWFYzCowHhVfy9+4SoldTNYTnD63kYLSHLtc6Uxytlf3S3+7YhdYvy+tzD7z1sYQlNF
         fdHkQ8Syq46RO1Cg5CDT1ah+c9OqEa1zES5wupDLfHf1wVzje9cSirVAY01/PVeyxb+q
         gRvg==
X-Gm-Message-State: AOJu0YwDI1LA2nLd04FOY/hYSS9HMZcQ1okJr2CCG/26IBLePB3MhmNK
	Df+mNsuBP/w0B1jUaQmSZYnauCqoAl0EtFe6wV2YDQZ7sSWUSM70QDIvZ/zus5c6ZM/Nm7xRm1u
	nccJmOBUv9NfsrU7il3/kuvXrSsaBARCEviVNe+3JJV7RL5SI/yGqsfSeQ1r16dfG1VWbBbRmFA
	sjNUwtO3BbI7P/y0Ul7HeewGRh2ILXjw+okd+2QlUrruNugRpoOJ9wFqes9J4=
X-Google-Smtp-Source: AGHT+IHN1brNhEqwbjgxRfUmN4rKMrV4z/3BVdYGbVJagf+4pWYCGKpL+e4/y4yE3uGb17nnzh1gc+fCR05mYSThTA==
X-Received: from pjbli8.prod.google.com ([2002:a17:90b:48c8:b0:2ee:2761:b67a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3802:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-2f12803559bmr6406562a91.27.1733952037733;
 Wed, 11 Dec 2024 13:20:37 -0800 (PST)
Date: Wed, 11 Dec 2024 21:20:29 +0000
In-Reply-To: <20241211212033.1684197-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211212033.1684197-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211212033.1684197-3-almasrymina@google.com>
Subject: [PATCH net-next v4 2/5] net: page_pool: create page_pool_alloc_netmem
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

Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.

This enables drivers that want currently use page_pool_alloc to
transition to netmem by converting the call sites to
page_pool_alloc_netmem.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/page_pool/helpers.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 26caa2c20912..95af7f0b029e 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -115,22 +115,22 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 	return page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
-static inline struct page *page_pool_alloc(struct page_pool *pool,
-					   unsigned int *offset,
-					   unsigned int *size, gfp_t gfp)
+static inline netmem_ref page_pool_alloc_netmem(struct page_pool *pool,
+						unsigned int *offset,
+						unsigned int *size, gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
-	struct page *page;
+	netmem_ref netmem;
 
 	if ((*size << 1) > max_size) {
 		*size = max_size;
 		*offset = 0;
-		return page_pool_alloc_pages(pool, gfp);
+		return page_pool_alloc_netmems(pool, gfp);
 	}
 
-	page = page_pool_alloc_frag(pool, offset, *size, gfp);
-	if (unlikely(!page))
-		return NULL;
+	netmem = page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
+	if (unlikely(!netmem))
+		return 0;
 
 	/* There is very likely not enough space for another fragment, so append
 	 * the remaining size to the current fragment to avoid truesize
@@ -141,7 +141,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 		pool->frag_offset = max_size;
 	}
 
-	return page;
+	return netmem;
+}
+
+static inline struct page *page_pool_alloc(struct page_pool *pool,
+					   unsigned int *offset,
+					   unsigned int *size, gfp_t gfp)
+{
+	return netmem_to_page(page_pool_alloc_netmem(pool, offset, size, gfp));
 }
 
 /**
-- 
2.47.0.338.g60cca15819-goog


