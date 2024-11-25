Return-Path: <netdev+bounces-147138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4549D7A2A
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 03:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF76162ADE
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DDC38385;
	Mon, 25 Nov 2024 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GcJrykKN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2045.outbound.protection.outlook.com [40.107.103.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B111713;
	Mon, 25 Nov 2024 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732502711; cv=fail; b=ryTzWY1KBezBtMlIpJfndL5BqyGR5CMNlFT5M+B3zGUb42UkiSLW092Mc+ptFlzj4S+1/DqKH0vvMO/3kzUp/gWXXu3lZ2ecvVtFSNnVcvSl83/SC4lcX+DXHvrPR14XLlFTV8Xpn++k4ircFKRbiI2uPy68HBxTvdr5wCwIfgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732502711; c=relaxed/simple;
	bh=oJzRzeDg+v3K3CjIL+TN7HuYA+6iJWwGJV6e/VDWQHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=scht5Q2s2k7EZsF7/fUlLA+H9JHKgxTKc+op4FHJxealHlvFOjIavbi+FHa5wrJ9hpYO4i5rcQ8dDk4gSgzGWop1T4EYf6Czmdp/MyIjpLJoCbv+vWB8/2YxNpeVAfWYarrbxQd2SE10q6h76/yPCb1UdyjH4/AcKoRWv6Nfh5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GcJrykKN; arc=fail smtp.client-ip=40.107.103.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHar4JuMiZZ1ydajp0DnVkUxslLRyO19DYfg/1OIw9B9V0+BqVWO5HHcZTLJgmmXNv7OwgabLQtICcIjgD92dc/yGmU285GXQ5iFk0mcCxbRYNod4j5SgkdaFUdBYBVujZeP2m1g/UyBbfyasJUQkTK9/W07tJs6Q5mSMGDi9Hhu9TDh5RK6MShnkeDxZcetVdoOk7vcX1nnkY/M+xZFf6tzVtrSFwXVjpO6Jqq9K0el3EFH2qDxEqT5L/Z/A6jedj8rwu730GruBAXgGq+ekfUELi4nQCfY/RuTdwH56Q6AZJaTvtDswK+F+I6SNxR6n3WG1xVArIG+Y7pR2IJJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbfrLrRO5iNjfojsiXpqsVRUkGjrCouFwFMYCr+0x5k=;
 b=iKNYvVY+jwCqHpuR+eVOGXInaPp5Ez6BVMfbi4ulAnwUlyMP/gj6LaSdx2tmYIpuAtt5ceWalR8vkA/21WZFCJ9CgEB2ESYk5FN7d2sfrVLK1G19i5b3ncBDc/aqV+FSxKQXl8rZFRJ+ijmasNYkHIex4ZTy8KnPgxJKAu09N3EjyRD3diMQWvC4nGSZsRYxF2HLh2iPjg0YgpcL2dONB9JHmyokNVZPDOZXyceTTO/Ik+HYE2dy/I0blx5A9UVzdoe9eJyrW4YtCIR7LhzFWwKYjH1a4o5xWMy5avR5eoMxlFFmaCjJXQ2W2JbN2Nf5AxBEyHygKPLtero1+A2NhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbfrLrRO5iNjfojsiXpqsVRUkGjrCouFwFMYCr+0x5k=;
 b=GcJrykKNDEKOHczjmhVzwPgKGdZIbuzhHmM2A0A4nuHj1fFPdwG6REyioPq0zZbEiDB/kmxOWdXFlLjbAiPQVme1Apgn/gw58x+qXy64Cf4uIrj9mbrWcnphcOV7YnI8/ZUFv5WRBukHwnHeNrj2Dss9cuLqRWlTX7EThY6j/73Ykq0S9CfMFT/xc7ibPNR27QGh5qD9ZqLVW63DIN0JmWc/HTb5X04r3TsejV83W6f1jW5gYkUF/y8oIkn4RWZ0u+DOL/CC5afez/IExsdlA9hMuzkEhXFr+/a4Xqo7qLk/8s8UDSdYjL1QIN+mnMSi2tENJmCUAFizalXEqwzIEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10496.eurprd04.prod.outlook.com (2603:10a6:800:21a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 25 Nov
 2024 02:45:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 02:45:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	heiko.stuebner@cherry.de
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: phy: micrel: Dynamically control external clock of KSZ PHY
Date: Mon, 25 Nov 2024 10:29:05 +0800
Message-Id: <20241125022906.2140428-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10496:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f20e28-1f75-4f68-72c6-08dd0cfb2a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s3u/gOeWd2hTyv3y+F/hL2Kl7xfz9RX0j+strBqk1k3Y3LwTo+dFhFvltJ/4?=
 =?us-ascii?Q?VWU9KZRT0IO5YM2LV4zQVhnbmBg68hXS6C3uuhzL5zbd/mNRZWWx2ze1ijxA?=
 =?us-ascii?Q?1e8I5mmxqGFdV3kACphhsyMVhXyrc8qFcP+/ACbQLTo37f/rwb72COGZxv5Y?=
 =?us-ascii?Q?J9A5d7uY2o/itT7Qfx5yLTDrRX2NYaPXyEVQwVQMNZDZJH9z2v4to+RjcHm6?=
 =?us-ascii?Q?k0RpZrcE34x4k0zE5YpdRbDj1Z87+RMeFUNTnc3l0Qm9je6sbuHbvr0J/sXX?=
 =?us-ascii?Q?/dlmFGNUTrF/dLk22c8K+JZ07ziGPvOKTxQb0Fd19blXsY34wJQ50DEKUBb6?=
 =?us-ascii?Q?SJvz2Dw9lLa+TzwYYAFfYFPIZ5qj9o/rb83S+/BNJnyaNGGRg6EcAZNN35Xa?=
 =?us-ascii?Q?oR6TlrqPJFyx+EPUSncggu5XUoUXg1cw+tRNqo2ZqJkY/bdvOn93PKY1vVou?=
 =?us-ascii?Q?NdrqPKtQTTeqX2VOVHUo48rwpGkZZTNvJXJ+0CTcNlX0ePyQuZI87772AfLW?=
 =?us-ascii?Q?EBYUvucF+NR++R5lruZBmnqz14gDH6ywfCL4pWUWqTdG5IP8QXTBJXn1x+07?=
 =?us-ascii?Q?XW1+z2YzXGmUG0EzLckxuXMux0M8UCvbuMtIXjrna03TV7D7smJAQaYbS9XU?=
 =?us-ascii?Q?t3odl5oentsQ+lrGjq2C63IwKVy4gSfrwmyQWHOcdKxjiUiL696ajDyI8GLO?=
 =?us-ascii?Q?L5BEGY3FpGjhn/zvvJV9fvVQgXU8Sg6WiYlUqnYsQm5DrU3zuJ4Pa0GvH653?=
 =?us-ascii?Q?FRpHpaRjgKHbUEkicNbnsgjEtbCO0G6abPtIG6ksK/Q7liuwvTky6a1aSsHJ?=
 =?us-ascii?Q?mz1ONm/VZH1Fe8wir1IJbU8mNcNdl3n7m6WMERXUtxeNB09eDvLNaauwkWh7?=
 =?us-ascii?Q?cGVO4MR6KZ9mgcuYvb5GNQR7R2EXCd/Ufvad559nG7M6xsVntUQbS0Q/teLn?=
 =?us-ascii?Q?bfCHQLqzyMIBxm7ngZ/ZOquMAkWLUE6ct1DRXS6TH7vk32BztprzlNryiHKa?=
 =?us-ascii?Q?ccTKzX49UgN9s8fgfELg35w+qEe4NRoa289UPE8ZRwT00/TyzDB8jX8vBDT+?=
 =?us-ascii?Q?lsUC4Eo95jxU4Y3QhTYKvnFCMui4wzUPT3Zx9Gia4bQc8nSigoHDFIHfiMKN?=
 =?us-ascii?Q?1gu+B5E1gxx5NnraKEdR8XnK1PGNv1eWGXaHs//oo6I6p8JDSJDHCKpvO0YK?=
 =?us-ascii?Q?be/tVxHzv4rXLYZK3wQsrqMGr6Nsk5esWt3c6fDN453xU6iFhXn63YBc3mNM?=
 =?us-ascii?Q?Oyz9SGC32iSpPsLIECRAq9uBcUJFqdgArOTmnpdKehKGjlP8Qp353jTg515h?=
 =?us-ascii?Q?rr0ij77qiQQpjnuMjzGOAdJ7iwipTuxeyu9nMy8h44i8uw3mugOUygleW+Gt?=
 =?us-ascii?Q?Mdum1YWhfvraaNlJefJ4xURWqDenBlrtDXxYDzc/Iu4kf0KAPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WBmTVFNsKzXdcmIJTD3OGTa3GeMrAPn8z0eiaIYzN02E5Zl7IvQOH/TF1QCI?=
 =?us-ascii?Q?qFYCg9VKoJRt0YdA34VQ5IEd+D4t81NNcpa7mvWbskL2iRSxDXOsEPXzOkDv?=
 =?us-ascii?Q?I9kbGuS7ZSRlR3wEr2jiDBdj1izdI7Qspwu5X/6wzPe30nFtenW8MieDSEH9?=
 =?us-ascii?Q?LiUEKrp6uodxRuNja6KC4vmSOacqMHU4DH2Orzopuoe+q7pWPU8fRrp5UtQy?=
 =?us-ascii?Q?VH6EFjYCAFHm5Eu1MzekcDVgt5iNSdnoXnTvjasez+SqWvkfwZUzEglwkCpI?=
 =?us-ascii?Q?Q6bzVfRud10eA1nhYmziM8dRnm7SeoBoTV2yfBICisHh3xLVgizPV0o3NY6z?=
 =?us-ascii?Q?CEAgmTzl8KB4zQZ5TE5XetdG9ehKf64dNy9LgYtih1RtCOYws7LCYXAAITkr?=
 =?us-ascii?Q?9UFkiApq6p6UcAqgIfLzPilHWRPhDnWcZMa4aXTl4C8HX1v0sLQwt3TcYrYz?=
 =?us-ascii?Q?ROFhuUtThc6W+JRwByiMVMTDF2jMRoXGdCkF2O6zr/tkfdG3vz6Zv7bnjQDR?=
 =?us-ascii?Q?CSl03xUZiZmIeeIzmh09sNrNu4fSlb42h6s23qUNkia1/36e1k7DY7yhF3gS?=
 =?us-ascii?Q?bwYtL54UVOuVTSL35wL//KnC3jLpB3fbXcIXWM1u8qpBXaX1714+4ksTWuyt?=
 =?us-ascii?Q?20YLQFlEnOpl8hLjSjtqPAkdwHhWm1Ro/kQmInvOG+6x/CZGGvEPxlqtWWbL?=
 =?us-ascii?Q?9MahsQX/kxARy8HvuaM36oUJa/4uglYe9UzbNeJfDx32IxfCyVmHZWgKL4QS?=
 =?us-ascii?Q?59uBqyYtEeMwgjYT12m6Iw/z2OAW71dHp9oWvdqCR+h/TBJU5ZXl6SbD8ttk?=
 =?us-ascii?Q?B2/CY6HtccDwNgygCHD4HNxmE+I2qi+KvV0hpRpkkujWOSrxxJrL/eCBHkyU?=
 =?us-ascii?Q?EiUahrOS6WG0g5GIjCjBTX82GRey1R0w6LopJtjlwH8gfyjgCQE96LEfCShh?=
 =?us-ascii?Q?wqQ0r5tuotShFELGrQUcKYaRl6lpLh5sCErmEWbnmoJ2PrIK5oDR+kvOzxJF?=
 =?us-ascii?Q?tz8ya7xhuq6mzy/lIMqsuCQhOHXNC9fUoxZsQ5ZcLY7nGWFRZEJxYkzvAWsF?=
 =?us-ascii?Q?HM1qeCIJ3DZO5lxD7DPdOiATd5VPeQ/tZ3vNoPjBNdKwFAAhaIJJ3jUhF4Ik?=
 =?us-ascii?Q?VfNKGnUzR0WSXes3RDWk3E3vUrCD8Y2/ObK4QMN+sFo6QIA+CkkCuFLYJB/s?=
 =?us-ascii?Q?2IXVSA6MLhOqLqfgl4RkIh3Zu/yYVqjdc4bUORoDIjsVWJ9xU9BgxzywW4gN?=
 =?us-ascii?Q?8Jf1EvXY9/M8O6HkhaKtgVtRH2XNqU3YyXONTSb/dqHbrUl9XtYUc1iDLoi1?=
 =?us-ascii?Q?YtOQIzM04M5HNSckkphZAIw6MAHmZFE2sBOvzuZARzXq+Momorz0ALb5VVtA?=
 =?us-ascii?Q?NU7q1B+lB5cTPGCWRGvBer7+iBWU2KAkjhD8rIwG4zQHUf5VwERIGwMyDSS/?=
 =?us-ascii?Q?K31crt17s9VX9PyI93hZDDTplSRfx/bAboRRIkFqbkv5QBmgO4JrGUJVPYF0?=
 =?us-ascii?Q?m/cKRDr7FudRohqUp43ks/CSudJ6bTRfz1TwhRmwrylwEACbKk88B7SZTKBL?=
 =?us-ascii?Q?XHyBRAELNpLQLAjCbf6OBnUSx3+losV3y1uSO1do?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f20e28-1f75-4f68-72c6-08dd0cfb2a9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 02:45:04.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIg5Jska5iODeyH5NUJWdUECnFdj1c1cOtmVLzLkFzQ5ox0keb64DZLsVoJNefNC/4SAxI/oExKSJVUPrbpN2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10496

On the i.MX6ULL-14x14-EVK board, when using the 6.12 kernel, it is found
that after disabling the two network ports, the clk_enable_count of the
enet1_ref and enet2_ref clocks is not 0 (these two clocks are used as the
clock source of the RMII reference clock of the two KSZ8081 PHYs), but
there is no such problem in the 6.6 kernel.

After analysis, we found that since the commit 985329462723 ("net: phy:
micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
external clock of KSZ PHY has been enabled when the PHY driver probes,
and it can only be disabled when the PHY driver is removed. This causes
the clock to continue working when the system is suspended or the network
port is down.

To solve this problem, the clock is enabled when resume() of the PHY
driver is called, and the clock is disabled when suspend() is called.
Since the PHY driver's resume() and suspend() interfaces are not called
in pairs, an additional clk_enable flag is added. When suspend() is
called, the clock is disabled only if clk_enable is true. Conversely,
when resume() is called, the clock is enabled if clk_enable is false.

Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/phy/micrel.c | 103 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3ef508840674..44577b5d48d5 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -432,10 +432,12 @@ struct kszphy_ptp_priv {
 struct kszphy_priv {
 	struct kszphy_ptp_priv ptp_priv;
 	const struct kszphy_type *type;
+	struct clk *clk;
 	int led_mode;
 	u16 vct_ctrl1000;
 	bool rmii_ref_clk_sel;
 	bool rmii_ref_clk_sel_val;
+	bool clk_enable;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
 };
 
@@ -2050,8 +2052,27 @@ static void kszphy_get_stats(struct phy_device *phydev,
 		data[i] = kszphy_get_stat(phydev, i);
 }
 
+static void kszphy_enable_clk(struct kszphy_priv *priv)
+{
+	if (!priv->clk_enable && priv->clk) {
+		clk_prepare_enable(priv->clk);
+		priv->clk_enable = true;
+	}
+}
+
+static void kszphy_disable_clk(struct kszphy_priv *priv)
+{
+	if (priv->clk_enable && priv->clk) {
+		clk_disable_unprepare(priv->clk);
+		priv->clk_enable = false;
+	}
+}
+
 static int kszphy_suspend(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
+	int ret;
+
 	/* Disable PHY Interrupts */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->interrupts = PHY_INTERRUPT_DISABLED;
@@ -2059,7 +2080,13 @@ static int kszphy_suspend(struct phy_device *phydev)
 			phydev->drv->config_intr(phydev);
 	}
 
-	return genphy_suspend(phydev);
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
 }
 
 static void kszphy_parse_led_mode(struct phy_device *phydev)
@@ -2088,8 +2115,11 @@ static void kszphy_parse_led_mode(struct phy_device *phydev)
 
 static int kszphy_resume(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
 	int ret;
 
+	kszphy_enable_clk(priv);
+
 	genphy_resume(phydev);
 
 	/* After switching from power-down to normal mode, an internal global
@@ -2112,6 +2142,24 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz8041_resume(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_enable_clk(priv);
+
+	return 0;
+}
+
+static int ksz8041_suspend(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
+}
+
 static int ksz9477_resume(struct phy_device *phydev)
 {
 	int ret;
@@ -2150,8 +2198,11 @@ static int ksz9477_resume(struct phy_device *phydev)
 
 static int ksz8061_resume(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
 	int ret;
 
+	kszphy_enable_clk(priv);
+
 	/* This function can be called twice when the Ethernet device is on. */
 	ret = phy_read(phydev, MII_BMCR);
 	if (ret < 0)
@@ -2194,7 +2245,7 @@ static int kszphy_probe(struct phy_device *phydev)
 
 	kszphy_parse_led_mode(phydev);
 
-	clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, "rmii-ref");
+	clk = devm_clk_get_optional(&phydev->mdio.dev, "rmii-ref");
 	/* NOTE: clk may be NULL if building without CONFIG_HAVE_CLK */
 	if (!IS_ERR_OR_NULL(clk)) {
 		unsigned long rate = clk_get_rate(clk);
@@ -2216,11 +2267,14 @@ static int kszphy_probe(struct phy_device *phydev)
 		}
 	} else if (!clk) {
 		/* unnamed clock from the generic ethernet-phy binding */
-		clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
+		clk = devm_clk_get_optional(&phydev->mdio.dev, NULL);
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 	}
 
+	if (!IS_ERR_OR_NULL(clk))
+		priv->clk = clk;
+
 	if (ksz8041_fiber_mode(phydev))
 		phydev->port = PORT_FIBRE;
 
@@ -5290,15 +5344,45 @@ static int lan8841_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan8804_suspend(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+	int ret;
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
+}
+
+static int lan8841_resume(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_enable_clk(priv);
+
+	return genphy_resume(phydev);
+}
+
 static int lan8841_suspend(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
 	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
+	int ret;
 
 	if (ptp_priv->ptp_clock)
 		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
 
-	return genphy_suspend(phydev);
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
 }
 
 static struct phy_driver ksphy_driver[] = {
@@ -5358,9 +5442,12 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count = kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	/* No suspend/resume callbacks because of errata DS80000700A,
-	 * receiver error following software power down.
+	/* Because of errata DS80000700A, receiver error following software
+	 * power down. Suspend and resume callbacks only disable and enable
+	 * external rmii reference clock.
 	 */
+	.suspend	= ksz8041_suspend,
+	.resume		= ksz8041_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ8041RNLI,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -5507,7 +5594,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count	= kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	.suspend	= genphy_suspend,
+	.suspend	= lan8804_suspend,
 	.resume		= kszphy_resume,
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
@@ -5526,7 +5613,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
 	.suspend	= lan8841_suspend,
-	.resume		= genphy_resume,
+	.resume		= lan8841_resume,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-- 
2.34.1


