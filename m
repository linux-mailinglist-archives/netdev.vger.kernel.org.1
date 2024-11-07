Return-Path: <netdev+bounces-143076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7229C10E3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B17FB225FA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD67218D80;
	Thu,  7 Nov 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvvZHTSc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A81218931
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014600; cv=none; b=u49NxiynUfEO0eGz1OAmG2/xc4oL3bXqNS6acmly/5CuQuyNyNU8kie6CSCXAn4NFmgJ19qVzSnqmxA3EFJIulkpGIPoCaLE9J6CxIecsIlhtqnhXGZfVvMHj10a4vxNMx6T2pfZ41wJ5TbabAbn6GkNJcZq6kXk3uq0LfSdNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014600; c=relaxed/simple;
	bh=MvJ6yPQOrI6wahZADxfSEp4jdMsiVlhVUJM/vAV2fS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tycwDyBUiZz8fj5/YNbnCPOwwU7Weg0i6nV6PFmAq5c6fmwMuS18lPkhdCnbrhBWf+B0fuhAnohq9g6p/2T/EgjFg1tkkElosxGlfZC4c/mr1dGCWKIhqclohuOji7SI0D27UxU7q+t/QBfsK4EbIkzXM69OFAUvZ1XBI6JGPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvvZHTSc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3705b2883so27310657b3.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014597; x=1731619397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J83wfJiF0JQ+3oVDQ8yXRG5SdUbkoDbY+HbVcbuh1Lg=;
        b=VvvZHTScGjBhZdgsuFEa93EhYKmmQxRdWkoHnY328/p+Ll5mw+hP1n1OxjoILI82XN
         o3oaxBgILqZ4HJXJ8xh6E8e+a7Ypg/QqIO5YrhNwUQqZEKRQwF0qY7ZriSSwajZAkgIf
         KsUyt+Yaw1gRffdhVO+xkhS1PpUz8M/h0uect80zoz+LiiLcUe0UIyibCu0gfegDPw8c
         ISiTFd2I7rgWQyXVN7v0GIlcInJ4f2ueJL/LFNklTlppHhosoinG5cg0rbjU9sVhdlXA
         hvGZlbObGURLjMpWSyst+pA1QQBR4lS1+z3lrT7N1f66r/Ey/phKRbCW/uh7nyJnJj6F
         TEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014597; x=1731619397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J83wfJiF0JQ+3oVDQ8yXRG5SdUbkoDbY+HbVcbuh1Lg=;
        b=Be3JrOs7khm6smkD3DKQZonr0wJcYE4lJjzUMXTOPLMj+6Komo9xc7jpewypoM/NkS
         w41RL97kOYk59WEhSS/vee4Ym2ztf24BUT1DMmwdBuJv36FqHCyQ1xxt78D08CxSNcqz
         OEgZdslYJajraVe+hY7SytPjb76tl+7Jfa2D5qIURl2inJHeUIniwCg05HPs8KFOYDAp
         xnj5hkAbTfI6d3Sq6zzHNEoEeR4fVPDGU9yn8D0HCLDFSgt6c67ODlOoHXAAmwNgq0wQ
         KLYmog1yOBJ5y1tOM6zLjNnYSPo+4pk9YuqCqz5jQjKnmYUp7hCAAfxRE4FLHUHLFHbR
         ftTw==
X-Gm-Message-State: AOJu0YxM+reRpYZHImCG7TPHEXippzEbpMVQ4Q6hnykzfddGYMGjakay
	0uQxftyXNvyR2Rt/avVqDS+AUSoAX/UqKHsB2rp6Z3f6YgfyKN8hGv60yXkN3sKEsAikQ+xioPo
	9aiuFUvoG1u61fjHIH+/0uFVUrb0vKs9XIDLhFGd+q8nlfeMzwGGBR9y9SVNkKsufNWILw4lpC7
	qJZ+xxcsKAdZXN9uTP6vBWG3dI4bl1bK7OPeX5+LHxxgH5ye4KqOb3506DTyk=
X-Google-Smtp-Source: AGHT+IF6z/QPQ1XLZAvWGreuIWIzXwrgafM/eQRgTmOxVD278ef+a/phPaMZMGyLfa6rqPGjMSbh4Q8VmdUVJC+pTw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:a249:0:b0:e28:e510:6ab1 with SMTP
 id 3f1490d57ef6-e337f8faff5mr344276.8.1731014597352; Thu, 07 Nov 2024
 13:23:17 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:06 +0000
In-Reply-To: <20241107212309.3097362-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-3-almasrymina@google.com>
Subject: [PATCH net-next v2 2/5] net: page_pool: create page_pool_alloc_netmem
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.

This enables drivers that want currently use page_pool_alloc to
transition to netmem by converting the call sites to
page_pool_alloc_netmem.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool/helpers.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 793e6fd78bc5..8e548ff3044c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -116,22 +116,22 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
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
@@ -142,7 +142,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
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
2.47.0.277.g8800431eea-goog


