Return-Path: <netdev+bounces-174212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342D4A5DDB0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888FA189F47A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FE4253341;
	Wed, 12 Mar 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEYKqJiA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB824C074
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785210; cv=none; b=lzXAuk0+aqHN9Qtbdm7CyPhfZSxm5pTxhPTdvQ9sM6NijX1ALztatBVml5oN0wuQyPD80K16WOr6vdFUOO1JtEKpANCBuJnmiIyt+V8e4HyfeXC9BOei1WAqwDkNhqPmiJcF7Oj4DF7cCr0zvZaIHqWNRidf+i2ki7UnJVsdCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785210; c=relaxed/simple;
	bh=f8y/rQZ4lb9rJA0scGNaVMp8V3mo2o89tiDVtfNV+BM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vi2D6M/0PdQWyLU5GmljqmZDzhAiDHBh6B1Yh7tSJj0LklhWRpypaGIix6S3rLy185TUeNXj7uK9dTAoidCyMwXBbOAoLzNbyAEIwncsWPMBke06VSAqWhwEOGS+WXRw/agd/YN+8Lm9qluQ+GZ6LG7n2I4Li0mcmr1MnwhhYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEYKqJiA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741785209; x=1773321209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f8y/rQZ4lb9rJA0scGNaVMp8V3mo2o89tiDVtfNV+BM=;
  b=HEYKqJiAYNw3Le67EgAZ7BDYLKtKAoT7MSlpwgHOhXHX4jiwxBjWuH8P
   sxrzWAuauo4uPOnW9Y8x7LLRlcEDCpG6UaXeyRzTFL2nKqIQZgOv5lX8q
   HKD1Wf/pFihCf4O58jMTT96zIWhd5BOHrkUMm2s5zXO4xZsMj1EO7G3Fe
   0pAOnJDRZ1FuTmoHqIKjTtKZG6+ZsZQ4Lgauyn8NEH6oz7wBJ2zPdv9TG
   X7f26f4YuoIJKNAOpZ23qBxsZXQqHNWrnKMu2bR3mAk9qGi1GEHhB87sD
   JqMBQSsoDaO4k9Og3HUv6r0Acd8fDAZFNujWEDQhuMNkBnczNlUXX2g26
   A==;
X-CSE-ConnectionGUID: pnulFWXbSz+MjRJIqBzsqQ==
X-CSE-MsgGUID: gaRhWxkkTNOk0Cvszm+qhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53510747"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53510747"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:13:29 -0700
X-CSE-ConnectionGUID: iiadsBg8T/mgD7jlYQMxmQ==
X-CSE-MsgGUID: LIYXY6LlRSSmUfXhjepVgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121542218"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2025 06:13:27 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v7 13/15] ixgbe: add FW API version check
Date: Wed, 12 Mar 2025 13:58:41 +0100
Message-Id: <20250312125843.347191-14-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
References: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add E610 specific function checking whether the FW API version
is compatible with the driver expectations.

The major API version should be less than or equal to the expected
API version. If not the driver won't be fully operational.

Check the minor version, and if it is more than two versions lesser
or greater than the expected version, print a message indicating
that the NVM or driver should be updated respectively.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v5: add get_fw_ver
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 34 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  1 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  4 +++
 6 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 391d53503627..87ec2dea5862 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -499,6 +499,8 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 
 	*actions_performed = BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
 
+	adapter->flags2 &= ~IXGBE_FLAG2_API_MISMATCH;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 83d4d7368cda..2246997bc9fb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -671,6 +671,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_PHY_FW_LOAD_FAILED		BIT(20)
 #define IXGBE_FLAG2_NO_MEDIA			BIT(21)
 #define IXGBE_FLAG2_MOD_POWER_UNSUPPORTED	BIT(22)
+#define IXGBE_FLAG2_API_MISMATCH		BIT(23)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index e6b35792fdee..5aa66534aa75 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3877,6 +3877,7 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.led_off			= ixgbe_led_off_generic,
 	.init_led_link_act		= ixgbe_init_led_link_act_generic,
 	.reset_hw			= ixgbe_reset_hw_e610,
+	.get_fw_ver                     = ixgbe_aci_get_fw_ver,
 	.get_media_type			= ixgbe_get_media_type_e610,
 	.setup_link			= ixgbe_setup_link_e610,
 	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9892d3f41620..de74132f9001 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8361,6 +8361,34 @@ static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
 	rtnl_unlock();
 }
 
+static int ixgbe_check_fw_api_mismatch(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	if (hw->mac.type != ixgbe_mac_e610)
+		return 0;
+
+	if (hw->mac.ops.get_fw_ver && hw->mac.ops.get_fw_ver(hw))
+		return 0;
+
+	if (hw->api_maj_ver > IXGBE_FW_API_VER_MAJOR) {
+		e_dev_err("The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
+
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+		return -EOPNOTSUPP;
+	} else if (hw->api_maj_ver == IXGBE_FW_API_VER_MAJOR &&
+		   hw->api_min_ver > IXGBE_FW_API_VER_MINOR + IXGBE_FW_API_VER_DIFF_ALLOWED) {
+		e_dev_info("The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+	} else if (hw->api_maj_ver < IXGBE_FW_API_VER_MAJOR ||
+		   hw->api_min_ver < IXGBE_FW_API_VER_MINOR - IXGBE_FW_API_VER_DIFF_ALLOWED) {
+		e_dev_info("The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+	}
+
+	return 0;
+}
+
 /**
  * ixgbe_check_fw_error - Check firmware for errors
  * @adapter: the adapter private structure
@@ -8371,6 +8399,7 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 fwsm;
+	int err;
 
 	/* read fwsm.ext_err_ind register and log errors */
 	fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
@@ -8385,6 +8414,11 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 		e_dev_err("Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
 		return true;
 	}
+	if (!(adapter->flags2 & IXGBE_FLAG2_API_MISMATCH)) {
+		err = ixgbe_check_fw_api_mismatch(adapter);
+		if (err)
+			return true;
+	}
 
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 5f814f023573..6bf6ba7dcdcc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3456,6 +3456,7 @@ struct ixgbe_mac_operations {
 	int (*start_hw)(struct ixgbe_hw *);
 	int (*clear_hw_cntrs)(struct ixgbe_hw *);
 	enum ixgbe_media_type (*get_media_type)(struct ixgbe_hw *);
+	int (*get_fw_ver)(struct ixgbe_hw *hw);
 	int (*get_mac_addr)(struct ixgbe_hw *, u8 *);
 	int (*get_san_mac_addr)(struct ixgbe_hw *, u8 *);
 	int (*get_device_caps)(struct ixgbe_hw *, u16 *);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 93d854b8a92e..4d591019dd07 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -112,6 +112,10 @@
 #define IXGBE_PF_HICR_SV			BIT(2)
 #define IXGBE_PF_HICR_EV			BIT(3)
 
+#define IXGBE_FW_API_VER_MAJOR		0x01
+#define IXGBE_FW_API_VER_MINOR		0x07
+#define IXGBE_FW_API_VER_DIFF_ALLOWED	0x02
+
 #define IXGBE_ACI_DESC_SIZE		32
 #define IXGBE_ACI_DESC_SIZE_IN_DWORDS	(IXGBE_ACI_DESC_SIZE / BYTES_PER_DWORD)
 
-- 
2.31.1


