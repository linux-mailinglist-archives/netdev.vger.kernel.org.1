Return-Path: <netdev+bounces-133359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91846995BBA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D203288DEF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093702185B9;
	Tue,  8 Oct 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckysRX5I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C021859B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430491; cv=none; b=sMRKJTTtGcUEhHweT4kquORYRH/Ogv6RfCXbYinrFxYwobVGI+heiH5tFTLhb2h+EypRpF2WcBD/ZUukJVKs3Xo5YX5QxUumn1DG2s7aQ4S3SiCitgDK6pB5x+Ohl5/3FaW/jc9eM9PoiuCi6RjsVfW4YpDrJyi4Bntfhg2UIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430491; c=relaxed/simple;
	bh=zevTVld8/d7GWo2XBSw8SGj6xl30CPHfmeplcQyFUG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKLMvpl2jDZzO/QuiZhUPjp0VjNmVX2ofTlbWKjuSN+bMDo01nyRRRcf4yYw7h9a7MVvtDvSyv+MBUQ2tJCd+v73v5DlKlCesTbSe8okAAx9QxEzqZvrNE5FBdjLt60lVwklZg1g1YCrAVej1VFQGaIe1yz6pr9w3zRuzWoULjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckysRX5I; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430490; x=1759966490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zevTVld8/d7GWo2XBSw8SGj6xl30CPHfmeplcQyFUG8=;
  b=ckysRX5IEqnU4z+c5Fh60LHMMiqVp4iIZSdfF0/fvOAA2+K4f1YhlB2+
   gJFOhI5nXUFWt3wFmQdkcTyKeD/yaGq5KrjfRTSYqEkJSAqLVu/Izb8BV
   zl13lBMXLHLIF7B9MV/QscLizGZ4ErHxx77RfPgzSzkBzuz39b99tbMGL
   tXVV8kJJLqoZ8+7e9yNAcGmobCXNzhJFk06wxDewU7vBfvKkbuxkXt0p/
   RxlojKA3pxnSuwvWmtbijuASQYfG+hGlSol5yGiSQsJdzMnhG0Krf3wKf
   OFZdvXfxd4ar/KkFtCW/WP2o16cJtIyT0RJsi+GNhEvFDMeV0O4YjL2MD
   Q==;
X-CSE-ConnectionGUID: JIW79XWJTCaNisDMcEq/NQ==
X-CSE-MsgGUID: pxLV40MGSu2uWt7T9dpeHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779873"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779873"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:48 -0700
X-CSE-ConnectionGUID: mL88Ek1BTh+wtfuPSC6VXg==
X-CSE-MsgGUID: y6Zm/8CIQ/65E+ywvJds5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794183"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 03/12] ice: consistently use q_idx in ice_vc_cfg_qs_msg()
Date: Tue,  8 Oct 2024 16:34:29 -0700
Message-ID: <20241008233441.928802-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_vc_cfg_qs_msg() function is used to configure VF queues in response
to a VIRTCHNL_OP_CONFIG_VSI_QUEUES command.

The virtchnl command contains an array of queue pair data for configuring
Tx and Rx queues. This data includes a queue ID. When configuring the
queues, the driver generally uses this queue ID to determine which Tx and
Rx ring to program. However, a handful of places use the index into the
queue pair data from the VF. While most VF implementations appear to send
this data in order, it is not mandated by the virtchnl and it is not
verified that the queue pair data comes in order.

Fix the driver to consistently use the q_idx field instead of the 'i'
iterator value when accessing the rings. For the Rx case, introduce a local
ring variable to keep lines short.

Fixes: 7ad15440acf8 ("ice: Refactor VIRTCHNL_OP_CONFIG_VSI_QUEUES handling")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 3c86d0c2fe1f..c8c1d48ff793 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1715,8 +1715,8 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 		/* copy Tx queue info from VF into VSI */
 		if (qpi->txq.ring_len > 0) {
-			vsi->tx_rings[i]->dma = qpi->txq.dma_ring_addr;
-			vsi->tx_rings[i]->count = qpi->txq.ring_len;
+			vsi->tx_rings[q_idx]->dma = qpi->txq.dma_ring_addr;
+			vsi->tx_rings[q_idx]->count = qpi->txq.ring_len;
 
 			/* Disable any existing queue first */
 			if (ice_vf_vsi_dis_single_txq(vf, vsi, q_idx))
@@ -1725,7 +1725,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			/* Configure a queue with the requested settings */
 			if (ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx)) {
 				dev_warn(ice_pf_to_dev(pf), "VF-%d failed to configure TX queue %d\n",
-					 vf->vf_id, i);
+					 vf->vf_id, q_idx);
 				goto error_param;
 			}
 		}
@@ -1733,24 +1733,23 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		/* copy Rx queue info from VF into VSI */
 		if (qpi->rxq.ring_len > 0) {
 			u16 max_frame_size = ice_vc_get_max_frame_size(vf);
+			struct ice_rx_ring *ring = vsi->rx_rings[q_idx];
 			u32 rxdid;
 
-			vsi->rx_rings[i]->dma = qpi->rxq.dma_ring_addr;
-			vsi->rx_rings[i]->count = qpi->rxq.ring_len;
+			ring->dma = qpi->rxq.dma_ring_addr;
+			ring->count = qpi->rxq.ring_len;
 
 			if (qpi->rxq.crc_disable)
-				vsi->rx_rings[q_idx]->flags |=
-					ICE_RX_FLAGS_CRC_STRIP_DIS;
+				ring->flags |= ICE_RX_FLAGS_CRC_STRIP_DIS;
 			else
-				vsi->rx_rings[q_idx]->flags &=
-					~ICE_RX_FLAGS_CRC_STRIP_DIS;
+				ring->flags &= ~ICE_RX_FLAGS_CRC_STRIP_DIS;
 
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
 			     qpi->rxq.databuffer_size < 1024))
 				goto error_param;
 			vsi->rx_buf_len = qpi->rxq.databuffer_size;
-			vsi->rx_rings[i]->rx_buf_len = vsi->rx_buf_len;
+			ring->rx_buf_len = vsi->rx_buf_len;
 			if (qpi->rxq.max_pkt_size > max_frame_size ||
 			    qpi->rxq.max_pkt_size < 64)
 				goto error_param;
@@ -1765,7 +1764,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 			if (ice_vsi_cfg_single_rxq(vsi, q_idx)) {
 				dev_warn(ice_pf_to_dev(pf), "VF-%d failed to configure RX queue %d\n",
-					 vf->vf_id, i);
+					 vf->vf_id, q_idx);
 				goto error_param;
 			}
 
-- 
2.42.0


