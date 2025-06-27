Return-Path: <netdev+bounces-201729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E501AAEAC88
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C673A7AF7EB
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D619D093;
	Fri, 27 Jun 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kmw9ArSp"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52C199935;
	Fri, 27 Jun 2025 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990133; cv=fail; b=K9dvQZ5C6qQJ+0z/dSOF9a2obmYqN9Yf/gXHKu4zFMG3uA1HL0dO3B3RKdkBSpUM7SxJu+tgq+Obz6QWfX1iCRqx5Y/v3cAW8zLonCdxk2jfkpzjM9+wlTeGQV+ginKMvYhp28evRqzYgTC6o01GKDx8YXPPTl70piFQOfhcSGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990133; c=relaxed/simple;
	bh=c/Nnipjfl3OBssV6vrh4NHQDaF8xQFq/UTT9N7nE1ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsLHfd5JJX1qUOclf7wjECF3JElCgFBf/f6sdR+vpiC3NxRrjUftHtwxs0guyd5f6lVEODq1XtGr28Xw/ziTnPiUeqhbuEU4ipY2wMY6NBq9Co1CsrYuc9xfDCbQL4dbTNq+WGKw43VBzUfGb0fLOwnQyP73N3XiqT+8rk6JdC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kmw9ArSp; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2LnhhSXNfpaHYke1eva5Z99336unbATHp2ylT7A//A60uMNpI/oLaw+5ViWQDwu4BNEDX8+61mXurPjpurbJ0sfvNG7pgwBbhhVKKajmIAkWaAxLtHIoZuQrAXFZHboYDZWb9UOTKv1An3vysk7Gyo853/sY5GXznPYPFKH8Fh5K3ltoZSVjIefQPRPv6bKtHmZStHzIObmuzUPOlAQ0QkFZGP45YsxyzR9/pDABWeVSz7cXrAJvwPVqsJcDQePxnbdd8qYgjlqYp37FgLJAeuKeLlYEOC8GTwgKxdX+I7YxDbHxgG1GFoap02vbbQBJxb7EdQSHTJNoRYDXDZjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isQQnQrNQpMRUzwrCQfC/3RNlJLEHYTKcFYEpopsAWg=;
 b=eWOtgHWii4np6O9Rtpv0PdlN1FLc31HWLDgyd8lMK/VnGmQMT0MJhQhFZkLKBTTIzdYUoxLQL9Sj4SMR/tnYgZ8Kd/4qsMQVMa2cEV6XViDTbpUQXYKFpLzKGnMHw5lhuC7m2/4oGFKC4Yhgq5vRBin/oeYARdqR7CUm6FDY4wD/VXEdIniFe28Wv1lmD81l0xkUZgc9LKnd1gayZpbHd1QSUZ2nsDFYC9mZe3AUUjFwVcVLeU6+3fpsxFoCV3UADe02LeASTvU9AsaldVPu2R9VeKK5iPk0rROgvqd7n+ixa4nIfhgxmgXZObL0LhXnEnIjp9rb/OGUrN935K3WkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isQQnQrNQpMRUzwrCQfC/3RNlJLEHYTKcFYEpopsAWg=;
 b=Kmw9ArSpFPmEq27E4kKFEbQNWoyLwVJfAnC1a1h9IooPiU/4n6ZYbWnMTZmZZBHp0twZ4JL7JnjSYEatk645CN1mZu4TYeYNUPFy/Mhc8rHEsyxeOLwz77qP0azF9A8R1Z474sIJK6m7WzDr8E8vq81cwxPVBBLoevflj7A4hjKGScbCNFwc6pe4D2xtXI0dkd7a8uG/Jv7CaY3Hqqwn6dDzOyd2FOGcI51SyHH71ZNtYjjWZMI173dicHo/2nPW9lgso5MHPMymEJbsDGr6VkNoh4I5VVxF6hnKceqe4t9/Bgg5bzuyio5GccJXq62pU1fS1tExLFaQVTDNh9ON8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 02:08:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 02:08:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 RESEND 2/3] net: enetc: separate 64-bit counters from enetc_port_counters
Date: Fri, 27 Jun 2025 10:11:07 +0800
Message-Id: <20250627021108.3359642-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627021108.3359642-1-wei.fang@nxp.com>
References: <20250627021108.3359642-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 5634dae6-59f7-41b6-9038-08ddb51f8e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IY8tK1yShq7QS0XsERYPoigNUK6VNAMH7YSO6FRdZxkB2cLewT+iy+ghY4Ql?=
 =?us-ascii?Q?nCPKFO8DGR+/SLjviTrL1sz03Upj4pdDRRgk4+n6kV/F1wxFEC7ltXrIgNkf?=
 =?us-ascii?Q?Wjg5x/X61sX9xFDqPgBXxtAPTJgfGOjyOlvN1gtSWotOXIC6LxgnFz/AUUPP?=
 =?us-ascii?Q?yYY3moBN1STQIfqye5BRxS+XEt81zC7wD66NQtmHnhQZUig5z9MtyYMOZ4+j?=
 =?us-ascii?Q?bvv0pIFX4fM4hk0weHaIX1WkRG3yn7/aQ7W5d4ERbKEjYSm2Tvc5LmoHAbW5?=
 =?us-ascii?Q?i5zAMd426VZp8EhKNK7xNBwlzNRo5/ourW2fgYRyPly6hu8nuZlxHqCFYbRE?=
 =?us-ascii?Q?nABNT24dgKV0deZOLjkhfuTXbjWkjRCz5oUvXf1wJrYTceE+vGSbwXtmmVAE?=
 =?us-ascii?Q?wDAzatqSb02E8ygoeVwkJlLmYmKEh1LEcQk6J+ogcUQtOLazM2DbGJH70FGi?=
 =?us-ascii?Q?3XTpCkwJ5OGsq+oXIi+4HYkwRPSvLZnymAhM2CVq31DUnio7/KHFWkLOGJs0?=
 =?us-ascii?Q?//xGhvo56/WvjtzJ+0gFQRfEl3Ciga9IjBaC1WsXTFIK06VswFBiSWf9tdtB?=
 =?us-ascii?Q?n8lJOgX5UsdABtr9KHnFF1nlWxj4K8rN3c4Kg7PtZxSy80e3bjjWN1yWu76J?=
 =?us-ascii?Q?fBI+vc76B/9x4EEECkmg4zgjL2zwiFu/SBxgOzWRuR9Y7xNrMnqsSkJ4ovUv?=
 =?us-ascii?Q?KHI8+IhtTxIjRTVtSReuJ5O0ViLQglh5woTGFNG9LY0yVxf2FPT/e6+AYozE?=
 =?us-ascii?Q?OjbqKf6sEacOCJriJHVw/QQa8l7dbzMfKK9bAWD3E9catrq2YxnxXdecQXyU?=
 =?us-ascii?Q?7+NrHRjd65UqTa86GUMo8Ne4v6R7tVIiBbovDtyOg3sx7VTSflstQlii6hBh?=
 =?us-ascii?Q?VgArBOfFGNcjoIuc3+ojT1VvwvCWuYnDXDY9IlS0jvZ0eYWXKHC5oAmKPjn4?=
 =?us-ascii?Q?bcfTrkvOGgdmQpUIJd6zYrjwgT5J+O85ipS1At1+zHPm569tTO/bJkWKnZx4?=
 =?us-ascii?Q?GcVpT6Zq8vaD/G3XorxYWR3igS3RGSmu+Dcb9+3dmrB3Ysi79Te/TI3oBG9g?=
 =?us-ascii?Q?XJsU5CSQoA98s4HJD6IN3Gq9RfzY1oukAHlmHkGM2MbhdTycTD0O8rbfx+Yc?=
 =?us-ascii?Q?JnrSENceGvnAOpKu4Tm8iGFAafVL4/xVt6lltIcK2dwlHti+1tAfK6Sh+EvB?=
 =?us-ascii?Q?Yb3cNaIOMLLM1BkVOoILBC4WiRBH5wk19s2dN3iX+JEsxSSSptQVwNF5Nm6U?=
 =?us-ascii?Q?pU5hdnxhM4ZdVDsgUtnpPXDqyGtVAsIjlZYoHw7Se/kKSw40kkr5FrxtibBs?=
 =?us-ascii?Q?zzQrQifHeXPx/jqdr1HWWL2l679bCl6cjF6MHN+IcSv2CF3ekU1kKAF48+hf?=
 =?us-ascii?Q?50PmJkvSopP+NBbe1dI+lOfhYG/vRKh0VOLOpw5AM6d9vvF/r9X5idGYuHgz?=
 =?us-ascii?Q?I1QCSko3TJ6/fLSAx2Ebpxgx7vLHyp4WxjSlINsagcm3PSaU2UtwEnQJGUHj?=
 =?us-ascii?Q?lsKQoxr3zkCqvLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p097mXBmp9jgxj9ZLmHfajF2+dVn+8Txr6xdGX1+Yrp64u69E5wm4Qn/l0Tk?=
 =?us-ascii?Q?77/ScaknnzeNoMwHuE2+LXhfNf5BuTTxknRTKc82+6ZmUbyN2sQvB15hy8Sf?=
 =?us-ascii?Q?TvTXXisUa9njIEEi3qeXETMpWw5LAbtyXFoHRxelbQosrOgm4NNaC6ScRdeF?=
 =?us-ascii?Q?+YP66wHm5G+Ink0hkD9xMf0w1+UrjenaRCaSr7Naznl78GzzOaqddJ7jfMcX?=
 =?us-ascii?Q?ylydeAuix7lCzfTmmSC7thRedTofyXZlknCskbgcMSXChzZ8DFgTKvdKnyYc?=
 =?us-ascii?Q?JoFbHRjJ7Fw//lt9yJLOV+W/sKH30O6lkbtepJ6dSXNgAc5gMv6f3XTleiKa?=
 =?us-ascii?Q?g6sRI3mJYQnIMECRRks51IqLOlX7OjIArI0cd6cb0eeVJU+wuuYR88/ymZqs?=
 =?us-ascii?Q?JwWCTY/t5IIRV8ARLQmNf3w+BX4DMV4yttrLYLrUzRaslS352fZsBZFT5moq?=
 =?us-ascii?Q?0OItMhX1/r1TUuRp+qMOeqN+11uoFuURU8dYp1k/Y6XEp0JL6B1uavgezjk9?=
 =?us-ascii?Q?gJ4jDXINChGyjLLR/6PVY0mXacj2mkn5bL+nOeOUPidGwVq0dtWph7MR+nLr?=
 =?us-ascii?Q?+fB4u7FVVA8QC4vgIoZfneVG8m3Z0zRzJL6qqnYPPisB/BLR4gZ9lhpelLNe?=
 =?us-ascii?Q?rgJIBS2SJeIdyCAXHPnDqbqBTl1SIuGaPdMXdl3m1iBTB2qDBL+/pe2ozoDa?=
 =?us-ascii?Q?EMrAxl+1jCO6dG044YiJ8QsJZ0lhTv9DLzqHYQOaO6ZHLafYIPn1y2wHg+Kw?=
 =?us-ascii?Q?HtQmZV+hAZwjvqEa8L2HB+gTdQZH402k2D7HoKvsLoS1m7vf6BZ8q5gZol6U?=
 =?us-ascii?Q?fSzipNTyNcttTt6XxyGc5G+lHKEQM2i7Y5zW8eI0NGiToPkVwr9skQX7VYWr?=
 =?us-ascii?Q?+s08G8GPbwgtU85pbM6M2IGBcq7IAyBSRl3/C4Ysqmk9hLXBZ0CJcvxEG+Fk?=
 =?us-ascii?Q?WVixY2+xwzOJ2+EDLgJYWPMlLL5A2WGfmt6Gj9bLGPNNTUqxtQbVRZ+MrWtC?=
 =?us-ascii?Q?XSBuaa9OTKQLMYggyX5y93EbJiuobwF13vh4kF7PW42tpTBnqtbv4M8GYVIa?=
 =?us-ascii?Q?6lG9u4S3HHQi5ZPhU2TNvU0qc1gDwjNiJa1Uqe6Dp4yo3RRpkMUbbCdjURdN?=
 =?us-ascii?Q?dwPjDFlLH1gteCIDyHtcuGafJnbz5pkjyowZwGuoBfkvReiIU10aismolX6r?=
 =?us-ascii?Q?pgsS3P97WE3z0Hp6PMB0TyFXpNap8/QCmKt4Egj2ij7mavLdbmtK0WbySfTo?=
 =?us-ascii?Q?14iSwAYE2bNU/YeHCvGpcGXWpnRlTr8suPyah71P567c6qrvedIEDtdXVbyh?=
 =?us-ascii?Q?sfGFUGTUBGcG/QuDQYjaxOQDsnm12HqAvNfgY8Qb/G9Usdw/qadVINBloUne?=
 =?us-ascii?Q?LqWuqz8rLOg8kdXlWllG8HThHsAlLbMjCAvPbUauDIfaIGIZUuqDKqGp35d+?=
 =?us-ascii?Q?ha1f5t6hRBK0EREixE6x3dryvq5K6I1zUnFec+Db708FF3SaErQCVW6rJe3Y?=
 =?us-ascii?Q?I8loFM8FqQggvXmbhTVLiQB9kDkhkfR5iZw9S7krHaLTiPLq6kiXWlWqQf81?=
 =?us-ascii?Q?0qbilPb5mg+KDQu8LxAxGsBocmpWiBSTruIFEZ4c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5634dae6-59f7-41b6-9038-08ddb51f8e07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 02:08:49.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG3Pj4+woapYpwBJs4lJKAN6H8cObXVCW0q8ofGYjVtG666DTlE/ukaukWgFKdu5StjItt/urkWzCFeliQae4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

Some counters in enetc_port_counters are 32-bit registers, and some are
64-bit registers. But in the current driver, they are all read through
enetc_port_rd(), which can only read a 32-bit value. Therefore, separate
64-bit counters (enetc_pm_counters) from enetc_port_counters and use
enetc_port_rd64() to read the 64-bit statistics.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/freescale/enetc/enetc_ethtool.c  | 15 ++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2e5cef646741..2c9aa94c8e3d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -142,7 +142,7 @@ static const struct {
 static const struct {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
-} enetc_port_counters[] = {
+} enetc_pm_counters[] = {
 	{ ENETC_PM_REOCT(0),	"MAC rx ethernet octets" },
 	{ ENETC_PM_RALN(0),	"MAC rx alignment errors" },
 	{ ENETC_PM_RXPF(0),	"MAC rx valid pause frames" },
@@ -194,6 +194,12 @@ static const struct {
 	{ ENETC_PM_TSCOL(0),	"MAC tx single collisions" },
 	{ ENETC_PM_TLCOL(0),	"MAC tx late collisions" },
 	{ ENETC_PM_TECOL(0),	"MAC tx excessive collisions" },
+};
+
+static const struct {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+} enetc_port_counters[] = {
 	{ ENETC_UFDMF,		"SI MAC nomatch u-cast discards" },
 	{ ENETC_MFDMF,		"SI MAC nomatch m-cast discards" },
 	{ ENETC_PBFDSIR,	"SI MAC nomatch b-cast discards" },
@@ -240,6 +246,7 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
 		return len;
 
 	len += ARRAY_SIZE(enetc_port_counters);
+	len += ARRAY_SIZE(enetc_pm_counters);
 
 	return len;
 }
@@ -266,6 +273,9 @@ static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
 			ethtool_cpy(&data, enetc_port_counters[i].name);
 
+		for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
+			ethtool_cpy(&data, enetc_pm_counters[i].name);
+
 		break;
 	}
 }
@@ -302,6 +312,9 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 
 	for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
 		data[o++] = enetc_port_rd(hw, enetc_port_counters[i].reg);
+
+	for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
+		data[o++] = enetc_port_rd64(hw, enetc_pm_counters[i].reg);
 }
 
 static void enetc_pause_stats(struct enetc_hw *hw, int mac,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 74082b98fdbb..73763e8f4879 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -536,6 +536,7 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 /* port register accessors - PF only */
 #define enetc_port_rd(hw, off)		enetc_rd_reg((hw)->port + (off))
 #define enetc_port_wr(hw, off, val)	enetc_wr_reg((hw)->port + (off), val)
+#define enetc_port_rd64(hw, off)	_enetc_rd_reg64_wa((hw)->port + (off))
 #define enetc_port_rd_mdio(hw, off)	_enetc_rd_mdio_reg_wa((hw)->port + (off))
 #define enetc_port_wr_mdio(hw, off, val)	_enetc_wr_mdio_reg_wa(\
 							(hw)->port + (off), val)
-- 
2.34.1


