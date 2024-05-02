Return-Path: <netdev+bounces-92897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA42F8B93FE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEA3B21F3A
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D8224F2;
	Thu,  2 May 2024 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bUH8QL1S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608D2135B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625665; cv=none; b=scmPHWTgrAgBRGr00ajCwqUpEhCy5/AGdYu27qXZ8T9+CrTxqGDvjfrEezXWCYN/5/5d6cW/LqX1fCMqUWjymKTS6vUAEnKSaVF9XZeJEktf8T6hPXNiGp3/6z11rPDCFchocvB13AAiAMp5rReMZlW1MNSiXjfoo+d9e9zWlMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625665; c=relaxed/simple;
	bh=jthI8hK9MrxYg3JgyHZimpUnG3c5aYxNuigyuiMuFuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWbSTTV6XO4wnN5Xj61EuuDbiI/BsSiGKMJ9VtAPCabDrlwDheZOWaoI+C74WAWtjxgFlyd0PxWZNA+P5zDwmrWPe3y3IyfXK93mpFRBlRRCwjdOqNxQTLZU6H9zbQX3rggXfqWg8CMzIgsWvvBPeclkwK/B2+s3o0uHjWpUaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bUH8QL1S; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso5361234a12.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625663; x=1715230463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/D9eyfvnwvo/JJPBJPqo7cc98rn6LXpR69ql3JkEKM=;
        b=bUH8QL1So81BzduQ+xExIOx5s7j2n/iavhPvPiFkEmr9kMF/MT0Fj7cEbkKExkSJ+E
         1/fcUFdUcqoE2pYf+S6IpcnRRi7Snhigv7/e2HPK62vhziDlw/gMKze9KPVYLy9iMBfd
         /8wCn7IrhBgsvkZr7EqxyD5Rcsj4RvWOh1jgzfWbEE4pUvrtsCgpJSy4+k0qysOXMXdy
         PUmLTCsc44A47lw9gQsluuf0n4V9t3UpBQiOp5iSJuokWPEeMIC12tqlXCl8OBFU903t
         H8FLGL8fWba5zzAokekgZfSEXWnzG5KAIUJD0p6MriTGLfTiSEKuJGRbuRp+P1jHK7jA
         QaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625663; x=1715230463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/D9eyfvnwvo/JJPBJPqo7cc98rn6LXpR69ql3JkEKM=;
        b=J64zCpKOu1uXy4UkRmhd0U13i6hJaEgmea0WH4VSQwQzm2WFMuKvs9T2632RaErsrw
         jNrOanYfEoYEhw+wJjMT1EY8mKzTF/hYK3MmuG0+CUHIueeWS+l6Uccgdsw5E+XRwAci
         U9/w3rioIxJXVPrjAPzTeKKeDrv2SlZy/NG0IL6FW4TvCDsW7Hj4zik78YhDG+GlHE1h
         29GX7rtMfJYu9+gpltkTVMjt2Qzt0FNxVfPOHBZlcf4bMRYEOkG0oCewIFicWBDzo3GT
         tjczsRlSJh22NjlsZriPSppzT2qcXrx5MUvzhEHNZtn/B104sNpw0bwc+wUKNSlJJwbP
         M1tA==
X-Gm-Message-State: AOJu0YymQoX7IVpp4LuggytUDPz6eTjzU6tVIPdV+IiLn+fm7Cnt571G
	SreXt6hTpub+O9UxJqXtp0FgkAlJV7G4DRCXPoynlebwGpzo9OliPQDyQer2fyoFXbYuzE9Tie0
	c
X-Google-Smtp-Source: AGHT+IEgM3zUkxqfLKYbfGfbBQrKH3frJNv5Zo/G+Df7Kc7l2SwM4GtWkqK9VrQdf5CClRiX53hacA==
X-Received: by 2002:a05:6a20:3ca2:b0:1af:73a5:238f with SMTP id b34-20020a056a203ca200b001af73a5238fmr1194774pzj.44.1714625663091;
        Wed, 01 May 2024 21:54:23 -0700 (PDT)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090a178800b002b24c3fce2esm296405pja.33.2024.05.01.21.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:22 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v2 7/9] bnxt: add helpers for allocating rx ring mem
Date: Wed,  1 May 2024 21:54:08 -0700
Message-ID: <20240502045410.3524155-8-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502045410.3524155-1-dw@davidwei.uk>
References: <20240502045410.3524155-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several helper functions for allocating rx ring memory. These are
mostly taken from existing functions, but with unnecessary bits stripped
out such that only allocations are done.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 87 +++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b0a8d14b7319..21c1a7cb70ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14845,6 +14845,93 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static int __bnxt_alloc_rx_desc_ring(struct pci_dev *pdev, struct bnxt_ring_mem_info *rmem)
+{
+	int i, rc;
+
+	for (i = 0; i < rmem->nr_pages; i++) {
+		rmem->pg_arr[i] = dma_alloc_coherent(&pdev->dev,
+						     rmem->page_size,
+						     &rmem->dma_arr[i],
+						     GFP_KERNEL);
+		if (!rmem->pg_arr[i]) {
+			rc = -ENOMEM;
+			goto err_free;
+		}
+	}
+
+	return 0;
+
+err_free:
+	while (i--) {
+		dma_free_coherent(&pdev->dev, rmem->page_size,
+				  rmem->pg_arr[i], rmem->dma_arr[i]);
+		rmem->pg_arr[i] = NULL;
+	}
+	return rc;
+}
+
+static int bnxt_alloc_rx_ring_struct(struct bnxt *bp, struct bnxt_ring_struct *ring)
+{
+	struct bnxt_ring_mem_info *rmem;
+	int rc;
+
+	rmem = &ring->ring_mem;
+	rc = __bnxt_alloc_rx_desc_ring(bp->pdev, rmem);
+	if (rc)
+		return rc;
+
+	*rmem->vmem = vzalloc(rmem->vmem_size);
+	if (!(*rmem->vmem)) {
+		rc = -ENOMEM;
+		goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	bnxt_free_ring(bp, rmem);
+	return rc;
+}
+
+static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	u16 mem_size;
+
+	rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
+	mem_size = rxr->rx_agg_bmap_size / 8;
+	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
+	if (!rxr->rx_agg_bmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void bnxt_init_rx_ring_rxbd_pages(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	struct bnxt_ring_struct *ring;
+	u32 type;
+
+	type = (bp->rx_buf_use_size << RX_BD_LEN_SHIFT) |
+		RX_BD_TYPE_RX_PACKET_BD | RX_BD_FLAGS_EOP;
+
+	if (NET_IP_ALIGN == 2)
+		type |= RX_BD_FLAGS_SOP;
+
+	ring = &rxr->rx_ring_struct;
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	bnxt_init_rxbd_pages(ring, type);
+
+	ring = &rxr->rx_agg_ring_struct;
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
+		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
+			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
+
+		bnxt_init_rxbd_pages(ring, type);
+	}
+}
+
 static void *bnxt_queue_mem_alloc(struct net_device *dev, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
-- 
2.43.0


