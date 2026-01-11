Return-Path: <netdev+bounces-248790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C9D0E833
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A0503080547
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD3330B3E;
	Sun, 11 Jan 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l9gf7aVj"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40436330D24;
	Sun, 11 Jan 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124499; cv=fail; b=neLqdFOIy3zabZyhsr11mdi5rrsNXOZIjsB/QuXlzfl01P7C6b9wqmuUA+Ekx5A9ZhofFTFymJXbODQLs2UPaLJW8l7cPCPYVi9Xb80muvbZIKQniLXi80WQ0My4J3+AjAYB3CjgIIZHv7Z6XvYeA1voLRKg5TuPvbFkB3CaUm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124499; c=relaxed/simple;
	bh=Tucy6eJ282m0PwQVgmGARFUfo8euuapAgRg6YEoJa20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMR2d4apDb+tVLPqLaeUMJy2JMIepWt+DF3x7kqy3J/5fG+QttGODUASRefewYvdhYu/jeY7RWHeKFWR+imKl6i+BVJAbBtwoqepWFlPXqPEIkqLdAk9P8fV7Z+0PfCnY/+GxA5u6c7c5Vqqj7h8POm6LoHmzKZdaBguNgxUIMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l9gf7aVj; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYR8f3+TtsJBWHQFsdtqTRoqKidQXOHznDsXeJUcQWtZPr7vAxZm1X8qd/14JrrVVe0wIa3uo1TX/w4ForTV/BX3x9Av7LpqGgxRlFztga/u9/XAjUlEsmt6aL5TctImAKVH8CEUEAAHd1e+96Ey+SASsjUclJ40jmM/mDCazM6HdJDxCnCvIxka7ZEsi6sXyljTVsmk1BxtqfV/2o0jolVm9Kia6H9eh9Bn2PenxYuNoGEn39cnv8oeBS/YN8u1qCIz5blni6l/3q53Xy5ItsBuXfnaxWmJzXd2GO0XooxaHyN0+iPtxQ8RAWcYn5i/jHJ+4UQlwmPVbJksJINwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zStSPVQlztOXUyoLm7NQWHtRaUKXS5UajHctN6ksU/o=;
 b=XW+Q+SUvjLbWVkUWBwFZS3idvsdV1YiXs0OSkcNPUbyL+3SJ30Me49LUUkHuFjKf5cFnJpxSegwB2iADO8Nh3Ux711L/3jjLmf6YZ64x1YWXd7PhHJcD/o0jqSt1oLMr/RopuFx+hmXpGwDqX1ZnYmqBoQvrl2Y5Lqnm+bTCSacpRgaBXaoD7zwcpoz71/qms91ND1mk37xJvNwYK0OyMTrlv7HqxQwLEtteyjUqYIF8ZXmCI5hqRaxEXfih27Z/oOcZRcge/CwcIxgbvR6uQHY0LWpOtRduKZ3tJRMDGUvYy5Ct638wsXoY+fXgmDMSuZssazTjKwFqCkl5ugmFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zStSPVQlztOXUyoLm7NQWHtRaUKXS5UajHctN6ksU/o=;
 b=l9gf7aVjZyirlA3dtlm6EHv+Rfp3qv5394hqoUYzrrqHZVPQ2FBa9JfWmtmNQdDAwpeicWbuEzh585oiEhLKVZLz3M8tRg53IrnvSdvQfgDRgc+Z7wICUSlErHFvlwlwZVv1AjhVCsxIkWJlCV4ZLeX3aUwAa59l3askL8QMx9f6iekmrR583WGEiSz6z4NMy1A6YC3DgALx2S/K+eoLl0S29UwfC7RuEK5byt/uKTphNUgEyJwuRkKFtC/FSiuMdTheE2ttYb/FkJfvmYKBg/QssD8ZTUUoebJtFOijuLJSAZ1GWl3ddb1w8Z2w/BIvTKS7NxdInc4WbbdyFeGCqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:11 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 net-next 08/10] dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
Date: Sun, 11 Jan 2026 11:39:37 +0200
Message-ID: <20260111093940.975359-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: b8239e34-c5a3-425a-c2ab-08de50f58dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uw5OGR0aL2Vwe4Im+5cNM6Hci3GZIXr+AIhbGhSJ03KcqEra165bazc0W+eY?=
 =?us-ascii?Q?zdrK0Ua1CEJAshTDsasOPjRr65epx/dH215vGvsUWj5lEN7sGV0HArSDYu0G?=
 =?us-ascii?Q?D6k93Ti2yauafRtaThxJINh8hUsCX3EKUtDWF+Ui5mVzlGUB9xoarCyPXPp4?=
 =?us-ascii?Q?rKZwGyt/WpqOv1JKNLEjwomHtO0svvkvBu1Enfs7OPeFoc5+08c4j9xa8SIY?=
 =?us-ascii?Q?yaNpNpe91D2VfzHF8fSyZ5Ibiz+1pahFEBt/NUhksu3cn/gkARQjAXRxy/gF?=
 =?us-ascii?Q?6IYoHJcIin64s+qLkgjChZyOeiWsXOvHYRqxlo7FdtE1jEdqCw+jUFF4GYnB?=
 =?us-ascii?Q?biZl+USHsYcaqBL/15CegaNmZLGy6QiN09IQBay4/DqR5mFvBsvms2JJLllH?=
 =?us-ascii?Q?afnWGpHy17kEP0YHQgYLRmmUlTyJunfER3+YZ1sX5ZhQAqF6jm7lDE2cnBs4?=
 =?us-ascii?Q?8ImApBN2p7TY1ZmiNs6+7uiATM+x+hbtlPB0jJN5Ul7Wd94BjGP0ewPPGfjb?=
 =?us-ascii?Q?Wy/MYkvlxWpH6czqpNCTOgNzAY9twmqvWXWg32gn2jPdiAJWCTGY4j0+qpgt?=
 =?us-ascii?Q?YYLdtfbBvjaE72+kgHPWBswjvcIltBH9ImvgPk/JwTNAWU0OQoWaOQxhQYc9?=
 =?us-ascii?Q?NE959VAvb0TaQ/K2NcZ5UscLZlLFw3xJipYqhprcx+52Bx6f3/QVEvbGeA2x?=
 =?us-ascii?Q?c0BYccdG9A9PHJOY6NM9mdlDeJvyeemaxLxneSD0JNigKOoBfMrTarLeqhck?=
 =?us-ascii?Q?3ucpJs4aQQb03k0qXqenLddpTcAWuvdv5MkVMDLJDvYzOhqgkCD4TAJMAoST?=
 =?us-ascii?Q?s3zZWQw9qcQklkz/6/HC8mrf/0183cxvAO5zM5/SukwMT+EI2afZKAz8As6Z?=
 =?us-ascii?Q?tRmza4iliDu6VBpxzlOiFMh6SuJ/t+S28N133peb5UKEvi7uPzCMhukrSAj1?=
 =?us-ascii?Q?BWyJF+nYIsYFaVSIy+IHIpUHvDXw2Z2ctFLz1YL8L1fPhXCP1p0ZQjqeX0KK?=
 =?us-ascii?Q?EE62+w8thXzQ+Mk8TClJoz9gDVk9hYpeERKpjrKO92inrsRgTIOjjT/b1RoR?=
 =?us-ascii?Q?dhhEU0NWbC46kKddgCjD80pIX+meqGT10U7ESl2oyoErYv7zA+wXJoJrP3yK?=
 =?us-ascii?Q?vss1F+dzQOfaqEQgyIOFsNePAMFS9mFuCUNGnTEWtK1MwNdJCV8O+W5tZA4w?=
 =?us-ascii?Q?zQ3/NxbZYwsu7GmYskb1+hPRzImHawgVHT60Em+plXW/R1gM7mllhueraApg?=
 =?us-ascii?Q?DpXulHxEF8So83WKDKGoxq4Q+sGHC6W+k2dhQC0udbR7GNaOJTxaQMc64slw?=
 =?us-ascii?Q?vDFnpj7y99vsghFZiqquv9ek0xSRRLa4WdaZILmdPcaHtapQkS2TfLgL/VWQ?=
 =?us-ascii?Q?yg3C1F41DRzXIgIe7/md1wKT/IdWJ1q9ZB6yhBLlMxYVWgFaxTiL83oWkv6Q?=
 =?us-ascii?Q?WcduIEB+Tv05ENxM+wuCxREn8ZTdasCS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?apURxMwMidr5Pjezuq2wnDuYdVsa52E6XzGV4NgJgyeBN9cVQ4H0GYNQaEob?=
 =?us-ascii?Q?ugdhguuR4LcLM87gB47El4iPoF8YdThg7hCM5OTzy+DPqQ7jvs6ZXED2ozzf?=
 =?us-ascii?Q?3NVnVDN9XRzHQW7sh4+YG2GATo2hBN0o8pCWM0WCyoBpAq0a+HAXKveK25P3?=
 =?us-ascii?Q?5ex9bSKnWD13JRGyWyUg7/XvdcXQACvEByaBiJaVCf1PUkmw2FZ6jfPghDxs?=
 =?us-ascii?Q?XbDlRWGO5YPXmzEIA0kHv6SFlgtK90wseH9fXFF2ZMZ/wPfb97ZAb+1qzp2I?=
 =?us-ascii?Q?07DmOrDvVxigQlLreyzEYJ/7mtjAYVEn9JI0bcqWhuXR/OAHuv1PbGD0OmaF?=
 =?us-ascii?Q?7CD5jxOrlLZ3puDK5rSem08CDM9+OoDyo/ugPs2AKDE2bussXvqUU8ze1qFJ?=
 =?us-ascii?Q?4jV3BKN+IzUAzeo4N040rYTH9MIa9Ov8Usw/vVlz4qHCf+OotCBS1MZNXzUm?=
 =?us-ascii?Q?v///H/wV8M1MiVvb9jd14FxOvzQ5LYrjNIDd8ddv0dxEg2ZXxY9KogdZu4uH?=
 =?us-ascii?Q?DIBrGZZ+RKM45PX5YBvlgcDL2bw6MNhPbLYkdCFnJ524ANneAta33Ttlpwrm?=
 =?us-ascii?Q?o+CnXx9GGzBCYVRfj7A3fiDuDgE1tX3KYhrsTBamgwoeaK4G89PXj8sBLzjj?=
 =?us-ascii?Q?W0iAcHoF95wHRmht2yU4I6DOtfbzLVGbN3UYudqp1yhwo+H8ThXiyKN5AI47?=
 =?us-ascii?Q?oX7VjyYTA6DvZOg0bbnQO2yYJ3Ifb/HZE/PlUwph0t3DjoOwoQYrw2jjReX8?=
 =?us-ascii?Q?z/1yLDlllQuhPSI43DpBJ1ALVR46uXLClb8vhmBiw5cViv2UjfbuR0BpDiPx?=
 =?us-ascii?Q?53Qnv1ebtju/wYgDFS93b2MqK7KGIimraTWCl0wNh28ggpg5wIyBPe97TqLj?=
 =?us-ascii?Q?dvSC6RiNJHv+psHI9f/nt3dldQzC4JKmipJHvnDN/7Wkl5wA1eTzqLmibUM8?=
 =?us-ascii?Q?2a6sNnK2919GAaonNh3H2U2r01KmSgVwbAUczDIxIeiu3YOomyXWuqAdp5p6?=
 =?us-ascii?Q?boaBOm60N4eD7zKTFhap7x49F2BWMXQtLmDE4u0RCEBTvE0Joi1DE9VUPOVx?=
 =?us-ascii?Q?d/vAD6xAJkq7EHSDvMxsW+6NIynTZxFlvZZAVnqQCCKAKrhDe479ZW0D7rk8?=
 =?us-ascii?Q?segeCFAxtsyathf8iUO6dMEDx9pvRYeN3GHKlBddMKdpr3f2KB7BRIXyY6PG?=
 =?us-ascii?Q?uSyIyRmGg42bmZtVHVC00AmDHKt3nsuCX1e0kwBsFi2aJYaVEK51Du+9End/?=
 =?us-ascii?Q?b8A0wuKH5cdtmKk+gR2Y63eqDzLQVZuSgyjiQ+7fbrhVnROxWgRMws/P+7Cz?=
 =?us-ascii?Q?cDoVKOSDIWFgYlitozfucqlDazn32/SucdmAFDyNb/b8GKR99uEUd2lTyv4p?=
 =?us-ascii?Q?nEBBWbOroaKLgGGlhGDk28lkLZVVkemJZi25LCjqhr3JN3GqvbjA90TfKCeW?=
 =?us-ascii?Q?c5Eg0VjUtfY/ivWfRjf70FdHeNm5zZXJ7OXB2buwQ4t3/9knG6l3XAUlgh/b?=
 =?us-ascii?Q?wKs1je6rHKOcU7MOHsGUrE6xaAx1vhcNqupcTt66vjqhqFfAcABwZ4D9KrRi?=
 =?us-ascii?Q?q40AkokgPdc0xeHAZr/cHx53QEg315WCzyHtInZhVI4IHLZCngg4zqSX9vSl?=
 =?us-ascii?Q?7cTGxtoCOet9IP+Gj4aFiHRHKtyLqrp4LUB9Fr1UL5wXVJb1QHtykO3vP7LQ?=
 =?us-ascii?Q?lN5xhFQSakrPoa1YMB4n3NTNXa5hMpGkq1sOlUPEp5DCvIuBN3YZ+xTEoKy/?=
 =?us-ascii?Q?lW9i8ZzzjTEa8/wgkiT/C9AsJQNgXO7QmHOW4LJJwR02lpuGHpKYm8bEBxzT?=
X-MS-Exchange-AntiSpam-MessageData-1: lEWL5y/jNRW9qnQGP5gKsFNqJwS83TjenUg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8239e34-c5a3-425a-c2ab-08de50f58dea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:11.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc1ja7GSI07me5J4ivazIYcpvyz+Gdep5zmqTn5Ch1haITf4lk5yCCg8RqlMusN3dU1vIDAL71fOYeDKSRJAIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Reference the common PHY properties, and update the example to use them.
Note that a PCS subnode exists, and it seems a better container of the
polarity description than the SGMIISYS node that hosts "mediatek,pnswap".
So use that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v1->v3: none

 .../devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml     | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
index 1bacc0eeff75..b8478416f8ef 100644
--- a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
@@ -39,12 +39,17 @@ properties:
     const: 1
 
   mediatek,pnswap:
-    description: Invert polarity of the SGMII data lanes
+    description:
+      Invert polarity of the SGMII data lanes.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml.
     type: boolean
+    deprecated: true
 
   pcs:
     type: object
     description: MediaTek LynxI HSGMII PCS
+    $ref: /schemas/phy/phy-common-props.yaml#
     properties:
       compatible:
         const: mediatek,mt7988-sgmii
-- 
2.43.0


