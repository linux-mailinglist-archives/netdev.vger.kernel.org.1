Return-Path: <netdev+bounces-202787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA1BAEF01B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B8F3E1F8B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91B26462A;
	Tue,  1 Jul 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MxGhosPc"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB625EFB6;
	Tue,  1 Jul 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356239; cv=fail; b=NgAOuC857uxQttvERn7YpAx+/T24f3Y0LhSQmTqtJ58XGw9lrePnmELkAi6bO6oWnXD+L6ZMlSwJM1vUn9bMGM366vOen4TtSW8y4YeBbduBvblqyYhYVIB1pESp/4dxk2oo/ajqLb+w3+4MpvyAoz29w8WoUcDl2srGfrh4rXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356239; c=relaxed/simple;
	bh=ZIqrQX3B5auXXf7dh6XPzPgSAICs/5GwnGv787GA8xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okiD2BsKNXzuUq/7yKiEQVX16oYkJZhtqKK2SWNdDT2bJ/qYd/VS4t3PrXIxV8tRaNEqfK/KWgLhc8m4kTjjv4JTiTzZUFWci+I+oNNqP5v6mLH3zMXIvtmVNw9Nywzrf4fvxqQ0Sxwv1Dfe9MXg5dExjC7kfzr9P0bl+SS0eRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MxGhosPc; arc=fail smtp.client-ip=40.107.130.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKTj+sJRB2fGVJNCzLb/k1RnxlWaAIfboFtUC7pF/RDX2b4DqdVUt+D199js1bWdoAA8CpplwXbDDiV8JlaKktg5rL0XxbPKwqqyJ/q6Vll4Kj/PpRXqAtRdaD8vRS1Nt4iInsEO5MFcm6giF4pB7xiAztrSOxElWb9rxI3+EbXmpn5szQsGwZLPcf65wtern9XpnIW8vFWPbByQz0+WZrhlOtsUY7UZO0yqtYj0FBazg3tadx4JFn5wWENdMdSdTlOTnvFqd6roJwXBXmELRS2m3LAL/TorwSzvGbstsD62QvbQfzRfi+IkzIMmDPHfD1SSfmKPUxZTVriO/QTk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nncrQjzvQr2sLVmhKgPZphMPq7RADJzbXx84i4q1ds=;
 b=yWPQiIRlZwMnR43ovKJnBCbdIdvIxR1oOgy7GfTCH2TV6pc2NEvlopi/NXNf+mHuZk/seG3GnbmYY14mFkCQAMdnmWtynoc5iurxRlg7cCwE2Mknijh09NlrqSGHJGfZc9ItqKMjM7m118Q0lzdmlqihRhd0tFN8ZHPDEeoA7K+taV6afLSt1dPuVfb3nd3TOHomu0/SJ7rTrbl6mj9f0v2S7je6JHAPBEyX1uPJGb4DXqkRkegbNM/ho049N1Z7a8JL3hzeD8gaIPSIIfeOqEZrnDtu/e9Ep9pbnN830MqXvr5bqOYOg734fmqBRroN/onAQHWu/vCDr6BmaYpStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nncrQjzvQr2sLVmhKgPZphMPq7RADJzbXx84i4q1ds=;
 b=MxGhosPcijLV8pZJMw1MaNOIAT64pOraFrito0AgnorH5Ow3Vtul9VCOHQT9S9NImn6Pmq8htt+cV6hnJa+FolodcexJh/k9ADn808dUf5DcHlDPsDWAn9+t/6zKqS67sKGbgOCbOdN1WGAHWV7oLBvQGc8dXSPY1JM51A+v2IE=
Received: from AM4PR07CA0026.eurprd07.prod.outlook.com (2603:10a6:205:1::39)
 by GV2PR02MB11417.eurprd02.prod.outlook.com (2603:10a6:150:2a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 07:50:34 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:205:1:cafe::44) by AM4PR07CA0026.outlook.office365.com
 (2603:10a6:205:1::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.17 via Frontend Transport; Tue,
 1 Jul 2025 07:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 07:50:33 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Jul
 2025 09:50:32 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH net v5 4/4] net: phy: bcm54811: Fix the PHY initialization
Date: Tue, 1 Jul 2025 09:50:15 +0200
Message-ID: <20250701075015.2601518-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701075015.2601518-1-kamilh@axis.com>
References: <20250701075015.2601518-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|GV2PR02MB11417:EE_
X-MS-Office365-Filtering-Correlation-Id: db1f3a90-0e41-4274-eb2c-08ddb873f5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|19092799006|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWZqL0swVUh4TjJyREM1NEhXdStSSEV0azU4SUR0T3VBQk1xRXZaNlB4eE9m?=
 =?utf-8?B?VjFNZVVEbFpZR3hvMzNCdEFjSGtPZ1pwSWx0RXFNUVkzQk9PMkl3c3UyTHF1?=
 =?utf-8?B?RTNnVUx3L0NNaDhtZ0Z2VDBSN09Dc3JKMjJ0OEVuaXduK2ZVVU9Cd255NDVR?=
 =?utf-8?B?RGR1dUtSdC9ibFZiTHl3aHllYkFUV002MU81VjlFMU1lakRlTFFocm5GcEdD?=
 =?utf-8?B?aDlSKzlCUDNuY0Uvb1drZnNON09OQ3NubFI5dzBxZEE0U2VtNnBMZkdEaFhI?=
 =?utf-8?B?UHNXSlZETS9DR1JXMC8xOGNpQ1JlRDB4d2h1VnFScVBXdC9mSEFaQWZIV2tL?=
 =?utf-8?B?b2NMampSMkw1TEFTNnFnRGlvbWJNbmxGVnVaR2F5UkRxRU53NFhZNDJkS1Bj?=
 =?utf-8?B?VEs1Z1c5bDlSYUV3SHRXV05HaXNjcEtCWVVXOStXYzVNaDk5SDY0VHRLbEpV?=
 =?utf-8?B?RGl3VW9BSlFrSEg1ajBhZ2IxOUtvWXRvemhUSUMybUxhb29ON2xZeUlkMW9l?=
 =?utf-8?B?Z2N1ZWgrWmt0cHhWVTRaTTd3QkZLMTFJaHVJUlhBMkRpV1pWa0dWRHNZSWk2?=
 =?utf-8?B?OXJPbVFFd0xMb1RDMGxSYWx5ckVkK3RLSUpBTUxENWxybHpsblltZzNlcWxl?=
 =?utf-8?B?dSt1Rjl1UUNqWks2bkF0RDBwVkRXWkJYWmRrZklBYm9BenpRMVMvdFQvVFQ1?=
 =?utf-8?B?cUNMRkFrWGdBeUFNbmoxaTl6d2RxenhlKzhuMFBNUVFieU95blNzRVBRTXdX?=
 =?utf-8?B?clhUMWs1MkxEa1BtK3F2V1BiUWZ2cFp6WHU2amF4blMwa3Z2WndDSXUzSk9Q?=
 =?utf-8?B?V2ppOXhJWWVsZkRianRBK1pVY1N0eW1yZUdCbE1sL21raXNFNjFOY3dQNkhE?=
 =?utf-8?B?Q3BmaHdIRnA1enpSamxyMzFHeVR1a2VQVDdLYWRjMWdET084RlFBNjl5M2FN?=
 =?utf-8?B?cVpabUFDS2xsQkFGWUtKcWYvRkt4aVNiZzZFNXJBelVhUDRPSGVMMVh1V3pj?=
 =?utf-8?B?VGlUajBPMmFYUkpUWVF5TkpDUXpZdHFtR3Q0MS9OelFxc0xnYnlqRSt3b0Js?=
 =?utf-8?B?MzRiQWRXY25QYVE5TmlRVWJnSDJEakd6ZFk2OW5VRUNTaU5CSnpOYzZuREFt?=
 =?utf-8?B?Mlk1czlJK3JzbEF6TnJITzFjZDJqSnFwZmpSay9CQTBkUk9jaDNvWjNhR1hR?=
 =?utf-8?B?eHV4MHhYc2p3UlJRNE53MDdJbldBWkhCbmhMNTlvRGtKYXpibGRDc1pXd1RV?=
 =?utf-8?B?eWdtSmRqbmtIZEJGc1BPR1VTamxkMDZJaWtLT0d3bmRLMWZpV2ZqQjMxLzQr?=
 =?utf-8?B?ejN6YzM3NlRXN2lFaWt6NmNRZzVRaUQ2Q2UvT2hhd2xFYWJYUnREWUFFcFRx?=
 =?utf-8?B?RUVIVjdsVUtvZ2g2YVRTT1NMUUZSMDkwRVdaNTBiZWV5bmJZQzV4NFlybXNo?=
 =?utf-8?B?UjcrT3ZlY3J4SWZGTU9VSk5HZDFXR2xLZGJ2cDEzWGtkaHowLyt5K3M1WHpw?=
 =?utf-8?B?U0RWaEMyZTRuY0ZYRVdtZlQ0WkRRQWpFbWhPSEdsZEpjOHlPd0c2SEs2OHFz?=
 =?utf-8?B?SWMrNG1lNkpYL3RIQ1Vta2hHSk5jYlpKcFB1WmUxSU03VU8rNzY5L29rMmw2?=
 =?utf-8?B?OThveUZMTVJQU2R0WlNQOHNHaFFsREVYdTJyYmNmQm5KVGZzbWdBVExoS1Nm?=
 =?utf-8?B?M3pGSHJHYWR4S3BaQjFTZDlHWFB1cnhaOHBlRXhQa2hORS9ORFAzNUMyakl0?=
 =?utf-8?B?c1BnTmlCT1Y3TEtheW5MRDNWdkppL3VKbjY2aVZSblNDRjFwaGpzY1FlN2kr?=
 =?utf-8?B?RW50M0l6VTZJOGpjaWxPUW5oc3MvTyt3RytWMzZxRDEwNjlkUC9Cd2hrREVm?=
 =?utf-8?B?UWJTMTNzdTEyZldSVVdvaWdNK3h5UTMvOTEyN05hRUVvbzBjKzFTNXozRWtV?=
 =?utf-8?B?bUFVOWhHVkpMS3pEako4RXlYSmwyalluY05SdDNPdnpQTmkyZFh6amJCak5a?=
 =?utf-8?B?Z1p3eFJSbGRxMUJIdG9sQlVZSUxJeURhRlBBZy90REpNVm15b21oNkxOQXZo?=
 =?utf-8?B?eXdhL1pySFVBM0NIM0FOWjhqYlB2UHROUUpBQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(19092799006)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 07:50:33.8823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1f3a90-0e41-4274-eb2c-08ddb873f5b0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11417

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


