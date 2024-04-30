Return-Path: <netdev+bounces-92638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5F8B82EC
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9915B1F236BD
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF131C0DDB;
	Tue, 30 Apr 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYhiov9k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C41C0DCF
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518879; cv=none; b=NwohtX3Z6KixBMlyh3gVImcojG9hnSOFJV2rEITnz9YEwa5/fP/G64oJo4s6/Xas/Qes5VGSkGvub9V3pFnDchKq5lGFqWJ3wq8+suOx6QCxrm28qNKzopOobnpLFnptS4fy1AtFaC4tEwnRoapYS4/wdtE7kcpaoc6qESDjTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518879; c=relaxed/simple;
	bh=G9vTwaOh9tqpmWBRnbfIv95mAPnSNpQXI1b5OG2x6ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXTh+YKFK6qBlOzWUHZbFQ6S6rJF+EDZU9z1plD6yssM53ZRNt2meYjHiP1BnG1N2UQZ5YqUqns7sMPpI1ieM3CaWAZ1wIcdGbIWC50dcH8J4HyiwB35H5oE7sX1uY8MdCi5Xmap5GXxeptUodHAkZJhm/EYI84gQdUd8cECpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYhiov9k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de617c7649dso2012034276.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518877; x=1715123677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQKspPSBYhGlej/Z1yQFkrqQvo1+u8pB8UNnxcDCgXM=;
        b=iYhiov9k56xdE+2tuh+hNLafjjZf5jaW9kCUnemKRq5EnkXnk91rErj/D15TUONu+K
         3mBxAPOJpwNqGt1+aMZczQMv5D0Nf1X97F00fdplZAFAG+dZUSHAyb9TrcDss/pUzfKQ
         fi2xSKuOcHpTBwA2kxU/TY9Ny00HvaS9zxWOP4tKaqlCqt3c/r3/HqY2td6381zE9g/q
         pyBPr1Y2Ge1iP2WbL6CNKALCys4XKxmzPR/HS9219dOsNC7M3mz1rhR4OCL6b5Wa3saa
         ihzaNoQWjlP2tSCjCJI5ZMZY0JOlWiVoE+J6/9Zjsw3fGmo8cHNQsTl+l9B/c6dgScqN
         X2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518877; x=1715123677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQKspPSBYhGlej/Z1yQFkrqQvo1+u8pB8UNnxcDCgXM=;
        b=YU+Zk9IWxySrKf5nmbVX8lto7pvuXDvj/28RfhOjzwA2svkvbQ2cyKZ7YZDwbV+KCc
         CUmBo4G4mc4QFUczYRxaeT7w/RWo+rXjO4/MNgGC1fYUyojbyjQLf5gquQTV8gwp/Lgd
         CqQF16djVfAvG7+qAgkZPhnNuQr6cs/Xdthrfk+RGHVNVGx7hN38hizhXmwMgBxN7Knj
         R6lmOjzTAcLThq9F41+w1XM2tH4oNfbDMtlaBTx/tRroNHo/3T0QgkfkItLyjmnRg3Tm
         y84NwPfic4MMsCmCxtfXhVkAXSYpUyJELBsko5ccnOtilu8TLte0EmGnLEh13ZIoFlk7
         f73g==
X-Gm-Message-State: AOJu0YynOVaRL9n9fp5DX6PoSYpWlDciE0FlPYvBsYIsQVhehzRdeCTl
	adi5DspBTPc3G/2b8WltfihapN3hqQldF2lrhwufMD3DhDwa5hfefXcas/goiWnxTKCVGFLoSFm
	3NF7oX4hLc/Dy2gq99RMlar1qqF/NcoFt5BTFiyFINg75Up5aiwb1kxqkEjI7KaWMsYjN+WACIk
	0ScwUHj7jGDiDnAo9U4tdrE0GIqrObaiZkOBu1i6xvwA0=
X-Google-Smtp-Source: AGHT+IEzqY05NkAq1Gn2LJqwB1WPzry6JpExZnGMwEJxmcc10xro9AzPpzGpuczywQ5DO+99AsfEAZdYSYSTUQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:18d2:b0:de0:ecc6:4681 with SMTP
 id ck18-20020a05690218d200b00de0ecc64681mr170359ybb.1.1714518877261; Tue, 30
 Apr 2024 16:14:37 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:11 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-3-shailend@google.com>
Subject: [PATCH net-next 02/10] gve: Make the GQ RX free queue funcs idempotent
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Although this is not fixing any existing double free bug, making these
functions idempotent allows for a simpler implementation of future ndo
hooks that act on a single queue.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 29 ++++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 9b56e89c4f43..0a3f88170411 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -30,6 +30,9 @@ static void gve_rx_unfill_pages(struct gve_priv *priv,
 	u32 slots = rx->mask + 1;
 	int i;
 
+	if (!rx->data.page_info)
+		return;
+
 	if (rx->data.raw_addressing) {
 		for (i = 0; i < slots; i++)
 			gve_rx_free_buffer(&priv->pdev->dev, &rx->data.page_info[i],
@@ -69,20 +72,26 @@ static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
 	int idx = rx->q_num;
 	size_t bytes;
 
-	bytes = sizeof(struct gve_rx_desc) * cfg->ring_size;
-	dma_free_coherent(dev, bytes, rx->desc.desc_ring, rx->desc.bus);
-	rx->desc.desc_ring = NULL;
+	if (rx->desc.desc_ring) {
+		bytes = sizeof(struct gve_rx_desc) * cfg->ring_size;
+		dma_free_coherent(dev, bytes, rx->desc.desc_ring, rx->desc.bus);
+		rx->desc.desc_ring = NULL;
+	}
 
-	dma_free_coherent(dev, sizeof(*rx->q_resources),
-			  rx->q_resources, rx->q_resources_bus);
-	rx->q_resources = NULL;
+	if (rx->q_resources) {
+		dma_free_coherent(dev, sizeof(*rx->q_resources),
+				  rx->q_resources, rx->q_resources_bus);
+		rx->q_resources = NULL;
+	}
 
 	gve_rx_unfill_pages(priv, rx, cfg);
 
-	bytes = sizeof(*rx->data.data_ring) * slots;
-	dma_free_coherent(dev, bytes, rx->data.data_ring,
-			  rx->data.data_bus);
-	rx->data.data_ring = NULL;
+	if (rx->data.data_ring) {
+		bytes = sizeof(*rx->data.data_ring) * slots;
+		dma_free_coherent(dev, bytes, rx->data.data_ring,
+				  rx->data.data_bus);
+		rx->data.data_ring = NULL;
+	}
 
 	kvfree(rx->qpl_copy_pool);
 	rx->qpl_copy_pool = NULL;
-- 
2.45.0.rc0.197.gbae5840b3b-goog


