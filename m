Return-Path: <netdev+bounces-239077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A9EC638C9
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A03CB4F0B5E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3483032AAC0;
	Mon, 17 Nov 2025 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yo3ltBre"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9C32AAA4;
	Mon, 17 Nov 2025 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374748; cv=fail; b=lpX6IRj4yp1kzRmJCsA+Mnc88ztvrvKViaaTrQADnJB6eZFt+fybMa26MLECV7nMsGcO2poXr9lrcTDfGchhEHVqgCpBO9gvDSVCtsF8WDKmKDyy4ns9t4oaC8j0iYFeXrydn3Eqk+gYuTS8xFGJAXN7kuC6UNanD18G2Vi2Yds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374748; c=relaxed/simple;
	bh=CiBSdnMypNR79jw2M/PMamoqaw9jg5G1XpUNz7Vg4kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcGVLSjpIi19LCQDkXwlLNhqdx/zm8Ap+xaABhO30zrZGMtA05PnFSsJ8kMTjC0s+ytg9t3IT8681qRk3LmVS6TFrI7vBjqZ/M5CB/iNGBmmNxIQfLWAbKt8ogLal7kqqy+X1dLt+2BW7p41WTL20/KWWPJDlC4Zdv/5vi5ZK9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yo3ltBre; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdFTn7AGaQ+vgySCwoPxur+aIlh1Tjy7AAa4lxsj3sI2XSedEE1heSE5Amjc9UfCtNxujiyIraVeLyT5yy8F8xvk4WanVMMYIFtIckQnVZpTAQd9UulRWPuzUryj7eZpB2XdYbg1XZZS3zDdiCrFt1optKojOBJH1Gk5NqX2lp+SOy3jK1jDelcAO+FKhWUuceSFRIiJIvqijorEJpZ3OIx9SAgGl7upSxZVS0VjY6hdSE4t84YAJ1QrJZhpbL37YgD32mImAvwVi95pVrARcLISBm4kIFEAOpFeqJqsoHgFSCtlsde537DeA1fOJT2bQZgoUccD+y4rf5t5SySq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKic2H7+6PQB4Mj0ntYl0nujlqC888QnoV1fALdjQXY=;
 b=VCavT9lyuwZ477CkHJ2ew8buzs5kfVE7NDZYQupsKpw5uMyVauObXNHP+ppC4iAtMl5JDcDTPhCi/0pfUEGAjgj5wIuGF0LcrAk7NUKCviX0a6cj5l4DCZYuRCGiNOWMzfaZ0ZwccLYh3gaMK+94mgu4zBzr42IR2ML8HOlk5DEq1QiQd4slwYRsygAdia4ie7AApdY62qrJxj8h8k/u81ix0Ti64qRg5ic2OSh1SFI9moW+clZrAskQAo6rxrTUZWXNqwJyZkoRMst3bY87pUr3FfKXq95Un1NC6pZGzGwz4eCUhBFA42lai/1fFajKqxiawLlJpGPDxdTksOzSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKic2H7+6PQB4Mj0ntYl0nujlqC888QnoV1fALdjQXY=;
 b=Yo3ltBreU5yyT92ncBWjOHvjLEI1aMfYgqq9i/tke3dX8Inr6rWYRFZQXTqbq7rnTg+Dvo3B68TUgrGyqCfolyuKaBdsyaeWkGZ69ufPzR1yV+BwEBmjvofzUY/GJjD4iHOlxve3PDSkJhMaZfHNjYs/qZPWBguW0recKIQmVjZGmT9vsMcMD5AIMcpKxt4l08v0O2qwPKny69b5s43XOVoDkwCUHezzSTaSX88gBDPTa9AZqnSXdf5QyL7h9DIeKOYuw63cUHN7xdykGhNNz8BKgWX64Dcrn4fuZ1GRyw1cUrjf+zBwTJdgsBO02aWGUPEPTWLgWAeunbTDAAcfWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB7011.eurprd04.prod.outlook.com (2603:10a6:208:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 10:19:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:19:01 +0000
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
Subject: [PATCH v2 net-next 5/5] net: fec: remove duplicate macros of the BD status
Date: Mon, 17 Nov 2025 18:19:21 +0800
Message-Id: <20251117101921.1862427-6-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM0PR04MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 315ac86e-b7fe-475d-eb4f-08de25c2ba47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1tfnHIa/RUtKKet0VPPO1pDlssGnGWCfTXrd/FDDTuuOC3Mh/zDD7kegeVmm?=
 =?us-ascii?Q?6HDw5TGRdnKeibQT03WNcLW5KVdBs/6n4VqLsKqTtliWUcWp9mfzqmQUAi5L?=
 =?us-ascii?Q?pimOX2/DA3UciTFwizmAIpfnAH6vlYEB0iYNyjTrca/jCkL46ADZ+wVEsNtY?=
 =?us-ascii?Q?KQRamNcLS+22Y1then/FE/zDbTEcXP0AAr94o5ZJeNcBQPiSqjeoTDPNcCcm?=
 =?us-ascii?Q?CnnPicpaCBi6GjJMIYbRaDZoa7oBeE+XYhmy7PaGy6AkJ/FjVsvAKxh2pLCt?=
 =?us-ascii?Q?ZUi58H/3z1npMW8F6jfdwztvJIhhufUNUUhRKRlg2Iv/kverka2l9OZql/NR?=
 =?us-ascii?Q?4ahbkQo/KzY3N1uojIbPWh2SMz10z5LrQfRd+x4ryieJcBvs5KnmYCuWf5gm?=
 =?us-ascii?Q?fDbkTB2HomSoCKNCLEmMIzYZqDCum10wHrg6uC6JX7rJpPF2kktnNIvVA1Hq?=
 =?us-ascii?Q?R5gJ00y9C/mxkj2Xrve9+ZPMxxNvuVgJoxhvA/AQT6LEUpokM3DcHApi94y5?=
 =?us-ascii?Q?/S+4aJHHoBZd2LtOw32kbcnYDaGckn72zJryIL2BZjnCRG2GwuM5NgDTBfBb?=
 =?us-ascii?Q?jNzDp1/SqOm+UAhICWDGk8+U32nokFTRiFj1ET+W9E2gu7ZpGdnIziRlsHkE?=
 =?us-ascii?Q?qSuIK2G1h+GN02pwJU7cGlIDytShLzxHNC5+oi8YNDUF2dfnbIoT+KF9Df+j?=
 =?us-ascii?Q?hQ/44ZuxFoTgH2UOXCjyrUjWqB+nakQBimN8KHYS2dAbRTJq+qhvsLff8GPJ?=
 =?us-ascii?Q?5KpitPiz8L1fTehj2TCK2MGT0X5+Pp6ra/d1y0G43vGa/Yt224l6XJjntT0K?=
 =?us-ascii?Q?HDkAAmn1aN66ZsDfnnWb2ug6mdYhYRAlTei8lxklKsELuYtXC7UC/aqkMBKS?=
 =?us-ascii?Q?uiPX1Twmi5jIb9frClqs1uueO7DG4lojZ7obCzDGUJCHAqlEUROKt/zNGCGw?=
 =?us-ascii?Q?FY8R2f99pzWbmS7GJW5DHTnNudNfthlckDYAajNhF0IIW/CTFGwaOy5rvXsC?=
 =?us-ascii?Q?Dkp7DS1nx/LXs5mZDVXNdp5Z+9khilHM38KG5afhURxULOw2FwlLfhdm2M4z?=
 =?us-ascii?Q?zN653rHTa4qS7eNc8uYmHZDvs5X3Mbs1Cz6QkZPCzBWnltkHIgc2XPt3nAGO?=
 =?us-ascii?Q?TmdQQCRanNtUsR8rbcA93ce1NKauK13do711CJNq+juRSpAcXOFgjOHBEPIb?=
 =?us-ascii?Q?CzC6lIMrQBJKU7YYN/BZ4dQGlj+2sPITYN+138mBAFT06Rcbtj6vsmMh5Md0?=
 =?us-ascii?Q?y24VHAPmZ/9auMhITZKJbVci45TZSYX6nPOrh7LFfYu+N8ytii08ay2bJDlf?=
 =?us-ascii?Q?d2OwdZHVMeNYwmFev2z9uh97FlOIlOnimbzJSs4eapg6VJE47Lc7b3DdWjt7?=
 =?us-ascii?Q?j9AQ1SJfc6DiMsynCJ+ObdL7B1r9fAMZ+mq0y/LHntiKc3C7QYuvAQ/YJYdt?=
 =?us-ascii?Q?c6Mob7CgdyEYaOQbfcY+tZ3IOhvqdaNXxO/Of/Unf94VXuXZNApUoWTkknIk?=
 =?us-ascii?Q?Fdpsr1yNbeO4EGAsj72d41k86GuhxkXku5rW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00lPXe6YJuBWdf6cw6BPrZFM87fdsq74klWazO4DZgN263SNEHzdW9wwfICD?=
 =?us-ascii?Q?iNx4snlJ291WFvTTeXz+zWE769olhEOSYa2QQFxzDIAt2E0tGm0fceaNe0CZ?=
 =?us-ascii?Q?szhEhLdewBrHZ3LoMwrxiTLB1LBfBAMS1oXXI871wt42LsESD484xUZa5bE2?=
 =?us-ascii?Q?9RiF+Akxy4Wpqv3Q87PfBBVrmcoUfv1YjRkChzOU0aL/DVB8dp9UQKk1+/Je?=
 =?us-ascii?Q?rp+TeDsmMZu/8Oh8gKLDK76QzwdZQQN58XtjW04bhwqSprYA1US/yuyzOMNr?=
 =?us-ascii?Q?Q2hd+Xf0X+XGAMi1+J8+58bILnZZcg8YZsvJb4jfTQssmAFXK7QB/lnoEDDX?=
 =?us-ascii?Q?2JWzfuDjajUy3Q2YO1xjW45WMB9C0JCyNxCNho/9tMpATLx2Fa+9TW7+DFga?=
 =?us-ascii?Q?MwnFo3/Iz5EpWHXfChXd8niUvk2dLGCbiENo3sbE0+9gTnl8Zhe7na0XVGDc?=
 =?us-ascii?Q?itX0ARUU+IM8xl83UjRlhEPDkVUdVvCKACqL3zZXwXr5wUvivaNCHVCKnK4J?=
 =?us-ascii?Q?v04xK+qcUgqxJmS2Am5mtcB9vvpRnpeeKv8oeJj9uRdx+Ij9FsiQ4z9ngP9D?=
 =?us-ascii?Q?SF1SBtjZJfOz98BfOYEtyrdlAdgtN/U2Ga4xSqLAHv6PW5gTi3ULWMXaWJ82?=
 =?us-ascii?Q?XNHUenBQZJTnj1sEnCTGU4JsRYo4/BUVLobqQqbKstDm4q9OnIkMsoToPaj6?=
 =?us-ascii?Q?9XCUmZfl5/Q1jc20OR3nxZSChtV7QWYRwUPUji1Pfoa/F0BxUHRAlnZjcRRj?=
 =?us-ascii?Q?1USkUy5gPR+JTR+Wv6i5pAKsvkYpe0UW1XqwQZi2KbI7p1pbfXfZ4aRyDl1s?=
 =?us-ascii?Q?JzgQjPF2PnWTzlV4KY0hKq3+Y4Jyqo1pdXfHxgLMrtXjoGhcy8gNs2+c0f64?=
 =?us-ascii?Q?KAFfeteTl/D8ER4Y+8RDGKOK55XELj4PGhtjJmCuKi0OT5tjg9xt0ipLC/gF?=
 =?us-ascii?Q?RSrTpOGGpZwo5OfRvn6LNQUaTjScus+T4nG+boqeCVl0s/SFX+3UPEewcFql?=
 =?us-ascii?Q?PQCKdiVdzsDoG+idumSiDCuVT4k3yYwLhSAXxYsvSMXEiFe6KKT8bdfgiYDV?=
 =?us-ascii?Q?Ud6iU0xELb2b6HS208WaFnltpG9w6XVN4JJ2J1H0XMh0EVqBKpx6AJ14Fy4/?=
 =?us-ascii?Q?bfX6srD3VfwdrR1EnVJ5K6SXl7myGL7mIEjr1AEvfYGcIelb6hQ6Xdq9zF7B?=
 =?us-ascii?Q?K1FdoyqRYPG9qfMo0+1GxT7QOz3YBad7lFZPLl8/vzNUiwE0QhN3M1e8Zpb2?=
 =?us-ascii?Q?PcDedA9SQGXvR8lBsEEal5qhf6LxktADbiHDvQEFVJQwd2hhx3T/lzpfrAtp?=
 =?us-ascii?Q?USdW8H6/vhfnqMK24mVJYXMT8LvV5uEOpfOrFRAWr04BQ5k0TAu4tcF6q4xX?=
 =?us-ascii?Q?vk7CNHprXJdfCAFeKU0KvQnoSOT0WZyDkeN9XpwdAukJsdL8D82r90Je+A5e?=
 =?us-ascii?Q?zXyNfr0ce6VjRrGDeEwY+oZ63PGkb5b05Oeza5BZgh5ZVCh3SmDqnlSqhg70?=
 =?us-ascii?Q?MwR/R7n9zyOAGDNIUQsnx3Di1gabA6KIPH1cPbtuYEmwPTPRnMg9At+X30XN?=
 =?us-ascii?Q?SYQQlI13+9ULhxGYBXvvJFPGB8nUK6Rk43NRgB0u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315ac86e-b7fe-475d-eb4f-08de25c2ba47
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:19:01.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN7L+SDBZEA1Re9rMNXKH+0COUOMFqTbWdemw6XvV44yy22PS93upJqCMy/50I1j15s95YkzVR5yMAPJBo7Rmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7011

There are two sets of macros used to define the status bits of TX and RX
BDs, one is the BD_SC_xx macros, the other one is the BD_ENET_xx macros.
For the BD_SC_xx macros, only BD_SC_WRAP is used in the driver. But the
BD_ENET_xx macros are more widely used in the driver, and they define
more bits of the BD status. Therefore, remove the BD_SC_xx macros from
now on.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 17 -----------------
 drivers/net/ethernet/freescale/fec_main.c |  8 ++++----
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a25dca9c7d71..7b4d1fc8e7eb 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -240,23 +240,6 @@ struct bufdesc_ex {
 	__fec16 res0[4];
 };
 
-/*
- *	The following definitions courtesy of commproc.h, which where
- *	Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
- */
-#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
-#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
-#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
-#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
-#define BD_SC_CM	((ushort)0x0200)	/* Continuous mode */
-#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
-#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
-#define BD_SC_BR	((ushort)0x0020)	/* Break received */
-#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
-#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
-#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
-#define BD_SC_CD	((ushort)0x0001)	/* ?? */
-
 /* Buffer descriptor control/status used by Ethernet receive.
  */
 #define BD_ENET_RX_EMPTY	((ushort)0x8000)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 785bae8e1699..0bc93fa15ebd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1010,7 +1010,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		/* Set the last buffer to wrap */
 		bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 
 		rxq->bd.cur = rxq->bd.base;
 	}
@@ -1060,7 +1060,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		/* Set the last buffer to wrap */
 		bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
-		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
 		txq->dirty_tx = bdp;
 	}
 }
@@ -3469,7 +3469,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 	return 0;
 
  err_alloc:
@@ -3505,7 +3505,7 @@ fec_enet_alloc_txq_buffers(struct net_device *ndev, unsigned int queue)
 
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
 
 	return 0;
 
-- 
2.34.1


