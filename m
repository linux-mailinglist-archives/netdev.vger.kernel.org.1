Return-Path: <netdev+bounces-202446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67FDAEDFCC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4268E3B66D9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319028C005;
	Mon, 30 Jun 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IrW5ph0c"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74128B7EA;
	Mon, 30 Jun 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291941; cv=fail; b=hEME9u2/3q1Kox95cWd4k1V5+pmYJ9Is9WCLBHS31cAIvuooxakHI6NcYY/xtOBQnJP/xvoOG137kMkN6B0NYc9wRcnL6+k62NXaL7DW40dAexJpiExHa2mvJ+FQsTFUomqzxnpZRK2DZLZrLBKd6Ruvtut2whFbasCNBSM3nDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291941; c=relaxed/simple;
	bh=NcvAuScwKf4k9DVehdsie1SetQBKOo9OmyLYS3eIquY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kt+TlAVbKWO9lL5DzCvq9dJrSQyGAoYCyKuZFVQyE2fRRMMkURS0GDtGV24UspS11Vl6kFARgsUBDdOV9e7Qb7jTKl8UocoAJ3OTKFR5zvjMiUhTXJvCBKUFxHVgVpdflCUS4fXRcmeKGVEnuoCM6rPA43dYxeiGSpU5yTujXTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IrW5ph0c; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFdYrYBId8ZQ7deR0c84WU5C56mwMkNhAbrquXHc0YV7A67BqSlmQec8cRcmLyXIRO9k8DpM0U34vu84PzTnUxXaVO70kSeIwQ3vtnec1RA3deGNfwigBJwkHpa4A5OTJoKTaTIvV75PLGh81j3pJ6pBeAvgABYXkgOIoxSpuMg0CH/XCeyhv3/fx8Lo6T5B9N//BX8x7jJBtRmLg9y9mO4kWIh5cEC2Q0VWrG0KX8J9bmMq44R+A23L7fhgx/f2Ac/gpQbOLwgJdZWaDlGxmVytb1pjdV+e5DWfOWLt/G/ic1EtlAobslnUD8F2Q08MRIQhzNimzvTPUJ63/TI4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rocE4T0RwHkcDDJAiBjxAByskvGc+jdclVl1Q6awb7w=;
 b=pf4yJvXJnk3x3BJe5jv3vA6ORezlcVAJ8jY0hJYR5V4bZw51JLgK+T9wEKX/INDp8C4T6FFIpvx/sVpEe9PibREMCIs2bAsNUlYYx0yXRZ7yJYQe0hjt5HUYBP59SX49WA+15/BiqD0k1r6Hci+g7zAnr65JBhDFyo4YWKLH0NY3aFO/qWoMF5slE4O4TqZpaPu84DAMYjVZt5gzpGoSdzLPHZweXmb2WuNzGwENVGtXq8B1OsAUvqnayp0ecrAQee1HfrmLNjKBv2SQwwmtJsGcmtXv+1F6Nbzs4YAS1ceBJrKPm2g3adEBMQIfjYCXxVaE3ZjrMnQlAsiyR4F5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rocE4T0RwHkcDDJAiBjxAByskvGc+jdclVl1Q6awb7w=;
 b=IrW5ph0c66YntRvmR7mPzeP6OMf3clAFP48ESVMS6rvF9A9fyPfAguFhSWmFewIhzViyFN3b6ZT8WNjg0Nak9wLU0zhG3yA0hKx9qYYtQHFwcQS1aEj+dQqTMvPeWHHygheUUF7GqYIOSVln0Hv2d+jPKkMcPm9iZAFY1I01y+c=
Received: from DU6P191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::15)
 by AS2PR02MB9785.eurprd02.prod.outlook.com (2603:10a6:20b:60e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 30 Jun
 2025 13:58:56 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::be) by DU6P191CA0040.outlook.office365.com
 (2603:10a6:10:53f::15) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 13:58:55 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 15:58:54 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v4 3/4] net: phy: bcm5481x: MII-Lite activation
Date: Mon, 30 Jun 2025 15:58:36 +0200
Message-ID: <20250630135837.1173063-4-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|AS2PR02MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: 870eb034-d2e8-40d4-4eff-08ddb7de412a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|19092799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDVsS0x1UnN6Mk4zSDlUemdTVTVUQjF3WVk5WlU3bVBQRWtSOGN4WnhVWTlD?=
 =?utf-8?B?OEltdk1XUnlMMzNxOVNKQnh1SkJXdWVHQ3Y0VHBaZVY2WlpHSDc2aTcwZTBu?=
 =?utf-8?B?OVpUckZ2WnBmY0E4WmpVL1FRZktpSHhnZXh2ckNsWWcvMVFrVjZ4dEtVSkcy?=
 =?utf-8?B?a0JOYVUzcXpQQVRyTGtnQk5WUVY2N2FPcmVaSlNjcVZRMSsrOXE4NzR5WE5w?=
 =?utf-8?B?RHhwU0NSQTVNeTNDeUowbFN6b00rRTlSRmVINVR2WGora3JzVEJ4MFhlU212?=
 =?utf-8?B?eHlYc2RKVkZiUTFRYmdZaE5XWWVROExIcXRxVW04YTJ5QXJnbldHRGZQM09q?=
 =?utf-8?B?aDY1SzdBT3NqNFVlb3prWHlqWS9OaldHUWVsbDMveEdicFF4cGZjWFl5Si9H?=
 =?utf-8?B?bVNXYkVnOUZ6M2lhenBCdXoxaDlIeTdTTUlxRVN5REVvRFV5bGhJVUR0eE1k?=
 =?utf-8?B?dThjNTN1M2l1Y1RYWGNLcXd0dTNIK2dlZUNZRWxKWmRSbWNHNWZuZFQzRkFL?=
 =?utf-8?B?MmN3TUkvWDhZbkh4OEQ2SmtiR1QyZ2d2QnRjZk5QSFpHTjdYZnVKL0FHVlZk?=
 =?utf-8?B?ckdFMS9WL1kySnNrYXJldWY2aCtkbG5WL2x2OXBYbXA2TlA5aWZhK2Y5bU9O?=
 =?utf-8?B?Z2FSc0FLZkFPUEM1VW5KR2ZJa3NsazhtaHJ1WnRkNHlqK3RwRGpERjlFZjMv?=
 =?utf-8?B?R1VsZkJmZDZ3bVZ6OUNjYVd3SUN1TWZXbjkvK2ZtTURzT2diYk13N3FyMUIv?=
 =?utf-8?B?bDlJSC9tNU1HWEc1N21pQVlUVlRVUkxXM0lxU0d2bGdIMHROYlBuQWdlYnpp?=
 =?utf-8?B?RWpXcmFRUm15elV2TDJMNEdoSTNER3hZeDIyNThBYUVCcmdJWDV5eXVFTDBx?=
 =?utf-8?B?R0RsVW9LK1o2dzl2T0c2aUdUdVUzRDI1ZUtkOFlTcGZTdVltK3VCVUcrenV4?=
 =?utf-8?B?WUZpT3gwNitYVU1UWVBFSXdyVktQS0l2SmZMTnJoWkowQVR1TFRvdDlFc25o?=
 =?utf-8?B?TmlnSlRiWlVKM1ZPQi9FYTNBTEdPL0VSc0Z0aG9VV1poSmJjNmoxV0dSb0lr?=
 =?utf-8?B?eVUvUlVERS9GOG5Fa1F4RkZFWk1ULzI2R0U0UzZlRFVWNTd1cDdXREdyM24v?=
 =?utf-8?B?YUd0Z0pkc0FZbVFMaEg5dWNTY0JBeit3MTVzN0JLdTVaM0JnS084TlYxcmYx?=
 =?utf-8?B?Q1lrQUdKMkRRYjJBQThjaUYyaXI3SWZRTTlhbEZWZytOWTA2WDRWbHFkK0Q4?=
 =?utf-8?B?UTFvbmhiMS81OU1xUHI0aEFCN0JxN2ZBb1hBN0R6S0srMHhKZnNTaElldWl6?=
 =?utf-8?B?K0xPRkdUZTN1WVZiUHQ5M3dYaC9IY1JJMDE0RlFuQWxZR2l1QkJRak9xTGhr?=
 =?utf-8?B?ak01NUtFL1VSYU5MWG5zOTJLYjhyUWdjeERxcm1WVUZ6ZE1iRERKQmhaQTVo?=
 =?utf-8?B?T3NZdVhrZktqNzg3Yjd5blR1NzFhbmJDb3ErVUhZRnZRZGF2K1lNL1F1Rldm?=
 =?utf-8?B?ZjdhTnRJME1XV3FZL3RUVEdTQ0txZ1hoakJFcWkxODZ6N0NCYjAvRi9mWmg5?=
 =?utf-8?B?OXB2QS9LblFnaWxLMUZ0U2tQbzlISDh5YTZ6YnkwQ3lLVFYwNHZyTys5RENW?=
 =?utf-8?B?bXY3YWJlTkc1cnE1QjFjZUJDUFlWZTF5WWgybFE1Z1p2UEJqZDc2UlpPT0Iw?=
 =?utf-8?B?N3dYU08zQm14Wjdnck9pYW45M3ZzQjlmWDNwa1hRQW1FdUVkdHltQTl2aG9x?=
 =?utf-8?B?a3ptWjM1azF4OTUxN05uSzlNdWtua1JNUFh2NG5ESGVzbkNPWjJUd29IdUpj?=
 =?utf-8?B?bVVReWN2eEhDWGRxd09BaWJNZTI4YnBIYWNUSzdzZFg2RU5yZmlnRDBTSlJG?=
 =?utf-8?B?VnNyOGhDallGY2NnZmw3cU5EbUZhUmc4Y1A3SENOaGdRVUZwYmIyczFQTWVq?=
 =?utf-8?B?TE54OFU0Z0R1SDJ2QWFrWTN2ZGVGbVhZdjZFaE0zandIVjMvaW5tME9QZUFM?=
 =?utf-8?B?aGROUFBSZUhmVlFOLzJIZE85M2NxeGFCYWt2WjlxWGlBblhsTWRER2ZIRFF2?=
 =?utf-8?B?VTlXSGVzekl2L2VTTHJibWlkZHZ1TTBvaTlZQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(19092799006)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:58:55.9866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870eb034-d2e8-40d4-4eff-08ddb7de412a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9785

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

Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
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


