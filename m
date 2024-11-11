Return-Path: <netdev+bounces-143631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C119C3662
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5031C20EDF
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F21448C7;
	Mon, 11 Nov 2024 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HF0eazUm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3285260;
	Mon, 11 Nov 2024 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290895; cv=fail; b=UiXZPu9s/KhwHmhl/AWy6x9PewyJmlTvqkw+Hf1B3eZcr863SVZVgzE7OYDpW4DsUcnpXLyhMnhZN670MI6x/QCgS6BWWNPQgyZS4L9fljF8DKGDWppE2D9wrag1NRsoLqoEzx/WLsCn5hQ6SVxp2q10O6tkX/8eEwgJHa0okpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290895; c=relaxed/simple;
	bh=g2eZt/EC4Fg1/2SUc8BWMFVMXACkSePdODMY0mq7Ggc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BPd+lLkWJzDvK3bWrbWCG7jEUjTJmn1JcED4BsB9aAfwPfM8luTfeTs1nnL6Q8lZ+MCIhDltlkfnN6gIc1CHzQOkNVMuvGOUk93E4/ipQK+40w7iHv4kj2SuuWw4TQ7Dcsurqx53PTbdTpNKD24jxPpnrlm6WsXCHT+siFCzB4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HF0eazUm; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjDl45ISJkVLwMWLDWMg7ocbTv5tWoFsQnfjJcA8fERT0U1uIBBBmAeSazUyymvMiNGWpEa96VYvJKCiPYqCri9bTxdsDyRD/p5k05QDkR/FcL19ZUHATINySnMM4r5IqJv53MO57HYVCn91IE/Jhk4L9TEY4mCOqB0U6p3QTdQTrjFs8zFkF5PAnbNRR1euhwm7MT2+u9QMpg3iD7OLtJzWt2RNEo8qfqnrYESk7k4u+z8igTPJNzZb9a7AoDlt0Fc+KAHIC203c6mqHcW5oqgXkBJI0uWLM/GgrlTaWSfwBV2pG1kQWuwLMSFI2/5fLMWUqedG7mujX5L8x+NiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcbyJnO9HUt/TykEJFC8ZTYzskhcRG6yutS7gX/5ReQ=;
 b=C6SDv1/M/rg1gsL+VooxOPawaSZd3IOtn/5NmXLkQBXDg565ntq68CKD5VcmccGamZKbhSikYyitVUYy8gdAMLEPVx7RvU3h+Prs7GEVL5Uvg8cJv2uaaKIyNcyRFSK3Xbq4ZQufAuEopswY71CqB1np8OE0J9rtg9uAdhEiKh94pF74fuT9jXSPprYRmCYom5sWX4nLTNe6nnK77fryKyB6I7oHIwccwDW4yK3gw5frmKbozMh2kXTf9CLHumYbCLG8qqzC5B+1C5C3EAUTPl5b/2hn4MUUcDOWmp6WoE3dyO74eqdKhFGAaIJzpv3U1P5IOIDYbnhUoejaXwswLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcbyJnO9HUt/TykEJFC8ZTYzskhcRG6yutS7gX/5ReQ=;
 b=HF0eazUmJHkybFW3PXWmFHlJsXFZHm/bKiUHt9TcNKyVfycGA9ulYdmtVZko+IsNLPbBvIX65Nw+9qftcyT/7OpNfTLypsyQDfT2zSaM7PRzFGTLoi1eeVwnKokRelc8MJEFph00PqU1Elwcd3bGIwI/lRJ7FIefincCdsw+Hld5izRNGz+CtJf8f3dzFGZHCbVomdOO5LlV4Qo5GqfBFzjZj8CT9vZT+zqZKmlfFN+iEPkELWWwHWomiS/zlZFkbODnnPnvpBWaGRNjWfDIZyaSHSTuaK7k2XaETREycC5ea3VVIAtcNkGq8xodwh06yssgKm19P+kcTy3XDVwSbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7745.eurprd04.prod.outlook.com (2603:10a6:20b:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:08:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 02:08:11 +0000
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
Subject: [PATCH v2 net-next 3/5] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Mon, 11 Nov 2024 09:52:14 +0800
Message-Id: <20241111015216.1804534-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111015216.1804534-1-wei.fang@nxp.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 1062b1e7-b48c-4602-28d2-08dd01f5b174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09Miffm+AB87twI9hqi4Xmfg0foxjHKYc3LmVvKMPLqbS6BQx6t3I5Ut27Xo?=
 =?us-ascii?Q?ZWuaXcK3aneIdtZNoKuZ/PGRIvASXYMfqUuYDRQ2muHc53jfMv1SVFkXZl73?=
 =?us-ascii?Q?ILIyLj0Ja4LRBPxGk/764UQyeaIZZasL1aJmH9n3hA0UVg5P7/EGP4JulgvN?=
 =?us-ascii?Q?Jq3gnWEt6IkKw1/kuUtgYJBOtsoWDrBPZ9gK1+CetjbVrhflpeCzC63/sk/y?=
 =?us-ascii?Q?/qHc2JIjm94eWwE49Q5HhLGT5eqH3RE3seAKzwq+vcyGCL5DTd0AMyOC1OoJ?=
 =?us-ascii?Q?rKqSEJl9tTwej9qva8AxVm+PakiaaFsWY2JdUvuMp9MkzSGqrehSAjyA0tSr?=
 =?us-ascii?Q?Skw8Vd/0O5SV8dH3GhxpRM5v5uClNZCZEPNk8ASqxbCgd/myJSfy7xPOeD3x?=
 =?us-ascii?Q?6hmUDAdOEN0We2HdF4UKCPwHMNJEGQPhwDA/k5wecZwgdgS0+zmndzXq+0Ib?=
 =?us-ascii?Q?cMFZHHbeG07R2NQKPWuAYWyPZ92qGUzvzs/+zWYJ9i8d0f4L4R6+BRgHyZiC?=
 =?us-ascii?Q?AK61I0DANgfXOt76oA+PUhIOg5i0DlxRIPtxUnwD5FtZK/jyQUT0N2maJiGX?=
 =?us-ascii?Q?Xw4S2O3E1lIOyMs/8DiCKR9ZylCZBl006xWEvvCYX2SZLAJWwPOv7jwxPsXJ?=
 =?us-ascii?Q?gil/e3piYY2qSVnUMprUwIVdOoqQABJA7h77Hz6o97KvMx4lAkkgNa6rt6iz?=
 =?us-ascii?Q?B6G7547betv2mAEc5KHfkM74AkcdjajZCaClKFj5PjXicVw7wIerEhlvExiY?=
 =?us-ascii?Q?pr+aw3s8Cr34jM5I6XRXaRqhtL07uJH/hLSu0Zvaac2Ofcx/wAJjzKf4u6f+?=
 =?us-ascii?Q?dcT2FHG5HMWuVN6qfwP5XvMV0sUN+VSB5Cf09Zd9UVILFnrLgU5auH0k9PzU?=
 =?us-ascii?Q?AqPerPjwSLYEi/31AvP7sZCaOC8BsettsGQlQuywPKwB/rSG+8jE82h7C3Ko?=
 =?us-ascii?Q?bfLnMtzSnruCutxB51ZJIAL6FwJ+Ip2RHwox3jzyDYALYKmlci1tw3Z/G38o?=
 =?us-ascii?Q?RFZDfD0x4jJAlLfEGtnXSc5lP1u+bHql6xSTiwG5dxxffbYF+ZIIaVw2YvQd?=
 =?us-ascii?Q?eI3J0uB0F0PezLWSeJYHzWh8rHbwrdP9s9I+YdE0itefPdZdjDG1V1xUXJuz?=
 =?us-ascii?Q?GyVIUsS8icToS6Pu8aVjopijBOFt/F1nHJ8XKrZJbIF+quPsWrzNFvYfmDML?=
 =?us-ascii?Q?zezyDQf579O0CTLZJdivN0zWmcVn0pF4RG8GxdjDNUU+5HiSmPH8Q0nKcZzF?=
 =?us-ascii?Q?dhPoz0rYgeZS28Eey15sP9VaiumhHGK1YL4rXXJjBfl9NlAXlxYgPlegPhKe?=
 =?us-ascii?Q?LeJGGWq9g4NMJNHRjqOh74lhh4HPfPhm/SZDgh+xZOxTnFJsY8wTGrDEc2QY?=
 =?us-ascii?Q?+VGYyhk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?05tX11hy7o0mDrzKW1pkREUqTShMBjA+ZOLzCYz4OvdyRbvCEXeB+OCXFzVE?=
 =?us-ascii?Q?F/siP6MpO1wVkQeF99xQPgAYKQHxGzhmjHJbsSBuG+AeMu/8V9h/s/FcoT/f?=
 =?us-ascii?Q?lA1m4keZ26iN+RLGk8s98KZer/4iCh5bMkDqf4qclQgqINxFLl3vlFblVCCb?=
 =?us-ascii?Q?5kaaLV7I2bSJCVRK9qRPfkfbEffhqENgeMmsX0NihUuBtgjcx4eJIdwXu1c0?=
 =?us-ascii?Q?TkltyzZRwEJ0QRhIUN8W3I8TlHb7tpdXj/XZ/Crk1/qpSWjpbkO/rjP8pk7I?=
 =?us-ascii?Q?YisPNEz8VvN71e4cg/YwteFOnMF1o3cYbeRKHkkymi2kMaN8eZJnuqtt/jHQ?=
 =?us-ascii?Q?3UIgw4WiFG3dgyCABICL8X3Yg6pO+WyrkYV8pKrLy3g3N5exxEsKtFEkaGSF?=
 =?us-ascii?Q?vvhzqTW/7ODhfKDkpWgLGtI02WKHn2T+h4fkG5f21FZRhdY6BVI2GwVUk/tc?=
 =?us-ascii?Q?c1/fLVb2lpe0QQZrtoYa3b5eB13MQo6t4/t6WRdlqxrXPJz+5lduK+r+ectD?=
 =?us-ascii?Q?Zbk3MAei39tYiRPntMmdSrXBHD+Go13ja+jWYHGS+2gZL452n4fbcZmjhN1Y?=
 =?us-ascii?Q?y29Lo7UNKF8Mq4pizkst8DVH5hZEMzGJEXpCfFBINz3LiBq3sDpexCIjRTXp?=
 =?us-ascii?Q?HBas1VNn74le1iXBooqQ2MtDnbv/+Dq0cbobtgq24oyrjctOLBmoy2U+yI4O?=
 =?us-ascii?Q?urRBPKFCTti05UCl3PqbKcRl5sK4l7V6EBusXunCKDYCLA2Pok1HZOGv7vwW?=
 =?us-ascii?Q?/BFubo7o8/zTLnzqB+rMYb7eDaqoQRxLOpyg7O/Uas2pPweYpQACKn5Xve22?=
 =?us-ascii?Q?0q+otdr7YRFbCHhqEA70Ro6TTrM8r0fRErioum1CtHKn64Fvf4fvFnFl9i2U?=
 =?us-ascii?Q?pHraTDiviJf/4FnzIY9YObbFNloFjKp0o5htD+znRe3ErSIXIw6iGHXXE6ye?=
 =?us-ascii?Q?nQszeUV3bfDe61zrsNia3WkYXFDUVElNcYMmNdPt2f7dxQxz3BvOuyoGdqCd?=
 =?us-ascii?Q?EnG5WhNcNXY5T/F61hKAQxMCihdsyGjHxd8RYx4VukycxTw4qAvrr9hALFta?=
 =?us-ascii?Q?38eNhbieicDpGDjq8mdZx5ZVST7PY5582LcljgBC4QCazAxGL2NBF4l+6n04?=
 =?us-ascii?Q?zsooHT/6PBFpS465fLpCelpQxv5Nn++BRnDtSK4RpgbFXCQ96CWl6ZJUQ6dF?=
 =?us-ascii?Q?DNFDCwusKD0amcYJmVT2UPmhrulSkGSYZIp5VIzz5cf4LSVbfkfLm8PXSno5?=
 =?us-ascii?Q?MyeoouXWswiBjw3xx/pSXetorIoW/ITY9kbsWepx5u8wj5xrk7mfJAYzfVfm?=
 =?us-ascii?Q?M7wPlEREWWc8HnYA/szd0Q0Ees79C7Txz4+N+Uz4bFfLnuekDGrl0azdL8hT?=
 =?us-ascii?Q?C+LJwWpvT3hrdngaV1v1kTZhHPupa4G1w3O32HrEwDT7W5/KYTZJh7vZcIDM?=
 =?us-ascii?Q?ZbNxVn1l1SQhsTg/MoofQD8zu4WI3cn+/909xKA5Alvh6I2T0tDDlJvQH3m1?=
 =?us-ascii?Q?RyBor4ec9zzQOLUYcbR/SdYdghtOQDEMqKYOnE/zSYukycrEC5Fk8lgm4yM0?=
 =?us-ascii?Q?hepupXBK5thm9qGGCTsg2LKIugU4yS4lVQUjLuMp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1062b1e7-b48c-4602-28d2-08dd01f5b174
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:08:11.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6C7TRfgEbDmZLrFbeNZSOckuf/Du0HwLWf8eNcUhmaVJTEuFrrKx7bFqKYft+DX4fNaL32Q+rnZZvNbP9DDEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7745

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
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 502194317a96..87033317ca56 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -531,6 +531,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -596,7 +597,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -657,7 +658,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -675,7 +676,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -943,7 +944,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3318,6 +3320,7 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
@@ -3326,11 +3329,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
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


