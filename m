Return-Path: <netdev+bounces-199505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A7AE08FE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E595A4D90
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B72264C1;
	Thu, 19 Jun 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/fP8iMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B218E02A
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344197; cv=none; b=LnPo85LxBFWQOyRb4US5LUiOtfc5pu3vS9DVGNB8m+QG3KJOugac7rWSDHxbCXBGi+/fK2BmPg6TMDTW6w2woOvlbf170mIdJRjU58HYCESlUrEPmZskHBvENhw67+v2IERUPpBUMhL9I9JXUKGZm0jZZuTpq5mwse0vmJn8Bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344197; c=relaxed/simple;
	bh=V94t/ymD0gYUeOVZo1Kk6rym0WD1lgoPg4oOdJCj7hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rcdkkSnMYcYczfvsI6xQcF2kNFJYUvaHEi4219q2W3wPr82aV29gl3kG/GhDje4w1KJPc5xG2/hTcIa+/gtOOrTEq6acQz2hrJbvhQTOie+PButjJ9Ast8IeYKi5x+BAw/zCC3dKi/HRnrraa734QryjXqTE0BNxdn6ZD0PPyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/fP8iMD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748e63d4b05so459190b3a.2
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750344195; x=1750948995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqvn+eXFXjREz+f5McbZ+dyBrTJCR+prm+A59eDzmbk=;
        b=k/fP8iMDfi9U/KlNezEvlsVhqAo5eBMDFSmVKro2rTnxZFhv0aIRqTRoKNvlU5ks0L
         VXKwUj8b4kVtqxtA9qpl8Sl6Js5pr/ntfxT+FOvx07BoxjFJ8//XI8xt/d9xFde8sj61
         JYZChQfcQz95oTQD5uJfyhhG9iGszfuaL9OG89BT66SoArpjGA0z2hFz4H9g3pBuAcZc
         ueCanTt0mCfddS7H3/qWymb9vc3v4eAaiAnmoh2fQkxz/H4v0q+/GIkO4u2N2sLAxIqz
         1BI+NiX56+7oa5gOMehK1Ukt4JWZ1KLDYnljqA0AXwwAbRlV/LZuEkKiexWOJeaAuyU+
         Lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344195; x=1750948995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqvn+eXFXjREz+f5McbZ+dyBrTJCR+prm+A59eDzmbk=;
        b=Kjm9F3d5uFtO+QsUg/AGPQMs75g64KC6Ur3tb4G1PdZMlkExn0/0R04804aoqhDImN
         2Jok3SWcg2NOkZ2UJVPoMDg9Ii6VsbvdGXYAHwvLTYTnEg+LqWf1NRXPxnfh/M2Sskeh
         uUyBsPBijV3+QNZc+W7kHOe/kg/K3yl1YZ4mJI262NoPnEbMP/FI06N0E4LtgrrWXRnc
         /E5QGPU1L6Ua29OPcziNUkIKIWXb/WNsfifkWbYisWaKGGzHYzgMUKuquw3v4D0XSyR6
         P+w5v/eMKtXd2jyUkLmjRXZzdfOyRjNN30s2GSS4I7Gy0FcucKNVx/RMZJDkEhip5LHM
         c0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ViOT8aF8B/xZ18MsjFdNG8uq7fwoIyv/KBZoTBygQOg96lVljgnyL/dULFnZj6zmhGz5Vao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhlYvmwizGmuk27ijqJNwfGZtSXaJtpwUmzAjVyouMpDKzOEVg
	bqqO71P3WV3K/LV1o9rgclgNwoeuICkM+sFjRQN4Q7Mct8HgnUwE507W
X-Gm-Gg: ASbGncvBR4cVifxRH6C0dfgIne+Zj+yuxg5qA3LGDwwy6glnZLFljDtsxVnSDx3KYcs
	6v5qnE2r84zvxayuMlQ1V8ZFwsRSRJxdW1koKWA4DIetyGzWGh0verFlbFn3zGJn/csKIFmBRfK
	hMZpoosxDBjEssTElmJD0YBIFCDK8Sm0maa1glwRlhz4qZ830KALbKwOb+5f/085JShckHDMUZz
	EEBTaVUk7MWKpTixbrCT09BSIGt6/2VTLOjKDuH+SwClzB/YCizYvLQG01iY8kHkt3MPQ8F3hhh
	YWq/NjcDuGM+VLjJOt2rSBYiXvyhI2twfEJt4L5OXirwcpllkGw=
X-Google-Smtp-Source: AGHT+IFoWy+HBOk5/RjwFMxEcdxeTvlQajqO7J7ILcrPrTovokCAGX82ybYS7ZnI1tVD1FU0lj6GWw==
X-Received: by 2002:a05:6a21:3982:b0:218:bb70:bd23 with SMTP id adf61e73a8af0-21fbd5de25bmr33768184637.42.1750344195458;
        Thu, 19 Jun 2025 07:43:15 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31efce3235sm30410a12.37.2025.06.19.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:43:14 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	almasrymina@google.com,
	praan@google.com,
	shivajikant@google.com,
	asml.silence@gmail.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH v3 net-next] eth: bnxt: add netmem TX support
Date: Thu, 19 Jun 2025 14:40:58 +0000
Message-Id: <20250619144058.147051-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netmem_dma_*() helpers and declare netmem_tx to support netmem TX.
By this change, all bnxt devices will support the netmem TX.

Unreadable skbs are not going to be handled by the TX push logic.
So, it checks whether a skb is readable or not before the TX push logic.

netmem TX can be tested with ncdevmem.c

Acked-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Add missing changes in __bnxt_tx_int().
v2:
 - Fix commit message.
 - Add Ack tags from Mina and Stanislav.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 40 ++++++++++++++---------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d93b0a661ccb..dbc8a47ecefd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -477,6 +477,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
+	skb_frag_t *frag;
 
 	i = skb_get_queue_mapping(skb);
 	if (unlikely(i >= bp->tx_nr_rings)) {
@@ -563,7 +564,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		lflags |= cpu_to_le32(TX_BD_FLAGS_NO_CRC);
 
 	if (free_size == bp->tx_ring_size && length <= bp->tx_push_thresh &&
-	    !lflags) {
+	    skb_frags_readable(skb) && !lflags) {
 		struct tx_push_buffer *tx_push_buf = txr->tx_push;
 		struct tx_push_bd *tx_push = &tx_push_buf->push_bd;
 		struct tx_bd_ext *tx_push1 = &tx_push->txbd2;
@@ -598,9 +599,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_copy_from_linear_data(skb, pdata, len);
 		pdata += len;
 		for (j = 0; j < last_frag; j++) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
 			void *fptr;
 
+			frag = &skb_shinfo(skb)->frags[j];
 			fptr = skb_frag_address_safe(frag);
 			if (!fptr)
 				goto normal_tx;
@@ -708,8 +709,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
 	txbd0 = txbd;
 	for (i = 0; i < last_frag; i++) {
-		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-
+		frag = &skb_shinfo(skb)->frags[i];
 		prod = NEXT_TX(prod);
 		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 
@@ -721,7 +721,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto tx_dma_error;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
-		dma_unmap_addr_set(tx_buf, mapping, mapping);
+		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
+					  mapping, mapping);
 
 		txbd->tx_bd_haddr = cpu_to_le64(mapping);
 
@@ -778,9 +779,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (i = 0; i < last_frag; i++) {
 		prod = NEXT_TX(prod);
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
-		dma_unmap_page(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
-			       skb_frag_size(&skb_shinfo(skb)->frags[i]),
-			       DMA_TO_DEVICE);
+		frag = &skb_shinfo(skb)->frags[i];
+		netmem_dma_unmap_page_attrs(&pdev->dev,
+					    dma_unmap_addr(tx_buf, mapping),
+					    skb_frag_size(frag),
+					    DMA_TO_DEVICE, 0);
 	}
 
 tx_free:
@@ -809,6 +812,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	u16 hw_cons = txr->tx_hw_cons;
 	unsigned int tx_bytes = 0;
 	u16 cons = txr->tx_cons;
+	skb_frag_t *frag;
 	int tx_pkts = 0;
 	bool rc = false;
 
@@ -848,13 +852,14 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		last = tx_buf->nr_frags;
 
 		for (j = 0; j < last; j++) {
+			frag = &skb_shinfo(skb)->frags[j];
 			cons = NEXT_TX(cons);
 			tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
-			dma_unmap_page(
-				&pdev->dev,
-				dma_unmap_addr(tx_buf, mapping),
-				skb_frag_size(&skb_shinfo(skb)->frags[j]),
-				DMA_TO_DEVICE);
+			netmem_dma_unmap_page_attrs(&pdev->dev,
+						    dma_unmap_addr(tx_buf,
+								   mapping),
+						    skb_frag_size(frag),
+						    DMA_TO_DEVICE, 0);
 		}
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
@@ -3422,9 +3427,11 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
 
 			tx_buf = &txr->tx_buf_ring[ring_idx];
-			dma_unmap_page(&pdev->dev,
-				       dma_unmap_addr(tx_buf, mapping),
-				       skb_frag_size(frag), DMA_TO_DEVICE);
+			netmem_dma_unmap_page_attrs(&pdev->dev,
+						    dma_unmap_addr(tx_buf,
+								   mapping),
+						    skb_frag_size(frag),
+						    DMA_TO_DEVICE, 0);
 		}
 		dev_kfree_skb(skb);
 	}
@@ -16693,6 +16700,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	dev->request_ops_lock = true;
+	dev->netmem_tx = true;
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.34.1


