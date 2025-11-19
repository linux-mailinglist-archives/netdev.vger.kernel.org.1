Return-Path: <netdev+bounces-239798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9D7C6C755
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BC3A34A096
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E242E041A;
	Wed, 19 Nov 2025 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="em0FqOvW"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDC2DE6F4;
	Wed, 19 Nov 2025 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520674; cv=fail; b=KlHe9FWJHfPuvw1wnZWOg4n4pAF+BWTF+UAcmjQ1ekDzCPaDo1cNcUSh2BH8xDuI8tLMKS5kxbuUARcPZ0/3P6MrndgTtyyTyE12+/fbIEsqqP42d6HhIjWhCjEJ5owJhohnvbyPrgy/7U1RSmmzUiZviHnyXd9wpfYlLHFNGqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520674; c=relaxed/simple;
	bh=h2NRGz8OE/4vBaC4QDgkBZvFnpJkohggw3ErfIAwrIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miRZ0qlJh1xZNam1ArR0jUjB5reEZ93CW0tJe3jlD7SwKpPq48zUtV3Ep1DwJyX2vZ6ifdvT399riW5cszxdCjpqn4jEfYfEzSv2wDqhHTAlwq7zaibW4lFu4AUNEKFS1Gv2ukPjXZ32lbw0d3lAT5COsVP2olnCtJLLC8Nt15E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=em0FqOvW; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGY+jpdtviAEfUR/MpQ7pSh9mFhH7KnLfcwOElkqqeetSy4CCoZUd6ixzVHQUlLusfcMveElmXMYYJqzEEVFw8jG3GFMmb5O4Q/vQNZHTZ0Ua8bq7PnetfURUMBEKCF61VV5qnewnejUnWJKTRLuwKswhleHO53jqCMQah9WSSC31pVAcsQ884ilo0mtDekGh3yqL+YOIGd5cLOYpseWWj+0Mu95AIDlDXU9GuhwbC82+x/Brrh2g5Hc9/Qv1J8Ioa9+i+Amiy0olPgjcd1l9bKEtzTuL+viYrhB51t1oT9dEx/IX+RXHpm9i5MGzL8a0kLjZDVJvCnGWoos8v2MZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGCpYWKDlCqMpkFxcOCIMLWXKFA5C3ajtbGREWQDZ+A=;
 b=qdq9vOFmuuExE0jAv64VYYhwSOqu9CiVyaOr9wMAEPit0IwQ1J6bS1Mg55aqywnvDnYBETSWG+RdkfUB4ACZjOw6TxHMKliMAOLIw8ylrEF7we6wG7+B8vktV/HMJrSHIkhzkUHSJ5aLVoGKtnnp2RSpQkZ6DNiqRYRhYntfjcoWVM9Ux1LGAIydwwD0Nelq7xOBSxhXtw3wJw6z7LNE931j4X2ziMA7XS1r/1YmcqyW0EFVwbNkfnfzR6hnamDOU4OE7qfAmzREaRBCTSrHRI3M9R/N2EkGu+2iccT4lCTqAhvK3wFafbeePNpZdhEyCPoz7GVamCRjcR1B3hryjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGCpYWKDlCqMpkFxcOCIMLWXKFA5C3ajtbGREWQDZ+A=;
 b=em0FqOvWWi0UlP4ji9zVrv7wY0co2gMAqIcMnK7Sfihb4dsTXYExF4USYmSyKEIC8ONiOKW70Pv1k3ebBoFlMs5gt5X3VpovC1sZhSAHayClvSsyDX0jLrGWzwypKHsaIVBCshZHp/I/Z2/WPehhamA8qWHIGfMWVGWQmNAKtV2WB+zosqFaWc/B1Fn5W+Uy+A+CicOt8A45HgWtATBShI1lpva3abHoAo16Vhli33d/hQIBpbgiFMAYG0XQXx3BUNgGlI5Guh6UAtc9M3dBi0udgnne5rl0thl5nQOdv/yd81XVyn8zdeXdKqV6TuV1DUzxlmyPiXKWbzip3EbqJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by OSKPR04MB11439.eurprd04.prod.outlook.com (2603:10a6:e10:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 02:51:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 02:51:10 +0000
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
Subject: [PATCH v3 net-next 1/5] net: fec: remove useless conditional preprocessor directives
Date: Wed, 19 Nov 2025 10:51:44 +0800
Message-Id: <20251119025148.2817602-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119025148.2817602-1-wei.fang@nxp.com>
References: <20251119025148.2817602-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|OSKPR04MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: a54c86c4-dc8a-4111-8f67-08de27167e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1LNoaDTcjS6NnzWIKkXZL7aMHj0hktHVG8wfjRcngTsAJ3n2EVM4bOfxnnCK?=
 =?us-ascii?Q?Q2gYm0+QuwXubPnPS1rbqzEYOcQM1O9h2vX6Ly+B161jr7lsmoePOr+71o2k?=
 =?us-ascii?Q?IMayTnnUZEZA5Hq8A7AJs2+J9yiobdVGIptmJI1ZBhP1PBHKwze7MSx7HdVV?=
 =?us-ascii?Q?30iLfOLzV1pXCO72Q8NI1CF+EhOP8R4c9yvWCQocuUd/iPPE4wQLWT4edUao?=
 =?us-ascii?Q?RFuKTm0+9E44c8lN44XaVY6WDbe8kmQzf1zqRYtny+8gO7BLc7if2xXO3N7T?=
 =?us-ascii?Q?EcK5AT0dPG84pyLBC+aJiCCsGNjS3UhRrn08GMU2LeIYvBiB/Ir281ETGZYo?=
 =?us-ascii?Q?VqJ/FDxnwv+vlrW0wbd6eKrSoe9o6jianWLm4G9CG/K4G6X9DGNcA+O5pSq3?=
 =?us-ascii?Q?L2tcp9fJ7E88R1w/i67PRMjxFP13TLClzPj8AOkmJYYdWVsSpx8AmeRH8nn4?=
 =?us-ascii?Q?4ekhlaPBenspIp3aGphiJTJmxrC1+8hbJp4smisg3IBjYjvjGA7Xa+gfb+9r?=
 =?us-ascii?Q?SCVjlfG/wMjIawNQxzmW5ptSIpJoGWO/koSXNKQoLzsUhdWnpf0QXSG64+Vk?=
 =?us-ascii?Q?E40OIkSvmtI2sJcyEbgg31KXlroLVNJ3LSWuaBKmP9NRve/aC7xdus6WTp9f?=
 =?us-ascii?Q?Ubw68YUg7SQwuVsJEf8+ummhxmRxYbJbrGkXyW1RysKTH3++EDdHyiMMlasT?=
 =?us-ascii?Q?P2zGhRIYsNfvqx6C03mci+u5Z+IGe70tI09ao/IDXM0rgfP/VKHACM7k6DhH?=
 =?us-ascii?Q?fPHsAjJZGaN+P+PHlv6hGTO+t7YC4i4b2w7P+q7r7r7A9PjB7CVDJSGfX9v9?=
 =?us-ascii?Q?JVgwySvNimPZWt3tdMZ5cizPnK/A1Rfj+84UaOd4x7Utu/rEppRSduqpe8RT?=
 =?us-ascii?Q?z8z5/Y0erbdGlChSCox+3qdEoPTNAetwHa7hNfhzAowDKQ+INP/8lyLDg1lu?=
 =?us-ascii?Q?EBrICl0/D734rZUeCrCr2eUyNSNT/zdJ02A0ex71Geq2t0D5buDbQR6Jprg7?=
 =?us-ascii?Q?aaRMhzgce52catthgbt4WQNgRMBBh8UYCUc0GmpIhBH86kv1sR4MqsiaFAYK?=
 =?us-ascii?Q?+5Z5UPX91YjFjhlSJ52ftjpWvx2FBZC/6mrg8EnL3w18rTPjM81nWq5tiVb9?=
 =?us-ascii?Q?/QCdZlCU6WvaGmo//LF+bzDgrpiIPwBG1CCZJCSUB1KQpeK8H8wJtokmxnMS?=
 =?us-ascii?Q?ij27VGIQg9Kg7AZj8cR2CANhOZzP3sktewbltPx+wmw6Y9m5dvNgGZvyY6VX?=
 =?us-ascii?Q?Ce/mhseDgJQ/OG9x/Y7jSU2luWNy51VHhFgQRh5LH6yKS1HlmNXqmty73e3x?=
 =?us-ascii?Q?Zjug4DIyRzSqpJ30HrwJp/0Ae7oEBslr26dBLYyfAGF1Pp1xpxA46ibPp7Bu?=
 =?us-ascii?Q?hJs4tsbalh/myVIbyKNkZKE6dd9Xk4rnYeQ7ke4hhEanlhw7RFRstzKCeOti?=
 =?us-ascii?Q?qgS7fWMKncEitWsxFIMBzzrBF5mmmVdzEMHY/Yow69f4XWBj9lTkOC1pXK3P?=
 =?us-ascii?Q?OBkg+CQ8p5IVuBsRhdvraXtxnTs047RJNceY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTaU13qLBVTZSAqv0bD/Bost7ij0s++aUP+RZRJoEoKtXCbctp3h44Sx4iMz?=
 =?us-ascii?Q?hPJnO4fwXVdZKXKTS7BvdytyoTHsyTouNDSSeesu0sGkzbr4M7b34Ic14LxP?=
 =?us-ascii?Q?SHjyjqmDlBdZYqRxu59GbPnWZLPwY4rzJn6NDXe3ytvF8v55Jx4aHfcvg6Dh?=
 =?us-ascii?Q?A8BBf050vGPJd6hYwmKGAD8wEYNs0R+JcJNseVnJaNcQSYGWP5TlaeK2qdBH?=
 =?us-ascii?Q?AG7Jdtdqu/sUCKU7vR4otCz5+ey2IFDlZL6Oh0ZsenCPKJXCJDiZKZbKeTk4?=
 =?us-ascii?Q?9Fls8R9BHJrZ4jbHc4Tun1glKPQjW55jIwUUQ+CWCPz8NvhVioU1cgCLHTsD?=
 =?us-ascii?Q?ejFlsL6TmzQOgxPb84vqpDCupWnnsax36JCjgaBoRtTL/+8UogmRX2dUUQB2?=
 =?us-ascii?Q?t9N6a+wSOpmauzSbGXH0i0DpwWSEmJ/4Wbs3l7C5BWrxdpVdh63xYxaNtZga?=
 =?us-ascii?Q?HEPtFf1eU6PM5EoWp9Xdh7WJjQGW1LMk0YYRlEQpGg38dp5XtlrMu0TNgv0H?=
 =?us-ascii?Q?fjIX8ZVe+CDdLeZ0ge51R24YVBu5VeqlCAdb/mXCSy1XPsj95SpqbY/s1s/+?=
 =?us-ascii?Q?rkkMNXV6oBFCazyvKNKVreRm8FkzNS1ffxm6/ARZ8J1pS+98Ap3YlGUbAGis?=
 =?us-ascii?Q?6P2lQUwtXfCbtCpEId5z5FIZ6o4hiHG6XS9k9NGd4y3sWr4Vx9X6pqOlSGus?=
 =?us-ascii?Q?fs1TCh86LrHl7L0MkcK90ahgTriUKfLqzWbYbF1mWG16EGWmM+UJ3oymwtmB?=
 =?us-ascii?Q?vaLm+MABdKLD1shWY9hSaV9O3LdWQJwGxiLPcc9Jcay5ulWmIGsFDTv41fw3?=
 =?us-ascii?Q?Ko+7TgIX55s6rGl89uFUmaoEM1Be+YbTtqoSbcl406XRCcfGlEKxn+xK0SY9?=
 =?us-ascii?Q?qdZEUxEWQlgnFlMuo+GAOmCO3k0OLvKlUD6J+HQZ0SNJP6MkSeyhhUzM72ii?=
 =?us-ascii?Q?L3CO0OYZXzfkpztruygTYd45kH8TCMmlvk4FFENLh+jOUPaXDzCbq8pwb9a8?=
 =?us-ascii?Q?0xEfXJdkKD/QdgUMfyw6BWvd1wFQSKrp8A/vexxWdiuftKy6CCjDBo4l5zWs?=
 =?us-ascii?Q?LuSsOQvh+tpqXYprBXaYyHBm7crQ5ljkTD6oF8RqzpMxndDELUggJWKyGvMw?=
 =?us-ascii?Q?jp2ftsSGVdoDtb40pGK3dBQ8ulOhCjFOLdGM9S+4NZL/8ra0EXQxgk/KuiFK?=
 =?us-ascii?Q?7d46JcJhXfGViIdZXew4ebh5Lzs/kdINZexjFvAZOsNGuL7fmiClVnm98XwU?=
 =?us-ascii?Q?2V5jZj6Mufc1Cg7XPZUTPakEhObZBjscHhYqVOodtkTM2SVeiISE5YyZk8cF?=
 =?us-ascii?Q?FEdimm6PmjB2L891lJF9s+qutpXkywuAkk8EDaN3vv4QfYP3o1KN9kEl/Gbo?=
 =?us-ascii?Q?7J6Jq667RZlMSxe+ZgrGOEdtfXbRrQKwFEtZBJ9kb96XiPMrVZY/nVxOl7S3?=
 =?us-ascii?Q?ruO5C2wqSB0zgVS0VfNmccv9zWqt3Fave/xpQAehi7XCVQJ5MJWhVO16C2Om?=
 =?us-ascii?Q?DK0SHkaM/72dTaYM5GWk19wCot415HHJiMDyvyIYWtGJnmWfuDtuNfbhpVp4?=
 =?us-ascii?Q?AFTeJqC+HZoGOaBMSnq7ZuKr/FfdXQ1KHvlXryzE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54c86c4-dc8a-4111-8f67-08de27167e83
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:51:10.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnXEMC64561JCfUDTvP9dCZcTgphb6GiITisdgbd+18mzl6rOmftDJkhm0PMusAqKNW5XE0a274wx8HFlx0bUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11439

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
index b6fbb84cfb06..c2a307c6e774 100644
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
@@ -2517,9 +2515,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 		phy_set_max_speed(phy_dev, 1000);
 		phy_remove_link_mode(phy_dev,
 				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
-#if !defined(CONFIG_M5272)
 		phy_support_sym_pause(phy_dev);
-#endif
 	}
 	else
 		phy_set_max_speed(phy_dev, 100);
@@ -4402,11 +4398,9 @@ fec_probe(struct platform_device *pdev)
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


