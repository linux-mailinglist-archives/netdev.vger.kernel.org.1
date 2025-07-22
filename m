Return-Path: <netdev+bounces-208888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579DCB0D7CE
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505BB6C2D3A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4582E3394;
	Tue, 22 Jul 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWHVZdPY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E228C2B2
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182427; cv=none; b=j5NdU1tuR6HuUOnm4uf35lqEjUjR8Q0GkZv/NlywaOugjJRfExc41D5m91oDREIYARCRmJQ0VWdxo8N+N3dRsyRrDzYBJuXeQDfo1mwmrqhu2xvgyyeqoosP3/LXmvQKmgayt2wax9ma5C9csTKHc1m5f5S2GrDxVZG3FYUYnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182427; c=relaxed/simple;
	bh=VDCYv50sR16//RzoiqClod2CdnadLpSqllJULhbeYd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ/lRkNpsFpRPt+d+CAvxGthACKvF1E1WHs9ljfsqwk7eMg7MGZRK0i5pZtqXlaf5QjETWuX2hQAz6mdBYUlN5x53/jzPygKpJu45Gkp4hnQSvCTE5edNmSjTsetaZKFHju/xvju079Dni2WiW17QA4bwxpKFF9BaXLjjL4YU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWHVZdPY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753182426; x=1784718426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VDCYv50sR16//RzoiqClod2CdnadLpSqllJULhbeYd4=;
  b=VWHVZdPY71p7Ldtqsss77m5OV6z2kiHcoKOL9qJCTdD3lh/xplTaxlBU
   OE8i7ZuiJSDvCkZmY9L7MlRW6QFwtxieyBl0uQjhrVuyWPcsIA/8L6NyW
   Iyv8l93lO3JIkV01gSrcSoG9GHo0FB7muS4LQZj/ad7LbmqJM8GWhoA2a
   wsMh4PtKRlhalNF138+PFi+i0exAXlWjBsLjIPuAaDlO7fcBAGbEoP/6g
   hFsbr9+UbNm1uSwjbo0D+mzkM7T3qMVT5+IOcPf5G2MNnjxkri3otaN91
   PbkqAJTj1+fob7mTk5ZX4VhE0rPow4u0Sv9cDPoB89WWrjN4LoLO5sp2b
   w==;
X-CSE-ConnectionGUID: F68Cxb/VR1SFo24L0NEYig==
X-CSE-MsgGUID: LHznH6YbQFubFSU8TcCsUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59083597"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59083597"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:07:05 -0700
X-CSE-ConnectionGUID: QLBRZ5aMQOyuM3qJZsqlkg==
X-CSE-MsgGUID: 0D7bExcuRkeXJaaVHRD5ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163153945"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jul 2025 04:07:03 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 05/15] ice: add pdev into fwlog structure and use it for logging
Date: Tue, 22 Jul 2025 12:45:50 +0200
Message-ID: <20250722104600.10141-6-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare the code to be moved to the library. ice_debug() won't be there
so switch to dev_dbg().

Add struct pdev pointer in fwlog to track on which pdev the fwlog was
created.

Switch the dev passed in dev_warn() to the one stored in fwlog.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  |  3 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c   | 37 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_fwlog.h   |  7 ++--
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 5d7f348aa596..7f293c791775 100644
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
2.49.0


