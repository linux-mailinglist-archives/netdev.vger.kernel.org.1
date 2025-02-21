Return-Path: <netdev+bounces-168540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB7A3F3C6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634FD3AFCFE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D720E718;
	Fri, 21 Feb 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIZ3lToO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6514820E327
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139546; cv=none; b=SiuYM+V/8YUsfmOM7B0gAnZuS4dncPz1zM1TmP6rFaJ5gias7aEEnyJ+R6EMNb0gjg8adep4j+PofT3sSwXusviUXLawgncclJye1KFQTClqz7sK+YCYt6EyFKw5230jkpG2OciLPRCcEZVw7taOxJflAkUG2B7HagfVQUpAptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139546; c=relaxed/simple;
	bh=xixukXm7ljB32mPhw/quuTckGgmI2fpv9SRa11Vs+5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuP0JmO5Njc1maWsoazhJ/2o4OKb8ttFFGmNdv5hFmbmVTXb0p0OUgcerwbUGmVAKN4SyJ/Z13mHwjC3ppE+2EMYtbA7r1/EiZ5OnvJvOBzIsuLb8cjFm1L2zW6oqMLs9iatlwT3Jbd43fdwMef7/aiV943RPbinviLinLILLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIZ3lToO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740139544; x=1771675544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xixukXm7ljB32mPhw/quuTckGgmI2fpv9SRa11Vs+5w=;
  b=eIZ3lToO8IeG5Mak0nntssRa80B51zhVpXUQ0IYU8Wb+XJLqH808GXmn
   6kLMti3BAtfD90VaEqWqAWiGscazHEFmYkiLSGaOvFgpeCK8RMZtD81kq
   hskMXqkSLUDGGvniS03NtdzKBSf8h9QZyxE7FtqGh+zrdOLFewkoOUDNu
   bGMNM5+x/X1vJ5Kquf42B6ENDAuE3/PoIGa0eY/sKLjt7uVLAUJT3AxEv
   PGMMPeerQ/L6b5uHlmYtR9PWjNkjV6Cf1vpy86ld9v+rHexWIxe+gIc4U
   RxIV16o4leHPue8oIto4TG8s5ZrcBMx/l9WEpEDKR2UDGE3O8L6UTzCNh
   g==;
X-CSE-ConnectionGUID: +rLfKtyEQ+ioXn7ILeS8wg==
X-CSE-MsgGUID: xI/srBy6TaS+o6GP4OWLtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51599042"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51599042"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:05:44 -0800
X-CSE-ConnectionGUID: Px2FsCo6QrmZWh1PtphBlA==
X-CSE-MsgGUID: deNJwFw9RPqrDqzTIcqRVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116260338"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 21 Feb 2025 04:05:42 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiri@nvidia.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: [PATCH iwl-next v5 14/15] ixgbe: add E610 implementation of FW recovery mode
Date: Fri, 21 Feb 2025 12:51:15 +0100
Message-Id: <20250221115116.169158-15-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
References: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add E610 implementation of fw_recovery_mode MAC operation.

In case of E610 information about recovery mode is obtained
from FW_MODES field in IXGBE_GL_MNG_FWSM register (0x000B6134).

Introduce recovery specific probing flow and init only
vital features.

User should be able to perform NVM update using devlink
once recovery mode is detected in order to load a healthy img.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 17 ++++
 .../ethernet/intel/ixgbe/ixgbe_fw_update.c    | 15 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 88 +++++++++++++++++--
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  3 +
 4 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 21a94a43144c..e029257f1ccb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1815,6 +1815,22 @@ void ixgbe_disable_rx_e610(struct ixgbe_hw *hw)
 	}
 }
 
+/**
+ * ixgbe_fw_recovery_mode_e610 - Check FW NVM recovery mode
+ * @hw: pointer to hardware structure
+ *
+ * Check FW NVM recovery mode by reading the value of
+ * the dedicated register.
+ *
+ * Return: true if FW is in recovery mode, otherwise false.
+ */
+static bool ixgbe_fw_recovery_mode_e610(struct ixgbe_hw *hw)
+{
+	u32 fwsm = IXGBE_READ_REG(hw, IXGBE_GL_MNG_FWSM);
+
+	return !!(fwsm & IXGBE_GL_MNG_FWSM_RECOVERY_M);
+}
+
 /**
  * ixgbe_init_phy_ops_e610 - PHY specific init
  * @hw: pointer to hardware structure
@@ -3878,6 +3894,7 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.get_fw_ver                     = ixgbe_aci_get_fw_ver,
 	.get_media_type			= ixgbe_get_media_type_e610,
 	.setup_link			= ixgbe_setup_link_e610,
+	.fw_recovery_mode		= ixgbe_fw_recovery_mode_e610,
 	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
 	.get_bus_info			= ixgbe_get_bus_info_generic,
 	.acquire_swfw_sync		= ixgbe_acquire_swfw_sync_X540,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
index 052d5b3fb371..c74f397cebb7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
@@ -73,6 +73,8 @@ static int ixgbe_check_component_response(struct ixgbe_adapter *adapter,
 					  u8 response, u8 code,
 					  struct netlink_ext_ack *extack)
 {
+	struct ixgbe_hw *hw = &adapter->hw;
+
 	switch (response) {
 	case IXGBE_ACI_NVM_PASS_COMP_CAN_BE_UPDATED:
 		/* Firmware indicated this update is good to proceed. */
@@ -84,6 +86,11 @@ static int ixgbe_check_component_response(struct ixgbe_adapter *adapter,
 	case IXGBE_ACI_NVM_PASS_COMP_CAN_NOT_BE_UPDATED:
 		NL_SET_ERR_MSG_MOD(extack, "Firmware has rejected updating.");
 		break;
+	case IXGBE_ACI_NVM_PASS_COMP_PARTIAL_CHECK:
+		if (hw->mac.ops.fw_recovery_mode &&
+		    hw->mac.ops.fw_recovery_mode(hw))
+			return 0;
+		break;
 	}
 
 	switch (code) {
@@ -653,7 +660,13 @@ int ixgbe_flash_pldm_image(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	if (!hw->dev_caps.common_cap.nvm_unified_update) {
+	/*
+	 * Cannot get caps in recovery mode, so lack of nvm_unified_update bit
+	 * cannot lead to error
+	 */
+	if (!hw->dev_caps.common_cap.nvm_unified_update &&
+	    (hw->mac.ops.fw_recovery_mode &&
+	     !hw->mac.ops.fw_recovery_mode(hw))) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Current firmware does not support unified update");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 492e6b194f61..0667e4e85f10 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8423,6 +8423,18 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 	return false;
 }
 
+static void ixgbe_recovery_service_task(struct work_struct *work)
+{
+	struct ixgbe_adapter *adapter = container_of(work,
+						     struct ixgbe_adapter,
+						     service_task);
+
+	ixgbe_handle_fw_event(adapter);
+	ixgbe_service_event_complete(adapter);
+
+	mod_timer(&adapter->service_timer, jiffies + msecs_to_jiffies(100));
+}
+
 /**
  * ixgbe_service_task - manages and runs subtasks
  * @work: pointer to work_struct containing our data
@@ -11228,6 +11240,66 @@ static void ixgbe_set_fw_version(struct ixgbe_adapter *adapter)
 		 "0x%08x", nvm_ver.etk_id);
 }
 
+/**
+ * ixgbe_recovery_probe - Handle FW recovery mode during probe
+ * @adapter: the adapter private structure
+ *
+ * Perform limited driver initialization when FW error is detected.
+ *
+ * Return: 0 on successful probe for E610, -EIO if recovery mode is detected
+ * for non-E610 adapter, error status code on any other case.
+ */
+static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct pci_dev *pdev = adapter->pdev;
+	struct ixgbe_hw *hw = &adapter->hw;
+	bool disable_dev;
+	int err = -EIO;
+
+	if (hw->mac.type != ixgbe_mac_e610)
+		goto clean_up_probe;
+
+	ixgbe_get_hw_control(adapter);
+	mutex_init(&hw->aci.lock);
+	err = ixgbe_get_flash_data(&adapter->hw);
+	if (err)
+		goto shutdown_aci;
+
+	timer_setup(&adapter->service_timer, ixgbe_service_timer, 0);
+	INIT_WORK(&adapter->service_task, ixgbe_recovery_service_task);
+	set_bit(__IXGBE_SERVICE_INITED, &adapter->state);
+	clear_bit(__IXGBE_SERVICE_SCHED, &adapter->state);
+
+	if (hw->mac.ops.get_bus_info)
+		hw->mac.ops.get_bus_info(hw);
+
+	pci_set_drvdata(pdev, adapter);
+	/*
+	 * We are creating devlink interface so NIC can be managed,
+	 * e.g. new NVM image loaded
+	 */
+	devl_lock(adapter->devlink);
+	ixgbe_devlink_register_port(adapter);
+	SET_NETDEV_DEVLINK_PORT(adapter->netdev,
+				&adapter->devlink_port);
+	devl_register(adapter->devlink);
+	devl_unlock(adapter->devlink);
+
+	return 0;
+shutdown_aci:
+	mutex_destroy(&adapter->hw.aci.lock);
+	ixgbe_release_hw_control(adapter);
+	devlink_free(adapter->devlink);
+clean_up_probe:
+	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
+	free_netdev(netdev);
+	pci_release_mem_regions(pdev);
+	if (disable_dev)
+		pci_disable_device(pdev);
+	return err;
+}
+
 /**
  * ixgbe_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -11366,6 +11438,13 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_sw_init;
 
+	/* Make sure the SWFW semaphore is in a valid state */
+	if (hw->mac.ops.init_swfw_sync)
+		hw->mac.ops.init_swfw_sync(hw);
+
+	if (ixgbe_check_fw_error(adapter))
+		return ixgbe_recovery_probe(adapter);
+
 	if (adapter->hw.mac.type == ixgbe_mac_e610) {
 		err = ixgbe_get_caps(&adapter->hw);
 		if (err)
@@ -11392,10 +11471,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		break;
 	}
 
-	/* Make sure the SWFW semaphore is in a valid state */
-	if (hw->mac.ops.init_swfw_sync)
-		hw->mac.ops.init_swfw_sync(hw);
-
 	/* Make it possible the adapter to be woken up via WOL */
 	switch (adapter->hw.mac.type) {
 	case ixgbe_mac_82599EB:
@@ -11548,11 +11623,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)
 		netdev->features |= NETIF_F_LRO;
 
-	if (ixgbe_check_fw_error(adapter)) {
-		err = -EIO;
-		goto err_sw_init;
-	}
-
 	/* make sure the EEPROM is good */
 	if (hw->eeprom.ops.validate_checksum(hw, NULL) < 0) {
 		e_dev_err("The EEPROM Checksum Is Not Valid\n");
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 4d591019dd07..1df5ac2e1fc5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -88,6 +88,9 @@
 #define GLNVM_GENS		0x000B6100 /* Reset Source: POR */
 #define GLNVM_GENS_SR_SIZE_M	GENMASK(7, 5)
 
+#define IXGBE_GL_MNG_FWSM		0x000B6134 /* Reset Source: POR */
+#define IXGBE_GL_MNG_FWSM_RECOVERY_M	BIT(1)
+
 /* Flash Access Register */
 #define IXGBE_GLNVM_FLA			0x000B6108 /* Reset Source: POR */
 #define IXGBE_GLNVM_FLA_LOCKED_S	6
-- 
2.31.1


