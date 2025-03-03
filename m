Return-Path: <netdev+bounces-171225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC6A4C02D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF27A77E2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEB120FAA0;
	Mon,  3 Mar 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4jtm58z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4420F077
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004434; cv=none; b=d7rYfjz8ZypzEw0bgPvkgAWVaiehdiG+KpGBE/VGPB5b5FsXzXudQz3swPBGQUJ1KxJxV5Rrt5zeznyeWLD4udhTnAqnsvN1jUk5lqUPnbXh/Ch40tii7fHV7ZpPCebiALROa6h/GWX3V9X8QEofxScu83uavMh2IV32vllziRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004434; c=relaxed/simple;
	bh=LVDZfMPOEih0ayuqtp6N23jO8XWCLAEalFTiBen0j1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuXIW6duzDzfxp22pAI0giOFhpxD6mzn1hVDCBf8xtG72YYku+CTH87YmHdmLOeyzN2IkPHOxrOvZVNbmGo/goALO14NWv0oxAQNlVBqYyYulZDesTRe133HceMlLuYBR68n2Zn8iWu0YNd9EvAe/QRQH/ZucrD9MYCSjFarDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4jtm58z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741004433; x=1772540433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LVDZfMPOEih0ayuqtp6N23jO8XWCLAEalFTiBen0j1s=;
  b=M4jtm58ztZPeDtEh2lQVBvbTJmjbdds/VeU3VOQhZeF0LvA7aMgsW8IN
   9n5w+DYSoIVbg/lLscOyq/dba07r7Pc2ubjnABNEHHr9iui22GwVpWj+p
   xompDqLsXl9DmHUs+mdGU9m+0JGCFbG4SQtBX7Ksz72D0tjRyTQQxe4ZN
   t9Kpgu9yngSJnuwOrLHUzqa/EV5xl1/ZY1Q8AqOYlrWY4OHivZX5bS8Um
   Nk0E6vGNNVJaTCHHDhvnm+Ftaa8G5aAKh0GPkr1PrXnmtrsQsuZWoVuCc
   F5YFwCGWShucWmB9jBTsoX36EAe1cN7pBY3fjUTatUr9v1IA7PVX6j/C4
   w==;
X-CSE-ConnectionGUID: UIi8wnOZRJyUotqGqpdGZQ==
X-CSE-MsgGUID: cx/1+paoSNymPlecqKNZ1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41052435"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41052435"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:20:33 -0800
X-CSE-ConnectionGUID: eHoIPpWPSZurtQOQzUbPTg==
X-CSE-MsgGUID: /3VzKCQuQJK0rwn+QvsFCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117976113"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa007.fm.intel.com with ESMTP; 03 Mar 2025 04:20:31 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3 2/4] ixgbe: add support for ACPI WOL for E610
Date: Mon,  3 Mar 2025 13:06:28 +0100
Message-Id: <20250303120630.226353-3-jedrzej.jagielski@intel.com>
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

Currently only APM (Advanced Power Management) is supported by
the ixgbe driver. It works for magic packets only, as for different
sources of wake-up E610 adapter utilizes different feature.

Add E610 specific implementation of ixgbe_set_wol() callback. When
any of broadcast/multicast/unicast wake-up is set, disable APM and
configure ACPI (Advanced Configuration and Power Interface).

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 83d9ee3941e5..abc8c279192a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2365,6 +2365,50 @@ static int ixgbe_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 	return 0;
 }
 
+static int ixgbe_set_wol_acpi(struct net_device *netdev,
+			      struct ethtool_wolinfo *wol)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 grc;
+
+	if (ixgbe_wol_exclusion(adapter, wol))
+		return wol->wolopts ? -EOPNOTSUPP : 0;
+
+	/* disable APM wakeup */
+	grc = IXGBE_READ_REG(hw, IXGBE_GRC_X550EM_a);
+	grc &= ~IXGBE_GRC_APME;
+	IXGBE_WRITE_REG(hw, IXGBE_GRC_X550EM_a, grc);
+
+	/* erase existing filters */
+	IXGBE_WRITE_REG(hw, IXGBE_WUFC, 0);
+	adapter->wol = 0;
+
+	if (wol->wolopts & WAKE_UCAST)
+		adapter->wol |= IXGBE_WUFC_EX;
+	if (wol->wolopts & WAKE_MCAST)
+		adapter->wol |= IXGBE_WUFC_MC;
+	if (wol->wolopts & WAKE_BCAST)
+		adapter->wol |= IXGBE_WUFC_BC;
+
+	IXGBE_WRITE_REG(hw, IXGBE_WUC, IXGBE_WUC_PME_EN);
+	IXGBE_WRITE_REG(hw, IXGBE_WUFC, adapter->wol);
+
+	hw->wol_enabled = adapter->wol;
+	device_set_wakeup_enable(&adapter->pdev->dev, adapter->wol);
+
+	return 0;
+}
+
+static int ixgbe_set_wol_e610(struct net_device *netdev,
+			      struct ethtool_wolinfo *wol)
+{
+	if (wol->wolopts & (WAKE_UCAST | WAKE_MCAST | WAKE_BCAST))
+		return ixgbe_set_wol_acpi(netdev, wol);
+	else
+		return ixgbe_set_wol(netdev, wol);
+}
+
 static int ixgbe_nway_reset(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
@@ -3656,7 +3700,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.get_regs_len           = ixgbe_get_regs_len,
 	.get_regs               = ixgbe_get_regs,
 	.get_wol                = ixgbe_get_wol,
-	.set_wol                = ixgbe_set_wol,
+	.set_wol                = ixgbe_set_wol_e610,
 	.nway_reset             = ixgbe_nway_reset,
 	.get_link               = ethtool_op_get_link,
 	.get_eeprom_len         = ixgbe_get_eeprom_len,
-- 
2.31.1


