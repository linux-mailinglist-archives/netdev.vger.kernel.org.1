Return-Path: <netdev+bounces-218120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11753B3B28D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1941C86790
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533922522A1;
	Fri, 29 Aug 2025 05:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bGx8CoW5"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC4250BEC;
	Fri, 29 Aug 2025 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445311; cv=fail; b=JCpGlxrsnJqrqTl4pgOEy/lFlHP8acQ8pjrAZTnwBpcW9OKwQtzp9+Qu1LV+nj3Y7S1B4xJ7ctZnmnfjvuLJlJGyDAqdUYOwoMcHJ1NfTtwL6RpVNkEa3nyuhqJOJZlR3s+zOaqQslZ62PwoWiw3jvnbM+5e9o7bqm6REYF6OO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445311; c=relaxed/simple;
	bh=lNV7dEWQHA38gt6sztJXojgBCuhBNzqQGGtnZafw/kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HakqnT7A6vskWI3Y6AFC+B56vgQyF5+TBWy3hJ4bjygt8wj+YxUpvcswkHKEwhotBBCE+Xj94ltrSljSu6NODnZ8TVdG/Plli6UhJK0uot61HhGLDVTRUolavJjj00dGJSKnGvQx+EI4pfA/zsDkFLkMI0PZk7NcR3o6xuAx208=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bGx8CoW5; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUfIP+wKKXMFQIWrU1xER1fqT+QkryqdVZbu1NQPFSYpb7NEmok+e3go7K21bRWtrtkQCDif+h/kNzUqwI3SR/OUxAviKXJrtkn8trHrVVic0lYrmfzFIKxYC4IIzTJsuL3KtFGZ7Nw30J9vGjDIqXqxY1VqytYaq2sBFzgko5pA40LGg/MkF4S4MDRwW/qqrZj+havAqBX3h78wGmSKZcJTJpNYYtfJSQ4P71OoctLCp8uJfqs4/ewTrnjL2OC81v43JGp3SVF7xKyt/UD51tCPzsvd2vHI/tYo6RQCZM71J9oqKfVperp+mDdBHbK5yyql2zS2kKtdmCGGvCBb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaKmAE9YbBLjEGUI2po+vwhi8ekhLxsn2jOlNdqIiWU=;
 b=j5hsOYlwm39NMhY6oCaMPtyI6/8FH4thZsPUbEVrE8uKrTIDSBjy/9xe7ZED8s/iWkaTD+GcxapTgF1RPX/ysqxT5y6usDlx4cva3bBnY1T5QCv60Ar2g2Lrv40fNwYg2DPnOh70UrT/mVO8ML5qe/4gZwoB1gCBfAD946Ux5ozy5XEtIKZ3+IXiGvZ56BMdzSU+DLifBPB8pMz44GFqqFIJ/NHXbywQbR0S8y2MNuQSrcTnaaryo+MandVYJLNxQxmLfkp5gKW17+g2xio4KmDmUbEN1F34oXY5QRsJAf4KMU7DqMoCYHjE7jpTQeoPHEqFLPL/vrrQH44W4KDuLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaKmAE9YbBLjEGUI2po+vwhi8ekhLxsn2jOlNdqIiWU=;
 b=bGx8CoW5MtK2cRjcPax2X+wVcZBdQwTxcB8p6R4q0wuIap7ajHj1vuzFS42kOkZtAhZUJ17iHunLEZgvuS8ytgUziqHmKIraTuWemnvw7LZRXnKrVk4UZ/W+fEdjIpE2sv/lfeYzqL6eAzF0tlRvOwgIo6czsp83P/ykLflJBl7mvvBDlUTn1h7bMczftYNLdmzgZpgiAIDqsLnvLhQBv/73SBDaOVU21Z+enkSb1u/PAwWuj1IYuiBbFIo3PXu/mMQsNRWifX/n51PracWoO9Zqc4yM9DaU3zRAzBU3M2PYCd1foPFQ2dueFny1lqX3WmuCcyrTJNBmPwn6V5tbcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:28:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:28:26 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 13/14] net: enetc: add PTP synchronization support for ENETC v4
Date: Fri, 29 Aug 2025 13:06:14 +0800
Message-Id: <20250829050615.1247468-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 99235408-d27f-4da8-141f-08dde6bce107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpwTrJVR3jTOSyYDYUpMVZswgYGLyuCmCSPFZlfvMrAllU7hxJT65ll2Q+h9?=
 =?us-ascii?Q?mUJlhwOkO5ypmVgcMRsbnGzr8LRJLHT0xPhkKTscnyri55xFSs/d2Jr05iXT?=
 =?us-ascii?Q?KFNXbDcFf6T2H1TJ0b0wvHpKqetVZEEmoi6cWPysbP4PVF3r70tFa7zAu2s/?=
 =?us-ascii?Q?7PLaEMbeYhEJmzwTKrsg2n8rVane9lP6iQSwBJ/jkgdsrBujALg9khLaorUh?=
 =?us-ascii?Q?PcBTNfr6W3ukfjnnduyQt5Smy0QIRkoqDTa+yf6+kV94gxYspxNz7f+HvXuR?=
 =?us-ascii?Q?0vs+LDdU+Zw2fZAgqQjtpW1V5oKY6t7q5PbVeJHOA/idMl3414XEyNp/QdTn?=
 =?us-ascii?Q?mn9yiT7xN6gP0Hv8Q9eaO8soXfFIAc0N5b5vDTu8l7rVqNDdxF2hRHwzkhEL?=
 =?us-ascii?Q?42kiswYOejFdeiNmpiLJ+dlAbAah1qkIYU5KruxB4Ocd2q8sFizEgUR4DUTS?=
 =?us-ascii?Q?YGkPx914dX+w3inRgwReQsN/oeRenwRc+7wagw5MGnVpBNPkcjJaeDr5zA8G?=
 =?us-ascii?Q?MuSKfzB2hf+r6j4HqWkUg58HicKhPIApjQcdS6qyRAN78rsDJFcSDLU/nkpO?=
 =?us-ascii?Q?2f13jV0/Cegk8D2pU9ga3E8A8tZkWjbG66i3pQESKnSBWky/uOreZzoQ/yRI?=
 =?us-ascii?Q?kHWPJlFoHytGlIv1o07HMC72mP+uedDmOHkDCY6MO9mTTDhNwizOqWaHnHSo?=
 =?us-ascii?Q?4DahaXaaBnjml1UGz8EkGyTmJ24J6k+dsgBhMb5kqRbo+faCxy/2fKt0xR7W?=
 =?us-ascii?Q?CTYToijXPqnlpGAY+6QKQJ4zjelMz50Y+iUbrU/qkBnvjx2JMEsoaakL7scB?=
 =?us-ascii?Q?ocXIXCkvueahtU1sc6+H83rIMuQIaKZ03OEiDQfCMyV3fUe/FFLQ4/Wip83w?=
 =?us-ascii?Q?Ij/0p5iZepLn+k1Eap5hYSek+3pU3oemaDCX+uFnxeX2RXUbKZvQwIMJ8Wqp?=
 =?us-ascii?Q?xm2RkENGbbCjif7/uUzw4Y5bVoUhFl8i/9Q3NtzceX87BShMTVTg41Djgpel?=
 =?us-ascii?Q?vg6vOHsJKCUJoaIJnkJuV0qNq2juu2gbp37yU6dqTGbEGUShFdSUyL6NDALz?=
 =?us-ascii?Q?f0h2OX/lHNB9BuMkMKSnOvbxHIy7Dx0vj32TZg+VQj3j3cHsykCAPsZ0SmUb?=
 =?us-ascii?Q?VH5G6vnyszhwc1kzEEbbUI8YQYYmCKqfGV7sMYvStXcikiIhFnPqnNPTDaxV?=
 =?us-ascii?Q?dVdhyXi2KLEBewK/pIMpkS+DTqbhNJ9/6/Tl9SuvTgMeVV4ZWU2uHCMeJASz?=
 =?us-ascii?Q?vI9pZpLh8zcqilh7Hdq7x6ZlZNLpDkYKrdyABnmPMSSyAdhi5DQzzBIkaPc+?=
 =?us-ascii?Q?WkVTHxMQduIl9WBLYrPV+7YEkQ8axCjm1/qUNDEDo1gf6Qke8v6tWOKESVA9?=
 =?us-ascii?Q?nBqDV1HTKk9PaW+7r8RCOUQwYgAYvd2ForyGDywjmnxqm2GBD1Uoe3PFC9oO?=
 =?us-ascii?Q?d358oh/bQUhcfsZU0cd0Vqf6s+G78gAYpnh5FaZC8ecvbtU0EU5on263K7pY?=
 =?us-ascii?Q?1vWKU0AU+8tWLFk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okBxbhU3Hez0b+xGZA7CsTAdlXfgRFST50BYQneJ3CnCuTagMNDGkjNji9aQ?=
 =?us-ascii?Q?a0IsWwRzFVDmF2WtBM7gbW2GCCahtVOFakTDvK0rsAHo9fej7xKH7QVvxIyM?=
 =?us-ascii?Q?rUxMvbYHImcJrJcrkbY5icHd2TPgRpWM0ILz7Qr6DyfNClcbFeguJ+Cp6EsR?=
 =?us-ascii?Q?ETBoxJq47UeJ21w1BPoRt42FHOYTvLpEBffpuWiCmqeSvE7hCkyS9SQktYA7?=
 =?us-ascii?Q?SU11Xpz+0S+YKLeXBdEkf1RyIm1YayiUl65b5L+88X+ykL16DndD64ktL7he?=
 =?us-ascii?Q?F/Kny56eORtfUnEDoV6uPJ2Hrum+cQc7VMNMO/q+TOOF9W3wdzNcJz3Leu7j?=
 =?us-ascii?Q?uGPt7p7uAN9X0SzAHnWQWQclZRs4lja4qw/f/J7ZoyeNtapc07qXEvOImPqO?=
 =?us-ascii?Q?sjHGvZvhSSco0MK+nSNSuuU3Dw0HGZ2bjZn8sO+KBJkVjRqu8TSurupTobaa?=
 =?us-ascii?Q?BlxbNC6RJodEsDUE2lpjsJWcR1iQLkfxz+LncP3vkb7KBN+RpcWnh1zJocsG?=
 =?us-ascii?Q?is7c1KTNfLq4URQF/cDkkydeie7jNC+Z4aWTPhWOXw6Ad4XWzm87+7aSNYsF?=
 =?us-ascii?Q?4tl4aAptGrW/MWBG6cWsyiRTF8bEcA8grgxigCZgqbYne2FyKlO37IlmgIe5?=
 =?us-ascii?Q?uff3E8gbe+abRnfpins4lhcv9ccaSNbSLL4ob2EaZtI2GWlRSFa9yxnlChiW?=
 =?us-ascii?Q?TjhEoP7u//uR7zHZ++FPlE3Lj906FRNMdXP+CfLvdQEWkcv6k6deTKAEna8q?=
 =?us-ascii?Q?Y2Vzh3nIJpl/+AbJ9dgkpBo6/WU14yKPC8EZbww0LaTWjDQW/xaDbOE3l9BE?=
 =?us-ascii?Q?S/ew3zEO+1U3twEkMdL5EIlFEIT1Q9xtwb33eQridjlwahLm6/ey+S6MXehg?=
 =?us-ascii?Q?ptAe+Rsdja1D9R3bD7900rGRhQv3VMsrAfpu5EdU9fy/NFfDxlHaLAM4kBsz?=
 =?us-ascii?Q?q2+zx5MS32lx74sJ59Dgm98YsQpOTaURD7kwM/uqoQMm6MWA67/jolZfNQyx?=
 =?us-ascii?Q?XClmx+iWV6KvWanJfZDjOmIkKqkZ87aYrQRClfjQ+vcLAlvyKnZUjQkiNs7/?=
 =?us-ascii?Q?yx2sWUuDG6JBiq4PKTAWjrTpGv+GG7I92n7QVkEdHWjR/48Q2cHU0nFKejDp?=
 =?us-ascii?Q?ggpO3+Fm6JYOeigQXRxrlNEjpwfCbogSG4rqfqHF3ADUJb8WRRdHRFEU1l5S?=
 =?us-ascii?Q?+7tIzp9Xw35+OsptD3OHMaTcdL279eborasDaMmdYJwqFkahIShqhczRpquH?=
 =?us-ascii?Q?VTY/1icwBP+BAFUU0tEMWIo1ctZSV9B7HCUHLyHR6t5r1DQa61xGdCfO8nRh?=
 =?us-ascii?Q?ZUaPgsnwJNMeyCpIZtudkgEgKeJgnIcnSMLcsQOG2dqj0sPLdSF2YjXVILtw?=
 =?us-ascii?Q?pn8u6u0HjsCG+bhvxq+EHAFgOqI6fRZswFY1pH3pyo82J7zLhEnsbX9L9TIq?=
 =?us-ascii?Q?GZUVTm783BDUSZsXxlsdcD2YZ8LAgxPcGnw29AihS+Lx9P0/uF+zx9Z/c9FE?=
 =?us-ascii?Q?pQAUOGCVt4l8FFbhuar+ptp7x+u7KFv1XrT+uwqkZhMHFh6cW5NJz8GVzh9/?=
 =?us-ascii?Q?dlbIfbnNN8Cex271GT3uQHMw0mfiYxM5ohKcpQlD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99235408-d27f-4da8-141f-08dde6bce107
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:28:26.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPD+2YMAAI+LlZZU7rTlX25gAAkAmEm0E9oIGNl5YRfzn76SFphFSZFksvLaAl096JIFfoQGZCMJbAPFgzvUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
mainly as follows.

1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
different from LS1028A. Therefore, enetc_get_ts_info() has been modified
appropriately to be compatible with ENETC v1 and v4.

2. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
register offset, but also some register fields. Therefore, two helper
functions are added, enetc_set_one_step_ts() for ENETC v1 and
enetc4_set_one_step_ts() for ENETC v4.

3. Since the generic helper functions from ptp_clock are used to get
the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
symbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be
selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
NXP_ENETC4. Perhaps the best approach would be to change FSL_ENETC_CORE
to a visible menu entry. Then make FSL_ENETC, FSL_ENETC_VF, and
NXP_ENETC4 depend on it, but this is not the goal of this patch, so this
may be changed in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v6 changes:
Extract a separate patch "net: enetc: move sync packet modification
before dma_map_single()", so update the commit message.
v5 changes:
Fix the typo in commit message, 'sysbol' -> 'symbol'
v4 changes:
1. Remove enetc4_get_timer_pdev() and enetc4_get_default_timer_pdev(),
and add enetc4_get_phc_index_by_pdev() and enetc4_get_phc_index().
2. Add "PTP_1588_CLOCK_OPTIONAL" dependency, and add the description
of this modification to the commit message.
v3 changes:
1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
2. Change "nxp,netc-timer" to "ptp-timer"
v2 changes:
1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
errors.
2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
Timer.
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 40 ++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 91 ++++++++++++++++---
 6 files changed, 129 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 54b0f0a5a6bb..117038104b69 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -28,6 +28,7 @@ config NXP_NTMP
 
 config FSL_ENETC
 	tristate "ENETC PF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
@@ -45,6 +46,7 @@ config FSL_ENETC
 
 config NXP_ENETC4
 	tristate "ENETC4 PF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
@@ -62,6 +64,7 @@ config NXP_ENETC4
 
 config FSL_ENETC_VF
 	tristate "ENETC VF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 25379ac7d69d..6dbc9cc811a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = ENETC_PM0_SINGLE_STEP_EN;
+
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
+	if (udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	/* The "Correction" field of a packet is updated based on the
+	 * current time and the timestamp provided
+	 */
+	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
+}
+
+static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = PM_SINGLE_STEP_EN;
+
+	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
+	if (udp)
+		val |= PM_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
+}
+
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 				     struct sk_buff *skb)
 {
@@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	u32 lo, hi, nsec;
 	u8 *data;
 	u64 sec;
-	u32 val;
 
 	lo = enetc_rd_hot(hw, ENETC_SICTR0);
 	hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 	/* Configure single-step register */
-	val = ENETC_PM0_SINGLE_STEP_EN;
-	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-	if (enetc_cb->udp)
-		val |= ENETC_PM0_SINGLE_STEP_CH;
-
-	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+	if (is_enetc_rev1(si))
+		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
+	else
+		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
 
 	return lo & ENETC_TXBD_TSTAMP;
 }
@@ -3315,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
@@ -3365,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index c65aa7b88122..815afdc2ec23 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
 void enetc_reset_ptcmsdur(struct enetc_hw *hw);
 void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
 
+static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
+
+	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
+}
+
 #ifdef CONFIG_FSL_ENETC_QOS
 int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
 int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index aa25b445d301..19bf0e89cdc2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -171,6 +171,12 @@
 /* Port MAC 0/1 Pause Quanta Threshold Register */
 #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
 
+#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define  PM_SINGLE_STEP_OFFSET_SET(o)	FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 38fb81db48c2..2e07b9b746e1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_eth_ioctl		= enetc_ioctl,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 961e76cd8489..6215e9c68fc5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -4,6 +4,9 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/ptp_clock_kernel.h>
+
 #include "enetc.h"
 
 static const u32 enetc_si_regs[] = {
@@ -877,23 +880,54 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc_get_ts_info(struct net_device *ndev,
-			     struct kernel_ethtool_ts_info *info)
+static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 {
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	int *phc_idx;
-
-	phc_idx = symbol_get(enetc_phc_index);
-	if (phc_idx) {
-		info->phc_index = *phc_idx;
-		symbol_put(enetc_phc_index);
+	struct pci_bus *bus = si->pdev->bus;
+	struct pci_dev *timer_pdev;
+	unsigned int devfn;
+	int phc_index;
+
+	switch (si->revision) {
+	case ENETC_REV_4_1:
+		devfn = PCI_DEVFN(24, 0);
+		break;
+	default:
+		return -1;
 	}
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+	timer_pdev = pci_get_slot(bus, devfn);
+	if (!timer_pdev)
+		return -1;
 
-		return 0;
-	}
+	phc_index = ptp_clock_index_by_dev(&timer_pdev->dev);
+	pci_dev_put(timer_pdev);
+
+	return phc_index;
+}
+
+static int enetc4_get_phc_index(struct enetc_si *si)
+{
+	struct device_node *np = si->pdev->dev.of_node;
+	struct device_node *timer_np;
+	int phc_index;
+
+	if (!np)
+		return enetc4_get_phc_index_by_pdev(si);
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np)
+		return enetc4_get_phc_index_by_pdev(si);
+
+	phc_index = ptp_clock_index_by_of_node(timer_np);
+	of_node_put(timer_np);
+
+	return phc_index;
+}
+
+static void enetc_get_ts_generic_info(struct net_device *ndev,
+				      struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
@@ -908,6 +942,36 @@ static int enetc_get_ts_info(struct net_device *ndev,
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
+}
+
+static int enetc_get_ts_info(struct net_device *ndev,
+			     struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	int *phc_idx;
+
+	if (!enetc_ptp_clock_is_enabled(si))
+		goto timestamp_tx_sw;
+
+	if (is_enetc_rev1(si)) {
+		phc_idx = symbol_get(enetc_phc_index);
+		if (phc_idx) {
+			info->phc_index = *phc_idx;
+			symbol_put(enetc_phc_index);
+		}
+	} else {
+		info->phc_index = enetc4_get_phc_index(si);
+		if (info->phc_index < 0)
+			goto timestamp_tx_sw;
+	}
+
+	enetc_get_ts_generic_info(ndev, info);
+
+	return 0;
+
+timestamp_tx_sw:
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
@@ -1296,6 +1360,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
 	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ts_info = enetc_get_ts_info,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
-- 
2.34.1


