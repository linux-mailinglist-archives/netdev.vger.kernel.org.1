Return-Path: <netdev+bounces-153232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 384659F747B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E318859C1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 06:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7030216615;
	Thu, 19 Dec 2024 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HwHlB4L8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404F2165F8;
	Thu, 19 Dec 2024 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588267; cv=fail; b=V0+P6N5iZ6g3c5BYE9r3PdkytWfxpLWnFgoRtbx+y7VrdiOzzaESoUd0PwfSSZtKTNF5gNNUIoBB8TvWRAxKLZn/jhto7LRV49wmqFb6B4Kqe+TRgB147u16W5a3IA8d8VQBXpUJDGxMhDas1/hrurmcqc708YfNLd7Ey8wFmS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588267; c=relaxed/simple;
	bh=a1vaJVGEVu4KjYGKt7MtVRkWf5OrMhPGAwTRULgxwK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cU/rrujKY/3yVuMtmWK4J4al8q5O9NCr2rSXpBPG2O72ThyHP1BsVvFW4s7Kj21CR25W+5YZvZ3QdUnSgWkT3STzsIKb2cBBJfIHwEP/VvEgYNANmRTttQqKP3XgCjupTzGT+CTEYCQjLdQKiga+yXh0VWIzbP/3RgQxbIrcbzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HwHlB4L8; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktqHezhtcKj68vJQNps5pVG5Ud/5QbLeg4HfnmlRMNMdBYleogAKlif7vAw5szYADG9Y8nTYF37PgbxRR3ofCH8pRuRJdjZfOsE5i2pO9ScCZXMMuL/8E01e3d0v5wgDsLlCAeCwFNdg24HvGFhDKEG/POaSNtyPN+t26TnTucY4igqNcrW/jlQ8PBs0bEojPCxvi/XSzkLB3f7UMpCH5eyqJS3blHmxwaJOCmab3bOOD7ebSBJGMIyVnNXzf0o5JRFoG4pvKKnZA/R+ajrXNJaIyoKTnEt5oxSLfLQ0mA7qPBb5yWb7oWvAeuPGERtZY7ZA91oZXFs1E+8u/KJB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiHOWP1QonDdpsn0cYnEjM1XSo6OIywstpK5i19FR7E=;
 b=cwkohDwq5UUwl+J6+Ify7wq82L6Q7otHSpiWQ2pY4WSuqGeBxzbEUHA2QhMLEf+yQisjjQQAkAc70vOZAB+6oysvZFRAb6f91ZfrUg/sQssFclyA6hV3LkWfi94Boq3Ekt1SSW6rweaYz4qpw6UWPv/3xnynAaUO51WpnpwtjiVv9Vu6mLaBLGQA3+Vs/e2NLa9e2G0uMiAHcTyhS1UUejujXRYv6OtOScOA8yNaPr8Zlf6/WQiIgTVXnPx/kKSdnheIeaHgIzNnD0ZswEb9VBQhchL5qIEIPQaigjr9lgGWcYbAY0jgmSi1SifIZigXHvK+puyB+khGP8upU+2PtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiHOWP1QonDdpsn0cYnEjM1XSo6OIywstpK5i19FR7E=;
 b=HwHlB4L8G+F23plW3pwJ9SOk4l2iHbfdgrbHCRB6fH5UF+sel5endwvNDfs/dQcRI+lOGAjkTNmTcEVocmsKkMecrS+KMu1ILobImOTjAH4LQRkAX9iqN8mKh1BsWTtIq/3WlEAqMKarma0zjA9w+J8ducSbVt0t9IUOz62vXKZDnNBVL0QDAa9FEIcQiDp0IynKFYHVK9ubuVZJAZkDGM6j1TlbJ2nCBsgY/k/w1BWEHWAeWBDjNxNp5IyCX7VdLc/DKwWp4inqxx7vnDfHUuzW9Wr2lbHmb1DyAAJnaWtDKia9sM2aCKmLYhVAav3RJZZFAJ/DdXtLgPBaOQjy+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 06:04:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 06:04:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v9 net-next 1/4] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Thu, 19 Dec 2024 13:47:52 +0800
Message-Id: <20241219054755.1615626-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219054755.1615626-1-wei.fang@nxp.com>
References: <20241219054755.1615626-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0107.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: d27a440f-5d6c-4877-68ec-08dd1ff2fc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rNb4AULUYUUt688fwR4lOJF4Ip0Pbznzl0oay2JzmN+AUQu0P/H6Fxl+4yQj?=
 =?us-ascii?Q?d50EDGhf5xDR/SZx7K+QkEBiAe5XfqULgo5mbZALt9tA3DyGSJBEpfr8aUHd?=
 =?us-ascii?Q?fwmh6ETLGjjHGdjG2PngWq84IC+WK2sZe/19JkT6+STUW6UjcyYs9fd6DkzI?=
 =?us-ascii?Q?ZYM5Mw4i0JJlvmUoSz5p7NPwe6h0wPzvwOMoLj1LroLH0LqITD9ZIrHmDTfu?=
 =?us-ascii?Q?vdbYrwNlnlI77uLArRVa6bjYm2Qc00aIXXfFMlFBK9KHRCHvcMa7X2x8XGVe?=
 =?us-ascii?Q?5Jfi0PDdz8UVFQt6oHKA1mBwzp/CqZYw0chogIRtyLP5Ab9lxl6o8BSaG70k?=
 =?us-ascii?Q?NjRnmndeX+CTRvT2s12HfVQepyIZ3spz17Jd/CJFUvP1wAXMxO70/gkbEiTQ?=
 =?us-ascii?Q?dpDXJAMypiJmA9j+tL52D8soA2bwyHx0UhxIndev/gmL0Rz7DOPg/N8qnIpt?=
 =?us-ascii?Q?BdcZyR2jHJ+QHxnNofbmN/4WozbJoLVdEXuCPxAsmf2u6kDQez2+MH4Jgxdg?=
 =?us-ascii?Q?5vJN7VCy1bDQcT4nMGxeL4QWWcqm3XPQzHu+RQ2qeCUOup4y9TCW7bvI4Dd/?=
 =?us-ascii?Q?NTDGCzKY6NPr6+D0X864Afx1VixuBywa4r1M5rkbRnUc34v0a5WL/yOjjhnG?=
 =?us-ascii?Q?t8pCb5J1cS8b9MYYhNTglMb0WR53xVltwOaMrNj9I+0HMK2IkJAld48qzi22?=
 =?us-ascii?Q?7tsK3GOAXmPCOuueNo1jFi7357zkYTl9E9b+3n8wmb4R9mlaJkbfGmHi8UJO?=
 =?us-ascii?Q?711H1Kw26qp+oon1dk8H7zBi9GJ8YI/35jym4i+Sevv/T6rkqmLMEIF+pwIp?=
 =?us-ascii?Q?NZDXyfLCBH9Dvtcb8s4vippxfOB3AiFH7xRatGZa4XLvzfhLNaM4f+WsCeOL?=
 =?us-ascii?Q?hKd+NQMAiWVjg/UPSmsdIw2aKw5WJiE0lcEai13FUJY6poKEdw0ZwYXNQm/4?=
 =?us-ascii?Q?GkmEXNBzV63OsmuSZ28Sg6kM0Lvsb2L7/tqztFK93MJcNN6FV1ErG3YXOWeE?=
 =?us-ascii?Q?f0ZpSz1p7D2KZaE/YZOmkLgLhSzJ1Ya1quYmNIA2n90OF/pLnmgo9eefBtdo?=
 =?us-ascii?Q?w7DmXCJl940k7l5duBhIZxHwk4U0j1w6OZaiZEKgwXqWQZy7/VP5CRDbQoDb?=
 =?us-ascii?Q?26K16s4LSsNQoM+/cQDxOIMcWkPv0UsDLbKZ9rnkupjAcik41VNHHwQ30IYq?=
 =?us-ascii?Q?7Ws+Ppc/SmIaJT80xQxUbd8yb5Dc9k0VXf6p30sXbvAIjHeEST2mDvH6xXAk?=
 =?us-ascii?Q?KG1rwM+GV9bj6UOSS3qDkGoJkX+SbByW9ZM7TdihVsLtEhPWdwFqx4bca9/c?=
 =?us-ascii?Q?HhDvYnWSH1JLEFHafl3kqSLo/N5LaUCHsasP9ajMfUy+7VLTXoQlpd5Guyj+?=
 =?us-ascii?Q?pcDDC6dPa9vH2vie3snoiOBosSXhGCIP8rGvgltOKZYdU7Ss0JCHvCzyg9KY?=
 =?us-ascii?Q?q5TrnuQ7OKrDOuqF+aNI6FBnN70UHVsa50mEfgF2Zn8zUm386SaJoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHwTbXCuiFpPBZt2vnKsUWe0M/ROwogOFCSKke8g+IjlaApMU7FoNKEURJ6E?=
 =?us-ascii?Q?KTelMfoo2nq8q1WFieCCx6uiYMv9qWJpikhf9Nm9x8RUekIDEpmdf0AlJsnu?=
 =?us-ascii?Q?mFdzLs7Io038roDYOQndmNRXxfGCpQcMWqJZ09aRC8p6Y8PBNWLppDJubk7Z?=
 =?us-ascii?Q?PCzpT/CqSTRnDj2q3Y+ix59gsS7PTMrP6t0EwEYgRhzklXMSKiX+8UX5X7dO?=
 =?us-ascii?Q?hfevXUKquHplrsA+Qm1a9m0T2I1oE/2mfJ0JakE1LcSf2Z3ga2N4ntDFjs+J?=
 =?us-ascii?Q?s/ahMJB1jT+QFuuHLD0WF0po1PKhCMo/tetHkR9AdSJceOlRGoyXkw5Fzz28?=
 =?us-ascii?Q?2HJJJbaI4a2Vbb3rZS9NExeZ6I5H0j0wcq6DfPVZJyBiTsgv+H6FuKARN0lr?=
 =?us-ascii?Q?/TZ6rRprmkZO3uyTULspT3Xf5AsnfPCoFBS7XT1bhKtCf92Btk44IT3Wt8wO?=
 =?us-ascii?Q?lI5N+e2ipHCRkFlz4ZdZdl2A0r+W6egpM02VsSNKGHCjEZ/Mpco72Jo3IqJ3?=
 =?us-ascii?Q?V+312umNIAg1ujpOFcerkZGEdQaL2XzEHemANgHlqVh+5kITA7CHsNuDSIJI?=
 =?us-ascii?Q?37eAlz4brXIyGMD4r4lnuLQCaScrY3cElQxuxywFKy9LeJmpHL5Kt2Ze5GHC?=
 =?us-ascii?Q?FZyC2khThcpm+nGgYXwJH8PLpfeozb/ixrRAaMH1QsRquHEylhrCV8Ozq6ij?=
 =?us-ascii?Q?y8hIgcaVP/gnzTr3/ktPBv1SKhwctAQWlzBHUACl3zwUAr7QIc6Qy540+19+?=
 =?us-ascii?Q?zqsG1uWUHZnDsCNgHRbCKnrcPCJ/8sAt44YLvRZhf6DYrQS6HIZN9GpaSvjN?=
 =?us-ascii?Q?QsWC9KhQ2bRa1sbU5wqZ3pM+pPmV4+/WxWddOVbvpwE0YMZ6xKyynf/6cKDs?=
 =?us-ascii?Q?2+ykuYl+jTo311l4MjwdNgIks1pL+vr3bd+b2L4ug8K4igQiA14tCKOh7Y3B?=
 =?us-ascii?Q?NyNMXkZ9+qCi8TUfkWPMyQXBPCjRUw0PO+Hhj5VIVRqRqOpL0KJp9IRyOPpH?=
 =?us-ascii?Q?IsAHWAtwBXK6AsVb1c7+wLg6oehCwMUbJ8aiXebthyWDknE+578rdZTI8hr8?=
 =?us-ascii?Q?M1U9LMbDIELxpuEGAk5y2b6yBHYswgQFMxu/lXAmKTb50YkMW+rePoit94UK?=
 =?us-ascii?Q?pxMiUSf2nEByKLn+9vUgWpgNaE+98OQ4isngppn1lELzGN4hw+UfK5IirCsV?=
 =?us-ascii?Q?5JQ893uXvc75Y4UcIaAIHMN5pwPGA4ZNe6kmlRLDBNj7H/Nv+Y/r0iwzkMpZ?=
 =?us-ascii?Q?pzCXKvQWULCKmwAoGYqpBpsMQwsvNrH+XfUhlY57BOthU2zuZd0Oj0ZH64nu?=
 =?us-ascii?Q?xouVKBLr1l2vvN9SmaT0g0T4Kitz8dUrCZspWXoJQGQGJp07hway4MiSQG+s?=
 =?us-ascii?Q?iqp03epdixKBTNOtxL22bSgr8qYnNOg1gKh89IL5iGWBpXYpN8GEkMJIKyLh?=
 =?us-ascii?Q?58YyuMaPe5W1z2pcY/pMHDTVHxAiGDqkYP6m0ychiyV6ol85micnX2+7iUIT?=
 =?us-ascii?Q?Vs2RHDZYo54v+g43H/U0TyOFhbimlFrROV4TrRJELmzWaNCrt2jxBy6ozZqP?=
 =?us-ascii?Q?PAYfeqCni6ON6sfNBBmH1MbpsLz6kaPnXdHE/sdN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27a440f-5d6c-4877-68ec-08dd1ff2fc05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 06:04:23.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anifCuIwlpN8nrT2sRvAI2IY2bcHJ6hodT1kFBEuxgGYkKChPeTUj74ILUHuhgiku1EzfzBSDeYCCusCSlHwMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032

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
v6: no changes
v7:
1. Change the layout of enetc_tx_bd to fix the issue on big-endian
hosts.
2. Rebase the patch due to remove the Rx checksum offload patch from
v6.
v8: no changes
v9: Improve the else branch in enetc_map_tx_buffs().
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 53 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 15 ++++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 535969fa0fdb..88f12c88110f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -146,6 +146,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
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
@@ -163,6 +184,29 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			temp_bd.l3_aux0 = FIELD_PREP(ENETC_TX_BD_L3_START,
+						     skb_network_offset(skb));
+			temp_bd.l3_aux1 = FIELD_PREP(ENETC_TX_BD_L3_HDR_LEN,
+						     skb_network_header_len(skb) / 4);
+			temp_bd.l3_aux1 |= FIELD_PREP(ENETC_TX_BD_L3T,
+						      enetc_skb_is_ipv6(skb));
+			if (enetc_skb_is_tcp(skb))
+				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
+							    ENETC_TXBD_L4T_TCP);
+			else
+				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
+							    ENETC_TXBD_L4T_UDP);
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else if (skb_checksum_help(skb)) {
+			return 0;
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -173,7 +217,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -594,7 +637,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -627,11 +670,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
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
@@ -3274,6 +3312,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = true,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..e82eb9a9137c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_TXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 55ba949230ff..0e259baf36ee 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,16 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_aux0;
+#define ENETC_TX_BD_L3_START	GENMASK(6, 0)
+#define ENETC_TX_BD_IPCS	BIT(7)
+				u8 l3_aux1;
+#define ENETC_TX_BD_L3_HDR_LEN	GENMASK(6, 0)
+#define ENETC_TX_BD_L3T		BIT(7)
+				u8 l4_aux;
+#define ENETC_TX_BD_L4T		GENMASK(7, 5)
+#define ENETC_TXBD_L4T_UDP	1
+#define ENETC_TXBD_L4T_TCP	2
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +591,10 @@ union enetc_tx_bd {
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
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..09f2d7ec44eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


