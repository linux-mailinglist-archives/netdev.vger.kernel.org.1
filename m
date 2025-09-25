Return-Path: <netdev+bounces-226226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1730B9E4AD
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC703B6B71
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D402E972C;
	Thu, 25 Sep 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etCQzOkx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA4287267
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792202; cv=none; b=Rw3TkNKqh17LsYTJ3pBqLD28DenpUrDJ90uN/Wokan10bbpa+XILYMVL0i+0oJRRND/pgYG3lbAag8DXygbJt8MBH5d5vtAWKRqMHcnpRAE68Cc03BZ/t4SUnrEacLx+xE4UaUC1Q3HWfw2HrpYMMtzhL+/3PM1RcPJCcbtowGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792202; c=relaxed/simple;
	bh=2GkVst/qXmI8asfQP83t0rpAzjI6bjQTITjI6JzCWfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjseXS90FQfbM+nGuoM6z9kv0i+4fIu/eQj4RmgTE4EtmYtfhVUhGd8ZIkGjCSRPCZXw9oj1ng7MWDiHhx5B1ZzpSa3Fq1BZfouPIiLogauUELUfhq8TuvoEB+ca0i+PeXV3/rzPO2pWMS3ITH87qc2n8eV8NrsJpd5/YRwR3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etCQzOkx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758792200; x=1790328200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2GkVst/qXmI8asfQP83t0rpAzjI6bjQTITjI6JzCWfI=;
  b=etCQzOkxrHwB3/K4GSeeRtZ807mYxm5NhPGyCDDk2JecJ8z1//SiMDqu
   oX3BSSXiJpiSiEGG7CFSCblGvaI0CHrfQr2Sy4KOiFJs2bhvUulAcP6nJ
   6XpRSsN/xMSp9/b6hE0+W/lxg2IDxvrYmkBiu0cpFO348LZJhv8B+3ge7
   /ui05FS811YHDltwSwW0heMLideOeyedZ6MFVW8ZKbFQ/CieRzy5o2Bcl
   GeMBfzwvau5XG3T/5x6XwhaJh5MsOQwqmlCCsmxGCgKlDtNkoFDsNZVg4
   XWE90vLGY1rCe5nOfettr2GT0b2pSftG1bfva2cokCnGkvQGprzgUntCu
   w==;
X-CSE-ConnectionGUID: DBJjAMk1T3yQT0IHoACHwg==
X-CSE-MsgGUID: owCOLJ/LSXWcYE3//vFWtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71724555"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="71724555"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 02:23:20 -0700
X-CSE-ConnectionGUID: g5u+aO5nQhSUn3Y9c9juYQ==
X-CSE-MsgGUID: e6J1chIGSdODukb8ZMLAaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="214411811"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 02:23:18 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com,
	larysa.zaremba@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	pmenzel@molgen.mpg.de,
	anthony.l.nguyen@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-next v3 1/3] ice: remove legacy Rx and construct SKB
Date: Thu, 25 Sep 2025 11:22:51 +0200
Message-ID: <20250925092253.1306476-2-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250925092253.1306476-1-michal.kubiak@intel.com>
References: <20250925092253.1306476-1-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 53844673d555 ("iavf: kill 'legacy-rx' for good") removed
the legacy Rx path in the iavf driver. This change applies the same
rationale to the ice driver.

The legacy Rx path relied on manual skb allocation and header copying,
which has become increasingly inefficient and difficult to maintain.
With the stabilization of build_skb() and the growing adoption of
features like XDP, page_pool, and multi-buffer support, the legacy
approach is no longer viable.

Key drawbacks of the legacy path included:
- Higher memory pressure due to direct page allocations and splitting;
- Redundant memcpy() operations for packet headers;
- CPU overhead from eth_get_headlen() and Flow Dissector usage;
- Compatibility issues with XDP, which imposes strict headroom and
  tailroom requirements.

The ice driver, like iavf, does not benefit from the minimal headroom
savings that legacy Rx once offered, as it already splits pages into
fixed halves. Removing this path simplifies the Rx logic, eliminates
unnecessary branches in the hotpath, and prepares the driver for
upcoming enhancements.

In addition to removing the legacy Rx path, this change also eliminates
the custom construct_skb() functions from both the standard and
zero-copy (ZC) Rx paths. These are replaced with the build_skb()
and standarized xdp_build_skb_from_zc() helpers, aligning the driver
with the modern XDP infrastructure and reducing code duplication.

This cleanup also reduces code complexity and improves maintainability
as we move toward a more unified and modern Rx model across drivers.

Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_base.c    | 23 +-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  5 --
 drivers/net/ethernet/intel/ice/ice_main.c    | 11 +--
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 86 +-------------------
 drivers/net/ethernet/intel/ice/ice_txrx.h    | 16 ----
 drivers/net/ethernet/intel/ice/ice_xsk.c     | 72 +---------------
 7 files changed, 6 insertions(+), 208 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 9ee596773f34..28de4273c2e8 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -509,7 +509,6 @@ enum ice_pf_flags {
 	ICE_FLAG_MOD_POWER_UNSUPPORTED,
 	ICE_FLAG_PHY_FW_LOAD_FAILED,
 	ICE_FLAG_ETHTOOL_CTXT,		/* set when ethtool holds RTNL lock */
-	ICE_FLAG_LEGACY_RX,
 	ICE_FLAG_VF_TRUE_PROMISC_ENA,
 	ICE_FLAG_MDD_AUTO_RESET_VF,
 	ICE_FLAG_VF_VLAN_PRUNING,
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 2d35a278c555..b3eb9f512500 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -461,19 +461,6 @@ u16 ice_calc_ts_ring_count(struct ice_tx_ring *tx_ring)
 	return tx_ring->count + max_fetch_desc;
 }
 
-/**
- * ice_rx_offset - Return expected offset into page to access data
- * @rx_ring: Ring we are requesting offset of
- *
- * Returns the offset value for ring into the data buffer.
- */
-static unsigned int ice_rx_offset(struct ice_rx_ring *rx_ring)
-{
-	if (ice_ring_uses_build_skb(rx_ring))
-		return ICE_SKB_PAD;
-	return 0;
-}
-
 /**
  * ice_setup_rx_ctx - Configure a receive ring context
  * @ring: The Rx ring to configure
@@ -586,13 +573,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	if (vsi->type == ICE_VSI_VF)
 		return 0;
 
-	/* configure Rx buffer alignment */
-	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
-		ice_clear_ring_build_skb_ena(ring);
-	else
-		ice_set_ring_build_skb_ena(ring);
-
-	ring->rx_offset = ice_rx_offset(ring);
+	ring->rx_offset = ICE_SKB_PAD;
 
 	/* init queue specific tail register */
 	ring->tail = hw->hw_addr + QRX_TAIL(pf_q);
@@ -753,7 +734,7 @@ int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
  */
 static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi, struct ice_rx_ring *ring)
 {
-	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
+	if (!vsi->netdev) {
 		ring->max_frame = ICE_MAX_FRAME_LEGACY_RX;
 		ring->rx_buf_len = ICE_RXBUF_1664;
 #if (PAGE_SIZE < 8192)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 4dbfe5779168..7155e161530b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -340,7 +340,6 @@ static const struct ice_priv_flag ice_gstrings_priv_flags[] = {
 		      ICE_FLAG_VF_TRUE_PROMISC_ENA),
 	ICE_PRIV_FLAG("mdd-auto-reset-vf", ICE_FLAG_MDD_AUTO_RESET_VF),
 	ICE_PRIV_FLAG("vf-vlan-pruning", ICE_FLAG_VF_VLAN_PRUNING),
-	ICE_PRIV_FLAG("legacy-rx", ICE_FLAG_LEGACY_RX),
 };
 
 #define ICE_PRIV_FLAG_ARRAY_SIZE	ARRAY_SIZE(ice_gstrings_priv_flags)
@@ -1856,10 +1855,6 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 			ice_nway_reset(netdev);
 		}
 	}
-	if (test_bit(ICE_FLAG_LEGACY_RX, change_flags)) {
-		/* down and up VSI so that changes of Rx cfg are reflected. */
-		ice_down_up(vsi);
-	}
 	/* don't allow modification of this flag when a single VF is in
 	 * promiscuous mode because it's not supported
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 953bf557d9d2..b877151b45a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2957,10 +2957,7 @@ int ice_vsi_determine_xdp_res(struct ice_vsi *vsi)
  */
 static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
 {
-	if (test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
-		return ICE_RXBUF_1664;
-	else
-		return ICE_RXBUF_3072;
+	return ICE_RXBUF_3072;
 }
 
 /**
@@ -7848,12 +7845,6 @@ int ice_change_mtu(struct net_device *netdev, int new_mtu)
 				   frame_size - ICE_ETH_PKT_HDR_PAD);
 			return -EINVAL;
 		}
-	} else if (test_bit(ICE_FLAG_LEGACY_RX, pf->flags)) {
-		if (new_mtu + ICE_ETH_PKT_HDR_PAD > ICE_MAX_FRAME_LEGACY_RX) {
-			netdev_err(netdev, "Too big MTU for legacy-rx; Max is %d\n",
-				   ICE_MAX_FRAME_LEGACY_RX - ICE_ETH_PKT_HDR_PAD);
-			return -EINVAL;
-		}
 	}
 
 	/* if a reset is in progress, wait for some time for it to complete */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 73f08d02f9c7..5d59ee45d3da 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1169,87 +1169,6 @@ ice_build_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 	return skb;
 }
 
-/**
- * ice_construct_skb - Allocate skb and populate it
- * @rx_ring: Rx descriptor ring to transact packets on
- * @xdp: xdp_buff pointing to the data
- *
- * This function allocates an skb. It then populates it with the page
- * data from the current receive descriptor, taking care to set up the
- * skb correctly.
- */
-static struct sk_buff *
-ice_construct_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
-{
-	unsigned int size = xdp->data_end - xdp->data;
-	struct skb_shared_info *sinfo = NULL;
-	struct ice_rx_buf *rx_buf;
-	unsigned int nr_frags = 0;
-	unsigned int headlen;
-	struct sk_buff *skb;
-
-	/* prefetch first cache line of first page */
-	net_prefetch(xdp->data);
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-		nr_frags = sinfo->nr_frags;
-	}
-
-	/* allocate a skb to store the frags */
-	skb = napi_alloc_skb(&rx_ring->q_vector->napi, ICE_RX_HDR_SIZE);
-	if (unlikely(!skb))
-		return NULL;
-
-	rx_buf = &rx_ring->rx_buf[rx_ring->first_desc];
-	skb_record_rx_queue(skb, rx_ring->q_index);
-	/* Determine available headroom for copy */
-	headlen = size;
-	if (headlen > ICE_RX_HDR_SIZE)
-		headlen = eth_get_headlen(skb->dev, xdp->data, ICE_RX_HDR_SIZE);
-
-	/* align pull length to size of long to optimize memcpy performance */
-	memcpy(__skb_put(skb, headlen), xdp->data, ALIGN(headlen,
-							 sizeof(long)));
-
-	/* if we exhaust the linear part then add what is left as a frag */
-	size -= headlen;
-	if (size) {
-		/* besides adding here a partial frag, we are going to add
-		 * frags from xdp_buff, make sure there is enough space for
-		 * them
-		 */
-		if (unlikely(nr_frags >= MAX_SKB_FRAGS - 1)) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
-		skb_add_rx_frag(skb, 0, rx_buf->page,
-				rx_buf->page_offset + headlen, size,
-				xdp->frame_sz);
-	} else {
-		/* buffer is unused, restore biased page count in Rx buffer;
-		 * data was copied onto skb's linear part so there's no
-		 * need for adjusting page offset and we can reuse this buffer
-		 * as-is
-		 */
-		rx_buf->pagecnt_bias++;
-	}
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		struct skb_shared_info *skinfo = skb_shinfo(skb);
-
-		memcpy(&skinfo->frags[skinfo->nr_frags], &sinfo->frags[0],
-		       sizeof(skb_frag_t) * nr_frags);
-
-		xdp_update_skb_frags_info(skb, skinfo->nr_frags + nr_frags,
-					  sinfo->xdp_frags_size,
-					  nr_frags * xdp->frame_sz,
-					  xdp_buff_get_skb_flags(xdp));
-	}
-
-	return skb;
-}
-
 /**
  * ice_put_rx_buf - Clean up used buffer and either recycle or free
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1464,10 +1383,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		continue;
 construct_skb:
-		if (likely(ice_ring_uses_build_skb(rx_ring)))
-			skb = ice_build_skb(rx_ring, xdp);
-		else
-			skb = ice_construct_skb(rx_ring, xdp);
+		skb = ice_build_skb(rx_ring, xdp);
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 841a07bfba54..427f672fe053 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -373,7 +373,6 @@ struct ice_rx_ring {
 	dma_addr_t dma;			/* physical address of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 ptp_rx;
-#define ICE_RX_FLAGS_RING_BUILD_SKB	BIT(1)
 #define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
 #define ICE_RX_FLAGS_MULTIDEV		BIT(3)
 #define ICE_RX_FLAGS_RING_GCS		BIT(4)
@@ -422,21 +421,6 @@ struct ice_tx_ring {
 	u16 quanta_prof_id;
 } ____cacheline_internodealigned_in_smp;
 
-static inline bool ice_ring_uses_build_skb(struct ice_rx_ring *ring)
-{
-	return !!(ring->flags & ICE_RX_FLAGS_RING_BUILD_SKB);
-}
-
-static inline void ice_set_ring_build_skb_ena(struct ice_rx_ring *ring)
-{
-	ring->flags |= ICE_RX_FLAGS_RING_BUILD_SKB;
-}
-
-static inline void ice_clear_ring_build_skb_ena(struct ice_rx_ring *ring)
-{
-	ring->flags &= ~ICE_RX_FLAGS_RING_BUILD_SKB;
-}
-
 static inline bool ice_ring_ch_enabled(struct ice_tx_ring *ring)
 {
 	return !!ring->ch;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 575fd48f485f..b25bc5ba40ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -392,69 +392,6 @@ bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring,
 	return __ice_alloc_rx_bufs_zc(rx_ring, xsk_pool, leftover);
 }
 
-/**
- * ice_construct_skb_zc - Create an sk_buff from zero-copy buffer
- * @rx_ring: Rx ring
- * @xdp: Pointer to XDP buffer
- *
- * This function allocates a new skb from a zero-copy Rx buffer.
- *
- * Returns the skb on success, NULL on failure.
- */
-static struct sk_buff *
-ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
-{
-	unsigned int totalsize = xdp->data_end - xdp->data_meta;
-	unsigned int metasize = xdp->data - xdp->data_meta;
-	struct skb_shared_info *sinfo = NULL;
-	struct sk_buff *skb;
-	u32 nr_frags = 0;
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-		nr_frags = sinfo->nr_frags;
-	}
-	net_prefetch(xdp->data_meta);
-
-	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
-	if (unlikely(!skb))
-		return NULL;
-
-	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
-	       ALIGN(totalsize, sizeof(long)));
-
-	if (metasize) {
-		skb_metadata_set(skb, metasize);
-		__skb_pull(skb, metasize);
-	}
-
-	if (likely(!xdp_buff_has_frags(xdp)))
-		goto out;
-
-	for (int i = 0; i < nr_frags; i++) {
-		struct skb_shared_info *skinfo = skb_shinfo(skb);
-		skb_frag_t *frag = &sinfo->frags[i];
-		struct page *page;
-		void *addr;
-
-		page = dev_alloc_page();
-		if (!page) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
-		addr = page_to_virt(page);
-
-		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
-
-		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
-					   addr, 0, skb_frag_size(frag));
-	}
-
-out:
-	xsk_buff_free(xdp);
-	return skb;
-}
-
 /**
  * ice_clean_xdp_irq_zc - produce AF_XDP descriptors to CQ
  * @xdp_ring: XDP Tx ring
@@ -757,20 +694,15 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 
 construct_skb:
 		/* XDP_PASS path */
-		skb = ice_construct_skb_zc(rx_ring, first);
+		skb = xdp_build_skb_from_zc(first);
 		if (!skb) {
+			xsk_buff_free(first);
 			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
 			break;
 		}
 
 		first = NULL;
 		rx_ring->first_desc = ntc;
-
-		if (eth_skb_pad(skb)) {
-			skb = NULL;
-			continue;
-		}
-
 		total_rx_bytes += skb->len;
 		total_rx_packets++;
 
-- 
2.45.2


