Return-Path: <netdev+bounces-202387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66163AEDB08
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86DC17874F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916025F98A;
	Mon, 30 Jun 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ozrfL0vl"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24225F784;
	Mon, 30 Jun 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283064; cv=fail; b=cFDesSj1aV0RX4Ccg1ad4488rycFfynEdQkac3xeQYr/ADuUDxQtwZ3oYkBaOlQX5pRPPHGJ8seOEN7XvH1cmJ8EQfteuldxJmiIPmQFBTkWLPHYIkTExY/XFIzKd+750gDMI7OwHJ47wsQ5EP9WxQTIrRtfRDGhQfI6VK2MlB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283064; c=relaxed/simple;
	bh=LRKmZbxzE6+uGkv6VXMmid8DCus5WheNVsic6sNB6sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az06sLbF5X54JPVtx+onqCcO14Ec334P8jzxS5YxJGpEB0M4qqzS/Hs71MmjXDn58ocLpDk7h2M2iN/TzYU0oOqcJy+LJLW55dIWwymS/1aOYrAD60DGrc2wdv2aEoaBoyOodNgUZx2CzNhLgh7GddWdMB6u7N4Wl+2o/Z0FWRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ozrfL0vl; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKGqvcNFAdKDmb5QikLRgvUKIdyvOpJup0qaBSjhZ3VkTzixbYc5o778efsHAsqnaIsZFGf2j8RUJcXhaBggIMeCg0rsRPMuRDJj32OaNBnNu4O4Bz7hv7JDbpX2jYzwPoCL8nDznL3xOk2FDXNS20NCNrFYmvGg8XLnWAAMbIbl3JfZySgYccGBjb9MBPk5fbgAkW0YThx2FMERLRRQ1lmEKnEJBquGOvepae2Szt7+LeXXjJ6ZAXPbBgB5lKGG6jMU4fNYx6IZQDIQdtwHUhTVmTikZiOCZQHsNo2kPgjHUhxBpzHVf0M/BJlU+LedPTwzdPnMEWqrdzHorNzTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvLIVsaY/5slKUog2jDLMFrqyCAw/YsKqC3/XTUkW9w=;
 b=FFxCUxpO/lu30cPcGjyr2TftjKMfNk+Fiaw8qONMvQMOskupckCEDS9V/Lq2vgxFVEp4TP2mao4DFWBhQr5wLss7CBmx0Xh/ZUuzSoDhUNTvqXDSvDF89PO3kHAlGAEEw4C0LsP7Ny/hhKSvlPQeja34eeuafDxSFf0Akoj1OPKFc30IkxPmzp0aYdGDZcHDPrCrXwr451MCo5UM08/ospOL6L+a4nF3uDHmh2H0GpAdAs5nhz/6sbVHbKWlAehMsLTayRZ0LNuQ6hEc/1Lwl9YgfPlpFE4Co1M8Bl+M/R4Wd4utgxFHidJOqPESggPuBCB02eLmY96kjEnWZ/3ytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvLIVsaY/5slKUog2jDLMFrqyCAw/YsKqC3/XTUkW9w=;
 b=ozrfL0vlbXwM4egCyeOlGUFzWd0Lpy064wDjdMso6binC6FfAdxve3/1RqPu/H4xH/BdyBZgVD2dgvM/3K/flnD0l9QD2oocerSwuTh4Kqw3bPCLFqX14tlp3wCsZdsLJcTFwCyPzeKS4g2s9jlnc47dZ7IMgw4OEKRbjsqWp3s=
Received: from CWLP265CA0427.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::14)
 by DU5PR02MB10727.eurprd02.prod.outlook.com (2603:10a6:10:520::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 30 Jun
 2025 11:30:58 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:400:1d7:cafe::1) by CWLP265CA0427.outlook.office365.com
 (2603:10a6:400:1d7::14) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 11:30:57 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 13:30:55 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v3 3/4] net: phy: bcm5481x: MII-Lite activation
Date: Mon, 30 Jun 2025 13:30:32 +0200
Message-ID: <20250630113033.978455-4-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|DU5PR02MB10727:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c7ec2a-c477-420a-6c50-08ddb7c99574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|19092799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajBYUHI1eXNSTExoTVZXTzl1eHp4Yng1SmlDSmlYekhBank0Q1NMc0NsODNv?=
 =?utf-8?B?a2FhdGE3WklHamx3L3EzWW9BQXZocFBlRFZQTC9hcUtxS25CR2V4WEc3SEtk?=
 =?utf-8?B?QWswVGV5ZWMvaGVISnRXSlRZa1lmL01ad2g3ODJId3paRGUra1RQM1N6MGV3?=
 =?utf-8?B?dzRTemV0cERIWmNRQ2xxdXNqT0xWaDhsdTg2R3ozd29vV1VWK3JIVU1PL2pS?=
 =?utf-8?B?UFNXbzJkZ25SZUtwcUhFaHlVR0VvV3FSbFR3UHU5OU4vUmlXeXA0dWJmdkxr?=
 =?utf-8?B?SkZtQkZXZkVTczZtMkxCSHpOZW9ObEJPQW5SanRwd0xyK09YMTdOQ21VTW1N?=
 =?utf-8?B?c2VrUlZuY0VwMXE3VE9ncktaUm1yVlJ2VjNFbzFCRnNYcEJ5QmdkenIzRGFI?=
 =?utf-8?B?c0NvNHljMnBkVE5pY2s4aDRWV0h1ZGgvVUpxVVBnN1ZZRSt0SUlNaTBNcDc4?=
 =?utf-8?B?Y3VPQ1RRZnpmTVhXdmtMc0lCMTcrUnVBaWZHYVJJZDZDNGdpWDNwdlRKcVF4?=
 =?utf-8?B?Q2Q4R0pkd3BwZ2hKYkNTY2hSWDd2aU16OFdDeDN0dk1ydTFTbjNBSUh5SE9D?=
 =?utf-8?B?c1BZTmN6MkxNME9Sc0wvOFRYVXRVNTJXbjhCemZZdUh0S2xjK2IrT2FNWnZh?=
 =?utf-8?B?eDEzQVlndzZ3UU9zb1ZMYWZKa3NtY1hqbGJOaUxySG1EbXorM1dCT29URklO?=
 =?utf-8?B?TWVmckNzZ2NLS2h5RmZlZGt6WERUbmVPYlUwZHV2YWdkand6VWJkVmFQcjJ6?=
 =?utf-8?B?UzhwRlJUVFIzMVlkUFR1MFc2YXpDY0ZjaWt1Y04xL1ZpeGFGUHdycFN5MThS?=
 =?utf-8?B?YkFxWnRlT0thYTZWc0UrMkJZM29NUWlicVZLTkdGenN2ZFZiSFV3N1JhdXZt?=
 =?utf-8?B?T3ZCWVNWeGNqblJoQkJKdmdzQ2Ryb3M5Z2hoRG4xQXJZZ01NVGRXQWF5bW90?=
 =?utf-8?B?bHFpSlNtdFJvcDUrNU45R1VVd3BvM1d1WnZhS21ldHFQYU1VRTRaY0RKN2ps?=
 =?utf-8?B?RmpEVG1rc3BVdFZOQ1I0Zm5Sa2xXNWtnUktLR1ZJd2VtejVDblRhSm9ML2dX?=
 =?utf-8?B?bk52VHdpVnI4cmc4VVlLcURBTUk2QnhlSjY0VEVQekFhU2lTaUlOUzYzK0Fh?=
 =?utf-8?B?OUxEcGdCa1lYTkdjdTA4ZFZrcHJpbm1JYVBOZTRTemdnelBIOVdQRDlldXZx?=
 =?utf-8?B?M3o1Q0FuaUV4SDBBb0tSN1UySDRNYy93cTVQdlF6VkpFK2lVWWl3KzA4RmNp?=
 =?utf-8?B?N2szajYyVWlCaVp1eUh3aDNBNkpGRm1aWEgvNVg3eWpRS3ovR2pYVG1RVVhU?=
 =?utf-8?B?ZVA2dTFhRUdINDRDMEEwTGFjbWFpTkxKcVJEZHl3RS9Mb3IxdEIvVGQ3WkpB?=
 =?utf-8?B?SDhPNm5qZDdESEhRckpUTFg2YTZNMGZFSCt3QS9PV3YyMktpVlVFQVM1ak1H?=
 =?utf-8?B?amhkVXYxTXh4YXRob0JJbVE3bkYvbGY1MzdOeDIraTFab1NWdWMvNTBxd3Ra?=
 =?utf-8?B?STBmdnZLcWI0WlJ3OURRTnVlb016Qzg2M2loWmUvcTcwWE03Nmg3WnhSWFBo?=
 =?utf-8?B?SXFkbmxCK1pIZnhJKy9GOXh0N0dQS0VEcGpvYVpHZ1YwK2tGNXNMbFlJSURL?=
 =?utf-8?B?VTBrWHYrV3hDaEo3MmVIdWVGQnJYZENWaVBTK0hmaWF6TnM5c2lQUEE2MjVj?=
 =?utf-8?B?alpNZkF0Rks0VnBWTEF3Nmtrc3V6Nklaa01meHA2bUg5Q0ZJczZBQWxwY0tD?=
 =?utf-8?B?eHVMSU4vcU1OdS9jN2FkY3cxTDZUM0RxS0lzQmk4ZnQ3R3hGd1lwQ2hEQVEv?=
 =?utf-8?B?LzJRVVJnTUhkQU9zYi9iWTk4dGxCdEkvaTVXL3Zta0pqYkNwbnFQdmk4RWx6?=
 =?utf-8?B?SGpSUWJrK2lESmZVbkcxOWU0K1RMRlpFV2h4THVQelRDNzZXRU1lZVZlS0Zo?=
 =?utf-8?B?OVVlY01ZU1pZZjlpUUQ1eEh4MHVnRk9GUElaU0VlZVdLbE50Mkl2NE54blNt?=
 =?utf-8?B?cFFqSjVOcnlSVHZ2ZHZTbFdEK2R2YUk4SHNtclQxSHZJTllLdHAwQ3FJRGRm?=
 =?utf-8?B?NWRjei94NThXSFJFbVY1bmh0T1dUWjlCb3NQdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(19092799006)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:30:57.9806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c7ec2a-c477-420a-6c50-08ddb7c99574
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10727

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


