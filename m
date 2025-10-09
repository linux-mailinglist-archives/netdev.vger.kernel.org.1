Return-Path: <netdev+bounces-228376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14CDBC9335
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5B01A618D9
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171D2E7BDF;
	Thu,  9 Oct 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="F4u3X2zt"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85F24634F
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015256; cv=fail; b=uf7JjdjshgXw/zv+Y236hrqTkQ2yUIAsH9GFZVvjcITo8BaWYKVFcuyJ4VzwvCBFAyc9hb0QaOE/ZD9M/XbOpypmxzfKNqR2MoNWaS03MSfNmQDrqp8nmwHWFJYRcTn6ALs5Y9uu7hmUgVPYsoCYqbmAILtC02DfgCJifvJu16I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015256; c=relaxed/simple;
	bh=YeUGhJcC0y3bC6sV/BcoOW2H+TGJ7BAylwpYDRLrKcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSfv729fJeNh/TvGcNnBX3UAdgjAye+kj6ShGV6awyNUdjNGpVsODNsYADqSbI3fDVT5/5AqyEVlgwDJNWis+8K8Q0Z8kKMx0MI9w7q4u7Kio7EDW276W+QZuDiubumwAkb93U9TrUTgFBg/d19M9mY00Yty1+sgvVp22eYqzFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=F4u3X2zt; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHyGnWCfcDVx3g/bh8MSAnDv2g5lcKfLQwmDsrwR1pzCrXA61hatGyptdOmCYYm3bDSoLEIlxvFph2ssLMInCOTlfhds3hmaJFo31BQPyTTzbIiOH7uoNtSuYzeysSPgbbnkJ1mYxr3JQtdJq1aiULMX6bKdd7r3L7fu4W/or7l6Jog8wjWj87wIr/y25OeUWE4xQ5q8ymPS4/l7kUv8ETehMOvkxPZUUmNjy8T6ee9C/htfO34Ni0rWbSVNHfKcz4XjVqcYfSjf0GMYULN5S++xSzQkpWjLOi8u/8a4G7PFFRmyU44YeCj4AR5KozH9ZTjrXgSkxycLRKlguQUQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml59bA3NFIOPEVfD00uIpfx0VY9Wns1e+rfRwrRwXqE=;
 b=MfILDgNKCsJZNclj29ivrPLxM7MUtPnU4ynYF244s/CiSBDisJLUCZBGrVzrbSSsgrOlDEJX7ow807X3Cp3cVr2g8XKXkp94rIN6zw2qmTt9IDxmdC3sqMO+Go9/jJAmE1LT/B7kEMX8tRd6kg3RhbdpgEfWOFr1TFy4Rb3fm1FpQkdHljRiAkoQfnJtHnI9w6ZBTuYlrjhablUyXbSVf7hlQrN8/NkSIigrZprdNi/dA2wP2WhlwZsvzhtoRseu85Z+Rg8qB7JNPypGCQNzd17FzasZ7zu0eD/Agni5lL5c7boAMHk9SDDkUptlGzqmrlLMj64iMGtZ/hs/zZLU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml59bA3NFIOPEVfD00uIpfx0VY9Wns1e+rfRwrRwXqE=;
 b=F4u3X2ztUPPgYmw1dULMcV6S3iel9+wAqizebZJYu+/Zz3ge1ietIYWnksf1G+VD2Mu2BN6H+6brhrKKigCDNPV9T0VNvu1w/l2dtLWgjOua5l6Wa8jHk57udca2wesICWM50W607P+TYEVQlKTlljdo1fFjV3MEpzY8JCxnEPA=
Received: from DUZPR01CA0280.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::26) by AS4PR02MB8455.eurprd02.prod.outlook.com
 (2603:10a6:20b:577::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 13:07:31 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::56) by DUZPR01CA0280.outlook.office365.com
 (2603:10a6:10:4b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 13:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 13:07:31 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 9 Oct
 2025 15:07:30 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v3 1/1] net: phy: bcm54811: Fix GMII/MII/MII-Lite selection
Date: Thu, 9 Oct 2025 15:06:56 +0200
Message-ID: <20251009130656.1308237-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009130656.1308237-1-kamilh@axis.com>
References: <20251009130656.1308237-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|AS4PR02MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: d05cc77e-6229-4103-3bef-08de0734ce4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXB2c2VsRmpCdVJDMFBrR1BKUzhpZkNac3hhTHhBUFZMbm9WQytXTzU5dkVF?=
 =?utf-8?B?YkR3SE14WUx1Qjd3RjN1QnBPT2NtSXY1VGlGZjJWSHlwNjdkUjNxdGl4RVBQ?=
 =?utf-8?B?ZkdmTm4wcXZaNHVqczFTYnpKMkxLUEt5dlVvT0NjWjh6TmZkbXhRaXlpQXJx?=
 =?utf-8?B?WUhwZU1FN1ZLVUdET2xVVVdjUnRIL0RxbnUwL1AvWCtTMTUvbDhWc1BlT1Y2?=
 =?utf-8?B?NUl3UlBRRUJtM2xoV3p1Y3JpT3A1d2NkVVdNODI3eXJPQW4raGx4WmJEeDhw?=
 =?utf-8?B?Q2lFRFhrczFIVXlPNWJ1MnhVMWNvSlAzUGZXVmVma1JCNkE3cm1xRDl1Rk5L?=
 =?utf-8?B?WFZzeGhyWUNuZDhsQUIvWVhyMGdHUmE2SWxIc0k0bENyTGNrRFZUVjhxbFZj?=
 =?utf-8?B?aCtIOGJKVVpoS21ZQ0RtNHV2VXVReU9hZjM4RFVsMk1MMzkrM3dWclBBSmdC?=
 =?utf-8?B?dTZJYWp6NjY4am5TSFFMMHhGS1RnaXAwdzc0UnpQL0s5K3pKTDIyaU1xZEtR?=
 =?utf-8?B?YU53UkRtQ1MxV28xY2x0T2ZJb2tYQ1U2Yzc0VHkweWJ5ZnJBRHVaazdmVjky?=
 =?utf-8?B?TUk3ejV5cUxsTUFieGlqbWM5K2RQVUM3V2dJelVvay8wcnFoNE9RQ25ZcVkx?=
 =?utf-8?B?aEFGcnlPK01WVUs5L1RMMTJadmFCVFUyS3kvK3VLb0gzRlR2dHN2d1lDc210?=
 =?utf-8?B?NUFOaml6Z0NhOXdHS3B1MGhrSXo3YUt1N0QrU0ZBR0JENlVjUHByajZUTDRG?=
 =?utf-8?B?OFQ5bVJKQ08xNFJ1bjRxSUJQV3UxUUQ4STRiWmNTaVJUNGZ3RlNiajMxUzVm?=
 =?utf-8?B?SVFEUVkxUmt2UFBqWEFXS2dmRHRhTGo4SUJWUjd3bXBKOVBpZVZsL0FxMW1l?=
 =?utf-8?B?V3lnNXFhcUl1R21iNlprN0hoKzhvcDJkUTE3V2lVS2ZUWlhQQ1NidEhvZWlo?=
 =?utf-8?B?cVpweDd0blJOejMwaUh0bm1hWTd0WWZ5RHFxT2svNjAwSEtPak14Zk1vMUts?=
 =?utf-8?B?d292QlpKT2RtQWRINHFNY1BGZjhPSWoxaExTUWc3T05KbTFvMU92RUh6T21x?=
 =?utf-8?B?Q3JmVm94aUlkbXdDVXkrNW5HVFk3aTg3WFI2V3F0TmlhZlZid0Q4dkFGQ1pF?=
 =?utf-8?B?TDRFenVpdTVzanNsZzYvb2F1WElEd2xncUY2bnRYNHdaeWhORzVIbnBJdEU0?=
 =?utf-8?B?ZUpjdGZoLzBOdjNsTTdNSFprV1YvMFJPWlhBY2FiVFduU21zMThheWtMYWJ0?=
 =?utf-8?B?SXUrWDFjWUtGdWg0d1BtOVMzaXBEZ0FNZFIxV1BWbFh1RmZjdUp5M2VYS0dq?=
 =?utf-8?B?VjhJWlBRSi9YTmM5L1lvM1VicThlYzdiaDFpQzhvWWk5aUtHcFhzUWhoSUtV?=
 =?utf-8?B?cjNqU0FzQm5IS0d5K1R1M2krS0ZMZ3ZnRHdpNjliWVhOa1VHeXQvdVl6Zmgr?=
 =?utf-8?B?RG1BU0dSSGYrbUVsKzFlQS9Wa2lycUpxeW5oK1Y5UUdDSnRPUmQ1bzQrUXVm?=
 =?utf-8?B?NGdqV292NVZQWnFudDBXdTRkUkFPSW9GTjB3ZlpLVUlYb3VjTVoyOWJKd1RF?=
 =?utf-8?B?cVRXd2V5R3VRQVJWUnNUeStOSWpFTzF2VXM4dG1RL0tPVmFJZTBORVc4YTdJ?=
 =?utf-8?B?enZzUkpnZ3FVemw3NVNaQ0tOQWQvMkpsTjlOSm5Cbmp1VEQwdmtIci9BQkhO?=
 =?utf-8?B?eWpnQzVDcHZaU2Y4Ni9kNkEzV3JyWUtFQ0Npb0FSbk1FYWF6Vm9vRHJZaEhl?=
 =?utf-8?B?eWhtcThkdkJjRGs0NTIrUWZ1UFo0MTM3eEZjV0NhOCtVby8wZE1FYSsrcGxN?=
 =?utf-8?B?Q2dzQVpmZktVbWx1QzAzRGhMVlBkNWtoRmJXVGI4Y2JoeUZ3d2xuVlJqbUV2?=
 =?utf-8?B?aVV2aHdtWk9lTmJvY3o2SWV1eU1WWVo0YXZOeVdudDVQdnpzQlFuQldYZW4y?=
 =?utf-8?B?eVhId0I0SWxCaUFiN1pFTXJ4M25Tb1V1SEtoTUd2MVBmRG5jY3BEQzdWVVd2?=
 =?utf-8?B?V3ljQTRMbUsxMUxxa3ZQRUVzVlpKVlhiak1xZ1o4Y1hhWGpoUjB0Wk9kOURN?=
 =?utf-8?B?Y2FXZzFMOGVic0MyVC9uL3RWSnBPNkpaYXVneDNveHFqSmFSWUhSdmlYa0Fh?=
 =?utf-8?Q?TCVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 13:07:31.3631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05cc77e-6229-4103-3bef-08de0734ce4f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8455

The Broadcom bcm54811 is hardware-strapped to select among RGMII and
GMII/MII/MII-Lite modes. However, the corresponding bit, RGMII Enable
in Miscellaneous Control Register must be also set to select desired
RGMII or MII(-lite)/GMII mode.

Fixes: 3117a11fff5af9e7 ("net: phy: bcm54811: PHY initialization")
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c | 20 +++++++++++++++++++-
 include/linux/brcmphy.h    |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 3459a0e9d8b9..cb306f9e80cc 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -405,7 +405,7 @@ static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
 static int bcm54811_config_init(struct phy_device *phydev)
 {
 	struct bcm54xx_phy_priv *priv = phydev->priv;
-	int err, reg, exp_sync_ethernet;
+	int err, reg, exp_sync_ethernet, aux_rgmii_en;
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
 	if (!(phydev->dev_flags & PHY_BRCM_RX_REFCLK_UNUSED)) {
@@ -434,6 +434,24 @@ static int bcm54811_config_init(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
+	/* Enable RGMII if configured */
+	if (phy_interface_is_rgmii(phydev))
+		aux_rgmii_en = MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN |
+			       MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN;
+	else
+		aux_rgmii_en = 0;
+
+	/* Also writing Reserved bits 6:5 because the documentation requires
+	 * them to be written to 0b11
+	 */
+	err = bcm54xx_auxctl_write(phydev,
+				   MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
+				   MII_BCM54XX_AUXCTL_MISC_WREN |
+				   aux_rgmii_en |
+				   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD);
+	if (err < 0)
+		return err;
+
 	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 }
 
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


