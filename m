Return-Path: <netdev+bounces-142644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC79BFD1B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67751F22BFC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37091192B8A;
	Thu,  7 Nov 2024 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YQ4UzU4N"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43631922CC;
	Thu,  7 Nov 2024 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730951649; cv=fail; b=RwTiUqy7+pOTDV1jZBLmu7IvXfyi1+7Om1E1cmVbPPD6/Tf34yMsu+fBD8nZlgD2EA9L3WX1xNfDdGhsvbEDE8rt7Y0sXaVMuWZaO537L5OSlxbNa4MTVVZL1qrtntO1pyOPHsOLPPPpsBBYSZR96AuYScdhHBU8Mxr5t9oRE0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730951649; c=relaxed/simple;
	bh=kWdRpoAXi4NBpxy49iB4UBzELwcCJ584DBJ2JoSTvow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKaIX7SSgtYPoFNOVvSd//T6wNjMZf1WRaVg9tCYMV0DtERj3MFL1zZBjk7ZN7OkUhfdznqEZx6YocbdrGqo3F8tdwrgxymNWyZmXtRgIalPxEqQioKZzmiYWgtPQ6+j9YKb+pK0GfsAzQz30fK1RD4Kyyr0Ov9DXsH2iNyizKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YQ4UzU4N; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwLkmYzS8WDUdEHai+hWPtrzpoNbdK4xTMBpLJzZ+gYYEsgtKZ5cjzL5gIdmrgzPHMaQVrXBEFNnAkS/1DABfoRzi5rGelSc90+QKZwSX+NLXKsw92Q38CCREbtXUMqi/wQAaVQjpjIB/4B8iCDCUWMxSpmSE7jA1qTtZ78B6QkNrGADTWN5HMAOEzmyuePjWa2J8JAvZ2CHO1wznfObFysco7VidnTxrc+wQ7JFY4jCG8d6Cojnp+aWCQViiXLz/CMZ++iqtPRdGGtUBaKOIM09liM5AmA8LtLBP5qqMyA/zpXCi5ySo4puC9mavawS28p0hrZEB78o74QZnffYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgnxCjX7eNR9ErGwGn971WROAL1GVJX1D+8L1Pxb5vw=;
 b=w+Ei/jMDeaFqrvBb5Cw0lmfPW4QNHeAl8nl7v4UA8yBnB7NJdPtrJlzihdRBbw191WOzwfEF0Jnq/AlOm9M6kO2lpXRjcdZNHxkrtz7YGGNVe/OFJqoyFK5kwuunFj6nHMbWdem0H9nArfHekTuLzvkg3XfVNozCIQeUDi65hGQ39nfX25A0ldpjmK7aD3rJOpYso4bl/KydhNekabj1wHLokEQjN46ARNUeZcGiewDsUb1n4Rhmcbn3I581pLgubZKqdxy0vZBbz55TFevyn9IRZTHRxbt9wuZKZL3FU/TMLJK/yme8qTXqMv6u3+OFFDe08ImebDu8EPvFrLZ5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgnxCjX7eNR9ErGwGn971WROAL1GVJX1D+8L1Pxb5vw=;
 b=YQ4UzU4NfdxpDI1qxeIbeQv0l38RdXngqbMN52bbNbcOsD2Gf74EOC1wNGyF7OLPde5WSuYnP82Ra8rGLc4plmAYa6PquPeToyVqr1QYerUmRVykvw+ba42Fw48REkg4Hcl+uqW9oz9KgcQ8iqFcWbMCRvz+X/GYcAjGupqCAor0YERL8YYI93QTwcF3bVRHdDW3D2xxlm2IFThKZHcMFfTf5IdsRPDXuG50hemfGAGzAET1oTJ71sEbsOu5v5TRL36nCmtCuQBvqEpE6R1zIfVfvU0ZCQyHzwNUgdA3C4/qvpB6lCBvo0SMffYdO/BzmTI46WsVYf5d1NrxxYxvcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 03:54:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 03:54:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 3/5] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Thu,  7 Nov 2024 11:38:15 +0800
Message-Id: <20241107033817.1654163-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107033817.1654163-1-wei.fang@nxp.com>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: a10f55fe-bd6f-4508-4d8c-08dcfedfd1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?id7Aj7gDknZNh3+soSevB6gJgvAIBpHcKXf8Um7120mK17b3X4ylNo/dYC3z?=
 =?us-ascii?Q?x3/mwKZq0+tnisLT+YdhgMqu7JCy4yyViPQRK0czuJg7x4fkAY5eKBQ8SVoF?=
 =?us-ascii?Q?+SKYGFfW44lipBRUw2Dv63+YhBQC+ShdK9+30yvDK0tP9nC3X4NaVxPAv9vC?=
 =?us-ascii?Q?k9ncRVKhxBH/vnmbNBSptJCqivb/7KSgHASjOaschlnuETFBm766VqAzAgXk?=
 =?us-ascii?Q?iqVrMpTNbzjD/FiO0azdUGaBfMwpOjXHDIB9vrtOPVNOpxqaJfoPpDni9SB7?=
 =?us-ascii?Q?g4ANYKIVTfJNy9ZAiBVxxeQpKbGYMvsZfi7usRtGcN7I3qrqmpm4Mm+pzod2?=
 =?us-ascii?Q?/nj0U44x2ExcdWzGTCJ5JDUHSRYX4Y6EguMXsrpXEXv664nsC4lGpQu2YnvQ?=
 =?us-ascii?Q?4Ax0ins0DKmi2Bobq1GFCfbPOsM4A214k3kZ+X+R9Silaohtc2uEUvqimgaw?=
 =?us-ascii?Q?tqSKeVR1zq/R7DxURgVG6cYDd2gN4NdoCfZwuTczO/SzBfp0qRIW5xeBUZnK?=
 =?us-ascii?Q?aHVeQcsZpyRUG48+Sg9DHlBaj+AduANT02G5vzGjtLt+CDXHf+3tFNF+FgbO?=
 =?us-ascii?Q?vQ+/GaH4cnrpxplpDFueb/Uj0MP9afLAf73Mp+QdrOQpXULuy3Xm6A98v1TG?=
 =?us-ascii?Q?F017XBrfR7gjA1UL1G6i5g4ioQTeoplbvzm5vi+HQU13IfBkzEechs41Z9Xy?=
 =?us-ascii?Q?WvHBCXbpPGyUHQKIl+oRut5MXNlfQ/2Y9YGX3hwH/RZGLeWbM4Rnt/jIKuEp?=
 =?us-ascii?Q?h81fUeZj29y5Qo5FdVp/zwn+RYBv8CFwBvVxGSIWdjcbvxdNjlZHto9TryDb?=
 =?us-ascii?Q?gORkz3bO5Z6fJvkfn4Rk0FEC4RmnXMsFX4kEldUcO+EAnw1PrvVGcp3pW8XI?=
 =?us-ascii?Q?/IFImqQ4n0zoyI7z9+0j6FyMI01ZX3oVrmA5UFu61w8JEnWxgGisgyZo0fBC?=
 =?us-ascii?Q?VZzoa6+ckXnRDiYo9jO4upvdsC7DqiE8HJ1oWjmGFMColTLRYnSXyeZHCrH1?=
 =?us-ascii?Q?e33kxIHuUQdRp4vGPbqQtWgnUaKK/qKme+JtGjqKAA4H9w6snyzde4JztV5j?=
 =?us-ascii?Q?an1JJ50eR39bPt1yU4WMkXKNGTPjgGcy0i/HATa47Mv4K1zFXOiGMEsjLeXf?=
 =?us-ascii?Q?RgYXdOBa4lt3TtHkROBliPyYST5DR/dcmHBqyVcMM9MGPI2VL1+LnwP+rRLZ?=
 =?us-ascii?Q?tglMHswWXr3+k+ZDqPu+Ddx44KK3tM1x5X0gKTDhWrBHxvMl753QyP+sABE4?=
 =?us-ascii?Q?CRp0OB2HbXp+8fdanMdjztsCdQ9nlFdQ3BzFZMMukPWwYqFhsL3ZLM0T5M3s?=
 =?us-ascii?Q?0v8B4gzqewYXwzM/R0Q9cYkZRJnyKSTQIi6XbTNDec0qYD5AYE+F4MXIcSP9?=
 =?us-ascii?Q?dwaE9Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y37c/yJyjWD3t+yzaS+gTfreYIRqAAJWGYaWgraP1d1rRPA+LyrFm20k9SRx?=
 =?us-ascii?Q?gCY+yAz4eQgPHwWuscQl36x7U3fVg2falgCSRy0flgdPJ8iHcG+gr6nV+Kb0?=
 =?us-ascii?Q?5OST31zHU64Hy8pzPJFmdMdYysA5WSjDUJh1Nrq2vV+C1p0AxwE//4DApI5f?=
 =?us-ascii?Q?pCXqVAzQ6F3qG7rxl74jVwjNbNJo/v5qrdR90aFvQMT4YbVixNdPMZ0FT7T6?=
 =?us-ascii?Q?e0eFVdWvuZWrh4codU28P22JPY2IykUnktEnthioF8shWi5qAY8pVIKs3i86?=
 =?us-ascii?Q?wyQ93jrTsNONF+GrIQwem9wocAepiRSO3RGro3KvgrT8O1bvlBXrFzFHMSS7?=
 =?us-ascii?Q?1PiFmLkHtdY9LoFa09+RXS/JIii0Zsxx+CODwYzLAQ+G/1zUxu3MJUOqgBjG?=
 =?us-ascii?Q?Lf7XJBpVjciUhoOgXgWxCpHFnuj3WJJ5dw92P+aRYnh/bTz3vdYya1FYzFCt?=
 =?us-ascii?Q?93tNGqGzL0jNs2xdHvRxxxNsj03wVAd20hJWEgWJpQxLg0Gvf8NFhLqyvpMC?=
 =?us-ascii?Q?Mz9J92SIlbVrWYbPlLirrHW4+7/4C8VJmazalJAoZnKWERxuJvYPhEAv+sPV?=
 =?us-ascii?Q?eg7jU/B6SQRS1bHhOq5kYoUgKi/vgiYUplMrnEt0iCE3Ddj890+oRO5LxfZF?=
 =?us-ascii?Q?DwLDrlIpYKOYlka7r4x3ce255TNXq7l2toqmtHo4eF/14UGH82QmLPSGXOd3?=
 =?us-ascii?Q?SRTyPgWBFdlUi3obpHWhUDpxWTdwmtCw4bPXrn2FO1BPCQH3QFf2jC7baw/9?=
 =?us-ascii?Q?d9WGE73VB/nzvpIyagHfH9AC20pTU6xR9RiQU8oPlEtFKlFTXu6nF9Bsvsoe?=
 =?us-ascii?Q?reJQZ4rDlHavgeAg/kGhye+Bf5Ha/29g0ibjXKWqyouXUE4Po8vTR3cK+Y7d?=
 =?us-ascii?Q?tcbySZDg1QiL8IH7xG42Rrm0AX60ERXUzGeScj0DOQFNudE5OEWAiXS9TJEE?=
 =?us-ascii?Q?AhysB1mhQeKBMgBPjywLa+P49YIPBHOw7skMoI1llXUq9KE9m83mOY35rq7+?=
 =?us-ascii?Q?Alhwitgn3m8iPS5U4OeIqrTukzyEQ7PFgtmoVhWDFNFwrFlHHgL6EFzR2WGD?=
 =?us-ascii?Q?L3x31Wn+Kh29DqOpJBwjZihG4T9Mgyht2kEHV6wedx+5S5s2VSQ4EVBfR6jA?=
 =?us-ascii?Q?WNAT2PBXR9fs+hmSmj0EzhvDTl8rm8z8RRl2AVQhFeyIfdbIM15xbE4DWuXu?=
 =?us-ascii?Q?x++PB2wNBBx3LOLZ2ZCQ30TYMcqXkZJydRJkzelNQbeQKii0Wez+c+RDCdgr?=
 =?us-ascii?Q?FaeuqVqBsSEbBFPktJDodTd0gegqcsIEwMVAjnpeCpII8Obhc7Ok70JJH662?=
 =?us-ascii?Q?6c59kyX+AOhWUPr5dngHwKEqMfZObPeYkckJ3GxteM9KIRFfY8a3CNjiLvwG?=
 =?us-ascii?Q?cz6TiKsIkTJSSuDq6Yx9Z4J0rkgOEdCP9WkuxWmMaXBX5J9t/GtQM3YjjubH?=
 =?us-ascii?Q?8H7dNzqw22FY9u1fo+M8v1qO8ds+eA17TadM9tLpWQ0+HsVH/5I+wvN8SbBT?=
 =?us-ascii?Q?ocjinSSd64Xmj18kss1fOeHe3EG8JrPoMeo99mdC66Y75XFFl7gES9mu4Fp9?=
 =?us-ascii?Q?V7EvSMX3EpU/M4UmiyH53nEZ3I/BBuKKjRaLbnqX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10f55fe-bd6f-4508-4d8c-08dcfedfd1c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 03:54:03.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20iKrzL5VaJlSnaDjpAcXXuWQPRB7muyKA2CfE65FEq/Ibvh+1KnABoJUsN4IJCosT6gqsxL2Wg50Ep2Ucc/Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

The max chained Tx BDs of latest ENETC (i.MX95 ENETC, rev 4.1) has been
increased to 63, but since the range of MAX_SKB_FRAGS is 17~45, so for
i.MX95 ENETC and later revision, it is better to set ENETC4_MAX_SKB_FRAGS
to MAX_SKB_FRAGS.
Because the maximum number of chained BDs supported by LS1028A and i.MX95
ENETC is different, so add max_frags to struct enetc_drvdata to indicate
the maximum chained BDs supported by device.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index f98d14841838..b294ca4c2885 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -530,6 +530,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -595,7 +596,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -656,7 +657,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -674,7 +675,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -942,7 +943,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3317,6 +3319,7 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
@@ -3325,11 +3328,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
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


