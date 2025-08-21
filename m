Return-Path: <netdev+bounces-215755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF4B3022C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E91892E08
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56599346A00;
	Thu, 21 Aug 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VboYRDG+"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A734575E;
	Thu, 21 Aug 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801259; cv=fail; b=DT+Qf5zPaw9w5tLJq6ppWaxIThqIIsRu9JMuLSIBY3B7ZbPYKgaegMxsH38xYKoiXoHGIFy2fW0uzlAuqZSM4dVmWAX1kiRFLjcKBSFSo8PuuxzBJqo/o7pHrQrXa5CJ8ZFTZPzpxunVFyIl8WwWPKEHFUROtUEWZf3V/u82DGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801259; c=relaxed/simple;
	bh=EsaqHf+C0KEtfjIaYWb53I+V2oRRvxDGWpfWLhQW3/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhbAE17TknTm3bgQLzDNlyUJCLxzYgpbFpQTKuTj3XcwYlqepUyuL+OCzp+oclfAk3APfdFTn3xsyPR1R59INutjIplqU8yiBEsITG5c8nLyZV0mtEv+WNGvYCl3w/ing3lVmbFz9UA6S+aNmBPLCoC6Jt0/oyPQOq0nhTaGG3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VboYRDG+; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY0fl4AydQuOe93cG7+jQi/6c1wRaHWSYlWbAvfTD6DO2+uOTbMHAvCQ9/Ps0D3RcjMxMrB+lfE1cGh5nKnORcZ5plMEWPY48l3MHQjPpImmkE5mgfA44zaMWQjRT6OrshAWvzznLVs36PqBOYYJS39JaM4kr+SRJfHwyt1J8tk+IUsWyp68lqNmj3R5IpiPst/YjB2nS/hG4u8ugV+s/vecYPeYAFq4DlD6H5lnt/RUXCu/86X7QT7OijwXLtfFmJWbfD1S3vMT7dSrW86VrNy1eN3Ln5N3Dcqm1z2RPtoQMjOVbCXKNhSVKAinzaWzYwlhB3brQfJ0oA+00MV66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3JwY7/QbmaStblidKRJI4ry3fPRxlQft//lDPJTZDg=;
 b=TMlWTJ0GoV0MY7Px/0UegRmRK0va+stsEtzWcE916dK6SmLOv/l83jUix9nNRAVmjzZJOb5l1ku/hQ2+dtXFvqvAF97MRRGyJaQzRXY1xpTdwHkArVMHfff4wl1V4gxiYo8257cDXDhdRE/IJkB0dHzFqSPoELLhNOA+f1evcRJJiXLpsGUX8TDV5+29Ja2F13nwZCmc5iorWvqc4SR86D5KZyPyBj98vfzOIkNK2REnYOzJu3cWXKgYaxdyfOLNq7Tjz6zi68v/fyNmobqD9hZgce6TJFlhCg5VsSaeVwHbWt1stZo7VKkZURus52T7OeeEgTX8gw+N9MbZIS7s7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3JwY7/QbmaStblidKRJI4ry3fPRxlQft//lDPJTZDg=;
 b=VboYRDG+6mTsOgejCA9K5wsBZnHIq5fBVp2hsFRSbYsINmq4BvcB5sQ16jlP8GfKmKfooXxwdP9XUJzp+2HD7636VP3vhE8ySiKk1xVKFTcnMnFnKtL99FyolEEFLWHKCYbFZkXJ8PDO9y5IOmqdNnI5Ms3PX692Wak3YLXtOg2BOFNipmvgEJJaG7M/vVbmu6UHkGKXdL21xldLZXt276VP/S/KNojib4HX9B6CF9Z7MBu3O7NsWba28yjQ1dfD5TpWBmWXULsNInnAnM9ZazWg3X0vNCcCYYDpc+jwgfrlVBFb6IsVXjgK7ETRSw+YhOD1NQ0NHvGyGjsHkRDA1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 18:34:14 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Thu, 21 Aug 2025
 18:34:14 +0000
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
Subject: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support configurable RX length
Date: Thu, 21 Aug 2025 13:33:34 -0500
Message-ID: <20250821183336.1063783-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821183336.1063783-1-shenwei.wang@nxp.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0065.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::22) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bb85fd-31a0-4454-fab3-08dde0e15431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+5Wb/jDphd21NQPuOggtPwaI8TFmSHWA2a+D+Tj1xukaWzVNHe6uE4mjT93g?=
 =?us-ascii?Q?bWx8WwgW1DeirbzTzywurizorWAGzuryUkhSi2zpcpEjs9vpQIvca7ReBTbm?=
 =?us-ascii?Q?aPMmZ86ckvfv1h7mBOJWo4xb/WHr8gFCw8DhF1WTg3x/nJSvybJTyzymF9b4?=
 =?us-ascii?Q?4ZmC9dJRFPm9nZUlFty6Z1ShR9KbY1KC+V5lNrpxtGPExiOhMO8BejxYNqlr?=
 =?us-ascii?Q?VzZSJy8Ddo5Rko1mA/RqBbWmMHKanuvkx2Xz2ecMfb3mAOoOZLY1r4K1KSI3?=
 =?us-ascii?Q?BRwVOR33xjSknRyKJ/q3T2CT3cQbOKtIBijEJ24X7e/4tzVKBCIwurylOeRv?=
 =?us-ascii?Q?qR8PtejVaKfrynjyLsbvBzn0y2mlehMP6d4G/ozWObAERkz4m6AcfagDWx8m?=
 =?us-ascii?Q?wISlJeFlRb2kEzMLKG3IEeTephJfWmjyfkelhbgXecF3/6buEMpu9VpRZdR1?=
 =?us-ascii?Q?dkl9SXyMkWX1SlxyV7gOVYJaYt4KMMBqkXODZYtRIQMU9hO0sOCFI7JGV008?=
 =?us-ascii?Q?rb/o/BfHuynK4H/yeiMVaUSrVP68C1oUa6qCLZZRpbiTGmS+9hr8iSisJK31?=
 =?us-ascii?Q?9MlAoaUCzM63OItRmZQVDgACP4+GIzdZNlWxNvaV2kBB7gOxLm22evG2vcXk?=
 =?us-ascii?Q?W5NBm4Ofz0jT/IYfpBOFIAtiD7Xtj8xCpZOEL8Y/hGUx2MmeuQQK09lvfkkA?=
 =?us-ascii?Q?wHs7t6L/dP1DjivaNRuVubrDtVYijjpnQRLkqotU+hBMrIf41IQCrdf0vWTa?=
 =?us-ascii?Q?GsFkQk68tDzkfhy2yJ3xbJa4Q2v+LWtEfFHbS/ktxk4xj+Gy5cR7IFBvR3cK?=
 =?us-ascii?Q?ABbB2obL0amDdOU7lwhm6bM8SCWWPkFxmBYnd9bKn0YdBkX7TA6LyfCMWk0A?=
 =?us-ascii?Q?ygemVtgACWGJq3OKWexYZMHwVO351KchfPm4CZBCCEdhw1WK2oHy5ZRi8iNC?=
 =?us-ascii?Q?tnCfQchAkOrV/QbLKr1jd44b1qAv8Yv4MP9ESvKrfw+loYw6Q3Y5Id0ZkiH8?=
 =?us-ascii?Q?VRd1MEUR/yoWH8UTF8z3wgl8xufGW6iDVlM15ceFUHGlFcgbFzM9+x5HNEpW?=
 =?us-ascii?Q?RKKil8fB2gujETaNQXH3y1GWMe5IwNgDg4rvrlMvgMzy1PNTV2345xa1lWHU?=
 =?us-ascii?Q?drGeqmLdlhvidfyGF/Ux2MJYK5qbxt5QD8fa/eIAobQ4QT71fGW79vaXk+Ph?=
 =?us-ascii?Q?qBjpkv99HfyjYSwbjvnmsU1XL60sYd9kreNAJIE/p46zusRCFt8n92SW0Zpx?=
 =?us-ascii?Q?CCgDFNxZYXXlnOE95d91yOxZaH7V+ARh/rGKBCUj4+XlDNUwCWwc7BT0tKE7?=
 =?us-ascii?Q?l4R0KB0hHwTYRri2cfetMnzMomaRna7KIKCwkxO9mr0YnN7hi6TiOv/PxsUV?=
 =?us-ascii?Q?qB3QSIZrQZynFAZU4YjxxCSrLYuUd2yg53E4HUIW16nUI8djLUKzLS4uCwOD?=
 =?us-ascii?Q?0+ZQlsYLQB7+yZKiEzna64RdXzFYJ2FLVNUh1TimGvafrAQ+eyRbu4m6Q5yf?=
 =?us-ascii?Q?Ka+VfTYx4EJMNxU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaibIcQ5NgO3tVyjwnEb0jSLNtMlfp6Q1fff5+U3bb7aRIdFtpyGSLJ5IrtM?=
 =?us-ascii?Q?XwOD9+/PYrjQvSiOG435FyGoyVRA00Ys93zgDMuO8vQiaK9RkG1DpbFBwpss?=
 =?us-ascii?Q?8plWZWfH+cGSVoD5kibNYa/GvYWUWp2UBkGKQm+3iprCLRlannlXKqtMEFyM?=
 =?us-ascii?Q?zFfs846r40BDrvqtm8MmaA0rrDEIm1lcGtF10MZ4i6osnfsheUiUz70dpoyy?=
 =?us-ascii?Q?fXs8vcjXY0U7Yl9vSU+KhLWMEyCFoLHEfO9bpxK3Br26WvoUilmriQMPcFIu?=
 =?us-ascii?Q?KuuDN2KeoAJs9/U7b84+TJyzF2yOjWzL49jXjr73DCpP4gZBJhcd7uWs2sT5?=
 =?us-ascii?Q?e9fi71ub1RfJgl8Lcyq7JiX9xax6EHfOI3/5Ht7cqt6ToZ2pBTnCVpQiSlcW?=
 =?us-ascii?Q?V3yeJyjAefEYnijQjHQ6kRJjeb1q+YjLdze06qnHdK3A5vgR8SYxP17IdUyb?=
 =?us-ascii?Q?LMw1kX1T16qMN5hw2b5eK+ssYagfGMTST840IiyidfZUjK09fgup3IYy3+GE?=
 =?us-ascii?Q?hrIgOhEZKuX4U7BbRgiRhuur39WMXAxtt0Z689gDOe8Hu3MH+9hKLJjbc80q?=
 =?us-ascii?Q?SNo+AqizzDqDM3vSsaycN/FKcXMdKLfPU8x35uJ2QsCfQKTLbm30iwUDwunN?=
 =?us-ascii?Q?O0MRiKYSJW2SzBVeY4I6wEO4r3Yg82jbOfzsmfbniO1x9w1k34ssINNVSLim?=
 =?us-ascii?Q?byrrX+SkcZHz9TSoYlkF9MUhoMY8NgRXDqnYts9mI2FOJngcdO4N9fmr2HUr?=
 =?us-ascii?Q?0m01lzZEQsGLiSa+BNwlLWhpcozvusymcso/4OQvp2Vn8eHQ0BpVBm3SlHDX?=
 =?us-ascii?Q?WtKFMMp1mfZGJ6nxo+TnKMnEsKk7CT3TCKDWleVvsUQ4bdwFmVr91MGi3s8i?=
 =?us-ascii?Q?b4NoCkrd1nvEpA4cCcknvYY+Ln4Iq0R6/xRccgZd5EC9iEhabksiHgi1dlCg?=
 =?us-ascii?Q?JBKLZcsEOFEl0FQthyaD4ZhmRzevm9MLv8lNExNT7wnDadD3H6C4E2Gbaspk?=
 =?us-ascii?Q?ipeFzBQqt4DpeBWz0WDccGcb4NIK1icAYPjEE9KdPs8RucztT/ZVBULw7taC?=
 =?us-ascii?Q?cctEeGRsp4zR+HOAXyJJWilqaTht3yd+e4x96cHSBjitCb3tqGKwiTyhAqnA?=
 =?us-ascii?Q?fF+wzrnES51HRH+oxG9yL2RzpwgyAtyDIGzSpeE91wHLSYiRmKdwCdNbxvD9?=
 =?us-ascii?Q?5ImQrPyF+9v+n44sBdSHLtm6zvX3WbxbOgadj+QyQuc5bH7Ijj+dNouBTc1D?=
 =?us-ascii?Q?RVhfRJK8b2/Im19/vCcuJ6uKM75X+VFu7niK6lc+DkrBOkAFoQabjG+SnYkn?=
 =?us-ascii?Q?WCZh3W/93fvmuUm4SzL+JlgP5ASbR5coi4XfKV2RUEwECF7gnOjNqvTmIPHn?=
 =?us-ascii?Q?wktRwful9yu2+//nKptyn8HQmWfT3j9lv+6zb8lHTF4/xv31eTHSMMl7mE8+?=
 =?us-ascii?Q?O5uIlDI8q7MT55T6fcpTk7rm+rJnNkzDz1a+7OuehM26CTEgavE5G19YU1b1?=
 =?us-ascii?Q?TrthwPvYU01BPq731MZiADRK0GCbASFgvZEcZs4C3V0nPRP3jWKrM6aBtDob?=
 =?us-ascii?Q?4JQ/RJpBewUu5OvFD7/z25l78zrb61Exl1QwJy1i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bb85fd-31a0-4454-fab3-08dde0e15431
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:34:14.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3HbrnN0vg3F0ykZ4uZ9ye+cLE/4XzgrepOdKx+sZjrjWhUi1C+y9+oSYhcPhaJRWPijVt00mGemDiIIF1u5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925

Add a new rx_frame_size member in the fec_enet_private structure to
decouple frame size configuration from max_buf_size. This allows more
precise control over RX frame length settings. It is particularly useful
for Jumbo frame support because the RX frame size may possible larger than
the allocated RX buffer.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

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
index b6ce56051c79..6d0d97bb077c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1148,8 +1148,8 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl = FEC_RCR_MII;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
-	if (fep->max_buf_size == OPT_FRAME_SIZE)
-		rcntl |= (fep->max_buf_size << 16);
+	if (OPT_FRAME_SIZE != 0)
+		rcntl |= (fep->rx_frame_size << 16);
 
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
@@ -1194,7 +1194,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
+		writel(fep->rx_frame_size, fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4563,6 +4563,7 @@ fec_probe(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
 	fep->pagepool_order = 0;
+	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


