Return-Path: <netdev+bounces-241451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8FAC84107
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F7C3A906D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84E2D9EE2;
	Tue, 25 Nov 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cUHJTeko"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E918EFD1;
	Tue, 25 Nov 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060693; cv=fail; b=jr4QZQzEklABzEHohXkvY5jQOE1mSwIlAQOyw0XLdyT24zaSxt8e1lgo0M/llUZa2z/NhyGvegTnda9/Uob1NlA5JHATDpNegF0J7mWnCJkK4/5A2WbZmXf9I/j9XuNqF6mSE+zk0N2T7NNjDxJgdao6y3vVy8chrz1LLGndG2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060693; c=relaxed/simple;
	bh=3Iix/RY/00sZrCHrMJsI8P9coDpa2JdcrsrLXrh+lzo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lJlIjE0eeKSYVzjgYxWHeok2d58ybfG0CW8S808F9uQO3/Y1sfYF7gpVmS3E7x8crqXw398Cvmn+ZyX2GtF/ALWdm0Z9/lfgh42BRAETLF86IF13K8sKoiRXQhwpLJp1mlYekY0i3wPxfxAjtxYuI9pkdJW7Hnkis3fHNNGhLK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cUHJTeko; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEd6dcXzyIfgz6lpslz3hkkKiUcxurEUhvXEtEt/UNL+esaiAYhd+E6B5nnPfLzdfmGc1moQ59ilUNJp3xO0Jcywex8IgpiQk25b/CaBhizDpMjfj3WoN9vj9OOJjQacI8gb8i2sKX+AoabYlORV3J2scOgCuMcGD+lQxXpVTGe8uhcV+LA/3YvrmBYlDBOwiPiO0ps83TI0+GnxGYncW4NKrQ221YT9tJPzXWwbRig7Wg4zhe7voY7rLKfxSaaDn55n5Z1hghTVgfyKEvNtFhrbEskaEcWObK7n7D0qlWzBm/t1xgaO/8uJx2YaWBw6v4Z0EL9QQxPJv+y6Unp/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZicUD5WfwzsTWwYa4N3XM6Wf8xhDT6TlsUM0eWfN6g=;
 b=MAWKGBXwjc5nassQGYYQvzuJ8LTNHN+WksAjhzil9ezzSZhJ2WWoHYiSlBSVhJ/GztFDhoBiLm1fWTHlQupI2uEtWfgVXMCzMYBhEBuJEYfs/wqy0VSpR5NQCJRbzKqU7qw1/2FzJC/N8D0FCzIzilxvdaV6TkADe+T2ulZ+AWJab/DIcl6umCUKLC7VEKu60Y0sVjRw0aWP2VOfHdhU8uMAMVBfThL1WGXziiix9XOI8MvZD4vOCQ/+EEjztb4QCG6ck7u3AcvjagweS4U/Zz+Wnqq/DIzC7omubihIpuMGK0UGVArdujpt5FTcuVwLX7YKxKGEI8nsS8SEFyVGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZicUD5WfwzsTWwYa4N3XM6Wf8xhDT6TlsUM0eWfN6g=;
 b=cUHJTekolcVPgznvWhuTDI9Lxy42HGxtDfL5LiM0/yZqj0PsYun2i/TgEMRaISxZ1kQbhJhXZTq/LCgKbhDR2eP8KpLUJ2puKhJMXDz0gB9D/KRWX2syvXj18Jt+eMdlyRo17+7ltSl6rCQ6zgpZO/fWxbHlHYUnswSZb5iWOoQTmPi3eKYrMhPb56LFalfdiqhueQ3P7cTWwioBOc424j5pYnsF9O9tG1omDj/Q7720Y9llzlQVoytQovc571unQRNBK6NH2S07Hn+hDWaKqB8ITwOLx6NFo6YCUI3+VwZC30oeDegsr1oWD2tBAuRwlWJbyZCTT/DD+EEBEPzvfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 08:51:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:51:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] net: fec: fix some PTP related issues
Date: Tue, 25 Nov 2025 16:52:06 +0800
Message-Id: <20251125085210.1094306-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: e25442a8-2188-4606-7a0a-08de2bffd279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xDUjUm7rNOEF6Em/tWwrsXJVz1M5w+yY3SyoolMNsw4puw5KaKUbh0HB0Ynd?=
 =?us-ascii?Q?CdmcfZXPeTq5ff2PnWKW2lIDRPaUQk24NPPVFFtyTVThOtG1RgarM4F2Z2lM?=
 =?us-ascii?Q?ExDdM1MOayDtCZoUk/NmomCjiBGCZl2TpsAm7a+CXVu+WlqWhI3kCb7/giVp?=
 =?us-ascii?Q?O6GgioQvGHYtGG0763lYmRFyZx9yjLhxzGA2X+vaEOHvVOSxI2PoWhGw9nFG?=
 =?us-ascii?Q?D5OC5OAdf2YkzXlXcW2Naq81hW7NLrXi+2hKJ87qPMldu/JpKGUsDolApCQn?=
 =?us-ascii?Q?HqUkTM7ZqZJsQkM3Iq6lbV+IeRwaDD/qQ/ovMzrmzTpIPfpKTJnSfTk3m3Uz?=
 =?us-ascii?Q?rtrgRr4WidSJTvu4uiaWRDTfrivLI4H31NVR5i1pnnnhzoagq2k0I+dSkj+Q?=
 =?us-ascii?Q?4qMuw+776XRp9moeshwdZTrjYCWoWC3gkYRGO/sHL+40vsBAjaBOceoW09BO?=
 =?us-ascii?Q?hJV98mZP38YH7ve116iCZ4VAx5KSRta+sC4oaunfroc3xndC6B9PYGyCX5ag?=
 =?us-ascii?Q?l4Qscd7zZs4MmrQz2KSo6EpKNaJLgaDgLcbr0SIdP6ZphNlQ9XWwYQkJSVLe?=
 =?us-ascii?Q?BKQ9b6Ojrlw85Z+uhKN6ljL2FGzZCWYd1D8XUBWGDzhkADG+CrM2acYwKs8l?=
 =?us-ascii?Q?NGvIimSkrtUtfvsg9AiMmDvWPn/c/nxN5W07toqYAGQpA6Qv+4w3Gv6imDHj?=
 =?us-ascii?Q?fjkG6BaJZFOA2RqpRJ3FDn/B/W9L7YaOEvYmRA2qVqd3N0pG9cT/454+tA7/?=
 =?us-ascii?Q?9x2DSrfgtUWU1h20L68ADtNbBt/LvM5L3Y70S60PQbiywganLS8xfk4QGtPF?=
 =?us-ascii?Q?3SQ3synVGtZDQ+nonNYXvaBBCgglB4zVAjAPzesU9vcvuThTzIZguyzxK/up?=
 =?us-ascii?Q?i7VjjNl4uISBW1XlBLBVxV7iA1QavWC9tDTYPf802OdqXVHkUabQGQb9lp0c?=
 =?us-ascii?Q?jSOIpcBjUS47xHOYNaJ0G89Q4BEyoLxuqAUr/81Xe7b0S6KQwD4j5awb9zIR?=
 =?us-ascii?Q?9iNcc0Ak/Qdz21RVGjTL03H4pH0XqlcIfF8qSQNaRFLWvLxKjMKd1pYOSmth?=
 =?us-ascii?Q?pbmNUWSAQffe7KrkFfCNBnwNOkqPkgzgclXwgJxq2/1I/5ctdpQhUXJUGrhv?=
 =?us-ascii?Q?iFXOMB/a5ee1AHoDZc6XhjLJoJIznGof95/tL2pU+dI4xHxANJOJh/mr59wB?=
 =?us-ascii?Q?3YxoS4+hekeowdhHinLdOQdC24lkiY8NDqNjuZZ83fDH0YOyqUKrwl447Zby?=
 =?us-ascii?Q?aca+AIWhmiRqlyEKTdesDKyq/eA6tkxbz3sWCLGtCKi/fbAY291jfgdsgFyT?=
 =?us-ascii?Q?hFulrFEJRzQSjY3crSq5HCi4WY1stBfPMzQCTM/bOsksWHXRzHg9Kwl0T4su?=
 =?us-ascii?Q?UOousEwfzJ+0rCCFBX+Q7gGFLg34CMikTv5oj2OaI4mx1eGjnJpmhPcsOnsW?=
 =?us-ascii?Q?ZSIBfG6j9s6awBUKbFzVDzUcAOhfuOixtmBmqAOtiqb9c+KNlvQ0w5YoADD+?=
 =?us-ascii?Q?fgNZXofl/kWRyNcXIgWKnGs1P41nwIGQzpHy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AI+sQ5DCPaBkU7EZJKq95ohiOd1wz5ix7gLCtlf+vAO8k6IEnM5d+F5L1iV+?=
 =?us-ascii?Q?mdNxTvdWwOqIlL4IfOCngHFD5IZKDQEsTewLE5+2Cz+YoPQ/3IdLFxTvsWjf?=
 =?us-ascii?Q?nsU2zYhKYrUB0KnMgheoW9YuH6g+WW6w0M63UsrotWlzEVRsyIsC9uBCpiUF?=
 =?us-ascii?Q?bb1I9cDZ/qWGmechYOOvcMLjOb++Uf18EO3tRsRP9urHvgNq5mv7eSVBQ3wh?=
 =?us-ascii?Q?Y7qzT6t/7TKJ4In8CMEtwiuByMdmxie7JocOxO4H+SxSuUcMF94YMgccDIoS?=
 =?us-ascii?Q?nU4okqvEkep0hvyVG3bPkkgpjGAR2FeFKU7qMftnGS/NBZscg/F5F7eYW+ke?=
 =?us-ascii?Q?gGyFGPiMJadAZuSWQO3DKIHHJ/S28ACdKr7MigTiMK0QRYZpetjjxk9H8Mp2?=
 =?us-ascii?Q?755U+jOyNUf0TtTDnL4tqRDatYYWplvek2eXrr36FXvOmSzNknlDBa7Dn164?=
 =?us-ascii?Q?2uSpTd2v6svG3i9Qc0EX4estFNshqaAuO6qlKE5zyTBV/y9kHJAwvKfQlX7w?=
 =?us-ascii?Q?0+mOvw37wn2rtlpq+wncy5kK5yPh+IhTA+3S/ghxUxk5chwNh2APg88lhEZm?=
 =?us-ascii?Q?ysu+FQjXkCHZmxPEQYNpHJ4dlnwhagSqvBCo0hKYA9mUE9IEDWofbY6KtgEW?=
 =?us-ascii?Q?N3unyrlu6//LfwpeGyNG+EqqEgqGzbf5sNNQFCrt2fLQfa2Pw3BTo5ZGf3ZD?=
 =?us-ascii?Q?yhJ0Mgd6C70Ta6BWfJo4gqTq5+hE8hhJMgkVc+SRphr21K3j2FQd0G9uKQJE?=
 =?us-ascii?Q?olKxDLYBQg/gyHnhPZOmm9DOaqAajYCpEEsYMcagaTYTl2reDgnnPzg+DUSE?=
 =?us-ascii?Q?hIiYInBRNCdMvTD0U1+TwZzR80oIFCAIcrKHkqhsMqS4wS0gZx1ssF3QQmaq?=
 =?us-ascii?Q?XwTgXkbSkkEuLv7rbmc0sRmA2wzjywW4BgyHRkORCzdP+lokWtI73ltRbhJw?=
 =?us-ascii?Q?0YEyhpa+GzN4Wdb7IvJd4IOiScvoOaBcX+s/ZW3bZsYOGDuQ8uL25R9tuJki?=
 =?us-ascii?Q?uq4JhcPz9RPd/HGHZPTZVoR6GvMhklVNaPgedTCSh+QeUFcHGXoSXeQCSxlp?=
 =?us-ascii?Q?c2NcDB3+mVRfyfuosH8NmYV7jeXOenGvul2I/RpgQyUfNxLLmEZaK2HqEnJW?=
 =?us-ascii?Q?tRlfqUZlFGujg8OakQ247OmRuKEYH4vNime94MxZ/GM6BQoxGDrvYgFkX0Dg?=
 =?us-ascii?Q?dHX8WAYOhMR0kfLsMf1KA4+D3j3NhjYBjhOhUklHvVAeD/GksY9lus3Rv9tU?=
 =?us-ascii?Q?HhypjUwzAcETIQ153qCwzTlixnTgeNoRCihcd0cZ5m0rOO6kZAWv6D17TEgb?=
 =?us-ascii?Q?TJqAMF4CY3FTKHh27afO0tU2nJqC2NF6IbuJxTV/rxQC9aU06Xo+EPebROyI?=
 =?us-ascii?Q?kH/IcGHL877JPoSWfey9ZK+00CwifmkgsJ+39D74RQtnp5uA+Xht7PMZITkN?=
 =?us-ascii?Q?rahhSugP/9LLvQ3/f6sEgUYeBsL87RDpRNJInam3iiqxU+eAiOB5poI0reSM?=
 =?us-ascii?Q?m8jA5+1TnmBjkzGgie9PfO8QQJnYuRi/+8ExE3fG3fZGvBpVkalw6DNHhk0C?=
 =?us-ascii?Q?YpizIwX6MdjQ8VEvf6FKhSQFIoQq62TJfcfD00tt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25442a8-2188-4606-7a0a-08de2bffd279
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:51:28.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvUejoV66SqAY/vW4IyG5RKzRw0fIbru4NMa4yI7P/xDRotb/SM3nL5uZKfo+KtGstEwLJpxvyK/b7CkGEzQRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533

There are some issues which were introduced by the commit 350749b909bf
("net: fec: Add support for periodic output signal of PPS"). See each
patch for more details.

Wei Fang (4):
  net: fec: cancel perout_timer when PEROUT is disabled
  net: fec: do not update PEROUT if it is enabled
  net: fec: do not allow enabling PPS and PEROUT simultaneously
  net: fec: do not register PPS event for PEROUT

 drivers/net/ethernet/freescale/fec.h     |  1 +
 drivers/net/ethernet/freescale/fec_ptp.c | 64 +++++++++++++++++++-----
 2 files changed, 53 insertions(+), 12 deletions(-)

-- 
2.34.1


