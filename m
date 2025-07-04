Return-Path: <netdev+bounces-204069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB6AF8C4A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223276E2D85
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752492EF665;
	Fri,  4 Jul 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="UVAqYLA0"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2F28B41D;
	Fri,  4 Jul 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618142; cv=fail; b=lcFECVnTNqsjaeg9eB1arCzCZnNicG8hyWqe8UgWuzu4u+xNMki6XbW19aw6AWpVJLLsW42+s4UE/+qpifRKWqfi7R3hivX7CHM/ryWTcFp3RBxcT9QPiQi1QYdhojU6ySv3QYcuOF5/W11HyOw+BVKRLiYqtIJnzjbuPPQMMMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618142; c=relaxed/simple;
	bh=ZIqrQX3B5auXXf7dh6XPzPgSAICs/5GwnGv787GA8xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYS2LPB/98LLN0kYKqoTmoLUnWkbetJJgrf5MdVZ8558AwgMVBzWAGENzHmXLACGOoNJOP87l7GwEGiOebW76frbThjDqKCS43hMkoSTmdcCY8f+b1qr/M0W75t88zgjyVXV3EcaPZP5/OhlbHlRYmuXMYdoxRK9VJG5JFONTng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=UVAqYLA0; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkNTDpAZTerIPjTvVR2SnItOqVD0yN2I2IqjjcHnFeW6sxBdrIsiwon99CrsJd4uBM4JAirmczYG5YWRXnK1MIbuFhTmAt+1GzW0Q8deBcICE6tw+lmpIYiNsAuqZumuLhaRb6axhl0ues+zxO3FF1a5dnPgZs9IL4lJPNhPbI6Q01/Udneb1Orcn4XHqplCAWmJ6UL9Xnx4v3bkLoU9kc5aFJRI08kQHd97ETswadBUW5swjYFZH4ynsLmXmgV0DSWPsiMEXx2BIua6h9qvEMmrLtWgMPditvY1PcI+FOx7cMO4tzSM22prcmPNLyOXNaIf4s3DUo5oRJHO1d0F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nncrQjzvQr2sLVmhKgPZphMPq7RADJzbXx84i4q1ds=;
 b=WPLrklXAX2d6+s4nW1MFZo+er2IBTh9oF6LhyjjZ9/d6LltJLq060zWnsshrV+RGjqIMUT2KMs2NLFx0e3exjAqoCOsraLCee4sYZszUYAIsjb8vnQa+RinLK/r/2wSmInd4im70KrXof5dRkFRFEYkRGNHXLzxnSsqMPSRkui2qH/6Jw7bThcplTFaLW+2Uox1758OKzvj2MK/Q6DeHSE362oFqSd6h7wc8S+E4dmSJTY4dY07EBAALcNm1zxNgV87cs7ULSsCDbHKwoMk9XnwVvOZnrMNZH1jwLrubpIq9DatRUflqfnarSmZ74cQDDw1xz1adDj0muarLaO80qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nncrQjzvQr2sLVmhKgPZphMPq7RADJzbXx84i4q1ds=;
 b=UVAqYLA0XoTFOsTuHP/KGHMwyG/qaFkx3Ep8fKMPX1rd1oq7mIjHrwi0Tmoz2rswlCyZ4T4raC9UuAjMqm+ocykRl7QFRYsC7HPcZqprV/rP3eYMVW7asshlRmUJdsVBq/NA4n6GjJC/UQC2JaXpMyIQTyAlSfBn/zokGSR2UE0=
Received: from DU2PR04CA0266.eurprd04.prod.outlook.com (2603:10a6:10:28e::31)
 by DB9PR02MB9706.eurprd02.prod.outlook.com (2603:10a6:10:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Fri, 4 Jul
 2025 08:35:35 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::4f) by DU2PR04CA0266.outlook.office365.com
 (2603:10a6:10:28e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 08:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 08:35:35 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 10:35:34 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH net v6 4/4] net: phy: bcm54811: Fix the PHY initialization
Date: Fri, 4 Jul 2025 10:35:12 +0200
Message-ID: <20250704083512.853748-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704083512.853748-1-kamilh@axis.com>
References: <20250704083512.853748-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|DB9PR02MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: e942d31c-7353-449c-b76e-08ddbad5bf34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|82310400026|36860700013|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnRpZnZUR3krREthdFg5TTlKSDM3TFFvME1udVRoWHVlQkdjLzFaMjdCQjlR?=
 =?utf-8?B?dWpnNHZISzBRd1l3d2JRaGNmbHRRNTdoQnl6V1lTMGpyRktkdHlSd0ZQV0VU?=
 =?utf-8?B?M3VtN0hvdG5YeUdYRmUwMXFRRFA1ZFdLNFBHL2hwbG1DTU5yNGtqWHd0bVM5?=
 =?utf-8?B?bkdmNisvVUR5MjBlZFl4NW85WS90UEpMZUV1RlFIZlh0cFY1M0QvcWVNRnFo?=
 =?utf-8?B?RnhHWkpFT2hIeS9LbzNIM21vZTUzaVdaeFVxeHVLdk02TzJocTQvU1dQZHFp?=
 =?utf-8?B?aVJKQXAzT2F0TFYzVzJGSjlFbzJnYjh1aXZLbVEyeVNZOHNrbFlRTklEK0pF?=
 =?utf-8?B?NkQwdFgxMnBzWTMxTktHck9uOEdVL2VlRHBEci8yZlhLY2RqWWhhS1NxM3Jl?=
 =?utf-8?B?bUgzc0ZzNUhKN3hTeXVYUk9ITEVhQnJaYW9VakRhbGxHNjRKS3A3UGw2ZHhk?=
 =?utf-8?B?ZHhhMmdZNDEwSE1nMW84bmxiTUV3YmtQWEdNT3ppRlFWLzNtUzFEK1Z3R2JY?=
 =?utf-8?B?WkRoNW9MNC9UcmdDYm9qVHVVTzN0bXBGbW5MZ1dET1NiVG45QzY4aEY1MzZP?=
 =?utf-8?B?cllUYUFVY1lXN0syZ1NjN2UrQndBTFhrU2NzczczNmRwUWV4cXRjL0RON1c4?=
 =?utf-8?B?QWYxSTFVU3J5bjlTUURvMVB2eDVORDZVL2FzZW0yV0czbmVXSlhJTnBscmpr?=
 =?utf-8?B?Y3R0VEtMbUNKUW5ZdW94SndyTzhsLzh4am5ISmU1bm5Zb1FjOCszMDZGZjZ3?=
 =?utf-8?B?S3MxNzNzT2QwVHBhbDFQVnNSaVZsNWVGRS95dE1qQzlBZjJrRnNlMVd2bE9r?=
 =?utf-8?B?NW5VU0p0RTg4Z3ZkRVdTZllsbkl3NmN0TzBGRlV1TVFQaWtsSXBReG54a1d1?=
 =?utf-8?B?L3ZqSzB4RUhERWhqMndBY3R1R09WRlFyeE5PSWZ3R2ZvbDFZQmJPM2VIRmd6?=
 =?utf-8?B?WHFsTnBiVC9FOE1sclQ1SitwSHZPWHFpSEdncDl1MnFSOFo2cjMvUWh6RHVU?=
 =?utf-8?B?cFdrb2NFWUpFU254SE9STDFPVS9OM20zODY1Y1ZXYUtuOWVWV3Nxd09ncEJG?=
 =?utf-8?B?amNwMTBFZVh5UWhkT2ViSU1KYWZMMGlwd1lEV3BDSVFBTDh3Rm1JTHNIRXhP?=
 =?utf-8?B?STdmVmgxSHBWNjN2bEJtY2U1MmFaQVJ1UCsvRnVqemt0bXB3R29WRnFxTnNw?=
 =?utf-8?B?YVNXUWxhWmJhUFMwM2xVcllJZE10ZFJqK0V3L05iTE5jaXU1UnEyVjZGMFVO?=
 =?utf-8?B?M1ZOOFhEdGd0dXcvdHNmeWJkc0tveml4cTN2Ykl4SUZwWFpSbHBYUHE2aFZM?=
 =?utf-8?B?SFd3Yi8xTzd3eVBtb0lEdlV4YkZna0pUSkovMytxd1VZWFFTbGc5aWtDWTY5?=
 =?utf-8?B?RStpR1ZMaFJQUnJVRWJTaWd4eWhTL3g1Q01rejZmbFE2THV2ajIvUHNMczNr?=
 =?utf-8?B?Y0p1dzJkdUlIa2tDTDZRdlJKU2JzYmFFdk9abTZwaUlxaForeExHMVAxeEdK?=
 =?utf-8?B?OGYwK202alZ4aGpsQ3NBVytMRlZCUlZFMUlIY1dtZ0t1dkNxTmNsMDN5eUtm?=
 =?utf-8?B?WTZTb0RZcWNjRjJUb05MemdXZkkzeWRkdkY2VzRRYkp0YUVlS3VWcW1xRWRq?=
 =?utf-8?B?Lytsb1BsNzNwUFdyZTFlbmJYa0tJTTBDZUJkNTNQZVNYMW1XeHJ2UDhON0o2?=
 =?utf-8?B?QWhsRWdxNUovS3N4QWc2ZmhDMDc2YU1vYVJmMFFJNUhVYWg0cU1rZzRaVC9G?=
 =?utf-8?B?SXRaYWFhcVRtc1VIbUIxQ0pqTVJjci9lRTF6eFhZSC96dHNmUUkrY1dVdEg2?=
 =?utf-8?B?RWE2Uks1Umt6dWgxejNNdWV5UlJMNWpRenFIRkpxNVEyUEJTcEh4ZksyVGtD?=
 =?utf-8?B?UU5LMEdmZ0V2TWExbWUxYjFPYlJ1RUFJSEtuZjJySzRZNk9aS1UyeHhuUXlk?=
 =?utf-8?B?VnFpTStOd2FaLzU1RHNHRGZSLzFoSmRFUXEyYmZKMDZOUVRzRnE5RG41M1Nx?=
 =?utf-8?B?aG5ndkdxd3NaMUJFKzVpaEFPTFdLMWNibWZ6dEhWUzlhZEliaDc3WTU2WnV2?=
 =?utf-8?B?TE1zampKVk5zNWRZSFhQbnkxMngyRHBLUi9Mdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(82310400026)(36860700013)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:35:35.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e942d31c-7353-449c-b76e-08ddbad5bf34
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9706

Reset the bit 12 in PHY's LRE Control register upon initialization.
According to the datasheet, this bit must be written to zero after
every device reset.

Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/broadcom.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

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
-- 
2.39.5


