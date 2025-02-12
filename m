Return-Path: <netdev+bounces-165435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A80A3205A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA3D3A5FC5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58BB2046B9;
	Wed, 12 Feb 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWdCOHAv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1831204694
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347052; cv=none; b=InlsR6EZ6JpTbsY7hx3L5LORWx/pt9cLWu8FnCyY2d1CqIUwZT0g+HVhfHJupa3vJ8XYqvPF4GTjREXxoQE+rh/YnqpFoX6oTGYIdtS7uNCkb/nh6SPRIry55foKGVt24v31AmjNIjbYTtVYhRHwBpnRV1ydas8dCTz/x8vm8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347052; c=relaxed/simple;
	bh=+r6KnAcDVpkoAHYw8iFtiV+DY+pi7pukgZUBnjg1mZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b45fZD0MZj2W10DAqv9JHjuG9jwhETc5QH8HbCkHvhtI5b4Ftw4PBLF4wGsq+fy1B5bO1obfXsAmHBpaR4w6oSqSOhKe29WJ58MnQIndLDXdJiUQ/5Ji7kYcM4Ogi4BsL73q5F5FR0nOWTagDhhtZdqTPBNtA/QzbG8r/gVGan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWdCOHAv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739347051; x=1770883051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+r6KnAcDVpkoAHYw8iFtiV+DY+pi7pukgZUBnjg1mZc=;
  b=lWdCOHAvMg21tS1L02agJIA+dC/mj1+6QwKwUBrZJYZpDC44WFzeK2mb
   KFeyL5PgozXMovUTV0dPuuHiOJie5xrOIghreUOFGWpRJRwE44niZ2UJs
   ORJ447UF53v3F48+D/fIRYpyDOYrbOyUlv+Jzhp/6i4s0LWCNpGNv4Fn7
   4phKOSnfONkNdQAhPTkgsB0qJgXNhEzchNq8S64WbxahgRZ3Xg/rKsDem
   SctmbECKMctr68rnySnupvWPePjANLrCLfH0HVh36VKA8fGNG5Sas1GJd
   s36MuKSP+ovAfrNX4rCz3wzAObFG82GzRAgfJQQ2r6u+ZDyaFM1s4R+q8
   w==;
X-CSE-ConnectionGUID: wb3kFIa0QcGdoB0yD99zWA==
X-CSE-MsgGUID: OmuL5eQdRt67CHAcPlarqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50212346"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50212346"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 23:57:31 -0800
X-CSE-ConnectionGUID: dPrkRuUeS52sMEeWjZ40qw==
X-CSE-MsgGUID: GycKQyf4R6aI3XCFHqiLWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112579843"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa006.fm.intel.com with ESMTP; 11 Feb 2025 23:57:28 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com,
	horms@kernel.org
Subject: [iwl-next v2 1/4] ixgbe: add MDD support
Date: Wed, 12 Feb 2025 08:57:21 +0100
Message-ID: <20250212075724.3352715-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250212075724.3352715-1-michal.swiatkowski@linux.intel.com>
References: <20250212075724.3352715-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

Add malicious driver detection. Support enabling MDD, disabling MDD,
handling a MDD event, and restoring a MDD VF.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  28 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 120 ++++++++++++++++++
 4 files changed, 157 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 5fdf32d79d82..d446c375335a 100644
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
@@ -3534,6 +3556,12 @@ struct ixgbe_mac_operations {
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
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index cb07ecd8937d..788f3372ebf1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2630,6 +2630,10 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.prot_autoc_write		= prot_autoc_write_generic,
 	.setup_fc			= ixgbe_setup_fc_e610,
 	.fc_autoneg			= ixgbe_fc_autoneg_e610,
+	.enable_mdd			= ixgbe_enable_mdd_x550,
+	.disable_mdd			= ixgbe_disable_mdd_x550,
+	.restore_mdd_vf			= ixgbe_restore_mdd_vf_x550,
+	.handle_mdd			= ixgbe_handle_mdd_x550,
 };
 
 static const struct ixgbe_phy_operations phy_ops_e610 = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 277ceaf8a793..b5cbfd1f71fd 100644
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
-- 
2.42.0


