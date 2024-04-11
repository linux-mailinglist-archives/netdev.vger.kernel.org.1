Return-Path: <netdev+bounces-87150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CF48A1E01
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C09128E7E2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE812B154;
	Thu, 11 Apr 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTmK6Z4G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAC823DD
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857142; cv=none; b=dnnjT73Eq3Gh1oXb14M0/KOPPXkc7ZDIyd9CfcP6LexJEPJQf50mQYiLI5E7UkDjAQOGq9HmlfNrdHagyNSHwEWjeeoaUe1PLQkyKLXoMU/juQ+SsaaK0BLr+bMn0fQUAW02CXYS6ZyLcHragtkNgIRFajkj2VptOqHxn+ZKe6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857142; c=relaxed/simple;
	bh=Eojmi3C5aytOH+U+m2rHIVHEm1nD0qS6J2Fke6T4VFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmqlbKNEEfbhXDBwKMbqUpxjQtZsggmV5+BehXsF284SPqnDz0d1osdacZJSReIT02DeMpTEejbY9NPhHaPfFsia1m9IzgzPT9sLzosNohyzDXFs7t/My577kfE4I+J+N9QJD6L96cmVFpBYOAsVlbt7aKHG+Kz3Qyd59JvuDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTmK6Z4G; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857141; x=1744393141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eojmi3C5aytOH+U+m2rHIVHEm1nD0qS6J2Fke6T4VFI=;
  b=LTmK6Z4GMpvuuGjtt17+29vznpiCors+H+tpVehjEtPzC4Dk2WJsXC8r
   rS7F06u2r2pFYZ54Zn4RVjzWuSrucC9AIurmV94hSn2tz9ddldIbgbu/x
   SPj3LSw9opLkB8ZNOAff30pi4Toym3VX3rBBebUepCX8gBM8Ht/hAKEiE
   IHptM89QiVwK5rg4RjeQBFCCttV0av/uyHNh1IXWtcn0yH7Vq+Iel4o35
   xd+mlNkMe0XbHJommgDzbLLeiPfudbRRqcdnN+jDvbm0NsSgcKqJdgOoN
   5+JSQrfNVfepgDLFX1k5rARIQzW9OfhX3zuWouccVDomYxeb4oMKBAmAZ
   g==;
X-CSE-ConnectionGUID: 3jm7alRRSP2dHmDkPX61/A==
X-CSE-MsgGUID: gk0vgJbGSj6ux8FZf2r3IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="11252969"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11252969"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:38:58 -0700
X-CSE-ConnectionGUID: IuBzOzMFSgW5Ak/yk5z1ag==
X-CSE-MsgGUID: 7hizS3NlQh2EIjYGeIBwXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20949120"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Apr 2024 10:38:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 4/4] ice: store VF relative MSI-X index in q_vector->vf_reg_idx
Date: Thu, 11 Apr 2024 10:38:44 -0700
Message-ID: <20240411173846.157007-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
References: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
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


