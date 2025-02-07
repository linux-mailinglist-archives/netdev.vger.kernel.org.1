Return-Path: <netdev+bounces-163926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60ABA2C0D2
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C61884D19
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23901DE895;
	Fri,  7 Feb 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhGBhVDC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF881DE89B
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925032; cv=none; b=cd2AE67mCHjWRrJjAv9pxuNyUqvtFfP8PJjaL+DsRwxqrFVgug/JAe42CJ2Dh+Rkx5QJSxThEgzchehVg8tKZp7mEprUAjk/SsvTIKoIdIhjK5Sv/aIusDbiu5CnFauIrIQqgMe5z/G8e7ylVp3Ki4u9eKBedu51deHikC9+PlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925032; c=relaxed/simple;
	bh=txIlwQwBYmj3MwndSw3Y0eUYQAu1rReog22AiwBpQpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGA+AKOvPi5C925HNQEXbUTbcMaA/HkgJiupwdX6sm3HDt390kxoUM503Id1/I0aZfPEKBZsJUkYAHLYFSUmS3XKVxBqYzrj8c0Ayl5BachqSWDHV8qWws6+Cz8c/6heEeOY4d3sbzxCd3mCvjPs3QfB3sgIAeOuQ64vJgMaqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhGBhVDC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738925031; x=1770461031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txIlwQwBYmj3MwndSw3Y0eUYQAu1rReog22AiwBpQpQ=;
  b=GhGBhVDCrsB/kd503XvxH001Oz2cBZtOdPCrgJBgYF1bY2VnDHOTh3hG
   LfXwrAVSZ/tCScCXL0nPnSL7M95H9mk3xZYwEYAlD0oD2KSw9m3kLUrov
   3JeZPZV6ePZHlLa0d9j6GQcy3KdF9YJNrKlD1mPSf+8i3ZiWmcPLxanjV
   66Ia84U56VoU2PDLDifh7nLnYlLpJTUn7Go7SCqho0OOVaJjxKGWbY9n5
   APu0VVlFdQmf0waiEIWgak5ordq7Tiv9d/ARt7FVqabSnyu6lfqWOO4Rh
   AIa3Osmt3VeX/kmLk0r+kcUVL3yKgXwYc7WaNA7G38o8XTf05GfqSw9Ti
   Q==;
X-CSE-ConnectionGUID: IX8PhQlcTvKMTowf1kYGBQ==
X-CSE-MsgGUID: AXFGEb4GQfuFYGcmGM/+Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="62039832"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="62039832"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 02:43:51 -0800
X-CSE-ConnectionGUID: K0TRHe6oQx2sXk5O7g63KQ==
X-CSE-MsgGUID: ZfoTiboIQa+losFgjaf0dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116429791"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 07 Feb 2025 02:43:48 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com
Subject: [iwl-next v1 2/4] ixgbe: check for MDD events
Date: Fri,  7 Feb 2025 11:43:41 +0100
Message-ID: <20250207104343.2791001-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
References: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Don Skidmore <donald.c.skidmore@intel.com>

When an event is detected it is logged and, for the time being, the
queue is immediately re-enabled.  This is due to the lack of an API
to the hypervisor so it could deal with it as it chooses.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.h    |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 ++
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 50 +++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
index 0690ecb8dfa3..bc4cab976bf9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_PCI_IOV
 void ixgbe_restore_vf_multicasts(struct ixgbe_adapter *adapter);
 #endif
+bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter);
 void ixgbe_msg_task(struct ixgbe_adapter *adapter);
 int ixgbe_vf_configuration(struct pci_dev *pdev, unsigned int event_mask);
 void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index d446c375335a..aa3b498558bc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -402,6 +402,8 @@ struct ixgbe_nvm_version {
 #define IXGBE_MRCTL(_i)      (0x0F600 + ((_i) * 4))
 #define IXGBE_VMRVLAN(_i)    (0x0F610 + ((_i) * 4))
 #define IXGBE_VMRVM(_i)      (0x0F630 + ((_i) * 4))
+#define IXGBE_LVMMC_RX	     0x2FA8
+#define IXGBE_LVMMC_TX	     0x8108
 #define IXGBE_WQBR_RX(_i)    (0x2FB0 + ((_i) * 4)) /* 4 total */
 #define IXGBE_WQBR_TX(_i)    (0x8130 + ((_i) * 4)) /* 4 total */
 #define IXGBE_L34T_IMIR(_i)  (0x0E800 + ((_i) * 4)) /*128 of these (0-127)*/
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 467f81239e12..3ff48207165c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7959,6 +7959,9 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	netif_carrier_on(netdev);
 	ixgbe_check_vf_rate_limit(adapter);
 
+	if (adapter->num_vfs && hw->mac.ops.enable_mdd)
+		hw->mac.ops.enable_mdd(hw);
+
 	/* enable transmits */
 	netif_tx_wake_all_queues(adapter->netdev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index ccdce80edd14..c374ebd4a56b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -207,6 +207,7 @@ void ixgbe_enable_sriov(struct ixgbe_adapter *adapter, unsigned int max_vfs)
 int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 {
 	unsigned int num_vfs = adapter->num_vfs, vf;
+	struct ixgbe_hw *hw = &adapter->hw;
 	unsigned long flags;
 	int rss;
 
@@ -237,6 +238,9 @@ int ixgbe_disable_sriov(struct ixgbe_adapter *adapter)
 	if (!(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED))
 		return 0;
 
+	if (hw->mac.ops.disable_mdd)
+		hw->mac.ops.disable_mdd(hw);
+
 #ifdef CONFIG_PCI_IOV
 	/*
 	 * If our VFs are assigned we cannot shut down SR-IOV
@@ -1353,12 +1357,58 @@ static void ixgbe_rcv_ack_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 		ixgbe_write_mbx(hw, &msg, 1, vf);
 }
 
+/**
+ * ixgbe_check_mdd_event - check for MDD event on all VFs
+ * @adapter: pointer to ixgbe adapter
+ *
+ * Return: true if there is a VF on which MDD event occurred, false otherwise.
+ */
+bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	DECLARE_BITMAP(vf_bitmap, 64);
+	bool ret = false;
+	int i;
+
+	if (!hw->mac.ops.handle_mdd)
+		return false;
+
+	/* Did we have a malicious event */
+	hw->mac.ops.handle_mdd(hw, vf_bitmap);
+
+	/* Log any blocked queues and release lock */
+	for_each_set_bit(i, vf_bitmap, 64) {
+		dev_warn(&adapter->pdev->dev,
+			 "Malicious event on VF %d tx:%x rx:%x\n", i,
+			 IXGBE_READ_REG(hw, IXGBE_LVMMC_TX),
+			 IXGBE_READ_REG(hw, IXGBE_LVMMC_RX));
+
+		if (hw->mac.ops.restore_mdd_vf) {
+			u32 ping;
+
+			hw->mac.ops.restore_mdd_vf(hw, i);
+
+			/* get the VF to rebuild its queues */
+			adapter->vfinfo[i].clear_to_send = 0;
+			ping = IXGBE_PF_CONTROL_MSG |
+			       IXGBE_VT_MSGTYPE_CTS;
+			ixgbe_write_mbx(hw, &ping, 1, i);
+		}
+
+		ret = true;
+	}
+
+	return ret;
+}
+
 void ixgbe_msg_task(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	unsigned long flags;
 	u32 vf;
 
+	ixgbe_check_mdd_event(adapter);
+
 	spin_lock_irqsave(&adapter->vfs_lock, flags);
 	for (vf = 0; vf < adapter->num_vfs; vf++) {
 		/* process any reset requests */
-- 
2.42.0


