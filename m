Return-Path: <netdev+bounces-222322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 465DDB53D7C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1C77B970E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BEA2DFA2D;
	Thu, 11 Sep 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atjk61gI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016D2DF13A
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624748; cv=none; b=J7Ph8nwTTxxMD+wcuhsWS2oBMdsnb681M9QDhv2ygM5uDulNQvb8IHGHP1c2ndGRS4yOyZkVCbAlOcCehNMe61zg6B13kIycW7taQc43FN1s9k7Y6zUC6ILQpYoBaUNuEhndDYc7MqFLwZd/QK0qBQrOmRERJYlnwobuoTazvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624748; c=relaxed/simple;
	bh=wr3E/w4wzNEZwzz9JfOI7VNQu+O+0lN9ShWBdrc7ENc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI2vieAbJcaHo1taS414lVlF9BjsL2s5VlpH/cmhPip/MfNYWwssIcYOdkdQOLJQv07grUi0HGpfvI2ozoR3BMocqLU/clcN7Gr5eLZO4HcRAhHNpFMBqEVBrBv2Ki4t5TvUSWRwH8IllUv0kTBSWTVkBkjREMRspmOPkKbsF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atjk61gI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624746; x=1789160746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wr3E/w4wzNEZwzz9JfOI7VNQu+O+0lN9ShWBdrc7ENc=;
  b=atjk61gIzduxhvgLviDtUIH09FWSpTnS1bLJsxDK0Nl0EAQHtrt/Ut+A
   wLpsdEmSeeRYNwCIVljZl2MphhmcoseyJyPY0a4xHIMBAscGlCdG8pimG
   7smPtyv68nPkEwaxkJni2c9IhSUlI9xM0wJXmvQ42Ap59dLRgxCOQbtbD
   PX4o+iKEd5Ug/BtOwJba+etiAvRaSpBn+8flD/gtENPsybh+U2BubHMIN
   4DcYVWYFl9jsxL1+Cyhy+kDPZC9Kmrphz+OFPZsNw2MCrWY+wD5YhhEI8
   wbH6YVDE309Ve60I2pAlcT1K/2RUS/Y2qfWvD1af0NBrSe0jh48siawlK
   w==;
X-CSE-ConnectionGUID: Ps5DhiKSRhyNKtItNAu1SQ==
X-CSE-MsgGUID: LoZdwvZjS/+sLxbUX4yImg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558942"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558942"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:46 -0700
X-CSE-ConnectionGUID: 97EcIVMlRX6i0UlxG/8xJw==
X-CSE-MsgGUID: mTlS40+xRoq00F1FOncZLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583419"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:44 -0700
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
	horms@kernel.org
Subject: [PATCH net-next 11/15] ice: move debugfs code to fwlog
Date: Thu, 11 Sep 2025 14:05:10 -0700
Message-ID: <20250911210525.345110-12-anthony.l.nguyen@intel.com>
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

This code is only used in fwlog. Moved it there for easier lib creation.
There is a circular dependency between debugfs and fwlog. Moving to one
file is fixing it.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 618 ------------------
 drivers/net/ethernet/intel/ice/ice_fwlog.c   | 652 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.h   |   3 -
 4 files changed, 635 insertions(+), 639 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 9ed4197ee7bc..d35eb6404524 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -905,7 +905,6 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
 	return false;
 }
 
-void ice_debugfs_fwlog_init(struct ice_fwlog *fwlog, struct dentry *root);
 int ice_debugfs_pf_init(struct ice_pf *pf);
 void ice_debugfs_pf_deinit(struct ice_pf *pf);
 void ice_debugfs_init(void);
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 6f7f6788447e..f450250fc827 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -1,629 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, Intel Corporation. */
 
-#include <linux/fs.h>
 #include <linux/debugfs.h>
-#include <linux/random.h>
-#include <linux/vmalloc.h>
 #include "ice.h"
 
 static struct dentry *ice_debugfs_root;
 
-/* create a define that has an extra module that doesn't really exist. this
- * is so we can add a module 'all' to easily enable/disable all the modules
- */
-#define ICE_NR_FW_LOG_MODULES (LIBIE_AQC_FW_LOG_ID_MAX + 1)
-
-/* the ordering in this array is important. it matches the ordering of the
- * values in the FW so the index is the same value as in
- * libie_aqc_fw_logging_mod
- */
-static const char * const ice_fwlog_module_string[] = {
-	"general",
-	"ctrl",
-	"link",
-	"link_topo",
-	"dnl",
-	"i2c",
-	"sdp",
-	"mdio",
-	"adminq",
-	"hdma",
-	"lldp",
-	"dcbx",
-	"dcb",
-	"xlr",
-	"nvm",
-	"auth",
-	"vpd",
-	"iosf",
-	"parser",
-	"sw",
-	"scheduler",
-	"txq",
-	"rsvd",
-	"post",
-	"watchdog",
-	"task_dispatch",
-	"mng",
-	"synce",
-	"health",
-	"tsdrv",
-	"pfreg",
-	"mdlver",
-	"all",
-};
-
-/* the ordering in this array is important. it matches the ordering of the
- * values in the FW so the index is the same value as in ice_fwlog_level
- */
-static const char * const ice_fwlog_level_string[] = {
-	"none",
-	"error",
-	"warning",
-	"normal",
-	"verbose",
-};
-
-static const char * const ice_fwlog_log_size[] = {
-	"128K",
-	"256K",
-	"512K",
-	"1M",
-	"2M",
-};
-
-/**
- * ice_fwlog_print_module_cfg - print current FW logging module configuration
- * @cfg: pointer to the fwlog cfg structure
- * @module: module to print
- * @s: the seq file to put data into
- */
-static void
-ice_fwlog_print_module_cfg(struct ice_fwlog_cfg *cfg, int module,
-			   struct seq_file *s)
-{
-	struct ice_fwlog_module_entry *entry;
-
-	if (module != LIBIE_AQC_FW_LOG_ID_MAX) {
-		entry =	&cfg->module_entries[module];
-
-		seq_printf(s, "\tModule: %s, Log Level: %s\n",
-			   ice_fwlog_module_string[entry->module_id],
-			   ice_fwlog_level_string[entry->log_level]);
-	} else {
-		int i;
-
-		for (i = 0; i < LIBIE_AQC_FW_LOG_ID_MAX; i++) {
-			entry =	&cfg->module_entries[i];
-
-			seq_printf(s, "\tModule: %s, Log Level: %s\n",
-				   ice_fwlog_module_string[entry->module_id],
-				   ice_fwlog_level_string[entry->log_level]);
-		}
-	}
-}
-
-static int ice_find_module_by_dentry(struct dentry **modules, struct dentry *d)
-{
-	int i, module;
-
-	module = -1;
-	/* find the module based on the dentry */
-	for (i = 0; i < ICE_NR_FW_LOG_MODULES; i++) {
-		if (d == modules[i]) {
-			module = i;
-			break;
-		}
-	}
-
-	return module;
-}
-
-/**
- * ice_debugfs_module_show - read from 'module' file
- * @s: the opened file
- * @v: pointer to the offset
- */
-static int ice_debugfs_module_show(struct seq_file *s, void *v)
-{
-	struct ice_fwlog *fwlog = s->private;
-	const struct file *filp = s->file;
-	struct dentry *dentry;
-	int module;
-
-	dentry = file_dentry(filp);
-
-	module = ice_find_module_by_dentry(fwlog->debugfs_modules, dentry);
-	if (module < 0) {
-		dev_info(&fwlog->pdev->dev, "unknown module\n");
-		return -EINVAL;
-	}
-
-	ice_fwlog_print_module_cfg(&fwlog->cfg, module, s);
-
-	return 0;
-}
-
-static int ice_debugfs_module_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ice_debugfs_module_show, inode->i_private);
-}
-
-/**
- * ice_debugfs_module_write - write into 'module' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
- */
-static ssize_t
-ice_debugfs_module_write(struct file *filp, const char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = file_inode(filp)->i_private;
-	struct dentry *dentry = file_dentry(filp);
-	struct device *dev = &fwlog->pdev->dev;
-	char user_val[16], *cmd_buf;
-	int module, log_level, cnt;
-
-	/* don't allow partial writes or invalid input */
-	if (*ppos != 0 || count > 8)
-		return -EINVAL;
-
-	cmd_buf = memdup_user_nul(buf, count);
-	if (IS_ERR(cmd_buf))
-		return PTR_ERR(cmd_buf);
-
-	module = ice_find_module_by_dentry(fwlog->debugfs_modules, dentry);
-	if (module < 0) {
-		dev_info(dev, "unknown module\n");
-		return -EINVAL;
-	}
-
-	cnt = sscanf(cmd_buf, "%s", user_val);
-	if (cnt != 1)
-		return -EINVAL;
-
-	log_level = sysfs_match_string(ice_fwlog_level_string, user_val);
-	if (log_level < 0) {
-		dev_info(dev, "unknown log level '%s'\n", user_val);
-		return -EINVAL;
-	}
-
-	if (module != LIBIE_AQC_FW_LOG_ID_MAX) {
-		fwlog->cfg.module_entries[module].log_level = log_level;
-	} else {
-		/* the module 'all' is a shortcut so that we can set
-		 * all of the modules to the same level quickly
-		 */
-		int i;
-
-		for (i = 0; i < LIBIE_AQC_FW_LOG_ID_MAX; i++)
-			fwlog->cfg.module_entries[i].log_level = log_level;
-	}
-
-	return count;
-}
-
-static const struct file_operations ice_debugfs_module_fops = {
-	.owner = THIS_MODULE,
-	.open  = ice_debugfs_module_open,
-	.read = seq_read,
-	.release = single_release,
-	.write = ice_debugfs_module_write,
-};
-
-/**
- * ice_debugfs_nr_messages_read - read from 'nr_messages' file
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- */
-static ssize_t ice_debugfs_nr_messages_read(struct file *filp,
-					    char __user *buffer, size_t count,
-					    loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = filp->private_data;
-	char buff[32] = {};
-
-	snprintf(buff, sizeof(buff), "%d\n",
-		 fwlog->cfg.log_resolution);
-
-	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
-}
-
-/**
- * ice_debugfs_nr_messages_write - write into 'nr_messages' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
- */
-static ssize_t
-ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
-			      size_t count, loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = filp->private_data;
-	struct device *dev = &fwlog->pdev->dev;
-	char user_val[8], *cmd_buf;
-	s16 nr_messages;
-	ssize_t ret;
-
-	/* don't allow partial writes or invalid input */
-	if (*ppos != 0 || count > 4)
-		return -EINVAL;
-
-	cmd_buf = memdup_user_nul(buf, count);
-	if (IS_ERR(cmd_buf))
-		return PTR_ERR(cmd_buf);
-
-	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
-
-	ret = kstrtos16(user_val, 0, &nr_messages);
-	if (ret)
-		return ret;
-
-	if (nr_messages < LIBIE_AQC_FW_LOG_MIN_RESOLUTION ||
-	    nr_messages > LIBIE_AQC_FW_LOG_MAX_RESOLUTION) {
-		dev_err(dev, "Invalid FW log number of messages %d, value must be between %d - %d\n",
-			nr_messages, LIBIE_AQC_FW_LOG_MIN_RESOLUTION,
-			LIBIE_AQC_FW_LOG_MAX_RESOLUTION);
-		return -EINVAL;
-	}
-
-	fwlog->cfg.log_resolution = nr_messages;
-
-	return count;
-}
-
-static const struct file_operations ice_debugfs_nr_messages_fops = {
-	.owner = THIS_MODULE,
-	.open  = simple_open,
-	.read = ice_debugfs_nr_messages_read,
-	.write = ice_debugfs_nr_messages_write,
-};
-
-/**
- * ice_debugfs_enable_read - read from 'enable' file
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- */
-static ssize_t ice_debugfs_enable_read(struct file *filp,
-				       char __user *buffer, size_t count,
-				       loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = filp->private_data;
-	char buff[32] = {};
-
-	snprintf(buff, sizeof(buff), "%u\n",
-		 (u16)(fwlog->cfg.options &
-		 ICE_FWLOG_OPTION_IS_REGISTERED) >> 3);
-
-	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
-}
-
-/**
- * ice_debugfs_enable_write - write into 'enable' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
- */
-static ssize_t
-ice_debugfs_enable_write(struct file *filp, const char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = filp->private_data;
-	char user_val[8], *cmd_buf;
-	bool enable;
-	ssize_t ret;
-
-	/* don't allow partial writes or invalid input */
-	if (*ppos != 0 || count > 2)
-		return -EINVAL;
-
-	cmd_buf = memdup_user_nul(buf, count);
-	if (IS_ERR(cmd_buf))
-		return PTR_ERR(cmd_buf);
-
-	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
-
-	ret = kstrtobool(user_val, &enable);
-	if (ret)
-		goto enable_write_error;
-
-	if (enable)
-		fwlog->cfg.options |= ICE_FWLOG_OPTION_ARQ_ENA;
-	else
-		fwlog->cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
-
-	ret = ice_fwlog_set(fwlog, &fwlog->cfg);
-	if (ret)
-		goto enable_write_error;
-
-	if (enable)
-		ret = ice_fwlog_register(fwlog);
-	else
-		ret = ice_fwlog_unregister(fwlog);
-
-	if (ret)
-		goto enable_write_error;
-
-	/* if we get here, nothing went wrong; return count since we didn't
-	 * really write anything
-	 */
-	ret = (ssize_t)count;
-
-enable_write_error:
-	/* This function always consumes all of the written input, or produces
-	 * an error. Check and enforce this. Otherwise, the write operation
-	 * won't complete properly.
-	 */
-	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
-		ret = -EIO;
-
-	return ret;
-}
-
-static const struct file_operations ice_debugfs_enable_fops = {
-	.owner = THIS_MODULE,
-	.open  = simple_open,
-	.read = ice_debugfs_enable_read,
-	.write = ice_debugfs_enable_write,
-};
-
-/**
- * ice_debugfs_log_size_read - read from 'log_size' file
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- */
-static ssize_t ice_debugfs_log_size_read(struct file *filp,
-					 char __user *buffer, size_t count,
-					 loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = filp->private_data;
-	char buff[32] = {};
-	int index;
-
-	index = fwlog->ring.index;
-	snprintf(buff, sizeof(buff), "%s\n", ice_fwlog_log_size[index]);
-
-	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
-}
-
-/**
- * ice_debugfs_log_size_write - write into 'log_size' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
- */
-static ssize_t
-ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
-			   size_t count, loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = filp->private_data;
-	struct device *dev = &fwlog->pdev->dev;
-	char user_val[8], *cmd_buf;
-	ssize_t ret;
-	int index;
-
-	/* don't allow partial writes or invalid input */
-	if (*ppos != 0 || count > 5)
-		return -EINVAL;
-
-	cmd_buf = memdup_user_nul(buf, count);
-	if (IS_ERR(cmd_buf))
-		return PTR_ERR(cmd_buf);
-
-	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
-
-	index = sysfs_match_string(ice_fwlog_log_size, user_val);
-	if (index < 0) {
-		dev_info(dev, "Invalid log size '%s'. The value must be one of 128K, 256K, 512K, 1M, 2M\n",
-			 user_val);
-		ret = -EINVAL;
-		goto log_size_write_error;
-	} else if (fwlog->cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
-		dev_info(dev, "FW logging is currently running. Please disable FW logging to change log_size\n");
-		ret = -EINVAL;
-		goto log_size_write_error;
-	}
-
-	/* free all the buffers and the tracking info and resize */
-	ice_fwlog_realloc_rings(fwlog, index);
-
-	/* if we get here, nothing went wrong; return count since we didn't
-	 * really write anything
-	 */
-	ret = (ssize_t)count;
-
-log_size_write_error:
-	/* This function always consumes all of the written input, or produces
-	 * an error. Check and enforce this. Otherwise, the write operation
-	 * won't complete properly.
-	 */
-	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
-		ret = -EIO;
-
-	return ret;
-}
-
-static const struct file_operations ice_debugfs_log_size_fops = {
-	.owner = THIS_MODULE,
-	.open  = simple_open,
-	.read = ice_debugfs_log_size_read,
-	.write = ice_debugfs_log_size_write,
-};
-
-/**
- * ice_debugfs_data_read - read from 'data' file
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- */
-static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
-				     size_t count, loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = filp->private_data;
-	int data_copied = 0;
-	bool done = false;
-
-	if (ice_fwlog_ring_empty(&fwlog->ring))
-		return 0;
-
-	while (!ice_fwlog_ring_empty(&fwlog->ring) && !done) {
-		struct ice_fwlog_data *log;
-		u16 cur_buf_len;
-
-		log = &fwlog->ring.rings[fwlog->ring.head];
-		cur_buf_len = log->data_size;
-		if (cur_buf_len >= count) {
-			done = true;
-			continue;
-		}
-
-		if (copy_to_user(buffer, log->data, cur_buf_len)) {
-			/* if there is an error then bail and return whatever
-			 * the driver has copied so far
-			 */
-			done = true;
-			continue;
-		}
-
-		data_copied += cur_buf_len;
-		buffer += cur_buf_len;
-		count -= cur_buf_len;
-		*ppos += cur_buf_len;
-		ice_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
-	}
-
-	return data_copied;
-}
-
-/**
- * ice_debugfs_data_write - write into 'data' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
- */
-static ssize_t
-ice_debugfs_data_write(struct file *filp, const char __user *buf, size_t count,
-		       loff_t *ppos)
-{
-	struct ice_fwlog *fwlog = filp->private_data;
-	struct device *dev = &fwlog->pdev->dev;
-	ssize_t ret;
-
-	/* don't allow partial writes */
-	if (*ppos != 0)
-		return 0;
-
-	/* any value is allowed to clear the buffer so no need to even look at
-	 * what the value is
-	 */
-	if (!(fwlog->cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED)) {
-		fwlog->ring.head = 0;
-		fwlog->ring.tail = 0;
-	} else {
-		dev_info(dev, "Can't clear FW log data while FW log running\n");
-		ret = -EINVAL;
-		goto nr_buffs_write_error;
-	}
-
-	/* if we get here, nothing went wrong; return count since we didn't
-	 * really write anything
-	 */
-	ret = (ssize_t)count;
-
-nr_buffs_write_error:
-	/* This function always consumes all of the written input, or produces
-	 * an error. Check and enforce this. Otherwise, the write operation
-	 * won't complete properly.
-	 */
-	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
-		ret = -EIO;
-
-	return ret;
-}
-
-static const struct file_operations ice_debugfs_data_fops = {
-	.owner = THIS_MODULE,
-	.open  = simple_open,
-	.read = ice_debugfs_data_read,
-	.write = ice_debugfs_data_write,
-};
-
-/**
- * ice_debugfs_fwlog_init - setup the debugfs directory
- * @fwlog: pointer to the fwlog structure
- * @root: debugfs root entry on which fwlog director will be registered
- */
-void ice_debugfs_fwlog_init(struct ice_fwlog *fwlog, struct dentry *root)
-{
-	struct dentry *fw_modules_dir;
-	struct dentry **fw_modules;
-	int i;
-
-	/* allocate space for this first because if it fails then we don't
-	 * need to unwind
-	 */
-	fw_modules = kcalloc(ICE_NR_FW_LOG_MODULES, sizeof(*fw_modules),
-			     GFP_KERNEL);
-	if (!fw_modules)
-		return;
-
-	fwlog->debugfs = debugfs_create_dir("fwlog", root);
-	if (IS_ERR(fwlog->debugfs))
-		goto err_create_module_files;
-
-	fw_modules_dir = debugfs_create_dir("modules", fwlog->debugfs);
-	if (IS_ERR(fw_modules_dir))
-		goto err_create_module_files;
-
-	for (i = 0; i < ICE_NR_FW_LOG_MODULES; i++) {
-		fw_modules[i] = debugfs_create_file(ice_fwlog_module_string[i],
-						    0600, fw_modules_dir, fwlog,
-						    &ice_debugfs_module_fops);
-		if (IS_ERR(fw_modules[i]))
-			goto err_create_module_files;
-	}
-
-	debugfs_create_file("nr_messages", 0600, fwlog->debugfs, fwlog,
-			    &ice_debugfs_nr_messages_fops);
-
-	fwlog->debugfs_modules = fw_modules;
-
-	debugfs_create_file("enable", 0600, fwlog->debugfs, fwlog,
-			    &ice_debugfs_enable_fops);
-
-	debugfs_create_file("log_size", 0600, fwlog->debugfs, fwlog,
-			    &ice_debugfs_log_size_fops);
-
-	debugfs_create_file("data", 0600, fwlog->debugfs, fwlog,
-			    &ice_debugfs_data_fops);
-
-	return;
-
-err_create_module_files:
-	debugfs_remove_recursive(fwlog->debugfs);
-	kfree(fw_modules);
-}
-
 int ice_debugfs_pf_init(struct ice_pf *pf)
 {
 	const char *name = pci_name(pf->pdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 30175be484a5..036c595cf92b 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -1,32 +1,84 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, Intel Corporation. */
 
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/random.h>
 #include <linux/vmalloc.h>
 #include "ice.h"
 #include "ice_common.h"
 #include "ice_fwlog.h"
 
-static bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
-{
-	u16 head, tail;
-
-	head = rings->head;
-	tail = rings->tail;
-
-	if (head < tail && (tail - head == (rings->size - 1)))
-		return true;
-	else if (head > tail && (tail == (head - 1)))
-		return true;
-
-	return false;
-}
+/* create a define that has an extra module that doesn't really exist. this
+ * is so we can add a module 'all' to easily enable/disable all the modules
+ */
+#define ICE_NR_FW_LOG_MODULES (LIBIE_AQC_FW_LOG_ID_MAX + 1)
 
-bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings)
+/* the ordering in this array is important. it matches the ordering of the
+ * values in the FW so the index is the same value as in
+ * libie_aqc_fw_logging_mod
+ */
+static const char * const ice_fwlog_module_string[] = {
+	"general",
+	"ctrl",
+	"link",
+	"link_topo",
+	"dnl",
+	"i2c",
+	"sdp",
+	"mdio",
+	"adminq",
+	"hdma",
+	"lldp",
+	"dcbx",
+	"dcb",
+	"xlr",
+	"nvm",
+	"auth",
+	"vpd",
+	"iosf",
+	"parser",
+	"sw",
+	"scheduler",
+	"txq",
+	"rsvd",
+	"post",
+	"watchdog",
+	"task_dispatch",
+	"mng",
+	"synce",
+	"health",
+	"tsdrv",
+	"pfreg",
+	"mdlver",
+	"all",
+};
+
+/* the ordering in this array is important. it matches the ordering of the
+ * values in the FW so the index is the same value as in ice_fwlog_level
+ */
+static const char * const ice_fwlog_level_string[] = {
+	"none",
+	"error",
+	"warning",
+	"normal",
+	"verbose",
+};
+
+static const char * const ice_fwlog_log_size[] = {
+	"128K",
+	"256K",
+	"512K",
+	"1M",
+	"2M",
+};
+
+static bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings)
 {
 	return rings->head == rings->tail;
 }
 
-void ice_fwlog_ring_increment(u16 *item, u16 size)
+static void ice_fwlog_ring_increment(u16 *item, u16 size)
 {
 	*item = (*item + 1) & (size - 1);
 }
@@ -77,7 +129,7 @@ static void ice_fwlog_free_ring_buffs(struct ice_fwlog_ring *rings)
  * @index: the new index to use to allocate memory for the log data
  *
  */
-void ice_fwlog_realloc_rings(struct ice_fwlog *fwlog, int index)
+static void ice_fwlog_realloc_rings(struct ice_fwlog *fwlog, int index)
 {
 	struct ice_fwlog_ring ring;
 	int status, ring_size;
@@ -123,6 +175,572 @@ void ice_fwlog_realloc_rings(struct ice_fwlog *fwlog, int index)
 	fwlog->ring.tail = 0;
 }
 
+/**
+ * ice_fwlog_print_module_cfg - print current FW logging module configuration
+ * @cfg: pointer to the fwlog cfg structure
+ * @module: module to print
+ * @s: the seq file to put data into
+ */
+static void
+ice_fwlog_print_module_cfg(struct ice_fwlog_cfg *cfg, int module,
+			   struct seq_file *s)
+{
+	struct ice_fwlog_module_entry *entry;
+
+	if (module != LIBIE_AQC_FW_LOG_ID_MAX) {
+		entry =	&cfg->module_entries[module];
+
+		seq_printf(s, "\tModule: %s, Log Level: %s\n",
+			   ice_fwlog_module_string[entry->module_id],
+			   ice_fwlog_level_string[entry->log_level]);
+	} else {
+		int i;
+
+		for (i = 0; i < LIBIE_AQC_FW_LOG_ID_MAX; i++) {
+			entry =	&cfg->module_entries[i];
+
+			seq_printf(s, "\tModule: %s, Log Level: %s\n",
+				   ice_fwlog_module_string[entry->module_id],
+				   ice_fwlog_level_string[entry->log_level]);
+		}
+	}
+}
+
+static int ice_find_module_by_dentry(struct dentry **modules, struct dentry *d)
+{
+	int i, module;
+
+	module = -1;
+	/* find the module based on the dentry */
+	for (i = 0; i < ICE_NR_FW_LOG_MODULES; i++) {
+		if (d == modules[i]) {
+			module = i;
+			break;
+		}
+	}
+
+	return module;
+}
+
+/**
+ * ice_debugfs_module_show - read from 'module' file
+ * @s: the opened file
+ * @v: pointer to the offset
+ */
+static int ice_debugfs_module_show(struct seq_file *s, void *v)
+{
+	struct ice_fwlog *fwlog = s->private;
+	const struct file *filp = s->file;
+	struct dentry *dentry;
+	int module;
+
+	dentry = file_dentry(filp);
+
+	module = ice_find_module_by_dentry(fwlog->debugfs_modules, dentry);
+	if (module < 0) {
+		dev_info(&fwlog->pdev->dev, "unknown module\n");
+		return -EINVAL;
+	}
+
+	ice_fwlog_print_module_cfg(&fwlog->cfg, module, s);
+
+	return 0;
+}
+
+static int ice_debugfs_module_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, ice_debugfs_module_show, inode->i_private);
+}
+
+/**
+ * ice_debugfs_module_write - write into 'module' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_module_write(struct file *filp, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = file_inode(filp)->i_private;
+	struct dentry *dentry = file_dentry(filp);
+	struct device *dev = &fwlog->pdev->dev;
+	char user_val[16], *cmd_buf;
+	int module, log_level, cnt;
+
+	/* don't allow partial writes or invalid input */
+	if (*ppos != 0 || count > 8)
+		return -EINVAL;
+
+	cmd_buf = memdup_user_nul(buf, count);
+	if (IS_ERR(cmd_buf))
+		return PTR_ERR(cmd_buf);
+
+	module = ice_find_module_by_dentry(fwlog->debugfs_modules, dentry);
+	if (module < 0) {
+		dev_info(dev, "unknown module\n");
+		return -EINVAL;
+	}
+
+	cnt = sscanf(cmd_buf, "%s", user_val);
+	if (cnt != 1)
+		return -EINVAL;
+
+	log_level = sysfs_match_string(ice_fwlog_level_string, user_val);
+	if (log_level < 0) {
+		dev_info(dev, "unknown log level '%s'\n", user_val);
+		return -EINVAL;
+	}
+
+	if (module != LIBIE_AQC_FW_LOG_ID_MAX) {
+		fwlog->cfg.module_entries[module].log_level = log_level;
+	} else {
+		/* the module 'all' is a shortcut so that we can set
+		 * all of the modules to the same level quickly
+		 */
+		int i;
+
+		for (i = 0; i < LIBIE_AQC_FW_LOG_ID_MAX; i++)
+			fwlog->cfg.module_entries[i].log_level = log_level;
+	}
+
+	return count;
+}
+
+static const struct file_operations ice_debugfs_module_fops = {
+	.owner = THIS_MODULE,
+	.open  = ice_debugfs_module_open,
+	.read = seq_read,
+	.release = single_release,
+	.write = ice_debugfs_module_write,
+};
+
+/**
+ * ice_debugfs_nr_messages_read - read from 'nr_messages' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_nr_messages_read(struct file *filp,
+					    char __user *buffer, size_t count,
+					    loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = filp->private_data;
+	char buff[32] = {};
+
+	snprintf(buff, sizeof(buff), "%d\n",
+		 fwlog->cfg.log_resolution);
+
+	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
+}
+
+/**
+ * ice_debugfs_nr_messages_write - write into 'nr_messages' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = filp->private_data;
+	struct device *dev = &fwlog->pdev->dev;
+	char user_val[8], *cmd_buf;
+	s16 nr_messages;
+	ssize_t ret;
+
+	/* don't allow partial writes or invalid input */
+	if (*ppos != 0 || count > 4)
+		return -EINVAL;
+
+	cmd_buf = memdup_user_nul(buf, count);
+	if (IS_ERR(cmd_buf))
+		return PTR_ERR(cmd_buf);
+
+	ret = sscanf(cmd_buf, "%s", user_val);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = kstrtos16(user_val, 0, &nr_messages);
+	if (ret)
+		return ret;
+
+	if (nr_messages < LIBIE_AQC_FW_LOG_MIN_RESOLUTION ||
+	    nr_messages > LIBIE_AQC_FW_LOG_MAX_RESOLUTION) {
+		dev_err(dev, "Invalid FW log number of messages %d, value must be between %d - %d\n",
+			nr_messages, LIBIE_AQC_FW_LOG_MIN_RESOLUTION,
+			LIBIE_AQC_FW_LOG_MAX_RESOLUTION);
+		return -EINVAL;
+	}
+
+	fwlog->cfg.log_resolution = nr_messages;
+
+	return count;
+}
+
+static const struct file_operations ice_debugfs_nr_messages_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_nr_messages_read,
+	.write = ice_debugfs_nr_messages_write,
+};
+
+/**
+ * ice_debugfs_enable_read - read from 'enable' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_enable_read(struct file *filp,
+				       char __user *buffer, size_t count,
+				       loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = filp->private_data;
+	char buff[32] = {};
+
+	snprintf(buff, sizeof(buff), "%u\n",
+		 (u16)(fwlog->cfg.options &
+		 ICE_FWLOG_OPTION_IS_REGISTERED) >> 3);
+
+	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
+}
+
+/**
+ * ice_debugfs_enable_write - write into 'enable' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_enable_write(struct file *filp, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = filp->private_data;
+	char user_val[8], *cmd_buf;
+	bool enable;
+	ssize_t ret;
+
+	/* don't allow partial writes or invalid input */
+	if (*ppos != 0 || count > 2)
+		return -EINVAL;
+
+	cmd_buf = memdup_user_nul(buf, count);
+	if (IS_ERR(cmd_buf))
+		return PTR_ERR(cmd_buf);
+
+	ret = sscanf(cmd_buf, "%s", user_val);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = kstrtobool(user_val, &enable);
+	if (ret)
+		goto enable_write_error;
+
+	if (enable)
+		fwlog->cfg.options |= ICE_FWLOG_OPTION_ARQ_ENA;
+	else
+		fwlog->cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
+
+	ret = ice_fwlog_set(fwlog, &fwlog->cfg);
+	if (ret)
+		goto enable_write_error;
+
+	if (enable)
+		ret = ice_fwlog_register(fwlog);
+	else
+		ret = ice_fwlog_unregister(fwlog);
+
+	if (ret)
+		goto enable_write_error;
+
+	/* if we get here, nothing went wrong; return count since we didn't
+	 * really write anything
+	 */
+	ret = (ssize_t)count;
+
+enable_write_error:
+	/* This function always consumes all of the written input, or produces
+	 * an error. Check and enforce this. Otherwise, the write operation
+	 * won't complete properly.
+	 */
+	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
+		ret = -EIO;
+
+	return ret;
+}
+
+static const struct file_operations ice_debugfs_enable_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_enable_read,
+	.write = ice_debugfs_enable_write,
+};
+
+/**
+ * ice_debugfs_log_size_read - read from 'log_size' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_log_size_read(struct file *filp,
+					 char __user *buffer, size_t count,
+					 loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = filp->private_data;
+	char buff[32] = {};
+	int index;
+
+	index = fwlog->ring.index;
+	snprintf(buff, sizeof(buff), "%s\n", ice_fwlog_log_size[index]);
+
+	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
+}
+
+/**
+ * ice_debugfs_log_size_write - write into 'log_size' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
+			   size_t count, loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = filp->private_data;
+	struct device *dev = &fwlog->pdev->dev;
+	char user_val[8], *cmd_buf;
+	ssize_t ret;
+	int index;
+
+	/* don't allow partial writes or invalid input */
+	if (*ppos != 0 || count > 5)
+		return -EINVAL;
+
+	cmd_buf = memdup_user_nul(buf, count);
+	if (IS_ERR(cmd_buf))
+		return PTR_ERR(cmd_buf);
+
+	ret = sscanf(cmd_buf, "%s", user_val);
+	if (ret != 1)
+		return -EINVAL;
+
+	index = sysfs_match_string(ice_fwlog_log_size, user_val);
+	if (index < 0) {
+		dev_info(dev, "Invalid log size '%s'. The value must be one of 128K, 256K, 512K, 1M, 2M\n",
+			 user_val);
+		ret = -EINVAL;
+		goto log_size_write_error;
+	} else if (fwlog->cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
+		dev_info(dev, "FW logging is currently running. Please disable FW logging to change log_size\n");
+		ret = -EINVAL;
+		goto log_size_write_error;
+	}
+
+	/* free all the buffers and the tracking info and resize */
+	ice_fwlog_realloc_rings(fwlog, index);
+
+	/* if we get here, nothing went wrong; return count since we didn't
+	 * really write anything
+	 */
+	ret = (ssize_t)count;
+
+log_size_write_error:
+	/* This function always consumes all of the written input, or produces
+	 * an error. Check and enforce this. Otherwise, the write operation
+	 * won't complete properly.
+	 */
+	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
+		ret = -EIO;
+
+	return ret;
+}
+
+static const struct file_operations ice_debugfs_log_size_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_log_size_read,
+	.write = ice_debugfs_log_size_write,
+};
+
+/**
+ * ice_debugfs_data_read - read from 'data' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
+				     size_t count, loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = filp->private_data;
+	int data_copied = 0;
+	bool done = false;
+
+	if (ice_fwlog_ring_empty(&fwlog->ring))
+		return 0;
+
+	while (!ice_fwlog_ring_empty(&fwlog->ring) && !done) {
+		struct ice_fwlog_data *log;
+		u16 cur_buf_len;
+
+		log = &fwlog->ring.rings[fwlog->ring.head];
+		cur_buf_len = log->data_size;
+		if (cur_buf_len >= count) {
+			done = true;
+			continue;
+		}
+
+		if (copy_to_user(buffer, log->data, cur_buf_len)) {
+			/* if there is an error then bail and return whatever
+			 * the driver has copied so far
+			 */
+			done = true;
+			continue;
+		}
+
+		data_copied += cur_buf_len;
+		buffer += cur_buf_len;
+		count -= cur_buf_len;
+		*ppos += cur_buf_len;
+		ice_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
+	}
+
+	return data_copied;
+}
+
+/**
+ * ice_debugfs_data_write - write into 'data' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_data_write(struct file *filp, const char __user *buf, size_t count,
+		       loff_t *ppos)
+{
+	struct ice_fwlog *fwlog = filp->private_data;
+	struct device *dev = &fwlog->pdev->dev;
+	ssize_t ret;
+
+	/* don't allow partial writes */
+	if (*ppos != 0)
+		return 0;
+
+	/* any value is allowed to clear the buffer so no need to even look at
+	 * what the value is
+	 */
+	if (!(fwlog->cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED)) {
+		fwlog->ring.head = 0;
+		fwlog->ring.tail = 0;
+	} else {
+		dev_info(dev, "Can't clear FW log data while FW log running\n");
+		ret = -EINVAL;
+		goto nr_buffs_write_error;
+	}
+
+	/* if we get here, nothing went wrong; return count since we didn't
+	 * really write anything
+	 */
+	ret = (ssize_t)count;
+
+nr_buffs_write_error:
+	/* This function always consumes all of the written input, or produces
+	 * an error. Check and enforce this. Otherwise, the write operation
+	 * won't complete properly.
+	 */
+	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
+		ret = -EIO;
+
+	return ret;
+}
+
+static const struct file_operations ice_debugfs_data_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_data_read,
+	.write = ice_debugfs_data_write,
+};
+
+/**
+ * ice_debugfs_fwlog_init - setup the debugfs directory
+ * @fwlog: pointer to the fwlog structure
+ * @root: debugfs root entry on which fwlog director will be registered
+ */
+static void ice_debugfs_fwlog_init(struct ice_fwlog *fwlog, struct dentry *root)
+{
+	struct dentry *fw_modules_dir;
+	struct dentry **fw_modules;
+	int i;
+
+	/* allocate space for this first because if it fails then we don't
+	 * need to unwind
+	 */
+	fw_modules = kcalloc(ICE_NR_FW_LOG_MODULES, sizeof(*fw_modules),
+			     GFP_KERNEL);
+	if (!fw_modules)
+		return;
+
+	fwlog->debugfs = debugfs_create_dir("fwlog", root);
+	if (IS_ERR(fwlog->debugfs))
+		goto err_create_module_files;
+
+	fw_modules_dir = debugfs_create_dir("modules", fwlog->debugfs);
+	if (IS_ERR(fw_modules_dir))
+		goto err_create_module_files;
+
+	for (i = 0; i < ICE_NR_FW_LOG_MODULES; i++) {
+		fw_modules[i] = debugfs_create_file(ice_fwlog_module_string[i],
+						    0600, fw_modules_dir, fwlog,
+						    &ice_debugfs_module_fops);
+		if (IS_ERR(fw_modules[i]))
+			goto err_create_module_files;
+	}
+
+	debugfs_create_file("nr_messages", 0600, fwlog->debugfs, fwlog,
+			    &ice_debugfs_nr_messages_fops);
+
+	fwlog->debugfs_modules = fw_modules;
+
+	debugfs_create_file("enable", 0600, fwlog->debugfs, fwlog,
+			    &ice_debugfs_enable_fops);
+
+	debugfs_create_file("log_size", 0600, fwlog->debugfs, fwlog,
+			    &ice_debugfs_log_size_fops);
+
+	debugfs_create_file("data", 0600, fwlog->debugfs, fwlog,
+			    &ice_debugfs_data_fops);
+
+	return;
+
+err_create_module_files:
+	debugfs_remove_recursive(fwlog->debugfs);
+	kfree(fw_modules);
+}
+
+static bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
+{
+	u16 head, tail;
+
+	head = rings->head;
+	tail = rings->tail;
+
+	if (head < tail && (tail - head == (rings->size - 1)))
+		return true;
+	else if (head > tail && (tail == (head - 1)))
+		return true;
+
+	return false;
+}
+
 /**
  * ice_fwlog_supported - Cached for whether FW supports FW logging or not
  * @fwlog: pointer to the fwlog structure
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 9efa4a83c957..d5868b9e4de6 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -79,13 +79,10 @@ struct ice_fwlog {
 	);
 };
 
-bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
-void ice_fwlog_ring_increment(u16 *item, u16 size);
 int ice_fwlog_init(struct ice_fwlog *fwlog, struct ice_fwlog_api *api);
 void ice_fwlog_deinit(struct ice_fwlog *fwlog);
 int ice_fwlog_set(struct ice_fwlog *fwlog, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_register(struct ice_fwlog *fwlog);
 int ice_fwlog_unregister(struct ice_fwlog *fwlog);
-void ice_fwlog_realloc_rings(struct ice_fwlog *fwlog, int index);
 void ice_get_fwlog_data(struct ice_fwlog *fwlog, u8 *buf, u16 len);
 #endif /* _ICE_FWLOG_H_ */
-- 
2.47.1


