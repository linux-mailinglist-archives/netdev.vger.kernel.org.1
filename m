Return-Path: <netdev+bounces-207396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A216B06F9E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E69D1889E3F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B120B2E92BB;
	Wed, 16 Jul 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NkotkGVJ"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F92E92B2;
	Wed, 16 Jul 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652337; cv=fail; b=qVJxjdKJ2rqsnmxvbYznVslEco5bkyK4QpmGV+RmJ70dcBHpxMdTWI4v9N8eaNnL+RRO2+TR2f4e+cbAFJw1vtMbBWlyQ45JS+pqNYPuYbVoxcGrvI5zcniVvEE9zRcupBBIjZJvlw9f8v3mxvaYfM8QfGSvs35W7Q1/SgUJe/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652337; c=relaxed/simple;
	bh=cLcl0njecwBydV3q417qP+A9KOA0UW4qnICxcdXYz+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BaHPFF3aF7wliUTvmS/JPg1MlT2HavcigyCugDNZemFlOcD4xmVxI+khyTVRs6NF+12GPGd6cxXmg4A0xUTjNBLsTAr+xWVgkts2bY3t9emqDBxp4peNtSvc+ACoqtrLCrT/0idOhty2x9mIFLnceCjwDAbeC/595i41nS4Sf7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NkotkGVJ; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7FUPRdwSkRwUjkLrVHrD4N+bJvujmq88iozLIn58zbl7PpTVJw5B2p+0tA9/E2rZz5Q9coH/E0tCEarQuPY3EQNhnwbxXOwHMVS/EPt/SYpyngDxRGabpLee2qjJH0OX/rFsENe9Xsrkj/h9dJWkAD5tWWlCMVK3W2D+O/mFGU6RpVOlZbnT+HO267GzHz28LHZn+6TVaxGBVO6zCLcMOHZvmnYEKS1xU9QCcmPI1COx/8C2Wa0OYaLVaqGNEUqzQ294/2Jyhac6GCe38ha2HhrtEJMvzdWOxc4mI94V8rIb4ZY8zGh0MWLx7evxkyosMyySMReRAdlqyR2/9NaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ1d0o/8FbjGHJD5TksFMyHrmGobsCcF2PQdMx0A5dU=;
 b=EFSH+ZPlV9rsSOWU/wGCP4D72cuqErf4SLzWoW51WMAzub16OYxWy71m6bF/jcE9BDYZwH2QoDu+06G6rmAo5cesZ6XvNqDUsyT+aL+MG0ESuGa28/rU3jpgyYuE4VjjyFx+pI0fuH/Xzvmxvvt7F3NPI7pHc3c6glXoxeMD3fw6n3Js3RkaHsxVz1ifHy3TyDnrjG5PKnOaRa4E/oOIVJeuhvRhOf2a+MBh/87v1GMTI2glVIEnAqQIdcRVty04WCcyLyT7UquFILlLevuK5FCKW208Wc6L1u57OZAqKaixP0ZSZ9k3GnwvNILeP5K3kK/D3qHQ4FZ6QFWU0xtG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ1d0o/8FbjGHJD5TksFMyHrmGobsCcF2PQdMx0A5dU=;
 b=NkotkGVJp+WoDrKQxr8Xqaom+1dYdDa1bbYQkPVCxsDg9nWVctBHVk9Zjta4mLWynASGYku6ePaqLm8XjQlBHXAFVgyXDJV91QBWJuVxZk3uJTCLlQzSlinvu8swASMn6vZR8xHP/lR6VLVLkmRkQ01QOHVkDAJJKTMPC/P7xmoUtJprl5hsFme71ipVFDbMLI2MguAD6GTtVyVYfBGvcEALtCJFgy21g4eG61nBEFCDXMd6kdabwmNOmKh19IwMgxU+IqNuv/+8wDtRLHTqL6dc6Wa/62ZauMH3WDu6WYqoKPuDlQDUVpl+MnDGkLffOSb2Z0bX7z/5oO8ohDjVWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:52:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:52:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 10/14] net: enetc: Add enetc_update_ptp_sync_msg() to process PTP sync packet
Date: Wed, 16 Jul 2025 15:31:07 +0800
Message-Id: <20250716073111.367382-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eca1b3b-bcf4-4aa5-e6f4-08ddc43dac64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCJJTFcCdm926k5CCKIH7E08e9Oko79GM38Vlnw4jzAMk219zQQX9P7LMDy7?=
 =?us-ascii?Q?HxO34BFPYY9qT5C1LmIhDY7Z2a+kqoSSZoo64XMs0OLb3vGp79oXG0rbCKFj?=
 =?us-ascii?Q?L0OSOCPlssO6sTR2G5wo/43EZPD3jqdPA7nmLDO8GD6nEffxAjjX1U3sOIUT?=
 =?us-ascii?Q?/bKXL/otP2ZBA+n2BOvfVRPC82GZYqy0jlBocpCC8MyVENrh0IO4gs2g9Sr5?=
 =?us-ascii?Q?WJiS2n9g2e0CIRcuX0E2Bm4S6cI61AKYRFnDYSgeKvRm5o2C6ctBuecp00mq?=
 =?us-ascii?Q?7C1EnI/7l6B6NOJyRWj1BLHcmr0IyWISVvLk7p1wtfgOookBfP2pkt8S3+yg?=
 =?us-ascii?Q?H8VjDf/jlv5Ox/DYmchNK2YwEqyOx3VLtv4tqQLsuyebK13kBrpoKsmMlJ0a?=
 =?us-ascii?Q?cgvFtwROxi8LaaKwFGnM2Y6Lxd/SvdUGd/K7dCi76H4utrBB7Nh0sLwerJdx?=
 =?us-ascii?Q?EAp7Y0S8p1mWldx7m0tPB3rPRos72xOlF93grbnhOfAjYAhOLSJ4KJvru4w5?=
 =?us-ascii?Q?cRJfeK5dcNk2y+wG5tEhH4ssiswCqKMyvf5PerUceDZOrAG969R6FBAFNvZI?=
 =?us-ascii?Q?Igz8EzGi3XVVelZXXEd5dlDKms+N8TAATfXZkqODDgRWaLHEPw1+GBy6Y/27?=
 =?us-ascii?Q?6rramLKW6X57P0hXN6dZPEqBlpLTIKKbga/BLfvdvo/rkVMekHc3a9eYqWaa?=
 =?us-ascii?Q?bd6wnL1ON9b1AjaZpju6+3Ip5R9GWbD3OjfEIO0DnwVAM/W37oVohYb06BAK?=
 =?us-ascii?Q?Dy4OMZRdcT6nZM9X7fYC3ohCqsI8QF0TR98TUd6WBYpzkLjVd5k0Bo3Pij2G?=
 =?us-ascii?Q?2/kAPlCBL6X6DbyH7S3KLMdiUU8cUM8Mi1iiPoXDDMHD/pitEIifpN+xTAe6?=
 =?us-ascii?Q?sHzUJk0ShzGQFPF0WOEZGRFJkBoo6qFlwOnPJQ9GREfufINGrcUc8xrvIyWV?=
 =?us-ascii?Q?LvoIszy+D9Vu/AUu1pTS/ArwxgcNkhgOf+zh1WITuKM+Ikn9tksx61nTAHPD?=
 =?us-ascii?Q?zhWBT3w+6al87fEEBtbvDjQo0jFfkOtoL0wiyZFLjO+W1s4fFZ1baLn8wJeh?=
 =?us-ascii?Q?jgkMrSM9h7UrwkTRYqVBVA8pAGoNDly0opYztb9u/5Pgadmyn2gZm9eDZhtA?=
 =?us-ascii?Q?BzqIjhm1QxcvGwOPdbIS3DIIlsmQy63XYd14B6iM9bDlILDBqJq2Q/1SXgiU?=
 =?us-ascii?Q?pXrlxvvEGqLvTBvAOsM5P4DS86iPMCgv8aO5kzxzaVO1zY3Z4dwSazz9y1gV?=
 =?us-ascii?Q?phJCf9TMZHAAqc1CeKHyfJs0YiFGURJG6KU9xa0VT8iZM91CF+XxYrFntI+s?=
 =?us-ascii?Q?zLmVgbjpyerZAwl0AA5iTSZd23cmi3HdC8rPlDPslnSW4WoXSjTHCwdQ0e6r?=
 =?us-ascii?Q?g0r/o5GXEjIwpIAtEOxI6crpFhL+dqbtygPCOl3XsO5Szo2ZnI1uw5w4tjPU?=
 =?us-ascii?Q?zby9VOIVDgLARq5LaER+iX3uEM5JO739dg+Ie+dRciRZcVKDQIRbIwap5hvB?=
 =?us-ascii?Q?oUJem1Mf8D1fn7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLGBiMbnF8RZix8epXjV9wsRNeNacc0+fdvSuggZ1c2zevlT3UxHgZVlTl2B?=
 =?us-ascii?Q?ZV4Tj5ENvlCjLGVNcJ+bQG4/OQh1Yulcf6OrkqnQZXMx/3pqiPMx0styQRog?=
 =?us-ascii?Q?43xS2V7wvy/o2DwekvrHXSWCAOTY1+Lh0Y0Ve8IAA97n9H4P/rMVMmwwTTge?=
 =?us-ascii?Q?TTkScTgL4cVtGM0chuCcqH2oa3Z2oMibMclNRhBdaIdyirbIsdzPNiEhaIPq?=
 =?us-ascii?Q?IZ70Dl3Sl/MVB9w87qPvkUXnk8tVeEaXVYbNVLFxdNqKfncjLtn8aBb8cPCw?=
 =?us-ascii?Q?EWdyfQBfwaiswKIo7QUQ3C5ODbRGUHKzYzdU2KQUw8uxzMZZcepNxTXX+fVN?=
 =?us-ascii?Q?jvHxt+Q4UNvRrQL9UfFXlkZ1TiILHIYp6qzKh1myoNKb4yyDloJxgRFcxvOg?=
 =?us-ascii?Q?Nx13SMYUBNXy/UarxZ2gut19mD4BttIYQwNtcaJbirAoohFTP0TYvMb0axdW?=
 =?us-ascii?Q?dGL4fS2BeCFmuqeKROyyENPxpcAiCwA8gE8jGh9eRgIg2RNj6ZVYJGgUY9DC?=
 =?us-ascii?Q?3MgQ4Pl6ScJHW4DQLebthz3ta66+Wkf7MddUPjeBcyPSiLks6u4k+MI+APti?=
 =?us-ascii?Q?lbu7dE8F3fQbMXgz0dH1WYHy3G1uQRql7Eja9AUtLawJB643+yI7fGv3TxWX?=
 =?us-ascii?Q?VR5Dzxk4Tztg571K67v2+vZaAHk20zqb/zOMdmjZBMF7vsz93eul1exsB43J?=
 =?us-ascii?Q?cThv7zUiGJdTZOn1AFhAd7JC+YX3ap0QJyIHLeQqBkSccUgYNRPTl+aj2t1c?=
 =?us-ascii?Q?ZVsOWhA+vIVwJ3hO1DkB6yTNggwMs6V8jhChIBW7w+XKsF06y7t86wCnfKi5?=
 =?us-ascii?Q?4dlQQx3MgY3y9VG7y5r0KuLx+hyDOCbPABNd9IvMl3UVdWlsCqzXgUkwaFkH?=
 =?us-ascii?Q?eN10UDyX9cmt7VDNduIV5+qGg/jM6lHQmqdYQ4o8+h8/GqhbJY6J4vUb4wQw?=
 =?us-ascii?Q?hmWYTMb5VW4kjl0qsG4beNmS9ivD0CtnBRzCpPXXMhnAYJrUmKg2MUW86beO?=
 =?us-ascii?Q?pxSzt4JRqUP9tlxvMQQnLeI1oDVvo1mYvTe0E0fq6osflaFS5LfKudjmXcSo?=
 =?us-ascii?Q?bm3JrfOXcLplOEcmsCNXiaLaHXdUqAjsQeltjeBaHtSbwCA4cId84sOOYeYb?=
 =?us-ascii?Q?afdVrDgekeJQ0+ncDGa3Rge3TrC/cTPwH+fHzgvNI6XbfPzBa2BYwhbe8cAJ?=
 =?us-ascii?Q?hhK73rFqTx2MVg34HR9dcI3KwUWQiizQzCsfGaScgZ2sFd3oB4dXXPRmKwwO?=
 =?us-ascii?Q?T6WEWxJs+1p0H+pH/QQmRiZ0luZeIQFCM2kpah7pM48JBjr5nv8U36E7XIei?=
 =?us-ascii?Q?oWf6G6ZNVzswumK5Ht6p93Y/0sxsApvExXzZ1NQ3JHhNHdk3prBaLmdFtQJT?=
 =?us-ascii?Q?0irkEU1nCJ522MKbF6zna2c6/1PA6zPq3wsmsfi7p7V+nbcRHZo+pCyMnGr1?=
 =?us-ascii?Q?NqoTvH/Av5RzWzryzY08ISbpWe1oSa3NKmbMiW60wS23i6fv3YWEGyY80eJ6?=
 =?us-ascii?Q?2cEJRvXsSFD91lOjIiM8pnIBG8b7nLflBfwcUd6veTxJktVWOozVvF+nB3z3?=
 =?us-ascii?Q?3RWmelpk326cc29tppz4sb6T/qtMQJjDN5IgxMY6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eca1b3b-bcf4-4aa5-e6f4-08ddc43dac64
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:52:12.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aZNzfztkSTBqn/fuP6FSf7zC3gTG5xZgUgTDJQrGkPqt9NIg7uA3BvP+4k2x1/DsXJoE3olk3++scUHT4syLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7709

Currently, the PTP Sync packets are processed in enetc_map_tx_buffs(),
which makes the function too long and not concise enough. Secondly,
for the upcoming ENETC v4 one-step support, some appropriate changes
are also needed. Therefore, enetc_update_ptp_sync_msg() is extracted
from enetc_map_tx_buffs() as a helper function to process the PTP Sync
packets.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c1373163a096..ef002ed2fdb9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
+				     struct sk_buff *skb)
+{
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+	u16 tstamp_off = enetc_cb->origin_tstamp_off;
+	u16 corr_off = enetc_cb->correction_off;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	__be32 new_sec_l, new_nsec;
+	__be16 new_sec_h;
+	u32 lo, hi, nsec;
+	u8 *data;
+	u64 sec;
+	u32 val;
+
+	lo = enetc_rd_hot(hw, ENETC_SICTR0);
+	hi = enetc_rd_hot(hw, ENETC_SICTR1);
+	sec = (u64)hi << 32 | lo;
+	nsec = do_div(sec, 1000000000);
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanseconds field
+	 *
+	 * In addition, the UDP checksum needs to be updated
+	 * by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong
+	 * checksum when updating the correction field and
+	 * update it to the packet.
+	 */
+
+	data = skb_mac_header(skb);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_nsec = htonl(nsec);
+	if (enetc_cb->udp) {
+		struct udphdr *uh = udp_hdr(skb);
+		__be32 old_sec_l, old_nsec;
+		__be16 old_sec_h;
+
+		old_sec_h = *(__be16 *)(data + tstamp_off);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+
+		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+
+		old_nsec = *(__be32 *)(data + tstamp_off + 6);
+		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+					 new_nsec, false);
+	}
+
+	*(__be16 *)(data + tstamp_off) = new_sec_h;
+	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
+
+	/* Configure single-step register */
+	val = ENETC_PM0_SINGLE_STEP_EN;
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+	if (enetc_cb->udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+
+	return lo & ENETC_TXBD_TSTAMP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
@@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u16 tstamp_off = enetc_cb->origin_tstamp_off;
-			u16 corr_off = enetc_cb->correction_off;
-			__be32 new_sec_l, new_nsec;
-			u32 lo, hi, nsec, val;
-			__be16 new_sec_h;
-			u8 *data;
-			u64 sec;
-
-			lo = enetc_rd_hot(hw, ENETC_SICTR0);
-			hi = enetc_rd_hot(hw, ENETC_SICTR1);
-			sec = (u64)hi << 32 | lo;
-			nsec = do_div(sec, 1000000000);
+			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
 
 			/* Configure extension BD */
-			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
+			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-
-			/* Update originTimestamp field of Sync packet
-			 * - 48 bits seconds field
-			 * - 32 bits nanseconds field
-			 *
-			 * In addition, the UDP checksum needs to be updated
-			 * by software after updating originTimestamp field,
-			 * otherwise the hardware will calculate the wrong
-			 * checksum when updating the correction field and
-			 * update it to the packet.
-			 */
-			data = skb_mac_header(skb);
-			new_sec_h = htons((sec >> 32) & 0xffff);
-			new_sec_l = htonl(sec & 0xffffffff);
-			new_nsec = htonl(nsec);
-			if (enetc_cb->udp) {
-				struct udphdr *uh = udp_hdr(skb);
-				__be32 old_sec_l, old_nsec;
-				__be16 old_sec_h;
-
-				old_sec_h = *(__be16 *)(data + tstamp_off);
-				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
-							 new_sec_h, false);
-
-				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
-				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
-							 new_sec_l, false);
-
-				old_nsec = *(__be32 *)(data + tstamp_off + 6);
-				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
-							 new_nsec, false);
-			}
-
-			*(__be16 *)(data + tstamp_off) = new_sec_h;
-+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
-+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
-
-			/* Configure single-step register */
-			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-			if (enetc_cb->udp)
-				val |= ENETC_PM0_SINGLE_STEP_CH;
-
-			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
-					  val);
 		} else if (do_twostep_tstamp) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 73763e8f4879..377c96325814 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -614,6 +614,7 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_STATS_WIN	BIT(7)
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
+#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
 
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
-- 
2.34.1


