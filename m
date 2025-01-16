Return-Path: <netdev+bounces-158848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04DAA1383C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1801A160B4E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D971DDC08;
	Thu, 16 Jan 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="niW6nHke"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76F1DE2DF
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024412; cv=fail; b=ubopdkfCU/0tWV3y7tbGpFeyO+VGARFLBY+XryK2f/F1NU4YcDMONG67+OBv8D6bJIXBdc/OQAXOkLcS3Qb+tV7SDGzQzUhL0cZsFheJW8ZE/2+ZQl5yVq3takDS6h6tVLuEWZ7o9e8wu8+PeN2Y0yKAXDNmb1PekjAFATxs5AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024412; c=relaxed/simple;
	bh=IHA8fp4Q4gV/MIhj+R35cm6aFt+NwEdVCzjfSkMlfhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uEvaof42mfIPMxdjgo5ay8Fdrxdm/fe2Au/JRyxQn/zMIm8CgBm2h7w7A2k8m28MxtxMiuzdTH1xl8Zh4qIVyp0WqlBsaEflhJDKY44tBWzOJP76XhnPiu6wDK9qIQOo0i44sLKPXIyxfg2UPhwMBf3YTVaomaYdmksFXQ9P5tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=niW6nHke; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMZ+nSJjWgqajrJrwzh7cTJsqzcJ6eyMTyMOIInhXuf2goNISnjO3zej5LYeagvYzLNQ9xCgvDNHdJ2hycFJat/Z6dcMgLlw6n7svPD7yhocdLcbBBUNuayHZNShFdzobnU2b/gdDjsOIfBPl5IREgWGYqur4/LLFWq3+W2hds5fAXUbtIASUJfPV0oCCj2LhLVhu2LsEnpVk/XkvHAGyEzLbMzq5/0/z3bO83JmCOy57qQaT7tGaPWOhD+nGpOQe3cZwJqfQviU7kN1THTsICl6AwaRgriMHfbvMHmty9BNJQ40dFlmgxpnUeI0U3g5Rj4rlmFaPieOQizgGGR0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbfSZfFsWDu/8wKhUUuOt9WHsnnWhpVMhVScY+sz1q4=;
 b=mhs2+OaA/H5mPJEZC205dSiV3pgdjoeRmLVsVy1F6eYO3fKuRWf/89h34BL3g919PRpGmqxOvNf21JKny3FK9ithE3Ks2xe0LI9G1a8gN7sXNqT4z6QPjL8HHbZnXqd1B/GxUY4k1Sm/g0Dfmu3wZAHqfKCod0e+n2OX56ShB7bmT2xMaF8K6fkn+4mHqeBreyPz07NPVH8l6/IGg/5ecHpLcqD/pVjvvvuJDeR3iwI81SMFxQQh1JUtC7uF8ZGO3vDxXdqOVpUVWVupgqBVPkl6ZJCbWJSL+XUod8ckwXv0KxL5tEpmjtNJz++wBBHVnrWSkmD8o8RkUn6rs/IMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbfSZfFsWDu/8wKhUUuOt9WHsnnWhpVMhVScY+sz1q4=;
 b=niW6nHkezFLTuqJKkBIEMAQcDYNxjVFo9Aa6Zjmg6zLOQUyh4DdsucH+OnEKP+lzjVsGGHbJjVMqB4zFfx8QM++7xx49ghCgeQq/oNorr5gDDQgLEMaxFJWyMR4LkfkmvcH+chwnzfaR9hMoALkf8axN7A94lOzB1GHcaribZ+HjWoU4fKVewv6i7lAdpyDqD9/QYZYsGsi458o5SnPxQzmJ3s5KhriUtpS7A8JEf8mKd3r04CWcc3VURLtcDgBFrWea0c8bGVrKEVLDRC8GqiEJEE+ubrwoETaeWCvxJcFMKFuz6p5/gpoX7njzFqDgAIm4d2/c2OspWnTOeFOtIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 10:46:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:46:47 +0000
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
Subject: [PATCH v2 net-next 4/4] net: dsa: felix: report timestamping stats from the ocelot library
Date: Thu, 16 Jan 2025 12:46:28 +0200
Message-ID: <20250116104628.123555-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116104628.123555-1-vladimir.oltean@nxp.com>
References: <20250116104628.123555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: a9590bc9-1576-4b66-1982-08dd361b1371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sFTCjvUoBjAAJLBinJEySafGfwYi9W9BhQGcZ8LMrUsXDorJT7bFv2QgQMBK?=
 =?us-ascii?Q?S/QNNw9gkzIX+zsqdcLABjG7FEeY+nT7Iu/fcyzi3NILYh68LjNCpJYkA4sN?=
 =?us-ascii?Q?p/6sxk+r3YYLfL4MXeA+g6ZmwQGXE0W8NJTIdOYV8tzFl7Wn20zF5cFLPlIQ?=
 =?us-ascii?Q?C6mFLJDopRt5O0BCj7kJFMKfYv8drNvPG6J8bc020iCWRTcpym6TS8YLnsE2?=
 =?us-ascii?Q?lnRUPQoFfUqIv9MiGBEWwGUGg+bdShYQa9ULzw+/WT6gO+m+i//SEEk1XIVp?=
 =?us-ascii?Q?kxvdOAQ5Y0AnbZ9t6uDko0LaswqKqg+NAnbK7Al/39eoPjQ4tzgMpCj3TVjx?=
 =?us-ascii?Q?XyN6IThNKzsVSWVg2EwdmXxTcyHZAyK4jL19XWiVp3FG2Td6RGCeR88Mn7cw?=
 =?us-ascii?Q?ISKQjhsvH8GyJF8KCPw2+rG/YC/AlHI7Fr6DUY63Qncp8rB2UVAEL+N2DUfq?=
 =?us-ascii?Q?IwzJvxHCXWWNctUqGmHsGgbfrNhucSXmSvy4vYX0HZsoz/NK6Vr3F7yqCWAo?=
 =?us-ascii?Q?C5+5R7vmPKJtD0u0i8CLWADioO2+QT2TMLSzkX4YF4EXrFQF30Gy1l25KsCM?=
 =?us-ascii?Q?LHlcz4+niVXr+oatG1fImvYXm+ZYhNWKzlO47FL1tilY2k2kDkI14MPfPaXo?=
 =?us-ascii?Q?f4e/sJRG/+X6BlHCFNCqmSzMMg4BfrfnCnyQnLl9RiZgR0Zu6/+J2K3OaDiv?=
 =?us-ascii?Q?q2nJDslvAKsmQcOKwofRHDBsWOaeJDdEiS3qfj7rWcssT16L0SygG7xNMzf2?=
 =?us-ascii?Q?KRhdhnyTUVn7Qli1jyo3vuvex/pS+qTceNzX57mGaT+ptrsX1cVP+rpQ4oeb?=
 =?us-ascii?Q?raFnVAcYxS+erkaxDsnZ000C7PONC3PNpbBwRgwwV81nj1ykI1mzEl9LBtLT?=
 =?us-ascii?Q?lw+l0qO0ZZdAD9EETeFnxvDANyChyme9uNWMJ/VQctrR7n25CribWPDqd+sB?=
 =?us-ascii?Q?VEHOZxSB4YKyKhOeAq4zyj/4FFweqVjUZ4loUa3l9OyLQtW+tg5CtFre2i+3?=
 =?us-ascii?Q?aiR/eXSLg1QBiYyogA0lXWEq+TD/3VODW97V/3kTqcOVt5peqxl1hn2s4oOg?=
 =?us-ascii?Q?XNNhBDCYusbIwUbTwWWD24jcumvrGft8tDbJuCeqMSE24h9+QvJ+YANVaiQ9?=
 =?us-ascii?Q?F8VcebZW25AmXeKXqcvEP+vg5p9SJ6Fa8VxDdH+iuKKL4RqoMsMa/gsn/dt3?=
 =?us-ascii?Q?XSwWuy2CDMNbmb3CkN/WlYmmEktyftkLYYnNUTdIn+wMUa11OodNNi5O8Ugx?=
 =?us-ascii?Q?0SY/hueAd7/G+cB1kr3ocFe++67z9RqqRSUvtBrCvy0A1QIDfIkfuWy3MHjv?=
 =?us-ascii?Q?iL4nSIqNaiNEHEfBAk5r6TIec6IZ/IsA7EjWyihw257Q8c/jVMRmK0ChnOEJ?=
 =?us-ascii?Q?mu4ePTymJRwTG+I2E+lmwlynJqJvREP/y4REBzCjiG+aU5keysh21QQktkvg?=
 =?us-ascii?Q?2flXu20xhRSyGyx21yZK1lh93TXUwhPG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dhHFNbbQNSoOSBmBRnZxtq+CvkI/iIi2fa98zV+xbbkcd3pknuV5aI2vUY1J?=
 =?us-ascii?Q?KpEdC2NrTUwFJ/67P6N8gduMzt2G1kx30tYC9wmJFCZYiaO7KE2X7QnrfJbY?=
 =?us-ascii?Q?yV7ruhH6+pxdVPS+ZpOu8DMnFgDjLWRQPDkl+VCxVzn03xPioM1UWg/Zv9Nw?=
 =?us-ascii?Q?gqm7tDXI/moVaN5kQLkEP0G3Sdf1O9L9GsZBHRvfYVJYRQLO8QjIL/nuDt+l?=
 =?us-ascii?Q?V5vq9EapQtMHUEugVpYySKuOSaDRaeytvFW0v7fudKn2rhacyDnstNrQWvuD?=
 =?us-ascii?Q?wnD/ErGajrhTvarUR5DtDKffaqjBgZw/AgmXtBfazkfZ6l84Vma2dJCnqY1k?=
 =?us-ascii?Q?+pibuVPNY5figWJTChiHzmBk+UjCyQEVUYKUcASw/CCEKHoYB6v5QloH4lpy?=
 =?us-ascii?Q?qUppl4KCO93kBH2DJrRWefebZWMk3BVsx1/0Jv2ATUmlQex1NfqU1SO+9lzu?=
 =?us-ascii?Q?A6chi1h0O+vxkud5ULtUNa1NSWn8o/Zn2ptskrHSrVTCNtoUCGbZ7mvpuaeQ?=
 =?us-ascii?Q?Tztn47mKXWSnhUv8X0kun/kTN43L3Iuqz5VJG+kR0w2+UEHbO6wz//zDB0lE?=
 =?us-ascii?Q?YJqgm0q08dVL5oFwZyC1YFaPaR+fNMOScSXukValgJWCvrhF67pR2cJLU8Jl?=
 =?us-ascii?Q?Tpd5xUqz0+D/faJ5kqPTMK8rdzDiKR8nhdr2/BJnyBRPXJwchas48THCZC+9?=
 =?us-ascii?Q?H76iUoX/i54ARjg8qS0lA/1OU5tP2taLYlVJGfDYVv4R5eOZN7qfPQuYWWLR?=
 =?us-ascii?Q?D/eWDt1sPVzR/zxoWK7XH+b2WvR+mrOe8BYV0p8M7QmA1FpVGQYLO+QCHSyJ?=
 =?us-ascii?Q?Brr4fGyVIiEeP4UpAiPCzq8Gmfado2I3pYduzeag5KrJLeXDHTDl56iGNRn6?=
 =?us-ascii?Q?GzccExA/9+Twmjb2mKhL0TEkU/yc1RfxcpdXVlOg1xXfuJkdZVwc3kPZFFVK?=
 =?us-ascii?Q?y9QUPpMN2UF8dLR28TskgQI+sIwQGBaS2wlumIay2Z9Xz934pO4gsh/nZ6hg?=
 =?us-ascii?Q?QQO6VpcL8KooTgZHe7vXvTSXHvcUrg09n8Q5cCkl1NzTCZXdWzIxV47iv6tA?=
 =?us-ascii?Q?0T+gHD0fCJUc8LlE2II2kCWBHC1VNl4/nCT+YtZBz7TKO1BdFBG40mJKhmDs?=
 =?us-ascii?Q?zrWnscvNRF9tVXiyAALv2EvNlxQneEAUAwhnrLJ/asKBjAUB3ijIlQ8RCu80?=
 =?us-ascii?Q?dvHiX+Ek/DzihDvdyTFdrJ+UzeRLt7fu4vaQyQ2Jpzu9P6Fk9Sp+V3p8mlib?=
 =?us-ascii?Q?bjaG41oXndUPfc//GuB5KQ1BDjtgVam5XhNtaML8iGK6ckz83sEpkPHP0/9A?=
 =?us-ascii?Q?HV1qbvHW43PyB4u2bGGyze0MAcq7X8TrLXmNUFpnBuYnYZLEGKHLdczgkyud?=
 =?us-ascii?Q?6KzJaMATPcnz+mG6L1FqsFItt6RRUSrIs0PFn1tmhGg7oaDLSHsqFZlGjIdz?=
 =?us-ascii?Q?fLRZIMhBCGgbElnN5TMompZVt+nJHfJXZXpUgy6t2iBp3Dxw9ARvbvgMDPrM?=
 =?us-ascii?Q?+f8ByR0c19UylqQqj6SNv0hhYjLiMXSGsgk/arqFWzV2acPdjhUUq+lLMRuc?=
 =?us-ascii?Q?SqPTHlvnap6zs2hA/WVToS0wflK6QJXgfoKXgnm1/S5AWRfuwYPrYvna2gRf?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9590bc9-1576-4b66-1982-08dd361b1371
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:46:47.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2H2DKmgcVQM58bniQYgeoaO2YyE4xD0vA3TB25kQsR2L8JPiZaazDOnVMBEaKOEQT605OlZyB7t1x/b1H6Drg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675

Make the linkage between the DSA user port ethtool_ops :: get_ts_info
and the implementation from the Ocelot switch library.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v1->v2: none

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


