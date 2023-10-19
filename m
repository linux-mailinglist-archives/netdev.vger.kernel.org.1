Return-Path: <netdev+bounces-42747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730F7D0095
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD8E1C20F91
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163C13550E;
	Thu, 19 Oct 2023 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuGqJmO+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8234183
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5112A
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736756; x=1729272756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lcCgOeN6z/mJjFZzm8CKVREZOcwWzVFxHGnfur41Eec=;
  b=CuGqJmO+83b5AKSTpiuQJze8jo4nq94DrNzE3aMrZLUhy8Am7Pd+mFas
   ln7nJoo+jl+3dwW3m6v/TPKmWOeb0cYT2LTcBqgySIGyBIE9qX3WIlH6p
   6ufqauyAQsdoX5imwc+wPZYFyYsPJxHChWazwRK0D85EhEHs29ENBG/vT
   KvDv5F2H5peAGF9GJJL1SFL8SiOEcx+G+pYo3Q1R/QP3vJO023Mie+XIt
   gJtGodbarLZ5mGuzpt+RjzqfJu2gs7LrntZYnqHGoesYk3eARxOv7o2rZ
   Z06C9qzabBvB8QVmZH6Xlnk/ktgRitrb78x3cO3jZe0Cs0JmUFphsG0vZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183693"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183693"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722681"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722681"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:34 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 04/11] ice: implement num_msix field per VF
Date: Thu, 19 Oct 2023 10:32:20 -0700
Message-ID: <20231019173227.3175575-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Store the amount of MSI-X per VF instead of storing it in pf struct. It
is used to calculate number of q_vectors (and queues) for VF VSI.

This is necessary because with follow up changes the number of MSI-X can
be different between VFs. Use it instead of using pf->vf_msix value in
all cases.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 13 +++++++++----
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  4 +++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1f45f0c3963d..efbbf482b2d5 100644
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
index 01e88b6e43a1..cdf17b1e2f25 100644
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


