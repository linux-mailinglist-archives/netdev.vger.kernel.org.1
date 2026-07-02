Return-Path: <netdev+bounces-304070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QE+XLOgyRmqCLgsAu9opvQ
	(envelope-from <netdev+bounces-304070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:44:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F886F56B2
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HWnpmapQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304070-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304070-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 380D2315E0B3
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40848096B;
	Thu,  2 Jul 2026 09:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB448AE1E
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:35:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984919; cv=none; b=Ae+QDVEZMwlsXLr6/leiJaYfnQ9xXsLORjuHeDkAo3s9kvU7ZAWaeitV2OOiWx6T0FwBp2MNIY1r6/SE0sZ/hLEDNwILNup5GsWq5zimQhzbIg7GxTDjsAuNo5n3kuXGayAGnrC6b/XJZ/0uo/Yv7QTu37C+D9T/Tp5ejWVqQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984919; c=relaxed/simple;
	bh=gmcZ3AOfOUgcWqGiO+no6doGb36KhYEwFOkvQ5A3t0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNR1gzcK8Cmz0XY2wHRASOKih0T4szEoHtI1yXzMXhK0TSBBbnRwAI876y+oYH7OUTKnHBpnHEGwV2JjL4fIw1nJtrT+4sECE5Tt/04Q7ck/wKqu3UkR1K8nYop44xOET7Op7k1p2IgrXTzguBiouIQhPIailV9eXyHlyvJGe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWnpmapQ; arc=none smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782984918; x=1814520918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gmcZ3AOfOUgcWqGiO+no6doGb36KhYEwFOkvQ5A3t0U=;
  b=HWnpmapQeutcAcz9P92PSm8rMfOBkbNtD68yowDQ6T6u22b0vKtIsOC/
   1ibWZVHiyVo72syIKV8qAOfHv0SsfPfAhamkEsOP03ZgtCOkS1n/jQ3Rr
   7eXWSgAtdCz0QJ96xDSwEZYKWI1UzlKdGBmWH9UQowXz3ejQUNQ2T0R3Q
   Rj+AJgQfojMlJQ2dFwSFMlwLWoCENcEY6witobF1xZ/LjTNTVKY/42zYn
   OuEiihBRg/zgWVaDgqAMZP2Q5NjV68rDKs5WAXA7UlfNJe9E4gRZuT5T9
   aSuAyd6HnW74d18rxGQwPEonJity8NptADNychFSYJkwzqRA8KQpQEkUA
   g==;
X-CSE-ConnectionGUID: HzRzheRERy+/3PR83zrghA==
X-CSE-MsgGUID: jGuafm+rQFGjydTX7LpNjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87649816"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87649816"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:18 -0700
X-CSE-ConnectionGUID: S2jCqB1KR9GGbdAFDLxo2A==
X-CSE-MsgGUID: YEt9ZdP2RsSxo9uueSSO5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253476424"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2026 02:35:16 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 4/6] ixgbe: E610: re-enable LSE unconditionally
Date: Thu,  2 Jul 2026 11:15:51 +0200
Message-Id: <20260702091553.57112-5-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304070-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:jedrzej.jagielski@intel.com,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64F886F56B2

ixgbe_aci_get_link_info() currently allows to [en/dis]able LSE by @ena_lse
param. This isn't proper approach as this function objective is completely
different than toggling LSE feature. Creating such parameter was probably
dictated by the fact the flag corresponding for LSE enablement was placed
within the ACI command used by the function.

LSE should not be switched off while the ixgbe driver is running.
Current driver behavior doesn't provide such possibility for the user.

Enable LSE by default whenever 0x0607 ACI command is sent. Such change
corresponds to the fact that FW disables LSE whenever new event is
triggered. ixgbe_aci_get_link_info() is a part of routine handling LSE
events, so it ensures that LSE remain enabled.

Remove wrappers utilizing @ena_lse param to [en/dis]able LSE as they
are no longer valid.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 25 ++++---------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  3 +--
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 +----------------
 4 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 54cc0f116e88..ec7d8073efe6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1391,7 +1391,7 @@ int ixgbe_update_link_info(struct ixgbe_hw *hw)
 
 	li = &hw->link.link_info;
 
-	err = ixgbe_aci_get_link_info(hw, true, NULL);
+	err = ixgbe_aci_get_link_info(hw, NULL);
 	if (err)
 		return err;
 
@@ -1445,7 +1445,6 @@ int ixgbe_get_link_status(struct ixgbe_hw *hw, bool *link_up)
 /**
  * ixgbe_aci_get_link_info - get the link status
  * @hw: pointer to the HW struct
- * @ena_lse: enable/disable LinkStatusEvent reporting
  * @link: pointer to link status structure - optional
  *
  * Get the current Link Status using ACI command (0x607).
@@ -1454,8 +1453,7 @@ int ixgbe_get_link_status(struct ixgbe_hw *hw, bool *link_up)
  *
  * Return: the link status of the adapter.
  */
-int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, bool ena_lse,
-			    struct ixgbe_link_status *link)
+int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, struct ixgbe_link_status *link)
 {
 	struct ixgbe_aci_cmd_get_link_status_data link_data = {};
 	struct ixgbe_aci_cmd_get_link_status *resp;
@@ -1474,7 +1472,7 @@ int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, bool ena_lse,
 	hw_fc_info = &hw->fc;
 
 	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_get_link_status);
-	cmd_flags = (ena_lse) ? IXGBE_ACI_LSE_ENA : IXGBE_ACI_LSE_DIS;
+	cmd_flags = IXGBE_ACI_LSE_ENA;
 	resp = libie_aq_raw(&desc);
 	resp->cmd_flags = cpu_to_le16(cmd_flags);
 	resp->lport_num = hw->bus.func;
@@ -1561,19 +1559,6 @@ static int ixgbe_aci_init_event_mask(struct ixgbe_hw *hw)
 	return ixgbe_aci_set_event_mask(hw, (u8)hw->bus.func, mask);
 }
 
-/**
- * ixgbe_configure_lse - enable/disable link status events
- * @hw: pointer to the HW struct
- * @activate: true for enable lse, false otherwise
- *
- * Return: the exit code of the operation.
- */
-int ixgbe_configure_lse(struct ixgbe_hw *hw, bool activate)
-{
-	/* Enabling link status events generation by fw. */
-	return ixgbe_aci_get_link_info(hw, activate, NULL);
-}
-
 /**
  * ixgbe_start_hw_e610 - Prepare hardware for Tx/Rx
  * @hw: pointer to hardware structure
@@ -1913,7 +1898,7 @@ void ixgbe_fc_autoneg_e610(struct ixgbe_hw *hw)
 	/* Get current link err.
 	 * Current FC mode will be stored in the hw context.
 	 */
-	err = ixgbe_aci_get_link_info(hw, true, NULL);
+	err = ixgbe_aci_get_link_info(hw, NULL);
 	if (err)
 		goto no_autoneg;
 
@@ -2219,7 +2204,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
 	u64 phy_type_low = 0, phy_type_high = 0;
 	int err;
 
-	err = ixgbe_aci_get_link_info(hw, true, NULL);
+	err = ixgbe_aci_get_link_info(hw, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index ecda35a77adb..4fb4ab99d458 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -32,9 +32,8 @@ int ixgbe_aci_set_phy_cfg(struct ixgbe_hw *hw,
 int ixgbe_aci_set_link_restart_an(struct ixgbe_hw *hw, bool ena_link);
 int ixgbe_update_link_info(struct ixgbe_hw *hw);
 int ixgbe_get_link_status(struct ixgbe_hw *hw, bool *link_up);
-int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, bool ena_lse,
+int ixgbe_aci_get_link_info(struct ixgbe_hw *hw,
 			    struct ixgbe_link_status *link);
-int ixgbe_configure_lse(struct ixgbe_hw *hw, bool activate);
 int ixgbe_aci_set_port_id_led(struct ixgbe_hw *hw, bool orig_mode);
 enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw);
 int ixgbe_setup_link_e610(struct ixgbe_hw *hw, ixgbe_link_speed speed,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index b8e85bc91a27..5d71c1011cf4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3647,7 +3647,7 @@ static int ixgbe_get_eee_e610(struct net_device *netdev,
 	linkmode_zero(kedata->supported);
 	linkmode_zero(kedata->advertised);
 
-	err = ixgbe_aci_get_link_info(hw, true, &link);
+	err = ixgbe_aci_get_link_info(hw, &link);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f33a534490b5..d1cfe913081f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5966,19 +5966,6 @@ static void ixgbe_configure(struct ixgbe_adapter *adapter)
 	ixgbe_configure_dfwd(adapter);
 }
 
-/**
- * ixgbe_enable_link_status_events - enable link status events
- * @adapter: pointer to the adapter structure
- *
- * Enables link status events by invoking ixgbe_configure_lse()
- *
- * Return: the exit code of the operation.
- */
-static int ixgbe_enable_link_status_events(struct ixgbe_adapter *adapter)
-{
-	return ixgbe_configure_lse(&adapter->hw, true);
-}
-
 /**
  * ixgbe_sfp_link_config - set up SFP+ link
  * @adapter: pointer to private adapter struct
@@ -6008,8 +5995,6 @@ static void ixgbe_sfp_link_config(struct ixgbe_adapter *adapter)
  **/
 static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 {
-	struct ixgbe_adapter *adapter = container_of(hw, struct ixgbe_adapter,
-						     hw);
 	bool autoneg, link_up = false;
 	int ret = -EIO;
 	u32 speed;
@@ -6035,14 +6020,8 @@ static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 	if (ret)
 		return ret;
 
-	if (hw->mac.ops.setup_link) {
-		if (adapter->hw.mac.type == ixgbe_mac_e610) {
-			ret = ixgbe_enable_link_status_events(adapter);
-			if (ret)
-				return ret;
-		}
+	if (hw->mac.ops.setup_link)
 		ret = hw->mac.ops.setup_link(hw, speed, link_up);
-	}
 
 	return ret;
 }
-- 
2.31.1


