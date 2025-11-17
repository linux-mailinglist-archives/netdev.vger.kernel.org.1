Return-Path: <netdev+bounces-239073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D95C6388A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC6381A0E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE032720F;
	Mon, 17 Nov 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWg1YrA4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EB3246F4;
	Mon, 17 Nov 2025 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374732; cv=fail; b=G3O+etNNgqGBoKdn+FIEhF4MRhOU6QXfZwLiGMdKNK8+JVJyfkhdx3hcCagiZ+65owr1+s22Sgamkczou18KTf3L+Tw8TJAcuwZeylx790k7eZirhzlGFGiQ9qX22ygyO2TD6HS5TXmyLkR9SAkMETBW2Fu8c6Ua4uiSf4FRDLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374732; c=relaxed/simple;
	bh=y6hbN/hWOZpb715td3kXvFE9LkI6bqxnTGdRPynEZ58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1clLYEQUlTTV81DI7BFoFpWhEBWOdDfDB5D1W9sCLWWoCg6RpnPkob56DvZ3HzeKyrnVnTloIAEyeWbGXWZlyB17YCrBJbJfhieRyJwG7YLuZLRO/t+hWW7XmtnpurI4qMIhXxBOPrgBqzpSxAWFgtIj76+W6puOPGG5dUIQJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LWg1YrA4; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu170ZX900k+2D2AvTxJIoAJaKHQRrjeuFXbcOOCx13tgccbP4xstjy4VrcUMKQqJ4gX8pmcd2sdaNRplmlg938B8J8oDmOU/y1xyymH1IjTSS6jwYF+UvAwLL84RKkikx947whBNNiz1UpgwTZJ+1kmqQ8IuDWyf7ZzGVmdszJnqcFA8DKKbrcDGz4qY4BZa04bnsNFybBoDY7xAU1iiWvpPse5mij5i4m3WwhDrMKXfFvTM07qcr9cDHLg+lD0bWHUQyCIFBFu1AklzNOsxHq2No9P2ex5VhffowEOMjoImmAU9wXi7+2W4xMyP7h2OTixB+rOAiv/MLFOwgxS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6+l/7pPPD0u6rzCFp3Z+lPx3RWE7r/Nv+At7INfcDE=;
 b=OMBgwzN+q5TmfHUuhvnTLz2CxP0MYgBeABWATw4P/GGL6qAjN6cvLurlX4SbXqDy41R8hz8AoIf991wObgCeB0F7mJuWHwPR9R5OnNhbIEtwpn1R3hTKu4CHHaldNd6PKKixfW43St1El4/bypEDWwgARxveyrqEs9xntGOBkOzxxASEpu+kHwRCnjp46+/VRj4Lz2thWTlC1c7bUpBweP4JwXmOouAV8Z71X436H6xPfgc2MsModWojoNBnOqeW66GU6MKvUxeYzPY+NaTTHPDPaVkdhVZtHCB4V0qicyZszg8T6rpAvKagod/eIMJEuJGFHy2MIqbJcdpwhIJd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6+l/7pPPD0u6rzCFp3Z+lPx3RWE7r/Nv+At7INfcDE=;
 b=LWg1YrA4yVcPup2PXX0uUA6acVfAD7/gMbZzp1Ceezx740b+tZCqvjBEX8xcjUQ/c7shMX1WDWZlWCILR2rhLPxsJ0hJimGT+EwCtA1fYzTF9u7Hhq1l4+yI/0ZW6lygANyvNkKYzXlUkwOKjBeEgRM3UnV8nHm2YpDLEaN4dsr2HMKPdvtoLSn52qmJXBOBIyXNUPfQ3ubD4tdEcTrl8hl35uwKmblgT7xSk44FVG04q8j6oxbpeDqfz+N0bgUcVM5pxH2DxaYjhO3kfZETd6+7XrzgyZnoqsEhT/r69BGhy+Nh6Ho53X08nphOVFx7AoktdH4RmuGVLBXb3HNyng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 10:18:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:18:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 1/5] net: fec: remove useless conditional preprocessor directives
Date: Mon, 17 Nov 2025 18:19:17 +0800
Message-Id: <20251117101921.1862427-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117101921.1862427-1-wei.fang@nxp.com>
References: <20251117101921.1862427-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb9544f-756a-4876-4559-08de25c2b15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lwzP77D3lDgceOdrgUX2HieVEgeJkW4ovvf1OqOz/eUHT6h2BxwRpDgmtMu2?=
 =?us-ascii?Q?u5hEdFbDoKo0fnY+YJF2RYo0U8IY4Ide/1JlFyKRYk2iGMEHnK7OT+cjNYjQ?=
 =?us-ascii?Q?301HrKhVlAU2ZFZPzoxNyoYEqsIIPCPTLA2wQ0v379zP9pMyDRsvEiZZm5UO?=
 =?us-ascii?Q?g12SvMTH3fo5b5sH+E71VZgEZIBXD0iafa3hqixFtyc0yyRQND1et0JmDYbj?=
 =?us-ascii?Q?S6ps8b/9JZYa4D2Dyr/C+wHQc3fEJgZheLIW38zwlA1XSEhbrL4zSVBRQFAe?=
 =?us-ascii?Q?jp3gaKcmaoPPw6D7T4FqlycM+Gnu7drtjhhBW+0cEA3KhzSpswjp7/y/sz3D?=
 =?us-ascii?Q?qbO5JCsiUB7mSsjK/jy4p9eiX2uYP1B5oh9aPVrgRJBlSGhYb4vbjJKw2U/A?=
 =?us-ascii?Q?mfYFy72uoiLefSngnRhnpcFVBVBSAEoS4p7R20wd3PrnHtDMxulqRY6D3+6Y?=
 =?us-ascii?Q?Dsk2DPn7eydu+Hxu5JWLxAxHhFeYbsnod2uVKCD4gGbQOM7CoKVXxI5vnEaV?=
 =?us-ascii?Q?NkPh/ey8ZlRh7FwJ+VBtuPzslgQhAXunkOFpg2oqvViBWyaUUI0kmkY5uv7d?=
 =?us-ascii?Q?e32KFn7aKOPD0akqa5UDGAh1INiTP5hBxL6vplD2HSr3lOu1YdyMHculmHs/?=
 =?us-ascii?Q?RgXY+aIJfETE04IL0ABxm9ODiZr3/eTK8Z92DiC757iBNzXiAKFQf+E6s+As?=
 =?us-ascii?Q?JLTRs9p1W4TPQ6fDKpOjcLDc+WHhdaeLvaKVz+W/1aKAb3IjoHpw/NfEK6Jx?=
 =?us-ascii?Q?YoTR5pa7t2t8tafi8zA5IzeuAABSo9Avt81okFheTULQ1VRYgj8Tv2Vhbu3z?=
 =?us-ascii?Q?fF0IPjiH+6WHEoIqyAbHgxRbl8piObl03B9swNhv5SHHpcEp6S3x1eE3aWKm?=
 =?us-ascii?Q?PVVrDvc6b5mapM7xn+LbdX43+HAKzkx0+Eon5t9DHWlGwi0hTE+jvt2qgC/G?=
 =?us-ascii?Q?uCybgzZ11rYZULk7oZjIAK+ZD/IGaPQnjiaLxsngNb4A3IqzrR81SXNSBJBD?=
 =?us-ascii?Q?+MZOersGhUWhPxp46jK7hZvbwV9ALuk91Xq7keV0OBgrv0zCuHoI/TlgO3Jj?=
 =?us-ascii?Q?H5eS7RkawQePXfe1oLwNE49SqnVQa88qqOUKuHtAPKbJuMS3PHTYSIKuQaoN?=
 =?us-ascii?Q?z8hiMDML4CHC7BLcoXuuH2Vl/y3cm03SoJxsaJrtMn1p1bBAwwk//+c/AcV/?=
 =?us-ascii?Q?mdwlxih5vAIEEB/THL0nPwmqVxjnUysqxqS090C3t4y3gP8eH7xquawMMor2?=
 =?us-ascii?Q?Qa14cOJGvuEgLipcmcCDg7DyYgK5uwMuvQcwrN996j532HhC4j7XacYMvPOo?=
 =?us-ascii?Q?C3Xa+5VkRaQIDwd7qUV/BR0Yquv7EhKMaQi4CZM1HvZu4hokOg5hfTWlOpdA?=
 =?us-ascii?Q?qIc9OiaOWrOxQ5CJ9sv9APIhsvnkbCENrAzsNE3fbYC3WtSK2BmNEak5o4P6?=
 =?us-ascii?Q?cQSqI3ko2AF1QPKOlgsCgWm95el6uNZ8nbCZ9HPQSb+/aIRnICwILqcN1jml?=
 =?us-ascii?Q?9XPgL1WzWo31pevoinnjudv7P5ArRvOo7C8j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i4D3XstgQU9G6Znu0yxHKpdD9wHt2MGvGAJtftbJFj+7a6kzATET78LUEXXi?=
 =?us-ascii?Q?iiMOTjLCSEG7xdhPlBCUcHfvX+9ezKFvQaR6wEW6vCfUEAAC2PLIZWDmACWl?=
 =?us-ascii?Q?5Tw9BgrVndwWIHp4IW9w4DP/Yd/moKPeKZc9QDe9qFLbc6PJ4SnYqj3tvNoy?=
 =?us-ascii?Q?InSzyebgvz6W+0z2uIFm+gdg8j7hNK/nCOMlYkJNUU990c0DDidWamUZwZzm?=
 =?us-ascii?Q?lBEuL584rs7yocf0RBLkpsbmrLURDQV1XvhTRz9OhDaMIieUAJuxdMB56ePO?=
 =?us-ascii?Q?yo4Lt84YZCC5QPw8+B1JOC7z6ZQ0yAWUt4fQudx7nAazh313MiY4KTatZLaP?=
 =?us-ascii?Q?lL/UZZ+ElcBJlJzZ/zqMx5aUg2jh19yd5rOI6IEV7mt7pjKPIUIKd6p3C+a+?=
 =?us-ascii?Q?PJGWeTIro9FTAdnodBTgip615ZGUz/Ik3YwAqPMM5Q1E095MbnVCW71z7AED?=
 =?us-ascii?Q?SPqg32zfD1RunaHDzB++P2R9AtIvX14IHGdKm63Sy0yQX6iSgkBqFcqr/YH+?=
 =?us-ascii?Q?BWoButZYNN5nYkDrNrgdU2ym6vSQno/tXVh2Xwxj/+4UaChs9Lxe1lNAP8NJ?=
 =?us-ascii?Q?wJSaqSov1z5gNIueZQ27Yb6yR4ZNk9kkYJjNm85bM7jZx6jrR3h63L0mgDOb?=
 =?us-ascii?Q?dDRPNoMP7MCd87hweuh2mUDILk8vVzmPXapF5n9dV1hUKpHITNL/gcuvPrCn?=
 =?us-ascii?Q?T8sppXqykB6vR7FRieNiWCyhqGOZLm6ZuGdeRU2ouG3k8KyFL6pIqTHSqPZZ?=
 =?us-ascii?Q?db+NGIJKaPELbz4bECL2ipVMcIFMZ/DUarRxyI+uEYmQgsfX8NlKpuYY34/H?=
 =?us-ascii?Q?hFU4eDcbF/iSNJ9FElJSS12uTTvgLy+wcZaSA0ZvA7VO1e/lkkBCMGGx74D/?=
 =?us-ascii?Q?mBluNdco7iS8rlcIYRk+ER3tXgh3YFKuSO1gJuMrzFHrAVG/chWVsJXO3Eol?=
 =?us-ascii?Q?FhaXQyCz8VDnls5wlWHnFxvA+dafSXscZYdOa8BF7/dspGqSf4dd+3X/05Mb?=
 =?us-ascii?Q?Y9Qwb5IRpYKL976XjD17xrRzndvAeG75hZschwS75gczZlI7xdVSBxHzse2Z?=
 =?us-ascii?Q?cpOgsmIaRrY+vILM4EZoDCDQMXVe8o9VT9KoukK/JLUwjFioiXlTZa54OiEj?=
 =?us-ascii?Q?xdZWy4By2LZh8vwMgei/YuB/ldBEWzPsrEHtjHWVwB/uCKR8HbpJejub8Up9?=
 =?us-ascii?Q?E2iMWXILq7ySZ0QNjrwLWZtvOOZEtpzUoFI5hMNvhwNpiZ5PYFRh2r9RGqe1?=
 =?us-ascii?Q?ucsr+WulNkeH+DLXCxQO7tHesHmihGtWapSeaWS4Ig28yWz7B/m5ZfDSvKA/?=
 =?us-ascii?Q?kor67uVwixrB7yF5rJ0HU5SeJ3lQHvrLlydEo7oqZ2s0f90onwlsEOzhsDou?=
 =?us-ascii?Q?1LDgENQhQHks0QfTcDCQnlJ51v2F6M/9wZPqZWrYJ7/phP3O8PNXxBXwMDyC?=
 =?us-ascii?Q?NrYir+UffRqxROgvYoH3QgQMEXdcHd28wxy2GHiLtNKyo7XzjOapi+6GW1L3?=
 =?us-ascii?Q?K6jL7vOHixzuxOo/OxqBn5vylu3H3YCzy+cDrQ0wD/1u5bdAF/mxk8DrnzwF?=
 =?us-ascii?Q?w8wGjaADlbivj8zTvC9VAkypbC54hk/c2ZHlIg/5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb9544f-756a-4876-4559-08de25c2b15d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:18:46.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASxvMkjvEVMnihHOYGfdWqb3GMLMLli97xTCZD3TKPdv9TUtvHWJCZwSKx4gxsMhXuujdn/P8OBnb/fJxHh4TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885

The conditional preprocessor directive was added to fix build errors on
the MCF5272 platform, see commit d13919301d9a ("net: fec: Fix build for
MCF5272"). The compilation errors were originally caused by some register
macros not being defined on that platform.

The driver now uses quirks to dynamically handle platform differences,
and for MCF5272, its quirks is 0, so it does not support RACC and GBIT
Ethernet. So these preprocessor directives are no longer required and
can be safely removed without causing build or functional issue.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 742f3e81cc7c..e0e84f2979c8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1773,7 +1773,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	__fec32 cbd_bufaddr;
 	u32 sub_len = 4;
 
-#if !defined(CONFIG_M5272)
 	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
 	 * FEC_RACC_SHIFT16 is set by default in the probe function.
 	 */
@@ -1781,7 +1780,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		data_start += 2;
 		sub_len += 2;
 	}
-#endif
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -2515,9 +2513,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 		phy_set_max_speed(phy_dev, 1000);
 		phy_remove_link_mode(phy_dev,
 				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
-#if !defined(CONFIG_M5272)
 		phy_support_sym_pause(phy_dev);
-#endif
 	}
 	else
 		phy_set_max_speed(phy_dev, 100);
@@ -4400,11 +4396,9 @@ fec_probe(struct platform_device *pdev)
 	fep->num_rx_queues = num_rx_qs;
 	fep->num_tx_queues = num_tx_qs;
 
-#if !defined(CONFIG_M5272)
 	/* default enable pause frame auto negotiation */
 	if (fep->quirks & FEC_QUIRK_HAS_GBIT)
 		fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
-#endif
 
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(&pdev->dev);
-- 
2.34.1


