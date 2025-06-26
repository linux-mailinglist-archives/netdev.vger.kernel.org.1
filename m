Return-Path: <netdev+bounces-201537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D9DAE9CF7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D44B1C40337
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B92517AA;
	Thu, 26 Jun 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="q0y1YtLc"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012054.outbound.protection.outlook.com [52.101.71.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D431BC3F;
	Thu, 26 Jun 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939002; cv=fail; b=q3XBeNxQHucGM3AYOHeEsXApyluwpUQuh3ft4Syw3G2IqbDD9B3kkrBNeacYWocgTYEn1Z8ls0lFicrnEBV4EsuYJwefbkLbcL1Mo1Dm295PpdrBgvcEFQr4+ApIG2OqOV08vwWCX01b+9Y3SkitikLe87DHxrcWQiB1KcYIROQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939002; c=relaxed/simple;
	bh=j8/eFpjbHOGqJp6GCy9iqb+g/MIPkkyQdKqQk9u6uRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLya6nooY1Z/pvBirHgaRKklIvAcSobtDfHVnCKyCrmyYn258CYzzohTiOTK2/v0ul1i+l/+yaMsVFKJYYEFuHDw6YkgZSBUzm4cMCe9wUjFlYa7nT1A4JcR3w03VH8SpRGkk4uDDeQPFRH2Kvyw/RzGf2LDkLRRgbbOy3t3PqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=q0y1YtLc; arc=fail smtp.client-ip=52.101.71.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL+Hij9LYpOwl9vl6QFpVvO/P32k9tzFYqNLj5W0aJktkKg0L0HXQJAt1h6b22lFSJRS4QUUbAQb2c31gf2YTnPjXcTI81OIoHG8OEDYm9g/HaQDJ+KqqXokIndN9la5YKiZ51tn0RvOX1AIcMMfGbfNpIbNR0lk4a5DETrU31u/tr/HGVRX8N3B2eMFqPP7fJaPPfMy275qCD4cpnIcD7jmSaVWAfLy7+53WokH6aLpPLtZM1VekpeeftAhWxd9gOIfFmyECpw/jhp40Txk87R3ZFwUekXAzvItW9WNc8qg+GqJduGEQDlDM6mD7ZSe8q8aMBDM+KRAJVkg8fDJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvAizWi2dWDeKQp41LN06QAdCKLL9N6UcX/p9IPYSpw=;
 b=jNHvoi96jNWB2mswsqz7xRoImbERbuKtLWanQx4p/DbLusyfIzxhDINX4WtlBHTWTR8xSjDGEtAmlu6fdcGU+PeshY1bDKeIgX+fZzJmNDI986cxIqmpftWm1CrP5b2E1FQMStQDnhcmFLvxWgazGeDjf+RDEx39Zi/ZMaY8fEKUFWEbXAAc6kf1XsBL4xzAr2pWj/ZAbgVhI9+FZK6xulab5tI5I34phFWZXuBfkrbCn2s7JcqBgB3fhG1LWhxLpks+J1YzFMRAFl0NAx6oAl38RizgH+pVYeYyMc1JSsJr8PWP8ZNzYZKSYg0QThfbfKbNUdSACqMiXKQpofP5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvAizWi2dWDeKQp41LN06QAdCKLL9N6UcX/p9IPYSpw=;
 b=q0y1YtLc87LvpfIXtL9uqAY0y9PZQTX/f7ShLcQLlkBRccDTBajCi4fHIli5YzjJK+8a7qgnAbAzSKIHf4jS+Tp8HkgEvxHuBv2efa+XsYLKZ9F5xRBaHlYCob9oRyi6RXIkcOutBNIPQcq1Wvzx75rTtipRLcT6rcB/3XS1JQ4=
Received: from AS9PR07CA0028.eurprd07.prod.outlook.com (2603:10a6:20b:46c::30)
 by AS8PR02MB7109.eurprd02.prod.outlook.com (2603:10a6:20b:2b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 11:56:37 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:46c:cafe::14) by AS9PR07CA0028.outlook.office365.com
 (2603:10a6:20b:46c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Thu,
 26 Jun 2025 11:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:56:37 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 26 Jun
 2025 13:56:35 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH 3/3] net: phy: bcm54811: Fix the PHY initialization
Date: Thu, 26 Jun 2025 13:56:19 +0200
Message-ID: <20250626115619.3659443-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626115619.3659443-1-kamilh@axis.com>
References: <20250626115619.3659443-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|AS8PR02MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d88705-dcd3-42a3-a653-08ddb4a8813d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tnk5NFAwdnFpYUJOeGNWeVp0WGxMb1ZiUUZMYkVZY0VBeWpvRVNOV2p4QWRk?=
 =?utf-8?B?V3A5NEhibHZGQkd2WU9ZeHZhNWh3R2hVV2VEb0tVKzZnUlhZa0JrcGd4aVRk?=
 =?utf-8?B?cG92WTJLcWI1OFlWczdNVXNzdVlNM29ldnlqNkwzNGM1WHRFeFNvUThVZmFG?=
 =?utf-8?B?SGRrUUZ3ZGljNHlTM1hrRzRoNVRzU2ZUNVhLekNMaUNNTWFJVThZQmhSeWF2?=
 =?utf-8?B?eUIyRm9QNVpKNzM5OHYyaG9USEVpeitWb3h0VnVyZ011VVZNUk00NU8xSGYv?=
 =?utf-8?B?UzZERW1RbCs1cUN5bk9GS3grMGR0WC9XeENQVjNFeldqbTVmdndvdEE5ZUNL?=
 =?utf-8?B?aEdlWDdaUlBrVzZXZlpTNnIvRHh3d0JEOHJoamJVTEVOdHVrbDh0NitwSGZT?=
 =?utf-8?B?OGpqZXM5cDF3WkQ0Vi9ETDZqOC96SWhwa0RvTE9wTTRqRXV3VjVlQ1VqNVp0?=
 =?utf-8?B?NWtaMCs2MFlWVzlTZ1BhV1pvY1NDUkwvQjlaSEdJUG1BRmN5S0E2SGQ0VHlz?=
 =?utf-8?B?YWJ2QlkrTmxFM1dSV2lNU2JCT1UrU01lYVg3THU5OHRFYlRLTkVCaFo3SURI?=
 =?utf-8?B?Z2FoYk9LNGgzWEJXbFBaaDRLdmdzc1V5Z1ZjT2J1NVJSajNWdG9xdmFubW5C?=
 =?utf-8?B?cC80T1hlTkZERTBiZXBpeUpKYkp3NEljRjE3NzhDTXZQSXF1dmVvYitFM2Zh?=
 =?utf-8?B?WDBvNjdxQUxCbGlXTy9sR2J1RmxIWGxDZ2VTbGdLMm0weDdqM0c4SXBLdTM2?=
 =?utf-8?B?NVZYVjFUMnFvOFJXYkZFd1puanNIVC9Eb2didmNHOUlqWGV0V09RODdjUjVV?=
 =?utf-8?B?Y1dhUXpQZ21sNUtyWTlHZXRwTisvTnhqWno4Q0FZTUFLSTcvLzc5djIxWGkv?=
 =?utf-8?B?M3NhL3M1SExGQjhieTZ3N0hpdW5GMEg3c2hLazBQdWFORDlrbE9XREdhUUxN?=
 =?utf-8?B?THdESEhzUm40b1EyaHlwRzdzMGFlekJ1ZkZCQmVrbEswaUczb211c0d1WGhF?=
 =?utf-8?B?eDJFak5KcHFTOWUxMmlXbG9IcmYzWWkvc2RrV0V2UzdWMmphVHdKMm1FT1Ey?=
 =?utf-8?B?dmNVeFVGRERkL0o5TmVrbTlNSWg5bDQ2MDFtaFVtc1llYlp1dFEwcWFaRHho?=
 =?utf-8?B?QWs5SXZkckExbjRXZExlNmpCNTUrRDlZOUJCNWtYK01iYi9JYTJkOUsrcm1Q?=
 =?utf-8?B?M0NLYnk3bzVHeGsrUjM0MDZyRlJ1MFRkMU0xRHBDMC92N29pRUVUSmp6elJV?=
 =?utf-8?B?V1pHTmNBN3ZkaFhxMDgvcHpmMCs5SzFuVzF6eTcvWVRZVE8zTGpaTHlROGU4?=
 =?utf-8?B?YnBwdTZEK3dMa3MyaHlpZWREeDN6UDN1K3BVZ0tCRmJMVGRDbDNIZCtBZzA2?=
 =?utf-8?B?L05aQmpiRmR4dnVPVXZQVGEvWHU0bHhWU25wZ3JxallZVURjb1F0Vm0zLzZp?=
 =?utf-8?B?RVROWnNQT1dRMmZmQjQwMFRkelRuRS83ZjRBMDFwa2FUU3hxMnZkN1VvWGVJ?=
 =?utf-8?B?bXB2b1pxRzllL1J3b1A0K3pneHlhazBYbklwck44M0ZBeDZiNTBvVGdQeVdj?=
 =?utf-8?B?SWZSU3pYTG5Jam4wVmdUVGNlK3p4TFZ5aXlqMkNtQXcrYnE0anRjL004eWhj?=
 =?utf-8?B?UXM1eUVOOWRqT24vbmtiOXZ5RTQrTmNzdE1NMnQ4QWhVeFloWUZyNmZpNXVM?=
 =?utf-8?B?ZXRhVjJ1TUhpZDF6aWRwWXAvanNnSWd1WFoyZVc2QkFiek9xN2pXMHVWS25V?=
 =?utf-8?B?bXdRUXlCayt2dHBCYW10a2tpVWYraVV1ZVBDRUhzMTBaWWkrc2FBVzZvTE4y?=
 =?utf-8?B?RGNMMjMxWG53NDVDSDRLaWdaa0VaTFRmRzhlOEFGb0dUTm5SN2U3QjhRcTZH?=
 =?utf-8?B?NWxmVm5tT0pWVkVMazRPRUVRUytwWTgxWUErUTU4UjduTkZmb0lEM1pUbHl6?=
 =?utf-8?B?TUgvOHVIdDV4N0pWZ2pVVmxNcjB5LzVFTUtrOXlVblFHV0pqSC9lVnlSNERM?=
 =?utf-8?B?L25pR1lHQm4vTVAwWXVnR0lQMzFVV3hrUW9PYkRxb0t5OGVod1NtbWMwOTgr?=
 =?utf-8?B?cXRoVFFrekVuVTI0NkhUQVZQZURZNnhlNEIvQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:56:37.1878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d88705-dcd3-42a3-a653-08ddb4a8813d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7109

Reset the bit 12 in PHY's LRE Control register upon initialization.
According to the datasheet, this bit must be written to zero after
every device reset.

Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
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


