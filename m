Return-Path: <netdev+bounces-203896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E45AF7F49
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B1F584712
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B962F235C;
	Thu,  3 Jul 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnElgf2W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E352F237A
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564573; cv=none; b=rxtr08JSudjpR6cnpH/VTQnS+iWPh4zmRUy5pd7p4NZWjvvpbHPlvY3Alh7YbbZEjdzUbd+7/JgPcV+9upiSMZ0Bj2DTiZHPYpfjWviGDnr90J7G21B+H2RVzzwuvv10gnyCKLrSq05nZWwbzu+K6Mk1dAVn7ZudBVvNE9uDc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564573; c=relaxed/simple;
	bh=csO0ykXEBWopPfPKvT8Yh6AI+JBISxQAkO+lDUMbwPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMAe6y5SI7gE8PWdwenUr1+Y5zBLt0bn/mtOaInlh8SYpF1+CEXXQ5kCuOR6N8cFc9zslzruYnrWiDXo4tZs7iPm9mMN9w9IuMjXmx1s3bC3jvlbs6jrPbrFRbDJg6rncJQbDVY8tTB6JQcxOSyhp9vhg2qNtuHLUo2vvJNrFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnElgf2W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564572; x=1783100572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csO0ykXEBWopPfPKvT8Yh6AI+JBISxQAkO+lDUMbwPc=;
  b=bnElgf2W78szEV4aPmohoco7Whn3FdDG73X6vVBXaoi0ivCiVPs221Ke
   EHdug16wzdTcHrFDxiQtrozKAnHrtzMbDAZat8snLOAb0kq+QJv6Ub4/4
   sKT22WlN5hXZoH7twR4YstXHUZ0+z2vdo/DYK2Ej3Mm9xvUfnEfZfvuVa
   aM9iyR8Zz/86IsQ7z/iPrifmZzLVLE6/FSSeB+QZgDA2UJGSBujUQq92v
   cSolZ4kKddcQLZbLvW+hGIAU9t9+moPYw/i8tWVxSUSWCpHvoFTDv6J8c
   UyZvJJOR2IsDj/QJv6ciilPIy4zRWGZu1uyV4yk/1j3Xkgod+IChXWW0M
   A==;
X-CSE-ConnectionGUID: wQmN7VKCTimsfkBOP4yiHg==
X-CSE-MsgGUID: Hgi5uap4SV+6t96GEpJf1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767937"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767937"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:50 -0700
X-CSE-ConnectionGUID: HTrMhSBLQcKWJSSRjzZKgA==
X-CSE-MsgGUID: U0+jXUbfThaJ+NMSwfkHBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997903"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@intel.com,
	piotr.kwapulinski@intel.com,
	marcin.szycik@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 06/12] ixgbe: add MDD support
Date: Thu,  3 Jul 2025 10:42:33 -0700
Message-ID: <20250703174242.3829277-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

Add malicious driver detection to ixgbe driver. The supported devices
are E610 and X550.

Handling MDD events is enabled while VFs are created and turned off
when they are disabled. There is no runtime command to enable or
disable MDD independently.

MDD event is logged when malicious VF driver is detected. For example VF
can try to send incorrect Tx descriptor (TSO on, but length field not
correct). It can be reproduced by manipulating the driver, or using
driver with incorrect descriptor values.

Example log:
"Malicious event on VF 0 tx:128 rx:128"

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  28 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 120 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   5 +
 4 files changed, 157 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 71ea25de1bac..87b03c1992a8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3965,6 +3965,10 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.prot_autoc_write		= prot_autoc_write_generic,
 	.setup_fc			= ixgbe_setup_fc_e610,
 	.fc_autoneg			= ixgbe_fc_autoneg_e610,
+	.enable_mdd			= ixgbe_enable_mdd_x550,
+	.disable_mdd			= ixgbe_disable_mdd_x550,
+	.restore_mdd_vf			= ixgbe_restore_mdd_vf_x550,
+	.handle_mdd			= ixgbe_handle_mdd_x550,
 };
 
 static const struct ixgbe_phy_operations phy_ops_e610 = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 892fa6c1f879..2a25abc0b17a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2746,6 +2746,28 @@ enum ixgbe_fdir_pballoc_type {
 #define FW_PHY_INFO_ID_HI_MASK		0xFFFF0000u
 #define FW_PHY_INFO_ID_LO_MASK		0x0000FFFFu
 
+/* There are only 3 options for VFs creation on this device:
+ * 16 VFs pool with 8 queues each
+ * 32 VFs pool with 4 queues each
+ * 64 VFs pool with 2 queues each
+ *
+ * That means reading some VF registers that map VF to queue depending on
+ * chosen option. Define values that help dealing with each scenario.
+ */
+/* Number of queues based on VFs pool */
+#define IXGBE_16VFS_QUEUES		8
+#define IXGBE_32VFS_QUEUES		4
+#define IXGBE_64VFS_QUEUES		2
+/* Mask for getting queues bits based on VFs pool */
+#define IXGBE_16VFS_BITMASK		GENMASK(IXGBE_16VFS_QUEUES - 1, 0)
+#define IXGBE_32VFS_BITMASK		GENMASK(IXGBE_32VFS_QUEUES - 1, 0)
+#define IXGBE_64VFS_BITMASK		GENMASK(IXGBE_64VFS_QUEUES - 1, 0)
+/* Convert queue index to register number.
+ * We have 4 registers with 32 queues in each.
+ */
+#define IXGBE_QUEUES_PER_REG		32
+#define IXGBE_QUEUES_REG_AMOUNT		4
+
 /* Host Interface Command Structures */
 struct ixgbe_hic_hdr {
 	u8 cmd;
@@ -3539,6 +3561,12 @@ struct ixgbe_mac_operations {
 	int (*dmac_config_tcs)(struct ixgbe_hw *hw);
 	int (*read_iosf_sb_reg)(struct ixgbe_hw *, u32, u32, u32 *);
 	int (*write_iosf_sb_reg)(struct ixgbe_hw *, u32, u32, u32);
+
+	/* MDD events */
+	void (*enable_mdd)(struct ixgbe_hw *hw);
+	void (*disable_mdd)(struct ixgbe_hw *hw);
+	void (*restore_mdd_vf)(struct ixgbe_hw *hw, u32 vf);
+	void (*handle_mdd)(struct ixgbe_hw *hw, unsigned long *vf_bitmap);
 };
 
 struct ixgbe_phy_operations {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 7461367a1868..a8263f59ebba 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3800,6 +3800,122 @@ static int ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	return status;
 }
 
+static void ixgbe_set_mdd_x550(struct ixgbe_hw *hw, bool ena)
+{
+	u32 reg_dma, reg_rdr;
+
+	reg_dma = IXGBE_READ_REG(hw, IXGBE_DMATXCTL);
+	reg_rdr = IXGBE_READ_REG(hw, IXGBE_RDRXCTL);
+
+	if (ena) {
+		reg_dma |= (IXGBE_DMATXCTL_MDP_EN | IXGBE_DMATXCTL_MBINTEN);
+		reg_rdr |= (IXGBE_RDRXCTL_MDP_EN | IXGBE_RDRXCTL_MBINTEN);
+	} else {
+		reg_dma &= ~(IXGBE_DMATXCTL_MDP_EN | IXGBE_DMATXCTL_MBINTEN);
+		reg_rdr &= ~(IXGBE_RDRXCTL_MDP_EN | IXGBE_RDRXCTL_MBINTEN);
+	}
+
+	IXGBE_WRITE_REG(hw, IXGBE_DMATXCTL, reg_dma);
+	IXGBE_WRITE_REG(hw, IXGBE_RDRXCTL, reg_rdr);
+}
+
+/**
+ * ixgbe_enable_mdd_x550 - enable malicious driver detection
+ * @hw: pointer to hardware structure
+ */
+void ixgbe_enable_mdd_x550(struct ixgbe_hw *hw)
+{
+	ixgbe_set_mdd_x550(hw, true);
+}
+
+/**
+ * ixgbe_disable_mdd_x550 - disable malicious driver detection
+ * @hw: pointer to hardware structure
+ */
+void ixgbe_disable_mdd_x550(struct ixgbe_hw *hw)
+{
+	ixgbe_set_mdd_x550(hw, false);
+}
+
+/**
+ * ixgbe_restore_mdd_vf_x550 - restore VF that was disabled during MDD event
+ * @hw: pointer to hardware structure
+ * @vf: vf index
+ */
+void ixgbe_restore_mdd_vf_x550(struct ixgbe_hw *hw, u32 vf)
+{
+	u32 idx, reg, val, num_qs, start_q, bitmask;
+
+	/* Map VF to queues */
+	reg = IXGBE_READ_REG(hw, IXGBE_MRQC);
+	switch (reg & IXGBE_MRQC_MRQE_MASK) {
+	case IXGBE_MRQC_VMDQRT8TCEN:
+		num_qs = IXGBE_16VFS_QUEUES;
+		bitmask = IXGBE_16VFS_BITMASK;
+		break;
+	case IXGBE_MRQC_VMDQRSS32EN:
+	case IXGBE_MRQC_VMDQRT4TCEN:
+		num_qs = IXGBE_32VFS_QUEUES;
+		bitmask = IXGBE_32VFS_BITMASK;
+		break;
+	default:
+		num_qs = IXGBE_64VFS_QUEUES;
+		bitmask = IXGBE_64VFS_BITMASK;
+		break;
+	}
+	start_q = vf * num_qs;
+
+	/* Release vf's queues by clearing WQBR_TX and WQBR_RX (RW1C) */
+	idx = start_q / IXGBE_QUEUES_PER_REG;
+	val = bitmask << (start_q % IXGBE_QUEUES_PER_REG);
+	IXGBE_WRITE_REG(hw, IXGBE_WQBR_TX(idx), val);
+	IXGBE_WRITE_REG(hw, IXGBE_WQBR_RX(idx), val);
+}
+
+/**
+ * ixgbe_handle_mdd_x550 - handle malicious driver detection event
+ * @hw: pointer to hardware structure
+ * @vf_bitmap: output vf bitmap of malicious vfs
+ */
+void ixgbe_handle_mdd_x550(struct ixgbe_hw *hw, unsigned long *vf_bitmap)
+{
+	u32 i, j, reg, q, div, vf;
+	unsigned long wqbr;
+
+	/* figure out pool size for mapping to vf's */
+	reg = IXGBE_READ_REG(hw, IXGBE_MRQC);
+	switch (reg & IXGBE_MRQC_MRQE_MASK) {
+	case IXGBE_MRQC_VMDQRT8TCEN:
+		div = IXGBE_16VFS_QUEUES;
+		break;
+	case IXGBE_MRQC_VMDQRSS32EN:
+	case IXGBE_MRQC_VMDQRT4TCEN:
+		div = IXGBE_32VFS_QUEUES;
+		break;
+	default:
+		div = IXGBE_64VFS_QUEUES;
+		break;
+	}
+
+	/* Read WQBR_TX and WQBR_RX and check for malicious queues */
+	for (i = 0; i < IXGBE_QUEUES_REG_AMOUNT; i++) {
+		wqbr = IXGBE_READ_REG(hw, IXGBE_WQBR_TX(i)) |
+		       IXGBE_READ_REG(hw, IXGBE_WQBR_RX(i));
+		if (!wqbr)
+			continue;
+
+		/* Get malicious queue */
+		for_each_set_bit(j, (unsigned long *)&wqbr,
+				 IXGBE_QUEUES_PER_REG) {
+			/* Get queue from bitmask */
+			q = j + (i * IXGBE_QUEUES_PER_REG);
+			/* Map queue to vf */
+			vf = q / div;
+			set_bit(vf, vf_bitmap);
+		}
+	}
+}
+
 #define X550_COMMON_MAC \
 	.init_hw			= &ixgbe_init_hw_generic, \
 	.start_hw			= &ixgbe_start_hw_X540, \
@@ -3863,6 +3979,10 @@ static const struct ixgbe_mac_operations mac_ops_X550 = {
 	.prot_autoc_write	= prot_autoc_write_generic,
 	.setup_fc		= ixgbe_setup_fc_generic,
 	.fc_autoneg		= ixgbe_fc_autoneg,
+	.enable_mdd		= ixgbe_enable_mdd_x550,
+	.disable_mdd		= ixgbe_disable_mdd_x550,
+	.restore_mdd_vf		= ixgbe_restore_mdd_vf_x550,
+	.handle_mdd		= ixgbe_handle_mdd_x550,
 };
 
 static const struct ixgbe_mac_operations mac_ops_X550EM_x = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
index 3e4092f8da3e..2a11147fb1bc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
@@ -17,4 +17,9 @@ void ixgbe_set_source_address_pruning_x550(struct ixgbe_hw *hw,
 void ixgbe_set_ethertype_anti_spoofing_x550(struct ixgbe_hw *hw,
 					    bool enable, int vf);
 
+void ixgbe_enable_mdd_x550(struct ixgbe_hw *hw);
+void ixgbe_disable_mdd_x550(struct ixgbe_hw *hw);
+void ixgbe_restore_mdd_vf_x550(struct ixgbe_hw *hw, u32 vf);
+void ixgbe_handle_mdd_x550(struct ixgbe_hw *hw, unsigned long *vf_bitmap);
+
 #endif /* _IXGBE_X550_H_ */
-- 
2.47.1


