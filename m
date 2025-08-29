Return-Path: <netdev+bounces-218116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98400B3B280
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A161C85F00
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29A244664;
	Fri, 29 Aug 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ny/bKiUE"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05582235C1E;
	Fri, 29 Aug 2025 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445288; cv=fail; b=KUg/7/muwjLUjff/FOgJPyBvYJ2uOr+xYGxg3moEnkBGaEyympBEWOz3EeSH3/kKWTa997W8wr/g0DSsZkl/QbZR6vH58tuB5eMd89Nkw7AiXfYGt+b97CLJrQsbK9gSjJAqWHTSy5zRa0su58FYQxP3unmquiF6TqLcD9m9hj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445288; c=relaxed/simple;
	bh=CkKuUQo77/6Bsid9gISKPCco9ZCqu6JAyUVn/1OeQVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTa2DNXzRJ3/gAryJZaT82GfsaR3i1hGyFGyNfgF5h5Hi7Jw5o9+KvCBQEfVv1ZMFavUFo/u3bEJ2+UDEWEMHi0psE8299ICypClHcU2Wmmf1Su/YwrbWZFqlExh4af4XyCsElcKU30UvNBxwebfzyLEpvvdDEkm9b6sKGMkiRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ny/bKiUE; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCVXLG3sHbANjalubH0IsEQtcyoLKxWF2y8OwD/Oo9U3yiOPjqs8WgN9Qg7zNXyG0QfH7s1IUGKqKNtS/SpIEyJFqQDWCWak6IVtZnrGWbfzO0/Ig+mePsGswRIm3HECvKe1h9qxzjDuMZFeEBRycC1+INuu77JtZII24XWCwhrNiPP+ovjnW3JQTIw6S1nGOomVzTR93c4egYa4TbN0KbTaqvW+AmMhcT+IEo7pthF1pm3qrRTCeVuiWQBWZ5x4UP2YeO/0pwMjlPRA87zJNA6JK0uk0n0dEqZAvIL56I2Fmthfj317Ny0y7RpE/IS/lNGAyn6VGvBhnuPKLbLiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6AjQTwpITTpQXwlvr3UsSda5pIcERSr2k2iUIJndF0=;
 b=oZ1KBLalJ+90l8Znl1AcAgk3Ta7v1xuJEQ90VqwqEtXPKl529rWTU7Uv5zZGnNtRWGcpF0kwDp7sahf21XVYatSRErDDLlTZiXUMFlJl5JlXi6v8RRgSSbbKVGH6Q7eJOJiDxGLi5Xyg8r1HwwhcQA2nKq/IYC5+/KQyLjT7VKocBK94WMfzZrTl6uttgzdZtglQvQzDj9Qf3ufBZDjNRBfwR0oSX/hgXXYy9lBGNBTf7NXZpxDjzDwr72LI2CcAqKHTf5sYUGcd7f98uYj3EIjx6TFl6bCBtDDwuwQ8+cXKpNeWGauDfmhBsKKk3eP+Xl62o+fajZXqowt8aSirkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6AjQTwpITTpQXwlvr3UsSda5pIcERSr2k2iUIJndF0=;
 b=Ny/bKiUEd1BiqlYH2gRnhDPBy2CfEAnXv8BkL/B4SEWmspyYmBPi4clRRBwSP40f+o4qphsLavVGNqlKRQlDRyJh+REqpSe0ddkKrIUV+6SGRMACKNwKr0FOpV1IktjLnRmSAczW1pSGEgjENSsO8Yv4JEBev/SY0wJwIrBSTACG1d5tTtOoXYqBP+0c8ISPKDiCjKgLggf9+1dxETM+DG40goGElZkHLGnqxwDECaycuUG3hpftSG8SJ5J8gMkWQywIDRMitC7cP6/YRJaeb4bmvSMbreyQ0y5nlr3JBKGYXipCYi4S6p83M2cakRY5g+Dxpf7OBwJt/laJAwOIpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:28:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:28:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 09/14] net: enetc: save the parsed information of PTP packet to skb->cb
Date: Fri, 29 Aug 2025 13:06:10 +0800
Message-Id: <20250829050615.1247468-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: f74ea269-2323-4f7e-11e4-08dde6bcd351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4VWqyuBjCjtpos+r8v/9/IOOdCVGj8jInC6JS4/shzwRhdGRMjIMgJu5fR+D?=
 =?us-ascii?Q?HTnxD4KuSrkNDufrrR1+PlQG3NKRs8yXyNeGo8jdc36N3de4ZSQdmxj9vEar?=
 =?us-ascii?Q?kZKvty3N6/XISxEiVz6FpGYa6vRJPn8G8VXmxAIU+rXQMFMdmT1KGiy8IoT7?=
 =?us-ascii?Q?tjuRYaXU34DNsvO7TM55KwL8j2mTQrumh72hHOsIOupmGy7LvvKwu0ek2HVE?=
 =?us-ascii?Q?w3LcmzIjOcy+sAC8XxTtbMOz7dTOr9mBOs6DdlsWc/e6C3l9JEMJmQW2J21y?=
 =?us-ascii?Q?BsBIPu84zJuGFo+hkDZGZ5cDNUJRh91ptxosxUUvaIIjOffftJoxYvMtFX4/?=
 =?us-ascii?Q?7yS8+4Sqx/IVIZcQY1cn+0OjHBw5Y93uHpXaWL0ItEsQclwusTyJCbCtvU07?=
 =?us-ascii?Q?+lT8uAbjdIkvg5AQd6mVJ4pxkGl3kU0R2HgEoVTi7VTprUZG2q1cmIIsVeI/?=
 =?us-ascii?Q?ioor1ioEYOnYOF2sGwUuWDu5CktwgBGJ11ln/06o/12whdjWryaHsAOjc0e5?=
 =?us-ascii?Q?Okv/fSgCegN9FS0jTEKAMwf8b//5ok/4Y++eLuHOEjxM+Wf5h2ac8oXUqcJJ?=
 =?us-ascii?Q?uNqoUrwrSI+5iLUbM3PHtDxaJhZErBaiW3/FjFfioLYH2yhjOewXiPnCEkqT?=
 =?us-ascii?Q?50t0wRadZ8PFqLeRbCrZSsrbE3DOFR7AgzpYatLwbO7zy7C3GWhcsbYdi4++?=
 =?us-ascii?Q?z1V9JzPUjte/ulajX144nXzatc4zv4lZx3aPRMHlJTxtDpYXazmqS8OjbeUn?=
 =?us-ascii?Q?bwTWuLdcrZtX07+oMy/wDhl8uoDXdTZZwZc/ueAOt1fTFViOxsuSrrcPIOuO?=
 =?us-ascii?Q?PLvk5soZ+H+v148hSRyDGlKnqVXSz+jOS5oeiDeDZENTwGNCbNdG8jg0c73z?=
 =?us-ascii?Q?+o0A0IsXWIjLh1bm1ZiNuIR/M/59SRK88mQ1Tpkc6ZvbG+MqHHvGTPLaMcfF?=
 =?us-ascii?Q?ejXy2JKvr7XlZ9ZMIKB7bc7jFopQce0VvDpP7lYz9aCALQXKgVNEPNKVvoP9?=
 =?us-ascii?Q?7XrerLfzsgdZrUonlp7LEpmtdhl6zV0bQ0BNGG1IegEQXtvJXIyuSQdY4Gh8?=
 =?us-ascii?Q?FXyN37Or3kCSC1MUZCXLLi/9lRbPsiesifaXeYbwh/SuEsLGXNcTVuP5YagO?=
 =?us-ascii?Q?wdMsQF0odCctvxrii9NazV2ZcLtWmv56g5F8sUX3POXJo4u+Nq6IJXZm8VIj?=
 =?us-ascii?Q?mYbVCFPB+bP0Gl8EgaRtxyf8XZgKjyo2DJ+2IIRd8jMq1J7SLsy3WIX2fv54?=
 =?us-ascii?Q?vL1ZmEm7nckwU+2MdtDI8/84RVhElE64mkQF62QGTl/7zNfqK5FCgMbOE3AX?=
 =?us-ascii?Q?9rVyAiPivJzjA+ddDDUDQuRd1LmcnMBtqnuOBfmaj9ueHv7SUKOkCkWWNoM+?=
 =?us-ascii?Q?62F6Irqc2uiPhRDu7IOK3v5fZCmfwAL9LPuJmwHAc5BKGmji1xXQuPNTLRj/?=
 =?us-ascii?Q?k0dte9UPiP3g7KtFyvMP0A3P5e8y7b6IogOEtGmliBuOP7KHYRLlDAn7AgLn?=
 =?us-ascii?Q?atxffkyCD9Tks64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lfbh0OV4sMA0etGfhCpWRbUhOYh23ScjwHW2M3gD8arnlBfT0PoHtaH/QpX3?=
 =?us-ascii?Q?h7fg2XPjQ2KauBhORkwCrDaIeziIHW7+ZLoGEFfLtym9408s9JmOdE24olBn?=
 =?us-ascii?Q?tWnBjNecRCuBN2Umgpw0x4qoCSQbQAgKREdgcBYqAGccJuCBbTty1BXG06In?=
 =?us-ascii?Q?pbdf5NziNcYDhy1orYcjn6WNjcgJscHWV6vY94J65zwN3KGstMeitBsO+EP3?=
 =?us-ascii?Q?1cvPQJR6UztR5fhWxu5yCb9USt6N0MW735Gr2cQcaCIrurq/wFYg5iIcB7mW?=
 =?us-ascii?Q?aWlyNiAVPfcebkZgfW5r/rgMEd++/YFnAWrjxTbQeqcg0xZay8hhxqXNo/hA?=
 =?us-ascii?Q?+L2QyB2ZWaXZyS9Je410e9q38ERgBenPDF2y7rqYFG1cInVQb9SGxaKcfipo?=
 =?us-ascii?Q?MSaIT4iSXDp3JJO1YcU7zQcKyevl/x+1bFfVJipSOiI6oMjf6pU4+i06mKfF?=
 =?us-ascii?Q?HgqV+gBtizSRTmxeaTC62AHkegWJTTtFar752Gg+ya1ljLJOM2B6bMSdFgD6?=
 =?us-ascii?Q?olO8b4zxpLGWvRrCVnu2QXSr7JIfTXH2+tQJmcA/v8qexjPJMF35K8/NzSMg?=
 =?us-ascii?Q?zM2pZ7T5njSR7y1YtOKDgJS50tsXXCy4nk1llYaxcddAqisHmQNkWnptcaw7?=
 =?us-ascii?Q?39IJDH+TZ3M3CWjZCDH2Kl8ZtJ4JQ2daRIDUR7zNgbrbng0i3PGUZlnL4RP7?=
 =?us-ascii?Q?OoGCifAMDA6HWmg9DMNTCGpKu2BoGOBhDgCOoLBP9gfziMZzDRrzSUdxGhc9?=
 =?us-ascii?Q?ENU4CUuT5RSI99ERS7FQ7TRZ9Kcp55dBEkoOex9gfsX72YW+KgN/80fXJN/g?=
 =?us-ascii?Q?nFtKfx2Snnr0ZigFnHRFt0iceEnb47UqZ75JlwcrUOPqLTgnmCqkcffKr8ql?=
 =?us-ascii?Q?KaHtut3Op7twDdyQm2pqd99UJlIu11MvcbskcjVGlTYNQo/Gv5Qw9Ei6aj2u?=
 =?us-ascii?Q?8HtudySF5Ec5gz4wYcls3R/bU3HB9PuNt5FTfIV9KcBorDBDDWDNzMbInBJk?=
 =?us-ascii?Q?Q7MmhKumSsLH3EQGTHwusp1IYFtmZwEIDgBN3kAY9AmpxwTTQQrlUjQLOKS7?=
 =?us-ascii?Q?f6p927li0W2o495yFD5SEa1Z8hgOBrBiVIvG1H/GNeSe/RlZHlukofUyVdcw?=
 =?us-ascii?Q?N5VmUtc5L9IauzoDKVlIf7CZhyDjRCXiGbkCB6d7OR+vtrXqAyrVnIKIVpl1?=
 =?us-ascii?Q?Wj5r1gQ1lZrL7a4ygimqiMYDR7tyoSuTTjtmsDFkIMVMMRtbkPg/NLz+npLz?=
 =?us-ascii?Q?uM9HBgUypg4nIYI/AYAV7X+pDpyA96Tx1HmeuPqjFxXi03RaS+w3ZHxCeRGM?=
 =?us-ascii?Q?eCjNFUm2GqKw1kbXOdBrfelGu3fKwd+4tCWJnwkRoK7gq+ge1Nsj5eU6f1yS?=
 =?us-ascii?Q?sY8wvDNREfL7TNQZzo/oBhbyBay0MLW1dtpEm0PbFRNfstR2hZd7bB/H1TlK?=
 =?us-ascii?Q?L04N7zt7Np13B2ifSiIDz4GaociKtb+/bsOpLuUd4qdSYMdJK/j9trEEg1YN?=
 =?us-ascii?Q?QLfxrHxlZnCv4CXUUOjvzgTIClVm0JXHYk6JY3LC8G4VigPSk3hsmMBIz3K4?=
 =?us-ascii?Q?Bmkl/7Iwb9GEPff9psMIPwuG3PzkGafaoypV55DE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74ea269-2323-4f7e-11e4-08dde6bcd351
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:28:03.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd+d/aqCgDFFZo7FR4j3SvS1i3u70mUozgHsauQucvvGiSbj2XEmUg5AMOjOz+DW656onv4BOEE2OBCIJnBtQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

Currently, the Tx PTP packets are parsed twice in the enetc driver, once
in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
and is unnecessary, since the parsed information can be saved to skb->cb
so that enetc_map_tx_buffs() can get the previously parsed data from
skb->cb. Therefore, add struct enetc_skb_cb as the format of the data
in the skb->cb buffer to save the parsed information of PTP packet. Use
saved information in enetc_map_tx_buffs() to avoid parsing data again.

In addition, rename variables offset1 and offset2 in enetc_map_tx_buffs()
to corr_off and tstamp_off for better readability.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2 changes:
1. Add description of offset1 and offset2 being renamed in the commit
message.
v3 changes:
1. Improve the commit message
2. Fix the error the patch, there were two "++" in the patch
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..54ccd7c57961 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
-	u8 msgtype, twostep, udp;
 	union enetc_tx_bd *txbd;
-	u16 offset1, offset2;
 	int i, count = 0;
 	skb_frag_t *frag;
 	unsigned int f;
@@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
-		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
-				    &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep)
-			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
-		else
-			do_onestep_tstamp = true;
-	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
+		do_onestep_tstamp = true;
+	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
 		do_twostep_tstamp = true;
-	}
 
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
@@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
+			u16 tstamp_off = enetc_cb->origin_tstamp_off;
+			u16 corr_off = enetc_cb->correction_off;
 			__be32 new_sec_l, new_nsec;
 			u32 lo, hi, nsec, val;
 			__be16 new_sec_h;
@@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			new_sec_h = htons((sec >> 32) & 0xffff);
 			new_sec_l = htonl(sec & 0xffffffff);
 			new_nsec = htonl(nsec);
-			if (udp) {
+			if (enetc_cb->udp) {
 				struct udphdr *uh = udp_hdr(skb);
 				__be32 old_sec_l, old_nsec;
 				__be16 old_sec_h;
 
-				old_sec_h = *(__be16 *)(data + offset2);
+				old_sec_h = *(__be16 *)(data + tstamp_off);
 				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
 							 new_sec_h, false);
 
-				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
 				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
 							 new_sec_l, false);
 
-				old_nsec = *(__be32 *)(data + offset2 + 6);
+				old_nsec = *(__be32 *)(data + tstamp_off + 6);
 				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
 							 new_nsec, false);
 			}
 
-			*(__be16 *)(data + offset2) = new_sec_h;
-			*(__be32 *)(data + offset2 + 2) = new_sec_l;
-			*(__be32 *)(data + offset2 + 6) = new_nsec;
+			*(__be16 *)(data + tstamp_off) = new_sec_h;
+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
-			if (udp)
+			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+			if (enetc_cb->udp)
 				val |= ENETC_PM0_SINGLE_STEP_CH;
 
 			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
@@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
 	int count;
 
 	/* Queue one-step Sync packet if already locked */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
 					  &priv->flags)) {
 			skb_queue_tail(&priv->tx_skbs, skb);
@@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
-	/* Mark tx timestamp type on skb->cb[0] if requires */
+	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
-		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
-	} else {
-		skb->cb[0] = 0;
-	}
+	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
+		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
+	else
+		enetc_cb->flag = 0;
 
 	/* Fall back to two-step timestamp if not one-step Sync packet */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
 				    &offset1, &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
-			skb->cb[0] = ENETC_F_TX_TSTAMP;
+		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
+			enetc_cb->flag = ENETC_F_TX_TSTAMP;
+		} else {
+			enetc_cb->udp = !!udp;
+			enetc_cb->correction_off = offset1;
+			enetc_cb->origin_tstamp_off = offset2;
+		}
 	}
 
 	return enetc_start_xmit(skb, ndev);
@@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 		if (xdp_frame) {
 			xdp_return_frame(xdp_frame);
 		} else if (skb) {
-			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
+			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+
+			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
 				/* Start work to release lock for next one-step
 				 * timestamping packet. And send one skb in
 				 * tx_skbs queue if has.
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 62e8ee4d2f04..ce3fed95091b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -54,6 +54,15 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_skb_cb {
+	u8 flag;
+	bool udp;
+	u16 correction_off;
+	u16 origin_tstamp_off;
+};
+
+#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
+
 struct enetc_lso_t {
 	bool	ipv6;
 	bool	tcp;
-- 
2.34.1


