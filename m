Return-Path: <netdev+bounces-190219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CFEAB5A1A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE133AFF46
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067642C0325;
	Tue, 13 May 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNeKQP8u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57472C0320
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154107; cv=none; b=gibvjPBIkGHV8mJAdNLkVVJa/XA7f5j79kLhFLvnMG+aJOXXZDIzN4HebMfIOmgZJ+t1ngr0E5ofadWt7Diu/zVYBfedN4Wg1vt6mLWe7BoYSIMUUVRYr9QPnK4aD6W0LPfNWB4euYtHLP0qFjWUMSSmfWpfYPU/T4JguKGoO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154107; c=relaxed/simple;
	bh=LuI21fazPCPjiw1XUPMaiVnZtrF9a5CII2+pk6dGMbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RcR3dfwcElBTqVtR2B2K4K7dAO97oBV52L9kSQ8z299NjvBRTjEL3opGPYZtfqW3dh8FzJ/fFgE8Rap/XklFpMdbHH0EhX68QIhMWjqpRnhPhrKRmG+R5IXYB864S79XgOBOu6IStAFUMuT0myuL0PQG1Qg97lG/3z3X3x6VN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNeKQP8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B460FC4CEF3;
	Tue, 13 May 2025 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747154107;
	bh=LuI21fazPCPjiw1XUPMaiVnZtrF9a5CII2+pk6dGMbc=;
	h=From:Date:Subject:To:Cc:From;
	b=DNeKQP8u6rZUMWUrtj4oQIwZ2DmD0fxD41mka5vzWkPcfAchWkkQpks/AxhjSCpHq
	 ttVMhsyUDjT8i24LJc4qcNfDv9NixcCrD2jf2GyXYQ2irXVBKhD817cWZv/N0eRUce
	 6WgyrUN012hFMHlgUzm/x+mY4vj2BUuXctfe2/ncYroTN3HtbeupOIeCGbV6q1zhyi
	 bIpCbqCGK/Ksf+vnWFMTB53t3WrYgp2ROx4ZK/iuOxHMssl0vZr1idF8Xz7uk2xs4C
	 3/0+6NxiSfNt+vDhkf6XBArjONNFTePiI47YPjoafkgB6IGJ2xInsYmzDParp9MZDQ
	 LO86uFVHma8Pw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 13 May 2025 18:34:44 +0200
Subject: [PATCH net] net: airoha: Fix page recycling in
 airoha_qdma_rx_process()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-airoha-fix-rx-process-error-condition-v1-1-e5d70cd7c066@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKN0I2gC/x2NMQ6DMAwAv4I8YwnShqFfqRhC4oCXGNkIISH+X
 qvjDXd3g5EyGXy6G5RONpbmMPYd5C21lZCLM4QhxCGOL0yssiWsfKFeuKtkMkNSFcUsrfDhBVw
 mimWJoZZ3BW/tSm78P9/5eX7p9jhmdwAAAA==
X-Change-ID: 20250513-airoha-fix-rx-process-error-condition-b6e5db52fd4f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Do not recycle the page twice in airoha_qdma_rx_process routine in case
of error. Just run dev_kfree_skb() if the skb has been allocated and marked
for recycling. Run page_pool_put_full_page() directly if the skb has not
been allocated yet.
Moreover, rely on DMA address from queue entry element instead of reading
it from the DMA descriptor for DMA syncing in airoha_qdma_rx_process().

Fixes: e12182ddb6e71 ("net: airoha: Enable Rx Scatter-Gather")
---
 drivers/net/ethernet/airoha/airoha_eth.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d748dc6de92367365db9f9548f9af52a7fdac187..1e9ab65218ff144d99b47f5d4ad5ff4f9c227418 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -614,7 +614,6 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
 		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
-		dma_addr_t dma_addr = le32_to_cpu(desc->addr);
 		struct page *page = virt_to_head_page(e->buf);
 		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
 		struct airoha_gdm_port *port;
@@ -623,22 +622,16 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
 			break;
 
-		if (!dma_addr)
-			break;
-
-		len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
-		if (!len)
-			break;
-
 		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 
-		dma_sync_single_for_cpu(eth->dev, dma_addr,
+		dma_sync_single_for_cpu(eth->dev, e->dma_addr,
 					SKB_WITH_OVERHEAD(q->buf_size), dir);
 
+		len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
 		data_len = q->skb ? q->buf_size
 				  : SKB_WITH_OVERHEAD(q->buf_size);
-		if (data_len < len)
+		if (!len || data_len < len)
 			goto free_frag;
 
 		p = airoha_qdma_get_gdm_port(eth, desc);
@@ -701,9 +694,12 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		q->skb = NULL;
 		continue;
 free_frag:
-		page_pool_put_full_page(q->page_pool, page, true);
-		dev_kfree_skb(q->skb);
-		q->skb = NULL;
+		if (q->skb) {
+			dev_kfree_skb(q->skb);
+			q->skb = NULL;
+		} else {
+			page_pool_put_full_page(q->page_pool, page, true);
+		}
 	}
 	airoha_qdma_fill_rx_queue(q);
 

---
base-commit: 4227ea91e2657f7965e34313448e9d0a2b67712e
change-id: 20250513-airoha-fix-rx-process-error-condition-b6e5db52fd4f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


