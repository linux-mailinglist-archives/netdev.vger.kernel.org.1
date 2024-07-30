Return-Path: <netdev+bounces-114184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A369C9413F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E287FB258DF
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2EA1A2549;
	Tue, 30 Jul 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZnJs5Imu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB31A0AEF;
	Tue, 30 Jul 2024 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348609; cv=none; b=e1asyOqJQbA9/tolXGbTtirdMvKznyymFb1AkWhRSySucSd9rDWBpBH7Iwe0JM347JcLSTvP3vq1vmCwZEWfJKr2tra/8O1eMyzBvjuuPwTqeWwSnLOXLxe5dh+AqoBLg/SvLWPk3VKKSNb1c6N1Cx2QuMAc0EAFPkjt45k85fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348609; c=relaxed/simple;
	bh=q92kTsiCAO+HesV4LSgSax01SMh8pA6Gjpg4zm0PmkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBSaYfok2dQDCuSFi8q+YeLU8AV5kBag9cKLhi+SpWPEpWNyeANd4vL2s2zLkzx6icGNX8wn0BcG9EFNAac63FjBId7sZVSFCqvpNiWgHdUq/67JNStECoDzel3gAIdkv8di0Qo0nqOkHm65/w+byEvR87lcfKNK8rSnnruw6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZnJs5Imu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722348607; x=1753884607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q92kTsiCAO+HesV4LSgSax01SMh8pA6Gjpg4zm0PmkM=;
  b=ZnJs5ImuaUzDyZNPGSQ5OEcHOhhxoyoELJlRaN972cL1TdVAEshpUAGM
   udfMO5d0lv7oopVUXdAnzp28PIsN7CHC/oWTOOepzOxwjbaPOGuYapTmi
   p8fZOPHR8/piYBYSa8OY5WW0vn3i/elkgHJTwx5U2EXYvuzrE6a7qYJJA
   HgVyTFFSuJm0M/3we2DXBdeGGH/0dlIODLLzfI3nk3kmtONdMh2jXtduG
   9XCvrXYirLhx9Hx1vxP4N1Z/ERGyrSc+/YaCwOOfu1PCi7TDJwP4Qnh5r
   F6RqOFTusZK9BXXWTPT99iKSbX3nrKhPLtwlIPYHoGESnO3bj4wXzZoPS
   A==;
X-CSE-ConnectionGUID: pJjtUho7TD2Gsi4T6qZB0A==
X-CSE-MsgGUID: ZmEpBAh9SEuk49DejQce7A==
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="260769375"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2024 07:09:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jul 2024 07:09:50 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jul 2024 07:09:45 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <horms@kernel.org>, <hkallweit1@gmail.com>,
	<richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V3 2/4] net: lan743x: Create separate Link Speed Duplex state function
Date: Tue, 30 Jul 2024 19:36:17 +0530
Message-ID: <20240730140619.80650-3-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Create separate Link Speed Duplex (LSD) update state function from
lan743x_sgmii_config () to use as subroutine.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:                                                                    
============                                                                    
V2 -> V3:
  - No change
V1 -> V2:                                                                       
  - No change                                                                  
 
 drivers/net/ethernet/microchip/lan743x_main.c | 75 +++++++++++--------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index ce1e104adc20..b4a4c2840a83 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -992,6 +992,42 @@ static int lan743x_sgmii_write(struct lan743x_adapter *adapter,
 	return ret;
 }
 
+static int lan743x_get_lsd(int speed, int duplex, u8 mss)
+{
+	int lsd;
+
+	switch (speed) {
+	case SPEED_2500:
+		if (mss == MASTER_SLAVE_STATE_SLAVE)
+			lsd = LINK_2500_SLAVE;
+		else
+			lsd = LINK_2500_MASTER;
+		break;
+	case SPEED_1000:
+		if (mss == MASTER_SLAVE_STATE_SLAVE)
+			lsd = LINK_1000_SLAVE;
+		else
+			lsd = LINK_1000_MASTER;
+		break;
+	case SPEED_100:
+		if (duplex == DUPLEX_FULL)
+			lsd = LINK_100FD;
+		else
+			lsd = LINK_100HD;
+		break;
+	case SPEED_10:
+		if (duplex == DUPLEX_FULL)
+			lsd = LINK_10FD;
+		else
+			lsd = LINK_10HD;
+		break;
+	default:
+		lsd = -EINVAL;
+	}
+
+	return lsd;
+}
+
 static int lan743x_sgmii_mpll_set(struct lan743x_adapter *adapter,
 				  u16 baud)
 {
@@ -1179,42 +1215,21 @@ static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct phy_device *phydev = netdev->phydev;
-	enum lan743x_sgmii_lsd lsd = POWER_DOWN;
 	bool status;
 	int ret;
 
-	switch (phydev->speed) {
-	case SPEED_2500:
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_MASTER)
-			lsd = LINK_2500_MASTER;
-		else
-			lsd = LINK_2500_SLAVE;
-		break;
-	case SPEED_1000:
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_MASTER)
-			lsd = LINK_1000_MASTER;
-		else
-			lsd = LINK_1000_SLAVE;
-		break;
-	case SPEED_100:
-		if (phydev->duplex)
-			lsd = LINK_100FD;
-		else
-			lsd = LINK_100HD;
-		break;
-	case SPEED_10:
-		if (phydev->duplex)
-			lsd = LINK_10FD;
-		else
-			lsd = LINK_10HD;
-		break;
-	default:
+	ret = lan743x_get_lsd(phydev->speed, phydev->duplex,
+			      phydev->master_slave_state);
+	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
-			  "Invalid speed %d\n", phydev->speed);
-		return -EINVAL;
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
 	}
 
-	adapter->sgmii_lsd = lsd;
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
 	ret = lan743x_sgmii_aneg_update(adapter);
 	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
-- 
2.34.1


