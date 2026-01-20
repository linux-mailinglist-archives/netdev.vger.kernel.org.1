Return-Path: <netdev+bounces-251502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPZCGpmScGkaYgAAu9opvQ
	(envelope-from <netdev+bounces-251502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:47:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F4453D1A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7D9D50CA62
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B443D4F4;
	Tue, 20 Jan 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PK7K3huv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783943D516
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917758; cv=none; b=l+GrX7i3dqbGzwpDN9PNK0BXrR1xyYCKoPbWRfS8vOThqQSjWNoi4dpMUKKN26BYKTO3PGpp5NJUBoOvXHdJGnEHEtImJemH9Iy2xZFbaFk92Xv4ET0H6WyEPXV+vbv3VJuPCMxvw5ylZ4yg3YmebMHr1hyGrb06uy1kLnDsJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917758; c=relaxed/simple;
	bh=c3wTneRn/63MhMwZxOvqlh2YqVZIDxaN722tVWa8hsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7dhODXq6EFxB9Bbj7oS8Gv5GzVBRy6ryJKQYtsgilatGF9s5hgiudrtA2nMhWQCp+7f59fo7+A0Geih7ptLINLu01+tapE/kBkMgD1qYHtPfxhpPgYmbckqXP4v41QsB3Dm7WlNzp83XsqwuhhKb+tJHwtJMX27gTtRybNe3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PK7K3huv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917756; x=1800453756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c3wTneRn/63MhMwZxOvqlh2YqVZIDxaN722tVWa8hsY=;
  b=PK7K3huvnMFs1b5Wd8U121azZAyhl4YCw9oXSFSoiOp2m7QnlvYgI1yv
   xT+NMv9tb0T3PQXCNuqCoC07T4IEWkWMNK53ZWxwmwvqdOwGmeL70cxg9
   5NfiVAt3ZvZj9cwy5c/tB1eu5U1Qp1hmRkFZGXuxmIi35nM5gjgxrn1Rf
   RYsEb6V7CnedjJOIna399sBxai3/rVUZnul1WEwfFmNrtuVt2/dv36Stf
   5my4dIJ/bDIuQbYunDiMZ/DeHGa1W6JOszj29q7/gln0hGV1GrZLmlm2O
   6hfcWs4HXhbaLX8F9ThWQYei/qoCN2SwJ2XD+x+yUgkAi4h1/d0ByfUD/
   A==;
X-CSE-ConnectionGUID: lWT1jnwlSly1M0khVVtisw==
X-CSE-MsgGUID: SwvplByuRwyL9RZZNhK7fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711792"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="72711792"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:02:35 -0800
X-CSE-ConnectionGUID: sUCTT2O7SAyZnrMiOgq3mQ==
X-CSE-MsgGUID: NWu3HeNwQmCqVixRY2Vx8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210978977"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:34 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 6/6] ixgbe: E610: add EEE support
Date: Tue, 20 Jan 2026 14:44:34 +0100
Message-Id: <20260120134434.1931602-7-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251502-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C6F4453D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add E610 specific implementation of .get_eee() and .set_eee() ethtool
callbacks.

Introduce ixgbe_setup_eee_e610() which is used to set EEE config
on E610 device via ixgbe_aci_set_phy_cfg() (0x0601 ACI command).
Assign it to dedicated mac operation.

E610 devices support EEE feature specifically for 2.5, 5 and 10G link
speeds. When user try to set EEE for unsupported speeds log it.

Setting timer and setting EEE advertised speeds are not yet supported.

EEE shall be enabled by default for E610 devices.

Add EEE statuis logging during link watchdog run.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: get rid of setting unsupported speeds from ixgbe_setup_eee_e610();
    remove 10Mb EEE case; remove EEE control (Andrew)
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  40 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 145 +++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  30 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   1 +
 5 files changed, 212 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 8a3d8000a79c..3b941906b502 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2013,6 +2013,45 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	return 0;
 }
 
+/**
+ * ixgbe_setup_eee_e610 - Enable/disable EEE support
+ * @hw: pointer to the HW structure
+ * @enable_eee: boolean flag to enable EEE
+ *
+ * Enable/disable EEE based on @enable_eee.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_setup_eee_e610(struct ixgbe_hw *hw, bool enable_eee)
+{
+	struct ixgbe_aci_cmd_get_phy_caps_data phy_caps = {};
+	struct ixgbe_aci_cmd_set_phy_cfg_data phy_cfg = {};
+	u16 eee_cap = 0;
+	int err;
+
+	err = ixgbe_aci_get_phy_caps(hw, false,
+		IXGBE_ACI_REPORT_ACTIVE_CFG, &phy_caps);
+	if (err)
+		return err;
+
+	ixgbe_copy_phy_caps_to_cfg(&phy_caps, &phy_cfg);
+	phy_cfg.caps |= (IXGBE_ACI_PHY_ENA_LINK |
+			IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT);
+
+	if (enable_eee) {
+		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_2_5GB_FULL)
+			eee_cap |= IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T;
+		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_5GB_FULL)
+			eee_cap |= IXGBE_ACI_PHY_EEE_EN_5GBASE_T;
+		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_10GB_FULL)
+			eee_cap |= IXGBE_ACI_PHY_EEE_EN_10GBASE_T;
+	}
+
+	phy_cfg.eee_cap = cpu_to_le16(eee_cap);
+
+	return ixgbe_aci_set_phy_cfg(hw, &phy_cfg);
+}
+
 /**
  * ixgbe_identify_module_e610 - Identify SFP module type
  * @hw: pointer to hardware structure
@@ -4026,6 +4065,7 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.fw_rollback_mode		= ixgbe_fw_rollback_mode_e610,
 	.get_nvm_ver			= ixgbe_get_active_nvm_ver,
 	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
+	.setup_eee			= ixgbe_setup_eee_e610,
 	.get_bus_info			= ixgbe_get_bus_info_generic,
 	.acquire_swfw_sync		= ixgbe_acquire_swfw_sync_X540,
 	.release_swfw_sync		= ixgbe_release_swfw_sync_X540,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 11916b979d28..2cb76a3d30ae 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -55,6 +55,7 @@ int ixgbe_init_phy_ops_e610(struct ixgbe_hw *hw);
 int ixgbe_identify_phy_e610(struct ixgbe_hw *hw);
 int ixgbe_identify_module_e610(struct ixgbe_hw *hw);
 int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw);
+int ixgbe_setup_eee_e610(struct ixgbe_hw *hw, bool enable_eee);
 int ixgbe_set_phy_power_e610(struct ixgbe_hw *hw, bool on);
 int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw);
 int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index b5b9b9335d52..020b97556ef7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -12,6 +12,7 @@
 #include <linux/ethtool.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/string_choices.h>
 #include <linux/uaccess.h>
 
 #include "ixgbe.h"
@@ -3539,7 +3540,7 @@ static const struct {
 	{ IXGBE_LINK_SPEED_10_FULL, ETHTOOL_LINK_MODE_10baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_100_FULL, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_1GB_FULL, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
-	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseX_Full_BIT },
+	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_5GB_FULL, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_10GB_FULL, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
 };
@@ -3556,6 +3557,17 @@ static const struct {
 	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
+static const struct {
+	u16 eee_cap_bit;
+	u32 link_mode;
+} ixgbe_eee_cap_map[] = {
+	{ IXGBE_ACI_PHY_EEE_EN_100BASE_TX, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
+	{ IXGBE_ACI_PHY_EEE_EN_1000BASE_T, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
+	{ IXGBE_ACI_PHY_EEE_EN_10GBASE_T, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
+	{ IXGBE_ACI_PHY_EEE_EN_5GBASE_T, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
+	{ IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T, ETHTOOL_LINK_MODE_2500baseT_Full_BIT },
+};
+
 static int ixgbe_validate_keee(struct net_device *netdev,
 			       struct ethtool_keee *keee_requested)
 {
@@ -3597,6 +3609,133 @@ static int ixgbe_validate_keee(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * ixgbe_is_eee_link_speed_supported_e610 - Check if EEE can be enabled
+ * @adapter: pointer to the adapter struct
+ *
+ * Check whether current link configuration is capable of enabling EEE feature.
+ *
+ * E610 specific function - for other adapters supporting EEE there might be
+ * no such limitation.
+ *
+ * Return: true if EEE can be enabled, false otherwise.
+ */
+static bool
+ixgbe_is_eee_link_speed_supported_e610(struct ixgbe_adapter *adapter)
+{
+	switch (adapter->link_speed) {
+	case IXGBE_LINK_SPEED_10GB_FULL:
+	case IXGBE_LINK_SPEED_2_5GB_FULL:
+	case IXGBE_LINK_SPEED_5GB_FULL:
+		return true;
+	case IXGBE_LINK_SPEED_100_FULL:
+	case IXGBE_LINK_SPEED_1GB_FULL:
+		e_dev_info("Energy Efficient Ethernet (EEE) feature is not supported on link speeds equal to or below 1Gbps. EEE is supported on speeds above 1Gbps.\n");
+		fallthrough;
+	default:
+		return false;
+	}
+}
+
+static int ixgbe_get_eee_e610(struct net_device *netdev,
+			      struct ethtool_keee *kedata)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_aci_cmd_get_phy_caps_data pcaps;
+	struct ixgbe_hw *hw = &adapter->hw;
+	struct ixgbe_link_status link;
+	u16 eee_cap;
+	int err;
+
+	linkmode_zero(kedata->lp_advertised);
+	linkmode_zero(kedata->supported);
+	linkmode_zero(kedata->advertised);
+
+	err = ixgbe_aci_get_link_info(hw, true, &link);
+	if (err)
+		return err;
+
+	err = ixgbe_aci_get_phy_caps(hw, false, IXGBE_ACI_REPORT_ACTIVE_CFG,
+				     &pcaps);
+	if (err)
+		return err;
+
+	kedata->eee_active =  link.eee_status & IXGBE_ACI_LINK_EEE_ACTIVE;
+	kedata->eee_enabled = link.eee_status & IXGBE_ACI_LINK_EEE_ENABLED;
+
+	/* for E610 devices EEE enablement implies TX LPI enablement */
+	kedata->tx_lpi_enabled = kedata->eee_enabled;
+
+	if (kedata->eee_enabled)
+		kedata->tx_lpi_timer = le16_to_cpu(pcaps.eee_entry_delay);
+
+	eee_cap = le16_to_cpu(pcaps.eee_cap);
+
+	for (int i = 0; i < ARRAY_SIZE(ixgbe_eee_cap_map); i++) {
+		if (eee_cap & ixgbe_eee_cap_map[i].eee_cap_bit)
+			linkmode_set_bit(ixgbe_eee_cap_map[i].link_mode,
+					 kedata->lp_advertised);
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(ixgbe_ls_map); i++) {
+		if (hw->phy.eee_speeds_supported &
+		    ixgbe_ls_map[i].mac_speed)
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
+					 kedata->supported);
+
+		if (hw->phy.eee_speeds_advertised &
+		    ixgbe_ls_map[i].mac_speed)
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
+					 kedata->advertised);
+	}
+
+	return 0;
+}
+
+static int ixgbe_set_eee_e610(struct net_device *netdev,
+			      struct ethtool_keee *kedata)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	err = ixgbe_validate_keee(netdev, kedata);
+
+	if (err == -EALREADY) {
+		return 0;
+	} else if (err) {
+		if (err == -EOPNOTSUPP)
+			e_dev_info("Energy Efficient Ethernet (EEE) feature is currently not supported on this device, please update the device NVM to the latest and try again");
+		return err;
+	}
+
+	if (!(ixgbe_is_eee_link_speed_supported_e610(adapter)) &&
+	    kedata->eee_enabled)
+		return -EOPNOTSUPP;
+
+	hw->phy.eee_speeds_advertised = kedata->eee_enabled ?
+					hw->phy.eee_speeds_supported : 0;
+
+	err = hw->mac.ops.setup_eee(hw, kedata->eee_enabled);
+	if (err) {
+		e_dev_err("Setting EEE %s failed.\n",
+			  str_on_off(kedata->eee_enabled));
+		return err;
+	}
+
+	if (kedata->eee_enabled)
+		adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
+	else
+		adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
+
+	if (netif_running(netdev))
+		ixgbe_reinit_locked(adapter);
+	else
+		ixgbe_reset(adapter);
+
+	return 0;
+}
+
 static int
 ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 {
@@ -3823,8 +3962,8 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.set_rxfh		= ixgbe_set_rxfh,
 	.get_rxfh_fields	= ixgbe_get_rxfh_fields,
 	.set_rxfh_fields	= ixgbe_set_rxfh_fields,
-	.get_eee		= ixgbe_get_eee,
-	.set_eee		= ixgbe_set_eee,
+	.get_eee		= ixgbe_get_eee_e610,
+	.set_eee		= ixgbe_set_eee_e610,
 	.get_channels		= ixgbe_get_channels,
 	.set_channels		= ixgbe_set_channels,
 	.get_priv_flags		= ixgbe_get_priv_flags,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c58051e4350b..b2bd34b53bf2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6748,6 +6748,7 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 
 /**
  * ixgbe_set_eee_capable - helper function to determine EEE support on X550
+ * and E610
  * @adapter: board private structure
  */
 static void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)
@@ -6764,6 +6765,20 @@ static void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)
 			break;
 		adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
 		break;
+	case IXGBE_DEV_ID_E610_BACKPLANE:
+	case IXGBE_DEV_ID_E610_SFP:
+	case IXGBE_DEV_ID_E610_10G_T:
+	case IXGBE_DEV_ID_E610_2_5G_T:
+		if (hw->dev_caps.common_cap.eee_support &&
+		    hw->phy.eee_speeds_supported) {
+			adapter->flags2 |= IXGBE_FLAG2_EEE_CAPABLE;
+			/* For E610 adapters EEE should be enabled by default
+			 * if the feature is supported by FW.
+			 */
+			adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
+			break;
+		}
+		fallthrough;
 	default:
 		adapter->flags2 &= ~IXGBE_FLAG2_EEE_CAPABLE;
 		adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
@@ -8074,6 +8089,7 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 link_speed = adapter->link_speed;
+	struct ethtool_keee keee = {};
 	const char *speed_str;
 	bool flow_rx, flow_tx;
 
@@ -8114,6 +8130,8 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
 		ixgbe_ptp_start_cyclecounter(adapter);
 
+	netdev->ethtool_ops->get_eee(netdev, &keee);
+
 	switch (link_speed) {
 	case IXGBE_LINK_SPEED_10GB_FULL:
 		speed_str = "10 Gbps";
@@ -8137,10 +8155,11 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 		speed_str = "unknown speed";
 		break;
 	}
-	e_info(drv, "NIC Link is Up %s, Flow Control: %s\n", speed_str,
+	e_info(drv, "NIC Link is Up %s, Flow Control: %s, EEE: %s\n", speed_str,
 	       ((flow_rx && flow_tx) ? "RX/TX" :
 	       (flow_rx ? "RX" :
-	       (flow_tx ? "TX" : "None"))));
+	       (flow_tx ? "TX" : "None"))),
+	       str_on_off(keee.eee_enabled));
 
 	netif_carrier_on(netdev);
 	ixgbe_check_vf_rate_limit(adapter);
@@ -11995,6 +12014,13 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_netdev;
 
+	if (hw->mac.type == ixgbe_mac_e610 &&
+	    (adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE)) {
+		bool eee_enable = adapter->flags2 & IXGBE_FLAG2_EEE_ENABLED;
+
+		hw->mac.ops.setup_eee(hw, eee_enable);
+	}
+
 	ixgbe_devlink_init_regions(adapter);
 	devl_register(adapter->devlink);
 	devl_unlock(adapter->devlink);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 94e00ab96692..4b8c439df2e2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3524,6 +3524,7 @@ struct ixgbe_mac_operations {
 	int (*get_link_capabilities)(struct ixgbe_hw *, ixgbe_link_speed *,
 				     bool *);
 	void (*set_rate_select_speed)(struct ixgbe_hw *, ixgbe_link_speed);
+	int (*setup_eee)(struct ixgbe_hw *hw, bool enable_eee);
 
 	/* Packet Buffer Manipulation */
 	void (*set_rxpba)(struct ixgbe_hw *, int, u32, int);
-- 
2.31.1


