Return-Path: <netdev+bounces-76698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A2686E8B9
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025691F26C6B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43523B18F;
	Fri,  1 Mar 2024 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZQYADrd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130A39AF6
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318949; cv=none; b=jGyQIuUNuZ9kZXfrF4CKe4kL+rJAqmv6pTFnLUi30dhzsKsR+Cgoq+PoEUwH5fRygtHStXk7Dnd5QYFuB8FUC2pwZHa+jllWDEVjnq4JzhpxtzoStez+30NyQMlJh/tsz2HEDXGxEGuwHVJ5vkSFfocwYySTVuaHv6ZeipEnl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318949; c=relaxed/simple;
	bh=chO/whDimWnncw44l5KLSam6JJcnInonCV3SoOhIt4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntALCmwQ17J4UoKJulrikudgbyEQvLzsF7SFF2x0VB1P7rdXXgp+nHKVESOeWhyE0uxjQpxH48kt9vY6Fc1QyXZlL7JNxNYG2Utv4sG2ePlCqiCrKvYc84P37w1W+VzrkK8SRSF+uWJJTXslVUgiDJ9xMMu4uNyFtngY1KjSQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZQYADrd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709318947; x=1740854947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=chO/whDimWnncw44l5KLSam6JJcnInonCV3SoOhIt4Q=;
  b=YZQYADrdbHgZV5CPae8DFJ3A3fg2/JLElSLd1/bsBgIvXsknkEaGLupf
   hBMGUus1SKgin3YZd+oTJ5WLig13FqFEbdcRv/irXAdDWAo+FVwIEjiJG
   HVUq04sMw2fruagCwbIg95SE45tDCgDOFohhh7TqfvfioYfrDe8o9p67u
   WzxuCOxf63NhXiqd0I4fAptTrNIHNr/DvPvc6xXSA6JqZn7la/zXSp1Xt
   gORmiS3ktWPdOxi3vCxI2picuIQ29Jk7f1yTNefhy/zqA/VT04Q4hbvwj
   uCiNnhSw+m/4tfP2GZhk1uwEM9C+a4nsw1gz7/7AERoGT0hgyjbZN69aa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15303335"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15303335"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8205856"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Mar 2024 10:49:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ernesto Castellotti <ernesto@castellotti.net>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net-next v2 2/4] ixgbe: Add 1000BASE-BX support
Date: Fri,  1 Mar 2024 10:48:03 -0800
Message-ID: <20240301184806.2634508-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
References: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ernesto Castellotti <ernesto@castellotti.net>

Added support for 1000BASE-BX, i.e. Gigabit Ethernet over single strand
of single-mode fiber.
The initialization of a 1000BASE-BX SFP is the same as 1000BASE-SX/LX
with the only difference that the Bit Rate Nominal Value must be
checked to make sure it is a Gigabit Ethernet transceiver, as described
by the SFF-8472 specification.

This was tested with the FS.com SFP-GE-BX 1310/1490nm 10km transceiver:
$ ethtool -m eth4
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x00 0x00 0x00 0x40 0x00 0x00 0x00 0x00 0x00
        Transceiver type                          : Ethernet: BASE-BX10
        Encoding                                  : 0x01 (8B/10B)
        BR, Nominal                               : 1300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF,km)                           : 10km
        Length (SMF)                              : 10000m
        Length (50um)                             : 0m
        Length (62.5um)                           : 0m
        Length (Copper)                           : 0m
        Length (OM3)                              : 0m
        Laser wavelength                          : 1310nm
        Vendor name                               : FS
        Vendor OUI                                : 64:9d:99
        Vendor PN                                 : SFP-GE-BX
        Vendor rev                                :
        Option values                             : 0x20 0x0a
        Option                                    : RX_LOS implemented
        Option                                    : TX_FAULT implemented
        Option                                    : Power level 3 requirement
        BR margin, max                            : 0%
        BR margin, min                            : 0%
        Vendor SN                                 : S2202359108
        Date code                                 : 220307
        Optical diagnostics support               : Yes
        Laser bias current                        : 17.650 mA
        Laser output power                        : 0.2132 mW / -6.71 dBm
        Receiver signal average optical power     : 0.2740 mW / -5.62 dBm
        Module temperature                        : 47.30 degrees C / 117.13 degrees F
        Module voltage                            : 3.2576 V
        Alarm/warning flags implemented           : Yes
        Laser bias current high alarm             : Off
        Laser bias current low alarm              : Off
        Laser bias current high warning           : Off
        Laser bias current low warning            : Off
        Laser output power high alarm             : Off
        Laser output power low alarm              : Off
        Laser output power high warning           : Off
        Laser output power low warning            : Off
        Module temperature high alarm             : Off
        Module temperature low alarm              : Off
        Module temperature high warning           : Off
        Module temperature low warning            : Off
        Module voltage high alarm                 : Off
        Module voltage low alarm                  : Off
        Module voltage high warning               : Off
        Module voltage low warning                : Off
        Laser rx power high alarm                 : Off
        Laser rx power low alarm                  : Off
        Laser rx power high warning               : Off
        Laser rx power low warning                : Off
        Laser bias current high alarm threshold   : 110.000 mA
        Laser bias current low alarm threshold    : 1.000 mA
        Laser bias current high warning threshold : 100.000 mA
        Laser bias current low warning threshold  : 1.000 mA
        Laser output power high alarm threshold   : 0.7079 mW / -1.50 dBm
        Laser output power low alarm threshold    : 0.0891 mW / -10.50 dBm
        Laser output power high warning threshold : 0.6310 mW / -2.00 dBm
        Laser output power low warning threshold  : 0.1000 mW / -10.00 dBm
        Module temperature high alarm threshold   : 90.00 degrees C / 194.00 degrees F
        Module temperature low alarm threshold    : -45.00 degrees C / -49.00 degrees F
        Module temperature high warning threshold : 85.00 degrees C / 185.00 degrees F
        Module temperature low warning threshold  : -40.00 degrees C / -40.00 degrees F
        Module voltage high alarm threshold       : 3.7950 V
        Module voltage low alarm threshold        : 2.8050 V
        Module voltage high warning threshold     : 3.4650 V
        Module voltage low warning threshold      : 3.1350 V
        Laser rx power high alarm threshold       : 0.7079 mW / -1.50 dBm
        Laser rx power low alarm threshold        : 0.0028 mW / -25.53 dBm
        Laser rx power high warning threshold     : 0.6310 mW / -2.00 dBm
        Laser rx power low warning threshold      : 0.0032 mW / -24.95 dBm

Signed-off-by: Ernesto Castellotti <ernesto@castellotti.net>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  4 ++-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 32 ++++++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  3 ++
 5 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index e0c300fe5cee..cdaf087b4e85 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -334,7 +334,9 @@ static int ixgbe_get_link_capabilities_82599(struct ixgbe_hw *hw,
 	    hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core0 ||
 	    hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core1 ||
 	    hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
-	    hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1) {
+	    hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
+	    hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core0 ||
+	    hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core1) {
 		*speed = IXGBE_LINK_SPEED_1GB_FULL;
 		*autoneg = true;
 		return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 633bac1543dd..6e6e6f1847b6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -349,6 +349,8 @@ static int ixgbe_get_link_ksettings(struct net_device *netdev,
 		case ixgbe_sfp_type_1g_sx_core1:
 		case ixgbe_sfp_type_1g_lx_core0:
 		case ixgbe_sfp_type_1g_lx_core1:
+		case ixgbe_sfp_type_1g_bx_core0:
+		case ixgbe_sfp_type_1g_bx_core1:
 			ethtool_link_ksettings_add_link_mode(cmd, supported,
 							     FIBRE);
 			ethtool_link_ksettings_add_link_mode(cmd, advertising,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 75e9453331ed..07eaa3c3f4d3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1532,6 +1532,7 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	enum ixgbe_sfp_type stored_sfp_type = hw->phy.sfp_type;
 	struct ixgbe_adapter *adapter = hw->back;
 	u8 oui_bytes[3] = {0, 0, 0};
+	u8 bitrate_nominal = 0;
 	u8 comp_codes_10g = 0;
 	u8 comp_codes_1g = 0;
 	u16 enforce_sfp = 0;
@@ -1576,7 +1577,12 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	status = hw->phy.ops.read_i2c_eeprom(hw,
 					     IXGBE_SFF_CABLE_TECHNOLOGY,
 					     &cable_tech);
+	if (status)
+		goto err_read_i2c_eeprom;
 
+	status = hw->phy.ops.read_i2c_eeprom(hw,
+					     IXGBE_SFF_BITRATE_NOMINAL,
+					     &bitrate_nominal);
 	if (status)
 		goto err_read_i2c_eeprom;
 
@@ -1659,6 +1665,18 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 			else
 				hw->phy.sfp_type =
 					ixgbe_sfp_type_1g_lx_core1;
+		/* Support only Ethernet 1000BASE-BX10, checking the Bit Rate
+		 * Nominal Value as per SFF-8472 by convention 1.25 Gb/s should
+		 * be rounded up to 0Dh (13 in units of 100 MBd) for 1000BASE-BX
+		 */
+		} else if ((comp_codes_1g & IXGBE_SFF_BASEBX10_CAPABLE) &&
+			   (bitrate_nominal == 0xD)) {
+			if (hw->bus.lan_id == 0)
+				hw->phy.sfp_type =
+					ixgbe_sfp_type_1g_bx_core0;
+			else
+				hw->phy.sfp_type =
+					ixgbe_sfp_type_1g_bx_core1;
 		} else {
 			hw->phy.sfp_type = ixgbe_sfp_type_unknown;
 		}
@@ -1747,7 +1765,9 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core0 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core1 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
-	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1)) {
+	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
+	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core0 ||
+	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core1)) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
 		return -EOPNOTSUPP;
 	}
@@ -1763,7 +1783,9 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core0 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core1 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
-	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1)) {
+	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
+	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core0 ||
+	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core1)) {
 		/* Make sure we're a supported PHY type */
 		if (hw->phy.type == ixgbe_phy_sfp_intel)
 			return 0;
@@ -1999,12 +2021,14 @@ int ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 	if (sfp_type == ixgbe_sfp_type_da_act_lmt_core0 ||
 	    sfp_type == ixgbe_sfp_type_1g_lx_core0 ||
 	    sfp_type == ixgbe_sfp_type_1g_cu_core0 ||
-	    sfp_type == ixgbe_sfp_type_1g_sx_core0)
+	    sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
+	    sfp_type == ixgbe_sfp_type_1g_bx_core0)
 		sfp_type = ixgbe_sfp_type_srlr_core0;
 	else if (sfp_type == ixgbe_sfp_type_da_act_lmt_core1 ||
 		 sfp_type == ixgbe_sfp_type_1g_lx_core1 ||
 		 sfp_type == ixgbe_sfp_type_1g_cu_core1 ||
-		 sfp_type == ixgbe_sfp_type_1g_sx_core1)
+		 sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
+		 sfp_type == ixgbe_sfp_type_1g_bx_core1)
 		sfp_type = ixgbe_sfp_type_srlr_core1;
 
 	/* Read offset to PHY init contents */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index beedcb7bec0d..14aa2ca51f70 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -17,6 +17,7 @@
 #define IXGBE_SFF_1GBE_COMP_CODES	0x6
 #define IXGBE_SFF_10GBE_COMP_CODES	0x3
 #define IXGBE_SFF_CABLE_TECHNOLOGY	0x8
+#define IXGBE_SFF_BITRATE_NOMINAL	0xC
 #define IXGBE_SFF_CABLE_SPEC_COMP	0x3C
 #define IXGBE_SFF_SFF_8472_SWAP		0x5C
 #define IXGBE_SFF_SFF_8472_COMP		0x5E
@@ -39,6 +40,7 @@
 #define IXGBE_SFF_1GBASESX_CAPABLE		0x1
 #define IXGBE_SFF_1GBASELX_CAPABLE		0x2
 #define IXGBE_SFF_1GBASET_CAPABLE		0x8
+#define IXGBE_SFF_BASEBX10_CAPABLE		0x64
 #define IXGBE_SFF_10GBASESR_CAPABLE		0x10
 #define IXGBE_SFF_10GBASELR_CAPABLE		0x20
 #define IXGBE_SFF_SOFT_RS_SELECT_MASK		0x8
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index d44c58130be2..ed440dd0c4f9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3210,6 +3210,9 @@ enum ixgbe_sfp_type {
 	ixgbe_sfp_type_1g_sx_core1 = 12,
 	ixgbe_sfp_type_1g_lx_core0 = 13,
 	ixgbe_sfp_type_1g_lx_core1 = 14,
+	ixgbe_sfp_type_1g_bx_core0 = 15,
+	ixgbe_sfp_type_1g_bx_core1 = 16,
+
 	ixgbe_sfp_type_not_present = 0xFFFE,
 	ixgbe_sfp_type_unknown = 0xFFFF
 };
-- 
2.41.0


