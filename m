Return-Path: <netdev+bounces-111055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F423292F97F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDAB1F22EF6
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C215B54A;
	Fri, 12 Jul 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="asLguyKX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5A7EF09;
	Fri, 12 Jul 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720783243; cv=none; b=WPw7mqW9PHOt2WBi0Tk9XyQjzTd0EtocLJmsuXiPGVtQzAeMjTxpz1uMgasYY6ldon61guZtv2fJUWtHLI5yB84/QTNsDROD/wZpx6ZOrCgpg6cqxMwdhq01cZm332K0jNFFWfSroIwsYM5AbIV+k9tSCIj5TA7ELUsfkNc85fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720783243; c=relaxed/simple;
	bh=2vS20Ep8ZAaCHpMOeANEzKfY3e41sVjlOIwRfXNfiNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjVf40t27jT+HEEm6x43dA72PAJ8qeX+BhR72hDhZ1LbLIqg7dthRxdDcx6xHZ+pabHwugcCASXhPHXOXXgk31FDgC70u6Kas4T6V/DiL+BnzW5G/9HbGvUBwipqEql/UMVXAuztD7mRgIKXmVvx0HdaymhOh2wEVKvjhRfNh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=asLguyKX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720783242; x=1752319242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2vS20Ep8ZAaCHpMOeANEzKfY3e41sVjlOIwRfXNfiNE=;
  b=asLguyKXNFJkEP4lv32FvYshDwRCYaKs00OVXm1TIg3cMR+I1LqUesjI
   IcxI+MjhG7Exq3qaz1VubbM7h0z3zWYfgKnmCtt2MQFiYoU8bQjtsBEiV
   NJ1q+Z4Vpy5NDKQpMSOXkVw+BGWm1tvWo2ySSCi09Ru41MSt76rUSTiNO
   IqV3ED2d9eaKfO8oY5hSMivSJnRQcHKmb6pQQFi1GT/ibRdZJCujGwl7K
   ub4J+ewY0qZIMMTPt9rdp68FzfJyBO3w6pwDlsbZ33IAf5tmRCBvi6sev
   /bZBPrZVSwvu7Lq1jfauRQQktiCBi9QFsbdD6ixKQol92JBvzUq+BA578
   g==;
X-CSE-ConnectionGUID: 7sR71l0RTy+K4/gLrcpizw==
X-CSE-MsgGUID: T2yuLgl/SzuY7Cf/EGmb1w==
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="29165133"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2024 04:20:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jul 2024 04:20:03 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jul 2024 04:20:00 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horatiu.vultur@microchip.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net] net: phy: micrel: Fix the KSZ9131 MDI-X status issue
Date: Fri, 12 Jul 2024 16:46:48 +0530
Message-ID: <20240712111648.282897-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Access information about Auto mdix completion and pair selection from the
KSZ9131's Auto/MDI/MDI-X status register

Fixes: b64e6a8794d9 ("net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/phy/micrel.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ebafedde0ab7..fddc1b91ba7f 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1438,6 +1438,9 @@ static int ksz9131_config_init(struct phy_device *phydev)
 #define MII_KSZ9131_AUTO_MDIX		0x1C
 #define MII_KSZ9131_AUTO_MDI_SET	BIT(7)
 #define MII_KSZ9131_AUTO_MDIX_SWAP_OFF	BIT(6)
+#define MII_KSZ9131_DIG_AXAN_STS	0x14
+#define MII_KSZ9131_DIG_AXAN_STS_LINK_DET	BIT(14)
+#define MII_KSZ9131_DIG_AXAN_STS_A_SELECT	BIT(12)
 
 static int ksz9131_mdix_update(struct phy_device *phydev)
 {
@@ -1452,14 +1455,24 @@ static int ksz9131_mdix_update(struct phy_device *phydev)
 			phydev->mdix_ctrl = ETH_TP_MDI;
 		else
 			phydev->mdix_ctrl = ETH_TP_MDI_X;
+
+		phydev->mdix = phydev->mdix_ctrl;
 	} else {
+		ret = phy_read(phydev, MII_KSZ9131_DIG_AXAN_STS);
+		if (ret < 0)
+			return ret;
+
 		phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
-	}
 
-	if (ret & MII_KSZ9131_AUTO_MDI_SET)
-		phydev->mdix = ETH_TP_MDI;
-	else
-		phydev->mdix = ETH_TP_MDI_X;
+		if (ret & MII_KSZ9131_DIG_AXAN_STS_LINK_DET) {
+			if (ret & MII_KSZ9131_DIG_AXAN_STS_A_SELECT)
+				phydev->mdix = ETH_TP_MDI;
+			else
+				phydev->mdix = ETH_TP_MDI_X;
+		} else {
+			phydev->mdix = ETH_TP_MDI_INVALID;
+		}
+	}
 
 	return 0;
 }
-- 
2.34.1


