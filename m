Return-Path: <netdev+bounces-157646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55373A0B176
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8067A1DE8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA6C2451CE;
	Mon, 13 Jan 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A4878ppj"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980B2451C8;
	Mon, 13 Jan 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757644; cv=fail; b=QzacmItIr62ID4Pn5qF4fqymtWJe/LRfUIRMzxQ0neyc5a/kHv/CaYpyoYikEi97K0+y9okk90E52Me6C62S6DxyDl57095JTUJlJ34ch59J+CYR0fF65KUWb+XOR1heuNIK8cjqm6pb1c3HQ0T3XhQOKIwB4z/K5oS3WLZfF6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757644; c=relaxed/simple;
	bh=JmxllbqFqcMPKPYI+iodlWFUvaReO8XYyGUzca3r0Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9vbfkF/p5LCwywvGxPng6ue8QEUF0uR3irDnDwnk9k9K/b7xyPLjb6CTgzv0InIlpAT+jAhyeEplTE9+eZWoPEK/4I9LHTR64ytJCKvgxQdHMRnsZEei8fhsBZXKsCqgSskrVDE6D7T6hfZwX/oUvFOHN568VD47W2tOMhPCFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A4878ppj; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Itcyjv4lNisMMzjI9O5R+E40JgdAhtj0thGcvqGJoZoDbXhKIxN27UZIqUUGfcOWekuNP6Xs/DgmDfkti5jMkZzR4nup85Yibypq+YdcXPGW5uNQXj/Pjm6HZoX6AsI6+sVTGKeQjrii968Ezh1pjWvazmfCCg+mQdC0TNitiTHVpkfJ+5jp0VlHruLJd9JPjJb1iG/IYC5cn381XjRSnBSXdKgLVT6niCYqTvwucxIRLLyq0+OA3efcpcmcqQ/M4xVNiTWko9+zfbhc4mwZYZpKowkvcJtHA9NmYf2MNE2lNLOMi6gyt6/uPmAgIS+MaqtumqsIji6ztyPAkw2UzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvCzdnuJIE9/JlCNRGdk+TwR0dWiRgIn06L9QmIyikQ=;
 b=FJ7SDhYErgSLwgHfRYFb5jqPCcDxvUcUVbCiz5BdyAYxUzdAgfqTh2wIZhQ1uABrlSfRJkvc6jb0FFVQ1J5N69atRZssvykG4/CvEQ8qIiQyVTlQNVX2WsGj18ep7hBxxMkfknNH7U8q4qHccPeoJVSqtePSDm3XWo9Y/FSf9W6COAJBQ9xqzTmhlgVKfW3EeRhk2hwhblKDK37j+jg596rax9JVV/4JOMzAi0dfpaUgn3jUdB+KwSr0tIQsSZbfiqQWve+YNt/ie+zqcFnd7B5expgRWfr9BnUxNJznnhDurtu1Z3h0EPobQQqFTi6PDp2LkpxSCHy2r8uy/egpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvCzdnuJIE9/JlCNRGdk+TwR0dWiRgIn06L9QmIyikQ=;
 b=A4878ppjhpFoZ3AOCa/Nbgwukj5FrgketedLY8SVLuLnVKcVHy4UTC8GgtNJYf9xCOmdPXxBcW1ssJWFnPZKQo3V2r12A2G8UTxrTA/GhHY2lrTDgVd/S8B6e1sqk7xW4NKL2SvdcHAI0xTnBCaDFIzCorgn+aoRtQ9M0j5LBlNJKGJ8DqvJlJaAgvEtixA+MQyg/z2E+a4jgEpnD75abrJYzOfi6ieHOB3RhxWxobHrGsDAi8w8IovZ64P/SXBXutKGX7/JBPkW+DiotuxsT5X/KN9VGow+SY66RG/JsBiPlNYAN1peFusSymfeCInMRff+ATzYt5YjPWfwTz24YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 08:40:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 08:40:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	christophe.leroy@csgroup.eu
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 12/13] net: enetc: add loopback support for i.MX95 ENETC PF
Date: Mon, 13 Jan 2025 16:22:44 +0800
Message-Id: <20250113082245.2332775-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113082245.2332775-1-wei.fang@nxp.com>
References: <20250113082245.2332775-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2393c5c4-a9e2-4c83-516e-08dd33adf555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aq4NnGK81MFZ6npk9gw3Zcs4N3OalF17ve+sSVpnZi72Yw0pGZyXDoH1m2/V?=
 =?us-ascii?Q?+TQ9flBufjz7eO0QvvRhaDYHazqxOEAsSFKIEJVxJdoLGYqdTL47EgZ8gfZW?=
 =?us-ascii?Q?J5sJKIY6lUD04HJTdBA8K0arF9OunqXh4f3eF4+CZgjRBcuJlh/F6YSPET2f?=
 =?us-ascii?Q?8xZSo0pBymSRoOEBIVpjQe7TKg9N+PLd5+IQFJu1xpcXIrUAhAtlylcaJ+AQ?=
 =?us-ascii?Q?dNwQU1szvmjhaEYMOwenOxhkGMhZLu2wABd2cCuEeAulsnPLE9evqSXTfu+9?=
 =?us-ascii?Q?X7jFJbvPcF8oV4vcZ+TxyVWFKpIFYLoDm+71nH2YbNSiUJpMsJVwiF6eZWSQ?=
 =?us-ascii?Q?Ieb5NekeTDlMnnHGn+zwYd/NfulZlKW5+H9zCF6Oy47fp0/tsqHZ6+I7PXzp?=
 =?us-ascii?Q?goBmiDyLKC0Fp0c5iw1aJTNNMW+ZVSIX+2clDw6zL35qmC9nSxuFTk8Byvd7?=
 =?us-ascii?Q?OApE9vuATeWabaqwGmOHLiarB6YNkvIwQHXjVxAsaIf1gYcyieY+fYP9wSnD?=
 =?us-ascii?Q?eMrrn0Hgbu95MUepXPAImq3407gwHJGpZrqB2Owt1jMs+8G+4XMN1CsJUVLY?=
 =?us-ascii?Q?4rS/4x+/IxvqovhxDb81AtKOovKaHrznmly1MGAuMf/agirD15oIqPN8BfqH?=
 =?us-ascii?Q?sK2XMWwkIYw6DESHC2AFScBoDUaetHJIDY9wLYAgQpETQCKUF8TCw2gMdnkV?=
 =?us-ascii?Q?3brRDzATVvaf/ciswMQUb5YEVQD6kcd7zXbbaN91ThXCSsOonaLcJqdedxM7?=
 =?us-ascii?Q?1DfjYb/VDvwtEA8vhfxRMvCS3xqVtX+2ZN9PY0j9+1pdFPlO/YlsXVaCKOzl?=
 =?us-ascii?Q?4Iu9IbimD3iy0THTwuxtpgf+czf3F4AZPStoU3oiktVvXunkdsVzYv3RaFxM?=
 =?us-ascii?Q?koJzBhNitsi2Cu4N4OHXmed4n1EVm7wiRUk8Bo9Z+glxuGExpTG0Ap88jwBJ?=
 =?us-ascii?Q?U9nyAOK96Rfnc4JwzUXOcXi/qzWzg4a8jcL4IQXKlh6ymbOwwBan0l8lNXMe?=
 =?us-ascii?Q?M6qf2cYqulAkV3tbFKsYZ093l2cMlNCmEdBKMgEetvos+megMbh1dSzuwgbu?=
 =?us-ascii?Q?SsUeWeiXDhKrJ8qpqJBxJFX1JqKsCduzGWgTSjSk84eOzi7O1V0vITrRfzXB?=
 =?us-ascii?Q?CL75LwmhCP1mgY+kpDOXG4WpmS0UzkPYluZuHx0dTA6/VcQhUXM5LuDo2Rfb?=
 =?us-ascii?Q?OO5Bx7cZoiJU3lvL2y7wICwbXeUNaRkNXVty07lDGSSh0ecyzTwD9mSp+EwP?=
 =?us-ascii?Q?ji7H55RDr822zddX2o07G0daT3CyVWeVH2JH5klhz5m5RoMRNPxAvVSLNnxo?=
 =?us-ascii?Q?Dd3MGDOYOI1ZZWBuaW/d+3vh6aEC291dgWDUdNmzOyyHEHngOy2Qkvn9F9pT?=
 =?us-ascii?Q?QVJ9zXcWkhfkKuz+X48p9o0LBd7pUFmJN74Ho4lK+BCBf5XZN4YTAyyhF1Hz?=
 =?us-ascii?Q?T76DO+MExzKBfpJtUii7RHSoF6bv2/aB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnJEu3g3XtBT/kcuh/3RrPNiwo+tAzWibd+2HR7/ikeT8rf29snvGMwTprXs?=
 =?us-ascii?Q?1/W2+p2/nnS9X+4+zRLiFx6nB5pCGemg4jboVyN9/nWBMOmVhIkMyfYl9Ymh?=
 =?us-ascii?Q?ELTFO3vAuLjZuKiLNsNJfzKPyNF84CTOKtcnPZjXCE/IoH7HUOVoBZ1SkTWR?=
 =?us-ascii?Q?TIzOFDAk6td2NS2JaV3daBOzJ6+RG4XfVQlPiSOhNS7DEj0DDsBLxike9Iiv?=
 =?us-ascii?Q?EStH62UqDqMzBdCNeIW/IKDzA4IRY/sJeHgRITgUtLUSmZGIFmcyYABacUNB?=
 =?us-ascii?Q?OtU1F1KYmHSTye3DroPN7n0Sak2JOvlBzy3cKbPQBCOhPKJmW6AnCrcluLGv?=
 =?us-ascii?Q?uUqXDsExUujPYvcjPgvtKHHKFH2VAFMrJGdOu/d2IXwDgWLbYV47+EBqUXSb?=
 =?us-ascii?Q?c6uidFJOzRomn1ZGwVchence9YrpoarAOvplXIx34Cxq9Q/uwPBAv+4xxpjX?=
 =?us-ascii?Q?uHEQ1RA4wgXjosHiXP9pwBVb6ecHGDOAi8ifD3ONme0sZID+bKxDiGbSP6HK?=
 =?us-ascii?Q?86S57aovDX9WBoA3JRM0Rqr4mb1KJ+137oDB3T3sqhIsjALU+O7qyUavFh6H?=
 =?us-ascii?Q?lShk1mKpratTo32ijVVrARlqKP8RwRkZmG1L1Zn2oRUvrMVDlJWjSH1K3S0K?=
 =?us-ascii?Q?92K4vXGFWt5F7xEixg/+QAbKeHSzs/0ymBjBf0K8Vid5Ma+tOjMGFj6qs4ps?=
 =?us-ascii?Q?sQIKSKHy1XD3Zu2y69BTV2f+PJdvIiM3+Bcv+NpYLjYLH/tBlZFm3RsqoBje?=
 =?us-ascii?Q?nyp+v/LXeVHo2+CJs6D77pFOWvZKUhJ+6dekXQtTkk1zlraUoCqNxg3RyC3i?=
 =?us-ascii?Q?6B9xugD9bscfWZMGdXP/b6WQijdhcsjKK6U8ZDx/ty+oax23SGYRvebTo5eS?=
 =?us-ascii?Q?ECvOdp8OrnjCMRT+NpK6d95RYwrZmAUPpTAlQAqxZYaiY6DGubRY71aAXmqQ?=
 =?us-ascii?Q?8UQEhXQCX1V++RV5DJmUfUJqLd7GLZ+sQlz6BPkbZPQ9Xycbvj7Lu7aZupJ+?=
 =?us-ascii?Q?AJcLixO2eyBOeiQMKuhai+XujLA6s0fMKv71e4FsEE85rKN7tEsRZ4Se7BbV?=
 =?us-ascii?Q?QfvlDxCrnoiRHQ/JFFq7wD6KtLfv8CqDpIVHiPqOS+CtKAVjJPvepudlkHKO?=
 =?us-ascii?Q?GfPmI0N6f4QVBXkX9dY4iBlZzXmtjV2cqM9TxPiHn2ASgSIB3gCYO8inQDMk?=
 =?us-ascii?Q?e87b8XJVFlgawx4vCdPNtsVDCIj5GqevTUZ6QVYKJ0f2ibxr5WrGJfVJV0mR?=
 =?us-ascii?Q?rNZY+UdeaW6qUR7KjQkd2MBIh4vyqoDo+XTbpHXxWfVSi8J2Jvs/GLYVJ3TO?=
 =?us-ascii?Q?vR/KaPDz8CdXyavdsGMRtQKll6BTBrl9GaZWVTYxkRrqDFk+9g0URkd2QPmz?=
 =?us-ascii?Q?ZrILKXpwLNuuD2MHWLCGPX6VKzBtgC27EThbveDyUvpEgAxETLPo4BpEzx0R?=
 =?us-ascii?Q?kHQ5uZMFwSBXc56H2J20BWp7py8qW8ZhvF1BBu/PDm40GwDrZDfFTF9pggLC?=
 =?us-ascii?Q?3Gw4f04Nieb2rLdHPswEkk2OwmDIak3xxfZduVqRCJEKIxupU1P7YCxQB8dW?=
 =?us-ascii?Q?VoJUAyMOvZWErjZ0StvoV5zTcqah/boJfOw0/8KO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2393c5c4-a9e2-4c83-516e-08dd33adf555
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 08:40:39.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/OgzMjT7o9LMihzA9Oi9qt1k5gLvwUIlyZQXWFjK2yUOU0DEbOpKHSDqutpV3NOsSmC2JQldjuCIJHs7++9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7740

Add internal loopback support for i.MX95 ENETC PF, the default loopback
mode is MAC level loopback, the MAC Tx data is looped back onto the Rx.
The MAC interface runs at a fixed 1:8 ratio of NETC clock in MAC-level
loopback mode, with no dependency on Tx clock.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c   | 18 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_pf_common.c |  4 +---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 65e6e3742ada..948d2f796bfb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -709,6 +709,21 @@ static void enetc4_pf_set_rx_mode(struct net_device *ndev)
 	queue_work(si->workqueue, &si->rx_mode_task);
 }
 
+static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	u32 val;
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val = u32_replace_bits(val, en ? 1 : 0, PM_CMD_CFG_LOOP_EN);
+	/* Default to select MAC level loopback mode if loopback is enabled. */
+	val = u32_replace_bits(val, en ? LPBCK_MODE_MAC_LEVEL : 0,
+			       PM_CMD_CFG_LPBK_MODE);
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
 static int enetc4_pf_set_features(struct net_device *ndev,
 				  netdev_features_t features)
 {
@@ -722,6 +737,9 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
 	}
 
+	if (changed & NETIF_F_LOOPBACK)
+		enetc4_pf_set_loopback(ndev, !!(features & NETIF_F_LOOPBACK));
+
 	enetc_set_features(ndev, features);
 
 	return 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3f7ccc482301..0a2b8769a175 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -134,10 +134,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	}
 
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
-	if (!is_enetc_rev1(si)) {
-		ndev->hw_features &= ~NETIF_F_LOOPBACK;
+	if (!is_enetc_rev1(si))
 		goto end;
-	}
 
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-- 
2.34.1


