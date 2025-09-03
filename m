Return-Path: <netdev+bounces-219691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3FB42AD0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25727B85F8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854DF2E336F;
	Wed,  3 Sep 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6ht+rOI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BF2DC35B
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931143; cv=none; b=kADctZi7JEX9Vmz2dPW90O8dryhU2azrlZPDhDP7phSRrzg7LR2KTw5DmydlPSTANyoBSRuR/2devqDV/UW22zUe9WYYOcvzVSAaUzJWs0mP93K5eYqDXwNuRsX0LhPKPhHdslam73qtTk+5i0+WpAaMBpUBqzgDmASKdrHj/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931143; c=relaxed/simple;
	bh=z4z1g2KNDStkYhEc1ZBMVhWhxC5yprenWEMNv0tRiZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCumrQ9VLHkspCDNk+eSG7R3gFXDYkj7p+fJAmNcI+j/Gq1VZk+Tgp5Jc5FTu3PMmM1gHyilJsrnbtr5kbZIRXanHJCXaO+sSYiRuPoMLj/yQxArA+wVZJtV5pwKqlAxYRXrnWHqyGsPQcANtNRoH5ATGk+YYi7ymaE0ps2PJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6ht+rOI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931142; x=1788467142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z4z1g2KNDStkYhEc1ZBMVhWhxC5yprenWEMNv0tRiZc=;
  b=D6ht+rOImhXZBGfDyw7d3tQxjPTalKzWUGTfYAjHIJH7B1UdERH91f0s
   orTS1lrXz7y0fnfxpBQw5TCsdr87rKJ1KQUIdxFDUJ+lHWCXExIT6KdRs
   Cj/PxRzH8zmPTGOchrrKTbXAgFkcoSHekLEWoRL5Bmykps5VzE2NryDWE
   3ZUxWPiwekbQ5oGM2k23jHbCRL9H/Cv6N8IfhTTqLah32QZlZil0hF9Vs
   6QPav61AjsAeNepO6Jj3vUuz4pdVr75MWtyWnzX5PkmDJ5yOSIIuHxpVs
   ITCr2Iw8uHi5+B+Sr/9bOHIy8qh71Gg50/O6Rs5f84aR6cBPNBcKGGQut
   A==;
X-CSE-ConnectionGUID: Ccpd9ONRSoGiWWzoGiyWzQ==
X-CSE-MsgGUID: mo0QFFfhT9+Y0tEabqXF5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173006"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173006"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:40 -0700
X-CSE-ConnectionGUID: 67ZkkEyvRl6euKUH5I0ngg==
X-CSE-MsgGUID: hPN4h7+ATPO0o02yX0lZSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823442"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Sep 2025 13:25:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 1/9] ixgbe: add the 2.5G and 5G speeds in auto-negotiation for E610
Date: Wed,  3 Sep 2025 13:25:27 -0700
Message-ID: <20250903202536.3696620-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
References: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

The auto-negotiation limitation for 2.5G and 5G speeds is no longer true
for X550 successors like E610 adapter. Enable the 2.5G and 5G speeds in
auto-negotiation for E610 at driver load.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 35 +++++++------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index bfeef5b0b99d..7d4f12b69ee2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1953,6 +1953,16 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	    phy_type_low  & IXGBE_PHY_TYPE_LOW_1G_SGMII    ||
 	    phy_type_high & IXGBE_PHY_TYPE_HIGH_1G_USXGMII)
 		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_1GB_FULL;
+	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_T   ||
+	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_X   ||
+	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_KX  ||
+	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_SGMII ||
+	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_USXGMII)
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_2_5GB_FULL;
+	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_T  ||
+	    phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_KR ||
+	    phy_type_high & IXGBE_PHY_TYPE_HIGH_5G_USXGMII)
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_5GB_FULL;
 	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_10GBASE_T       ||
 	    phy_type_low  & IXGBE_PHY_TYPE_LOW_10G_SFI_DA      ||
 	    phy_type_low  & IXGBE_PHY_TYPE_LOW_10GBASE_SR      ||
@@ -1963,31 +1973,10 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	    phy_type_high & IXGBE_PHY_TYPE_HIGH_10G_USXGMII)
 		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_10GB_FULL;
 
-	/* 2.5 and 5 Gbps link speeds must be excluded from the
-	 * auto-negotiation set used during driver initialization due to
-	 * compatibility issues with certain switches. Those issues do not
-	 * exist in case of E610 2.5G SKU device (0x57b1).
-	 */
-	if (!hw->phy.autoneg_advertised &&
-	    hw->device_id != IXGBE_DEV_ID_E610_2_5G_T)
+	/* Initialize autoneg speeds */
+	if (!hw->phy.autoneg_advertised)
 		hw->phy.autoneg_advertised = hw->phy.speeds_supported;
 
-	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_T   ||
-	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_X   ||
-	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_KX  ||
-	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_SGMII ||
-	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_USXGMII)
-		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_2_5GB_FULL;
-
-	if (!hw->phy.autoneg_advertised &&
-	    hw->device_id == IXGBE_DEV_ID_E610_2_5G_T)
-		hw->phy.autoneg_advertised = hw->phy.speeds_supported;
-
-	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_T  ||
-	    phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_KR ||
-	    phy_type_high & IXGBE_PHY_TYPE_HIGH_5G_USXGMII)
-		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_5GB_FULL;
-
 	/* Set PHY ID */
 	memcpy(&hw->phy.id, pcaps.phy_id_oui, sizeof(u32));
 
-- 
2.47.1


