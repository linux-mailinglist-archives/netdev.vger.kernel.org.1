Return-Path: <netdev+bounces-171227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C8A4C02B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0871E1700F3
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60921018F;
	Mon,  3 Mar 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeIxic5g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12E211463
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004439; cv=none; b=pZu6evFf76oZVHAOBsLFLqyCqgg1hDq1Df+ABxCsNEe/0Z98e2eMYnzdSwI9zUEi1B7YrSrqpPMyuK/GjZ1HEbr+W6aI9VsUPAATyZD0WX5aSWHfr+21E6SS8XoFM6Saiw/T2b51UI9pEDkGCpchIs8x0W5DEJfWDDDSsszGVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004439; c=relaxed/simple;
	bh=TTvSG7TDQFQDkBq5pRQMySQHYobi/W0Br8YWTpsb49w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NA7T3AGeROwcJLfmf436HviPOyFX78rIGnHdce6CdC5qHYZQVlwCTiUhh8nmS0LNd27UXubGjM3JrUMUCFdBAwYw0dYr5g/mn1DYnsz1JQU1qXFGIGGXeWEtsUCt2Y/x9Fy8RPY3nOeFsyT9bMDV8x/PP5utImaNI0RbWB9qilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeIxic5g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741004437; x=1772540437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TTvSG7TDQFQDkBq5pRQMySQHYobi/W0Br8YWTpsb49w=;
  b=QeIxic5gvrIVNPtTlc8IHGuDBBUkLBHnCxzvkPPgDhxzS/av31lYPgCO
   0+RvxipnMXnPhEnaTYEHs0eR8fYzcbTiB0hI8vl/fiY2u/n7mJEIyzE1f
   AhOSEy973R6G0YAk2BdG6WIvR4gS4N+TFFaTOlxRnQARJ3YJMJKJiO8a2
   yMFVdcgWBVwCVjG9Kpzyvvq7esV7BoY+jMpLKiyRtt8+BU+dL+laY7k7F
   MLHPEF2Ccd0yVaux9WwgcIZS5ohxgd2ezs7bcSJwS+yY1uVQVcSyqtIOl
   3qiUl+OzcVYdagb/2krXARYAKv+Zq0Keo5e0waZ/dCnfz5Uc8EmRqnbDe
   w==;
X-CSE-ConnectionGUID: WIrpFqgZT22ney1GGKT+sg==
X-CSE-MsgGUID: d8+toBwJTpaPmb1mN/EJ3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41052443"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41052443"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:20:37 -0800
X-CSE-ConnectionGUID: m2pvdrVdS9+MKCO6yf6SMQ==
X-CSE-MsgGUID: /cGAWAvZSZ657QglL7ttGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117976134"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa007.fm.intel.com with ESMTP; 03 Mar 2025 04:20:35 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v3 4/4] ixgbe: add E610 .set_phys_id() callback implementation
Date: Mon,  3 Mar 2025 13:06:30 +0100
Message-Id: <20250303120630.226353-5-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
References: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Legacy implementation of .set_phys_id() ethtool callback is not
applicable for E610 device.

Add new implementation which uses 0x06E9 command by calling
ixgbe_aci_set_port_id_led().

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v3: move the #defines related to ixgbe_aci_cmd_set_port_id_led out of the
struct definition
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 29 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 22 +++++++++++++-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 14 +++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 7b0a405a305e..f11cd13c18f4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1485,6 +1485,35 @@ static int ixgbe_start_hw_e610(struct ixgbe_hw *hw)
 	return err;
 }
 
+/**
+ * ixgbe_aci_set_port_id_led - set LED value for the given port
+ * @hw: pointer to the HW struct
+ * @orig_mode: set LED original mode
+ *
+ * Set LED value for the given port (0x06E9)
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_aci_set_port_id_led(struct ixgbe_hw *hw, bool orig_mode)
+{
+	struct ixgbe_aci_cmd_set_port_id_led *cmd;
+	struct ixgbe_aci_desc desc;
+
+	cmd = &desc.params.set_port_id_led;
+
+	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_set_port_id_led);
+
+	cmd->lport_num = (u8)hw->bus.func;
+	cmd->lport_num_valid = IXGBE_ACI_PORT_ID_PORT_NUM_VALID;
+
+	if (orig_mode)
+		cmd->ident_mode = IXGBE_ACI_PORT_IDENT_LED_ORIG;
+	else
+		cmd->ident_mode = IXGBE_ACI_PORT_IDENT_LED_BLINK;
+
+	return ixgbe_aci_send_cmd(hw, &desc, NULL, 0);
+}
+
 /**
  * ixgbe_get_media_type_e610 - Gets media type
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index b668ff0ae2e5..c97623fb10ac 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -36,6 +36,7 @@ int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, bool ena_lse,
 			    struct ixgbe_link_status *link);
 int ixgbe_aci_set_event_mask(struct ixgbe_hw *hw, u8 port_num, u16 mask);
 int ixgbe_configure_lse(struct ixgbe_hw *hw, bool activate, u16 mask);
+int ixgbe_aci_set_port_id_led(struct ixgbe_hw *hw, bool orig_mode);
 enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw);
 int ixgbe_setup_link_e610(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 			  bool autoneg_wait);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 17d937f672dc..49ced536d679 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2491,6 +2491,26 @@ static int ixgbe_set_phys_id(struct net_device *netdev,
 	return 0;
 }
 
+static int ixgbe_set_phys_id_e610(struct net_device *netdev,
+				  enum ethtool_phys_id_state state)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	bool led_active;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		led_active = true;
+		break;
+	case ETHTOOL_ID_INACTIVE:
+		led_active = false;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ixgbe_aci_set_port_id_led(&adapter->hw, !led_active);
+}
+
 static int ixgbe_get_coalesce(struct net_device *netdev,
 			      struct ethtool_coalesce *ec,
 			      struct kernel_ethtool_coalesce *kernel_coal,
@@ -3756,7 +3776,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.set_msglevel           = ixgbe_set_msglevel,
 	.self_test              = ixgbe_diag_test,
 	.get_strings            = ixgbe_get_strings,
-	.set_phys_id            = ixgbe_set_phys_id,
+	.set_phys_id            = ixgbe_set_phys_id_e610,
 	.get_sset_count         = ixgbe_get_sset_count,
 	.get_ethtool_stats      = ixgbe_get_ethtool_stats,
 	.get_coalesce           = ixgbe_get_coalesce,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index bea94e5ccb73..09df67f03cf4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -223,6 +223,7 @@ enum ixgbe_aci_opc {
 	ixgbe_aci_opc_write_mdio			= 0x06E5,
 	ixgbe_aci_opc_set_gpio_by_func			= 0x06E6,
 	ixgbe_aci_opc_get_gpio_by_func			= 0x06E7,
+	ixgbe_aci_opc_set_port_id_led			= 0x06E9,
 	ixgbe_aci_opc_set_gpio				= 0x06EC,
 	ixgbe_aci_opc_get_gpio				= 0x06ED,
 	ixgbe_aci_opc_sff_eeprom			= 0x06EE,
@@ -808,6 +809,18 @@ struct ixgbe_aci_cmd_get_link_topo_pin {
 	u8 rsvd[7];
 };
 
+/* Set Port Identification LED (direct, 0x06E9) */
+struct ixgbe_aci_cmd_set_port_id_led {
+	u8 lport_num;
+	u8 lport_num_valid;
+	u8 ident_mode;
+	u8 rsvd[13];
+};
+
+#define IXGBE_ACI_PORT_ID_PORT_NUM_VALID	BIT(0)
+#define IXGBE_ACI_PORT_IDENT_LED_ORIG		0
+#define IXGBE_ACI_PORT_IDENT_LED_BLINK		BIT(0)
+
 /* Read/Write SFF EEPROM command (indirect 0x06EE) */
 struct ixgbe_aci_cmd_sff_eeprom {
 	u8 lport_num;
@@ -985,6 +998,7 @@ struct ixgbe_aci_desc {
 		struct ixgbe_aci_cmd_restart_an restart_an;
 		struct ixgbe_aci_cmd_get_link_status get_link_status;
 		struct ixgbe_aci_cmd_set_event_mask set_event_mask;
+		struct ixgbe_aci_cmd_set_port_id_led set_port_id_led;
 		struct ixgbe_aci_cmd_get_link_topo get_link_topo;
 		struct ixgbe_aci_cmd_get_link_topo_pin get_link_topo_pin;
 		struct ixgbe_aci_cmd_sff_eeprom read_write_sff_param;
-- 
2.31.1


