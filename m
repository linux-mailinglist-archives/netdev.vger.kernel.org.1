Return-Path: <netdev+bounces-202449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BBCAEDFD5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CA43BC421
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EAC28C5BD;
	Mon, 30 Jun 2025 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IQxAi7ow"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543528BABE;
	Mon, 30 Jun 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291943; cv=fail; b=W+d2gRiDNA9rE9FpHk/MDrDypupJu4NzvQ4UJYpy/suoXt+iZkMXeBHfj0aNCP665EXVlyYAIuB73wyi2O9zqK0TeEhbt9ZWtWNRGsTnArf09fK/RlIrCPBkGkY2v7Bm9YEAI1RBzVi0do2hlw0xsVnXqRqNQfkoHS58x863JoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291943; c=relaxed/simple;
	bh=6rZuFm3pcAXpxzRuMFb6aIkBzPT0opm2zSCq8W9ea7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BizABA4GeNl9LrdHSOtAFu9XvEQILBwV3UnmU3WXfnXypxzNKQAmnZUnE4wM9rRsq9VnJJcE19r1dnY4d4qsLZ9CVDp8qCFTe+S842OxHLG9mwETCPyefTT3jBUUwd9Ht+hcp837iPtiTRw1PQT1Bm2bdl69Cv4ze8JrhEipR+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IQxAi7ow; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r91m8k0HZzA20pSQqRWoNLNFlmk8UTWkLqgE/nW60u4HdosMLu6DsBSac9Jhem2Iv5oTcXtAvBWTZqKTROCKnTtp9hIpBUuNP6Z8RBdeghMIC5qQhI+Em5SOGf3B6xoLIWd4DaBScnYbEef2y39k1HfcyUlQssq6Vnj+DUCk8JaBZY9TM5b8sM8/lhvZ/JHmmYw4JNKCX2zv/tRbtOhGDuJiIjWkYt735ZtSuDy7NSBvXSKLA9p0kp7aizmbRtoKmoWN+R1zxbkXhFPRNGxBSJn8ptSb7DjHpG9CxHcbmV8m/Hcbm3aoq7tJKUY0nP4U/C9MPDYZfrB6mmp4H466XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FJf+sJQDufzwCS66IhAtj8B/g/B7+z9j42tJVFPsPU=;
 b=yNKJHmUbMfDKDhAEfMVkHhy+DjN9wfLFboOvse9ym2AzaDlx3MBQ+UT5+tMYkMUgRAocn2DFwaW3QurntJNg440WgVZhRRrNwiXhTYMo9AmeYQYqN1p5e2i+f04F/+RTZhuet+ALamOJOZCCEs+zsfhLOp1lmVFhGO0svKK6zHIwc/wojhNOzWEIkkwenCsjubZjwo0zTTZF0CS8t0ngQtXuen/GCkNgGKO0UCwN1Vg3FCyfzoLHOaSXiutHoqz3MXT28KqtAIfxLwWRabsVF6krH6CpOyj22r5PXO0VIpugQBrI7X9vJFw1hlZGzrGhLpc2NcRmCVXwVJ78bEZvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FJf+sJQDufzwCS66IhAtj8B/g/B7+z9j42tJVFPsPU=;
 b=IQxAi7owOV3TGCAjl1ZsjW8pUUotepO4WJYbdw0iP3F/25Ova1UOU9fsfdXxWSil137p+ajJVJi4pNdM1x8sY5aPKxCGajOgQYcB019D+U7zs53918H+KI0YQ9hjZFs9n+4rBg6oxeuSa+vOqKDbHGfPktpmGuEnpDs1rBfGbDg=
Received: from DU6P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::28)
 by GV1PR02MB10664.eurprd02.prod.outlook.com (2603:10a6:150:15f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 13:58:56 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::c9) by DU6P191CA0029.outlook.office365.com
 (2603:10a6:10:53f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 13:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 13:58:56 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 15:58:55 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v4 4/4] net: phy: bcm54811: Fix the PHY initialization
Date: Mon, 30 Jun 2025 15:58:37 +0200
Message-ID: <20250630135837.1173063-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630135837.1173063-1-kamilh@axis.com>
References: <20250630135837.1173063-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|GV1PR02MB10664:EE_
X-MS-Office365-Filtering-Correlation-Id: b57370b1-6d0b-4224-4d3c-08ddb7de416f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|19092799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkYwTlRtNUN2YzlDeHlsZDZ6eVRzUUxHN2ZVU1RrRkg1aGtsS1I0VXRlUkZC?=
 =?utf-8?B?UWE1OEZYNWJjamFMbzVDMWs3bFlTVnJmd3FPWWtTeXhkSXNJamV4KzNQVkxP?=
 =?utf-8?B?M0ZqR3RUL2NXN1BRU1dlRXdVcWdpN1VqUHNHalBrRHYwT1pQRnJBak40ZmxH?=
 =?utf-8?B?bUV1bzcvU1JZUnZaNDdLUWM5eTk3a2dIR0hGZWFDWUJiMXlhSG9LczA0MXdN?=
 =?utf-8?B?Nk1WOU91cUdRRnduWW8vZ0xlSTJWQnBSb2NzNjJlNCt2NzAwYlhLd2lRTmFP?=
 =?utf-8?B?RzJVRklOOUQxazF3RzJoQUY5KzF2UUtGajlKUjBsdWJnb3pJcEJVRWRnTU9O?=
 =?utf-8?B?cUdSMSs1bHdpd2lxektsVEhaRktaUllRLzBXa1lMWFdGc0FFbjBkV1BzQzJu?=
 =?utf-8?B?TWh5K2wrSk5wZWhyTGtZK0szbEhIR3VzY3dPMUpCT05EejRoVVpYWGFkeTJO?=
 =?utf-8?B?NkdoQk1YTy90dEt0cDE5UEJHSk84VytSTzlJWnJ4T3ZCVTF3ZFhxVTUzL3VC?=
 =?utf-8?B?UUYySGQxejFzM3V4TW9uQlRBb3BrT1pTZm9HZVpkSkFvbFFCaU9qaG96Yjhk?=
 =?utf-8?B?dXRPS1Q1bzRoL09oZm5lbW54RVduTllOSkhzNjhDU0RUUHVRUnJyZ3luNFdM?=
 =?utf-8?B?ZExpVFJHcEc3SnpSUzNmaTY2WTlKcy9ycmp4M1BVR01GYWFtcmJ3WmN0WTV6?=
 =?utf-8?B?empkTmNQVlpRZUhBNDhVcDJTdUliWU5TTndOSUlPcTNsUHUvQ21Vb2ZVWHFl?=
 =?utf-8?B?NndhWDdjNVRWQTVhdi9yWmhNTXdBa0p4QkRxa0FySW50S2V0OUtUTEpGMU1Y?=
 =?utf-8?B?bTFOYk80dFQwK0FYTXZ4eTNVakNlc01ZVVdMRUxEdURIVlg2bHc3L1UrN09o?=
 =?utf-8?B?UUhMUGZ6U083ZUpmSEQ1UEdtVHBoU0ZSZnRQcHR2bjJ6THVPMXhXZGNSMCtr?=
 =?utf-8?B?aDB6UHZhVEZPQmppbFRib2xhT3A1eHFJbE9RZjA5Y2d0b0VER25mSmYzMXVq?=
 =?utf-8?B?a3BPNkc0SlNKRTJhRzYwcmRyQ1dLMnZ1WW42VThQbHNNdjlRMnh0dVlybjVa?=
 =?utf-8?B?R3pLeko0VUVPUVBqWFNKOGMwanU0cGRvVGU5OWF1V1gxL1haTjRBajdJUEMy?=
 =?utf-8?B?MlRvMzV5YXJPTWhoc0x6ckZzTGVGdkJjOEljZnJhUjdSKyszUlZVbFBoVm4z?=
 =?utf-8?B?bnNpUEJmT1NUNllsWFNnSUlQVnc5TUdoS1lYM1pIQnB4YmMxd00wUFZ0K3NJ?=
 =?utf-8?B?TXZxU2d0cjV5ay9HeGcwa1IzRmk4cUZ2cVgzODk5dGRCVlhHc3dDeXU1SEVr?=
 =?utf-8?B?eUZ0R2NXQUhXSE9HWXFRQVlVQ0hpUlZyZWRncEw2d1hGdzdPVWdYM3dJd3Fv?=
 =?utf-8?B?L1lNekVJMWFQWVJROWt4SHE5YXR3cjJaU0J3bVpvRHkrRzlWaUpJOGoxbGFI?=
 =?utf-8?B?cGlMaW9oK2sxSlJrdHF5Q2kvc0l4Q2FBZmxHbU84b0tVcXJZaXNXQzI2YzFu?=
 =?utf-8?B?cVNXcllidUF0L08xSkhibVFiQnZsNm9Jb2dRUFlFL2dGSTJGeUYwejRoMWRU?=
 =?utf-8?B?VDRRbjAwMFJ3Nlg2OGdwTVNHcGtxczBLeEFKcFBSU3NwZ3F0QXptMGRUbDhx?=
 =?utf-8?B?bXY1bmlOR0dtYUtvTGVuRXNYSEtraVlVQWlnTDM3RFhtTXNHVVp1MFF2Z3J5?=
 =?utf-8?B?Z09mRzNKWWU3V3lNSXlOamxtLzBDUWRrOVNHZjF1Qng3SDJ5cTlkTThIbXJD?=
 =?utf-8?B?UXg0cmJhYVprWFMzTDNtMzlUOVFDK2JCMFh0SEVvb1VLSUkrU1U3TWNYL09Q?=
 =?utf-8?B?Q0gramhqMVB5UHhhWndMT0tlUktGZDdxUThRZGNJQTNIZlNnMERTSm0xRzhB?=
 =?utf-8?B?Szh5cm5zWHNrTm5uQUkzZTJVQ05QUFhFVlFzQ3V1RmNJdzBFd09BSHpSdHJG?=
 =?utf-8?B?Y243VU1YWlpQbWhhbDNmL3R3YzdYQmI0YWdESUZhWG5IcktvWWltcmFnN2pQ?=
 =?utf-8?B?c2hlZUNVYzIzUWJPNndIZXVJY2paRUpjSENrbFVBTnhyQWdMOU1XZndLRzBo?=
 =?utf-8?B?YXpuZDlxN2NmdUZOSlBGd2xqMjdVdkRWZnZPQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(19092799006)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:58:56.4394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57370b1-6d0b-4224-4d3c-08ddb7de416f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10664

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


