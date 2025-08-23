Return-Path: <netdev+bounces-216239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E073EB32B8E
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F539E460A
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F52ECD1A;
	Sat, 23 Aug 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RPuPNwrX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2862EC57B;
	Sat, 23 Aug 2025 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975732; cv=fail; b=suRekLjbchX1plzyVU1FIdd39nyh+IORMox1GBibkZKk+UF+9FxyBBMdYo4E7OhtY+0eoQs1iP2MniETuJSoydy+fbbElQKYczma0v7iPC+N1fMS2dsh7fg2bN8HMYI1KyLQI/zICF3Fiz1NQmXI0BBLTlVni/6qzRkYnJYzsOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975732; c=relaxed/simple;
	bh=rsk8zdPPsCYHX6ErSgRb2FVtPpPSLwu4gFfD9a7smDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=De2GC4QDqS+0Yivo57q/e0EtbTrmZX0aEAtdiDhjp8wwVPTUXTJQKpAdUKqpF/DGrVL8jhSphGAn5+l97SBbklF9UQ/ye5ahNYSkGzUEz9X1OUwI0BYfZ1KCOXFUIGEgQl9xuGzg8yUtrc6anYEndtbl4qFFTuSAlrOQiPwgvaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RPuPNwrX; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL6+w1bsGUuPJIWB3XbzJi7MkPgcUrAuIomtVHo9hPmtNZO3IeMq6KJcGVSyXgO9xtaI9rTiZSrX/9k+WdxZ+UiCPGZUFQqKbh2J81AZFPHtY7w1o8eghbbeMYMxDMmuE/76R6UbQtQMcYO1pfobokbiqZ3zY4RZhTq5KmFbr6HL1ozloKm8k1XO8peIBVgdc4O/8sYKCola48amlFbIxccRlAHtfb253Tl/UPpNQmUR+1/uisGzsjL+X67r/0fSVp4kv5iCllgbdj3ShMgkpUMWzHQnN3MiyFbSi1ICsW4rxfXkarYU7KxNrx+yqOY/CIiYOV6NFYpIm2AO9lU2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31SQa+LRT+EwL59+6GcooIhAn0nh1XIEmZdhWXKDNTE=;
 b=fNp8z17fsfJ1TZ0ypTwbQE1UdN6hnB0a639d7S/BsL/ir47BPtGnYhWQRKUGZ5yJj6jwAlqDTHIBTADhvejrvJVV0JUm/aNmyejxqhKEfS7jXnzON/6dBGVU/n/8ON3GE3f5h1ou+m62U8KwmayYBOOB8u1tUugMNErtJjLsxsYMrXiEDkfleIS9OofKz1C5/eTuknpfuBqDIF+a60LCYKaQCTTXk68EimoVgHQw+z4aSkyF/Zq7ajIMCs6hevAUgkT/FZZSbA+EmbZZxNUB3xUA/fFOl4woUkiGTW6XoN4TGqO+O3yOUocsJDEBPkQw2n7FK/jOm59zbdD9J94uKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31SQa+LRT+EwL59+6GcooIhAn0nh1XIEmZdhWXKDNTE=;
 b=RPuPNwrXr0Upg5wN7gKvIEIte+SOJ0smM+1/+Xe91E9qCr/PHzmzmNZf/DArle2mdxAwYsxKV8Soaz7Ryog38TeijZ+/0Wugg5w7//FcwF3XeOeN5qzuM4u/dR3+Upv1ifb6Mcr34qPk9Obh3Wg6+WdpLRtrrxTO01+LGVwcezZe01uef3ndzA+C2apSurAbbal8t3m9m95Tyk7uhjykker2DKBNq3dY0XfjT3Dg7Ztmq6FGntTcqWbsUto+G1tLu64MdY/ajYh1alTjY57zPjxDtz4jRR0A9+9Y+lRa7SAzrevERSlG8q/vCMzQUUJAyWxGJAWZxxpmP5Q4KKSQ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB10456.eurprd04.prod.outlook.com (2603:10a6:150:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 19:02:07 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 19:02:07 +0000
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
Subject: [PATCH v3 net-next 4/5] net: fec: add change_mtu to support dynamic buffer allocation
Date: Sat, 23 Aug 2025 14:01:09 -0500
Message-ID: <20250823190110.1186960-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823190110.1186960-1-shenwei.wang@nxp.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|GV1PR04MB10456:EE_
X-MS-Office365-Filtering-Correlation-Id: a83f758e-f9e3-4da9-9bf3-08dde2778e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pu2tvfHmTAdQswrOug8kBySKTmm9US5zMm3x5VlD8PSnzzYg8LwiromkkX71?=
 =?us-ascii?Q?jYguHpz6z6ZJd/ksDseeeIlTAbQBU/0AahReAPkysNRLngTM2iC+hcteMscN?=
 =?us-ascii?Q?oND3QE0AJXD/ky244GjQ8lDSMb9//HNh8I2/HrvsIBtB14/OSLNgY/mqQhGZ?=
 =?us-ascii?Q?S/+Alslks7slo4qYTU9CWMzU8zg2g3eaeBp0Yu6e97uRzSsEPU59/+lOa4v7?=
 =?us-ascii?Q?W3cyS7o0FIRNPuO4MuJRJ+zxqidekTARxJ884SNnt8NhQmXMWngOWwMElcF8?=
 =?us-ascii?Q?BOJZErpKWYL3TBpJC+rDB2zcaRok8PWxU0sRV20tUzvjVF2fGma/r+e9W0Ap?=
 =?us-ascii?Q?sfE1QOyP/IdPlp3I/b/QHplA0IDFq4TI0Ix6AhBnNEjcsmHBzUIqPwEjcDUY?=
 =?us-ascii?Q?SQR5AMeZ8IEWzdL64wqCTFyxe0zyrLe1xjCwz62yNJ30RVVO9dHpUZgPFs1K?=
 =?us-ascii?Q?01SPwUXgUg+dGKvMXM5QmkUGuZ24xMEfdy0e32pjzzGXLE82nGuZun53SEBf?=
 =?us-ascii?Q?OeE4KaDaFsOOh9WiLsN+bqYA2hIDIy+WRPul2fvobaJgT/sCujFRDfH0yJ35?=
 =?us-ascii?Q?uvA17Y9ySKQf1YxwmTGPIza34NlZ1zrxnNM1w+sRPE2X+AkWiaV0US9LIIuM?=
 =?us-ascii?Q?e24LeMMisXLLsyt8zYJFfRTiCSkKEdLqGRFE+n4hMZkI+lbswM7zUtqI5uX5?=
 =?us-ascii?Q?KJSFDfJVh//3Fd5HqwcwxIx8UzUZ5xFleFymrF0IJIBoBYj+4mvi+gCYyL5j?=
 =?us-ascii?Q?uR092mf1wRC9lWz58eVvQiQa31tHAJ/VeGuswffKI+p0K7TzU7QyVxGDGmRW?=
 =?us-ascii?Q?dmnjTjF9iAteuHEPF50um1+3qM6aH/SHG5S8Eq2ssPlf2+0163Afoi4lcUS/?=
 =?us-ascii?Q?QJShI5StDc2UK+vsYlhABMbS5bGLBUzUSiWEs9Dq2UpBmQxK+S8Wm0XNxf6i?=
 =?us-ascii?Q?XBDW/OnvXPJrd0+aDf6PtdK0PZWygeVTiSAgp5rQCUOTTguKFkqljcfnJ+Ab?=
 =?us-ascii?Q?kNBIALuZzHyRi4KC9tNWNzwGuHnbAHm2Mj+oTNyQQNNK92jK2D15dp2rqNmk?=
 =?us-ascii?Q?okk9IHyG3bmBnirJvHZRNSVF8pWQu9fag90xP+ufGWKETYQepSuUx3nsY+oX?=
 =?us-ascii?Q?mlTHGN70W3oY1035Cc5E7ms10XY5CXLp2hWKoMjXYgTX72yEhjWtgAXq16B+?=
 =?us-ascii?Q?koW+8V8ht8NFeRplhC9ms/37OQmlzrPoBhPav8YNAi8gV4Myw+mNBuhZjVJK?=
 =?us-ascii?Q?ZlmyKhJiFt0E4J81+sxbyheRgjbmXi7x1UF9lIkHGvwjzQqEQ8zonB8xBW+I?=
 =?us-ascii?Q?OHNav8u5zogaHfI1IWjWkbOP4KhGopGfDIQ+Q5U9w2ZfZLjfLj+crVb9mxRr?=
 =?us-ascii?Q?GK1ivpwS1bgiNOvc7ZpPte7UBMGeFYzjYLqrKv7M2jwldquT2qzoHGcbbE9r?=
 =?us-ascii?Q?zCPwIgbdx5XBhG2D9Cgro9bB+qYQlYoEeJOYoGTkB9hzpgbNlq9r7b4MxsC/?=
 =?us-ascii?Q?JexWumY3fY04+9k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+kAwMFOg17v5BIAK3mog5xCgvBOi2kU0gPFzA0G35gHMxVpSgvO8z35gHge?=
 =?us-ascii?Q?I2i6oI6zAcKzi6MtOwr3p0itIs1JTd+733pmzESvszDY4eA0tCvgU5o8//sB?=
 =?us-ascii?Q?mUS4ciBwmozz0mqvCtWOtylZ5SNb/F/MHKmw8Td2v+Miz/vXjy7rnmhJYaDi?=
 =?us-ascii?Q?zxbiatDzcFTEwAvh0tlOw9Y8t/d/bcw6sFX/Nv/XD3pQw8owhaSSWWfTYjw3?=
 =?us-ascii?Q?Nmx/d4zkPzv4OEVSeu/D3lEQ3T5SeMzzBJwn5jTPhgaaJwmDb7jjus70jYFL?=
 =?us-ascii?Q?O9GdbwVc8nqgC4dzPvRz80noRE//7AI0ufEpUKsyR4GjdMY6/h93MuMviwUo?=
 =?us-ascii?Q?7Vp000+1DyGy+x98+xKJFjFSP5mNL/z2jRM2VHVu+HmUrHMf6jEb1hAu9uAD?=
 =?us-ascii?Q?VlP92AYUxHvgJGRLbhtP1z/2A715XmBAo43M1ue/3EZc23m/6JfA2prvlXgA?=
 =?us-ascii?Q?lT1i0G2a6Sl/WvIhOPQpp3ngd4LeJveLtN/O5SQARhsy1p2jA/ot8ndJWmNh?=
 =?us-ascii?Q?1y22PtRBx8Pv/XvIyMH/YUlDlwDooa0hxGBNZVQp4HQfaa3lVMDyb6Ml4uj8?=
 =?us-ascii?Q?6bZwd8G1OF63UxfVZAPsDmYhEo7JRfPITpvu7Jtf+w6scPrSV5bqDhdjCcwW?=
 =?us-ascii?Q?k4Gds5olGIVP0I9p3xIFsVXM7U3/XEdMR2A84qmLT/k1K9Qee2t1oBAtzAWu?=
 =?us-ascii?Q?yXjaBasaYDA3i/aGe39wFjGuqGV1fceivco49N+R25dtECRI0vpLFUhJVIib?=
 =?us-ascii?Q?h2YnDyNL24Zr/3Khl/vI2Fw71TRhxX70hRM1Tg9RRs9Threl67uTLHUkP6h0?=
 =?us-ascii?Q?7Ms4mfEQq+G3dKYv9jstfodOmkPwkr+99W6sz40HHzf+3z/vYngytXYcuG8r?=
 =?us-ascii?Q?koQ0299ZKX83bQCHTqFgaD0j+LILJasvW08XPPfYGf4W1q2G1MpEoQygShbz?=
 =?us-ascii?Q?SnV0kVVFOy2ZXBqMI4wqmqKRDJ3LFmwg1sPwSTWRHnGJ4ZF7zzccJGTX8yWN?=
 =?us-ascii?Q?WBjIghNCKG1m7kwITpgMLDxitHezt+cLkwrP2TM7GXum6FvWEUhOr+svEAUQ?=
 =?us-ascii?Q?u8TPE2ybYe2A5i5C1oA+vXEYBZgxuqYQ3EtJtopVezjRUEu+6hoOhB9YZJuL?=
 =?us-ascii?Q?xYvachEHToMFLfNfGGcmkLrQaTMKGQ0cO/QYDwpuaBL5H0wE1znag1vYwNTx?=
 =?us-ascii?Q?1iIpqUCs5/sEtMlTlbL3vAzuoHXRemsx/e0qUPx5pBpSFgn2XPnefMoSZb80?=
 =?us-ascii?Q?qsSNi7aMNbUTc0xP25Bp0UY6T6OCjUcxnBEv0askLHtdYr8H9OOpO0OjhxG8?=
 =?us-ascii?Q?a5RQSILHVVKGC5z/vT54R3U8Bb1OYlksXm3+xb1x/4ZAwEE/TlQtyFqkb8u4?=
 =?us-ascii?Q?D7tLye5fBdzgBYOPtFSD8F+1TA59GZnVNKLtofbGuwT4eeCm3OReel7Uz96Y?=
 =?us-ascii?Q?Gp7Gl1xgisLJiRXdmMgmPeUrrSTDBHArLJ089/fEMSG9biztpIdGFj4Nshnv?=
 =?us-ascii?Q?DiRtOckUz/r3/LkIfhj+BvCYbOSFPuY302hXFbxUcq4orCMY62LA+OklS/Dy?=
 =?us-ascii?Q?dRMWh2c7xJ3Rsjsm6ENHHQ5Vn17jMvPTFHHF8me2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83f758e-f9e3-4da9-9bf3-08dde2778e46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 19:02:07.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvyQ12E2/ElG9rxaNj3UnzcYUnjAb/iqZSwL4wBFafoxKtjIVM+HL4O3e+T0Vc8yJ74Ux2QIcPtW46G/oCnCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10456

Add a fec_change_mtu() handler to recalculate the pagepool_order based
on the new_mtu value. It will update the rx_frame_size accordingly if
the pagepool_order is changed.

If the interface is running, it stops RX/TX, and recreate the pagepool
with the new configuration.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 46 ++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 3f25db23d0de..aeeb2f81313c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -470,14 +470,14 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
-		.order = 0,
+		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
 		.offset = FEC_ENET_XDP_HEADROOM,
-		.max_len = FEC_ENET_RX_FRSIZE,
+		.max_len = fep->rx_frame_size,
 	};
 	int err;
 
@@ -4020,6 +4020,47 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	return fec_ptp_set(ndev, config, extack);
 }
 
+static int fec_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int order, done;
+
+	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
+	if (fep->pagepool_order == order) {
+		WRITE_ONCE(ndev->mtu, new_mtu);
+		return 0;
+	}
+
+	fep->pagepool_order = order;
+	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_ENET_XDP_HEADROOM
+			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	if (!netif_running(ndev)) {
+		WRITE_ONCE(ndev->mtu, new_mtu);
+		return 0;
+	}
+
+	/* Stop TX/RX and free the buffers */
+	napi_disable(&fep->napi);
+	netif_tx_disable(ndev);
+	read_poll_timeout(fec_enet_rx_napi, done, (done == 0),
+			  10, 1000, false, &fep->napi, 10);
+	fec_stop(ndev);
+	fec_enet_free_buffers(ndev);
+
+	WRITE_ONCE(ndev->mtu, new_mtu);
+
+	/* Create the pagepool according the new mtu */
+	if (fec_enet_alloc_buffers(ndev) < 0)
+		return -ENOMEM;
+
+	fec_restart(ndev);
+	napi_enable(&fep->napi);
+	netif_tx_start_all_queues(ndev);
+
+	return 0;
+}
+
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
@@ -4029,6 +4070,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
+	.ndo_change_mtu		= fec_change_mtu,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
-- 
2.43.0


