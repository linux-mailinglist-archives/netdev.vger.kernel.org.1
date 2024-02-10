Return-Path: <netdev+bounces-70792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7458506CE
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 23:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D11F21DAB
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 22:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CDD5FDCD;
	Sat, 10 Feb 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T07EqNFM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBC5FBBF
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602483; cv=none; b=X+CHN0Pit0167DJd6AEFbw6F6CfHNJYLBhB8KsUc6bvWstBapqWVfXWO8PTlE75bWt/dvlp2ruttNeRG3zNEriItcHB2k9EZ/btWEfZGuF8M+o8PnK8+IHIyBMguMd48eh6wioM+/saZE4Y+UKMb042Pd9q/WPgPWhEf3Ti2TFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602483; c=relaxed/simple;
	bh=73gVd0jL3LIZ/NUnA4I60xb3vo48N8JaflqhU2tf2SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTZWDjPYvmEu49gxuf8n9SJIHw1rQmUUygzUyloidAAYRkEdd4U5D216RgtifldYNyoffxZizzN+Inb8bbiXHK+I/95BBCR2Ghnn74HDF+UvYkvb3ucp0nWlAX4UyRNJkKqHViCliFhBxMfGEThFYb7eLLv1VBwP/YxSgCBCTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T07EqNFM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707602481; x=1739138481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=73gVd0jL3LIZ/NUnA4I60xb3vo48N8JaflqhU2tf2SI=;
  b=T07EqNFM9o8TPLtIafsMXxP3fb9IB7HQoss0UmneJGr6yh9oR3jHmYri
   miRO3XNcw4+5+BryprIGc2KU+eRVxO1sYITo9FG6zp6pH4+peyhVMWynm
   qmBh/dJkifVqBJATz7Y+La+w+5YJ2AttyJUyAHI3a1/hfVRdWW05UsOKe
   j57Iejq3ppZxBjWK7jb0ILOegtxhFIZ8FMJqhNwiateO0YdZnj7MxoQZR
   4Lo7UWWsr6UyTPUKlog9DEuyUWkFZ2zEWvWwskpPsmuEcYpsgpcBtW+xj
   an86d7g55WnVRbffgtTvl2l8zL0gBm5LyLmJK2dZoiGTPj1+amaX63sPJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1474818"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1474818"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 14:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2211143"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 14:01:18 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iwl-next v1 1/2] igb: simplify pci ops declaration
Date: Sat, 10 Feb 2024 14:01:08 -0800
Message-Id: <20240210220109.3179408-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240210220109.3179408-1-jesse.brandeburg@intel.com>
References: <20240210220109.3179408-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The igb driver was pre-declaring tons of functions just so that it could
have an early declaration of the pci_driver struct.

Delete a bunch of the declarations and move the struct to the bottom of the
file, after all the functions are declared.

Reviewed-by: Alan Brady <alan.brady@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
e1p v2: add back mistakenly deleted pm ops struct.
---
 drivers/net/ethernet/intel/igb/igb_main.c | 51 ++++++++++-------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4df8d4153aa5..fdca4901defa 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -106,8 +106,6 @@ static int igb_setup_all_rx_resources(struct igb_adapter *);
 static void igb_free_all_tx_resources(struct igb_adapter *);
 static void igb_free_all_rx_resources(struct igb_adapter *);
 static void igb_setup_mrqc(struct igb_adapter *);
-static int igb_probe(struct pci_dev *, const struct pci_device_id *);
-static void igb_remove(struct pci_dev *pdev);
 static void igb_init_queue_configuration(struct igb_adapter *adapter);
 static int igb_sw_init(struct igb_adapter *);
 int igb_open(struct net_device *);
@@ -178,20 +176,6 @@ static int igb_vf_configure(struct igb_adapter *adapter, int vf);
 static int igb_disable_sriov(struct pci_dev *dev, bool reinit);
 #endif
 
-static int igb_suspend(struct device *);
-static int igb_resume(struct device *);
-static int igb_runtime_suspend(struct device *dev);
-static int igb_runtime_resume(struct device *dev);
-static int igb_runtime_idle(struct device *dev);
-#ifdef CONFIG_PM
-static const struct dev_pm_ops igb_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
-	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
-			igb_runtime_idle)
-};
-#endif
-static void igb_shutdown(struct pci_dev *);
-static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
 #ifdef CONFIG_IGB_DCA
 static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
 static struct notifier_block dca_notifier = {
@@ -219,19 +203,6 @@ static const struct pci_error_handlers igb_err_handler = {
 
 static void igb_init_dmac(struct igb_adapter *adapter, u32 pba);
 
-static struct pci_driver igb_driver = {
-	.name     = igb_driver_name,
-	.id_table = igb_pci_tbl,
-	.probe    = igb_probe,
-	.remove   = igb_remove,
-#ifdef CONFIG_PM
-	.driver.pm = &igb_pm_ops,
-#endif
-	.shutdown = igb_shutdown,
-	.sriov_configure = igb_pci_sriov_configure,
-	.err_handler = &igb_err_handler
-};
-
 MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
 MODULE_DESCRIPTION("Intel(R) Gigabit Ethernet Network Driver");
 MODULE_LICENSE("GPL v2");
@@ -647,6 +618,8 @@ struct net_device *igb_get_hw_dev(struct e1000_hw *hw)
 	return adapter->netdev;
 }
 
+static struct pci_driver igb_driver;
+
 /**
  *  igb_init_module - Driver Registration Routine
  *
@@ -10169,4 +10142,24 @@ static void igb_nfc_filter_restore(struct igb_adapter *adapter)
 
 	spin_unlock(&adapter->nfc_lock);
 }
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops igb_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
+	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
+			igb_runtime_idle)
+};
+#endif
+
+static struct pci_driver igb_driver = {
+	.name     = igb_driver_name,
+	.id_table = igb_pci_tbl,
+	.probe    = igb_probe,
+	.remove   = igb_remove,
+	.driver.pm = &igb_pm_ops,
+	.shutdown = igb_shutdown,
+	.sriov_configure = igb_pci_sriov_configure,
+	.err_handler = &igb_err_handler
+};
+
 /* igb_main.c */
-- 
2.39.3


