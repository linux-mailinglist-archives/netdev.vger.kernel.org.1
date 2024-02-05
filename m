Return-Path: <netdev+bounces-69141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDB3849B76
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D92B29A67
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2AC1CAB0;
	Mon,  5 Feb 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRySHjHK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A01CAB9
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138360; cv=none; b=m+/k1MKIriRmI/3nRvBg7Qm20J8eEid6yjrju+F/0lGjQuJLBWrkH45eDaDGGmqNWuB/dzUIuOeMf7EvK1zmaiiYeEzyfS78no8NmaU27trC0DklPAAr30cRDlwHBPzoO1Ntky6ia9dik16J269mYXmzMcIT5PnuZr9Cqxls/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138360; c=relaxed/simple;
	bh=st0mATr4D+JloWcT1mJHpcSg8tnYAr5Rc1tpLla9LdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tT9ocwomusGTUxLFhy68O1tzoaCQQ8oym/nHVfOk1WwDSMr5sGvVMQ33kQUvVtKpNxm57xo1FZoom1qBIDG1DJlwv+cD+HADRCIQ/GfVh06zoe1aORy75GoZi9eEylXYv5TNTlcvSxo3/Ab+oLnL+Lad/RMYg/+H+okdnKwOrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRySHjHK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707138359; x=1738674359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=st0mATr4D+JloWcT1mJHpcSg8tnYAr5Rc1tpLla9LdY=;
  b=ZRySHjHKMph5fF2pqyulG6wRarRaHMm1sOiEaXZedUH6zlrwAX5GZXCh
   OaHn0YlB9s82nreL2tORNqnUYiniZXlnUIb2pp3qBxTSZq0l6G3w1N3Bd
   VOpHyBi886BwUEV+f+piYVdE7L0ZgyjcKCygZ0mSyQQiBdb8WNQbCBEUV
   fOKIl07Na8sKnBD5a8Pttm3NUlQ6bgAJZXR4QrTBNgPgw0vnSgcWhskAr
   +E0+m/w2GpN3drl2IJdsWlfS4B04CwKwjwfvoW9O5INfqsBM5vHyZZfFi
   CO6Ocy4TJTj2GH5LewUsmfaUBHX7m6U+kgCaeHB1N8LbKxF5Oiww7jvY3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="407549"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="407549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933151702"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933151702"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2024 05:05:56 -0800
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 71BDE27BB6;
	Mon,  5 Feb 2024 13:05:53 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	vadim.fedorenko@linux.dev,
	paul.m.stillwell.jr@intel.com,
	bcreeley@amd.com
Subject: [PATCH iwl-next v5 2/2] ice: Fix debugfs with devlink reload
Date: Mon,  5 Feb 2024 14:03:57 +0100
Message-Id: <20240205130357.106665-3-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205130357.106665-1-wojciech.drewek@intel.com>
References: <20240205130357.106665-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During devlink reload it is needed to remove debugfs entries
correlated with only one PF. ice_debugfs_exit() removes all
entries created by ice driver so we can't use it.

Introduce ice_debugfs_pf_deinit() in order to release PF's
debugfs entries. Move ice_debugfs_exit() call to ice_module_exit(),
it makes more sense since ice_debugfs_init() is called in
ice_module_init() and not in ice_probe().

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
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
2.40.1


