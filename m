Return-Path: <netdev+bounces-100385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42238FA497
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6F41C23783
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFD13C832;
	Mon,  3 Jun 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljvTIisU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3113C9C9
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451495; cv=none; b=VQU3OklhFfD2JkBcvfzH/pLm+QvlQs96HXw/L4ZHEZdz03gjPKkTLNkWqT6yK8eo72fOafoJFs60EVbBP+UbFuhp6VpDGT1bXA6tKMx7r96MApx3GVMcpX/VcjT85f1pfIVMPXSJ+zbr69RX7ZMOvN36pZMZ5wk7ToBkQU+9eCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451495; c=relaxed/simple;
	bh=+TDF/2CIRei3Ohwr7BN0FeQPT5azQyI0+4qZrUM2OcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5OLUBEpNgobBwy6syrVA1L32thyiySFMQVvI160oB5g1cdvvLapBcJp89+wp1tSejukGEQswQnS5Tnglh62BJQHOYNuLvPBXD72NGpvCfr4pn0gHAQlgotVH8tkm1A53hOHAEWK/3ISXll7W44psaLPUXIicnfpm+oOrG50hXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljvTIisU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717451491; x=1748987491;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+TDF/2CIRei3Ohwr7BN0FeQPT5azQyI0+4qZrUM2OcM=;
  b=ljvTIisUNZR2MGORjUGHdJ+y6eRp3ssEh+sseDtwt9++ZjocXrGjTNdq
   GXpQZCWrgHiss9L8WmRWaYX9sRNFrh1imZ5Hulu1Sz3jceGe+5Bi4/fCj
   S7Ygi9M6RWABBeE3WXR+IZ6kkG5UVOlIBp8addiGasg0ckq3Lww+rX250
   3EMV/c93fJFoa6NS0yezGCEnhzOHwPIHvqahYHC1C9zQvwwKFt7nzj7U/
   mizVDTHlzRZsrF6sDJqk/neIIyCgdclJ+RwdKP1pg+VY/73WSnD/++NyZ
   RIKSgHpQG8X3yTe83LP4yxuQBPHHz8T9Fy3V48jPCa/OIECmvOGKUgPW/
   A==;
X-CSE-ConnectionGUID: SPF/a2znToecBgZqEX/yUw==
X-CSE-MsgGUID: e/Usq4SBQ2eWf6l4D7YIwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24547599"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24547599"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
X-CSE-ConnectionGUID: 0FjcPghXRPmXAhHtRiPLFw==
X-CSE-MsgGUID: aaSvKKf6Tb696Ho+uYcISw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37608252"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 14:42:35 -0700
Subject: [PATCH net v2 6/6] igc: Fix Energy Efficient Ethernet support
 declaration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-net-2024-05-30-intel-net-fixes-v2-6-e3563aa89b0c@intel.com>
References: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
In-Reply-To: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Sasha Neftin <sasha.neftin@intel.com>, 
 Dima Ruinskiy <dima.ruinskiy@intel.com>, 
 Naama Meir <naamax.meir@linux.intel.com>
X-Mailer: b4 0.13.0

From: Sasha Neftin <sasha.neftin@intel.com>

The commit 01cf893bf0f4 ("net: intel: i40e/igc: Remove setting Autoneg in
EEE capabilities") removed SUPPORTED_Autoneg field but left inappropriate
ethtool_keee structure initialization. When "ethtool --show <device>"
(get_eee) invoke, the 'ethtool_keee' structure was accidentally overridden.
Remove the 'ethtool_keee' overriding and add EEE declaration as per IEEE
specification that allows reporting Energy Efficient Ethernet capabilities.

Examples:
Before fix:
ethtool --show-eee enp174s0
EEE settings for enp174s0:
	EEE status: not supported

After fix:
EEE settings for enp174s0:
	EEE status: disabled
	Tx LPI: disabled
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	                           2500baseT/Full

Fixes: 01cf893bf0f4 ("net: intel: i40e/igc: Remove setting Autoneg in EEE capabilities")
Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 9 +++++++--
 drivers/net/ethernet/intel/igc/igc_main.c    | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index f2c4f1966bb0..0cd2bd695db1 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1629,12 +1629,17 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 	struct igc_hw *hw = &adapter->hw;
 	u32 eeer;
 
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 edata->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 edata->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			 edata->supported);
+
 	if (hw->dev_spec._base.eee_enable)
 		mii_eee_cap1_mod_linkmode_t(edata->advertised,
 					    adapter->eee_advert);
 
-	*edata = adapter->eee;
-
 	eeer = rd32(IGC_EEER);
 
 	/* EEE status on negotiated link */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 12f004f46082..305e05294a26 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -12,6 +12,7 @@
 #include <linux/bpf_trace.h>
 #include <net/xdp_sock_drv.h>
 #include <linux/pci.h>
+#include <linux/mdio.h>
 
 #include <net/ipv6.h>
 
@@ -4975,6 +4976,9 @@ void igc_up(struct igc_adapter *adapter)
 	/* start the watchdog. */
 	hw->mac.get_link_status = true;
 	schedule_work(&adapter->watchdog_task);
+
+	adapter->eee_advert = MDIO_EEE_100TX | MDIO_EEE_1000T |
+			      MDIO_EEE_2_5GT;
 }
 
 /**

-- 
2.44.0.53.g0f9d4d28b7e6


