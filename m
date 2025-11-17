Return-Path: <netdev+bounces-239268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B90FC66915
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4968929533
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAEC321440;
	Mon, 17 Nov 2025 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JKH4d1iM"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC8315789
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422905; cv=fail; b=Hx1PrMTTvRtCZ4o54QLwEAECiipZkcEW0vY5G967ZkvcKfm7sEw3WWl80Igf8O9mgkfYn2mbefVnx5ts3zWGJE23QJ7mH2Upb+FWruzlaxmhG+OEKZJt4BtU6I0OcINYD3PP9yeec22bb4EzryHY4yX1HVX3RaR+gp2XlvkEQpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422905; c=relaxed/simple;
	bh=PLqZqCbxUl5zegaFE2GcW4e9DQWtBFYKdLfsu3wy5QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=na0gljg0FLOv0sRaDfjoqLQYGI9pa+lrN/mn2EZEY/TSKy6ZlYDkAmBRgj2uUFGWB/zQIINew58t1DkMQA0bJRXU6lPJ831ugkYzLwfeKHdv5JcLjXcTap9XKcv2Xt9xjBOhm0HbN59VFw+RC/A0Kyo+xia5NzGBG0g84CuQQJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JKH4d1iM; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbheWjKOp8jd23Vzo8lXcPSJwWIhiJ//oYDH95TJvvrsaz4pzdcKQVwq3YMtHAcpLHjzgP1Q1AX5RkoDTD3Cm3jfYQqvfMsdT8s1VrLTf8atiD9173xxaAZuMNR/m0VIwc6sBhGHVPswUeBJNX3PImr+Y5XNBMkkxBuMuP+0Lr5VkHAiacHUZG75O5Z/+jpEKdNvOimNTXaZg63BUjvpkP1UzRrSCfgCpDHJK3aDALRLN+J0tbiTXYHKdoQSgkqWiZZDUsaWS+6QLF8QyPfJribHfkV3N4IdmS7BU33rucIzAafSsMUNby8p0aB2cNat/oZVTaivJgyecobwmV3LYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk8EbPqDUjKWdg+pVNLvO5ONd1kQP96oPPAqWiBGZMQ=;
 b=NmDfjOziTGKZ8OX+RqwiB4UkkjyKgqfI8sHhwDVaUcIeg6swr2CM3WCYRxK49TTtovj4DcGtqWqRZ5VArKxv2mLJ+uVGP5nzXyacDxMrEb9Y+DrMWKoc3qMwVeCZFH4XOB5xFoJRLPeXAoGfkVpHodTo4UxHTE3BJuNtTYWwQXmC0iwMqbXdOqpLwNpyu3ziJXOTe74nqkRjk5xmBTLLTuoWprTkwTzcOV1iHcXz3O9ikDave9lirxgMeXrLA8ZB+fd6sP1GQBp1BmvGsAnR+KAo3uAHT3E8ejjJFGEnq8BiPEAMvbc2UEKr8eUmS/p2WKIny0dYOVocePkE/Wb36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk8EbPqDUjKWdg+pVNLvO5ONd1kQP96oPPAqWiBGZMQ=;
 b=JKH4d1iM07k37/xV/fpFdxHVIpnB71KchVRgicdFIen2heIpaSyY4T/AF0SVdgaoBCQ5JO66TMJzciGXyQr446iKsyZxcIhhuFnn+JRPajlsF5XoJtxHKEigfINJgZ0HakWES99KnDUCGsRjUSOoj2ndXrjhwDKtS8kNpQ0Cs3HkttYcuUiXNetOJr7I1V38X3el6tGyCO8RLW7RuxY10rSEBnxPR5kggJ9KFHEWDqK8AYgSMQX2+LnLKaO1vEtuKkQlD93zJvoKAzk/IkX3VBpu0GoTT2JGmQnfuIMgp/JLlODqYlpBmJQk3PiNoT3F3D8geyboG4x2IdTTlnGyFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Mon, 17 Nov
 2025 23:41:35 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 23:41:35 +0000
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
Subject: [PATCH v3 net-next 2/6] net: phy: realtek: eliminate priv->phycr2 variable
Date: Tue, 18 Nov 2025 01:40:29 +0200
Message-Id: <20251117234033.345679-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117234033.345679-1-vladimir.oltean@nxp.com>
References: <20251117234033.345679-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe5b81d-37ff-4f85-74aa-08de2632d866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X3+6iAvf+s7O+ZQ3fFiVoHUuxvoOXf9O8XfjkOyGC6fPStckQIrtm//lRzGY?=
 =?us-ascii?Q?n9/HWA52C9uHCBh/xeP5xJkbZvmVz5spwCcTCua4tFfb4INPcZIHW/STupgw?=
 =?us-ascii?Q?4ONPkZn5hU+C/uXjxF6AH2c2+jP3SQvgnWZBMEZLdbjsbRUBX/V8TVnIHx4M?=
 =?us-ascii?Q?n9iDJOIEb9DTYcrywmX0CewAVYDrOP2uxX5uEI8PcFDr4y1HNeZT1In+yFeh?=
 =?us-ascii?Q?F8QYIxA3OmcuYCHK3VQ2c4MJDgg6miRTRI70NRhryVXZDdCn+bFlA1M9fpAH?=
 =?us-ascii?Q?KG17MIWmwq5W7oSKWNABKhSqChsWaXPMJ5QOyXE0kajVjyRDrAz8SIXXPc4X?=
 =?us-ascii?Q?+++9JN52UDk8whIPXldGpLpREUjs+4oi+fEjiSHeB0TT9Qgk+TYKjNzy/kVH?=
 =?us-ascii?Q?zRZWS18b+1zEAH/f5XBpugQeCJ3m3tbL8kBkewoObJDXYvZOJ5CSEo1kl6YX?=
 =?us-ascii?Q?+cHgnvjzuEjEy2aOYLyw8E1PxXynYVIotRD9fOryUIC3WLFdVUEKtSv9Ax29?=
 =?us-ascii?Q?gl9bIGNYeJ5ktNkOMFYFsK+bSzqWmK//kIgStu21j735aq+Mogw45nVUMLdB?=
 =?us-ascii?Q?PCrcsqKnk9bOjH5oTympujMm3FrudVsFOk4ci6Rn8LX4rhQBdjQiIgzyB1D6?=
 =?us-ascii?Q?mHcgi3NFGF9/l0Ip582V1BaC8wOJuDE3W57i2ueIfAIi+GbguyPn4ybRYa3N?=
 =?us-ascii?Q?tDBJZSEIFbcBgHcVyLEiV63szEizQNFRfMvh5nhWqkZnKjj+gm8HMb82F5pl?=
 =?us-ascii?Q?bgElkJchYGmNN9Aj3Ja9j5FADQ8Vf7xvtXB6Y0PvoJh0v279GaODPnYWGlzq?=
 =?us-ascii?Q?KSDcca+1+FgvgHxDiLS7u5CpLLBvka60Xef/bwQRYkAuR4+1sLmq3FuIrlZc?=
 =?us-ascii?Q?TAQfdbWHxjL70v+wvywkSKduUFtaiL260qiB8/9feFrG8lI0cdTsYXg/nAt+?=
 =?us-ascii?Q?86FKQgQN7Dlnx4GFMtXx8prfsqwiDAC+HvaoJ0l9VpnflAuVW4WAsi4CnrK4?=
 =?us-ascii?Q?ja3gSC3gfvVTArwvUAZ/H2Ykz3QS5EAKjXE033MZHnjakEnxmKoteLTX/72U?=
 =?us-ascii?Q?LXDa98C6E79GIsAXuKbU443mgPrUTavo6rjZqMM0nT3heiRF4x4Hqn0q7RH4?=
 =?us-ascii?Q?riuiPNxULw0YLcnTOU6IPZiqipFJkl3bHOR5566HxI45LQY75n/YQuFEeIeS?=
 =?us-ascii?Q?WL3j3fP+c9Xdw73Z+PyJkTmsjD7Jzw10WtxK9o1fXYz1wzDlNMnm0EUTx6RA?=
 =?us-ascii?Q?slKrAWPxxB36L5n3ZW4pztqtNnBsFf/b+p0d6wtT0oacSDMPoPfD3YtHz2Ca?=
 =?us-ascii?Q?q87QvzkCvIMgQGzHtwaShppmZ9QpBZ0xqhrYjVjAd/dL1ZnID2Nlj0cZqFSW?=
 =?us-ascii?Q?iDLbMPIKuvDf/3i1B1wrCFIv2U51IBt+fDvc8WfDMiFPyeQAR7uBRPIOFaQK?=
 =?us-ascii?Q?D3V+lpEXjaDQfxs1FRUH/W1ClFyZTxex?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+EivVEyRa7mNd07CEcUBjUkp+BMSqSnXobeUw92D/zI838NvIk7hVOA2CZD?=
 =?us-ascii?Q?JPzgxngcSPEv3FKqMMfnB573rXllyS40gFwQoPtpm9OV9mVYxZIMzFAs49xp?=
 =?us-ascii?Q?BCuHtJQnH9/J8vfDS/wTTj6K+XO+FulwP3511w1k3ks3jCVoFi15Sku1lC+h?=
 =?us-ascii?Q?9NwXE6vk8FbEDNzBtdLddLUc5VpEgYgE1QPLM+2NY+0h0vf1FYetCKIe5lF9?=
 =?us-ascii?Q?xqkH2viCzTaMVarWfcq7UnJANA5zVYf0TkN9D2BbTxVSVaYWe2GWnfO1sNNf?=
 =?us-ascii?Q?bQhbVruTzyUIECTrFAgMPHh8CoPXVrni9hTU3GjHAmSQ0S1ivKTOed0ofkBI?=
 =?us-ascii?Q?e+vBPHCmblj0HKphKf4RMi6YqpEMb96Oq5xa6GPaIX7S9gymaEVoDoWvL/V8?=
 =?us-ascii?Q?IzvU1k9S54gjtDdDmscqozI7u4Hh/P5xV1GSy1vYtS/LLoaCzlxVSXab/xwB?=
 =?us-ascii?Q?sOgkXYWz0k1KEdsHeABfSkriPyLlkJWyVisLjb1QfXc3o3EyftrzTLPZdmIg?=
 =?us-ascii?Q?OrhHjjgTLTxMUd5VRfhW4ij1wwL5mOJDyhtDRx/XPOSDqGcx9np3xm4ytGzM?=
 =?us-ascii?Q?7ZAABngX+9b0ANFtQ19GrdLxZRc3KwFJZd5MipBhTNG2D3UWEX6MW8ttVEiR?=
 =?us-ascii?Q?AQcETKQcAESIazmU2N2hhDsqaEJzzoUKJnO20sIFnjDVHTb8DY36YVYXqNOQ?=
 =?us-ascii?Q?NvRyTQjeUhrpM3Sgcipb/2fCxs48LvoYKMvpEN3kfHv1rDWuth5sKnh51AXJ?=
 =?us-ascii?Q?D2eL7GI9N7wfy3JhwYKqa8gVliMIUY2deJJIkfAEfkSB7V3eITGG4lIQ2JQ7?=
 =?us-ascii?Q?QOgEWalIl/q34BeyRcihIDhye/s7bB2gTjiOC1wKxupcKccAsRK7l8VwgPx6?=
 =?us-ascii?Q?VG+STJqTGZFrgE4KgwRxm7KA7dVdGCoq7a5Yh+WBwOeFhxPflr0cBtP6y4TH?=
 =?us-ascii?Q?6ovY2M8diKa1dZUxUSjLcvWUKvdpZumeKGZMrvEJXJvg5E40DDPu5+IcyL3J?=
 =?us-ascii?Q?/+khno1AlcLTc09t9nCHbiFhg/zTGqPMJHjD18ljDjdIYbjju6wzDRX0fjmw?=
 =?us-ascii?Q?+HJDlaxI+Jw4Ff5C1EXWFnpFomaMgHAHFbkD1pa+OpmcSa1X++pYvD1Eb/AR?=
 =?us-ascii?Q?yvidui8DR5v11y4uCzTw4Pz5mO3odYUFASBBTS5Qt64a+O23HmpG7EgJ6YQR?=
 =?us-ascii?Q?yzSOAV8H8nz7Qqc4QgQC1ZB0/vVoi/t6wZFsHhfBGH0vVL2XBpJsOpNmr17U?=
 =?us-ascii?Q?lFkajX8CG1VRL5lXB3wyUVO8NV7P2QEEoQDHgsGlm4E+SP1ABgFlj3c4VZe7?=
 =?us-ascii?Q?CO6PU5yd9QByBjUKTRGYdhR1rFo+Cv7knE+A4heS9A0TlcBx76sN+Ipv9unE?=
 =?us-ascii?Q?nGy/Ox0uR6fpCbXJ5O/r4Vw+7HxGBoBpq+B8S9PMxg+tPe0x5JNvtyzBcmpQ?=
 =?us-ascii?Q?w3XiyWRryguLSrWrRE35aF2Fk2r27/VeZz+s1edTek6B+C1AmV5VA0yE8T4t?=
 =?us-ascii?Q?mZvzD6aXlBdrn0p/Gh3cIdxJGbl/1/kvyzrDgAhn5fhuYL/xtj3RjogJoNLz?=
 =?us-ascii?Q?hiiFxydUy5XBm11Ojyi5zUvqTDhn+gI+Uss/Mynf03uuUNor33ihSYc2rAbs?=
 =?us-ascii?Q?m10eITQy3HCCZekUj0K4deU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe5b81d-37ff-4f85-74aa-08de2632d866
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:41:35.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTScE5r8L82Bee5renAe9KuKuOl2AALsOMSQuGnpbwBt7nn8qggpBwx55FUUBTpD+hr/E3HXAawifCBSi4/TPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

The RTL8211F(D)(I)-VD-CG PHY also has support for disabling the CLKOUT,
and we'd like to introduce the "realtek,clkout-disable" property for
that.

But it isn't done through the PHYCR2 register, and it becomes awkward to
have the driver pretend that it is. So just replace the machine-level
"u16 phycr2" variable with a logical "bool disable_clk_out", which
scales better to the other PHY as well.

The change is a complete functional equivalent. Before, if the device
tree property was absent, priv->phycr2 would contain the RTL8211F_CLKOUT_EN
bit as read from hardware. Now, we don't save priv->phycr2, but we just
don't call phy_modify_paged() on it. Also, we can simply call
phy_modify_paged() with the "set" argument to 0.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: move genphy_soft_reset() to rtl8211f_config_clk_out()
v1->v2: rename rtl8211f_disable_clk_out() to rtl8211f_config_clk_out()

 drivers/net/phy/realtek/realtek_main.c | 38 ++++++++++++++++----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 896351022682..eed939ef4e18 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -194,8 +194,8 @@ MODULE_LICENSE("GPL");
 
 struct rtl821x_priv {
 	u16 phycr1;
-	u16 phycr2;
 	bool has_phycr2;
+	bool disable_clk_out;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -266,15 +266,8 @@ static int rtl821x_probe(struct phy_device *phydev)
 		priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
 
 	priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
-	if (priv->has_phycr2) {
-		ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2);
-		if (ret < 0)
-			return ret;
-
-		priv->phycr2 = ret & RTL8211F_CLKOUT_EN;
-		if (of_property_read_bool(dev->of_node, "realtek,clkout-disable"))
-			priv->phycr2 &= ~RTL8211F_CLKOUT_EN;
-	}
+	priv->disable_clk_out = of_property_read_bool(dev->of_node,
+						      "realtek,clkout-disable");
 
 	phydev->priv = priv;
 
@@ -654,6 +647,23 @@ static int rtl8211f_config_rgmii_delay(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl8211f_config_clk_out(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	int ret;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->disable_clk_out)
+		return 0;
+
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
+			       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
+	if (ret)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct rtl821x_priv *priv = phydev->priv;
@@ -682,16 +692,14 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
-			       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
-			       priv->phycr2);
-	if (ret < 0) {
+	ret = rtl8211f_config_clk_out(phydev);
+	if (ret) {
 		dev_err(dev, "clkout configuration failed: %pe\n",
 			ERR_PTR(ret));
 		return ret;
 	}
 
-	return genphy_soft_reset(phydev);
+	return 0;
 }
 
 static int rtl821x_suspend(struct phy_device *phydev)
-- 
2.34.1


