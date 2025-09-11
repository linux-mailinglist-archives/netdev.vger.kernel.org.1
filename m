Return-Path: <netdev+bounces-222315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5B3B53D76
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48996AC0F5E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16272DE704;
	Thu, 11 Sep 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh4YpUBb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B62DBF40
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624742; cv=none; b=LS66d6yBF1dPfiMz9bo8fDnY/yMoBn+/FJWieG4N0B+V2OHSWEOUiGndMN5aCW+GQ71eURzVkSZmeL9whXVaE8xWyE90NJX5C1r0YhN3CcfvGU6Z2wLJ8xDHB/xb5n0/c+1b09athWjXU0+WUF++zqlPX3n5UKNr1fRPeL4ORJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624742; c=relaxed/simple;
	bh=mej0inr1DYFDpkEhi1W3lJSrBplCIAGPtYj7EdmirHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyiDjajJTAO4AxWO6MiPym1f3301kWW037+3v5HVA/dZ58qaxLAOXhgLaMvF2NcE4dMaHRvFV5VEj72KVWLHfkJURWFE5+6Wa4ObOVnPYJsvoQxvwPxxmkbvz+tCBqoBomB5z8CnQyQSiSpNKFYF4j1p2idnEYCe1asgzvLp+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh4YpUBb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624742; x=1789160742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mej0inr1DYFDpkEhi1W3lJSrBplCIAGPtYj7EdmirHQ=;
  b=Nh4YpUBbun00WmHB0mY090DeQ3PjJmnNV9Sfqp1doqeBZr9Q2H319LWO
   7QM+u3D7spjqf7/abgdkblaUl/ANcHiLHjt7JGcwhcdpM+e+ibn9rABY2
   /adczCUnHkp8tFaIP0eqvPoeJL9a+SKtpD3fWPRyias/DmQuQjQbVWKeb
   A8jmF+IDYl+HENvjzsbrFJ41cwPsL2YLKSxXGX4AJIyYe9u2mHzmMl2f4
   SAdp5QNRJA2IRjgCuy2f4xVU0xqZDylEwXzbUSPWUIg/1iRnBZ1nRZtp8
   PQsZlXTmHTcpXSd5dK9oro47aNa4OYnRVyc/6TiOVEMoQMbUUzcwGr+rl
   g==;
X-CSE-ConnectionGUID: 96ACMjtcRaK9+GjhUmq9Yw==
X-CSE-MsgGUID: GMEN96WpQDipZ+uBsrCQiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558887"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558887"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:39 -0700
X-CSE-ConnectionGUID: bM+XOB2dQiOcoPkxdrfAsQ==
X-CSE-MsgGUID: QqO3dLIlSyq+FHhBXXKtuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583353"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 05/15] ice: add pdev into fwlog structure and use it for logging
Date: Thu, 11 Sep 2025 14:05:04 -0700
Message-ID: <20250911210525.345110-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Prepare the code to be moved to the library. ice_debug() won't be there
so switch to dev_dbg().

Add struct pdev pointer in fwlog to track on which pdev the fwlog was
created.

Switch the dev passed in dev_warn() to the one stored in fwlog.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  |  3 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c   | 37 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_fwlog.h   |  7 ++--
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7043cca525c6..c3f99b2e2087 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -992,6 +992,7 @@ int ice_init_hw(struct ice_hw *hw)
 {
 	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
 	void *mac_buf __free(kfree) = NULL;
+	struct ice_pf *pf = hw->back;
 	u16 mac_buf_len;
 	int status;
 
@@ -1012,7 +1013,7 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_cqinit;
 
-	status = ice_fwlog_init(hw, &hw->fwlog);
+	status = ice_fwlog_init(hw, &hw->fwlog, pf->pdev);
 	if (status)
 		ice_debug(hw, ICE_DBG_FW_LOG, "Error initializing FW logging: %d\n",
 			  status);
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index dbcc0cb438aa..1e036bc128c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -450,7 +450,7 @@ ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
 	}
 
 	/* free all the buffers and the tracking info and resize */
-	ice_fwlog_realloc_rings(hw, &hw->fwlog, index);
+	ice_fwlog_realloc_rings(&hw->fwlog, index);
 
 	/* if we get here, nothing went wrong; return count since we didn't
 	 * really write anything
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index a010f655ffb7..b1c1359d5ab5 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -73,13 +73,11 @@ static void ice_fwlog_free_ring_buffs(struct ice_fwlog_ring *rings)
 #define ICE_FWLOG_INDEX_TO_BYTES(n) ((128 * 1024) << (n))
 /**
  * ice_fwlog_realloc_rings - reallocate the FW log rings
- * @hw: pointer to the HW structure
  * @fwlog: pointer to the fwlog structure
  * @index: the new index to use to allocate memory for the log data
  *
  */
-void ice_fwlog_realloc_rings(struct ice_hw *hw, struct ice_fwlog *fwlog,
-			     int index)
+void ice_fwlog_realloc_rings(struct ice_fwlog *fwlog, int index)
 {
 	struct ice_fwlog_ring ring;
 	int status, ring_size;
@@ -109,7 +107,7 @@ void ice_fwlog_realloc_rings(struct ice_hw *hw, struct ice_fwlog *fwlog,
 
 	status = ice_fwlog_alloc_ring_buffs(&ring);
 	if (status) {
-		dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log ring data buffers\n");
+		dev_warn(&fwlog->pdev->dev, "Unable to allocate memory for FW log ring data buffers\n");
 		ice_fwlog_free_ring_buffs(&ring);
 		kfree(ring.rings);
 		return;
@@ -165,16 +163,16 @@ static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 
 	status = ice_aq_send_cmd(hw, &desc, buf, ICE_AQ_MAX_BUF_LEN, NULL);
 	if (status) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to get FW log configuration\n");
+		dev_dbg(&hw->fwlog.pdev->dev, "Failed to get FW log configuration\n");
 		goto status_out;
 	}
 
 	module_id_cnt = le16_to_cpu(cmd->ops.cfg.mdl_cnt);
 	if (module_id_cnt < ICE_AQC_FW_LOG_ID_MAX) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned less than the expected number of FW log module IDs\n");
+		dev_dbg(&hw->fwlog.pdev->dev, "FW returned less than the expected number of FW log module IDs\n");
 	} else if (module_id_cnt > ICE_AQC_FW_LOG_ID_MAX) {
-		ice_debug(hw, ICE_DBG_FW_LOG, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
-			  ICE_AQC_FW_LOG_ID_MAX);
+		dev_dbg(&hw->fwlog.pdev->dev, "FW returned more than expected number of FW log module IDs, setting module_id_cnt to software expected max %u\n",
+			ICE_AQC_FW_LOG_ID_MAX);
 		module_id_cnt = ICE_AQC_FW_LOG_ID_MAX;
 	}
 
@@ -225,8 +223,8 @@ static void ice_fwlog_set_supported(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 	status = ice_aq_fwlog_get(hw, cfg);
 	if (status)
-		ice_debug(hw, ICE_DBG_FW_LOG, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
-			  status);
+		dev_dbg(&fwlog->pdev->dev, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
+			status);
 	else
 		fwlog->supported = true;
 
@@ -237,17 +235,20 @@ static void ice_fwlog_set_supported(struct ice_hw *hw, struct ice_fwlog *fwlog)
  * ice_fwlog_init - Initialize FW logging configuration
  * @hw: pointer to the HW structure
  * @fwlog: pointer to the fwlog structure
+ * @pdev: pointer to the pci dev used in dev_warn()
  *
  * This function should be called on driver initialization during
  * ice_init_hw().
  */
-int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog)
+int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
+		   struct pci_dev *pdev)
 {
 	/* only support fw log commands on PF 0 */
 	if (hw->bus.func)
 		return -EINVAL;
 
 	ice_fwlog_set_supported(hw, fwlog);
+	fwlog->pdev = pdev;
 
 	if (ice_fwlog_supported(fwlog)) {
 		int status;
@@ -261,7 +262,7 @@ int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog)
 					    sizeof(*fwlog->ring.rings),
 					    GFP_KERNEL);
 		if (!fwlog->ring.rings) {
-			dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log rings\n");
+			dev_warn(&fwlog->pdev->dev, "Unable to allocate memory for FW log rings\n");
 			return -ENOMEM;
 		}
 
@@ -270,7 +271,7 @@ int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 		status = ice_fwlog_alloc_ring_buffs(&fwlog->ring);
 		if (status) {
-			dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log ring data buffers\n");
+			dev_warn(&fwlog->pdev->dev, "Unable to allocate memory for FW log ring data buffers\n");
 			ice_fwlog_free_ring_buffs(&fwlog->ring);
 			kfree(fwlog->ring.rings);
 			return status;
@@ -278,7 +279,7 @@ int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 		ice_debugfs_fwlog_init(hw->back);
 	} else {
-		dev_warn(ice_hw_to_dev(hw), "FW logging is not supported in this NVM image. Please update the NVM to get FW log support\n");
+		dev_warn(&fwlog->pdev->dev, "FW logging is not supported in this NVM image. Please update the NVM to get FW log support\n");
 	}
 
 	return 0;
@@ -308,7 +309,7 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 	fwlog->cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
 	status = ice_fwlog_set(hw, &fwlog->cfg);
 	if (status)
-		dev_warn(ice_hw_to_dev(hw), "Unable to turn off FW logging, status: %d\n",
+		dev_warn(&fwlog->pdev->dev, "Unable to turn off FW logging, status: %d\n",
 			 status);
 
 	kfree(pf->ice_debugfs_pf_fwlog_modules);
@@ -317,7 +318,7 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 	status = ice_fwlog_unregister(hw, fwlog);
 	if (status)
-		dev_warn(ice_hw_to_dev(hw), "Unable to unregister FW logging, status: %d\n",
+		dev_warn(&fwlog->pdev->dev, "Unable to unregister FW logging, status: %d\n",
 			 status);
 
 	if (fwlog->ring.rings) {
@@ -436,7 +437,7 @@ int ice_fwlog_register(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 	status = ice_aq_fwlog_register(hw, true);
 	if (status)
-		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to register for firmware logging events over ARQ\n");
+		dev_dbg(&fwlog->pdev->dev, "Failed to register for firmware logging events over ARQ\n");
 	else
 		fwlog->cfg.options |= ICE_FWLOG_OPTION_IS_REGISTERED;
 
@@ -457,7 +458,7 @@ int ice_fwlog_unregister(struct ice_hw *hw, struct ice_fwlog *fwlog)
 
 	status = ice_aq_fwlog_register(hw, false);
 	if (status)
-		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to unregister from firmware logging events over ARQ\n");
+		dev_dbg(&fwlog->pdev->dev, "Failed to unregister from firmware logging events over ARQ\n");
 	else
 		fwlog->cfg.options &= ~ICE_FWLOG_OPTION_IS_REGISTERED;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 334a125eac80..9c56ca6cbef0 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -68,16 +68,17 @@ struct ice_fwlog {
 	struct ice_fwlog_cfg cfg;
 	bool supported; /* does hardware support FW logging? */
 	struct ice_fwlog_ring ring;
+	struct pci_dev *pdev;
 };
 
 bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
 void ice_fwlog_ring_increment(u16 *item, u16 size);
-int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog);
+int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
+		   struct pci_dev *pdev);
 void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog);
 int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_register(struct ice_hw *hw, struct ice_fwlog *fwlog);
 int ice_fwlog_unregister(struct ice_hw *hw, struct ice_fwlog *fwlog);
-void ice_fwlog_realloc_rings(struct ice_hw *hw, struct ice_fwlog *fwlog,
-			     int index);
+void ice_fwlog_realloc_rings(struct ice_fwlog *fwlog, int index);
 void ice_get_fwlog_data(struct ice_fwlog *fwlog, u8 *buf, u16 len);
 #endif /* _ICE_FWLOG_H_ */
-- 
2.47.1


