Return-Path: <netdev+bounces-218577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94793B3D53C
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 23:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAE07A9F33
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 21:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C53C273D92;
	Sun, 31 Aug 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RlptLZzr"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFE2737E1;
	Sun, 31 Aug 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756675003; cv=fail; b=QupqKbT2KxNehD8ysCzQ6w2dGhPN3pehAWFGcEk1/ec38dkvTWXsboxlLfDWgO5dxjKqaXqO4KuR68/CNOH4d8z5rpYEehYk6PEUXp3RPEwbfb5aWv83MM1kAsJw74AJVghprk5TaqNihUrCj+cj+UMZSc8GZDnumKMdO91kkHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756675003; c=relaxed/simple;
	bh=tA0zzrO+ELa+PMMlwICt29AqofS5ReJuWzTDAz5ZRqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAeDb1YiRsq0K61NVUsw0CHj6Z1+Ya61Jk1AH3OT8WDa8N6IzyGv8J+BVh1mPPgIImZYkrx/1nuooAibz41tORNhhR1+6pPqdXug2MNgYPNIv+u+mEqyhPvKyyMcR0ESAAagV7XmXuhHGphJF/Qv8fforRo87lC0rRLnCrJxzPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RlptLZzr; arc=fail smtp.client-ip=40.107.130.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0Uekykfxc4oEVYZXzKADP4G+NuVru8E65ku77DWVaeXzAS9W+ofWPk+ThVTV2aZXGV7M2NvuAErmWGME9x92HHdaKauxB5La0IcCUZWLB9aghWakN52Noyl2vg+VwoVVi7VFL/9qFIzLoU1JLKRsQHiX+Nb21Fo/bdgh/Q/fMFtvhqSlOe6NIwF07zas8NDqkYHyPM7FBASV0JnHWrJOS1VUXZdzXO4OYEFE2w8zH1C7Dyd2Omahdy1s5YjvxA/C+OXlPalBXZ2nJB7VHsTaWZfkVA8mAH0brrMbUAS5DKcdhMOQEuQC2Lm67aZi6r+zFMt9Pt3PmI9ugyR+Hf8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NrKOz0zLXTaILrsCQFv6thc73C7pbL2G1aMvA9naMk=;
 b=eEpLqp2TwdQ34Zx4pufh4PTf7TcbVmGKA1CTOXw0krUwx1U2cAWCdjoyOwvz774qCXGm/fB15ARCx9FdEi9Orld2apzeUbrKwx1GZv1B9GRcZEa1KLXOzFIXvpZh/Zfhi+LEZNCBTAljuRv3qbyBDyQ+vLf8l++WBsMCofphrWo4rdIQxDFr/tB7x7hK60d6T0EO5aTDS8Lilk06NyPUv8tiLqGtOxGMXoi41avTTnrNxiRJ9cfWQT25FPUsUbq1DsYsRBm7Qap+dLoAJV+sT1QtgRjSB8MB/kIny8tysRkveNWeii4IxKjUeaK7RMpv10mNdsZfCuE8LLMLhC04/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NrKOz0zLXTaILrsCQFv6thc73C7pbL2G1aMvA9naMk=;
 b=RlptLZzrDhyD0mwRiOepc2juR9j+RNMFwxRHsgPGQSm93WjGqGvl6RI5jYV3PG/qAnaXAqyaXHPxeONroPrwSBTwuYFHV96saYf3M8Bfluj9EGCtUlr3lpKisLHcpmnqsxRQubzXp/eqbS4W7YgW4hCYfGffxUFZPq3yxABTZHNxLM8jbcWcpOhojnQdm28+ZsnkrVOtkGrJo71v2ys30PIZH0NwmlZsOZe0q/O1H1CUABrHvi0U+8EXe0hn1yYNSWYDY+b+N9oBPWjrAF/LKPcsNbj92sXoJzMM5TfoU8znzo/On3/ZipvDQTkXSp2lB6nkrLSokEGUlOqoSFVCuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Sun, 31 Aug
 2025 21:16:38 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Sun, 31 Aug 2025
 21:16:38 +0000
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
Subject: [PATCH v4 net-next 3/5] net: fec: add rx_frame_size to support configurable RX length
Date: Sun, 31 Aug 2025 16:15:55 -0500
Message-ID: <20250831211557.190141-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831211557.190141-1-shenwei.wang@nxp.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 04750abc-0f62-424d-4b0d-08dde8d3ac74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56SQVR0EHCyh8T/D0sBzzeaUWfootyijM7zzNub7bgoqeaZJWxsCLvL+jKUy?=
 =?us-ascii?Q?SBGxAjTG5epWDc1GjFgV1CM9xUBkq63IYmL9QTXfjkSZzkDoCy2mwYAXBkCU?=
 =?us-ascii?Q?nZULI2RwDaIBioWQSF9ASM3OcGW6VHV1jd3iFNgTcEvWj1e3/bbDQ8xXt2x4?=
 =?us-ascii?Q?vmr40N4MKCk+e9wjt8sCFTx7cK4v+0UsO8wEpHXyKHVPdfCgoJdY6Eq2iBvy?=
 =?us-ascii?Q?hbcaSPVgTNgQ0k4Xn5bHZyyTZdt77GxIPu4bWsOFir70Qz8nz+jm34d2va28?=
 =?us-ascii?Q?ctE7TccSbj7L1ETgi/6BtgEmDUx3GxgESsgvSrAbme8U35ea06oAWb+AKGtW?=
 =?us-ascii?Q?pOtlZZpDYCbmyVOw8WqseZpPh5aOXb4j93qKaRowONtvWG2UDT0dP78rVagV?=
 =?us-ascii?Q?eqcJy7m74wr2mZVCplwhsM/1Vknbamf6OPSeaQN1Er+mmVlyt17JHaMqzvRZ?=
 =?us-ascii?Q?qwEkuRNMYzc0kZP4VYV8vcoLnxYNpT5pk6xc543mGH4UzxElJiXwjp48npzx?=
 =?us-ascii?Q?uBuZ3PmihA+YCAVTakCfEMFnFCE7b+uU1TFj9gooL4BqogX1izH1jfF4teVP?=
 =?us-ascii?Q?GqnDTXmzK6AmMnKRgp1XmVCK3pgaE3tPkrohI0Amemavq4nw/3XidN1EZG2F?=
 =?us-ascii?Q?ODVj9X6JKVtZvYoftdpmzFon79PQt1XrhxI5xfXN9QH1hBzLt5TzwZqNSkZ6?=
 =?us-ascii?Q?ES2ASVEpXoEf9KfkkXVnFozTU5ewdlHGvvMCm6g90U6R35VueejODeIFjgHy?=
 =?us-ascii?Q?5wj9ZC/si6O5XHj/YKXnrs9F0QXWEJSbNhAzDpqAbd9Lp2U8jhnDpGrWVj/q?=
 =?us-ascii?Q?b71rvfAs8DSJTEu46J7v2kAe30DELcSSwmLU0PKmFAmTHfM7Ihe0PajuKpwD?=
 =?us-ascii?Q?qqm+bVKD3rIga5wIzh/Lmw5JZNfqsvtPaDn6+1itCBcReHDuftVYu7QYe1Am?=
 =?us-ascii?Q?iOc5GIg79u3WlV/hTJ/UjX5FjN4L2JeakFxQhLTiyeIm4luzzu97E2vmf9QY?=
 =?us-ascii?Q?JTMb/PNtuEKcNlwc8ZqSzkQd9mY3JszG3rNlMUaxz7M65cFwRo9i1yk5ij3y?=
 =?us-ascii?Q?sSGMQPXhtS2P3DOZkvMrkj7RjIIK7YCgO6vfXwLm+c/aAs0gatpkGmouJKeu?=
 =?us-ascii?Q?I3mXNDqJZ7FuUe3j9TztpOBicBUjQ+lJj5X2Dvr+CcZasNaw4NUEgLwuqhsM?=
 =?us-ascii?Q?EOUT0w/8FMy9Ket3cNDarUrl9univ1gGnieahe+ZaM3pqmEPf/VllPnF3XwH?=
 =?us-ascii?Q?WAnp55vAsyeDiXDBJk3e/5x5+P39UpFRsZ7TNWzQZvEQ7Wd5kTF7Q10rJr7S?=
 =?us-ascii?Q?3TlM1N3TOTyYYcIejT4Yt40RmkcyteEv+MPoO6UqJLhlEcoEyue5Rn3fKzYW?=
 =?us-ascii?Q?tUs/4Dcu0hkCQnQHsQSuEdG5yWb+sKXQRtzrmlsRpdZMJ/43+6h0Ii3rI0cl?=
 =?us-ascii?Q?ruRc+wh+QYq6bgtxHJV9TBn5BV4KgXTd5QtEaznQ8YF4vsKKUc9Urjtw9aIn?=
 =?us-ascii?Q?EeNJgheW1X1HZDk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWaUbV57ONBhsUCyTgv8hyFvW4S823hqJ89w1ZB1AWDgb8iwE0x1sDx8bjSd?=
 =?us-ascii?Q?yX7w0IszTo5gcaEle5CpO4f+fBnF9bgCW9yfGNu+qDRYbRmN8YiGRdvamRSj?=
 =?us-ascii?Q?sokU2pSdkFWsvGmpKma35LgkZUoTRGfvcUy6z8ClZJCnw4HsM6TPZI+jY5I1?=
 =?us-ascii?Q?SDsm8MrFemHLyuuCar9gU2a6dg2mjILg2zj+P/Fl+78ecaG3vsz+inJ3pzLg?=
 =?us-ascii?Q?1AzVtY5ERAKcrSAjtMQ9gykkwjuLbUpgZk0/VRerl7ypmJ6OVzWVKjeLz/wB?=
 =?us-ascii?Q?5nC0BsVwc4QxTjLW0aeRTIhPNZsyO9as1/11B1voBr9ie4Kt/ROiKBp9GlwQ?=
 =?us-ascii?Q?YP3LfxIBooFsk6hNZ7ZTCUyFW4ZpaeQP8Uag7u2ZUl/XXUAMUYXoG+l2AKBv?=
 =?us-ascii?Q?8ey2PfO20xcFOWJuAFDWtXe5jG2qiOk/oPfVS54/tV2Hvnrvb8f5VwSZO8S4?=
 =?us-ascii?Q?T46IcliWk6PSd+qnA1HZbY2UPF73SM0z+wWaBClriitMKnMrvYXEw44E/ECB?=
 =?us-ascii?Q?8dWLZH7mxZgnR34/VU/PIMZdyBKC496B8TICc5CGnzJXryMiTAHBKPp0oEtv?=
 =?us-ascii?Q?A7kGClzgmhgqrzyvXRgXs3ov+tlOTXgIvHfnBptrox/uoX5rcjtr1dW3/jQ2?=
 =?us-ascii?Q?7jXprIm2Nt/Ef+jBvSQZfBuVtF7QRVyPu2Y0AlkeOwHTsxxwpLu2l4Ew+HSL?=
 =?us-ascii?Q?WqkgNt38PCqczgld+sTuPPDYvx7WNr5wjM4+10+k6SgMkBg/3WZcJhMpr+G+?=
 =?us-ascii?Q?e8O8KosbwKthxNggJFt01Nwn1KmGifUd+CKrlW26R1+wXL0ibr0lnSLRNtg+?=
 =?us-ascii?Q?pPfPoh7SBO0YD5ExdEKUQ2iTB7xKRQzd4AvdeSWsmIE7LctOhRT1BXVK8Eb7?=
 =?us-ascii?Q?JJP87kaKkbydiNnlCLvc9vx6DLeQpxGzeYLQVDqartczdlVf2treoguzrP43?=
 =?us-ascii?Q?8LLLjbZRbD+K1OMhbv9J5ILhRZG6FFmdEIN8l2F2H88ezP+WkBXYsYGpuyAo?=
 =?us-ascii?Q?arChh7mIsuMomazpAUwYYeiJUoz1euWCDinCYGh7ANxobFT5gtDzt9hJ+MxW?=
 =?us-ascii?Q?Cw7k2Fm4ZOIf4kftZH4Tbbqk/J0vwjgukpT6C03WvM0InrQb7wnu5jBFlnzE?=
 =?us-ascii?Q?suJ0e6bRNs754blD33SEzhHZS5xDw7HVHQnYeHdQK5ZoOyFvvuSXhwl0FAns?=
 =?us-ascii?Q?GSEK8E6DsRA8JOgQqWEFfEvBScuiH6uYIhH7YmHwjXkace6cjgVdI8hfiIZq?=
 =?us-ascii?Q?QVOgGWf4C4cJfAxUyrvyA/c7gBdRP7paXSvdDoyxVIillpgFuaRAjy3Xbr7F?=
 =?us-ascii?Q?zR+eXavoDqUh66J2wJTAfVdq4Jl3D6NLGFjoIKzqDBGRONiGXnI8sGA1ERiY?=
 =?us-ascii?Q?FTXy72zhgk0G33eYzj+W9cHWPn8JrR/XI7XTLiQ175vjJbf7JRaw+wNWgViU?=
 =?us-ascii?Q?jk85fbd1bOvOBJGh9eLKRAuY3B6ckJTqpCrEIsiQX/WiLQo+waofhC4xFUP9?=
 =?us-ascii?Q?fYNd71K64RicH7d1oMARINIL+isTZ/XI3CugVlWYBD4GZlwS3G5RFIRth1b5?=
 =?us-ascii?Q?jQ8Not2oJ0JwShxzh86VASzeA4c0KVLwH6K2sqyd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04750abc-0f62-424d-4b0d-08dde8d3ac74
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 21:16:38.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMzr5ibctX3e2PLJZXBkh9gCHp1AnagIqQ3jwkXHr6uGUgJxJqW5NV0MCZBeSz8tlWGHs4AaHu1g8gb0MHFG/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

Add a new rx_frame_size member in the fec_enet_private structure to
track the RX buffer size. On the Jumbo frame enabled system, the value
will be recalculated whenever the MTU is updated, allowing the driver
to allocate RX buffer efficiently.

Configure the MAX_FL (Maximum Frame Length) based on the current MTU,
by changing the OPT_FRAME_SIZE macro.

Configure the TRUNC_FL (Frame Truncation Length) based on the smaller
value between max_buf_size nad the rx_frame_size to maintain consistent
RX error behavior, regardless of whether Jumbo frames are enabled.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index f046d32a62fb..cf5118838f9c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,7 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)
-#define	OPT_FRAME_SIZE	(fep->max_buf_size << 16)
+#define	OPT_FRAME_SIZE	((fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) << 16)
 #else
 #define	OPT_FRAME_SIZE	0
 #endif
@@ -1191,7 +1191,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
+		writel(min(fep->rx_frame_size, fep->max_buf_size), fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4560,6 +4560,7 @@ fec_probe(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
 	fep->pagepool_order = 0;
+	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


