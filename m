Return-Path: <netdev+bounces-228836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C6BD54FD
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC2758693C
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D6630C62A;
	Mon, 13 Oct 2025 16:02:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246B30C612;
	Mon, 13 Oct 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371325; cv=none; b=q7NqOTF5Hdy5iTDuGLA65H2LkQHPedHVDvouPL5myjFJFK51h1AhHPl5wnUHhyCGtOVzvMcXkeEujXyJBu/uVoxS3G+BcM2W+gtkhFYoXnFkMYX6DSPQCkD6NM8l14ui1annmFADW7hreAdO5aSvC3OxEITlCPZaseqfX5cAwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371325; c=relaxed/simple;
	bh=U+bQZlFoG7hW3T+en4GDNEj1wbxRlsKAiPfRXeex2bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AJl8W4FYv3sff4acURklU8b/f4wgfczzixbOHex50DNRMWzrjY5XyMufHp0GNx/emGnaoUkk2S3INs+IhML28wx3UjSKH5vlQgRxgU27+TdZETcPh/vpb0PRqx4slZ5/3r9vqTSeFyfl1voUkdGkcS1fnpky28Tw6cUXLBKK4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id CBEBD48531; Mon, 13 Oct 2025 15:54:14 +0000 (UTC)
X-Spam-Level: 
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6E89648525;
	Mon, 13 Oct 2025 15:54:13 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 13 Oct 2025 17:54:11 +0200
Subject: [PATCH net-next] ixgbe: Add 10G-BX support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-10gbx-v1-1-ab9896af3d58@birger-koblitz.de>
X-B4-Tracking: v=1; b=H4sIAKIg7WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0MjXUOD9KQK3cQkEwujZNNUwxRTEyWg2oKi1LTMCrA50bG1tQDHcVV
 uVwAAAA==
X-Change-ID: 20251012-10gbx-ab482c5e1d54
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

Adds support for 10G-BX modules, i.e. 10GBit Ethernet over a single strand
Single-Mode fiber
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
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |  7 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     | 37 ++++++++++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h     |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |  2 ++
 5 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index d5b1b974b4a33e7dd51b7cfe5ea211ff038a36f0..892a73a4bc6b0bb1c976ca95bf874059b987054f 100644
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
index 2d660e9edb80af8fc834e097703dfd6a82b8c45b..76edf02bc47e5dd24bb0936f730f036181f6dc2a 100644
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
index 2449e4cf2679ddf3277f4ada7619303eb618d393..99959602a33105c81206b5c711a0f9dfdc5c5d4a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1541,6 +1541,7 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	u8 identifier = 0;
 	u8 cable_tech = 0;
 	u8 cable_spec = 0;
+	u8 sm_length;
 	int status;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_fiber) {
@@ -1678,6 +1679,26 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
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
+					    IXGBE_SFF_SM_LENGTH,
+					    &sm_length);
+			if (status != 0)
+				goto err_read_i2c_eeprom;
+			if (sm_length > 0) {
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
@@ -1768,7 +1789,9 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
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
@@ -1786,7 +1809,9 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
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
@@ -2016,20 +2041,22 @@ int ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
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
index 81179c60af4e0199a8b9d0fcdf34654b02eedfac..fc875ce33d5d3ed08906ad91b3312c522ab09960 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -32,6 +32,7 @@
 #define IXGBE_SFF_QSFP_1GBE_COMP	0x86
 #define IXGBE_SFF_QSFP_CABLE_LENGTH	0x92
 #define IXGBE_SFF_QSFP_DEVICE_TECH	0x93
+#define IXGBE_SFF_SM_LENGTH		0xE
 
 /* Bitmasks */
 #define IXGBE_SFF_DA_PASSIVE_CABLE		0x4
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index b1bfeb21537acc44c31aedcb0584374e8f6ecd45..61f2ef67defddeab9ff4aa83c8f017819594996b 100644
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

---
base-commit: 67029a49db6c1f21106a1b5fcdd0ea234a6e0711
change-id: 20251012-10gbx-ab482c5e1d54

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


