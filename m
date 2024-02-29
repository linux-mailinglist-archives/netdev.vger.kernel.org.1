Return-Path: <netdev+bounces-75968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29586BCED
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5600286F90
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24F200B7;
	Thu, 29 Feb 2024 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLoOs0id"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031AA11CA9
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167302; cv=none; b=Py1lzed50S+vrJ7yrfOV/b6eWWhVB0q4SouDRuAz5fIEAx980N71dWhSsWpMQ2C6ssLYdFDyvZGyDVbFRGvijejd1q394xmewGTEUFZlhLy7GSHQW1elCDbXP1HseNU0VSqOl1ibV/QL6Ohi1TGARrNxLJEEYb6qvTCT7GtC9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167302; c=relaxed/simple;
	bh=EPJHw/OluRirBrIzZ3FGUF0PRd5m1QJ88f3TVfnDptI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCL+blDV4L4PQYm4zzpPYE6AIFuQD8ag+DNOcSDB6fM1x33az221nVC42A7f5RBZOyJnPRjuK993/R8cLE/QIPhGL4ceX6e8wQ6HYx5iEzPC57av04fPP8MBGQfhSMB6yvNpNeKo9JNcEaPbkN3XrjFgw8o5COMB6bmQWksKcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLoOs0id; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167302; x=1740703302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EPJHw/OluRirBrIzZ3FGUF0PRd5m1QJ88f3TVfnDptI=;
  b=kLoOs0idHktB+MgNwHSwqRR6agobKZA36HaE65cIPODPiVWNOj6nNda+
   h4oswJa0g3L+gee18BojsgQC+PrUjnb/cIjLnr+2Z1MJfgNCOlt6+lD/1
   Ln1hERBb56df5MC8ZavmySNOnJdTmStR09dbx5xYOE3pb1khiWaMn6/9d
   5OrCkjXGqVR9HLvzC5p9ykrp7yvRo+A3tE1A1RyxC1SxUqTNMsfPsNtYo
   rQuKrLRTNzrERWX6I/scFwYFZlld/4F7+mMJwjNYRcdxSpXLNWWjzyjSK
   a8CSP5gwXT0rao8tgFFm7e6iiyr0GcktYYjOSGKyLK8z1P1/NCkqQcVYF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3776516"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3776516"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12281949"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 16:41:39 -0800
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
Subject: [PATCH net-next 2/4] ixgbe: Add 1000BASE-BX support
Date: Wed, 28 Feb 2024 16:41:30 -0800
Message-ID: <20240229004135.741586-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
References: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 32 +++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

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
-- 
2.41.0


