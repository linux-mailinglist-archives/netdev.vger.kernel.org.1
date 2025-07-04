Return-Path: <netdev+bounces-204205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B937AF97F1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389A37AAF4F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7506C24DD0B;
	Fri,  4 Jul 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRsLpuxx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB728A726
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645975; cv=none; b=p9WAjOtsM7ZP3XGe3dcFpAvG8CC2wZYlcpya7nM0PDpnzxCBhO4Yz38AC6XprLL4qQw+WZZwdGIcZ1REaWrTo4qWkDGbVJNvFhAmUeMyZFpXWpsdoWQGmTtZgbXNXQqYIxKbacSHkYzyMDeE8FiTR+lHgohU8dKE6dHm3M6Ivvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645975; c=relaxed/simple;
	bh=S5NAoUuRkk3MyG2PTYca14W3BaJJAvNe8cRlDvm1WjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUCK8mvm+7KRkYBLhNcw/lRTw3ceoDuJUk8nof0jfHu7TtBiVLh9BKUvDUhXwIp4Gm6REL40pxrbbG8XvsONXN8bVvOcFetrBr7HiXjuUldwXNfLSctf94hgZV4tYO4Uots/hYENjhOJe/PGk8CnlXyTWnILVkME7dazqeUFgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRsLpuxx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751645973; x=1783181973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5NAoUuRkk3MyG2PTYca14W3BaJJAvNe8cRlDvm1WjI=;
  b=FRsLpuxxnshdeiB/VUPW5OlbXFxSyL+P0uuszDcNTrf4t7CYcCy457X4
   YW3lDusRY+++RkgbUx6qCaPeIqPe6pZZZUFu1jk+1zeJKonP+89eR7Qtr
   vfb036zYePgPcm2YXDZAYg4HJv4IO4EmkXXCtPBCUge1iEPIk5Fhbr5zJ
   hO4swVqKVDDAtTR5E8M9b/krg/nE6vZ5osMEN9ZBY4GrBQJh562LUDYA6
   jmJGOUydvwRExGzdrdYCRtPbgzXRULiFVeo3L2FZ3KueoTNjxfucHY99i
   iX/tF9hmBRODK/mCFzyTWwstZ+SSBDZYcGULOxFraIwwxPb0hqcvVmLCi
   g==;
X-CSE-ConnectionGUID: UDaCJJTUQjupQZAMythVbg==
X-CSE-MsgGUID: ItU1CM1aTeiKktqvcNZLYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="64672749"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="64672749"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:19:33 -0700
X-CSE-ConnectionGUID: W7mQlU14QR6fxrbLecYa/A==
X-CSE-MsgGUID: g7qEyxsRR++RuQZXRBex6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154094649"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:19:31 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-next 2/3] ice: drop page splitting and recycling
Date: Fri,  4 Jul 2025 18:18:58 +0200
Message-ID: <20250704161859.871152-3-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704161859.871152-1-michal.kubiak@intel.com>
References: <20250704161859.871152-1-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the transition toward Page Pool integration, remove the
legacy page splitting and recycling logic from the ice driver. This
mirrors the approach taken in commit 920d86f3c552 ("iavf: drop page
splitting and recycling").

The previous model attempted to reuse partially consumed pages by
splitting them and tracking their usage across descriptors. While
this was once a memory optimization, it introduced significant
complexity and overhead in the Rx path, including:
- Manual refcount management and page reuse heuristics;
- Per-descriptor buffer shuffling, which could involve moving dozens
  of `ice_rx_buf` structures per NAPI cycle;
- Increased branching and cache pressure in the hotpath.

This change simplifies the Rx logic by always allocating fresh pages
and letting the networking stack handle their lifecycle. Although this
may temporarily reduce performance (up to ~98% in some XDP cases), it
greatly improves maintainability and paves the way for Page Pool,
which will restore and exceed previous performance levels.

The `ice_rx_buf` array is retained for now to minimize diffstat and
ease future replacement with a shared buffer abstraction.

Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c     |  26 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 132 ++----------------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   7 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   5 +-
 5 files changed, 27 insertions(+), 145 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index d67dc2f02acf..bf37c8420828 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -369,6 +369,8 @@ struct ice_vsi {
 	spinlock_t arfs_lock;	/* protects aRFS hash table and filter state */
 	atomic_t *arfs_last_fltr_id;
 
+	u16 max_frame;
+
 	struct ice_aqc_vsi_props info;	 /* VSI properties */
 	struct ice_vsi_vlan_info vlan_info;	/* vlan config to be restored */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b981555630e6..ceb969fe0ba2 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -391,7 +391,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Receive Packet Data Buffer Size.
 	 * The Packet Data Buffer Size is defined in 128 byte units.
 	 */
-	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
+	rlan_ctx.dbuf = DIV_ROUND_UP(ICE_RXBUF_3072,
 				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
 
 	/* use 32 byte descriptors */
@@ -432,8 +432,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Max packet size for this queue - must not be set to a larger value
 	 * than 5 x DBUF
 	 */
-	rlan_ctx.rxmax = min_t(u32, ring->max_frame,
-			       ICE_MAX_CHAINED_RX_BUFS * ring->rx_buf_len);
+	rlan_ctx.rxmax = min_t(u32, vsi->max_frame,
+			       ICE_MAX_CHAINED_RX_BUFS * ICE_RXBUF_3072);
 
 	/* Rx queue threshold in units of 64 */
 	rlan_ctx.lrxqthresh = 1;
@@ -504,7 +504,7 @@ static unsigned int ice_get_frame_sz(struct ice_rx_ring *rx_ring)
 #if (PAGE_SIZE >= 8192)
 	frame_sz = rx_ring->rx_buf_len;
 #else
-	frame_sz = ice_rx_pg_size(rx_ring) / 2;
+	frame_sz = PAGE_SIZE / 2;
 #endif
 
 	return frame_sz;
@@ -520,6 +520,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 {
 	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	u32 num_bufs = ICE_RX_DESC_UNUSED(ring);
+	u32 rx_buf_len;
 	int err;
 
 	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
@@ -527,7 +528,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
+						 ICE_RXBUF_3072);
 			if (err)
 				return err;
 		}
@@ -536,12 +537,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		if (ring->xsk_pool) {
 			xdp_rxq_info_unreg(&ring->xdp_rxq);
 
-			ring->rx_buf_len =
+			rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
+						 rx_buf_len);
 			if (err)
 				return err;
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -559,7 +560,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 							 ring->q_index,
 							 ring->q_vector->napi.napi_id,
-							 ring->rx_buf_len);
+							 ICE_RXBUF_3072);
 				if (err)
 					return err;
 			}
@@ -631,17 +632,14 @@ int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
 static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi, struct ice_rx_ring *ring)
 {
 	if (!vsi->netdev) {
-		ring->max_frame = ICE_MAX_FRAME_LEGACY_RX;
-		ring->rx_buf_len = ICE_RXBUF_1664;
+		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
 #if (PAGE_SIZE < 8192)
 	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
 		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
-		ring->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
-		ring->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
+		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
 #endif
 	} else {
-		ring->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		ring->rx_buf_len = ICE_RXBUF_3072;
+		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index af09e8d214b7..cd561ce30e1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -412,13 +412,13 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 		 */
 		dma_sync_single_range_for_cpu(dev, rx_buf->dma,
 					      rx_buf->page_offset,
-					      rx_ring->rx_buf_len,
+					      ICE_RXBUF_3072,
 					      DMA_FROM_DEVICE);
 
 		/* free resources associated with mapping */
-		dma_unmap_page_attrs(dev, rx_buf->dma, ice_rx_pg_size(rx_ring),
+		dma_unmap_page_attrs(dev, rx_buf->dma, PAGE_SIZE,
 				     DMA_FROM_DEVICE, ICE_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buf->page, rx_buf->pagecnt_bias);
+		__free_page(rx_buf->page);
 
 		rx_buf->page = NULL;
 		rx_buf->page_offset = 0;
@@ -672,10 +672,6 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
 	struct page *page = bi->page;
 	dma_addr_t dma;
 
-	/* since we are recycling buffers we should seldom need to alloc */
-	if (likely(page))
-		return true;
-
 	/* alloc new page for storage */
 	page = dev_alloc_pages(ice_rx_pg_order(rx_ring));
 	if (unlikely(!page)) {
@@ -684,7 +680,7 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0, ice_rx_pg_size(rx_ring),
+	dma = dma_map_page_attrs(rx_ring->dev, page, 0, PAGE_SIZE,
 				 DMA_FROM_DEVICE, ICE_RX_DMA_ATTR);
 
 	/* if mapping failed free memory back to system since
@@ -700,7 +696,6 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
 	bi->page = page;
 	bi->page_offset = rx_ring->rx_offset;
 	page_ref_add(page, USHRT_MAX - 1);
-	bi->pagecnt_bias = USHRT_MAX;
 
 	return true;
 }
@@ -771,7 +766,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 		/* sync the buffer for use by the device */
 		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
 						 bi->page_offset,
-						 rx_ring->rx_buf_len,
+						 ICE_RXBUF_3072,
 						 DMA_FROM_DEVICE);
 
 		/* Refresh the desc even if buffer_addrs didn't change
@@ -800,69 +795,6 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 	return !!cleaned_count;
 }
 
-/**
- * ice_rx_buf_adjust_pg_offset - Prepare Rx buffer for reuse
- * @rx_buf: Rx buffer to adjust
- * @size: Size of adjustment
- *
- * Update the offset within page so that Rx buf will be ready to be reused.
- * For systems with PAGE_SIZE < 8192 this function will flip the page offset
- * so the second half of page assigned to Rx buffer will be used, otherwise
- * the offset is moved by "size" bytes
- */
-static void
-ice_rx_buf_adjust_pg_offset(struct ice_rx_buf *rx_buf, unsigned int size)
-{
-#if (PAGE_SIZE < 8192)
-	/* flip page offset to other buffer */
-	rx_buf->page_offset ^= size;
-#else
-	/* move offset up to the next cache line */
-	rx_buf->page_offset += size;
-#endif
-}
-
-/**
- * ice_can_reuse_rx_page - Determine if page can be reused for another Rx
- * @rx_buf: buffer containing the page
- *
- * If page is reusable, we have a green light for calling ice_reuse_rx_page,
- * which will assign the current buffer to the buffer that next_to_alloc is
- * pointing to; otherwise, the DMA mapping needs to be destroyed and
- * page freed
- */
-static bool
-ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
-{
-	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
-	struct page *page = rx_buf->page;
-
-	/* avoid re-using remote and pfmemalloc pages */
-	if (!dev_page_is_reusable(page))
-		return false;
-
-	/* if we are only owner of page we can reuse it */
-	if (unlikely(rx_buf->pgcnt - pagecnt_bias > 1))
-		return false;
-#if (PAGE_SIZE >= 8192)
-#define ICE_LAST_OFFSET \
-	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_3072)
-	if (rx_buf->page_offset > ICE_LAST_OFFSET)
-		return false;
-#endif /* PAGE_SIZE >= 8192) */
-
-	/* If we have drained the page fragment pool we need to update
-	 * the pagecnt_bias and page count so that we fully restock the
-	 * number of references the driver holds.
-	 */
-	if (unlikely(pagecnt_bias == 1)) {
-		page_ref_add(page, USHRT_MAX - 1);
-		rx_buf->pagecnt_bias = USHRT_MAX;
-	}
-
-	return true;
-}
-
 /**
  * ice_add_xdp_frag - Add contents of Rx buffer to xdp buf as a frag
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -905,35 +837,6 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	return 0;
 }
 
-/**
- * ice_reuse_rx_page - page flip buffer and store it back on the ring
- * @rx_ring: Rx descriptor ring to store buffers on
- * @old_buf: donor buffer to have page reused
- *
- * Synchronizes page for reuse by the adapter
- */
-static void
-ice_reuse_rx_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *old_buf)
-{
-	u16 nta = rx_ring->next_to_alloc;
-	struct ice_rx_buf *new_buf;
-
-	new_buf = &rx_ring->rx_buf[nta];
-
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* Transfer page from old buffer to new buffer.
-	 * Move each member individually to avoid possible store
-	 * forwarding stalls and unnecessary copy of skb.
-	 */
-	new_buf->dma = old_buf->dma;
-	new_buf->page = old_buf->page;
-	new_buf->page_offset = old_buf->page_offset;
-	new_buf->pagecnt_bias = old_buf->pagecnt_bias;
-}
-
 /**
  * ice_get_rx_buf - Fetch Rx buffer and synchronize data for use
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -959,9 +862,6 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 				      rx_buf->page_offset, size,
 				      DMA_FROM_DEVICE);
 
-	/* We have pulled a buffer for use, so decrement pagecnt_bias */
-	rx_buf->pagecnt_bias--;
-
 	return rx_buf;
 }
 
@@ -1057,16 +957,10 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
 	if (!rx_buf)
 		return;
 
-	if (ice_can_reuse_rx_page(rx_buf)) {
-		/* hand second half of page back to the ring */
-		ice_reuse_rx_page(rx_ring, rx_buf);
-	} else {
-		/* we are not reusing the buffer so unmap it */
-		dma_unmap_page_attrs(rx_ring->dev, rx_buf->dma,
-				     ice_rx_pg_size(rx_ring), DMA_FROM_DEVICE,
-				     ICE_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buf->page, rx_buf->pagecnt_bias);
-	}
+	/* we are not reusing the buffer so unmap it */
+	dma_unmap_page_attrs(rx_ring->dev, rx_buf->dma,
+			     PAGE_SIZE, DMA_FROM_DEVICE,
+			     ICE_RX_DMA_ATTR);
 
 	/* clear contents of buffer_info */
 	rx_buf->page = NULL;
@@ -1100,14 +994,10 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	for (i = 0; i < post_xdp_frags; i++) {
 		buf = &rx_ring->rx_buf[idx];
 
-		if (verdict & (ICE_XDP_TX | ICE_XDP_REDIR)) {
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
+		if (verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
 			*xdp_xmit |= verdict;
-		} else if (verdict & ICE_XDP_CONSUMED) {
+		else if (verdict & ICE_XDP_CONSUMED)
 			buf->pagecnt_bias++;
-		} else if (verdict == ICE_XDP_PASS) {
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		}
 
 		ice_put_rx_buf(rx_ring, buf);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index fef750c5f288..f7fb24afb2aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -359,7 +359,6 @@ struct ice_rx_ring {
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
 	u32 nr_frags;
-	u16 max_frame;
 	u16 rx_buf_len;
 	dma_addr_t dma;			/* physical address of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
@@ -480,15 +479,9 @@ struct ice_coalesce_stored {
 
 static inline unsigned int ice_rx_pg_order(struct ice_rx_ring *ring)
 {
-#if (PAGE_SIZE < 8192)
-	if (ring->rx_buf_len > (PAGE_SIZE / 2))
-		return 1;
-#endif
 	return 0;
 }
 
-#define ice_rx_pg_size(_ring) (PAGE_SIZE << ice_rx_pg_order(_ring))
-
 union ice_32b_rx_flex_desc;
 
 void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 num_descs);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 257967273079..0090099917ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -2086,18 +2086,17 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
 			     qpi->rxq.databuffer_size < 1024))
 				goto error_param;
-			ring->rx_buf_len = qpi->rxq.databuffer_size;
 			if (qpi->rxq.max_pkt_size > max_frame_size ||
 			    qpi->rxq.max_pkt_size < 64)
 				goto error_param;
 
-			ring->max_frame = qpi->rxq.max_pkt_size;
+			vsi->max_frame = qpi->rxq.max_pkt_size;
 			/* add space for the port VLAN since the VF driver is
 			 * not expected to account for it in the MTU
 			 * calculation
 			 */
 			if (ice_vf_is_port_vlan_ena(vf))
-				ring->max_frame += VLAN_HLEN;
+				vsi->max_frame += VLAN_HLEN;
 
 			if (ice_vsi_cfg_single_rxq(vsi, q_idx)) {
 				dev_warn(ice_pf_to_dev(pf), "VF-%d failed to configure RX queue %d\n",
-- 
2.45.2


