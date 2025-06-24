Return-Path: <netdev+bounces-200569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE94AE61DD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83075189BA30
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5F3283C9D;
	Tue, 24 Jun 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QYy5qQa7"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A0280318;
	Tue, 24 Jun 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760011; cv=fail; b=b777ojNiPyLk+9/QDQF+6+t51CLyEUMY2e5F57u/tq8qonnfs0jyPQ9kagyOoaE+REs/hUnrdeP7u440H7TCmtjC+EkoP4AgwE/hYP+c/xlOEdZQnE+U6P0imSkY6MyMLVWKCbFW9HT98OUaj+GnGjZudup8OGIf/8qExhio3b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760011; c=relaxed/simple;
	bh=OLaWNEF8aHYU8Y/vsqsq0wZ8g5uImD65iR2axgNxypM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rtnX2nFRcIGjSmyJDoXisL+GYybDf9oZ45KkLqjr3hyCiRjb/J4PNZxQxKVDGqnUYQ14rvYfEzpMLvVpJzty+PrcxbzmXiaaNxbLzxcYQIa86SR6bhklaI0IFOwpLTUDF5HY9EX4bbjOB+nLBGGc97+QIhkq6wM+V2vsZ1i8/QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QYy5qQa7; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo9YC0sqN7NlqyjfvdrKG9t/umGGFHxybW2Jvniy74WKf2nghM4pHU9ORITWjXVP5PYYLV6DXYTTJKpW9nWGRswhGsRH/lRrkIn/xuLUd/ZvEAivrC8fuy1KGvFgWOCVFv7KOBpssfqrxLMp3qdH+uQr+NRGdIBhqPy5vNubrqnLVCIzAvTHBXz+LdgU3dxCnav+ZrcszXjTJrpSl5GxulTnsGZlDWkx+u3hoe+/Mckp/AAYCfuG97rRXnHZsI6gEKqRCI3+zHv0nFiiU/MOeHiis9mrz7dMRki8ZAcmHpCM5Guj1G6ymplN6NpFeVDqmJ6o13DSuiiTcZ4w7diwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNpZh/TqCUvihnWB8zQ7g6ptHgFiCP21Z8Pv2hLiv2s=;
 b=gpFjAtWYb82hc7e3xG0fScTGRJOzo1KJFEiqK4s0KFmO5D8Gt3qpMwldyIzjBJIkoiedjZ5j8O/76SdBSwEZZM1VX6iRVhm2dJr5fiP13ppqNPt11HpePVAAiTLpeVGgfm78oyZJcYwjsCEgQNd8wQdaYsXY51CBKGX5fUEl5zmHTvtHxN750MgzhhkogRA+BjsZ9tHKjRxAKHQA6lafKYA+konzxyq16HC237C6KPScqpOpOnlHiRJ8UIJ2aOkHtmSwq40Xxiy4hfUcjPRwtzr17T1ghsmy327XZwOtWmFcUng9Y4t4q6tZGITdbYTNP+5yiTb6LS3pWSeS2YyYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNpZh/TqCUvihnWB8zQ7g6ptHgFiCP21Z8Pv2hLiv2s=;
 b=QYy5qQa7hD3xgMYUOn5QK7kuxZum1/60CnWXbhxO03KjAPWVdyYGJ6Ip7S6klMsZDrntBzHPv+uRzoYP/FPtZe41jMNaO0xUh0HGNwWz4zDuJf4iuGy+k5oJT+dcyEmJPCmk2EqUBd7dEVcY2pyJuwn/pfED9S4gPzvmwP4/o5iiAWDbZHu6bgoNJJ3CN/WHQ+NT+GEijqFzdvbwnnEB1m6Je20aW3iuOKyV4y7IRemSYtZ/YVVXmq8wlD5wgrLkZCWBOPEDqNAI4X4DIkQADweb8Tavj5z8+4qWPl3q8DJEPt0aHHstnaqZpZvehPPNE/9ENNarqJIOB/cdTVUDAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8636.eurprd04.prod.outlook.com (2603:10a6:20b:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:13:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 10:13:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 1/3] net: enetc: change the statistics of ring to unsigned long type
Date: Tue, 24 Jun 2025 18:15:46 +0800
Message-Id: <20250624101548.2669522-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624101548.2669522-1-wei.fang@nxp.com>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d18308-f1fd-46ac-cafe-08ddb307c337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CORW6KITZikh+PZQR7Ukx0VoLYZMccv/9FXhz3ouf2gMakynBPz0Ccl53rhQ?=
 =?us-ascii?Q?YMtiTUn9QcYkxg6QBD2scESwsmLRA51EuuJ/E2kOY3pwRpIt/XiIjnATkxxC?=
 =?us-ascii?Q?8gOAEVVRada+DPfFN+SKLxcPsDb+JmXLV+N5ZaDo11GCpCucYJ9VNVWXY03W?=
 =?us-ascii?Q?xhBLwx4J7OF7WNUyOj2uN2XEypj7s6aktw16LbOMYQZWCMn+QsJH61xujMWM?=
 =?us-ascii?Q?E8ahR7/5HWqA3mc2nOWhWbDEJRm+4YL9DZ3ZsDk9QHbqoCIimmEWlS21oxPJ?=
 =?us-ascii?Q?D0/wNEmb2p/IoXkt3X7VvWDpbfPHeKiQp2HeCa+vlF9jeA/3i6oNb0n5dpkd?=
 =?us-ascii?Q?VGBlMV6jE/Yq5lFe4Bc8gCUn5gOOieYWwK9Oys2D/Q742JUw/Hy4xeA8zFWS?=
 =?us-ascii?Q?bIvloYqqZTV6/JNadTvdZheYePX0tAITPLhaWsUSlAZxxcsDF0G36tylrWKC?=
 =?us-ascii?Q?rUQk2/8C+qiV7+lKGgrkUCEvlhqiUMvxvWmyoEuWIumf5AyPqYyhdDU2zg2j?=
 =?us-ascii?Q?I4yBzUStWGqn7CzOMptGljuhj4BYRDffLQW3TQ+vMLrfcWMle+jCpaPjSHDL?=
 =?us-ascii?Q?fXbtnbD6qcR/xoZbpdHc1q1vLAnlwQOoVsJR5wODkEuVGFxe4YUBwICo04dy?=
 =?us-ascii?Q?DEOIQTqsgE1lXz+IbMkKWU2QDa/ivwVBIF6rsx7TrSTIYZbNf1pZhmLdAjqc?=
 =?us-ascii?Q?/woko7LiivRwKzNxzw8Wp1C5hK3wX35DsdGbWgKDJsfrRdOsKC2zudZOHwSf?=
 =?us-ascii?Q?vAXEms96VPHB6Q8xJeqGvVslELiwUvq4pXrZi/Pkec4TKJTkg0M9eLUEpOwh?=
 =?us-ascii?Q?S7n5svDHgHxnLVCuR/j04Nqi87cJ8W/mMQdV/Z2yfyoz2xy8NcjvGNhhSCef?=
 =?us-ascii?Q?0T9WFRSd6jUYiIMHIdwi9Y6VNUa0cJh9/1PnKxMtg8lISSAEHyTAEiNnJzsy?=
 =?us-ascii?Q?w4RxO4OFM3nZGJswP9RbVoiLGnwxSDABCM7kEPJTwbSkray3WKQXyQQPOAzF?=
 =?us-ascii?Q?LaQnmOh1oGKC7hwJqPDBpnwxWGBxjV9xMXv4d+HI/8dX3mXPcOWNzi7IzfdG?=
 =?us-ascii?Q?pFKiAw1s/TnNS66U7o/t3eLmFSmPgyAA5Dq4isHFAzqqEM3VerkrKdzs82SO?=
 =?us-ascii?Q?ZoyyB06ShBLOdIQITWxJ5obh2GrhB1rUZBXKWy0mSdXsHXdvLjcDpD1Sor3A?=
 =?us-ascii?Q?RNOgJhvzkGsp3lFa3YrT6xFjlWrrQpyM96YBvgthQXVXtFNWRJhTlvl4WFOK?=
 =?us-ascii?Q?HzEE6YUu0hf424KAmSGEPRd2vLUt12A+6h41Efx3WIfDrQX2bMDMb1Ytsl4c?=
 =?us-ascii?Q?zON7FTK+oN1KnV/1xa/8iRsJ+vcEcNpCziytx0ytnRuu9fNz8c3ua/cXZ61U?=
 =?us-ascii?Q?uwGAmR8g6AKa0+XBZ5X+ANY0yt+DObMiYlBvo8bbv7ZElbPAyeZfRlYAsX5E?=
 =?us-ascii?Q?XT8pSPqFsAxUkFODV8gzVAOvCP5MDudoIJf0pnNPVXAkfMQ24G4qqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgHnwFHBai4mPtiLPYaJqQTHjN9f49TO7lNC9I7K7dEERa7bteyhvYR4T1S4?=
 =?us-ascii?Q?QainZxswbZdSAv9nirwXY3UQ09/dX3I73hbJ0bMTa7gYqsB4bEWNyK7YWcea?=
 =?us-ascii?Q?XRvOZGbbi8uQBeMO1rErJdldtQOj60Di57hYkpBgrredkSRZ8dkjtlQXDdyc?=
 =?us-ascii?Q?DGUKyrW3WXvL+yhdXmKgp8IWIt3GEFqO623p5B/pAk/UOvutaLTE17Yrvrh5?=
 =?us-ascii?Q?uXajEMqRrrrymQVURDBBGnVs+2vqReTWIQG80Re/yPkyL4K6I0tGUTty+vUK?=
 =?us-ascii?Q?kB6nFOcFT4NY7pBySKz+wWIyETD+emrJjtPTFzFfkw75x2v0XCocRjrTZrxW?=
 =?us-ascii?Q?b4O+3alTgRIod2y1EbKAK2H9qIlGLkUj8Th2Gx8xaxrtdwkkLM/V2oU6nKvY?=
 =?us-ascii?Q?Q4y7d1zdlPso5Uigfu+8HrGYt52Nwfz9rKjPhG7NnNw2LYgXMAS9hE1DcqHJ?=
 =?us-ascii?Q?/mpdJL5HyZYVZI15Y7IUZwzBsvJibP9CZ8CD971qZXK5jsVGy5Rq2ObQ04OM?=
 =?us-ascii?Q?NQxxK9Ts9DMksl7ja1ZV77j/e74X+de/s00jHyE9DHTHT3LNMattPOowwJFr?=
 =?us-ascii?Q?4eVpi6fu1VX7B4e4aFYMSFpumOGyYK69htsQxKGgz6PomLL11Ofz2Nc6z18y?=
 =?us-ascii?Q?28EzgEfmXI00xzZ7ZKosccaqkgSOkMqH88NDI3RU2fCqrKDTykMaLI0uLaSW?=
 =?us-ascii?Q?af4XDnXDDz5W3EQpE8/2ic5lXwEa9d2K2YfFpFnyz8SrT4E2sjSbqMMxrf4k?=
 =?us-ascii?Q?UseGk1VGjxF6bDZs+x1CzKvI9L5wMRG+UUv+Wky5A2UkNxAYmJAcMYztyjWB?=
 =?us-ascii?Q?oFt3mw7EFLdvs0STCN6qmVAf0gNV8wV8ynlE4Wwl4YwNyz06ITV1nZFNbFx/?=
 =?us-ascii?Q?i0VM+Ism8o85sU/a+pv3/JdY80k3+uvM8qEb3VJJeABwK5WS5hTZ6gAksDnH?=
 =?us-ascii?Q?mKq8i1t5wuleu+29xlqGTphe85OtzcNs3b22C7eJ/b2rVrKNoNpf/hQCq9O0?=
 =?us-ascii?Q?JISpPFa25vZVUkOPhPjMr18xEXvhOE8qi7j63h761CT7KjQsnVHb49sdVVMB?=
 =?us-ascii?Q?KkdArEJv9/OCeD21gXTX/GeVQ1Vd4MsLC6bKz5urbxhMMNUMUqYt2dHLrDEf?=
 =?us-ascii?Q?98Eh82nqeCOGO981cTYgB5N/XoFmFkpOaWLaQEOPphFxXgPbuYkou6/VwlZN?=
 =?us-ascii?Q?Zdwx0uA9FAXvI+SghtYezhqq8/wguS7uizD4KtHwU1a4B29V5PakT91FAv44?=
 =?us-ascii?Q?5PDFPY9C871wyjO/rzbrfMJjg/R9GRMK4m55BBJVt1AmfaNhQiTEI53g0IqS?=
 =?us-ascii?Q?3BDMthuFJBhTshOFgxsWMCm8qjnHY9SSAw0QYZklyu1S7sLWVfcXP2gx9NVj?=
 =?us-ascii?Q?wHkfD3DVUx7+PyxR2Sr6nkseyk6sfk2MEmc73A2LvCSrqnJBER3VC778zrXI?=
 =?us-ascii?Q?6rp9yata3Cjf5WTnZ5WHYFyV7y9CAoE53mKW46VtS/dyFaJqJHWjwZ7h96tc?=
 =?us-ascii?Q?Q1QGRgQqGyocPBFcMtFkAvDU4FUZGmuNDs6uTjjtvF4RdW2Qru4hZreGKRUO?=
 =?us-ascii?Q?6v8J8rmqOo0IXqyS9IVOcTJkUI3bKxXD3H3qCt+u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d18308-f1fd-46ac-cafe-08ddb307c337
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:13:28.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAL3G4umseat/ylUKEP9AByIXusarQc8uA1vgQ313dvolmr51ufB6YX1aX6v0KEV3q8FDMtX7MNZ3dQLrZXuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8636

The statistics of the ring are all unsigned int type, so the statistics
will overflow quickly under heavy traffic. In addition, the statistics
of struct net_device_stats are obtained from struct enetc_ring_stats,
but the statistics of net_device_stats are unsigned long type. So it is
better to keep the statistics types consistent in these two structures.
Considering these two factors, and the fact that both LS1028A and i.MX95
are arm64 architecture, the statistics of enetc_ring_stats are changed
to unsigned long type. Note that unsigned int and unsigned long are the
same thing on some systems, and on such systems there is no overflow
advantage of one over the other.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 872d2cbd088b..62e8ee4d2f04 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -96,17 +96,17 @@ struct enetc_rx_swbd {
 #define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
 
 struct enetc_ring_stats {
-	unsigned int packets;
-	unsigned int bytes;
-	unsigned int rx_alloc_errs;
-	unsigned int xdp_drops;
-	unsigned int xdp_tx;
-	unsigned int xdp_tx_drops;
-	unsigned int xdp_redirect;
-	unsigned int xdp_redirect_failures;
-	unsigned int recycles;
-	unsigned int recycle_failures;
-	unsigned int win_drop;
+	unsigned long packets;
+	unsigned long bytes;
+	unsigned long rx_alloc_errs;
+	unsigned long xdp_drops;
+	unsigned long xdp_tx;
+	unsigned long xdp_tx_drops;
+	unsigned long xdp_redirect;
+	unsigned long xdp_redirect_failures;
+	unsigned long recycles;
+	unsigned long recycle_failures;
+	unsigned long win_drop;
 };
 
 struct enetc_xdp_data {
-- 
2.34.1


