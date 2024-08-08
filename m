Return-Path: <netdev+bounces-116967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5C794C3BB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610991F21E58
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294A19004F;
	Thu,  8 Aug 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWlyG2QN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8382C7E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138272; cv=none; b=twH/DvkBLev5+WkYM1iuoAcPnAHjSI3hZxoP1KNWQayNwnyrh84WnbWPSZhRQCTajMwmmXM099vDkxGiuTwLDHJK4pzkH6zl7xRuYwJRowa1yj94+bOoXvZAINlA30d9sesHwYhF1EQX/d1xYEdriYdXsmKsFy9Gwrwlf1ZU/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138272; c=relaxed/simple;
	bh=5pZI0DhneMrzk+LJHzW8B8uLQmHB4QKDiVrYnouvFaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHeQjirHQ1Gv8/Uq1DiP6rXdpjKvexkRCtzkzQIpVOZ/pAJ6IflkqARYunkrb3NEf0b00M9bJn3vTaIXyBoG4X7YKMkAFgu0D0KasZkzl8JZydM/VgNjg142CAr4mcIzkrBGiBIz3CDH5L7DaSiIDgp8cQvSGIAJ1AnhHBluNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWlyG2QN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723138271; x=1754674271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pZI0DhneMrzk+LJHzW8B8uLQmHB4QKDiVrYnouvFaM=;
  b=FWlyG2QNR/lLq6byJJeHAjGSvX6swzYDo1ujJe7QSoWL5SRkccBUZGYS
   SWpdt+0H9jLuDHgHcQijicTFTXEXd+JYpcnDuxaBz8RcmUcJwX3AAJ8ZS
   edxFBd9gTOQM0TSa0DXVJjDS7qY3HEDXufN5DjcmAKxLnsBs9nG8bWXco
   Z5AEHWaoOkVtzD17iDgGEVNOZiG8RCbr5MqkkVQ8saSSoLg4we3ImA816
   JV8l6UmcvZ5S3hKh08djp8BTylJ+sbjDVLtuPGKE4yB5eJ/FKOT53zoqs
   CZk9xiv9XqKzvkAKUWGhm4fvoLvjiqF1KAw1g9A+2h0WbXFoxao1i/xvk
   Q==;
X-CSE-ConnectionGUID: tLbqNqh7T9ibh4WHUg/zjA==
X-CSE-MsgGUID: mzbkSoJ9Q3aM/EH5PdIA7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32675376"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="32675376"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 10:31:09 -0700
X-CSE-ConnectionGUID: togPLidpRNy6Zhna2HnOBA==
X-CSE-MsgGUID: MHx8ns6STBCaQPOeNkx7AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="61682413"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 10:31:08 -0700
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
Subject: [PATCH net-next v3 01/15] ice: add new VSI type for subfunctions
Date: Thu,  8 Aug 2024 10:30:47 -0700
Message-ID: <20240808173104.385094-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
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
index 1facf179a96f..bcc59dea7564 100644
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
index 3de020020bc4..5986f676062d 100644
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
index 240a7bec242b..b918cce8dee6 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -298,7 +298,7 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 {
 	int err;
 
-	if (vsi->type != ICE_VSI_PF)
+	if (vsi->type != ICE_VSI_PF && vsi->type != ICE_VSI_SF)
 		return -EINVAL;
 
 	if (qid >= vsi->netdev->real_num_rx_queues ||
-- 
2.42.0


