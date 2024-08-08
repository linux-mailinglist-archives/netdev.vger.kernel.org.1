Return-Path: <netdev+bounces-116728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8A94B7B9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E171C21E06
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074F189BA3;
	Thu,  8 Aug 2024 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apdeVoHI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B118991B
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101642; cv=none; b=hOLU2mrPRb2qZzwhwUMNR+BvWvn0R0ZPD+F2c3drPs/HHSzgzs8yZ+tgVQlq+nY5T98fT/IURllPZOmPJHgAEVE3tP0yPwXDSqIF9r+Dwyj0s6WWcNdKOSuOt3Tp+reMceGN0ySONMJXfWidhQe8JXnPR5ddlEkMCg2Pto1D+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101642; c=relaxed/simple;
	bh=2iAur2PGepsejhYkr3ZsYF5aT0CyObt1pbXN87ylCTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3t+5U8ZGPKB6ZBhDunR+KCJxFdfnvVUrIFSf2HvZj8Fhwm8ZMqkCGZk8J1R0Z78Lqrlhc3oQMPY25XRm+f6MedDe/DPpEMGO/QklD7Ottn1MD4mcnne+/gsVCqdb7xzSKne7Np8E6u6fZziNZqee19yTAns12fxu7UDBwWD8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apdeVoHI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723101640; x=1754637640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2iAur2PGepsejhYkr3ZsYF5aT0CyObt1pbXN87ylCTc=;
  b=apdeVoHIuW2yjCWagwYBChHR3KxhETAQjpBmXuXzwa4Tf2uhZmjRSQRE
   llkpqiVOXnY0g3mI/X+VePETvhSpa90OPfHLP0yOVqliogx8MiKMFFNpG
   IBFU00uKzD3aw7tXwpMPjEP7A3FMBm5EhGQAO/D7PTGiVubGIbU/fsUoZ
   RezAIAF1+XzHUupYucKTVAt8/V1IQ1JGKasVZ1mwCeaAG41XSplRQI5vk
   Rr4saJarTAu/BW8yuX+SEHswEuFOi4mFoTG4sPTVxsUlXE3+TIVJXAwBH
   O0UgtPOnUKZpDSMV+o3fzgLFDqN0tz3WczSobAxshX1td43+FxtW/lO84
   w==;
X-CSE-ConnectionGUID: Y/oicffNRuu4LswLrQapkg==
X-CSE-MsgGUID: E1CNAbyIQji5oxsIKeVrSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21361382"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21361382"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:20:40 -0700
X-CSE-ConnectionGUID: xLCa2vZTTEWVqYEJ4NvyUg==
X-CSE-MsgGUID: s/KteXOCQaK2DEEOgkgx/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57073512"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2024 00:20:37 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us
Subject: [iwl-next v3 7/8] ice: simplify VF MSI-X managing
Date: Thu,  8 Aug 2024 09:20:15 +0200
Message-ID: <20240808072016.10321-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After implementing pf->msix.max field, base vector for other use cases
(like VFs) can be fixed. This simplify code when changing MSI-X amount
on particular VF, because there is no need to move a base vector.

A fixed base vector allows to reserve vectors from the beginning
instead of from the end, which is also simpler in code.

Store total and rest value in the same struct as max and min for PF.
Move tracking vectors from ice_sriov.c to ice_irq.c as it can be also
use for other none PF use cases (SIOV).

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h       |  10 +-
 drivers/net/ethernet/intel/ice/ice_irq.c   |  75 +++++++---
 drivers/net/ethernet/intel/ice/ice_irq.h   |  13 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c | 153 ++-------------------
 4 files changed, 78 insertions(+), 173 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b4ecf71d702b..8a6c7e350534 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -548,6 +548,8 @@ struct ice_pf_msix {
 	u16 cur;
 	u16 min;
 	u16 max;
+	u16 total;
+	u16 rest;
 };
 
 struct ice_pf {
@@ -564,13 +566,7 @@ struct ice_pf {
 	/* OS reserved IRQ details */
 	struct msix_entry *msix_entries;
 	struct ice_irq_tracker irq_tracker;
-	/* First MSIX vector used by SR-IOV VFs. Calculated by subtracting the
-	 * number of MSIX vectors needed for all SR-IOV VFs from the number of
-	 * MSIX vectors allowed on this PF.
-	 */
-	u16 sriov_base_vector;
-	unsigned long *sriov_irq_bm;	/* bitmap to track irq usage */
-	u16 sriov_irq_size;		/* size of the irq_bm bitmap */
+	struct ice_virt_irq_tracker virt_irq_tracker;
 
 	u16 ctrl_vsi_idx;		/* control VSI index in pf->vsi array */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 10caacaae804..61977876c943 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -20,6 +20,19 @@ ice_init_irq_tracker(struct ice_pf *pf, unsigned int max_vectors,
 	xa_init_flags(&pf->irq_tracker.entries, XA_FLAGS_ALLOC);
 }
 
+static int
+ice_init_virt_irq_tracker(struct ice_pf *pf, u16 base, u16 num_entries)
+{
+	pf->virt_irq_tracker.bm = bitmap_zalloc(num_entries, GFP_KERNEL);
+	if (!pf->virt_irq_tracker.bm)
+		return -ENOMEM;
+
+	pf->virt_irq_tracker.num_entries = num_entries;
+	pf->virt_irq_tracker.base = base;
+
+	return 0;
+}
+
 /**
  * ice_deinit_irq_tracker - free xarray tracker
  * @pf: board private structure
@@ -29,6 +42,11 @@ static void ice_deinit_irq_tracker(struct ice_pf *pf)
 	xa_destroy(&pf->irq_tracker.entries);
 }
 
+static void ice_deinit_virt_irq_tracker(struct ice_pf *pf)
+{
+	bitmap_free(pf->virt_irq_tracker.bm);
+}
+
 /**
  * ice_free_irq_res - free a block of resources
  * @pf: board private structure
@@ -93,6 +111,7 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
 {
 	pci_free_irq_vectors(pf->pdev);
 	ice_deinit_irq_tracker(pf);
+	ice_deinit_virt_irq_tracker(pf);
 }
 
 /**
@@ -116,6 +135,9 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 					      &value);
 	pf->msix.max = err ? total_vectors / 2 : value.vu16;
 
+	pf->msix.total = total_vectors;
+	pf->msix.rest = total_vectors - pf->msix.max;
+
 	if (pci_msix_can_alloc_dyn(pf->pdev))
 		vectors = pf->msix.min;
 	else
@@ -128,7 +150,7 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 
 	ice_init_irq_tracker(pf, pf->msix.max, vectors);
 
-	return 0;
+	return ice_init_virt_irq_tracker(pf, pf->msix.max, pf->msix.rest);
 }
 
 /**
@@ -155,7 +177,6 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
  */
 struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_allowed)
 {
-	int sriov_base_vector = pf->sriov_base_vector;
 	struct msi_map map = { .index = -ENOENT };
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_irq_entry *entry;
@@ -164,10 +185,6 @@ struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_allowed)
 	if (!entry)
 		return map;
 
-	/* fail if we're about to violate SRIOV vectors space */
-	if (sriov_base_vector && entry->index >= sriov_base_vector)
-		goto exit_free_res;
-
 	if (pci_msix_can_alloc_dyn(pf->pdev) && entry->dynamic) {
 		map = pci_msix_alloc_irq_at(pf->pdev, entry->index, NULL);
 		if (map.index < 0)
@@ -215,26 +232,40 @@ void ice_free_irq(struct ice_pf *pf, struct msi_map map)
 }
 
 /**
- * ice_get_max_used_msix_vector - Get the max used interrupt vector
- * @pf: board private structure
+ * ice_virt_get_irqs - get irqs for SR-IOV usacase
+ * @pf: pointer to PF structure
+ * @needed: number of irqs to get
  *
- * Return index of maximum used interrupt vectors with respect to the
- * beginning of the MSIX table. Take into account that some interrupts
- * may have been dynamically allocated after MSIX was initially enabled.
+ * This returns the first MSI-X vector index in PF space that is used by this
+ * VF. This index is used when accessing PF relative registers such as
+ * GLINT_VECT2FUNC and GLINT_DYN_CTL.
+ * This will always be the OICR index in the AVF driver so any functionality
+ * using vf->first_vector_idx for queue configuration_id: id of VF which will
+ * use this irqs
  */
-int ice_get_max_used_msix_vector(struct ice_pf *pf)
+int ice_virt_get_irqs(struct ice_pf *pf, u16 needed)
 {
-	unsigned long start, index, max_idx;
-	void *entry;
+	int res = bitmap_find_next_zero_area(pf->virt_irq_tracker.bm,
+					     pf->virt_irq_tracker.num_entries,
+					     0, needed, 0);
 
-	/* Treat all preallocated interrupts as used */
-	start = pf->irq_tracker.num_static;
-	max_idx = start - 1;
+	if (res >= pf->virt_irq_tracker.num_entries)
+		return -ENOENT;
 
-	xa_for_each_start(&pf->irq_tracker.entries, index, entry, start) {
-		if (index > max_idx)
-			max_idx = index;
-	}
+	bitmap_set(pf->virt_irq_tracker.bm, res, needed);
 
-	return max_idx;
+	/* conversion from number in bitmap to global irq index */
+	return res + pf->virt_irq_tracker.base;
+}
+
+/**
+ * ice_virt_free_irqs - free irqs used by the VF
+ * @pf: pointer to PF structure
+ * @index: first index to be free
+ * @irqs: number of irqs to free
+ */
+void ice_virt_free_irqs(struct ice_pf *pf, u16 index, u16 irqs)
+{
+	bitmap_clear(pf->virt_irq_tracker.bm, index - pf->virt_irq_tracker.base,
+		     irqs);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.h b/drivers/net/ethernet/intel/ice/ice_irq.h
index f35efc08575e..d5e0fdd9b535 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.h
+++ b/drivers/net/ethernet/intel/ice/ice_irq.h
@@ -15,11 +15,22 @@ struct ice_irq_tracker {
 	u16 num_static;	/* preallocated entries */
 };
 
+struct ice_virt_irq_tracker {
+	unsigned long *bm;	/* bitmap to track irq usage */
+	u16 num_entries;
+	/* First MSIX vector used by SR-IOV VFs. Calculated by subtracting the
+	 * number of MSIX vectors needed for all SR-IOV VFs from the number of
+	 * MSIX vectors allowed on this PF.
+	 */
+	u16 base;
+};
+
 int ice_init_interrupt_scheme(struct ice_pf *pf);
 void ice_clear_interrupt_scheme(struct ice_pf *pf);
 
 struct msi_map ice_alloc_irq(struct ice_pf *pf, bool dyn_only);
 void ice_free_irq(struct ice_pf *pf, struct msi_map map);
-int ice_get_max_used_msix_vector(struct ice_pf *pf);
 
+int ice_virt_get_irqs(struct ice_pf *pf, u16 needed);
+void ice_virt_free_irqs(struct ice_pf *pf, u16 index, u16 irqs);
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e34fe2516ccc..865421b8ed83 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -122,27 +122,6 @@ static void ice_dis_vf_mappings(struct ice_vf *vf)
 		dev_err(dev, "Scattered mode for VF Rx queues is not yet implemented\n");
 }
 
-/**
- * ice_sriov_free_msix_res - Reset/free any used MSIX resources
- * @pf: pointer to the PF structure
- *
- * Since no MSIX entries are taken from the pf->irq_tracker then just clear
- * the pf->sriov_base_vector.
- *
- * Returns 0 on success, and -EINVAL on error.
- */
-static int ice_sriov_free_msix_res(struct ice_pf *pf)
-{
-	if (!pf)
-		return -EINVAL;
-
-	bitmap_free(pf->sriov_irq_bm);
-	pf->sriov_irq_size = 0;
-	pf->sriov_base_vector = 0;
-
-	return 0;
-}
-
 /**
  * ice_free_vfs - Free all VFs
  * @pf: pointer to the PF structure
@@ -177,6 +156,7 @@ void ice_free_vfs(struct ice_pf *pf)
 
 		ice_eswitch_detach_vf(pf, vf);
 		ice_dis_vf_qs(vf);
+		ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 
 		if (test_bit(ICE_VF_STATE_INIT, vf->vf_states)) {
 			/* disable VF qp mappings and set VF disable state */
@@ -199,9 +179,6 @@ void ice_free_vfs(struct ice_pf *pf)
 		mutex_unlock(&vf->cfg_lock);
 	}
 
-	if (ice_sriov_free_msix_res(pf))
-		dev_err(dev, "Failed to free MSIX resources used by SR-IOV\n");
-
 	vfs->num_qps_per = 0;
 	ice_free_vf_entries(pf);
 
@@ -370,40 +347,6 @@ void ice_calc_vf_reg_idx(struct ice_vf *vf, struct ice_q_vector *q_vector)
 	q_vector->reg_idx = vf->first_vector_idx + q_vector->vf_reg_idx;
 }
 
-/**
- * ice_sriov_set_msix_res - Set any used MSIX resources
- * @pf: pointer to PF structure
- * @num_msix_needed: number of MSIX vectors needed for all SR-IOV VFs
- *
- * This function allows SR-IOV resources to be taken from the end of the PF's
- * allowed HW MSIX vectors so that the irq_tracker will not be affected. We
- * just set the pf->sriov_base_vector and return success.
- *
- * If there are not enough resources available, return an error. This should
- * always be caught by ice_set_per_vf_res().
- *
- * Return 0 on success, and -EINVAL when there are not enough MSIX vectors
- * in the PF's space available for SR-IOV.
- */
-static int ice_sriov_set_msix_res(struct ice_pf *pf, u16 num_msix_needed)
-{
-	u16 total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
-	int vectors_used = ice_get_max_used_msix_vector(pf);
-	int sriov_base_vector;
-
-	sriov_base_vector = total_vectors - num_msix_needed;
-
-	/* make sure we only grab irq_tracker entries from the list end and
-	 * that we have enough available MSIX vectors
-	 */
-	if (sriov_base_vector < vectors_used)
-		return -EINVAL;
-
-	pf->sriov_base_vector = sriov_base_vector;
-
-	return 0;
-}
-
 /**
  * ice_set_per_vf_res - check if vectors and queues are available
  * @pf: pointer to the PF structure
@@ -428,11 +371,9 @@ static int ice_sriov_set_msix_res(struct ice_pf *pf, u16 num_msix_needed)
  */
 static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 {
-	int vectors_used = ice_get_max_used_msix_vector(pf);
 	u16 num_msix_per_vf, num_txq, num_rxq, avail_qs;
 	int msix_avail_per_vf, msix_avail_for_sriov;
 	struct device *dev = ice_pf_to_dev(pf);
-	int err;
 
 	lockdep_assert_held(&pf->vfs.table_lock);
 
@@ -440,8 +381,7 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 		return -EINVAL;
 
 	/* determine MSI-X resources per VF */
-	msix_avail_for_sriov = pf->hw.func_caps.common_cap.num_msix_vectors -
-		vectors_used;
+	msix_avail_for_sriov = pf->virt_irq_tracker.num_entries;
 	msix_avail_per_vf = msix_avail_for_sriov / num_vfs;
 	if (msix_avail_per_vf >= ICE_NUM_VF_MSIX_MED) {
 		num_msix_per_vf = ICE_NUM_VF_MSIX_MED;
@@ -480,13 +420,6 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 		return -ENOSPC;
 	}
 
-	err = ice_sriov_set_msix_res(pf, num_msix_per_vf * num_vfs);
-	if (err) {
-		dev_err(dev, "Unable to set MSI-X resources for %d VFs, err %d\n",
-			num_vfs, err);
-		return err;
-	}
-
 	/* only allow equal Tx/Rx queue count (i.e. queue pairs) */
 	pf->vfs.num_qps_per = min_t(int, num_txq, num_rxq);
 	pf->vfs.num_msix_per = num_msix_per_vf;
@@ -496,52 +429,6 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 	return 0;
 }
 
-/**
- * ice_sriov_get_irqs - get irqs for SR-IOV usacase
- * @pf: pointer to PF structure
- * @needed: number of irqs to get
- *
- * This returns the first MSI-X vector index in PF space that is used by this
- * VF. This index is used when accessing PF relative registers such as
- * GLINT_VECT2FUNC and GLINT_DYN_CTL.
- * This will always be the OICR index in the AVF driver so any functionality
- * using vf->first_vector_idx for queue configuration_id: id of VF which will
- * use this irqs
- *
- * Only SRIOV specific vectors are tracked in sriov_irq_bm. SRIOV vectors are
- * allocated from the end of global irq index. First bit in sriov_irq_bm means
- * last irq index etc. It simplifies extension of SRIOV vectors.
- * They will be always located from sriov_base_vector to the last irq
- * index. While increasing/decreasing sriov_base_vector can be moved.
- */
-static int ice_sriov_get_irqs(struct ice_pf *pf, u16 needed)
-{
-	int res = bitmap_find_next_zero_area(pf->sriov_irq_bm,
-					     pf->sriov_irq_size, 0, needed, 0);
-	/* conversion from number in bitmap to global irq index */
-	int index = pf->sriov_irq_size - res - needed;
-
-	if (res >= pf->sriov_irq_size || index < pf->sriov_base_vector)
-		return -ENOENT;
-
-	bitmap_set(pf->sriov_irq_bm, res, needed);
-	return index;
-}
-
-/**
- * ice_sriov_free_irqs - free irqs used by the VF
- * @pf: pointer to PF structure
- * @vf: pointer to VF structure
- */
-static void ice_sriov_free_irqs(struct ice_pf *pf, struct ice_vf *vf)
-{
-	/* Move back from first vector index to first index in bitmap */
-	int bm_i = pf->sriov_irq_size - vf->first_vector_idx - vf->num_msix;
-
-	bitmap_clear(pf->sriov_irq_bm, bm_i, vf->num_msix);
-	vf->first_vector_idx = 0;
-}
-
 /**
  * ice_init_vf_vsi_res - initialize/setup VF VSI resources
  * @vf: VF to initialize/setup the VSI for
@@ -555,7 +442,7 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 	struct ice_vsi *vsi;
 	int err;
 
-	vf->first_vector_idx = ice_sriov_get_irqs(pf, vf->num_msix);
+	vf->first_vector_idx = ice_virt_get_irqs(pf, vf->num_msix);
 	if (vf->first_vector_idx < 0)
 		return -ENOMEM;
 
@@ -855,16 +742,10 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
  */
 static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 {
-	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	int ret;
 
-	pf->sriov_irq_bm = bitmap_zalloc(total_vectors, GFP_KERNEL);
-	if (!pf->sriov_irq_bm)
-		return -ENOMEM;
-	pf->sriov_irq_size = total_vectors;
-
 	/* Disable global interrupt 0 so we don't try to handle the VFLR. */
 	wr32(hw, GLINT_DYN_CTL(pf->oicr_irq.index),
 	     ICE_ITR_NONE << GLINT_DYN_CTL_ITR_INDX_S);
@@ -917,7 +798,6 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 	/* rearm interrupts here */
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 	clear_bit(ICE_OICR_INTR_DIS, pf->state);
-	bitmap_free(pf->sriov_irq_bm);
 	return ret;
 }
 
@@ -991,16 +871,7 @@ u32 ice_sriov_get_vf_total_msix(struct pci_dev *pdev)
 {
 	struct ice_pf *pf = pci_get_drvdata(pdev);
 
-	return pf->sriov_irq_size - ice_get_max_used_msix_vector(pf);
-}
-
-static int ice_sriov_move_base_vector(struct ice_pf *pf, int move)
-{
-	if (pf->sriov_base_vector - move < ice_get_max_used_msix_vector(pf))
-		return -ENOMEM;
-
-	pf->sriov_base_vector -= move;
-	return 0;
+	return pf->virt_irq_tracker.num_entries;
 }
 
 static void ice_sriov_remap_vectors(struct ice_pf *pf, u16 restricted_id)
@@ -1019,7 +890,8 @@ static void ice_sriov_remap_vectors(struct ice_pf *pf, u16 restricted_id)
 			continue;
 
 		ice_dis_vf_mappings(tmp_vf);
-		ice_sriov_free_irqs(pf, tmp_vf);
+		ice_virt_free_irqs(pf, tmp_vf->first_vector_idx,
+				   tmp_vf->num_msix);
 
 		vf_ids[to_remap] = tmp_vf->vf_id;
 		to_remap += 1;
@@ -1031,7 +903,7 @@ static void ice_sriov_remap_vectors(struct ice_pf *pf, u16 restricted_id)
 			continue;
 
 		tmp_vf->first_vector_idx =
-			ice_sriov_get_irqs(pf, tmp_vf->num_msix);
+			ice_virt_get_irqs(pf, tmp_vf->num_msix);
 		/* there is no need to rebuild VSI as we are only changing the
 		 * vector indexes not amount of MSI-X or queues
 		 */
@@ -1102,20 +974,15 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
 
-	if (ice_sriov_move_base_vector(pf, msix_vec_count - prev_msix)) {
-		ice_put_vf(vf);
-		return -ENOSPC;
-	}
-
 	ice_dis_vf_mappings(vf);
-	ice_sriov_free_irqs(pf, vf);
+	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
 
 	/* Remap all VFs beside the one is now configured */
 	ice_sriov_remap_vectors(pf, vf->vf_id);
 
 	vf->num_msix = msix_vec_count;
 	vf->num_vf_qs = queues;
-	vf->first_vector_idx = ice_sriov_get_irqs(pf, vf->num_msix);
+	vf->first_vector_idx = ice_virt_get_irqs(pf, vf->num_msix);
 	if (vf->first_vector_idx < 0)
 		goto unroll;
 
@@ -1141,7 +1008,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 
 	vf->num_msix = prev_msix;
 	vf->num_vf_qs = prev_queues;
-	vf->first_vector_idx = ice_sriov_get_irqs(pf, vf->num_msix);
+	vf->first_vector_idx = ice_virt_get_irqs(pf, vf->num_msix);
 	if (vf->first_vector_idx < 0)
 		return -EINVAL;
 
-- 
2.42.0


