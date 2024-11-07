Return-Path: <netdev+bounces-143075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D71439C10E1
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23EDDB21402
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730312185BE;
	Thu,  7 Nov 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEXhEdqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF229217F38
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014598; cv=none; b=GzHh358bPbBiOcPvcYmShnbxcPgu9kSaWKDKVmfP6Oufnb4S8Mn22riBwMtmukSgaNgfv3p+7CeE2EDJrfe6DZ0aMye5RqtXpRjxHzt6p+P4bTSzz1bbOY9GRiAHuCuJkdzJ5zpkzf3JbG0xSJmdobQAom288/FVyZdbGo2w0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014598; c=relaxed/simple;
	bh=zU771VywMfhHaMQg5hypX6J21hCCKxI+7oDPusRKQbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NMQWYN0RPjxLuNvFOYYdRuJQV8peh9UfX6RmhL+W7X/dBGVskun+XTWYApY/jiOUeeBXQ7lGvw+YBMf0raW/koqrNRTkK4p34oySAPVV2eOviPtOolTo1jm2hFtQYOrakn5EXyNEE51927Pv2aD+qcPZn+3oVfo2nsQfLAUesac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEXhEdqJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e297a366304so2298398276.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014596; x=1731619396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAZq9oy6Bl8obMNqEnRNBAotywvY9gCvI9My8ktbfNI=;
        b=kEXhEdqJaNPGNjReXtFogjSarfC5FImDYl44aTYtzxhYAS3b+GVDfrIceX+XpmHISZ
         AHFm4DCvPvvizFe2JSttuygckm9bAFZ/Zdb7nxKBm9ElExcFMtI7DIVi68p7nmbl14JG
         GjvdgS59x5S9A0ny6DOfsqt6c0WwehYQMQdHcAyG458DkeEF/VOgZIBHAXCCcO1wSGYV
         RnCo5ZGhwRI1cKQb/Tv6AKUKvzghVsUD0+YZ4Bp7ufBLUFdX1GaOFQnnoCen9J0+kjvu
         h1lSsLCe5jcXTU9xA8x6JWMFJrwRh3FrtMHA3BGLK1a7AgzpHYrDOxWgiFjEwzXGDRI3
         NAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014596; x=1731619396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAZq9oy6Bl8obMNqEnRNBAotywvY9gCvI9My8ktbfNI=;
        b=pPZHJ3YEQricLXR/g3boPv+/fQmE4AU6ruXDECM7WtCDmN0gg/EFEe3uB70ty0R4Ma
         06F0L8enFgSVzz63+uukSJ4kXt65/YiNwPRiWO76e37LXpThe92X9t7Y4cPdm+hAsPlC
         W28S46tRuC8z9StHKCz3RJqQvjVXJ+OImAvhABChtBChl6o9Aeqv4mHdMsBD8sTwwBwp
         po8Ceii2DaFXXeBKwTY/OoaZbWIVbYxTtlNjVpqSMG58JonjQvBG32VD+eKO+sprvHHc
         CxIQcldZIJ8Q8wIyZJBZgxqrgcbCeaM8IHc6F0PaJP0S15UDGTk4xksdbBPFPBRZWqpX
         MMJA==
X-Gm-Message-State: AOJu0YwerV/6a+g41+NLuPnvcACxdcFajXCFmVA7k4WS9mKiKjzf6U0m
	mh7gD64KnmsGiy21bOIKTm5Rlko7BqT+gcNI8AYbBMgJ345QT0wxfKTHQ4AQnK5ENf6SG9aylmE
	np0GAtio16dlr73tEW/hKmkQv0+rdwzcpRsp1LXpAqwlILfTBZ72afykQwJh9HJvGh+aUiFBJM1
	nua+Q8SmiG5uwiAfz//9pAjAKzSrCxRntCMGd1XrXwp+LoyMJdasatzh6BNkM=
X-Google-Smtp-Source: AGHT+IFpZz3joBko2XoXlKijEWXBVEsSKlDAhkhOb9gDzyhStaeTOBcZzdF/pwUDd8RiQ/Qt/WPqhvbOJCOQ6hJZQQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:3302:0:b0:e28:e4a7:3206 with SMTP
 id 3f1490d57ef6-e337f8e44f5mr795276.8.1731014595774; Thu, 07 Nov 2024
 13:23:15 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:05 +0000
In-Reply-To: <20241107212309.3097362-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/5] net: page_pool: rename page_pool_alloc_netmem
 to *_netmems
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

page_pool_alloc_netmem (without an s) was the mirror of
page_pool_alloc_pages (with an s), which was confusing.

Rename to page_pool_alloc_netmems so it's the mirror of
page_pool_alloc_pages.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool/types.h | 2 +-
 net/core/page_pool.c          | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c022c410abe3..8f564fe9eb9a 100644
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
index a813d30d2135..77de79c1933b 100644
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
@@ -956,7 +956,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	}
 
 	if (!netmem) {
-		netmem = page_pool_alloc_netmem(pool, gfp);
+		netmem = page_pool_alloc_netmems(pool, gfp);
 		if (unlikely(!netmem)) {
 			pool->frag_page = 0;
 			return 0;
-- 
2.47.0.277.g8800431eea-goog


