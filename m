Return-Path: <netdev+bounces-241012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAE7C7D69F
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 291B9352091
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046352D879B;
	Sat, 22 Nov 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cpy3KN2I"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963902D738E;
	Sat, 22 Nov 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840059; cv=fail; b=ekKbs4XVZWUjMwlcVQZdPIfbjZUgJnVXX49zdbAE3VZqPtjnrijk7pu7LX3vYiUHzvgg7aiUMCBC2nptWlHBPqLMDIYMlkocoEx8ItYqcKeT8mo8xD5rw/DSNbXAd7v8BMtSALrY8944Bk17NLGzhJfsj9UooiTrXaz4d1oghts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840059; c=relaxed/simple;
	bh=xGmMyssGBW3fGviNYzZJEo3RSEd+Rnn+dNMbr0n/mzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHui14hqe0rWV7e+L2XkebZv8yXUnspvlHc7yVaXIZLi06UaR8QXxCe492ZIwcoEkqfm2mVUG9QQ18m+q2UZNjk4rNkIy6tY48Bki6i3ZJUaqSf7gqpArlKVqljK0HL6HRT+HsVOlbVpR5kC1Z9xwkD49hPq0LukpecghQd7D74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cpy3KN2I; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFAecNJz2tmczu/32C+V4civLZDRH8RAbkPB7XfWSBZr08NtzmKbWaoaXEqKo7RZ0j9wNLLaE6p6FRkKxwDMaf/r/fyNpE+xHQnfNzCmXUa1SdBl5FWIMkltFvjfdd+Px97++CeiNvAMbf/tIIV8A8vvtFXXufxJQDC3rlwWFZe/DBWP90A/RHpYU/9h0Rwn0SEwjQeY8oCN/oUby23ozg/8AuVA51CaHYWizlRhQt4VqleNak9ArcjgumF4n3makM2pGAwEUZ/LQZiQiBJzPlmcfs3W4xWLlIh8CcFJq2+8Y52jv5QFopUJGnKolO+F/oz8goBtn+B+Ze86Tyb5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II3IqyMjYH1TH8o5t3t6voOd/HTgX8wfeUIJwfy8aB8=;
 b=kmnS1/CLN4zu98ejobSA0t5wd/8LKmJxLrmBVh/wn6EVFolWuf7id2FI5Q1HzROhXbxlno8anNO1syuvDZIxrZc1ouvcq5CdNrdChJ7UFyARW8ApzmwaI6T5BHr/uyLmGecoCxEU4v81mVmxntNRtD6+mI3fMczcYfcvn9PNs95M1+nLOHLc78CM7uIc8U/4aue1zIgX8grJYWqSCmRdZ3nVLakkF+wLHYPfA57GY0/g+dv5RZVpPufnoJSbJSs0v69S0uArU+bwqk61TEjz0wNSWYyDEvvZozmZXrsLTeF9ibIrXMP2J08qY7dWYz33/h5aMmPlPYasek98/ah1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II3IqyMjYH1TH8o5t3t6voOd/HTgX8wfeUIJwfy8aB8=;
 b=Cpy3KN2IHF5SooHd4t+vEPoF2cOFdvl6a7jciBzmEAmoIfNXN4S0ghH2h/9fKguP4A8/LmQIly3M/GqrQnJqvofGW+y1VXNHMIrRJEsrvHcgtq/O/vAhH2PKkT/KNtYPumh10dl+GtGKQ3NrYinpOofO0//dwrBHUHsE+dUUH086Ugh1qAxxKeD5c8XMa0PScGB3U+6ru0Lh/MKI/RvjcVchRU5zML5OqeGGiVi8X7UP2eWlRB2Ln1NxXvowyaHXE2QVoRz7Y6w+AJNR0YpO0XmH6FA/EX7F1WdQsIB8kppJMRPEUm0aMItI6tSdEvcNieV1RQmGQdQIdt9jp0SNkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:34:08 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:34:08 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
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
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH net-next 7/9] net: pcs: xpcs: allow lane polarity inversion
Date: Sat, 22 Nov 2025 21:33:39 +0200
Message-Id: <20251122193341.332324-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: e5469056-822b-47bd-1c2c-08de29fe1afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y8DCDccpF570WMlZjR5HfhJJo2RU6ODoxrd5EzV2fjQz/9h7xfBzaB1yuzMb?=
 =?us-ascii?Q?GC1lZvrvoJF+aYHpBevSSDDxl2gtOCZrDWD1oFX872FlUk/YWjVi3n964B8T?=
 =?us-ascii?Q?Lqy6B2/bYFcYmiv8lUp4BwDM9yd284tmVcLzGgfTvwr2ifb95p/SwUzfZZ+Q?=
 =?us-ascii?Q?L/chkPVFgJ5f6lqwJUdnVUF+EU35DEKx659IssB6qDPux/FSflvt04asuCyc?=
 =?us-ascii?Q?kgSpF0OrzWey/TEzBKt35xhQ8ROtRKUC0dTvUkipUnnIVdNA6ZOn2JYuGSqz?=
 =?us-ascii?Q?JbKB4d++LiIvMU5XjxCMPam060IptsEQXohU3rmPTRtMshO77aahgSJjZ9Hg?=
 =?us-ascii?Q?vw5/8Bb+eUejsY5gml+s74naHaBbOSO1JPC4pRuHMmcT8dkoSsEJY9g/fE4J?=
 =?us-ascii?Q?vRU+rFRZLJgIzseqGXdf+JBJxVwHzQmFCRXEX4fubYKkpBhFvupoUfdsPtJx?=
 =?us-ascii?Q?1R1XuLfzfrMQ6bwhACGHAmTrLjzwa78ntSwvC7p40CZbDj2sI5kGw45VmhFv?=
 =?us-ascii?Q?BBI7PgzYyWO8RpRXFCgO7B4Obt9TMEvtvqtZTzbnHcp4zwX/0HuoPnIhSUoN?=
 =?us-ascii?Q?LdtCb3gjXJz8fqhGP01hMmyo61uTQBt+Jv2xZW214j0F1sNu8c2uw6bMi/PZ?=
 =?us-ascii?Q?1F8EfC0ZL7CNgXZRVH4V/HRBZ95dnVJqJw2OhkhRiKiYiQe40gLNj8eOZ7+w?=
 =?us-ascii?Q?6Svxr50Pmt3T/kPoaB33cJGbsOEil6HSPnEB4b8Vqy6hN2P8ga8D+Uny/NKS?=
 =?us-ascii?Q?0AJRBQ8VGCvsu5rPfp2OjGYCqb9hlahySQmBTze7ec51P9lKptGZeZnca9z1?=
 =?us-ascii?Q?fGAJhI8F4OIq1BviGG16vHXMiDiDxj3hJF1Nk2wE50M/kWGCLoQeVhQP9/Vi?=
 =?us-ascii?Q?vubVT7BRypg3dtuhc0o2RftpoqwWKfz5tGUBrljQ0QXd5I+gFhcd/ahaJGcw?=
 =?us-ascii?Q?I67OOkiEIJkfKutz3ysMslx5SzgUHtYdZ+efeL4NMkZAj/xAyYowtNaJIJca?=
 =?us-ascii?Q?ErDoqZE1XMTDHW4RZDJjhkHkN1n3vz0tJhH+Ix2wjwAXr20fCkQpuy/MZtRB?=
 =?us-ascii?Q?3xhKiGGku+RkxAIdlIw3JQ/w9mN6EQIwlbFVYnPIXG4wbgMKpZcu1JJYaxmg?=
 =?us-ascii?Q?sMSuTD5k1DlwVzrYrbCgTbmtE6jFbzQmdHZ7VqtAG9lkyItuzovfCGkyKvx/?=
 =?us-ascii?Q?jwISm1k/XkQhios7Tq88QbSuWMnaCX7q2B2QCvNyjOH+f7fMiLIAtHem09JQ?=
 =?us-ascii?Q?cq3y8a6mB4zptiLDCWG/wn08ae2s9CjJ95bXdKoprMdqj4GaeC3z2+DxTEgt?=
 =?us-ascii?Q?oMW5KkX4//Z2TZVh+BqMsRgcR1gGH7WMiwfwIuD7zqx1VNtH6phohZ43/0ix?=
 =?us-ascii?Q?ILOCZnvN17N4vOnGl7WKmgI+6PlWs88/cONOwN1RO1qlIuryNmYMkugOswOW?=
 =?us-ascii?Q?vZ2pQJD5p9X6xMbB/5rsd/eS7Lh1AQy3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPpBR9El8PVUFlh99fk4friD/BaUClWHZRcBKfW0BPmUKozt4KlVb2TzB7pB?=
 =?us-ascii?Q?n3JQ2BNCY6rSOtc84dGAfH4WosxC6xiEawNELxDyH5y9JIIJx3P+FBCzm2BR?=
 =?us-ascii?Q?SMFJoAwVt4xuLaQWSG9ZUZBCChzbQsCJ/q+MacFt5DTp3ZCvel9qYT5vAxHj?=
 =?us-ascii?Q?3UzOXK0nXamNJJ73ZrunEyGKkXJgbpMkYx5ij0ejxPqx092zWIulGbA1jmPk?=
 =?us-ascii?Q?emL8exkDvADg/NnjC0aBTQ4S+I1CJq++XJGramBuvt5IA/XLuy1sgrCSuUIa?=
 =?us-ascii?Q?x+QBiaHLHmLe7BehE7OWDQxVWQEGrdXX/zmFBCys5BN65GIa10V7g/uTUJVL?=
 =?us-ascii?Q?kPS1htvjYDyP6XLdfgnWeaCBDU6oWzyzjqns+jp2FYJrqzwOtw5eX2Nf+x/k?=
 =?us-ascii?Q?FzXK9B5jUWjT0fz1RU2jMVGviPva4qcvsxIDkXR7md5ONVm/JSkAB15xGHFb?=
 =?us-ascii?Q?rW9oQpHoVSC+FO8P+XP4ASXGDm6zTmI9UVyX6dKV/6cX8wt+JMV5dQGxSUcM?=
 =?us-ascii?Q?hzR8VrcvfVEz/SJ2LgiCuEVkoTdfDhX27xXoJGWLeI76DlQ6vEAhugPNPIJ0?=
 =?us-ascii?Q?avIPqsXWGj3bSQOA51aCbMUOcIVjFLqtMDB9z+bu+cs4DwrbSqFdEENiRqSU?=
 =?us-ascii?Q?h7sxpa33mtv0AXWfMuPWhuZMKiLGpROps5PLxbyjyyhJ7tjTuMLLNctfkdNX?=
 =?us-ascii?Q?xHc6qZPg56zDNdIMTo2ZcrWleX0FclzOfc7Zz27Nq7YGXgTAhulXqKNEQ+zu?=
 =?us-ascii?Q?25P7es+VeKPW0RCgRkvWRni7suZ4zjifV16UNtIkAjMYRydSl80tbcUoLRvY?=
 =?us-ascii?Q?X1mp9E6cKaMuF8bk6NkHW9cTjBGr7/qWrIhxEx6RVpMm1+nPrcI3ZjiN7ChA?=
 =?us-ascii?Q?g4JOpmkNzbt4P5Lh3tb969E9p5tKOk0nXl5DaLZ/sLfPSVpClVs3Cd4QhTKn?=
 =?us-ascii?Q?B24Y75ONssEXhT/Zev8N85T8gFcxt2aolpKGOLyrIDtxyraN2mRcWqWhd7VN?=
 =?us-ascii?Q?Qr54jcIAqYLpPFZge0WwlgPZnLLwpU9+rsF5udet+Pj3VrEuLVg0jYRx9uNd?=
 =?us-ascii?Q?0sOp13p6uWFzgZn56eBPtF4RNZQhdsJVr7UVSE5zKNiX8sf8jmQ/JGXmFXzz?=
 =?us-ascii?Q?FoLx7YCJcu1xhzcvxO7w2bmy3HijK3qQ2HDhXmOksilAVQ/huMIFoSr4cukX?=
 =?us-ascii?Q?xVEM7xuwySEK9UAMoALBgaj9NlctiL5F9hzLv48JJaA0jZXjimO2O9bqI/xt?=
 =?us-ascii?Q?/3dogYnF0zVjhXp1ITyYMJq1b1oFlNUyCAG8zljnQBXth9W7CBvEedVq7jPg?=
 =?us-ascii?Q?9xkoGmPEG1WwhAOP+Dmv6neTNAiKWHfbn5cQV18Y838WKqgD43fTvxgJoJfx?=
 =?us-ascii?Q?iW/odkuT1tOQkKwPg90YsoAtETd7juANvWHINGyLMQnSkwr8DDxQiWkBPpZ2?=
 =?us-ascii?Q?5Fsp5JmrvT+2rg/5vyw6ecQAzMv93FOSVpuUakIpgbPVuw0XRuft04KLGBgh?=
 =?us-ascii?Q?Yo7JDOh+mSADh2AISbwzG6zlF9FB9GAIx8dFAPCMIlnf1GyV26v7/aOExOjp?=
 =?us-ascii?Q?0+mgydOUNI3qO9p+m0Pq4aovRbNqJYGMHiKzgNragiFPdzNugzZJSZblxpEt?=
 =?us-ascii?Q?ea4RxS/LISICdq68DF1Hvj4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5469056-822b-47bd-1c2c-08de29fe1afc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:34:08.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmaUzA1pSj+Prq5/VgJFhz3O3jdQ34GgACcJx/B7ms9tLPWGM1XMaIC05H4C5OBpk8Lffi8urK4gYz9GIGeoZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Using the linux/phy/phy-common-props.h helpers, get the 'rx-polarity'
and 'tx-polarity' device tree properties, and apply them to hardware in
the newly introduced xpcs_pma_config(), called from phylink_pcs_ops ::
pcs_config().

This is the right place to do it, as the generic PHY helpers require
knowing the phy_interface_t for which we want the polarity known, and
that comes from phylink.

Default to PHY_POL_NORMAL, and support normal and inverted polarities in
the RX and TX directions.

Note that for SJA1105, 'normal' in the TX direction is inverted in the
PCS, and 'inverted' is 'normal' in the PCS. This is because the device
tree property refers to the effect as visible at the device's pinout.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/Kconfig    |  1 +
 drivers/net/pcs/pcs-xpcs.c | 33 +++++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index ecbc3530e780..3598747d6c53 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -8,6 +8,7 @@ menu "PCS device drivers"
 config PCS_XPCS
 	tristate "Synopsys DesignWare Ethernet XPCS"
 	select PHYLINK
+	select GENERIC_PHY_COMMON_PROPS
 	help
 	  This module provides a driver and helper functions for Synopsys
 	  DesignWare XPCS controllers.
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 670441186cc6..7625dc29d2ee 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -11,6 +11,7 @@
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/phylink.h>
 #include <linux/property.h>
 
@@ -810,14 +811,34 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 
 static int xpcs_pma_config(struct dw_xpcs *xpcs, const struct dw_xpcs_compat *compat)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&xpcs->mdiodev->dev);
+	u32 val = 0, mask;
+	int pol;
 	int ret;
 
-	if (xpcs->need_opposite_tx_polarity) {
-		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL2,
-				 DW_VR_MII_DIG_CTRL2_TX_POL_INV);
-		if (ret)
-			return ret;
-	}
+	mask = DW_VR_MII_DIG_CTRL2_TX_POL_INV | DW_VR_MII_DIG_CTRL2_RX_POL_INV;
+
+	pol = phy_get_rx_polarity(fwnode, phy_modes(compat->interface),
+				  PHY_POL_NORMAL | PHY_POL_INVERT,
+				  PHY_POL_NORMAL);
+	if (pol < 0)
+		return pol;
+	if (pol == PHY_POL_INVERT)
+		val |= DW_VR_MII_DIG_CTRL2_RX_POL_INV;
+
+	pol = phy_get_tx_polarity(fwnode, phy_modes(compat->interface),
+				  PHY_POL_NORMAL | PHY_POL_INVERT,
+				  PHY_POL_NORMAL);
+	if (pol < 0)
+		return pol;
+	if (xpcs->need_opposite_tx_polarity)
+		pol = !pol;
+	if (pol == PHY_POL_INVERT)
+		val |= DW_VR_MII_DIG_CTRL2_TX_POL_INV;
+
+	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL2, mask, val);
+	if (ret < 0)
+		return ret;
 
 	if (compat->pma_config) {
 		ret = compat->pma_config(xpcs);
-- 
2.34.1


