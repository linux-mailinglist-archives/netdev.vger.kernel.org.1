Return-Path: <netdev+bounces-212851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E8B22426
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0118507E91
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243E2ECD15;
	Tue, 12 Aug 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mGHCVhxU"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4942EBB84;
	Tue, 12 Aug 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993274; cv=fail; b=DIHVef9VAidIQffVD6j71DiSsU7OkjNM/meiW0O3VQMdHrd0GdEXN5gPiJoOONswDMLZw0hwdCJ9JOsFfXyhe9FUfzlNgiRMmvHxc9dpRWTY+Ecuh0lMgJaB3aJ7f9AI6dYXOT0xhWsnZ1FSRPu0iKoB3vvNnWfOyjBW1Ehml7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993274; c=relaxed/simple;
	bh=5qdUrphgNivbENu0s4msuOUPa7RkyEFeluZgdlv3hgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ih1RUI3ugbHjejaTWkD96vuwZgnLXOJNqFazNqXwVBCO5QIgVMF0JMq7D21Vt9/2969TxbNMmcGVAtNUFCCqzYPGjZxMddtAn3Jj+qwQXOEcYQsnZ9UExXtkJ4I2mWtnCur/jx9Z3aTh7v7YZlYvPFK5/jkLR7+CbqKIBrlzWeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mGHCVhxU; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WK+8zmf2rMaBuFiEjr5W5PS9sog0LEjxGCWY0GRJbAmv/y7ns91FXpqEhMG2p4CuhHMEpDaDbRFsF52pZ8F5qnGwZlDcBVn2dwi2UQ6MxTVnTBZIZsTOG3s0JtTWFta6yFfb62SISB5R7zT1eQ3Z/FsrEnoRcIHpe1Wzt5EU3ajaSl2lAJRMaQXBPo7mmfX3pTNbtmPy/diraYyCQKvZr0uc+dBGwz/Plr4BSHwVupcmYLoBJU6gEGPYxyVR75zxax54j6bBxPyvlblF1iNH7hYHs1EvAURg8i1dKdKtZMdinSwxxEK7eTC2ETbIcoKYl5ETnAVUgbvDQP87T3Y7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MIcMDxwaduA8ihzjvsopCoa7vumkUY7JEeQ8nnD6Hg=;
 b=Nw4IxVUrIjOrDbG30kNgeF86D/gZEnJN/HXG7lVyMU3Z3593F1yfIBXnvsBKlRSJ3eVlnfv5P1sl6gleKz8sgmXyimLgIS3osOwsExLNGamiX7EJUgNypaewj+GRzb0NW/Y5JYtfeYTWUNLGNNa7QD14ZedaxqR1x+F0HLP7tgxEwR/sSI4QYdnr5wd/fJ3CDAsPdTVIyoxnC4kInxi/mxyuu9u5kfhhFkxl8uEhgPe9zZa1s79VjdnR/rnin/cYfcQRMkViKfWuiSxC0abQpytqjkfIvMD9ZMjJSlmZKbsxCY2fehJoApUusz2rIwNaW2X3vXLT+vYx5uSdcQr+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MIcMDxwaduA8ihzjvsopCoa7vumkUY7JEeQ8nnD6Hg=;
 b=mGHCVhxU0zxMWDaUfRriFMTfTIpPSrhIJzpY22XlE7PUYLNG2eDbpWWaJJKGoTlTwBNMp/kLbhiTtn7KdnI/mxPMb8iJOmT7e9a75eS+DKII4cXiSGI9nRsAUERoJhNgqj+qJo7VFKkdWJ9UIkol+IZFUkSStlbNkmdPnAb5WZ1XsjIpFuXfdk4Bzl0OaJyGfE2/QmApiSXtX+zykHKocyUSaJ5hQ7UZZY7Q8Ix7/W0ydys+MmY7rnZbVg0XvlpN83S6+Fdtt40B5Im7mfdvkFirAb+v7x+LMVeR3Fs4w2OYdPg42+kQKJNOKj1oBqySP7OXNag/zUPaRjYcWDKQsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:48 +0000
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
Subject: [PATCH v3 net-next 07/15] ptp: netc: add external trigger stamp support
Date: Tue, 12 Aug 2025 17:46:26 +0800
Message-Id: <20250812094634.489901-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 484cce92-fd31-4a85-ef45-08ddd9881744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oLZ/OBGxdmdYuwfJu1QYNnw2hG3czK17fCmbMPGS3xS1c3skWuB0FKA6dZKd?=
 =?us-ascii?Q?CEyOrtlQhdsEa/772TVrEbzuu1KAI0ix3X7K7lVIJJERnf8apegfmrgAc86w?=
 =?us-ascii?Q?wQ60jjnrujsW39Iqfu249sbgLIGV+2h+0y5KslnFR2MyItj4nIF6kX+FqbZf?=
 =?us-ascii?Q?YdgQu5c7UAZIPi+apFN1tXIHwZ3lgGgshUsWk+UfTcSSXDWTENIcUZS/k5N1?=
 =?us-ascii?Q?+SRsPRn1QmFqwSIBxtyrgh6HOZCL/P07Co1AsAicoMt2g0/88Dmqir8+lxG/?=
 =?us-ascii?Q?iPLKT/6jJoKjZCqlRjJefUV722FDLUFJ0KB2VzoyOJJNOlrBSLvucIYS1gQL?=
 =?us-ascii?Q?FBUmbdyltf3dhS9d3Y8nlGCr9TLs6dYpjp0ohDTxxtMpcIlfGRsmiw+ZWjJi?=
 =?us-ascii?Q?U1jmTKyz+o/lvEv/mArMf2oPrAOIBTPwrkGBEGuhjMUYu1NeEZZVa/yDc4cR?=
 =?us-ascii?Q?cygVOZC5kN8JNDiheh7lMzJi45w+89FN5WWlYZ1MMiN3hvRL0YrXUuZGOCN8?=
 =?us-ascii?Q?5YKQSzbscrBZJuGLpFJ3f0f/xjjeqTcxtdHHFgvcXKZ+/J64TDg9WgIWCVme?=
 =?us-ascii?Q?gI4mQtkOWDH/sAJgQP0xT3BNPB1/To0fZHxR9KJg+2z2EH/vyqOD6+l6020u?=
 =?us-ascii?Q?DR3EX3HzV6eYUWvMcCL63Hq3epdjGF2txTnLfZ3wASo7thLznE0oF7mcOeZV?=
 =?us-ascii?Q?sDYTZjJv+7s2Gdjr8yFmbKQjDHykx20Vi6+9DYI7Yzu9CWU5efsT8akesGfS?=
 =?us-ascii?Q?NM1rReBJiYzybfEc+FWXSA9kkVT5PvoFE97QAKC9dbVyyIk0eYz0PIRB/MCR?=
 =?us-ascii?Q?M05vK6rnHyOsaWA1HEbw+6gGmQIW1Ozul21Qv3sEPmg+fSfFFqJuey2krsk+?=
 =?us-ascii?Q?GVpFQNsBUKcN2Y+gLMaindhi++0o441sKEHHM9KaGv1+cdSsYaHrHR7ZvrV3?=
 =?us-ascii?Q?qX0ZdEzaQWcMgeIRUI9VXOzNMOqVh95MaCJwnJJQ9eJ3m4LUOfHiYHxDb30i?=
 =?us-ascii?Q?DL8rpJlxYJTZ9wYxM+QkAKqC2tanlLBCo3Ru4h4faKuYvmc8w3nHQ1UFqOoY?=
 =?us-ascii?Q?wLdJW7C7TPiNm6I8v98KwLW1z6ICAjKPolc6HwqqO5foKZTQjD5cKS4AXlxZ?=
 =?us-ascii?Q?vdWSc229inZdqUTLmHKXUhqZEz1xaJOp0rDY4iL2HtSJ1Q5K0KFvANVgm7wV?=
 =?us-ascii?Q?Q30jdWT4/cMR7Y9iYmdBai3YB9tpVUNiJKGVQz+bv89BHLmbH7f8Qc/gQnrG?=
 =?us-ascii?Q?NFqQiAiZF53dWvfG+iPQhszeZApXnUQ50+91R53eMSiINe2wkNkFwA2eDOQU?=
 =?us-ascii?Q?k1jBUtrEbgVUgvC2zo++zWhwKCXOxYCioxXvl6vSbOzImu1Vb1s1hmiLV8X5?=
 =?us-ascii?Q?XJsnf8rStynG0BvdTobCjVgmW2puTrDWkqubwb218nDbuYP4wp47fMfNEXqI?=
 =?us-ascii?Q?Xlerymx7YFq5fC5tMFwZbaShDwNkcaDwz9L/jQ3FcgNW/cfZEg4m3YrwT7be?=
 =?us-ascii?Q?zF61OT9DT7GfbSk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?om/b9SBtM7d0WNekInJIuQkGudZNQL1x4ji9s8deTENtumK1uaojTksc6nWk?=
 =?us-ascii?Q?N+zI1XVv7WaoqaCSHNQqMKbSqaYCQfqB8d7PBQWTukTYvhrbJI5Qfp4+RmKM?=
 =?us-ascii?Q?qUHtgfkxsKPKf4AFSWbo9IXktoY5/wTRCwbgtbrQ2mtsIrZQLRxcjDJqMpGZ?=
 =?us-ascii?Q?5cgdP41WRa+HjFa+jsB9tnbq/jmcTjilAkxIr7chi0HprL54smVuBV+No1GT?=
 =?us-ascii?Q?ICXnIkH/2XRfcHUSSVRbRARyWpWVa3LSjXpN2cOHgbn/hE9HWRf1uiRbIfIM?=
 =?us-ascii?Q?ht/X3s20e+reyoX9b6m/H0BZdhcGkwpWvMGfRy0oweHrLqAVFsWvwBMQyxi0?=
 =?us-ascii?Q?lMCRV4gTuE1Cuwa13IkvK6vTvJyCeGtmgf48ATB/7fThyXnzMik9zQZeTd5L?=
 =?us-ascii?Q?UxN7PyBpGge7ilmv0YHR5o/btfCnRFxNIIv7kQ321Lxribsh8USyLia3UQ7R?=
 =?us-ascii?Q?E13jz2Fh2aMVgglYHcq+BpA7s40xKMd497ezeW5YgtVtDs+9iUtZ4JXPQCKr?=
 =?us-ascii?Q?VMauowYxhE8duQxjhKtB2XAiwE6Pa41jYEqP5yrEAfvOCMdMBvk63rWGVsAn?=
 =?us-ascii?Q?BSkRijunEGM3ygGm0CmFwscrmrS5L0HQuAJKMimNz79R7B7CHJcNZhdbKTeG?=
 =?us-ascii?Q?tZFr5O1BwHPXjtEbubnbXOMy/E8MM9yjJrzM8P+kRKvrLZVnbNIix7wd8qZS?=
 =?us-ascii?Q?w8QZ0j0XuUQ6SNqmgM8B4hU1cUhhiu2gO2FgNP1gD2S0suBDA95Ey7lHFn0A?=
 =?us-ascii?Q?ktthKZSUC5qbz8e+wfQvXfkYf+2tbDfmHNhlABkuQ6ynSvogTR6lqip2TLmb?=
 =?us-ascii?Q?o5VCw3zB71VLqqNlVQqRbHR4TqdT3ZJafB8Juh887xDC8q/WqqLZfG1ShZLe?=
 =?us-ascii?Q?b3dHaxzLpGT65me/Begj5ISsTK1v02kn/NYxMfz4dLMFqZ6/iGhMvzplJkUK?=
 =?us-ascii?Q?O1J7x0aDmIFoGM2KTo6IjHcjo7ANsSwLhGio/DeQHbuPPBUkoV9zYL3ppeah?=
 =?us-ascii?Q?1e/UbTKsgwxWAgTW5GpyP4rcwqmmLsMyJZ5kbjlMOZwqzvZiot8wAxgCOE17?=
 =?us-ascii?Q?Okwip1BPwpqDKnieVU+MZ6R7f/OdZuJSe1eDr9XKryiHwOV62urP9RVC83no?=
 =?us-ascii?Q?7VJjNNip7CxzN6qSo07ANUZ2z58T1jx032uzds4urW6NqTdc/GyD1Y2D9hp9?=
 =?us-ascii?Q?GwDXNV1ynVIWuY37pSbkQNE4AQS+LXDLtSCWJLlJoKDCsY841sGsz9i1gKKh?=
 =?us-ascii?Q?r+BjAir14CX/FxqVGPWFLzhcz34UugJ3aEvKHm9gYB75NOheLeZkv2EHlvm/?=
 =?us-ascii?Q?V/C6ybyuF0Iq4vpjlrrUd17cHN07XTG1hWBxdsks0+YFHzMeWk7AykFEcUlA?=
 =?us-ascii?Q?jPnRRDV9UQ6xPSlCSgN/teGg8Y/yMxLwITOG6QZJFQWucxVxHqFVVyiuAAJs?=
 =?us-ascii?Q?1WeAWuCOKyGNCjr3+PjUdV2aoANInqkOsXbYH+Eyvims6Uq74rBlrWmZwNcU?=
 =?us-ascii?Q?Qnzvp0wd3tg7J6WAQlJJdbE0zoeE1NIm0u3spEU+nFj393xUx8lo9NWxT+Pj?=
 =?us-ascii?Q?9vrEFBCi6PYDI/t4FkSbqfQJuhtjDFInxTN74G+8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484cce92-fd31-4a85-ef45-08ddd9881744
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:48.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RM3iKc1p3/6kz2qHvR7HYeU5guisnYGkxOkiV5Zg9wocLU7GtFde7oDuKvZJ/949EidwDrp/sTxOStxI25pX9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

From: "F.S. Peng" <fushi.peng@nxp.com>

The NETC Timer is capable of recording the timestamp on receipt of an
external pulse on a GPIO pin. It supports two such external triggers.
The recorded value is saved in a 16 entry FIFO accessed by
TMR_ETTSa_H/L. An interrupt can be generated when the trigger occurs,
when the FIFO reaches a threshold, and if the FIFO overflows.

Signed-off-by: F.S. Peng <fushi.peng@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v3 changes:
1. Rebase this patch and use priv->tmr_emask instead of reading
   TMR_EMASK register
2. Rename related macros
3. Remove the switch statement from netc_timer_enable_extts() and
   netc_timer_handle_etts_event()
---
 drivers/ptp/ptp_netc.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index aa88767f8355..45d60ad46b68 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -18,6 +18,7 @@
 #define NETC_TMR_CTRL			0x0080
 #define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
 #define  TMR_CTRL_TE			BIT(2)
+#define  TMR_ETEP(i)			BIT(8 + (i))
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
 #define  TMR_CTRL_FS			BIT(28)
@@ -26,12 +27,22 @@
 #define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
 #define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
 #define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+#define  TMR_TEVENT_ETS_THREN(i)	BIT(20 + (i))
+#define  TMR_TEVENT_ETSEN(i)		BIT(24 + (i))
+#define  TMR_TEVENT_ETS_OVEN(i)		BIT(28 + (i))
+#define  TMR_TEVENT_ETS(i)		(TMR_TEVENT_ETS_THREN(i) | \
+					 TMR_TEVENT_ETSEN(i) | \
+					 TMR_TEVENT_ETS_OVEN(i))
 
 #define NETC_TMR_TEMASK			0x0088
+#define NETC_TMR_STAT			0x0094
+#define  TMR_STAT_ETS_VLD(i)		BIT(24 + (i))
+
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
 #define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_ECTRL			0x00ac
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
@@ -49,6 +60,9 @@
 #define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
 #define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
+/* i = 0, 1, i indicates the index of TMR_ETTS */
+#define NETC_TMR_ETTS_L(i)		(0x00e0 + (i) * 8)
+#define NETC_TMR_ETTS_H(i)		(0x00e4 + (i) * 8)
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
@@ -65,6 +79,7 @@
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 #define NETC_TMR_ALARM_NUM		2
+#define NETC_TMR_DEFAULT_ETTF_THR	7
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -475,6 +490,64 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 	return err;
 }
 
+static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
+					 bool update_event)
+{
+	struct ptp_clock_event event;
+	u32 etts_l = 0, etts_h = 0;
+
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
+		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
+		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
+	}
+
+	/* Invalid time stamp */
+	if (!etts_l && !etts_h)
+		return;
+
+	if (update_event) {
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = index;
+		event.timestamp = (u64)etts_h << 32;
+		event.timestamp |= etts_l;
+		ptp_clock_event(priv->clock, &event);
+	}
+}
+
+static int netc_timer_enable_extts(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	int index = rq->extts.index;
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	/* Reject requests to enable time stamping on both edges */
+	if ((rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_handle_etts_event(priv, rq->extts.index, false);
+	if (on) {
+		tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+		if (rq->extts.flags & PTP_FALLING_EDGE)
+			tmr_ctrl |= TMR_ETEP(index);
+		else
+			tmr_ctrl &= ~TMR_ETEP(index);
+
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		priv->tmr_emask |= TMR_TEVENT_ETS(index);
+	} else {
+		priv->tmr_emask &= ~TMR_TEVENT_ETS(index);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
 	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
@@ -528,6 +601,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 		return netc_timer_enable_pps(priv, rq, on);
 	case PTP_CLK_REQ_PEROUT:
 		return net_timer_enable_perout(priv, rq, on);
+	case PTP_CLK_REQ_EXTTS:
+		return netc_timer_enable_extts(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -655,6 +730,9 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_alarm	= 2,
 	.pps		= 1,
 	.n_per_out	= 3,
+	.n_ext_ts	= 2,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
+				 PTP_STRICT_FLAGS,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -687,6 +765,7 @@ static void netc_timer_init(struct netc_timer *priv)
 		fiper_ctrl &= ~FIPER_CTRL_PG(i);
 	}
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
 
 	ktime_get_real_ts64(&now);
 	ns = timespec64_to_ns(&now);
@@ -820,6 +899,12 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 		ptp_clock_event(priv->clock, &event);
 	}
 
+	if (tmr_event & TMR_TEVENT_ETS(0))
+		netc_timer_handle_etts_event(priv, 0, true);
+
+	if (tmr_event & TMR_TEVENT_ETS(1))
+		netc_timer_handle_etts_event(priv, 1, true);
+
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
-- 
2.34.1


