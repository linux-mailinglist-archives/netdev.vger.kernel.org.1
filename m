Return-Path: <netdev+bounces-116799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700A194BC26
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040B7282C34
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E91891AC;
	Thu,  8 Aug 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byc+qfOe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482912C7FD
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116144; cv=none; b=GzjOVlq97t0XIzZ92OG4A508daGcWjiIK4eLdbrrFk2rJED5NvsRrF9nKb5T1Uj1QP+OkwD4CZRlWloBubMEIxyEJMwbbmt9dGGA7EAEmuzlsTUGVHHrP4c2AROsHD9VwnsZqEF9snt4gWvJDY664KYiPzHXY9SkP67hLtmPbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116144; c=relaxed/simple;
	bh=boMFstUhVQMsNW3xa4HAW4jtrge3LjkojImXyNp5wt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J967Wec/3en16GnuNQqmL2rTmcNCu17NfYbjHTmV5D+S+g7pmwzUQHN02Ga900QvK1H6ouR8YhxlcjomZGewO2b2xxdc8TiXRKRqwwEOmfZCxegnDRO9XB0krX3najbS3XDwK/qQ6Hi2u1tTqMgiDE/o/la0PnJhBCyBmrgffwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byc+qfOe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723116142; x=1754652142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=boMFstUhVQMsNW3xa4HAW4jtrge3LjkojImXyNp5wt4=;
  b=byc+qfOe1O4bdpcmkGKHAmr+ivzK7wYRC5tYYLfOylIyKzE/FCWC0f/d
   GZloRZMULAWexjwLlIez+0S++IXAg+jLZfvjgiD96IISd1c47cqX+5Uv6
   JKU+xIJ4KGMWcLdql8LArPGwV29+/46fQr7IO7ncvXWi1//6GVFRmwf25
   ifO2JKVghlQIomaCTdcndkd9jkcGnj2hSrhI+Qiq4zefBXXLu8x6F4XC1
   Y97dUpG5XZsGoJGIS56IrqHuhXGI2Wenq0OdtDQlysdZsNjPXBtPbCgQ3
   /OCatFlwSMEPRFwmXo2Qewd+kRIDe5qyb4TtIfrOKS26QUy9dZvxUsS00
   w==;
X-CSE-ConnectionGUID: Ie1PKQMoQneENHAmPZTEjw==
X-CSE-MsgGUID: qX6w+1kTSxWousH1hQtsww==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="25027263"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="25027263"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:22:20 -0700
X-CSE-ConnectionGUID: bQu+0RPOTACA7wsMTw5WmQ==
X-CSE-MsgGUID: 9qC6DPDjTEesezrzH2pi9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57109927"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by orviesa009.jf.intel.com with ESMTP; 08 Aug 2024 04:22:19 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next v1] i40e: Add Energy Efficient Ethernet ability for X710 Base-T/KR/KX cards
Date: Thu,  8 Aug 2024 13:22:17 +0200
Message-Id: <20240808112217.3560733-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "EEE: Enabled/Disabled" to dmesg for supported X710 Base-T/KR/KX cards.
According to the IEEE standard report the EEE ability and and the
EEE Link Partner ability. Use the kernel's 'ethtool_keee' structure
and report EEE link modes.

Example:
dmesg | grep 'NIC Link is'
ethtool --show-eee <device>

Before:
	NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None

        Supported EEE link modes:  Not reported
        Advertised EEE link modes:  Not reported
        Link partner advertised EEE link modes:  Not reported

After:
	NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None, EEE: Enabled

        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
                                   10000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
                                    10000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full
                                                 10000baseT/Full

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 37 ++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 25 +++++++++++--
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d546567..0f25a48 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
+#include <linux/linkmode.h>
 #include <linux/avf/virtchnl.h>
 #include <linux/net/intel/i40e_client.h>
 #include <net/devlink.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1d0d2e5..cd7509f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5641,50 +5641,77 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
+static void i40e_eee_capability_to_kedata_supported(__le16  eee_capability_,
+						    unsigned long *supported)
+{
+	const int eee_capability = le16_to_cpu(eee_capability_);
+	static const int lut[] = {
+		ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+		ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+	};
+
+	linkmode_zero(supported);
+	for (unsigned int i = ARRAY_SIZE(lut); i--; )
+		if (eee_capability & (1 << (i + 1)))
+			linkmode_set_bit(lut[i], supported);
+}
+
 static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_aq_get_phy_abilities_resp phy_cfg;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
-	int status = 0;
+	int status;
 
 	/* Get initial PHY capabilities */
 	status = i40e_aq_get_phy_capabilities(hw, false, true, &phy_cfg, NULL);
 	if (status)
 		return -EAGAIN;
 
 	/* Check whether NIC configuration is compatible with Energy Efficient
 	 * Ethernet (EEE) mode.
 	 */
 	if (phy_cfg.eee_capability == 0)
 		return -EOPNOTSUPP;
 
+	i40e_eee_capability_to_kedata_supported(phy_cfg.eee_capability, edata->supported);
+	linkmode_copy(edata->lp_advertised, edata->supported);
+
 	/* Get current configuration */
 	status = i40e_aq_get_phy_capabilities(hw, false, false, &phy_cfg, NULL);
 	if (status)
 		return -EAGAIN;
 
+	linkmode_zero(edata->advertised);
+	if (phy_cfg.eee_capability)
+		linkmode_copy(edata->advertised, edata->supported);
 	edata->eee_enabled = !!phy_cfg.eee_capability;
 	edata->tx_lpi_enabled = pf->stats.tx_lpi_status;
 
 	edata->eee_active = pf->stats.tx_lpi_status && pf->stats.rx_lpi_status;
 
 	return 0;
 }
 
 static int i40e_is_eee_param_supported(struct net_device *netdev,
 				       struct ethtool_keee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_ethtool_not_used {
-		u32 value;
+		int value;
 		const char *name;
 	} param[] = {
-		{edata->tx_lpi_timer, "tx-timer"},
+		{!!(edata->advertised[0] & ~edata->supported[0]), "advertise"},
+		{!!edata->tx_lpi_timer, "tx-timer"},
 		{edata->tx_lpi_enabled != pf->stats.tx_lpi_status, "tx-lpi"}
 	};
 	int i;
@@ -5710,7 +5737,7 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	__le16 eee_capability;
-	int status = 0;
+	int status;
 
 	/* Deny parameters we don't support */
 	if (i40e_is_eee_param_supported(netdev, edata))
@@ -5754,7 +5781,7 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		config.eeer |= cpu_to_le32(I40E_PRTPM_EEER_TX_LPI_EN_MASK);
 	} else {
 		config.eee_capability = 0;
-		config.eeer &= cpu_to_le32(~I40E_PRTPM_EEER_TX_LPI_EN_MASK);
+		config.eeer &= ~cpu_to_le32(I40E_PRTPM_EEER_TX_LPI_EN_MASK);
 	}
 
 	/* Apply modified PHY configuration */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cbcfada..55bbf0f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7263,6 +7263,22 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 	return err;
 }
 #endif /* CONFIG_I40E_DCB */
+static void i40e_print_link_message_eee(struct i40e_vsi *vsi, struct ethtool_keee *kedata,
+			    const char *speed, const char *fc)
+{
+	if (vsi->netdev->ethtool_ops->get_eee)
+		vsi->netdev->ethtool_ops->get_eee(vsi->netdev, kedata);
+
+	if (!linkmode_empty(kedata->supported))
+		netdev_info(vsi->netdev,
+			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s, EEE: %s\n",
+			    speed, fc,
+			    kedata->eee_enabled ? "Enabled" : "Disabled");
+	else
+		netdev_info(vsi->netdev,
+			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s\n",
+			    speed, fc);
+}
 
 /**
  * i40e_print_link_message - print link up or down
@@ -7395,9 +7411,12 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 			    "NIC Link is Up, %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg: %s, Flow Control: %s\n",
 			    speed, req_fec, fec, an, fc);
 	} else {
-		netdev_info(vsi->netdev,
-			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s\n",
-			    speed, fc);
+		struct ethtool_keee kedata;
+
+		linkmode_zero(kedata.supported);
+		kedata.eee_enabled = false;
+
+		i40e_print_link_message_eee(vsi, &kedata, speed, fc);
 	}
 
 }
-- 
2.25.1


