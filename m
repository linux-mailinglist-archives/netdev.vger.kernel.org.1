Return-Path: <netdev+bounces-151000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18AB9EC50C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C36188834C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921A71C5F20;
	Wed, 11 Dec 2024 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hKtzPPwy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC731C54AE;
	Wed, 11 Dec 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900051; cv=fail; b=urQ0oEEU3l2Rp5bt+eNQyaZAs95063IPTYkM0D4MNo30vrugadGi9pbksBG+xlhcJKrnfM29FC/6VzFpNRUoeWYVJoHZ1DfVxW0cS8fi6wSNP+ffPcg0auKKNHMCMPG740TTjcXCmD8ypElf5U2XFl1Ujb5Mm9K2WtNS6D7ilpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900051; c=relaxed/simple;
	bh=0RzK3vPXsSDop+1uHZxrKUHoJVm70qGUneKQ7Mkz9cE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0P1VLgN/Ksgr8iHaOQ2rjkQZL/3nFOZlhy4Xk/emEl5HcYwCbTrh7vJrekiM50jCsdnWBd3wAt8ANQdua1Jx0xPJ4UvRr7xHALwLMrjTkbYI8vnmfb93gwhl+MQ6YZ6wZDqSWYtlZtLCqVOchtsvkedddn1Huw926OOIPQHz6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hKtzPPwy; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIJL4qUmk7OAQpq/SIUCcOQzVpykHN4VgHmBeseZsvdyN4DGJPz3SweQhWPXPuzGYZOlP890BrCXh3Pge3oXu/UM2IICMRjsnFICNkv/Sw0ZXDrsIIVj2AchMOHSE74Qcxumyca1vlPxGCO2KZQYtpS5m+6Y19CsUQI/ZnJRmCGr6aQgVg7oWPAe338C7mgZn9G1lfn4xgkHhlZ3WrQvYTiBKmxMhCeG6BGlhgGQHsXmlZhX2eSfL/aOP6ft7EnCTMwN6ukYvxN6Xu2zuU8AG5OykRibXuhSkdUl4/MkPUpxBdPcFIFOKD1aDfqYsgfIXpWNbd+u+usUTtlaT5z5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MNH0GTv3dqSITDJ1d/46crgUBeR+xkN9Td26hYfk5c=;
 b=ZCKCmAcatFdyDujHBwAYkCocL3zFTCw5qm1AZD/X3tI1QupW3xaFzuGKJeS6V3DhfzvXB8L0lP4N8RNRqnN7ECQuYGUld4aEW3zMCaEFBHgevryXNsktvosD3Ah9k+3DZaF3bQuLxJxM4uvbGzXt0et8xhX8hV7e2U8bq8LulqJ4vMfUF1oe/qptVRcb+jET3LwepXcw6+FDLdSmeiDorQcIj+XnPvGlelo/pelY5zb2CeM88QD6ji3WzwWaRoSFoJ86VSxkTOaSCru1OJ5EkeKHxt+t6KB5qwTt0n1ZT0k0cj65wotQDBLOojWgXINgyQ8QzquCiMnNkUZ1hLy4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MNH0GTv3dqSITDJ1d/46crgUBeR+xkN9Td26hYfk5c=;
 b=hKtzPPwydeZBSxMt7aM25jGq7Df2670HIt/61eoLrc3c8dTAS3fFSRhYfa6WTJxehLPlovs5imLxTsUyYXcR+rJ8DxdjGqUxpfE/X7u9u+l46e0YaygGxqgnTDEKHxbS4LMsvxwW5IUQWF/Dv0vfDleWKw6w3D1GL0GCx784WDirH5zYVGskFs892WnKJDzwEnoxnpUSHs0TOqExAGDsIz5ZFQrTl7c3PgZQ7TTybINGUkHg0ASQf0P0pRy73kvsgmUEBk0DkBQmmBLRGDujmwzaeWXr838xefRUr2hmZbZ3sTVWbvuxA/al3tKA0z25Gb92iwtQ2ZjbpwB3JKuWHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11042.eurprd04.prod.outlook.com (2603:10a6:150:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 06:54:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 06:54:06 +0000
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
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 2/4] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Wed, 11 Dec 2024 14:37:50 +0800
Message-Id: <20241211063752.744975-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211063752.744975-1-wei.fang@nxp.com>
References: <20241211063752.744975-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB11042:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2b28f0-237e-44c1-ccea-08dd19b09af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HwGGlxdzC04H7IJLAUMiDw6m4mlAJSX817DPjF3vXdT5t3RgrXUHL3cXJoBR?=
 =?us-ascii?Q?Cy1TcYKVccvV0zyqRvkqQgL/6JTO9e05PlNs1kEDzTyfL9Kb7XI1mPzplVki?=
 =?us-ascii?Q?dRwnGr0RaGY0+l1ThwWTZ90FjUuOW724Fol1osU/I4XD9nmLsoxEwlJr4uvB?=
 =?us-ascii?Q?KMKza9pObClUb0XvM60TS+T6iRau34ZAdJqy6xeP+ydXPuSUvu6VU4akKlry?=
 =?us-ascii?Q?qOB6MUL37XMkjSPhAVMzlk4ijNh2lbLBAhy8FaHiWjWyu8IbZE22Hi49BHdi?=
 =?us-ascii?Q?qxfG5airOhE9/rJpVf31vJsYTxVPiVqaWUSStKotEPNO+YIv1yVfSMxmabrd?=
 =?us-ascii?Q?7y1g8FCfkWRSpmGb7n3V2kQZf/WekQeFewDNSmhjSz3zuqiAP0sl7tLzQ8SB?=
 =?us-ascii?Q?yUkVF9G+o6/tjuvpL5RlilBKqJ6KkWBmXANm4ns3QBSZ1+pkuKlQTa4M15QS?=
 =?us-ascii?Q?Cz4xpzI8t0tbsdLEK43z9MrfA4xkZKVEf4yLK3KIEVZ6W7LIusj5Z0hJhVd/?=
 =?us-ascii?Q?IlJVB8Cn9AUELOz6MjjxPgcJl+F4w6BXVaV4AqdTdywQtPSyzJ6+R1bh/MQR?=
 =?us-ascii?Q?MQBzX5V28TWrsUn88dORDAXbHPULkxVEyl+Eg5P7sGXl/pBr3iCbrR+QEqoV?=
 =?us-ascii?Q?hF2WosA+UfDv3ALRiqBVZjP+254bAv8pkUYg0GwPfZIP7lIKdtyV6hcu2gKR?=
 =?us-ascii?Q?9/b/gOfGKgiavdnvgCujYpcZ04gRblU3wpcKx5Ia0akJ64V3siRN7Gy8qvI6?=
 =?us-ascii?Q?n0nPJ6rryRsuzHRQ6RPgVBKkvIZZqNCUE4EFvkeVQk5I0f/PyrUleiaDKWHc?=
 =?us-ascii?Q?+B3ybOh/RV4oA84MDFD4J2WuEfDMFn2lCpFPL4wy3l0swBP12OKmhMSagqDV?=
 =?us-ascii?Q?Lc/tKOQv7MLo4eSvuVtVLDG0ZPqNZ5zXoug2pPiMN0iuUyxByc7mxu0bOdBl?=
 =?us-ascii?Q?3C4ho6l3uohiKolO9hl1QZsc7TRm9ORgR33CpCqNFWZHWuxbWD8T/cG8d6LJ?=
 =?us-ascii?Q?eKJML4PEmdpZQQgJEtgMFJTXGWnexdgx6ZxHZ9saY5JqNELs7a521DwD5jqN?=
 =?us-ascii?Q?SPKCuaaDIAi1qxXQ4MhqbIsRzk7WyDSKy/XCCBiT9DInseiOBrETQhzkhAHL?=
 =?us-ascii?Q?JhtV5evg/ClylF0HpA6W+xn/ywgWDc26mVjVZ4AAirsFSimgvOXTGzeT+uFN?=
 =?us-ascii?Q?+/seA3UqKG1Xyk7+uM46jYvCphiz1/YpgN49gdfRPPz1ZgDnSsQoEfe+H59P?=
 =?us-ascii?Q?SnJiHzSY/V697rFc5jF1DMuA0CfZsACYm/5XlpwCFI+qeHbK1IztjkvVDgqW?=
 =?us-ascii?Q?/fhfw6SnKfv32tbc1lC0An7L3iCdrCSh80JmsxwcBeV7W0skT2pa+EKDxBAm?=
 =?us-ascii?Q?F++DUoJkUAIWX72ApCgPdZm8gwCae9WOazGZJT9Dflyck2J8UotHFrAyinhG?=
 =?us-ascii?Q?cbTSzdC79pw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OLnTc4iUhBgssGbJogFgIkFj9o8bacrppo5Fka0nuyNHhLfW9bGtIuU+mlA0?=
 =?us-ascii?Q?S1SZQufhjSegrr+VzXl6bDLXQcs0k6T/zq+2aELozuhkugoK7ntGzyDdWGwE?=
 =?us-ascii?Q?n8Y/+jLQNdNEdXAreurIXWSKAmzM1rmJOiA9fDi4TNpjHesvbApPiQm/Kg2B?=
 =?us-ascii?Q?/JU4pgUWV5LcQqcXKMsmGMT3m3Y19tE2E5N41WcO4ucBP66FkInPToBk7hUJ?=
 =?us-ascii?Q?o2VRJ4Wu5eIdnJklSEM1ZmUt0s8suQiQbMREw7QQyIF3Y+ao0iOvfVlOOYta?=
 =?us-ascii?Q?nVjPohMU6mf3F97I0t8zi8/dO3fn9oAgi8AdlrHEU1ZpgKUlhoWbEi41BW/u?=
 =?us-ascii?Q?OnvZ1gCbH0jM6o9Cx+ILzcdhHLBt6fCqHZ3Ms5ZSIINv/fOdz92r7hXNDEiq?=
 =?us-ascii?Q?yH71ZUZo5T5kOfoQjVj382pXQSHaBH+8yHVwRHHr8s0euEeOcq4TLJetlh6i?=
 =?us-ascii?Q?8y9UF7IRElpWvg4IWiP03+XFwirfTrOQPP2bi3jLTrNH74VUyDu/5LCPc9zv?=
 =?us-ascii?Q?aAtLuWDe4axMtDVHZpXnds+IF436jjZwLaKrXkKh+ZvTKIGPaLa/bUj+Kj42?=
 =?us-ascii?Q?WmCtNbqYCGU5DRKl4LtPngjlIfocU74NvHwOQFAQILJ7lzw5UelFCXGWFUub?=
 =?us-ascii?Q?KnWyu6z3fkBcrxX5pTQKDB+8VI9uE0lSnaY+NPx5Dfbg0nCKEH/g+bIG828f?=
 =?us-ascii?Q?sSVTbU+tNfvpaVVA6Cg2kfeCNcC4MNXH6t3C8vkZzuEw0GNnJMuoCGOB6ERt?=
 =?us-ascii?Q?xwNbtGBYiI739Csdwrmsmg193mIyjJnEgLF8ITVI4whL4Ad/xDtzC5JyEC/U?=
 =?us-ascii?Q?3u+GYHPq3YxWZuAETE/3oWjjCt0yI1pUfYdhlCUYR4PjokNrvXvof872TzKe?=
 =?us-ascii?Q?UCuEmuoAui1M2ElPlDWoAMpOzLpFFb2KwWlZgsmVqfpV2WN3C6FkxsnxOvLh?=
 =?us-ascii?Q?MHUEJqDQUFLfiDMGLS/ePvK1EfNqySyB2TPF6SRk49nST+mxUbGJOcDmP0FD?=
 =?us-ascii?Q?FuNXIed/Gtpib4OlVgz9d/AiNgmCJCp/SjCUA3T1+sU5UTBblutE8AadGKL7?=
 =?us-ascii?Q?nMXNIQzrVm8BuyZnccX5z0u/CMmk6XodaZZ6z2xITcCrU4ZtDMIMf8wgHV2q?=
 =?us-ascii?Q?dAINurgE6XTu1p8XOpxT2b5YBTGRmFHeMAGdhMds9K+nj9EB/NFEH6Z3TnHa?=
 =?us-ascii?Q?knvyB1PqIbsq+RO2EnBGa3/7H4walU6724TM6X9X/SaoogS85/knga0/dyLX?=
 =?us-ascii?Q?DjLXGXwF68AXkPrPFcIs2jLBvagVjd2LamvRgz976j5Vd50nsKj062/qhyS/?=
 =?us-ascii?Q?BRnYuAmniaVRIFTlWXytTuIcmOEvptV5pD38jDpBdUAxhVnn98Z1ScWHHzdD?=
 =?us-ascii?Q?rKruiRmuEcw2nps833DOyA/sfp2XfyZzD+UH3pTQ2qaUsWkQ1u2lJkZkhMzx?=
 =?us-ascii?Q?uNxuDAxglwna0JmmlWYowGPqyBZZbiLCcgfxQ/Qn3yGE8945cEq0ufg9fIbO?=
 =?us-ascii?Q?VgHnjfZYvhrSL6PhZNqNAsDE3UrEZEZrdYc8F7Pvrb0PrElWm1zwqiNPCBxe?=
 =?us-ascii?Q?RsbmApKQlNqWJfASoZ09GHgegFMd5cgYK1sa5Vcx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2b28f0-237e-44c1-ccea-08dd19b09af3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 06:54:06.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugxvmvdKTiEWaGDCFxMvi8iSd0aYf/0RKQzJfIdoT9S1/3MoCfEzF+xvuYNBYKoaSsNm+laXOUZHxFjbwq/YvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11042

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
v3 ~ v7: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c278915cd021..f31b7e71ef97 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -532,6 +532,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -597,7 +598,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -658,7 +659,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -676,7 +677,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -944,7 +945,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3314,18 +3316,21 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.tx_csum = 1,
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


