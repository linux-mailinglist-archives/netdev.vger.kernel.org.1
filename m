Return-Path: <netdev+bounces-171224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9EA4C026
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3A51893911
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7C20F09F;
	Mon,  3 Mar 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJhv2BhD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCCB20F083
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004434; cv=none; b=WtegSqRGgO2kT+vk/6ws/zz2XzjrhguTErOxmEFdD+DYnafHzMdkFvODViiViAPy+fYl42qNzTf3BLOkOcKaVvqWG+3ewC+Om3Z6ijI2eezn4KOcd6SHflEoWiQMAp3ItJTICHkyN0AR1iNAg29bG1ANcLgkjZrx4mrjmLDjTLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004434; c=relaxed/simple;
	bh=Gv85Hsty2Iv5ISvvHpbT+I2EWz07RxluAVDdb+7pWo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YP4W8gaV5j1rKjOXVOIsy/faCr8CE2E69JDqweo5hu8s9gyuQ30WKe6vaRYZ8CesW4Y3LOQKL6xpVr8vCz+6tCxrYkwGDtl3Cfch4rTcg3BF2r6xr3sx764+N95XfBllcs23by3y6CDpM8CPk1ICqxFmR1DPKCiuFu0f3tCdC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJhv2BhD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741004432; x=1772540432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gv85Hsty2Iv5ISvvHpbT+I2EWz07RxluAVDdb+7pWo8=;
  b=gJhv2BhDVhy4JtRjJ0Ard6sQ+IrLOLWsP3HWVR+qAIsyfC+TWeddSOsF
   ayWHhEDLUeCjc6uIggqLUfhetO+UWIoSmVNTfZaKAHvDAle55V6AQ80kn
   9gsmrS1OdkVqfuBwfQphFSbk418cHyKjUTFBmLfBQhMmbaFeFA7cCmTVr
   Kvw1tVg1h0gCpvZAtx7DWIKS+rRqgb2TdAtEcbRcZwNPTfkCt7KoPVv1a
   9Dj5KHlaD+0cTQLzvTDTfXRDbaq0q7D9W7ILoHOONu9PSwZvALxqPO66B
   nlqjrUetNInpRqrMw5Oi9IoBpRiKO3vy4AChveV+gZ7Y4jP/1PWTIG6qI
   Q==;
X-CSE-ConnectionGUID: tBiBJL89QQOXB1FxfxNXKQ==
X-CSE-MsgGUID: imNGUmouTMir1u2tYXrbnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41052429"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41052429"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:20:31 -0800
X-CSE-ConnectionGUID: vL6S6XntST2OHEJ/7gFfsA==
X-CSE-MsgGUID: iP1bj8zvR0K72wL6PLMF7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117976106"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa007.fm.intel.com with ESMTP; 03 Mar 2025 04:20:29 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3 1/4] ixgbe: create E610 specific ethtool_ops structure
Date: Mon,  3 Mar 2025 13:06:27 +0100
Message-Id: <20250303120630.226353-2-jedrzej.jagielski@intel.com>
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

E610's implementation of various ethtool ops is different than
the ones corresponding to ixgbe legacy products. Therefore create
separate E610 ethtool_ops struct which will be filled out in the
forthcoming patches.

Add adequate ops struct basing on MAC type. This step requires
changing a bit the flow of probing by placing ixgbe_set_ethtool_ops
after hw.mac.type is assigned. So move the whole netdev assignment
block after hw.mac.type is known. This step doesn't have any additional
impact on probing sequence.

Suggested-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v3: correct the commit msg
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 52 ++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++--
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index c86103eccc8a..83d9ee3941e5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3650,7 +3650,57 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.set_link_ksettings     = ixgbe_set_link_ksettings,
 };
 
+static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
+	.get_drvinfo            = ixgbe_get_drvinfo,
+	.get_regs_len           = ixgbe_get_regs_len,
+	.get_regs               = ixgbe_get_regs,
+	.get_wol                = ixgbe_get_wol,
+	.set_wol                = ixgbe_set_wol,
+	.nway_reset             = ixgbe_nway_reset,
+	.get_link               = ethtool_op_get_link,
+	.get_eeprom_len         = ixgbe_get_eeprom_len,
+	.get_eeprom             = ixgbe_get_eeprom,
+	.set_eeprom             = ixgbe_set_eeprom,
+	.get_ringparam          = ixgbe_get_ringparam,
+	.set_ringparam          = ixgbe_set_ringparam,
+	.get_pause_stats	= ixgbe_get_pause_stats,
+	.get_pauseparam         = ixgbe_get_pauseparam,
+	.set_pauseparam         = ixgbe_set_pauseparam,
+	.get_msglevel           = ixgbe_get_msglevel,
+	.set_msglevel           = ixgbe_set_msglevel,
+	.self_test              = ixgbe_diag_test,
+	.get_strings            = ixgbe_get_strings,
+	.set_phys_id            = ixgbe_set_phys_id,
+	.get_sset_count         = ixgbe_get_sset_count,
+	.get_ethtool_stats      = ixgbe_get_ethtool_stats,
+	.get_coalesce           = ixgbe_get_coalesce,
+	.set_coalesce           = ixgbe_set_coalesce,
+	.get_rxnfc		= ixgbe_get_rxnfc,
+	.set_rxnfc		= ixgbe_set_rxnfc,
+	.get_rxfh_indir_size	= ixgbe_rss_indir_size,
+	.get_rxfh_key_size	= ixgbe_get_rxfh_key_size,
+	.get_rxfh		= ixgbe_get_rxfh,
+	.set_rxfh		= ixgbe_set_rxfh,
+	.get_eee		= ixgbe_get_eee,
+	.set_eee		= ixgbe_set_eee,
+	.get_channels		= ixgbe_get_channels,
+	.set_channels		= ixgbe_set_channels,
+	.get_priv_flags		= ixgbe_get_priv_flags,
+	.set_priv_flags		= ixgbe_set_priv_flags,
+	.get_ts_info		= ixgbe_get_ts_info,
+	.get_module_info	= ixgbe_get_module_info,
+	.get_module_eeprom	= ixgbe_get_module_eeprom,
+	.get_link_ksettings     = ixgbe_get_link_ksettings,
+	.set_link_ksettings     = ixgbe_set_link_ksettings,
+};
+
 void ixgbe_set_ethtool_ops(struct net_device *netdev)
 {
-	netdev->ethtool_ops = &ixgbe_ethtool_ops;
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+
+	if (adapter->hw.mac.type == ixgbe_mac_e610)
+		netdev->ethtool_ops = &ixgbe_ethtool_ops_e610;
+	else
+		netdev->ethtool_ops = &ixgbe_ethtool_ops;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 90cffa50221c..b6ce1017bf13 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11610,11 +11610,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_ioremap;
 	}
 
-	netdev->netdev_ops = &ixgbe_netdev_ops;
-	ixgbe_set_ethtool_ops(netdev);
-	netdev->watchdog_timeo = 5 * HZ;
-	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
-
 	/* Setup hw api */
 	hw->mac.ops   = *ii->mac_ops;
 	hw->mac.type  = ii->mac;
@@ -11644,6 +11639,11 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_read = ixgbe_mdio_read;
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
+	netdev->netdev_ops = &ixgbe_netdev_ops;
+	ixgbe_set_ethtool_ops(netdev);
+	netdev->watchdog_timeo = 5 * HZ;
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
+
 	/* setup the private structure */
 	err = ixgbe_sw_init(adapter, ii);
 	if (err)
-- 
2.31.1


