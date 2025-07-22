Return-Path: <netdev+bounces-208886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB08B0D7CA
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB485608F4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C662E2F16;
	Tue, 22 Jul 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG1ZqOsr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14B2E267A
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182423; cv=none; b=Sybw9pwdOpiTrTt5TpuWUzF/EBe8QKkzZk/m9tzpl5G5QBZg6QgO0RT59fzdl7WvftHOuqvioUq3wJiApmcdJ0I9JVkshVSmUErROu03La0dR+w1ci4ACITBZM4LDxFrIynOuzodkevQqM0EZlQcle8A211fNprKY1mq3GTEhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182423; c=relaxed/simple;
	bh=8x47+Z+F76MmDeFE/G/x/ULdrEuvltAv9rYswrzQcl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLQq9haTuxjzfmUDMpCZpwC1W2FyJllNA0kiiygRMxBrdUU0e86V0j1C9f20HJLjbej7geh3mXD3CvUbNoHYXGAfu1jDuhZgvkIagV+PmIrliVWiuMK/5MxdLZxtw3D5m5rtohNg8OT1eww5wFFT0WUIRC77b6NpDdvxbyeFh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HG1ZqOsr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753182422; x=1784718422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8x47+Z+F76MmDeFE/G/x/ULdrEuvltAv9rYswrzQcl0=;
  b=HG1ZqOsr+NI+Ub/T4C1bJ7FfTjWijqQPim0LLQO1EEIZ73KW7M8e4IqQ
   1Xi0rQfv+JyDkBpZ+lRe3Jt2aHEzBIQE3pkWxQL1J3CXIlK5L0nYS3ry4
   LklmV3c17th+I+EmS7nIG3CEOlDNV5RTQM4n2vuqjvQ4SpXlGSIruCE1a
   ETpatHFY0GSg+vgZCB76z4zEsD1XB9215oe+b9tClB3FvZFjudWOeCGH3
   do/e05jfXq84W4MCnQ45UVRGQ5cnSbjCLQZa4qckI1nUMG9PeimIhehRp
   mtDH2G1gBdB8ohWH20qtJUEwljFPLw9dgBouGvZ02uSxYrvBExxnDbqOl
   Q==;
X-CSE-ConnectionGUID: yMPwNFPAQUy3m7kgcygcXg==
X-CSE-MsgGUID: TydIem+fQjiR3UlTgoBQrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59083585"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59083585"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:07:02 -0700
X-CSE-ConnectionGUID: 5zWitBxBRZW+TnNJbxTvEg==
X-CSE-MsgGUID: U8PjrdKSTd+ZCA34uFRIBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163153935"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jul 2025 04:07:00 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH iwl-next v1 03/15] ice: drop ice_pf_fwlog_update_module()
Date: Tue, 22 Jul 2025 12:45:48 +0200
Message-ID: <20250722104600.10141-4-michal.swiatkowski@linux.intel.com>
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

Any other access to fwlog_cfg isn't done through a function. Follow
scheme that is used to access other fwlog_cfg elements from debugfs and
write to the log_level directly.

ice_pf_fwlog_update_module() is called only twice (from one function).
Remove it.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  5 +++--
 drivers/net/ethernet/intel/ice/ice_main.c    | 13 -------------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index e952d67388bf..a6803b344540 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -912,7 +912,6 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf);
 void ice_debugfs_pf_deinit(struct ice_pf *pf);
 void ice_debugfs_init(void);
 void ice_debugfs_exit(void);
-void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
 
 bool netif_is_ice(const struct net_device *dev);
 int ice_vsi_setup_tx_rings(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index cb71eca6a85b..170050548e74 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -164,6 +164,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	struct ice_pf *pf = file_inode(filp)->i_private;
 	struct dentry *dentry = file_dentry(filp);
 	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
 	char user_val[16], *cmd_buf;
 	int module, log_level, cnt;
 
@@ -192,7 +193,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	}
 
 	if (module != ICE_AQC_FW_LOG_ID_MAX) {
-		ice_pf_fwlog_update_module(pf, log_level, module);
+		hw->fwlog_cfg.module_entries[module].log_level = log_level;
 	} else {
 		/* the module 'all' is a shortcut so that we can set
 		 * all of the modules to the same level quickly
@@ -200,7 +201,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 		int i;
 
 		for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++)
-			ice_pf_fwlog_update_module(pf, log_level, i);
+			hw->fwlog_cfg.module_entries[i].log_level = log_level;
 	}
 
 	return count;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c2101853adf8..7f72b8d09d79 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4620,19 +4620,6 @@ static void ice_print_wake_reason(struct ice_pf *pf)
 	dev_info(ice_pf_to_dev(pf), "Wake reason: %s", wake_str);
 }
 
-/**
- * ice_pf_fwlog_update_module - update 1 module
- * @pf: pointer to the PF struct
- * @log_level: log_level to use for the @module
- * @module: module to update
- */
-void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
-{
-	struct ice_hw *hw = &pf->hw;
-
-	hw->fwlog_cfg.module_entries[module].log_level = log_level;
-}
-
 /**
  * ice_register_netdev - register netdev
  * @vsi: pointer to the VSI struct
-- 
2.49.0


