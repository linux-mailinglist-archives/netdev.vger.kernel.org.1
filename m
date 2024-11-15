Return-Path: <netdev+bounces-145150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153C9CD5AF
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE64B23064
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783117DA67;
	Fri, 15 Nov 2024 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X8SecEO2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37812224FA;
	Fri, 15 Nov 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639811; cv=fail; b=I2SzfG6E5Kk+6xLjKccFiBGL++ADgdHdNBeBK4YZ5iOh7r0EWZqhQrpCGq4ISnAel39B30nCjHeRnm+pp6IJDz4BsDuazClCzlYbmn5ffg2hd5h8MCR73L9Xt8r2VIMAcyA7sWPwWg7uILiSx/0q5p5iopI9fdGM+CA1h8e+nNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639811; c=relaxed/simple;
	bh=seTMRWUKJatIcpUtW7HUi0YEBmtjIfz10tZv6jofIMM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A6HG/yRwpdA4GpiJb4QzjM+0FipsnG1qo7gFGwSv0a7ppjmY3FMmimkQ4hNnxlQEncQnbQh5nTrdA97Oe8Gnwk0cxH/hb6qEH7yEpJjrrwxYytJN0YgCM+qQD0tlMEX07eMB6rDhh05udNhR8ZNF7LzNIs1oaOp1b1pVbOau/2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X8SecEO2; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuuYqXljsTJF7X2RAKcZ983AtqXDZORhHM1rzvRGFKVv7K42TD7gbgi/f3+mpuIUPWFrIAPcigIOyYq3OuTSTE8Gpv8cvJZHwgBPFx8isG459sWSOkPGH8kYEyVz08flG2jocYDjlDZIt/jIU+OC9AXBiWOa+OOLbmVNA8AuEhdLcE/cibk8HHCqtFGw4sm4PDjHz22/99hTlKMf/cOMPwLlazTJqGjWRAXNM0dl9lr1nS/DMRwlOjjyyOF1JTc9wqE1PE9uY2SmgpI8k+VQLT7m9nsKYs1lOYhqRpJMed+RBrZWxzNh7NBllNktDrQ69wF26SJyNGXt5boaANYIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0FhedZOIErokV0cbN0PZkgr+z31bB6V2oEx8mof3z4=;
 b=uS7RdPNkytA6OH8wUl8BgsVm4+MEiMTTZT4iHCtpvi/8Uv8k14erYR1n8WB2j6z0HMvHamGHyz/KkK0Kb28cUIVWZOSpaMbRpt3qtEZvNBZowFg4TU/fgkQ8cPqnm+fneQuMqheThiHrkSXJyywH8N+3ou1OpjwWg8QnRFVGNCazyFWzkgGq6k4+RU25m56TuqwFMMc2MB1CDCqCnWZKeA2MjieSt3pcV2nEYOdP7x5TvZxHhG8lnbFxU6stDtRnaycBMPSDmFxBQsrnNWmDWo5Y3yPm4rRpe8+ERzZS2rZoUSZu7EMRd31y/N/eIwxcLN3wuy6NLqwN6N/xe4k3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0FhedZOIErokV0cbN0PZkgr+z31bB6V2oEx8mof3z4=;
 b=X8SecEO26yNcpF63K+lB0TeNAT/gHqGKP5x56UqaRIdUvXHBnCJiASVkM1eh9wdk449J9Ic7Fp8ZH/3ar1M/XwzqkPXnnVDDgTfsasiygDEndiFBZECXS3QEHvrMN83qNWKFNGloRwSjGhcLlpvQai/euQ9l8V8fCibpc9v3IORfIzK9nAdSXYDbo3twBc0vsop65oLoD71j5cC6GD7fBxDEf5Ltd90SzysNVSO3txhJGxDrBH1oLzkIU6tZHfTh0TFhO7iaHPkhYibY0IeykhWVPN/6BLdFVZoJxHAdHe2mYnRgoRIRtyb7KfCJ1EfFNheVVxWPQ0UEP5lA6Zclyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 03:03:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 03:03:25 +0000
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
Subject: [PATCH v4 net-next 0/5] Add more feautues for ENETC v4 - round 1
Date: Fri, 15 Nov 2024 10:47:39 +0800
Message-Id: <20241115024744.1903377-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5283ca-6d7c-4678-369e-08dd0522126f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LgexqpYvRaG7r47ARkqs5+KVgDfZUZignLd/nqAvwQ78ZoKna+7kpp50daYu?=
 =?us-ascii?Q?wkbmooCB/dcFULu4aULyfvIvieX3fL6GEYIHUywBPD/Pq8XC0IgogpkaDm98?=
 =?us-ascii?Q?EpWkJhFyq4+NsOqZeHdOj2RObKixiVjlEHdBRvydFGz5UW3CNzEY/+sfcs1p?=
 =?us-ascii?Q?9NXkCXdSMmZRBINOxQaf06v7jujMxhKPhdmgujZ/FdRDe1FLvTcbqHRGeHCJ?=
 =?us-ascii?Q?GuSJrpsTdtMfKRQWNDONL7tYSkW2BvxfKoWIONIXtYwlNl+k6qhdBLqYGFKy?=
 =?us-ascii?Q?MN+0ffoQIjBKaP+0CH5qRK9kj1Z7w6z+ZgZXVawCKXPXyCzp/ihEyxq+3By8?=
 =?us-ascii?Q?6qcGSHop/W+nDiZ1CB3opyFJMq7sZeBt0sPcI+UbEWkIyj49Ly2JFiD9RNr+?=
 =?us-ascii?Q?vO3ctDLRLs85nzNVUtgXVmFHxrS4+4PDudLMSEfDV904l8Elwl7ZGZemHLnI?=
 =?us-ascii?Q?3DvSpxbZ0Iv9irY5d/ZWSiYxlTtSep8Z2aqB/JCrzxZIxlvuBW4Uf6N83YYK?=
 =?us-ascii?Q?oJlumgsmDhNRBtJ+/SRR2lcZep/+Si0BA0GUHNC1fLLfz4ZvmqlkuT0RKOrX?=
 =?us-ascii?Q?yUYEPdx84EX2R4381uVykmQ+jYnQR1U3idr/M1+DbPkIacskjr2Qcz1Fphsd?=
 =?us-ascii?Q?oUZQhoWz9pv3bCJMiqXT2JCbpob8WWGR57Rxkx9toxekX/slI2cI9QoJ3ftn?=
 =?us-ascii?Q?fSW7LgQEnBnqS2nM3VEGgFaIqHy8xesU0Iv7bGrPKO1AHCLiZSZyA7FYECvR?=
 =?us-ascii?Q?r7SO0AR1qEdNNQgfHbWYPigAMRjuJ4BgWcM66RIqNcbw3IX3pCn/YOjOWZoM?=
 =?us-ascii?Q?+VMXMAohUiTxlAu2jadV7FTO3cpcWv35rDPwKv6wYbggdqhZNfOigfrHex4S?=
 =?us-ascii?Q?7MPgtk48Qr6ogkDdd7J/UbLzkabGHYVL4BW6POdmXpJK4jjLdblXa9jWBTah?=
 =?us-ascii?Q?kdEPLx1QUI0Oh/HYcnLW+2Fqyhc2N/MIQPy9LoEpGqsN//CRwEFTVw2YobsK?=
 =?us-ascii?Q?/kxEa1ArtxWekJL3rgWpsR6Bc34shT6XCqaSUwPXM7TeD8l67uoZRz/MIMaO?=
 =?us-ascii?Q?z5J102fkZ8k4sGJBMwTW3yWYiWUDqlrvOFHjXaYQXYIAg6+68kMOX3VirK5L?=
 =?us-ascii?Q?pasrmqx+KeCTWv1Y/225vR/LkUPyfLotqRNDnEDuBZ+p6AEfMPVR7f4vvIFu?=
 =?us-ascii?Q?3SLnKBLAwdYGeYtLamrIymQ8U1QAAzWTgfJdCwhjHuo1lDqYyCEWavMm8b5q?=
 =?us-ascii?Q?QWlexw/+SGxK60Vpd29g5OaTjBnTwXmjOVWmYBAsjtq8F+rXDwKz/YbNdyT0?=
 =?us-ascii?Q?cFtS77YKyzvcJ5iZqI7g3DNH9C2wP6eLNrUstsK4hfhJSk/yqf5HicfRhIjq?=
 =?us-ascii?Q?dyVZ9JM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ztWltX2eCeskcse5wJ0Q/eaAu8GkAPQHhj7f5rc3eyo0klOGqWMHwr7QaVgZ?=
 =?us-ascii?Q?mVQUfe6dUgmhOPMqNSpes4SfpIsZrvNyhRSl4DlLmu/a0LT905ObwmGXqEJi?=
 =?us-ascii?Q?nQhtWYFHGeDXLJHaXZD4DqyAxGpItVqVX/o89wZomXSxXta6ln04FyVxWe1v?=
 =?us-ascii?Q?MEUo5gAmkndoSyzhakzZDzWL5FkgUSo2MjRQbAp6alsRvvPTGfYgfN6G3EJq?=
 =?us-ascii?Q?zOO2jTrD2rDILkN0TpqB36rVV2I0WmNvz9YY11MYhXY3vRgYqJtv4wEulfnQ?=
 =?us-ascii?Q?00Rpn3vqgd41VhT2HPu+TWHq27i1wWPbsDnU9hWzKa1128LnPFTSvnX2wcf7?=
 =?us-ascii?Q?jlaOIuAwCDYGwuiGSKVn1oXFXNt9TB1iX2/ztYriNegvkFGjqRvwDfru1qoU?=
 =?us-ascii?Q?gSfS28nlaNnQKoYHfb9GcQ9Q4UaisjYicn+eszuktC09mCdZFyNnDGGdJ+NL?=
 =?us-ascii?Q?qAb3Cm9o9kC9aukEDSe9r/Ps0w2omQbT+finvdJrZr6o28czA97Tm6fhjzV+?=
 =?us-ascii?Q?oRFDdHqsOIaG+iI24L8NYz/PKLl16H/YlDi3DWQ1DXjHlql7XsDHvZ36IDbF?=
 =?us-ascii?Q?TVtCiIRPuC51FfD+s7XHHlBgEpO+JNMEwUnUhrRq7+VgIq4nw2OMyP2NpYEZ?=
 =?us-ascii?Q?tV/FbKO2PtoOA8M+bvxrGZdbswgVjJKq8mfIwW/W1GU6EDA4Z4B7wH5NUWIr?=
 =?us-ascii?Q?3vPY7ftFxls7LZf5hjrFIQDc2V5mRO4MWXN9B300Wu203Fhz12Kpfrww7tdw?=
 =?us-ascii?Q?HwzR+x2PQuHN0iS0/DW8PXHGehzi3aG/eZp+G/rHBPBezUW0KfwR0ExQ+G34?=
 =?us-ascii?Q?qIuVsqOJYnIiWJrSL+QajMbBWI6nnjNmH8IHNlHiLvNmMQkkYN4nwIzTN4t8?=
 =?us-ascii?Q?2vH/3tyB6B1Abo25Eh8+ExaTEVgEvpBR90irJ78s2P3I9EZY5LlWid+3+2T6?=
 =?us-ascii?Q?L5hfZnvmrFuqwKTeQS2dhbhqBto4yY1opQISW0lqMniuSeopy1kJgQF/L0L6?=
 =?us-ascii?Q?zOOyOQhbB+sy1PbZ9musZqD3U4aSInOALVGZmsURnF+2j3KtjBxJqwkLB7JP?=
 =?us-ascii?Q?rUGIkrsGK7FYSqCi7XRUsjbbnvvACxZUFdSJ1otjAeMWiD25rfvKB4sLY4SR?=
 =?us-ascii?Q?VfoYSLxlfo6yhaSzMTgiG5yVh3FuUUoDT8jEzuNkwZ13gSFeUw/zlPko+dNn?=
 =?us-ascii?Q?Y5+1s2XUSsKDYqxlAXK2Hg+GBENYKW/Y3rwmmP3AUz2P/45oDT2EEmYTUF2L?=
 =?us-ascii?Q?gujwCWDukOn8obXhIqY0yOetmEjY3uXFMUF0B32qmkqrd3WfpGhvPYbq6sjD?=
 =?us-ascii?Q?2ejdKppcsKaSHZmXuUWeJosPzRfdQGj+ktRVBEM24duvh9c6ZtY4XOaPMk3P?=
 =?us-ascii?Q?xN1Dgr1i/Rt/smRxhx3jCMeFNR/io82roA0hzpfg33koYvsCvbRz4AfbK3xN?=
 =?us-ascii?Q?wWmPCvv6fxTFnLp1eDeQYj6B5M0EZB7EQXofhLJuQEwtS/xMYvIrdrFHSPzO?=
 =?us-ascii?Q?2YpEVPyBoyai+EfGLQDMLUZVyK8BlP6NNyoO3M2xjVq5dgmDkcbggbSNJiPE?=
 =?us-ascii?Q?LZB5OsAkkc0W9udHt/ZdEPNAZlB+tfTKMsQgf67+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5283ca-6d7c-4678-369e-08dd0522126f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 03:03:25.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Md4qMnI2K0ztwtsitxHzdoOzDg47UMVKDR3EmcLo3Ajrgr7VKUXjfzgfZAuQPiI0P5NeOeeUYy/vZDvXmBkECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028

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
---

Wei Fang (5):
  net: enetc: add Rx checksum offload for i.MX95 ENETC
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 344 ++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  32 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
 .../freescale/enetc/enetc_pf_common.c         |  16 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 418 insertions(+), 34 deletions(-)

-- 
2.34.1


