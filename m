Return-Path: <netdev+bounces-166920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A048A37DDC
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45B4188818B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD11A5B98;
	Mon, 17 Feb 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddH/H/1r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E1155316
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783207; cv=none; b=GGrNyyVVqBZmf8JiwJfSD9V+N60BZ6sRKP8yR0W2MqUj7+IxH361CNVvQLj+xA0AC4yGXs0ZPET4jWkYC4YG+p2bHs+FBiAXPAm4A6L9/gK5VbOOzaEF0B437g1Mmk3WtWxiqntCsm2i7PLVRbyRdytRwsy5vFxYeDD1/hhfPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783207; c=relaxed/simple;
	bh=txIlwQwBYmj3MwndSw3Y0eUYQAu1rReog22AiwBpQpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L44uwUHgN0+YHBWf8diuzo9gvJfva7HqY6Z96Ol4PyvO9b/9BuqzLF+V1ZqVL37u2YOku6jt6fDbhoTlQnaxuOxuCLurpai+ALEONGHaCXbmT7lNc01c9/7Gw8L0a0pMcdVjcWK6ooecZRo7isWHxAbLlafzTCiMryaseDV/ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddH/H/1r; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739783206; x=1771319206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txIlwQwBYmj3MwndSw3Y0eUYQAu1rReog22AiwBpQpQ=;
  b=ddH/H/1raBaDezCEMF7MuCFfzV5bJMJN2NoeO74p6HOHIkEvdfksYtgd
   g8pKG6K4a5FKHLr7B9/PDclAma5/7TTdW8T9uFYZmZKCPAiOfMPEX/Ta9
   jRC71hTQTEZp2bCm2QLnUnYHcP9sW2uNXA1mBrZQ/KeF0VNI6R5/u3KZc
   B/ltGRu6WslO2gud0H9TRCBgQnOKS7cyh37B2Tm/kU3r2Ubi007TIOwUd
   OHYefkLm9mTJSZF8/Wn0K+2X7ewm58x7UMklKvvF8RPSHdcdoIPY214qQ
   AXVqtmLHzkkS3BjY0quruazMcOXQwOKXTBg8qeiBzZqjk6OlbnqxxIFnO
   w==;
X-CSE-ConnectionGUID: 1cC7Go9ESB2y113uk4PG6w==
X-CSE-MsgGUID: 9jxsk7AORpy2gbz3Msyl0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51078489"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="51078489"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:06:44 -0800
X-CSE-ConnectionGUID: RqZOrp0pSpqB+dnSogsfew==
X-CSE-MsgGUID: X04kE7UTQhiMpGJJpMMXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="113937596"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa006.fm.intel.com with ESMTP; 17 Feb 2025 01:06:42 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de
Subject: [iwl-next v3 2/4] ixgbe: check for MDD events
Date: Mon, 17 Feb 2025 10:06:34 +0100
Message-ID: <20250217090636.25113-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
References: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
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


