Return-Path: <netdev+bounces-205726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04999AFFE03
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB631C25B75
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A928291C2E;
	Thu, 10 Jul 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5nkB00q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D1220F32
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139507; cv=none; b=Qw+jfmBXlB2/WPLMuPL0vPoOBvYgvrbS+YbuLYjnQNkNRUlEMj+aBs0rYpLtF9azgYz4GSr1X3wn6d6dTw/4jzQk++nsQQqnNKdCdI6qsGbha/6vtaTMO1JSKnshq6wtc2Ome9voDOimFeekepXWyBf/TdM4p4L65Ulp97KXV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139507; c=relaxed/simple;
	bh=4FHDJgBt3GJVGc39nnazpXKmRkj9tIT68gP9VqpXssE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hCDQtK7MbJRfN2dhj9FJ0pmH+Rn0xTrgPdBgCOmrImAiK9sJOlZqAEg/VXg+OLhBepn8FKV1HG5EMSBFQa6BtELKF6JwPaXXm9SbRo/g1wcQQSxga4kxrNImRxWCF1lpLb3XOF3TJ2Nh19UCqbknp7seqO4EsZ6AisRnvQhuEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5nkB00q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752139506; x=1783675506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4FHDJgBt3GJVGc39nnazpXKmRkj9tIT68gP9VqpXssE=;
  b=a5nkB00qbo+saAKkUyo8lA3q7LOqZh0IGUfMr4tK+aGR+dTQpd1fNAEm
   PARQTxBFpv5K0NtlibldnuV1b7lrFnZODSPsJaTLqhCxaEmFCToVnBthC
   4VHP7p6cfkWESH5YK5C+c+NllQamSF/SgTUjyvsq8XWVOJDeNq7Matuxf
   HIcZDTMU+MyT9hA/csV60m0gu15TBU/yCa4Pu+SjyYUraO3OUSDJb2Y1F
   EDj+nOljRvwTQmVhD1C5H7Oy68AN1+7ZXW7984cQTWnkGigy7yI3lHJJU
   yM0Hy532wUHfsNY+19W09Zr0ht2TkZ+W6zliGXekeUfomjo4pY3/P22Ia
   w==;
X-CSE-ConnectionGUID: dnpx1T8TQLGAhRR/NUg9Aw==
X-CSE-MsgGUID: rj9+1/PKRjem/2CFo1QFcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54386014"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54386014"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:25:05 -0700
X-CSE-ConnectionGUID: f+8mMgxHSJGrCUUrY3eiAw==
X-CSE-MsgGUID: LY2qwmd3S+WJXqenjjQjDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155788710"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.51])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:25:02 -0700
From: Vitaly Lifshits <vitaly.lifshits@intel.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: dima.ruinskiy@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: [RFC net-next v1 1/1] e1000e: Introduce private flag and module param to disable K1
Date: Thu, 10 Jul 2025 12:24:55 +0300
Message-Id: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The K1 state reduces power consumption on ICH family network controllers
during idle periods, similarly to L1 state on PCI Express NICs. Therefore,
it is recommended and enabled by default.
However, on some systems it has been observed to have adverse side
effects, such as packet loss. It has been established through debug that
the problem may be due to firmware misconfiguration of specific systems,
interoperability with certain link partners, or marginal electrical
conditions of specific units.

These problems typically cannot be fixed in the field, and generic
workarounds to resolve the side effects on all systems, while keeping K1
enabled, were found infeasible.
Therefore, add the option for system administrators to globally disable
K1 idle state on the adapter.

Link: https://lore.kernel.org/intel-wired-lan/CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.com/
Link: https://lore.kernel.org/intel-wired-lan/20250626153544.1853d106@onyx.my.domain/
Link: https://lore.kernel.org/intel-wired-lan/Z_z9EjcKtwHCQcZR@mail-itl/

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   |  1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c | 16 ++++++--
 drivers/net/ethernet/intel/e1000e/hw.h      |  1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 44 +++++++++++----------
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  2 +
 drivers/net/ethernet/intel/e1000e/netdev.c  |  7 ++++
 drivers/net/ethernet/intel/e1000e/param.c   | 27 +++++++++++++
 7 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 952898151565..5c284468de74 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -461,6 +461,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
 #define FLAG2_CHECK_RX_HWTSTAMP           BIT(13)
 #define FLAG2_CHECK_SYSTIM_OVERFLOW       BIT(14)
 #define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
+#define FLAG2_DISABLE_K1		   BIT(16)
 
 #define E1000_RX_DESC_PS(R, i)	    \
 	(&(((union e1000_rx_desc_packet_split *)((R).desc))[i]))
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..cc1ea2daa324 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -26,6 +26,8 @@ struct e1000_stats {
 static const char e1000e_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define E1000E_PRIV_FLAGS_S0IX_ENABLED	BIT(0)
 	"s0ix-enabled",
+#define E1000E_PRIV_FLAGS_DISABLE_K1	BIT(1)
+	"disable-k1",
 };
 
 #define E1000E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(e1000e_priv_flags_strings)
@@ -2304,23 +2306,31 @@ static u32 e1000e_get_priv_flags(struct net_device *netdev)
 	if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
 		priv_flags |= E1000E_PRIV_FLAGS_S0IX_ENABLED;
 
+	if (adapter->flags2 & FLAG2_DISABLE_K1)
+		priv_flags |= E1000E_PRIV_FLAGS_DISABLE_K1;
+
 	return priv_flags;
 }
 
 static int e1000e_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
+	struct e1000_hw *hw = &adapter->hw;
 	unsigned int flags2 = adapter->flags2;
 
-	flags2 &= ~FLAG2_ENABLE_S0IX_FLOWS;
+	flags2 &= ~(FLAG2_ENABLE_S0IX_FLOWS | FLAG2_DISABLE_K1);
 	if (priv_flags & E1000E_PRIV_FLAGS_S0IX_ENABLED) {
-		struct e1000_hw *hw = &adapter->hw;
-
 		if (hw->mac.type < e1000_pch_cnp)
 			return -EINVAL;
 		flags2 |= FLAG2_ENABLE_S0IX_FLOWS;
 	}
 
+	if (priv_flags & E1000E_PRIV_FLAGS_DISABLE_K1) {
+		if (hw->mac.type < e1000_ich8lan)
+			return -EINVAL;
+		flags2 |= FLAG2_DISABLE_K1;
+	}
+
 	if (flags2 != adapter->flags2)
 		adapter->flags2 = flags2;
 
diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index fc8ed38aa095..655872c99a9b 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -709,6 +709,7 @@ struct e1000_dev_spec_ich8lan {
 	struct e1000_shadow_ram shadow_ram[E1000_ICH8_SHADOW_RAM_WORDS];
 	bool nvm_k1_enabled;
 	bool eee_disable;
+	bool disable_k1;
 	u16 eee_lp_ability;
 	enum e1000_ulp_state ulp_state;
 };
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index df4e7d781cb1..bdb6fa97e108 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -286,21 +286,23 @@ static void e1000_toggle_lanphypc_pch_lpt(struct e1000_hw *hw)
 }
 
 /**
- * e1000_reconfigure_k1_exit_timeout - reconfigure K1 exit timeout to
- * align to MTP and later platform requirements.
+ * e1000_reconfigure_k1_params - reconfigure Kumeran K1 parameters.
  * @hw: pointer to the HW structure
  *
  * Context: PHY semaphore must be held by caller.
  * Return: 0 on success, negative on failure
  */
-static s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
+s32 e1000_reconfigure_k1_params(struct e1000_hw *hw)
 {
 	u16 phy_timeout;
 	u32 fextnvm12;
 	s32 ret_val;
 
-	if (hw->mac.type < e1000_pch_mtp)
+	if (hw->mac.type < e1000_pch_mtp) {
+		if (hw->dev_spec.ich8lan.disable_k1)
+			return e1000_configure_k1_ich8lan(hw, false);
 		return 0;
+	}
 
 	/* Change Kumeran K1 power down state from P0s to P1 */
 	fextnvm12 = er32(FEXTNVM12);
@@ -310,9 +312,12 @@ static s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
 
 	/* Wait for the interface the settle */
 	usleep_range(1000, 1100);
+	if (hw->dev_spec.ich8lan.disable_k1)
+		return e1000_configure_k1_ich8lan(hw, false);
 
 	/* Change K1 exit timeout */
-	ret_val = e1e_rphy_locked(hw, I217_PHY_TIMEOUTS_REG,
+	ret_val = e1e_rphy_locked(hw,
+				  I217_PHY_TIMEOUTS_REG,
 				  &phy_timeout);
 	if (ret_val)
 		return ret_val;
@@ -320,8 +325,7 @@ static s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
 	phy_timeout &= ~I217_PHY_TIMEOUTS_K1_EXIT_TO_MASK;
 	phy_timeout |= 0xF00;
 
-	return e1e_wphy_locked(hw, I217_PHY_TIMEOUTS_REG,
-				  phy_timeout);
+	return e1e_wphy_locked(hw, I217_PHY_TIMEOUTS_REG, phy_timeout);
 }
 
 /**
@@ -373,8 +377,8 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		/* At this point the PHY might be inaccessible so don't
 		 * propagate the failure
 		 */
-		if (e1000_reconfigure_k1_exit_timeout(hw))
-			e_dbg("Failed to reconfigure K1 exit timeout\n");
+		if (e1000_reconfigure_k1_params(hw))
+			e_dbg("Failed to reconfigure K1 parameters\n");
 
 		fallthrough;
 	case e1000_pch_lpt:
@@ -473,10 +477,10 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		if (hw->mac.type >= e1000_pch_mtp) {
 			ret_val = hw->phy.ops.acquire(hw);
 			if (ret_val) {
-				e_err("Failed to reconfigure K1 exit timeout\n");
+				e_err("Failed to reconfigure K1 parameters\n");
 				goto out;
 			}
-			ret_val = e1000_reconfigure_k1_exit_timeout(hw);
+			ret_val = e1000_reconfigure_k1_params(hw);
 			hw->phy.ops.release(hw);
 		}
 	}
@@ -4948,17 +4952,15 @@ static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 	u16 i;
 
 	e1000_initialize_hw_bits_ich8lan(hw);
-	if (hw->mac.type >= e1000_pch_mtp) {
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
+	ret_val = hw->phy.ops.acquire(hw);
+	if (ret_val)
+		return ret_val;
 
-		ret_val = e1000_reconfigure_k1_exit_timeout(hw);
-		hw->phy.ops.release(hw);
-		if (ret_val) {
-			e_dbg("Error failed to reconfigure K1 exit timeout\n");
-			return ret_val;
-		}
+	ret_val = e1000_reconfigure_k1_params(hw);
+	hw->phy.ops.release(hw);
+	if (ret_val) {
+		e_dbg("Error failed to reconfigure K1 parameters\n");
+		return ret_val;
 	}
 
 	/* Initialize identification LED */
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 5feb589a9b5f..97ceb6fa763b 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -310,4 +310,6 @@ s32 e1000_read_emi_reg_locked(struct e1000_hw *hw, u16 addr, u16 *data);
 s32 e1000_write_emi_reg_locked(struct e1000_hw *hw, u16 addr, u16 data);
 s32 e1000_set_eee_pchlan(struct e1000_hw *hw);
 s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx);
+s32 e1000_reconfigure_k1_params(struct e1000_hw *hw);
+
 #endif /* _E1000E_ICH8LAN_H_ */
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7719e15813ee..03c3c238bbc7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5267,6 +5267,11 @@ static void e1000_watchdog_task(struct work_struct *work)
 						  &adapter->link_duplex);
 			e1000_print_link_info(adapter);
 
+			if (adapter->flags2 & FLAG2_DISABLE_K1) {
+				adapter->hw.dev_spec.ich8lan.disable_k1 = true;
+				e1000_reconfigure_k1_params(&adapter->hw);
+			}
+
 			/* check if SmartSpeed worked */
 			e1000e_check_downshift(hw);
 			if (phy->speed_downgraded)
@@ -7474,6 +7479,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->bd_number = cards_found++;
 
 	e1000e_check_options(adapter);
+	if (adapter->flags2 & FLAG2_DISABLE_K1)
+		adapter->hw.dev_spec.ich8lan.disable_k1 = true;
 
 	/* setup adapter struct */
 	err = e1000_sw_init(adapter);
diff --git a/drivers/net/ethernet/intel/e1000e/param.c b/drivers/net/ethernet/intel/e1000e/param.c
index 3132d8f2f207..28d78a42a06f 100644
--- a/drivers/net/ethernet/intel/e1000e/param.c
+++ b/drivers/net/ethernet/intel/e1000e/param.c
@@ -136,6 +136,15 @@ E1000_PARAM(WriteProtectNVM,
 E1000_PARAM(CrcStripping,
 	    "Enable CRC Stripping, disable if your BMC needs the CRC");
 
+/* Enable K1
+ *
+ * Valid Range: 0, 1
+ *
+ * Default Value: 1 (enabled)
+ */
+E1000_PARAM(EnableK1,
+	    "Enable Kumeran K1 state [WARNING: Disabling K1 may cause increased power consumption]");
+
 struct e1000_option {
 	enum { enable_option, range_option, list_option } type;
 	const char *name;
@@ -524,4 +533,22 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 			}
 		}
 	}
+	/* Enable K1 */
+	{
+		static const struct e1000_option opt = {
+			.type = enable_option,
+			.name = "Kumeran K1 State",
+			.err = "defaulting to Enabled",
+			.def = OPTION_ENABLED
+		};
+
+		if (num_EnableK1 > bd) {
+			unsigned int enable_k1 = EnableK1[bd];
+			e1000_validate_option(&enable_k1, &opt, adapter);
+
+			if (hw->mac.type >= e1000_ich8lan)
+				if (!enable_k1)
+					adapter->flags2 |= FLAG2_DISABLE_K1;
+		}
+	}
 }
-- 
2.34.1


