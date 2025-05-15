Return-Path: <netdev+bounces-190627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6237AB7E0C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B753A8F43
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8551A08AB;
	Thu, 15 May 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+BMLNUM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3C8F6B
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290816; cv=none; b=le3cxDIy5QxIIupxsSr5e8lyf2YT819lQA7fOAt3nopjLqHvxomvfRAwf6npiSRnaLIvrsafmMRgUL9sA2igsrG+f+BhxlMwGk4XIAkfTNU+qHlmZFLnDy65aiy52V1ydRzYmZ03Dg0Urq9ulNqFFGCRsSDF71goOiwYno5i36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290816; c=relaxed/simple;
	bh=cbgw9V6+Bp5MHHZNIW3rwxi/2ijk9oU/XpwF92m4FqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dp/H1Nja7DxBF87azVPgGu7UxPlDGvnDoBKq+RaVCUJnl8+p2cNc5wlbpVg7aO6FXQohiYKhGQPq4g6VH+NBslvN6yuEBUv9247UD1b2Kn5vgKqD0qulwkZ6GMyWyG2d26+0PD6w5Kv25JAUAJy2vmuWXk6femYCHycYo5Xhqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+BMLNUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EF2C4CEE9;
	Thu, 15 May 2025 06:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747290815;
	bh=cbgw9V6+Bp5MHHZNIW3rwxi/2ijk9oU/XpwF92m4FqE=;
	h=From:Date:Subject:To:Cc:From;
	b=D+BMLNUMB2Vy87lZM2dhvbjvAU3/q53V4thtud/f8WqZcPx726NeWFyIziJ3hjlFK
	 nAIdNSRVnjC/jKayjqGGOegQLLhkEcrf4Nd6uoOizkLDwfSST2y3GX2PDe3vI1sWuT
	 LS1Uvzicy6HACYfwvKG4F6y6KBqiVej1HsYcgGRctp6MMhcuFaJvWkhfe3rm8KjaB1
	 bFIcXfAaaPg97efmXJdUm9V+menpl4NXZc3jocs5wTSvfdJ1fb16IDWztjgi9oWIAI
	 3w48nZrywTnS3W3HAU7kH0/7hc+CfBBElpWr79GSjaoREQshSDSfOArDrLuuo9id9Z
	 CH4LWaIgc3Vow==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 15 May 2025 08:33:06 +0200
Subject: [PATCH net v2] net: airoha: Fix page recycling in
 airoha_qdma_rx_process()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-airoha-fix-rx-process-error-condition-v2-1-657e92c894b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKGKJWgC/5WNQQ6CMBBFr0Jm7Zi2WkhceQ/DAtoBJprWTAnBE
 O7uyA1cvp/89zYoJEwFbtUGQgsXzknBnSoIU5dGQo7K4IzzxtsLdix56nDgFWXFt+RApSCJZMG
 QU+RZDdjX5GPv3RCvA6jrLaSPo/NolScuc5bPkV3sb/23sFi0qJHGhNgEU9f3J0mi1znLCO2+7
 1+YFHm82wAAAA==
X-Change-ID: 20250513-airoha-fix-rx-process-error-condition-b6e5db52fd4f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
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
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Add missing signed-off-by
- Link to v1: https://lore.kernel.org/r/20250513-airoha-fix-rx-process-error-condition-v1-1-e5d70cd7c066@kernel.org
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
base-commit: 09db7a4d287d1a2bcfc04df023c103d1213a0518
change-id: 20250513-airoha-fix-rx-process-error-condition-b6e5db52fd4f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


