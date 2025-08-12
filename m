Return-Path: <netdev+bounces-212844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A6B2240D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9455A17500F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8F2EAB9D;
	Tue, 12 Aug 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DnomvMNy"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2F2EA169;
	Tue, 12 Aug 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993228; cv=fail; b=Ts3bDiOD3jgzrUm1NHEaylGVEPUI913o94Pa3c5Gm4H+msXGfKoSX9UOuThZrf25wfxKCxj6s6lRnIksduWtxTO/Yx4VGdXUk2ldGxRvi1QXMF1kkGxzG3XanYIva6yRfQTRFcSPrMwrSr7m0sagNj8yklkPjeO72d1huLLFOfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993228; c=relaxed/simple;
	bh=zBU1yp7rhp+MMHLFRl09SB8XgUWlQNfYOLrfpHOfqNw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H0QsSPBoa0EWFx6ImTsOS9+leMoRdFH6d74KGsPGD4HpfiHGr4oMxb65I7XXhZfCw5utaiPQpxRV0Ys9PUM/K066p4p2jq7fFTKA4nEYXEUFNy7QqbjJAflQKojoDEQT4/gULnX5xvx3SlEWiJV4CzsO1FxS1z67QG0nUPoZA7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DnomvMNy; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofRN3qirFOJ9Ryyl/K4rNWfgNqImRHszJ59plOAKvmis/SjCYhtMOJ9TMYBEZ9fSaQBzEEIPDDLo/hrB/lshZdmd94Oyaid/g7sg9V0QUAQs84vXIqyMPKAqHyVHNboQWpCeY3wxzsu91f/8zAGZrhastuly/eWaUeSYN/mWXDKn95Zv5Vo2BuJekgqllex2nDz9BF0pTkcOPfS44HqsHRC1441oVwrOKceCfQOTyb7aLp7f+jpWDErEJewqTiZwXHrd4DA6ZbKPn31tTgS3OZ+4/X6+7vr3lI/KAJozM8T1Gk9xeQziRhRqys2DT8s+Umr02XA9FybtMffgYFAzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahRIIJnCoo/4qpGop1jcWpL3l4SCptQiORAo3Ynw+ew=;
 b=gDVLj6xlYmG8eeuHtbWo4wNir6XzQWpHXkLrGmwOuCy3GAiIwqUTXbeyurPQW805WzxWm/q7wqnf6pab7nUoElvx4lG2cR3u7ldZNNyfCt3fq93hnxeFMDoNrSWWDDWIuRnv/lE3Ohwg8oNlmFKrplgBxkSDip5p3PXQFIgvW8/gKX7pioy2Rcni5avFuUWUN9Cjir9CpBixZNhFSGvrawZoLRvoJvDme0DWZAFL/zw/bWIu8Dnm1H4N70TXyEIOhDY5jmS6nUO+1SYfEvaUbtn5J2KPBDttLSt3HhAsviC+Zk3YHnXg5cT5C9N05U8UdXS+hdFvFpT+mSQeTCVnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahRIIJnCoo/4qpGop1jcWpL3l4SCptQiORAo3Ynw+ew=;
 b=DnomvMNyr7E9S9dgrSNJ7EGalbKBmLLbGak0Bf1ACaCxHycoAqcSABiVZ3WMy0PTjAb2dShtMAX/eSF8dqXAvG1GJt9FP/ZZHHYvC5aU9+pIyHbc2+sidKpeI+9xiDijXEfW9ztz0GJBFECyOwOPadGsTAB3FRUmjGv3YFNcfU5HfPowkRzXLZIiwx6aLP3XJtY6CyTUqtTWMXKGqh1/MMamSU82Yw2EB2dmLdYymdZ+wh/srJSudwS6sjYWXxgTLDEMn4tVvBx/X+zdItcXNDm/ZeYq+OBnSsIWyJgIqho2L2lpd4XMuzIM9qfPeLSXKM3LgZQ6YX8Qz/1hZym4Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:01 +0000
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
Subject: [PATCH v3 net-next 00/15] Add NETC Timer PTP driver and add PTP support for i.MX95
Date: Tue, 12 Aug 2025 17:46:19 +0800
Message-Id: <20250812094634.489901-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ef0be7-71df-4eb0-195f-08ddd987fad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hc5pOvaXM3qiFhPII23+G7ZD+SYtIj/+fu+1rEoYRU541wfLzFJz12h6PeEy?=
 =?us-ascii?Q?2u46eeVQB76YHhJ+K87CJvWG1607pEjnLtZfBJqojZYBBWwo+ygv/pBhy+Oz?=
 =?us-ascii?Q?33nrZd69h22161ljkkfuWl1BYMTik59KPAzU8Hh1hotTGRi+VpxbZdN4/Kms?=
 =?us-ascii?Q?QQ96oq5arg0fG1IwR11XIi5fS8QHNGTGownIXRr6YXTlcc10sMlvHouH4jqz?=
 =?us-ascii?Q?3+Fj93BnWu+PDI3Gy0XpfKqWThpfT64M9rTjfYR83WllVEYhXA/UjbRvdqOY?=
 =?us-ascii?Q?njv70+i9Od9RcC4KkQ+4wbh6diexndaozVperWNVvls3U6WxR3Lh+ef6daSI?=
 =?us-ascii?Q?T/H+fksXgEMq78AbPj6MxDVDZaEOGVAf0JWxigB3pwLrEqAdWzuQyv1ormRG?=
 =?us-ascii?Q?atopFxJSIxEM+F2NLKZCz8lBULX5afBTydq53D82zfGIwNVEGqgMHDu/9nW0?=
 =?us-ascii?Q?cZ4lkn1HSIs18ZYGfoiMNtWE0ZR0hO4z8b2N2gK6mc2vWCEvFq3/LFCCNssp?=
 =?us-ascii?Q?xG7G3olPzXLIJpU10eQsU9AIWncKdCUlEM1IJ99URFfnIOOyZXChjRv3LLNw?=
 =?us-ascii?Q?ydYnm3vaaojeI/pDb5RFvskSjGfLIM5RirrrOcUkEacZW6BtjvbKLEkanMX6?=
 =?us-ascii?Q?MQ1dcwCrnOoDoxo1fUK9JuRnZik+06R+BcnsVGlpJmQlD1EXzemRByvVVfIo?=
 =?us-ascii?Q?AbLE2pX1We+8UJrm413BPbstz6H8XLiw4Zrl2neSFPfQYIkWrjvFoEA2Y0lY?=
 =?us-ascii?Q?+JQduXl6vf0hP9NxYo+dXwIPgWbSCI/Lr7t40SrY5mxtfrJr2GjfUVEyR7gE?=
 =?us-ascii?Q?UMKYA3O0+1Iey2Qq27KigUpXwOFBbRv/98N7UsU6vIlGATRV+Z+9KiPyFd0v?=
 =?us-ascii?Q?m9TdwHpBiFCiFXb2nEr/d501ILkpLDaX3aEJJQaSyit1IPziYoORFnCvtgJ5?=
 =?us-ascii?Q?BUIKcoSBgKS/AI7Pnekamtp/8U8bSD65e87G7hf41aT+utuoggtV/bzERbRK?=
 =?us-ascii?Q?sHscJiI8Djln8/M6cNcDYAax7T5NUtrY7Dg6Wx7Uj5BvykBCi2BoYT26pSiN?=
 =?us-ascii?Q?OqQvc0y7NNaYgsYAGyNDgE42aw9xAI3eTZJ+TEiqQtbw1cfqg+JF4d6L+I+2?=
 =?us-ascii?Q?sevakJXNs95X3tcu2FwWi42v+PyyBmbsWhjOOf6M6KEQjAPZTZezNoMkG0Ko?=
 =?us-ascii?Q?j0ozmIl1rbsL4Xb67dtY+72qnaluhPLiO+kE/NC1PVVlcOvpk3hksLXoBLeB?=
 =?us-ascii?Q?f/o5OXIn7RP6BO+JfWmZuJiR4Mz7kQTpsHLcO78ul20AYqVkU0ARq59BWso7?=
 =?us-ascii?Q?KJi7hyF61KpA54xGBd5rR8gMhML1CIriKIA75rccqd/8DOFDTtghTHRVh2m8?=
 =?us-ascii?Q?NIQeDIUtv4kyaqjCJGmTf2Nvv87KBYkYhXNjK2mCOLmETpkjjicWyjWCw3Su?=
 =?us-ascii?Q?Qqy4BNC6AHaEkWiQCSJFaT9OKu2NRDn+6hNXfEI7ye+OVTINdbaTXnSwI2b9?=
 =?us-ascii?Q?HEfsJ3ZZw5QQ9xfmjfeUEaYDaf3Eibv5ZC+T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nvESQtncNf26MFa8tOaddaPjj9zd3neCpUXbnO5C5yv9vZTZObuuKrLiFP1?=
 =?us-ascii?Q?9m8wxzYy2T2Ea6MTUL1EWQh/FejQmVkV5A2vP3ONaL855+6JViaHrPdhU5cG?=
 =?us-ascii?Q?WYFVsiaTAc5WMQz2N3Sxw7WxGCqvkDaDrlELLh4vXY/8RYNJYEzgcFRqz8ft?=
 =?us-ascii?Q?8n9aYhOhDfeLxCrkb+k+9lorGEcr54jAvSQsslRMKf4KKkIM5Rpq3VaNLF4J?=
 =?us-ascii?Q?WS8HyGhqtXGE3gTXk0qayk4Sj7H+xyFITogFFPXVICJlQmJKzw4+5nXo6q1g?=
 =?us-ascii?Q?TjGpRK3nisXIVgpG5538Bk1SG1OBoevHE722lOzt3QIIsMtNv55qYiPwLEDQ?=
 =?us-ascii?Q?/jAV3HKAqJavQeQ8lppLEJtR8C9CHFpXCdn/FlxswJkGb0aR0kyZdaEO5Qd2?=
 =?us-ascii?Q?tVpBzQiiKw5k9/c+5Hm1SzgqYMYjalC8g6N+J8+QZT3TTIE6XdRZ1L1ergmk?=
 =?us-ascii?Q?c0mRh2MjyXmMoF3A59oP0L9qd1z60Apa/Lcf6arzSauhe6zOIukgBXAcgL5B?=
 =?us-ascii?Q?WBP7Fci3zwHbmykgWXglr67mWgjGpREZlElShpBphL2ncl6dfuiwybbvL7Cu?=
 =?us-ascii?Q?1cxZDvc2H+EiDReQRFxhaeW5Epr2evfocqyV+6o/Qxw0RJwk3tMjRFQSORM7?=
 =?us-ascii?Q?Jot1kNEVdr3ze/D4FgmxxZtFNd7bqcbjauky05QrYaUTEMtnbdyh7QXReRtB?=
 =?us-ascii?Q?RGyUO0PHOToPt+R+VTPrRwCdlQhCJx2aC4RhCvk3YpSnzAy9I+bHKT7wTjcQ?=
 =?us-ascii?Q?t1sYvKDW+iZXSjpIJ/6ypfIq38XlzmG8/OZD5VVCNiXZofkYQH6cfKtN/w9H?=
 =?us-ascii?Q?XbvoDXW854ck28HKGTS7bFop8aGC06Wja6FbcUircTzX5vOMqmEuWGtVovEF?=
 =?us-ascii?Q?Hb60U+WzhvcKMc5eYQQxcj2jT+eD2wqBD4w+jZhAKc0Qa8m/3yIkDMqO0oQH?=
 =?us-ascii?Q?DZ5avT/iN70S0DvTYdtjH0jEDqK1V6uZ1dSYEIMlJsBbcs8500WTRjT5y0BL?=
 =?us-ascii?Q?EaIVP8eAlM47B+z6KMJ9txKnXb5moKzL1lj9PkY4VoL7wODSXROM9Pqkgv5/?=
 =?us-ascii?Q?VnKdzNhc4O+o2/dOOrgOPy0xPcQ2vbeYho9Myq523o9IBTwx4llw7Q/LNVmp?=
 =?us-ascii?Q?zZijPOA6nzGOnzDLcx1HPkjhTSMrmgEDWlN1uYo6AwhOKjg1eGNZfnaAhUdl?=
 =?us-ascii?Q?r7m0bM9hPAZV9+o+DUlD43yxaGeKlD3inMGWb2X8SQfKS8299mBo1cID/VLe?=
 =?us-ascii?Q?juqyeX3Iu/s1hc6ueAava4ji214YP0+fFWGYpGBgAFggloX4n4DyRrwxGums?=
 =?us-ascii?Q?bZCAWQaD/7paAgSNUoNLQuacEa75xlzrqbpQo1hD1fACuM44fTtBAwMsT+lU?=
 =?us-ascii?Q?fNMsbFnFu7JK2LtnIE0odDu2MJcoaiIoUQ7URC3cuMlmBf5fTy2c+W6pNpUP?=
 =?us-ascii?Q?0/eE8WgKctIX9oEwTRCTyUufGVWxwyo2oqtUopzesbq54Gyw8iGanObbY1JB?=
 =?us-ascii?Q?wlRoj7QS8A9Lo85kqw6eJ9UCXk09Kd+0EHVA4J+rtIWfRF+YjQZxtegevWIz?=
 =?us-ascii?Q?lpSxM5m508XABk6mnR+gbv8rNIn4zoEB7ofD1j12?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ef0be7-71df-4eb0-195f-08ddd987fad2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:01.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaHwFtz/g7LEgR5Ehe50hBiXsCD9frCjck1ni+5DIBcfR9scTIyZF+uTFGxXPNI8NwcBLpfI3KhJGH1ntDHDZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

This series adds NETC Timer PTP clock driver, which supports precise
periodic pulse, time capture on external pulse and PTP synchronization.
It also adds PTP support to the enetc v4 driver for i.MX95 and optimizes
the PTP-related code in the enetc driver.

---
v1 link: https://lore.kernel.org/imx/20250711065748.250159-1-wei.fang@nxp.com/
v2 link: https://lore.kernel.org/imx/20250716073111.367382-1-wei.fang@nxp.com/
---

F.S. Peng (1):
  ptp: netc: add external trigger stamp support

Wei Fang (14):
  dt-bindings: ptp: add NETC Timer PTP clock
  dt-bindings: net: add ptp-timer property
  dt-bindings: net: add an example for ENETC v4
  ptp: netc: add NETC V4 Timer PTP driver support
  ptp: netc: add PTP_CLK_REQ_PPS support
  ptp: netc: add periodic pulse output support
  ptp: netc: add debugfs support to loop back pulse signal
  MAINTAINERS: add NETC Timer PTP clock driver section
  net: enetc: save the parsed information of PTP packet to skb->cb
  net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync
    packets
  net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
  net: enetc: add PTP synchronization support for ENETC v4
  net: enetc: don't update sync packet checksum if checksum offload is
    used
  arm64: dts: imx95: add standard PCI device compatible string to NETC
    Timer

 .../bindings/net/ethernet-controller.yaml     |    5 +
 .../devicetree/bindings/net/fsl,enetc.yaml    |   15 +
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml |   63 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/freescale/imx95.dtsi      |    1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  209 +--
 drivers/net/ethernet/freescale/enetc/enetc.h  |   21 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |    6 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |    3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   92 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |    1 +
 drivers/ptp/Kconfig                           |   11 +
 drivers/ptp/Makefile                          |    1 +
 drivers/ptp/ptp_netc.c                        | 1127 +++++++++++++++++
 include/linux/fsl/netc_global.h               |   12 +-
 15 files changed, 1474 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 create mode 100644 drivers/ptp/ptp_netc.c

-- 
2.34.1


