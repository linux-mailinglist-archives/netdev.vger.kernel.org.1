Return-Path: <netdev+bounces-114183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBBA9413ED
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14281F24549
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8C1A0B0F;
	Tue, 30 Jul 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FMc+yYQV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E31A00C9;
	Tue, 30 Jul 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348608; cv=none; b=BIkQzR1C/FuKr0kq+GvtujA+vK2lOgklmiwYQLL+fTnh4UGzA8HS4Srk60RPPJ1Zc4XUqGYXS2wH0RSstp1OfopOoqdVsjYIaUS09g3StQt4MT8UwubGepzzznuV+ZmQg1l80u3I9nvwDnorr3PiWbm8VRfNReUAeEDBykJPXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348608; c=relaxed/simple;
	bh=KzfqhmS8FIygSg5eeXP75nm95AbYuX6rNKCsxtWaRww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezvwhSkHzJIY8Wykeu3t01Db+YYrh2kD+rD58JOggSyM4QFwBFPFQKE/BdNqSDSH+cp1EHHdLuDzyeOuS83hsccf174CYlTxLMWZqCjwPndIpLKvHSPjPD+y2SSxttiWw/E7bIBXz3ETEwfGL14KUv/FX8zi2tteO5SY8J3k8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FMc+yYQV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722348607; x=1753884607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KzfqhmS8FIygSg5eeXP75nm95AbYuX6rNKCsxtWaRww=;
  b=FMc+yYQVwPjnX4oFdRe2QThLQ9AZ9hpAr0CjDNVTPE0eICv8WWJs/sG4
   nlFlT3IEXY2EkYHundnnlRofpzFTe7G/63skxIpsUpHkveXzPGpCbvLXY
   ynCBV87zy1g3esuYnBnuN0byEiKhDXDsf/BFGVOBYgaMVnmeTmesVE1WS
   rD7nw2+sp1+KjEtPi1A7zXu83t2WuFJ0GU6CVJp6uRnUro83xaDkfhJKS
   nZksNOiz66gbXBr1vsAt1A0LaB6rdyu5GB+B1G3Pa+nsfF8Z+WyT4Bpc/
   bSCxIYfvvnRi7Hxu6QoTyPaKc0v4DBjUUtSHWrLEbscpWu9FgdtvUvcP5
   w==;
X-CSE-ConnectionGUID: pJjtUho7TD2Gsi4T6qZB0A==
X-CSE-MsgGUID: xgHq1b6NQquAia1SOVSnBA==
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="260769373"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2024 07:09:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jul 2024 07:09:45 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jul 2024 07:09:40 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <horms@kernel.org>, <hkallweit1@gmail.com>,
	<richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V3 1/4] net: lan743x: Create separate PCS power reset function
Date: Tue, 30 Jul 2024 19:36:16 +0530
Message-ID: <20240730140619.80650-2-Raju.Lakkaraju@microchip.com>
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

Create separate PCS power reset function from lan743x_sgmii_config () to use
as subroutine.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V2 -> V3:
  - No change
V1 -> V2:
  - No change

 drivers/net/ethernet/microchip/lan743x_main.c | 55 ++++++++++---------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e418539565b1..ce1e104adc20 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1147,12 +1147,39 @@ static int lan743x_pcs_seq_state(struct lan743x_adapter *adapter, u8 state)
 	return 0;
 }
 
+static int lan743x_pcs_power_reset(struct lan743x_adapter *adapter)
+{
+	int mii_ctl;
+	int ret;
+
+	/* SGMII/1000/2500BASE-X PCS power down */
+	mii_ctl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMCR);
+	if (mii_ctl < 0)
+		return mii_ctl;
+
+	mii_ctl |= BMCR_PDOWN;
+	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
+	if (ret < 0)
+		return ret;
+
+	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_DOWN);
+	if (ret < 0)
+		return ret;
+
+	/* SGMII/1000/2500BASE-X PCS power up */
+	mii_ctl &= ~BMCR_PDOWN;
+	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
+	if (ret < 0)
+		return ret;
+
+	return lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
+}
+
 static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct phy_device *phydev = netdev->phydev;
 	enum lan743x_sgmii_lsd lsd = POWER_DOWN;
-	int mii_ctl;
 	bool status;
 	int ret;
 
@@ -1209,31 +1236,7 @@ static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 		netif_dbg(adapter, drv, adapter->netdev,
 			  "SGMII 1G mode enable\n");
 
-	/* SGMII/1000/2500BASE-X PCS power down */
-	mii_ctl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMCR);
-	if (mii_ctl < 0)
-		return mii_ctl;
-
-	mii_ctl |= BMCR_PDOWN;
-	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
-	if (ret < 0)
-		return ret;
-
-	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_DOWN);
-	if (ret < 0)
-		return ret;
-
-	/* SGMII/1000/2500BASE-X PCS power up */
-	mii_ctl &= ~BMCR_PDOWN;
-	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
-	if (ret < 0)
-		return ret;
-
-	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return lan743x_pcs_power_reset(adapter);
 }
 
 static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
-- 
2.34.1


