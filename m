Return-Path: <netdev+bounces-144017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE219C520D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1CF1F2240A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1815C2123C2;
	Tue, 12 Nov 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E+UnMJBd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A982101A4;
	Tue, 12 Nov 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403833; cv=fail; b=UyM6FqrIrxwmMv5XjfxNNYf2AkXKqA7Ju5COkIitRDFnxOj4PFXiD1CZpkbAlGFFTje1CpAIyW2qYXVzbDvPFYr9P1WE+UOuT+JogDUibKc3GxLIAVHKpNfSI+7RCcdFB/xJ2Q0UxGuloBeeW+hyPTy5905EZh0Tugb1lJL5Jfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403833; c=relaxed/simple;
	bh=UiBA0kHLm6NlsJwRa64NkkxUP19MJ7g8Uxh5nc1+OUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQyDNmM+CBzQewsluOJwL+SB7BTW6OOhxeuRMDeTOrBi2DNfik/zwuDA/uN73B0KOXu4csUQRCCidijb+VMZ3GEZ++ZIf1BUHUueCNLl055NLryNANTpgI1pcbD7sd7CpHFRKaYbIrhzEhDWYmxgFux2cIPNEXDRSO7z9qmv5tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E+UnMJBd; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZzSXA+doK+0dCXeLW0J0TNjAxHAxbDDDUlOXYa+NuJbH5f4x++cJuv8qlD26TkZAXtE2j+k6xWePTb8bJcfQj7QqFf/4xQNZPX5G5KqRx3upqh7Yz6ZLqlikJDcO7lkaIEHVNgUNrWQ+sZSNmQe9hvJrWCKbPtUo5l2SUH8We+ubtuqLZNdgl6cqZdGAssQELclpqyj+aXVBSg95b47jEt7lAvZ6QxHJZtOgJ1jGcwYs7NAa3LVfntnFdOMBk+ab3KGlGc+L5myjkBW8PRw692gey1wUDiCIOZ95O8m7pdBDCGHMJxVW6P4tq/aZfasWrqrwW4WhhDs0HTm2NL7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNRIVuA5oKrIVX7jFT0M7Sbbqulv1P+PUqog7zFTdMc=;
 b=jd4QLlOjWtogaiSnLLF3JItClA1EJjMqUjtTIa43pzJTAfetUnDV+WHa3VWNVEoUCks+eUu9mLakMWrTVzGI/H2I47ohR9oyoLtKFuhl3CYMUIBCRJmmDBhortBC0BPuekA4nywAVVrGDMDfrq/A8yuQ+AsTkTBZuKSi+7JOPpee6hFHWOJYhuwm+8Coxoq51QB0w2dGnfXzH3BJoqweMjQQd0qW97Il+XtVx2iI65ahRYbZimiOD480OmwoMK/udwrqIQXD10n2AdyrcRDLs5vFOPbMWa/1X7INIm/4I5VIE6JK/3IEpWqZRHpJyX3vuRcKWOzYqQstV+gV956pdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNRIVuA5oKrIVX7jFT0M7Sbbqulv1P+PUqog7zFTdMc=;
 b=E+UnMJBdWJsAd+LxNtbONJtCL076r6WELgMCj+LS9lw66maY+xYPh6S2vbjtuoXj6QH4pc027wA8l8fBuRT9EKoWSGudwpnep3Kz7yNpw6VpBDeTBZBV+plxhoLj3Rg5NN7zYkBBakiB7O89LMdCotj55+4urGC+JvqsX9uftQs2O4rnVY6Fss8ZeH3e74/XcyDxtyqPk9p+cduBDm4dY9Xyi/2+wDB9BNvq5ka3MsxkIYwZDpwfBLx+5oN1YKvIGRAQ4TjtEPaEPvgZRLODumvWobxhvNDE+d4KGxTx1TH1bndld1LLv1nnRRnsiUT3KuMb7rTHGcoESSSwZNroTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7892.eurprd04.prod.outlook.com (2603:10a6:20b:235::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:30:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:30:29 +0000
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
Subject: [PATCH v3 net-next 3/5] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Tue, 12 Nov 2024 17:14:45 +0800
Message-Id: <20241112091447.1850899-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091447.1850899-1-wei.fang@nxp.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bc4d4d-e9fe-47ee-55d1-08dd02fca589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ctll0faqhqoqwpUS5zSU7a2c0fabqSPAId9rz++ypq9i7wgSBPKqhyIXLSH?=
 =?us-ascii?Q?06IT+xw7/pif+Mt56CyO25e03ZfgWhR5B4LmRpmeghOCJXhbfCsTa8Lb7+B0?=
 =?us-ascii?Q?HWOIGslEtdHqXvqREjC/sBH4OphRlCGfCz9iQgp3qO8jCWvJ2Oyolc4vjPrw?=
 =?us-ascii?Q?Jo+C3Qu+yABo0zMlhMUjcPNIOVA631T8Awqm6n5Uo6G3AjjEELlYbum1xpOe?=
 =?us-ascii?Q?OeI6oc0j9X4HINSjzuDtwtFdiaTCdCEvSkWlNggsOPlx28jPr0qW0JhYEA5z?=
 =?us-ascii?Q?2XFs/0P3PVUQTX1OezIrtwVN5AAQphmyTwVouvaSiIkRBmSjngQSetwZEMwb?=
 =?us-ascii?Q?jE0q/UllUpY+c4nWSVgAsSdUgXFukVbs2QEdjI5tiQxbInYsD8iPMfki4a68?=
 =?us-ascii?Q?3hr6agjoAEisp8BPWNaVSVpNGj4WezEAPr6o1TK2MdJ7r2RxaOBS/hIhK06/?=
 =?us-ascii?Q?rVCgcKw+To3DDpQsXMMloEMtrJfULFoOTkbrDtvr2o6fe75hdOS97NKH9V/5?=
 =?us-ascii?Q?fIC86nA7+plao+uyJY3Qq3MweWvh/4YYkFej/t7xfCz5KUMt56h5h1DvWFcK?=
 =?us-ascii?Q?mpAD54u1E7ZE2REXegY/aCMI+1jCGK4R7+F6spjdK9NZ9MwIzj0y5MIijEyk?=
 =?us-ascii?Q?G70xrqUMRRrHIb0xgzMBoF2XFb8a5cV0xWFpNSfQrIZ2r86fHqG/s/hpzSCb?=
 =?us-ascii?Q?j9NfTm82k3aWMhguue3ryC4+25xriJ8t8T6k9HVB5gg6ORVsZPdVG3whTERl?=
 =?us-ascii?Q?D1jyDw7VwRUIJmDYkuJw49+nlzysWingpNknm73/yu99LBT6CF0n5MkdmS4I?=
 =?us-ascii?Q?I9aNtr3W8aOrcUSq4L1IfyW4Vwv0axILp5ye2ey1h1JwvmnTlgNk185znpyi?=
 =?us-ascii?Q?vXPMaus5Zwpu3QFrCRyh3gbPJRdpewEIFQh7rxojc/OKhrKimjhPlmoGrBnS?=
 =?us-ascii?Q?yGhjQ6AwH9Vb3+53mHJY9Omna3NCZ6nGAXn2lT30yHTW5MFF86V0oh99ez3A?=
 =?us-ascii?Q?kZJ9p6h/4/s7Ao2j8/Pc/qhcaN5bCNfY5coblNIMi6RQc0+pOdMVvM4EGum0?=
 =?us-ascii?Q?bOaWcrEj9/xDL+S+8Nwo4V39ZGMIGeZknBZhpR+pBOOsIOdJysNBH9UFkaQF?=
 =?us-ascii?Q?R4ornHxSQNjBUPf9X/58EBwJ/2Ffib5tHDGAihgUn8vzXEVqgmLCgXH2sjqo?=
 =?us-ascii?Q?ZCJOwEW4hjPYLHp8vkluSk1Ps2JUw3KfTJ15Y7kWIi1OmyE9fJDpgg0G3V+K?=
 =?us-ascii?Q?Fq02eZYyk1WCMg5eQ3MDYuyUmi2zvarxwO5EX10qze4/nsJTVdj749Jg0Ngf?=
 =?us-ascii?Q?eSzdDSdxVg/xy9LZzgH1Ycii2awa8tdJcnaeme4CuH9F94rkerixlSOd56t9?=
 =?us-ascii?Q?MVU+lhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0XMScVvzRXQGyZ76Id/YeApZRDsvI8tD9Tr+CkbyUW2XfYLI8jvnh7h8RqbB?=
 =?us-ascii?Q?uPiIahipPXLlbvuElJvb2rXf7mwWja36sVgdP0ZWmnfixsgLPDno3Ddbl8gF?=
 =?us-ascii?Q?Gm7Oz+TP/KcQ9NjmzcOiD7/nffrRN1Q2KIczo+3CZ4xvIRAnDsrp9NbZq8j8?=
 =?us-ascii?Q?TcnR6Ddx9yQp8lyz95m7+JZqUvw+zNpkMCyqy4LI7dfwWul1cHZVoAOMFkce?=
 =?us-ascii?Q?+sbYYxFIh8h0iZhd3+rfsMWJO2aX8ISedwiHDXgQdwUftAq5km3tz2ad1w28?=
 =?us-ascii?Q?9MyUnW8XWy2Mc8A8XkF1iT8feL8k69KxtDQESjPO2NdWwkWSKIHNDKvF5id9?=
 =?us-ascii?Q?tUVEQr6zHSCeO7PRehVnxqhWB8jhql3WqsOcDbXCVt1+cVzywhABVpuOhw0w?=
 =?us-ascii?Q?ANCHDHlczet0+dePO3gHonwRsVuQVm08dUgLOtgaYp0zR/cPr/k92L5ZDyva?=
 =?us-ascii?Q?KF3XLOn5/pzY/oXSfUPL24vfMzuq0SnFQd6FIvLqu97XMtjftcCva2gs1FYp?=
 =?us-ascii?Q?ozHNNTRm4HnkYUCg33o2fXZu0Yb+mFr653WXBsaODt0C/u5qX9teTxEhpv7u?=
 =?us-ascii?Q?0b00TDX3eUwDMxScoadvoWsOttTpr4EViu+rvv44cIU7BWjd+Jbenz1OH9W1?=
 =?us-ascii?Q?G9knne7Ju+Z3O4ABfzrACvaxFN86a+mritE/OjBzfxsz3k4KN7pM7YdIZY8f?=
 =?us-ascii?Q?Tfg00CTd+jW1dYsHSn19Uwd1n33Z7VcA3JDSsIqNVnyJOpymFp1keG0PPKlZ?=
 =?us-ascii?Q?X7QodSu+8JA9QjnUE5vO1OAv4k+kAYEjuX9ojZODUbRACH6O4K/GaRcAGEno?=
 =?us-ascii?Q?kalSOjv20yIqE3ejkl7seDtmBhMNaG5i6jKOCxRfOu4mcki+Tvxm8W509XcC?=
 =?us-ascii?Q?dzZnvzIf+mAjBLb4n/FQboD3EQse3Tmzs7nocS0Y2RBHyfxsgrrPz6zCvuAD?=
 =?us-ascii?Q?XCqI0Ik2NyAeJzuPCex0wXsZi+Hp7CpJ4PjvvyaFBR+Vnjy2nQIbdDfdYXul?=
 =?us-ascii?Q?wtVOoEiW3hnQN1HfWa+Zjse1rbCq5r24P9UkW1saz68KwFNJv1cgxch6f8Yc?=
 =?us-ascii?Q?YP8KTDHjB0lUC99w74PamChXBjnsEXhlPoFHiyvlZ77uaJHtbO/axH0bkJpq?=
 =?us-ascii?Q?2AS6OzcQlRFpOVTUBpCZglJYuzcTmsMjfYgh4KLH1FTDEy8Cs6cpGN+sF3rO?=
 =?us-ascii?Q?XBlAPSj0hlPIbYUfCfm0jc8Slu2znFe+TsK+jgM7g5bllGjF9QrA5XJyr4/5?=
 =?us-ascii?Q?0FuqAU6SaQdNXsbWpgAkyd/AiTuLLJ3WBcNJGq/FeGjNm6XWcJ54WIwLbhjw?=
 =?us-ascii?Q?sY8sF461cuzxmDZd70GZI/k3YrX95B6Xvt6N3Lg0npntL9+HlEPvbfPd5LO4?=
 =?us-ascii?Q?Q88mucneX4KTlT+zf7dyiWzK06Uuf5cCxy9QvCuLUIdlwu7UY+Y8pkL+ii4k?=
 =?us-ascii?Q?//4PhDenBJsamFQAdPZVx9psC0K1EsBHvAMYfPEw5mwQHyW+EDKSxCT1LoYP?=
 =?us-ascii?Q?lJ8NJJyFlLt4btupnVAj+E6b6Fi7JcyqdJFoWnwqu2q4VzyGMg7bp5deO3bc?=
 =?us-ascii?Q?+gQvZh3OnK6WHtmC8Wi0+FJacW2OmKJSkl3hsP7q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bc4d4d-e9fe-47ee-55d1-08dd02fca589
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:30:29.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krDQ2btQbr9dOCUdK7zwdPsXuamjxQkr+arCPbVjW20pfscMnUXSrKu8h6Smc31oP76wddgSJKbwVPfN05vnQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7892

The max chained Tx BDs of latest ENETC (i.MX95 ENETC, rev 4.1) has been
increased to 63, but since the range of MAX_SKB_FRAGS is 17~45, so for
i.MX95 ENETC and later revision, it is better to set ENETC4_MAX_SKB_FRAGS
to MAX_SKB_FRAGS.

In addition, add max_frags in struct enetc_drvdata to indicate the max
chained BDs supported by device. Because the max number of chained BDs
supported by LS1028A and i.MX95 ENETC is different.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2:
1. Refine the commit message
2. Add Reviewed-by tag
v3: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index eeefd536d051..7c6b844c2e96 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -529,6 +529,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -594,7 +595,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -655,7 +656,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -673,7 +674,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -941,7 +942,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3316,6 +3318,7 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
@@ -3324,11 +3327,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
 	.tx_csum = 1,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
 static const struct enetc_drvdata enetc_vf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ee11ff97e9ed..a78af4f624e0 100644
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
@@ -236,6 +243,7 @@ struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
 	u8 tx_csum:1;
+	u8 max_frags;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -379,6 +387,7 @@ struct enetc_ndev_priv {
 	u16 msg_enable;
 
 	u8 preemptible_tcs;
+	u8 max_frags; /* The maximum number of BDs for fragments */
 
 	enum enetc_active_offloads active_offloads;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3a8a5b6d8c26..2c4c6af672e7 100644
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
index 31e630638090..052833acd220 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -129,6 +129,7 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	priv->msg_enable = (NETIF_MSG_IFUP << 1) - 1;
 	priv->sysclk_freq = si->drvdata->sysclk_freq;
+	priv->max_frags = si->drvdata->max_frags;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
-- 
2.34.1


