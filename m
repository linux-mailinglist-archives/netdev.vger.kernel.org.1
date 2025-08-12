Return-Path: <netdev+bounces-212858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C5B2244B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8598A1896205
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4E2EE60E;
	Tue, 12 Aug 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JWzLGWa+"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C52EE604;
	Tue, 12 Aug 2025 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993319; cv=fail; b=Qj0ioi5gJGpFok9KbnfFOGgY7+LOB4ODqQLe0hwahCzkMi54JzQOJAXy4qHfimcai9uXVYA34Mz3HeHsGjgOHogDW9KT6Z1D8tFRSlVKCmDLQDFfbqi7o9hxaRLdw7LkCdtMbz5sWFNitm//M45KPrfTq0ognUILK/1XjMU9jzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993319; c=relaxed/simple;
	bh=XKim+Apovg3ClzFH9GZkEj197hgDaqrgI4nW5tEW1BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CM6gxMFLszJmLXfUkimeN2D1GA1RlOVP+eN6+T9cB19bBt73F4d2U+T3mUrqHLCRFjTtanvjrZwayeYoj9CEDknPqS8OgB4c6vMBia1rDnY6JnqaLz0RDrzyCVq+3MQqp7HHybKRuCYbwMy2O8AL1LEsT07SPxi47hWDldNsdMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JWzLGWa+; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjg3Xw2EntMPj7HXMI16elRxEucl7VluNAAmGs4LaVuf6tW1yulSD5mFtFutgmVFjYjucK2ARN/ipmaqEHTN+gl5dnR8O/Ip3+jGhoFx/zVDV29QFHfa8wsSHwyLkjdB9e4Y8rysICmoHr7a3JsAIGCcXGjYqZA4wwDrAUGyONCnCH9DZEoNQZmDuU5tZncTTIs5mnldUpoDhBLUo0gTnb4mFwoasmYXxaaHpofCkOrMUttxUEwA8gP1NK69BFlFKjjHkWTZGcjKlP9+WLVwSwKOC9ZPBNKKSwThnGIx43/9eOfNh6tc0aDi/Dd5IW5JqhyzduOfU63ri71W4h2C0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=K83D3JLnEPpvifjEMjw+q8ElybGZXryUTqh6+MBC3LgYZc3/uyvrkUmSCEEszQF9rucFQ8USvuChZnAlbgfPv4Doak2A4dbWUPQ7XfTqR1ZqjNTLAnv309IL4FjNFqPFEp6ogOIBjPQ7i37IRqFvRoQSiPBFpJkqTEsL1wyzeO8EwLGzyv4PwZb/5Mku01kHU3yfGGKF0ndMFM4JtS1Wnx4NBb3wYfDjErdA1hAsnQ88jfprUz/AJvRWeAFdyv/pGo4qYaivr4c9W4ExagG+uZToKWksbtIR6BMM//2sqXWU21BplgndDlFnGuKe0Yxo4uT407qHlVhB6yR0g6KwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=JWzLGWa+Ub3cJnfHA0naaIv+nWuC60cEBG70vcmet5K0dXsDw34HtgHOvLbF4Ih65oK6OvBUWT03xCBrhYUBxvGgMisXNAImQ6OjgdCOSGycLXTBlYb49W3hPxKLdk8MhwrryTVqqaBviMG/w/swS+upG2AoCDbm/0y/LY2hob1mUei1Cn0exaUSmS0ePXQxMQwzSUsCtQsB7ixnpHTxzi2qw8be4eAkJmMM7ikrW/cZIKE5dkmrlOhpVkPv+q7FfUaP8aqyrAr8sV/0wVAkDMegWV2WwTsnHa9LhqoL1cyLEO7wCyab4n0PXhVAaHEMc6yyeBQSbWldCqmKFrr9Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 10:08:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:08:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 net-next 14/15] net: enetc: don't update sync packet checksum if checksum offload is used
Date: Tue, 12 Aug 2025 17:46:33 +0800
Message-Id: <20250812094634.489901-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 2231a736-cf29-4338-89b2-08ddd98832b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mFH9sA2ktxehG+nWzrqyPtbbuexp3oLcpABF6v3Ucil2UAwL7VwuEJS9pKmG?=
 =?us-ascii?Q?Mk4ebAxRr1Stn4Wh3xo21uaJTVbkWpYA/12RBbemxmX0b6Stb6s0wQrZiUNo?=
 =?us-ascii?Q?bSmKwnG0fVAfSu8c1yonyW+pF04pO8UOxrvg3h/w8Vanp7cNzGj41dMmG7kS?=
 =?us-ascii?Q?LvWebiPaACNL4DzymTcjFdHvnSZC60XEsX28fko3doNkViwdPW6UsRbuhPgm?=
 =?us-ascii?Q?RzZR4XLqmsOjkrQoBc2d/ftMWQnKz0aHMWU+T893caS8jEFB6KhDI6wSxnLq?=
 =?us-ascii?Q?ApUmRScinFs85+CNlgtnZNgNFEjVzEy4Qm1qK/QHjfyhRKyRsAUrtxcjgn/l?=
 =?us-ascii?Q?wGYcYue6GAOHEpuHYd+rJEH1EqBmggyL3rReTPlTpaHxfsyw3BBIjR2Nae6F?=
 =?us-ascii?Q?ir+YUwnvSQOunMxaYiR28KKd3itaf3j0+oksLy4wYkqZwije428FZJPdixRI?=
 =?us-ascii?Q?44jINrqATRV2VmzXsIXxkxRMvzT5foNrKnghWJhqkQ7D08iW4mV3ESB8Fgof?=
 =?us-ascii?Q?vNBMl8UoNtAqZsRMblSPlBrmqIMFeJUhZpFCNEawLTUnPS2opAJECNP4SXaM?=
 =?us-ascii?Q?xrnuqbCsTJLbGqCo0NiOy2g1bljCwasTOUn2xrOhTjNRLDEDhSww6GFGQMH6?=
 =?us-ascii?Q?pVMNRE9LWzRp+YXZ/g/OPWXmmwavOgvUW0bi5F3mGwSWZklzohb19LrBtr9e?=
 =?us-ascii?Q?zB+guHdu4R9JEc/1yJYzeQnSObFyAuKK2/QRzay162CUDYt/pheDcz3DQQAt?=
 =?us-ascii?Q?KTCJXfpl9KkRNglx8TfZpzZHgpJ8CWpfiU5wWXRjBht4M7Qu9+i5QwwdvXE4?=
 =?us-ascii?Q?3RsdPiRQzxIPkdhQu4j11m5Ob1xCHSCJwK8iY/yDYEiaTxVSSbApv6eb7jwl?=
 =?us-ascii?Q?JSBtHvZQDlyxbnRVZw9/VvzIUxyVN9xJnp87YFAg7zVsXnbPgboF8cyq0Iqa?=
 =?us-ascii?Q?USkWF8g+iU1hOfqxiZBZIYPrOS1XBuIyiJ07FXAAXdV9cJhGhYq4GfnjrMP5?=
 =?us-ascii?Q?9mhv7zu9wiDelNgORoW4iGVY3nIP3TRkZxP58gk7u0kmfas86wrKB6ksYb4L?=
 =?us-ascii?Q?hZxIEjg08E2dj2jKCU/eB0togwflygX4LVQJ0jhilTarfg1LhPSmCECDxSn9?=
 =?us-ascii?Q?p008gdSjWr5FpP3X0WijGojVqM2UV/Z9jhTMZ0yhIOXPqJWqwBDRWsTowhZO?=
 =?us-ascii?Q?ixer8zrlkkzmZ3sjsipIMlWu7DfMPcXWk8QStfiELF/MG/BByuoIeP3qXlES?=
 =?us-ascii?Q?Rhrj+psc+X6PfiZgY0AKRxIHYCQcF0iaXMaGl61mqAG/Q2y4mnfGcfW/XQDf?=
 =?us-ascii?Q?8lyqr4TlAKMfVwHFFX/7zRXODIq1N5fCKi2v1gf0QwaZerKSQ/9BDF3x5q36?=
 =?us-ascii?Q?wsUPrmlhwmEWBMNFKwZ8VRhPQrOZ8DLHTmhYxmT+UqpvGU20+xmL2kCg+PH7?=
 =?us-ascii?Q?Izdu3lKRAjw+y6L8DQNIDuH+xGWo3l6FWcnVwiConhtTK1jSuQ4swORy+wM7?=
 =?us-ascii?Q?KIuCBtd3lp4JvlY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2OT8WFKrKRMSfpHKy5otfs8Xu0/eDgMfXnSY+LOcpkJGYj9DmrKnJaFElpsd?=
 =?us-ascii?Q?OwVvFIC8Vi8mrkd8RdOSLPQWCF5W8iTPIZAIgxq7tiNm+ZuVsYw0CFt4vy3m?=
 =?us-ascii?Q?eHGBOEb5VZiCTPNtFxQO/Zr2IOg6PmQW+p+OgqZcjREFAwLqjaSDz/FyEI+y?=
 =?us-ascii?Q?uGRtYyjhEC1Nk0R4EGF95fOQz2TjoGgihbn0iQhvhQLvUxwqCEFKvZninFNE?=
 =?us-ascii?Q?8an/d7805Sh7rQlag0XUGqrCF5SgkvZ4VDoDVTqFW7bbcFMfsAosveBjjc8Q?=
 =?us-ascii?Q?lm8Ig7/KUJo6ad8qYfMdJLinBWmrndF8E++riNxespZtj5OcMuHGJ9R9zH8k?=
 =?us-ascii?Q?8PPMWVUQIfZXmSkBMfwOw4kAXsIzK06tpNHXsB4XMWV1jzPnCdXs3Q4Hnpnp?=
 =?us-ascii?Q?yAbKoUq1PZSFsRpgiwuyAxFDnBBNwbzGp6V7C9etxFMZT9mpTGXnei66krTT?=
 =?us-ascii?Q?acfQgeLqoH9r+1t6tAr73zzHVLT62AtQ5Fz+l5AFL36myX/L2EIaIC37QGUb?=
 =?us-ascii?Q?U5YlI9yfnpoAvaO9FMIeS7Ky60d9DWrEq6REV5/uBDs8G/4i4GhUPnBMK2QU?=
 =?us-ascii?Q?aaAP7o/Ur3AALQIqWDTcv7hXAU2D/xYAchZ5QXmjwnhzCV3hW5GCXO0uNxYe?=
 =?us-ascii?Q?v6uKj88KQJC6Lu7QHHpVS5BaNb5Rwe0bzdw3bgfGSwzR13FACjhcNgur8Nit?=
 =?us-ascii?Q?xL3QuwqojQynlsRsNaAIohyQi8F4Xsn3bEPtQLkeexDJhSl7QZUKbS0fCWVk?=
 =?us-ascii?Q?MwFuEPhHvBlj7SragHhz40oK2Liw/vRoczMMKxkxTnhmKtNqkAWvm+Io6tKc?=
 =?us-ascii?Q?SwwRroBIgWYS0I94LFaDaKa8NgMdnqDVW90PTOnccNhQDA15YaAS/75qf1FF?=
 =?us-ascii?Q?SAlyCIqsJYX3xqxd6zaq36qpaVMEVwzIslSwKfRfJu/BfvrxSsXoTIU/NH6l?=
 =?us-ascii?Q?U8kUo2wRwiBqrdAE6BmH453IISxiTWWGZDYexWulBxTlI7vOZOE1Ko6xUq05?=
 =?us-ascii?Q?floP7HVh751+guC91OWZiN6KHeY8ucuIssbsRc/fdhx9TGdnSXsEDJn52+Il?=
 =?us-ascii?Q?H6FY7edjd7BavzH8wA/pFqg+jS7nOPOrY8F24qdCCckE5AP1q+Rb8JxXmA0X?=
 =?us-ascii?Q?6IuNT/DvsADgNg5IdQ59sO5ixx6NjswfSYfce3E6KB+mrUhPoPOvoFvlWdg4?=
 =?us-ascii?Q?dyDUfUqy5XsDH0+txKwRYbvuI9xNJnSR1YauPCF9LGNX/5n3URVDYaqRZJhN?=
 =?us-ascii?Q?jhubvdA4WvitFDaaxlr9ewsDxITU06lC74avHHmSc4l4CblF79NKdXgBboXK?=
 =?us-ascii?Q?+sbssPy0lW2nHUJNoSuTt/vnnIiDSwFyn+qLDAkGWTOGE89d3xc/ZTmpBEhU?=
 =?us-ascii?Q?CkKCHcIbrf2sWoJbJxHK6T8KVeo2tqa7J+tO986KGq7D8512P4pcvOJ7hyAu?=
 =?us-ascii?Q?SuLczuZZn/B3MncZw1BZqbq2pA6h4iv2jgTroOI/dD1BGGoVQxlwjAtiONAD?=
 =?us-ascii?Q?4vAiDuekBPCYcKn5DRFWgIagzyLsKMthbRPvirMAveu27XLSqUHZmrDWDddw?=
 =?us-ascii?Q?dFnpyoaUw9iHkNH9tIbm6CN5R82Mmost+DmO62Sx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2231a736-cf29-4338-89b2-08ddd98832b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:08:34.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlgYOpIya5/Jauc0jAzU/q3RWKXveRgqcR/Jx9nCFZoA8L9UigWm86EMPAyQ7a3QAAxkzSTMTDQmL/LGW/2pYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

For ENETC v4, the hardware has the capability to support Tx checksum
offload. so the enetc driver does not need to update the UDP checksum
of PTP sync packets if Tx checksum offload is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v3: no changes, just collect Reviewed-by tag
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6dbc9cc811a0..aae462a0cf5a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -247,7 +247,7 @@ static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
 }
 
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb, bool csum_offload)
 {
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	u16 tstamp_off = enetc_cb->origin_tstamp_off;
@@ -269,18 +269,17 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	 * - 48 bits seconds field
 	 * - 32 bits nanseconds field
 	 *
-	 * In addition, the UDP checksum needs to be updated
-	 * by software after updating originTimestamp field,
-	 * otherwise the hardware will calculate the wrong
-	 * checksum when updating the correction field and
-	 * update it to the packet.
+	 * In addition, if csum_offload is false, the UDP checksum needs
+	 * to be updated by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong checksum when
+	 * updating the correction field and update it to the packet.
 	 */
 
 	data = skb_mac_header(skb);
 	new_sec_h = htons((sec >> 32) & 0xffff);
 	new_sec_l = htonl(sec & 0xffffffff);
 	new_nsec = htonl(nsec);
-	if (enetc_cb->udp) {
+	if (enetc_cb->udp && !csum_offload) {
 		struct udphdr *uh = udp_hdr(skb);
 		__be32 old_sec_l, old_nsec;
 		__be16 old_sec_h;
@@ -319,6 +318,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
+	bool csum_offload = false;
 	union enetc_tx_bd *txbd;
 	int i, count = 0;
 	skb_frag_t *frag;
@@ -345,6 +345,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
 							    ENETC_TXBD_L4T_UDP);
 			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+			csum_offload = true;
 		} else if (skb_checksum_help(skb)) {
 			return 0;
 		}
@@ -352,7 +353,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		do_onestep_tstamp = true;
-		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+		tstamp = enetc_update_ptp_sync_msg(priv, skb, csum_offload);
 	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
 		do_twostep_tstamp = true;
 	}
-- 
2.34.1


