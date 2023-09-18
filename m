Return-Path: <netdev+bounces-34406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086547A4186
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0711281CE8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 06:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596B6FC2;
	Mon, 18 Sep 2023 06:48:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963BE6FC5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 06:48:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4889F
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695019691; x=1726555691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zS+y0FyeVWrZrn0/adWo6USEQX/rFF5uUQ6hstGMtzs=;
  b=cA3kNn9VuS+eleSwv++Ja2AAvgCD1hYfOnbAq1D7Nm2koqS0uCHCY0Jw
   fhdxtiFoaKHu9QV0+GPmuWv14+2QlSxUaR1cLrvotNBshawUKVKNuptPl
   H8z3iwRwnobElatDq+EpntcLipx0kwZ2+ELnkqar8+XHOgJXXgkLIDz/e
   gEP4UK9xp1p3pk0BDMaGCJVqMKhthG1XxCV1XWiereilE8h5lWmJR/pkb
   ROp9Rv1Rs8zvLlOV9/cUO1DxNWiuxn1jGR6hNEJbrB3M74YjNryzRUByL
   9X2zUFVmuGa///BMs+o3u6qe2U39D9qDGBaF+3GU0l6xJxWscgrKjL/4C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="369907532"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="369907532"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="869452226"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="869452226"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2023 23:48:08 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 1/4] ice: implement num_msix field per VF
Date: Mon, 18 Sep 2023 08:24:03 +0200
Message-ID: <20230918062406.90359-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918062406.90359-1-michal.swiatkowski@linux.intel.com>
References: <20230918062406.90359-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Store the amount of MSI-X per VF instead of storing it in pf struct. It
is used to calculate number of q_vectors (and queues) for VF VSI.

This is necessary because with follow up changes the number of MSI-X can
be different between VFs. Use it instead of using pf->vf_msix value in
all cases.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 13 +++++++++----
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  4 +++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8da025f59999..c1e0f84146f7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -229,7 +229,7 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 		 * of queues vectors, subtract 1 (ICE_NONQ_VECS_VF) from the
 		 * original vector count
 		 */
-		vsi->num_q_vectors = pf->vfs.num_msix_per - ICE_NONQ_VECS_VF;
+		vsi->num_q_vectors = vf->num_msix - ICE_NONQ_VECS_VF;
 		break;
 	case ICE_VSI_CTRL:
 		vsi->alloc_txq = 1;
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 4ae59c59e22b..d345f5d8635b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -64,7 +64,7 @@ static void ice_free_vf_res(struct ice_vf *vf)
 		vf->num_mac = 0;
 	}
 
-	last_vector_idx = vf->first_vector_idx + pf->vfs.num_msix_per - 1;
+	last_vector_idx = vf->first_vector_idx + vf->num_msix - 1;
 
 	/* clear VF MDD event information */
 	memset(&vf->mdd_tx_events, 0, sizeof(vf->mdd_tx_events));
@@ -102,7 +102,7 @@ static void ice_dis_vf_mappings(struct ice_vf *vf)
 	wr32(hw, VPINT_ALLOC_PCI(vf->vf_id), 0);
 
 	first = vf->first_vector_idx;
-	last = first + pf->vfs.num_msix_per - 1;
+	last = first + vf->num_msix - 1;
 	for (v = first; v <= last; v++) {
 		u32 reg;
 
@@ -280,12 +280,12 @@ static void ice_ena_vf_msix_mappings(struct ice_vf *vf)
 
 	hw = &pf->hw;
 	pf_based_first_msix = vf->first_vector_idx;
-	pf_based_last_msix = (pf_based_first_msix + pf->vfs.num_msix_per) - 1;
+	pf_based_last_msix = (pf_based_first_msix + vf->num_msix) - 1;
 
 	device_based_first_msix = pf_based_first_msix +
 		pf->hw.func_caps.common_cap.msix_vector_first_id;
 	device_based_last_msix =
-		(device_based_first_msix + pf->vfs.num_msix_per) - 1;
+		(device_based_first_msix + vf->num_msix) - 1;
 	device_based_vf_id = vf->vf_id + hw->func_caps.vf_base_id;
 
 	reg = (((device_based_first_msix << VPINT_ALLOC_FIRST_S) &
@@ -825,6 +825,11 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
 
 		pci_dev_get(vfdev);
 
+		/* set default number of MSI-X */
+		vf->num_msix = pf->vfs.num_msix_per;
+		vf->num_vf_qs = pf->vfs.num_qps_per;
+		ice_vc_set_default_allowlist(vf);
+
 		hash_add_rcu(vfs->table, &vf->entry, vf_id);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 628396aa4a04..93c774f2f437 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -72,7 +72,7 @@ struct ice_vfs {
 	struct mutex table_lock;	/* Lock for protecting the hash table */
 	u16 num_supported;		/* max supported VFs on this PF */
 	u16 num_qps_per;		/* number of queue pairs per VF */
-	u16 num_msix_per;		/* number of MSI-X vectors per VF */
+	u16 num_msix_per;		/* default MSI-X vectors per VF */
 	unsigned long last_printed_mdd_jiffies;	/* MDD message rate limit */
 };
 
@@ -136,6 +136,8 @@ struct ice_vf {
 
 	/* devlink port data */
 	struct devlink_port devlink_port;
+
+	u16 num_msix;			/* num of MSI-X configured on this VF */
 };
 
 /* Flags for controlling behavior of ice_reset_vf */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index cad237dd8894..33086c39869c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -501,7 +501,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	vfres->num_vsis = 1;
 	/* Tx and Rx queue are equal for VF */
 	vfres->num_queue_pairs = vsi->num_txq;
-	vfres->max_vectors = vf->pf->vfs.num_msix_per;
+	vfres->max_vectors = vf->num_msix;
 	vfres->rss_key_size = ICE_VSIQF_HKEY_ARRAY_SIZE;
 	vfres->rss_lut_size = ICE_LUT_VSI_SIZE;
 	vfres->max_mtu = ice_vc_get_max_frame_size(vf);
-- 
2.41.0


