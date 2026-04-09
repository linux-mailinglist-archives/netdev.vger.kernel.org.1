Return-Path: <netdev+bounces-276873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCA+OmNc12kCNAgAu9opvQ
	(envelope-from <netdev+bounces-276873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:59:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B23C75FF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF93F3011A43
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8F38654D;
	Thu,  9 Apr 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GslN6c/C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0283859D0;
	Thu,  9 Apr 2026 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721014; cv=none; b=uAIVTUUzG6+rGTxB23tJf2Akal2SgcCUm1wRLZVYvxXOfyYXcAMzwRl4Rjp8EqUXj8RxclFB/17Bou8CzeLUn6fwR8VJhqhO+kucL3doM6qZBXSpfdihFkU/5yS9iJVwiVwxOOIkzd/4AnQpCwuwYKNZnpuQrEbV3Y4XKUpVSaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721014; c=relaxed/simple;
	bh=xXwCqovJX3iIOUZaivpInM88vxlkHLtFkzVV9gvd0xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csRKHlsyI9Jfnl5tKf9Ee2GJnGxZw2C17M/B3vE95GTxiBP2KoeO6s08gG+FoH/ipKuvXuUol7GSzn856yui9Le35HIlmfOG0SHwYXw8uX3AILIcAdhBXMd6s1YA+O7OXp+YttoCI7HWJN8AWOVTFpJ8S0LuDVAvVvJR0MZL/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GslN6c/C; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775721013; x=1807257013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xXwCqovJX3iIOUZaivpInM88vxlkHLtFkzVV9gvd0xc=;
  b=GslN6c/CmdnN7es5igOS0h7zODAH7PuU3lWY0ExLmLbSa3wjqCeVH6nI
   povDAV4KSr7u1u6KuoT/YGoAB9585U08JI9goZ3UQpWMcwRQm5CLHYf/L
   W7Jny6XUbdtCQtAvO6wH9kthCiY8m7YDHqY79jiaZVgr+ZIATN2qo1h+L
   sgprvgxE9lbYhcpMoAwRWQFhV961sjKU+NjZGgfzAsGGTdOVOTeWVYM0p
   EEVVPvHjL3guMtjcwU518eWHX+c5A4qXyOUrQX+n/ZCK4LNGTLqcC+naZ
   ebMVijAYWXXGkj6VYwrI7sBUj+nby7vb2vpHXihIlLtrgGqq+sVeBWl4k
   w==;
X-CSE-ConnectionGUID: v9GuXswwT5qP+WkLgzPgTw==
X-CSE-MsgGUID: A3jDwE4sQ0KOpi3NLgtYHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99345661"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99345661"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:50:10 -0700
X-CSE-ConnectionGUID: EEf733KSSPatx2WnE/RbBQ==
X-CSE-MsgGUID: LKKd+yAJR++04q9/XNNC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="228627821"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by orviesa008.jf.intel.com with ESMTP; 09 Apr 2026 00:50:05 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
	hector.blanco.alcaine@intel.com, hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Looi@web.codeaurora.org, KhaiWenTan <khai.wen.tan@linux.intel.com>
Subject: [PATCH iwl-next 1/1] igc: add support for forcing link speed without autonegotiation
Date: Thu,  9 Apr 2026 15:27:47 +0800
Message-ID: <20260409072747.217836-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[intel.com:s=Intel];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276873-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.273];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 881B23C75FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Allow users to force 10/100 Mb/s link speed and duplex via ethtool
when autonegotiation is disabled. Previously, the driver rejected
"ethtool -s <dev> autoneg off speed <N> duplex <half|full>" with
"Force mode currently not supported."

When autoneg is disabled, the driver programs both the GPY PHY and
I225/I226 MAC control registers to bypass autonegotiation and apply
the requested speed and duplex. The MAC CTRL register is configured
with FRCSPD, FRCDPLX, and the appropriate SPEED and FD bits, while
the PHY STD_CTRL register has ANEN cleared and SSM/SSL/DPLX set to
match. Flow control is also forced on the MAC side when autoneg is
disabled, consistent with the existing autoneg-failed path.

Forcing 1000 Mb/s and 2500 Mb/s is not supported by this change.

Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c    |  35 +++++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 122 ++++++++++++++-----
 drivers/net/ethernet/intel/igc/igc_hw.h      |   9 ++
 drivers/net/ethernet/intel/igc/igc_mac.c     |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  66 +++++++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 201 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 1613b562d17c..ab9120a3127f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -114,11 +114,35 @@ static s32 igc_setup_copper_link_base(struct igc_hw *hw)
 	u32 ctrl;
 
 	ctrl = rd32(IGC_CTRL);
-	ctrl |= IGC_CTRL_SLU;
-	ctrl &= ~(IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX);
-	wr32(IGC_CTRL, ctrl);
-
-	ret_val = igc_setup_copper_link(hw);
+	ctrl &= ~(IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX |
+		  IGC_CTRL_SPEED_MASK | IGC_CTRL_FD);
+
+	if (hw->mac.autoneg_enabled) {
+		ctrl |= IGC_CTRL_SLU;
+		wr32(IGC_CTRL, ctrl);
+		ret_val = igc_setup_copper_link(hw);
+	} else {
+		ctrl |= IGC_CTRL_SLU | IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX;
+
+		switch (hw->mac.forced_speed_duplex) {
+		case IGC_FORCED_10H:
+			ctrl |= IGC_CTRL_SPEED_10;
+			break;
+		case IGC_FORCED_10F:
+			ctrl |= IGC_CTRL_SPEED_10 | IGC_CTRL_FD;
+			break;
+		case IGC_FORCED_100H:
+			ctrl |= IGC_CTRL_SPEED_100;
+			break;
+		case IGC_FORCED_100F:
+			ctrl |= IGC_CTRL_SPEED_100 | IGC_CTRL_FD;
+			break;
+		default:
+			return -IGC_ERR_CONFIG;
+		}
+		wr32(IGC_CTRL, ctrl);
+		ret_val = igc_setup_copper_link(hw);
+	}
 
 	return ret_val;
 }
@@ -443,6 +467,7 @@ static const struct igc_phy_operations igc_phy_ops_base = {
 	.reset			= igc_phy_hw_reset,
 	.read_reg		= igc_read_phy_reg_gpy,
 	.write_reg		= igc_write_phy_reg_gpy,
+	.force_speed_duplex	= igc_force_speed_duplex,
 };
 
 const struct igc_info igc_base_info = {
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 9482ab11f050..3f504751c2d9 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -129,10 +129,13 @@
 #define IGC_ERR_SWFW_SYNC		13
 
 /* Device Control */
+#define IGC_CTRL_FD		BIT(0)  /* Full Duplex */
 #define IGC_CTRL_RST		0x04000000  /* Global reset */
-
 #define IGC_CTRL_PHY_RST	0x80000000  /* PHY Reset */
 #define IGC_CTRL_SLU		0x00000040  /* Set link up (Force Link) */
+#define IGC_CTRL_SPEED_MASK	GENMASK(10, 8)
+#define IGC_CTRL_SPEED_10	FIELD_PREP(IGC_CTRL_SPEED_MASK, 0)
+#define IGC_CTRL_SPEED_100	FIELD_PREP(IGC_CTRL_SPEED_MASK, 1)
 #define IGC_CTRL_FRCSPD		0x00000800  /* Force Speed */
 #define IGC_CTRL_FRCDPX		0x00001000  /* Force Duplex */
 #define IGC_CTRL_VME		0x40000000  /* IEEE VLAN mode enable */
@@ -673,6 +676,10 @@
 #define IGC_GEN_POLL_TIMEOUT	1920
 
 /* PHY Control Register */
+#define MII_CR_SPEED_MASK	(BIT(6) | BIT(13))
+#define MII_CR_SPEED_10		0x0000	/* SSM=0, SSL=0: 10 Mb/s */
+#define MII_CR_SPEED_100	BIT(13)	/* SSM=0, SSL=1: 100 Mb/s */
+#define MII_CR_DUPLEX_EN	BIT(8)	/* 0 = Half Duplex, 1 = Full Duplex */
 #define MII_CR_RESTART_AUTO_NEG	0x0200  /* Restart auto negotiation */
 #define MII_CR_POWER_DOWN	0x0800  /* Power down */
 #define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0122009bedd0..e14771532dad 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1930,7 +1930,12 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 
 	/* set autoneg settings */
 	ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+	if (hw->mac.autoneg_enabled) {
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+		cmd->base.autoneg = AUTONEG_ENABLE;
+	} else {
+		cmd->base.autoneg = AUTONEG_DISABLE;
+	}
 
 	/* Set pause flow control settings */
 	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
@@ -1983,7 +1988,6 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 		cmd->base.duplex = DUPLEX_UNKNOWN;
 	}
 	cmd->base.speed = speed;
-	cmd->base.autoneg = AUTONEG_ENABLE;
 
 	/* MDI-X => 2; MDI =>1; Invalid =>0 */
 	if (hw->phy.media_type == igc_media_type_copper)
@@ -2000,37 +2004,54 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
-static int
-igc_ethtool_set_link_ksettings(struct net_device *netdev,
-			       const struct ethtool_link_ksettings *cmd)
+/**
+ * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
+ * @netdev: network interface device structure
+ * @speed: requested speed
+ * @duplex: requested duplex
+ *
+ * Validates and records forced speed/duplex when autoneg is disabled.
+ * Only 10/100 Mb/s speeds are supported.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int igc_handle_autoneg_disabled(struct net_device *netdev, u32 speed,
+				       u8 duplex)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
-	struct net_device *dev = adapter->netdev;
-	struct igc_hw *hw = &adapter->hw;
-	u16 advertised = 0;
+	struct igc_mac_info *mac = &adapter->hw.mac;
+	enum igc_forced_speed_duplex forced_speed_duplex;
 
-	/* When adapter in resetting mode, autoneg/speed/duplex
-	 * cannot be changed
-	 */
-	if (igc_check_reset_block(hw)) {
-		netdev_err(dev, "Cannot change link characteristics when reset is active\n");
+	switch (speed) {
+	case SPEED_10:
+		forced_speed_duplex = (duplex == DUPLEX_FULL) ? IGC_FORCED_10F : IGC_FORCED_10H;
+		break;
+	case SPEED_100:
+		forced_speed_duplex = (duplex == DUPLEX_FULL) ? IGC_FORCED_100F : IGC_FORCED_100H;
+		break;
+	default:
+		netdev_info(netdev, "Unsupported speed for forced link\n");
 		return -EINVAL;
 	}
 
-	/* MDI setting is only allowed when autoneg enabled because
-	 * some hardware doesn't allow MDI setting when speed or
-	 * duplex is forced.
-	 */
-	if (cmd->base.eth_tp_mdix_ctrl) {
-		if (cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO &&
-		    cmd->base.autoneg != AUTONEG_ENABLE) {
-			netdev_err(dev, "Forcing MDI/MDI-X state is not supported when link speed and/or duplex are forced\n");
-			return -EINVAL;
-		}
-	}
+	mac->autoneg_enabled = false;
+	mac->forced_speed_duplex = forced_speed_duplex;
+	return 0;
+}
 
-	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
-		usleep_range(1000, 2000);
+/**
+ * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
+ * @adapter: private driver structure
+ * @cmd: ethtool link ksettings from user
+ *
+ * Records advertised speeds and flow control settings when autoneg
+ * is enabled.
+ */
+static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
+				       const struct ethtool_link_ksettings *cmd)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u16 advertised = 0;
 
 	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
 						  2500baseT_Full))
@@ -2056,12 +2077,51 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 						  10baseT_Half))
 		advertised |= ADVERTISE_10_HALF;
 
-	if (cmd->base.autoneg == AUTONEG_ENABLE) {
-		hw->phy.autoneg_advertised = advertised;
-		if (adapter->fc_autoneg)
-			hw->fc.requested_mode = igc_fc_default;
+	hw->mac.autoneg_enabled = true;
+	hw->phy.autoneg_advertised = advertised;
+	if (adapter->fc_autoneg)
+		hw->fc.requested_mode = igc_fc_default;
+}
+
+static int
+igc_ethtool_set_link_ksettings(struct net_device *netdev,
+			       const struct ethtool_link_ksettings *cmd)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct net_device *dev = adapter->netdev;
+	struct igc_hw *hw = &adapter->hw;
+
+	/* When adapter in resetting mode, autoneg/speed/duplex
+	 * cannot be changed
+	 */
+	if (igc_check_reset_block(hw)) {
+		netdev_err(dev, "Cannot change link characteristics when reset is active\n");
+		return -EINVAL;
+	}
+
+	/* MDI setting is only allowed when autoneg enabled because
+	 * some hardware doesn't allow MDI setting when speed or
+	 * duplex is forced.
+	 */
+	if (cmd->base.eth_tp_mdix_ctrl) {
+		if (cmd->base.eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO &&
+		    cmd->base.autoneg != AUTONEG_ENABLE) {
+			netdev_err(dev, "Forcing MDI/MDI-X state is not supported when link speed and/or duplex are forced\n");
+			return -EINVAL;
+		}
+	}
+
+	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
+		usleep_range(1000, 2000);
+
+	if (cmd->base.autoneg == AUTONEG_DISABLE) {
+		if (igc_handle_autoneg_disabled(netdev, cmd->base.speed,
+						cmd->base.duplex)) {
+			clear_bit(__IGC_RESETTING, &adapter->state);
+			return -EINVAL;
+		}
 	} else {
-		netdev_info(dev, "Force mode currently not supported\n");
+		igc_handle_autoneg_enabled(adapter, cmd);
 	}
 
 	/* MDI-X => 2; MDI => 1; Auto => 3 */
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index be8a49a86d09..0794139dbc24 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -73,6 +73,13 @@ struct igc_info {
 
 extern const struct igc_info igc_base_info;
 
+enum igc_forced_speed_duplex {
+	IGC_FORCED_10H,
+	IGC_FORCED_10F,
+	IGC_FORCED_100H,
+	IGC_FORCED_100F,
+};
+
 struct igc_mac_info {
 	struct igc_mac_operations ops;
 
@@ -94,6 +101,8 @@ struct igc_mac_info {
 
 	bool autoneg_failed;
 	bool get_link_status;
+	bool autoneg_enabled;
+	enum igc_forced_speed_duplex forced_speed_duplex;
 };
 
 struct igc_nvm_operations {
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 7ac6637f8db7..16b0f2db0689 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -452,7 +452,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	 * so we had to force link.  In this case, we need to force the
 	 * configuration of the MAC to match the "fc" parameter.
 	 */
-	if (mac->autoneg_failed)
+	if (mac->autoneg_failed || !mac->autoneg_enabled)
 		ret_val = igc_force_mac_fc(hw);
 
 	if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 72bc5128d8b8..437e1d1ef1e4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7298,7 +7298,7 @@ static int igc_probe(struct pci_dev *pdev,
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
 	hw->phy.autoneg_advertised = 0xaf;
-
+	hw->mac.autoneg_enabled = true;
 	hw->fc.requested_mode = igc_fc_default;
 	hw->fc.current_mode = igc_fc_default;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 6c4d204aecfa..51870a5c00a6 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -494,12 +494,20 @@ s32 igc_setup_copper_link(struct igc_hw *hw)
 	s32 ret_val = 0;
 	bool link;
 
-	/* Setup autoneg and flow control advertisement and perform
-	 * autonegotiation.
-	 */
-	ret_val = igc_copper_link_autoneg(hw);
-	if (ret_val)
-		goto out;
+	if (hw->mac.autoneg_enabled) {
+		/* Setup autoneg and flow control advertisement and perform
+		 * autonegotiation.
+		 */
+		ret_val = igc_copper_link_autoneg(hw);
+		if (ret_val)
+			goto out;
+	} else {
+		ret_val = hw->phy.ops.force_speed_duplex(hw);
+		if (ret_val) {
+			hw_dbg("Error Forcing Speed/Duplex\n");
+			goto out;
+		}
+	}
 
 	/* Check link status. Wait up to 100 microseconds for link to become
 	 * valid.
@@ -778,3 +786,49 @@ u16 igc_read_phy_fw_version(struct igc_hw *hw)
 
 	return gphy_version;
 }
+
+/**
+ * igc_force_speed_duplex - Force PHY speed and duplex settings
+ * @hw: pointer to the HW structure
+ *
+ * Programs the GPY PHY control register to disable autonegotiation
+ * and force the speed/duplex indicated by hw->mac.forced_speed_duplex.
+ */
+s32 igc_force_speed_duplex(struct igc_hw *hw)
+{
+	enum igc_forced_speed_duplex forced_speed_duplex = hw->mac.forced_speed_duplex;
+	struct igc_phy_info *phy = &hw->phy;
+	u16 phy_ctrl;
+	s32 ret_val;
+
+	ret_val = phy->ops.read_reg(hw, PHY_CONTROL, &phy_ctrl);
+	if (ret_val)
+		return ret_val;
+
+	phy_ctrl &= ~(MII_CR_SPEED_MASK | MII_CR_DUPLEX_EN |
+		      MII_CR_AUTO_NEG_EN | MII_CR_RESTART_AUTO_NEG);
+
+	switch (forced_speed_duplex) {
+	case IGC_FORCED_10H:
+		phy_ctrl |= MII_CR_SPEED_10;
+		break;
+	case IGC_FORCED_10F:
+		phy_ctrl |= MII_CR_SPEED_10 | MII_CR_DUPLEX_EN;
+		break;
+	case IGC_FORCED_100H:
+		phy_ctrl |= MII_CR_SPEED_100;
+		break;
+	case IGC_FORCED_100F:
+		phy_ctrl |= MII_CR_SPEED_100 | MII_CR_DUPLEX_EN;
+		break;
+	default:
+		return -IGC_ERR_CONFIG;
+	}
+
+	ret_val = phy->ops.write_reg(hw, PHY_CONTROL, phy_ctrl);
+	if (ret_val)
+		return ret_val;
+
+	hw->mac.get_link_status = true;
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.h b/drivers/net/ethernet/intel/igc/igc_phy.h
index 832a7e359f18..d37a89174826 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.h
+++ b/drivers/net/ethernet/intel/igc/igc_phy.h
@@ -18,5 +18,6 @@ void igc_power_down_phy_copper(struct igc_hw *hw);
 s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data);
 s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data);
 u16 igc_read_phy_fw_version(struct igc_hw *hw);
+s32 igc_force_speed_duplex(struct igc_hw *hw);
 
 #endif
-- 
2.43.0


