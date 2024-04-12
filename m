Return-Path: <netdev+bounces-87544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A954E8A3787
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 23:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3728B1F239EC
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF5E14BF9B;
	Fri, 12 Apr 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRgzWScs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB914F9EE
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955947; cv=none; b=dwo7SHPjZEr/r9VHdMCqar19sIv9YeNptCJ/2I8bPRgMTc51LR5pU35ttZGs1vbHgpqNGcCHP0GYZPdLDOZRmulTnn7Jb73PawIk9IaLniAJGdDdyhvnxq972Niqir3b0JBfl6xEIAcmPmCsGsR9qzsVfYrO2clOxx3c3zUytLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955947; c=relaxed/simple;
	bh=Eojmi3C5aytOH+U+m2rHIVHEm1nD0qS6J2Fke6T4VFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0en3qaxaHKcsBEYZAqNdCp7CWIh3iDJvwExJ3Kw8vU873eXvlo2f94vcmVSsTrnrB+2wXEA1/OiY0GHd92HopVazF3WfIoP8a0EunmXZRo20La0kNIxMLgPIZ7sbKND3N6yCRyzTAAnZGG+TCL5+XrsCe/KfwQOlmb2w9wPSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRgzWScs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712955946; x=1744491946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eojmi3C5aytOH+U+m2rHIVHEm1nD0qS6J2Fke6T4VFI=;
  b=CRgzWScs+3HtMuvI8NQAeB1lxv90CZHC8/zI95WNk+FGm4M8WvAGbukU
   t7uAwnoFLRIZHxsMwC9efvml+BTNGZRdP09tKAHaJ2mJi5jsKzn2HsLxp
   RcUeG1ohbnsCp1H6TvgE3ntnNQpqe/Ab37/rmWCslTtJcX9NLnPYBs8XR
   YJ2jf8YOExikPOdh1fXwLtHJ8K6CpSMqVt7EQzHHoe5RNXfX7FcKiOly3
   gHFJPyjBeVEBZBkCfY0FdFuT1KL9HNImwYQ1fTzfHY24ZtnEj4XxDS2GK
   cQSSLPkT0RbxMlPmsCmJ+ueHvSchMWdcGrBvztLCFkxLWKIXPzXeDLoH8
   A==;
X-CSE-ConnectionGUID: wHyxWcaGRdOh4serJlVxhw==
X-CSE-MsgGUID: tGTA5YS1Ss6CITP45WkaXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575234"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575234"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:05:42 -0700
X-CSE-ConnectionGUID: 9AKDlBqcR4WDpd04DXwZvA==
X-CSE-MsgGUID: x0ZHJyfpRfKgK175AdCayA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21836896"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 12 Apr 2024 14:05:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v2 4/4] ice: store VF relative MSI-X index in q_vector->vf_reg_idx
Date: Fri, 12 Apr 2024 14:05:33 -0700
Message-ID: <20240412210534.916756-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
References: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice physical function driver needs to configure the association of
queues and interrupts on behalf of its virtual functions. This is done over
virtchnl by the VF sending messages during its initialization phase. These
messages contain a vector_id which the VF wants to associate with a given
queue. This ID is relative to the VF space, where 0 indicates the control
IRQ for non-queue interrupts.

When programming the mapping, the PF driver currently passes this vector_id
directly to the low level functions for programming. This works for SR-IOV,
because the hardware uses the VF-based indexing for interrupts.

This won't work for Scalable IOV, which uses PF-based indexing for
programming its VSIs. To handle this, the driver needs to be able to look
up the proper index to use for programming. For typical IRQs, this would be
the q_vector->reg_idx field.

The q_vector->reg_idx can't be set to a VF relative value, because it is
used when the PF needs to control the interrupt, such as when triggering a
software interrupt on stopping the Tx queue. Thus, introduce a new
q_vector->vf_reg_idx which can store the VF relative index for registers
which expect this.

Use this in ice_cfg_interrupt to look up the VF index from the q_vector.
This allows removing the vector ID parameter of ice_cfg_interrupt. Also
notice that this function returns an int, but then is cast to the virtchnl
error enumeration, virtchnl_status_code. Update the return type to indicate
it does not return an integer error code. We can't use normal error codes
here because the return values are passed across the virtchnl interface.

This will allow the future Scalable IOV VFs to correctly look up the index
needed for programming the VF queues without breaking SR-IOV.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  3 ++-
 drivers/net/ethernet/intel/ice/ice_base.c     |  3 ++-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  7 ++++---
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  5 ++---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 14 +++++++-------
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index a7e88d797d4c..67a3236ab1fc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -459,7 +459,7 @@ struct ice_q_vector {
 	struct ice_vsi *vsi;
 
 	u16 v_idx;			/* index in the vsi->q_vector array. */
-	u16 reg_idx;
+	u16 reg_idx;			/* PF relative register index */
 	u8 num_ring_rx;			/* total number of Rx rings in vector */
 	u8 num_ring_tx;			/* total number of Tx rings in vector */
 	u8 wb_on_itr:1;			/* if true, WB on ITR is enabled */
@@ -481,6 +481,7 @@ struct ice_q_vector {
 	char name[ICE_INT_NAME_STR_LEN];
 
 	u16 total_events;	/* net_dim(): number of interrupts processed */
+	u16 vf_reg_idx;		/* VF relative register index */
 	struct msi_map irq;
 } ____cacheline_internodealigned_in_smp;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index af0384b37119..687f6cb2b917 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -121,7 +121,7 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	q_vector->irq.index = -ENOENT;
 
 	if (vsi->type == ICE_VSI_VF) {
-		q_vector->reg_idx = ice_calc_vf_reg_idx(vsi->vf, q_vector);
+		ice_calc_vf_reg_idx(vsi->vf, q_vector);
 		goto out;
 	} else if (vsi->type == ICE_VSI_CTRL && vsi->vf) {
 		struct ice_vsi *ctrl_vsi = ice_get_vf_ctrl_vsi(pf, vsi);
@@ -145,6 +145,7 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 
 skip_alloc:
 	q_vector->reg_idx = q_vector->irq.index;
+	q_vector->vf_reg_idx = q_vector->irq.index;
 
 	/* only set affinity_mask if the CPU is online */
 	if (cpu_online(v_idx))
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 5e9521876617..fb2e96db647e 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -360,13 +360,14 @@ static void ice_ena_vf_mappings(struct ice_vf *vf)
  * @vf: VF to calculate the register index for
  * @q_vector: a q_vector associated to the VF
  */
-int ice_calc_vf_reg_idx(struct ice_vf *vf, struct ice_q_vector *q_vector)
+void ice_calc_vf_reg_idx(struct ice_vf *vf, struct ice_q_vector *q_vector)
 {
 	if (!vf || !q_vector)
-		return -EINVAL;
+		return;
 
 	/* always add one to account for the OICR being the first MSIX */
-	return vf->first_vector_idx + q_vector->v_idx + 1;
+	q_vector->vf_reg_idx = q_vector->v_idx + ICE_NONQ_VECS_VF;
+	q_vector->reg_idx = vf->first_vector_idx + q_vector->vf_reg_idx;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 8488df38b586..4ba8fb53aea1 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -49,7 +49,7 @@ int ice_set_vf_link_state(struct net_device *netdev, int vf_id, int link_state);
 
 int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena);
 
-int ice_calc_vf_reg_idx(struct ice_vf *vf, struct ice_q_vector *q_vector);
+void ice_calc_vf_reg_idx(struct ice_vf *vf, struct ice_q_vector *q_vector);
 
 int
 ice_get_vf_stats(struct net_device *netdev, int vf_id,
@@ -130,11 +130,10 @@ ice_set_vf_bw(struct net_device __always_unused *netdev,
 	return -EOPNOTSUPP;
 }
 
-static inline int
+static inline void
 ice_calc_vf_reg_idx(struct ice_vf __always_unused *vf,
 		    struct ice_q_vector __always_unused *q_vector)
 {
-	return 0;
 }
 
 static inline int
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 1ff9818b4c84..1c6ce0c4ed4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1505,13 +1505,12 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
  * ice_cfg_interrupt
  * @vf: pointer to the VF info
  * @vsi: the VSI being configured
- * @vector_id: vector ID
  * @map: vector map for mapping vectors to queues
  * @q_vector: structure for interrupt vector
  * configure the IRQ to queue map
  */
-static int
-ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi, u16 vector_id,
+static enum virtchnl_status_code
+ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi,
 		  struct virtchnl_vector_map *map,
 		  struct ice_q_vector *q_vector)
 {
@@ -1531,7 +1530,8 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi, u16 vector_id,
 		q_vector->num_ring_rx++;
 		q_vector->rx.itr_idx = map->rxitr_idx;
 		vsi->rx_rings[vsi_q_id]->q_vector = q_vector;
-		ice_cfg_rxq_interrupt(vsi, vsi_q_id, vector_id,
+		ice_cfg_rxq_interrupt(vsi, vsi_q_id,
+				      q_vector->vf_reg_idx,
 				      q_vector->rx.itr_idx);
 	}
 
@@ -1545,7 +1545,8 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi, u16 vector_id,
 		q_vector->num_ring_tx++;
 		q_vector->tx.itr_idx = map->txitr_idx;
 		vsi->tx_rings[vsi_q_id]->q_vector = q_vector;
-		ice_cfg_txq_interrupt(vsi, vsi_q_id, vector_id,
+		ice_cfg_txq_interrupt(vsi, vsi_q_id,
+				      q_vector->vf_reg_idx,
 				      q_vector->tx.itr_idx);
 	}
 
@@ -1619,8 +1620,7 @@ static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
 		}
 
 		/* lookout for the invalid queue index */
-		v_ret = (enum virtchnl_status_code)
-			ice_cfg_interrupt(vf, vsi, vector_id, map, q_vector);
+		v_ret = ice_cfg_interrupt(vf, vsi, map, q_vector);
 		if (v_ret)
 			goto error_param;
 	}
-- 
2.41.0


