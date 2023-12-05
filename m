Return-Path: <netdev+bounces-54124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72200806097
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD09282039
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E1A6D1C0;
	Tue,  5 Dec 2023 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngctO9b7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F9A5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811185; x=1733347185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdHTPl6Xff2eyxWTBObIuAaJFjOonTxjeLKInTiGvfM=;
  b=ngctO9b7tnikBiNwmIUSorCYdZ9+p+iunGLu/ESg95wJsEuN1QPcDTGC
   dTYI9zFa8B7ySL8NoDGeBfEawA/n37mTlAYbdauTFzFpe1p5KfALCJQ3w
   swSRWoZua2mfKO2SMd/wan8Nw2EnJS6yH+PNbDzu8apJbrBB25OpzxYF0
   /8IDRKbChDPHLiIUM+Jekz/5kDgAk33MyWrO946+xSUXFkpoF/kufLEpP
   vy8/kbRNhT0WtlcfAmJT5CSSPKqM+UUFmAEVeeHYBgRPsM6W6T1L/Rjue
   Xaxnj776FptF08B6FJTgutnK1k8HDZiYcSmKxIJoWggDAOo/vzO69Z3yH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393693804"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393693804"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894510101"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="894510101"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 13:19:26 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/4] ice: change vfs.num_msix_per to vf->num_msix
Date: Tue,  5 Dec 2023 13:19:12 -0800
Message-ID: <20231205211918.2123019-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
References: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

vfs::num_msix_per should be only used as default value for
vf->num_msix. For other use cases vf->num_msix should be used, as VF can
have different MSI-X amount values.

Fix incorrect register index calculation. vfs::num_msix_per and
pf->sriov_base_vector shouldn't be used after implementation of changing
MSI-X amount on VFs. Instead vf->first_vector_idx should be used, as it
is storing value for first irq index.

Fixes: fe1c5ca2fe76 ("ice: implement num_msix field per VF")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 7 +------
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 5 ++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 2a5e6616cc0a..e1494f24f661 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -374,16 +374,11 @@ static void ice_ena_vf_mappings(struct ice_vf *vf)
  */
 int ice_calc_vf_reg_idx(struct ice_vf *vf, struct ice_q_vector *q_vector)
 {
-	struct ice_pf *pf;
-
 	if (!vf || !q_vector)
 		return -EINVAL;
 
-	pf = vf->pf;
-
 	/* always add one to account for the OICR being the first MSIX */
-	return pf->sriov_base_vector + pf->vfs.num_msix_per * vf->vf_id +
-		q_vector->v_idx + 1;
+	return vf->first_vector_idx + q_vector->v_idx + 1;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index de11b3186bd7..1c7b4ded948b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1523,7 +1523,6 @@ static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
 	u16 num_q_vectors_mapped, vsi_id, vector_id;
 	struct virtchnl_irq_map_info *irqmap_info;
 	struct virtchnl_vector_map *map;
-	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 	int i;
 
@@ -1535,7 +1534,7 @@ static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
 	 * there is actually at least a single VF queue vector mapped
 	 */
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states) ||
-	    pf->vfs.num_msix_per < num_q_vectors_mapped ||
+	    vf->num_msix < num_q_vectors_mapped ||
 	    !num_q_vectors_mapped) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
@@ -1557,7 +1556,7 @@ static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
 		/* vector_id is always 0-based for each VF, and can never be
 		 * larger than or equal to the max allowed interrupts per VF
 		 */
-		if (!(vector_id < pf->vfs.num_msix_per) ||
+		if (!(vector_id < vf->num_msix) ||
 		    !ice_vc_isvalid_vsi_id(vf, vsi_id) ||
 		    (!vector_id && (map->rxq_map || map->txq_map))) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-- 
2.41.0


