Return-Path: <netdev+bounces-145739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF69D0986
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D94B218E3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000214E2C0;
	Mon, 18 Nov 2024 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FM82sYh0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09B14B976;
	Mon, 18 Nov 2024 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910947; cv=fail; b=YUSsuIWDGZF16gFD3DfueuGO20d0acQ0CKYg89voQ6XajXoTiuz3sZe/Szk0j5tq8QJvXVHBeIRoeQGQGP4dEjFiDgdfuHXKNjDSZa1vroh7pL97sfghlA3MwskhN6rb46r1QIIRYsl7WX4JSGG3+pl/zH3aSyT0kZEoIlDNRHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910947; c=relaxed/simple;
	bh=jiMHE4X8F+B2nXCbXCSq+wHndX/xHZEc297e8Qm+2WI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiViRE/wxqnOQ1TtqHQyvMYE43p8YdrhO2UaneCkg2dQMdQ4h3MClkn1Bg6E8DzA0Wl2NQ6VcQknWYwHbK+VfMasmNPXepL8ZCjNVxQMZnM8VUP5xk8FvnCeD/fUlffcDYshDK6u5K+/hwhFSbNQ3M6V+K2WGl35FHFDA20JcCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FM82sYh0; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWuNRVDTZw8BcseYbv0gsukN8GdfG5kC5eZPK8BGA7TfSeLAWmRhe5hElF5k51Vuzd0q91w11H8e7ghUujTBSVdcIPfE1DzRWacyDvV3pKMwlHOH1a9m/8hOlhXCnXNIEGHC/s6i68AB6eBekQ84XSgY/01RgL77IZXNfx+ficF80anj9xPDnY1cpp1woslmM6qzFZ2l9TuyO1pnC/4deYLm1nZBCjSp7G1lnNH3hzQuXM8Y+ymYp3ykkyY4amh00T/GbpZ+kc6x8CtbQ//AHxfrpB7MdC0wE/bLhVdX373K8xaXViAPGDWE0GRO6fQOnY5GFCJsc7PhHfg0lnNNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mlCNhC4y7y5LLKnK+1q4fmiM5iXD+n49KHonHzpNnw=;
 b=sJPq7CC08VRWWU4A0PsERpNbh0/6DJJ/2+U14G5m2s2qF7zvVntaXGZkc7BvdqFxfAJ6Lr4ljXLGtNK7Tv1cd1VHxpYx6yvVar1gR5pmEncs/p2EIsf9l6CaYix6hf/0O0ULtvRATtibNmJqhuIwd1p+PKf/wofZlXi8YfWsJLVY8lebsyOnJiDsdZMs+Evy3+ytm85YvrLI+LQq+at7/t+qJTXAO7Gt2Mo4Pwr8ZFM40dWyvvc/swceU/WKDnELkEthY2yRYlWCmnM8sSL4WzOt1Q/eEekXdzGDDuDOcs5XajIdLiw1OmzcVA80mJ6WDzbPo7DWFYToPcpK5/zOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mlCNhC4y7y5LLKnK+1q4fmiM5iXD+n49KHonHzpNnw=;
 b=FM82sYh0a111zWB6AyT3euAOEhde6pdIQ26GlHBVqqDtH4FDHcOZCGrcni4UhPa2WLq5Wr66xrbJO6SFVXvLvVj23NsIe8K2kRY0KP5fGdRsPgMtoQrRC5KhwCtcHpGqJgPJ5RQbqhHM0flBpsQTZkCqFLsxuPQ3Zjy+mFxiPDYVdKjrAzbP60z/TmiLyjF3Z0Q/DJvgJwjMkDIrAM2TXYKvZHEIdBcpP8xhMX/t2CP7Xx4eYo6qESinewws8yG7VLBG+kk84G4bFrSIBA1Usjm+uPY0mxNzXiyPgpI2fkCfLhqeovX9stk76b0b950YZdMxLOD7xGng5LhevpXS2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 06:22:22 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 06:22:22 +0000
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
Subject: [PATCH v5 net-next 2/5] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Mon, 18 Nov 2024 14:06:27 +0800
Message-Id: <20241118060630.1956134-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118060630.1956134-1-wei.fang@nxp.com>
References: <20241118060630.1956134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 385aecfd-2b4f-4d33-bb87-08dd07995ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fnbWsTdn0XY+BO7jOJuu5/9TVY5bVb6URj7Z1UzpN47TgKAUP1psHn/NHIWr?=
 =?us-ascii?Q?KeMcZDJIW9CG/SbIyYDJlWk3LBFAyOiq+VbuEg4WiAtbt0iTAtsayXlLlJUb?=
 =?us-ascii?Q?F29sZ4ONUrN3f3rnORuM1xDR9L2u7qgflWyfH72JXfjzoaSeNVevL6Ztgf6s?=
 =?us-ascii?Q?upIo0JSey/GtfbU1V8gHMdsRPbzysfpyl2/Wd7IkDfkDZGmIfmNHJ8EzEAts?=
 =?us-ascii?Q?RmkDl3YJQGJdvo5Rm3dc4MKIVjtny7WWxaDEc5zGJ3+ot2bcV2PCRqWZ41ay?=
 =?us-ascii?Q?ldUssB8sP4un5Y1ADfhc+pPu8YD/1zlp7SZUngKUP5giYju16tV3BkgbzjcJ?=
 =?us-ascii?Q?JhsBuGh3v3JXRUpZrzZk5J8lXb75iJWKQQYEQQ3vOQwWNJGDA4HeB0EORpeK?=
 =?us-ascii?Q?NycgjwfFI14qn5LLyTMeJZs+plVsXf9HDQ5227slz7G2/K1HRhM9JHAtvlVa?=
 =?us-ascii?Q?PwEZ4MRJEzzRsoxlsg6YhgEoJawY4YBJwq0OJhxH3TSvlyUgV0XalcCYRlhg?=
 =?us-ascii?Q?Mt1Syuq1h/iWHa2nJzUPrgIFE/0L/Ih/v94EfdAHAutR84iqf1LwuL8WBnnw?=
 =?us-ascii?Q?T9JaVZLtRRRuHr9FkiB9kFT52fW0ObPbuaBs7vVdTXK6rJtlA0NwGR2TpMZH?=
 =?us-ascii?Q?WgWMmIb4Wa+fCjL6ub/poMrquINl77OqBZiHZ9ci+/tGhk5q+ox7lrZGOAbk?=
 =?us-ascii?Q?hgzfFrLRcH5sRxwSfDKZvuJe0PH6JSpKDHP7qsA8NsPz3gCHOWS/tgztayi+?=
 =?us-ascii?Q?9rHk7XDxj3Pa5hXn+3XG0jNeCwPFwElKGdDX31O14VFnBXkrlurZ9Vz3NBu+?=
 =?us-ascii?Q?s8espEes2APKU6vXegHnXDMSF/PnM0/7O9S+2afu4L8UfCLMNfoJC02GQp4I?=
 =?us-ascii?Q?KADfQLW0QKOEa+2tIEeJBFLfrsJNxTEEoJYxNiAjE0suqjySyU5Hm/+dV997?=
 =?us-ascii?Q?byKVD31XIIARyvt6kB6hdDmIG3AeAqwLT4FYjUQhOhU+Rr0nlg7c+Rfg/H+V?=
 =?us-ascii?Q?6ezFzdhSDo+SqFQVohfIVeGdbRsW4Yv+zAF04Ak3TwaMmHE8YZwBykWUtnO3?=
 =?us-ascii?Q?B6TW6DMxrPovEJuC8MBb5+Rv5OFO6hWOJyM3gbL+jvt1LP7cmEy2b07vJOw2?=
 =?us-ascii?Q?Wsp0E9ZysAKKURVrYRp7OsHSCFWBmqWHCrhS5U8kkHhWDt4rQNISL8qiRawu?=
 =?us-ascii?Q?tIw2eXovxgDQqJZ8YHZCTE5DkUqQNj89ZUuop7iXdJcWackdAl+XCgyvqnfZ?=
 =?us-ascii?Q?08vybSEcHjUe4lYwfGpm7u0aCx2DzOVcM9HGbpR+fnesQlBLq0YKyui9cJ1k?=
 =?us-ascii?Q?P3ZuKD+43JKyvltzsuj2AEPX9cL0DoGHG3xndjtI+7otNWkolGpy7ONVD+h8?=
 =?us-ascii?Q?C3hCwgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6NibOdPDgTKPOaKgcSUgtnq+WBLqHJCg8LfjFgkmh1Q0ZJlDLuHe34EDsFrv?=
 =?us-ascii?Q?sA2qryS9xPnBFJT3w8HC+LK0oMgoelGp3QL584m9z3UP6ESivA1yF2tAKZI8?=
 =?us-ascii?Q?hdxG6if3Il12YOb2fQ9mBWvJv5lis+yRBUQQUBaHO1mZOe2yHXf5oAVfexuo?=
 =?us-ascii?Q?pgiwBfpuJLrfJDRva1yA2YXiGifdCOpd6gk7TZ9xFfPyd2SD43vPUYVRCY/m?=
 =?us-ascii?Q?2AbsawZmjiZg/bDcjN+ENuqxUO0XthsSLpoIi604Cjnd9FUO3vWobgiDyL2w?=
 =?us-ascii?Q?tMh+/zwvIjGfALD7XSV+bcs9/MgahS9HdtVAfcUet6bTLLKG/9WvrlY6m/5R?=
 =?us-ascii?Q?OqbjQ87FxaNN3RcrKC1657dxISpR4xTTYsLWzGF7HUHX3oajyADa0EMER/zM?=
 =?us-ascii?Q?H42pweNgsm9yua0srueK70w5CedtyP/QVHxOZ8Qak1wMDt/cOuS2hWo/QCuG?=
 =?us-ascii?Q?cMjqZrUYKKXhUwD1fBZZp/xYvviizMkCyvtJC7tn+MDMIjPdPl+JewrJ5X9W?=
 =?us-ascii?Q?HY/4GQ/Bh19Tef0vQqzz6P9La25ebrw4OnxJU2pkp5SyQryePWghDjhn3P5o?=
 =?us-ascii?Q?1VvwQOzuXEHLZkMImVU9+eWGGkMRVlmmSuHSogY80VlPQye3vfl0Wi89uym6?=
 =?us-ascii?Q?cYXWmxI2aGWzkEhPn5PUrqttd0RWgFbQOsdeKUD/KN+MXreXTJxcrt9B7zsQ?=
 =?us-ascii?Q?VYbYBddXguHe94XeuViC1wAAMtnM/LY416M29Ls0LFSHywvj2QTRlzkfRUJE?=
 =?us-ascii?Q?DJR83Pq9Ij+RDTtT02vvVtAafRbTVnpwlPFY9EubXve6gK/u9TeQ5sGXMtTj?=
 =?us-ascii?Q?xAhrPg3ZfwQ5ryHFsqKrcdJ2fSFjt85rNfvmoECBXPNmaKwQCr4WpIqwb6Ir?=
 =?us-ascii?Q?NL7skT03vmbMdjGW3V+S8+1CHQNOFM/qaHQNF5AgwI292ks2ZGazoVEe+Th5?=
 =?us-ascii?Q?m/JoFeFLhibAEQm16lcicNH+1IRyNjSRxyXv33Bk+jNq1WghlXArVflbnzBU?=
 =?us-ascii?Q?i8aPU0MJmhgSlHJv9DW8GUkc2tjTHMed5rBaTl+WdCSim0VKJoevuUlfimLV?=
 =?us-ascii?Q?XZxOKB0qPOug8+WFmf1ewIltYD760vxNxy/zmANDySysNCxRtZz9l0ZpmhEj?=
 =?us-ascii?Q?a202ZHOs2jQeOFmmpqi0H6GwuqBuuabI0qQqiRNW210GDcLCEEbFL3bbZJ5Q?=
 =?us-ascii?Q?Oz9lq8y5TakOQWveEUpaknakmBV9QafpHCOmTpxtG+cdLY9uhfsHSbNxP0GZ?=
 =?us-ascii?Q?WsGo5hvJxBJO4da7FjNUi/Rq2SSYdEw/mvj60aknzsNe2x6CZGeP3sv2qb+W?=
 =?us-ascii?Q?wrjDo5/8wcpSar0AiqgXwpeIGLzwBjD8QIucXFR+EO/dDlY9RBuPUP3neMQA?=
 =?us-ascii?Q?iDl0neysfCPgfI8Hf0897fY10SUPgS0w+Fral17ef2brlRt0rxOoASC7rX/T?=
 =?us-ascii?Q?Yl6WutxS6RN9e+hlMO1RY5s0ERL7+Yv6H4lmAM2VIuutlAUFzBuqRxdjDItH?=
 =?us-ascii?Q?Fc1q6hoNVgJnMSLUErk2JSKpUSJnDmAqflJRsxnkE7KPoDwJactaHLeQWo/Y?=
 =?us-ascii?Q?9cnA+J9TbzWwDFZEqm/aAfgPqNx0ZsJtvMKlZbod?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385aecfd-2b4f-4d33-bb87-08dd07995ca6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:22:22.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0yhuLq6zXBD+C+MbQ3Q7UlxMuUJJqQTIrEAdMfh4tbQFWmOT/q92+c3luPL9F8vBgqcG+/W8Jp4hgfcO3WmrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739

In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
Tx checksum offload. The transmit checksum offload is implemented through
the Tx BD. To support Tx checksum offload, software needs to fill some
auxiliary information in Tx BD, such as IP version, IP header offset and
size, whether L4 is UDP or TCP, etc.

Same as Rx checksum offload, Tx checksum offload capability isn't defined
in register, so tx_csum bit is added to struct enetc_drvdata to indicate
whether the device supports Tx checksum offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: refine enetc_tx_csum_offload_check().
v3:
1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
skb->csum_offset instead of touching skb->data.
2. add enetc_skb_is_ipv6() helper function
v4: no changes
v5:
1. remove 'inline' from enetc_skb_is_ipv6() and enetc_skb_is_tcp().
2. temp_bd.ipcs is no need to be set due to Linux always aclculates
the IPv4 checksum, so remove it.
3. simplify the setting of temp_bd.l3t.
4. remove the error log from the datapath
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 47 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 ++++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3137b6ee62d3..94a78dca86e1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	switch (skb->csum_offset) {
+	case offsetof(struct tcphdr, check):
+	case offsetof(struct udphdr, check):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool enetc_skb_is_ipv6(struct sk_buff *skb)
+{
+	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
+}
+
+static bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	return skb->csum_offset == offsetof(struct tcphdr, check);
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -160,6 +181,23 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			temp_bd.l3_start = skb_network_offset(skb);
+			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
+			temp_bd.l3t = enetc_skb_is_ipv6(skb);
+			temp_bd.l4t = enetc_skb_is_tcp(skb) ? ENETC_TXBD_L4T_TCP :
+							      ENETC_TXBD_L4T_UDP;
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else {
+			if (skb_checksum_help(skb))
+				return 0;
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -170,7 +208,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -591,7 +628,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -624,11 +661,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			err = skb_checksum_help(skb);
-			if (err)
-				goto drop_packet_err;
-		}
 		enetc_lock_mdio();
 		count = enetc_map_tx_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
@@ -3287,6 +3319,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
+	.tx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 5b65f79e05be..ee11ff97e9ed 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -235,6 +235,7 @@ enum enetc_errata {
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -343,6 +344,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
+	ENETC_F_TXCSUM			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4b8fd1879005..590b1412fadf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,12 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_start:7;
+				u8 ipcs:1;
+				u8 l3_hdr_size:7;
+				u8 l3t:1;
+				u8 resv:5;
+				u8 l4t:3;
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +587,10 @@ union enetc_tx_bd {
 };
 
 enum enetc_txbd_flags {
-	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
+	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
 	ENETC_TXBD_FLAGS_W = BIT(2),
-	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
+	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
 	ENETC_TXBD_FLAGS_EX = BIT(6),
 	ENETC_TXBD_FLAGS_F = BIT(7)
@@ -594,6 +599,9 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
 
+#define ENETC_TXBD_L4T_UDP	BIT(0)
+#define ENETC_TXBD_L4T_TCP	BIT(1)
+
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
 	u32 temp;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 91e79582a541..3a8a5b6d8c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -122,6 +122,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->rx_csum)
 		priv->active_offloads |= ENETC_F_RXCSUM;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


