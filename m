Return-Path: <netdev+bounces-237531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62BC4CE11
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69881892B29
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138093446A9;
	Tue, 11 Nov 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVdyTcVF"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9E33291F;
	Tue, 11 Nov 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855237; cv=fail; b=mJXJarvNVTPBQpDNgV08dt0eB0fy5XnK794Z0XmHU38fA6bhl0UcJDXOiATyuol0T6KOOtsrXKtNDSkN5sW2SB1iJ9jfzAlj+QXoqLiDqI7BsPMPd1ZfeLAPw9cduAw1xv9Cj2e5kILAQczgQf+P8fwb3iJTe7GfnuyPy2KuIPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855237; c=relaxed/simple;
	bh=ozoFHH0agETR1NaTx5iiDfq+Exfc3sUQbCc8xbNF3j4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MBAmTrWDC8rVsS7wFRK0rQiTpJJDNoJ1p8FGZ5vgIc6s7N1LW13C1szRH0CBzvPA3mcvg2ebOwFzj1Nz6vBPWG/AdPLcjJWXk+241x4vb5zaiIgQQJ6E+Zy86PFpilBxwIkX1rQOUxy6gRXBzYCx9+QL2AD5/O3m4x0qxAH1+NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hVdyTcVF; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzY4b9zOUYcfVxiNYe0AyiO6cLsRK9Ev7RFognjoJyeAWutwShJpsQKsbpiGjKEu05rI8Hz4TmBHLuZAZaLfwwS5+nQxTvbwWfhTsCwEMS/d8otVOrEaKBuf/RGOaq+cEHa7f8efsR2LrKPIVcW585EMhP0CbC1xwyw/XsHMMhgyHIW24bWc+E5CLH5au11yah8ih7tYbbOvwCOe2XGaxLy5N+XC/9aAeJkS8GlC7n0iBhXhx/p2dvX9kENpCDd+6QTmXKdS74E7Bbb/2e/4eeQd+555kRuqIM2fIcVSqV7mPXJpN7sQe19L9nR7Z/Vv2GevTovOGm1EJtxOpBUiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16mltBBiY7I/tNy4UapJ6ADsBIheLEBNkpxs8oE/Hkk=;
 b=jZCKumYuiEurvzExVrqM5Mn1XO4s2RYRmdczwxzjqyrL2Wdgv4v/JjIRq0lYVxLEX1l1L2ltDOAI0GzqjXRibchFGQBK909sQXGwXDyboKICdE5D67j1MPuAVlaz0vNAO99B4OSrsdAp6CW5aNSFbXGzO5sCpmvWTjievGx7f7c2GgLFUu2atP55A1kzOIG73Mg2cWi3wn4KLrq0F5IMhRGLhLPbq7UFQdWAbtJc3aYd706yoZoZ2pSNHpdqujt/f6hoYxMTlAT8pqUIONd1fl6wu5P9o3SJqkloiaHTdfW3JOS2O8fQWbQ7QMIKtUdvhycsToPFYxWOz4BwVmgX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16mltBBiY7I/tNy4UapJ6ADsBIheLEBNkpxs8oE/Hkk=;
 b=hVdyTcVFRGO1HqY1nuk7Bn9FCLy3/Llho4Z89dt/WEP4GizTrto4cSFh81ippzisC2AdlIR2lupRjhxa0vnMklLglt8aTtiRVEiBX3Qe3kLIkWaY2iP7nIiJnEMihgV9beW1SCac7Jp4kl4fZzUMT46pYw6DMyflpqM7wmLcVuNVzLSmQjKJJwREwWZ4iKjaMC4aaOaeIpuNxI7wKDshPKxmdEgA6s6Ugv62FDB4LYEj7ZvtCatO2uuYrg3obV/eO9f7R7Tqv2TqRpfr7Fbp3FWGHeIMHnpIOBALjQ5l+uGzYR/CZoQHgIpWOcSfXB83PMnwTtd59Pn+EjZkeETrXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7545.eurprd04.prod.outlook.com (2603:10a6:10:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:00:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:00:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: fec: do some cleanup for the driver
Date: Tue, 11 Nov 2025 18:00:52 +0800
Message-Id: <20251111100057.2660101-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: f67d019a-e99c-4849-904b-08de21092599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LC5jy/GsU+pDRLjlIYgPYAlDGqlabxujQLiWxVR6CvNKm+5zxnoRdcvBLsv8?=
 =?us-ascii?Q?oF63IEtcO8CZTfkqA67n382ebjzI+SNkeZ9EyyqeYRBgpL7B5BnzprTNNP0/?=
 =?us-ascii?Q?J0hlxQcePmZ2qvfrSgN4G67mChYqB4w/eqZ7w0KxCtlIKHAT7G8jWSwKQBQ/?=
 =?us-ascii?Q?3eBVqs7qWG79a5zhPPK/98YPsx7cgtiZgXfSwagwixGJOpLYUP2Yr30G6xbz?=
 =?us-ascii?Q?g/f+UMuwPWjcdmh6OsJyxF+H3ye1j5OFLLESSAhsQWObu8GUCO71PkKi7zwb?=
 =?us-ascii?Q?bs6zE/OIZiowIbhF+uRtlx2DYs4cDiGP8L1+5WMEdk9lzxextIcNZLeulltq?=
 =?us-ascii?Q?dw/N9FQuXFeHFANYKT6boPJsTzQrco0rl8GdKmkr8RTtJCOGuT5QNHCPmbg/?=
 =?us-ascii?Q?6/t8IwW5DJEiGhl80W1JGhGyudidDs36/23P0e48tBFyjQVAbNDHd9s49Bks?=
 =?us-ascii?Q?asA7wvaBGJ+t+S7FE8fKugKuZRud5RjwS4/ZKixiJk3yqVwwDlJJEMIpr42+?=
 =?us-ascii?Q?uEKED/zfaMEA5JQBJUOX1TTX/TTzgMQMhkhee1S32d4ZC2+yFzTsYcBWdkX6?=
 =?us-ascii?Q?ND04INlAPQFRxuvWlOSUdmmha1sq7mz3H1IX9UU2zdvENkiglylaQYlj4sJn?=
 =?us-ascii?Q?XQUNRjfOckHhYdR7Z1RR6UieX35JTB3I6DX8G7gZo06Geayk1Z7Nuha2Ij0a?=
 =?us-ascii?Q?9fZBs170hwrrhJxRyYNOqz15vHOArNDucFIb0hWhTSLOvsWXCSCfaJszKMkj?=
 =?us-ascii?Q?8KScZ4kqJty9HWLnDhUhi1ylpOX88pDKGFJsibYgXizWmLQODGdInuIhGsRO?=
 =?us-ascii?Q?NDi60r4I1FgI74I+LN1teVB+K8cWEBjAS4jVq2eqp4u1ccswJpbfTZvH911D?=
 =?us-ascii?Q?3CDcOb1dDGT31E7HAIGjCPR7S8uyW6IKSUdEEPRuxtXOTmbTH2hvnStzjGNN?=
 =?us-ascii?Q?0jGXKbQgxbkO8Y+/8l0kBAUf5eK+izP2c/UAxqEd+vJtsLOLcvZHZTwgYNJm?=
 =?us-ascii?Q?0SwbsshxKfAakwSciRIqocYxukMCYeWC1+VP8qtUlEnm5xPoJEuzj8wvoWxs?=
 =?us-ascii?Q?555MOIjuj2PDnZOc4hHCvKxzAjaQaAEkRGgwpUyU/xJi9b82KH2JyXd4Vt6R?=
 =?us-ascii?Q?vAKhheWe2W+iZUxtBB5fvpaQPInWz6Lp2SRDkTM0dpTEseNIiiFx5K1FSRcg?=
 =?us-ascii?Q?Gn9WsKt5y9a0g6AkZiVRXxNKnTWD4cR58VYU1pQH5CkRKo5hLHYxpF89t+hI?=
 =?us-ascii?Q?iF2qdXdB9ddrA4OnTcg77NRnb9Ctmr/3JvNxpcFqmFUgBoQBiWicfqd4WCfH?=
 =?us-ascii?Q?W7m9fCOjt9nWwDd6KkVKcy+2Fi+yKKZHRcOetdhc6d0c+CUvZNM7MQ0wJ6hK?=
 =?us-ascii?Q?gwC90VVSh+C5/pYkUhsq5fn5tjNv1uAi8784rqf/t6xOHCiaRD8bCYxqNPg+?=
 =?us-ascii?Q?O0xpvxzWe0mUQxXJEZsBsVBqIIRnS7dlF1b5AWEqFSIOvI8Ew0hnm/XL+Euy?=
 =?us-ascii?Q?RzoQumk0MIVlL11ers1IZULgkDX/GSsKB26Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PwHqsxWE91F6KhqcQCDWK+Su0+pGRE+bCjSA1kbc/6/wl9JxAlBPiOKXFnGV?=
 =?us-ascii?Q?lOEeK2D3qEMEwUlX2KJ2GaYq6Wn6TUeHZWCK2gArFh6s0/alYeJr2krq+tUO?=
 =?us-ascii?Q?qH/j9YmsDic1Brn4+U2pAds7pZ8BFg4SgX+guXytS+b0DLXB1kfw2znddi6m?=
 =?us-ascii?Q?X1BDhSLkK+x90YFhRshogpwv78xkusnD3l2f9xrK3SuF6uPnOKKrzX9n73ua?=
 =?us-ascii?Q?y95Kg1eI28oP4YuJNdAe6FtuoylHFopP0TUoiang0E5UrpabURLhob7EqIza?=
 =?us-ascii?Q?+sH4AhjmgKXYU5xPOtvQZaIsfTiRBvbjW0/G7wvWga/Zrv8xzyfGoQhr2Cr1?=
 =?us-ascii?Q?Y/60eDeibsNG1z+F5/pE1DneJ9tfkvDmP50/AhvfLX/rwSXL/A69h26K4O+5?=
 =?us-ascii?Q?KwhNe1I7XrW7X4CPbKh0yiGmY1+3byu9RPSj6cAyfJQCixFc1gqSjnWQhGlH?=
 =?us-ascii?Q?od3bGaoPg3YokfLT+Ef4dtHtOVXRSru4Tv4SirzsNj6P5XPu1pIK6NAjVHqH?=
 =?us-ascii?Q?KkMuoxTqBKtK0svwplRj43hmE0IeNVgo6a4iJeX1Lq4o/dkBj4f5LMtz0p9i?=
 =?us-ascii?Q?2diA2WxDcvJAOPqxvhn5eo3x0GPizq9gMPBJxKn6AxUEhV/xZSIzRNsttYEG?=
 =?us-ascii?Q?xfiOiOFnfdEvL4IfBHrOAuk1CqPv0tZZuPYMQT4nzle3Sj+4zctNlBKMV87h?=
 =?us-ascii?Q?FwkZseQEGIE3uW8D9/zE0SiNqgNzfN8k6N5P26CpoEg3NaynhEgqnWk1cnlt?=
 =?us-ascii?Q?LTmOOIWqfHi8q/gLQrCewskWaoRJm8s/5IgmCuIJaaz1EWvOywjlCy9gkQIP?=
 =?us-ascii?Q?dDdgRI28uMHSfqmtE1XZA937J+l5aKONRO6LNilD/lN3tw+Vp2jZrnoshFAC?=
 =?us-ascii?Q?oLcMvP9NeWMa5x4gxmfU1ng97Wb5Kgs7CJjH+uvhN8TEQ+P+Ob16wvK+dyfs?=
 =?us-ascii?Q?AwCIhp5Ee+hzz8zPIeukYXTpp9Qyr2bFtcTK5ZDRDQAKjHunyFt6XmEl02Qd?=
 =?us-ascii?Q?w4XfHShehqvdReJ4qneQqntm0MaqFbs2eFztTBpyXS4oV+Auwxty+N1oQMPd?=
 =?us-ascii?Q?gKmVXNL4k1eml+pG0t902KpZcq7uhK3nTtfmw/s/PeaDhopBXouYnsvVUhI4?=
 =?us-ascii?Q?Pg2Qmsw8i4iRd+JCxQao3wn1OE7s+L+fJVXSyKOwfbm+UjPx9QPkRI6t2PMW?=
 =?us-ascii?Q?ncD2OgWi/WcIlGlIGpEOz0XiwkuXcqohlPIHR7/TMA2twIHd4bmkC0jdgvtw?=
 =?us-ascii?Q?gIFQARsjZh8djT7zkGLxr8LA2ITRQ4mzkIW395xgJ1xj6t6AmS+ON+3uymmL?=
 =?us-ascii?Q?RXjDUbp91eEqIin6Qg2Vxw2V8kRtEqJuDeS1Nbx/26Jrr/r9uuoPD9UYUcD5?=
 =?us-ascii?Q?0oH/gm+G6JNeGUspdlN1Qdd3NUjgM8Cw46U/Ce7JlSTlluVUK+SIaC0vQzpL?=
 =?us-ascii?Q?lTN/RbmFfZ4Ah9jq0kzuh5MdggzQdxKrnlA2NloltYESrlFgxnXlRZEtbpR5?=
 =?us-ascii?Q?vEPLYK2tKrqLCMAEKn+BgpDB42swsk2LyCPP1VjYi47T/WNQ2SzpK39Xu9oQ?=
 =?us-ascii?Q?blxXWK9e0XxnrGOOw80kROh1IZctl+TFBrdvO4s4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67d019a-e99c-4849-904b-08de21092599
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:00:30.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Z5aqDdJf6GEHDXH/KLO7LBqijWSqVjvhsVxzILeZjI4FsdTHeg30reeNjIUyQubIwbDBM5rLxtcVVMjHf6MiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7545

This patch set removes some unnecessary or invalid code from the FEC
driver. See each patch for details.

Wei Fang (5):
  net: fec: remove useless conditional preprocessor directives
  net: fec: simplify the conditional preprocessor directives
  net: fec: remove struct fec_enet_priv_txrx_info
  net: fec: remove rx_align from fec_enet_private
  net: fec: remove duplicate macros of the BD status

 drivers/net/ethernet/freescale/fec.h      | 30 +-----------
 drivers/net/ethernet/freescale/fec_main.c | 58 +++++++----------------
 2 files changed, 19 insertions(+), 69 deletions(-)

-- 
2.34.1


