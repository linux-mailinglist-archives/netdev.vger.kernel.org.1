Return-Path: <netdev+bounces-174637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F51A5F98D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9653B17A16E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162642690D1;
	Thu, 13 Mar 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6zrxP2K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018C268FD2
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879121; cv=none; b=gCPpIgOHbYKtddGDtgdZXqtz2jnKNyxkeeGdhUU+/M9vOLKEGXx5WQkgm9sStBoCXepN+jzhom1siAW4Mea2GOw+GoIqM8Q97fkTa7Z0a5dbNC2ZkLOkSEaiCmvhOZkjgEWz8aJ/29Dj6zOTu+seQtAHtuI71rHpu9MoC4QYAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879121; c=relaxed/simple;
	bh=DJuhdKgBG7XHGJBgFunm7QYohmKylbxg2m+Ps7AbJuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5Km+2J7Pp9VOMxpIeoo21B7MdVkA+xnX6Pqh5rI2uQUFuhQO4FMpa9lM/mGGUqJOXaf0p5G45Dd6H3ub3ekDbADm+q/51NA9OESuqpoV0u94lSfx/H82DX/Iw20eUe1gfp/ntEC4efBqDO8LZ28qW7vrU2Te69RKf984w5/HkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6zrxP2K; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741879119; x=1773415119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJuhdKgBG7XHGJBgFunm7QYohmKylbxg2m+Ps7AbJuQ=;
  b=k6zrxP2KfgMZuc5jJEB0IhMHe6Vw5eD+EK2yPitPUV1HkXRxL6/Ph9j6
   wZZMDxlGul6/M2/Azy8h/9YdLKfKybgHg9vrGEOYVxZCK1KECcMSs3d/M
   0F+9tfogr4JvS8sE2UHK83C2J2TjsvshBXCL78SgMNFginskStUKO4quD
   E65KlHCLjuD9F6VBfs8ZhNzYDQZRJt+Cb16dZE1l8nRhfTt2TTaEbPHjl
   l+Ni2e+0B5moc/qzXgkPmCwYF2BbopHp3Qny2rQX+Eq4IArjMgWpbck98
   sgGWt1hh4whYs277880oiacJCsd0i0WYjGbIksFDLWktjiSHmQSxpGq1V
   g==;
X-CSE-ConnectionGUID: v8cI9NkoSFSqAkq0ak438Q==
X-CSE-MsgGUID: m9akZLbcT5OYRUIARTwlFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43104928"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="43104928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 08:18:38 -0700
X-CSE-ConnectionGUID: NJWovphySEWS1n7rtn4TNQ==
X-CSE-MsgGUID: b6dNe/PCR2+ICS51H1qYBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121918411"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 13 Mar 2025 08:18:36 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Andrii Staikov <andrii.staikov@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v8 15/15] ixgbe: add support for FW rollback mode
Date: Thu, 13 Mar 2025 16:03:46 +0100
Message-Id: <20250313150346.356612-16-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313150346.356612-1-jedrzej.jagielski@intel.com>
References: <20250313150346.356612-1-jedrzej.jagielski@intel.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 33 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 26 +++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 ++
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  1 +
 6 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 87ec2dea5862..88335912bd6f 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -499,7 +499,8 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 
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
index 84b015e2dac2..bc1a5775a3a0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1831,6 +1831,22 @@ static bool ixgbe_fw_recovery_mode_e610(struct ixgbe_hw *hw)
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
@@ -3163,6 +3179,21 @@ int ixgbe_get_inactive_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm)
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
@@ -3897,6 +3928,8 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.get_media_type			= ixgbe_get_media_type_e610,
 	.setup_link			= ixgbe_setup_link_e610,
 	.fw_recovery_mode		= ixgbe_fw_recovery_mode_e610,
+	.fw_rollback_mode		= ixgbe_fw_rollback_mode_e610,
+	.get_nvm_ver			= ixgbe_get_active_nvm_ver,
 	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
 	.get_bus_info			= ixgbe_get_bus_info_generic,
 	.acquire_swfw_sync		= ixgbe_acquire_swfw_sync_X540,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5c9de1fafd28..ce73a47ce00a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8420,6 +8420,32 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
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
index 6bf6ba7dcdcc..892fa6c1f879 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3525,6 +3525,8 @@ struct ixgbe_mac_operations {
 	int (*get_thermal_sensor_data)(struct ixgbe_hw *);
 	int (*init_thermal_sensor_thresh)(struct ixgbe_hw *hw);
 	bool (*fw_recovery_mode)(struct ixgbe_hw *hw);
+	bool (*fw_rollback_mode)(struct ixgbe_hw *hw);
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


