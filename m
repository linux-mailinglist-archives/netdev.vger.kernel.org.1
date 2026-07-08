Return-Path: <netdev+bounces-305754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fj+0Ca4mTmq2EAIAu9opvQ
	(envelope-from <netdev+bounces-305754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:30:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1324724570
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:30:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="M/cB5jh0";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305754-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305754-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6446130431A6
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C573921E9;
	Wed,  8 Jul 2026 10:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07938837B
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:25:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506334; cv=none; b=LDpsMOw0hrwVIAjgb8GveHrmPrMqIJcs07GxPSvO/X6xQGYQyg98/EC/MauAIF7cXGns87FDlP3a6qRzBu6phOCXNWb0ZsvRBWFWDyXT3SfRPadAg8gMbas+5JMp70QRBxWkHJt1pKyPIpM0LbCQRvZ2DqLaOsVmOd9LWHd/d/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506334; c=relaxed/simple;
	bh=3ujeQAT2Zujw2I8H3azrrcUWTkL2aGkXHXo+Gy6YLSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nOrzx0+Obw5gHr7f0+FzQ5unllYCBAx2NG7cG7GeFSzSkzj+Y27YBNn87NMEOOK9fBwwHUThV8Il9kMnIKnL9G2Tqd9XZmRnf7WkbH+KjccFqe+xOFxuZtVyvqgEjhejQ94C9hjHPjKKFqlQvB5lDN7TzXXaja7ODtlzX5R29a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/cB5jh0; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783506332; x=1815042332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ujeQAT2Zujw2I8H3azrrcUWTkL2aGkXHXo+Gy6YLSQ=;
  b=M/cB5jh05B+cpFovqWHd5qxmpof6o8cEhUElaAc0DIJU8PHDEwxP79x2
   hIxNzKRbDgeBi8D7QqR8vksf1O9k1dlX4LLfIplyDZAQmFPI7g0Hvbc8M
   FrkEQyu9Xmq4gTRj1dZUnsbkZJKFLI+2xRDQNePN+p/gDNf396YWW2rg+
   oxXzpxa6z1xwAxMQLmKk1o1+DPoejKYX1GoeNA4mQ0+YKupfZ5kECTtaE
   CoGQAbAx7F4P+ExzQ22/LnXKJlX7eXzr1iPxNVYlRmIcT1/+oWVeWxepH
   XXAqGXtMhLiIS2BZIsILi7Sj2irD2zr/yMtMPk947WqpBGresQ6S2UUNh
   g==;
X-CSE-ConnectionGUID: 6nLEHChSRPGVgcgHfexgOg==
X-CSE-MsgGUID: xDTxwko8TIm4HIZorZTHVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83142705"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83142705"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:25:31 -0700
X-CSE-ConnectionGUID: sN6NktRyTFmY7p2yIh54kQ==
X-CSE-MsgGUID: 447K19F2SrWllaqVZVjJLg==
X-ExtLoop1: 1
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2026 03:25:29 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3] ixgbe: E610: force phy link to get down when interface is down
Date: Wed,  8 Jul 2026 12:06:09 +0200
Message-Id: <20260708100609.331976-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305754-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:pmenzel@molgen.mpg.de,m:jedrzej.jagielski@intel.com,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1324724570

For the E610 family, similarly to the E8xx adapters, the default behavior
is for the PHY link to remain up even when the corresponding OS interface
is down.

Add function setting down the PHY config IXGBE_ACI_PHY_ENA_LINK bit
what leads to disabling PHY link.

Now ixgbe_close() needs to share some of the ixgbe_watchdog_link_is_down
code so move the common part into the separate function.

Align functionality with the implementation of the ice driver.

Let user to configure link-down-on-close enablement through ethtool.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: apply Paul's notes
v3: use e_err
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 35 ++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 15 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 27 +++++++++++---
 5 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 30f62174acf2..7bbb82dd962c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -685,6 +685,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_MOD_POWER_UNSUPPORTED	BIT(22)
 #define IXGBE_FLAG2_API_MISMATCH		BIT(23)
 #define IXGBE_FLAG2_FW_ROLLBACK			BIT(24)
+#define IXGBE_FLAG2_LINK_DOWN_ON_CLOSE		BIT(25)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 831cfe9a4697..02bc0dac5123 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1923,6 +1923,33 @@ void ixgbe_fc_autoneg_e610(struct ixgbe_hw *hw)
 	hw->fc.current_mode = hw->fc.requested_mode;
 }
 
+/**
+ * ixgbe_disable_phy_link - force phy link to get down
+ * @hw: pointer to hardware structure
+ *
+ * Send 0x0601 with the IXGBE_ACI_PHY_ENA_LINK bit set down.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_disable_phy_link(struct ixgbe_hw *hw)
+{
+	struct ixgbe_aci_cmd_get_phy_caps_data pcaps = {};
+	struct ixgbe_aci_cmd_set_phy_cfg_data pcfg = {};
+	int err;
+
+	err = ixgbe_aci_get_phy_caps(hw, false, IXGBE_ACI_REPORT_ACTIVE_CFG,
+				     &pcaps);
+	if (err)
+		return err;
+
+	ixgbe_copy_phy_caps_to_cfg(&pcaps, &pcfg);
+
+	pcfg.caps &= ~IXGBE_ACI_PHY_ENA_LINK;
+	pcfg.caps |= IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT;
+
+	return ixgbe_aci_set_phy_cfg(hw, &pcfg);
+}
+
 /**
  * ixgbe_disable_rx_e610 - Disable RX unit
  * @hw: pointer to hardware structure
@@ -2207,6 +2234,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
 	u8 rmode = IXGBE_ACI_REPORT_TOPO_CAP_MEDIA;
 	u64 sup_phy_type_low, sup_phy_type_high;
 	u64 phy_type_low = 0, phy_type_high = 0;
+	bool force_on_required;
 	int err;
 
 	err = ixgbe_aci_get_link_info(hw, false, NULL);
@@ -2272,6 +2300,11 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
 		phy_type_high |= IXGBE_PHY_TYPE_HIGH_10G_USXGMII;
 	}
 
+	/* If IXGBE_ACI_PHY_ENA_LINK has been explicitly disabled that means
+	 * we need to force PHY link UP state during PHY link setup
+	 */
+	force_on_required = !(pcfg.caps & IXGBE_ACI_PHY_ENA_LINK);
+
 	/* Mask the set values to avoid requesting unsupported link types. */
 	phy_type_low &= sup_phy_type_low;
 	pcfg.phy_type_low = cpu_to_le64(phy_type_low);
@@ -2280,7 +2313,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
 
 	if (pcfg.phy_type_high != pcaps.phy_type_high ||
 	    pcfg.phy_type_low != pcaps.phy_type_low ||
-	    pcfg.caps != pcaps.caps) {
+	    pcfg.caps != pcaps.caps || force_on_required) {
 		pcfg.caps |= IXGBE_ACI_PHY_ENA_LINK;
 		pcfg.caps |= IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 2cb76a3d30ae..59044d67ebeb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -50,6 +50,7 @@ int ixgbe_cfg_phy_fc(struct ixgbe_hw *hw,
 		     enum ixgbe_fc_mode req_mode);
 int ixgbe_setup_fc_e610(struct ixgbe_hw *hw);
 void ixgbe_fc_autoneg_e610(struct ixgbe_hw *hw);
+int ixgbe_disable_phy_link(struct ixgbe_hw *hw);
 void ixgbe_disable_rx_e610(struct ixgbe_hw *hw);
 int ixgbe_init_phy_ops_e610(struct ixgbe_hw *hw);
 int ixgbe_identify_phy_e610(struct ixgbe_hw *hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index b8e85bc91a27..16e26d54f3be 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -139,6 +139,8 @@ static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
 	"vf-ipsec",
 #define IXGBE_PRIV_FLAGS_AUTO_DISABLE_VF	BIT(2)
 	"mdd-disable-vf",
+#define IXGBE_PRIV_LINK_DOWN_ON_CLOSE	BIT(3)
+	"link-down-on-close",
 };
 
 #define IXGBE_PRIV_FLAGS_STR_LEN ARRAY_SIZE(ixgbe_priv_flags_strings)
@@ -3822,6 +3824,9 @@ static u32 ixgbe_get_priv_flags(struct net_device *netdev)
 	if (adapter->flags2 & IXGBE_FLAG2_AUTO_DISABLE_VF)
 		priv_flags |= IXGBE_PRIV_FLAGS_AUTO_DISABLE_VF;
 
+	if (adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE)
+		priv_flags |= IXGBE_PRIV_LINK_DOWN_ON_CLOSE;
+
 	return priv_flags;
 }
 
@@ -3859,6 +3864,16 @@ static int ixgbe_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 		}
 	}
 
+	flags2 &= ~IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
+	if (priv_flags & IXGBE_PRIV_LINK_DOWN_ON_CLOSE) {
+		if (adapter->hw.mac.type == ixgbe_mac_e610) {
+			flags2 |= IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
+		} else {
+			e_info(probe, "Cannot set private flags: Feature supported only for E610 devices\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	if (flags2 != adapter->flags2) {
 		adapter->flags2 = flags2;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7a0783c1abc1..d0bba3e202ca 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7551,6 +7551,17 @@ static void ixgbe_close_suspend(struct ixgbe_adapter *adapter)
 	ixgbe_free_all_rx_resources(adapter);
 }
 
+static void ixgbe_handle_link_down(struct ixgbe_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
+		ixgbe_ptp_start_cyclecounter(adapter);
+
+	e_info(drv, "NIC Link is Down\n");
+	netif_carrier_off(netdev);
+}
+
 /**
  * ixgbe_close - Disables a network interface
  * @netdev: network interface device structure
@@ -7573,6 +7584,16 @@ int ixgbe_close(struct net_device *netdev)
 
 	ixgbe_fdir_filter_exit(adapter);
 
+	if (adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE) {
+		int err;
+
+		err = ixgbe_disable_phy_link(&adapter->hw);
+		if (err)
+			e_err(drv, "Cannot set PHY link down\n");
+
+		ixgbe_handle_link_down(adapter);
+	}
+
 	ixgbe_release_hw_control(adapter);
 
 	return 0;
@@ -8251,11 +8272,7 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 	if (ixgbe_is_sfp(hw) && hw->mac.type == ixgbe_mac_82598EB)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
 
-	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
-		ixgbe_ptp_start_cyclecounter(adapter);
-
-	e_info(drv, "NIC Link is Down\n");
-	netif_carrier_off(netdev);
+	ixgbe_handle_link_down(adapter);
 }
 
 static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
-- 
2.31.1


