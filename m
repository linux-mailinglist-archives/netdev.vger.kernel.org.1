Return-Path: <netdev+bounces-199786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F964AE1C8A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AA9188AFE0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B5291891;
	Fri, 20 Jun 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="KvtZSeSu"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2567290BB4;
	Fri, 20 Jun 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427184; cv=fail; b=G1HVJ5PaSr+UK2QBlA36PzAWfobotv3FRmfrch+/7r0e3kYONaflZuCdVs/m6ukUoDbBMCUK+gkUY2bLq77gMMuxmVZdRs4t2BtD4dwnfC1OPkIWUiieFWYl65h/HzwQcuJsqg7Af2EvhAqxDhPjszAuounyBALCXBwwE3Bborc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427184; c=relaxed/simple;
	bh=BPj5pzRuIlmwy2Pg8fBnUbqxuQMIy7fLGb905dJBjzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRi29yw483qA+BIQGyKXoGpfLKrNUfXtG1vkXBmAhQbr3Dx3sBfiVZ6r2s/LZ3YFVkstqQfaW3+mVn523OEvRnkLkNYjRcj67dOCt3iZ6OelKlhMYS8+3DCYIG+/2TWg3XCaY7lKxju+GQdOsIFqKNyvO75pFoI5K2AV4wnkQ0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=KvtZSeSu; arc=fail smtp.client-ip=40.107.159.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRkDF6MA9x3eWX1cADIu016dZJ6otjrFOOL3wUJFqUeeSUR3eZyn1fqw7MKh4QzeyNeVBNcO6reqh5jaEEXCBvRWKg3qo4ysUelDZQpCIxlaSrTfZcm0DkxzU3kEx6nQBhUavmGqjkc0gURy4WFaJ01cQs01CLNZek3GA4ES/rBs04fTyvZo5uc5zFCmAA59rht2lFcsSbmBLoxzZOLkKpnZ0uRes8FJ1KLSKB9xhYW0M8xX9oOyvs5JYOAdZ9TxJt49OWJHUnYzPCNOYzfQIe0J4UiKdFJ58Yvzub4vhAVEEwSnuWn1Dl8K998puP62cz53KMcAvPYZHf0LKIJGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anOF4imD8C1/sav3axelNhThghhOoBR1jzFolcZ/8C0=;
 b=E3PJePyYD4lBk0NrzU8rjlQ/JodZAA4INR4iOvPTq0mYNTtwWxEeMnXqpG4UTNYFLPpsdqyDZuLuLS30H8gt6C64JYFqu0zG1UNpMoID3TvSvtZlhvZE047uX87NPo8dVe1qPKroMtwDJEZJXsIvYurwxtQiZPA+jHCxXDknvNrT84kJLL8hESqje0GspLlnlvZkd0ljYRqkyF9D32OWwWadEssSmkxifGIR1KegFZXaKcYb4E7iyOkWKJw59u13zOAHFiUjFh859AFI7qRGuCx8cUNdIg5Sgfowr/PCIH7cQMB7RLxnzE7gJB/o7OytwEzX3sQ9j0uaOYyLvwQZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anOF4imD8C1/sav3axelNhThghhOoBR1jzFolcZ/8C0=;
 b=KvtZSeSuiG8QpH/Ho+YG4ujlvOyH8nXjsMRCs5zE3wvIkBEjS58NwjVLFw752vHkTLOPm85Ky0n86mk980203ppWcl0cArn0S7DNUUOpZdf4oPQL4oaBolNv7PkduuvOzbODTM793tXwGrUzjgE+6iaAEecayP+20yh586Gvtnc=
Received: from AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22) by
 GV1PR02MB10909.eurprd02.prod.outlook.com (2603:10a6:150:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 13:46:18 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:205:0:cafe::23) by AM4PR05CA0009.outlook.office365.com
 (2603:10a6:205::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 13:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 13:46:18 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 20 Jun
 2025 15:46:17 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: [PATCH 2/3] net: phy: bcm5481x: Implement MII-Lite mode
Date: Fri, 20 Jun 2025 15:44:28 +0200
Message-ID: <20250620134430.1849344-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620134430.1849344-1-kamilh@axis.com>
References: <20250620134430.1849344-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78D:EE_|GV1PR02MB10909:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fb0178-7da6-4f49-a8e4-08ddb000d594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2RwemdTZ2NadTVBVmFBeVpzVTduYTRPU24yQ0h5OFp2cG16RVUvU0FzNEhO?=
 =?utf-8?B?dCswUFJXdXZMYlVWTzVlYXRNN21BbE4vQmNCRTYzRndSMllpUnlRa1NjUXJp?=
 =?utf-8?B?Ykd3TnFVRXc3Q3RSSXZ0YmVkSkswWXV5dGlGMnpIaVdvbTlsWUJjc0QrUmZo?=
 =?utf-8?B?UmJLd2MzamdnQm1HYmFrZGhSempYOWdUZ0MwUUdSVFp5djQydTFKeXNEMVl0?=
 =?utf-8?B?SSt2eUZrMTdDN0JwQjdsZGR1a0NPcEphNlI1K1IvUFMwR1U3SU1JVTgya2FB?=
 =?utf-8?B?WkpWOENtVllnMmdRNThuUVU2TFlrNWJ4SFNxb3loeWtqdFRxMi9FYmxUc3lM?=
 =?utf-8?B?RENKWVNqR3JmMEJSUExUNXorMDhnY0V3elBoWHF6RURkT1VFTUpUUktqcWU2?=
 =?utf-8?B?cWJmYzR6RmxEQmc1K3pCSjloQXk5NnUzMlhkckFWQk1TRTcwNVdnVVNPZXJB?=
 =?utf-8?B?QkUrNTNYVnA0eUZUMnVVUGY0M2JobWljbmpEdysvRCsyY3g5VjBtYm5SMmFT?=
 =?utf-8?B?VUYrY1QvamNMbUFqUG1iWE5QQ2NsOEd5RFRKZE9kYzRRRHBhOVZWZnBIK2VZ?=
 =?utf-8?B?STJIWm45dEZsOUJMZWVPWVByNk81dlFnQ1YxelQweEVpVmtHMVpRWnYrN2U3?=
 =?utf-8?B?aWlxMXpDU2UvR1pUa2VhY2prVWs1NmlFL3RvZU5ud2l3THhDOHRhZ24yQmJr?=
 =?utf-8?B?K1doaERtNWZCYWcyUEtGa2VRWHFzbkQ3a0pna216N3lhSmpybDhadjQ2amVJ?=
 =?utf-8?B?dTFDZndnSDVvdytKUi9HcVVhVnBjb3RnRTJNNTQvOXRXMzNGbWZDd05LSTlR?=
 =?utf-8?B?U2FiSDQ4cUltMk9ab3pzTVZ2dzZWSlozY3h2S3F2NHptR3JyajRiQmNwSm4y?=
 =?utf-8?B?cWJiZjBiU2VaQ1hJajRaclhhaDRlT3ZzRXhPckFvdnYwbmJsTW5LSTVEeWJQ?=
 =?utf-8?B?TkkycGVVSmZIQld4SW1RT1Rva2dFWTdxQnhhODdabFRvUStrdzNPelV3TFFH?=
 =?utf-8?B?NXQ2SDhFK2ZrcE5VVjJSVGRvb2xITmt4THQ2QmpkMkE4bHVyd09vQWlIczh5?=
 =?utf-8?B?S3NVMzhyc3dXZTJoUFc3V1pXVm54elY3a29nZDMrVEx0SmsyNWRBSnpWSk51?=
 =?utf-8?B?bmgrN1BHSEczUU5KVnY5dDl5NEFCSXNmeHN5YjZXV0pkZFpuYXNaS3h6Nm5Z?=
 =?utf-8?B?L0tXRjk3ZmxTNGJkY1dsb3ZCKzFUUFcwVGRWR1BjZ25CRHc5QTFPQlloK3FG?=
 =?utf-8?B?bVNIbEVXdjhFUmhDVjFJTVIxUEdzYWdtOFNGTFVnZWx6UW81TTdxNUNlTWt1?=
 =?utf-8?B?YlJNRlE0VWRqZk5PaGlodGY4UXFQc2RSSjhZUXRMTlNNaStldy93SmVvNEZw?=
 =?utf-8?B?ZHkxSTllUEJFdElQekRTcmR6ZXVSMktMb2MzaWZJOW9CZkorVnFjdDR1QWxB?=
 =?utf-8?B?VmFxZjJCcVo0WlJtWVpJcTByY0JqRTFQZDVUQThUZjlSUjRHRlZMblRpOCtI?=
 =?utf-8?B?OURRUklEajZSYXZrcm9hNmRPdVZqd2gweUp2U2JnMElwUHBXUnN5VGgrNkJB?=
 =?utf-8?B?ZFpyZVMweXBvK0QzY3BTbGtYVnc0dFF2L0ZjbVMzMzQvN3Jra3JqTlhoalBt?=
 =?utf-8?B?MSs4SXdwQ0Vua0xsUUVqbWVXOU93bE0rT0VZdVlnSkdldlA1VkFRRjl6Tkxw?=
 =?utf-8?B?cFN2bWZDdmZVWkE1eUlyTFFwVXJYeU9aSFdDU2pNaTM4eFBXZm02WG50YlhP?=
 =?utf-8?B?WFFDS1pocElTc1B6Tkp4V01wenFxSWY5akRFK2ExWUUyMFhyYU1JOHRVSDVx?=
 =?utf-8?B?aTJmeTVMMFhzcGhRNGh0ajJyTHlOUXpadktNTkU0N3llQUpteVRyVHNGUjBs?=
 =?utf-8?B?cnd3TzFhdmVha1MyRUdqb2traHlOcmtOQklFWVNxd0pscUhOb3VuOU96S0Vj?=
 =?utf-8?B?bXlmZUFiTVdhZHdHM2RXVUxhbG51eUozZC9yL2Q0WmZuaEJPdGo3Q3VHbmhl?=
 =?utf-8?B?aTBIMXFyL0EwVXNyVnhlemNxQjJtajhlWlpGQ0ZjL1VZQkRTNlFZa2lpRUgv?=
 =?utf-8?B?Vk1SRXZCYUIzTkx0aGV0OGQ5bUZvQlpEY1Bkdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 13:46:18.5830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fb0178-7da6-4f49-a8e4-08ddb000d594
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10909

The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
simplified MII mode, without TXER, RXER, CRS and COL signals as defined
for the MII. While the PHY can be strapped for MII mode, the selection
between MII and MII-Lite must be done by software.

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


