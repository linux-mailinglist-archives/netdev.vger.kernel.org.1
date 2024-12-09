Return-Path: <netdev+bounces-150292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A339E9CE7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B92166BB2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7415535A;
	Mon,  9 Dec 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Orq2XtT/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000FA153BF7
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764994; cv=none; b=jzGC3YmVgeORoagZnWk6tJpYdcPg6dPBey6TInvJVkxvEVeXdNB9WLEYYHXpbIHRvtcvOw9/We8byWsTF+TXB7s/jN1BfZ6PrM+MipCceL6kmirTnq2DDdSrJzXpW/TbAdTayajnBBxnUSCcZYWFb4rFcY7IulKbCbBYEoPF/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764994; c=relaxed/simple;
	bh=inYtJTadn/ilQufeg2hRjROOpb6WnuRJ/R3Eo2kT9Ak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvAQtnMr9eJ4kn19rJ6dKEy0LHyM7+DxFUefDc6qYFpA5ROzJ7SI0TQyDbbtuUFrOhaU9wavFGMQkEg4/16EM3h+tdzLRDoGzDlLF6a7NvAHNVA0oQ6qRCcYmHLs5EETsLK5MVaxHMv42pgDkyPZhUWrkZ9fogNK9fxQ6r55U8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Orq2XtT/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso1446156a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 09:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733764992; x=1734369792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rD4fHb5o8v+27TSL8zHXq3Z19Qh3ytPkt3LCpxEoKxE=;
        b=Orq2XtT/ERZSUjmtMsQzAA1Gw68J824uikYBYqoub078MfbsKcLSi3YJUkRFw1jpYx
         MIUOyAqWij26W5nMpzukQDiqB82hqF7eAmDTdO8q/tgMejRjVR96trbCIsEVFwYJchHa
         j5B84v/YJiDnZakJ3K2lsutaJNUZZFG1RD/9e2TnuezaIfaoRCuK7JFpr/fxQDREXC13
         VooRM4uFI7IgNWzkZ5/e/WL0yS5qQaH8AnpPued8EXjwrFWM9a4LkAlo02bSjBkfHW6i
         jP1+rAHp5h1Wl2PjEm1brlVY5iTCNXRbFuZVtYz02Pn0jddRevgSzoa+NrBRd2lvheEO
         fLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764992; x=1734369792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rD4fHb5o8v+27TSL8zHXq3Z19Qh3ytPkt3LCpxEoKxE=;
        b=HwLtbIrTk6j4Ab1cYHqmR1f/BLB37VTXcaF0Hf5gsksSSkJ4w9tmghDgwiIQX8ZIXZ
         YGiKMGelBsuBqKJYMMtkxFNQYhPirC0M37DSJ+YkrdhWM7Up5kc4v7ipcHr8/3FJmSAu
         InhLwjI/euPAjuChCmti/abjRSxlFHlxqyHeyR2tuGUeqid9lIRTGVOkbOdD0gzyPkl/
         vBfY2GUOYv0iPoXcZ4ullVJNgLJb8fzrgWaXAwFL1vYFJYfpcObtf17bKIB7B792I4EJ
         ciyV2ScvK/+b4oXTjOW//fCj4pXEv2NgN0SXr0feeSgOTPFK+6Z7SkuAbO6EcynWwqor
         m2OQ==
X-Gm-Message-State: AOJu0YzkYcjXi2fwV5uNgEOAeBjV3mg8IxTJnUEYSiBVvlPnB1lq1qD7
	NP2Wi1VOPriXEHVIUDVsf2db5fUWXJZReNBlY5P02ZjtymxfMOEOFEpDtFpJPieX9f+FcrWxn1z
	QEc9m+mpAaSw4m+StUTYItXlv1o28BXK0VzcW/Yo/WKkh+S9ZJ13ZRx7u7DHra1LM/P6ATZoQw7
	jtGHTtCE7Gv2KUQkonLUsLfqWGUFVUVOFAdimQb50nGW30tJrTbQRsAdUh0Oo=
X-Google-Smtp-Source: AGHT+IF/gnzzxrq5wZW7Oq+BE9snOE5665TQRiKiXV7o1WW6Cds5d4hj9kPz8o9cXdP519d70WJqMsaDSx1ufbKdtw==
X-Received: from pjbpv2.prod.google.com ([2002:a17:90b:3c82:b0:2ef:82a8:7171])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:50:b0:2ee:c797:e27f with SMTP id 98e67ed59e1d1-2ef6ab296e5mr18017086a91.36.1733764992288;
 Mon, 09 Dec 2024 09:23:12 -0800 (PST)
Date: Mon,  9 Dec 2024 17:23:04 +0000
In-Reply-To: <20241209172308.1212819-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209172308.1212819-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/5] net: page_pool: rename page_pool_alloc_netmem
 to *_netmems
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
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


