Return-Path: <netdev+bounces-283116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II5qMm5L9GkUAQIAu9opvQ
	(envelope-from <netdev+bounces-283116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:42:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB84AAB69
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B0A93066899
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5736E473;
	Fri,  1 May 2026 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXzVRiuV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6E366057;
	Fri,  1 May 2026 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617518; cv=none; b=ox8ELpnCLxME+bk9KUGCgf3sANO5VJO/VlgQkn7cn1bIWuJWCluVroVLosZw5sUQOsjaf8KcxaHNjFXjjHaNztX03BljcuJLTiRRIDHJOWFavjMcP1m5JtoqNGpJC8d/uo5Y+1JbdM+JIPikmkTqThHu4DJvrhrPFYnXyvvjxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617518; c=relaxed/simple;
	bh=lrTfy831AAdvCfQHoAGfGz8PxDEyWTIdedjabTyqb1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gWKemTvqxC7ELjUW7QQJ9G8JnUbwIFsqUdINdS8TL4Z1dpcYeSZLyIoCcuzbEc1MBobL6Z0enaaPrVQblkJ9Z0H/F5AmacdyWR1T90hI2vgF92HZWB8LTEKMJa9bwsu5Z4q3oojwqPD9p+/wYSIdZ2FOlz68UimPxzn7tFlriHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXzVRiuV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617516; x=1809153516;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=lrTfy831AAdvCfQHoAGfGz8PxDEyWTIdedjabTyqb1w=;
  b=dXzVRiuVblm0An7BFE1ZOhDB+dlfyxtP2AchqdW3vYhDTPUs/rRDcHjn
   6XzRwQXolJzWI06Uhw9NxEfP1+t1nimKzDPifkZvF8lUiN09YtU1ROrO6
   k/DCqqDH0qpJMgsx3tWN24Tg17EUblqcqVmSH7/0P2HZnmsIP6sStK3BJ
   NPYI51GIX9OF0flbNEumLxHbeNBIHvKh6neUav7hiv2ZoDNyC9RjYDb0Y
   vNApQ/cslDK6Z0UrklHskdOef4Mlzuagv3afhcVoXF5J9w+aVByZw3ui7
   wMe80RgdLvf+5OrbgM0MSEsy39LSKgSfDXCHo0v+mBnM28MW1X1RR4LRJ
   g==;
X-CSE-ConnectionGUID: 91WJMLopTuCdsHkh484mPQ==
X-CSE-MsgGUID: mhz/QuGJT0GXXsnmULgE3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271894"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271894"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
X-CSE-ConnectionGUID: S5dleScdQpaT2g6meLpyjA==
X-CSE-MsgGUID: jgMYbmcVSlmC0MF4zOrYig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752855"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:17 -0700
Subject: [PATCH net-next 06/15] ixgbe: E610: add EEE support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-6-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=13772;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=6oCNnEyq63lnz1tHYDfSGCeCEMD2dPzCwLamxw3Z24I=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXinHTLKq7HWrsyL8FopsCA5sfl8m/sFVt9nk5bqZP
 97Fv1ncUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwETMTzP803kZP2u/dqpybXP5
 tyWb+3efW+L/aZrn9qdzZk8S6ZhjFMrwv2SvcE2/sWPAqePMV+Y7sZ38n8jC1sBucJUnLvbkzN0
 svAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 44AB84AAB69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283116-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

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
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c    |  40 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 145 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  30 ++++-
 5 files changed, 212 insertions(+), 5 deletions(-)

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
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 61f2ef67defd..01d0aa70b2b7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3524,6 +3524,7 @@ struct ixgbe_mac_operations {
 	int (*get_link_capabilities)(struct ixgbe_hw *, ixgbe_link_speed *,
 				     bool *);
 	void (*set_rate_select_speed)(struct ixgbe_hw *, ixgbe_link_speed);
+	int (*setup_eee)(struct ixgbe_hw *hw, bool enable_eee);
 
 	/* Packet Buffer Manipulation */
 	void (*set_rxpba)(struct ixgbe_hw *, int, u32, int);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index a01d991ee2e0..665a9813e251 100644
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
+				     IXGBE_ACI_REPORT_ACTIVE_CFG, &phy_caps);
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
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 186345933f3f..6990fe53f049 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -12,6 +12,7 @@
 #include <linux/ethtool.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/string_choices.h>
 #include <linux/uaccess.h>
 
 #include "ixgbe.h"
@@ -3540,7 +3541,7 @@ static const struct {
 	{ IXGBE_LINK_SPEED_10_FULL, ETHTOOL_LINK_MODE_10baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_100_FULL, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_1GB_FULL, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
-	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseX_Full_BIT },
+	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_5GB_FULL, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_10GB_FULL, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
 };
@@ -3557,6 +3558,17 @@ static const struct {
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
@@ -3598,6 +3610,133 @@ static int ixgbe_validate_keee(struct net_device *netdev,
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
+			e_dev_info("Energy Efficient Ethernet (EEE) feature is currently not supported on this device, please update the device NVM to the latest and try again\n");
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
@@ -3824,8 +3963,8 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
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
index 2646ee6f295f..9e1fb7383975 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6758,6 +6758,7 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 
 /**
  * ixgbe_set_eee_capable - helper function to determine EEE support on X550
+ * and E610
  * @adapter: board private structure
  */
 static void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)
@@ -6774,6 +6775,20 @@ static void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)
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
@@ -8082,6 +8097,7 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 link_speed = adapter->link_speed;
+	struct ethtool_keee keee = {};
 	const char *speed_str;
 	bool flow_rx, flow_tx;
 
@@ -8122,6 +8138,8 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
 		ixgbe_ptp_start_cyclecounter(adapter);
 
+	netdev->ethtool_ops->get_eee(netdev, &keee);
+
 	switch (link_speed) {
 	case IXGBE_LINK_SPEED_10GB_FULL:
 		speed_str = "10 Gbps";
@@ -8145,10 +8163,11 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
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
@@ -12003,6 +12022,13 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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

-- 
2.54.0.rc2.531.gaf818d63126a


