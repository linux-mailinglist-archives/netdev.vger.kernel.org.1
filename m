Return-Path: <netdev+bounces-186898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AACAA3CEA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D10E9A530A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189C255F29;
	Tue, 29 Apr 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEEKhyJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333B24678B
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970426; cv=none; b=smszTK+SUnC/4CeS0W/bxl3uOpyXfFyecIypcNrmt1DGOhBKmWo4EFAtYcP0/br7v/KKH7X3lRjGvd6HHO2yqDMfCfSy1iFiM6dzbgZs2tkOPMqQXWOBDodfCaLM4DF/x5OPC16Z+rvdbMzJItA0PCfipRFtX7FNTSpIE1K0zrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970426; c=relaxed/simple;
	bh=ZbgEhEmewsCsLrQJXRIg8bEnHZYpGiaZkYUr1Bbj/Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg6jTETVLdPDVLuFqi+u5/IwzqKeQ0FF2/zVX2p3wqvM+ACrtYIQDHKE2unYL2occhg1d9qQz2Dh8NPcRlPYNsIhY6lR9SJDwom0lcauaLE+++ZYS1cZs2WsJjRv3kj9VZOO67WxKNAE69VCrk7MFh2RtC/AJkh6p5432jzElfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEEKhyJZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970426; x=1777506426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbgEhEmewsCsLrQJXRIg8bEnHZYpGiaZkYUr1Bbj/Pw=;
  b=HEEKhyJZOFTwu22lB+IkbarwKWwVCQUVHM5+HZoMJYhg5j1muT7jwSuy
   jaoZ3ftKnz5Iv3t8l1Mrs1Uh91b++KDUh4ahZMvNhxQsOujZJakfPrrTf
   G1WAlAyJuSWKGpQ8Aprc00TrIDL6MYZ9qn0n2lTqHcvZsazKrWiK/GdqW
   u2vVWoR7SmCwcARslZUHp11okFKKjjpHA4TanBZFQ8Br5MqQ2fAZdZWYb
   h9qf8Zukp56CAoInh90M19oNcFsFukgOaCgA4twY5kLJA/aq57hpn8tdX
   xCZkHslWcOU3+XHsbSQHholfPFKF8bJpJca0dgEnauXhWN1+s1pg9Wavf
   w==;
X-CSE-ConnectionGUID: nRDrRn9BRRm+Rr5AHJqjfw==
X-CSE-MsgGUID: Hyxj/EL+Sp6B+uBhbQi/DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990115"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990115"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:03 -0700
X-CSE-ConnectionGUID: i7fLRHJFQ9CqYe4+LxVHzQ==
X-CSE-MsgGUID: 2DE6y43lSzqFmB5UzRtsKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979634"
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 08/13] ixgbe: add support for ACPI WOL for E610
Date: Tue, 29 Apr 2025 16:46:43 -0700
Message-ID: <20250429234651.3982025-9-anthony.l.nguyen@intel.com>
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

Currently only APM (Advanced Power Management) is supported by
the ixgbe driver. It works for magic packets only, as for different
sources of wake-up E610 adapter utilizes different feature.

Add E610 specific implementation of ixgbe_set_wol() callback. When
any of broadcast/multicast/unicast wake-up is set, disable APM and
configure ACPI (Advanced Configuration and Power Interface).

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


