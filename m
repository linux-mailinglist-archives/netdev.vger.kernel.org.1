Return-Path: <netdev+bounces-124930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5852796B638
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCBE1F25E00
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512151CC89A;
	Wed,  4 Sep 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qvCpHTsM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A117D8A6;
	Wed,  4 Sep 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441095; cv=none; b=uzX6s+S7E4OPKsMJzO7acLVU361z8VRIdLCMZz/Erm2HN16XJ/Nij2UpN3rg7MlbxyaoL6Sc2e0l91ClQ+8YBEo0PmdgNccAUsdgNLJGBvtgHrRV3EJHv+EErrciiRY3OTS9MCu6FiUseJCak6spTt3QbvDlES7cMUTlG9oCwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441095; c=relaxed/simple;
	bh=aFlBLLBMB9BZDXRx6q7YCkU3hPzqL5ceOUsPyTbLzk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beudVUGBsa/keQR1y24Fd2sYhYIR4UBT97Kay9W5INxj2q4UhzAouB7NUSJnIHTV2ey7+Pm1lJsOGQmABKe7vh8jjltcg/4CQc0pzuUXhCAzt3ThkteEe1uToF0Gt3gV1o/USuMvBDQeQGSr1dIhY8j+mgT2Daj4Z8E5KeQrKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qvCpHTsM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725441094; x=1756977094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aFlBLLBMB9BZDXRx6q7YCkU3hPzqL5ceOUsPyTbLzk4=;
  b=qvCpHTsMu4HZzGJdbDooUI6RvFgHON3jbZRg401Rz6FApq/pOchv/lHs
   Oc/ou294qSKtZe/NvJ5PgPJKcv92FBUdHMAYlC+mVLgZszWiwg6UPXUzh
   zhLwzdmfsnGo8bmi9QxkYKc2AwbCZdpLVUo5FYoIPpR8gTvQhRyUSWutS
   NPT1UJqULEquYjach/Z5LQ6GStELKDTdrYnq4sJcEu5IqQ7Ta+xG6lYK5
   uCVkmRQby23JNTMHwhQYH+qIn7pKPh7u75e4IOtap6my4KkhmE0uxLDSP
   3kEnYAb45w1csTxTaxo8ZtvUiN5S+X/X6VeHASR5SBQV603t2RwE2vx/d
   w==;
X-CSE-ConnectionGUID: X5ttu7xLTNqJG4pfRwf/Zw==
X-CSE-MsgGUID: gA60KnLvSCCjGL6Hyk4OOQ==
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="31282055"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 02:11:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 02:10:52 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Sep 2024 02:10:47 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <maxime.chevallier@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V5 3/5] net: lan743x: Create separate Link Speed Duplex state function
Date: Wed, 4 Sep 2024 14:36:43 +0530
Message-ID: <20240904090645.8742-4-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
References: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
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
V4 -> V5:
  - No change
V3 -> V4:
  - No change
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


