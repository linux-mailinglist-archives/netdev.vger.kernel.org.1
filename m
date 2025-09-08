Return-Path: <netdev+bounces-220874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F5EB49507
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2A43A74E5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43056310627;
	Mon,  8 Sep 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nSZooDZQ"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576483101BA;
	Mon,  8 Sep 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348337; cv=fail; b=sv89bu/W+/2p+lx2PgiZkLXUiJ51t/Sjfq2vAnsxGqkUAAA+acc4cZvi3Zn3wYo4kfLd8sTT0ztY5z5fRu9vMZAKLiEDxQgW5pizDfJHXAghIM+ExQUKP6YgruXcKh0kogpRf3LFVQo+NyKpq7b77TRieqegfkYbFjHlpvHsk/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348337; c=relaxed/simple;
	bh=d98D7HDoJqiSyPbuEn1xJ1fYQo9FY2D+YE7v7HPEeOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTT3cixiIeoSFDe/CK7qp2cGiFi5NIVx4QKRl5UmYyh42yy1A1+k1/X74RN83j9R9Zvdf5CCGvNmouchCIa3arXfwSexClL6GH0wUrqIsf67HtDblGqaqVoeFrOFPBrOLkikh/wubF9lRN848AUwlMmJ9SACLTLCLRPl2S2Oi5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nSZooDZQ; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi3MnyZEoUl7jq+6zMsMCR3DXxViCmUhQgJU1M+NHSanehyAWBIcr3Ke0WORrehA58VzxxJUH3GWH+HB6DcNXLTRfZtrdxZAPJBYuBXiw/xSWXSKvIuf+nO3kaG/XYqplJXXQ9alTtlu9ds+lKU/k0WvdMOmaRfk5OEpQmzMb2OLdSEdhDdCj4RqjDs+4iU+Pus8n6SZsokJ6Syv71ttMylUVMHAkWWLlfBKlKqdB2/Z2v0CiufS2/AAtTzSdDZLQJqHmwcObalO5mXDf/7t0oAF6u4KhZ9sIn6nFSYi3sA/s8p771c7SmcNG848yXo65dp4nCNYje4RTfTb2k4luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOLXlwptZlRImTydzToI6aUfYYFXsz4zaP+3sepq+Fk=;
 b=PDlZIbhWixcbJzEdKxcxVuNGxKiD9oN45sxDbur0ZKX1mpNlvtCboTcLXZ/kxO3day+U4eimkhzshSuqOBDn+zV7owaUyqq1TkPO5wHJa/HoBwnGCsZSg7YKce0YJSTFY9KUWLd/Ylv5yiD8dQ2Bde96AFHW/z3uT39YKpm1BnyogTZYKYrLssQKgp64NSu75DAca8UjTBETnuYBFUBYfcpuAvlV1Npe0XXkxmbfnQ0nycMXw8Kf/7s5VFRGr+jO7nHhU5eK7+R4NNq1x+brdydC+mtreSTQXfke40n4MFJWJCR/zUS8Uzsezqt7wmWIO7VOhKmDXRA0b+8bbv1bRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOLXlwptZlRImTydzToI6aUfYYFXsz4zaP+3sepq+Fk=;
 b=nSZooDZQlVz1Fo1gkGPNKCBMDhE1Vp6si32kpyOQaFxZFdy0h5SU0noVO+N0pZOCa/mA4AuTlz2EToH5K3Vw1dN9mYBHNxpCIkO2mRYyk5LFoLUFF2UmxqolxNU4cLNftaDvqUtsip6PAwt3KC7UBnZwD9p4W/bHrMeCXCw3iYntrElH1XlHQ7xGo253ad9AYq/t/xfn6JCP5kIKjN0pvy4+mm2p+szUFv+HwBAuEjwJ1dO5/pvIPrfiDwWHdwQ98p41KOM0mhNDci0To1unGU8r4lXkxbCGcSqcAcNpofgysVG0gcTFxpdjCz608X/7NNwtaxSuCDTD0M+3ifaJ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 16:18:53 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:18:53 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v6 net-next 4/6] net: fec: add rx_frame_size to support configurable RX length
Date: Mon,  8 Sep 2025 11:17:53 -0500
Message-ID: <20250908161755.608704-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908161755.608704-1-shenwei.wang@nxp.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU2PR04MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 350f7794-bb53-4637-a520-08ddeef3671d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9R9awaT9SQXM4pCAHoVVs1O0K7WsbYdBlG+QHhEEUMIRjDyEu8MrTJ3dak9X?=
 =?us-ascii?Q?jAzq9kZdt7obbmU7TShor6rViTg0UXdqaM12H7M7CDwP6rzpgpcixMS2LtnN?=
 =?us-ascii?Q?Z2DAjJ8emq05vhrdnw4d1duoD+oWMN0UkFgz//5Ncr69R2KmkXpyWu0Bmp/K?=
 =?us-ascii?Q?W8gJcziQ5Lr6jGOM63Y9HoAEGRV5STPk4YGuXw+tyB+ZyMjaSJ5UTyp4vNdU?=
 =?us-ascii?Q?C8vzpJBaPQspUbzXGOeXMQ3O9Xj5mnrpiAU+Y3nsmg2Ncz6DdEdISIqy+vfL?=
 =?us-ascii?Q?3Dd16spRBnQedwsutIn26gcnM4pIENL6wsuIKOet7zHZKlf6SXH+ZrVNnIP+?=
 =?us-ascii?Q?21EDp+k8+GzHjok6Sx3e179+P8KfOle0llzTlleDWaZehtp/HZjft1Bwl+dB?=
 =?us-ascii?Q?HFCQ+cRvmrZIbu6KymFVdYPiaLb5dzqC/AZsw296EklFWZPFdrNfTK+vXgPm?=
 =?us-ascii?Q?h9zeNPxxJG9+ZTTb3ZPPRPMYPVK1ylnF50rHGRbraslMeJIOsRIr1Ghon/uF?=
 =?us-ascii?Q?f/DA8Mm7ClEAWfVCd5TXGIsqLFVWeanwAJzAJ8ROJ9DYcLARJm+qtR69jpMJ?=
 =?us-ascii?Q?Aat1i+ZMkihGRwjgmwQ+1YpIysQQ8A/QGeQ2YQH0rT01jiI5hHam81zmSAnm?=
 =?us-ascii?Q?gz9kteKKUoyt1aHi6o1VRQNkT1Mh0kN/Jsrv0R/IUTXYh8fXgJAYcE7nX5fj?=
 =?us-ascii?Q?Giniyappf1MbjkbLbGhJqYZNS/tPBMyOLpzpvhBojrSbn6LV/G9equPACMTg?=
 =?us-ascii?Q?RpOGr8GrQjhjiiGAnPx/w2TZ80HhAa8/oYz6m3BmyqVqfkhaiuHYTNHEnEdL?=
 =?us-ascii?Q?pviXH+C/yrYuXpq+3CXOaUwQBVhUagwlrnv3W8fWx+Os4CZfPbJa519FqB/+?=
 =?us-ascii?Q?Qq1h8AiT0K5MMBrLk9HFo+Vn9sQ0PgfwXVhfMKI6K69+wWjgzf8Wl9ctNAlm?=
 =?us-ascii?Q?e3Jx+tmnERUGPzR6+Ftxrhu/yfQP4obp0FpJ1ug3Kwa3Y6nEju4fyjU9MvA2?=
 =?us-ascii?Q?wtd/lAB51Wk3y0anjzQ3RSeLY4egdhu5bw1qGfyETrKIEdz7U7vFStq+fpPM?=
 =?us-ascii?Q?qiU4EleZ78cfmKf94p8XK1oiz3J6yzvxg85VbktfIPmGSKN3jM18P1WL7AL1?=
 =?us-ascii?Q?65+6DUJJjchWcq05LiFc7GNZoV0xDIrHV2vyJ45VA8R2uXUkhftUWqYN3qaQ?=
 =?us-ascii?Q?TxsPDEBCOoktKsqm9JN/3ed2bRCWC+3JDTMLMn3TIkr848d5P0rDrwJ2gwx8?=
 =?us-ascii?Q?5lVUBw3R+4iCTzIcR2vzJitRaNw13gfSDzPKFL/bVJCAcVpc+xyndrgxrETb?=
 =?us-ascii?Q?C7Etdc2Z1PvnwDhyMf9iUP8iRFTdvuLYV+akLCQC7uySxfragL1Uy56F1oNv?=
 =?us-ascii?Q?xsk7Te4Z2nh+4aT8Y1P16iHxzL93MhwLzGPHNvTaFXrfif8ReTeJN5UqB8Yg?=
 =?us-ascii?Q?zPRpGO/ZPt09BUqhk0VwUxlCvdOEcUbPmaudoz7WDKBA/0MKbBYRcglZRo49?=
 =?us-ascii?Q?4G1fRBTJc1/3yms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3EXNhQBWsRBbifW6qt0L4Mftrd87cxWRdOHaBB8vLRcqKl/beFeCfkbZhaO?=
 =?us-ascii?Q?VYt/fR3CFOJHTebfv7qLYsA1BnfiiVKpnDZBjoKey8l7t0ce1Pw5Qwx5pRKR?=
 =?us-ascii?Q?63rDvbkp1vbZZQFz/IsYRkD/pvYqDZ5OXmfvwuw0pXtVY9NZMzEbjYpcH0WB?=
 =?us-ascii?Q?pqMS01GFFLFPvnhBRpIgfY4R2YVfJCmia3MBwIP4jqW8TgclB8R2qnJr1Ylp?=
 =?us-ascii?Q?JRSYOztSsPmTNVN5cR0EgFPlBcSztby4hfstytHRvUrPhUInZTu2aAy/bvR6?=
 =?us-ascii?Q?xPF43pYOsPA96dIxHTRSMHUuvQ+N3AwccI1rNhExEJKe5PdjaadVqBsVCqaI?=
 =?us-ascii?Q?fMMgzA82oKoQhYJoSleo+aEuCLa5xAynFX2Q8hNbVnCTnpMTap/0m52+V3f1?=
 =?us-ascii?Q?UK3qqnfi77yc2V+cmDMaCkCWrRKkLeEYQNHPMJSkq+8o0VcnhEMqZ8Vr7Xlj?=
 =?us-ascii?Q?3gcXrNC3hg1XxNzbmbSd3aJi2f9jmnkdHNQORamdiZuBYeKSzMNp/wBTYhlH?=
 =?us-ascii?Q?6/Tf9C+hlIczra+6QQ2v3VxTJNgnHpM21zUEKo8k6R5MCXeGtrcqsf/AvQCz?=
 =?us-ascii?Q?iEzTZUTWs7yugch54HUqoU4BP816A9678Hg5cySWJYLCby20az9f6lU/G1Og?=
 =?us-ascii?Q?+dhBoOALYYV9d8zfy6GQNnpdj3aXRgTI9hiliaGXs+bFGs0DHVf/hQMqRox0?=
 =?us-ascii?Q?fyTJofbH699H8tHXAJU1CpOVb7UbFTvLPcxEkOJSWljlbvP3usnvLxHtltdI?=
 =?us-ascii?Q?hqsx6Rn0vPmYjQEP8YguclWPCL7qbW9yklnH9LYeEFbpIdYlqpLQnPXiInAj?=
 =?us-ascii?Q?puOvCPef0KHqLXCKBwpN3/wlC2O8qsjS/rq+I58KPIvQMzUctzuWJzyB+soP?=
 =?us-ascii?Q?wqCnoR7WKgIOa/uKzEsbopqXP3p9SRE6DnLaR/bzspeOgYn9QwAljaRJIyq8?=
 =?us-ascii?Q?x/SlGwheriE05fBuP7Fs1pjTSG3R/nxMD2e8O4NB2z6mWakzC0ek6ntVBQqr?=
 =?us-ascii?Q?XRkCm0/0lT4QDSyHMms7LMTAcGBqsixvscazowovRv+ikeBefRa2zXFc7utZ?=
 =?us-ascii?Q?8FUW+B+aWRMbfedVcEywLZHL/Q4lj4/NlE2MSdcF7ay6QC7M8lvQ6T4+I3vC?=
 =?us-ascii?Q?viPXivQ34b9zyBNluNjYQhbd1liwlkdAxi9VH0WRanOJ/9ZiSg5YJSw8PDNj?=
 =?us-ascii?Q?xNesezD/QVyj0tBsQNmIQbGBT3toFMZqdbzIkM1UNe5/fEG/1ixPyg+8Uyzz?=
 =?us-ascii?Q?ekPk3H7q3SrksQNwM10LNScnGwyhr6LRmd/4AZawGRf7YsrWbY3sHgRdShPx?=
 =?us-ascii?Q?ca1JQmNCITO9bIsKx9XpgA2fHW+fmPI0G1DaDRDVA3eZx86MFt28mrOiOLUG?=
 =?us-ascii?Q?UD7vK05kVQcR+3B7CfEqGUsQscw/beCO/aUOIRRCIn+RSawGjGsb6fweEhBY?=
 =?us-ascii?Q?3wwl9u6me5XtxvAXmcRZgAhpC4idCK2qIxzdtUudTcvKhgsCfPeK8zRfMXTm?=
 =?us-ascii?Q?MQekCxzxBQNz5Bx70qngIx5Z1W4dazl1ncG/ibRfIXzDVkkfOPkWAu2pqL2k?=
 =?us-ascii?Q?7C8UXM+2Dwmq1BcrzceGqSnu8bYAHNWXUtEj0m7a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350f7794-bb53-4637-a520-08ddeef3671d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:18:53.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lukB8wzCGzgxQZ9LOUkxf2I90o24tJ0uNTmMd1T8GN4bVxWJkAjbfIzTjCkmZmtCx4pqD+K40LpuqJDubPEkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501

Add a new rx_frame_size member in the fec_enet_private structure to
track the RX buffer size. On the Jumbo frame enabled system, the value
will be recalculated whenever the MTU is updated, allowing the driver
to allocate RX buffer efficiently.

Configure the TRUNC_FL (Frame Truncation Length) based on the smaller
value between max_buf_size and the rx_frame_size to maintain consistent
RX error behavior, regardless of whether Jumbo frames are enabled.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 47317346b2f3..f1032a11aa76 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -621,6 +621,7 @@ struct fec_enet_private {
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
 	unsigned int pagepool_order;
+	unsigned int rx_frame_size;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5b71c4cf86bc..df8b69af5296 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1192,7 +1192,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
+		writel(min(fep->rx_frame_size, fep->max_buf_size), fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4562,6 +4562,7 @@ fec_probe(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
 	fep->pagepool_order = 0;
+	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


