Return-Path: <netdev+bounces-145152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583B9CD5B3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90683B23180
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D216F0E8;
	Fri, 15 Nov 2024 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nnBJpq2k"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8515EFA1;
	Fri, 15 Nov 2024 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639820; cv=fail; b=qn4+9+xnMwVwLXF+lcuMxa/1QKzzv9zt71ozKgKw/IatGz7yD7D2MwW5KEO18/+fb9Ubw6eNxmoth2ApVhkRtpiPuXEtR46tToUbTWMsuIuDsP6m/Lj0pz9DNSGeRtGN0lUnDYU6TG3COCdAjUV9u0XsYBsJgktz16fqEFcwUhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639820; c=relaxed/simple;
	bh=wvcwA0TcQ2lY7UCi56C7BFzkvVyhvP1G7nl+byj0pCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwnvskvvnZF2zptgFfMVawnsI+i0QRj9lHUGg5WNo3jvbv6HlVeASJkJoz2RjP4H68w99h9HYezrvrAhgCvIknvpaMdt3+Kr7o5ZmDl5sn+PMLfFNMz9qkpt+qUxly4qETXUdXkMrA+fr1n7V7gREvBekaaqo9lf40rEIc0gJ3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nnBJpq2k; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6/yjI3ctHocQi2G//sj42heLJ56P8CvBrPEER9AkdGtWbiUtW7bajtyYY2HA/3B8aRR8uPoFC/+WN34omCT4nSltqI8n2GvhSNoWKRi12HzSglgi4iBT/B65DDoMKQNbbvCK+cmBUUQF8jGbmNFe7yJASruKkPCuoxtlPDisjJsVKwt/7szZjMlkVW0E5L1JiUgB85gAedR16iUuk6HMjaEZ2Yb1vCRQ+kEeDWUyO6PWu8urfZMFaAtK/h4un50h0t0LXDQC6dN+Ve+Ul6WImk6u3ygb4+B2WtbvZj5iu4se+FsJi7Y9x9k6HQUSfX+iudKbb9LXxiTIpIbmdOJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI7n+9YpO7BspDRS6jV2qe1q7HOQ29KetcpUYE3oZA0=;
 b=DzOeREDQ9YoZj/N042UIlziVBEaZ/hP2lMydEb+nrkuvWdD8XylVX9Pf0QD3HxaU7kpEUBMC7cG9NmTxcG0O5BHuMHZZ8QE4R7FnupMjjf8zrxUWIEtzyd2oSmgBJuEg4qU5cv/wUvoaMjBR1FBK3EFdZ0TGN5lkMzfqkVwmKIq3iMHpOq2YAcWDCYh1pLFrQwxV5tGxqARvWNDqpUZ6HUnbHMpuVRfFO06L8WFmtZo0GrkDmYfUpgY7SpIvQAjjqRjnoCA4oT6C8MeonQ9ZNA+gklcIQcXoVdH+yFNuzik3X+1eOPSsd2aG+FAZlPo5b+aOx71DXOG1c2jZ1OcRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI7n+9YpO7BspDRS6jV2qe1q7HOQ29KetcpUYE3oZA0=;
 b=nnBJpq2kZsl8i8hOdRqq1kXmQKnOOsEBhoRQjqlFv0c9HY/FwJEVg/hkiEgOk7cuI2uhEYQ90uK9CsVZdyhvIipngYN0jY/Pr8D58170UueWIQA4KnX03HoJyqgUlCIFgbISNw/BNk95sV5ZUnHlNdmrL6aFzOA6hQzb/TDB4eViCfcJUydsQK1wlsEso79gKHQijR/Yzo99ZtBHz+Ue4w48jzAOacrNQV1dANFxcerVXYv4fFEsNUvy2qGxvLHvhLUh5cWRmz18nBOhQf6C1YkABbaXf9VnpTWuG1YYT6nIrjHm31vK8ePaWH/+wHaXTFkAKR9bJBl/sw9wiF1j/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 03:03:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 03:03:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net-next 2/5] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Fri, 15 Nov 2024 10:47:41 +0800
Message-Id: <20241115024744.1903377-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115024744.1903377-1-wei.fang@nxp.com>
References: <20241115024744.1903377-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: 438dd3ee-ab96-4913-30bc-08dd0522182c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zvvDfoDSgc0WWbeDYVGIJAkuiWUV1JTjCLnjqPjjSjKxw83FXRw5UlHDspgl?=
 =?us-ascii?Q?a8MBLiyCb6QLBqJ+jEmCL9RxUOiHCCUGibRg2fGEEu1IS7SZ3FufVmy2Y7lB?=
 =?us-ascii?Q?t0EW4L/TOOpQOhAf6b+/JNHKqnaJzFAf2X/BPjOtdFT0yBwYjcw3E7tLcEPj?=
 =?us-ascii?Q?7SQngqj7x7z5YoFG93F34/FEQzHPJiFDolDephkZIwO9Or4MobWYpi2U471K?=
 =?us-ascii?Q?GDY4WlF7wp1Xbeajwx7h8ZJh2HUwtC1qU6oNhSTCLmfHLyjfggVaS5cr8dSE?=
 =?us-ascii?Q?JnzMNxbNGEBU9R63Klz5ra7qrF/Y3t871wyllZrrJMbEFZOk2gCeHddBbKs9?=
 =?us-ascii?Q?w++G8iEtoVAS6LlXRTr5XA0rjH9JhVbWoQ2iJE3u4gxWu3Oc57bZ3duedIKY?=
 =?us-ascii?Q?juuSp6W5abmdJOj70fk02TXQnzlIt/9rwp7zZfXMS1d7vCl7Yucmu7YUmjGP?=
 =?us-ascii?Q?pYZ/H3XJyD3MeGzqtl6WF3Ze7xhzyku1cfxIZ8+obk+NoMVHZ4zHHZJjoxpv?=
 =?us-ascii?Q?5fOjx0uPW82zeP9D761hOSV66RcoBf2Yb84R+nxn5LC2zfNh4UwwR/esod2H?=
 =?us-ascii?Q?kW1QM01RrEmOUKLAh3TD1iy+AXSD1oeH4unvzlixwK9qqrddkvNhw0SNgE4N?=
 =?us-ascii?Q?wapzsE+DlSNqjnpydMF8mqHFrRs2oMsjIiXjTizlgqMDIJ49XBiW0FtUoT9n?=
 =?us-ascii?Q?KsteHUrQ7iODv72MdaTRKiqRgadLw05rNdh2ZCVSdQ2LD1JKDpOwT+IITEx6?=
 =?us-ascii?Q?clKdvtO39U3yt3cKnZXe1QYZFOCmib5b06y6VgEfWLVPIAa5utpUZsOsMfTZ?=
 =?us-ascii?Q?7nNZwwRZ9bdnZGFcgBfIdFB68KfNGVznJRqpE7q8qRNLqqm/vs0G56UmnN/f?=
 =?us-ascii?Q?WWq+JDGmtBI9pQ6eaub4sQKRh2MrA6RtDUkE66NZaS9Raq90gjF5WcvHEaOF?=
 =?us-ascii?Q?zgIJ6jsbawPw/wRz8amrMXu4zmUvU4tUrZIUV0bU3YZN93AH6cs1v9ln6fUK?=
 =?us-ascii?Q?LXi01ZYg+Ec3x1hMPLqIbFroLwA+JDi+h0dUhhi3hn5mUUg36F1JbEsKhIGz?=
 =?us-ascii?Q?AYeSG5DxWhBN3frznHMAUEJ5tZN1EN7bF6ClAYN/qU1XuOZEm8cvzABOGNJd?=
 =?us-ascii?Q?cyZuobgzedfiCkHlmBXg8cpQxosIjWLiAunbtTL2quOhwGpkKfxIS/QUsISM?=
 =?us-ascii?Q?ujGkR4sF1jhMCdNf+RFb9EFExl8RuwwP9axwp6r3am/w4fKAAQ9XkOWdVB6O?=
 =?us-ascii?Q?OcRNywV6Qdtu7G6xvoD0A2rrGXnuwxqACLYEsYmq48C93Oa9JhMEgZC2aSky?=
 =?us-ascii?Q?+MgIC3LMHpxKdUslKTObKgqrATdNVcrKTUhA8ftqPIA9LNMnU7IRrlxCMlkv?=
 =?us-ascii?Q?Aw202wk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BxCsuRbHK+1UeXP19tMq59B5IvOjySjgayhgnYFB3FQVDa0CZKNf8vHTu3Ka?=
 =?us-ascii?Q?v+pVFiuIDbUf71rSUARb48kSiydUZVjYMotMTQDaWef+haV3ZgwefSoB5by6?=
 =?us-ascii?Q?cAeh/TsjB8RIqAWrx7Qg+sfUDZ9MXYs4ZeLQg6CCW/e6lynFa3feygRK4kfP?=
 =?us-ascii?Q?u/+fFPOzjK1PuAd4jCzUOYkHWOwDOWtKpkUQYmUmx/fUC+pPJ/qjyhAwBTED?=
 =?us-ascii?Q?mfi94n2HsR8rYbr4LgkxsrPjb7NucTyf4eulGjtW/JICGlHVhEjQD7pNci9f?=
 =?us-ascii?Q?nfs8/Yu7F6QDJA57aNiIveoroESAvvpotJDPO6FnNcWhdrSMLMY4kFPrFSCz?=
 =?us-ascii?Q?fAFd2BRTAqmwNvG6d5k9WYr+vu9XJe55RWjnJFuo66b+tAQxC3kTLADkFLV2?=
 =?us-ascii?Q?UZLbIUCTZpR+8r+Z5/prwFQsLa2qGtUlSSV9NofHLMobiuyAAlHDYDS/K34R?=
 =?us-ascii?Q?CrEbrbXUxFVUUnuEFjZCo2SGDGdk2/WNbCeZPUCMsicFWgAmuxJ4xgwdX1jh?=
 =?us-ascii?Q?8+LYnxBfFOmm2uuMmq+Y4rfG7hNC4bWJqIwC9HcmVCo7IQkV1fDOZ21PKikG?=
 =?us-ascii?Q?Ds9QYaqdwHuhoivbk3TAb/Kao3VpRQr3AZ+7l3lIa3V4N/r/3pLkumuQZpY6?=
 =?us-ascii?Q?bNmS6Asd8wBFYn0jndvdVGdBv3n0MkEmX+L0q0UUffD3kx98B2h1kNVULcbW?=
 =?us-ascii?Q?WgSxK76AESmMQQKP/IMyLbag//lAjae8GKTB17noC0kDpiCDMScufSFtFMNZ?=
 =?us-ascii?Q?oGB8L4JoGECwJAPg9scEwruEnwxYWxyuQ31C4cNitOAjJhmwkGL/X0Omg+Px?=
 =?us-ascii?Q?tMKmMpMgTBS1vP2bpXmencPQnE4Hwjcg49kPxBO+sQDShwax315dJTjBTyq0?=
 =?us-ascii?Q?Inx5ufMPyNnooo+awVoQqWCUyb9BOYl1P+TjlmQZo2jDY7YEkGfxNsYFoaMl?=
 =?us-ascii?Q?Ci/3IHm8WDlJOM9wGjmL1b+14NWeh2/96D5OSxOb8mDs0YE9+6qG12Z6ptSC?=
 =?us-ascii?Q?PKANWRZLcED8Val7bdydQrAPx9ZQC9jbpkHtXwQH1MCgbDsd+bpPYnuOSQPx?=
 =?us-ascii?Q?tdwWRT0yxAwFSxE9vZFtPSZXmxHocHIVR1PdCMlSg3bNJH8Aa+Y/Kh9i1uI1?=
 =?us-ascii?Q?LIMtw9GumL+ufd/jOjf76liIeUfziAtGny2AmjbBE4uMC5cNAkC1lLK4rhXO?=
 =?us-ascii?Q?iaFwP9i/dRfl39Xusaq/zZ0/3pkuxVQcbMuUflS6jWVO+f8QhBl4kZ/1Tib2?=
 =?us-ascii?Q?f51kHQsXvChN9LJS65W2i1X1tC7uPQbg8tmZa9uB1DiEnMb7/VwmKqePbd6v?=
 =?us-ascii?Q?OOzdmWTeMDX6mIFcvQtABNWhybmElqFF7N1yfFS2lTUrKQGO1prY63ewyU28?=
 =?us-ascii?Q?6xmcqO22XcpI6KhNG6x3Tjwww5uf/oBkW8jmo0bXm87ao/xyoDvjXBj7R6DI?=
 =?us-ascii?Q?VqN6vA00RNei045XUHKU2fg8+uwMSqdhv02+mzLTQNKLn04sQu2U0ySkBJwX?=
 =?us-ascii?Q?KikgZsI9v0ScmF25DFkSN0GRampm9wPcco7SrICfoCfHY4O72sKz9pPDT+fe?=
 =?us-ascii?Q?7kZF5tr+MEq2noMVHZxLFMssBDeXphSk0zkURhSI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438dd3ee-ab96-4913-30bc-08dd0522182c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 03:03:35.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OBpKfiQtfSVlMZqlJc6dgLe/q889FQiLT4bCBDMEXd/stnMQ8PJERJKiO43YKlOINSVNXhYcZjG4EV/h48R5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028

In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
Tx checksum offload. The transmit checksum offload is implemented through
the Tx BD. To support Tx checksum offload, software needs to fill some
auxiliary information in Tx BD, such as IP version, IP header offset and
size, whether L4 is UDP or TCP, etc.

Same as Rx checksum offload, Tx checksum offload capability isn't defined
in register, so tx_csum bit is added to struct enetc_drvdata to indicate
whether the device supports Tx checksum offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: refine enetc_tx_csum_offload_check().
v3:
1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
skb->csum_offset instead of touching skb->data.
2. add enetc_skb_is_ipv6() helper function
v4: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 51 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 +++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3137b6ee62d3..eeefd536d051 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	switch (skb->csum_offset) {
+	case offsetof(struct tcphdr, check):
+	case offsetof(struct udphdr, check):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool enetc_skb_is_ipv6(struct sk_buff *skb)
+{
+	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
+}
+
+static inline bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	return skb->csum_offset == offsetof(struct tcphdr, check);
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -160,6 +181,27 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			temp_bd.l3_start = skb_network_offset(skb);
+			temp_bd.ipcs = enetc_skb_is_ipv6(skb) ? 0 : 1;
+			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
+			temp_bd.l3t = enetc_skb_is_ipv6(skb) ? 1 : 0;
+			temp_bd.l4t = enetc_skb_is_tcp(skb) ? ENETC_TXBD_L4T_TCP :
+							      ENETC_TXBD_L4T_UDP;
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else {
+			if (skb_checksum_help(skb)) {
+				dev_err(tx_ring->dev, "skb_checksum_help() error\n");
+
+				return 0;
+			}
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -170,7 +212,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -591,7 +632,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -624,11 +665,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			err = skb_checksum_help(skb);
-			if (err)
-				goto drop_packet_err;
-		}
 		enetc_lock_mdio();
 		count = enetc_map_tx_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
@@ -3287,6 +3323,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
+	.tx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 5b65f79e05be..ee11ff97e9ed 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -235,6 +235,7 @@ enum enetc_errata {
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -343,6 +344,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
+	ENETC_F_TXCSUM			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4b8fd1879005..590b1412fadf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,12 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_start:7;
+				u8 ipcs:1;
+				u8 l3_hdr_size:7;
+				u8 l3t:1;
+				u8 resv:5;
+				u8 l4t:3;
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +587,10 @@ union enetc_tx_bd {
 };
 
 enum enetc_txbd_flags {
-	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
+	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
 	ENETC_TXBD_FLAGS_W = BIT(2),
-	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
+	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
 	ENETC_TXBD_FLAGS_EX = BIT(6),
 	ENETC_TXBD_FLAGS_F = BIT(7)
@@ -594,6 +599,9 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
 
+#define ENETC_TXBD_L4T_UDP	BIT(0)
+#define ENETC_TXBD_L4T_TCP	BIT(1)
+
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
 	u32 temp;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 91e79582a541..3a8a5b6d8c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -122,6 +122,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->rx_csum)
 		priv->active_offloads |= ENETC_F_RXCSUM;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


