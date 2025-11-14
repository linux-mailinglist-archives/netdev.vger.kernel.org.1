Return-Path: <netdev+bounces-238578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFCC5B638
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 06:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 015C93560CF
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629B2BE053;
	Fri, 14 Nov 2025 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aNMmJjnx"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228326D4EF;
	Fri, 14 Nov 2025 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763098090; cv=fail; b=sVPwQxpANcEscCFButvbibl+4WkvTRLz2/Imc2TBEkHLuwFPv4T6ande7/YkCcYM/ECUwtk/ZD33nw+2uGwLd/hWFCGViLZMaibFMVU+a1ldOKyTOgHF42qaiDWQSBcaJY5LT3Ih99bE47P/oz+ZIkhb6tfJplF9Jb12sLrlCUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763098090; c=relaxed/simple;
	bh=riRxEt+oTqNfK/V4AOnA5js9Qe40ybs/wQswrqiFKh0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fK0I1y/tcUoZaOVY1DvT3Bi8QIG6sj9LNfz71DzFUoj0P9IYWx0tWolOggd6S4q+H6SLOmfi1Qpm4Qn8hskH+s9PV/K7vsOq3aagGddBs3IiPeTwzA9gmWF5YFCSmCf/+fI71FsYITp90c9kY/iJ60p9IigJh19NmE4uwK5Y/0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aNMmJjnx; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMFc0hcqGFs2UTqXXL0hL7pGeHrT9v+qNn1qBed01tvbfoR1RczX/2bUXEgrzz5F5gATrgeS2Rw5Nd60YQsTFQ3gaevQrcf6i8IxQgyFWB3FgbmpEEDuUPeCNOsua6dqKj7iOkBaKrZdCalwP3e3BNJJBdPV59l8ZJpFriSsZevVLWe1TiveLSae5A1HM0oR1w4UoEYSloB8hmYL7gZQR1ZU8uEtye6O3DWicnkNECYCNrRaMnrhFp2HuniM8T1WZR98zGCi9GORVwswLX9BUQHINTtkUru/tWongDp36UvTlnQG+xef8v983RRr+VNk89rsZg8Gcr4hk4j+jjLpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z5YwaIfVMEnJcdIzVhp3JUMotCHKybsedXk1qpL3H8=;
 b=vAGIhOp60H4DO9iS9kCWigBnUgmf5cS+m5pT6Qkj3LjqNCyTB1Vbi+MHUfv6CvC37KUnT+Evzf+dALzhqNnVyK/+TNugZP6FjP7Bnac5tIwwakjFXp1bfMph8YiePInOZOZ/S3HAl9afL4BPgrs0oalrRUSi25YOcA70OCz0hDkjSvLyPIZIHsMe4aFVyPkrkfE+fpnGyM99BPBXxfLrt2B0bTWrGXzoISBLnOQMWl/mBRxU5RyxD+YMjRCriqrNaD5gm/05AjTz472Q9ur83iO4UA0lLeKZWY2ahf/Ix79lcfFCaZWNy2qf9kPhZ5Lc7EHM4TU8duxYCkxGBBMHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z5YwaIfVMEnJcdIzVhp3JUMotCHKybsedXk1qpL3H8=;
 b=aNMmJjnx3MQ/nXHosGV/cfu/TdQxa0WFBrN3OBihVRq3ysboTEXE4GIfDpVLpppmLbxFHF9Ud1CEa41qKLyN666+ihJisP2XEWwV3vqbQCWm7RJ2w2AFa4cS8c6msnnBp6V5Dg9vKq9DySTprKKIE9ex/bbHiLQq/NAaDCNhF6kOsX1p6AQvdwMM8r8sh2YJpfe/UU2B7jrFCuJqrxK+jM/J7fXenGSf6aNTPxEB5uiYu+uvmKKaRxjL7T3Ud3T1AGUtp8DhCqyPnk2IZB53TFZhm9aE8eOb+pCueaNjf3Qp6gmy/pMjlhuSekexLdi1ylmhwcVXSIasYBhURfQk1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 05:27:59 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 05:27:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phylink: add missing supported link modes for the fixed-link
Date: Fri, 14 Nov 2025 13:28:08 +0800
Message-Id: <20251114052808.1129942-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 381e8677-4ca3-4673-c2ba-08de233e9264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L2xyafKEXnAy4/aYQxLE7ozrN8nmZ19YjJ78cy4T9mGddqQY4Fqrf0hpnp/p?=
 =?us-ascii?Q?7tZwt29KnvBb9If9xGegBr4UdSx+i8x+zhXrSYrvRiN/S8HBtCQ3KDRzhQMw?=
 =?us-ascii?Q?s7hlnA2upxQiFeGKbOECn6F71Sho+837fzx3BbfE5Ywf+Tv8wAf7IO7HTicJ?=
 =?us-ascii?Q?FwJxAtEaBgOFx+DZQPIYCsCZayg7LoKTpgaoBtq8ALgtBytShDi9F6roUk9L?=
 =?us-ascii?Q?7V5mjm9DvPJWBTgh3gxXxSIwmBerXUFKK4R0sqzPp8lxj2GcsJFQPUgj196B?=
 =?us-ascii?Q?HFoWcxnvhYaVLBdpL4fu3sv6VLXofUWQzYN68FVled6iigWk41zIyUCazhp4?=
 =?us-ascii?Q?2iCQykM3DW9FEWJshQMcYimn/OKOAOS7XQKohQendKZ477rho2zpljyKAjdQ?=
 =?us-ascii?Q?imSmq2/YfqUt7G6RCwkVKXMHw700MyKc/ceosmAFV/dVHvy6rEmrj8z25lgj?=
 =?us-ascii?Q?CH/aXKBlfu45OBmR8xzaOlJYkkwbItObRW2dMPax/mSdnGof7gEUVuwaAkGk?=
 =?us-ascii?Q?0G8oEZ8UWc49IKd4Q3J9/BT8RIueAuSUOoAB0Eg5WH4+/vrZ44goHhicX3pw?=
 =?us-ascii?Q?h7qPJYaAekdHuF3hwCWsedUuJWDOvv6mmoszq2zeDfRIAOMEDNgURVW9WeiK?=
 =?us-ascii?Q?rfSVqOrgiVZT/ggTEuVg6wID1D8b4Yp3IfN4di9ZSDGHZqexXikeixbj9Tao?=
 =?us-ascii?Q?kSECnM0LwEtWSpalcKAAaIt5VVxFRmzu6VjMzQnZWd0jzqQWVhkTPVp+evna?=
 =?us-ascii?Q?cFFzWPKsAbdwm/L5NDCUF43kUeeagBYmTiiQDvXNichESQH+u/mlQY8qerU6?=
 =?us-ascii?Q?tmfOSQLJloA9OVtxyckZ8mNpDGnn73maVjg03Sp76kHHs0FC1GLgsMbjOV2C?=
 =?us-ascii?Q?GScbSVkGA+rfI2KgmMl4I1Bu3T8d6lLvUK/yKqjW5FtsZE+uLY7x262mjZpX?=
 =?us-ascii?Q?v3wbvbucBPl1w6hmk4PoWZ8IvWbAOTjaYUBC0rrUqNz/ERQQzueAE6iYXzkz?=
 =?us-ascii?Q?jQPoc9vQ8UeCU74jg/7/6tIfMC/fSIV5jtkqO4FftKv+7kauZd0YFLfuUTPf?=
 =?us-ascii?Q?KL7OI8gZVw0gNWzSct0JHlrq22PiZOiHs9JrNTYeSob8rxiPdkAdgcOAhIey?=
 =?us-ascii?Q?PKWWeIi1xDdEUxKereeaXF515XWUHgwhlD2amh49O1Nb5F5u3Zy1pvIZr+Ff?=
 =?us-ascii?Q?zToZ3672/01OiesqNw8KXBbOlah54DAXNS4u+2TCwjkq3WV3obIv5J2b2Dqu?=
 =?us-ascii?Q?a4bwAp6bHj6/ugPHEGOGPtOLvtoXK5hgy/9kI2ueUuCTcYe+KZy7df+G0JVG?=
 =?us-ascii?Q?7OZQ1LHYjM/tUR5HsRxvYZ4mZWtdtdBy9wyUfgM38Jt/FSOxtZiyW/q4iY4x?=
 =?us-ascii?Q?4xIaoftU7BSccfTiDjqLskjJely2GVXOKqGOsiGs1Ig8S1gmRTgyVQA4BNvV?=
 =?us-ascii?Q?/yMBVjo6qaAdC0QsWjGb3Tj3OzTbH78Sw3k5c8x3bUD83nDwZ5Ye+5ZN8Ygk?=
 =?us-ascii?Q?qPx/80XDnnmxjQ0WZtI3Joc8TexWaXk6oFT5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZpdL07RCdUsTVXV4+IE2jUEPHwLQi3XwEIYpWP4bVHC4ZE3PNvmi6NNrBQ6?=
 =?us-ascii?Q?bvhn1qAIBTFLyCjEL033XlMqUvQat4rdS1pyMQIMAaA+TSPjquksyG0iPTk7?=
 =?us-ascii?Q?x7X2iE3l1MSviOB827SyW355KeAhf/kTiYEa7tm3A3H5b3lOrqxPmA9yoI7q?=
 =?us-ascii?Q?nak0fv8ZJ+OgtK+R3U18GoxggnWfeVW7yH1sMUWPYf91+Gfib1/5NSO1eQCb?=
 =?us-ascii?Q?RMKeSwBnu8mVWM11wQaF5UTXzGudb406XZ3VTNHMW3CvpMo6JgDyt275DAg6?=
 =?us-ascii?Q?2SF2uyG5Ni53bTmSWdXLnqaiVeO685jHQqwPACvRc9sDbrHg+3OlyMqjLYbu?=
 =?us-ascii?Q?Ei7+0QK4xJ91t2zvWfX+X3Ma3Lalmf//MxDYLdagr7FBa4cdlg3JURVlMl9M?=
 =?us-ascii?Q?Zq4mQqCo52M2DsCkeKtdBv7sY6wWMaP00GgPrfCY3mcqUwsFjzmGJFRHoZHf?=
 =?us-ascii?Q?UVj0Gz9J6t0F2HguSpTe+Hc2tr90mXH/JK4H8HW/WZ4vATQwtP0mYj9XDysQ?=
 =?us-ascii?Q?6Vajj9/BTfrWwp/zgPAY/tTuOEbZsQ/asWNFhoLumoUlNUkDt44B/H2Tnwpx?=
 =?us-ascii?Q?be5lrFFRVDjaiKyK3iu49Z7E8XDqUdVQye1az7UltemuyX15Y1uyKTCUweww?=
 =?us-ascii?Q?xLSnr2yxB/iHS0StfckKm+miZKkcX1J3BSNALwiVlJvWcQShcfYEysIc5uTO?=
 =?us-ascii?Q?0U6nK4Tqoxgo/mcQNNiW+yu1uW51QHHZQsLOB8IchRqTsd4Ca1pPOXESU8UX?=
 =?us-ascii?Q?VSprPDWjy4+dFsVtnXnrmYzYnRbBenfQKE1QbX/bK7ZgOAdc5PYgnA3TRnkO?=
 =?us-ascii?Q?7S2oR9l1gHWd2dyIgdFXWOfQXcEd9wvrZ8tt0LibTMKLtMZaHsSpBdBkCphR?=
 =?us-ascii?Q?6eZtTFUSrAJgefpDCOkfqj66eizsPpAuLuJRHyZtDJxXg4WrT0eKcYsvVCqH?=
 =?us-ascii?Q?QHPNvMjoLMTP22mzgJeFPKeqap15xeyxfWf6FlQonHgBdETjlD27bbNMWEo0?=
 =?us-ascii?Q?sUyqgC7CDN0pis5Xlo7kmOH41Uefq51bS0CQ2y83qvOOhvccj11R+wotWzZN?=
 =?us-ascii?Q?c3uZzeyV3QCoc338FLq6DizlYqSXpX9CQgy66Y5yUUzRMVt0h9cfxqLfLQaO?=
 =?us-ascii?Q?hWve1uzMF5m8Xoc/SFM0aTYqDtZc52gNq2VUY4wb0ZtPWm1c1WJpvxCmnPu4?=
 =?us-ascii?Q?sd+70DSAD20dBVuy6fi2BKTf+1Ou8lBGQha+wv9ga/dUyeEB55BP7mbv67kc?=
 =?us-ascii?Q?wXd+LvHgKyEmFzpf2Rx7f0bFdQs0i3m51lVqO4d7ymTE49QOdwSlG7XpWx3E?=
 =?us-ascii?Q?h7pS5RftJ85G/xsjXIUIewex4qLBpg4fpLYIwJN7oAgMTE6VCllP+W7qLsru?=
 =?us-ascii?Q?KPjhIySIjxBcgpTY77Yy1DmOfENBOO57P1kinm3KS+ON0FAvhpMWn9IobStn?=
 =?us-ascii?Q?EqtfHrfTvR27ErefJpKaMP8/v7QFgs7g+76hV3yOulR8gTfEQzVYzr2KsIWt?=
 =?us-ascii?Q?i1hrbcrSop0ojz2nzcZnJdptV1YFGAAcpP72nmk1pV1SqE1KVPmr+ynuVYIx?=
 =?us-ascii?Q?4jyWy2GgKn8Q7qDr7/lxf01lGJrXz3vI6a09AumR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381e8677-4ca3-4673-c2ba-08de233e9264
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 05:27:58.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bLuT6AWuKgmn7b5OPSxMtMpQUMWP8lirrrIgIXUJsLUOuZ+gbbDJ+Kv9w5KP+Qa6kD9sDgosOEp+Z8eKTllWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640

Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
initialized, so these link modes will not work for the fixed-link.

Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/phy/phylink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 9d7799ea1c17..918244308215 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -637,6 +637,9 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
 
 static void phylink_fill_fixedlink_supported(unsigned long *supported)
 {
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
-- 
2.34.1


