Return-Path: <netdev+bounces-243161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E96C9A27E
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 06:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB3C93466DC
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 05:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EF2FD660;
	Tue,  2 Dec 2025 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="uSWR5UTf";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="QWYtH+zR"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA22FD66A;
	Tue,  2 Dec 2025 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764655083; cv=none; b=dOP+ZSSjSQxjdUJr2/jTyKDa5nC/Z2b29dK8itbwnhSQ0QiHeG/AUngCxB5Qh4qzQ7XZ90UF3bqx8+YhPy9NBLap7H/Gp7AA2HroSR2CK2pebSlNKVvU2MmT/NU8gchMJSbkWkauANY46pAJQqYNj8rBlLO4uWSP7kvT+OPra5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764655083; c=relaxed/simple;
	bh=PHaz/sOzh9D5lWWBtb0WGJsCAi0opo4umag/aUgkwbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YnNkOJgxatUf4L/WI+m2OjHfAC7m398Jq9GKDTKAt47KK7IQnBKM+oSNfBtUzQJczvpb2Okc/V8WqmW1MFHWI2h8om3UWpsy45Qns6H27IX4jrHATRfEeDrn0aFTWDl/xEKAYGimE6Rr5BPpGD/7Yo4lBMyceVq8Zk6hjySUEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=uSWR5UTf; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=QWYtH+zR; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1764655073;
	bh=PHaz/sOzh9D5lWWBtb0WGJsCAi0opo4umag/aUgkwbM=;
	h=From:Date:Subject:To:Cc:From;
	b=uSWR5UTfytXyJHRqLD0Nqt6/H3rGecyo+rktT+Dsal2i4lZWiIBHHBgGFiO1/txtz
	 mG2ebYxSj7M5FUZKUquQWiahI+CQBk8ASZ1FxsF/HO37rDHQygXnUpcAgUNsBsVZjD
	 /jmz6jmZZdOx2JU0BZ7fnnM+abcAb0XLoO6BJR6+sLVNWhm/mXTOpOCS1NhxkCWMhC
	 2Y8aQdkD9rLKmnytGc0ap6RGW940EJcdbQ3Op4ffzmjdiyhQtN5GuJgBDYkAHfnw0P
	 Q3zMEilD4OIlX+HYulpl4UWJyXSLw8yxcwywOGMgAZM+Y3a7Xbi9GtbDKmXFHTCZ7W
	 OnA+rjxEsZ/Qg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 034C63EC67; Tue,  2 Dec 2025 05:57:52 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1764655071;
	bh=PHaz/sOzh9D5lWWBtb0WGJsCAi0opo4umag/aUgkwbM=;
	h=From:Date:Subject:To:Cc:From;
	b=QWYtH+zRjCfffl6p1FBDois9MAM1pfGJSONXUwkO7MwHx+ZGngbvO23zM8T0NH7T7
	 jBdA63EX1LeHWlHXJ6VHJwreGU6bhG4ZKssjMNUTcv6nuM3bNAPDCtVJeACOgSwnBC
	 O01Zgw+U3Ix8BOZuJn9Sil+hf8aTBNomU989CZgbt0Qdx7eMWTS4iw8d2kTMPqxAxc
	 jyLbrqaC3kSfIWjYHEjVekzwT6n3CW8OYAgld6c9Y4Mb0MaUf2ffGHryW8Opx6toPf
	 ThB3cvX7rY6KZAWIfYT8ulSq97bGI+ly/ID27STyYLLTgmwr+zeB7rjRj6pPr3lD58
	 Du4LkX+j99lFg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2DA163EC67;
	Tue,  2 Dec 2025 05:57:51 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 02 Dec 2025 06:57:48 +0100
Subject: [PATCH net-next v6] ixgbe: Add 10G-BX support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-10gbx-v6-1-e7acbd3dff69@birger-koblitz.de>
X-B4-Tracking: v=1; b=H4sIANx/LmkC/3WQy27CMBBFfwV5XSOP4zEOK/6jYuHHJFitCHKQR
 UH59w6ooSzI8o7mnBndmxipZBrFdnUThWoe83DkYD9WIh78sSeZE2ehlUZQoCWoPlykD8bpiAQ
 JjeDdU6EuXx6ezz3nQx7PQ/l5aCvcp7Oh+TNUkMCa1rXWd01Ctwu59FTk1xC+8/m6TiTupqpfa
 TPT/IhsnYqoDQDQZolu3tL8hEQVk3dWb6BdvG1eaTvTrJHKRx6HDq2PSzT+0/BsriLToCM3qKw
 K8e3taZp+AV28hTiaAQAA
X-Change-ID: 20251012-10gbx-ab482c5e1d54
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Andrew Lunn <andrew@lunn.ch>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.14.2

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
---
Changes in v6:
  Added else statement to explicitly set sfp_type to unknown if the length-check fails 
- Link to v5: https://lore.kernel.org/r/20251112-10gbx-v5-1-12cab4060bc8@birger-koblitz.de

Changes in v5:
  Added "Tested-by" 
- Link to v4: https://lore.kernel.org/r/20251016-10gbx-v4-1-0ac202bf56ac@birger-koblitz.de

Changes in v4:
  Added "Reviewed-bys".
  Slight rewording of commit message.
- Link to v3: https://lore.kernel.org/r/20251014-10gbx-v3-1-50cda8627198@birger-koblitz.de

Changes in v3:
  Added "Reviewed-by". There also was a possible mailserver DKIM misconfiguration
  that may have prevented recipients to recieve the previous mails 
- Link to v2: https://lore.kernel.org/r/20251014-10gbx-v2-1-980c524111e7@birger-koblitz.de

Changes in v2:
  Allow also modules with only Byte 15 (100m SM link length) set to
  be identified as BX
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |  7 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     | 45 +++++++++++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h     |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |  2 ++
 5 files changed, 53 insertions(+), 5 deletions(-)

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
index 2449e4cf2679ddf3277f4ada7619303eb618d393..5cdf2503610d26d66ce5b0f28901fcad14803662 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1541,6 +1541,8 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	u8 identifier = 0;
 	u8 cable_tech = 0;
 	u8 cable_spec = 0;
+	u8 sm_length_km = 0;
+	u8 sm_length_100m = 0;
 	int status;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_fiber) {
@@ -1678,6 +1680,33 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
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
+			} else {
+				hw->phy.sfp_type = ixgbe_sfp_type_unknown;
+			}
 		} else {
 			hw->phy.sfp_type = ixgbe_sfp_type_unknown;
 		}
@@ -1768,7 +1797,9 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
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
@@ -1786,7 +1817,9 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
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
@@ -2016,20 +2049,22 @@ int ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
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
index 81179c60af4e0199a8b9d0fcdf34654b02eedfac..039ba4b6c120f3e824c93cb00fdd9483e7cf9cba 100644
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


