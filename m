Return-Path: <netdev+bounces-202788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7633FAEF021
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132853A7B06
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A208265CA2;
	Tue,  1 Jul 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="aSGQNoza"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B432620E8;
	Tue,  1 Jul 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356241; cv=fail; b=dGP7Jfj4GzXpaA2wLm/80mI38StMjkPbd6bywtEO+FGtV9zcLLn3iFfS8S/iipncWfX8EMNg8oHaxDLGaTdyRcaWvj+22JjFI0APjEAUvythjuDMX7pLkhxvzSaA8Io8GtCQu/6eJ856WJ2CDN4Q5I5lmFD9qwCS6jlcJD5YPPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356241; c=relaxed/simple;
	bh=wiavBSsHVxnjxiyFsBISmOdlNkKRY2jBRLJ2F21RWX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brMQfdYquovg/ebFzJ2L9K0RSBGIglMA+qsncdJFTXJbxh0V99dj2sxUQ0oO0AIs/o+ucebFucwgzYkpfq8IlD/vUdMWYPoKaOpWG7Cj+eLymr50+LHXo6K+GX+CArGGTesstZeCsSX5ND45n9tVFBqH6ZnOOY3NAqCixiPZsF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=aSGQNoza; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSz7cK0RPJjIS8Lnd9l0S4oK3sQwc+T9VR4/HDmkbGCvuE+zSBRypHxDG+63FndCvSyEsKZSufBWCVGZidMyufyHscFytn9RsIVJPtEvDeilnHufUynsfwmdjDlRZCJoueLgM5+Fm1pQ6DzXZRCkPSsJTFIddAxUQpsTXxUDfiCl7Mq7rYT4sBlbZjTF7kRhsD6Gtw52mVq4ID0/dRrtTUVMvLkfkU9p3+i4638dV2fST7HxBhtWgYuS5SQNQBByi4X3OS8iR1SQ6za24GCxOSRDdXO7Zch5+FSFTeE9fGt6e6fcyF9tn34e/V7v3KDVfnN/3aCBL9ZNaSpffc12jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqqJKLVK+iRN2eOJCTeewjp8WvXT6DArcDg7nGgvr2U=;
 b=D9v86bs8jWNvhI9Gg+ZqzslKfk+hyBuTkO167fcz4WsjYgRU7t0FFkKFmwJG/dLYBBuC71ZhVNsAUKRx82qG5Tysyv0AbZ8zZc5Y+Hnsp712MlUOSSuww4V+GrfSkqXl90Zd8YVw4kWOyEbNl4ieV1HR4aElC+YiQy4uL9+eUa4IPRmwgvknm1L+TrQFB63f1U7IX7bWiEw13cvsDPyNG19AngPWcMqUZIJkerQP+TFy/lkqIFYSO3hHZ3quWCuu0g4+Q7K/ImUFkIIaII6iD4r3lqswyLQVOcdTN5MgdhF8mP/WTaKu7FDpCIdBbgt5Fx30Qyz4SQwNBoFGN2l4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqqJKLVK+iRN2eOJCTeewjp8WvXT6DArcDg7nGgvr2U=;
 b=aSGQNozasI5YR4mdszzA50IVvCSPTkLpaO9FJomX/uhAMg552rhac5tGVCIS4abaDyoboFFN3S8p4TC+NbCjbE/E6opfg+kwuJU75w8z6FFm114NqPRkXjYjmhGAofnXy2qjzqcHEyy1Ef5/HqT/OhafoS7EtkAUDOSePsQoPvk=
Received: from AM4PR07CA0030.eurprd07.prod.outlook.com (2603:10a6:205:1::43)
 by PAXPR02MB8224.eurprd02.prod.outlook.com (2603:10a6:102:243::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 07:50:33 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:205:1:cafe::ec) by AM4PR07CA0030.outlook.office365.com
 (2603:10a6:205:1::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.13 via Frontend Transport; Tue,
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
 2025 09:50:31 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH net v5 3/4] net: phy: bcm5481x: MII-Lite activation
Date: Tue, 1 Jul 2025 09:50:14 +0200
Message-ID: <20250701075015.2601518-4-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|PAXPR02MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 541412d5-1d08-446f-4855-08ddb873f550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|19092799006|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2hBVCtLTWMwZjhUUk5hNElmcng3UnQxRUVZRnJqYitKb25JMXB4eVVQSGQ1?=
 =?utf-8?B?WDQ5MGtHU1grWURMa0NJUVRBY2NCRy9hNmFPbGk1UnNPdENKL1NuRWxuZlZr?=
 =?utf-8?B?bnR0UkJEaS90TWxUMkt4bGI4aldGTFBtRTBoejVKR0ZKc2daR05ZUVllcVRH?=
 =?utf-8?B?MDRldUtJdWdrakpjTHlaRGg0R0JWVlU4RDNZT05hMzF3MWJ6Sm9id0ltSVF0?=
 =?utf-8?B?UDV3b0Yzd0drWmc3NnJKaHJVWG5yaWdnckNxQk50RXUxWTN4ZEgwMEZob3Ro?=
 =?utf-8?B?TW1hdXFHTlFGZzFIMFNzSkxyUFhsK203SjdDNnE4bVhrQmcxS016Vi8rQjUr?=
 =?utf-8?B?MjcrSnY4TVFqZkZXRC9waDJudXpLQWFVVm00cXkveW8rbTRaTk80T2l3Q0lu?=
 =?utf-8?B?NUkvUlVlZVlVd1lTRWZBRmpzT2w3Y0U5dS9LQ1JWeER6U2NCUTVKNG4zaUw5?=
 =?utf-8?B?VkpQVEI2UDNhSTF6SnBKdlZRZEF0VzRwRU9FaXBLWStKTmQyOTlid1hMeFpJ?=
 =?utf-8?B?MElUTDlXaVorZnRTR1NWT0JMdHA4YVZudjJJTnlPZ2FDcXVxVU9MeWRYQTFK?=
 =?utf-8?B?VTBhUmNVZ2MrUVgxRFVNdkxuZmxOY1RKYVNEQmcxNHAxU0EzQW53V1dHM053?=
 =?utf-8?B?OEp5TDV1OUNwOUMrRkF2WjJYdTZKZWdBNXF5OSswdXRxNmlzd0FmcElTVXlt?=
 =?utf-8?B?cDNGQmFYL3dqNXd0QzF2MExSZ21tQUFJbmRObStpVEJudmt1emFMcW9zUUZG?=
 =?utf-8?B?WG1DQjkvRjVtblNUMzlJN2JJS1dWT1FCYWhVbGFkdUFvempjeFA1c1FhNjhD?=
 =?utf-8?B?Q3g5cldNSnh5MWN0L1YxNTNhYXZvZWFyeXo1QTFDN29wVldFSGt0cElPTFg2?=
 =?utf-8?B?TGMwSXd0OHlrb2VMZ1JkZXg2OXN1MFJTc2daQnVPVzlqYzc1TFFhVzZ3WE84?=
 =?utf-8?B?a05UUitZRmRuY1JQc1hWMlZFYzkvYkYxWDRsY3lYMFo0Vnd4MkJnUXdWZ2xD?=
 =?utf-8?B?L0oxREtVR3hINDJXN1pLRlR3U0tzSzRVNmZTRTlkYVg3S0JqOUFrVDJEdHFD?=
 =?utf-8?B?cjlMSTREMjhnL2tuT2FpSHFDdDQ4UU9uWXFpSFB2M3E5emVYek9PY1dGYmE1?=
 =?utf-8?B?a0s5cFF5RVNtRzV0M0UzbkhtOUxZOWFET2FwcEF2eFpwVFdLaForZi9FY0d4?=
 =?utf-8?B?S1RHdVNJeUw1TU53dmsrUGFXeEZJUjJZM05NR3hqN1FVUzg1R3VxY3ZmWXV6?=
 =?utf-8?B?MmJSUEtVUFduYXY2SmZZS20xbjZpclVPcEt5clY5MFRPallMZHQwSVpoVng5?=
 =?utf-8?B?QVFTNVhVejVXU1JHWTlFUDBVbllnNHY2MFJKSVozbTNaTFFxYWIvYUZVMFNB?=
 =?utf-8?B?d0JoYkt3Z1NrQWhwU1lBcFhMRVJhamwvVkVZOWV2dEhJcTRTM0ZkVHMyS0cy?=
 =?utf-8?B?T0RSdWFuVWloM0x3MmxHNUd2d09TZ3djME8rTStKU1FVbGJZWFNXNCtZb00w?=
 =?utf-8?B?bHpQbForeG5CK01WemY5MnhXVEtGbWtydHJxYmU5R3lUOFVsNUlKVXU1WDZH?=
 =?utf-8?B?N0U4UlpzQktyYzJtNjEzdm5weE1rSHJpYXVrRklQeVorRWxvQVprNVYyaFZQ?=
 =?utf-8?B?OVZYQnljU0d6WGJ6VEYvcWZYUHpLMU93Nks1UnJ1S0xPb2dJbG04c3N2UGh3?=
 =?utf-8?B?VFAvMmQwbVdDQ010Y2lPRWpLYnE0bzhDQlc3ZnY0eGZ3SGFnTW5yREpXcmxC?=
 =?utf-8?B?TVcyV0puTFEyVG1Ma1lqYmxwSUxZb0FtWThuK05tcE9walZCdW1PdzlaR2hn?=
 =?utf-8?B?MVl2MHhuTVBPMzR2djRWREF5QnBKbXFtRm1JUnZKZWo1STR3eHkwRjBaT2lW?=
 =?utf-8?B?bVZQMk9VcndMUTJFOFBPT3Y4Q0ZFSFJQVjRWOW43VHA0SCtvRTlkMklKY3ZC?=
 =?utf-8?B?SFViM1U5MStUOXFsWjJoMk1oSW80RVRrUldORUo2ZVIyeWNaZ3FCOVEzZGVD?=
 =?utf-8?B?c1E1VFdYUUxobGlpUWFlQm5wWGRPdVErTHhrSnZuUnJISE5lblF0SjFKNlZw?=
 =?utf-8?B?YlJDV0ZwNno3eVdNRlZiQlpHUlpWNFlGT0NjQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(19092799006)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 07:50:33.2497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 541412d5-1d08-446f-4855-08ddb873f550
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB8224

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


