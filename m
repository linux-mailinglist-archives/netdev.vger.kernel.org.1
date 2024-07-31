Return-Path: <netdev+bounces-114698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942094389E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3759B23A31
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D67F16D4CC;
	Wed, 31 Jul 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xp7YsCrA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C5383B1
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463849; cv=none; b=myQecXakJeKREJ/FF5R6WmkLHXge96kTTVK9xCp4ElHFzOd9T88FRUVCb2YyDor0Ig2ojBHmT+I749g+uKEzvTpWDxdxSzB2ocKgvlNcAdcRUPOFTlkjhXlfMscw5QduZypYi2SyOmOS2ap1vGhwQYZbowjPG+2/dtBFeXJGcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463849; c=relaxed/simple;
	bh=QFozTuFy6CWnWEpDmmVCpzSBe6/5Nv+bNFaLk/y+tqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmpG/o5YGY7IkZrKFZRjf8WKxk4sPF0dVOcuASOxUwNgvcvlquVEfAJDyVPKhNL5RcYmEY4mKCnc5KiLBLSmuLmGyrqUiTpixaUnq6Mm5St2dyCcmOt7qltbcvnsaS294+7p9LIzZYUPC7HaCSeqztxKPXlkjDUnyO8vXrlSKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xp7YsCrA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722463847; x=1753999847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QFozTuFy6CWnWEpDmmVCpzSBe6/5Nv+bNFaLk/y+tqA=;
  b=Xp7YsCrAjsroih9MpiHWVv/hSQW0rDSJ71lF3RYMfJHOpuBkHYuzCtPK
   CXOgGpEEsGOeGbcQSNNW+bkzwXwJzEtgynP8X0bcQzKZrvRmt//VjpSqs
   AivzdOv+RkAtG14jMdCL3tP1QkPnhSqcb35Fnqu3qdcis4I7IbQISFPBi
   2wlneedRty0YweQ96hTkOYq+hwEHsUwghnTZKuaeKxjoXMDlYOpUEnsGs
   ufS4gsrcAIoemT2+H613WQy82jt/ErkQ+fNzAfU5BodMf8PXOOHnUZcNZ
   Jee8syZCBo2fYsKZ79BkfW5DxFOa3PajCPmb6x7GyJeiiwoeqjR2Tcw+e
   A==;
X-CSE-ConnectionGUID: VM6CrmjFR3up1vu3WgfvxQ==
X-CSE-MsgGUID: G8Pon+lVSzuZGGObFn7bPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31765475"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31765475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 15:10:45 -0700
X-CSE-ConnectionGUID: dHZ4STg3TJqSizqGajmshg==
X-CSE-MsgGUID: 9aP8AK0iSbeA0IlbeQJ4AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54734120"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 15:10:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Piotr Raczynski <piotr.raczynski@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v2 01/15] ice: add new VSI type for subfunctions
Date: Wed, 31 Jul 2024 15:10:12 -0700
Message-ID: <20240731221028.965449-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Raczynski <piotr.raczynski@intel.com>

Add required plumbing for new VSI type dedicated to devlink subfunctions.
Make sure that the vsi is properly configured and destroyed. Also allow
loading XDP and AF_XDP sockets.

The first implementation of devlink subfunctions supports only one Tx/Rx
queue pair per given subfunction.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c    |  5 +++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  1 +
 drivers/net/ethernet/intel/ice/ice_lib.c     | 25 ++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c    |  7 ++++--
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c     |  2 +-
 6 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 5d396c1a7731..34beee29d205 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -330,6 +330,9 @@ ice_setup_tx_ctx(struct ice_tx_ring *ring, struct ice_tlan_ctx *tlan_ctx, u16 pf
 		tlan_ctx->vmvf_num = hw->func_caps.vf_base_id + vsi->vf->vf_id;
 		tlan_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_VF;
 		break;
+	case ICE_VSI_SF:
+		tlan_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_VMQ;
+		break;
 	default:
 		return;
 	}
@@ -526,7 +529,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 
 	ring->rx_buf_len = ring->vsi->rx_buf_len;
 
-	if (ring->vsi->type == ICE_VSI_PF) {
+	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
 		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index a94e7072b570..a7c510832824 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -187,6 +187,7 @@ void ice_vsi_set_dcb_tc_cfg(struct ice_vsi *vsi)
 		vsi->tc_cfg.numtc = ice_dcb_get_num_tc(cfg);
 		break;
 	case ICE_VSI_CHNL:
+	case ICE_VSI_SF:
 		vsi->tc_cfg.ena_tc = BIT(ice_get_first_droptc(vsi));
 		vsi->tc_cfg.numtc = 1;
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f559e60992fa..be1e65bafe13 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -20,6 +20,8 @@ const char *ice_vsi_type_str(enum ice_vsi_type vsi_type)
 		return "ICE_VSI_PF";
 	case ICE_VSI_VF:
 		return "ICE_VSI_VF";
+	case ICE_VSI_SF:
+		return "ICE_VSI_SF";
 	case ICE_VSI_CTRL:
 		return "ICE_VSI_CTRL";
 	case ICE_VSI_CHNL:
@@ -135,6 +137,7 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 {
 	switch (vsi->type) {
 	case ICE_VSI_PF:
+	case ICE_VSI_SF:
 	case ICE_VSI_CTRL:
 	case ICE_VSI_LB:
 		/* a user could change the values of num_[tr]x_desc using
@@ -201,6 +204,12 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 					   max_t(int, vsi->alloc_rxq,
 						 vsi->alloc_txq));
 		break;
+	case ICE_VSI_SF:
+		vsi->alloc_txq = 1;
+		vsi->alloc_rxq = 1;
+		vsi->num_q_vectors = 1;
+		vsi->irq_dyn_alloc = true;
+		break;
 	case ICE_VSI_VF:
 		if (vf->num_req_qs)
 			vf->num_vf_qs = vf->num_req_qs;
@@ -558,6 +567,7 @@ ice_vsi_alloc_def(struct ice_vsi *vsi, struct ice_channel *ch)
 
 	switch (vsi->type) {
 	case ICE_VSI_PF:
+	case ICE_VSI_SF:
 		/* Setup default MSIX irq handler for VSI */
 		vsi->irq_handler = ice_msix_clean_rings;
 		break;
@@ -886,6 +896,11 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 					      max_rss_size);
 		vsi->rss_lut_type = ICE_LUT_PF;
 		break;
+	case ICE_VSI_SF:
+		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
+		vsi->rss_size = min_t(u16, num_online_cpus(), max_rss_size);
+		vsi->rss_lut_type = ICE_LUT_VSI;
+		break;
 	case ICE_VSI_VF:
 		/* VF VSI will get a small RSS table.
 		 * For VSI_LUT, LUT size should be set to 64 bytes.
@@ -1133,6 +1148,7 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
 		break;
 	case ICE_VSI_VF:
+	case ICE_VSI_SF:
 		/* VF VSI will gets a small RSS table which is a VSI LUT type */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
 		break;
@@ -1211,6 +1227,7 @@ static int ice_vsi_init(struct ice_vsi *vsi, u32 vsi_flags)
 	case ICE_VSI_PF:
 		ctxt->flags = ICE_AQ_VSI_TYPE_PF;
 		break;
+	case ICE_VSI_SF:
 	case ICE_VSI_CHNL:
 		ctxt->flags = ICE_AQ_VSI_TYPE_VMDQ2;
 		break;
@@ -2092,6 +2109,7 @@ static void ice_set_agg_vsi(struct ice_vsi *vsi)
 	case ICE_VSI_CHNL:
 	case ICE_VSI_LB:
 	case ICE_VSI_PF:
+	case ICE_VSI_SF:
 		max_agg_nodes = ICE_MAX_PF_AGG_NODES;
 		agg_node_id_start = ICE_PF_AGG_NODE_ID_START;
 		agg_node_iter = &pf->pf_agg_node[0];
@@ -2261,6 +2279,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 
 	switch (vsi->type) {
 	case ICE_VSI_CTRL:
+	case ICE_VSI_SF:
 	case ICE_VSI_PF:
 		ret = ice_vsi_alloc_q_vectors(vsi);
 		if (ret)
@@ -2647,7 +2666,8 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
 
 	clear_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
 
-	if (vsi->netdev && vsi->type == ICE_VSI_PF) {
+	if (vsi->netdev && (vsi->type == ICE_VSI_PF ||
+			    vsi->type == ICE_VSI_SF)) {
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
@@ -2676,7 +2696,8 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 
 	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
 
-	if (vsi->type == ICE_VSI_PF && vsi->netdev) {
+	if (vsi->netdev && (vsi->type == ICE_VSI_PF ||
+			    vsi->type == ICE_VSI_SF)) {
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ec636be4d17d..1d2c9126d848 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2968,6 +2968,9 @@ int ice_vsi_determine_xdp_res(struct ice_vsi *vsi)
 	if (avail < cpus / 2)
 		return -ENOMEM;
 
+	if (vsi->type == ICE_VSI_SF)
+		avail = vsi->alloc_txq;
+
 	vsi->num_xdp_txq = min_t(u16, avail, cpus);
 
 	if (vsi->num_xdp_txq < cpus)
@@ -3084,8 +3087,8 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	struct ice_netdev_priv *np = netdev_priv(dev);
 	struct ice_vsi *vsi = np->vsi;
 
-	if (vsi->type != ICE_VSI_PF) {
-		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF VSI");
+	if (vsi->type != ICE_VSI_PF && vsi->type != ICE_VSI_SF) {
+		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF or SF VSI");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 96037bef3e78..cf98bf8415c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -158,6 +158,7 @@ enum ice_vsi_type {
 	ICE_VSI_CTRL = 3,	/* equates to ICE_VSI_PF with 1 queue pair */
 	ICE_VSI_CHNL = 4,
 	ICE_VSI_LB = 6,
+	ICE_VSI_SF = 9,
 };
 
 struct ice_link_status {
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index a65955eb23c0..6247a3fec9de 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -287,7 +287,7 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 {
 	int err;
 
-	if (vsi->type != ICE_VSI_PF)
+	if (vsi->type != ICE_VSI_PF && vsi->type != ICE_VSI_SF)
 		return -EINVAL;
 
 	if (qid >= vsi->netdev->real_num_rx_queues ||
-- 
2.42.0


