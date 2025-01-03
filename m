Return-Path: <netdev+bounces-154898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D50A0044F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4701631E7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328391C2443;
	Fri,  3 Jan 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K+/tBl8y"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBCA1C2304;
	Fri,  3 Jan 2025 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885432; cv=fail; b=CrOCNd7nQUy0EXRKGnCf/4O/h5SXjfCyX833Iil8kY/ynDEI8xYp8xE9WPqAnjFW2BVZGRS8jkz2sHdw6Pv6YNZvWCzzxmzmmzMeGBZwl+nBVM58gqC7r9T51g7VUR01fJcjCQqql8VW8HdqQLSlqOW5/6HOPNoWF+jNijLlKCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885432; c=relaxed/simple;
	bh=Bnou1bbhVRNe+Bh8EnXhERm+89rQi68IDBnMUQdUVB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fauUmgx1017dq0fly79T6Tig4Qq5+e/DcqUmR1R01Ke66WioGMXRuGu6Wn41mwbmz1u+Xa2AARCrLRXRpi4FYCqEMvBcjmdjL8/L/GZWILIi14bXwbgzWV6GK75U69F6P4asXtDecevRlv+k7V4V0ZoAPYudR0+BRlUjXJ5Iypo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K+/tBl8y; arc=fail smtp.client-ip=40.107.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sd2DSKmcMOT/+etBKuV6Cayc75SwlUE52UpkY1Dgvxilqb9unDNaZWK+3KsUEL96FfcTHAWevvL29Mib+1pgbH+tzeq+gYlmhahoIvrSDkV7FTQhxbgxw1xo+ZwCFwuOsTw+I7oyQN2uEyV/q5wBBn0qgPSccmI2goquyHhIxL+2FhYEXdCKr8WtMzBD17v61YKiM3by4sY+285Cg5nNlGu1HHUuY3kyX8SxhiihP4k3auhCj3ONB3uHNKZ2TIjG0bvCbIZB1fd9lB60la8Xh8XiXIN3pIMqLUy2/LrLAOD9MwaHE0f3an/1SwoZ7h/gt5TybJuc3FjuUNVIsEMYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvI+Qtevc4/gpebHs+HCKRERnuaKPkBcj1HPAJ3Rn4A=;
 b=QWdNRrnI2QSGccKYg0KEYWVQ/xeZEdaArH/uAIaLOLVJOIOCufPs9v9NIFyI6bcrAhU7L1UdOPWE6FIedUcayz6RfgTYKjryJdzUcgkUCQLP9CoacF8kihK6/w83xXt39e7zuhvsHlIn1HmP/eWXOnXxTka/Fh4xVxfpUJ8U0M6lpWSogsbLzr1hb3e1FmQCYT9KsHdHpqcNzH1CTH+v721vnf7vkxhXZxlunDMouOYSRl1HOKusWkEI3vLJlyPOpAd6qoXGxgQV5HmpJnO5r3XsdjyKQExI4RpK90CrbxEr1qqwRMw5CEDLSiLaIoWgX5EDE/og3q5Sbcmuyq1yCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvI+Qtevc4/gpebHs+HCKRERnuaKPkBcj1HPAJ3Rn4A=;
 b=K+/tBl8y6fT9OGkSASLqdDDqU1tJEAg3vhel4w28NjVrdQl1KIqRKW8TJqeaO3XpydxyCBzLH4Qr37fsSFr0ZQwMxM3mIIxJxZo2y54Pw77RIXVSZFLkTslfs0o4uFVJboU+yMsU/fi56p76m9JzJBobDRldsuTM9cBeE2ZmcEGNEAR+HZnpG8MOTu7iY0CZZPnjUaEpRajs6mt7oRlXl3v853f0hWuovC+JsTiOUr6IBKTYqWyx5rDg7KvXDhP9Q3+NTV3r4g2dT6pR9RMkRYRFH8Jylzl/ZGFPFHQIrPRmJRfsNffLg0nl8qdLLlAfvWl37VhrYa26S8F3kmmzXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9331.eurprd04.prod.outlook.com (2603:10a6:10:36d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:23:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 06:23:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	christophe.leroy@csgroup.eu
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 10/13] net: enetc: move generic VLAN hash filter functions to enetc_pf_common.c
Date: Fri,  3 Jan 2025 14:06:06 +0800
Message-Id: <20250103060610.2233908-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103060610.2233908-1-wei.fang@nxp.com>
References: <20250103060610.2233908-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb0faf6-def3-485f-7104-08dd2bbf2be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JVxr+VXmUMr1CS/u4IAnG1hnMwC5uJZ6CGFeQOGXF/QjaZ7ch3DxIisKe1OG?=
 =?us-ascii?Q?bRTmn4SDyM1Bf5dJW26Z559mTxWVmRfAxhmBGdl6GShcrRlutorC7zMFfCEr?=
 =?us-ascii?Q?4FRjkeu83NhhqzEEnUMo2JQtWa/IP9iDkuBEqRNjma0RpWveFJM8pnBj3yw9?=
 =?us-ascii?Q?rrnRrUAvpSV9kYT07cLL7PaBYsW5Sb+LdI+sfAhLZwey7rDUvosVEFsfmuu8?=
 =?us-ascii?Q?Pv0tHuKjGUslFNpEqNbYKGPLVGTnVEyDBo89MXf4UtP7lWZZ6w+8jYa4cjas?=
 =?us-ascii?Q?oXGRmIUeQA1kPwOKL2vqvDD0hlHH5hPTAe1raKN8y3pcZAtrrntJKImd0ZNJ?=
 =?us-ascii?Q?+be517Jd8ynQUoZPpHQCJ1dDfywe8rBgBzXs/xqZCJ9UrN8dzUr0rcI+ppZQ?=
 =?us-ascii?Q?206Vq2Ag3Q4bOd3BPOb82TWlO6TQzG66gornv74ptJkmVTiSfVbmn+WSB1+m?=
 =?us-ascii?Q?OyXNiDUC0xxUUWWYVmwyZ8w7nVC5jz4Pxs30OSCTHefr2sLeJNC6Ev8Y88W3?=
 =?us-ascii?Q?sfuslmiDaybAgw8dbBwFs/am7kHqrzYumbMzDl/KNUYW2hqeu0zKwa/xiqp+?=
 =?us-ascii?Q?aaImme5bJAvwiCcDXcr8sCjVG9scRE4N6bJlVLOvwBu3Ho2LcS49koaa4NYp?=
 =?us-ascii?Q?1twM+nsnevHY7Q1ErNRXOuFU5VNPWe+uQdDc++2WrJbVmQlFcOmUgFdWtQSa?=
 =?us-ascii?Q?Ou4Kmvo1W0MNPl9x/er+y2uG/uivpLv0H1NgTRVXzncW0aeMfZFoEmitUq/K?=
 =?us-ascii?Q?3OOH8zVFF3zQhl3fl5r5/cIATOKQ6RnlS0JyvSJE2kvEXulDG9eOz/HZciGh?=
 =?us-ascii?Q?lNfNY6QzSeVqpwWIRxE+GuNnCpdpM3Y5zKgrkfXPSOfXUnDerUCirkiLcTeO?=
 =?us-ascii?Q?fBCYBtj8cYuYBnlOQn8mMOlSQOrZkIo3LdyqyT7czYHvFw0Gtb2m0b9XgFPw?=
 =?us-ascii?Q?9ROgUleDRJ8LsPPuLrCPAUHb84Px+k29IcBYLPjxORDzJF/dW4iacwbZA7zF?=
 =?us-ascii?Q?lgxYzI51eDYl3X0yQyP2mSqJFuC2jpl4BsKnmoA261HZkItFu/PT5rUBrjP2?=
 =?us-ascii?Q?LWIvc6pP9cHXZU34zpGr6ja/QcSPQOIa/rrtN+pLu1w/ghxYZE/natoLCckk?=
 =?us-ascii?Q?0Th2YVBFK+HeUmt2h9sVKYYNBEUtSUkyIF1bpmSiXKITM0Qlzk55NbSygo/Q?=
 =?us-ascii?Q?IgR754PSDbbOEiX8b5/QI3vud5VXq2I79/NO91vxnnG56tkqH9J8zk7VFExL?=
 =?us-ascii?Q?0ZMjlpVyBHopEgmR/NBI/7S4p9pY4ibfFZNtvWoY/zaoRGuH3H9hwvw0qmq0?=
 =?us-ascii?Q?5cHpM10xGa4ecMUZK34Lx62mrAsRjC5Vki1ukqR0Sx4mvVRDNadqGI/WrYe3?=
 =?us-ascii?Q?d4pRiI0QYzbqZaF2y2eT/jbVeI+jndltMuaODPOkGaw/a6oL1t5j8+XKkXfa?=
 =?us-ascii?Q?6Qg+B9teaPSkqWIzyllyhDBm6vMwCtw7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3c+uDYh8ZQ9GR1dwOlnxEcz9LFx98150ThwjmUbH6ji9c3sqRpTjq4juXUuL?=
 =?us-ascii?Q?wv6+RMK/hB8H66qEVoE0x0Mo6jFFQ5viSi25ah167x41NZ2UUJNCK8TU4jAD?=
 =?us-ascii?Q?aNd8fTRh9ZByK2NW9SHD3r3aDz3y55OuA3y0CFG6pm9Nc+b7VPh6WfBeBuzb?=
 =?us-ascii?Q?Kg5XqzQPHOKi8oLBtVZ+ssrpIR8JUwTjx6hz8mRCWHn0ynm5LHjeMe4iFGd+?=
 =?us-ascii?Q?OK701i9ozl/HmQvURSi7SSU1RU700O3gDbZT2IGrTJu6nfJunAzV8W6cPgCe?=
 =?us-ascii?Q?etwP8IRoKMXm4CbgGMJSgipiT0UyaIfqgnGDILcRQG2NptanVqhAHS8nznFz?=
 =?us-ascii?Q?ycZ/pe4yRpWI2Kxa42wTd6cddW4nuTTl49aAKkXtRyDcjhswztGRSyR0W/Mj?=
 =?us-ascii?Q?3SW0n/oyHku2ES+d3NqYt5XLvzaREUCS3KdcjzFrcLJe6sQMPx/ZsFO8Tr+r?=
 =?us-ascii?Q?F4rEwDMiYTejQHLyMyxUidY7s0u5+Ntxk/xk4SQXJICVFLC4/aX9KeXkJvwB?=
 =?us-ascii?Q?mz64vyN1m1ftcKtXqN/hmwDZd42yGaxKymh26iPUFwQLS9AXl+GU/cYt5fJD?=
 =?us-ascii?Q?Up9pIPzx8UcOCEVdUWl1a5px7yitFCpIObiiKfil5GjohkvojJlWbyCrRV1E?=
 =?us-ascii?Q?FZiGlmfEbkqt+o2as25tUoGVEU47K7ebcjJ7nTjp2fsoF28glSxlNfawPQwh?=
 =?us-ascii?Q?fwbXPb0tqGdhHf7HJ9jU1S3MfPgoLZ+uOddzYSUkZFbH4nEqfsDpBcT73InH?=
 =?us-ascii?Q?pvuF3ezQdmnmxsuRouG5v1oHaQjE0382+krhhZS4P+atO+lkTtbIFO/I0hPv?=
 =?us-ascii?Q?ClcaEsVD0PCteuo4uE6CXlCpNxgGgdBy8+yzDbOaBh0MpX2M9qo/0C7V+rAL?=
 =?us-ascii?Q?YrO7naUIP2ubmuiCN+eQxcxI+nKukKeScl3USBXYyfrU4jo/3hrwVwPSErnF?=
 =?us-ascii?Q?VRyQQAbc+rxxXXLI+bpJxpWuxlttQcDDIRyuVwDO6vnVDQW6xvJp5q0wZp8i?=
 =?us-ascii?Q?SbL23UfRHKP66zrcwvHAa3vw4IhS7qBk0nLZEpV9RVDaU3GtGHI6DZ2tiAmJ?=
 =?us-ascii?Q?2sbots2mykVX2B/0CZCiaM0M9ofZLAwTXw3nFim7qjVfXcijJaWFLb9bL3cO?=
 =?us-ascii?Q?toBsG01yggs5hcKlU6ly6R9ob0Hf1OJBS+O+XryuPI6AgoMYxU07jPKNXY03?=
 =?us-ascii?Q?nLzrbuiMMu/fTO0aOWwAs5pQfi/YP2xQETBnu+MGuqmUEvdQjonUm6nNHglX?=
 =?us-ascii?Q?pIQvzTzpGsmZavjC2S9GN1GEZx2dGp3wl5hgxLtIeIL8FjdW8bQhLj0vV9oQ?=
 =?us-ascii?Q?E+DvhKnCxlNMBQADPQzntj9y/gFIlld/kvtbEE95M9wGAVmmQ95TAx6Xpsfa?=
 =?us-ascii?Q?+qRX+tocvRxYOQCiLWHbGUIUsAyG97MXmVR56Z81FXHvcESkqmAa1g4VbI2z?=
 =?us-ascii?Q?IPSwV7qPKE9dYkKt1UlChzWCGEWFHbBHilKScu3jzGaqnAm5j5McdkwJOylS?=
 =?us-ascii?Q?nFW0KMymCpfoPXvusci+UM9PhIWcBZMvjKlZEjypT2OEEEHrPHlLLYbHkdHJ?=
 =?us-ascii?Q?DBOHFv7VGQ/AVKr7Pgq85o8nm0kJan6s90KosU32?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb0faf6-def3-485f-7104-08dd2bbf2be0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:23:43.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce2urAadZq5RbtlAcsM0ObLNMNq3dudQtK59XJ15GCvLGf86YdD3FeIMKL8cbCd57WDQn0ldkId8/bTL97CncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9331

Since the VLAN hash filter of ENETC v1 and v4 is the basically same, the
only difference is the offset of the VLAN hash filter registers. So, the
.set_si_vlan_hash_filter() hook is added to struct enetc_pf_ops to set
the registers of the corresponding platform. In addition, the common VLAN
hash filter functions enetc_vlan_rx_add_vid() and enetc_vlan_rx_del_vid()
are moved to enetc_pf_common.c.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 34 ++-----------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         | 34 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 ++
 4 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index c0aaf6349b0b..d9c1ebd180db 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -215,43 +215,12 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 	enetc_port_wr(hw, ENETC_PSIPMR, psipmr);
 }
 
-static void enetc_set_vlan_ht_filter(struct enetc_hw *hw, int si_idx,
-				     unsigned long hash)
+static void enetc_set_vlan_ht_filter(struct enetc_hw *hw, int si_idx, u64 hash)
 {
 	enetc_port_wr(hw, ENETC_PSIVHFR0(si_idx), lower_32_bits(hash));
 	enetc_port_wr(hw, ENETC_PSIVHFR1(si_idx), upper_32_bits(hash));
 }
 
-static int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_si *si = priv->si;
-	struct enetc_hw *hw = &si->hw;
-	int idx;
-
-	__set_bit(vid, si->active_vlans);
-
-	idx = enetc_vid_hash_idx(vid);
-	if (!__test_and_set_bit(idx, si->vlan_ht_filter))
-		enetc_set_vlan_ht_filter(hw, 0, *si->vlan_ht_filter);
-
-	return 0;
-}
-
-static int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_si *si = priv->si;
-	struct enetc_hw *hw = &si->hw;
-
-	if (__test_and_clear_bit(vid, si->active_vlans)) {
-		enetc_refresh_vlan_ht_filter(si);
-		enetc_set_vlan_ht_filter(hw, 0, *si->vlan_ht_filter);
-	}
-
-	return 0;
-}
-
 static void enetc_set_loopback(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -971,6 +940,7 @@ static const struct enetc_pf_ops enetc_pf_ops = {
 	.enable_psfp = enetc_psfp_enable,
 	.set_rss_key = enetc_set_rss_key,
 	.get_rss_key = enetc_get_rss_key,
+	.set_si_vlan_hash_filter = enetc_set_vlan_ht_filter,
 };
 
 static int enetc_pf_probe(struct pci_dev *pdev,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index d56b381b9da9..7a0fa5fba8bf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -39,6 +39,7 @@ struct enetc_pf_ops {
 	int (*enable_psfp)(struct enetc_ndev_priv *priv);
 	void (*set_rss_key)(struct enetc_hw *hw, const u8 *key);
 	void (*get_rss_key)(struct enetc_hw *hw, u8 *key);
+	void (*set_si_vlan_hash_filter)(struct enetc_hw *hw, int si, u64 hash);
 };
 
 struct enetc_pf {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index a737a7f8c79e..9f812c1af7a3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -343,5 +343,39 @@ void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
 }
 EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
 
+int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	int idx;
+
+	__set_bit(vid, si->active_vlans);
+
+	idx = enetc_vid_hash_idx(vid);
+	if (!__test_and_set_bit(idx, si->vlan_ht_filter))
+		pf->ops->set_si_vlan_hash_filter(hw, 0, *si->vlan_ht_filter);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_vlan_rx_add_vid);
+
+int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+
+	if (__test_and_clear_bit(vid, si->active_vlans)) {
+		enetc_refresh_vlan_ht_filter(si);
+		pf->ops->set_si_vlan_hash_filter(hw, 0, *si->vlan_ht_filter);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_vlan_rx_del_vid);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 48f55ee743ad..253310859ca1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -12,6 +12,8 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops);
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
+int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
+int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


