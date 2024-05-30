Return-Path: <netdev+bounces-99506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34E8D5126
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D9C1F22C4E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1604C602;
	Thu, 30 May 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hvd3rzA7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4F481B9
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090809; cv=none; b=LMGCGYL3YxCdMLAIT38CNEoql1UG8Jm9YEEWENYUALuA2WVy3SXOqLUQDHZjmfh7pN4/p/OB40nxNpPpuMZzxwdW7mJrR4vZq5h7Q+ZHw7LEj5caklh9dJTC8YASZmyZpli/D9sBRlZv62uoReCQG1dKWx7PKoRE3k2Z1YCslTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090809; c=relaxed/simple;
	bh=Kg6ibsTMYlJRhm/X4dMYvY9c3LXtKklGp5ExQ377yNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOwRXGsTH77GudNlhieTveRmRKJ7cwiet24XQVU5jWlLUUSW4x/IhgBURnm9c/eOly69yMvCQZybF+6YXOMTpj/fX5SFkOtSEkbqctKxg71g6bIMOKPmLYWeIkvkLd9Xv37jxmlBSiSwHodyrzeubP+laRl+SeaK4iJK88l9fa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hvd3rzA7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717090807; x=1748626807;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Kg6ibsTMYlJRhm/X4dMYvY9c3LXtKklGp5ExQ377yNw=;
  b=Hvd3rzA7C8nT0MSlKjbgaeTQWmogBj5W3HBF/tuNQFQyXACoDTzT2iLw
   Ks4H4Q73lsyp/9JV5XLJJKb5FUxmoTysv6hteL2VOoMhAw2KyBC3FPYid
   iOT5OHP8Uq36OlHzaI7HZk6EIvjYjzT6q/6MfCfp7b6TUEeP1KaYOrFfT
   ycElRBBGY5uSto6bjGvr/deJKc5iYLQjYFyGzzeJSuCnKltJdFmnGRQ7R
   dbGzLCadmyI6r3eYatnbf5ppGZeO1TRYFqYReWcm1lhHWnYcRYODmr8BW
   44edIpgD6gDzamlWMmeveafT5+eC8EYPqi14o2u68kzZ1oEWpL12hYr0E
   w==;
X-CSE-ConnectionGUID: qQTO1Cs1RcWZ/ErIMHVzXg==
X-CSE-MsgGUID: ZShdmcbWR/+4HkTNOLCXyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31119266"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31119266"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:03 -0700
X-CSE-ConnectionGUID: DtuhYT8ERHq50XtC6DxgTQ==
X-CSE-MsgGUID: CKkj5VJgSNOXHCN2tXdZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66766684"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 May 2024 10:39:32 -0700
Subject: [PATCH net 5/6] ice: map XDP queues to vectors in
 ice_vsi_map_rings_to_vectors()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-net-2024-05-30-intel-net-fixes-v1-5-8b11c8c9bff8@intel.com>
References: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
In-Reply-To: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>
X-Mailer: b4 0.13.0

From: Larysa Zaremba <larysa.zaremba@intel.com>

ice_pf_dcb_recfg() re-maps queues to vectors with
ice_vsi_map_rings_to_vectors(), which does not restore the previous
state for XDP queues. This leads to no AF_XDP traffic after rebuild.

Map XDP queues to vectors in ice_vsi_map_rings_to_vectors().
Also, move the code around, so XDP queues are mapped independently only
through .ndo_bpf().

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c  |  14 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 128 +++++++++++++++++-------------
 4 files changed, 84 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b91b2594b29d..da8c8afebc93 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -940,6 +940,7 @@ int ice_vsi_determine_xdp_res(struct ice_vsi *vsi);
 int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 			  enum ice_xdp_cfg cfg_type);
 int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type);
+void ice_map_xdp_rings(struct ice_vsi *vsi);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 687f6cb2b917..5d396c1a7731 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -842,6 +842,9 @@ void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi)
 		}
 		rx_rings_rem -= rx_rings_per_v;
 	}
+
+	if (ice_is_xdp_ena_vsi(vsi))
+		ice_map_xdp_rings(vsi);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index dd8b374823ee..7629b0190578 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2274,13 +2274,6 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		if (ret)
 			goto unroll_vector_base;
 
-		ice_vsi_map_rings_to_vectors(vsi);
-
-		/* Associate q_vector rings to napi */
-		ice_vsi_set_napi_queues(vsi);
-
-		vsi->stat_offsets_loaded = false;
-
 		if (ice_is_xdp_ena_vsi(vsi)) {
 			ret = ice_vsi_determine_xdp_res(vsi);
 			if (ret)
@@ -2291,6 +2284,13 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 				goto unroll_vector_base;
 		}
 
+		ice_vsi_map_rings_to_vectors(vsi);
+
+		/* Associate q_vector rings to napi */
+		ice_vsi_set_napi_queues(vsi);
+
+		vsi->stat_offsets_loaded = false;
+
 		/* ICE_VSI_CTRL does not need RSS so skip RSS processing */
 		if (vsi->type != ICE_VSI_CTRL)
 			/* Do not exit if configuring RSS had an issue, at
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2a270aacd24a..1b61ca3a6eb6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2707,50 +2707,33 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
 		bpf_prog_put(old_prog);
 }
 
-/**
- * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
- * @vsi: VSI to bring up Tx rings used by XDP
- * @prog: bpf program that will be assigned to VSI
- * @cfg_type: create from scratch or restore the existing configuration
- *
- * Return 0 on success and negative value on error
- */
-int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
-			  enum ice_xdp_cfg cfg_type)
+static struct ice_tx_ring *ice_xdp_ring_from_qid(struct ice_vsi *vsi, int qid)
 {
-	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
-	int xdp_rings_rem = vsi->num_xdp_txq;
-	struct ice_pf *pf = vsi->back;
-	struct ice_qs_cfg xdp_qs_cfg = {
-		.qs_mutex = &pf->avail_q_mutex,
-		.pf_map = pf->avail_txqs,
-		.pf_map_size = pf->max_pf_txqs,
-		.q_count = vsi->num_xdp_txq,
-		.scatter_count = ICE_MAX_SCATTER_TXQS,
-		.vsi_map = vsi->txq_map,
-		.vsi_map_offset = vsi->alloc_txq,
-		.mapping_mode = ICE_VSI_MAP_CONTIG
-	};
-	struct device *dev;
-	int i, v_idx;
-	int status;
-
-	dev = ice_pf_to_dev(pf);
-	vsi->xdp_rings = devm_kcalloc(dev, vsi->num_xdp_txq,
-				      sizeof(*vsi->xdp_rings), GFP_KERNEL);
-	if (!vsi->xdp_rings)
-		return -ENOMEM;
-
-	vsi->xdp_mapping_mode = xdp_qs_cfg.mapping_mode;
-	if (__ice_vsi_get_qs(&xdp_qs_cfg))
-		goto err_map_xdp;
+	struct ice_q_vector *q_vector;
+	struct ice_tx_ring *ring;
 
 	if (static_key_enabled(&ice_xdp_locking_key))
-		netdev_warn(vsi->netdev,
-			    "Could not allocate one XDP Tx ring per CPU, XDP_TX/XDP_REDIRECT actions will be slower\n");
+		return vsi->xdp_rings[qid % vsi->num_xdp_txq];
 
-	if (ice_xdp_alloc_setup_rings(vsi))
-		goto clear_xdp_rings;
+	q_vector = vsi->rx_rings[qid]->q_vector;
+	ice_for_each_tx_ring(ring, q_vector->tx)
+		if (ice_ring_is_xdp(ring))
+			return ring;
+
+	return NULL;
+}
+
+/**
+ * ice_map_xdp_rings - Map XDP rings to interrupt vectors
+ * @vsi: the VSI with XDP rings being configured
+ *
+ * Map XDP rings to interrupt vectors and perform the configuration steps
+ * dependent on the mapping.
+ */
+void ice_map_xdp_rings(struct ice_vsi *vsi)
+{
+	int xdp_rings_rem = vsi->num_xdp_txq;
+	int v_idx, q_idx;
 
 	/* follow the logic from ice_vsi_map_rings_to_vectors */
 	ice_for_each_q_vector(vsi, v_idx) {
@@ -2771,22 +2754,55 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 		xdp_rings_rem -= xdp_rings_per_v;
 	}
 
-	ice_for_each_rxq(vsi, i) {
-		if (static_key_enabled(&ice_xdp_locking_key)) {
-			vsi->rx_rings[i]->xdp_ring = vsi->xdp_rings[i % vsi->num_xdp_txq];
-		} else {
-			struct ice_q_vector *q_vector = vsi->rx_rings[i]->q_vector;
-			struct ice_tx_ring *ring;
-
-			ice_for_each_tx_ring(ring, q_vector->tx) {
-				if (ice_ring_is_xdp(ring)) {
-					vsi->rx_rings[i]->xdp_ring = ring;
-					break;
-				}
-			}
-		}
-		ice_tx_xsk_pool(vsi, i);
+	ice_for_each_rxq(vsi, q_idx) {
+		vsi->rx_rings[q_idx]->xdp_ring = ice_xdp_ring_from_qid(vsi,
+								       q_idx);
+		ice_tx_xsk_pool(vsi, q_idx);
 	}
+}
+
+/**
+ * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
+ * @vsi: VSI to bring up Tx rings used by XDP
+ * @prog: bpf program that will be assigned to VSI
+ * @cfg_type: create from scratch or restore the existing configuration
+ *
+ * Return 0 on success and negative value on error
+ */
+int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
+			  enum ice_xdp_cfg cfg_type)
+{
+	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
+	struct ice_pf *pf = vsi->back;
+	struct ice_qs_cfg xdp_qs_cfg = {
+		.qs_mutex = &pf->avail_q_mutex,
+		.pf_map = pf->avail_txqs,
+		.pf_map_size = pf->max_pf_txqs,
+		.q_count = vsi->num_xdp_txq,
+		.scatter_count = ICE_MAX_SCATTER_TXQS,
+		.vsi_map = vsi->txq_map,
+		.vsi_map_offset = vsi->alloc_txq,
+		.mapping_mode = ICE_VSI_MAP_CONTIG
+	};
+	struct device *dev;
+	int status, i;
+
+	dev = ice_pf_to_dev(pf);
+	vsi->xdp_rings = devm_kcalloc(dev, vsi->num_xdp_txq,
+				      sizeof(*vsi->xdp_rings), GFP_KERNEL);
+	if (!vsi->xdp_rings)
+		return -ENOMEM;
+
+	vsi->xdp_mapping_mode = xdp_qs_cfg.mapping_mode;
+	if (__ice_vsi_get_qs(&xdp_qs_cfg))
+		goto err_map_xdp;
+
+	if (static_key_enabled(&ice_xdp_locking_key))
+		netdev_warn(vsi->netdev,
+			    "Could not allocate one XDP Tx ring per CPU, XDP_TX/XDP_REDIRECT actions will be slower\n");
+
+	if (ice_xdp_alloc_setup_rings(vsi))
+		goto clear_xdp_rings;
 
 	/* omit the scheduler update if in reset path; XDP queues will be
 	 * taken into account at the end of ice_vsi_rebuild, where
@@ -2795,6 +2811,8 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	if (cfg_type == ICE_XDP_CFG_PART)
 		return 0;
 
+	ice_map_xdp_rings(vsi);
+
 	/* tell the Tx scheduler that right now we have
 	 * additional queues
 	 */

-- 
2.44.0.53.g0f9d4d28b7e6


