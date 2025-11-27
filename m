Return-Path: <netdev+bounces-242257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6B4C8E31D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD633AD936
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D432B987;
	Thu, 27 Nov 2025 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fnAPv92Q"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38A32E128
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245375; cv=fail; b=Nfw4Tx4bm8P3ZwlIbp3fpb9UkRBnDTkEQwcsx9qhZAXbueo1ZJXwSYvIYYK5X0v/VbkjOeQvLdvqWIuR2MCDlPr8CNVBsfmlCi0QH23Fy3O/HzpVHSN47yjkINeYpOfVWDef4OS6ciYw4Fd4iGliTo5gutxk8CM0HL2aYeMBc/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245375; c=relaxed/simple;
	bh=DyPysGTVverSOiNospYJhWZu2Wa9ntNt1cdF8YBjgzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AazxN+Yu/A+JLP+c8SRBLjU0crR+V+3+QcL3IDPlbLP0mAyVE2OpmwEJkJXkHn8w8jwhb0IuhTdZSjvarZfmlkGv2h3I+i3eD7rwzMAocfIydP4AEt6iVXFyfIMva8f8WH86hI8hOmHZcXoDeemYQoq2v9Mn0InYGv+UoapuE58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fnAPv92Q; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJURUqjPStbP8N5ryJgpuwfAdfHdZIAC8CfvXir+IYy9RSTW+FAqGEBHbrHPTwHA/oDny2C9JeH/qGCKi2VUbiarRYLQzrn2fiZkKmQeA4ykbgdXEXrwiQQxaA/QWGyRKd0WRBNDmxTYiJaYvWt4vQ26P6jxgUkYRnp0XGY+StHNwBTY2+SnR6NXDNXl5BSsFYHQ9UJYo06xB00mngFAyzmwcesvra3gLZtiLxaivALfh1WXV5jGK5SuQy01lFR1XAwLSVFhx4PveQ8s5NLHZY2X2eLxpaw2PFJpQkpA6LSJLcC83IXRLdYxGztnRzkmuEAALCI0wWKeDmeFCHkEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeLGejGQNuOlro7bdIA6N60lgvfpUmReGkwgI+8kxS4=;
 b=iuta1C640WivvtYriVCg2bpuJhPsNT/2F+Q6yDAFNnJpobYJ7ytBTz2guS4wNeNvt9kgRqjYqBp6IWqtCtZaCNCbTsLDYz7IamcIHHcQgiB03vkjgCWo3okAvjLMqnc5upyvN5gBtUs4MZ7LCSajMZyvxvJt+J+ifg58hv1RZ6RvNOsGgsn+4Y05wsfQQ7bV1qWXZmv91FVcgIx2M0EcLcl2jX8pqhH5tWVlKHfL+CowEGMIeG7r8rcYv8qerhapDFq5HcSnIclhp4XhZNBI7eWZnQcq/cLn3UP4O2MaKYNELsrd80XhYD6TmaGeorR+gCh8N0Ma7zqbwmViz5bkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeLGejGQNuOlro7bdIA6N60lgvfpUmReGkwgI+8kxS4=;
 b=fnAPv92QdYRvdKEItFWtR90DeWmP87t5DeB8LB2dk87MZuPZMSYjONmKKuI5+8SJmYU8h7dyQcVa44KWn7nHL0JseA3cX4By6/voLN+TeseIz4PZKAkDtoJl4gU/Pft7G5klVbrbdoY3i/zwRmLNkd/gdsaEAK30V4iK+Zt1ThQBr//c6TsnAOf92/Uc5IlTJ8bK6+ZYImvijKICfDFHpq2s1pduJtKTi7IyDOCDjWQNNabEiFh1nC3qFG5GyHM5Sig5j1JlmUYENnFVPZP3qvWrg6EcxZaZ+LhmARw4KLZNz9ce3jtSPUVV2lkNaSMrMPPCFdC2MHWjyx3lVpomyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next 06/15] net: dsa: tag_mtk: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:53 +0200
Message-ID: <20251127120902.292555-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d2b827-23ab-4a9a-72e2-08de2dadcee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3T+zE8+nuB4N3SAhs0ip1ZNLb9OfYurB8RawfmQFLQuDe2g/2jWF+Kd+rFjU?=
 =?us-ascii?Q?eUatWJSfbZDcYSs7r7F0L+zlJZBwdcVOYs2qEkfAgYqmtdtdXwGM9y2Sdj2v?=
 =?us-ascii?Q?9smO1t1l86Z6q/8i0fwHkaJS1dpyDlJ2E6W3FXV2rsYYnYSHZI+eouuF96QR?=
 =?us-ascii?Q?0X+OtSMaVK5uux3Zwk2tiKj3a2ASyVT+l03hqQlPJ5H2PP+TxEbohWlBNDrF?=
 =?us-ascii?Q?zcyeRmNRI58dtpBlJHlf4rq9tuIWiiiz4YfDs8wPVLF2OWwCCqDPwSsq/Yn+?=
 =?us-ascii?Q?imlPe0AWq/LfhiXixA5E+FXQVHEmMJlmSEFvBRiIuZIQ8duQ1NAoEDD/93sB?=
 =?us-ascii?Q?exWtD6J9frAoouqzeYcsujzKjw+44MfFWjgzNb1qNx6k0x7i+Jf2coP28Y5F?=
 =?us-ascii?Q?VbZgF4DabQRJOUVLskRUzWDKBYpOEVq//AsH7t+ttW9c9jmN2MHGzMhozPth?=
 =?us-ascii?Q?iJ9+PNFZEbD1pg9uGOXcQzUdgX7YhzseKK32cDAeIa9cDcT/vEuZIe02beiM?=
 =?us-ascii?Q?S0J+BCF5UX1Zng/dE2JCPR1m2RcRX5z/XGiI6IZlERw/R2aO0tnmIpzejrbg?=
 =?us-ascii?Q?4IFKZya0Hh8EvWeoCVYvX9cKQL529/r3GSFRM5cpseDWUt/RV/6j10i3tLaa?=
 =?us-ascii?Q?KIgB1NhXv+iOKVS76tClAvFPpJRcd9PrNuIa74WjwEVRR4p5MtlrRjEya8+4?=
 =?us-ascii?Q?7eUokKW/0rAf8AhjB/XHMPzmjCZIT36dakqscWjx5RNe/v2bHpJ8TEDiATtc?=
 =?us-ascii?Q?ZBBnyfLLxP1Hvl7JFesjNEGgoZ87guCO2MWAV3pg+akCrjSxorIkMTZ+jxVb?=
 =?us-ascii?Q?R0BxdhOkchTlbdBvvlUse47rDBruDREfrB0ZWnHZ+KJpvOp0synKm+uGQGyt?=
 =?us-ascii?Q?/xokHD1hZk7v45qmzcmM/o4YhIqUtQLJeSYGJYcCPr504YLWetgI9gpiJio6?=
 =?us-ascii?Q?DHNwknDwfUVAaNKLHY9/41kDQzfOIaClaTxMROkFDiFcKFxCW2K0/1z1jlL8?=
 =?us-ascii?Q?doFSMlZVK4/cmK4j2N2BGZFbZRzTSewbLPDy4QbuXEM15IlVetct9TkNbfay?=
 =?us-ascii?Q?AuYD2Vi9udhdT1p79HDri15TWZWEpDtBGTCV3/3uhieMluZJli4BOLCCCIBD?=
 =?us-ascii?Q?6VtbG8JLhvCzf1DD3QwRlwulSLFrAMAJJ04KX1gggos45t6ves/7ygikhhia?=
 =?us-ascii?Q?gQ5ETL0xyx34vVwkQldnIaP+LeaBRDFeMEqLaDMj6u9r78mBjoof1DgO7j2V?=
 =?us-ascii?Q?0+Q7K7FEb3FBiy6cdGqhJXzE8i4qJGeCIClkNCJsS8aVdw5ipdR+OhJoh3U0?=
 =?us-ascii?Q?deYm0ObW47O1BCkxryuNIHzuBSP+vCEvqpU6U/te20H75OTdkbfu5HBzC30y?=
 =?us-ascii?Q?EI8eao+pIiVdcRk/Jnj/DmmIkEISlnA1w2zR4XG1xQD3D4wTvU7PQJYs0j6q?=
 =?us-ascii?Q?/ZMNMy9N3hCRJFkGt2zdA4I8+T+GzZT/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSKZfo6cdPQRZ0q8hIUciPuU+DaZFVshpvWeuOYl7CrwkLpzIGWwR55g0nOg?=
 =?us-ascii?Q?uU/aX6k9ZO7TeSGGyhhWckMzVODx3VRrri1F3l+NsnMUqTLIpoI2GKmZkj9j?=
 =?us-ascii?Q?b5V0X7qAOxrxaprYeMU+TjNcBMoL6nb0GImqEDxpy/1VAnxnWT9pWRFZLRq0?=
 =?us-ascii?Q?m6wzKaJI1Czxwh5OquwN0fQ9kUaO2WNUBY+ZCad5DZbTYGDIaKXG1m8RWyQO?=
 =?us-ascii?Q?NJ2FpfqI4Mb9Aw280Zb9M+0FexrbtVdnetBeFjvD6w7v8f7FQSWINwpz3NVJ?=
 =?us-ascii?Q?BzJcORJPQH4TzCOBrIopo9yLnPpydDDzCabS32WpdHYYpHMbLioOulBTmdsw?=
 =?us-ascii?Q?V0ZSQf3BPxMrfQPajFqClEGJnfXaHkSSY3cegaq+IU4vrhAl/Ou+rW8p/LlT?=
 =?us-ascii?Q?LlXdeXTLwcBcWh1TgRWUJuDyk2uGzXniVSpbinORoM0+t7W/zWcYGgIxpxpz?=
 =?us-ascii?Q?kNJxpv+vfx9CKCZLGIDZPDHhWox0fvPp9nRVMTIFqR1+XMPnzKfzfVfYKcBA?=
 =?us-ascii?Q?PHLEiaXCHYU5fDwxl8pzJ5evSnMdl34UFBrEeuF/GUCRfBtu3a/07V4tskpM?=
 =?us-ascii?Q?gAMImepjf6wtSyrc30IBv4iNpvgRrhlBt+48czurQxwXxLBdy0Ln9WSlxjjm?=
 =?us-ascii?Q?/YO8e7bhyeL1KDUoM6dHWkoFqrNPju8Zy/KFMbvSqZ4ZqAvcpJJP2RDgE4r5?=
 =?us-ascii?Q?GD52WHMiHfU2esS98omTuP7d5HzezeDprm5kd4hA8p3LLb7GUqA5IHBk0PlU?=
 =?us-ascii?Q?NDwRtOUUfaaCPVtld4/QT+u8zreQwx31XXhFhJANNlnE95NLekiJ6m/RKDUq?=
 =?us-ascii?Q?f5Aq6HWNREOjwpxJTjNqSFCPeiZ+YwPb7B52OaLXcoQ33tfrCUEEb58dpziF?=
 =?us-ascii?Q?954ezRKxNTwCFKR2AA417zMOyh+M4oRZfK2JQ72p0ycoh+HpGVnkD6y+rw2I?=
 =?us-ascii?Q?fh/FVz9mEyTqXht0O8FPqIxSqG4zjVxGf4b2F2LQixkmirIiqHRWnkLC78xj?=
 =?us-ascii?Q?HBROKXialXn7CRAVBIJMb8gpcwr2WoEOFLh6jfkVf3SVHOTqbtuKxQQM00Nd?=
 =?us-ascii?Q?z8OmfF4VZYDx1r2yfHk2K1BIAr1qQptxEiqvgp3oYlzC9kMuk3ia1sJ7mkb3?=
 =?us-ascii?Q?2qjipRSPHuupK560uJhX0WZlVCkCMhJFHww7fD1WVJWmUCnzeMDQxgP4H4bK?=
 =?us-ascii?Q?ddDQIKrjlES7736ZKSbTxq4/aAgheuM0pAJ9WWWLeaQQEgp46v9wfmWXU8c1?=
 =?us-ascii?Q?2KqF6CVXibd5zI2xCwPpd2MoLfwtAYQLdygvaEbw/vkYuOfow1ai+TbMLCKi?=
 =?us-ascii?Q?SGu8BToYdhGb58nZhqD4FutrhOxbFBjl5YEGcX9Rm32tt5TVPC76kqN3wsc2?=
 =?us-ascii?Q?p4Yre7FPIG5mym+Ynd8VBWcjbcz139DDxZZh4mp6tWhT+1DGemBGahPes3BJ?=
 =?us-ascii?Q?VNzjHVSnQgfnVx6n53G2LKuc+ZhBM97w7L/xSZJmay32dAo1V3k7Vl8pfgym?=
 =?us-ascii?Q?GqgrVa+fTuWDKkWtINoJtzWyceD1O/kQEWKFnecFHdUOPteqZbxm73DAIZEe?=
 =?us-ascii?Q?pdAsX7HwnLAb9dLN+XycW0D6U40dcWkpShtDIqjBrG9OSzW5EA76agcAeZ0W?=
 =?us-ascii?Q?IappUUfCJblZ/4vW26szjvOK3gA0v/XX4eAC7x70zbPg77LYNDp8PsZ5Ip5h?=
 =?us-ascii?Q?oqAMdQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d2b827-23ab-4a9a-72e2-08de2dadcee0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:25.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bllLEi19VhCi+5DP1lzjg3UYhVj8tJyVzrOgJevtn/oFtxWD43BDWIuL35F/N1h0tY/pfPwcDzSRaifhOA/35A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "mtk" tagging protocol populates a bit mask for the TX ports, so we
can use dsa_xmit_port_mask() to centralize the decision of how to set
that field.

Cc: Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_mtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
index b670e3c53e91..dea3eecaf093 100644
--- a/net/dsa/tag_mtk.c
+++ b/net/dsa/tag_mtk.c
@@ -54,7 +54,8 @@ static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
 	 * whether that's a combined special tag with 802.1Q header.
 	 */
 	mtk_tag[0] = xmit_tpid;
-	mtk_tag[1] = (1 << dp->index) & MTK_HDR_XMIT_DP_BIT_MASK;
+	mtk_tag[1] = FIELD_PREP(MTK_HDR_XMIT_DP_BIT_MASK,
+				dsa_xmit_port_mask(skb, dev));
 
 	/* Tag control information is kept for 802.1Q */
 	if (xmit_tpid == MTK_HDR_XMIT_UNTAGGED) {
-- 
2.43.0


