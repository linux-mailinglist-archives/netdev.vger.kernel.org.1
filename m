Return-Path: <netdev+bounces-237534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D985C4CDD8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5C3234F839
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E734846A;
	Tue, 11 Nov 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oFu2Jiow"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013054.outbound.protection.outlook.com [52.101.83.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B6346FB2;
	Tue, 11 Nov 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855246; cv=fail; b=QLNPoehouE8KGZO84MhO1YSmKfOQRB97z69M0n9OyAnrqfChaBaKD6YesQr6JtT2AsmyduRCQBlA6BLvhE76Ysdt7RjsIVo1ajJhW5QPtLpQgT/3MzD8AWXCiX0BRgdlm5VYiBlDGzOK7jvdQ+40ZkL1oE341bZYKJnrKVtASE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855246; c=relaxed/simple;
	bh=qntyOaVvILoxRCPPoipzddWgdR4s3vwtW75F/1cGPEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VVyqNiCsJ2Sh1TEYRgr0TeXzGEEN+O/wDLtI5YV+2yL+kBw6NyFk2K3Z6gdg13TRJRZRJrLhWlEIFq6t5CJ78Dk/bnvHKOl2Wj1w77uwZtqfYwfIblC0s1XiYXQwTodZUbKHWiu9rp7IZ2k1f21XU5K3NeLb5ViwMWcCvtYaIZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oFu2Jiow; arc=fail smtp.client-ip=52.101.83.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Buy1Tc4Jw/a772bkLerKdcEA+Dzj8EsTFJqHXKx8BPf6rMKxHX/ZxVWVgxrorJWEvHJoiAm+apj+05qpo6yD3Mheozm9wGSq5O0EoR1Eg6TfCkxXgACPW8Oeyh6mm8rU0utlriLojZcAql1H8Hbc2LwVloc3LYhfzS8aHKrh0JMHeguJzH5KA7ximr6QtDPlsshS4t6C4qiNr951nkmiuI5XL59Ddy98tSwMUO1qFcLQ7q8Q/sW6x0imI9NJTdrNxjZ588U3gLQgKJ3Tq4CTcjmTcDnYnJfciWQYntISTdKGjuJYLdxv7iWnlwPIxmTyNf5o6vgYaPNk6IY0ASk+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92CYP/z3nQQ/CFHhL6IdXpcswu6JKSihE/6Idb+EzqY=;
 b=oZ7p3hMUw+UUwSQvv0s9ryg5P4YpKTLNA0L7I7qXZCTpglg3cwlviTfPrrNcsdB2YzTHdUJmRqXn0LJWh3s2KvU+YJ5QFTWdFYbC1jK6u7JP3d1EdPVU3pPDjvY+nKdd3GzweuT2zuWjlymRmzSRqQcj5vgVV+7whelJbmVFKiUGy2PPSSFjwAPlEAUHuy1el/tE9Z8bLz8OdMQZVT0m/5NxwESpA74o5XCEhWnJID3soPL9wDu5MajC1wuDybquAZuT6035SXj/+uCJA+hdP6Q6+76WlsuBdz0wObBcf4Y46XcOR4YOFUBCx/3aH5diM11Y6Ccph0dEotoe8o0amQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92CYP/z3nQQ/CFHhL6IdXpcswu6JKSihE/6Idb+EzqY=;
 b=oFu2Jiow7bz3OGSpqByaVUPlFwSAd9qNiAAh1sF4LBFAW1o8Cen6FZEadiSApK1X6GcxouOp0Y0UyMzGTtE76kduLAfFem+47sOTktmWLqGp6YjEJlkLJUKqH+Kot4hDh8Gjx9Ha5cncVYM+PYL9uhKXGVnrTDXEIqnth0onCCf8ZO7tM+httcACuaGje3lVYBiHRiIEnm6MUt7JwTlws/VKiUgj+o8QzuxZGc5CYCfzPH0HtLQUdtiOGN9nbnqzFHUeP9jsaU0Nhl4Yk7A7jN46+5xBUA7begsMY7wlyoiyF6SntkVrIhBddi7TmVV7lxheG9DhgHWC3ZvWOa+XJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7545.eurprd04.prod.outlook.com (2603:10a6:10:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:00:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:00:41 +0000
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
Subject: [PATCH net-next 3/5] net: fec: remove struct fec_enet_priv_txrx_info
Date: Tue, 11 Nov 2025 18:00:55 +0800
Message-Id: <20251111100057.2660101-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111100057.2660101-1-wei.fang@nxp.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf841497-865d-426e-982d-08de21092c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NoNNc3avm/w5lSupNTur27gzI2qZGsy3kRoDexZzfclJ3nZsqK1LD79HEpjC?=
 =?us-ascii?Q?qa++mnsj3tt6TEM8Yorfoz3IaACR4ZsPfsm8Sx1LWYTZGQhH1hn3vPMhiVQO?=
 =?us-ascii?Q?LL5IF5/CfSFVCcIu4uMfT3EWYvBPkatX884aAqIHZGH9GXatc063UG/xhS8Q?=
 =?us-ascii?Q?eD7X4GhT5G20+ulEOlUGbL//7mQzYdYPaNj/GJL88jfYgnlC1IG+of9z4/Zf?=
 =?us-ascii?Q?J6p5o/OX5dxJ2ZJxFZ0Dgzr7UmRiPb1FG8pwuK/8WjfXZSHm3ma9Lcgmn3gh?=
 =?us-ascii?Q?SU97X65IjfUdB54C4gP2tH8bikiq25FNMgpdq4yFMH40641rmFbCbWCORFsI?=
 =?us-ascii?Q?a8hg1TMJjwer13jJCL4/4iorc5WYOesx46VBYyvYdlBPnhw46oh5LhWbW/pN?=
 =?us-ascii?Q?vQmhDWvVcn8JuD+4fs9XyVzJVfk8N4+fG7j1NT7/ZO5nK6qWGC7Rgfiv0z8a?=
 =?us-ascii?Q?zTx9whoUNhTQB5zmLxTORKyVRQYuql5mkT4RjgeeNmV0XO+VyVD4BaN0FSPN?=
 =?us-ascii?Q?yoPTcAPJDb3E6X4jIGQY8qiwwi63+c7VvmhBI/yTlnzvsNFHj1p833tgSmwi?=
 =?us-ascii?Q?iLdlvs64V7d3CrAfNn3lBHBlQ9xu4VyRKVD7L958WbbphGiuBGiKhRi1YsLO?=
 =?us-ascii?Q?tQfDD+fAqiQlrTPy010Eg3SWSgSEXgBkrxecdOf5H4hKV5evHC55kQp+8Pnk?=
 =?us-ascii?Q?IZlfZsOyPuSpbAcxnNzrqkqEpWXdLM2eTC2SZZZ+dwbNQbWVrVBRhOPoth5Y?=
 =?us-ascii?Q?Ad5P+FMGzkaefy5YHzgU+Ee9Ao/B7RU8eT/xUQYdfOHxF89ba4bnkf0ljhAT?=
 =?us-ascii?Q?9x/4y8qcRt+/TFiL6nxKOEtOeDYu2NUgTSeSK04efB5Xb4jKff0fAkp3pkS5?=
 =?us-ascii?Q?aPT5KvtCNgKXUkaKcRPreEPEOn4KtAoSKtEJUmReuE478mFmCTcAs65wqrOf?=
 =?us-ascii?Q?ksLiQBinyQWSuRjRbthVc0u8TFwlL1H2Hks9eprQpdPeGPwhH11EhzeFVrVx?=
 =?us-ascii?Q?fxrlpBc/6McUpU+edmDeBWoTxnJXtdaYGJc0sUsuzA3Vq9KXg0ShbfN8OFfx?=
 =?us-ascii?Q?oP3oEAF6D0i3MczMH8R5ameJ8XXN6HLsbghaLlWYXIVguWJ5Upr5U9VI7yR+?=
 =?us-ascii?Q?8RkgBSL0Y7MijWYRBZDkDQ+tg/6paqzlUcsZ53h2yhDCj28Rx+mVynGpfADI?=
 =?us-ascii?Q?7alkr2JHCq1jzM7dgr8ZeNrDCvvTVPM97gWCpgZ1HoeFLCnsZ1v19ci9UdwU?=
 =?us-ascii?Q?xV1dWHjExBRX5NDTr0XdnCPP7URGLn8n8FnLXXAhaoM6pPAimKRGqQaz/6zZ?=
 =?us-ascii?Q?Xv1aU+tRCjdEooZZqutCJET7cfqIcZKQrQ3avm9YJluucPgbtRMe+sjn+jBL?=
 =?us-ascii?Q?jhiCC2YayJHMB1FMYE27rMY4htDb2u8pcufsvYkAjamAtvus54a9szUCIKHK?=
 =?us-ascii?Q?LRMUqU7NhU6j/MKCDDn8I9g2aPpTs4a7MDZy1sWjpPUukpMp+WYhHihKGNA0?=
 =?us-ascii?Q?IuVKQye5OycTBWyAgAb4hNPhCgnqnDPJqsnm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sf/d11JYCmGkERwD1eA8Pm2U3wsSwopFR/egFWAeKqEz5LEiZvv+FezJg7Sg?=
 =?us-ascii?Q?elyNhDzm1HF3Hc7j+woXWfjvOpZtwq95iSs36NJNpy++VdGsX0Rjt1sc/Xe4?=
 =?us-ascii?Q?9d8R3jN3jSeLUdBpwsR+tiNHE1jz2KcvxBHChZ8cXbjA32ahPtlIzXdGgflY?=
 =?us-ascii?Q?z9kw7t+CEBE5/J5u595oHQ8JTBcQb4YpIM7R52LBCQeFXdu16YrLrmXoFU1l?=
 =?us-ascii?Q?czkzuGTOMSVLHKPr3XAl3xcnXrGlsx4NRIyGDccDg9xoleHTf7GPcFLW/v2S?=
 =?us-ascii?Q?f74OyNNbBnxsTbY078ku1jqPiTcnwvKHQJfuAoP90M4uUm2rpmmz8SMDA387?=
 =?us-ascii?Q?SipSDUNT3RtQn0O2Pc8GtaFRZlKp5VyJzPFdTH/WQ1bvHGn/cYvCAuRqkwu+?=
 =?us-ascii?Q?WSN/JbO3+3cODuFBQbIRGO14uN9opUUCj1aAxw1Fj5r25m7Yvl0nmLWxY2K3?=
 =?us-ascii?Q?D5Bh3hNjMLRWEDrpRueh9pZE3fhLX4pnjhAUyd9RzzXcJMh37rPgLllZdEqr?=
 =?us-ascii?Q?1pI3xKVusZS463+nks5pyipMXnzQDD2+P9P8QJ/4uLz8ULFf9PkTQ4/FdfsV?=
 =?us-ascii?Q?hpPNca+mhYZDx5PF/gbEgSu2Zs5L+HPufp1Ar6ryhxVMslUNNePFA8vFzQc7?=
 =?us-ascii?Q?XOHePnyA9YQpgkeBbn9Aj9jyzr3PAZHRDHQT4pLu2TUGqHHwKqgdw/JFOf9f?=
 =?us-ascii?Q?Cts0f7Mu7IJNhlovMe/SFmj7Law/nIEdhB7/Z3yQNQeHbp7aZH9w5tPJ3VEM?=
 =?us-ascii?Q?GQwx+Zmbt7yFrhQgZ7rnuiYeyRnbgyH73gqsjSzKX92m0LGsn7K2MP4qvj94?=
 =?us-ascii?Q?ZnX1qyVpIPWyfhTMhd7cR1jNblivRRRz4chGMntZHKydXX8mygD44IOW0j7y?=
 =?us-ascii?Q?dyHWuh+4df8E0w6ElXtGhbG6ijhhQCJ/lAMtSmVYdOExlaRa7EklehGob69f?=
 =?us-ascii?Q?VxEbY1Dif6H8H2ciRkt0fNWG+7LaRmjd9geYsXjQ4nErgL/Lz25nW6oULNry?=
 =?us-ascii?Q?h1XlxxveM14q3oHK5XkcYCAdH/r+ZxUuoHeSh68bD9LdBgM5BSiFFzPhfSPK?=
 =?us-ascii?Q?nK8MZ9UkBuZfxB77IQIJI2N6sXlghCdDJyTrJsJz5SUCc+KLaApS4eWO4JEX?=
 =?us-ascii?Q?rEtEL19qSRBn1Xut3vVNgntgvfmHe9ERvboB8S+p2QmMSztHWYHLlllTJI5f?=
 =?us-ascii?Q?LflW4qmL5IV8NAj5qhKPK5oT8+EOBS8hYki53RuNsTASz6jFXoWnFzWoApqg?=
 =?us-ascii?Q?5SqfSUeZ6wslbT5dP6Q4ADwjBjAKuvtDFF0ImcMpGF1GVT72vyLsnQmJSW5n?=
 =?us-ascii?Q?yoz21eDRPkyGVTrDUb5+zxr91URuBu75LjZ1Czju19tyKMvYi1YuevgbFO6x?=
 =?us-ascii?Q?MX/bzONaAMY3NVpteqv04HbHc9Qy38TmokG/7aBHH68lhnQNVqZZW9WC5cJO?=
 =?us-ascii?Q?ilzLA2AQmdT1eiGpv02/2pcLIHiK82E3fvogFi/KtN8T6hGMB5fCls9yqih5?=
 =?us-ascii?Q?pfFzmuKt5mNf5P6I7nmDJkoL7j1SAG5/Wgv+zLiigmkGkGwS9dPw8Bh9s1zA?=
 =?us-ascii?Q?i0tlI5wZNoCUsodaNTeu63MR0aHMAtPfrKmkuyw3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf841497-865d-426e-982d-08de21092c62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:00:41.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hovHPskHjcsUasiLNAea1IpOYS8jLUHATNqiDkn13qsLDj+T9PgUdHp4TaOpW9sBtRUIYoSBJdeD8GysiNhssw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7545

The struct fec_enet_priv_txrx_info has three members: offset, page and
skb. The offset is only initialized in the driver and is not used, and
we can see that it likely will not be used in the future. The skb is
never initialized and used in the driver. Therefore, struct
fec_enet_priv_txrx_info can be directly replaced by struct page.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  8 +-------
 drivers/net/ethernet/freescale/fec_main.c | 11 +++++------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8e438f6e7ec4..c5bbc2c16a4f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -528,12 +528,6 @@ struct bufdesc_prop {
 	unsigned char dsize_log2;
 };
 
-struct fec_enet_priv_txrx_info {
-	int	offset;
-	struct	page *page;
-	struct  sk_buff *skb;
-};
-
 enum {
 	RX_XDP_REDIRECT = 0,
 	RX_XDP_PASS,
@@ -573,7 +567,7 @@ struct fec_enet_priv_tx_q {
 
 struct fec_enet_priv_rx_q {
 	struct bufdesc_prop bd;
-	struct  fec_enet_priv_txrx_info rx_skb_info[RX_RING_SIZE];
+	struct page *rx_buf[RX_RING_SIZE];
 
 	/* page_pool */
 	struct page_pool *page_pool;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9d0e5abe5f66..5de86c8bc78e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1655,8 +1655,7 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	if (unlikely(!new_page))
 		return -ENOMEM;
 
-	rxq->rx_skb_info[index].page = new_page;
-	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
+	rxq->rx_buf[index] = new_page;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
@@ -1834,7 +1833,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		ndev->stats.rx_bytes += pkt_len;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_skb_info[index].page;
+		page = rxq->rx_buf[index];
 		cbd_bufaddr = bdp->cbd_bufaddr;
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
@@ -3309,7 +3308,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
 		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_skb_info[i].page, false);
+			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
+						false);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
@@ -3443,8 +3443,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
-		rxq->rx_skb_info[i].page = page;
-		rxq->rx_skb_info[i].offset = FEC_ENET_XDP_HEADROOM;
+		rxq->rx_buf[i] = page;
 		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 
 		if (fep->bufdesc_ex) {
-- 
2.34.1


