Return-Path: <netdev+bounces-236269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E45CC3A7E6
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BB88502D4C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3DB30DD1B;
	Thu,  6 Nov 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2cNCG+3"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017F30CD8B
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427483; cv=fail; b=cKr6OOv82Uyg2xae1AOACaHgc8pSSSvstcGiFtT3bisgE/SGFQMCmiDJ+1LvdH1pa9J26OmlYc9jrbknZKKvLj+OkPTUfZuyJKAQvzkjV51KFare+xs0/mWIO5i+5b9RobQ8ZxUWXZmaGo6vnwPFG/zzdMbJZaGCIsGGPR6qr9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427483; c=relaxed/simple;
	bh=RHVnQ7nnVHaYXo7D084/wLjewOY9g8pp8F1gsLKIAAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ApNgEiIrJEoA0aaw2dqZGU5DGWUUC04qrM0dWr85Ix/B+9ee4ac9p9gjoNDEFIYeJamzm2piFT/MxcFsTJ0aIYt+YcnVoPqzcPVVpSqlRB+sgGaPuN1rLBJYZZQIrIeH68UMAX4Zc2AjVW41z0A+g2xr7NKLCecMumbyePCaw8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C2cNCG+3; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afi5jX7L0pR9wW5r/eHO6A5VlrAqDTwWh3C1T9XMjj8IphUSByiRXpe56gRXO8qnh+/bOw2JMiD28olGiOcI2AO3lm366f9SZ3q+o8x6RoBH4YnxD6zqJYwivSsMU4WulpqsljriI8bkF1qMjSv8LygvHOw4iDVNOWTydC3SqWOmcizdk4DQbYJKNmxHLj3T/K5MAU98BKO35w49vt+mW+7u+HbYf5o6vbePeKNNBjppSj6a38rJdBHsbxUDuTHSykfm0QjWOZ0VNZIc+MMAQ1uhZcRc98ygXEOQHoP7xCSJD4e70c4hhyPAzCCdQ4mXmWuKTmL7GAYt112AaGi3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks8+8dY2KsJM62YjqMJvgdORi3Y3O102bHM74kJZoLg=;
 b=KwI095DiVbV0n6ORXoQYpZH4CcdL5cgFo/ZPnkI6C1hbvuQLPQsJpaDCz67euf6DjULx+CXwSe067mEYVnD0HsKBfhAAuUtA3krjHg9AE+QKQOLiW9I4Jc0BgheNXvTxKM4MtYc9AFNoXOfeDkDNkT1w+wtOf8a5N7AJEbNje1M7HHyEi8amSKaKdGzFG4ypXPrWIab/jAphZIiFIsYVWdYr6hMj3Ef/Cm0T0Gsdy/rZZ7bb2oPa4AQxO6LxPEnWr/36bQ2Y49Y+y4wRs5WVpkvnM3LffIVSM8IPvfqHqU0+5X75M3e1Cfqq0p8TmixOkeDRtzJhLYyFEPnJodtGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks8+8dY2KsJM62YjqMJvgdORi3Y3O102bHM74kJZoLg=;
 b=C2cNCG+39ClRqnr8R4+n9N1Dz+hqYcfcM93yU64LR0H9TPsuod4hLqAlLLloz5nMquoXi6k5KBHZIstTnNh1YJGW8CscB4Z2e9YJylrquXcLmhHBeWq6iQUMhC3SoqaUjpABnM3ivDiXnEmTDVwoirDMXrS+mRgHlXNXjFHgqXRra3EhO2Olv58gf4s2or5lfCNYhwxmzGdBdZZEFq4lA6zW/Nj0Eic4ibE8gqX4HT2v0H9PP067SSnW728uLvjhwpy55tMcLOC5uxm311u97QgjVc3+fTBI3EQHlK8gUMXmKREqND6Fq/6B/M2N1HHGjSMbAVZZUwaA3rexgSfRVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:11:16 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:11:16 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH net-next 2/3] net: phy: realtek: eliminate has_phycr2 variable
Date: Thu,  6 Nov 2025 13:10:02 +0200
Message-Id: <20251106111003.37023-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106111003.37023-1-vladimir.oltean@nxp.com>
References: <20251106111003.37023-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::11) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dda097-4dcd-4100-e975-08de1d253439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YC5uRQck0XMdf8Vmujlg5OhoPiY4MTd+iQjI30ML3qhR/bgwZQUk5KJ3BtJQ?=
 =?us-ascii?Q?T6mc6Wwfb4RAxuinCSfEVQzmgp9du4yUVq/J6A1oYWE3tFoArhaTAMrc03C1?=
 =?us-ascii?Q?CugO8KP8R002ExIjB1k93UFUth7u5OZZd7FZWfHTalE3vmjJ8xrvrxHZbsHg?=
 =?us-ascii?Q?BusSfvpb2GUR4y1SiNltpOLC/1rG7eLYS5DevJVeZ0yuLpRfNvV8glFimI7c?=
 =?us-ascii?Q?a2YXUJaJ+aCb2SX5YAgd9ql5eIUy5G9z3rUUA8fKnN3HTjEONB7oTcmaB09j?=
 =?us-ascii?Q?wFX8GgHQiFyDCE9vbpRUaorCpew5vAkk+zXQdZeMzWVRAHr0+6Hsd/yUip3M?=
 =?us-ascii?Q?ONzBz2ppFO48awudHTUKhKc4z9YtttYm6kzs+x87JVeYRGGHJYINt1PMcyYM?=
 =?us-ascii?Q?AfDD84okbXE4giyIRu0dxQ/+7ttLuk2gRTkBVJJ7gBwsPd/n2Rp0E981UNNH?=
 =?us-ascii?Q?dtd9d52yLQj8CdZqgcj6PRq+BbpeQZpxoNrnoVxam9nDXiv2UF4QHvvDXWfc?=
 =?us-ascii?Q?+JVMmcuNqTSp7X1UCvPp+uQ/PD5T7+SnhbXl66pMHBH5ZORthi2uwJ1Z7O/1?=
 =?us-ascii?Q?MypoPq4KrkmpUbyuSKYvP6v4lIcI5amtyqr+AnH500xAvuFAJzCPRXd87L4Q?=
 =?us-ascii?Q?XyL4RwTiwzje59mMv1T+nv82CPTUjjo2fxTb+7G3st2ZxDnw6r0g3P3D1wm0?=
 =?us-ascii?Q?1+d92UIhNFHqYpHL2LitzPfPEM4NORZu9y+rXSNzfoHscGk3MzJeX7k+xpmR?=
 =?us-ascii?Q?8OwGth1Q4Dr40aDvgdHwR+rFMesr9d5czeSN6KIPY4DYNNNwhKweQgsN43tZ?=
 =?us-ascii?Q?fB4gYwGdKgNDMmoShX7BM37qk0zo0l62QMsM1n6q8yXgNgtHhp4TXhazZhwa?=
 =?us-ascii?Q?JT54cU0wNa7MpW2UAVAvzR/MQDCZV0CvWKbwvoCdqn9YXLL4l+tkUPCDvHBy?=
 =?us-ascii?Q?LnEBIp4oMMw/ySJNYrYn50xGkKQlVpO97coBQSCUO9KY6bRqtQYdN6x5RVtU?=
 =?us-ascii?Q?gtSgd60fgdD1m1uRlSaOHnDnvUzSjiu+ghMSig8BcARPv/9fEBrcqst/YmZ7?=
 =?us-ascii?Q?cV6Kj9pQpjdQ1v1ihudefz07BpOAL9fiDVd/deXv08ta7lOAS3A836aMyEti?=
 =?us-ascii?Q?FnqnxjGOTq2yj0/LJx3dcQOqGE0FjpExTSBq20owzi0dHeAq5jgYKEFtOJW/?=
 =?us-ascii?Q?WHnmQvbhHaqqmcMoBlf8Dm+aiwxR7iGsWXoCZ45SOM833e/Yl6faw/vUV3wm?=
 =?us-ascii?Q?c85Io8IBdD9gv9DBAiEWkiGQYzzN/RblpDFwUEYZLWgjos1GjwUueZKJUT4W?=
 =?us-ascii?Q?4xRDh6ufk3ShrTLNWT1G/OkMBD1RUF44Z9Zxg9dP8klIdZZZevqIkD+A7Jab?=
 =?us-ascii?Q?dG76bijy6VZh564sYFUJ4U+VJCKg5B9aX4L1rQmZm8hy16Lm0bZ3FIgoSAm3?=
 =?us-ascii?Q?sQZq6b8hcAluZj03OnhodE3CrqSHuSqx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJOswvMAB8EU20Ht54+h71OM8ng+ylLUdocM9J99u17Jr7+cj7y77Z7VQY5T?=
 =?us-ascii?Q?dubTZ4BneXp3Rbn6T9A5UFPZvTJk2JKGSE9A5aTY9Jq6de0l9S4fW3wFxV7q?=
 =?us-ascii?Q?evjDyENLa0u9YQcnzw61XZtKl0lMfcCLMSFomaMzSmku2vdljxRCUnF4q9Ik?=
 =?us-ascii?Q?dxys48GJGsNvgFk5cL+3O8C+ImBjDQr72xxJbFyANiV1R/LRAjAAqwa6alVK?=
 =?us-ascii?Q?L+QNk6I1KeoHRWwwjJZGcutS+75C8CAqL0YMqtpag7HTQzLHrktwlxSIJ371?=
 =?us-ascii?Q?5IpK8VgwM7cC+03GvQV0eD2UvsGTd4sKmhh6WffQSZ6FNYoT+U5Dgi3IzO/X?=
 =?us-ascii?Q?9JJQcEKZaLMoyMPfhfV/L8xGT/pcaU3QxBr1d60bnYErCaJHE4FKfxaYZmTa?=
 =?us-ascii?Q?0bzSPhkiwJd43S1HBR9U8kRlxPlfSvu5DTenAPpQ5aLaVVPFyOTOypxgYmuT?=
 =?us-ascii?Q?6GnTHNNnpSBRv5+H8ou3mAKubgDBWLNmXNfcZGGBqjPAvdmggeWQMna6Wt4o?=
 =?us-ascii?Q?5bzXm4b8o61e54BkKVBZ6CbSCb+P5W4zHvhcFpldZk+CGqLD0ThR4PlTnXlC?=
 =?us-ascii?Q?R8maDuFCiHKGyx6qgkiuy8etZaPQSnYK5zxoaKZxsBtM9lKAYh9Y6mDznE9M?=
 =?us-ascii?Q?5DGG/MuF+vDaD+MMLN6EcU7K/7K/a3IBQUK1iryz50MUWZt3dDw1DzJ163WN?=
 =?us-ascii?Q?RCNHZd+UXuITjsCGaU1vgC5VIUCFTVztiR4WfpqA8UmiO8Zm220GRhJam4fM?=
 =?us-ascii?Q?AkknOdNe+sYxNHdJTLCM/ekJl90qWguf81HSCfSTPPlZg7O8YSAkcRJPDRKM?=
 =?us-ascii?Q?DzX4i+pPvIiiMAI117AgRhT5AoQMyQ/hPp/SuDhL+ordbnteRKojzHAC03dV?=
 =?us-ascii?Q?g4F6MA2c/HQEkMcDImUBZ2i0NTJY82pC1hIBR8Yq8F5L22Yckpr92YImfWMb?=
 =?us-ascii?Q?/btf9037LaFvyUw8UWACYKz1qozEWornIoMxweO5JGhSEYzN3gyxpYa61Trx?=
 =?us-ascii?Q?pKoWtc73EI9ZVQ+PAqZ0oNub1R1BMhLdkFk0u0l67n/zi++cLXAK8QKKWZlu?=
 =?us-ascii?Q?ddVZvziWUXLDFPm1Ab5yiMmYiRrVk8LmER4uOmsO2NjbJa9eVnWsgIV3Vkji?=
 =?us-ascii?Q?s2BmafSGiP/DUVuO4YOp/N9SjWeP4K0nOM8lalWz2doj3+HD8n5rbT5aVVbZ?=
 =?us-ascii?Q?9yIwjyOSMHX8Yg64C2Sno6V4SFV8OjUxPXQmkfUqclGj72yp561Lzo6SE2vV?=
 =?us-ascii?Q?PiV4BbkBB08StbT1pGImWUOvjJUPKcbmvk+e/YblTdh4yBsn5RqLMY4oTUWI?=
 =?us-ascii?Q?I+06dUllRR5+kmiGrpUxXC7yUcgIcgtkDJvg+RIia8Dpqby1zNU5IHhwh4e9?=
 =?us-ascii?Q?MSxjmkjRgyzvWgHogBQcc8URINcIm5Bqb5BbrC5mJT1p6XWMKf1wNFRVI9iN?=
 =?us-ascii?Q?rxMvwUWvnDmRzIjXGFhKvNYKjUVPqolmCXK81Z8iObHXBN7zuXuGfhWgSVoH?=
 =?us-ascii?Q?g8Ds5gewMEaJeSjxgDu4mqWHl8p+ZAf+21L7xHN54ZRFppf3W1vREkA9PmiU?=
 =?us-ascii?Q?2sg4LKSM8SR2r3UBoMXS+MS2CDAIWFN3S1XTB5HXIdG7G6dkNq6+b5Tt7Bv4?=
 =?us-ascii?Q?7z0YZOt1pHOVJdNm/L92t9g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dda097-4dcd-4100-e975-08de1d253439
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:11:16.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhlK/n3kpyshQ0XPH/A94dy8crG1ZCvf4EK1PX7MqiSOgn6CJkiUIJHwJ2AqqBWe2E13M4LVsMG4i8UtLfT5Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

This variable is assigned in rtl821x_probe() and used in
rtl8211f_config_init(), which is more complex than it needs to be.
Simply testing the same condition from rtl821x_probe() in
rtl8211f_config_init() yields the same result (the PHY driver ID is a
runtime invariant), but with one temporary variable less.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/realtek/realtek_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 45b53660018a..89cc54a7f270 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -194,7 +194,6 @@ MODULE_LICENSE("GPL");
 
 struct rtl821x_priv {
 	u16 phycr1;
-	bool has_phycr2;
 	bool disable_clk_out;
 	struct clk *clk;
 	/* rtl8211f */
@@ -245,7 +244,6 @@ static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct rtl821x_priv *priv;
-	u32 phy_id = phydev->drv->phy_id;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -265,7 +263,6 @@ static int rtl821x_probe(struct phy_device *phydev)
 	if (of_property_read_bool(dev->of_node, "realtek,aldps-enable"))
 		priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
 
-	priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
 						      "realtek,clkout-disable");
 
@@ -665,7 +662,8 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 			str_enabled_disabled(val_rxdly));
 	}
 
-	if (!priv->has_phycr2)
+	/* RTL8211FVD has no PHYCR2 register */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
 		return 0;
 
 	/* Disable PHY-mode EEE so LPI is passed to the MAC */
-- 
2.34.1


