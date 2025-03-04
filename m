Return-Path: <netdev+bounces-171509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1052A4D4F1
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD12718871E0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92691F790F;
	Tue,  4 Mar 2025 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZCnznAm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACB1F78E0;
	Tue,  4 Mar 2025 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073963; cv=fail; b=YCQ4kmR4/mSBZGr/dg10nqY4gig6761YSjCD+loYrNqe4HxFLQacKrWoYJeunXd+YZGB59mg/bggQJ1OUTq6O9RlPXpZr7PTf6mYE4mltdtXYtJkHpWDJopQhofkJcDi3ouCYap6Q2PZLGZqJKLj6GXOKKMT7K6bgOvv1DnBqDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073963; c=relaxed/simple;
	bh=NufbJZCn8PE2I8kl+7SPK4n7TS2z0AvpJoPweNJD7BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G/1PRGXTwKmKu1L13Mu7DqZpJPwm+imDDpPPjo7d7XezRJCwM7+f8Kxp2Ifygwb5GVq7vORAJGsIu/L/HulMObM0nBw48HaZfa9PiFBzAifuvVuwsCxD6lo6bGSVQOH888QlH5/9ohrNvPzr6I2r/QfzD84+sMjZKPKcu8tfNdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EZCnznAm; arc=fail smtp.client-ip=40.107.241.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGTFghF+CNqKWOUvTJhz+DUlDQZdX3e9kCECxboP0we0YptewdO9lZW8Xk7EcM22wTkz5FK+f/lMyVzWUmVCJ65LxPb9AOV61QsBRy79ver0Jgis82nuhgVY1nvvZJsxZhGVCmTkTL84JSGKiEOkUBBS09YeGZJbMsFEBZ4RyuGAlwhSHjzHjKGbsL+KYmH5UdQ6uj97mQ09hbkGVGsybHmZ9HHQP70c/9i7iAzrK32dQr+MzekQwEcrKY2Rh7GnBrbsy2ka7LGsI7UBgWgX9EWjEow4uvscPsOkTXbrVL4CjHlTt/vsvTTOWx3Y/F0QFvzxiaafrnnUjAwOBsp0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPyIXos3ru6W5Ck1g8ZM9pY1oR/pp9JPZqcgi4Buli4=;
 b=ey5fp2N/jQlVEHc7+Pogv5yQEgleAzykeWEiG+pVjBMBN/XKGrkyRB8XrxoRISYupGEN+8Nle6mS9b0+YKKio5ZTeiBldi7b3Ni+gyzgkR+uqb72ilvntmZCI6VUTWPKWMUIdypr1olEyDCQrQo37XRBC2A/S1v9jcYBOmwW/hGXR5NOOitX7ByaBe033UHDsEM63qqjfjrc7R6xdr0MQiUwFnQ1oSYJqfXcx8LbPBGe/C2rxjkV2asRfhue7xu3urkm0/K/VkLmsmolWmGLtfc+KkgqxzY9123KNW2SiRgYsbymXWBRc0lztnl/qN7Sgl0g1qyNxCgix7IWerRcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPyIXos3ru6W5Ck1g8ZM9pY1oR/pp9JPZqcgi4Buli4=;
 b=EZCnznAm5KQMrMyNQO811+9DpPpdoqopRzDVdyBTdxeKnwcBRs/rKz39zNQj3SOx8pQCN9MJUzfsPIy/BpSOoj6gM62Oz7PYmWdoDFiLUfWIPv1iWQzDjhJUCs67/r+CWLq2jqBBOxh3TEMCDDrlNQRsMMjruIDEDaMp89KW2EE7llISwsXqwsR1Ds4kBvSrzKJltP2LadZ+cptSsG/6nr49T3nXHWdKh0nSuusJyFPF661EuBlWEfUODzQIbL7H61QqGumy53pMTdjR5GtJ23SNPK1vehe1xW8xxe9UKHSMUgxOWUFVBBAIVH8j3Ijp0gvP6cmSR9e3Dij2xDio/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB11171.eurprd04.prod.outlook.com (2603:10a6:800:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 4 Mar
 2025 07:39:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Tue, 4 Mar 2025
 07:39:18 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 00/13] Add more feautues for ENETC v4 - round 2
Date: Tue,  4 Mar 2025 15:21:48 +0800
Message-Id: <20250304072201.1332603-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ae4fc9-1cc2-41ce-5234-08dd5aefabc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2z0p7Y92gmxxi/fIO2O6ikxnX6ldbug23e3tvZMTBnbiCTzbGUY/Sb/iWkeU?=
 =?us-ascii?Q?OZwY1O7AcHtm+Ch43FD4jRSBi9rneb/OcJi0peDCA/WBAO1nS893bPvxoJfF?=
 =?us-ascii?Q?NDERH/3xG44A3ka81j98/lzam5HNcTh0HRnoH/0+YldVi0cqLwWI5ZgURYVB?=
 =?us-ascii?Q?ptUo0x6NYQG9riACBXwSWJUUcL2m1MZfNaTWRb6Y+vci/oQYVRHWguCCt16b?=
 =?us-ascii?Q?e9rh8PaOyjkWlJdZm2xOPtiNJGRtNC5BF1vXjQMPbEZ34HcFR4LBBJ1bUClz?=
 =?us-ascii?Q?FomvurqZNnFTGsdAQt/Fl+/qJBy+r4BplnOdUMfaJV7nIP/Y/55zLK1nKP2K?=
 =?us-ascii?Q?aKkD6ZlSoV2PuzNAC5V2FHb7+YiLdZM/RlS/RWnTOGigg5eDb0lcKFYjaKBu?=
 =?us-ascii?Q?jB5bqIPwo+aevyf1DM9Dv+a86f+ojQhHJ93wcuZ0RtNme+LRBjqzp8PEPNyt?=
 =?us-ascii?Q?g1vr6FGJV4tPBnNrBRxljcrvhwE6i8olaCHSZqNl7KsLBnsouCoz5yhQhESy?=
 =?us-ascii?Q?2h51CyrLqK0nETJymdWGQkokfCISWmu0/CR5z2slMGWj5L7ZzL96SkFq2NzR?=
 =?us-ascii?Q?LGX7HZUcSfy1k7DcTuQQ9N2o4DYbDnjYitZP1Br7HKhekqWb/BHLG1bmxZbn?=
 =?us-ascii?Q?6b5GkYMEsTd+Nv7C1fSN2uU3DqiGnkwuANV+ukTeeBJEKIk4VWU5/2X521Bp?=
 =?us-ascii?Q?CEPQtknS/rBsap8SiZFoshdWz0wiNoQOY6WGF//A2wKI3lzgcZCofntT6Ore?=
 =?us-ascii?Q?Yt8O8JMrzadfINKXtNeUCa69iZrG0kyVPL6sTDhD9tBJs+Pwnqn5ZtJIyBj0?=
 =?us-ascii?Q?hdEV+/3suxC+Xrj/w819oL62swU5r9qIcei/7nA5uNoraL5fjsJp03g31wya?=
 =?us-ascii?Q?8cgJAlX7b457El8bj4YQZTripurA3fDRQ10Ya5Dj0X6BczWRle9pE7UDnd2Q?=
 =?us-ascii?Q?kw5zGLqw472xvztflRaFgVBl3m4O6VU+OLb28LRXYKJo7KcvE+HDdyzAWjGB?=
 =?us-ascii?Q?VharK0nY7SdKQ5atfayc+KZdz0KkaqDQmqyJUKq/yWnrl1a+YL7ugu+RigsV?=
 =?us-ascii?Q?2Tn3o7QcWIREQMpUtmQsigPp3CzJfnYQsNoe/eWnqEInn+uGZxc4WaDFhPUP?=
 =?us-ascii?Q?S9K8I5TbRQeWa/XDtCHY1+rZz6eQjZtrJBwvIoWsw1b+gV8mjUt+6QQeeddB?=
 =?us-ascii?Q?ZaNCfGAiMGdjYsU+MhTLWSOBXPHsqp+5q5OM7+PHtCQ1fYW0pMo0F+B8+GAo?=
 =?us-ascii?Q?WUtmymqsgsv3lGZq98jnX6xqt6G8dgSAQ5Yf0W1Ux8sd9myCLjapqtAVZuBF?=
 =?us-ascii?Q?06l1sPHla0PvqI4e94lQhga+1MTXWjtc+ArMeyajXXYJhU/sZ03EeG6Qzprk?=
 =?us-ascii?Q?P3a2dIp81xKdEFRRKZPZjP6ybL7Tbl8Bc9mEXgkE1BGMExaqSF2UAw/AlCVX?=
 =?us-ascii?Q?UjlHlutsfiXAgkZrIcGmgN3esYT0LHdQnnZZ2qk2u0tAveqSMi4PUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJlFIDqSbU2w7fjLnw4eZbzZKWXX6f+26zyUDmmObraQq/nwED2lWHLy62l4?=
 =?us-ascii?Q?KVmQscwwC0VmRkOQebX6Opp5H12uU6LSzznr0e0R7e/Qyn6qSu8MNkVgQS1K?=
 =?us-ascii?Q?mPRU375s1BUnbN7WoaMcy7bQSXdSJ5UNp9mHLVft1tF76tPiOZoCrB8JTLTO?=
 =?us-ascii?Q?KobfOAkvTm1rdt/7AzKlwRVbtnJ9v1Q3DFr6+MDZtTvs66Xx6GmXIRRtLgLj?=
 =?us-ascii?Q?FCYpXlFWio0PjLMR5X/GfO/jjbp1D6OgQ7Ofezt4fspAWrdxYHesmCHBwqnm?=
 =?us-ascii?Q?L9Aa9Mum2dLHvgDynhheXN7DNLezXBHj05RvtRoU62/0RXOZt9+4dldQqMp8?=
 =?us-ascii?Q?VVcimV6v/dZi3h8H8X46YuYitCOfsuN9Msma3ORWHHp1Zo3SIIGmqTwNuPg9?=
 =?us-ascii?Q?SMS6bG0+ooCKUocztndwVPvpR6AlorMdCmPfjBl2Zxj7C5XhzvcDPQjh1ULP?=
 =?us-ascii?Q?XQOwo+72aNZsRJeY8M1bw5YL0jB49g0oQBiz1l3Ys7Exe1+gq9keZdCk7hI8?=
 =?us-ascii?Q?+g7PQuD649eiRx5hQ3geRDEVyHKEiqwfEtuIuh3jBNGzFp4MknjcHHSKXmSN?=
 =?us-ascii?Q?Rz6Hj+R8WYaZoRrhb9KNAVBk98vGIFdWUiP21Qu5GD1SNVGZOiOiTyy9hZec?=
 =?us-ascii?Q?RuwabgC4NHACeLs4J7nHDk99IldM+a/M15dXtldg1oxpPkTIg81uOyknUqk6?=
 =?us-ascii?Q?OY+q0adwycBt4yfUqbTdsKVfz3TfbuHqdB2BmMbn+l9hP4aJc+EiS0UP1XfM?=
 =?us-ascii?Q?9G0l3u6HxPN/XkRgP1x/5+vTVL3jBwnBywRBASQMFdynnLzGBO9stwPnEEZu?=
 =?us-ascii?Q?S65+vhObdgKm6YeOVmJt6moCd5byCM5S71WRMhMgAI920cYRElktKMtqpOQE?=
 =?us-ascii?Q?Wl3Bk1zR6M07KNEr8jPerfMiLtmhyVz8YnHC9SyVNjJeoKPn7OV9JAsScZA/?=
 =?us-ascii?Q?6nH8kXx4BxFKZ2sh+h6zJYDlVc2cwn2COx/jJpoIUkAhExOKLhvztq7JWm4N?=
 =?us-ascii?Q?TizWzJzJDpVZtcsXtFGUb4NCMoE4Qj9RZUTG3nm8BsMagxIS9EoLquqNUfWJ?=
 =?us-ascii?Q?Ah1P/zvAxhqg3fWklG2b6HUJF9nYQqUB+/lZ9fjMK0/zXy/7R1FPvnLMGl4a?=
 =?us-ascii?Q?wBHBeymd9xZPMAykThg3VmCqBxfxqq0FRVKHFm0CcRsxQyEGoe/iAo7a4Gqe?=
 =?us-ascii?Q?frcIMonxuHcTpn08xLMKmSkdI/hqtOVw7R6T2D6GcTNmq0tv/iSW3q/m09Hy?=
 =?us-ascii?Q?nsf+qUourRpwhiJxlowlYj60V++0+Dm0vMVWuArDLxQyJ5FNhEWA3gimGooZ?=
 =?us-ascii?Q?uzMa4p5pUtntmls7pJ0psElIT5eMm6aPuyQf+slOlXIHc2eRio8bssrsphuH?=
 =?us-ascii?Q?RAvxASXzwcTtwRpG47SDhq11BlVUjmrl9E3NNatoAQzcXRO3NIYh/XTIYhx/?=
 =?us-ascii?Q?HFgg1FX3upV3o+M78F4+hIG1zlRi4RzH+CfsyI/5cm9cJcfHhYxeW/OvvG8A?=
 =?us-ascii?Q?8d6qqWrSiLEXvD5MLMjfMWAbdHfrzoo+jsd7t2KtuvyZ/8GI9C/kJxreVDQc?=
 =?us-ascii?Q?yyG+W1pePMLsuPDEcXk291W5ziFukWUJsjODBfsD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ae4fc9-1cc2-41ce-5234-08dd5aefabc0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:39:18.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0ZAsTOrlr/VPMrl/WZFTfk1DBXHJ/yWII2ZYvUxjW9B79tEH+62rAT3qG6SFTux6TBBXlrE+GitVaY4/wqfZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

This patch set adds the following features.
1. Compared with ENETC v1, the formats of tables and command BD of ENETC
v4 have changed significantly, and the two are not compatible. Therefore,
in order to support the NETC Table Management Protocol (NTMP) v2.0, we
introduced the netc-lib driver and added support for MAC address filter
table and RSS table.
2. Add MAC filter and VLAN filter support for i.MX95 ENETC PF.
3. Add RSS support for i.MX95 ENETC PF.
4. Add loopback support for i.MX95 ENETC PF.

---
v1 Link: https://lore.kernel.org/imx/20250103060610.2233908-1-wei.fang@nxp.com/
v2 changes
1. Change NTMP_FILL_CRD() and NTMP_FILL_CRD_EID to functions
2. Fix the compile warning in enetc4_pf.c
v2 Link: https://lore.kernel.org/imx/20250113082245.2332775-1-wei.fang@nxp.com/
v3 changes
1. Rename ntmp_formats.h to ntmp_private.h, becuase in addition to
   defining some table formats, some macros and function declarations
   will be added to this header file in the future
2. Add struct ntmp_dma_buf, so refactor ntmp_alloc_data_mem() and
   ntmp_free_data_mem() accordingly
3. Add the setting for cache attributes of command BD Ring in
   enetc4_setup_cbdr()
4. Remove __free() and scoped_guard() from patch "net: enetc: add MAC
   filter for i.MX95 ENETC PF", as these cleanup APIs are discouraged
   within networking drivers.
5. Remove patch "net: enetc: make enetc_set_rxfh() and enetc_get_rxfh()
   reusable" in v2, and add enetc_set_rss_key() and enetc_get_rss_key()
   instead of adding .set_rss_key() and .get_rss_key() to enetc_pf_ops
6. Separate patch " net: enetc: check if the RSS hfunc is toeplitz" from
   patch "net: enetc: add RSS support for i.MX95 ENETC PF"
---

Wei Fang (13):
  net: enetc: add initial netc-lib driver to support NTMP
  net: enetc: add command BD ring support for i.MX95 ENETC
  net: enetc: move generic MAC filterng interfaces to enetc-core
  net: enetc: add MAC filter for i.MX95 ENETC PF
  net: enetc: add debugfs interface to dump MAC filter
  net: enetc: add RSS support for i.MX95 ENETC PF
  net: enetc: check if the RSS hfunc is toeplitz
  net: enetc: enable RSS feature by default
  net: enetc: move generic VLAN filter interfaces to enetc-core
  net: enetc: move generic VLAN hash filter functions to
    enetc_pf_common.c
  net: enetc: add VLAN filtering support for i.MX95 ENETC PF
  net: enetc: add loopback support for i.MX95 ENETC PF
  MAINTAINERS: add new file ntmp.h to ENETC driver

 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |  11 +
 drivers/net/ethernet/freescale/enetc/Makefile |   4 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 103 +++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  59 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  93 +++
 .../ethernet/freescale/enetc/enetc4_debugfs.h |  20 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  12 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 529 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_cbdr.c |  69 ++-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  76 ++-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   6 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 124 +---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  30 +-
 .../freescale/enetc/enetc_pf_common.c         |  46 +-
 .../freescale/enetc/enetc_pf_common.h         |   2 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  19 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 458 +++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  67 +++
 include/linux/fsl/ntmp.h                      | 178 ++++++
 20 files changed, 1716 insertions(+), 191 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/ntmp.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/ntmp_private.h
 create mode 100644 include/linux/fsl/ntmp.h

-- 
2.34.1


