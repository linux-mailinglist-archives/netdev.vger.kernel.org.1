Return-Path: <netdev+bounces-77738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B896872D03
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4A21F288D1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1590EAC0;
	Wed,  6 Mar 2024 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCDfdAl0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96745D531
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693440; cv=none; b=iOZd4D/8L+TB4Wzb6yueGV4YSohMAgKUaNyKrgW9w5xgbtAy1VJMU34XCNECE2BPm3ryVaemTpKd8O7O83TWblWlOgpPbNS83E7SFmU6mI6S8tOdUo0fSORl7wjU61jkxHjiPTFdq5+Li1pSGDWNT1Cqsby6lKUQY0sKShffzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693440; c=relaxed/simple;
	bh=UPuZBrQvWS6NhKxz2fbZdD7E8p9RwtqSgF4i3HGBrC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYamlIbfc7MvyvfE3BuiGDFS3fAjMUBAqbTU1rQLuCO1njG+3DXcGzfxiwYjundHzYKjBk5GFvolaxOzeJwJ328v6oKw+wn0K/Pavn5v4y4KMDoUZw9mQV2QhFf03Pm/iqP4Oq228J118H1zLY9G98xxji151qFPSaqLCTNq86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCDfdAl0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709693439; x=1741229439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPuZBrQvWS6NhKxz2fbZdD7E8p9RwtqSgF4i3HGBrC8=;
  b=CCDfdAl0y7uBGcf/Rno5IUuxrAx0iN28NTTlWTGY9pr5n8+8/gDwOag2
   2kUOO0YoPL+YG89Cc1bICF2FcOamrERzkyC6UIzoPDuy2pTcPFyFaDVbo
   XijGoikRgZKepeKQ1deLTvwOaDudnpVDhI/m4aFv6ZRRE1pA9P41Q9I80
   z3G4tUxVD0b78jdUu6qLm8tSid0n/aazgKEID+eCS9RwNfXGiIvzcpEEl
   LrFsnxY3ws9Jj739tAQbpWcAFXRyF7UznZtM8Ey9/0JGSMAgDqPpWAzng
   87b4QHjO6mam3bHiPvSHFNb+RjEC/zHJvpDQ6AsDJ0BWMa4aYpbtiB7d8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21741390"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="21741390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14088542"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:50:31 -0800
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
Subject: [PATCH iwl-next v2 2/2] net: intel: implement modern PM ops declarations
Date: Tue,  5 Mar 2024 18:50:22 -0800
Message-Id: <20240306025023.800029-3-jesse.brandeburg@intel.com>
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

Switch the Intel networking drivers to use the new power management ops
declaration formats and macros, which allows us to drop __maybe_unused,
as well as a bunch of ifdef checking CONFIG_PM.

This is safe to do because the compiler drops the unused functions,
verified by checking for any of the power management function symbols
being present in System.map for a build without CONFIG_PM.

If a driver has runtime PM, define the ops with pm_ptr(), and if the
driver has Simple PM, use pm_sleep_ptr(), as well as the new versions of
the macros for declaring the members of the pm_ops structs.

Checked with network-enabled allnoconfig, allyesconfig, allmodconfig on
x64_64.

Reviewed-by: Alan Brady <alan.brady@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: added ice driver changes to series
v1: original net-next posting
    all changes except for ice were reviewed by Simon Horman
    no other changes besides to ice
---
 drivers/net/ethernet/intel/e100.c             |  8 +++---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 14 +++++-----
 drivers/net/ethernet/intel/e1000e/netdev.c    | 22 +++++++---------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 10 +++----
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 10 +++----
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +++---
 drivers/net/ethernet/intel/ice/ice_main.c     | 12 +++------
 drivers/net/ethernet/intel/igb/igb_main.c     | 26 +++++++------------
 drivers/net/ethernet/intel/igbvf/netdev.c     |  6 ++---
 drivers/net/ethernet/intel/igc/igc_main.c     | 24 ++++++-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  8 +++---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  8 +++---
 12 files changed, 64 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 3fcb8daaa243..9b068d40778d 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -3037,7 +3037,7 @@ static int __e100_power_off(struct pci_dev *pdev, bool wake)
 	return 0;
 }
 
-static int __maybe_unused e100_suspend(struct device *dev_d)
+static int e100_suspend(struct device *dev_d)
 {
 	bool wake;
 
@@ -3046,7 +3046,7 @@ static int __maybe_unused e100_suspend(struct device *dev_d)
 	return 0;
 }
 
-static int __maybe_unused e100_resume(struct device *dev_d)
+static int e100_resume(struct device *dev_d)
 {
 	struct net_device *netdev = dev_get_drvdata(dev_d);
 	struct nic *nic = netdev_priv(netdev);
@@ -3163,7 +3163,7 @@ static const struct pci_error_handlers e100_err_handler = {
 	.resume = e100_io_resume,
 };
 
-static SIMPLE_DEV_PM_OPS(e100_pm_ops, e100_suspend, e100_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(e100_pm_ops, e100_suspend, e100_resume);
 
 static struct pci_driver e100_driver = {
 	.name =         DRV_NAME,
@@ -3172,7 +3172,7 @@ static struct pci_driver e100_driver = {
 	.remove =       e100_remove,
 
 	/* Power Management hooks */
-	.driver.pm =	&e100_pm_ops,
+	.driver.pm =	pm_sleep_ptr(&e100_pm_ops),
 
 	.shutdown =     e100_shutdown,
 	.err_handler = &e100_err_handler,
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 1d1e93686af2..5b43f9b194fc 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -149,8 +149,8 @@ static int e1000_vlan_rx_kill_vid(struct net_device *netdev,
 				  __be16 proto, u16 vid);
 static void e1000_restore_vlan(struct e1000_adapter *adapter);
 
-static int __maybe_unused e1000_suspend(struct device *dev);
-static int __maybe_unused e1000_resume(struct device *dev);
+static int e1000_suspend(struct device *dev);
+static int e1000_resume(struct device *dev);
 static void e1000_shutdown(struct pci_dev *pdev);
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -175,16 +175,14 @@ static const struct pci_error_handlers e1000_err_handler = {
 	.resume = e1000_io_resume,
 };
 
-static SIMPLE_DEV_PM_OPS(e1000_pm_ops, e1000_suspend, e1000_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(e1000_pm_ops, e1000_suspend, e1000_resume);
 
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
 	.id_table = e1000_pci_tbl,
 	.probe    = e1000_probe,
 	.remove   = e1000_remove,
-	.driver = {
-		.pm = &e1000_pm_ops,
-	},
+	.driver.pm = pm_sleep_ptr(&e1000_pm_ops),
 	.shutdown = e1000_shutdown,
 	.err_handler = &e1000_err_handler
 };
@@ -5135,7 +5133,7 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	return 0;
 }
 
-static int __maybe_unused e1000_suspend(struct device *dev)
+static int e1000_suspend(struct device *dev)
 {
 	int retval;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -5147,7 +5145,7 @@ static int __maybe_unused e1000_suspend(struct device *dev)
 	return retval;
 }
 
-static int __maybe_unused e1000_resume(struct device *dev)
+static int e1000_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index cc8c531ec3df..1c91dece75a8 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6950,13 +6950,13 @@ static int __e1000_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-static __maybe_unused int e1000e_pm_prepare(struct device *dev)
+static int e1000e_pm_prepare(struct device *dev)
 {
 	return pm_runtime_suspended(dev) &&
 		pm_suspend_via_firmware();
 }
 
-static __maybe_unused int e1000e_pm_suspend(struct device *dev)
+static int e1000e_pm_suspend(struct device *dev)
 {
 	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
 	struct e1000_adapter *adapter = netdev_priv(netdev);
@@ -6979,7 +6979,7 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
 	return rc;
 }
 
-static __maybe_unused int e1000e_pm_resume(struct device *dev)
+static int e1000e_pm_resume(struct device *dev)
 {
 	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
 	struct e1000_adapter *adapter = netdev_priv(netdev);
@@ -7013,7 +7013,7 @@ static __maybe_unused int e1000e_pm_runtime_idle(struct device *dev)
 	return -EBUSY;
 }
 
-static __maybe_unused int e1000e_pm_runtime_resume(struct device *dev)
+static int e1000e_pm_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7032,7 +7032,7 @@ static __maybe_unused int e1000e_pm_runtime_resume(struct device *dev)
 	return rc;
 }
 
-static __maybe_unused int e1000e_pm_runtime_suspend(struct device *dev)
+static int e1000e_pm_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7919,8 +7919,7 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
 
-static const struct dev_pm_ops e1000_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
+static const struct dev_pm_ops e1000e_pm_ops = {
 	.prepare	= e1000e_pm_prepare,
 	.suspend	= e1000e_pm_suspend,
 	.resume		= e1000e_pm_resume,
@@ -7928,9 +7927,8 @@ static const struct dev_pm_ops e1000_pm_ops = {
 	.thaw		= e1000e_pm_thaw,
 	.poweroff	= e1000e_pm_suspend,
 	.restore	= e1000e_pm_resume,
-#endif
-	SET_RUNTIME_PM_OPS(e1000e_pm_runtime_suspend, e1000e_pm_runtime_resume,
-			   e1000e_pm_runtime_idle)
+	RUNTIME_PM_OPS(e1000e_pm_runtime_suspend, e1000e_pm_runtime_resume,
+		       e1000e_pm_runtime_idle)
 };
 
 /* PCI Device API Driver */
@@ -7939,9 +7937,7 @@ static struct pci_driver e1000_driver = {
 	.id_table = e1000_pci_tbl,
 	.probe    = e1000_probe,
 	.remove   = e1000_remove,
-	.driver   = {
-		.pm = &e1000_pm_ops,
-	},
+	.driver.pm = pm_ptr(&e1000e_pm_ops),
 	.shutdown = e1000_shutdown,
 	.err_handler = &e1000_err_handler
 };
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index d748b98274e7..92de609b7218 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2342,7 +2342,7 @@ static int fm10k_handle_resume(struct fm10k_intfc *interface)
  * suspend or hibernation. This function does not need to handle lower PCIe
  * device state as the stack takes care of that for us.
  **/
-static int __maybe_unused fm10k_resume(struct device *dev)
+static int fm10k_resume(struct device *dev)
 {
 	struct fm10k_intfc *interface = dev_get_drvdata(dev);
 	struct net_device *netdev = interface->netdev;
@@ -2369,7 +2369,7 @@ static int __maybe_unused fm10k_resume(struct device *dev)
  * system suspend or hibernation. This function does not need to handle lower
  * PCIe device state as the stack takes care of that for us.
  **/
-static int __maybe_unused fm10k_suspend(struct device *dev)
+static int fm10k_suspend(struct device *dev)
 {
 	struct fm10k_intfc *interface = dev_get_drvdata(dev);
 	struct net_device *netdev = interface->netdev;
@@ -2502,16 +2502,14 @@ static const struct pci_error_handlers fm10k_err_handler = {
 	.reset_done = fm10k_io_reset_done,
 };
 
-static SIMPLE_DEV_PM_OPS(fm10k_pm_ops, fm10k_suspend, fm10k_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(fm10k_pm_ops, fm10k_suspend, fm10k_resume);
 
 static struct pci_driver fm10k_driver = {
 	.name			= fm10k_driver_name,
 	.id_table		= fm10k_pci_tbl,
 	.probe			= fm10k_probe,
 	.remove			= fm10k_remove,
-	.driver = {
-		.pm		= &fm10k_pm_ops,
-	},
+	.driver.pm		= pm_sleep_ptr(&fm10k_pm_ops),
 	.sriov_configure	= fm10k_iov_configure,
 	.err_handler		= &fm10k_err_handler
 };
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3fada49b8ae2..0628abeb5674 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16509,7 +16509,7 @@ static void i40e_shutdown(struct pci_dev *pdev)
  * i40e_suspend - PM callback for moving to D3
  * @dev: generic device information structure
  **/
-static int __maybe_unused i40e_suspend(struct device *dev)
+static int i40e_suspend(struct device *dev)
 {
 	struct i40e_pf *pf = dev_get_drvdata(dev);
 	struct i40e_hw *hw = &pf->hw;
@@ -16560,7 +16560,7 @@ static int __maybe_unused i40e_suspend(struct device *dev)
  * i40e_resume - PM callback for waking up from D3
  * @dev: generic device information structure
  **/
-static int __maybe_unused i40e_resume(struct device *dev)
+static int i40e_resume(struct device *dev)
 {
 	struct i40e_pf *pf = dev_get_drvdata(dev);
 	int err;
@@ -16606,16 +16606,14 @@ static const struct pci_error_handlers i40e_err_handler = {
 	.resume = i40e_pci_error_resume,
 };
 
-static SIMPLE_DEV_PM_OPS(i40e_pm_ops, i40e_suspend, i40e_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(i40e_pm_ops, i40e_suspend, i40e_resume);
 
 static struct pci_driver i40e_driver = {
 	.name     = i40e_driver_name,
 	.id_table = i40e_pci_tbl,
 	.probe    = i40e_probe,
 	.remove   = i40e_remove,
-	.driver   = {
-		.pm = &i40e_pm_ops,
-	},
+	.driver.pm = pm_sleep_ptr(&i40e_pm_ops),
 	.shutdown = i40e_shutdown,
 	.err_handler = &i40e_err_handler,
 	.sriov_configure = i40e_pci_sriov_configure,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index aefec6bd3b67..6010ce71fd66 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5032,7 +5032,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  *
  * Called when the system (VM) is entering sleep/suspend.
  **/
-static int __maybe_unused iavf_suspend(struct device *dev_d)
+static int iavf_suspend(struct device *dev_d)
 {
 	struct net_device *netdev = dev_get_drvdata(dev_d);
 	struct iavf_adapter *adapter = netdev_priv(netdev);
@@ -5060,7 +5060,7 @@ static int __maybe_unused iavf_suspend(struct device *dev_d)
  *
  * Called when the system (VM) is resumed from sleep/suspend.
  **/
-static int __maybe_unused iavf_resume(struct device *dev_d)
+static int iavf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct iavf_adapter *adapter;
@@ -5247,14 +5247,14 @@ static void iavf_shutdown(struct pci_dev *pdev)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
 
-static SIMPLE_DEV_PM_OPS(iavf_pm_ops, iavf_suspend, iavf_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(iavf_pm_ops, iavf_suspend, iavf_resume);
 
 static struct pci_driver iavf_driver = {
 	.name      = iavf_driver_name,
 	.id_table  = iavf_pci_tbl,
 	.probe     = iavf_probe,
 	.remove    = iavf_remove,
-	.driver.pm = &iavf_pm_ops,
+	.driver.pm = pm_sleep_ptr(&iavf_pm_ops),
 	.shutdown  = iavf_shutdown,
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8f73ba77e835..48fdcf883365 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5321,7 +5321,6 @@ static void ice_shutdown(struct pci_dev *pdev)
 	}
 }
 
-#ifdef CONFIG_PM
 /**
  * ice_prepare_for_shutdown - prep for PCI shutdown
  * @pf: board private structure
@@ -5410,7 +5409,7 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
  * Power Management callback to quiesce the device and prepare
  * for D3 transition.
  */
-static int __maybe_unused ice_suspend(struct device *dev)
+static int ice_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ice_pf *pf;
@@ -5477,7 +5476,7 @@ static int __maybe_unused ice_suspend(struct device *dev)
  * ice_resume - PM callback for waking up from D3
  * @dev: generic device information structure
  */
-static int __maybe_unused ice_resume(struct device *dev)
+static int ice_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	enum ice_reset_req reset_type;
@@ -5528,7 +5527,6 @@ static int __maybe_unused ice_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 /**
  * ice_pci_err_detected - warning that PCI error has been detected
@@ -5702,7 +5700,7 @@ static const struct pci_device_id ice_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, ice_pci_tbl);
 
-static __maybe_unused SIMPLE_DEV_PM_OPS(ice_pm_ops, ice_suspend, ice_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ice_pm_ops, ice_suspend, ice_resume);
 
 static const struct pci_error_handlers ice_pci_err_handler = {
 	.error_detected = ice_pci_err_detected,
@@ -5717,9 +5715,7 @@ static struct pci_driver ice_driver = {
 	.id_table = ice_pci_tbl,
 	.probe = ice_probe,
 	.remove = ice_remove,
-#ifdef CONFIG_PM
-	.driver.pm = &ice_pm_ops,
-#endif /* CONFIG_PM */
+	.driver.pm = pm_sleep_ptr(&ice_pm_ops),
 	.shutdown = ice_shutdown,
 	.sriov_configure = ice_sriov_configure,
 	.sriov_get_vf_total_msix = ice_sriov_get_vf_total_msix,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index e749bf5164b8..820f6688ce38 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9439,12 +9439,12 @@ static void igb_deliver_wake_packet(struct net_device *netdev)
 	netif_rx(skb);
 }
 
-static int __maybe_unused igb_suspend(struct device *dev)
+static int igb_suspend(struct device *dev)
 {
 	return __igb_shutdown(to_pci_dev(dev), NULL, 0);
 }
 
-static int __maybe_unused __igb_resume(struct device *dev, bool rpm)
+static int __igb_resume(struct device *dev, bool rpm)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -9500,12 +9500,12 @@ static int __maybe_unused __igb_resume(struct device *dev, bool rpm)
 	return err;
 }
 
-static int __maybe_unused igb_resume(struct device *dev)
+static int igb_resume(struct device *dev)
 {
 	return __igb_resume(dev, false);
 }
 
-static int __maybe_unused igb_runtime_idle(struct device *dev)
+static int igb_runtime_idle(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
@@ -9516,12 +9516,12 @@ static int __maybe_unused igb_runtime_idle(struct device *dev)
 	return -EBUSY;
 }
 
-static int __maybe_unused igb_runtime_suspend(struct device *dev)
+static int igb_runtime_suspend(struct device *dev)
 {
 	return __igb_shutdown(to_pci_dev(dev), NULL, 1);
 }
 
-static int __maybe_unused igb_runtime_resume(struct device *dev)
+static int igb_runtime_resume(struct device *dev)
 {
 	return __igb_resume(dev, true);
 }
@@ -10144,22 +10144,16 @@ static void igb_nfc_filter_restore(struct igb_adapter *adapter)
 	spin_unlock(&adapter->nfc_lock);
 }
 
-#ifdef CONFIG_PM
-static const struct dev_pm_ops igb_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
-	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
-			   igb_runtime_idle)
-};
-#endif
+static _DEFINE_DEV_PM_OPS(igb_pm_ops, igb_suspend, igb_resume,
+			  igb_runtime_suspend, igb_runtime_resume,
+			  igb_runtime_idle);
 
 static struct pci_driver igb_driver = {
 	.name     = igb_driver_name,
 	.id_table = igb_pci_tbl,
 	.probe    = igb_probe,
 	.remove   = igb_remove,
-#ifdef CONFIG_PM
-	.driver.pm = &igb_pm_ops,
-#endif
+	.driver.pm = pm_ptr(&igb_pm_ops),
 	.shutdown = igb_shutdown,
 	.sriov_configure = igb_pci_sriov_configure,
 	.err_handler = &igb_err_handler
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index b0cf310e6f7b..40ccd24ffc53 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2470,7 +2470,7 @@ static int igbvf_suspend(struct device *dev_d)
 	return 0;
 }
 
-static int __maybe_unused igbvf_resume(struct device *dev_d)
+static int igbvf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -2957,7 +2957,7 @@ static const struct pci_device_id igbvf_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, igbvf_pci_tbl);
 
-static SIMPLE_DEV_PM_OPS(igbvf_pm_ops, igbvf_suspend, igbvf_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(igbvf_pm_ops, igbvf_suspend, igbvf_resume);
 
 /* PCI Device API Driver */
 static struct pci_driver igbvf_driver = {
@@ -2965,7 +2965,7 @@ static struct pci_driver igbvf_driver = {
 	.id_table	= igbvf_pci_tbl,
 	.probe		= igbvf_probe,
 	.remove		= igbvf_remove,
-	.driver.pm	= &igbvf_pm_ops,
+	.driver.pm	= pm_sleep_ptr(&igbvf_pm_ops),
 	.shutdown	= igbvf_shutdown,
 	.err_handler	= &igbvf_err_handler
 };
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 34820f6a78b9..8d1415ca70bb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7120,8 +7120,7 @@ static int __igc_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int __maybe_unused igc_runtime_suspend(struct device *dev)
+static int igc_runtime_suspend(struct device *dev)
 {
 	return __igc_shutdown(to_pci_dev(dev), NULL, 1);
 }
@@ -7156,7 +7155,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
 	netif_rx(skb);
 }
 
-static int __maybe_unused igc_resume(struct device *dev)
+static int igc_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7209,12 +7208,12 @@ static int __maybe_unused igc_resume(struct device *dev)
 	return err;
 }
 
-static int __maybe_unused igc_runtime_resume(struct device *dev)
+static int igc_runtime_resume(struct device *dev)
 {
 	return igc_resume(dev);
 }
 
-static int __maybe_unused igc_suspend(struct device *dev)
+static int igc_suspend(struct device *dev)
 {
 	return __igc_shutdown(to_pci_dev(dev), NULL, 0);
 }
@@ -7229,7 +7228,6 @@ static int __maybe_unused igc_runtime_idle(struct device *dev)
 
 	return -EBUSY;
 }
-#endif /* CONFIG_PM */
 
 static void igc_shutdown(struct pci_dev *pdev)
 {
@@ -7344,22 +7342,16 @@ static const struct pci_error_handlers igc_err_handler = {
 	.resume = igc_io_resume,
 };
 
-#ifdef CONFIG_PM
-static const struct dev_pm_ops igc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(igc_suspend, igc_resume)
-	SET_RUNTIME_PM_OPS(igc_runtime_suspend, igc_runtime_resume,
-			   igc_runtime_idle)
-};
-#endif
+static _DEFINE_DEV_PM_OPS(igc_pm_ops, igc_suspend, igc_resume,
+			  igc_runtime_suspend, igc_runtime_resume,
+			  igc_runtime_idle);
 
 static struct pci_driver igc_driver = {
 	.name     = igc_driver_name,
 	.id_table = igc_pci_tbl,
 	.probe    = igc_probe,
 	.remove   = igc_remove,
-#ifdef CONFIG_PM
-	.driver.pm = &igc_pm_ops,
-#endif
+	.driver.pm = pm_ptr(&igc_pm_ops),
 	.shutdown = igc_shutdown,
 	.err_handler = &igc_err_handler,
 };
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 595098a4c488..4fec48143035 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6944,7 +6944,7 @@ int ixgbe_close(struct net_device *netdev)
 	return 0;
 }
 
-static int __maybe_unused ixgbe_resume(struct device *dev_d)
+static int ixgbe_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
@@ -7052,7 +7052,7 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	return 0;
 }
 
-static int __maybe_unused ixgbe_suspend(struct device *dev_d)
+static int ixgbe_suspend(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	int retval;
@@ -11516,14 +11516,14 @@ static const struct pci_error_handlers ixgbe_err_handler = {
 	.resume = ixgbe_io_resume,
 };
 
-static SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);
 
 static struct pci_driver ixgbe_driver = {
 	.name      = ixgbe_driver_name,
 	.id_table  = ixgbe_pci_tbl,
 	.probe     = ixgbe_probe,
 	.remove    = ixgbe_remove,
-	.driver.pm = &ixgbe_pm_ops,
+	.driver.pm = pm_sleep_ptr(&ixgbe_pm_ops),
 	.shutdown  = ixgbe_shutdown,
 	.sriov_configure = ixgbe_pci_sriov_configure,
 	.err_handler = &ixgbe_err_handler
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 9c960017a6de..3161a13079fe 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4300,7 +4300,7 @@ static int ixgbevf_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
-static int __maybe_unused ixgbevf_suspend(struct device *dev_d)
+static int ixgbevf_suspend(struct device *dev_d)
 {
 	struct net_device *netdev = dev_get_drvdata(dev_d);
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
@@ -4317,7 +4317,7 @@ static int __maybe_unused ixgbevf_suspend(struct device *dev_d)
 	return 0;
 }
 
-static int __maybe_unused ixgbevf_resume(struct device *dev_d)
+static int ixgbevf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -4854,7 +4854,7 @@ static const struct pci_error_handlers ixgbevf_err_handler = {
 	.resume = ixgbevf_io_resume,
 };
 
-static SIMPLE_DEV_PM_OPS(ixgbevf_pm_ops, ixgbevf_suspend, ixgbevf_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ixgbevf_pm_ops, ixgbevf_suspend, ixgbevf_resume);
 
 static struct pci_driver ixgbevf_driver = {
 	.name		= ixgbevf_driver_name,
@@ -4863,7 +4863,7 @@ static struct pci_driver ixgbevf_driver = {
 	.remove		= ixgbevf_remove,
 
 	/* Power Management Hooks */
-	.driver.pm	= &ixgbevf_pm_ops,
+	.driver.pm	= pm_sleep_ptr(&ixgbevf_pm_ops),
 
 	.shutdown	= ixgbevf_shutdown,
 	.err_handler	= &ixgbevf_err_handler
-- 
2.39.3


