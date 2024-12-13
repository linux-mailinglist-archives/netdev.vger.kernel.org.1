Return-Path: <netdev+bounces-151796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75189F0EB2
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B44282917
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDD21E2821;
	Fri, 13 Dec 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HpOWDhQN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F511E25F7
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098967; cv=fail; b=VBNDnIcMJmUzwGFZ1/3VC8U3MpRhHLLjEXl04n5A9ras0c/Kao8dgGOvphrxSBSQTll607hjWi7pA6U3HsCMhjXFIh8o0/dhoUBSneQzuKUvu2n+vt4YQ8sMG0Jt0M4gldxrdB/OWhEeWHJOrycLuChr0Pvm4FulWkyLTYjMhGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098967; c=relaxed/simple;
	bh=sq25w2p8WcoztDuf+gDQiaKyRRG+OB+a2fIwRuWxG0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osYMyL5P8H9x/xaHHl+fTaf8GEBFcmnm6qGtgXTGU1TcSz0dCgwifcziybEYjCVNnFnhciwFlpN8nLPp6fV9yG3mBipz0FyH3D4ZA0ZgJ6/iuf5OHieFv593FFBRtVhBrPrijQMuLM+pamhhZlQDZclywQZlldy9og59ufWY/rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HpOWDhQN; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkaeGum6emGzJfuJqJa/XzyFodpGeDMqYjyvryjVUqONJThUkD35eUs7UlrQrISx/dEcL/9j8iCQO6+OqKwM1dz/t07wqE+V7rsAQJLAEg9Rijpaqwe4ANFE79lfV2bkyAiebi/GSrYKPEG3BHkJSDG5WwurE6z3DFvj7vlFjzEuncMgiq80pG9jPS3cv70jUMhqk8n9sFEgmAA8ouL/BbWanoLMcCCq5rgIGaqbnDtoM9A2OfWE/jrxFW73AfTYGIDB2VNca2keDvEAnH7x6vyJHulwpvcQP77u8evcK6IzKtoolXEXu93XJS8RrQYrqQDVo7HMJ4jGOcJC5jk42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIGpp+DXATI0t22DkGbXmzaky5X2aKLI8X8b6Gnqcso=;
 b=sF0hl3xWhqdLmOT6GFhRD4JGlaJWgeKvTnw/mIBkHEMX972a86rZ7t4stS6827B3YQVTTAQhiZ7QspQcjWhZG1g591uCFwPvlYwyth6B9mEGiVoedNKWxq/FbhPCBh8DCCQXAdpLnpbJGG4ksgF1sjxqKYQEmGPLmCIFKum5bQ0Ro2VcxUCPBt3CO7+oErofoqInaCBI+MBuN+i8zsDbuAZJtfRxt6PKKWTxvlB+lSDWHEixK+FJ88WTJQeJRX3auQvKQUr2GXgqwi43HFKce1Lh2ND1lSbRKfABNcdAxaVxHrz3ZRs2bEKAVzHQK0+p/z3Ui8v7HAdlqa+euSRfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIGpp+DXATI0t22DkGbXmzaky5X2aKLI8X8b6Gnqcso=;
 b=HpOWDhQNA8dtHCXjV7XQwGS4c+gkPdl9Q1MrDHy3U6CoyN4ZLUn/hZ5HyVzUROiMTnN/zsYpkMsC1UuKOLbK/tzrrHu2laor2S2RoJj+QjqNhJZ+cP90Dcyp0kUeKx0ZCe0qoeNMA1a/bOapukBPEw7ZuUvOzlSuiGnug9Q2lpmT1g2IIK7e2RoFQWc1WSufkVcoXNvRM5CXGNHjJ7DGoap9U/mbltnPI6LtaDWJ9vt5Auqt+vbAwGgHa5ANaThWzalaLDY2SaTzWTUuElvJOJi33aE7j9VXHMa5MiJk/H1VWkhfCdYRfPwO/JlT86aM1oIgHy7frYKOlz/5QMmD1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:09:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:09:16 +0000
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
Subject: [PATCH net-next 3/4] net: mscc: ocelot: add TX timestamping statistics
Date: Fri, 13 Dec 2024 16:08:51 +0200
Message-ID: <20241213140852.1254063-4-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85ab70e4-c0bd-4b0a-05bd-08dd1b7fbac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6L4CBrYICzdEvD4u5YNwuQ2D/X1Tgy6OX0m5DdLtUY5Y6OE2VJi5lLBYfm5H?=
 =?us-ascii?Q?Y/GLtUYZZhv8OIAvkpwzmRWFNtf/nhjqwyH0P9xJqBNZhxE3ApNDlhr2OoVT?=
 =?us-ascii?Q?/UevfX7C0p+cnS4hawD7pQrblDEQKHoB3QYgja/0Og1Ms6ci4pn4EG53ou+8?=
 =?us-ascii?Q?r9HhOoUvZ52YKdYSZNFwD0CmZ1tKBd8c4A5mmtbVGw3SuDjejX7rTc3wqcZk?=
 =?us-ascii?Q?V08/4GWs5t0OSvL96db6OGfaXN7QX+2KGwICraXeB+q2Nu9YRWqayHJSBb8s?=
 =?us-ascii?Q?3su/+a4LBNAjBq2v9iduM00WdFRmZx98Tigu9Mkov753KFiGoiUYwX7+PamO?=
 =?us-ascii?Q?iIek9qiBMUZoOcEz/HS5t0gNS7N+ZgoHc5x0QtajpeU8y/febENvV3eMRnaV?=
 =?us-ascii?Q?7rrowE8aQn7RYHUEUxwB95CR5JaqSEPX+K6CG+EGA3lbAIB4Zb3aHvjrjdm8?=
 =?us-ascii?Q?dxS38tVTmzfJe8OmedhOn/QtqlOIdz5DUTNEeGgojjFdCgxKNZmga7xbr1w7?=
 =?us-ascii?Q?IdCK82SXdCreDKejnbe7qCRU8FjXsx3y6/CAMAM5f376JuLKcUxwkV8qlz/p?=
 =?us-ascii?Q?W6/c2IvKU6+v+BUBMG61bHMcmCcKhOafbcjTo7a0escfS8w+TmJodJvNnBkn?=
 =?us-ascii?Q?pvHpSm6FHE4czKLenFDTlpRZ+j44xznub121BL6SWPWkG0sSmanUW/YH28/D?=
 =?us-ascii?Q?3BXhfr0pmdJa5negPn9T13TcgJE3146lLdV7f/03fsPJZz+Iu9wEwWcFYh+y?=
 =?us-ascii?Q?tsJIosV6RJ31GTEig+aExsmensjdMxQHJW9OU324BXjRn9++EvA3Itz6JT45?=
 =?us-ascii?Q?I00pAJg4kR1nI2+N51mxeuKQFmfni41nDCZqQzaSgYR/OOlD2ImORzs0yyHr?=
 =?us-ascii?Q?Pyd69QACHQL9j6Gg44am5G1chTwBxB6ggltAqyaXCRR2H0P2vtC+IFzSedLN?=
 =?us-ascii?Q?c3j90c+ZZx3sJBoa1hA8/aVRTMJczQyX/gN+GdSFQryFLN4BwxPa2fKkd+bu?=
 =?us-ascii?Q?ZHILomjaAYgQxMiIGze8g2m6dIWRKe1cJICCZvPBY4fIHNLQ8Mym76xXBo1H?=
 =?us-ascii?Q?1jULPtOtwuW5L47h5SDTsWVUyHsmsEFL/8hH0ED3tzELcZ8auzx5/xjE7vzR?=
 =?us-ascii?Q?CSqSnq6kB501aFKyPMpmvpokR1oJWs1TYVb0LgzwzsalYQOzvbWCvUTgLGcd?=
 =?us-ascii?Q?H14pu5sRS6R8qTeUSuGITy6aPJFbFdNVzQoumO496J70ml4AzXdQWHrcWsWW?=
 =?us-ascii?Q?LqqY44uglCbE28zaSAM9cT8+5Shqbs8YR0FWlkJ14C0jKdvVzyWXxV2Z/ZgO?=
 =?us-ascii?Q?u7azJ0SzKODodhmatSD4E4IU+phpk/D2oxgYq1O2InHDrVmAhQAteHL5JOL7?=
 =?us-ascii?Q?iDhx6lSkEKlr58xYv5O40P9UHGweqrTMzy/8dWAvYRPXNmkadw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1M5hEF6cP2+pVRqlQabdCso/ZCaHlm1+UCmOEeeWj/ZDEpEWmVP0XxAvpMb3?=
 =?us-ascii?Q?GmY4XNoQBWOcewuMDXkqmPEib/FoyBFbPhR2/9tnzpebjno3Q3yBPbJtrsyk?=
 =?us-ascii?Q?ITqS2rjfp39xztkzXBSwacugPn/R5dZeJc8f7HWbN0sR/QZ+2IQNujIF4w6f?=
 =?us-ascii?Q?3G5WZsu3NiN+sFzkaR+JCk+M37jnZzecHVpQSE6xuxDWu6ssqX3+pQ9Mbt1I?=
 =?us-ascii?Q?GveaO5ulGQIHzUEJPNuLu7EcV87rAfDg+xWJBqdzMfmvWzt+4O0eYpHqUUtN?=
 =?us-ascii?Q?GbRdpE4cHJfhG+83UzQGwiEjFjDT+ptVCR/LE65fZYAsmvsv5uNXpwgzedsz?=
 =?us-ascii?Q?jHGmP4SSk1kQv5vNoaIKGEGHMF5EeaFchc9KqqibXnTxD2PLPJTDTwneyn6T?=
 =?us-ascii?Q?y0W/ggNLx5RoFQz20L4Kl++zhR/b/HGxyqgNMjd3IkjkIy6As6Re7zTZ6qv4?=
 =?us-ascii?Q?30d96M9oErv+ntFxHTsIgU1igcrtDSg2ExlQjwWrHTmueuSsKdwoJvVC6uj9?=
 =?us-ascii?Q?FOMlgw/Z5RyfzgjE/0h0waARujuJPazNyKrj32A3q5Pl/dkIM8/KUiFQpKBw?=
 =?us-ascii?Q?wr1/iCnA1LCfkpGmETRC6+3RCui/2Z9NF9VziB2A0OgfOt4q/n1d5+b/WPnG?=
 =?us-ascii?Q?m88mQhRcA8pgCI+UBUlkFiabYx062wArENp2MrTDIg6Ldn56t/zENWno72DN?=
 =?us-ascii?Q?+apS1c6LYomJ3QkHEqnD7pDcurYURp7wknDT7YPogyAbbjOUzbTo1MGYPC6T?=
 =?us-ascii?Q?cf79xlVPRSX3KyvWkdIxXXYCIokkY+oAV+x7ZZRBKq7sIsiCGJ4jv0fbEvQg?=
 =?us-ascii?Q?DJRfP8G8BKVKxXpQKSVQRrLsBhqL99odWCPdQG02RE2IS7gVodTE0+7flUzt?=
 =?us-ascii?Q?FNIvfp1PazDNYg9Zqz6QZ5J5wTpOvxqSJdDAvCPEanDTnKAe+CgSyKAyiPAa?=
 =?us-ascii?Q?uVxg3ldPZDPH73mQEjrs0HmWZ5LHw8LzaqLftJxC6e6K4S4Htt7YfroOK+t4?=
 =?us-ascii?Q?X9dszk2qQ1mH20NDxCz93FLlrddxhkDwfdBufXR+vuEpmN2oPKphcn1YJuOD?=
 =?us-ascii?Q?IloXJUaTne/oWT5MIFFfsb1tirw6O87Lb4KG1HwK87p/9nNGXhStPuNDbfXf?=
 =?us-ascii?Q?0NELN4V4PY8Q3nvnH9wro/EWrFxlRElbw+QhUr/xCn3OD6llezDv54v13ueg?=
 =?us-ascii?Q?s2v2BpDUvroUebca+xVRFYbUTGBxX+3zeixuw2xJjTbkn+/Sbm9VdXnVD7rO?=
 =?us-ascii?Q?qVhIM0UO+NWaYz+aHBQgPWRw2JCI5a5t4u0rYc8PS4hWmzJbYllvBGSj397B?=
 =?us-ascii?Q?AAOyh0DEn6cJBrMkGKZSCpAkoTBA4Y5R86GzMdZ5SkhNVnqFE+XThLKQsGuI?=
 =?us-ascii?Q?PO/BfYk8uPsnR0qe/RwgGkrYCeqCCutxekcPWQgT9vwwJmLSJTBLhwiR0D7v?=
 =?us-ascii?Q?KYOUvi6djUkj7MyciAlX4aQ21B7QoLVj16RGKmjQuLpsn2aJyTlxtOF0/1SX?=
 =?us-ascii?Q?0YCwNiv66EHJo5clcx1/G1Wm96KNb3BVkgbfbIRJvkI9pp+Tj3Z7aHp+nQ7B?=
 =?us-ascii?Q?AzdZDsqJjFJoEZrPcvNqYUuyOpFpyvlCtZGgkevUcyL3eaWxtIaBvHgvv9th?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ab70e4-c0bd-4b0a-05bd-08dd1b7fbac3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:09:16.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8Qnfj7C8wgyNf5SlyqQCTMEb46vzo0bSondqZ28wciKMsAZHE6Jd1Atefi2v/AO0CZN6Mp+0YAHPF1xoYX2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780

Add an u64 hardware timestamping statistics structure for each ocelot
port. Export a function from the common switch library for reporting
them to ethtool. This is called by the ocelot switchdev front-end for
now.

Note that for the switchdev driver, we report the one-step PTP packets
as unconfirmed, even though in principle, for some transmission
mechanisms like FDMA, we may be able to confirm transmission and bump
the "pkts" counter in ocelot_fdma_tx_cleanup() instead. I don't have
access to hardware which uses the switchdev front-end, and I've kept the
implementation simple.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_net.c   | 11 +++++
 drivers/net/ethernet/mscc/ocelot_ptp.c   | 53 +++++++++++++++++++-----
 drivers/net/ethernet/mscc/ocelot_stats.c | 37 +++++++++++++++++
 include/soc/mscc/ocelot.h                | 11 +++++
 4 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 8d48468cddd7..7663d196eaf8 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -993,6 +993,16 @@ static int ocelot_port_get_ts_info(struct net_device *dev,
 	return ocelot_get_ts_info(ocelot, port, info);
 }
 
+static void ocelot_port_ts_stats(struct net_device *dev,
+				 struct ethtool_ts_stats *ts_stats)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot *ocelot = priv->port.ocelot;
+	int port = priv->port.index;
+
+	ocelot_port_get_ts_stats(ocelot, port, ts_stats);
+}
+
 static const struct ethtool_ops ocelot_ethtool_ops = {
 	.get_strings		= ocelot_port_get_strings,
 	.get_ethtool_stats	= ocelot_port_get_ethtool_stats,
@@ -1000,6 +1010,7 @@ static const struct ethtool_ops ocelot_ethtool_ops = {
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 	.get_ts_info		= ocelot_port_get_ts_info,
+	.get_ts_stats		= ocelot_port_ts_stats,
 };
 
 static void ocelot_port_attr_stp_state_set(struct ocelot *ocelot, int port,
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 808ce8e68d39..cc1088988da0 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -680,9 +680,14 @@ static int ocelot_port_queue_ptp_tx_skb(struct ocelot *ocelot, int port,
 	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
 		if (time_before(OCELOT_SKB_CB(skb)->ptp_tx_time +
 				OCELOT_PTP_TX_TSTAMP_TIMEOUT, jiffies)) {
-			dev_warn_ratelimited(ocelot->dev,
-					     "port %d invalidating stale timestamp ID %u which seems lost\n",
-					     port, OCELOT_SKB_CB(skb)->ts_id);
+			u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+			ocelot_port->ts_stats->lost++;
+			u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+
+			dev_dbg_ratelimited(ocelot->dev,
+					    "port %d invalidating stale timestamp ID %u which seems lost\n",
+					    port, OCELOT_SKB_CB(skb)->ts_id);
+
 			__skb_unlink(skb, &ocelot_port->tx_skbs);
 			kfree_skb(skb);
 			ocelot->ptp_skbs_in_flight--;
@@ -748,13 +753,20 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 		return 0;
 
 	ptp_class = ptp_classify_raw(skb);
-	if (ptp_class == PTP_CLASS_NONE)
-		return -EINVAL;
+	if (ptp_class == PTP_CLASS_NONE) {
+		err = -EINVAL;
+		goto error;
+	}
 
 	/* Store ptp_cmd in OCELOT_SKB_CB(skb)->ptp_cmd */
 	if (ptp_cmd == IFH_REW_OP_ORIGIN_PTP) {
 		if (ocelot_ptp_is_onestep_sync(skb, ptp_class)) {
 			OCELOT_SKB_CB(skb)->ptp_cmd = ptp_cmd;
+
+			u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+			ocelot_port->ts_stats->onestep_pkts_unconfirmed++;
+			u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+
 			return 0;
 		}
 
@@ -764,14 +776,16 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 
 	if (ptp_cmd == IFH_REW_OP_TWO_STEP_PTP) {
 		*clone = skb_clone_sk(skb);
-		if (!(*clone))
-			return -ENOMEM;
+		if (!(*clone)) {
+			err = -ENOMEM;
+			goto error;
+		}
 
 		/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
 		err = ocelot_port_queue_ptp_tx_skb(ocelot, port, *clone);
 		if (err) {
 			kfree_skb(*clone);
-			return err;
+			goto error;
 		}
 
 		skb_shinfo(*clone)->tx_flags |= SKBTX_IN_PROGRESS;
@@ -780,6 +794,12 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 	}
 
 	return 0;
+
+error:
+	u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+	ocelot_port->ts_stats->err++;
+	u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+	return err;
 }
 EXPORT_SYMBOL(ocelot_port_txtstamp_request);
 
@@ -816,6 +836,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 
 	while (budget--) {
 		struct skb_shared_hwtstamps shhwtstamps;
+		struct ocelot_port *ocelot_port;
 		u32 val, id, seqid, txport;
 		struct sk_buff *skb_match;
 		struct timespec64 ts;
@@ -832,17 +853,27 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		id = SYS_PTP_STATUS_PTP_MESS_ID_X(val);
 		txport = SYS_PTP_STATUS_PTP_MESS_TXPORT_X(val);
 		seqid = SYS_PTP_STATUS_PTP_MESS_SEQ_ID(val);
+		ocelot_port = ocelot->ports[txport];
 
 		/* Retrieve its associated skb */
 		skb_match = ocelot_port_dequeue_ptp_tx_skb(ocelot, txport, id,
 							   seqid);
 		if (!skb_match) {
-			dev_warn_ratelimited(ocelot->dev,
-					     "port %d received TX timestamp (seqid %d, ts id %u) for packet previously declared stale\n",
-					     txport, seqid, id);
+			u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+			ocelot_port->ts_stats->err++;
+			u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+
+			dev_dbg_ratelimited(ocelot->dev,
+					    "port %d received TX timestamp (seqid %d, ts id %u) for packet previously declared stale\n",
+					    txport, seqid, id);
+
 			goto next_ts;
 		}
 
+		u64_stats_update_begin(&ocelot_port->ts_stats->syncp);
+		ocelot_port->ts_stats->pkts++;
+		u64_stats_update_end(&ocelot_port->ts_stats->syncp);
+
 		/* Get the h/w timestamp */
 		ocelot_get_hwtimestamp(ocelot, &ts);
 
diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
index c018783757fb..545710dadcf5 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -821,6 +821,26 @@ void ocelot_port_get_eth_phy_stats(struct ocelot *ocelot, int port,
 }
 EXPORT_SYMBOL_GPL(ocelot_port_get_eth_phy_stats);
 
+void ocelot_port_get_ts_stats(struct ocelot *ocelot, int port,
+			      struct ethtool_ts_stats *ts_stats)
+{
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct ocelot_ts_stats *stats = ocelot_port->ts_stats;
+	unsigned int start;
+
+	if (!ocelot->ptp)
+		return;
+
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		ts_stats->pkts = stats->pkts;
+		ts_stats->onestep_pkts_unconfirmed = stats->onestep_pkts_unconfirmed;
+		ts_stats->lost = stats->lost;
+		ts_stats->err = stats->err;
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+}
+EXPORT_SYMBOL_GPL(ocelot_port_get_ts_stats);
+
 void ocelot_port_get_stats64(struct ocelot *ocelot, int port,
 			     struct rtnl_link_stats64 *stats)
 {
@@ -960,6 +980,23 @@ int ocelot_stats_init(struct ocelot *ocelot)
 	if (!ocelot->stats)
 		return -ENOMEM;
 
+	if (ocelot->ptp) {
+		for (int port = 0; port < ocelot->num_phys_ports; port++) {
+			struct ocelot_port *ocelot_port = ocelot->ports[port];
+
+			if (!ocelot_port)
+				continue;
+
+			ocelot_port->ts_stats = devm_kzalloc(ocelot->dev,
+							     sizeof(*ocelot_port->ts_stats),
+							     GFP_KERNEL);
+			if (!ocelot_port->ts_stats)
+				return -ENOMEM;
+
+			u64_stats_init(&ocelot_port->ts_stats->syncp);
+		}
+	}
+
 	snprintf(queue_name, sizeof(queue_name), "%s-stats",
 		 dev_name(ocelot->dev));
 	ocelot->stats_queue = create_singlethread_workqueue(queue_name);
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 2db9ae0575b6..6db7fc9dbaa4 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -759,6 +759,14 @@ struct ocelot_mm_state {
 	u8 active_preemptible_tcs;
 };
 
+struct ocelot_ts_stats {
+	u64 pkts;
+	u64 onestep_pkts_unconfirmed;
+	u64 lost;
+	u64 err;
+	struct u64_stats_sync syncp;
+};
+
 struct ocelot_port;
 
 struct ocelot_port {
@@ -778,6 +786,7 @@ struct ocelot_port {
 
 	phy_interface_t			phy_mode;
 
+	struct ocelot_ts_stats		*ts_stats;
 	struct sk_buff_head		tx_skbs;
 
 	unsigned int			trap_proto;
@@ -1023,6 +1032,8 @@ void ocelot_port_get_eth_mac_stats(struct ocelot *ocelot, int port,
 				   struct ethtool_eth_mac_stats *mac_stats);
 void ocelot_port_get_eth_phy_stats(struct ocelot *ocelot, int port,
 				   struct ethtool_eth_phy_stats *phy_stats);
+void ocelot_port_get_ts_stats(struct ocelot *ocelot, int port,
+			      struct ethtool_ts_stats *ts_stats);
 int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 		       struct kernel_ethtool_ts_info *info);
 void ocelot_set_ageing_time(struct ocelot *ocelot, unsigned int msecs);
-- 
2.43.0


