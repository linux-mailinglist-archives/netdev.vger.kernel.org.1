Return-Path: <netdev+bounces-166421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F93A35F37
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3675A7A14D5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FF264F80;
	Fri, 14 Feb 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+zHWJmL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C526656E
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539867; cv=none; b=KsOcUSZ3DkTH2zoXprcXi5Q2Upa3yMD+2c+s+EIvhfNH3x3yPHsJEGPmZz0p1f6pE/iJee5HCKZr3kLqZ4ANi6fhbmhyD8fGiA5BhIkIWXLt80HvB4ZaIJvuJIoKXV0MywfVBpcGuP1r5fyWfKvH6xrWkwfPxRwvWXTgio6Gyt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539867; c=relaxed/simple;
	bh=vNCnRYI13R8xnTaVvax32ohxXH7KF676i75tuialRL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=df+Q8mEaazUL3iXXrS9r0EhImmIS2oLgEscDjrxk5RY8jiLQx8XRonCKl9SDAVggSXKxI3IYscJP6YdvkVYLLlAfl4IgdZMMK2iNa80dKmBhU5KaTNxcCPfCZ3Nd3D9MhX8CQ4XUTPPchaujnWE8DNljhK/fQSu4t2LJYdJjCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+zHWJmL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739539865; x=1771075865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vNCnRYI13R8xnTaVvax32ohxXH7KF676i75tuialRL0=;
  b=U+zHWJmLW7aqJHhLG4pvyiUlCig1KnuDMv+61Hi5jW5DtYU7g2ddYyEI
   fCv00axvHDCPl4Uuc4HhuYaNKC1Uu2NwZRknq4edoPiKTJzX8oALvqLGQ
   AIM2MxfeFJStdKGl1+0EGkHMJSibJTTvX/0SQHFe7/DoJXd353VJEtl4M
   LdXvEi/K7bv90KcG4YQsYfEBM1dHiP84T5V3Oyo29FknVVjEwwG62E0hF
   H7N9J0W40NEKdqcsDKByapNDrycA6bDMg8GIvNgXjJC7g7u/Z3HRrs6kQ
   ufTVcVmhwZzo+WUxK7X5nx1s2DK9+tXbzjB6kTGZmA0LTa9nEJ6G7/kji
   w==;
X-CSE-ConnectionGUID: sjJvhFn0Ra6/bKmln7PdRg==
X-CSE-MsgGUID: jr8Wt9z3QVeQaoy7kQ50aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40159419"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40159419"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:31:05 -0800
X-CSE-ConnectionGUID: GDghNpbgRqOkX1LtEHpdRQ==
X-CSE-MsgGUID: VN8o+ulEQBKKEm4hZDXnzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114094394"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2025 05:31:03 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	"mailto:przemyslaw.kitszel"@intel.com, jiri@nvidia.com,
	horms@kernel.org, Andrii Staikov <andrii.staikov@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 15/15] ixgbe: add support for FW rollback mode
Date: Fri, 14 Feb 2025 14:16:46 +0100
Message-Id: <20250214131646.118437-16-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250214131646.118437-1-jedrzej.jagielski@intel.com>
References: <20250214131646.118437-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andrii Staikov <andrii.staikov@intel.com>

The driver should detect whether the device entered FW rollback
mode and then notify user with the dedicated message including
FW and NVM versions.

Even if the driver detected rollback mode, this should not result
in an probe error and the normal flow proceeds.

FW tries to rollback to “old” operational FW located in the
inactive NVM bank in cases when newly loaded FW exhibits faulty
behavior. If something goes wrong during boot the FW may switch
into rollback mode in an attempt to avoid recovery mode and stay
operational. After rollback is successful, the banks are swapped,
and the “rollback” bank becomes the active bank for the next reset.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 34 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 26 ++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  3 ++
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  1 +
 6 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index f0c7644eda43..b21ab86fb961 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -485,7 +485,8 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 
 	*actions_performed = BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
 
-	adapter->flags2 &= ~IXGBE_FLAG2_API_MISMATCH;
+	adapter->flags2 &= ~(IXGBE_FLAG2_API_MISMATCH |
+			     IXGBE_FLAG2_FW_ROLLBACK);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 2246997bc9fb..23c2e2c2649c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -672,6 +672,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_NO_MEDIA			BIT(21)
 #define IXGBE_FLAG2_MOD_POWER_UNSUPPORTED	BIT(22)
 #define IXGBE_FLAG2_API_MISMATCH		BIT(23)
+#define IXGBE_FLAG2_FW_ROLLBACK			BIT(24)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 7a8861a95835..aab92516fe1c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1829,6 +1829,22 @@ static bool ixgbe_fw_recovery_mode_e610(struct ixgbe_hw *hw)
 	return !!(fwsm & IXGBE_GL_MNG_FWSM_RECOVERY_M);
 }
 
+/**
+ * ixgbe_fw_rollback_mode_e610 - Check FW NVM rollback mode
+ * @hw: pointer to hardware structure
+ *
+ * Check FW NVM rollback mode by reading the value of
+ * the dedicated register.
+ *
+ * Return: true if FW is in rollback mode, otherwise false.
+ */
+static bool ixgbe_fw_rollback_mode_e610(struct ixgbe_hw *hw)
+{
+	u32 fwsm = IXGBE_READ_REG(hw, IXGBE_GL_MNG_FWSM);
+
+	return !!(fwsm & IXGBE_GL_MNG_FWSM_ROLLBACK_M);
+}
+
 /**
  * ixgbe_init_phy_ops_e610 - PHY specific init
  * @hw: pointer to hardware structure
@@ -3161,6 +3177,21 @@ int ixgbe_get_inactive_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm)
 	return ixgbe_get_nvm_ver_info(hw, IXGBE_INACTIVE_FLASH_BANK, nvm);
 }
 
+/**
+ * ixgbe_get_active_nvm_ver - Read Option ROM version from the active bank
+ * @hw: pointer to the HW structure
+ * @nvm: storage for Option ROM version information
+ *
+ * Reads the NVM EETRACK ID, Map version, and security revision of the
+ * active NVM bank.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_get_active_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm)
+{
+	return ixgbe_get_nvm_ver_info(hw, IXGBE_ACTIVE_FLASH_BANK, nvm);
+}
+
 /**
  * ixgbe_get_netlist_info - Read the netlist version information
  * @hw: pointer to the HW struct
@@ -3892,6 +3923,9 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.get_media_type			= ixgbe_get_media_type_e610,
 	.setup_link			= ixgbe_setup_link_e610,
 	.fw_recovery_mode		= ixgbe_fw_recovery_mode_e610,
+	.fw_rollback_mode		= ixgbe_fw_rollback_mode_e610,
+	.get_fw_ver			= ixgbe_aci_get_fw_ver,
+	.get_nvm_ver			= ixgbe_get_active_nvm_ver,
 	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
 	.get_bus_info			= ixgbe_get_bus_info_generic,
 	.acquire_swfw_sync		= ixgbe_acquire_swfw_sync_X540,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fc37e1dc0e32..1130d379ba6b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8417,6 +8417,32 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 			return true;
 	}
 
+	/* return here if FW rollback mode has been already detected */
+	if (adapter->flags2 & IXGBE_FLAG2_FW_ROLLBACK)
+		return false;
+
+	if (hw->mac.ops.fw_rollback_mode && hw->mac.ops.fw_rollback_mode(hw)) {
+		struct ixgbe_nvm_info *nvm_info = &adapter->hw.flash.nvm;
+		char ver_buff[64] = "";
+
+		if (hw->mac.ops.get_fw_ver && hw->mac.ops.get_fw_ver(hw))
+			goto no_version;
+
+		if (hw->mac.ops.get_nvm_ver &&
+		    hw->mac.ops.get_nvm_ver(hw, nvm_info))
+			goto no_version;
+
+		snprintf(ver_buff, sizeof(ver_buff),
+			 "Current version is NVM:%x.%x.%x, FW:%d.%d. ",
+			 nvm_info->major, nvm_info->minor, nvm_info->eetrack,
+			 hw->fw_maj_ver, hw->fw_maj_ver);
+no_version:
+		e_dev_warn("Firmware rollback mode detected. %sDevice may exhibit limited functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware rollback mode.",
+			   ver_buff);
+
+		adapter->flags2 |= IXGBE_FLAG2_FW_ROLLBACK;
+	}
+
 	return false;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 5f814f023573..33406e1f0b9e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3524,6 +3524,9 @@ struct ixgbe_mac_operations {
 	int (*get_thermal_sensor_data)(struct ixgbe_hw *);
 	int (*init_thermal_sensor_thresh)(struct ixgbe_hw *hw);
 	bool (*fw_recovery_mode)(struct ixgbe_hw *hw);
+	bool (*fw_rollback_mode)(struct ixgbe_hw *hw);
+	int (*get_fw_ver)(struct ixgbe_hw *hw);
+	int (*get_nvm_ver)(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm);
 	void (*disable_rx)(struct ixgbe_hw *hw);
 	void (*enable_rx)(struct ixgbe_hw *hw);
 	void (*set_source_address_pruning)(struct ixgbe_hw *, bool,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 1df5ac2e1fc5..c5cf153a19e9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -90,6 +90,7 @@
 
 #define IXGBE_GL_MNG_FWSM		0x000B6134 /* Reset Source: POR */
 #define IXGBE_GL_MNG_FWSM_RECOVERY_M	BIT(1)
+#define IXGBE_GL_MNG_FWSM_ROLLBACK_M    BIT(2)
 
 /* Flash Access Register */
 #define IXGBE_GLNVM_FLA			0x000B6108 /* Reset Source: POR */
-- 
2.31.1


