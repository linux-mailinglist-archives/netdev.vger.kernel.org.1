Return-Path: <netdev+bounces-34407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B097A4187
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C417D281C39
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE7746B;
	Mon, 18 Sep 2023 06:48:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BC6FC7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 06:48:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58397
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 23:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695019692; x=1726555692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZewXIPDm41f0GPMUjIb1QVbIyLgeOQM7RvDiQgEwv9o=;
  b=fBuKyK4n0s98zw24HR/7od7TX2u985vqzK6EXq4kMxDpxAS6eVDCFBvi
   ESzNU3yPG0YHEY8H0o4ZzRhExqIsxhqTscIKP8R76Qzcoq1fhvosXELdy
   g/YzpMTAQQB1EMRM8nG3lxILKftCJC234diAnA1qYOYZfC9F0X9g5A/pC
   qBwStwsv7vylbnbdqJQQxRjslubPTbig2+HTWWIMiomHRk/vIrXYg7BnL
   TS847icy3D8dsu95lhOP5+FGYyG/RJSNRIB0d6MRMe9NP2klYgnP2CZzy
   TuQRx9spjeX+Y42eWfjNlcZHQFvxO+ddi0YAUvnfYpZlbm09hqr+jg0F2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="369907536"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="369907536"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="869452239"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="869452239"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2023 23:48:10 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 2/4] ice: add bitmap to track VF MSI-X usage
Date: Mon, 18 Sep 2023 08:24:04 +0200
Message-ID: <20230918062406.90359-3-michal.swiatkowski@linux.intel.com>
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

Create a bitamp to track MSI-X usage for VFs. The bitmap has the size of
total MSI-X amount on device, because at init time the amount of MSI-X
used by VFs isn't known.

The bitmap is used in follow up patchset to provide a block of
continuous block of MSI-X indexes for each created VF.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h       | 2 ++
 drivers/net/ethernet/intel/ice/ice_sriov.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 051007ccab43..5fef43d3d994 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -550,6 +550,8 @@ struct ice_pf {
 	 * MSIX vectors allowed on this PF.
 	 */
 	u16 sriov_base_vector;
+	unsigned long *sriov_irq_bm;	/* bitmap to track irq usage */
+	u16 sriov_irq_size;		/* size of the irq_bm bitmap */
 
 	u16 ctrl_vsi_idx;		/* control VSI index in pf->vsi array */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index d345f5d8635b..49adb0b05817 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -138,6 +138,8 @@ static int ice_sriov_free_msix_res(struct ice_pf *pf)
 	if (!pf)
 		return -EINVAL;
 
+	bitmap_free(pf->sriov_irq_bm);
+	pf->sriov_irq_size = 0;
 	pf->sriov_base_vector = 0;
 
 	return 0;
@@ -853,10 +855,16 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
  */
 static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 {
+	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	int ret;
 
+	pf->sriov_irq_bm = bitmap_zalloc(total_vectors, GFP_KERNEL);
+	if (!pf->sriov_irq_bm)
+		return -ENOMEM;
+	pf->sriov_irq_size = total_vectors;
+
 	/* Disable global interrupt 0 so we don't try to handle the VFLR. */
 	wr32(hw, GLINT_DYN_CTL(pf->oicr_irq.index),
 	     ICE_ITR_NONE << GLINT_DYN_CTL_ITR_INDX_S);
@@ -915,6 +923,7 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 	/* rearm interrupts here */
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 	clear_bit(ICE_OICR_INTR_DIS, pf->state);
+	bitmap_free(pf->sriov_irq_bm);
 	return ret;
 }
 
-- 
2.41.0


