Return-Path: <netdev+bounces-71085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CED851F43
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845471F22C6E
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 21:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CC4D5AB;
	Mon, 12 Feb 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8Mc0Wag"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6244CE05
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772335; cv=none; b=sRgsTJexbeAt98S4Zar5jtYZilaEAYqmRJvnKe/NVVcVkUiCD9MvrtywfOhxdCCcX0ctiTNVs6WLewf3lcyhu6PANB6ZTsCQ4K05k/HADGzyUKb0cROrp+HGQkmQueUgoyjY6oGsUP4SNN+woj6gI3AQmgL8UJNmikVisqW5KLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772335; c=relaxed/simple;
	bh=P99FzqZ/ob5v85YMcxUmNT1Jn4+zsF2d+HaI1BzMT98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crMn56yLkjqB99p/eT+QbpL9mYNo35tYI1xJ9K5LKBGIzswXhmc/PpS8Y4NBhR3xqN9lvVgyDFfd7OqenqpOsIk8Yy+81DYgQYGTGE68Rh97XFHtdODCBkYmB+AT1QKxrqBUt4vVdOT29vcEk4bNkUA516yINK3v3BuYpbaXVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8Mc0Wag; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707772333; x=1739308333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P99FzqZ/ob5v85YMcxUmNT1Jn4+zsF2d+HaI1BzMT98=;
  b=E8Mc0WagTk/l2t/8Pn/CgOK/AUlWU/rnGoEp2EHGm4p9t9EMCSaweBMZ
   t2KpmespYebIFtwAj+7YuTsSGT6/cmeOIKopHXaf1AIiQq3wFOBk/AXqo
   kBHFdBy4eaP7f5djx2Ppyz7Hgv5OZmZLXChvf2aDY+w+UCa5I3B8K2Poq
   JK39CZDaLBeiEOC0SCECnuag1tOqhDi5uS12LVQ0esB8/z/jHvXl4esuI
   whxeQYor8cwxBgHQU5mZZOzbVRN444b+ldm7aqw5Y1tGQyfpvkfAGJM9H
   ItbZ74ie0MWcVABQXaoccDIKqIpAUkZTtiKM3gX5v6Fknx0eWGffOV2QF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436910930"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436910930"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7335626"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2024 13:12:08 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 5/5] ice: Fix debugfs with devlink reload
Date: Mon, 12 Feb 2024 13:11:59 -0800
Message-ID: <20240212211202.1051990-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
References: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

During devlink reload it is needed to remove debugfs entries
correlated with only one PF. ice_debugfs_exit() removes all
entries created by ice driver so we can't use it.

Introduce ice_debugfs_pf_deinit() in order to release PF's
debugfs entries. Move ice_debugfs_exit() call to ice_module_exit(),
it makes more sense since ice_debugfs_init() is called in
ice_module_init() and not in ice_probe().

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 10 ++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.c   |  2 ++
 drivers/net/ethernet/intel/ice/ice_main.c    |  3 +--
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 118e84835720..365c03d1c462 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -896,6 +896,7 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
 }
 
 void ice_debugfs_fwlog_init(struct ice_pf *pf);
+void ice_debugfs_pf_deinit(struct ice_pf *pf);
 void ice_debugfs_init(void);
 void ice_debugfs_exit(void);
 void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 85aa31dd86b1..d252d98218d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -644,6 +644,16 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 	kfree(fw_modules);
 }
 
+/**
+ * ice_debugfs_pf_deinit - cleanup PF's debugfs
+ * @pf: pointer to the PF struct
+ */
+void ice_debugfs_pf_deinit(struct ice_pf *pf)
+{
+	debugfs_remove_recursive(pf->ice_debugfs_pf);
+	pf->ice_debugfs_pf = NULL;
+}
+
 /**
  * ice_debugfs_init - create root directory for debugfs entries
  */
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index 92b5dac481cd..4fd15387a7e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -188,6 +188,8 @@ void ice_fwlog_deinit(struct ice_hw *hw)
 	if (hw->bus.func)
 		return;
 
+	ice_debugfs_pf_deinit(hw->back);
+
 	/* make sure FW logging is disabled to not put the FW in a weird state
 	 * for the next driver load
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 85a996ad2c1f..9c2c8637b4a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5276,8 +5276,6 @@ static void ice_remove(struct pci_dev *pdev)
 		msleep(100);
 	}
 
-	ice_debugfs_exit();
-
 	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
 		ice_free_vfs(pf);
@@ -5783,6 +5781,7 @@ module_init(ice_module_init);
 static void __exit ice_module_exit(void)
 {
 	pci_unregister_driver(&ice_driver);
+	ice_debugfs_exit();
 	destroy_workqueue(ice_wq);
 	destroy_workqueue(ice_lag_wq);
 	pr_info("module unloaded\n");
-- 
2.41.0


