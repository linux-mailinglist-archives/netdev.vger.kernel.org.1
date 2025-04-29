Return-Path: <netdev+bounces-186897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917CAA3CE9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E569A27F0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F954246796;
	Tue, 29 Apr 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS8jBvtN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53863246769
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970426; cv=none; b=IYhBOjhHX+W7tzdmnnK6D/CTy3Y//TJTpN6lsHthcKBmgeAH7741LYrApCvYM1I0Mf392CROaxRfbgv4unjjSWgk27jZI0aLqla74jmlzjLH2HfN+wsPkJWjIlpCGyQSrkqdPRAvHc8VQaFTG8DpDWjPaJ49F9URhNhZ6vEZHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970426; c=relaxed/simple;
	bh=fI2YRKcMNymoqjAOmXIng5Uxo7qFe3oStieL03pd5fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0ZyvkTLXqgcmsb0MtOtndD0i7cXudRoApkCQBFnOXk8ixBbf9HmZcdCFbQF5ampmlRHHThghVxruNRGlJ+0btR6SbeInyXGDzeY7xJ7t6eqhuVgOLw+Y3u9x3RwkCAH9UKgh4f+GW7yrKDz6C++eh21S/eAwKozUpKUgNa0d5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS8jBvtN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970425; x=1777506425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fI2YRKcMNymoqjAOmXIng5Uxo7qFe3oStieL03pd5fg=;
  b=kS8jBvtNoMZO4cmOfaOJWqeUm9XBdEPSYrKkQxEeGo2x3uqUV+E5C4Nd
   Db51IMsB2/ufnj7Tv1ohPnIb9Y9TMPJuM5nvWB2ZqoYQNMds1q2s4IuK3
   vRkobPrgBEa31CjdDIhDDhGpoQj4cWYKDELkaD7o3D6glxFR9sM2f6M38
   R1GADZ2xdgFIeJsspQkqAYIOARuez9Z5WK7mq+FXF73UyWMnYKTMIG0hg
   +2efdM70HS04L35wYc2JdRJAjjMtCSD4edprq1fepdqjgEgBKTUM5NoHE
   Ker9ZY0a6iwCkV8wmhXw/C+NTi3PCP72xdPOTFQjbXliT0kwmWyQkcw1C
   A==;
X-CSE-ConnectionGUID: i/pZ7ZBpS+ezvGItfftq/w==
X-CSE-MsgGUID: 8tDQapSPSkuJ7x9JTZPbHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990109"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990109"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:03 -0700
X-CSE-ConnectionGUID: 2j6AKF4KT2W406cO1gLsMg==
X-CSE-MsgGUID: bn8cceyTRoe6sJoZ5EPsaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979631"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:01 -0700
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
	Simon Horman <horms@kernel.org>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 07/13] ixgbe: create E610 specific ethtool_ops structure
Date: Tue, 29 Apr 2025 16:46:42 -0700
Message-ID: <20250429234651.3982025-8-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index cdfafc477ee0..40daab34e4fe 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11433,11 +11433,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -11467,6 +11462,11 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
2.47.1


