Return-Path: <netdev+bounces-228370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22937BC9162
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6963B5078
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8212E339B;
	Thu,  9 Oct 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OuLWFWYV"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC42E264C
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013689; cv=fail; b=RftXe9fo78z/eTPsz6ohFq3vKtBrkugdCUQ+Jm/bUlHUgRpFPESaw3y9oojXnwG06T7PezxqUSKexquaGZjKUPa1ahocWU2y/m5p94AJqJmh6k1SLJH/ICFJIPXLHoY4ALSI5iiJ0mAzdoTYas2qfmw4KzdDsla1ZqMfYVzqnKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013689; c=relaxed/simple;
	bh=YeUGhJcC0y3bC6sV/BcoOW2H+TGJ7BAylwpYDRLrKcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBtOQ3BQrjqtJvVAOIu5xVupyHwqHlRBh9kUDs6zXZS6dE1OpSKM3fYit+uqxHx3jYP1Tn3l1pA0Wi2/7yR29s6kYfLOLnXOXhfvBQqSv1T08f2rWJnXZdw8AzzI3Af6O/Kfc6lWMmAADZ3kFSfam3fJkyawbz0vE/DSgNqQims=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OuLWFWYV; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4agymAMsjA7YD5gpjalhUdqtVOpIbTA1Z1FIrwcflHzIZOy6K9hIyXdy77q9ev+/682TC4Rl6ONuUFcodYy4LfhynwXs04+Wz7dk8UNGK0jesgVwsQ3gSp4wg6DxmitIaIqVzUFVcEin7RzrbcKl4oTpEYFJKerUDIK7NAF0dt3HFTMLQbKlhsUXUBfasTEP2E/DHb53JW0YhiOWcteRLEY/SjUZNMOYcF+8JBoSD8F1h80zDvChCgpoelRggSRfT5KL5BNgYvS8VNTfkjYn/NXuTFNQbieSAY8w9QUaVJenc5TthF7S8QBavokYjwUeeRZ9C7Bwslnid9/RJUDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml59bA3NFIOPEVfD00uIpfx0VY9Wns1e+rfRwrRwXqE=;
 b=rWakpmCVQPxskODzwWcbuwECYx05p6CVmxBSAu7rrVvlrUsrIFJTPJGG22qXQn2UeB7yfueEzDSagg4kLg0f5+j/TNl82fmEYu4Abrx0thwy5nD0qC+4zryMbEo5wynwkw85UE4UwhvgJDOrB64txoCA+agu9xYsx0ltfHkOoFJTuQiAQ/rviIWWdgaqAHGSx+iTARPVR1rODfqXiYPo+5ZWnYneZV7fmIGSVjU3N+0jmnRD0pGGpvF/rfjv6Vd8zaFwgu8zfFeIjd20jSkxYsfzDOFf5w3Suzy8IHdKByU6HK3IpGA34/VqFibdt1/5OdA9jGQ9Y1UBzwEY5mw3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml59bA3NFIOPEVfD00uIpfx0VY9Wns1e+rfRwrRwXqE=;
 b=OuLWFWYViA05cja3Umvm1XNlNWzvbBfEjdir5DfMGv5Gw1NYX8GTsiJGbCGBhlCNS/cOi1xXaDZyukitJQigY+vMcMO4CITXrcBp4f9/y1edZ0drHzoEmZ9oSxqBL5a9GxzoYXE0SpWcwNhM7LFKxokKAz6KSlWk9ELQKQR4xUg=
Received: from CWLP265CA0371.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5e::23)
 by GV4PR02MB11350.eurprd02.prod.outlook.com (2603:10a6:150:29e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 12:41:21 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:401:5e:cafe::8a) by CWLP265CA0371.outlook.office365.com
 (2603:10a6:401:5e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 12:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 12:41:20 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 9 Oct
 2025 14:41:19 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 1/1] net: phy: bcm54811: Fix GMII/MII/MII-Lite selection
Date: Thu, 9 Oct 2025 14:40:51 +0200
Message-ID: <20251009124051.1291261-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009124051.1291261-1-kamilh@axis.com>
References: <20251009124051.1291261-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|GV4PR02MB11350:EE_
X-MS-Office365-Filtering-Correlation-Id: a114e888-17f6-4b85-58b2-08de07312605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVMrUGpBcjhkS3p1dmNrRzQ1QUFKSExrakRSVlQ2YXlOTUFhTUkzWnA4MWZW?=
 =?utf-8?B?S1JOU05oamYyQm5RVVQ1dVp5dVRSVE1OdTNobjNJU0hTYWREV0Fpd0orV2Ew?=
 =?utf-8?B?aGVFZktRbTkwYzdxZW83SkZFeFFPQVdaUHBXSEN2Q3JRb3hTTUNISk14ZlJq?=
 =?utf-8?B?b014cFVkRkc0WG5oTXA3U2twQmhyVHUrVG9SYXp4L084QTFwczh5c1p3MUVv?=
 =?utf-8?B?ckIxN2RVMU9OZFVxbzlOR0RaLzNVSThNSzN0dnF6Zk0zaUVBZ0NhdXMyMFFa?=
 =?utf-8?B?QUVSTGM2TXlNdnl3SFVmTVVWMFNMcG1OS0kwd2UxdHNMd0pwR0M4UUtMNXhs?=
 =?utf-8?B?ZElOcDdsUXQ1T0o2enRHdHF4bjlDbElBUVlPanVpc0hENXhaalN5Rlh0Yzdr?=
 =?utf-8?B?OHduUUxMV1l0YlRXNWlpbGZFblE3VTN4ak1GYk05R0RTaDdhSm5UamMxYnJm?=
 =?utf-8?B?MFljMkM0VzhieVd0WXA4VnlEZE8wWnpNMjZEazBMWHBoZ0tSRk84aU0rOGRN?=
 =?utf-8?B?YlMyODJ2Q2lLK2pZVkV2c0hDN3I1emliZzYvbkt3MCtYb2FYZ0o4OGs3bHNk?=
 =?utf-8?B?SDhMRTJUdWsvdkxhT2tGYUJ3RnZvVXZ1YUwyUWtRVVBxWkNGeU1jWEN0ZVk3?=
 =?utf-8?B?RFNrK2FXaEN1dmwzemJ3UmFnSGhCM29WRWFDQkNFUC85NC9PdWhoWURHWHlr?=
 =?utf-8?B?Tjk3Vk1PQTYrN05yckhjM0U3Qi8rakhRcTl1aXo5UmdvSy8yUFhza0krMzli?=
 =?utf-8?B?am0xclZQbk44WFhiQ0ZCcUtKcSszaTJhcTRid2ZaaEJHenJzK0RiSW5ySUVi?=
 =?utf-8?B?M3NIU1pCN0VmWHF1eU00UWFVSXdYQ3JrT0ZRMU1rYzZpY2x6UXlHYkMxRHNR?=
 =?utf-8?B?T0hJVGFKVytaRzZGWjZHbWxPZnpYODB4SmFOeTVWamk3SEFiMzV1TzlJQXk2?=
 =?utf-8?B?ZUhVTkRLVUk1YTlJKzFQb2oxTlAzb2RPRnVIcXBCT1lpaVpYbnBxaHRjRTFS?=
 =?utf-8?B?aUM5UG4rcVV3YXZwL3NTMkd4RUhRdytMTzVOOXhhSllPUmI1T1MxQ0ZrUlpU?=
 =?utf-8?B?K053TUZyTWhqZlFXbVg0OHUwYlY3NmE5SjdLa3FqNUdSWDRPMTNKa3RzSTNT?=
 =?utf-8?B?Zno4ZmV2a3BkelN0cHViME55YU0xaXJYWGFYbGNDRE9abVAzWlhCSmlyQzYv?=
 =?utf-8?B?UjFBKzlSWUV4aUx1dUd3SlRmU0llWitEOXYyUnE1TmRnYjNhbFZzVm11V1V3?=
 =?utf-8?B?aTk3b2ZKdVhWcWJaK1p3clJYb3ZMSEVIbGVrbk1wOS9rL2NocWdwbk9GV05h?=
 =?utf-8?B?My9HWFN6MDZUOWNaRGVrQllva1V5d21WV01KWnJXNE9nN2hQTkVZbmdHRVY0?=
 =?utf-8?B?RXpHdlNCZ2FOVkxXSW5KeWNqSmUxTCtyemVCNVR3ZTZYUm9qR0pIWURtKzZh?=
 =?utf-8?B?UTFYVWxpeC9nemRxODUxVm1Fd2JHY21jNWV4bGphUTU2cnV1d3hKR01wMFhT?=
 =?utf-8?B?K0JnK0lOUE9UR215MG4yem9Oc2VKcUZFVzhEdmZHM2RRNlVtR0NLYXdnOS8w?=
 =?utf-8?B?eXhONTVEdlBtTUxsTnRvV3RKWG8vNFdHTWVLYWhQdUdNS0RjNER6T2VkbkpO?=
 =?utf-8?B?U2c3VjFMYUx1aks1NHlkdHQzU2tzUSs5YndIK296c3owZjBVUFVQZTYwU1BV?=
 =?utf-8?B?OUtDNVZkMGFmUlhlb2hxcUpNVElaODFUYURoYjVXNkNzMTBEdUJMZFFzRmJi?=
 =?utf-8?B?RjJwVzZqK1dEYzAyYVg2ZHg3bGlBMHlJVE1MeEQyOXdTbURvbHVzaU1iSUV4?=
 =?utf-8?B?S1BLRHNQek5ueU5yOUdJYi8vNFM3OHBGcUhUN0pUYjBuYkNkc2J0REJ6SnZ4?=
 =?utf-8?B?QlRzdDB4TXcvUlFod0o2V1BOajE2NFRpRDg1Uk1xd29rWlVxMlR1WWlyN3Vi?=
 =?utf-8?B?U3lRWlZYM0xWVmJveVRhTnA5V1NDOFpsNHdhejUzVS9Qb2piOVVmRUMwbjdQ?=
 =?utf-8?B?NG12UXhMa1dmSTU1UDBsK2l5WVNvb3FwbkdDRE83Y21OUU5FZFdaOWhxMXB2?=
 =?utf-8?B?c3M0SmZNdjlpUWVqZ1lWSlBpU0d6SGRmcWdSQzU1K1FJcWtyOTBHREZHUkZI?=
 =?utf-8?Q?26Rg=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:41:20.5426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a114e888-17f6-4b85-58b2-08de07312605
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR02MB11350

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


