Return-Path: <netdev+bounces-236145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A656C38D47
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6858F18837E9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F722ACEF;
	Thu,  6 Nov 2025 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MAKbWqC6"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A8145FE0;
	Thu,  6 Nov 2025 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395235; cv=fail; b=nDmPlbOxANsXG21HSXDQES/JKvlkPhCG7NJMJmX8rSbk8DUGCufJHJxJW3obtVtYHqf1bGMUlsPHD99MKT7uuHIyTJYvTC7w+vuiF2YrCFA7+JHIIjsScVvd1SUwUq0SMRS2rc0OAjsiGj8mYpRHIJTTALxCcnYWR6XVL00MU3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395235; c=relaxed/simple;
	bh=KF1M9agGgY5sqMYGNQmRb8J5zEATnDJr52p3JYj6vDY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WCot7601QdZYqe5pu19wo4GdKqH17nnutp9+SPYCL7pB8zPOAQ2ZK2Mo2t4tRKwaHv6VHlP8cFGPP1yZ03hJ5fZ+K81Pgq2/PJVv2T8hS7k+nEsfHmlCCNGIVk/sHFZWj1cCFck39aEqCjARzCI7brYVJcYIMdqq0Ux4Lo/HoCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MAKbWqC6; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz+2of+h+AmPuLJ6LrzgR+kLTaXZkOCyeNSzQPDLQ6j1T8lYfWVKGlOSpj1GqS1bl4WgI+bOzd6u31KUCmK0m2NP8exNJK/DRw6+A4Q6Y5L1DCvNLqJU4z2lERsNVQx8eZQWQcV6lqXRjGcX2q9IpVt3/MaCuY1ubin+qfyif4WjH5turlNXnVy+Ksuc2em/HpS8VnKiKwQnKrMvaTX5U/bMJteNNOePTH97OKxR6jZ9xxUbQoPUguWGt7MMDSrkP8d6Dxm4y8NqST7HLXUY+aC1apdv4jZqDwxj4oA7w/HXAJD9Yr/ji5+y+R8wh9fquKbtqf1lQlND6GvNenLrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zL+OsOmD4/l1JfTKnT9jBlkd1EzV5R3mMXiijcicjE=;
 b=vqS9tNhIx+BkxB7BcwtarbUy4DoucjnVF9WVaF45U18jr0RCXzp8qnBA8vouxkqWXhkZp7yCHakpSZNz3dikMesoYrqiJf4e7ue8FojhYU8oDPZqToiyz78BPzZp/8VXToxk6W83AT1Onfn1Yu4/DABc9adRNcHoQkEWsiHm+biuN6RtHWseVMIa0yPi1N1SMPQf8CNHT8SuPhjmw/CmEvmi1FdUbNAzcav2VxhbYeoys2ub9xJHsHtrJurDywEYj/qDy3ailqGc6usq+3ucmIEGSGMW5JQ+1Hsd6L0uiUGSkBYbgQc5b13rNTfks0/6jHSvqWTX1TTZEiAbo+16cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zL+OsOmD4/l1JfTKnT9jBlkd1EzV5R3mMXiijcicjE=;
 b=MAKbWqC6sdNMbKU3Evqr72QywKM1HtK2HZhMWPQjHdmq25ObELXXm9iIPB9C8DqDj+75v1CZ9fWx21q4oJlp6bwuwl03F+hsCNUs+K7TtpHvN5W0vqzslD7pK4tgVz23uNlH6qaKL77UmjN1BuY04D+cWD6MtQ77sYPqJqMTH77NodjWPtt99MVjJ+z+AJJeA0eqkKW/giZo/u9GAEniDntF3Cccq9Jh5JKIHr+Dm1dbGB3qFRSgbi3QjUgmuh5jR6ZngD9/sWrEVTCsk2TUGmhz/hO3wOad2OQlpagqozAt5xb6I/JOpDAQpyHOSXtVC97eq7uLkHrWGndPtGT/ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 02:13:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 02:13:48 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: fec: correct rx_bytes statistic for the case SHIFT16 is set
Date: Thu,  6 Nov 2025 10:14:21 +0800
Message-Id: <20251106021421.2096585-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 784a75da-5bcb-4af6-3ae5-08de1cda1ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hKrTIrjrsEAPfG0L4oPxeA66Z1gTNV1ljBlq5avwq1Jk4INH+uNTZB0Uw9iK?=
 =?us-ascii?Q?p3JPAajW0yCTVadcDf03Aiqgxcdr9OrhVzrTVtn6sdCsa8XgCnYvk+Akt4UH?=
 =?us-ascii?Q?omlK5mSWkSgPham+rCwxjL1Y1pnNqainJAKxnUFfZaJDBms65nr3TRllIWXR?=
 =?us-ascii?Q?U+O1ThDbddkm2Mfca0NGgklM1vH5d50/uasXz3Ucbv6aUmy56p/8tWPibuUi?=
 =?us-ascii?Q?8JWYA8N3K/bCzVD4Ezxj+yEX6VCygvMfJMxkOmga3I7UndO3m3CqZ8Cwfncz?=
 =?us-ascii?Q?cGryx6i2fE0g3TiDlxQIFuj7ebWBl7qojbe88X49KT6fy905mGQcTlPmXYec?=
 =?us-ascii?Q?ChXdaQcxWvpdEaqRKn+10vkpdiDfDOtjrHw8/TNMkKIL4DBXEA08WaR9/Upj?=
 =?us-ascii?Q?ZSggYqrB2v1c8T2CL4itHSVIGEz/xGI/mrQMAzVpGA0fGqmAsGTWkXUZh699?=
 =?us-ascii?Q?Oary4uKwjbbXWlcDV7/fyFy0TvyiLdyEDLdkI03lTDOdJvzgW+SYR+EsyDB3?=
 =?us-ascii?Q?vVkKxJNE3aeLngBngYPV/ac6CFpPgRsKck0/ZTgCv+4D4NFuKi80+/qbBY4i?=
 =?us-ascii?Q?L91os2oliDIQ24T9BSw6xLQgOZ8+5xUtPt06H6GX957uVbTNnTi6qfw+uReQ?=
 =?us-ascii?Q?SuytbKqwvVl/ggzugKFFmmUABR6T/LxNnZ694M/if1TlrYXC0YDHoa6lHQlE?=
 =?us-ascii?Q?r1UQjqEBAChlb1YRzcB2ZKHmncAU2l4qM7Nv2R1TZHfcEL6Gikd7ZwCcl5ub?=
 =?us-ascii?Q?qOuXMPyyyUqM9UkVR6G60jXrvpoIfFjYXmo6kfDGWTKs+QtrbhSHIi8FVuTV?=
 =?us-ascii?Q?jhEyPi+KIZ8ET1p3OgLUm5bxxRXVtc1nPoIQN1nA6Fwyin18LUzf56Bs1NAA?=
 =?us-ascii?Q?hHUXjVtxoW5b2lfoAWawuPsaZfI67KP0+Xidi7FK4MMq1ii4gKYx00Jipo9S?=
 =?us-ascii?Q?B+8/8T1AhIAcAZFqrXU3e3AQDBmilEIjKHsYEGHj83n5DB7/K64NYoiyuhjq?=
 =?us-ascii?Q?enBDTdnKAPLn2iX/DXj+l0uMzluNZV48bEdhy1KnJNHqbimGoO8TLogogbeg?=
 =?us-ascii?Q?W212HSq3ffc99UdnpGwTHUX+xTCG6Z8HLYsulWSFGm1xhUCfPG/UxRqW4jzW?=
 =?us-ascii?Q?eu3ssJaAlBjIubC3Al8rA/Y+E+bKS1p0k1bTo09EdUpFzGPLNFxjL+5py8HX?=
 =?us-ascii?Q?Jw2e6RRmAxUWmSUzwJ9EXcxNZDaEoIbw2gY0uxAJpad03f6pawH4OmhMtqxm?=
 =?us-ascii?Q?FeejyjgGhMhKygLZ6lrBIkGsHW65caj3OiDpTs/QBvlU8Z+Fwd9rKGnu3bjz?=
 =?us-ascii?Q?YthNe/xxM/lbu7/DMQTZOMYlFo20V5FZjAOZBxpvzVS35jPFaoyeYwJLa+Bt?=
 =?us-ascii?Q?fUU2xH8IBdAp59tGA8ZO5S0wks9CvzmsOcIdr975FWKG6c5ZCaMvobZagKoE?=
 =?us-ascii?Q?Gn3U4KjWYapS/eDwjC6q1qr1kWE9Y/QUjxczVXZtaE0x4AywD8bzOU5j5r2L?=
 =?us-ascii?Q?tjOUJMUPkOMJar4VyY6/2aayNLodfvvJ0xvF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QO/vGfmU+RK3zVjZ9wGIfYAWVWAL2SmSl1DiGlGh1JqWUR7kigX7UWF51Xbt?=
 =?us-ascii?Q?9BLaMDfdEhdHuGS1D2iF0g2vyd1LwaEkSDxstuSIiS3ToK03FaVvLA6NjJTI?=
 =?us-ascii?Q?tCfVR1O+6MpHoRNVQUd355i7cEhalNKbcDtN0uEDRPWHELAGaaMeXK0viQhS?=
 =?us-ascii?Q?zhvHZpBlqOw4WLfmSVZ48NG8quuEBjR3ZTbih4/JRD1OKFGVdftCJ/nF5gtL?=
 =?us-ascii?Q?ZPtj0hqLh47VC4Oed7r6ck+U3Ad8uRCGps0EfOHfN34KwVpPWjgISFm+ns85?=
 =?us-ascii?Q?s4G7DtWZ7298D7cRkxD2rNxuhouU+5/dlyG9F1wc7A3Njejk7y3wpuAVpASP?=
 =?us-ascii?Q?Q5PilrwlONcT2JA8BX/ANx018JJlwyGCqTFlCAF7aMNzCM99b/reiki9rg7T?=
 =?us-ascii?Q?Mk2QycQB2QgEL8K4hXJ/87bq4OnYhXVpX8UbMIU6M3QH0MdMfq90+95jKfjU?=
 =?us-ascii?Q?2o+dCwzge+UuXl4usUg5sudVoyg4wC5u2IpomqvMKVvbKBBhzAneR49lhs3w?=
 =?us-ascii?Q?HvHReMu8WP9LaowgC0jgwIJ5AEJIujMWimPhhUBI2tng8QaMe8QnYmKMQRdF?=
 =?us-ascii?Q?Nr3GzCrQnJv5P1U/pPWKLak8XjcE6ZxCw4Z74L57rV/xYro8GXJNjmQeIkD0?=
 =?us-ascii?Q?jpsvKiGmWibipM38tS718o9JGRF1wLpcSAYRUcgoF4KswxTyuQCwvphNC1qf?=
 =?us-ascii?Q?ryLTSi4px2LvSy6AhXBjX/UuTyIwgR4hO2mdiEs6a04IS+wR9clmjPrL7tUw?=
 =?us-ascii?Q?Q4JHBs8r9eCq790qHbawcJSiPzP4ILQ8sFRbxaN55AkhyEjj0ggrixJLY2dK?=
 =?us-ascii?Q?p7qzoBuz7a2zXOzIbs+REc3W51gKju+tQlxLkpsvLhh97WkoK9LbIZVu1OTb?=
 =?us-ascii?Q?KL6smdWMVUyq+z5j1JdD1+MqjhDRNPO365xKBkwLKbQEo0mxssmIKpftGdKs?=
 =?us-ascii?Q?EvxDZSCTaMFw1eMKPz91L1vNgIz8lSsbH1B2tQkbRkl3MzJfxVSDbnIC4Bjc?=
 =?us-ascii?Q?yGvaShyAmHSiRL0xAU/r0orlzOKmuONyP2qK6FFzgNf3hc6JlRyK6nGLXEIg?=
 =?us-ascii?Q?H/LAMQVWvnf/01RzESLMzGGOJ1ZOPJq3evD2MYPNdklmGin68dhdJA59mnD+?=
 =?us-ascii?Q?IxWwNdqyaizOplWe1lp1LXF8tnPMT3S14bb1n7Focu7u5B6+SD22Xlj1Xxc+?=
 =?us-ascii?Q?F7BlQy0Yq1A3Bng6puvSKLjHioWlU0jyDBtRDLV10CbSpkEqarkV4GW5TBNF?=
 =?us-ascii?Q?J4upDEYZtPtU5n57LqkX+FpOo90foy/gHvmO1pjPkZaiPd9r9pwudwtNQJE4?=
 =?us-ascii?Q?RhyG3BBzzfC1Qmva1xYgzfdXJBr+VHnyKE2VuPUbfcRVyrCsMwlyo/flVvIW?=
 =?us-ascii?Q?Z/sYV6UW1T5YjaFyH7OP1Q32WpyhV7+4I1BiWFetUQYdn+jhv03C1NrhJ7IM?=
 =?us-ascii?Q?p9trTKnpLi4/LQzRun4TD1Vj+a/cdPAJMQajFzBo9r6FUHYRuHbWqZL1/3pu?=
 =?us-ascii?Q?nTSgsZj9421zjO3ByLuXQMkycXV9etf2A2MCB9w3yGFprSEAr4oZODUdLivZ?=
 =?us-ascii?Q?CqBk1taLjWIcxC8bOtZbbQ6XCNH1GldLvbIMVtIN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784a75da-5bcb-4af6-3ae5-08de1cda1ed3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 02:13:48.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJe93sIyxKyFD2fBabzH4XkiVn45CSoQuw+MWDIMNVn3krWRe7DiYaAJn3eCa7RdRN5qujoyzi/0eJUqcZx3Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402

Two additional bytes in front of each frame received into the RX FIFO if
SHIFT16 is set, so we need to subtract the extra two bytes from pkt_len
to correct the statistic of rx_bytes.

Fixes: 3ac72b7b63d5 ("net: fec: align IP header in hardware")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1edcfaee6819..3222359ac15b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1835,6 +1835,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		ndev->stats.rx_packets++;
 		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
 		ndev->stats.rx_bytes += pkt_len;
+		if (fep->quirks & FEC_QUIRK_HAS_RACC)
+			ndev->stats.rx_bytes -= 2;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_skb_info[index].page;
-- 
2.34.1


