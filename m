Return-Path: <netdev+bounces-100384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371ED8FA496
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DA3B22A6E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A17513CAAD;
	Mon,  3 Jun 2024 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIKl/o+e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4D13C90B
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451492; cv=none; b=bTLtNISrFv5LccZJVL6uKsKvGoMosNqNB+N2ntxSOjmZnTTUZvQKCSDz0O7oKATWtV+DbQv8Te9Dlu33WFcfbzXrchxppmTUKUweTDqmHjJqrzr/Uim2V0e4X21Mj/zfBm8SL7b5G/Jk96vM1npeGKAJ+eZWR/FZePgCavH8Tzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451492; c=relaxed/simple;
	bh=8T0iF6hSvlp7Ry5jtD9eeUF3Q+qah76z+bzuy9T1Q2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooSkarZM5tct51zUQ/6SqY1PJMx44h4gbPlH3IV1fPgV4enZU4dQwLL6jnBP+lKeMl87SJZBy4R4MeQT7oHj5q2EgdNR456ExzVTnkeQ32mKwqJZfX33122WORVl+m1PLWfJHSRoxRNZZxj3vV9Sf4Xbac+EOCdNOuGMPRzVEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIKl/o+e; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717451489; x=1748987489;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8T0iF6hSvlp7Ry5jtD9eeUF3Q+qah76z+bzuy9T1Q2Q=;
  b=DIKl/o+ezOkwYonW6qlB3IDRNy5BBc311wk3ETV+a9/ZM9LpBrbbJ+B4
   vgalDNqeZQ5pIGvxm6XlMfuB1kVZw+YEYaXUeYwdkaAL1/SIIkNR1/tM5
   eaLH0F+LPMuHAmOSsU5RQLAHI8rpbtd+blT5dgqsvBhgWXwIPA2KiF508
   zRZd9RzAMwW1lRwCKbpvlvJT4ywwq2YHNxfo8GYSmlwt+GRDVuElJk5gB
   ZEK4dpwWfngIHWgnh6R+5OYKUuuwkWz0H10FedtW9JgOkbJ0pS4MkzZkb
   PiCUsG8bKMseIZTEQeVF436uDzpXKZaoDUycKOFpU+ENMhO6uzAw6XjAo
   g==;
X-CSE-ConnectionGUID: qs4dSFtTSkaA1CMEPjOalw==
X-CSE-MsgGUID: iAgL8ojpQ46rKfnl/FtV3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24547596"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24547596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
X-CSE-ConnectionGUID: vsad9k/2TxeDnO04rbAxxA==
X-CSE-MsgGUID: NncQNDihSwGxPWzIYt4yag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37608250"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 14:42:34 -0700
Subject: [PATCH net v2 5/6] ice: map XDP queues to vectors in
 ice_vsi_map_rings_to_vectors()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-net-2024-05-30-intel-net-fixes-v2-5-e3563aa89b0c@intel.com>
References: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
In-Reply-To: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
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
index a5de6ef9c07e..99a75a59078e 100644
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


