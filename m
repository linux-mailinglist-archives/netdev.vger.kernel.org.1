Return-Path: <netdev+bounces-123084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F6963A12
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F194B21E53
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD614E2C0;
	Thu, 29 Aug 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t+GdHGU7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191114885B;
	Thu, 29 Aug 2024 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910964; cv=none; b=LeqjQr8LSC+Vke7VMKEGla93oDZ4J2FVap7UlR1HL+sRzo861UvOworK7n1R2YmpNqyrU4ZlIQPU+gWBuxpFmcf/buyzx45FXva2gW/aWAsVmwHbKaH601q/LDJwMIDJZkE6MB56LW8iuysnnf16nT7FUNDQnq7Dby+ZLmSSxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910964; c=relaxed/simple;
	bh=9teBeLbG752fvmqwVne8I2h161HrNP0yCk9bUOtHgzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8gn8ZqFVUXF2xFqc29K5ay/1hD6T8vB8LkrJElvdGWXkSsAIEw0PCmYXQG3DTexajWLI3CHIY1KtoEf5A5Bpq+1NBJLpFW8eR54hmOJGVqpxQf3vm3CcJ6mZN3Jxaex4Vc+NKiSrnAivpJ6iRLYHzHKz538PEdS/sjpDHaEsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t+GdHGU7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724910962; x=1756446962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9teBeLbG752fvmqwVne8I2h161HrNP0yCk9bUOtHgzI=;
  b=t+GdHGU7U+sgrQDOPehaZrqIf28/UZG3k5OMe0m6ImiSszsqko9i2CZ+
   uNmF9QmCs/juGQlrHPP00yI6fXvswd+a6x/ol9M5x1rlziddxYXEgBWP4
   JCGRAlhPgc/GoH0g1/XpvilH8dQsRxlrKgqcqJoMUGCSs4tkDb0LiFIGk
   6p+5b4navXkAuntMplLTC2XBWHbhKWRe/DpaXmMeD+HA9Nb8/KeroqdfZ
   JNFqD66Q4iQjivXEZp8kdwMaH6DU2xXMB/9NeTx28ns5Afw5SgySPE2W8
   YkJClLry68r1xxdBdY5Mz7hHCc3XPyoDdHrDE6GCE9GCZ2er9XpDilAnJ
   Q==;
X-CSE-ConnectionGUID: 2MQclz5sT/+LITt4o2qSTg==
X-CSE-MsgGUID: wPXtoDLHTluDukSsFfV9Fg==
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="261978659"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2024 22:55:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Aug 2024 22:55:31 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 28 Aug 2024 22:55:25 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V4 2/5] net: lan743x: Create separate PCS power reset function
Date: Thu, 29 Aug 2024 11:21:29 +0530
Message-ID: <20240829055132.79638-3-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
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
V3 -> V4:
  - No change
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


