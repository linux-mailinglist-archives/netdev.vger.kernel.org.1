Return-Path: <netdev+bounces-99505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A68D5125
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63233285CAC
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA724C3C3;
	Thu, 30 May 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bu1ejZEf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78008481C2
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090809; cv=none; b=pF5u/UF65VONUBYyVdsjX40EW789Lmx9z5auZNFzcQF7BSmUtlWFQJaD7Mas8QCOYoUg7+KKjMC+TAnFiowGWF5YChgFbv3V9DPejB0CJn4xRVva2ZyHwPi3DqZ2ROZJrbVq2L8hA9GWo4ld/M4RekXX8lVgZYUWhNIMvSObzwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090809; c=relaxed/simple;
	bh=+TDF/2CIRei3Ohwr7BN0FeQPT5azQyI0+4qZrUM2OcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVbhTdFyiBcWUSWAMKtK2xEFnQyC5Sh7pj3FXs0bEi+3eJYgUnTrbasQo+T7ensUVIPUjvuBJMpCYQ1TJYWlVCP6sVivvnJlbygNjrhqTv3Em296wpHgtxyIrQPqY7sIxses6S3YSWJymS+EIowu2JyveJtNFwVGFp7D3Wg4Un8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bu1ejZEf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717090807; x=1748626807;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+TDF/2CIRei3Ohwr7BN0FeQPT5azQyI0+4qZrUM2OcM=;
  b=Bu1ejZEfF6lyrcLfE9UV6hGLu43jIKXGaV+mCEfHw/M2Rnk7D13b7bgn
   AsrxyAPsich+c0g1REI8R50b+g6mfVcXTvD236q9fW1mQ2uSpLPsVLJMQ
   It2qCaoSoDuoHfV1foMZVET/KqBUg40Lx1Lacd5vq6KEzontowutngFEV
   vV26kugLaL8llodFgXmX38ILkLEU011I1yY7C28wJXQAfTJIwendmhdCE
   ou4xc/Q86k5xFgPp6k01PlfTmGZdk1rtVmEMNqQPQBbUEuhxLYOzFyegf
   eXp2PMBRIFJgTI63hK+4QFGcZZHENfl3TDNnYns7w0hHMnh8KT26RlCt1
   w==;
X-CSE-ConnectionGUID: coZXPYyHS8+CmIchCR9OXg==
X-CSE-MsgGUID: ZN/QLe/sTICuB8IOVHeIkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31119269"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31119269"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:03 -0700
X-CSE-ConnectionGUID: uRvhIuOrRiSfiRDxGcbqlA==
X-CSE-MsgGUID: wrSv0pqeQrypfEI9V+otmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66766686"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 May 2024 10:39:33 -0700
Subject: [PATCH net 6/6] igc: Fix Energy Efficient Ethernet support
 declaration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-net-2024-05-30-intel-net-fixes-v1-6-8b11c8c9bff8@intel.com>
References: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
In-Reply-To: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
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


