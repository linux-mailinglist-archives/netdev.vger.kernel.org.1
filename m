Return-Path: <netdev+bounces-75160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E3868622
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 02:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FD51F246E8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 01:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160EDDB8;
	Tue, 27 Feb 2024 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="OdtSny3e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43895672
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998122; cv=none; b=LhLaqHawU0VfKZuSSB+IT6j8Na9NcNDBS3yg0bGyJMPgMhrPU76GfbMaLVCsBT3pudTf5uBqYCpwwQJcvCYFr19hul03S11en6V6pWnkoZtnosyp21tYkOyWokCb2faIOhh2cI582FNk5fErq1W4dxIOn/6pDtFJCQTb4HJrmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998122; c=relaxed/simple;
	bh=FylOFo9RfnXHV9EQ7wt+WpmHfZyRTWtmSmAtnRbVm0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q945HjaHYiBcmb4wQtzVRheDEj1mKT1qj+2KcBzXCYmhDw3TrxFmJceJFpY5l51bvboNGoSWdb42GfuPL7InjnQybEefvsrNHRB/RfEQTPBhNDY1v5e91T3OHVSUs6uF1z47WH/hveE8lVNLM38NbBWqvo85SBXyrL3IfDIayaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=OdtSny3e; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a4848f0dso11384845e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1708998117; x=1709602917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAMsdRq2CCVLSK0J5TCOOSXhHRp3Zy11izA1aiVcHbE=;
        b=OdtSny3eBeon/nRgcFgCtqV6Fii17njq100paNU96oF5yktqQtNmPLUuoME6DwJUS3
         EFM0/iySxr2123T5ozlUvPkQddR2NtpX9tEqzF8UVSiHRamOMYw8OzOMrqzQ2jzNYzno
         rZIBvZKZL8HXMbcLHFhWUOwcmMXnhebVr3NBlkKz0I287VdSOIYW0lh/Op4UWD2SNhhq
         bLEz/y3Doe4U60AgkEfUMPQF6omBwiAs3N/+DCSvGh+rYwQtEHjjH/FSZAPpXfoC/6Y5
         Was0nuF92KkexZlsFpxlLThFxCGb5SlxFGqAk2C+HZ55xsWToO//5avnlCm9T30ZU2CP
         zDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998117; x=1709602917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAMsdRq2CCVLSK0J5TCOOSXhHRp3Zy11izA1aiVcHbE=;
        b=vh+HHY36f8dZIcwjk/4pqFW0hr29Be6drgtYl+tMQJoNQ3ES/R2SZbAVIcdNLIc3W1
         t7KiAHyS7Br+j1phebgzydGktK0jE+qgXVXU8RDB9r4NIs5+YtnipVEI80AqHyTsKWOl
         3WxiL6A8jqIeBiSkiRq5VxJpMceFJOt+/2eVR3Lfb9CtrwzI+ATaHt0TIRNGyv4ErNK5
         VcriyZf6Gzelav14vl3EzrVtE3KITs4AbrlvWCvAk/vCsu8WOHcGSyDuXgick6d8POme
         DjeCfTebA/hnuCUvjrZh/bulm0uRZGNFgct+X/ZMk5KHhmqsW0v4DXCF91jyMuQlD1sr
         mQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCW49WgWrEjkeZv01a3rkryZEQgfV2nDJHghj/HS8QbxiB2DaVRKDP4spI/wYHQYDpuDskV3HkJZAEXaUjOp0ZbzY15J9liB
X-Gm-Message-State: AOJu0YztSzJ7qm6kIBPuuHWqVYauBnGFKzUFeD1a/gjQ+N7gid9+nnr0
	+SWQtNt3BkN89KOmOnV/4ApHl61rLvkcrKqz44rWfdyF5Oo6JLicIHmOrqopiLw=
X-Google-Smtp-Source: AGHT+IHFbVMMqnwbkFQLA8ydpfnz28ahzoQuv6rhEthZZQ4GpgMQ8DCXucIt5tPkDi+0pGg6LjIPjg==
X-Received: by 2002:a05:600c:4f86:b0:412:94b7:bc2 with SMTP id n6-20020a05600c4f8600b0041294b70bc2mr7789978wmq.2.1708998117431;
        Mon, 26 Feb 2024 17:41:57 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id w15-20020a05600c474f00b004129860d532sm9827918wmo.2.2024.02.26.17.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:41:57 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 1/6] ravb: Group descriptor types used in Rx ring
Date: Tue, 27 Feb 2024 02:40:09 +0100
Message-ID: <20240227014014.44855-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227014014.44855-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240227014014.44855-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Rx ring can either be made up of normal or extended descriptors, not
a mix of the two at the same time. Make this explicitly by grouping the
two variables in a rx_ring union.

The extension of the storage for more than one queue of normal
descriptors from a single to NUM_RX_QUEUE queues have no practical
effect. But aids in making the code readable as the code that uses it
already piggyback on other members of struct ravb_private that are
arrays of max length NUM_RX_QUEUE, e.g. rx_desc_dma. This will also make
further refactoring easier.

While at it rename the normal descriptor Rx ring to make it clear it's
not strictly related to the GbEthernet E-MAC IP found in RZ/G2L, normal
descriptors could be used on R-Car SoCs too.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/ravb.h      |  6 ++-
 drivers/net/ethernet/renesas/ravb_main.c | 57 ++++++++++++------------
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 35e642fc4b2a..aecc98282c7e 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1092,8 +1092,10 @@ struct ravb_private {
 	struct ravb_desc *desc_bat;
 	dma_addr_t rx_desc_dma[NUM_RX_QUEUE];
 	dma_addr_t tx_desc_dma[NUM_TX_QUEUE];
-	struct ravb_rx_desc *gbeth_rx_ring;
-	struct ravb_ex_rx_desc *rx_ring[NUM_RX_QUEUE];
+	union {
+		struct ravb_rx_desc *desc;
+		struct ravb_ex_rx_desc *ex_desc;
+	} rx_ring[NUM_RX_QUEUE];
 	struct ravb_tx_desc *tx_ring[NUM_TX_QUEUE];
 	void *tx_align[NUM_TX_QUEUE];
 	struct sk_buff *rx_1st_skb;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f9fb772b05c7..c25a80f4d3b9 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -241,11 +241,11 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
 	unsigned int ring_size;
 	unsigned int i;
 
-	if (!priv->gbeth_rx_ring)
+	if (!priv->rx_ring[q].desc)
 		return;
 
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		struct ravb_rx_desc *desc = &priv->gbeth_rx_ring[i];
+		struct ravb_rx_desc *desc = &priv->rx_ring[q].desc[i];
 
 		if (!dma_mapping_error(ndev->dev.parent,
 				       le32_to_cpu(desc->dptr)))
@@ -255,9 +255,9 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
 					 DMA_FROM_DEVICE);
 	}
 	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
-	dma_free_coherent(ndev->dev.parent, ring_size, priv->gbeth_rx_ring,
+	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].desc,
 			  priv->rx_desc_dma[q]);
-	priv->gbeth_rx_ring = NULL;
+	priv->rx_ring[q].desc = NULL;
 }
 
 static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
@@ -266,11 +266,11 @@ static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
 	unsigned int ring_size;
 	unsigned int i;
 
-	if (!priv->rx_ring[q])
+	if (!priv->rx_ring[q].ex_desc)
 		return;
 
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q][i];
+		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q].ex_desc[i];
 
 		if (!dma_mapping_error(ndev->dev.parent,
 				       le32_to_cpu(desc->dptr)))
@@ -281,9 +281,9 @@ static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
 	}
 	ring_size = sizeof(struct ravb_ex_rx_desc) *
 		    (priv->num_rx_ring[q] + 1);
-	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q],
+	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].ex_desc,
 			  priv->rx_desc_dma[q]);
-	priv->rx_ring[q] = NULL;
+	priv->rx_ring[q].ex_desc = NULL;
 }
 
 /* Free skb's and DMA buffers for Ethernet AVB */
@@ -335,11 +335,11 @@ static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
 	unsigned int i;
 
 	rx_ring_size = sizeof(*rx_desc) * priv->num_rx_ring[q];
-	memset(priv->gbeth_rx_ring, 0, rx_ring_size);
+	memset(priv->rx_ring[q].desc, 0, rx_ring_size);
 	/* Build RX ring buffer */
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		/* RX descriptor */
-		rx_desc = &priv->gbeth_rx_ring[i];
+		rx_desc = &priv->rx_ring[q].desc[i];
 		rx_desc->ds_cc = cpu_to_le16(GBETH_RX_DESC_DATA_SIZE);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
 					  GBETH_RX_BUFF_MAX,
@@ -352,7 +352,7 @@ static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
 		rx_desc->dptr = cpu_to_le32(dma_addr);
 		rx_desc->die_dt = DT_FEMPTY;
 	}
-	rx_desc = &priv->gbeth_rx_ring[i];
+	rx_desc = &priv->rx_ring[q].desc[i];
 	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
 	rx_desc->die_dt = DT_LINKFIX; /* type */
 }
@@ -365,11 +365,11 @@ static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
 	dma_addr_t dma_addr;
 	unsigned int i;
 
-	memset(priv->rx_ring[q], 0, rx_ring_size);
+	memset(priv->rx_ring[q].ex_desc, 0, rx_ring_size);
 	/* Build RX ring buffer */
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		/* RX descriptor */
-		rx_desc = &priv->rx_ring[q][i];
+		rx_desc = &priv->rx_ring[q].ex_desc[i];
 		rx_desc->ds_cc = cpu_to_le16(RX_BUF_SZ);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
 					  RX_BUF_SZ,
@@ -382,7 +382,7 @@ static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
 		rx_desc->dptr = cpu_to_le32(dma_addr);
 		rx_desc->die_dt = DT_FEMPTY;
 	}
-	rx_desc = &priv->rx_ring[q][i];
+	rx_desc = &priv->rx_ring[q].ex_desc[i];
 	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
 	rx_desc->die_dt = DT_LINKFIX; /* type */
 }
@@ -437,10 +437,10 @@ static void *ravb_alloc_rx_desc_gbeth(struct net_device *ndev, int q)
 
 	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
 
-	priv->gbeth_rx_ring = dma_alloc_coherent(ndev->dev.parent, ring_size,
-						 &priv->rx_desc_dma[q],
-						 GFP_KERNEL);
-	return priv->gbeth_rx_ring;
+	priv->rx_ring[q].desc = dma_alloc_coherent(ndev->dev.parent, ring_size,
+						   &priv->rx_desc_dma[q],
+						   GFP_KERNEL);
+	return priv->rx_ring[q].desc;
 }
 
 static void *ravb_alloc_rx_desc_rcar(struct net_device *ndev, int q)
@@ -450,10 +450,11 @@ static void *ravb_alloc_rx_desc_rcar(struct net_device *ndev, int q)
 
 	ring_size = sizeof(struct ravb_ex_rx_desc) * (priv->num_rx_ring[q] + 1);
 
-	priv->rx_ring[q] = dma_alloc_coherent(ndev->dev.parent, ring_size,
-					      &priv->rx_desc_dma[q],
-					      GFP_KERNEL);
-	return priv->rx_ring[q];
+	priv->rx_ring[q].ex_desc = dma_alloc_coherent(ndev->dev.parent,
+						      ring_size,
+						      &priv->rx_desc_dma[q],
+						      GFP_KERNEL);
+	return priv->rx_ring[q].ex_desc;
 }
 
 /* Init skb and descriptor buffer for Ethernet AVB */
@@ -830,7 +831,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	desc = &priv->gbeth_rx_ring[entry];
+	desc = &priv->rx_ring[q].desc[entry];
 	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
@@ -901,13 +902,13 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		}
 
 		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
+		desc = &priv->rx_ring[q].desc[entry];
 	}
 
 	/* Refill the RX ring buffers. */
 	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
 		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
+		desc = &priv->rx_ring[q].desc[entry];
 		desc->ds_cc = cpu_to_le16(GBETH_RX_DESC_DATA_SIZE);
 
 		if (!priv->rx_skb[q][entry]) {
@@ -957,7 +958,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 
 	boguscnt = min(boguscnt, *quota);
 	limit = boguscnt;
-	desc = &priv->rx_ring[q][entry];
+	desc = &priv->rx_ring[q].ex_desc[entry];
 	while (desc->die_dt != DT_FEMPTY) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
@@ -1017,13 +1018,13 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 		}
 
 		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q][entry];
+		desc = &priv->rx_ring[q].ex_desc[entry];
 	}
 
 	/* Refill the RX ring buffers. */
 	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
 		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q][entry];
+		desc = &priv->rx_ring[q].ex_desc[entry];
 		desc->ds_cc = cpu_to_le16(RX_BUF_SZ);
 
 		if (!priv->rx_skb[q][entry]) {
-- 
2.43.2


