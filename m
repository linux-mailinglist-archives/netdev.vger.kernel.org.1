Return-Path: <netdev+bounces-208890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0ACB0D7CB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26AF07A731D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29FC2E425C;
	Tue, 22 Jul 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXO7Owcc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140AF2DECC6
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182430; cv=none; b=EXBQCsruTOhSYEWEDEyKclIgyOsd9/nPrg366Ypzccd4R+ZXKu7Nu1XSfKJo+WDLQl7XIjjKcng4yGiblu8N6JEjyTMp3chgTbsFBGGsTc+R0Xm8FlzZ/8jbYiYDCbXjta/EEdL1huzTYyMZ2NfQpyPpBjSiOONcruPIVdudnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182430; c=relaxed/simple;
	bh=a4DVyQ2ZKjgg4V3riO5kyjID7KlRSJahiBK7W6tnirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqy/XQheOmtXc83q2OairevJvcYRIaKQNNLWi77Lj63syg3wmMnW06s+Qors+YHSniZVwx6EzDCjvM9k/DaDJMnmwf82WnFK17Br+frZDcTraLZhkpcGMgIXANyqJd/SewFHfwkSvN34WL0ELPhELrHn5vKNGwclugoGKxFnDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXO7Owcc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753182429; x=1784718429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4DVyQ2ZKjgg4V3riO5kyjID7KlRSJahiBK7W6tnirA=;
  b=PXO7OwccY1YGZtG8LPJisR16YA7JYztWxFB1whw9TSjEZbDNGl/7uOSX
   fetzRcpjQxWWdnDML9ws9iKrK2x70afgxwhPU/hcK01xGnV89+RHSGBEl
   GQppPl+u32DcN+JiVKKXyTOBOesSwlOstq+LcQb1bdTe+UvlpU745EZPh
   YFffpSe0TH0zCUyBM6GzFToeUckmNWlqL6BdXJvZO1NwWTyBZ17t5w6JZ
   9etQJ4frirLvu5sDkJDrHLW7hbeuq85GKilIrZ9bVy9j9Yf2hSzdJlXDM
   jiGebz0GeIylEgrfqIUXoLryOztMv5pcc9NR2/TrkoNde5BrPwJUxPYYA
   g==;
X-CSE-ConnectionGUID: vWSZ7pR0Sau6ShjUr3STZw==
X-CSE-MsgGUID: 8woZYEWZQH6Z+a6uE5Zzew==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59083608"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59083608"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:07:09 -0700
X-CSE-ConnectionGUID: T8UMvo2zRZG+E/7jIwtfcg==
X-CSE-MsgGUID: Wct0qq3iS0CdQJY82hkLJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163153959"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jul 2025 04:07:07 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 07/15] ice: move out debugfs init from fwlog
Date: Tue, 22 Jul 2025 12:45:52 +0200
Message-ID: <20250722104600.10141-8-michal.swiatkowski@linux.intel.com>
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

The root debugfs directory should be available from driver side, not
from library. Move it out from fwlog code.

Make similar to __fwlog_init() __fwlog_deinit() and deinit debugfs
there. In case of ice only fwlog is using debugfs.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c  | 14 ++++++++++++--
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 20 +++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_fwlog.c   |  2 --
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index a6803b344540..ee2ae0cbc25e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -909,6 +909,7 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
 }
 
 void ice_debugfs_fwlog_init(struct ice_pf *pf);
+int ice_debugfs_pf_init(struct ice_pf *pf);
 void ice_debugfs_pf_deinit(struct ice_pf *pf);
 void ice_debugfs_init(void);
 void ice_debugfs_exit(void);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7b4ff20f3346..9119d097eb08 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1000,6 +1000,11 @@ static int __fwlog_init(struct ice_hw *hw)
 		.send_cmd = __fwlog_send_cmd,
 		.priv = hw,
 	};
+	int err;
+
+	err = ice_debugfs_pf_init(pf);
+	if (err)
+		return err;
 
 	return ice_fwlog_init(hw, &hw->fwlog, &api);
 }
@@ -1179,6 +1184,12 @@ int ice_init_hw(struct ice_hw *hw)
 	return status;
 }
 
+static void __fwlog_deinit(struct ice_hw *hw)
+{
+	ice_debugfs_pf_deinit(hw->back);
+	ice_fwlog_deinit(hw, &hw->fwlog);
+}
+
 /**
  * ice_deinit_hw - unroll initialization operations done by ice_init_hw
  * @hw: pointer to the hardware structure
@@ -1197,8 +1208,7 @@ void ice_deinit_hw(struct ice_hw *hw)
 	ice_free_seg(hw);
 	ice_free_hw_tbls(hw);
 	mutex_destroy(&hw->tnl_lock);
-
-	ice_fwlog_deinit(hw, &hw->fwlog);
+	__fwlog_deinit(hw);
 	ice_destroy_all_ctrlq(hw);
 
 	/* Clear VSI contexts if not already cleared */
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 9235ae099e17..c7d9e92d7f56 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -584,7 +584,6 @@ static const struct file_operations ice_debugfs_data_fops = {
  */
 void ice_debugfs_fwlog_init(struct ice_pf *pf)
 {
-	const char *name = pci_name(pf->pdev);
 	struct dentry *fw_modules_dir;
 	struct dentry **fw_modules;
 	int i;
@@ -601,10 +600,6 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 	if (!fw_modules)
 		return;
 
-	pf->ice_debugfs_pf = debugfs_create_dir(name, ice_debugfs_root);
-	if (IS_ERR(pf->ice_debugfs_pf))
-		goto err_create_module_files;
-
 	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
 						      pf->ice_debugfs_pf);
 	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
@@ -645,6 +640,21 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 	kfree(fw_modules);
 }
 
+/**
+ * ice_debugfs_pf_init - create PF's debugfs
+ * @pf: pointer to the PF struct
+ */
+int ice_debugfs_pf_init(struct ice_pf *pf)
+{
+	const char *name = pci_name(pf->pdev);
+
+	pf->ice_debugfs_pf = debugfs_create_dir(name, ice_debugfs_root);
+	if (IS_ERR(pf->ice_debugfs_pf))
+		return PTR_ERR(pf->ice_debugfs_pf);
+
+	return 0;
+}
+
 /**
  * ice_debugfs_pf_deinit - cleanup PF's debugfs
  * @pf: pointer to the PF struct
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 172905187a3e..f7dbcb5e11aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -300,8 +300,6 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 	if (hw->bus.func)
 		return;
 
-	ice_debugfs_pf_deinit(hw->back);
-
 	/* make sure FW logging is disabled to not put the FW in a weird state
 	 * for the next driver load
 	 */
-- 
2.49.0


