Return-Path: <netdev+bounces-222316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5FB53D75
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BD15A340B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131DD2DE717;
	Thu, 11 Sep 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiRy66Q6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E862DA773
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624743; cv=none; b=c7INDJA1ZUk37ovVXH9t31L8yKfFg5eYDS0y1tZEuKZ8Srue/aSpSgYww8VPzlTbwgSWPVj6cvPH3zSQuB+3gLeCMQrpmGNR7ArM3hOtlDDlHyiQWvN3IEcDoDRACZHz2fGitMYkoRFe4L/Rb8o6dTok1MsqnRMEi6FvUSaXrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624743; c=relaxed/simple;
	bh=JpH1QXsICL0itgUPDhwY43CfgW/QTQi0Nsz8ravvpI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4raBpRs+fVskSjCTGq22QTP2+V0P2YaF7XrnKPVvpMF7R2KvHisccZoPhEJTdPBV7QlF41cqg0uJxV/xjC2jdjhGIEB7EE0HmehK+b49nWvSwFve1GEu7HycQMPQaBn5FWDfmhimkAOWgRJUyyhlYLd1wDijFaitSr1Cp4WRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiRy66Q6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624742; x=1789160742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpH1QXsICL0itgUPDhwY43CfgW/QTQi0Nsz8ravvpI4=;
  b=KiRy66Q6wM+OCHRLDYuQMNAu6d4KGY2rWVO1WzlDm2wcbiEqbNEkYqlc
   sjgUbloAJasgoBRERRuFsMPSbNPw/zFttfdXQ95rjJO2TrhbPagBVwjho
   LInPR9Ojx2NHgeRziWRtC8NgWep5/gP/yKX7wRmVwwVY/LQlZ8QF32mVW
   zofWeDCIxbWJ0hwR3TrnBpaQkHEx4CD2KdzxIuXdqPYj71GSGf87KqMq3
   gwojB9qwOqpdmvbslKwVL1V7JiQ7T29qSd0BOe4Qoe3r1DzpyS1oA8xWt
   Jn5bSeJklIgnlKXX6P4KR3NotqV3hQR1eUq8Y44vA+eRhppjIiFZEJRgM
   w==;
X-CSE-ConnectionGUID: YuUayIlpQ3qDWkUHi7ZCPg==
X-CSE-MsgGUID: pH12bYWfT3m0GLHXwZzEYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558880"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558880"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:39 -0700
X-CSE-ConnectionGUID: YGqruOnNRLOGF+IpovobSQ==
X-CSE-MsgGUID: m2chIIMkRe6MCpVsaFyjMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583345"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:37 -0700
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
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 04/15] ice: introduce ice_fwlog structure
Date: Thu, 11 Sep 2025 14:05:03 -0700
Message-ID: <20250911210525.345110-5-anthony.l.nguyen@intel.com>
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

The new structure is needed to make the fwlog code a library. A goal is
to drop ice_hw structure in all fwlog related functions calls.

Pass a ice_fwlog pointer across fwlog functions and use it wherever it
is possible.

Still use &hw->fwlog in debugfs code as it needs changing the value
being passed in priv. It will be done in one of the next patches.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  |   4 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  44 ++++----
 drivers/net/ethernet/intel/ice/ice_fwlog.c   | 112 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_fwlog.h   |  19 +++-
 drivers/net/ethernet/intel/ice/ice_main.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h    |   4 +-
 6 files changed, 98 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 808870539667..7043cca525c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1012,7 +1012,7 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_cqinit;
 
-	status = ice_fwlog_init(hw);
+	status = ice_fwlog_init(hw, &hw->fwlog);
 	if (status)
 		ice_debug(hw, ICE_DBG_FW_LOG, "Error initializing FW logging: %d\n",
 			  status);
@@ -1178,7 +1178,7 @@ void ice_deinit_hw(struct ice_hw *hw)
 	ice_free_hw_tbls(hw);
 	mutex_destroy(&hw->tnl_lock);
 
-	ice_fwlog_deinit(hw);
+	ice_fwlog_deinit(hw, &hw->fwlog);
 	ice_destroy_all_ctrlq(hw);
 
 	/* Clear VSI contexts if not already cleared */
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 170050548e74..dbcc0cb438aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -81,7 +81,7 @@ static const char * const ice_fwlog_log_size[] = {
 static void
 ice_fwlog_print_module_cfg(struct ice_hw *hw, int module, struct seq_file *s)
 {
-	struct ice_fwlog_cfg *cfg = &hw->fwlog_cfg;
+	struct ice_fwlog_cfg *cfg = &hw->fwlog.cfg;
 	struct ice_fwlog_module_entry *entry;
 
 	if (module != ICE_AQC_FW_LOG_ID_MAX) {
@@ -193,7 +193,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	}
 
 	if (module != ICE_AQC_FW_LOG_ID_MAX) {
-		hw->fwlog_cfg.module_entries[module].log_level = log_level;
+		hw->fwlog.cfg.module_entries[module].log_level = log_level;
 	} else {
 		/* the module 'all' is a shortcut so that we can set
 		 * all of the modules to the same level quickly
@@ -201,7 +201,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 		int i;
 
 		for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++)
-			hw->fwlog_cfg.module_entries[i].log_level = log_level;
+			hw->fwlog.cfg.module_entries[i].log_level = log_level;
 	}
 
 	return count;
@@ -231,7 +231,7 @@ static ssize_t ice_debugfs_nr_messages_read(struct file *filp,
 	char buff[32] = {};
 
 	snprintf(buff, sizeof(buff), "%d\n",
-		 hw->fwlog_cfg.log_resolution);
+		 hw->fwlog.cfg.log_resolution);
 
 	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
 }
@@ -278,7 +278,7 @@ ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 		return -EINVAL;
 	}
 
-	hw->fwlog_cfg.log_resolution = nr_messages;
+	hw->fwlog.cfg.log_resolution = nr_messages;
 
 	return count;
 }
@@ -306,7 +306,7 @@ static ssize_t ice_debugfs_enable_read(struct file *filp,
 	char buff[32] = {};
 
 	snprintf(buff, sizeof(buff), "%u\n",
-		 (u16)(hw->fwlog_cfg.options &
+		 (u16)(hw->fwlog.cfg.options &
 		 ICE_FWLOG_OPTION_IS_REGISTERED) >> 3);
 
 	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
@@ -346,18 +346,18 @@ ice_debugfs_enable_write(struct file *filp, const char __user *buf,
 		goto enable_write_error;
 
 	if (enable)
-		hw->fwlog_cfg.options |= ICE_FWLOG_OPTION_ARQ_ENA;
+		hw->fwlog.cfg.options |= ICE_FWLOG_OPTION_ARQ_ENA;
 	else
-		hw->fwlog_cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
+		hw->fwlog.cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
 
-	ret = ice_fwlog_set(hw, &hw->fwlog_cfg);
+	ret = ice_fwlog_set(hw, &hw->fwlog.cfg);
 	if (ret)
 		goto enable_write_error;
 
 	if (enable)
-		ret = ice_fwlog_register(hw);
+		ret = ice_fwlog_register(hw, &hw->fwlog);
 	else
-		ret = ice_fwlog_unregister(hw);
+		ret = ice_fwlog_unregister(hw, &hw->fwlog);
 
 	if (ret)
 		goto enable_write_error;
@@ -401,7 +401,7 @@ static ssize_t ice_debugfs_log_size_read(struct file *filp,
 	char buff[32] = {};
 	int index;
 
-	index = hw->fwlog_ring.index;
+	index = hw->fwlog.ring.index;
 	snprintf(buff, sizeof(buff), "%s\n", ice_fwlog_log_size[index]);
 
 	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
@@ -443,14 +443,14 @@ ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
 			 user_val);
 		ret = -EINVAL;
 		goto log_size_write_error;
-	} else if (hw->fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
+	} else if (hw->fwlog.cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
 		dev_info(dev, "FW logging is currently running. Please disable FW logging to change log_size\n");
 		ret = -EINVAL;
 		goto log_size_write_error;
 	}
 
 	/* free all the buffers and the tracking info and resize */
-	ice_fwlog_realloc_rings(hw, index);
+	ice_fwlog_realloc_rings(hw, &hw->fwlog, index);
 
 	/* if we get here, nothing went wrong; return count since we didn't
 	 * really write anything
@@ -490,14 +490,14 @@ static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
 	int data_copied = 0;
 	bool done = false;
 
-	if (ice_fwlog_ring_empty(&hw->fwlog_ring))
+	if (ice_fwlog_ring_empty(&hw->fwlog.ring))
 		return 0;
 
-	while (!ice_fwlog_ring_empty(&hw->fwlog_ring) && !done) {
+	while (!ice_fwlog_ring_empty(&hw->fwlog.ring) && !done) {
 		struct ice_fwlog_data *log;
 		u16 cur_buf_len;
 
-		log = &hw->fwlog_ring.rings[hw->fwlog_ring.head];
+		log = &hw->fwlog.ring.rings[hw->fwlog.ring.head];
 		cur_buf_len = log->data_size;
 		if (cur_buf_len >= count) {
 			done = true;
@@ -516,8 +516,8 @@ static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
 		buffer += cur_buf_len;
 		count -= cur_buf_len;
 		*ppos += cur_buf_len;
-		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
-					 hw->fwlog_ring.size);
+		ice_fwlog_ring_increment(&hw->fwlog.ring.head,
+					 hw->fwlog.ring.size);
 	}
 
 	return data_copied;
@@ -546,9 +546,9 @@ ice_debugfs_data_write(struct file *filp, const char __user *buf, size_t count,
 	/* any value is allowed to clear the buffer so no need to even look at
 	 * what the value is
 	 */
-	if (!(hw->fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED)) {
-		hw->fwlog_ring.head = 0;
-		hw->fwlog_ring.tail = 0;
+	if (!(hw->fwlog.cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED)) {
+		hw->fwlog.ring.head = 0;
+		hw->fwlog.ring.tail = 0;
 	} else {
 		dev_info(dev, "Can't clear FW log data while FW log running\n");
 		ret = -EINVAL;
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index ea5d6d2d3f30..a010f655ffb7 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -74,10 +74,12 @@ static void ice_fwlog_free_ring_buffs(struct ice_fwlog_ring *rings)
 /**
  * ice_fwlog_realloc_rings - reallocate the FW log rings
  * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  * @index: the new index to use to allocate memory for the log data
  *
  */
-void ice_fwlog_realloc_rings(struct ice_hw *hw, int index)
+void ice_fwlog_realloc_rings(struct ice_hw *hw, struct ice_fwlog *fwlog,
+			     int index)
 {
 	struct ice_fwlog_ring ring;
 	int status, ring_size;
@@ -92,7 +94,7 @@ void ice_fwlog_realloc_rings(struct ice_hw *hw, int index)
 	 * can be correctly parsed by the tools
 	 */
 	ring_size = ICE_FWLOG_INDEX_TO_BYTES(index) / ICE_AQ_MAX_BUF_LEN;
-	if (ring_size == hw->fwlog_ring.size)
+	if (ring_size == fwlog->ring.size)
 		return;
 
 	/* allocate space for the new rings and buffers then release the
@@ -113,26 +115,26 @@ void ice_fwlog_realloc_rings(struct ice_hw *hw, int index)
 		return;
 	}
 
-	ice_fwlog_free_ring_buffs(&hw->fwlog_ring);
-	kfree(hw->fwlog_ring.rings);
+	ice_fwlog_free_ring_buffs(&fwlog->ring);
+	kfree(fwlog->ring.rings);
 
-	hw->fwlog_ring.rings = ring.rings;
-	hw->fwlog_ring.size = ring.size;
-	hw->fwlog_ring.index = index;
-	hw->fwlog_ring.head = 0;
-	hw->fwlog_ring.tail = 0;
+	fwlog->ring.rings = ring.rings;
+	fwlog->ring.size = ring.size;
+	fwlog->ring.index = index;
+	fwlog->ring.head = 0;
+	fwlog->ring.tail = 0;
 }
 
 /**
  * ice_fwlog_supported - Cached for whether FW supports FW logging or not
- * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  *
  * This will always return false if called before ice_init_hw(), so it must be
  * called after ice_init_hw().
  */
-static bool ice_fwlog_supported(struct ice_hw *hw)
+static bool ice_fwlog_supported(struct ice_fwlog *fwlog)
 {
-	return hw->fwlog_supported;
+	return fwlog->supported;
 }
 
 /**
@@ -202,6 +204,7 @@ static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 /**
  * ice_fwlog_set_supported - Set if FW logging is supported by FW
  * @hw: pointer to the HW struct
+ * @fwlog: pointer to the fwlog structure
  *
  * If FW returns success to the ice_aq_fwlog_get call then it supports FW
  * logging, else it doesn't. Set the fwlog_supported flag accordingly.
@@ -209,12 +212,12 @@ static int ice_aq_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
  * This function is only meant to be called during driver init to determine if
  * the FW support FW logging.
  */
-static void ice_fwlog_set_supported(struct ice_hw *hw)
+static void ice_fwlog_set_supported(struct ice_hw *hw, struct ice_fwlog *fwlog)
 {
 	struct ice_fwlog_cfg *cfg;
 	int status;
 
-	hw->fwlog_supported = false;
+	fwlog->supported = false;
 
 	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
@@ -225,7 +228,7 @@ static void ice_fwlog_set_supported(struct ice_hw *hw)
 		ice_debug(hw, ICE_DBG_FW_LOG, "ice_aq_fwlog_get failed, FW logging is not supported on this version of FW, status %d\n",
 			  status);
 	else
-		hw->fwlog_supported = true;
+		fwlog->supported = true;
 
 	kfree(cfg);
 }
@@ -233,42 +236,43 @@ static void ice_fwlog_set_supported(struct ice_hw *hw)
 /**
  * ice_fwlog_init - Initialize FW logging configuration
  * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  *
  * This function should be called on driver initialization during
  * ice_init_hw().
  */
-int ice_fwlog_init(struct ice_hw *hw)
+int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog)
 {
 	/* only support fw log commands on PF 0 */
 	if (hw->bus.func)
 		return -EINVAL;
 
-	ice_fwlog_set_supported(hw);
+	ice_fwlog_set_supported(hw, fwlog);
 
-	if (ice_fwlog_supported(hw)) {
+	if (ice_fwlog_supported(fwlog)) {
 		int status;
 
 		/* read the current config from the FW and store it */
-		status = ice_aq_fwlog_get(hw, &hw->fwlog_cfg);
+		status = ice_aq_fwlog_get(hw, &fwlog->cfg);
 		if (status)
 			return status;
 
-		hw->fwlog_ring.rings = kcalloc(ICE_FWLOG_RING_SIZE_DFLT,
-					       sizeof(*hw->fwlog_ring.rings),
-					       GFP_KERNEL);
-		if (!hw->fwlog_ring.rings) {
+		fwlog->ring.rings = kcalloc(ICE_FWLOG_RING_SIZE_DFLT,
+					    sizeof(*fwlog->ring.rings),
+					    GFP_KERNEL);
+		if (!fwlog->ring.rings) {
 			dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log rings\n");
 			return -ENOMEM;
 		}
 
-		hw->fwlog_ring.size = ICE_FWLOG_RING_SIZE_DFLT;
-		hw->fwlog_ring.index = ICE_FWLOG_RING_SIZE_INDEX_DFLT;
+		fwlog->ring.size = ICE_FWLOG_RING_SIZE_DFLT;
+		fwlog->ring.index = ICE_FWLOG_RING_SIZE_INDEX_DFLT;
 
-		status = ice_fwlog_alloc_ring_buffs(&hw->fwlog_ring);
+		status = ice_fwlog_alloc_ring_buffs(&fwlog->ring);
 		if (status) {
 			dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log ring data buffers\n");
-			ice_fwlog_free_ring_buffs(&hw->fwlog_ring);
-			kfree(hw->fwlog_ring.rings);
+			ice_fwlog_free_ring_buffs(&fwlog->ring);
+			kfree(fwlog->ring.rings);
 			return status;
 		}
 
@@ -283,10 +287,11 @@ int ice_fwlog_init(struct ice_hw *hw)
 /**
  * ice_fwlog_deinit - unroll FW logging configuration
  * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  *
  * This function should be called in ice_deinit_hw().
  */
-void ice_fwlog_deinit(struct ice_hw *hw)
+void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 {
 	struct ice_pf *pf = hw->back;
 	int status;
@@ -300,8 +305,8 @@ void ice_fwlog_deinit(struct ice_hw *hw)
 	/* make sure FW logging is disabled to not put the FW in a weird state
 	 * for the next driver load
 	 */
-	hw->fwlog_cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
-	status = ice_fwlog_set(hw, &hw->fwlog_cfg);
+	fwlog->cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
+	status = ice_fwlog_set(hw, &fwlog->cfg);
 	if (status)
 		dev_warn(ice_hw_to_dev(hw), "Unable to turn off FW logging, status: %d\n",
 			 status);
@@ -310,14 +315,14 @@ void ice_fwlog_deinit(struct ice_hw *hw)
 
 	pf->ice_debugfs_pf_fwlog_modules = NULL;
 
-	status = ice_fwlog_unregister(hw);
+	status = ice_fwlog_unregister(hw, fwlog);
 	if (status)
 		dev_warn(ice_hw_to_dev(hw), "Unable to unregister FW logging, status: %d\n",
 			 status);
 
-	if (hw->fwlog_ring.rings) {
-		ice_fwlog_free_ring_buffs(&hw->fwlog_ring);
-		kfree(hw->fwlog_ring.rings);
+	if (fwlog->ring.rings) {
+		ice_fwlog_free_ring_buffs(&fwlog->ring);
+		kfree(fwlog->ring.rings);
 	}
 }
 
@@ -387,7 +392,7 @@ ice_aq_fwlog_set(struct ice_hw *hw, struct ice_fwlog_module_entry *entries,
  */
 int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
 {
-	if (!ice_fwlog_supported(hw))
+	if (!ice_fwlog_supported(&hw->fwlog))
 		return -EOPNOTSUPP;
 
 	return ice_aq_fwlog_set(hw, cfg->module_entries,
@@ -417,22 +422,23 @@ static int ice_aq_fwlog_register(struct ice_hw *hw, bool reg)
 /**
  * ice_fwlog_register - Register the PF for firmware logging
  * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  *
  * After this call the PF will start to receive firmware logging based on the
  * configuration set in ice_fwlog_set.
  */
-int ice_fwlog_register(struct ice_hw *hw)
+int ice_fwlog_register(struct ice_hw *hw, struct ice_fwlog *fwlog)
 {
 	int status;
 
-	if (!ice_fwlog_supported(hw))
+	if (!ice_fwlog_supported(fwlog))
 		return -EOPNOTSUPP;
 
 	status = ice_aq_fwlog_register(hw, true);
 	if (status)
 		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to register for firmware logging events over ARQ\n");
 	else
-		hw->fwlog_cfg.options |= ICE_FWLOG_OPTION_IS_REGISTERED;
+		fwlog->cfg.options |= ICE_FWLOG_OPTION_IS_REGISTERED;
 
 	return status;
 }
@@ -440,44 +446,44 @@ int ice_fwlog_register(struct ice_hw *hw)
 /**
  * ice_fwlog_unregister - Unregister the PF from firmware logging
  * @hw: pointer to the HW structure
+ * @fwlog: pointer to the fwlog structure
  */
-int ice_fwlog_unregister(struct ice_hw *hw)
+int ice_fwlog_unregister(struct ice_hw *hw, struct ice_fwlog *fwlog)
 {
 	int status;
 
-	if (!ice_fwlog_supported(hw))
+	if (!ice_fwlog_supported(fwlog))
 		return -EOPNOTSUPP;
 
 	status = ice_aq_fwlog_register(hw, false);
 	if (status)
 		ice_debug(hw, ICE_DBG_FW_LOG, "Failed to unregister from firmware logging events over ARQ\n");
 	else
-		hw->fwlog_cfg.options &= ~ICE_FWLOG_OPTION_IS_REGISTERED;
+		fwlog->cfg.options &= ~ICE_FWLOG_OPTION_IS_REGISTERED;
 
 	return status;
 }
 
 /**
  * ice_get_fwlog_data - copy the FW log data from ARQ event
- * @hw: HW that the FW log event is associated with
+ * @fwlog: fwlog that the FW log event is associated with
  * @buf: event buffer pointer
  * @len: len of event descriptor
  */
-void ice_get_fwlog_data(struct ice_hw *hw, u8 *buf, u16 len)
+void ice_get_fwlog_data(struct ice_fwlog *fwlog, u8 *buf, u16 len)
 {
-	struct ice_fwlog_data *fwlog;
+	struct ice_fwlog_data *log;
 
-	fwlog = &hw->fwlog_ring.rings[hw->fwlog_ring.tail];
+	log = &fwlog->ring.rings[fwlog->ring.tail];
 
-	memset(fwlog->data, 0, PAGE_SIZE);
-	fwlog->data_size = len;
+	memset(log->data, 0, PAGE_SIZE);
+	log->data_size = len;
 
-	memcpy(fwlog->data, buf, fwlog->data_size);
-	ice_fwlog_ring_increment(&hw->fwlog_ring.tail, hw->fwlog_ring.size);
+	memcpy(log->data, buf, log->data_size);
+	ice_fwlog_ring_increment(&fwlog->ring.tail, fwlog->ring.size);
 
-	if (ice_fwlog_ring_full(&hw->fwlog_ring)) {
+	if (ice_fwlog_ring_full(&fwlog->ring)) {
 		/* the rings are full so bump the head to create room */
-		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
-					 hw->fwlog_ring.size);
+		ice_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
 	}
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 5b9244f4f0f1..334a125eac80 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -64,13 +64,20 @@ struct ice_fwlog_ring {
 #define ICE_FWLOG_RING_SIZE_DFLT 256
 #define ICE_FWLOG_RING_SIZE_MAX 512
 
+struct ice_fwlog {
+	struct ice_fwlog_cfg cfg;
+	bool supported; /* does hardware support FW logging? */
+	struct ice_fwlog_ring ring;
+};
+
 bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
 void ice_fwlog_ring_increment(u16 *item, u16 size);
-int ice_fwlog_init(struct ice_hw *hw);
-void ice_fwlog_deinit(struct ice_hw *hw);
+int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog);
+void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog);
 int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
-int ice_fwlog_register(struct ice_hw *hw);
-int ice_fwlog_unregister(struct ice_hw *hw);
-void ice_fwlog_realloc_rings(struct ice_hw *hw, int index);
-void ice_get_fwlog_data(struct ice_hw *hw, u8 *buf, u16 len);
+int ice_fwlog_register(struct ice_hw *hw, struct ice_fwlog *fwlog);
+int ice_fwlog_unregister(struct ice_hw *hw, struct ice_fwlog *fwlog);
+void ice_fwlog_realloc_rings(struct ice_hw *hw, struct ice_fwlog *fwlog,
+			     int index);
+void ice_get_fwlog_data(struct ice_fwlog *fwlog, u8 *buf, u16 len);
 #endif /* _ICE_FWLOG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47e2fab3432e..e7e775f7ea34 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1540,7 +1540,7 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
 			}
 			break;
 		case ice_aqc_opc_fw_logs_event:
-			ice_get_fwlog_data(hw, event.msg_buf,
+			ice_get_fwlog_data(&hw->fwlog, event.msg_buf,
 					   le16_to_cpu(event.desc.datalen));
 			break;
 		case ice_aqc_opc_lldp_set_mib_change:
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 8d19efc1df72..643d84cc78df 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -948,9 +948,7 @@ struct ice_hw {
 	u8 fw_patch;		/* firmware patch version */
 	u32 fw_build;		/* firmware build number */
 
-	struct ice_fwlog_cfg fwlog_cfg;
-	bool fwlog_supported; /* does hardware support FW logging? */
-	struct ice_fwlog_ring fwlog_ring;
+	struct ice_fwlog fwlog;
 
 /* Device max aggregate bandwidths corresponding to the GL_PWR_MODE_CTL
  * register. Used for determining the ITR/INTRL granularity during
-- 
2.47.1


