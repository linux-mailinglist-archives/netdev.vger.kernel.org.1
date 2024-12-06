Return-Path: <netdev+bounces-149558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067639E6377
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB202860D7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721B13B2AF;
	Fri,  6 Dec 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IPF2CZ4B"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA610957;
	Fri,  6 Dec 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449017; cv=fail; b=snBV5cGip5qgDtXefRN1nyrn6487t0bsKpnq3qksJKAoiqyB4/eJQT7Pds2gZXH2xSz0zfXDQ1DcR2850jiW9g6+beaj1ZpkX4Htax4XMMGOynJGOau/DCIMzI7sY9LLstumI31YEtpPWHzNVJVU7CBDWzKlRAGI9a74h44pTpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449017; c=relaxed/simple;
	bh=txnYu/QpAtY0s3APt3kO2iYvgZKuR4v/uXhDHQZTREs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KK3FiHGUODUshOp2gnyTljk+ayF1hc5zZ8A6GMTR0/M8useRbyOCtevMUVVtHGddHzKkAjSSZPwx6tI05jfwCF8v3Bnvp+NXOsPAcEqTvZhRfRiNrjepkQFmZFOXCXcu318b0coUOons+D2eSzXKxXXHZ1FCBgcZMVTM6O296lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IPF2CZ4B; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjAcIiflLMka2S68X1oCTfulbFk9kevUH4GYhNsp6rD5zvA1eDzXeshSCp1Qo2iazlkFBysEl3IuYRzgl/U3I8+YfekH7YKWIQZoP7LkPZxsjz2NRpTQ9C1tslFCdThqs933hDioK/BRkLVGp1Guk66sv9LR7ctmJc4Xt3zZWc8z0+sC4Nivq2YmChHohOYFq8f1yiX09DVjYLC401D+r4tsZfORCidVQegWTMHmCCjrQVfWJWzrLBDVhHG8CURGxHGz/Qg/M9dTXhl5B7xnolsGQDcSitDMN7J5f1r3CEVz3Q3bbvouSd9zDAJEh+txn0gO5YVavyetbjISVqpWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzshkbMzHpP1IrgsSFUhQ1czQLV+mKwHnNUsmg+NnyU=;
 b=s50iJsVA4CSTPbsXeLtdkiRUkoamvHSO9ACz2KWzxktwf3igWYw3G/jqU20O9jSv0fDaw4IYXhu3esu8WTo7DFSF2Kfwc3off5Vgg+dRZPRjrPzF8cPHdBvBJdm2KBehcZPDrvnmXwxNMOo9mNWAXQ5zVPhHxLM7w1yMEhgMFWDO1Yv8rNHQIjTtdwgDH/D2vGeLn7YZwq4CKLz+JcYFUZh1l/2fhUn24YckwRBRLt3weCMP/HVeF9Nu0Oeh5I5hH5EJoPatmTuxsmt78wm3YjUqBSKkM3pfMw4Mboikxz6XcaazBcItmNzNHXrOlTG6KctReNdqKm9PRhjsZzyzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzshkbMzHpP1IrgsSFUhQ1czQLV+mKwHnNUsmg+NnyU=;
 b=IPF2CZ4B+arOJxZZNwAB9AUTzO/wTRcohVR+QNK/QX5eHtAzA3KwbN7A5R76PXA/W5tlaE7TW8dJPJAk2Q50SCY6GC2Jgr4jBO3Ry9wbqfQzW+DyNlvw6wU9kUo+FPMLKVBwUZD9GaN9BQnT1jxVWXVfs3nkCkNLbxURh1cYHXeiPIpCTIv9BxCEQUEU3VcfOQf4JDLAxMdg0VlOsyLWBQKzAe7U4OUX4eHIS1B0l2JxhRhBhSmY0POmyRgsf84+vb2ePAfCwPWWZOl6ujSz8YRXzoC0N247p/g3+9AcH3zEyrgNjfahnIQankPvtrKN/3EqZGv40DhFl88ZAv1FbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Fri, 6 Dec
 2024 01:36:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 01:36:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	heiko.stuebner@cherry.de,
	fank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net] net: phy: micrel: Dynamically control external clock of KSZ PHY
Date: Fri,  6 Dec 2024 09:21:13 +0800
Message-Id: <20241206012113.437029-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6db4c2-290c-4e64-00aa-08dd159674ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?91M+2faGqrg769PMgKvKuqvoyYAiV5dXpsHUemHqwvhjzSrP2+8BgIo5BDEL?=
 =?us-ascii?Q?S3YbMvMiUN5MfIvRfCHFklhwTQ+rSGMgdqY39dXoW//dqj7w+bvy4vBM+MaG?=
 =?us-ascii?Q?5cDAT80Mtc8/s+pamcST1EPXN5hGRflsg7lFngzg+aSpTROK0D3bwYn8IoQF?=
 =?us-ascii?Q?NvhM2nZQBzI5N9ZWtG3IGIqQB+fSnNHrPFWeiCzj8BJafZ3LAdv1PGRrK4Ha?=
 =?us-ascii?Q?xpMABJR/hVKjrf2MurLNrR0vEz2JmjLAdMtCwuoTqHuB0rsouXPGxJJ5mF7y?=
 =?us-ascii?Q?SOCwoQb2cZl9enXkv2gFveGIeODlIAqUco7HeUg7HA57nAbp59um3ZWI5OA6?=
 =?us-ascii?Q?VNsUWZzf0Kw1NPSjtMlWjMHYlT5+QngV0Qzk5mGg4fzDijg52cxDHQd23/Jz?=
 =?us-ascii?Q?GzH59PkG2hR4bgFKD38pZLmTILX0JoxOZMZxDSMPpxCTpU0Uzk5p4ylAUNCd?=
 =?us-ascii?Q?3tMy4cVvrXkHXj4J4EhpmkpFB5SULNtg7aNnagtky1+8bLqsv4InQO6s6lWS?=
 =?us-ascii?Q?ciwd/FSs7WYWLEJ90qvi9NEjYkQ/+JNP0bWGpCZo2zZpqjF+gHwUUvDeXs9h?=
 =?us-ascii?Q?jsUFFVwz/KWyzaH/vM/UP/cGPWMirs/k0Xr97ovNEjZ3SoOZK0eSLdIhZSWJ?=
 =?us-ascii?Q?14rdUZb9TWaWxKozHKCrmrMnjmAJAEH+DgctFHBZcjlQ9sAwXUJXZjogqFa9?=
 =?us-ascii?Q?RQqTcmm0TBWQoZ/kURxbhbQOYcpTYriQb8dVf888xIyewiughd4ghx74mbVP?=
 =?us-ascii?Q?ZyWThWvbrNQ+OXqlJiOgnyxN70tmCeC3deQSidB0ESZdphRx4LRzcW8hmxnf?=
 =?us-ascii?Q?KX/gpoTB41J01FjvBz917vFfBgxlhoDeZABx076JtfSWIjyQHdEA/Lc1Zp0o?=
 =?us-ascii?Q?CMG2uUFic1yRggSXWOw5xVWXaQKX1QdtUMOqaofvm3hANULugUdligzoNk+7?=
 =?us-ascii?Q?RffJk51qOQwHa5xRuYZwh7JPJfKmxX8YVthdbF2ISyoHtwAL4m+LM6QIJNN/?=
 =?us-ascii?Q?GzPBtgrw7VBcGQeCGl2xKWbEy7fod4R/kC4t0Hfx3JIMkmi37INmHerFK6Wc?=
 =?us-ascii?Q?efS/44gb+1eXDFcrNQRFDvg7rVOqvGEfe56zzkkzii1HhDaQ509sont7BwEZ?=
 =?us-ascii?Q?P+R1+IhmaE/MRTlhuHouR1b5CF6mGiC6pTi8y8eQ9pBuvSpK7APFTrciahOt?=
 =?us-ascii?Q?R+qHMnND7yRfMZe6IYKfji6EI6b8h1uS/ZVsNI9BvF2mly6kzrp2KeWYuosM?=
 =?us-ascii?Q?UBlBWiFpUKj5Z19nhBECkZp2h9mX0961s+SBn+kxqxW08sZQXX1dHf+Y24vr?=
 =?us-ascii?Q?7qsgy9keGli5ybptO1hW9T3XIaZe8OraDkY0MjTNyJIZaR2G8ch4IWB2yXw0?=
 =?us-ascii?Q?42c+wwx1vQyQ5RhwaeZ49rpf8tHZUBBqOoXd6JKRtOuhF0wd8Ob8dU8Ff00D?=
 =?us-ascii?Q?40QkVY90njM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgM0LnwvVbHWCg9+Rph/ep1GjWet/GWSvcTlAChRiJZexgF9pcMLr20zHOa4?=
 =?us-ascii?Q?f0ZyKCiG/qDpKnPz6IHLzB6BltQ94VnVpr9raH0FYretmiaVc96eEw7sjbGI?=
 =?us-ascii?Q?i527NC1LDDM+LKTzedmQ98nRDwFjq/o5V7snBtBwF6F6kcMOwBhACElBYJ8G?=
 =?us-ascii?Q?GfhEIbxDLdv8ZgD/BqTFmcr9JU7UcS4fGKcr1SA7JNhKh7cRXDsMksjZWGAY?=
 =?us-ascii?Q?sWw+8G3vl2DoTAmKOW0D94jm8WD/URj2pKQflqF16UnFKb3zz1kl6vzItPkn?=
 =?us-ascii?Q?O3QolLmrIGfIAB58Etuw0Rx6bmDwBTaXe1DDcPMZEly3M05RDiTuU2//fJZz?=
 =?us-ascii?Q?Ef3rKkmUtApVWssR13oCiSLyJA8vsVj+f59IzKJrF5uexZj3Lv7JYMK6PG37?=
 =?us-ascii?Q?49WIRUk/mSt6To4ybOip77E8wcW+nLA1totDWjJ9xAtQScYa9BsEMTXEVh+F?=
 =?us-ascii?Q?D9nA8RMtBCd/JY/M0IWfeK8vJ/2BAGIjI12ygpb9DfoTgnnzB506DsFcFwzC?=
 =?us-ascii?Q?UZ1YRNhpNqi38JcTJrWTXfNb5Hcg2HpkRvs+0c8TIFhqWTX2HD2DnaaBpFCs?=
 =?us-ascii?Q?JLGChIN6fz37TWMhZvZipfqUbu+v37/8wtWdWUMfi78cQj2NrBGItJHn6jzX?=
 =?us-ascii?Q?xbCXOISLW23ufMRnMdXOY+dgeSlUg/CLloxoJkoQ6pUSuparBKag8PGCGQ2n?=
 =?us-ascii?Q?Y1yIgCsUIsta+8qdY8vyF1cLOBB9RajyfCQ7e6dhsjsEwlos3C8OBPs1Ux+w?=
 =?us-ascii?Q?j32tqt/kCxTxqGDKr2LI/rXjIU6b7Py6whLxotkeAClEtBjbk6yt8aqUsTiJ?=
 =?us-ascii?Q?nyMAoeh+HFKCAzQoX2bkiu55uONqIbvEvl1wThfRZybkB+1c2M+Qx7gt+BkP?=
 =?us-ascii?Q?xS/fCBppuqRkTNYQYF4tQyhVr9+NeC1cLqTafW7c801Zd1o9Af+zzrBUW3Ha?=
 =?us-ascii?Q?43B/zWK3hOxjVlPTjtgTthafe+xDtCUnCPqBY8DDFoD7nEcM1r59uSKcbtPk?=
 =?us-ascii?Q?sN/sn3AjKjSLtFArGbRQMDM5gIzJksxogwLhtsVozrthmPDW3G8hZ4LNCxAY?=
 =?us-ascii?Q?I3ahzZFwGPNjzGfS+MkXz7Uh+nYtwnrVd5HId/87jRUNr35jk6/ewkr46m0p?=
 =?us-ascii?Q?QgYMkGTySIacG5nKtZYfy35uQcXcQ+6cmdpRPd1Z8wreHXN1ZM2M3sc9ISPq?=
 =?us-ascii?Q?PTYNTZT63+njMNZXxFJ22HMpo+xyC//kvNXPER2E9SyC6YTWqOQ70r/2aKZC?=
 =?us-ascii?Q?NqR89lXDkbxkRI4KqklNpo2NpXSyC2//zA82RQvAfUBkpiH7xXp7QZpnXpDP?=
 =?us-ascii?Q?SasTz0cxW/rJOvRW4Rr7xFuz9RbUU6aeiqUvxpu34qWKui9WYUNWvlfq9EEo?=
 =?us-ascii?Q?J9mFE3NkyeEBoECp2H+cVCyVg3mIImLTnEdJ+pAudkL31FcfBzY1jnqRqbou?=
 =?us-ascii?Q?8Fflp93ivQ2D9KDwQ26xDNxpDFCm+sguoPa5MnlRasoymPVupkvcYKPaNq1R?=
 =?us-ascii?Q?+wVdwg/daOMyo++5Jd4Y3vmpXDVKn/cTbhPjGjbBYKdIdfuHx6zzJWszRi7W?=
 =?us-ascii?Q?DLELGHm72iqjVU50YSOdH4C45hAjOxrs7OQRmkBC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6db4c2-290c-4e64-00aa-08dd159674ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 01:36:50.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt6v4n1vxIJo9YOIArTaIs0wHLMc6TA+NnM8gXq1pXI+Y0NvrBAr8dX9tjWgs9U2DIymM/nJxbK4uh/AyeiRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233

On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
clock sources for two external KSZ PHYs. However, after closing the two
FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
not 0. The root cause is that since the commit 985329462723 ("net: phy:
micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
external clock of KSZ PHY has been enabled when the PHY driver probes,
and it can only be disabled when the PHY driver is removed. This causes
the clock to continue working when the system is suspended or the network
port is down.

To solve this problem, the clock is enabled when phy_driver::resume() is
called, and the clock is disabled when phy_driver::suspend() is called.
Since phy_driver::resume() and phy_driver::suspend() are not called in
pairs, an additional clk_enable flag is added. When phy_driver::suspend()
is called, the clock is disabled only if clk_enable is true. Conversely,
when phy_driver::resume() is called, the clock is enabled if clk_enable
is false.

Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v1 link: https://lore.kernel.org/imx/20241125022906.2140428-1-wei.fang@nxp.com/
v2 changes: only refine the commit message.
v2 link: https://lore.kernel.org/imx/20241202084535.2520151-1-wei.fang@nxp.com/
v3 changes: disable clock after getting the clock rate in kszphy_probe()
---
 drivers/net/phy/micrel.c | 101 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3ef508840674..ffc2ac39fa48 100644
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
@@ -2221,6 +2272,11 @@ static int kszphy_probe(struct phy_device *phydev)
 			return PTR_ERR(clk);
 	}
 
+	if (!IS_ERR_OR_NULL(clk)) {
+		clk_disable_unprepare(clk);
+		priv->clk = clk;
+	}
+
 	if (ksz8041_fiber_mode(phydev))
 		phydev->port = PORT_FIBRE;
 
@@ -5290,15 +5346,45 @@ static int lan8841_probe(struct phy_device *phydev)
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
@@ -5358,9 +5444,12 @@ static struct phy_driver ksphy_driver[] = {
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
@@ -5507,7 +5596,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count	= kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	.suspend	= genphy_suspend,
+	.suspend	= lan8804_suspend,
 	.resume		= kszphy_resume,
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
@@ -5526,7 +5615,7 @@ static struct phy_driver ksphy_driver[] = {
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


