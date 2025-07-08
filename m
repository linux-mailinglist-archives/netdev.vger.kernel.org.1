Return-Path: <netdev+bounces-204887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F2AFC68A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6A561FA8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE32C0334;
	Tue,  8 Jul 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="DYW1kgZX"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7F2153ED;
	Tue,  8 Jul 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965324; cv=fail; b=lHZm/UXYk59ALrVz8rfAn+IditXuJG8Te0tW2HyPrk5lhkaY1i/uxqpN2ooMqw1ShycWnke4fPQxt+DvMb+vzjW/yOnWzx7bXDu7sAIcmF9FiedgTGQ68NztQiU8nrmrRfNSEqBhpEW4YGoZ1lv9y08P7uotVXJQ+XthgnqDuv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965324; c=relaxed/simple;
	bh=16uP2nn0ozhDw2tAz+6/m25ObyWxW20XJy56JscOnXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrIqSabTZxYYsRjqivvqb3xdlnJ4Waxqxx/YWmMHxsKHdKG4eo6EQooWehCOeNdDmdJ8T2Ij5vMdfC9fGdGTpcD42S+ovTUoIcrxfSU8R/A1ZfynBYnurO5MrgxyNYP2NA2u23Dr1xLiuctO47s4MGWGRtaCpbDj2nDz5IOYiGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=DYW1kgZX; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSM89CvzG9hoZfOEjPbwLi1Q8N895vhmXuFMXP8SJJnPT051wT1APENlGV9lJAmFuQeASiuo3CmqmAnCofQ8a+beWG6we5/dycYtFmbyRmOMuqsbtzWlC7oeej1irDFxX/msNbBlxTkMXg/15jczDkW7sZKWHnnP9SFNc6P3qhv9xOhBlEDx48q1vJKKN9lLObBL3seQ+kAJgyqSAgTo9B3Epht2JZZ73DvpNQioiQN3y+WvGM+Z3W6EftEyK8bMe279Ks0Kr1YNQ2cEAG4jHqXj0AyuLTyWs3BoOGuLJNkueg1bD7EJ1At3TUBAXQeWJKWaqUu1JVyICFTLlaJ3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6X5IrxvQItO9fZwlwZWXnb1nBzvd3s4D/SjXqozyLE=;
 b=sPLlyrWdlGIgm2i8RnhiAAFiKmv+IQHcMayX5d/ABv0e/aYZxXg5ZrIZS6kQFfqTjQx4+YsNPusTlTvnUKTEexIhhOocu5JqUEThm59nYr3UsM1uzfZlN+gvtm50wczR5lUeOtKV5b1zw1pYDtzax2fxVW8wsFWlQugIpmW21fNZGrjt0LLEfzF4+u4XQczUcTZ18mrdmpCfVtc4uyPO1A3INEub5+jTcqxDtPrVIaI+ZvPjNJfcRVomvJKRfW5BW9udGeWY8E5MGFfCNaRAMaxu8YrOWsgeyfCI1kkobHsPg1gO5YUohqA3cDZ17sGzmo4t+NiHChs/nh4CE4cmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6X5IrxvQItO9fZwlwZWXnb1nBzvd3s4D/SjXqozyLE=;
 b=DYW1kgZXGI3GFpmY8/WiReoR6wPegywryqrbhvI9MGe1NRJviT/ijKXgVtwRYEXOD3HHK4d4y0WLq0R6gjIBDEsGhbq3lZmHXaSaePSmmHJf5+uOhsv3D3G3BAZ7/skAObWMeJRk47gb3EPLBUM1WU6mzqnAl1OQ8a/J3LX7pV4=
Received: from DUZPR01CA0344.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::9) by DB9PR02MB9851.eurprd02.prod.outlook.com
 (2603:10a6:10:461::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 09:01:58 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::e5) by DUZPR01CA0344.outlook.office365.com
 (2603:10a6:10:4b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 09:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 09:01:58 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 8 Jul
 2025 11:01:57 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v7 3/4] net: phy: bcm5481x: MII-Lite activation
Date: Tue, 8 Jul 2025 11:01:39 +0200
Message-ID: <20250708090140.61355-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708090140.61355-1-kamilh@axis.com>
References: <20250708090140.61355-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|DB9PR02MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: 464c63f0-3d11-4f88-7d61-08ddbdfe1837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|19092799006|7416014|376014|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUhmdE9tRGpleXVEbjczQlBWSWRzT1ZVWTgzLzdCNmxrbWE4WW5BRnkvR3Zq?=
 =?utf-8?B?V2F1aWdQRXI5UTluZjlJR1gvMHJwUmkzV0NVYzkrdUlVblZDdE9vK2RwLy9o?=
 =?utf-8?B?eUM2S1JqazYzVDB0MlZSSjUvRytWSEdSb2NvSlhrVXZsUlRBa2FJUU9IS0FO?=
 =?utf-8?B?b3VWN1lDRS9ONnoyOUdydkdZK1QwQTQ2cUFxa1RJVTBEdU9PbUFYaEJ6Q3o4?=
 =?utf-8?B?QUJrM245aDlWdXNTbGxzZUZManVjSWU5NzA0NjJQMVRJWlFIOVE3ZVVQNUhi?=
 =?utf-8?B?V0J1ZWswTDY1SFFxMzVuREhMY05XQ0g3YnRGTUxYNGRnczc3MU56SUhGN09J?=
 =?utf-8?B?VnJDOVRPajlidkxjUXZWUnhYSFd3VVFORGlEOWJhdHNBVFhTNWI0bUJrUTRZ?=
 =?utf-8?B?dkRiZktBNWw5NWd6Qm5RdG1mYVhrdS9DeWI2SDgrb3Jlam4wck02cGVSSjFh?=
 =?utf-8?B?OXQyZUFoZjNZTkNqMHVOcjQ3N1ZicXI1dklwcU9mNjZVNngvM2U0TFp6WG81?=
 =?utf-8?B?cmRNWmdjT2hvVFFGMGFJaWJ4V0RWaHZBd1Zxb2hLYW53N0U1U1YvcDVWcjkv?=
 =?utf-8?B?NytGVVY3QUtHUEt1OWw2L251dndwcnBNUERYTzRMTTJDL1o4VDg3Y0N2S3Fy?=
 =?utf-8?B?eUx5OXFleTlMem5jTlRwYlp5dURxUnR4eGRwNkNGbGVJQklraWtuVlU0SnMz?=
 =?utf-8?B?aTE3aGZacGUwL04yU0I4V1JYS3VJaml0ZzJtWE1pSnJHVGxOMVhTc2g1Ui9O?=
 =?utf-8?B?Z0wxYjl3MHZrbFhHVjFHOHlWM3E5TTE1TEcyc3d0ZGFYRUJCRWF6SFVpRW1i?=
 =?utf-8?B?N1hOMVN1eWVtYlQ3WnIyTC9vR2p4UzdET0s1T3czL3pMYzVZb2xmellMdmhj?=
 =?utf-8?B?Wi90cSsrREZQNVJHZis0Yk1VeXVNWmxGb3BvQWF4M2Y3dm1yLzZEejE0a2Jh?=
 =?utf-8?B?SThST0dtY1ZlVFNvQS9lc0RJbEc1eWs4amx0NDFxMkdUVlN4WGY4MjVwdVRI?=
 =?utf-8?B?SHg3M0hGdzZoS3hiT0pDSFQ5NXY2cFk1MmZ4OHk1S3d6MkdlZDRVZDl4L2k5?=
 =?utf-8?B?OEIzWGliSVZKd0h1b1dPZ2hrYzZOU0V0WEduSEdiQng3cmgzbXl0OWp4UGUz?=
 =?utf-8?B?aEJnMjZ1NGk5SEpCK3VVbUZqVmJzenovTSs0TWoyOVZZMjgzZTA3d2F2SjYr?=
 =?utf-8?B?YXY3ZmxtZXpKcURtYXVkZ3dYQ0k1S2RycUFwWEJpV0xOUXlUQnhrODhDRFRO?=
 =?utf-8?B?SjhtbHN2aS9MN3Fha3lJSXJJTmJmc1ZlV2tUWFBCR0dHTkdZTGZVakZXbGVY?=
 =?utf-8?B?VmZsTEt6TmJPYzVXMU9kN1lDRy84WVBGZDArZlBubm9iR1QzVENWVXYyL0Qr?=
 =?utf-8?B?bFo4WU5CanZoeDVIZ3pyN1pzVE1US0tQT2NlU0VqdUwzUGFYa1pYUjcyZ1ND?=
 =?utf-8?B?YnRPZmRmUFc0cEQvclUzc0M4bFV1MDNad0lJd1NmaGpieHoyZkNZZFVVK0ta?=
 =?utf-8?B?VmNJeWRZOTM3ZURtUFAwbUhsTk9hMSthcUFBRmhBQ0JzY3N0Vm1OQU5XQ2Qy?=
 =?utf-8?B?bGR3OFpKSFhqR3M5TDlZSmlPWk9sRDY1b05Bb1JmbGRVNWQwYUpZQWxFb0xv?=
 =?utf-8?B?amJVdm5aV01sUElUS1hranM2SkZCR3QyVDNSWEZ0amZzVmpDNU84TmhROERG?=
 =?utf-8?B?NDZ0REV6MnNDNFI0OVVOaWlQRm1NenNFdU1IYWRxSUptQzUxVlpTZW5yZ3la?=
 =?utf-8?B?VkFHRE56ZnA1UlhRM0tLa1BOcnBQYjlWK3ZCVnhvaHF0RU56eXFWVk1MVFJa?=
 =?utf-8?B?VkFNMW41K21Ea2drSThWaDRoeHFHOWpaeGJWZ0tYaFlHODRvcktjdFFvS0hx?=
 =?utf-8?B?alUxYVNLMkR5NjZMdGR0WXg4ZDRUaXlpRDgwQ0x5eldSQmlRbGtML3p3QnFT?=
 =?utf-8?B?SXViSlN1VXFCclhiT21PYzhKYVp2QS9aV04rVlBIVmJUOG1zSVpCWS9LVjYv?=
 =?utf-8?B?blV6WENaNW54SzlTVDBrY0F2cU5rKy9UZ0x1c2pEdnh6QXdUVWdCMWFFaCtK?=
 =?utf-8?B?MUNDN0lmVXJNdEJFMmdBNld5cWwyamorUmFpdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(19092799006)(7416014)(376014)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:01:58.1576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464c63f0-3d11-4f88-7d61-08ddbdfe1837
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9851

Broadcom PHYs featuring the BroadR-Reach two-wire link mode are usually
capable to operate in simplified MII mode, without TXER, RXER, CRS and
COL signals as defined for the MII. The absence of COL signal makes
half-duplex link modes impossible, however, the BroadR-Reach modes are
all full-duplex only.
Depending on the IC encapsulation, there exist MII-Lite-only PHYs such
as bcm54811 in MLP. The PHY itself is hardware-strapped to select among
multiple RGMII and MII-Lite modes, but the MII-Lite mode must be also
activated by software.

Add MII-Lite activation for bcm5481x PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/broadcom.c | 14 +++++++++++++-
 include/linux/brcmphy.h    |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 9b1de54fd483..8547983bd72f 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -407,7 +407,7 @@ static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
 static int bcm54811_config_init(struct phy_device *phydev)
 {
 	struct bcm54xx_phy_priv *priv = phydev->priv;
-	int err, reg;
+	int err, reg, exp_sync_ethernet;
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
 	if (!(phydev->dev_flags & PHY_BRCM_RX_REFCLK_UNUSED)) {
@@ -424,6 +424,18 @@ static int bcm54811_config_init(struct phy_device *phydev)
 	if (priv->brr_mode)
 		phydev->autoneg = 0;
 
+	/* Enable MII Lite (No TXER, RXER, CRS, COL) if configured */
+	if (phydev->interface == PHY_INTERFACE_MODE_MIILITE)
+		exp_sync_ethernet = BCM_EXP_SYNC_ETHERNET_MII_LITE;
+	else
+		exp_sync_ethernet = 0;
+
+	err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
+				 BCM_EXP_SYNC_ETHERNET_MII_LITE,
+				 exp_sync_ethernet);
+	if (err < 0)
+		return err;
+
 	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 }
 
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 028b3e00378e..15c35655f482 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -182,6 +182,12 @@
 #define BCM_LED_MULTICOLOR_ACT		0x9
 #define BCM_LED_MULTICOLOR_PROGRAM	0xa
 
+/*
+ * Broadcom Synchronous Ethernet Controls (expansion register 0x0E)
+ */
+#define BCM_EXP_SYNC_ETHERNET		(MII_BCM54XX_EXP_SEL_ER + 0x0E)
+#define BCM_EXP_SYNC_ETHERNET_MII_LITE	BIT(11)
+
 /*
  * BCM5482: Shadow registers
  * Shadow values go into bits [14:10] of register 0x1c to select a shadow
-- 
2.39.5


