Return-Path: <netdev+bounces-16111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A262874B68C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E8280C48
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12417AD7;
	Fri,  7 Jul 2023 18:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B717AA6
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6DCC433BA;
	Fri,  7 Jul 2023 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755188;
	bh=rHDX+yDL7HxzYs+rJvOA0l4y8FJUaQ6Mduuo8dOdRac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoMRdQlwjILHG8vALKWdTGThKwzO5BlnndxQ4gL5lx0d5DzGxeXe60WX/ol3qd8lW
	 2kDoR3M9lP/QNgyOawqEw/AyAKDNO6j7vFUL6W5zAvjAsnGomgTTuGOmC4zy1nGI+S
	 akYwJxrOy6tzQg+vpi9/+6jciIexFXdKb+3gpoSo4ip+kfUkz89nzhd7C1w0r6HFIA
	 udGhObkbQmMn2tExWdoI6HSi6NH3uNiGmd+hgZreYoZEVhU3qsZgugEnfJzPql+1Lb
	 KauaJygVdiR935TGxaXGgA+KFjOtkT1F0IgiNOAEmhfqrfAlvEtzP70U8Tj/41EqHF
	 WMSroydInmmkA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	edumazet@google.com,
	dsahern@gmail.com,
	michael.chan@broadcom.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 11/12] eth: bnxt: wrap coherent allocations into helpers
Date: Fri,  7 Jul 2023 11:39:34 -0700
Message-ID: <20230707183935.997267-12-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
References: <20230707183935.997267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prep for using a huge-page backed allocator.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 58 +++++++++++++----------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 679a28c038a2..b36c42d37a38 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2831,6 +2831,18 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static void *bnxt_alloc_coherent(struct bnxt *bp, unsigned long size,
+				 dma_addr_t *dma, gfp_t gfp)
+{
+	return dma_alloc_coherent(&bp->pdev->dev, size, dma, gfp);
+}
+
+static void bnxt_free_coherent(struct bnxt *bp, unsigned long size,
+			       void *addr, dma_addr_t dma)
+{
+	return dma_free_coherent(&bp->pdev->dev, size, addr, dma);
+}
+
 static void bnxt_free_tx_skbs(struct bnxt *bp)
 {
 	int i, max_idx;
@@ -3027,7 +3039,6 @@ static void bnxt_init_ctx_mem(struct bnxt_mem_init *mem_init, void *p, int len)
 
 static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 {
-	struct pci_dev *pdev = bp->pdev;
 	int i;
 
 	if (!rmem->pg_arr)
@@ -3037,8 +3048,8 @@ static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 		if (!rmem->pg_arr[i])
 			continue;
 
-		dma_free_coherent(&pdev->dev, rmem->page_size,
-				  rmem->pg_arr[i], rmem->dma_arr[i]);
+		bnxt_free_coherent(bp, rmem->page_size,
+				   rmem->pg_arr[i], rmem->dma_arr[i]);
 
 		rmem->pg_arr[i] = NULL;
 	}
@@ -3048,8 +3059,8 @@ static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 
 		if (rmem->flags & BNXT_RMEM_USE_FULL_PAGE_FLAG)
 			pg_tbl_size = rmem->page_size;
-		dma_free_coherent(&pdev->dev, pg_tbl_size,
-				  rmem->pg_tbl, rmem->pg_tbl_map);
+		bnxt_free_coherent(bp, pg_tbl_size,
+				   rmem->pg_tbl, rmem->pg_tbl_map);
 		rmem->pg_tbl = NULL;
 	}
 	if (rmem->vmem_size && *rmem->vmem) {
@@ -3060,7 +3071,6 @@ static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 
 static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 {
-	struct pci_dev *pdev = bp->pdev;
 	u64 valid_bit = 0;
 	int i;
 
@@ -3071,7 +3081,7 @@ static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 
 		if (rmem->flags & BNXT_RMEM_USE_FULL_PAGE_FLAG)
 			pg_tbl_size = rmem->page_size;
-		rmem->pg_tbl = dma_alloc_coherent(&pdev->dev, pg_tbl_size,
+		rmem->pg_tbl = bnxt_alloc_coherent(bp, pg_tbl_size,
 						  &rmem->pg_tbl_map,
 						  GFP_KERNEL);
 		if (!rmem->pg_tbl)
@@ -3081,7 +3091,7 @@ static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 	for (i = 0; i < rmem->nr_pages; i++) {
 		u64 extra_bits = valid_bit;
 
-		rmem->pg_arr[i] = dma_alloc_coherent(&pdev->dev,
+		rmem->pg_arr[i] = bnxt_alloc_coherent(bp,
 						     rmem->page_size,
 						     &rmem->dma_arr[i],
 						     GFP_KERNEL);
@@ -3282,7 +3292,6 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 static void bnxt_free_tx_rings(struct bnxt *bp)
 {
 	int i;
-	struct pci_dev *pdev = bp->pdev;
 
 	if (!bp->tx_ring)
 		return;
@@ -3292,8 +3301,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 		struct bnxt_ring_struct *ring;
 
 		if (txr->tx_push) {
-			dma_free_coherent(&pdev->dev, bp->tx_push_size,
-					  txr->tx_push, txr->tx_push_mapping);
+			bnxt_free_coherent(bp, bp->tx_push_size,
+					   txr->tx_push, txr->tx_push_mapping);
 			txr->tx_push = NULL;
 		}
 
@@ -3306,7 +3315,6 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 static int bnxt_alloc_tx_rings(struct bnxt *bp)
 {
 	int i, j, rc;
-	struct pci_dev *pdev = bp->pdev;
 
 	bp->tx_push_size = 0;
 	if (bp->tx_push_thresh) {
@@ -3341,7 +3349,7 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 			/* One pre-allocated DMA buffer to backup
 			 * TX push operation
 			 */
-			txr->tx_push = dma_alloc_coherent(&pdev->dev,
+			txr->tx_push = bnxt_alloc_coherent(bp,
 						bp->tx_push_size,
 						&txr->tx_push_mapping,
 						GFP_KERNEL);
@@ -4017,7 +4025,6 @@ static void bnxt_free_vnic_attributes(struct bnxt *bp)
 {
 	int i;
 	struct bnxt_vnic_info *vnic;
-	struct pci_dev *pdev = bp->pdev;
 
 	if (!bp->vnic_info)
 		return;
@@ -4032,15 +4039,15 @@ static void bnxt_free_vnic_attributes(struct bnxt *bp)
 		vnic->uc_list = NULL;
 
 		if (vnic->mc_list) {
-			dma_free_coherent(&pdev->dev, vnic->mc_list_size,
-					  vnic->mc_list, vnic->mc_list_mapping);
+			bnxt_free_coherent(bp, vnic->mc_list_size,
+					   vnic->mc_list, vnic->mc_list_mapping);
 			vnic->mc_list = NULL;
 		}
 
 		if (vnic->rss_table) {
-			dma_free_coherent(&pdev->dev, vnic->rss_table_size,
-					  vnic->rss_table,
-					  vnic->rss_table_dma_addr);
+			bnxt_free_coherent(bp, vnic->rss_table_size,
+					   vnic->rss_table,
+					   vnic->rss_table_dma_addr);
 			vnic->rss_table = NULL;
 		}
 
@@ -4053,7 +4060,6 @@ static int bnxt_alloc_vnic_attributes(struct bnxt *bp)
 {
 	int i, rc = 0, size;
 	struct bnxt_vnic_info *vnic;
-	struct pci_dev *pdev = bp->pdev;
 	int max_rings;
 
 	for (i = 0; i < bp->nr_vnics; i++) {
@@ -4074,7 +4080,7 @@ static int bnxt_alloc_vnic_attributes(struct bnxt *bp)
 		if (vnic->flags & BNXT_VNIC_MCAST_FLAG) {
 			vnic->mc_list_size = BNXT_MAX_MC_ADDRS * ETH_ALEN;
 			vnic->mc_list =
-				dma_alloc_coherent(&pdev->dev,
+				bnxt_alloc_coherent(bp,
 						   vnic->mc_list_size,
 						   &vnic->mc_list_mapping,
 						   GFP_KERNEL);
@@ -4108,7 +4114,7 @@ static int bnxt_alloc_vnic_attributes(struct bnxt *bp)
 			size = L1_CACHE_ALIGN(BNXT_MAX_RSS_TABLE_SIZE_P5);
 
 		vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
-		vnic->rss_table = dma_alloc_coherent(&pdev->dev,
+		vnic->rss_table = bnxt_alloc_coherent(bp,
 						     vnic->rss_table_size,
 						     &vnic->rss_table_dma_addr,
 						     GFP_KERNEL);
@@ -4159,8 +4165,8 @@ static void bnxt_free_stats_mem(struct bnxt *bp, struct bnxt_stats_mem *stats)
 	kfree(stats->sw_stats);
 	stats->sw_stats = NULL;
 	if (stats->hw_stats) {
-		dma_free_coherent(&bp->pdev->dev, stats->len, stats->hw_stats,
-				  stats->hw_stats_map);
+		bnxt_free_coherent(bp, stats->len, stats->hw_stats,
+				   stats->hw_stats_map);
 		stats->hw_stats = NULL;
 	}
 }
@@ -4168,8 +4174,8 @@ static void bnxt_free_stats_mem(struct bnxt *bp, struct bnxt_stats_mem *stats)
 static int bnxt_alloc_stats_mem(struct bnxt *bp, struct bnxt_stats_mem *stats,
 				bool alloc_masks)
 {
-	stats->hw_stats = dma_alloc_coherent(&bp->pdev->dev, stats->len,
-					     &stats->hw_stats_map, GFP_KERNEL);
+	stats->hw_stats = bnxt_alloc_coherent(bp, stats->len,
+					      &stats->hw_stats_map, GFP_KERNEL);
 	if (!stats->hw_stats)
 		return -ENOMEM;
 
-- 
2.41.0


