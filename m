Return-Path: <netdev+bounces-241684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C5C875A8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFB504EBB96
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE033BBD2;
	Tue, 25 Nov 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTALO9tY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202D33B6C8
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110202; cv=none; b=ogHQxqi0RL4Amo5SoPFDEsT59FezJ/nly1A/fpPOBvIohXuMbCF3N0+DC90rK5Zghbq9rI9pT2UYZSwLH6uLx0hI0hGMxqVvFXEH2psatL63fNZlzqWNghXB/bflBtknYRdgESYGgJUJVBlQuhdC17nVEeD5VEG9LWqNjZi65nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110202; c=relaxed/simple;
	bh=pSg45zTNc5VWzWRvWBhoX78X+x1/uHbFUsOw7sRSIG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNUhIFKvZKcqEPzQQRw93kDUFascSaABEUTBv8T8/7vcC1xa9+RCXP2XdzuKI3wHatq7qAGUAQdkKxgXiQeJvObxczabt8u9DeiW21BRn2jnyPcTSyRIhtz/lADeJ3cFtmwCT3LgoGHX/DhALSor9L7gcQJJWW+t/0h/lA10dzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTALO9tY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110200; x=1795646200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSg45zTNc5VWzWRvWBhoX78X+x1/uHbFUsOw7sRSIG0=;
  b=lTALO9tYTaU5tHcFcDTgu114jOUT6mNPVyPiuMkBIOGgIPJsKPJKzJv8
   DsVK7RvaGMzMwAM7+eNW6W+F4gpsS59g+s0OOlrNXI00pdoauDGhQ/7TT
   InAOg87G3QmuU9OzF1Bfj2BuDKMtcX7tx31o4FSJoFeiJQF0fGQJAsJuh
   kI05rlkt6k1YAdMJkvf4qMoVVFPYMB8UuiYJaSJ2D+ODuipNgQ2OqUyj+
   DAMssNnK5VH9+sk0RLvzc+CE+U3ykDU1rTK+Km1sTlZeVoWL3HPwZmXoO
   Ebuh4OWdWD+AZ5rkcLFHvDLB8HS3Fh/eTPe6TuXZKXybpgbiI+uWbRuA/
   A==;
X-CSE-ConnectionGUID: 5bt5zqetS92Eu0Noj4bxQg==
X-CSE-MsgGUID: tBPM9IwGSiGlqVyJJEtCFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729884"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729884"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:38 -0800
X-CSE-ConnectionGUID: gDEMWd6nSnOpyp3lvmxo+g==
X-CSE-MsgGUID: vm+FLf6pSdy337f6887CIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209552"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:38 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Birger Koblitz <mail@birger-koblitz.de>,
	anthony.l.nguyen@intel.com,
	Andrew Lunn <andrew@lunn.ch>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 03/11] ixgbe: Add 10G-BX support
Date: Tue, 25 Nov 2025 14:36:22 -0800
Message-ID: <20251125223632.1857532-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Birger Koblitz <mail@birger-koblitz.de>

Add support for 10G-BX modules, i.e. 10GBit Ethernet over a single strand
Single-Mode fiber.
The initialization of a 10G-BX SFP+ is the same as for a 10G SX/LX module,
and is identified according to SFF-8472 table 5-3, footnote 3 by the
10G Ethernet Compliance Codes field being empty, the Nominal Bit
Rate being compatible with 12.5GBit, and the module being a fiber module
with a Single Mode fiber link length.

This was tested using a Lightron WSPXG-HS3LC-IEA 1270/1330nm 10km
transceiver:
$ sudo ethtool -m enp1s0f1
   Identifier                          : 0x03 (SFP)
   Extended identifier                 : 0x04 (GBIC/SFP defined by 2-wire interface ID)
   Connector                           : 0x07 (LC)
   Transceiver codes                   : 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
   Encoding                            : 0x01 (8B/10B)
   BR Nominal                          : 10300MBd
   Rate identifier                     : 0x00 (unspecified)
   Length (SMF)                        : 10km
   Length (OM2)                        : 0m
   Length (OM1)                        : 0m
   Length (Copper or Active cable)     : 0m
   Length (OM3)                        : 0m
   Laser wavelength                    : 1330nm
   Vendor name                         : Lightron Inc.
   Vendor OUI                          : 00:13:c5
   Vendor PN                           : WSPXG-HS3LC-IEA
   Vendor rev                          : 0000
   Option values                       : 0x00 0x1a
   Option                              : TX_DISABLE implemented
   BR margin max                       : 0%
   BR margin min                       : 0%
   Vendor SN                           : S142228617
   Date code                           : 140611
   Optical diagnostics support         : Yes

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  7 +++
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 43 ++++++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 +
 5 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 3069b583fd81..89c7fed7b8fc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -342,6 +342,13 @@ static int ixgbe_get_link_capabilities_82599(struct ixgbe_hw *hw,
 		return 0;
 	}
 
+	if (hw->phy.sfp_type == ixgbe_sfp_type_10g_bx_core0 ||
+	    hw->phy.sfp_type == ixgbe_sfp_type_10g_bx_core1) {
+		*speed = IXGBE_LINK_SPEED_10GB_FULL;
+		*autoneg = false;
+		return 0;
+	}
+
 	/*
 	 * Determine link capabilities based on the stored value of AUTOC,
 	 * which represents EEPROM defaults.  If AUTOC value has not been
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2ad81f687a84..bb4b53fee234 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -351,6 +351,8 @@ static int ixgbe_get_link_ksettings(struct net_device *netdev,
 		case ixgbe_sfp_type_1g_lx_core1:
 		case ixgbe_sfp_type_1g_bx_core0:
 		case ixgbe_sfp_type_1g_bx_core1:
+		case ixgbe_sfp_type_10g_bx_core0:
+		case ixgbe_sfp_type_10g_bx_core1:
 			ethtool_link_ksettings_add_link_mode(cmd, supported,
 							     FIBRE);
 			ethtool_link_ksettings_add_link_mode(cmd, advertising,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 2449e4cf2679..3330cb334a17 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1534,8 +1534,10 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	struct ixgbe_adapter *adapter = hw->back;
 	u8 oui_bytes[3] = {0, 0, 0};
 	u8 bitrate_nominal = 0;
+	u8 sm_length_100m = 0;
 	u8 comp_codes_10g = 0;
 	u8 comp_codes_1g = 0;
+	u8 sm_length_km = 0;
 	u16 enforce_sfp = 0;
 	u32 vendor_oui = 0;
 	u8 identifier = 0;
@@ -1678,6 +1680,31 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 			else
 				hw->phy.sfp_type =
 					ixgbe_sfp_type_1g_bx_core1;
+		/* Support Ethernet 10G-BX, checking the Bit Rate
+		 * Nominal Value as per SFF-8472 to be 12.5 Gb/s (67h) and
+		 * Single Mode fibre with at least 1km link length
+		 */
+		} else if ((!comp_codes_10g) && (bitrate_nominal == 0x67) &&
+			   (!(cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE)) &&
+			   (!(cable_tech & IXGBE_SFF_DA_ACTIVE_CABLE))) {
+			status = hw->phy.ops.read_i2c_eeprom(hw,
+					    IXGBE_SFF_SM_LENGTH_KM,
+					    &sm_length_km);
+			if (status != 0)
+				goto err_read_i2c_eeprom;
+			status = hw->phy.ops.read_i2c_eeprom(hw,
+					    IXGBE_SFF_SM_LENGTH_100M,
+					    &sm_length_100m);
+			if (status != 0)
+				goto err_read_i2c_eeprom;
+			if (sm_length_km > 0 || sm_length_100m >= 10) {
+				if (hw->bus.lan_id == 0)
+					hw->phy.sfp_type =
+						ixgbe_sfp_type_10g_bx_core0;
+				else
+					hw->phy.sfp_type =
+						ixgbe_sfp_type_10g_bx_core1;
+			}
 		} else {
 			hw->phy.sfp_type = ixgbe_sfp_type_unknown;
 		}
@@ -1768,7 +1795,9 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core0 ||
-	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core1)) {
+	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core1 ||
+	      hw->phy.sfp_type == ixgbe_sfp_type_10g_bx_core0 ||
+	      hw->phy.sfp_type == ixgbe_sfp_type_10g_bx_core1)) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
 		return -EOPNOTSUPP;
 	}
@@ -1786,7 +1815,9 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core0 ||
-	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core1)) {
+	      hw->phy.sfp_type == ixgbe_sfp_type_1g_bx_core1 ||
+	      hw->phy.sfp_type == ixgbe_sfp_type_10g_bx_core0 ||
+	      hw->phy.sfp_type == ixgbe_sfp_type_10g_bx_core1)) {
 		/* Make sure we're a supported PHY type */
 		if (hw->phy.type == ixgbe_phy_sfp_intel)
 			return 0;
@@ -2016,20 +2047,22 @@ int ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 		return -EOPNOTSUPP;
 
 	/*
-	 * Limiting active cables and 1G Phys must be initialized as
+	 * Limiting active cables, 10G BX and 1G Phys must be initialized as
 	 * SR modules
 	 */
 	if (sfp_type == ixgbe_sfp_type_da_act_lmt_core0 ||
 	    sfp_type == ixgbe_sfp_type_1g_lx_core0 ||
 	    sfp_type == ixgbe_sfp_type_1g_cu_core0 ||
 	    sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
-	    sfp_type == ixgbe_sfp_type_1g_bx_core0)
+	    sfp_type == ixgbe_sfp_type_1g_bx_core0 ||
+	    sfp_type == ixgbe_sfp_type_10g_bx_core0)
 		sfp_type = ixgbe_sfp_type_srlr_core0;
 	else if (sfp_type == ixgbe_sfp_type_da_act_lmt_core1 ||
 		 sfp_type == ixgbe_sfp_type_1g_lx_core1 ||
 		 sfp_type == ixgbe_sfp_type_1g_cu_core1 ||
 		 sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
-		 sfp_type == ixgbe_sfp_type_1g_bx_core1)
+		 sfp_type == ixgbe_sfp_type_1g_bx_core1 ||
+		 sfp_type == ixgbe_sfp_type_10g_bx_core1)
 		sfp_type = ixgbe_sfp_type_srlr_core1;
 
 	/* Read offset to PHY init contents */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 81179c60af4e..039ba4b6c120 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -32,6 +32,8 @@
 #define IXGBE_SFF_QSFP_1GBE_COMP	0x86
 #define IXGBE_SFF_QSFP_CABLE_LENGTH	0x92
 #define IXGBE_SFF_QSFP_DEVICE_TECH	0x93
+#define IXGBE_SFF_SM_LENGTH_KM		0xE
+#define IXGBE_SFF_SM_LENGTH_100M	0xF
 
 /* Bitmasks */
 #define IXGBE_SFF_DA_PASSIVE_CABLE		0x4
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index b1bfeb21537a..61f2ef67defd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3286,6 +3286,8 @@ enum ixgbe_sfp_type {
 	ixgbe_sfp_type_1g_lx_core1 = 14,
 	ixgbe_sfp_type_1g_bx_core0 = 15,
 	ixgbe_sfp_type_1g_bx_core1 = 16,
+	ixgbe_sfp_type_10g_bx_core0 = 17,
+	ixgbe_sfp_type_10g_bx_core1 = 18,
 
 	ixgbe_sfp_type_not_present = 0xFFFE,
 	ixgbe_sfp_type_unknown = 0xFFFF
-- 
2.47.1


