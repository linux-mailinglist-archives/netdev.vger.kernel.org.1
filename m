Return-Path: <netdev+bounces-30512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCE978799D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 22:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9C1C20EC5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1C9A92F;
	Thu, 24 Aug 2023 20:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A06FA928
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 20:51:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6328B198E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692910291; x=1724446291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yBLJ++xfkl9rSXaZAlITFLVmkp3RZi/pB3yoW6yq9zo=;
  b=GhYMeOE4mFLm1FMxDElwzz4lXmj2BflxlJLo9CEXAGBhrtTOwH3MjYhB
   IM335gm8GVOFMmVUHFKknbjaHa/40TKyDWKcL72aDBmCjXznswp1KKzQX
   +nc4T6H/F1i1jIyg/kdAdlh22wLAUjinPnNPKFgdeHcD6DJMjvwTEVy+D
   qryaB+f86Z+tZ3rySpyx+OKqoaEev0iX9Aw5jIgs0BXDxcREjGbjLZIau
   jN0+KM3jxnb/Y56wYsNIvNMYataau+4U7fB8PzAPNI+IvWRtnPtDCaO0G
   WJt3WR9MBG3PmSnlKCV0Fu1/XhZBNXG/7imyn9LUPZtwSKicgMqVUwRoB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364746219"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364746219"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 13:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827312278"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827312278"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 13:51:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 3/3] e1000e: Add support for the next LOM generation
Date: Thu, 24 Aug 2023 13:44:18 -0700
Message-Id: <20230824204418.1551093-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230824204418.1551093-1-anthony.l.nguyen@intel.com>
References: <20230824204418.1551093-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sasha Neftin <sasha.neftin@intel.com>

Add devices IDs for the next LOM generations that will be available on the
next Intel Client platforms. This patch provides the initial support for
these devices.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 2 ++
 drivers/net/ethernet/intel/e1000e/hw.h      | 3 +++
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 7 +++++++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 4 ++++
 drivers/net/ethernet/intel/e1000e/ptp.c     | 1 +
 5 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 721f86fd5802..9835e6a90d56 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -917,6 +917,7 @@ static int e1000_reg_test(struct e1000_adapter *adapter, u64 *data)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		mask |= BIT(18);
 		break;
 	default:
@@ -1585,6 +1586,7 @@ static void e1000_loopback_cleanup(struct e1000_adapter *adapter)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		fext_nvm11 = er32(FEXTNVM11);
 		fext_nvm11 &= ~E1000_FEXTNVM11_DISABLE_MULR_FIX;
 		ew32(FEXTNVM11, fext_nvm11);
diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 29f9fae35f42..1fef6bb5a5fb 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -122,6 +122,8 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_PTP_I219_V26		0x57B6
 #define E1000_DEV_ID_PCH_PTP_I219_LM27		0x57B7
 #define E1000_DEV_ID_PCH_PTP_I219_V27		0x57B8
+#define E1000_DEV_ID_PCH_NVL_I219_LM29		0x57B9
+#define E1000_DEV_ID_PCH_NVL_I219_V29		0x57BA
 
 #define E1000_REVISION_4	4
 
@@ -150,6 +152,7 @@ enum e1000_mac_type {
 	e1000_pch_mtp,
 	e1000_pch_lnp,
 	e1000_pch_ptp,
+	e1000_pch_nvp,
 };
 
 enum e1000_media_type {
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 0c7fd10312c8..39e9fc601bf5 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -323,6 +323,7 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		if (e1000_phy_is_accessible_pchlan(hw))
 			break;
 
@@ -470,6 +471,7 @@ static s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 		case e1000_pch_mtp:
 		case e1000_pch_lnp:
 		case e1000_pch_ptp:
+		case e1000_pch_nvp:
 			/* In case the PHY needs to be in mdio slow mode,
 			 * set slow mode and try to get the PHY id again.
 			 */
@@ -717,6 +719,7 @@ static s32 e1000_init_mac_params_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 	case e1000_pchlan:
 		/* check management mode */
 		mac->ops.check_mng_mode = e1000_check_mng_mode_pchlan;
@@ -1685,6 +1688,7 @@ static s32 e1000_get_variants_ich8lan(struct e1000_adapter *adapter)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		rc = e1000_init_phy_params_pchlan(hw);
 		break;
 	default:
@@ -2142,6 +2146,7 @@ static s32 e1000_sw_lcd_config_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		sw_cfg_mask = E1000_FEXTNVM_SW_CONFIG_ICH8M;
 		break;
 	default:
@@ -3188,6 +3193,7 @@ static s32 e1000_valid_nvm_bank_detect_ich8lan(struct e1000_hw *hw, u32 *bank)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		bank1_offset = nvm->flash_bank_size;
 		act_offset = E1000_ICH_NVM_SIG_WORD;
 
@@ -4129,6 +4135,7 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		word = NVM_COMPAT;
 		valid_csum_mask = NVM_COMPAT_VALID_CSUM;
 		break;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 18a5e73b8680..f536c856727c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3545,6 +3545,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 24MHz frequency */
 			incperiod = INCPERIOD_24MHZ;
@@ -4061,6 +4062,7 @@ void e1000e_reset(struct e1000_adapter *adapter)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		fc->refresh_time = 0xFFFF;
 		fc->pause_time = 0xFFFF;
 
@@ -7913,6 +7915,8 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V26), board_pch_mtp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM27), board_pch_mtp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V27), board_pch_mtp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM29), board_pch_mtp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V29), board_pch_mtp },
 
 	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
 };
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index def4566a916f..02d871bc112a 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -288,6 +288,7 @@ void e1000e_ptp_init(struct e1000_adapter *adapter)
 	case e1000_pch_mtp:
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		if ((hw->mac.type < e1000_pch_lpt) ||
 		    (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)) {
 			adapter->ptp_clock_info.max_adj = 24000000 - 1;
-- 
2.38.1


