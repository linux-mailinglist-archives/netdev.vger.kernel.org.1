Return-Path: <netdev+bounces-88729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F1A8A85B2
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044FF1C20AE1
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA23D1411DB;
	Wed, 17 Apr 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gi3VlYJC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68B140399
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363347; cv=none; b=SqyPFLNlG86tVjJMPFPFvQaFIHjAf0eaq/iavdj9GpETrYPdaWQWOhozEOj0ht68N/Aanv5iNEgMQqB7/QBJYTysZR8oVDq2zcacIFaWVVty4/7SixCnmCU2hMb2srtNS8fSRB6XhzPMkSzqLBTlvMz4whyPL+elET4c3KRKVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363347; c=relaxed/simple;
	bh=dvrwrf5NWb+t7xsukKkrqdRndZXps3O3vclOaiEKKjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyAY3o8VST+oIJAKf6Da7wgmxWaSRLyhNNSKmbw1WgJYtQz45dm7fdbijmvIhHfyDV6/M7ucpruXl1inuBrm8C+h+szuwzC2H0fd5YimUT8KA62Ib6tC8K13Dmaqtk8rqVs2bf6m2IfhdlwYqmDqFhs7N/VkqLVy/RRayyOrxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gi3VlYJC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713363347; x=1744899347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dvrwrf5NWb+t7xsukKkrqdRndZXps3O3vclOaiEKKjY=;
  b=gi3VlYJC6PC5ORCK9PtJVDjQ8q4l7HgC02JwMjD/lFn0n55VX1kdwcLa
   rMdSXbdbL6UPBKTvckMHK4k8jIAw0E9lWTpDzEBEMGYCebDDzU4wjTYKG
   uk47IMAeGpx/c0LCGRm4VB59MUOcdG11KB1Ks0QlR5UhrkrXiJrsl9YPV
   hEAOCSJlv6E5zdL4FQxMNxwmva6YDqeH9wboFXqJMu2nWcJPkkurItYMb
   qupA6Zmoj+e+D4V0Ac422xndLHVxgq2J+vHEjMyfJrTE37bDcnKs0h/uZ
   RkCGD1rBjzFFsXOM3cH2Doy705ZJ0t25zR+UuRwZ5e6bipoTXn1E7VvXr
   A==;
X-CSE-ConnectionGUID: UDEGHpOwQI2c/5Cr++PRdA==
X-CSE-MsgGUID: 6M72pSJ6QUq4splHeRC4rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8737128"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8737128"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:15:46 -0700
X-CSE-ConnectionGUID: /Nyk7a9dSyWXVs5pNklC2Q==
X-CSE-MsgGUID: i/x4GDpPS7OB7kUgEWz+Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="60050424"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 17 Apr 2024 07:15:35 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: [iwl-next v4 1/8] ice: add new VSI type for subfunctions
Date: Wed, 17 Apr 2024 16:20:21 +0200
Message-ID: <20240417142028.2171-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
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

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c    |  5 +++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  1 +
 drivers/net/ethernet/intel/ice/ice_lib.c     | 25 ++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c    |  7 ++++--
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c     |  2 +-
 6 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 687f6cb2b917..bf1a085c7087 100644
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
index d06e7c82c433..06909bf3b517 100644
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
@@ -141,6 +143,7 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 {
 	switch (vsi->type) {
 	case ICE_VSI_PF:
+	case ICE_VSI_SF:
 	case ICE_VSI_CTRL:
 	case ICE_VSI_LB:
 		/* a user could change the values of num_[tr]x_desc using
@@ -207,6 +210,12 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
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
@@ -566,6 +575,7 @@ ice_vsi_alloc_def(struct ice_vsi *vsi, struct ice_channel *ch)
 
 	switch (vsi->type) {
 	case ICE_VSI_PF:
+	case ICE_VSI_SF:
 		/* Setup default MSIX irq handler for VSI */
 		vsi->irq_handler = ice_msix_clean_rings;
 		break;
@@ -894,6 +904,11 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
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
@@ -1141,6 +1156,7 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
 		break;
 	case ICE_VSI_VF:
+	case ICE_VSI_SF:
 		/* VF VSI will gets a small RSS table which is a VSI LUT type */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
 		break;
@@ -1219,6 +1235,7 @@ static int ice_vsi_init(struct ice_vsi *vsi, u32 vsi_flags)
 	case ICE_VSI_PF:
 		ctxt->flags = ICE_AQ_VSI_TYPE_PF;
 		break;
+	case ICE_VSI_SF:
 	case ICE_VSI_CHNL:
 		ctxt->flags = ICE_AQ_VSI_TYPE_VMDQ2;
 		break;
@@ -2100,6 +2117,7 @@ static void ice_set_agg_vsi(struct ice_vsi *vsi)
 	case ICE_VSI_CHNL:
 	case ICE_VSI_LB:
 	case ICE_VSI_PF:
+	case ICE_VSI_SF:
 		max_agg_nodes = ICE_MAX_PF_AGG_NODES;
 		agg_node_id_start = ICE_PF_AGG_NODE_ID_START;
 		agg_node_iter = &pf->pf_agg_node[0];
@@ -2271,6 +2289,7 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
 
 	switch (vsi->type) {
 	case ICE_VSI_CTRL:
+	case ICE_VSI_SF:
 	case ICE_VSI_PF:
 		ret = ice_vsi_alloc_q_vectors(vsi);
 		if (ret)
@@ -2662,7 +2681,8 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
 
 	clear_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
 
-	if (vsi->netdev && vsi->type == ICE_VSI_PF) {
+	if (vsi->netdev && (vsi->type == ICE_VSI_PF ||
+			    vsi->type == ICE_VSI_SF)) {
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
@@ -2691,7 +2711,8 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 
 	set_bit(ICE_VSI_NEEDS_RESTART, vsi->state);
 
-	if (vsi->type == ICE_VSI_PF && vsi->netdev) {
+	if (vsi->netdev && (vsi->type == ICE_VSI_PF ||
+			    vsi->type == ICE_VSI_SF)) {
 		if (netif_running(vsi->netdev)) {
 			if (!locked)
 				rtnl_lock();
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9d3f6683339e..8a4d9029434f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2946,6 +2946,9 @@ int ice_vsi_determine_xdp_res(struct ice_vsi *vsi)
 	if (avail < cpus / 2)
 		return -ENOMEM;
 
+	if (vsi->type == ICE_VSI_SF)
+		avail = vsi->alloc_txq;
+
 	vsi->num_xdp_txq = min_t(u16, avail, cpus);
 
 	if (vsi->num_xdp_txq < cpus)
@@ -3061,8 +3064,8 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	struct ice_netdev_priv *np = netdev_priv(dev);
 	struct ice_vsi *vsi = np->vsi;
 
-	if (vsi->type != ICE_VSI_PF) {
-		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF VSI");
+	if (vsi->type != ICE_VSI_PF && vsi->type != ICE_VSI_SF) {
+		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF or SF VSI");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index f0796a93f428..cdb923c1664a 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -150,6 +150,7 @@ enum ice_vsi_type {
 	ICE_VSI_CTRL = 3,	/* equates to ICE_VSI_PF with 1 queue pair */
 	ICE_VSI_CHNL = 4,
 	ICE_VSI_LB = 6,
+	ICE_VSI_SF = 9,
 };
 
 struct ice_link_status {
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index aa81d1162b81..64f4927efa29 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -288,7 +288,7 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 {
 	int err;
 
-	if (vsi->type != ICE_VSI_PF)
+	if (vsi->type != ICE_VSI_PF && vsi->type != ICE_VSI_SF)
 		return -EINVAL;
 
 	if (qid >= vsi->netdev->real_num_rx_queues ||
-- 
2.42.0


