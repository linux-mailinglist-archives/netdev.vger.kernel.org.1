Return-Path: <netdev+bounces-145153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 416EB9CD5B5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C681A1F220FE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20F17837F;
	Fri, 15 Nov 2024 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QT1NpE39"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B1176AB7;
	Fri, 15 Nov 2024 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639825; cv=fail; b=ZIZbYMb8na/NAmzOqO/r0Uf5VT/+ueTet9rqiKMvvrWVs9btdVUAntoVq9/V9a2T6DOZ2pRw7wtsGJF9aT9CLuQc14DhHiiihmrRDh/Tbj04hnncB+Lkdh3V6TZDoiGuqkUqaMS10mijw4e1pJVptaKpjkcrkCu8BVYtdR0N/fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639825; c=relaxed/simple;
	bh=SWBuTvYmdj+l000rued5AkC6nvwZZo8BOPcQf13pMv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uG0+Oc1gNWNk2gQbtKrE0sXeLAsegBLG6WqKciMtzXU5eiSJUKccF+8bUsisY5Zkti/OSUIvywFbYsGbvci+H4TAEb8vsRp/0tbwoHChVESMFDpOQl4I1VrkCuRZesEz3kulhNptsGd2tYKogwvFJxVC+p8l3N+j+zwy6e9Hds4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QT1NpE39; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dC2IhX8bY0muekWqTm8kWxs/Aly4c4FW6SMCxAakpqCSmVfQNtXVDRJrVtNZkJ2ubPWVhZyJJjnvHtHiIzIlETiggEYTIcf84rXgnDED3LUjJ1bU1phsUkthnxCU1sR1Yi0xqoPn9vStTee5wmy04wrRcxdWEENBigJFC2bYp+0Vucswf/CqH28/FwmiBwVCyqI2CRxT6z2ZoWjEgLe1qNrodmI57Hi6c02YfqOqOwaeQbD7UDZJNky1Yy0II2kTsKj7BWEpo9rGG7o1Cup2000PQqClfnEalvqZGkzzgXMc6sxHF8uKZ0KEdJsyyLKuYjbSSgxmw4HOEG+9haGJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGCDOkk2izEzTdvJ19yTFpJKyHMLmjxkpBFDGypQHCg=;
 b=SoR/PUwY+CiuO1pBOTQg5xAp3RZm4pcS2Xo0Jbg7RzWBoiwPP6ndwP5/P36YR4dyPhpQINgKqaJyHn/EA86GPDm01kL/IrEZLcqlhiwaJJSqYzTX8SduhVliD7kBjFLjL0fc6zNmc3IxGk6n/B3MtJCK7c8fmD+pHXP1q+HDSMqTdOVQ3zyrF3zlQRblnij+smSHdMZsEwE0aQ53FEPWpGmaJqiozg/POEjPLdD4pYTz1zwHpARJJCcxmmsivpD3NGX41ijMrbHgk+301nXMBCHz5idxbv6S47bNNjX8S30MxBZOLLvt6nv73nMHvIAmYHfyWSto3hhVSV+14LrtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGCDOkk2izEzTdvJ19yTFpJKyHMLmjxkpBFDGypQHCg=;
 b=QT1NpE39cfWvFSmWZNxVZ+Fu/trXZtsk6Lb/fbQVsEuMZvSUYJiQXpZcEbthqsILHhn+6HThrvjWVbqslo1u6JdlFRq29358kaF+NFurcdUBL3YosOo0C30hcnY6f+YJnfKWdzsbhrIKAhlyWjxx2Vhiz0+XdpVxlRMQB79mAXVA2HFO4lInACmVLXbMUkREOg6ytMByazOFO11iyCFvDlgQQVJJCGe8VJopQjJ/HHKcAla58KloQmxYwt2erdvCas6WT3F6XzhGl3Z0+pBuGVylACOts2Ip1sEChqgNV882VuKEwUc/LziUZ4BuVd1nLthJOkzcpft9XnzhCqO4zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 03:03:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 03:03:40 +0000
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
Subject: [PATCH v4 net-next 3/5] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Fri, 15 Nov 2024 10:47:42 +0800
Message-Id: <20241115024744.1903377-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b0e1b9e-b86d-4614-167a-08dd05221b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iiYN7OWe1mvRdvXk1oq5MIpakJlSvyY9v6mQYgRLMksrCpoOvYLFgFY1yn+y?=
 =?us-ascii?Q?T5uCbLIiPl+ULBmy12Dm89657lLZHWmA5YS5u5+uEJolKlr12jdPTU66UukE?=
 =?us-ascii?Q?SiNNqSNsXNq2ykJI6AXctABbM7uHrBc2Fkoqgn+vtStLmnpiSCX2fSgSmKg2?=
 =?us-ascii?Q?jrk95+H1keepii0ply41jpiOfve7gV/NKD3I6hgE4SVW7giTkmooBvYU7Iny?=
 =?us-ascii?Q?P7+Lf+RgHVj+PeLcVXkVA5ABZJudt8zsU9leOFUkGZQU4cLJVQACKvR7ymZK?=
 =?us-ascii?Q?7326L0Kjkio2Ubos8E67FlG+KXmNadGfwdlFcCV+hN+UtnNNcNNQSQUylvOT?=
 =?us-ascii?Q?Mkbds++uKFGwWWl4cfflr5TF+1Jqq5d1jerekEj+1UsgsU0x3waoaR6hQVmH?=
 =?us-ascii?Q?X7faS2nS120wslkaciRhovILlBPQ0FQqy5wNwUO6kUrIco+DSUz34hi7kZs/?=
 =?us-ascii?Q?xyz/Rs9h6/oZ5hHpt6OAWdnyyWbqdP7gn0mLbgtPHC4zx/Co+ufqHmUygXCc?=
 =?us-ascii?Q?i02t7zWKmKQe4zdiBm+uNApLm1+uFptrvpDUo5bOqsrksYzJPefxjbZHtrKv?=
 =?us-ascii?Q?QhRgoMMBXDKXU8B+CGmjmZxqvi1lAfhdLu80WmHc5dKSxMB1XRGshJ33JX2q?=
 =?us-ascii?Q?1FUKKmVEfpegpk+FX1PZN2mtfx/HgSe+/fqkuJ0IU2gtctIrtefrNAJcfpyW?=
 =?us-ascii?Q?AvE0NmFSoGQWeBiB5q/eVitxxz/69VykuFCC3jIkZBDHXDyARl2mKs3Rt/Pc?=
 =?us-ascii?Q?2SlKkXOyEPtBaPl6LR8mK+mDJjKectfaFOfdj7W+cEncDd3xK9iO8W9+TyQT?=
 =?us-ascii?Q?u+AVu98PgyesECEk9mcrJnjQ4yVB8zYfLOoXYARdtDgxW0HvX1UQr9iHzfxr?=
 =?us-ascii?Q?2bchy9vjYkbiZNZxQWWyRcJs+6J5Hb2lzWN71Aq6iq7Vkf2eH06B/CR67/Go?=
 =?us-ascii?Q?lHdzA4q8XaApZKj9WJiX8ENCtFovzwz/G6u8k1huj1+4hy9UcnG1eaGqLkWV?=
 =?us-ascii?Q?w/LtqA94vcguIXmp9mX46GcvzYepwo9lzg5nNXZkjqVIqJZnRkHfMLh1XZLe?=
 =?us-ascii?Q?+45fjbfoLyR+rSZ9OSmLRTxTmC3kE9DTX0gIY2DxhBtI7f/mxvZgpDvO9LZ2?=
 =?us-ascii?Q?xw+BemNcEAVaOSilvJpiQLBJNEWE2ei6XPKkRqbdv8i8rRnGtia7qz6rccpg?=
 =?us-ascii?Q?j7Mg2NFgQa5eULtTNRRvO+tNylaTYzq0IU/Lf/iAKqrXZ+/RLZQqusdxn19e?=
 =?us-ascii?Q?pQXKW42OFLeXFJiUvroTURSC6bzP682FqITqauBDQHKJlfg6eDvylYdQ/60+?=
 =?us-ascii?Q?OP+I6svyE6FT52+9pg005Xen/8Rk+TSZrTNO8ySct+kX2LTOCgnlbL+NGK9w?=
 =?us-ascii?Q?pUBqupo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YNOoov39xrybEUiEf9GWVBn55cMBzlTTyXsS7qkH3bXVX/xBPorXckEXlH3u?=
 =?us-ascii?Q?HD53zNRdGasNLh9t/js8tdrGmFKa+g09NGl6gNEflMegNsJ2psBFHJ0SkWhx?=
 =?us-ascii?Q?fDGVt0O5OItQkQc6kYBVxgt9tT4zIA9w+3FRrlkGUrAOd7rr+4uHsot9Ezhe?=
 =?us-ascii?Q?DsDl7c/JwZGGC4SjN0pf0klbgPUcyypuhdfL8paUAsNe2qe6eDPB1I3k8+10?=
 =?us-ascii?Q?WOPA+EB6jLq6xHC4BWmIaPlYzt9Pl4SQONJ5GzhHPmKmkHAaCA1GdbmhywTC?=
 =?us-ascii?Q?fUhR+plU6eS0DGQWxWSiUIXahqphMf40Zw6jK77uMgsYt0RVlzK9b602FMZ7?=
 =?us-ascii?Q?eZfwPlcz4H9iwTOusnvZSGitFOuDgStnFNSQhICB5rKRrGSQ/YVpTr73Wmny?=
 =?us-ascii?Q?8IBezIs8t4wc2znrR55F7OJ2s9nR6fobJZ/gPZL/H6jxbOE0EkyMQYjHJQl1?=
 =?us-ascii?Q?N3MC5DLiCKhKTDjbkF9SOsXnt2+Z0UGEBYlVXmDjKYgbE5vYuABND7vvN0dT?=
 =?us-ascii?Q?Kba9Z0n6IBr59pOHK4SFhiITTileOjotbSO9FYyFI76Ry26UnvOkxTUSlD+v?=
 =?us-ascii?Q?F5bHU32ivgbqhiNgd5QaioT5VVW2z32NjnY1hjl6clhfn68BkeL7VrkgrYZL?=
 =?us-ascii?Q?lU2SFJLEfvqOrCwzwft6DlvaF9/My3Z1YIlvYufdkEr9RAVuLw2oO+clnQeb?=
 =?us-ascii?Q?16HFr27vRUU8cmRoKxp7FDciCquzFHmwPJq/myPy4duM1XXK4fvt6g1MgMdq?=
 =?us-ascii?Q?qSGRiP8gSFA5FhC5FhjbCRGUdx/AMhz4kyX7QLld+s/DhVmGMEkONhCBAuhQ?=
 =?us-ascii?Q?zhAmVVEORG7FsVYT1083+CUISJ8SycrdgrXs2NbybieJ/Dj3p8CDNXT8clZ4?=
 =?us-ascii?Q?anspMATY7OyZ6LGvdKPDe709BbE92Z22NAp8YAszERgpM3KuziWvQr3Xrzee?=
 =?us-ascii?Q?6tguVX1FyiaVkaHul473tLIax30pclH0KMbxPZ5VXe5HefP1K2zk62MYhS9R?=
 =?us-ascii?Q?beurGRrLRFtXP+krkeTbhPnToypR50UuSvQHm2OQZjLBgbM7d0KvB0HoQ/HO?=
 =?us-ascii?Q?wXfPF2Nr6zdFiKGMlyu3Ji9l+O4otWrwxIdc3mm6TCVdJqqMlezC/l5nBr+u?=
 =?us-ascii?Q?mT0oBgNeGJC2Bj1NsI5kahBlJ1MmA89d2KzKuoqKRB8Q6BkzXnv8HMM13Y6W?=
 =?us-ascii?Q?TizDBg6NzdZ/6EKV5v0gif0wk6v5aJLW+VaPgFiELFKd/f47Eo74Obc1sPn+?=
 =?us-ascii?Q?FwTcxkX+orJwkks8gL0ZTcR8X6SQebLplYIzXPYiQNunTxMiWUTV7TAjlqD8?=
 =?us-ascii?Q?HS7zYCQM4vEWTG9RidXVaJe/AWvDa4Uomjo3Gb682DbxaAnRPJzoBflH7mP4?=
 =?us-ascii?Q?CbIXGC/01pgFNJmgO1hxiVUO+W5Oq0laP0+Wkls0u8h426dk2h0awyyMovKv?=
 =?us-ascii?Q?2L5yRbg2BUZeqoMiiXs4exudTGkFJgtRb0cdZXCbc/zuXB4Wdt0GYp56m3zx?=
 =?us-ascii?Q?xipgZv527e7sMkC27SWjzWLohZihKJ4V5P8Xt26QtMduv0PrXs2WSbF6TqrN?=
 =?us-ascii?Q?e6P7yBTWhj9X5+f9D/i/NY57eYYr31r+Q6CHD4AI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0e1b9e-b86d-4614-167a-08dd05221b51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 03:03:40.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQI0dn23NEBSIYf7m0yZhSt6yC0lb7y3Z/XlVjTuQcw3tbViwVZaPNgNEzqs85+iL3T5V1j+mdanuQdYVRlssQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028

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
---
v2:
1. Refine the commit message
2. Add Reviewed-by tag
v3: no changes
v4: no changes
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


