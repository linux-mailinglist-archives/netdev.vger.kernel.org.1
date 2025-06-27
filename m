Return-Path: <netdev+bounces-201901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35090AEB635
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B456561F90
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A22BEC3D;
	Fri, 27 Jun 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="nPpwQ7kY"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D129AAEF;
	Fri, 27 Jun 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023414; cv=fail; b=Rch0p4lQIN30Gg0VdLwQtYChL09jJ7Nt+Jf7evLsfbApuMGQm+gOtGhzgs5aPdv51NoZRXfpEK9ElOW9yZygdi0eQNrGuZGzbNpxT+tWoqqdHWi1xsMvUXkTo/VaiLxeu+dRhLakKnXhKK2sABXeftvuAZmcBmZMGeaXCfTri0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023414; c=relaxed/simple;
	bh=6rZuFm3pcAXpxzRuMFb6aIkBzPT0opm2zSCq8W9ea7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp83sPRZwFRfgVzcJJJdL4W6G3n9PwP1hY0jOXlY0zJa7NFme0EoNcQBrmXquyrT3XGXHMsZ7eadmhGi7lKq7N5jQhGqzRHpd0c9fkLsDYW+kL8OkH8o5CUWfHbkWFeLodain8jez/PxoL02XGwat2vQ5036QUPGtuHLW1E0j7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=nPpwQ7kY; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3FFjFSSmNUXFhigQIjZlcKorhOJO7ia1tFPukMsKHrY6QIaZ9DSe+66f8UIRuCx56CPH0LW0J6W1bz4v6PehzbvE1iAXSOZBIcb7HcnjY/JR3Jk7Nj8OqYV6kUkH5zkaihuAZWFOkUjG8GWHkVZpzg9g0ML/mQL7QN5naydODUDh5Na6MjIqdYAUJ3gS2aaF75v1B26pnLkVpI0UKYEbOUJGdP7LDFnAqd6+pHg3Cxx2PXBLvIof2CsznkSpjfLTZNPfhFieCXGshl2EMT6MnbWHNx2HJG8Y0rypbyAz0fH7wEho/jULk0MeH+pqW8yNqaW8yhRSZ8/RhohWhYmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FJf+sJQDufzwCS66IhAtj8B/g/B7+z9j42tJVFPsPU=;
 b=wSJKWRKm8/3y3G+YicPgzGI4TLZy9uQbdLiHiRYkhOmHQcHTff5j2YzZWoqamL5GSyGwK2Z7ZAtoHVJxAENyDVTThoYbb8FHx4Z1y/KsweeyNbATKYp76GeGNyIIO97YuyJo7yQ8c5DAxBsI/zgMe22mZ7oDHSfoMqVVG8kslH+u9ziV3BLcGxgy/IoPb+Fj4Ev5ZwYW5d51DZYGw0J24Pp9EKEKmgPY0Rkg20v+lKNqT+Ic5h1ABtpvPV3/2skgnkAa4TMB42eq5+YyujR3nResq1OFS2diNGk1LsOgUhKt9V5maRdZgtI9Y0fobFaC6Jeq809IT2wqmgxtMZd9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FJf+sJQDufzwCS66IhAtj8B/g/B7+z9j42tJVFPsPU=;
 b=nPpwQ7kYqVuZUWWOXbf0mY0pjDG471e0adCJ14yEU3Mx/e5VEGDjr5pp4t1sdY4J0kQ9yzzWqYvVI5sDavQCcANX8xyaY7QQoFqYwTRqOGOZn4gEJJ77QK4el1QdPmj8Gg5D0WBKw1vNwLLLn7M71dClJPB/w4aI1BivO/e8GPw=
Received: from AS4P192CA0030.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::18)
 by AS2PR02MB9692.eurprd02.prod.outlook.com (2603:10a6:20b:5e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 11:23:29 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::72) by AS4P192CA0030.outlook.office365.com
 (2603:10a6:20b:5e1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 11:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 11:23:29 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 27 Jun
 2025 13:23:27 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v2 4/4] net: phy: bcm54811: Fix the PHY initialization
Date: Fri, 27 Jun 2025 13:23:06 +0200
Message-ID: <20250627112306.1191223-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627112306.1191223-1-kamilh@axis.com>
References: <20250627112306.1191223-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70F:EE_|AS2PR02MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: b17bf927-af4c-4d58-5195-08ddb56d0b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjdnczNSc3MyaDUwTnJoRW1aQjZHRS9qYmwremx5cDdJNDZMT095dGZvTCtD?=
 =?utf-8?B?U0N5UlhBa2ZBdkRjZFY0TVZiSmpyMG1ha2dzOVQyZ25kaG1BT0Z3dXVvS3Vw?=
 =?utf-8?B?K3dqdlRaVnlOZnJVY1dva2NYakQ4enZoZ1I2S3RabmJ6eGU2c045LzBaNTcv?=
 =?utf-8?B?WXFyeTNkTitYNFFNK1JpQjJpZncrRVpOZzZjYkRSSCtxWnJOengwdk5jdnlU?=
 =?utf-8?B?YlRoRlViQkRlNlEvdjc0SDBSV05JOG1zZ2VSeWNlRU5nVnRFNENSMVV4Uysr?=
 =?utf-8?B?WlN5M04zcTNMNWdQYldJZUQrenlrSEpVS2wzUXpUSG5xZXJORWtYVlRySWRp?=
 =?utf-8?B?V0hneFlPQi9oZHE4ZXN5dnBFNFpYL1FlYU5vKzY2V1d1RnJvTVArUXpLUC9v?=
 =?utf-8?B?cjV3UktaUWdGaUNSKy9IU1hpQUg4NUttcDNJNTZHYkI3dnU0UVBVUUE3eGpZ?=
 =?utf-8?B?bHh1bUYzQmFKMmxabStuK3c0M1ZjcEhZK3VrdkFwSmR2WVovSEl0OTEzUDNB?=
 =?utf-8?B?MTNMQVJEbDlreDRnbEx0VGMxMzlPa2dpbGZFQWVTcEpBWE16dEJGQ0JOOXFs?=
 =?utf-8?B?QUVqOHJGL2dtVHhSVTJUcXhSVTFlRHo0RlowYlR2TGs3U2pobVl3dG5JVjRx?=
 =?utf-8?B?RlpMR1o5ZXkxcUZvSzlHcjBaT1p5SHExNlQweExRWHhYdnk0VlBsMm9DS2hD?=
 =?utf-8?B?YS9lcXlPVitYbVI0Z3NKOTBFNk53Q3pqVTg1LzNjYjN0aHZiWHEzQ0VZSytV?=
 =?utf-8?B?ejUxbmcrNjlBWXpETXlLT3BPL0hadUkyb3pCT1pJNTNmWUNuTW83TE9VdHJa?=
 =?utf-8?B?aGFJb2pyRUNrZWw0eGNtaSticVhVVkcwdTdVcUN5Zkk1OEMyTVh5bnRmd0sw?=
 =?utf-8?B?QzN6UzZHSnJtbmw4STltYTA3dEZNL0VFVm0xRTRHaExoU1hTU1NLd2FCcUtF?=
 =?utf-8?B?ZTFnL2J1NGJUaksrRVNya04zYkMvSk8xZC9XSHpycXcyVE5STWJsQzUwbHVv?=
 =?utf-8?B?LzZXanNRR3hJREI2ellxOHdsRFcyRFphK2JuRTYzbGw3cUpDTXBiRWxEdlRj?=
 =?utf-8?B?N28rZnkybU84Zy93MmFpVnN5N1NGVEFnRFhRRHVBVXVZYUJyNDhFZmdIZ2VJ?=
 =?utf-8?B?UU9WOEtRM1paYUdjQVA4TVduOG95bjc3VGtuNDNVODlhY1BXSWQrRmN5VTZ1?=
 =?utf-8?B?MXZHbGJocVhUQU9CWm5XMnBmZDFrUDd0WkRrTzJyTFgrNklDSnNYYTlkRnhM?=
 =?utf-8?B?aHdWeTdJMFNIa045bmZ5akpJTENxcW5SeFNsVVc5a3Erc3drcUdxRE5ub2Rp?=
 =?utf-8?B?bU9nODF3cFc4S2hxZ3hHL1VxOTNZUGZ1SG1uVDhLb29HWXRCUzM1eXlJYXBZ?=
 =?utf-8?B?Uk5LeFNaalJiRTJ0VVlHSzVEVitLZzExcWZpNHJmU0tXaEt6ZmVZOVBTdTky?=
 =?utf-8?B?RW5UaUtBRENta1cydEVUckRud3FYT1oyTGFqZ2txZjJlNDE2R2IxZzRWZzlv?=
 =?utf-8?B?eFVpdGtOb2JRKzFVVGVpUW1UbDhNL3NucTRHZVVBM2wrZnRiWER4ajB6emtF?=
 =?utf-8?B?S214aGNZTTFLQ2c2V3oxUXJjcFR2ZHRLaDE2NENzWFk0eE9PWFltc3dJeXJ4?=
 =?utf-8?B?U2lrOGdLUFZQQklKZWxRR1RCZURIN01oblhzTFRGd3pQU0s0ODZOanY0eGlY?=
 =?utf-8?B?bVdaU3ZZejRQcVRHZkU4NDI1TFRvOEdoVmRFOVNyWlczWEcxQWg3cVBqMlNV?=
 =?utf-8?B?S2xjcmVkMkE1UW92YVBqVlMzUVdMeFhteXJqKzhHVzVESXB5V1pNWkFmRUpt?=
 =?utf-8?B?b29yakI5aDZodEprOXVXN3c2dnd2a3RiZUhOWjhnS091ZlNvQ2F2Wk5KZWRj?=
 =?utf-8?B?WEhRdnB0ZmNyL0YrQ24zS1VPSnRVTGs0YWtJTFRNbUVGYUN2YWxVbDBmdVB2?=
 =?utf-8?B?ekZZQ0ZOYXdrNHViVlF1MDZRTmJYME9OUWdGQnU0V2JTTUg4SGpieGVSc254?=
 =?utf-8?B?UnN1MHBTaDV4ZU5oVEcrbll0NGRUNGV0NkR1Q09WdlBzeFAvcUJGdVU1c0F4?=
 =?utf-8?B?RVkzVVhCQVpOSXE1NGQ3UjR3T3RUS3NhTFRrdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 11:23:29.8728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17bf927-af4c-4d58-5195-08ddb56d0b1f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9692

Reset the bit 12 in PHY's LRE Control register upon initialization.
According to the datasheet, this bit must be written to zero after
every device reset.

Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c | 25 +++++++++++++++++++++----
 include/linux/brcmphy.h    |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 8547983bd72f..a60e58ef90c4 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -667,7 +667,7 @@ static int bcm5481x_read_abilities(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
 	struct bcm54xx_phy_priv *priv = phydev->priv;
-	int i, val, err;
+	int i, val, err, aneg;
 
 	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
 		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
@@ -688,9 +688,19 @@ static int bcm5481x_read_abilities(struct phy_device *phydev)
 		if (val < 0)
 			return val;
 
+		/* BCM54811 is not capable of LDS but the corresponding bit
+		 * in LRESR is set to 1 and marked "Ignore" in the datasheet.
+		 * So we must read the bcm54811 as unable to auto-negotiate
+		 * in BroadR-Reach mode.
+		 */
+		if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54811)
+			aneg = 0;
+		else
+			aneg = val & LRESR_LDSABILITY;
+
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 				 phydev->supported,
-				 val & LRESR_LDSABILITY);
+				 aneg);
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
 				 phydev->supported,
 				 val & LRESR_100_1PAIR);
@@ -747,8 +757,15 @@ static int bcm54811_config_aneg(struct phy_device *phydev)
 
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


