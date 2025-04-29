Return-Path: <netdev+bounces-186900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0DAA3CED
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403451BC55F5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019A255F3E;
	Tue, 29 Apr 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcfUVYip"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69813254858
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970428; cv=none; b=qp6V5TZFLUcOdFPGAk2qiXrWEk88uVvStreD4Ka0ImDpTZNSoDEOsdy1SOkopWrpTn1RaOy9KKsgKlAGbqANRnrsAPPESe0SMahZVQpBQDBkOkMBHaem+Dw+agajVa/5v2VdQXGaGQR0jhI2BeYvZeBeI2Ar29f2HsR+YCez5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970428; c=relaxed/simple;
	bh=N+tPmY2OUJgOleKlDaqyFho+MRfy08mX8Y03XoUKok4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKNwrOL6+3eH182JnU6u0Wv3Xpl3ERYmQd8gDQLUH7YhH+YRSx9lZkd23pmxtJCK8DKeXDul9J2RMSpLblgdzYmGvM0FYkZMIySVdEl3Cl/uSXtC1rRBdgTpsG5bqfNc9VrXTidqZq7mRqqfRXYX5X1iXcxt4sK/2sgiLNTRQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcfUVYip; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970427; x=1777506427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+tPmY2OUJgOleKlDaqyFho+MRfy08mX8Y03XoUKok4=;
  b=ZcfUVYipGOQGrDlBFca5g0WYusuRLJBWNMvhM5X2d0pbyDg1c8/CTqfc
   8cnBp9Yb0pWg+Klxt3eTdU2xZQ5Fgmo2VFTRHAQ9gOsGA/NwRLJtt/VhF
   CrMJwigLNei/T5BXREo6YhPetX1plwqoHZpYzLlKHlEPxOZGKuWBKe1H4
   EvqUcv9WEgr069K/+jHs2zKbzdOxDzAA6eEnwIrrh/HEG+rrrD9ku2ISL
   RVo5V5dUsQzVd37l/HBW7ypLwOzfqZfLcAGBQ5U7cJXSgjilZx7NGbwDb
   Gtk9Ug69Q5IcqL1MriecjmWcvRlSAcY98ThSCrmjs9q6vMSZ+4veialk+
   w==;
X-CSE-ConnectionGUID: O9CAyWG0RDu2JKvXNHiEjw==
X-CSE-MsgGUID: OeEFmJK9RdmB6fMOxal6tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990128"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:04 -0700
X-CSE-ConnectionGUID: lK6UjPjSRdSlECKpvb/XFQ==
X-CSE-MsgGUID: jSBNfTrsQ8aep+Dm3Br0Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979644"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 10/13] ixgbe: add E610 .set_phys_id() callback implementation
Date: Tue, 29 Apr 2025 16:46:45 -0700
Message-ID: <20250429234651.3982025-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Legacy implementation of .set_phys_id() ethtool callback is not
applicable for E610 device.

Add new implementation which uses 0x06E9 command by calling
ixgbe_aci_set_port_id_led().

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 29 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 22 +++++++++++++-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 14 +++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 9ada35f7d8f7..71ea25de1bac 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1484,6 +1484,35 @@ static int ixgbe_start_hw_e610(struct ixgbe_hw *hw)
 	return 0;
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
index 30bc1f1b2549..bb31d65bd1c8 100644
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
index 435f3fc3cec3..d8a919ab7027 100644
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
2.47.1


