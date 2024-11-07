Return-Path: <netdev+bounces-143078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BDF9C10E7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C151C23051
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4073219CB2;
	Thu,  7 Nov 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRtMRll6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3902194AE
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014603; cv=none; b=MSEekE854gFdggiKIwFiqCuWOtukQCCV/p1MsShcxGt/nrxiwkpCYRpgVOCi5g4SjikP/NJFE8Cma42RLdF2Uid/W9y+ilYgys/hW52dUfp3eJKGDxRS1A4MBdivZ+9O/LIvMlVc/XseX60a5+k82ioPPpyRZRUaKUUznAkm1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014603; c=relaxed/simple;
	bh=m8IdxZqUwMqRC2HMh2bTKic9Iv2zEBl6lcyJNuEk5WE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uLGmPDC209MswOuQQ19LqgCNTfMmREH7fhl6rxDa9Az3jt9ThhnY0xaAs55UCZ88US2v/52gxdXSoq12Mm920az7b9E0/hs2YX07qvBRSDP6+0XB6ITSH56Vi1klNWwgQfRW/juMNTM9cA2o0OrpO5UuYDaqGcGHlTAd2BKFiII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRtMRll6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e862eso18644897b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014601; x=1731619401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aiw631cVYF88tA3jMsDP51zKCtA5BveE1WXlRhKkO9c=;
        b=DRtMRll6XcMEv0/zWo3jzBOx4/oJy3DMVJmP3QOnigu9qvYLzwkZihnV8bhc07ow84
         2bupM3LBeBYtnus26kQQsCXM1KIvr7gXpuox6P/QkIrsxO6kDyW4SyuHYzctK5OEqe0r
         W0gH9yV8zPrifwEy1xD9W66CVtoxgTBqy0VtwqzfCFU4YUIWxw9lFR7jv/gAcgqwas9U
         j2YjCgLJyj1p2ZXIOII8QiaMKhW/xux/G8zn7UGmLF22Fm2iX4FmzFy3z+588iPJGPCc
         nS+YouO37ru0efKXTL+iAM8BFHnlVUqUMZa7avMV19b5Nmen7FJaqsugGsLvJA8/ioTZ
         l0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014601; x=1731619401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aiw631cVYF88tA3jMsDP51zKCtA5BveE1WXlRhKkO9c=;
        b=kxek5P7ILUqiN3ciDyvhmMi0LtlN93ulLj65UoM5VwYa9GXvQ8ZBw7FzM0F8npU1DP
         mpjs9v7m6FSBOrq2HXhfoqjpdoqlh53EQEEAuikOSNjSeVhzgcwCc1GaFcKRLRwvjXDW
         /txdcQnO6rBPpggUpuXA1ZW8Fabaeo+P5FqOm23cvHogznWNPPcwKBBSjGR3AnbMs5lj
         UnFahz16jmqvnuap7/lcFSW3MZnK3kAYX7G3lPDPG6G9kkuFt5oZOTPJMwkmt89pur5+
         k+9Ccju2XmJxkNvE06oPcUFARd2cO413lp8f5j4vOLoicvNNNwEX0YOT/eiZoCRiBM/1
         G6AA==
X-Gm-Message-State: AOJu0YyzwlQpmfEd7YpKaXl21pq7OghSqytb4zzK38LakdEhWA8Amhdu
	B4iidoUN9TcjH6Kv5Y5k9zJDEPr8H7rxA32UIH6UMEm/rF19JQN6gZeMNqD/dQxZ1qI7ZK4Z9FR
	bKlwiTvK4wkvHVwL+rzSYu5fzfVfXP63fdwXTno59z2rcTQzE5JHC0MU+X/jemJbnbjj/D1+reg
	5hZpIWt4loWnKsmsNtOJPzjqkdMpYFYW09js81MuKFjvXZ2me8caV1/IOWmdc=
X-Google-Smtp-Source: AGHT+IFcD/DvotfYM+pVSvbUUM61OCX/CMwJjo9lQAnn7vXUnCYSFqjVZ5LnQgBS3mPiwUW32kp2i4JkBRuWazqvLw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a0d:e545:0:b0:6dd:bb6e:ec89 with SMTP
 id 00721157ae682-6eade40bbf7mr39597b3.2.1731014600825; Thu, 07 Nov 2024
 13:23:20 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:08 +0000
In-Reply-To: <20241107212309.3097362-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-5-almasrymina@google.com>
Subject: [PATCH net-next v2 4/5] page_pool: disable sync for cpu for dmabuf
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

dmabuf dma-addresses should not be dma_sync'd for CPU/device. Typically
its the driver responsibility to dma_sync for CPU, but the driver should
not dma_sync for CPU if the netmem is actually coming from a dmabuf
memory provider.

The page_pool already exposes a helper for dma_sync_for_cpu:
page_pool_dma_sync_for_cpu. Upgrade this existing helper to handle
netmem, and have it skip dma_sync if the memory is from a dmabuf memory
provider. Drivers should migrate to using this helper when adding
support for netmem.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/net/page_pool/helpers.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 8e548ff3044c..ad4fed4a791c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -429,9 +429,10 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 }
 
 /**
- * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
+ * page_pool_dma_sync_netmem_for_cpu - sync Rx page for CPU after it's written
+ *				       by HW
  * @pool: &page_pool the @page belongs to
- * @page: page to sync
+ * @netmem: netmem to sync
  * @offset: offset from page start to "hard" start if using PP frags
  * @dma_sync_size: size of the data written to the page
  *
@@ -440,16 +441,28 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
  * Note that this version performs DMA sync unconditionally, even if the
  * associated PP doesn't perform sync-for-device.
  */
-static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
-					      const struct page *page,
-					      u32 offset, u32 dma_sync_size)
+static inline void
+page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
+				  const netmem_ref netmem, u32 offset,
+				  u32 dma_sync_size)
 {
+	if (pool->mp_priv)
+		return;
+
 	dma_sync_single_range_for_cpu(pool->p.dev,
-				      page_pool_get_dma_addr(page),
+				      page_pool_get_dma_addr_netmem(netmem),
 				      offset + pool->p.offset, dma_sync_size,
 				      page_pool_get_dma_dir(pool));
 }
 
+static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
+					      struct page *page, u32 offset,
+					      u32 dma_sync_size)
+{
+	page_pool_dma_sync_netmem_for_cpu(pool, page_to_netmem(page), offset,
+					  dma_sync_size);
+}
+
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
-- 
2.47.0.277.g8800431eea-goog


