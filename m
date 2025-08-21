Return-Path: <netdev+bounces-215754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0173B30222
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89BF14E2921
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263EA343D63;
	Thu, 21 Aug 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N4VUDRsh"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AD343203;
	Thu, 21 Aug 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801257; cv=fail; b=poM/8OOuELl6yq4so8PfZKxX890/SalPByQ180EvOF26Wsfyvd2SmBf8yHsa1SOEkDcR26RjKmWYRVDFr+cOz4dCOHK/3kOPA0L16R4MaKqmSSJsxY1t1HoSSZEzEqCboAJchbcj9P668aPVX4DMJMavO2QayMeGm74a8cKsyPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801257; c=relaxed/simple;
	bh=XxtsGt19e3tZOvI4cRNsif4YVLO4hKwIcdBaB/EFKK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aV1pV5xbn6SEVY7L96muo1aBJOoZQTijpCPX93QF9c5hkEgZ9rywipvokpQKuuP/cWHnyvAZQPoOM0609H5CKi5fQGwzJ4gp8amGMr/XxFjB6eSowvIiC7Rg7wNlE/nfzNvrjUI+UpLFDIlzBip2ZNjWSQoDxU8dGtu4dmARGA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N4VUDRsh; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbtRzSOAqXxJtYDCobxzm2///ojmSPySeGBfZ1fcmj9/NbpEb5R+0sZDtWIZmFRdC9OziGiUC/7ApDAZnNjQuSy8tnpqAjx6vEzdmT1og/Uah4kyvoRBAW7zpm/8liRTgX2v7xj8GBCKF2G4dAo8UEoMRhHhXveK9LV49YD0w+IfCdoS/LpJMECTHfobHGnEhFc3sEgl9r0YWbyr7yf6nvMSi4IpoOgz7h4djm5c+x4WPx0R4VllIC2W96oq7Vs2SMHrZvuUDW131y6n/PbtEiDCRmUA6ko+Q7SOSNoDoVBKbOxysxboWZ86hpkYm7Oodz87/xYKvD5CYY6MBw1gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4LcX+CopIK62GkqTl4nmCRhtwoZ4wJbOMrjkUruezs=;
 b=G9dHxO/Y0T3JcsoxWZlHepjGD0zc0bBKf4Sx6sv2EvxcukFUC0TcDJr7rxuxPB6iV8lv5SdwtMqbrLWhVrHDFYPzjMAsIeZUzI+USnDkAasRQGiS4Gb45aaPUNb+WMoa6SB8q7rAMi5s0w5+m06V8AqSvHWBISlWDze3klo08A5r7jKOLAf49QgDTjOSlDpnyUCS6+Ep3Bf2OjPrvPOOoj+Tj3odNW71WZQ4y+b0B7kx5bYdPiwjvgIemGY5R+8vmLhp8SYYj5gx2u9PmKk4A3DK9Kd3mLp9MYvCqnRWcyvNGuAHmy27HHHHlKeOqAM3K1+8X6YUyjPZhUAIw9SOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4LcX+CopIK62GkqTl4nmCRhtwoZ4wJbOMrjkUruezs=;
 b=N4VUDRshpl8jQ1bKsIW8GWPgcEwftHf8Um4pWSrKcw99q/Ede3Xcuy7E3phd8DZd4OePrQwYbD2TScAak3+bKU5mlbAMME2TwQjMduk2Ja4FH98o0zE60GHrs7nW883LW4A3EOydTO0qYB3mklD3MDxYKojQsyjGwsZHfPW9+q4z4BeTQW7QWM1orUQxpl4rXgV4R2U07OEMLEJUocqsUEL1CS82zzFzDR3PCLSRB0zTKxVLeqIfszmD5guCyPoKbEKinmnSYtfeN0L9fyRd+On1BuP7JIu2Gh3dJlC8tIF9+KZ41yb2w2UdwoH4oGfsqEWndAni7Bx9ner2iYkdXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 18:34:09 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Thu, 21 Aug 2025
 18:34:09 +0000
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
Subject: [PATCH v2 net-next 2/5] net: fec: add pagepool_order to support variable page size
Date: Thu, 21 Aug 2025 13:33:33 -0500
Message-ID: <20250821183336.1063783-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821183336.1063783-1-shenwei.wang@nxp.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::11) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d9f90d-1357-4db2-b8f7-08dde0e1514e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zMaV0lw0j/z8N3L/Glr8wSpIl6jTJwwlvScY6hWDHXeP3atbxCuE4k4a6NlE?=
 =?us-ascii?Q?/UUOLBXTt+WPkhAKofSGFd9yI7/C2qRQH4nqqUVnBncyIUtMMpdxRqqfmieM?=
 =?us-ascii?Q?Epbgz209SK7fdudidXw2e4Z6rMlYmxpNXAg+FRmnwrVs9bL3PXWLMV5RPRDJ?=
 =?us-ascii?Q?j9CwlvQRpyI96USD9H6ecJTzombng8cZwiwOTiiX39rTtHixECg/XE/95dBB?=
 =?us-ascii?Q?t8fDmPaS83VEZTpKoqfPceYI9mvZusUFU9BCHfg1Z9ioZZHtEYYqWoBPrp5o?=
 =?us-ascii?Q?EEXdBRa3ZoogSOsmvyXXCXLyu6gvp/VaAKUqZkkkyvLOn+4JT9GcLa3wtABS?=
 =?us-ascii?Q?vuDNMj+25DmDY+MYHAU8AIIlUtY4v6BZ+3ZMTg5tvkHn8sE7zSYyJHiZ6pie?=
 =?us-ascii?Q?RpXIoB4BIi4WdhXn9U68DiWnJqnU/13tPvbgJfkCiHDhc3zCn+uQ3DpqeYb8?=
 =?us-ascii?Q?B7mVARMYbpQ9NphNK9+R1X9Ye7ZKm2FAjo507S9O6F3VA844Iy8aGaatCcV7?=
 =?us-ascii?Q?uPWl3yTBj9azRqLLZguIk+iqvFCtTrhTrmurGZitmesJdlg34PjPtf1ZPpZk?=
 =?us-ascii?Q?vdD37aw7y1HukRbclXReAFnJ3nM9ZZtRPHDW2YfRvXh6tBjaAmuzg6Y9X+y7?=
 =?us-ascii?Q?fY50xScRSjo3Ft5+ylF4n1Euttz+mLBeukyJI/sFcYbwtvAk7JWAgqDdimbo?=
 =?us-ascii?Q?xQSQab0qiqndfEvjOPUxphRs/wTefpCEAbVk2aJOUDY8eu3XU7j//awovAmU?=
 =?us-ascii?Q?jbfF4dY52+/X3pkNSUlC+u78nnoCNWxBVrRM7HNvfYB+wxuHiELeNEcBnltg?=
 =?us-ascii?Q?Unrbn2GGYSpDvDeCcrWLL26oZmX8mjhJYOT6Zs57LQN+R3CTXvjzA+E1UX/w?=
 =?us-ascii?Q?j6S651q6tGWlvg7l2/tJMgjhe6Gyu37kiFO8/8FnThSn9yyzaqH9q1up7kGp?=
 =?us-ascii?Q?yC6MKs5gM/2zyltW0snOP7gvYZ6K0CfK/wPdelkij+o55X5AdbbTPK+OkFIK?=
 =?us-ascii?Q?FhLMHAQiNUDwAY/dK+SUg80Quw3w69XUyqdYjcoU6oAMLdYgCYlAJZtcva83?=
 =?us-ascii?Q?lVrZ/Bn9kpoLHrbRNoWyQLkjrEUBh4pZyDhm8emZFNPddBVYqnZvY4/qlkZ0?=
 =?us-ascii?Q?r4Ks12O7AKqaBaUIb0iIDMyzn4oxnWFrVE4YRYYlHXxA5H6P+i5sxsC/fhzh?=
 =?us-ascii?Q?5703GDavhFbMWMGNrP3s7TTgjOwu0YyjmfDFkjX5PYoumz9CHu/KxtM9524G?=
 =?us-ascii?Q?7448A83NIMJaFGzId/WGIxWow+XaNBLC0EZfQPXBgWGm7H26fxg+Aez7kjyw?=
 =?us-ascii?Q?WtRJext8IdcfOEE5A7CIxmY9fcOQ7HlffwJD4/0fVMb2gjru34vztEdkaDci?=
 =?us-ascii?Q?pWSG56YXkjQXqxjE3/pjTJuHV3Jd7B8e0yZIsU4iLiKrCInrAXxEXXvHhTfF?=
 =?us-ascii?Q?e/X1sUGUAfgoxkSm5XG30o8f/Fbi0rWqah0Z9XIEtQrgTNFiVqzRs7wR7WRn?=
 =?us-ascii?Q?+YwwRrjhNda0YwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oCK+Nn5QXZMeBgAePigUHPBiAREw//9POsix0oXNGAre2htSqqwTxy7zfKmh?=
 =?us-ascii?Q?antW9GGhx65w7+3iK6s+SoP4lBCz2rPTPD+HIrAEJLWdBLmrZwOxylFmnOi0?=
 =?us-ascii?Q?kQTOyZHCi9w1w0V72CrWad5X5OzK+MCl3+QE1To/PB41EE3VETGliQdzLifP?=
 =?us-ascii?Q?VUcTJIqQEebKJZ0P10Pdl+Y5RbeAgiyuQemiJBiLlwra3XfN//KPzNC1arHF?=
 =?us-ascii?Q?3DyzROG362WIjhyGBg2nokYTEIsxu23iqfdOcW1+5/ZLs2yNqBi46O+5cFoI?=
 =?us-ascii?Q?cIayy9y/j/FxMFeYXJjbnqxVOjSfHAcdAEF0cB1SOdrSLnmmo9cxmLBADyxr?=
 =?us-ascii?Q?cQ25FEZZdhnw4C6tbJMiZtmxRu7+SRa69DEfsVHWr5wR0iZ+zfRWqapm5bam?=
 =?us-ascii?Q?e2tgW67hKm8syw6IWvpchsOmlo501COZ2cCX03iXDQDWLSfHh8VoNFfgX08T?=
 =?us-ascii?Q?JwWKRepMPrgCRCNNaHpK1SbxZ9B+wgMuH7hgeXJKbnjl/XvyOb/qHOkpT+ez?=
 =?us-ascii?Q?sPWqQR5ReQokAJ5SrtqpY9aIx+V0LWvsGTHGu1ibQ90/dyAyCxi/Leh3rvuo?=
 =?us-ascii?Q?LqVvcY4kiOY1pEgYUTLFi9bV2B6T+VOnDUAxNzPbryOWS00D3MIQ1LWJ/GSE?=
 =?us-ascii?Q?oD3415GCjXye08o33t8DbBbsZdi7Y5JM3c5JA8QoyrD8uikUIpgIO4TA8gxc?=
 =?us-ascii?Q?lGYxPoLRLQZkKrbsWMo4tRtAerme2aepGJMHePDDtSU2LLrSxPSvTviAifTS?=
 =?us-ascii?Q?fiRVpRsUij3/HcXlQx1iJ5JBNLuHeZ4NVO13TGUC6d87MH3EaqV4bA5Ue4aZ?=
 =?us-ascii?Q?6GkJ375eMYNEqKtPc+KSEw/mNnLO86GO7ka1IctFDJsU8xdufhHHdbGc4ZNm?=
 =?us-ascii?Q?xBzVWPwxmKJCuzfVaS3XZYfzYHRVY4EK8msLYLynaYLBYmsT4PzTiLM8Wsq7?=
 =?us-ascii?Q?TkWYPJXbM6enwXg1tgHHRWz4QU5ffY0USfqoWZRFJBJXnEUXa4pbu1t2hBqy?=
 =?us-ascii?Q?KEMp6bSisqAswykv0fAg4lcRFncT/sKMaeqgPFPCbknedgUiN5QvatGlHwJl?=
 =?us-ascii?Q?vBYi1mREb9F+FL1gnKTUbeKJB9JESvy1O1p+ZBCb5/r4Sr87eWSParZbOji/?=
 =?us-ascii?Q?wioOGpR0STZV5Fq0WgTggfOL7bQnw2H68MjfSo0RF9237+HD8YrX4mphVBWj?=
 =?us-ascii?Q?Lju/yFv6k0T9gZDtatvb0WkPKtD/D/pE8PoNzeLMhquw8UFIW9WziHsyb1/f?=
 =?us-ascii?Q?hmWPl+XRh25MSY05vQ2c+K+yzCPF4Vz4difwhYKus0OM3VvFfPo7cTOP3IxB?=
 =?us-ascii?Q?FlrqWrmUKHaB5VUSG9tbjjPNdVp0WGPxh/vdPK6GH1e2x/NfTqwVyJPtMNNk?=
 =?us-ascii?Q?hzW6r6lx+fRoB6J/D6jRqY4tOYlIYJWQHUYBfngSKqJQTBe3WO3FjpMFFCWr?=
 =?us-ascii?Q?JKNBjYG86K8+VlIFdBwoLlPY/Igo+dzNRv/hH/w/Wv6dIOLnaME1UBqhoJE+?=
 =?us-ascii?Q?EF2YFczXTF5+dmX1IMJElVUgrm4TygdAAax+HehZ3tYszoXkBLZFcXXlUTJH?=
 =?us-ascii?Q?T/LR1Xkbj0E9pfiFoU7YmEujevPi0tpRXFD1p0v5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d9f90d-1357-4db2-b8f7-08dde0e1514e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:34:09.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ub6xHfOmpG/jyjaorawfa5dQBbsEITSdEIs5iFgdngg3g87OKrZROvH4irgzsgHujs3thcCesEy4yTMMN4oCjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925

Add a new pagepool_order member in the fec_enet_private struct
to allow dynamic configuration of page size for an instance. This
change clears the hardcoded page size assumptions.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 2969088dda09..47317346b2f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -620,6 +620,7 @@ struct fec_enet_private {
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
+	unsigned int pagepool_order;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 24ce808b0c05..b6ce56051c79 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1783,7 +1783,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 * These get messed up if we get called due to a busy condition.
 	 */
 	bdp = rxq->bd.cur;
-	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
+	xdp_init_buff(&xdp, (PAGE_SIZE << fep->pagepool_order), &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
@@ -1853,7 +1853,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		skb = build_skb(page_address(page), PAGE_SIZE);
+		skb = build_skb(page_address(page), (PAGE_SIZE << fep->pagepool_order));
 		if (unlikely(!skb)) {
 			page_pool_recycle_direct(rxq->page_pool, page);
 			ndev->stats.rx_dropped++;
@@ -4562,6 +4562,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
+	fep->pagepool_order = 0;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


