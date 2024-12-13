Return-Path: <netdev+bounces-151797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7879F0EBF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB652188F238
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B81E25F7;
	Fri, 13 Dec 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ALeqYb3y"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDB1E2842
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098969; cv=fail; b=NcvJXcS6+n1gUlFV87otOWKCqX3TDHXnPgcOa2ohh5nKoK3W9cOMsZLiVugV74NSH7sV3zmjWHCePvybZymugUC6yCRy5WbXXsut51O3KlvdSblAe7zuUOmAB9aaOyCJTTJgUtWCRRT9UO/Jhl3BKRBAeSOWp2TNnfkPhgC3jiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098969; c=relaxed/simple;
	bh=g0z/eB+HhrsFEe3l/6HUyienFzCU/6hkI670+Qm2Nxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E790WXN6SC0fEBt2k8ambJM1Socjy/zz/nPctYJUXxESfBVA9UTR+vHN9Z2BmNULSL14NCzCdkS5TUSB6iQDA9eW7WF5s+S2OdMU/9eWHYaKJ0lUXvlppQSsH0n8PWjhlgArFUeKX+PAdOF9EpwfHr8V6M4sGDIJkvgw+CZgLP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ALeqYb3y; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyrrqzWbef1nLnurXCwL9KBNyuP9J0QMKeBFmEl7SvSaA9zKY27ujW47gUgSZnfV6O344+B0YJb0oXINdtiaKBzhQwwVX6c56vFgnLr5dEwtmEL/uxK1qfv8wPDuMdi7fUMyavLIQTuY9eX2SubFsfzchK/XMOA5RZoG81AgEPP32OOyZpnG59iK5sAlXpRrRbieaobxyJsPW+9aWjgosRefbTsJX6V2o4+DVsItd8tZu3GULmlMOGg94dXlXj+VPT/uiYg8JPCveWF2kvJCqpzMpw08ScBrcD2Oycz3/6+Ar9ebXKD5jxHLK4ux2vixRUyxvDoFDT/HheIb23p/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujhfYqDZFfdpQbZIUEhTvU5d6WBNYCPoYd5uQmA0knY=;
 b=NNzQU2kzxGE5JCgSUA11Ayv9pg+FjQEef7ZhvVWOjphSUb891WRrmtv+BGdmy2jL8l0OXl2ubNk36KkPosVb9pB1LwXMp4Oyg3MkeiyjRQzZpEfhall5FPeTM4nrTladnfQEcfgqx8s5eSlWMuuOZdl1fjBbf4H14GOPfUkH5SZlycpXap0xsh4s+A/+Xw6XwERETLHgTYeDxJdj0GJ6AguuIkaYX2ePdRdpRGTmGrRR7Pcyw9bTVE1Z3R5IKFhsAFbPsLP34yDt7cGVF0Kv9DnSbq7HX48ZayM3tQAR9ZFzn0kLwy2WejueJc58errx7pOGcCyGooGFv7QNoYlyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujhfYqDZFfdpQbZIUEhTvU5d6WBNYCPoYd5uQmA0knY=;
 b=ALeqYb3yn1JgUxvWudCQdiC5Y2WEjF12+kratHCHRUiE7amQLzUkCm/vd8nSzDmNfnRFIZ/aRFwtVB+yC1kzJh1eUfz2AlA1cn4vS94Jcq2tVwTC1AfHV6X3H6F9qfvhUytQ2m83kNhJax9Tj6mhiBa2r2ahJYvPC9elLcxFaKvBek8Mzk3xNNLP8Dt7wj5i9Y9OpYoihnQuMpTb4pf3RowfGTx7WIGhzgKWlIiAWj3rBj8jnCHzLP9ITZSvYqUStyYMVI8tiSPupu2IbkfGz2VjCFxHAfqV6xpNGd5u10LGbRR4mpbxlCs8wd+XvzrbQLzu6ROaczm3u1R9zG7mBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:09:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:09:17 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 4/4] net: dsa: felix: report timestamping stats from the ocelot library
Date: Fri, 13 Dec 2024 16:08:52 +0200
Message-ID: <20241213140852.1254063-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
References: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfa0c5d-9e29-49ac-3ac0-08dd1b7fbb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iXIlnY2+EAaDQZckrwuTPc7feO21YstVlFFwGLoki8K5UZzNI9srNugohZBT?=
 =?us-ascii?Q?S939Ae7voNchSYfAa5xWRGSIQNi8SvkIxWN4ZbyGbGHOAU/GrWkKsH35n9Tm?=
 =?us-ascii?Q?FgEKWnsKsvBya1pCw9U24X0s6yZv8ZiwrEbjHLatSCeUH4OMWWrqXRGvP+3r?=
 =?us-ascii?Q?5I3apeIiotoanYujYHEs9PNEkWtfB2SenuMipLPfuYKRsPopfkbngvbcYb8K?=
 =?us-ascii?Q?7XF2y+9W/csNe/NnEd0zHnTa23WxFQpkB/J3wLd/QQFE3SOtp20HuOu0xini?=
 =?us-ascii?Q?cag1yRTQ83ZuJbAwUMu9USERaRMpLpcsfhmHkk63aEgoDC2w/8TTnR7smXn0?=
 =?us-ascii?Q?8PzVaak7A3Y2JJjURw/LXAJLT27Qd9CQdrjYlSmS+qXfqniVn724RpkOef1y?=
 =?us-ascii?Q?R/iIwHDH+7TvBAa1YcwRPGIwv7mHxfWbF+7pHo0lTOjB/Nva4pl2KMiBHmfG?=
 =?us-ascii?Q?7oQ0u1aUYfVhaBcIVO7r+TjX5q1SZZoLGWB6oSzEIIzm42ceTxr7q7mNjLsy?=
 =?us-ascii?Q?s2APNDEvhZkBKKFHGSPNwXfEcZ4OzweZiarzPQfDhRIhnuovqeSEU6aeQoAO?=
 =?us-ascii?Q?etAGIsXoDVjchpRI3cZM/+9lWW8HTcSniySxU0ieAXrJgg1wVi9VnUZVCH2R?=
 =?us-ascii?Q?9cEe1XjJ2SwhhQzkgE4WM1eK0AjDxmQrvfvM5JoTpJBESCVM3bDhyxY9XlHG?=
 =?us-ascii?Q?iWDmK5bwjvgKrkcszVM+KEEysKxVTXp4JvJaSVaRduhAURYMVTI5din0cWG6?=
 =?us-ascii?Q?wkgLuiXbfMLJlbLzwe5CXqweBSW/6xtkn5b03cPflVNrWOTH+R1R1ZtpGONV?=
 =?us-ascii?Q?yRcPyefsA5VEw4zrqfA4+UgFFdVrr49RwxsUrdv2zbp1VHdLQQlbIQn/E6vb?=
 =?us-ascii?Q?Z105mH3Brdd7+IPdbiQ2N4+OXyYgWKFuZiL04u+Uu1qF62j+P3nAGglXbKEt?=
 =?us-ascii?Q?8YKD3IquTILFgelK7nV4idxWUImbG0sZovLeQpg8rr05B8dwzRsLgrfhcMVh?=
 =?us-ascii?Q?+jgO9dE8x0FVAzPD0SuUCAxTxU+ClDIwZUMqyMLWElSl2CxNNVYvcKjWHX7f?=
 =?us-ascii?Q?Q1YTgc4jpmrYOT0PL/US4dhzxL/unNBN0vcdE+VsYGyvWO/vcgVz4LxIPeZ4?=
 =?us-ascii?Q?ptV31J/ZBCbvTOeoVYDYthlVJk+fRxO8+db5XMerjR1PGfydi8WdokC2EgC+?=
 =?us-ascii?Q?rGJDVYU7+NQN5F8kH6WHU4FLFwiHpNQf3MH18f1MDkkTvUWWxvn1CLBSJXg3?=
 =?us-ascii?Q?xZZclL58291J5WTLkp+HcllisU7muWdudh1S+KLwrABpwzlR1zm2h/iGUO/N?=
 =?us-ascii?Q?XWNsZmF498iDo7hlzRzcLCrUQuIxnnp2q5Qt+1/mkMBFqvrvHggdMLm2hG6g?=
 =?us-ascii?Q?VMz8cdNapINtXZ0jdgFXwU+J9xOLtGUGzgk9z79QjV9RaNU7Yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qteigv/CZ/rYMLQbg93sz+ngRvTGCptGg/wpHpyXYFUFPJTjDCqMIN9DLNFB?=
 =?us-ascii?Q?Njj5bwx2/C5gEj2U4U6SK1VgdUCMV7/bUlI9FF6WsvmFBvsaVwrSgOs9AEw9?=
 =?us-ascii?Q?14FTDMF7PGB8Eiie4zda57SoY/65rH0ik8lA/I+zlzIyfdwdufC14zzYyOMK?=
 =?us-ascii?Q?QQ0ICIl5Wn4U4L0VSr6d/YiTq2lz51tKV58mp6kUQ3ir/ATsU3BuS6ikuFD/?=
 =?us-ascii?Q?6Fhq/kHCxryUze469Kqt4MnL+4PNeR4ZYiqpFrpU2Z7dsK8DWPtt4BghpQLB?=
 =?us-ascii?Q?UaOkHZC1a4HURtGLRcDV1RD3ClVk+mgaKx8NDng+ZqvOiVE1Ld9aTYMFSRQ/?=
 =?us-ascii?Q?o9UrtmuPcWFebRjSn9pS0OdyGhufR5uDU/gg2H/kBeI3Bd2jZ3T04xlp/1P2?=
 =?us-ascii?Q?wUfrSmQfxHUeFtXckbIoc1eqUMijYsfYmveqz16CI4NT8uKDyIY34KpPBt1m?=
 =?us-ascii?Q?iHfK3sBnjko9iOjYCKt2g9/Yr55W8p0EvpeP1FUPNtT1n2RUj/019fCDfpNr?=
 =?us-ascii?Q?jxZHbr42siU4kDH8A6Bt9GHUPS2VecpOWOxBLAv0LbgPU7Nr92v9uFwxcwVb?=
 =?us-ascii?Q?jSMU7pTkXRylfTDce2VajGOwWCoKBEtOk+UjPrsTWNEwwsninpaRJbUhyLMV?=
 =?us-ascii?Q?5WQQNM7xdsFRkVLwsk1AIfJFktB7Jm5ZsrsEkbFKpAJzjak1zSqGzUg11wKM?=
 =?us-ascii?Q?TuiPH9hYLW2j7sWNR7Po586wYPi5tm/h3+45nLTIgUW705qbQlCSFMIZnN/l?=
 =?us-ascii?Q?eaQjWBr19LQGfVbBVbOIj2GAEuRphvGEVc1yQ3P8Iu6vBv56Oyg27zo17vx3?=
 =?us-ascii?Q?5iWQ/h+Rt2mcGNpkm+Exe8CkwGloTzwLTUjgPTAuq3w4iwnu3qsoLLxJaBny?=
 =?us-ascii?Q?X8/VtYK6BExa5XY5Lzuj/BKnQivxro7EC2Riv2/PCOoao0v+7XFH+C8Qrvv6?=
 =?us-ascii?Q?42CcI9AYaDzfra5tkbT3f+3OvTcjeUPXkT9h5JuyRTGanWr1T4yzyuCYcu0P?=
 =?us-ascii?Q?pflXJiPk1EmauxkTPeihDUFYPlUFUwKVLfaU/F3iB8zZgBwI6Dbw7bL0j5OR?=
 =?us-ascii?Q?4PHEiHafKPUddNEfNTisgzX/4XE4eC5RZWbSLVPvM02OQx+5TEhEdy1DheZP?=
 =?us-ascii?Q?nO2gTD+hNOYZjeEjaVr1WTzm1feq2D2GPzH91OINHew2rxLfTTHS/Z9R6Wv8?=
 =?us-ascii?Q?Diqq91o33Gd2kN9hit4xmK4/XM07JsqCJYgWh0ud6UylBq75RwbvAQ7wkCn6?=
 =?us-ascii?Q?sovqatZUFgCwm1/J42/7AiHWWcIks+ACIBO/QOSY7IHQ6FeNC2gWqKXhwfb+?=
 =?us-ascii?Q?U+O9n2DLU+svQqjLF1PA1cjlALKeySjqqRfY70+p5XznU6VE1GIg4y22IYhk?=
 =?us-ascii?Q?CYMPAoIGQ2DpjwfxCorOrs6p4CKsOrVo+vXHK/6buM6MsebP42cBWnOxHUq3?=
 =?us-ascii?Q?+LTJExdZTrkv461lcn+eYHwYIpyDW1Blll2Bp8x3Y/ks3LB8RsijSVuf2obJ?=
 =?us-ascii?Q?aqiqepycNaRmC+t9eECv4v01fsccC9OnujN6gmm0SLplC1FgsxfXjz9emDr8?=
 =?us-ascii?Q?xu+DwMqzxLn/ew5/Mx+vPOi45OAHR28tBiHW/qabytorDD+/zTQTh1ov2Tt7?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfa0c5d-9e29-49ac-3ac0-08dd1b7fbb58
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:09:17.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj2tFNbs6dEP4O4t8MfSaaudThZN1Ygmu5b27EpMUoRIi66GYeNcjEdXngsnbp77s8XP5/1rQd5CjRwSwQrJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780

Make the linkage between the DSA user port ethtool_ops :: get_ts_info
and the implementation from the Ocelot switch library.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 3aa9c997018a..0a4e682a55ef 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1316,6 +1316,14 @@ static void felix_get_eth_phy_stats(struct dsa_switch *ds, int port,
 	ocelot_port_get_eth_phy_stats(ocelot, port, phy_stats);
 }
 
+static void felix_get_ts_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_ts_stats *ts_stats)
+{
+	struct ocelot *ocelot = ds->priv;
+
+	ocelot_port_get_ts_stats(ocelot, port, ts_stats);
+}
+
 static void felix_get_strings(struct dsa_switch *ds, int port,
 			      u32 stringset, u8 *data)
 {
@@ -2237,6 +2245,7 @@ static const struct dsa_switch_ops felix_switch_ops = {
 	.get_stats64			= felix_get_stats64,
 	.get_pause_stats		= felix_get_pause_stats,
 	.get_rmon_stats			= felix_get_rmon_stats,
+	.get_ts_stats			= felix_get_ts_stats,
 	.get_eth_ctrl_stats		= felix_get_eth_ctrl_stats,
 	.get_eth_mac_stats		= felix_get_eth_mac_stats,
 	.get_eth_phy_stats		= felix_get_eth_phy_stats,
-- 
2.43.0


