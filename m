Return-Path: <netdev+bounces-222318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6CB53D77
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB6F7B8B14
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B12DECA5;
	Thu, 11 Sep 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXmYpD8K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D622DE709
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624744; cv=none; b=TvU1/UZJbMApEVMi7sW3WBsfFMDvU6OOKrqJ1x2pT1bKLFwBxa+e84jIsgQn7ddGSd6cpB4YgyaaihEFTY2bEPic7yezg4x6uVr4dsKwMaEL7a8BQafmtPIysVpvu85TYwj/Um/wLSyVgMS0O4VZ883rDSPI/taxvkUuakthPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624744; c=relaxed/simple;
	bh=rqmYJ0YIPhfJRWUa/bPEiZv0cq7UAwBaSwS4LKc9eKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd+pimXpW2+DaGTdawmO7pqjL/zxcRwRaqjWriEn95RT/jrPr7rvKj2fFpj3QHzmUPzi8tM0GiyLqfuUQXJw1SD2Emt6ldtt8MF4FzBnnPqPOepXLly7zw/imeys3SPKoZDzRWNwJO7u4K/eY9MqHw2zP/ImzrWj+iQYo66acuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXmYpD8K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624744; x=1789160744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rqmYJ0YIPhfJRWUa/bPEiZv0cq7UAwBaSwS4LKc9eKI=;
  b=CXmYpD8KiHyQc1c+zSi6yKy0jprcxoQpmlPpT44iuQguTC0ji2q0BKK6
   H5PR4Y49DUnTgrm5J+eGW3ICIk8pMra4vL4UMzcjsczC+olHqnjkhcVxj
   024mY0nQuO68AM6InSr5665TrkplRhkQ4jZ0MuWxu+4MfKG+RRGw7eumR
   mY6J+SaZ/rIvgJK5EaxZvHkWsm7LH5nmggM7bl94QC2vebSmG/3hkendr
   czjITEJMkKkEMAfJLlS/aHrDn95QQguXXvbWVK/BFws4YPpYhVDBKBEBS
   utjcom35lCFlHzZZG0ajj1UkbCYCGhh0DciYkrPOlnYl2V71lf1RydQyx
   A==;
X-CSE-ConnectionGUID: QzSWRQG1QH2zwn1cjYpcbQ==
X-CSE-MsgGUID: WofzIX/GQmW2+e+xn/XElQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558904"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558904"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:41 -0700
X-CSE-ConnectionGUID: eBIzMeRPTJG4xnm/EUN1Zw==
X-CSE-MsgGUID: o/N1gW9+R0GPqxigtaaFYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583364"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:40 -0700
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
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 07/15] ice: move out debugfs init from fwlog
Date: Thu, 11 Sep 2025 14:05:06 -0700
Message-ID: <20250911210525.345110-8-anthony.l.nguyen@intel.com>
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

The root debugfs directory should be available from driver side, not
from library. Move it out from fwlog code.

Make similar to __fwlog_init() __fwlog_deinit() and deinit debugfs
there. In case of ice only fwlog is using debugfs.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c  | 14 ++++++++++++--
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 16 +++++++++++-----
 drivers/net/ethernet/intel/ice/ice_fwlog.c   |  2 --
 4 files changed, 24 insertions(+), 9 deletions(-)

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
index 53d713d19da2..16765c2da4bd 100644
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
index 9235ae099e17..b9849d1ef928 100644
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
@@ -645,6 +640,17 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 	kfree(fw_modules);
 }
 
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
2.47.1


