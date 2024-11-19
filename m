Return-Path: <netdev+bounces-146146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7119D21BA
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827CE1F211C0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BFC1BD9E0;
	Tue, 19 Nov 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kjJ6OWVA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A7198E6D;
	Tue, 19 Nov 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005595; cv=fail; b=KTbwChe/B1Wy5cN1Yq1kECc/lpYa3WEocGBdBf2NDFUPZ8b0qSuL6Sy/Y8TK5TJqTe3goPM/XAA3HIBg2Fc6rmQ/7dZkgkCqrgE7jrulr13lXg5XAGcpPyrEeECAXxpUPr2hnBRNuPvVvcPlpF0RXEHDiUk5bl3a6CLVRYfxGk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005595; c=relaxed/simple;
	bh=+9nf9QsDdjUPoFsHi5usdr7sn0DYItbRdpYnVFW785A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bc7vmJICTM6GKWWr8VdalFQ8SpdKVTmqZpBkcrdXeDMFgZdG4EogzATbRds9PfLMeISeb3rUud7bszs1fMwlWGbaUBHePtKwAg/ude6V/fQ9oqml9AIuC5ri30oFJ1gOy/sTWM1k0uaejheTjytsPtgxxFwcnO7ZKL9G2PuzFoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kjJ6OWVA; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOeli7GpILXiS90xllpurd5VukzmeVLlluBUF7L1HVcpw0QBzrU5qq9tWmLSq0UXlZfk6zN/TaxDiRibIUtBijbFDjjriKTfTa4z2xII2UUhsyXibIYd6+UzR1HyB1Pwa53L1D9HVkIp38LSFMIAI4BJUWIy/dxwuD4uwida9iqlY7Os3wx01Pnmes0dlMGnF8i7jUj751LqKzGqndGFcWbp9ZewwPeaD0jnihRYaLocKrKQ17LR/gGFsbON5MkdJ3OtBkfAnRqaAcO3c7xScjKlxTOaspNzybT5vWfBSgDS8KKrGkZSJIKXEkJ4rUlj24JBj7dIWLdR6VyG8VN/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LEPox4/t6eD1N0yRuIj+mhJvpNJdmnUnmNgwk7HOUM=;
 b=ZYDhSn36PvvYgTanU2xGNzZu6ddXhKzSpEZqqruYfNQdyc+NEqD4n6Y9X6GHGgVpT26BY36BZ+zFXaBxTX/DKunDM9v/UknnbzHEso/46dhXsNn5hcZREEGfWkBsFeUmrnZVywnVx1bwUxrf34lET1T169cmxUwf0fWFi6R4JMfI4D4aB7v9LJNFWo+ci8jUr7WOI56SJy2tZM3e9oc0FvBVXTgVnz69wSkBB6xCD6XTWl3Gdf1SBZ56WEaag9k/77UMGag2M4gx8c6UnQdBPUG458dYoNN1xMzmxjzK2tRoB0oH3PZdAcoGryej6TwH8200hlaswQMNhqQa2vrYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LEPox4/t6eD1N0yRuIj+mhJvpNJdmnUnmNgwk7HOUM=;
 b=kjJ6OWVANsV07aD3uIOwHYBZD47r2rrBoD5Op3RAydxKTOVjCKK1QYK6GAdmCw2MtUig5oTKjXy9JS/IybLVoL75quRo+Psgh00fw/PCoz1bzHFmfGXt7LjfGsQNkRcM772ubTqNSa5r8kQnY0ADytACHRgneQSO6iRyQhkvzaPCCZ5hW3lH6UQOglNMEqSeDnsuB/Lk7c/+n7fVMKL9Mc+Oj9m0+0i8rpJXAPELutYXZQ+yLCocwmNoVpJZivHYU5cWGn1A6PkLo6EWBMuPqOuU5jjMkB9KwW4o/rEfqyqwk0YY9g0ufHT8+YNQFkDQNkpasb+1udTIT51QmTma7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:39:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:39:50 +0000
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
Subject: [PATCH v6 net-next 3/5] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Tue, 19 Nov 2024 16:23:42 +0800
Message-Id: <20241119082344.2022830-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119082344.2022830-1-wei.fang@nxp.com>
References: <20241119082344.2022830-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfba995-1a00-47bd-8852-08dd0875babd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xmyXbhZ6mzILYdXyBTuBusBQm8XuGA21w8ACaBZ+oDk17p2PJ9XzOoaVmSNK?=
 =?us-ascii?Q?Nq8GObhFbSNyry9d5rY6sVeKgZHQP/0JiyAnfbUFvQ6xIfKXICNR9KsfBA2x?=
 =?us-ascii?Q?3c8NEvVQ861TlKa3X37kSBXDb6LgYiiLdzpWaORXcpFjs8xZwy8aIRPJriYS?=
 =?us-ascii?Q?hENVMHXbeOR3xEI/8B0mkSZzNOMBkJ2XPlemJWcaGoWm6nH8WtWC423OdcCX?=
 =?us-ascii?Q?ms9XepbkYDiyxf96CghWyVkdS/oPUYer5gMueoa6D4prGRJ4/w+qKztViqI4?=
 =?us-ascii?Q?lu07XARbRww5D5OTEUWPGj6hy+IcsisYNKQJSKkyBDQKf0NsYUylQ+CABiRv?=
 =?us-ascii?Q?FGk1/Tvx/qiwToimBCovdsRhfi/30Xkltat2Cjpn7LN0uDPxZnOfS0eiu7ze?=
 =?us-ascii?Q?hj+dbRcQ2hrfvyrZBveYrCA+6NNRVmeQdGX3xYJvGRoFsCausZyWiRBPjAvY?=
 =?us-ascii?Q?jWAMRTZXpYMkydb0qqf7KZrxxtcT28IRXxXPRVCuR98mXh2YnVZebvNrZ8Ry?=
 =?us-ascii?Q?JsFGstRqjH9jlVTsHqOwqKEEJGQqwIFaspbJ6fgaIZm5nkxy8vxdLE8A/JHF?=
 =?us-ascii?Q?Y1Dk7m/ezvjqAcy5s6xufZTqX9OXeIo3I9YmISNw04EmqP5EsQuZZQqBS18T?=
 =?us-ascii?Q?R+cyS3XcqkICZLk0oU59acLPl7qcfdZLytNt/gqwy0GXUQDzvKOO9v07qmRz?=
 =?us-ascii?Q?wyKfbjV3HnTnRgPpfhQ/NO1q/9PgpwJnREFCicMtyewtDSofjkO5w48itq+h?=
 =?us-ascii?Q?nyNkJ5RJ+Yd0hdcgDkyxQ9WumPDjgJNBbwiy4SJUqNpme99VVvce8msCHWcb?=
 =?us-ascii?Q?gAu593+bwvJlFsSb6UVMrgvjeNYjJ1VEAL4J978dKsbjhOwzU7so4YBFjqG5?=
 =?us-ascii?Q?rVRNDEA8f9OatrC0pGS33YeSO7gRLLqxePIyIA0GITitUB0XZkXNFOvS/aX2?=
 =?us-ascii?Q?5t7SwwD2MnpWYV5XHOG6bdby+D/DtXUsDAsdRowVkpjDJBxqtd7/uE0L7GDZ?=
 =?us-ascii?Q?uWMmd0sG81IPK/pdyBYwZwmOXMnAjuMa8bEraIiLRAHMAJgDGobtwmSgCYzC?=
 =?us-ascii?Q?6S3m7f+lppQmC6plHBA2VtIS/nYRU4JOm0MCrnXphT+2Fhi3kdk9wYouldFK?=
 =?us-ascii?Q?wZpFntM3VYgGLmButQF3uKdTsbbQEt9qRatKQRr+akxVz0gMMeRYpo3QKesl?=
 =?us-ascii?Q?IuXG21dMApPBAq69+loXsO2lJcVNJv0jOCCKzndTKRNyU7MvojoMDvYseBc1?=
 =?us-ascii?Q?BVn1sYaryuuYF9E8BYTOA1zcN11lpw8thWnEyJepcwNVA9KRYGq+z5kN7a2J?=
 =?us-ascii?Q?7RDs/E4gXNbmJGACxx/CfbeZaEAmkqEngWYbonzwzo4ZU2hgrR58mTn7NdL1?=
 =?us-ascii?Q?4ccLRjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/MNaLTLUNPQxzG63m2vK8q8FGOfu/YRM4HxXTA7GwhXzsuKOwLMTitoAA5H?=
 =?us-ascii?Q?IhSZfvV9MZzxBsnPiV+fp+DCCvs5KcoGC2yo6G76fsIYtZMKplcoXcqQMFn3?=
 =?us-ascii?Q?XxoP5g3Litq9PSBiWjkC6q1QQTYPrJ74dkA3t/gHuE9Fc6h5o9B3cMd7tdaw?=
 =?us-ascii?Q?v9bZDXB4Rca71PG/XmyxnY7yAoatDlZMnqBE5FdXzB7kQlXAb8ok8VCedIxG?=
 =?us-ascii?Q?IFVUaDssVvtK2Es8pNxr5dyseSm4E5DABR9jw08a7EZ59dKkcJFxKfS66QcJ?=
 =?us-ascii?Q?2QCrKOazzN4IRCCh47mOvd89wFuaMpgpJPS9kOaozt+G+qhxYzozflDB5QaL?=
 =?us-ascii?Q?0R/VJ1Hv5gyeRSNqYiwPfX+TjqKmzjvUMbVWSPW+3EHtbd2Nqj/uK4xe7/0a?=
 =?us-ascii?Q?nAU9WNGB17IBwnjtDcZrIgeazu0SywZ2yDyRQp+51ZVLIrhU0RbAR7p4EVFp?=
 =?us-ascii?Q?vM8tz4iC8XopXRyKMs7xnTtAoW8JHoJOJvhJciXS1cuEhsU2rt/fb2xzB+UZ?=
 =?us-ascii?Q?9ivUw9wyVVllBurTxTSl9HIpYF4sBEzsJ/XGTSjqxlet/OUH1Lqf1wdA+9tZ?=
 =?us-ascii?Q?DWIErxmXVUK2rTeZgkYzrykreguUCpxMP6aVveqk4J/Tw3Ho58ghuBH8y9q1?=
 =?us-ascii?Q?idKCmUBY2ecgt+6iAeXHcAaFu/AEIOopFBgEkVSzZZNAEjWVnrEJwVbKxWiL?=
 =?us-ascii?Q?bBoXXpu/OqExhPSxJ/iVbGgzBBzlfBEJ6b2u88rjjauG2XL33859t3gFj5bG?=
 =?us-ascii?Q?PrmiVBkEEroSs74zyzF0rROJzly+ZKqqascntOm/GxRA9xv/1IxB+kQu3G6T?=
 =?us-ascii?Q?yPgVJLQAHpnVBehVDpGnm436t5PbLZS3yqKCTKFW06+NQPG91C0fjoEbg4ML?=
 =?us-ascii?Q?nYb8R3+WPXExGEaKZZPYC9TDdsnY6pVXBsbZzBAgbsRJ5KKQI7FpIS6OA59j?=
 =?us-ascii?Q?rBcmFzLlFFJMfskpszWnErPnH3ZpaFXwQv0TgRnaCtm6V4Z9Dki+URZFYkU6?=
 =?us-ascii?Q?LS/JRIs2WHCKXihG5Lm82pWRPrhY/boRw24V70Yq96YFS3+oygFuu0SsZhsw?=
 =?us-ascii?Q?kgGlqL4CiZVKvdSmWx3vUtfZkK6rWYOxTw9JpRnsPhnue7uZSFUgzZw6gkw0?=
 =?us-ascii?Q?Flq36W0s4j2euVW2RPtk2oTVvJ3vx5p5rcWYtHO8d03pUtm7HeSj+B8UsyLF?=
 =?us-ascii?Q?Fa/dbC2nKU1jWEq6Thprc3ZQ5a5j6Oj5A7UN6ePmlZl7LCT90PTge7s1RwnO?=
 =?us-ascii?Q?dtmCZ1AN3HJsajnF6sL/o6slssbV41eG/i5zEG2Eok63fPZmJfcRKh3sWZhC?=
 =?us-ascii?Q?5gI+GUqvx5736W4bgOt77Qzz8b1qOvoWPGKsllieHBESCvMzQbyqIgv/K+HX?=
 =?us-ascii?Q?1RAB4mB6bHwfy2lGqydrHxQIwdE+wWbrSgBfalPquOVGzJqc8swLS13krPZH?=
 =?us-ascii?Q?6VCPeO9G74l73dAAxyzdVqaSXmwIyefozGbODMkKtE6L1WsdY+HoRGTAYG2U?=
 =?us-ascii?Q?bH8KZGnxD/of4JxZIvTRgVco9j+Yr3Er5/6/Km9J2XJ6JJVJQyLolUL7NR6B?=
 =?us-ascii?Q?wpYVWgYs4+1oDsgsZC8VSpYaJS0/6mn1kHHC0jeM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfba995-1a00-47bd-8852-08dd0875babd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:39:50.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZYRAOU+veGQSY2Q/bU39fkcIB/C0yYNwFptLmrpKMLVTAv9WrdTFWdTuhoU/j91Rel/jbGd9C3JiFfokVh4OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160

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
v5: no changes
v6: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 94a78dca86e1..dafe7aeac26b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -525,6 +525,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -590,7 +591,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -651,7 +652,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -669,7 +670,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -937,7 +938,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3312,6 +3314,7 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
@@ -3320,11 +3323,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
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


