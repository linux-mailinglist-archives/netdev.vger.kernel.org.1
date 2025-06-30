Return-Path: <netdev+bounces-202389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D0AEDB12
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF053B06B0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9826136D;
	Mon, 30 Jun 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AGcY+73N"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D14231858;
	Mon, 30 Jun 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283065; cv=fail; b=bnBwZ7yh2KNGs183OD+xTh+ty7twbAW02cGjX5I7qmbM/wtFO6mGMbiroAOcPFoOMcakSwQjsNYET5VyVVR6PJJqe/NAfDMq0Udi7E0cOSCULpnsomFUXepoS8l027PpyRM0oBSKJzLY2g+g8o+UY5gWgt72FPXsxihOkFzKBKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283065; c=relaxed/simple;
	bh=jJiGRh+26zxHcWQraRs/8u4c0OjGZe2Mq6Aa+7tSS4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3L73WO8ayltB2TE8Fg/KF66Ii999MdFfyZ/fEeEfnM6qGyTM8zZ1gSxAfc0ZsnMPz91k9MF3ll2/QQCqFc4vS8SXZtpY9wUwwGPZtn70I481amJAIC1oI3SYXvudEPcgDD/A46GaDTsnTvVIvhu/EwRpfqHyTJVHFAfOOmGR4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AGcY+73N; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbebMApjss5OHX9o8Git61qDpRg/KQe7+dbtsYXMjLXTSAGpsJ5Nu/Adr4oAmbhFAul7VXG42juKHfqNKTRrtkn6K3FAfn9EY2ux9bX/XqVzrIBlytn5nUNtaExI39FLpU2DpsxU6ikn+x55Tpr52pcstVHaCDEYUFWBurGUtdRQNje+pAhtFhQQcx+Vj/0iVvh/TMQgWSdz2wfPCT0X7KF1QL64+5Hdg/6603bOeznLt/lg0jsr1eXEctIH6NfZVM47DwGQwuFAp3UTT558nPSiEzlq8ISQjLzPJmI8Y5d8NFlid2Z4DfquW2TMNjAojNmjvcxsqc1G2d0Ku82q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLRG+OtsTTrqpirz3e6RnjUqSi5znl0JpNF0lWmiFvk=;
 b=io0YB0MqQs0Cb5TYETv4hyC5rFp3x64663D1byeGSX8lF8cXXD6tvr+4oswfxx0ZZhVSmBDv1xJCAWV1PPO+OHB/XSOlpGipYLfTIAlN+Jfr7hurZLzQVhNQt6Krf29mJoqtUcHla7FcI9rC8KTyKT0rRzpeFC80Kq6Wvc1B9HVcMmPv78eKseS7tkH9mw/RvLrmpBDSa1TLdyHOJa5F8qziTkCQVGR0wB3rkxO0i4smLoe1YBjYC3OJWJ9Bg3xSEfFK8yYgSiB3d3gsLr1hcl7c9SDFN74LmJczLmNwuDtZg9p+A2ZCz7r79GCy+3wH9FWhDQLH2qxUxwkJIFoT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLRG+OtsTTrqpirz3e6RnjUqSi5znl0JpNF0lWmiFvk=;
 b=AGcY+73N3vJclNEnI5yChpNBXQr2Nxr2wY2tfqmBm6XeMlNqzv9a3xyPgwzXK1fQoq/wSUM1wnD47Qg8THzDHZMfOaOExYTLhKxnDPUdRPDXV3MxAdsxgqMp0onMMnAN/XPiQXJltL4xKdssnbZclaq9Jof8WB6ENwPgk2R8hMo=
Received: from CWLP265CA0438.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::18)
 by DBAPR02MB6038.eurprd02.prod.outlook.com (2603:10a6:10:18c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 11:30:58 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:400:1d7:cafe::2e) by CWLP265CA0438.outlook.office365.com
 (2603:10a6:400:1d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 11:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 11:30:58 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 13:30:56 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v3 4/4] net: phy: bcm54811: Fix the PHY initialization
Date: Mon, 30 Jun 2025 13:30:33 +0200
Message-ID: <20250630113033.978455-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630113033.978455-1-kamilh@axis.com>
References: <20250630113033.978455-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|DBAPR02MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce4e74b-0174-4f54-0964-08ddb7c995c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnpjaDdFa2p4dUZJdkNhNTVOK3EwK2NOMVJXYVlqY2g1bjFlRDJCN0xDY0JN?=
 =?utf-8?B?UFZwejZ3Q3lNZzhkZkM2TEFvZ2czMEpqU0pkelhJcVYrT3RLdDhNQWxseUFs?=
 =?utf-8?B?VS9HMzRZNEIreUdtdmljQW1FVmczMFNBL05QUzBHbFJyaWZVeXl4UnRMYWor?=
 =?utf-8?B?U00vUzN2ZEpOZElyQXpSZ0FHUlp1QzAydUxuRFN0eEtTL2I3MzEvVG03Y3BS?=
 =?utf-8?B?c0RvaVRzK1hKTDRlWUV3U2ZRNDZiNnNuMjRkZFRscFBVdmVTZ2JDSW5mUG1P?=
 =?utf-8?B?KzlKQVR4Y0doYlFNc3I5V0VXV1F3bnp2S3c1OHlTL21NZmtqU0JIVFlhckpJ?=
 =?utf-8?B?dEd5bHVYRXdKUysvc1ErZk15SGE3TlE4MUUySWdWS2dEYjBQQkIwbHpKcHcy?=
 =?utf-8?B?R0FIaXVMZzNsNGdXV2ROT20wMFp3U3ZOc2RYRm0wcE5hQkdFSSswaUROWDJm?=
 =?utf-8?B?dEpvS0R1TzhickRsb0JpbEtIU1pNa0hqU2pycjJIWTZTUTlFRG1Bc3YrcStY?=
 =?utf-8?B?RTdPaFF3Y05oMFc1TzFidU5tNHdxUnZuNlNyS0VvNUdDaTNjL1hkcFBkakhY?=
 =?utf-8?B?OU1iMkFTODVQVnp0Q2tYM0pac1lnUmJwMC9sRXQ2WS9pMnBBa2x1aGMreXpN?=
 =?utf-8?B?a3hxa1hMRHVHTE8rR2lJWHlRazMzNEs0T1BrK2xYUkJ5WXFjeVM4SENndE9X?=
 =?utf-8?B?cDcwM25tVlVBV2IxeDB3RGtxZXF5eTJFcDNndFo0aWVNYVRnUW1SYUs3VkVp?=
 =?utf-8?B?QXQwMTRjbE8xMEpVckF5L0Q2S3NXN05aZUVhcjRPTlJvRjR2TmJ0SjVNbmdv?=
 =?utf-8?B?Ti9EL3h0VGduYmlDcGRHQlFnL1Z6dFp4YVJQSlNaU1lPVjJHUExSTW1vanAz?=
 =?utf-8?B?NDhBVEtJZUFNclYzVjlTak1haGFDM0kzSERyc09LNE40cTNNcDUzWWRaZFRi?=
 =?utf-8?B?cjlUNTlUdk9TaGZaZDNHd2tOdG5Ub0xEL2pXS21jMUYvWDh0aEh0VGNxczU5?=
 =?utf-8?B?akJWS3VKOFZ2dk9MNEZ2KzJtVlFEN1pRZElCb1BXK3BnMXRwOXVPVW9LYmNx?=
 =?utf-8?B?aE5oM1N3c0ZGVytTRGVmMEI4TGNwRmc5dnNndDhQSGNCVlE3cCswZ0R0clh6?=
 =?utf-8?B?Z29IamN0UTd1bjhMNjV0TnRTVTZZU21DVTFXR2NkeEtZMkcxWEpnd1NvMFYv?=
 =?utf-8?B?d0cwaTBtMmNyb0FZeDQxVmhvdEd0L1EvQWtWZzZSYWEwclJmK2puQUVWWHF4?=
 =?utf-8?B?dGlVWGw0KzFSTGlNOE8vYTNMZHRnaEFxYlNEZXcrbk1FSU9qUG0vSnVpMjNl?=
 =?utf-8?B?TGJ0U0xUTUVzbXFveVBRaGUrUEdKV0JiUVljUXJKMFJSMk45TTdtWlV5Tnpq?=
 =?utf-8?B?Q29CMXczTFhTMGJqcEp3R2RKZVR6UWNWRVVUTk4xcjZDdWV5bGliaElQcWlD?=
 =?utf-8?B?QklRcC9zTHhaRjQ3QTFGdDdYaVN0Q0hFTXdvYUVrM2ZIYzlKRGpoRWI1eGhq?=
 =?utf-8?B?bEpWRUFLU1hDbWZaMWFhY3dmWk5xUHBtYWZ6alE1L2pZZklCc09ISm11bTBq?=
 =?utf-8?B?VTV4Q0N5R1VQajJONEdXSzlUTXg5RlN2WmhBR25YSCtrOW0yWGlXMXNqR0pm?=
 =?utf-8?B?UytLWWQvcFl5d3lHZUFqTk1iUGs5QXpZNmp3V01KRWV5b09qMHQ3ZXdEREZw?=
 =?utf-8?B?V3NDU0ZNQXhnbVJvTFJaQ3NJb1RqeVhvZFJ2SEhqdFdKTTMyUU9uYWdFQjhB?=
 =?utf-8?B?ZEM4dDVOazNmck9DUTE2U2lZdkdmR3NVdkw0OTBHdVgwUDBtbXpEV3MzRWdz?=
 =?utf-8?B?bHZFZ1liSm54OTlDZ2o5M3RkTFNGV3J1RzZrcUpRbnBkRm45bWJUSmNoN2F5?=
 =?utf-8?B?VDY0dXNTWnF2ZGFGdkJuYU5BakY2Mm90aE5vSFhSVVJQZ2MwUWorT0NxdWFt?=
 =?utf-8?B?anN6Znh3aGQwbTdoaW42bzdJclpYTjZvMUVxMlNCOENQZDRCL1ErYzduYjZl?=
 =?utf-8?B?S3pSMmlXSjNGMkc5TlBGVlQ4UkF5WkhvMXhzU2hEaGhpV2c4N3NnVldsOVpJ?=
 =?utf-8?B?ZXErQmpZUkRSUVIvOEExNlRaaXYwTlBBNkluQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:30:58.4809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce4e74b-0174-4f54-0964-08ddb7c995c1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6038

Reset the bit 12 in PHY's LRE Control register upon initialization.
According to the datasheet, this bit must be written to zero after
every device reset.

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


