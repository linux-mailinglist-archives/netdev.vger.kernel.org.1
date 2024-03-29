Return-Path: <netdev+bounces-83407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F689230C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C3A285929
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56824136E28;
	Fri, 29 Mar 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgWqjfi8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215C136999
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735001; cv=none; b=TH//6uFszW16lWu1tO2azCGeOCzFONqqkeiCLpQT5UURT9jACcrbdsGQp3u6uqIU6NtvSqJ2nFhDVEfzIki6ivzdhw7jPQSvoYFuW2M/N3/H5vxhxPktXzbHxdWfyfNyYuzHV35EFm9VKdcPfI+ztz9GuLvyAiRIpWeeF1BJr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735001; c=relaxed/simple;
	bh=lGx5zW2Rmyji5DXogID81B8EvoL493AeagYE0QuGvf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0h4/919Wg/f2dyr9oGRn4QtVsZe7LPxrrpBKg2Jaa3Ngg/cmTKkjzTO+oDp5GyCptZgrnneVujhZbx8cKLp4Tb4862hHv+xu7LEpa6MHq1giC+6EoZnZ/hf/CbBIpVSFVN99/LttgB0dIXpaXHICbC3uGDF55N75uBolQUe6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgWqjfi8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711734999; x=1743270999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGx5zW2Rmyji5DXogID81B8EvoL493AeagYE0QuGvf0=;
  b=XgWqjfi8L4JSCTKZwuhxggGF6JcxQxIw9icWDmnkB+R7AZEEtyjZ2CGT
   BsOToZkIV4W407b5IClUQRrblhjHelPdIdbFCSYqIvg/y+/F27sjKSwo4
   wh1CLexKC1Gpn5Xrq1HshxLdzf9e47GymsZgv26uADf377TdocEQsnPfM
   t3Hl+nzRoH3EV+9GmELPkRJmY444UAnqFg93EnR4RBQdZgblkwPowWtq8
   2cTiQPukco78irPOTlvvpR48ZCrpPXfVr4aYK75YA0TLA1RwWuC9tRCuf
   4wbt6lKWhsjoruXKajphszPU3olbkmUwz92hUgAMndJO3/t788gKsIhWp
   g==;
X-CSE-ConnectionGUID: 6DOtIYX/QBuFwZ5u1tViyA==
X-CSE-MsgGUID: uN0AHiC3Tya1upJBxrOR0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="24422454"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="24422454"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21499352"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 10:56:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	anthony.l.nguyen@intel.com,
	Alan Brady <alan.brady@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/4] igb: simplify pci ops declaration
Date: Fri, 29 Mar 2024 10:56:24 -0700
Message-ID: <20240329175632.211340-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
References: <20240329175632.211340-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The igb driver was pre-declaring tons of functions just so that it could
have an early declaration of the pci_driver struct.

Delete a bunch of the declarations and move the struct to the bottom of the
file, after all the functions are declared.

Reviewed-by: Alan Brady <alan.brady@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 53 ++++++++++-------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a3f100769e39..89604c9d8e49 100644
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
@@ -10157,4 +10130,26 @@ static void igb_nfc_filter_restore(struct igb_adapter *adapter)
 
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
2.41.0


