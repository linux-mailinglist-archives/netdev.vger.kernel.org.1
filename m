Return-Path: <netdev+bounces-77737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3CD872D00
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495991F28925
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 02:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB6DDBC;
	Wed,  6 Mar 2024 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0KkptDg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BCD272
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693439; cv=none; b=P2NzI8lHSq648JyXv3zc/CYXhmzfyl6zt0MkQ2xS5/L3vGk1W4Nh1NITehcEt77s+JjjQIlyL5c6E87INIhB0TO6jle70HEsjBXZAoo6Xxb8Q+kUqWFF8hB88ns/5YBQMrgUSV2NQYfEvLMClpqCyhraU/8SHJ3gTVZVRyBU2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693439; c=relaxed/simple;
	bh=npkyWm4n0dy2Pz8WO8hv3jyBtDCyWKRzIoOA7bdosGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaYYGpAsz1v2FQFxsESVIFrKGNyyujwXa+ByYuQnXDsr8DZPbzGRSuzrQrZhRrT5QgrFmim1nCpl1xXwUP5Hq7YIJ5Lkls+MWHhHnns/1eNICreEgp8J1BOCTCDKRIccbrrfpBvNByvtkLjPPJpqcaXH9hzEl7eS4c7t8eBwJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0KkptDg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709693438; x=1741229438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=npkyWm4n0dy2Pz8WO8hv3jyBtDCyWKRzIoOA7bdosGc=;
  b=c0KkptDgcgPWCr3Uhn9aEiHsPBTQS/OVYiP1N/eqdC9ncw0fX3JfY5tL
   x3qn4bRzZ4PLxbViFfvvVFzEo8/DrRuJCXDVrUhPAp4UeXt+b94Bmg6+J
   LgqB+rBtjBgcNdv61Hfrf2sbpkrKbWFkAZLmpPdSZBnzefBl5Yrv/d0Lo
   LChe6kZ0MaCjaf4GyhWN8GlLaPaJPLhcnT7gO8zoeznOVhzvsQqyFzMas
   qT4yDaiq9EF1wNWCP9mHXkAlst3UwJYrJxXL+g15yaWutcHspjG6cZaeV
   eij2e28k0+oKWaJPqs2rFEz+/VUtvW8kzv/rTl2vzqCu7+r3lh1+hftp5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21741380"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="21741380"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:50:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14088538"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:50:30 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	Alan Brady <alan.brady@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH iwl-next v2 1/2] igb: simplify pci ops declaration
Date: Tue,  5 Mar 2024 18:50:21 -0800
Message-Id: <20240306025023.800029-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240306025023.800029-1-jesse.brandeburg@intel.com>
References: <20240306025023.800029-1-jesse.brandeburg@intel.com>
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
v2: address compilation failure when CONFIG_PM=n, which is then updated
    in patch 2/2, fix alignment.
    changes in v1 reviewed by Simon Horman
    changes in v1 reviewed by Paul Menzel
v1: original net-next posting
---
 drivers/net/ethernet/intel/igb/igb_main.c | 53 ++++++++++-------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 518298bbdadc..e749bf5164b8 100644
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
@@ -10170,4 +10143,26 @@ static void igb_nfc_filter_restore(struct igb_adapter *adapter)
 
 	spin_unlock(&adapter->nfc_lock);
 }
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops igb_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
+	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
+			   igb_runtime_idle)
+};
+#endif
+
+static struct pci_driver igb_driver = {
+	.name     = igb_driver_name,
+	.id_table = igb_pci_tbl,
+	.probe    = igb_probe,
+	.remove   = igb_remove,
+#ifdef CONFIG_PM
+	.driver.pm = &igb_pm_ops,
+#endif
+	.shutdown = igb_shutdown,
+	.sriov_configure = igb_pci_sriov_configure,
+	.err_handler = &igb_err_handler
+};
+
 /* igb_main.c */
-- 
2.39.3


