Return-Path: <netdev+bounces-153233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5D9F747D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F777A2545
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC182216E30;
	Thu, 19 Dec 2024 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JAqvauOY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85452216E1F;
	Thu, 19 Dec 2024 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588273; cv=fail; b=IIOSYRj1gSbW9pWPT/6QAQ0OTZWvibaRyKFFCkmZpdMzF+qrbPetN9GXJEvUf8BAmHL8/v31yFjSz679TGya6hGp7OiJ8BN9QxEk16xbHPcGqVvJ0Vco1ftvonXvXiLZ+qSf0pgxNG6lTvi18o7zyBf20xp7zftlTbfj1BXuo7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588273; c=relaxed/simple;
	bh=owzw50wXvJ6/gCDEgmEuBA6CeY+9+rqFWQrVZCvxuW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s1SqpZao/uW4inojmRxNVGfNKvKaMiNCoUNTqzA9lOo78WiokP9HhPoejw+T/IsPMIpMUTSx37L1J+vugDp0zw6xhLNJNHL6mhsgwMEX+aoRi5klQilGFfAGY3QrguWjC/Hud+blkRAE4U2leN/eU3BdzDsrITYQvHoFDnAFyGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JAqvauOY; arc=fail smtp.client-ip=40.107.104.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqCVwBBKtoQcVvtgzn+fqqcu7sx9Yh2YtgxUsFjlidmq5aYRZ0AmbII15Nv78zdJaquHuNFS56YtpvtES6YwL5G4F7QbqV77+XxQi6OKOciJU1/1/dE5Y6BW+Gj5POzTIPZMlgTibbFaCweJtvo1W/63UsxI6FggQ2FPJyaZHo8JA006DpUYajCcmOVeDMh4EFYnmybxcQueIqSYZ9CGSowDr9tlqHlfz9Wf0L6tvvvx9NYj2JMssUkm6bU2XaOD9B9y4H+DIEbVCodh6ue/69DZnqBtr+Ex+4lWJM4o/UTaGoe19aBnph8IJFCZvR0h2O6+Wy4t0ozxiZNkd6NZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yUhNGHcqHRzh8vPanUuSoW6+TSBRo6I9QH0WNB/ox0=;
 b=d+UtMbPHlfKwTZLIhUDbClAJ6KAMkJ1oxoDu2dxurP/vJN2UBs8FApulI7zE8fqnXr04lHKNygiSZjQMtVqfdBULK8m0vesJABllK74IocY5LdrwrTebQ04Ks2dAmj4r+qoTlERn5CyHveaqwCuX89W+KzahYagRQEYmTSzOhbR94dTKIuSPLb1AGxPV0LBChP70Hle79l8tjo8OtlMnjvXy7q7JmvPsKvZHeQeBrHuqBITapOH6WQZPuVkpZP+JqiYEbjGzgEVX2mUINxOmYmDUd37fmZ3AJEn3EKpO5ysr9TcWlS1WA8900jjjeHqMMG5vjRmkxtmnrFEhtLamgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yUhNGHcqHRzh8vPanUuSoW6+TSBRo6I9QH0WNB/ox0=;
 b=JAqvauOYWsj2m2H+bc0DLStO5+/enypN4ofYsLVVz6Lq+oDoBIWSgBXqghMu6qXQGZ4MlEXU+FasEYcx98dz+e9D34d75i9ccEQlvSmWITGpBslQKnkekhPErjmFdkTPL9GkAicHUrx3QqqqQoQUXen7XCmOyKcEsaYcQ0alUtdu5FWDcDj+80kgS0+xNRuC/OqFi9gh7jPV5zzSR9r+jTkwE8kPSpF9VBdFMaeSvN15yv1cNgHBnNQWgRwNtW/NenFlh7vUfLb5scnAkncw6va0ERD+tBXjeph+J0U44kiAnmLP3YQf3Kcncyl2CDsBD/GL6/3pIVAku4QuTVSKTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 06:04:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 06:04:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v9 net-next 2/4] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Thu, 19 Dec 2024 13:47:53 +0800
Message-Id: <20241219054755.1615626-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219054755.1615626-1-wei.fang@nxp.com>
References: <20241219054755.1615626-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0107.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 1226a3a3-f73f-45d8-b2ed-08dd1ff2ffcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+l1LKCqw+ELMo/byweCYybbRAX08+ijZrti1l1bnxR2nacco4m9khGI17wdy?=
 =?us-ascii?Q?lFUszeRbR+ikoT7d7nglcCv6nlutOvy8+UGVSK8Pa8XTmWlUyVJa9IjyruLO?=
 =?us-ascii?Q?7vxBY2podTjKOc47kMPGo7SSo9mX4nWFui4xMO5IbPNoVmRs6uz6x4wtOcwa?=
 =?us-ascii?Q?f0nAeAzhu4eXvGFy9ahsQiR7qARqXPr7NBm2pLKbybFo/le4GAiuW1FOj1iM?=
 =?us-ascii?Q?Io2n1oHJkogYNKUyxRPh9QUR8+5vtDaGiFzu4jP0u6iGu5e09iuXT5a6dE9m?=
 =?us-ascii?Q?Nb9Cw6x40dt7ToR4mfD2VHkg8WDF38s1B/3ln9IfYWgizSz3mMgVXLRzw1rF?=
 =?us-ascii?Q?LYRmDJV/pZ9Up/1qeKDSMiveuzkZoR+hO5oNECmVcnmecBsz0BjmlrZChO5a?=
 =?us-ascii?Q?XTX5Ao6NORaqMmpVMyjOB+SRwgdnGbhhIRI2Wt/aMrqIC4JCvEDFx3dvuZIa?=
 =?us-ascii?Q?UaTd5oepnTcNDPZZ8+07G0mpvAu1v/T8mQjJfU8ARakhGQ+xUV/R62ESsgTP?=
 =?us-ascii?Q?OLympfHoozRLePtsstcpLZx7djOW4lQ/tvJbmJcDOFxwpRwKia6uSd0KFo4J?=
 =?us-ascii?Q?98+YkDw0gVC9fJI4tB9hn3A5OK5dnYXMGIiuSFIuPT4HHql70H9f788ikOfa?=
 =?us-ascii?Q?8ZWsRMBOk8WdBnAJZ22qRo3prGbQ1FFgTWBDRUOKBJ6KCZ7My8dVl7YWnp2q?=
 =?us-ascii?Q?wHFa/Ht/xM3lU61YvNWUg6djvrWw1ObvtAtXwDbCq14iVcnpNhK07AgKwKiD?=
 =?us-ascii?Q?tY78VbnSjogpfoHFY/EpB6ttz+rWJX2Ud62moWcB7uk+8+N9fW1BNsUmwd1L?=
 =?us-ascii?Q?xM9U+BWceg8eUf48UPB0yxczIM63CnnLXLh+XLToyqyvY+JtBqKJW8CAZTHy?=
 =?us-ascii?Q?/cWCusrRVptnWPiOKek14z4yWuEP5QfYazTK4/Op6617BEAcBhhXJJzDFlhz?=
 =?us-ascii?Q?IQdNA/NBAUv55xMn77y3SeYJdryhzZx0/QwGzIGktWxhoLkY7ApLlRz9XN7b?=
 =?us-ascii?Q?5No8rEZ9QP4+JcFsOZ/EtO2WI7X3YcE/kO9kiBhbPTEWQCy4hUTkLcWZLusx?=
 =?us-ascii?Q?I487LxS8g38PLZl4+9H7b1/veoNBI2/bk10YgFwO6awmY5gTkfWjXaJIoeT8?=
 =?us-ascii?Q?tQ9dizOVJb826s2m0ktshfdUyh+UHapkO8w+4fn5ionculPWhe7vjPSiA99K?=
 =?us-ascii?Q?Ic5fTkLdozbKscYDvwpRmsJCKIFL3zIEIM7igODxUFfizZhnrWMiPZIjiFCS?=
 =?us-ascii?Q?fpRQtUKwCga1QkI8TsYPJ4oHf6Oj7rUpSRQynIzjMr+Vi7NEFy5VJozDK3/l?=
 =?us-ascii?Q?zvuBvSAPG1OK6iDOYsi0azShE3rzSvg9zRkIe4FLPSrMn4V2hOMQ7q/Y4ZPA?=
 =?us-ascii?Q?iR7Xm5KSjEFW57lxR3ZJcob9lZNkcZjAzBjNJ+Qn6hfLEDvMXOmNSMhiaaCa?=
 =?us-ascii?Q?FuQBcPQzG8ouXfLJzG1BXwv22cbkuUM4qBMcf9zvZmQgDt3HswsJ3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B0H5qCkMkEVz0AtgRKZs1BTus6dOb0Py43r4i8HVsfNsN3097EzhponsM5NA?=
 =?us-ascii?Q?wfKmJ8WrB4F8GLQbbr2Bz5G+S8MFqmm6tCNBioIKoLvLVxn/BTFUx+fqxlxF?=
 =?us-ascii?Q?YPdnYK8GM+V8UI5OqHV9ddSzXB2iFVJyEI8t+L8y35696/yxxT79aKVCbM33?=
 =?us-ascii?Q?IJD0SoHJejlaXRjUa6USrT0d5+rzOws1e/HILzy7ZQGrLY3PRgR9gNReM9FB?=
 =?us-ascii?Q?bAAZslCREDfUE5hKCYfpnw6z8g93q7OvVJkYqA3194Yc0F0+Omzx+HUjxTVa?=
 =?us-ascii?Q?TwGyJE8YBLs2ZfnSHXfogw68LxT9LZkNkqDjV8fJB3nAi6EGaoOyEirqLvV7?=
 =?us-ascii?Q?tgUIEybC/a5yCbAlTE1pTx5W3iFb427zxVV/iG4eB3+D2s76oILac5k1jlp3?=
 =?us-ascii?Q?UWEuOZeyJZpugoLgrwXqUmHcJOOnX6H5SvI2hNlyqJ3JGLk9zJdfgW2lHBF7?=
 =?us-ascii?Q?tvJn1RXpAHPooPbeIyKmKaeUT1sLt6GRQ/OHNtD85lT5tREJSU4zmgRnnKWx?=
 =?us-ascii?Q?rc5a1VlD+79TrBfXSMQGZGgm7xwt+vwNWmUsyzto1tC93Z6ZGvlBfvViZ+4P?=
 =?us-ascii?Q?15I2Om4OdPmlvFACNR4EiNXLOW9Jes7/l2G58WvQJkVmFOIgIgbZw8QO5Wmp?=
 =?us-ascii?Q?zdxDbClNJaVczvWDLywDHfduO5e6JB/C3ADgwv/+vWj4b0UioWII6QlywIEm?=
 =?us-ascii?Q?0NJPBENOhBno5XHyKfnZN+ZXaHAD6HlULJ6ubnLhXDQ4ftKg9m9g64RjyOIm?=
 =?us-ascii?Q?nRQfljjcVzi0ylcLCAi2jst4fDuZATfhEp+1yFBl1sM8EmHHdcKguYf/yfSP?=
 =?us-ascii?Q?McJtNxJ2qLHJt4bC/NPxdB+u//ww9jzaGCFbaiNbAmfsaWU/qfW3jPFC2NX2?=
 =?us-ascii?Q?AKkqGTttaEFbDUwnkWYjGTmPgDJoDvOdN0hCgK/4qWrTs/Q2gLA3s+ImEv94?=
 =?us-ascii?Q?4y9l0qgGDT24cOKKr3sBD3Hp1xkqiQSIGoAmHVrovulAd3KdBsIoUVokuaZg?=
 =?us-ascii?Q?sHIui/M+AwPhUYV//sFF61yQIuElFIZ9gXi30b8O49bjoNihjdEr3U5r8y15?=
 =?us-ascii?Q?E523yq8b+hXqLZi8a+uhbxVmirmoCuacht449yMdilz3CErt4j4vgsYKQkUS?=
 =?us-ascii?Q?7aRpX5LIUd9mYYdzvdw21UHzhOIJ8fWY/5fA4Nmj3ArhVf0qHrdNvIJWR7Oy?=
 =?us-ascii?Q?PH+WCjDfffbzKvlihyisfN7qOeE43pOCwZqYrF3GYP4soBhCIK+NyrZ4mTl7?=
 =?us-ascii?Q?DNRU8Dw2fDQoTjB2MuXGEhXV0dlWZwOlja9lws87DhZfOXaYrVkejrqcYOvI?=
 =?us-ascii?Q?f21y0W/aSUDgrM+a5HddBWOvNMr539DzoJnjOafyrwiFU0GbMW1J6x4bhKbT?=
 =?us-ascii?Q?UITe2GeDUL0GBlEjFlSR+Ifbm9t946ApY1LeUS9bpm60xgO51NZHk0b/T53O?=
 =?us-ascii?Q?QdN2wO0AFIpVmLHrR0l+Sk/S3LfwwlcJb8e1hg1x2kGf6oNABo+GCLULuT59?=
 =?us-ascii?Q?82pjF/emnT2yyglBvwuihqU/TGrdFL7BxsM4wLM3v7Q8aObvQUWEcIhsHcLj?=
 =?us-ascii?Q?RKLXUgB6vEU8Tf07hBSE+8Pqq3ic3sp+NDxtSWVW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1226a3a3-f73f-45d8-b2ed-08dd1ff2ffcf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 06:04:29.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XXq66f+CLA27RXMTagF7tqxNGKsLi8ODn4EQnw7KSJDDITKBfcQi0zMqVJR4VI7G+insFMLTvhQtlQkZM77tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032

The max chained Tx BDs of latest ENETC (i.MX95 ENETC, rev 4.1) has been
increased to 63, but since the range of MAX_SKB_FRAGS is 17~45, so for
i.MX95 ENETC and later revision, it is better to set ENETC4_MAX_SKB_FRAGS
to MAX_SKB_FRAGS.

In addition, add max_frags in struct enetc_drvdata to indicate the max
chained BDs supported by device. Because the max number of chained BDs
supported by LS1028A and i.MX95 ENETC is different.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
1. Refine the commit message
2. Add Reviewed-by tag
v3 ~ v9: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 88f12c88110f..76c33506991b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -534,6 +534,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -599,7 +600,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -660,7 +661,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -678,7 +679,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -946,7 +947,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3307,18 +3309,21 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
 static const struct enetc_drvdata enetc_vf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index e82eb9a9137c..1e680f0f5123 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -59,9 +59,16 @@ struct enetc_rx_swbd {
 
 /* ENETC overhead: optional extension BD + 1 BD gap */
 #define ENETC_TXBDS_NEEDED(val)	((val) + 2)
-/* max # of chained Tx BDs is 15, including head and extension BD */
+/* For LS1028A, max # of chained Tx BDs is 15, including head and
+ * extension BD.
+ */
 #define ENETC_MAX_SKB_FRAGS	13
-#define ENETC_TXBDS_MAX_NEEDED	ENETC_TXBDS_NEEDED(ENETC_MAX_SKB_FRAGS + 1)
+/* For ENETC v4 and later versions, max # of chained Tx BDs is 63,
+ * including head and extension BD, but the range of MAX_SKB_FRAGS
+ * is 17 ~ 45, so set ENETC4_MAX_SKB_FRAGS to MAX_SKB_FRAGS.
+ */
+#define ENETC4_MAX_SKB_FRAGS		MAX_SKB_FRAGS
+#define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
 
 struct enetc_ring_stats {
 	unsigned int packets;
@@ -235,6 +242,7 @@ enum enetc_errata {
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 tx_csum:1;
+	u8 max_frags;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -377,6 +385,7 @@ struct enetc_ndev_priv {
 	u16 msg_enable;
 
 	u8 preemptible_tcs;
+	u8 max_frags; /* The maximum number of BDs for fragments */
 
 	enum enetc_active_offloads active_offloads;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 09f2d7ec44eb..00b73a948746 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -101,6 +101,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
 	priv->sysclk_freq = si->drvdata->sysclk_freq;
+	priv->max_frags = si->drvdata->max_frags;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index a5f8ce576b6e..63d78b2b8670 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -136,6 +136,7 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	priv->msg_enable = (NETIF_MSG_IFUP << 1) - 1;
 	priv->sysclk_freq = si->drvdata->sysclk_freq;
+	priv->max_frags = si->drvdata->max_frags;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
-- 
2.34.1


