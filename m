Return-Path: <netdev+bounces-212761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153B3B21C3B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74C21A2648B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D168F2DCBE0;
	Tue, 12 Aug 2025 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAJauInV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4272E370F
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974033; cv=none; b=hTyEzDBJkgMGP3wlMWT68JIkr5uDRbmShnhdnRGESy1ObSjW4a21J9aptXQSEKCmHczeXH0Nf+aFSBJbEnSW3Ww2gfC8Vi7ey2nMIssWTY4fvnrwXids5SNW9uoUv6rxokOVLw37B5/Bpe0mAuYpfpjriMaVZlsAXjEKMxXUwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974033; c=relaxed/simple;
	bh=lUmMzhQyaWiRME1aliV1hPVAaG8WPUGfrFrDOvy44hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZfLrJEAIcMLMwP45v8Ud9qY1SI300N4LUEzssEHa+OTocRRGUqP+ksMnIC3lYNl9uKMADwGjsjmg6LPVwL/ENc80T5Y6ujvF7KB1xpL2bDWZ/d4xGwU7xoMGG+QtAI9pBOEMJse77c7rr1MJvAyHQ6mPf3s6wEuDwbEuabquNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAJauInV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974032; x=1786510032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUmMzhQyaWiRME1aliV1hPVAaG8WPUGfrFrDOvy44hM=;
  b=HAJauInV9xQXbfx0yVqYrYkVIHKzYhBs7ztCLn2RM1bAhmzehQ5aebjk
   9RyWTnv48M/1j+f5CHMhT8PlSzcLzpWPMEv6ZHAtGevdqSGFrAtIwT4UK
   T+CwYJL2Kf8fdLe9s5TeOqmf6gUiGXFSLbrRzXZVubC2RvTqAvFg1ZFEX
   mkHvQN75IVK6Lt9m7OJF6U6EncrA+dGvhmShq2wGqmJQGTSRXQyYCOsXu
   vX5a3reNmgP+DJji0//TyoviPHJ4lvQkIt5CHgW5LDsME10TmjhASsjt0
   z3tVJYByEadBG31eHXzRRS9Txx/uz4aV1bDDeI/PU35WkTBcAGSQvNH8j
   g==;
X-CSE-ConnectionGUID: wAubFlC8TwGg/dX0SIfAZA==
X-CSE-MsgGUID: 0G/uqrvhT2OMWCE+bMRLcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612761"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612761"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:47:11 -0700
X-CSE-ConnectionGUID: KAtEnrvIRPOFBT7itgngOg==
X-CSE-MsgGUID: rTt40fL6Q5mZS/4ESbZ1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327907"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:47:10 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 09/15] ice: drop driver specific structure from fwlog code
Date: Tue, 12 Aug 2025 06:23:30 +0200
Message-ID: <20250812042337.1356907-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In debugfs pass ice_fwlog structure instead of ice_pf.

The debgufs dirs specific for fwlog can be stored in fwlog structure.

Add debugfs entry point to fwlog api.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.c  |   6 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 131 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_fwlog.c   |  14 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.h   |   9 +-
 5 files changed, 75 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ee2ae0cbc25e..9ed4197ee7bc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -568,9 +568,6 @@ struct ice_pf {
 	struct ice_sw *first_sw;	/* first switch created by firmware */
 	u16 eswitch_mode;		/* current mode of eswitch */
 	struct dentry *ice_debugfs_pf;
-	struct dentry *ice_debugfs_pf_fwlog;
-	/* keep track of all the dentrys for FW log modules */
-	struct dentry **ice_debugfs_pf_fwlog_modules;
 	struct ice_vfs vfs;
 	DECLARE_BITMAP(features, ICE_F_MAX);
 	DECLARE_BITMAP(state, ICE_STATE_NBITS);
@@ -908,7 +905,7 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
 	return false;
 }
 
-void ice_debugfs_fwlog_init(struct ice_pf *pf);
+void ice_debugfs_fwlog_init(struct ice_fwlog *fwlog, struct dentry *root);
 int ice_debugfs_pf_init(struct ice_pf *pf);
 void ice_debugfs_pf_deinit(struct ice_pf *pf);
 void ice_debugfs_init(void);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2666e59b0786..5a365f65c0e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1010,7 +1010,9 @@ static int __fwlog_init(struct ice_hw *hw)
 	if (err)
 		return err;
 
-	return ice_fwlog_init(hw, &hw->fwlog, &api);
+	api.debugfs_root = pf->ice_debugfs_pf;
+
+	return ice_fwlog_init(&hw->fwlog, &api);
 }
 
 /**
@@ -1195,7 +1197,7 @@ static void __fwlog_deinit(struct ice_hw *hw)
 		return;
 
 	ice_debugfs_pf_deinit(hw->back);
-	ice_fwlog_deinit(hw, &hw->fwlog);
+	ice_fwlog_deinit(&hw->fwlog);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index e5b63b6bd44d..36a13f54bddc 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -74,14 +74,14 @@ static const char * const ice_fwlog_log_size[] = {
 
 /**
  * ice_fwlog_print_module_cfg - print current FW logging module configuration
- * @hw: pointer to the HW structure
+ * @cfg: pointer to the fwlog cfg structure
  * @module: module to print
  * @s: the seq file to put data into
  */
 static void
-ice_fwlog_print_module_cfg(struct ice_hw *hw, int module, struct seq_file *s)
+ice_fwlog_print_module_cfg(struct ice_fwlog_cfg *cfg, int module,
+			   struct seq_file *s)
 {
-	struct ice_fwlog_cfg *cfg = &hw->fwlog.cfg;
 	struct ice_fwlog_module_entry *entry;
 
 	if (module != ICE_AQC_FW_LOG_ID_MAX) {
@@ -103,14 +103,14 @@ ice_fwlog_print_module_cfg(struct ice_hw *hw, int module, struct seq_file *s)
 	}
 }
 
-static int ice_find_module_by_dentry(struct ice_pf *pf, struct dentry *d)
+static int ice_find_module_by_dentry(struct dentry **modules, struct dentry *d)
 {
 	int i, module;
 
 	module = -1;
 	/* find the module based on the dentry */
 	for (i = 0; i < ICE_NR_FW_LOG_MODULES; i++) {
-		if (d == pf->ice_debugfs_pf_fwlog_modules[i]) {
+		if (d == modules[i]) {
 			module = i;
 			break;
 		}
@@ -126,21 +126,20 @@ static int ice_find_module_by_dentry(struct ice_pf *pf, struct dentry *d)
  */
 static int ice_debugfs_module_show(struct seq_file *s, void *v)
 {
+	struct ice_fwlog *fwlog = s->private;
 	const struct file *filp = s->file;
 	struct dentry *dentry;
-	struct ice_pf *pf;
 	int module;
 
 	dentry = file_dentry(filp);
-	pf = s->private;
 
-	module = ice_find_module_by_dentry(pf, dentry);
+	module = ice_find_module_by_dentry(fwlog->debugfs_modules, dentry);
 	if (module < 0) {
-		dev_info(ice_pf_to_dev(pf), "unknown module\n");
+		dev_info(&fwlog->pdev->dev, "unknown module\n");
 		return -EINVAL;
 	}
 
-	ice_fwlog_print_module_cfg(&pf->hw, module, s);
+	ice_fwlog_print_module_cfg(&fwlog->cfg, module, s);
 
 	return 0;
 }
@@ -161,10 +160,9 @@ static ssize_t
 ice_debugfs_module_write(struct file *filp, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	struct ice_pf *pf = file_inode(filp)->i_private;
+	struct ice_fwlog *fwlog = file_inode(filp)->i_private;
 	struct dentry *dentry = file_dentry(filp);
-	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_hw *hw = &pf->hw;
+	struct device *dev = &fwlog->pdev->dev;
 	char user_val[16], *cmd_buf;
 	int module, log_level, cnt;
 
@@ -176,7 +174,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
-	module = ice_find_module_by_dentry(pf, dentry);
+	module = ice_find_module_by_dentry(fwlog->debugfs_modules, dentry);
 	if (module < 0) {
 		dev_info(dev, "unknown module\n");
 		return -EINVAL;
@@ -193,7 +191,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	}
 
 	if (module != ICE_AQC_FW_LOG_ID_MAX) {
-		hw->fwlog.cfg.module_entries[module].log_level = log_level;
+		fwlog->cfg.module_entries[module].log_level = log_level;
 	} else {
 		/* the module 'all' is a shortcut so that we can set
 		 * all of the modules to the same level quickly
@@ -201,7 +199,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 		int i;
 
 		for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++)
-			hw->fwlog.cfg.module_entries[i].log_level = log_level;
+			fwlog->cfg.module_entries[i].log_level = log_level;
 	}
 
 	return count;
@@ -226,12 +224,11 @@ static ssize_t ice_debugfs_nr_messages_read(struct file *filp,
 					    char __user *buffer, size_t count,
 					    loff_t *ppos)
 {
-	struct ice_pf *pf = filp->private_data;
-	struct ice_hw *hw = &pf->hw;
+	struct ice_fwlog *fwlog = filp->private_data;
 	char buff[32] = {};
 
 	snprintf(buff, sizeof(buff), "%d\n",
-		 hw->fwlog.cfg.log_resolution);
+		 fwlog->cfg.log_resolution);
 
 	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
 }
@@ -247,9 +244,8 @@ static ssize_t
 ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct ice_pf *pf = filp->private_data;
-	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_hw *hw = &pf->hw;
+	struct ice_fwlog *fwlog = filp->private_data;
+	struct device *dev = &fwlog->pdev->dev;
 	char user_val[8], *cmd_buf;
 	s16 nr_messages;
 	ssize_t ret;
@@ -278,7 +274,7 @@ ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 		return -EINVAL;
 	}
 
-	hw->fwlog.cfg.log_resolution = nr_messages;
+	fwlog->cfg.log_resolution = nr_messages;
 
 	return count;
 }
@@ -301,12 +297,11 @@ static ssize_t ice_debugfs_enable_read(struct file *filp,
 				       char __user *buffer, size_t count,
 				       loff_t *ppos)
 {
-	struct ice_pf *pf = filp->private_data;
-	struct ice_hw *hw = &pf->hw;
+	struct ice_fwlog *fwlog = filp->private_data;
 	char buff[32] = {};
 
 	snprintf(buff, sizeof(buff), "%u\n",
-		 (u16)(hw->fwlog.cfg.options &
+		 (u16)(fwlog->cfg.options &
 		 ICE_FWLOG_OPTION_IS_REGISTERED) >> 3);
 
 	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
@@ -323,8 +318,7 @@ static ssize_t
 ice_debugfs_enable_write(struct file *filp, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	struct ice_pf *pf = filp->private_data;
-	struct ice_hw *hw = &pf->hw;
+	struct ice_fwlog *fwlog = filp->private_data;
 	char user_val[8], *cmd_buf;
 	bool enable;
 	ssize_t ret;
@@ -346,18 +340,18 @@ ice_debugfs_enable_write(struct file *filp, const char __user *buf,
 		goto enable_write_error;
 
 	if (enable)
-		hw->fwlog.cfg.options |= ICE_FWLOG_OPTION_ARQ_ENA;
+		fwlog->cfg.options |= ICE_FWLOG_OPTION_ARQ_ENA;
 	else
-		hw->fwlog.cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
+		fwlog->cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
 
-	ret = ice_fwlog_set(&hw->fwlog, &hw->fwlog.cfg);
+	ret = ice_fwlog_set(fwlog, &fwlog->cfg);
 	if (ret)
 		goto enable_write_error;
 
 	if (enable)
-		ret = ice_fwlog_register(&hw->fwlog);
+		ret = ice_fwlog_register(fwlog);
 	else
-		ret = ice_fwlog_unregister(&hw->fwlog);
+		ret = ice_fwlog_unregister(fwlog);
 
 	if (ret)
 		goto enable_write_error;
@@ -396,12 +390,11 @@ static ssize_t ice_debugfs_log_size_read(struct file *filp,
 					 char __user *buffer, size_t count,
 					 loff_t *ppos)
 {
-	struct ice_pf *pf = filp->private_data;
-	struct ice_hw *hw = &pf->hw;
+	struct ice_fwlog *fwlog = filp->private_data;
 	char buff[32] = {};
 	int index;
 
-	index = hw->fwlog.ring.index;
+	index = fwlog->ring.index;
 	snprintf(buff, sizeof(buff), "%s\n", ice_fwlog_log_size[index]);
 
 	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
@@ -418,9 +411,8 @@ static ssize_t
 ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
 			   size_t count, loff_t *ppos)
 {
-	struct ice_pf *pf = filp->private_data;
-	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_hw *hw = &pf->hw;
+	struct ice_fwlog *fwlog = filp->private_data;
+	struct device *dev = &fwlog->pdev->dev;
 	char user_val[8], *cmd_buf;
 	ssize_t ret;
 	int index;
@@ -443,14 +435,14 @@ ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
 			 user_val);
 		ret = -EINVAL;
 		goto log_size_write_error;
-	} else if (hw->fwlog.cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
+	} else if (fwlog->cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
 		dev_info(dev, "FW logging is currently running. Please disable FW logging to change log_size\n");
 		ret = -EINVAL;
 		goto log_size_write_error;
 	}
 
 	/* free all the buffers and the tracking info and resize */
-	ice_fwlog_realloc_rings(&hw->fwlog, index);
+	ice_fwlog_realloc_rings(fwlog, index);
 
 	/* if we get here, nothing went wrong; return count since we didn't
 	 * really write anything
@@ -485,19 +477,18 @@ static const struct file_operations ice_debugfs_log_size_fops = {
 static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
 				     size_t count, loff_t *ppos)
 {
-	struct ice_pf *pf = filp->private_data;
-	struct ice_hw *hw = &pf->hw;
+	struct ice_fwlog *fwlog = filp->private_data;
 	int data_copied = 0;
 	bool done = false;
 
-	if (ice_fwlog_ring_empty(&hw->fwlog.ring))
+	if (ice_fwlog_ring_empty(&fwlog->ring))
 		return 0;
 
-	while (!ice_fwlog_ring_empty(&hw->fwlog.ring) && !done) {
+	while (!ice_fwlog_ring_empty(&fwlog->ring) && !done) {
 		struct ice_fwlog_data *log;
 		u16 cur_buf_len;
 
-		log = &hw->fwlog.ring.rings[hw->fwlog.ring.head];
+		log = &fwlog->ring.rings[fwlog->ring.head];
 		cur_buf_len = log->data_size;
 		if (cur_buf_len >= count) {
 			done = true;
@@ -516,8 +507,7 @@ static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
 		buffer += cur_buf_len;
 		count -= cur_buf_len;
 		*ppos += cur_buf_len;
-		ice_fwlog_ring_increment(&hw->fwlog.ring.head,
-					 hw->fwlog.ring.size);
+		ice_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
 	}
 
 	return data_copied;
@@ -534,9 +524,8 @@ static ssize_t
 ice_debugfs_data_write(struct file *filp, const char __user *buf, size_t count,
 		       loff_t *ppos)
 {
-	struct ice_pf *pf = filp->private_data;
-	struct device *dev = ice_pf_to_dev(pf);
-	struct ice_hw *hw = &pf->hw;
+	struct ice_fwlog *fwlog = filp->private_data;
+	struct device *dev = &fwlog->pdev->dev;
 	ssize_t ret;
 
 	/* don't allow partial writes */
@@ -546,9 +535,9 @@ ice_debugfs_data_write(struct file *filp, const char __user *buf, size_t count,
 	/* any value is allowed to clear the buffer so no need to even look at
 	 * what the value is
 	 */
-	if (!(hw->fwlog.cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED)) {
-		hw->fwlog.ring.head = 0;
-		hw->fwlog.ring.tail = 0;
+	if (!(fwlog->cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED)) {
+		fwlog->ring.head = 0;
+		fwlog->ring.tail = 0;
 	} else {
 		dev_info(dev, "Can't clear FW log data while FW log running\n");
 		ret = -EINVAL;
@@ -580,9 +569,10 @@ static const struct file_operations ice_debugfs_data_fops = {
 
 /**
  * ice_debugfs_fwlog_init - setup the debugfs directory
- * @pf: the ice that is starting up
+ * @fwlog: pointer to the fwlog structure
+ * @root: debugfs root entry on which fwlog director will be registered
  */
-void ice_debugfs_fwlog_init(struct ice_pf *pf)
+void ice_debugfs_fwlog_init(struct ice_fwlog *fwlog, struct dentry *root)
 {
 	struct dentry *fw_modules_dir;
 	struct dentry **fw_modules;
@@ -596,43 +586,40 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 	if (!fw_modules)
 		return;
 
-	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
-						      pf->ice_debugfs_pf);
-	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
+	fwlog->debugfs = debugfs_create_dir("fwlog", root);
+	if (IS_ERR(fwlog->debugfs))
 		goto err_create_module_files;
 
-	fw_modules_dir = debugfs_create_dir("modules",
-					    pf->ice_debugfs_pf_fwlog);
+	fw_modules_dir = debugfs_create_dir("modules", fwlog->debugfs);
 	if (IS_ERR(fw_modules_dir))
 		goto err_create_module_files;
 
 	for (i = 0; i < ICE_NR_FW_LOG_MODULES; i++) {
 		fw_modules[i] = debugfs_create_file(ice_fwlog_module_string[i],
-						    0600, fw_modules_dir, pf,
+						    0600, fw_modules_dir, fwlog,
 						    &ice_debugfs_module_fops);
 		if (IS_ERR(fw_modules[i]))
 			goto err_create_module_files;
 	}
 
-	debugfs_create_file("nr_messages", 0600,
-			    pf->ice_debugfs_pf_fwlog, pf,
+	debugfs_create_file("nr_messages", 0600, fwlog->debugfs, fwlog,
 			    &ice_debugfs_nr_messages_fops);
 
-	pf->ice_debugfs_pf_fwlog_modules = fw_modules;
+	fwlog->debugfs_modules = fw_modules;
 
-	debugfs_create_file("enable", 0600, pf->ice_debugfs_pf_fwlog,
-			    pf, &ice_debugfs_enable_fops);
+	debugfs_create_file("enable", 0600, fwlog->debugfs, fwlog,
+			    &ice_debugfs_enable_fops);
 
-	debugfs_create_file("log_size", 0600, pf->ice_debugfs_pf_fwlog,
-			    pf, &ice_debugfs_log_size_fops);
+	debugfs_create_file("log_size", 0600, fwlog->debugfs, fwlog,
+			    &ice_debugfs_log_size_fops);
 
-	debugfs_create_file("data", 0600, pf->ice_debugfs_pf_fwlog,
-			    pf, &ice_debugfs_data_fops);
+	debugfs_create_file("data", 0600, fwlog->debugfs, fwlog,
+			    &ice_debugfs_data_fops);
 
 	return;
 
 err_create_module_files:
-	debugfs_remove_recursive(pf->ice_debugfs_pf_fwlog);
+	debugfs_remove_recursive(fwlog->debugfs);
 	kfree(fw_modules);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 634e3de3ae66..8a1fede98865 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -232,15 +232,13 @@ static void ice_fwlog_set_supported(struct ice_fwlog *fwlog)
 
 /**
  * ice_fwlog_init - Initialize FW logging configuration
- * @hw: pointer to the HW structure
  * @fwlog: pointer to the fwlog structure
  * @api: api structure to init fwlog
  *
  * This function should be called on driver initialization during
  * ice_init_hw().
  */
-int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
-		   struct ice_fwlog_api *api)
+int ice_fwlog_init(struct ice_fwlog *fwlog, struct ice_fwlog_api *api)
 {
 
 	fwlog->api = *api;
@@ -273,7 +271,7 @@ int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
 			return status;
 		}
 
-		ice_debugfs_fwlog_init(hw->back);
+		ice_debugfs_fwlog_init(fwlog, api->debugfs_root);
 	} else {
 		dev_warn(&fwlog->pdev->dev, "FW logging is not supported in this NVM image. Please update the NVM to get FW log support\n");
 	}
@@ -283,14 +281,12 @@ int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
 
 /**
  * ice_fwlog_deinit - unroll FW logging configuration
- * @hw: pointer to the HW structure
  * @fwlog: pointer to the fwlog structure
  *
  * This function should be called in ice_deinit_hw().
  */
-void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
+void ice_fwlog_deinit(struct ice_fwlog *fwlog)
 {
-	struct ice_pf *pf = hw->back;
 	int status;
 
 	/* make sure FW logging is disabled to not put the FW in a weird state
@@ -302,9 +298,9 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 		dev_warn(&fwlog->pdev->dev, "Unable to turn off FW logging, status: %d\n",
 			 status);
 
-	kfree(pf->ice_debugfs_pf_fwlog_modules);
+	kfree(fwlog->debugfs_modules);
 
-	pf->ice_debugfs_pf_fwlog_modules = NULL;
+	fwlog->debugfs_modules = NULL;
 
 	status = ice_fwlog_unregister(fwlog);
 	if (status)
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index fe4b2ce6813f..22585ea9ec93 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -68,18 +68,21 @@ struct ice_fwlog {
 	struct ice_fwlog_cfg cfg;
 	bool supported; /* does hardware support FW logging? */
 	struct ice_fwlog_ring ring;
+	struct dentry *debugfs;
+	/* keep track of all the dentrys for FW log modules */
+	struct dentry **debugfs_modules;
 	struct_group_tagged(ice_fwlog_api, api,
 		struct pci_dev *pdev;
 		int (*send_cmd)(void *, struct libie_aq_desc *, void *, u16);
 		void *priv;
+		struct dentry *debugfs_root;
 	);
 };
 
 bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
 void ice_fwlog_ring_increment(u16 *item, u16 size);
-int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
-		   struct ice_fwlog_api *api);
-void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog);
+int ice_fwlog_init(struct ice_fwlog *fwlog, struct ice_fwlog_api *api);
+void ice_fwlog_deinit(struct ice_fwlog *fwlog);
 int ice_fwlog_set(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_register(struct ice_fwlog *fwlog);
 int ice_fwlog_unregister(struct ice_fwlog *fwlog);
-- 
2.49.0


