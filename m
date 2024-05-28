Return-Path: <netdev+bounces-98786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934828D27BD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0746BB232F0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C213E025;
	Tue, 28 May 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOI0Z4Ax"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78F13DDA2
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933982; cv=none; b=for372/RFIDI2+5WIWXvIeDX9Hg9CQI/wto9KY4jT1rWVOnXGTSUv3sMBqIISw2fBxkSQJrIgdYCkDyQIQEwOyPI52mLzEJAAvTfFuK4ldUup22rG4aT9sNh1AAZEP/XAHFqchLd7NO6kWFUIDGp1R4i8UIFamrYdXbyZonX5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933982; c=relaxed/simple;
	bh=xzEoLnmyLNTCv3kfDby/3xMi1hrWnZzH+NWFBEBfTis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TfAaY2HZd9pn8MSxQZjprUgoObNTElUX7jqSl92dYZgX/A0bOd1AIWNZMbf2G2tKf7pvutr/1DbQWzyGOHn/oQ0jiXAAf88BdhcEOg3/bAcuxD/zdijRWHc1YntR6xj9UruvSkXwqrMP+n3kaRIhjTkf2Ydfbl/9Umsoyb4rACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOI0Z4Ax; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716933981; x=1748469981;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xzEoLnmyLNTCv3kfDby/3xMi1hrWnZzH+NWFBEBfTis=;
  b=MOI0Z4AxpAKkuf0J1IBThGiKYrdCnU+gJQZp+lYjvntrVOFLOZwp1d1d
   pon8caHAkrTCSCV4eTIsGF/1wERavrMgnw0ky88jvnyy1QI7ys6QnGmi0
   Cfdr9vystZ8Bq0BS5j3k+BeC+a33IId0MdK+dfqUjBZbUajYJLjs2qjWG
   cz0UNZFjBkM0lfpHLsMJR7InJmjKJ3NuCsJzxnY1g5E4dkfxHlevCBDSp
   dgqS+2esEAd9+TF4HBTCmLxGUTu09kXpP+NqPiMeKWdm7CWJWI54KE2XA
   bTyJEfXe5H1mURFrNLReWsHrTYhZg4foY2YS5U+SoZUksKXS/KYH481WU
   Q==;
X-CSE-ConnectionGUID: ECKoaad5TNeE1dSK6ZF3og==
X-CSE-MsgGUID: ZQGlMZ8xQ7i85mk502yPoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13439609"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13439609"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:19 -0700
X-CSE-ConnectionGUID: PxEFiKsgSqOQb4g10EQYuw==
X-CSE-MsgGUID: XH74Jkh3Tr2oNpGOQsAswA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40087516"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 15:06:05 -0700
Subject: [PATCH net 2/8] i40e: factoring out i40e_suspend/i40e_resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-net-2024-05-28-intel-net-fixes-v1-2-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Thinh Tran <thinhtr@linux.ibm.com>, Robert Thomas <rob.thomas@ibm.com>, 
 Simon Horman <horms@kernel.org>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Thinh Tran <thinhtr@linux.ibm.com>

Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
introduced.  These functions were factored out from the existing
i40e_suspend() and i40e_resume() respectively.  This factoring was
done due to concerns about the logic of the I40E_SUSPENSED state, which
caused the device to be unable to recover.  The functions are now used
in the EEH handling for device suspend/resume callbacks.

The function i40e_enable_mc_magic_wake() has been moved ahead of
i40e_io_suspend() to ensure it is declared before being used.

Tested-by: Robert Thomas <rob.thomas@ibm.com>
Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 249 +++++++++++++++-------------
 1 file changed, 135 insertions(+), 114 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1f188c052828..d5f25ea304bf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16334,6 +16334,139 @@ static void i40e_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+/**
+ * i40e_enable_mc_magic_wake - enable multicast magic packet wake up
+ * using the mac_address_write admin q function
+ * @pf: pointer to i40e_pf struct
+ **/
+static void i40e_enable_mc_magic_wake(struct i40e_pf *pf)
+{
+	struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
+	struct i40e_hw *hw = &pf->hw;
+	u8 mac_addr[6];
+	u16 flags = 0;
+	int ret;
+
+	/* Get current MAC address in case it's an LAA */
+	if (main_vsi && main_vsi->netdev) {
+		ether_addr_copy(mac_addr, main_vsi->netdev->dev_addr);
+	} else {
+		dev_err(&pf->pdev->dev,
+			"Failed to retrieve MAC address; using default\n");
+		ether_addr_copy(mac_addr, hw->mac.addr);
+	}
+
+	/* The FW expects the mac address write cmd to first be called with
+	 * one of these flags before calling it again with the multicast
+	 * enable flags.
+	 */
+	flags = I40E_AQC_WRITE_TYPE_LAA_WOL;
+
+	if (hw->func_caps.flex10_enable && hw->partition_id != 1)
+		flags = I40E_AQC_WRITE_TYPE_LAA_ONLY;
+
+	ret = i40e_aq_mac_address_write(hw, flags, mac_addr, NULL);
+	if (ret) {
+		dev_err(&pf->pdev->dev,
+			"Failed to update MAC address registers; cannot enable Multicast Magic packet wake up");
+		return;
+	}
+
+	flags = I40E_AQC_MC_MAG_EN
+			| I40E_AQC_WOL_PRESERVE_ON_PFR
+			| I40E_AQC_WRITE_TYPE_UPDATE_MC_MAG;
+	ret = i40e_aq_mac_address_write(hw, flags, mac_addr, NULL);
+	if (ret)
+		dev_err(&pf->pdev->dev,
+			"Failed to enable Multicast Magic Packet wake up\n");
+}
+
+/**
+ * i40e_io_suspend - suspend all IO operations
+ * @pf: pointer to i40e_pf struct
+ *
+ **/
+static int i40e_io_suspend(struct i40e_pf *pf)
+{
+	struct i40e_hw *hw = &pf->hw;
+
+	set_bit(__I40E_DOWN, pf->state);
+
+	/* Ensure service task will not be running */
+	del_timer_sync(&pf->service_timer);
+	cancel_work_sync(&pf->service_task);
+
+	/* Client close must be called explicitly here because the timer
+	 * has been stopped.
+	 */
+	i40e_notify_client_of_netdev_close(pf, false);
+
+	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps) &&
+	    pf->wol_en)
+		i40e_enable_mc_magic_wake(pf);
+
+	/* Since we're going to destroy queues during the
+	 * i40e_clear_interrupt_scheme() we should hold the RTNL lock for this
+	 * whole section
+	 */
+	rtnl_lock();
+
+	i40e_prep_for_reset(pf);
+
+	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
+	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
+
+	/* Clear the interrupt scheme and release our IRQs so that the system
+	 * can safely hibernate even when there are a large number of CPUs.
+	 * Otherwise hibernation might fail when mapping all the vectors back
+	 * to CPU0.
+	 */
+	i40e_clear_interrupt_scheme(pf);
+
+	rtnl_unlock();
+
+	return 0;
+}
+
+/**
+ * i40e_io_resume - resume IO operations
+ * @pf: pointer to i40e_pf struct
+ *
+ **/
+static int i40e_io_resume(struct i40e_pf *pf)
+{
+	struct device *dev = &pf->pdev->dev;
+	int err;
+
+	/* We need to hold the RTNL lock prior to restoring interrupt schemes,
+	 * since we're going to be restoring queues
+	 */
+	rtnl_lock();
+
+	/* We cleared the interrupt scheme when we suspended, so we need to
+	 * restore it now to resume device functionality.
+	 */
+	err = i40e_restore_interrupt_scheme(pf);
+	if (err) {
+		dev_err(dev, "Cannot restore interrupt scheme: %d\n",
+			err);
+	}
+
+	clear_bit(__I40E_DOWN, pf->state);
+	i40e_reset_and_rebuild(pf, false, true);
+
+	rtnl_unlock();
+
+	/* Clear suspended state last after everything is recovered */
+	clear_bit(__I40E_SUSPENDED, pf->state);
+
+	/* Restart the service task */
+	mod_timer(&pf->service_timer,
+		  round_jiffies(jiffies + pf->service_timer_period));
+
+	return 0;
+}
+
 /**
  * i40e_pci_error_detected - warning that something funky happened in PCI land
  * @pdev: PCI device information struct
@@ -16446,53 +16579,6 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 	i40e_handle_reset_warning(pf, false);
 }
 
-/**
- * i40e_enable_mc_magic_wake - enable multicast magic packet wake up
- * using the mac_address_write admin q function
- * @pf: pointer to i40e_pf struct
- **/
-static void i40e_enable_mc_magic_wake(struct i40e_pf *pf)
-{
-	struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
-	struct i40e_hw *hw = &pf->hw;
-	u8 mac_addr[6];
-	u16 flags = 0;
-	int ret;
-
-	/* Get current MAC address in case it's an LAA */
-	if (main_vsi && main_vsi->netdev) {
-		ether_addr_copy(mac_addr, main_vsi->netdev->dev_addr);
-	} else {
-		dev_err(&pf->pdev->dev,
-			"Failed to retrieve MAC address; using default\n");
-		ether_addr_copy(mac_addr, hw->mac.addr);
-	}
-
-	/* The FW expects the mac address write cmd to first be called with
-	 * one of these flags before calling it again with the multicast
-	 * enable flags.
-	 */
-	flags = I40E_AQC_WRITE_TYPE_LAA_WOL;
-
-	if (hw->func_caps.flex10_enable && hw->partition_id != 1)
-		flags = I40E_AQC_WRITE_TYPE_LAA_ONLY;
-
-	ret = i40e_aq_mac_address_write(hw, flags, mac_addr, NULL);
-	if (ret) {
-		dev_err(&pf->pdev->dev,
-			"Failed to update MAC address registers; cannot enable Multicast Magic packet wake up");
-		return;
-	}
-
-	flags = I40E_AQC_MC_MAG_EN
-			| I40E_AQC_WOL_PRESERVE_ON_PFR
-			| I40E_AQC_WRITE_TYPE_UPDATE_MC_MAG;
-	ret = i40e_aq_mac_address_write(hw, flags, mac_addr, NULL);
-	if (ret)
-		dev_err(&pf->pdev->dev,
-			"Failed to enable Multicast Magic Packet wake up\n");
-}
-
 /**
  * i40e_shutdown - PCI callback for shutting down
  * @pdev: PCI device information struct
@@ -16552,48 +16638,11 @@ static void i40e_shutdown(struct pci_dev *pdev)
 static int i40e_suspend(struct device *dev)
 {
 	struct i40e_pf *pf = dev_get_drvdata(dev);
-	struct i40e_hw *hw = &pf->hw;
 
 	/* If we're already suspended, then there is nothing to do */
 	if (test_and_set_bit(__I40E_SUSPENDED, pf->state))
 		return 0;
-
-	set_bit(__I40E_DOWN, pf->state);
-
-	/* Ensure service task will not be running */
-	del_timer_sync(&pf->service_timer);
-	cancel_work_sync(&pf->service_task);
-
-	/* Client close must be called explicitly here because the timer
-	 * has been stopped.
-	 */
-	i40e_notify_client_of_netdev_close(pf, false);
-
-	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps) &&
-	    pf->wol_en)
-		i40e_enable_mc_magic_wake(pf);
-
-	/* Since we're going to destroy queues during the
-	 * i40e_clear_interrupt_scheme() we should hold the RTNL lock for this
-	 * whole section
-	 */
-	rtnl_lock();
-
-	i40e_prep_for_reset(pf);
-
-	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
-	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
-
-	/* Clear the interrupt scheme and release our IRQs so that the system
-	 * can safely hibernate even when there are a large number of CPUs.
-	 * Otherwise hibernation might fail when mapping all the vectors back
-	 * to CPU0.
-	 */
-	i40e_clear_interrupt_scheme(pf);
-
-	rtnl_unlock();
-
-	return 0;
+	return i40e_io_suspend(pf);
 }
 
 /**
@@ -16603,39 +16652,11 @@ static int i40e_suspend(struct device *dev)
 static int i40e_resume(struct device *dev)
 {
 	struct i40e_pf *pf = dev_get_drvdata(dev);
-	int err;
 
 	/* If we're not suspended, then there is nothing to do */
 	if (!test_bit(__I40E_SUSPENDED, pf->state))
 		return 0;
-
-	/* We need to hold the RTNL lock prior to restoring interrupt schemes,
-	 * since we're going to be restoring queues
-	 */
-	rtnl_lock();
-
-	/* We cleared the interrupt scheme when we suspended, so we need to
-	 * restore it now to resume device functionality.
-	 */
-	err = i40e_restore_interrupt_scheme(pf);
-	if (err) {
-		dev_err(dev, "Cannot restore interrupt scheme: %d\n",
-			err);
-	}
-
-	clear_bit(__I40E_DOWN, pf->state);
-	i40e_reset_and_rebuild(pf, false, true);
-
-	rtnl_unlock();
-
-	/* Clear suspended state last after everything is recovered */
-	clear_bit(__I40E_SUSPENDED, pf->state);
-
-	/* Restart the service task */
-	mod_timer(&pf->service_timer,
-		  round_jiffies(jiffies + pf->service_timer_period));
-
-	return 0;
+	return i40e_io_resume(pf);
 }
 
 static const struct pci_error_handlers i40e_err_handler = {

-- 
2.44.0.53.g0f9d4d28b7e6


