Return-Path: <netdev+bounces-199089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B192ADEE7A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C30163289
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F172EA46E;
	Wed, 18 Jun 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+tAR63v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE801C6FE1
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254844; cv=none; b=n63kMQYwWnlmng4927VhCDAmj85yIlvtE/LQknBwXOKyHaE+pAIce4X1hoLbYjlhAuVQS5ADuCXOQ1Ju/uvzd/0UvxXN1A/9RdsjyHoWJ32FLOL0gBRZAxgPuBjUl8gKqqIDsDnExewLGxeSKD9/A6lE7SVX/H5mcaiOtopUIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254844; c=relaxed/simple;
	bh=vWd/xlH2l9SqMnHtPB15GaJB3+HicFCJCM5BKl5iYOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zz8Dvbn+sMVjMhLiUN8OVQbsVdOp21+HBu5SFTwl/FyxKcCV8BgcJGqkdUCvMjcReIN9H0vCPwxy0LIBpYJnFjhRkobXhTbur+t081R+uFa9hkjR5b3mbLrEn4pBNoIJTga4F6KTJVCQvXaVMR6wRmuITR4UfymXqx32eiurWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+tAR63v; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso7610645a91.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 06:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750254843; x=1750859643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnjyQs+wSE0RtTPHl1rQk/zZJEVFmCm9DyJ5YgJY0DI=;
        b=h+tAR63v7zhmjOmVzNt4t3oAvu5VRDBsaj7IRMExn74RrdGclNI/7zBOTYct5i5jBa
         xi1eUr+OPRLwoy4Zc902OIzsGSywwxRA0LUieqRbkBp0LmPT1+1nmWcKjaO1M75q9knl
         DN2AmdoMmHvVtiSeZkScJn9rxBoS8Dz5/rpmfHd/Kms8b1GhDvssJg23BtVGqSNzpZH7
         qwcM8gqhFF7QhSiF2TI07wptcQ7txjKR1W+32JvWf/Sc5wTshHaYWOqNb5KkfeR86AQX
         Wgo95pGuUCqAfT+4D39NySTrzlHZZI6KvWMBCsDHg5+962LuZbucNIV9b6seNOqwyK9y
         cWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254843; x=1750859643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnjyQs+wSE0RtTPHl1rQk/zZJEVFmCm9DyJ5YgJY0DI=;
        b=T7Uuppw8wyGnjdCTUc06WTR/NFClkW5Jm/oXYxWtN46jcoAaEpTTz6sYtljtE3JAn2
         GVWCSidUgiCDvpXaT++RNj/3n8KUGM0k5pnC1jXCvCENV0fjFn5Qejj2aHS9gkYYsfR/
         j8OZVEZ0GHGj7v5wtbHRK6yw8YyPHhMnC1Jam4Gn6u2Yj+3Ym6RE5iFdsnWSY8GfK4Qi
         WdvcaY57+E9i3q9nRnapjrSESP0VUCVB1nBeedGaFem+Z4ERdIB0vDi9aErVxGeMwTfW
         FGqNXCKvL0EOXqncqUyTEyQDWxZK+kNokGeg1O27h1pecJlIWM6L2E8PF7OnJziMjHGa
         kpiA==
X-Forwarded-Encrypted: i=1; AJvYcCWikBroyhdRiWCYUvMUyom0mT06TqYInNYgAYr39It836/2o6Dk12Ev6U19i7Cnyt5QBoS/VDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYJY4EWsd+NqM5+dmJnu6IuINWBDmP43tYMvaKVHY5M5SePXk
	Rxf5au5s1H3q4Dvr15LU1p/tk0BwtXwZMBroL4HU1tko2/mYV5hVW7vt
X-Gm-Gg: ASbGncvDztoWiJ9sx9tr9VtiwU5+s869bBW9RlehHMvm2yXu3RNJd/dxukG85ZSjTw+
	9b/hmCR54NXwnS6zaQFWPjAsaUM8jGoUQ3ZYJV8sPFKIlWyOF3Ignt8XXAovnv8orDKC/ZRLur1
	JxJzSMOyE0QTa+2Cv6eRWF+H7bQ6N732ZRfPZ8r3pux8KXZBjMRh+bf5TC1xfuHhfByFIWhihme
	DENuDusI8j5SNksDIpTi5R36qa/c7exWdAUHOsX0RiSwJivWQ9KQytlUnVkN+UXgguGWlmHuxBm
	jV270omkOUZCXoy3d30yexPrxYcaVvO21w7zVh1B3MA7iNRGkVY=
X-Google-Smtp-Source: AGHT+IHoP1/lgNfKCn5JKcriGcsFZNvmMM3Rz5aOvNWSA1Rh/YuCCSTiHiQOHYoE23869xS+2/AKKA==
X-Received: by 2002:a17:90b:5243:b0:311:ab20:159d with SMTP id 98e67ed59e1d1-313f1db7dc3mr23732748a91.19.1750254842517;
        Wed, 18 Jun 2025 06:54:02 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decb5ccsm100099155ad.223.2025.06.18.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 06:54:01 -0700 (PDT)
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
Subject: [PATCH v2 net-next] eth: bnxt: add netmem TX support
Date: Wed, 18 Jun 2025 13:53:35 +0000
Message-Id: <20250618135335.932969-1-ap420073@gmail.com>
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

v2:
 - Fix commit message.
 - Add Ack tags from Mina and Stanislav.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 ++++++++++++++---------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 00a60b2b90c4..cd9d1b75738a 100644
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
@@ -3422,9 +3425,11 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
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
@@ -16713,6 +16718,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	dev->request_ops_lock = true;
+	dev->netmem_tx = true;
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.34.1


