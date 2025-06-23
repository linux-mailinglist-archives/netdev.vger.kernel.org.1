Return-Path: <netdev+bounces-200318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73969AE480A
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC2E7AD089
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CA27A444;
	Mon, 23 Jun 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="g+njIIYm"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012035.outbound.protection.outlook.com [52.101.71.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C72417F2;
	Mon, 23 Jun 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691502; cv=fail; b=EC6KNdgVxQtY57fIAQalu7p8qUXk9PwMAsMmnEJwZAbtSVO09zj9sc4o2j978w0pcq/k4xaAAIAmyF8dQc3Q4TgK+A8CkDjjzLPTxTJoPwvXQf7DlAQJxyCCyzq1RYR92S3nH7ZJ6jOi5iNi1yX/srWIeGttWvmuhCwbhaoRD0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691502; c=relaxed/simple;
	bh=g+XjNGYmyyulr+bLKIBVTDQTv9L/WbmSb/+VEueDoOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJte54o+8ZwKdC4LetKo0leZYzrXeu8IGY+1hlpp9CTQfZO5JPK5DGXbhXLEwxzC2OeoZ/TTYnqTG0OYVfS7UEV8qL+4GaybpiIGPnOJ6+JSKsluqcxxp+16jXtZmRKQTZlzUGIoUsQyYW5g67jOSyei9fNZMnTJ5DnsAiO97io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=g+njIIYm; arc=fail smtp.client-ip=52.101.71.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6dRmT6+kvMlt9AWcbEqxaJEmxCBjMo8WpYcHAWX4r0Pbt23MTyFSDdmSABZao8S9dA7nnAU2CYV5O6r09JDpwNzsQdBcCUcAnYxOu+wIFnqeII5axdHAe9Jypc27B8CX8utkACzGdm/Z3eVMMQebGvBkvWFrQVy+rL1Fct4l+jiD5amf4h7XEtq8K8YklpZTjmZWk659jTFLBWjfeX4qdJE1/em6GYJ6e7xdLOVC09fylPTIRMKQ0VlwdqZ0nUoYeWPw2bGIh6ZPb5Zw4QMaDjtMyWh//4nRijKAigT/rE6h/RfQ5emZOlYwK2u6JkjggSovFT8oGIZ9o87KNxTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyet8LSZEN+7vJT6jpZ1CEgClsQf1pCsANvkaasyVVE=;
 b=o7+Vbr/zOuJGY/BYEJllGKQbd+WpOIlEePpcAZc3qvobLd1XFOb2+Hpd5QfNj0Ltyovca/sGtbdW5EgWN+jSScTsLPg7FWfK1bMc36FT4WjhW4w8uNhux9RibW/sN+pWnfk5GyKKpD7kOtD/vC9RTv58cdzFACteCTwqvBhbcTKcC51BqFtQWLqFfWLZFNYTMoxqgb9y1WS3iYAZ4tzau2BReVfbc3qdFdWav6iIjHGAFstw7Zd9T99jnWatoOweCfHqj/TDNzH/2BRpzTVyofdnlLKFZixalLpZcvZyrEHBdiqIzyM/mpNWTvUs+IvY0OJvLHhQw9yxf3vNqSzhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyet8LSZEN+7vJT6jpZ1CEgClsQf1pCsANvkaasyVVE=;
 b=g+njIIYmZAKxiZwJH/xIhqfTmt3FtQKguFm0jPnu0Hc4PnmMs4n6X6layHawrq0oRR/6gDIYDMq75+XZVbuck15QrqXPNmUCqtEAKSIGUflJRhSrdZRQCE6X0y5DSRVqu4GoqdqQV4JJIQOI0Z/gDTQduxX8K7OfgXVjQ7kKnJ4=
Received: from DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) by DB9PR02MB9777.eurprd02.prod.outlook.com
 (2603:10a6:10:459::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 15:11:33 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::e2) by DUZPR01CA0022.outlook.office365.com
 (2603:10a6:10:46b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 15:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 15:11:33 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 23 Jun
 2025 17:11:32 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: [PATCH net-next v2 2/3] net: phy: bcm5481x: Implement MII-Lite mode
Date: Mon, 23 Jun 2025 17:10:46 +0200
Message-ID: <20250623151048.2391730-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623151048.2391730-1-kamilh@axis.com>
References: <20250623151048.2391730-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|DB9PR02MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8869d2-423b-4652-7c88-08ddb2683d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enZ3aTkrWXRaVXBlQWV3V3hXNGZ3QzlPV2JMZDBZZDVoaVdZUkNhOG56Wisz?=
 =?utf-8?B?aWRWY3pvb3VGRmFsOVlhTkU5QjlOUFFnc1R0TXE5RGlsSFJYa3g3NkJveklu?=
 =?utf-8?B?TkZteS9VeXVuTTlnWCtFeHQ4WDNvY1JRN1BxbHdwQWV3Y0RUb1J5eC8xVVhv?=
 =?utf-8?B?Q09HblVqWUlPcjl1bjZmaFJJS3lMNWJXeVZrYWt0NW5QRDUzZGc1WHhvcEJt?=
 =?utf-8?B?VDFUbUtnZW1lNEo2MHRYSEhDZkZCVXpXNlgvanNDeVdpRDd5Y243S3dkaFdu?=
 =?utf-8?B?L3dVVmpBaVBGK3J6ZitxRGpyVVA1TG9zalNVSTFnY1Bqa2ZzU3hzREJVVjBU?=
 =?utf-8?B?aVROUml0RE52emU2QjIxRWQ1UTBFR215M1lpWlJ2VVBDODZRNmc3MU9yaVJz?=
 =?utf-8?B?OC9PbytLaE9NZlVaS0FSRlY3QjMrTHZKZEpLVHJ0MTJOR1V0eUZhYWRzdndz?=
 =?utf-8?B?RHA1ekExeEhKM3lDdkZxN3c1ZnNjZUJ4WTBNeFJtalVSL3p5T3VXRHU4Njh6?=
 =?utf-8?B?QVB4OEFWdGd2UVIyVG9uRks5M3NDaGQ3cmNqbmk0cHk3L0JLZ2dVVXVzYTg0?=
 =?utf-8?B?QmNrRHIvR2haQTVzNlN6bTBsU3plbEhpOElPd3daNHNaY2sxbmZkbjFSei9T?=
 =?utf-8?B?RVVNSGhqZncxQnRDdDdKV2RVMUtOTk5UaW1IVGpwWi9tQndoMU40SThRREoz?=
 =?utf-8?B?MHZCZUo2UW05UEhqdkRrcXByNkx1SjN5eFBaSURyeG4xNHpvKzAxWGhlanRx?=
 =?utf-8?B?Snc4L1Z2Zk1iQmVydXAzR2xZUWdyNU1yWHhZM1gwOWpmSmFWNkxzMGVmMlhW?=
 =?utf-8?B?Y0RKRU9Ha0s0TWVDTmV1NzUxTEZlTHd1ejMvOEVzUFR6MGN3ajVISVA5dVBo?=
 =?utf-8?B?bVo3aTYzVllzUjVhS0FFVEZjOFdPekRweGk2RmtNYjVtUGlnSzhiUVNYaXIr?=
 =?utf-8?B?QU95bnBGTXhPbExndHhBTEhYVXcwY0tqQU0yeENDRWU1VW95a2wzbzQxODlj?=
 =?utf-8?B?TTFNV3drUHR6NFJ4SUFXektqeFdWTGtlMlpPQXlOdy9LTEwva0o2cCtBZFIr?=
 =?utf-8?B?VVI3bHVYK1NjYUdxSEM3eGFtYjMzWUlGSnNjd1lnRXgvNnNQaFQ3QUZYbTNN?=
 =?utf-8?B?dktTeFlRMjhRSk9uY0lxMzRTdDMxQzBycVl4OWd4bnk4QTlERVpkNW8xcmFs?=
 =?utf-8?B?dWNDcFRVS3RCckIxWjNRNnpwRXQvZnBGQmdQU1NqOG5zZTVmVXUwTlpFa2JD?=
 =?utf-8?B?ZStMRzR2aDlrdHhVWXlBV3BqVkt6Tkx0a0VhNSt2VTFTZDN3OW5idzlXSGd4?=
 =?utf-8?B?QWxMYzhkWGNXdWUwZUlkekZwMjgrenEvWXEvOFljRGNRSmdjV0JLb2NSNWht?=
 =?utf-8?B?ZkxZb3NvU29kV3N3U1l5cTdlM2pvMzJ0Z0JicFJSZG96WTY4c3RYVjhneFBY?=
 =?utf-8?B?SjA1SnEvMGZxblBNVDRjSDNOMkR6R3YyT2E2MXNzQzNnV09wSCtPRHF0WXpZ?=
 =?utf-8?B?OWVvdXVBK0Yxc3NZME5HejB3WjR6bW9HYnlRYzNJM2U1QjVScmNYZlJNQURi?=
 =?utf-8?B?SUk2YzJUaGxxcEE3TWc1NGlpMUpoNlpGdTlTcTY4MWZLa1prNldBRGFULzdW?=
 =?utf-8?B?NFlNcHdoaERNdnRFcGorQmNVM1d0dnhocTNVdjlZaTlia095M2g3b1M0Qiti?=
 =?utf-8?B?ZmhHWnUxOXNBbUVDZEhLVGdFRnVOM3VITk00WXU5LzU1WVRvNGIxSHpqTkVT?=
 =?utf-8?B?UzBqc2t5U3g0TmNPUERacmpQODBnb0NhMnllZHByRUg0czNkZGs2d3RsUW1u?=
 =?utf-8?B?UXhwUFdKN1RnM1E2eGV3S2hkOURrckY1ZHVrbnhnUm0zazFkS3hQUnVIZlYx?=
 =?utf-8?B?WWoxb2FTUk5JbjhVdVJTdEdkVHlHRW1oOUFzYkZqUTJ6am5FSHpyQ3Q0MHJj?=
 =?utf-8?B?QTFlMEY2V0UyaE1zeUx4N2lBQlRUNEpTRVRiODVYQlVJcjlEbEtRYS8vOWZr?=
 =?utf-8?B?Yys5RVh4VFJBT1pSaktoRmJZRWRUMVJva0pFVUVpYVYzYzZTQlRvZlloYXMy?=
 =?utf-8?B?amMvWXhSVDlzbncvdWdaTHdhNE9TVVVxdlZrQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:11:33.0298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8869d2-423b-4652-7c88-08ddb2683d46
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9777

From: Kamil Horák (2N) <kamilh@axis.com>

The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
simplified MII mode, without TXER, RXER, CRS and COL signals as defined
for the MII. While the PHY can be strapped for MII mode, the selection
between MII and MII-Lite must be done by software.
The MII-Lite mode can be used with some Ethernet controllers, usually
those used in automotive applications. The absence of COL signal
makes half-duplex link modes impossible but does not interfere with
BroadR-Reach link modes on Broadcom PHYs, because they are full-duplex
only. The MII-Lite mode can be also used on an Ethernet controller with
full MII interface by just leaving the input signals (RXER, CRS, COL)
inactive.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/brcmphy.h    |  6 ++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 75dbb88bec5a..d0ecb12d2d2e 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/phy.h>
-#include <linux/device.h>
 #include <linux/brcmphy.h>
 #include <linux/of.h>
 #include <linux/interrupt.h>
@@ -39,6 +38,7 @@ struct bcm54xx_phy_priv {
 	int	wake_irq;
 	bool	wake_irq_enabled;
 	bool	brr_mode;
+	bool	mii_lite_mode;
 };
 
 /* Link modes for BCM58411 PHY */
@@ -680,6 +680,12 @@ static int bcm5481x_read_abilities(struct phy_device *phydev)
 
 	priv->brr_mode = of_property_read_bool(np, "brr-mode");
 
+	/* Enable MII Lite (No TXER, RXER, CRS, COL) if configured */
+	err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
+				 BCM_EXP_SYNC_ETHERNET_MII_LITE,
+				 priv->mii_lite_mode ?
+				 BCM_EXP_SYNC_ETHERNET_MII_LITE : 0);
+
 	/* Set BroadR-Reach mode as configured in the DT. */
 	err = bcm5481x_set_brrmode(phydev, priv->brr_mode);
 	if (err)
@@ -1140,6 +1146,7 @@ static int bcm54xx_phy_probe(struct phy_device *phydev)
 	struct bcm54xx_phy_priv *priv;
 	struct gpio_desc *wakeup_gpio;
 	int ret = 0;
+	struct device_node *np = phydev->mdio.dev.of_node;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -1159,6 +1166,29 @@ static int bcm54xx_phy_probe(struct phy_device *phydev)
 	if (IS_ERR(priv->ptp))
 		return PTR_ERR(priv->ptp);
 
+	priv->mii_lite_mode = of_property_read_bool(np, "mii-lite-mode");
+	if (!phy_interface_is_rgmii(phydev) ||
+	    phydev->interface == PHY_INTERFACE_MODE_MII) {
+		/* Enable MII Lite (No TXER, RXER, CRS, COL) if configured */
+		ret = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
+					 BCM_EXP_SYNC_ETHERNET_MII_LITE,
+					 priv->mii_lite_mode ?
+					 BCM_EXP_SYNC_ETHERNET_MII_LITE : 0);
+		if (ret < 0)
+			return ret;
+		/* Misc Control: GMII/MII Mode (not RGMII) */
+		ret = phy_write(phydev, MII_BCM54XX_AUX_CTL,
+				MII_BCM54XX_AUXCTL_MISC_WREN |
+				MII_BCM54XX_AUXCTL_SHDWSEL_MASK |
+				MII_BCM54XX_AUXCTL_SHDWSEL_MISC |
+				(MII_BCM54XX_AUXCTL_SHDWSEL_MISC
+				  << MII_BCM54XX_AUXCTL_SHDWSEL_READ_SHIFT) |
+				MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN |
+				MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* We cannot utilize the _optional variant here since we want to know
 	 * whether the GPIO descriptor exists or not to advertise Wake-on-LAN
 	 * support or not.
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 350846b010e9..115a964f3006 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -183,6 +183,12 @@
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


