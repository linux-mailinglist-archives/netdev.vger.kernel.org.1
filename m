Return-Path: <netdev+bounces-153231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4F9F7479
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234451664CE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 06:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843171F867C;
	Thu, 19 Dec 2024 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WH1IvFk8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C9413AD22;
	Thu, 19 Dec 2024 06:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588262; cv=fail; b=muX6sNmFWilj/FXv565yM/v2uYQKdboNO6E8jsDaWlS3vfdtwVSpLrnLKOkbL5cF5dyfIHNFz0xGiNEuc9BzLAJ1qljy7587NtlYuTAiTKuF4449ox1yNE+moepGnptVmQpMG1YVt2OUPhjbTpx1Is8cEEldeZh9lQOVI9IEQig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588262; c=relaxed/simple;
	bh=nR/SQshg5WuKA4eSIi4UcKYOqjEdqWbwiyvN/lsQi6k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y7rFdFGudpB7n5wZItGBU2qUggN1zjgjE3wYlvjsENut1vyKRH4SQTE7NT7uCplwAAhVDpcOA4XQqSfvjeTvxqhxo+gWX+99LzUJ6XkGVhcWOPqZ9BoKPTbkJGea9ZqKp6Ji/4RfJWmstd/+qdaS3+a2oMDBF2fNJxz6O4U4+Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WH1IvFk8; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7x3Lax8WZiX9dT7t0nouPQ1UeG0MtETfmJgZjwL2aBildKh1LIZ/cQUXpByICzBCDKoGdimFJPRiUJXqw95u11JvOscIYR2rU5C3rswc6nOloqlmEbvH0X8Btb/2bbqTxayVl/t37K+RcZ/3Vku0DVG99BgZXvbI78CLHcPz87SFf3k/Hdt/aZHyzYEqIk52k3qCAZSw6zI9HzOy/+I7Mq7drMaE1jZuqFy1zNzANlrJlWKi9SH7I60ObXQjmE5Ap5hfuJRmNFztdTKx64ZOPBz9Q3rO7c5/PJJCPpRrLId6+r5uCm3Gla5wDkwJP7Vai2WBZncSPlzCqjQuVYhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbxJjFawwsxH3kyv9VZETt1n9GWT37zNz39YTESzYBs=;
 b=v+iMzLqrDWNCj1b7pBpNMCOFT6iB82sp8KISoDJbl3RO3zvrFjOxGC5OZaY9cnKa6ITispoP5leNl9U5t+5yonv+7+jejhhEfenjHED3HZYNTWuWEV8MhMCWcIHWxOOsRthYjJEJnUTbl713Q+7DISU27bvRD0H3hBfY1MbpbOZScd30JYFSPsvTcblmdZrPb9veviezQ5O34K+OWpja7Kcu07edEO2nMBIqyZNvScHNE3k2se6fmPE0MrvODEZIO5oUA+GZTKynqMhQ1JL3QkBZ20lYm15hQCEGLLj+XXPIPJx3JvUefRTRmquJI2IhJFl7/uSpvMEq8UNlmjT2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbxJjFawwsxH3kyv9VZETt1n9GWT37zNz39YTESzYBs=;
 b=WH1IvFk8GbsJ3FgQEcqQFiRuuH94HH5AJNvYiFuRL9ZILLbj1zHGi6Tge2wuaSJZ5KzPRCTxzy7k3AGN5N262yHKenGNSTCNAhqMZ+PabHeeJlTXFhwvha8VFbaGe0cHSa2g2EwyvgWpOTM0E07J73O5jBoHmqiSRI9Igghllda8Kki9Y66dySGnGvJgOcqGyBCfiaVh///H+ZgYlpVfOl+eHXObCxxKIgLOgkRnpWMrs3mgdaOocF9soY0gHxGOqcbjBCNIS5azh7Aqxlv95owm40g8aA8ooEb1BSAEtL9Db+KQ8RNfoDzGkTogxuC1QBs43NUb3ye6/Ho0RodIeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 06:04:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 06:04:17 +0000
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
Subject: [PATCH v9 net-next 0/4] Add more feautues for ENETC v4 - round 1
Date: Thu, 19 Dec 2024 13:47:51 +0800
Message-Id: <20241219054755.1615626-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: a21396b1-f84d-47ff-51cd-08dd1ff2f8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IFShFbqRiqYnZc6kfZI5OR+tg5Rhef2yStQMd/xIEk6BuuuQfU4lBw6Djksr?=
 =?us-ascii?Q?0ZjIepmpb1NOwva7N1gXX2gB1pXoPburuBDWu1z287OTygKPPOc3dDx68Awe?=
 =?us-ascii?Q?GGbA3xwsK5w49RbNg87onQPW8jVEUW3+CA5iT4XhBBaR7VUDrY8Sk+7Kkt27?=
 =?us-ascii?Q?ScxC7Q4RUyR/Jc9DvnM4p+/Nwv2gQVsgXiVPPKFEOF+KI5NwWxGob+rPciPC?=
 =?us-ascii?Q?X7UVHR3Nur/4JQi4GDw8+y0/XPDX1SxYKh3x982gpOLAeKMhwi8kH4mbh4E8?=
 =?us-ascii?Q?x6hSnixI2qo5wXkmcE2r3+JHx8oDndvsMR9mV/jEDQ12TSE5rTP13UHOirW9?=
 =?us-ascii?Q?EVfunf9X/fd8X0rqqTrUoKld8jrrHaG93Tx6zduYIzv3RLnzn5DbuN4eIS08?=
 =?us-ascii?Q?KSAquC2nG3ZuNtEunPd1rhrq3Ce66uKx+hqBPJBRC/yhNq390H4Dkg9Pve2H?=
 =?us-ascii?Q?HelHmuO7vjvQ6rFnE/TMoSY7cOe1BlnFLAOYGa4ll2DqXKEb+BGJJjqhhOM9?=
 =?us-ascii?Q?RaqcYc9i61tGiGaXq/bjMz7szgwD9R4LQ/AJCt3zeaU/f8i/BvpNcjE5VUPU?=
 =?us-ascii?Q?gXL/34Gxmc4ruy0jm0eux68UYgpL3Sqi8zYx72+LTl8pcAAsrrY/a28tbxXa?=
 =?us-ascii?Q?4HeyH6nQYyJEXVXA6SDsHvsGNemyHWLFToiTvtr9JCS4fGcapHl90uohtqHj?=
 =?us-ascii?Q?pYWHtz59SyWDWjLDkxVzCR4EQwpPNriMpDYCm/XULSpWY1gnKpovM5si2FSK?=
 =?us-ascii?Q?wqPaNlEAxhSYencTC65i4/CUmtV2kyp3NX44jvvle6OM/N7uBcV8VWFISVum?=
 =?us-ascii?Q?2BRy1b71wa14s/XzrzV05X0JttImJQ0RDjLfseCOOBCMfRRZpaK8OHA35Hb0?=
 =?us-ascii?Q?l+NeEFvxFF/k5bANlttxpBQ4/rXCS0MH2s68n8RGxQAvDdR1obnRp0oGAl7n?=
 =?us-ascii?Q?s2Jppc/hn5CI/fHkSg+3u1kR1XrceZ+eUwqfqitNN00eAm12+vBX/5/7jwcV?=
 =?us-ascii?Q?9bf/K8m0ziZRVjsadyjCUkVCE5qf+/487xD6twBQOzHsDzmGriSqpWFGTOby?=
 =?us-ascii?Q?b4jHdOPm+C/Nnk4rQ5t76tECNX3t6Rl4e+9fqdTf19aqYc4PfzlK+AFtpkf3?=
 =?us-ascii?Q?dEaWnWCG9xjwxsM0roqwpjdlFJbLFXrQvC6bPRf2rjRRKO3LR0tplWH6bN/O?=
 =?us-ascii?Q?ynT/QjK5inZgyLLMg5eaMm4Y8wa5E7cyFkR5hQeVxFtxuTdPlWalV/9d+9GO?=
 =?us-ascii?Q?f/t5aGqXMtWGZ6vF1mtXE8ds9EFZq5nUIIeOc6w102uhiOGtuWJkD2BHM1qx?=
 =?us-ascii?Q?U+NQjJoIWvOx1PPMx3fB6v+yHahGqsXi7GS1HYFMp4SBwGMa8TyxEfo+56YP?=
 =?us-ascii?Q?LrKSkO2IbbNn+6RmxTXcfZZHyAxOh/mJXOSE08BlXREGjD7xD0T4YcjRibss?=
 =?us-ascii?Q?VUGViFDYuMgHY11dTSe6VWmT8sO3K91wXT8w1S4hPmgzIaQD7V99QQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZ33aeXoor0sNSmyxd9YoqsVxMZqfAjw9WkJwrkt4FiedbgRBITLjrvgZvqo?=
 =?us-ascii?Q?toaTveftSzQG7RmH73sBbylgTaAeDpLk5BuXw1vsBu3dcAkqUbI25CvfJL/4?=
 =?us-ascii?Q?kndIm/OiVi/QCHsbzju2xi6UpnCUx/+HphxPEpcRmhxRgf5LKO2BDXDkAktU?=
 =?us-ascii?Q?KGSIXWdW8aZTxsm/9gkQhNemXbEkISL/KPNsun/7C9/bil8ygcFJPyY2jbPI?=
 =?us-ascii?Q?pOZN20GWdOQP+MSXVR4twKaMPfQT4VsxDrWhwSitQ1FCkPsRDGONZdacAcdt?=
 =?us-ascii?Q?o83CfdkZxlsaEA0c47JsH/b3A8lr4OOgVBQTx8OfiiWu16TTJK3eGrxGy/cV?=
 =?us-ascii?Q?25cWVkdO2m5C0dT0GeVAMy3YiuEajpsHbJ4OWpeF19aUbBrmH+WXpeJpNje2?=
 =?us-ascii?Q?b87pO3y1nJOU8oMNGOn8DbUCHODVOv+KTXKkJg2MqveyR/aQvmLXX5MMCQaL?=
 =?us-ascii?Q?wRvnliyZ3e6zLE6nc0eDpoovZ3gkPna3bAhcLK8ksC0jquvrvsUHR7ymviAY?=
 =?us-ascii?Q?MVg1gjlRV/imu1bfHB1qRX3oF3IrdvCUZttEzcIC904HafvPbDOvRgBhayPr?=
 =?us-ascii?Q?GfVrwZS4hCa1fpMYcAocl/kC61re9UeWXiP8svXRVMCmOp7tNvmbtWkjWyXb?=
 =?us-ascii?Q?9lVkcIh9QfvRgEdZHbMApPThHNLa/PJ7yUOryHDgSFGE5H8J7q/AubBapBF1?=
 =?us-ascii?Q?Gf/UKV4kz51M1bv+qREDir2MB6JN+O7ZfuaVWLY107A5KW8d04AeirYu/u6T?=
 =?us-ascii?Q?YqgCbASvsaVw/f4QVLWLm6B4KJaUGdWs3EmivxeD6hv6HQ9lToLUA7AAq2RP?=
 =?us-ascii?Q?OzABEVseW1uUtarJwJ5GdiXCZbWf0hpQly79UdNyheM+w9lMWfdQ39RNr/+v?=
 =?us-ascii?Q?ML7RfDofLZY7fgqiO3J/OZdFm5lit5f8I6UkRa10LGVwwHBhJcBZ6YuC7Sau?=
 =?us-ascii?Q?e3mcdkxtb3Vuz0NvvJBf72v4ffKxaitP97x5v6yn+jtF0jhHrIWRl/xhnn6s?=
 =?us-ascii?Q?d3kGOjasx5zgkYjh5Xk95OPjLvk/JVJcYdYp2UdrxKauqYYygIaA0gP7Uace?=
 =?us-ascii?Q?f2RcccrlNqNAmRk4u1dZoPlLG0e2+z/YmMepjF9kI/kyWXVaI2EMBm+RTRtJ?=
 =?us-ascii?Q?n7XPG/VCogGT26qWNBs2UN13pSOIiox5aLlq3M6u8J/hEzFSd6Ecv9BE3jXH?=
 =?us-ascii?Q?66DZCUWKmHRerbWwmFj2fqteARlncG8M/4sN+xyXV+Ga2xzQY4gaa6N3REfr?=
 =?us-ascii?Q?xxve78HyK3IeQesyH83gkcTIvrP0EySCGLmPXGHAy7KSRkI5egQh+kUF1PCO?=
 =?us-ascii?Q?k56EzE9YQ43SiOaUKX+hlIdmqaICjRj07x3RdqkYuOAdzebejHFOJCkIVCFR?=
 =?us-ascii?Q?475w51K1uC8rCaxNzkxIuawSy5q+QeEMafLn4hl9QC0+uYC8VYlGnpy1y3c3?=
 =?us-ascii?Q?QCQpsHWlCWnUzcgs7+0pmKt66OSaZQSlIVQJYoUe2MqdXILwBBRyvI9yvVEo?=
 =?us-ascii?Q?/G1689dUyT+c1Ei8lEXR35BtqpTD9tarHXIOzCsUysatDXPYuh9/tHNpcfcA?=
 =?us-ascii?Q?NOBj5KvmM6JBS4wsxQ1P+v+ivKHEa2SwPIUA7taW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21396b1-f84d-47ff-51cd-08dd1ff2f8d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 06:04:17.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWVKC3d7dmAjtyVdT7YdGAxRCZ8Eylwrm9tguR03jVHMijHQ7DxDdzc4XNjbMinDYmZeGSb5aLSfMIIy7uTYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

---
v1 Link: https://lore.kernel.org/imx/20241107033817.1654163-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241111015216.1804534-1-wei.fang@nxp.com/
v3 Link: https://lore.kernel.org/imx/20241112091447.1850899-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/imx/20241115024744.1903377-1-wei.fang@nxp.com/
v5 Link: https://lore.kernel.org/imx/20241118060630.1956134-1-wei.fang@nxp.com/
v6 Link: https://lore.kernel.org/imx/20241119082344.2022830-1-wei.fang@nxp.com/
v6 RESEND Link: https://lore.kernel.org/imx/20241204052932.112446-1-wei.fang@nxp.com/
v7 Link: https://lore.kernel.org/imx/20241211063752.744975-1-wei.fang@nxp.com/
v8 Link: https://lore.kernel.org/imx/20241213021731.1157535-1-wei.fang@nxp.com/
---

Wei Fang (4):
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 330 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  29 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  23 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
 .../freescale/enetc/enetc_pf_common.c         |  13 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 403 insertions(+), 30 deletions(-)

-- 
2.34.1


