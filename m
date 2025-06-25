Return-Path: <netdev+bounces-201258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003CCAE89FE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263A15A2610
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29092D8DDF;
	Wed, 25 Jun 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bYxa6/OH"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1722D542A;
	Wed, 25 Jun 2025 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869319; cv=fail; b=kx7Bki22+x07vGuh/pTHw3l0BdrW6tLmWLn01McBH2NUbvULikBOGxgJ7JJw5Wr7+iLyscBRuS0Q6blC3tpEydvyvYs16DaWGsHupHk+ejFIGl9E/urWktsi3OabjF7RxcfMShKAlr77Olz1MRnQeChFMil/VPF6KzwUuIhaxV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869319; c=relaxed/simple;
	bh=IHtvyqE95H8ROJBll+b5DokC/pyhUOkHQb5/V8Zstbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8aEb+StXCO81gD6zvcBRDdALqLofVSrPiBnPdq5kzUga9RgXgrce7KE4/x8Ji/4AEHTGKKnRK/0M8pqSZmdQ/eBnEWR/JbhX0NFy5CKo6qX2UbW7KqFG/TLVcbwfxpzBVbIlJlzMMvglJa/tfhthF/cdtmcOCXoTaAtOWjCoaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bYxa6/OH; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bck7WJU1XBXAp4m82wIH2pUPOIgjC5DrM1prL8xf1XDBCiQt46MXzEmvtGzycY3JqI2EtuAvExeI/GfNnG6koIvegrx2PQ3mwLjHXAFQf1qoiVYzKkL5NPVO+jPae0nDY4TuRV6oOZY+OHhR6smQDy+8+MVgnkQyjTDtTB2M8WeecEYZP4Kjdrzzbez/9tEbTel22HeVW7xg3pgDiGLJTxF+5agsONWZ8th/jrZJ7DdGG6iZXWm9YvAzmcea3qNHFs7lwtEwRO9qgAVPs+ovKlc5hSVjt8Qc0qj5TgwdciG4GCHOz8IwVzBkwCk9kOVu0ZhtPurAjPhucV+fviOG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klbt0P3AtEn8kc4ft+BcHu8U1DUMBOD8AganLYCB3Do=;
 b=eWt4NQ7EexwfL5lSkFtIP2INPTPNfXLtZ1pXLwB9CozGsZfT3OMrhNhEaXoOS1CIpWqpRjYT9cpwlS49rIdyy2On9F6nHLwI+jNqbbbN+oC1x/4nCAOgCcUeDR4pLePnDsK8ZJ4ycYWHVbpfin3PYR8VuKE5ej/qHA1n+bd+vMJHc4tFkfV5lJuvXMyBINj4XNxfLXSLj3NQ/eloUii0aISTbzkfcH2aKhEtX+LBC1GRpR4JJFS0kwAXwEW4E0zZKQGgezEkzXkrcxbWYsHA7oU1uc8XjCNKbwF32AAtdlHAXrXD6XgcWenqIm276Uca59DLle2R83ko2fePJiWxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klbt0P3AtEn8kc4ft+BcHu8U1DUMBOD8AganLYCB3Do=;
 b=bYxa6/OHU5dTJUzJmjCmF/4q2bOe5XOVHE1E9g/EqHlp5gTq6ZmqIz5+GTanFhtwVBPDW8EX8kGBiB13awCiBh+1slzAZ+qziJg+eK3abDSq73zc++2FTFLHhMOhy/E9QtV/86li6427GK6dlTUwA78k/+6XngiCYV8p73kGII0=
Received: from DU2PR04CA0264.eurprd04.prod.outlook.com (2603:10a6:10:28e::29)
 by PAXPR02MB8248.eurprd02.prod.outlook.com (2603:10a6:102:247::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 16:35:12 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::a7) by DU2PR04CA0264.outlook.office365.com
 (2603:10a6:10:28e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 16:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 16:35:12 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 25 Jun
 2025 18:35:10 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>
Subject: [PATCH net-next v3 3/3] net: phy: bcm54811: Fix the PHY initialization
Date: Wed, 25 Jun 2025 18:34:53 +0200
Message-ID: <20250625163453.2567869-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625163453.2567869-1-kamilh@axis.com>
References: <20250625163453.2567869-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|PAXPR02MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 843aaae4-dcd8-4235-6aa7-08ddb40641f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlNjYXlaV0h1M2pISXZBZEFRaUxzdFZCUjdRYSs2aHJ1S1lickUxdndUWHQ1?=
 =?utf-8?B?Z0E3Q2srRG5sbkVoRy81T2wxOEdzNmVvNnEwMnU2YThnQmVBUlB2RURNdkNw?=
 =?utf-8?B?eFIxaHVMaGNrTTl1TlpFME5QNDFZbm94d0lVYkFYSTdjUm9CYmR0T09TeEhu?=
 =?utf-8?B?OElUb0pOVGhFTit2d09NSUlKaWZ5Q3h2cHBmWWwyTVpCREdRTDkyMnFWMGVU?=
 =?utf-8?B?bnQ4cjBmNkpDSDJoc21DcEJBeXo5Vko3RzM3eVVNNVpCNWFiaU1lbkxhVDly?=
 =?utf-8?B?bFYvVnlVS1hJTzNZTVFOYkJWY0IvT0xRblNxNEM0WkJlcHJpZDd6ZzdQZ0h0?=
 =?utf-8?B?UkMrN1N1cnZQVUFNSGt6RWJodytwK3dhcGlmN1NHVGE1NVRORlVvd2tVaHlY?=
 =?utf-8?B?SCt3ZlFWT2F0SXFvNjNYUjFTU0FBQW5KSkJCbUpUc3dtVEtPRzVDT0dFTE1l?=
 =?utf-8?B?VFFESmVuL1JlQWQ0TEFkZVFhcUcveUhVVlZRcDNiZ0RwQXd1SjlJRk9jZzlK?=
 =?utf-8?B?NkZUQ0NBN05aeERReitHT1Bady9EaE05b29CSGhPbW5rdlNESFRWakdMY1g1?=
 =?utf-8?B?Z25vM0JSUUdrejR5T1hqODZoQzB3SmxDa1VoT1lsWkJWMzA2M29TNmUwb3ov?=
 =?utf-8?B?Vm40clFpWEx6R093R3Z3TFpzUFpsSGtGdzZxNWpQNWZTaTdsUFBPbDhIZ0M2?=
 =?utf-8?B?M2FOOWVuZ2ZPMFgyR1VkVWF4dzZXZkVaOXFEdnZXOGVHeWZhUk1TeUNEREVp?=
 =?utf-8?B?WFdicUUwRXR5VnZabVFLYmZKQjBRK3duSy9SdlZTZzdFRTk3UFRVK1Z5dmsx?=
 =?utf-8?B?TzBSOFRwSjhNUTNlSHFyWmluR3NNNGovSkR2OC9RbmpGNHJLVzRBU09pWnNy?=
 =?utf-8?B?bmlzYTFQV2RPb1BRWGdVaEsreFBqOEFhVFBBMGEzcVljOGlxSVZpZVRKdk96?=
 =?utf-8?B?YnMvMUdUQ0h2cWtTdjBpYmdZY2NjYW9NU1hvenk5eEl3Q0krdXAyQWlLYmtH?=
 =?utf-8?B?NzhJKzdJeCtCRXp3R2ZRcmlxNU42L1FJb2J4YWtuZ29WMXowckdqL1FlaW5Z?=
 =?utf-8?B?ZVRTT0N0Wk5OV0xZc1Z2Y1hGUzNub2pjeXk3TlZXeTNEbWpPVmdydDFQaHdR?=
 =?utf-8?B?TnNaQmF4VDhhVFd5WVdrQXl2bnFvKzlKVHdoRVJDUnFwZkhLQkhZTkJCVnZx?=
 =?utf-8?B?UFcwb05zV0FDNnZDdWg0MlYvZ3ZQT2lYZE1uQXprRnJoUFlTaDFoZ0t3cHFR?=
 =?utf-8?B?bWZHV0IrZ2tiNk1LMkNNV3pTRXNjSjhlN01LUDYzSXRsV0o5NFoxZkc0WE93?=
 =?utf-8?B?L0VpSDFsSlhackhZbTJxSzY2WEFXcGdBTG02ZDV6OElsdk9KNmJmaHVDYkZQ?=
 =?utf-8?B?SkV3QXgrRHZlYiszKzZ1MFM2WWtTVmY4OEJTVWRrWE15SFFGaXBOa3NTaXlG?=
 =?utf-8?B?c2F5bUlZeVpUbUwwUVpiSmo5OTV4YzVBc0Vac1hDc2pkK3pmSytjRUkyN1Nx?=
 =?utf-8?B?VFRkOXQvb0IrUGJOL1czeXpwMGgwNEVOSDVYWXdYUk9IOHhEa1JnNDZHQWhX?=
 =?utf-8?B?TW0xSUkrOGdHSStPZEJJRmg4NStObjhCamlJSmxQQnZna2d1NlZjUHRTWURT?=
 =?utf-8?B?aFZ3Wm1NQ2wxODRNTElBc2RLRzhweE94QUpZOGE4anlxWHhJYWY3UkUvOXpw?=
 =?utf-8?B?WEcwNFI2d0xINlZOakErTjlZMUJWOWQvM092dVJTL08vNFZiYkpKOE5jaWZq?=
 =?utf-8?B?MmMzakVTejdWc3BpN0IyUXFqN2c1NnJ2U1oybTNTd2tYL0svS1k0cUZVbUdu?=
 =?utf-8?B?V2pFRzMzTTkxWEZSMWRaMExCQXhDUis4OUxBTjZSaWFkMnV0Qzhqc2xtcXNw?=
 =?utf-8?B?K0YzYXVFSUxaU0dnUFJmOVA0UUhiR3psWk83NEtWNldOTVRSZXBLekJpVTZo?=
 =?utf-8?B?cm9POE1EbTRSOTNMUnJEODlIdkRhTVN4bWVmT21IcHBYdkpIU3c5eW9abFh0?=
 =?utf-8?B?cWlORVEveHdTZUc1N2EyRGUwa3IvMEVBSTdvNDVTeHlJVFdZRnRaRWdGT09M?=
 =?utf-8?B?OEUrYXlyMkt3R1hLaGxac013ZUl2VUpqSklsQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:35:12.5472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 843aaae4-dcd8-4235-6aa7-08ddb40641f7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB8248

From: Kamil Horák (2N) <kamilh@axis.com>

Reset the bit 12 in PHY's LRE Control register upon initialization.
According to the datasheet, this bit must be written to zero after
every device reset.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c | 23 +++++++++++++++++++----
 include/linux/brcmphy.h    |  1 +
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 7d3b85a07b8c..9d38aa7f3b45 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -662,7 +662,7 @@ static int bcm5481x_read_abilities(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
 	struct bcm54xx_phy_priv *priv = phydev->priv;
-	int i, val, err;
+	int i, val, err, aneg;
 
 	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
 		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
@@ -683,9 +683,17 @@ static int bcm5481x_read_abilities(struct phy_device *phydev)
 		if (val < 0)
 			return val;
 
+		/* BCM54811 is not capable of LDS but the corresponding bit
+		 * in LRESR is set to 1 and marked "Ignore" in the datasheet.
+		 * So we must read the bcm54811 as unable to auto-negotiate
+		 * in BroadR-Reach mode.
+		 */
+		aneg = (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM54811) ?
+			(val & LRESR_LDSABILITY) : 0;
+
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 				 phydev->supported,
-				 val & LRESR_LDSABILITY);
+				 aneg);
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
 				 phydev->supported,
 				 val & LRESR_100_1PAIR);
@@ -742,8 +750,15 @@ static int bcm54811_config_aneg(struct phy_device *phydev)
 
 	/* Aneg firstly. */
 	if (priv->brr_mode) {
-		/* BCM54811 is only capable of autonegotiation in IEEE mode */
-		phydev->autoneg = 0;
+		/* BCM54811 is only capable of autonegotiation in IEEE mode.
+		 * In BroadR-Reach mode, disable the Long Distance Signaling,
+		 * the BRR mode autoneg as supported in other Broadcom PHYs.
+		 * This bit is marked as "Reserved" and "Default 1, must be
+		 *  written to 0 after every device reset" in the datasheet.
+		 */
+		ret = phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_LDSEN, 0);
+		if (ret < 0)
+			return ret;
 		ret = bcm_config_lre_aneg(phydev, false);
 	} else {
 		ret = genphy_config_aneg(phydev);
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 15c35655f482..115a964f3006 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -137,6 +137,7 @@
 
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC			0x07
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_WIRESPEED_EN	0x0010
+#define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD		0x0060
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN	0x0080
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN	0x0100
 #define MII_BCM54XX_AUXCTL_MISC_FORCE_AMDIX		0x0200
-- 
2.39.5


