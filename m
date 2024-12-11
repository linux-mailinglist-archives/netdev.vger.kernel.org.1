Return-Path: <netdev+bounces-151213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF68F9ED866
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39B4165E95
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13601F237A;
	Wed, 11 Dec 2024 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/EpJ0W2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0FC1F0E54
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952041; cv=none; b=tRkwci0G2RkgXAIFSC7qONz6NZCSydBNY0OX/c2XSyPTr3PCG6V4M6p/4ZDfVNZora66vyi9bSNclR44mOSJamYWRxf+tfWcM4cCw06Lg3ey7W2b19xzoKUDpg0TTGtk6nRPnad0emfL3pNa5u4ldM/0IroYfrvXndSOe0Ng5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952041; c=relaxed/simple;
	bh=b90XShILltXC+LvOAJbN7AuVnXlBIVN+oi/xu7qF+1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=azddL0WiEuQdDTO9GTgGkNe7VWK7jHPZeu7HmtOG8PrBpssjHsai4A4iKASfK8qgZlksAFWU9pR22vrokWszslaiisgVTC+yc+4ilWcUoPUHm+H2R+90YFhbHxrDXVqdX986XqHQYH+iGsOB4wWfo+i1+qBzFmE4W+QZ0hR14ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/EpJ0W2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fdde44f4f2so1858129a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733952039; x=1734556839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkkaSKdaGNTNNhg4FUb498GHLs5FUYHJ5RvbafI+ZxI=;
        b=s/EpJ0W2mNFEeUnNn1xZ1TFGvqlWTt/ynOuqMsa/43tYpPRomrTsZI31x+4idNcsGJ
         p0bfQKfAU4Jks7ctcnEorFsbfjD7ENbp6GkW/tYV7qaoD/KVLgdn4BMLw7WSQC9odt9G
         rzGnsb064jnAS+0u9wflHiiulXj+KkItTUSbc2qzehLmp2SWEndYdm5XnzhgwpdyyIHL
         vQxVKtflHywz7LBt4G7BaiwtlbSP8ZVJTBVeXRdykSt1YkS3X7cdmFvRzBu2dhCR4hm5
         dVTIpL7Hx8V0qa/C77W+3YC+6iXKY90xUbkRqyXLqZnbffceXTyGZ8CC/QRonkIcZaRw
         IomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952039; x=1734556839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkkaSKdaGNTNNhg4FUb498GHLs5FUYHJ5RvbafI+ZxI=;
        b=SNlCbOrgwd5YierZQZbvl6uLruX9EdFrxwXWbMz4K18F3lP7OjBb7Cfm50jbERGZUf
         BmwrDjAKVkbdcHVtaEvLVR4FgUv4qZ+RkXOE5JpD4c7gqWnxOf7RXiAEinY3sv3v5Ido
         uYKJTpQIE8CZ20EcCTqC+5Ct82sD/t+/55yuIdukPbVzXfgseKlOEtugE7+gtPGMb3bd
         T70OfzshEYS/aSvy5nYLV8Qh8dB2VinFXezfgK6mAEJpCjirSfTkws0gb7QakFOtgIn9
         w8D8Q8+CQ1vL+GE7lZwO504l6Y/1Ac3QcbX3sHJ0QZDB+ePoM4s8YCMmATC6kHQ85Lah
         OrbQ==
X-Gm-Message-State: AOJu0YxklsZ9hBaBGJEsCOs1pxN/YEYNeRj3fs0c+LOtZ8HuUfRnBxLH
	ZDIaooQ6Efe/CRHKbcd5wDY/DCC5AvPA1cO/Wz0O0dCneMBGre4zGvy3L8oBaUIInNzQgVGv8Du
	ajEFWY7B1BE5PCbdBfxB5/nqTmTUnJOx9wcHPxXQWkCnYjDMRFHCnBUFDB9kt7A8ClJ3HqD9y9v
	wQzvKz2vUWMs3w26qWdruNxMnUsVodtWVYd57EmlUspN0ujJg/ySwcBRiAEdw=
X-Google-Smtp-Source: AGHT+IEWhVqk1hESVIlHN9fpnPz7ovhaAwHnlpf82RR0HAKH6Gbqs6fHleZO+74e3iAsiD+P7NcS8Md3jf3KevFa3Q==
X-Received: from pfbc2.prod.google.com ([2002:a05:6a00:ad02:b0:725:e76f:1445])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:258a:b0:1db:ec3e:c959 with SMTP id adf61e73a8af0-1e1cea99eadmr1328009637.10.1733952039349;
 Wed, 11 Dec 2024 13:20:39 -0800 (PST)
Date: Wed, 11 Dec 2024 21:20:30 +0000
In-Reply-To: <20241211212033.1684197-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211212033.1684197-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211212033.1684197-4-almasrymina@google.com>
Subject: [PATCH net-next v4 3/5] page_pool: Set `dma_sync` to false for devmem
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

From: Samiullah Khawaja <skhawaja@google.com>

Move the `dma_map` and `dma_sync` checks to `page_pool_init` to make
them generic. Set dma_sync to false for devmem memory provider because
the dma_sync APIs should not be used for dma_buf backed devmem memory
provider.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v4:
- Improve comment (Jakub)

---
 net/core/devmem.c    | 9 ++++-----
 net/core/page_pool.c | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..3ebdeed2bf18 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -331,11 +331,10 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	if (!binding)
 		return -EINVAL;
 
-	if (!pool->dma_map)
-		return -EOPNOTSUPP;
-
-	if (pool->dma_sync)
-		return -EOPNOTSUPP;
+	/* dma-buf dma addresses do not need and should not be used with
+	 * dma_sync_for_cpu/device. Force disable dma_sync.
+	 */
+	pool->dma_sync = false;
 
 	if (pool->p.order != 0)
 		return -E2BIG;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3c0e19e13e64..060450082342 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,6 +287,9 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_priv) {
+		if (!pool->dma_map || !pool->dma_sync)
+			return -EOPNOTSUPP;
+
 		err = mp_dmabuf_devmem_init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
-- 
2.47.0.338.g60cca15819-goog


