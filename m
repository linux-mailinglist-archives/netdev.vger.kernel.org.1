Return-Path: <netdev+bounces-201527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9049AAE9C50
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504351898E1C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98A275AEE;
	Thu, 26 Jun 2025 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MYhmSyNZ"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE534275112;
	Thu, 26 Jun 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936588; cv=fail; b=nnCGkSvGbSXN1/OW7RDmoANZxim4pMvXobLPccFQBsrcC2GCkiQDEYbeuANOlhOwz5j0SdUN/MlIb0BEhKQGdr7+dYjhMUZ19JTcyDeHp+aySxd7yeKJNCLRhqARVAfl5r6H7RvlneC2W7kWZ84iKgFnG1cttpKno1Fj/+gMSXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936588; c=relaxed/simple;
	bh=IHtvyqE95H8ROJBll+b5DokC/pyhUOkHQb5/V8Zstbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUX6dhUeUjcPNomE/KC2AVFHKb4bnAV7wQkdPCdti/G6V37pUqUwadKZjo4op19kTICJGIXkRTI+xetVgDTor/ONBHsnY1pkbf5F9epimTbcmO7/SrfI6Ox7oO78H5RhRCL9iRkfQp8elCG7vH4iBOOImvBgsDmwm5kwn0i57Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MYhmSyNZ; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdw/7IS8zz8R4+bYLfw0C882tDu5ypXY+vixRnHAg/I01BXnYr7W2A/z+KAPlb6koSyHDOi2A5hxV534P2O7Tam6sc7IyQ/Pq5CzFwcOhX1/fZ0dWYyI1XU02hN0RbR7UaaspVaiM2p7jo4ZXeOqCF0X0zcMuHAE3rXM8vK5L7tBeBM9yNbRKjd/w1mj8dqrFXyjRsKLOW2c+awxFJR7CuxlfgwXhGfeOdXt0NdYqWyvYTfQRdxsggV8F+cIn2wQncAjhF3wV4feqAzT9MkGLdb0wn26iY7jSm4kfOtGXzJ3lZIk13ylEB3oMahDXwDCy358EFj/GlSwIPDjGLW8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klbt0P3AtEn8kc4ft+BcHu8U1DUMBOD8AganLYCB3Do=;
 b=CCEAS7YlBoFkgk8XrS3ympWpYtrocPvquC1Rrre69NyJRvHtdINcsAyH/p+aBDs0gE3odedu+JLpTehuuBcRSmB0AIhTHs1TcyWjkpgIF/dhWy20W2l6EEmBsHvhzNlnKvSzS4Ba0d23jjlkhLxKTv3RE8f4gkY1r9IfbpRPS1rED8n3gGlRNP4cD8mUaje6yczspExsP+r025QDxsQAQQyHvLt68TawoFq5D6aiJhZ6ZgAYXcMz8OgvsFnZDoCoOwe553qGN/rgmy2yevAYYdVwouUYkJGFC8/tghMPXzlorcIXWjx5pU8rE+ALRrU6BF1Pl17h6fpvpWo5Ot5lTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klbt0P3AtEn8kc4ft+BcHu8U1DUMBOD8AganLYCB3Do=;
 b=MYhmSyNZGOW1WydVS1Xchbi8WtDd9F9ZqN6bfrCH+sMSDfofLsCPz9iiqTgDKxSiAaPEGy6eiW1JMI/rh+xkI2cJ+8ZutZrF689SRbVIYwR1Dz0NVpemCAM6KzmFIfUzbrg0sRUgs8INtadLPep5w5iDR10k++PomoPRcLUoo3k=
Received: from AM8P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::23)
 by AS2PR02MB9439.eurprd02.prod.outlook.com (2603:10a6:20b:59c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 11:16:22 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::4d) by AM8P189CA0018.outlook.office365.com
 (2603:10a6:20b:218::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Thu,
 26 Jun 2025 11:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:16:22 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 26 Jun
 2025 13:16:20 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net-next v3 3/3] net: phy: bcm54811: Fix the PHY initialization
Date: Thu, 26 Jun 2025 13:16:03 +0200
Message-ID: <20250626111603.3620376-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626111603.3620376-1-kamilh@axis.com>
References: <20250626111603.3620376-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|AS2PR02MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 03063389-8b3e-49f4-d65f-08ddb4a2e1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3V1OUlCckpHOVBPWFJpdXJOdjN2UVpZbUpXcC8vVjJuelhuaGpnaERKbktr?=
 =?utf-8?B?U256WEt2bzd4VUlKYkd6UzIxSUNneitVRFZnVU1tWHgyeVdkU1NpZ1AwZ2xi?=
 =?utf-8?B?aVE0MmdJMlovUTRyNCtFUmpiNFRlUTJLVnVvWlppd1dSODV6STN2YmtYOGJB?=
 =?utf-8?B?TDNhV3hzTTBLT3UvTlpDQjhTSTMyalVubmlHV2FlYWZzb2M4TldmZFdlWEcx?=
 =?utf-8?B?djdTN1hPU2pZWXl3ek0yTjA3WUJhWTJ5Zkl1czI3RnF5Nnl4ODlkbFhvMS9M?=
 =?utf-8?B?NXRRMHNycGJFM2lMcFN1SGFQWlZJMi9uVFBpQWdkcVIwVW5ET1JPK1FjOGxk?=
 =?utf-8?B?UVp4Zk50YkN3TkJNMFlFOWxKNjVPM083eXVBSjBmNkkrdHN4OVhBWlZYNUR5?=
 =?utf-8?B?NjF0V2VyWHdoSGpaZDk4dWFkNjhlOUtxcXF5am5hMCtpVDFnVlZBb0JtSVRt?=
 =?utf-8?B?cUYvZGtlMmM5RVRuZTM0eXFKa2lZUStMYWpuanZzTStiWFZkR2prTXRvai93?=
 =?utf-8?B?U3JpS3ArNWxnTHVINFYyUTFVZXk0aC9NeHo1bit2dTgrZnJSR1kxOWRSWWo3?=
 =?utf-8?B?T2NWakhzeTF4a3VVSzYyUW5ma0pnQ3JvNnhZbm4rZXlrd2NsamY5ZW56RENR?=
 =?utf-8?B?SFNHbWo3TXIwdHdsTnVZeGR5VFRMUEQvQ2hmZEZXand4NkhmUGdmdGVnWEpO?=
 =?utf-8?B?VUpBbjVBa1lkMi94MFRyMU1mNUkvU3hjdVl5d01Vajh2bFJub3FIR1d3YmpL?=
 =?utf-8?B?SUkzMFlxK1F5eE9TTkRXek5nVnRuREdncmZrRFVMQ2ZpVFF2QVp1dVphU1dE?=
 =?utf-8?B?WFVFbDBsYmpXaTMySjEwbjRwSlJ3OWRPWXRGWlFKMGMrYWVIYS9VRlBRbi9n?=
 =?utf-8?B?RFVjeWI0MjR2SjJja1F4UFBPd09NeWJsNHFoSFNPWDBtQzNVbUlyWnlybDFJ?=
 =?utf-8?B?OWxSOXJFUWlJcFkzQnFzZWk1WitpQTFqbW1QZzYwSmU1eXNJUmlXVTlWUlVq?=
 =?utf-8?B?d0loUlhRTnJ1UEdiKzJNemR4bGtGK3k5MU1vc1h6SVliTm8zdFZyRXhuU0Z1?=
 =?utf-8?B?Z1gvRUhybXBJUUdRbkw0T2RQSjRZM1k3a0dBcXZ2N1N6bWJkanRpaGZ0Qno5?=
 =?utf-8?B?ZnhGSHEzK1k4enZrT0lDUlRlZzJMVTNCdGhBRDFrb09NbldNRlVMb3psMDJp?=
 =?utf-8?B?MCt5SEF2VTdhWCtwbjhSaTFXNVRqM0JqYnRQV25RYUdlSG9LQlgzRm4ySklZ?=
 =?utf-8?B?VW8wMkE5dVFUdUhrSzR1UGtTYStnL0NTWUxqb3FEOFMzR2sxTVZRNUZ4TEh6?=
 =?utf-8?B?ck0xZHVDNy8yQ0ZSWUxEdDZyNmRwZWZoQ29aQUxndHQ2dGFrNEtZR2M1WUdR?=
 =?utf-8?B?WG5kM0tnZU1EUElCRkw4U1JLT3d6d1lvZ01hRWNoK1JIYUtrS1hlMFVlTzVy?=
 =?utf-8?B?Q2xOeHl4d04xL3ZDTjgzdGJSMys2Z09sT2RZa1R5VlJrUlRlYnduZzVVL2l0?=
 =?utf-8?B?TzRwbVFVM2xUY094eFdWRDFzQnc2RERJM2hXRC9tMzREK0ZVMm9WZXNxNExC?=
 =?utf-8?B?NlY0Nzh5NGwrZUQ0blZzd2o3c3c0Z05EbEZWa1ZRMVRSaDludE9ZY1Z1Tnc5?=
 =?utf-8?B?TUNtdDRORS9wZmJlTFFtYjhKRGY2SnpvenhtWWJxYjBQdGdvR3RLNlZoN0Yz?=
 =?utf-8?B?d3JmWW5WK0htMjNtQStBNWZJWk80TTFaeVVjdERPWDFsaHBqQzBQVEIvUHpQ?=
 =?utf-8?B?NTQ0ZEhaWUxJaWpxckFUbzRkdXdHMVFYb2JpOFZ3aTBCLzdTbkduKzdjVlJ3?=
 =?utf-8?B?SlBlempRbVlXdS9sOG9PMXlaR3hHVWhBSS8yakZMeCs1WmFiaWtFUzExYVM3?=
 =?utf-8?B?cUNUdk1jYUwvQmtYYjNRODEzTk9ZWkdSeldQQUU1RlZwSS9Vbnk0cGdGaEZu?=
 =?utf-8?B?dU5jejRUMlRNbFArZldwNFc2dHRtUnJCMzJwQTh2NVA1L3JhanJralByZkVn?=
 =?utf-8?B?eVFyeEY3ZndxaWNNaHBXeEZqT3k3VEg0RFRtVENXWFA3ZXdyWnZ1TlNWeVVV?=
 =?utf-8?B?b2pGR2RURmZKKyt4QlZSbkxCMG5oK3E3T1AxQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:16:22.4212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03063389-8b3e-49f4-d65f-08ddb4a2e1ed
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9439

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


