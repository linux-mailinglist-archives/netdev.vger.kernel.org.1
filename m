Return-Path: <netdev+bounces-216365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90954B33534
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11AD3AD60A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD02327FB28;
	Mon, 25 Aug 2025 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fp7SJWBA"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1827781E;
	Mon, 25 Aug 2025 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096614; cv=fail; b=bIk618XLFwkHLg37ok7A2XwiM+e+E4GiD6uEsXpWQE2aAPpXMm0uWHhVCFqvnQ7PuLWBHNF3sK+yF7rsCAzkUPHchsiKDbzAqQ/T/wXmrihmkEPRg8t8di1TNO4yVZBbaWCRCT7tVqF+841auvbl4SWUq5hipbZrlLPa4ds0sBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096614; c=relaxed/simple;
	bh=z0+3W4qlHGBjVcnpgxGyiIVH6yaFZRYziEKh2AC3YFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qn7uZOSJuCRQ73AvsxIIQOMCYpDAYmtSiQgsEekjPCdJpOR1SboLCmCQ6m4SwJ4yCCULWezmcG2l0MBUUPSu98V05pEdM7LFYXDsIILVU9eBID4k345xwbGkp/NdP9EL4wJKZNG9Vl2Glf2qaJnwL+zMLENiMGyAhLecLUOXs4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fp7SJWBA; arc=fail smtp.client-ip=52.101.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPuKSvu/GXuneiVcG7T+L2DUuhVlepG/e9tZSbE4TNN88xSnPr7jd3lI1FwRHWlVo6AVC/sTQo1PRPS765ADBpRGkPzqAA0HhU3rdJqeZxnNTMPGYPUOFqhIkPXONojJXdH9R43me7lXWxWKntpE9yL6VFEcLMfkNFRW2wEDIl8DAA2sib3DUJsEhlgFBJlqzILxOyUlo2KeP7WWW8Iuxc/E89YNaN5uICPwB4G0prK8HeuvLenLOfYBPQpRFN0z9v12DxDwPRMRooHFZzHbhNAtNYKl7JxNUE8BmXVIYy96SE7t4g6uHguyyDPgJUKr+vRy+6DfYrMLePyy8dBUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i8y6boPM/pGBqRM6IetrKiO8r+KStM9AfjX6W/qJn0=;
 b=UFutZcIF4v90+2/pxe9dqM1fc1zWSTl4s7x5qdYaMi0suRu03dhwM6ThG+OJt8kjOlTVIq9kAeRCNW7awOZmSLq21C99TC+44vmZrbAgr97iXJ5qztr1tvmcWshxW4PUb+oRfxqQvJhyjhipqP30aq77hp2rG6WBU3xjXbHqFEqVqGXI3giLe25BFxP6KdQsEfo7hGr3aaK6jycuH7ZoFEx1LXybNwJGeatr00HE0hUxqGAbL7hM4Rym1ZlxzNhBRunkDlqY5HrMhqtXFYPGiUQxw8WGOHONRc2UdPgehHjMGmu8UymmqCZqgdMxktXMTZUI8Ul1J/vLMFFhY2LPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i8y6boPM/pGBqRM6IetrKiO8r+KStM9AfjX6W/qJn0=;
 b=fp7SJWBAKOHmiMYxqLsvAeWZ3ZaA+E9pNjhRgfHRAGk63RdUCfbkHAc0T4qo84U7Bt36CGD0cQNEU/12cE0RRgnFRHT8R4USZIQMHYAZ9FY3Hoau9IRV7BAumh1E7DVz7Q2S07Qihb1fpoCF+of9wG4lz3msC70otb0WsbvnrkRzXYbr4rOkgXa0ryjBs4bVvA4xPS11Mu2N0veLqAB1xiK99jACPGj4PQdp0LTkhiP8P7Nj4ow+7RKH8tc7cWv72UgUGGq/hQIgZ1hiyTbwEaFN1JVGtGh+a9Uf04pewrcq0wOZkyM5IIFiAeQ3enuZOE6LZz5X0HJcyQqAa17g3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:36:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:36:49 +0000
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
Subject: [PATCH v5 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver support
Date: Mon, 25 Aug 2025 12:15:21 +0800
Message-Id: <20250825041532.1067315-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a1cc7f-cec6-48ee-abae-08dde3910185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOXXw6O0nIbibrevGsxti8OlVHBMOn96OUfL0BNkhg/E1MK4nEVv7DzG43DE?=
 =?us-ascii?Q?Z7YEDfcUDH1xbaHCS37sUKgR57l1U7uplf+uBxWHfJJx8juUKu2XvesGiJaw?=
 =?us-ascii?Q?NX7utdKDYW7ChvtPbJt8FT6z2PxS0vTvywaATpbx9PzfRCeZbCO4rFa30jOW?=
 =?us-ascii?Q?79eO1/ckIlUWcezntm+7ThSg4zUQ3Y/tNxwv3a3ZYES9WH5mCcOsWPhhJDvn?=
 =?us-ascii?Q?z7YaQ9F6JiffYd0F589VJH1oHCvL9/wR2Juo4LJk9Ev7ne9snsK3d/y+ZEaF?=
 =?us-ascii?Q?Pv0EdpmLV4A/dirnAlSlEWW2UL7noxVxQm+D2XHsUHuCcI/SDw0bBobGQ4wn?=
 =?us-ascii?Q?p4aaldc14nSU04RH0ay09xasXGHOfeu1W1klVMwFYrYmzhNHc6q695mPXe9C?=
 =?us-ascii?Q?TAqOdB8Fe5TzvNsCEBwgRZWESmvO6JOM+v/tzxIAuWiMAbBPwyEt7Ul5PFpG?=
 =?us-ascii?Q?o359I2FoSlR25sMeRPTFohTmJ2U0FZSUKU/+I5egqifh8sIxGdy8CDLM3UUE?=
 =?us-ascii?Q?Z5YIfBQA39uuGm/TkrSapA91qOmUjr6d89JaIZPDLDnP4OeEebPTITak69WB?=
 =?us-ascii?Q?BeKX/gXSZMxCkreBogXMD03zVIa/iZK5/oa3Zuhgt7lfsQf4PJLJhNcdp4kJ?=
 =?us-ascii?Q?BkEV5q+wQbBUWWHyFOX/Ta6XKmSFgYfFPv8q3Ddr/pJnrvXD05Q/4n/HAbXB?=
 =?us-ascii?Q?6oxsG0oOxYgq/hBXmr7xDdcxAXdB1kCrE/F+Xdb5ltjuUikCoacqPiAvE3bH?=
 =?us-ascii?Q?4ZlofuyhUFJ2hbaKGFIcbXn3+GzKU7bgEztIEo04LDn1rG2oJVnmQ0cxh6c1?=
 =?us-ascii?Q?P7raHxeI+O2h0W70zVdetkLm15/Ei+m8Ovw5nOnE2fDHYav0Qj2Yb3Z+93IX?=
 =?us-ascii?Q?+7wvuILrTeJh5nfR3xHMgSns57Ndv9qnNZurKNCr5QLMC6DvFKoQMYuoDWE+?=
 =?us-ascii?Q?KqgHAPDSxIOmW80lzc6izvyG1RW+KdzxUnBM4hBDoCGUbbthtLwaFFf1vXVa?=
 =?us-ascii?Q?xNhlGBUR+vQ82vacYjTtsopGMeOee2UEH78C+siKhCvWXH93lZCeFDa4QBO2?=
 =?us-ascii?Q?z6FKJFO0p4DdSHZgidFQxlaZZUM9D6aUDYNzSTxapnmgb3t0GJxdo9eLR/z3?=
 =?us-ascii?Q?a6oPhGT1263wWzsylGY3duaycZ6JMCJPgGHkab928TQryJDvRgD7DPfch7z/?=
 =?us-ascii?Q?ynq+H0icx7NzYfooAQaDfPLG6ZcGaGip7jxVfSbXSMCOPUfjKO/YgDay+ZgH?=
 =?us-ascii?Q?ZBAtPNRMokuF0RKG+NO+G5SrAQZKTLViqb1h3dseY1SG+IvgsLSszJnLGzHc?=
 =?us-ascii?Q?6PSNHM+HRfjpdDu2iQzPrChN/XLD6CSeA1ghqEGnqM+gh147NUgsrhGkBAv3?=
 =?us-ascii?Q?esQA+WsN+RXrApKC3o8dndFypjeKXWMBToeLl26euPEOBwlSZIhf/kXU1U/C?=
 =?us-ascii?Q?Xn7ZZPZrvvjhZy3f/d4bIAR3sz2cZa1ebdhTGg1PChjeDjOapq/4/p0cFSw1?=
 =?us-ascii?Q?c8xn7XgQxnxNhkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5QsRQTTorlbU64vP0czN8PlhX4nr3Dp+QLN/ElUZZ+lphP3h75WgAitZZkZ?=
 =?us-ascii?Q?nd5y0d9BBFqlLo7qCWxL7LC/Zap4WcMLkeE3fPEQtaDNK6Ifzdf0pzu6xCsA?=
 =?us-ascii?Q?0tSfr9bN3ql0rtTzUSmoRyur8QIZhCJNHP2dBXVLa5TCVLxrctCOm7Ifbe7i?=
 =?us-ascii?Q?FShdVFTWS5n7Lya6dfwdoCqCTOm3tXLHfeC/iDfeAqMpbecCIygUcl+D3B04?=
 =?us-ascii?Q?qah75tfFBiRkU9yPebKjC4f9FVGGM+OTuRE1gup7y3a8qguQ/sXJn9KgGngS?=
 =?us-ascii?Q?pdJN2DFqQUNLcDcZLNDy/dParAOpFCfAT49flNicPs17QnD+f9MQECuX5OR6?=
 =?us-ascii?Q?DrzA6L4BDcB7pM5XlVwUlY+JPKJaj48lui2zNPulDRWoh778zTy73AkHpw1r?=
 =?us-ascii?Q?YvxlZtXT10CUu90N/+MvzY9zD8GJOdX5ou2GjKVOAvqM1v3Jn+vVV3jmhXe5?=
 =?us-ascii?Q?X83zUR1yQ14qOouKG3zc2dkPblBEm+cHArmRI2GKGbYTc1VcGW/ajUC2aHBn?=
 =?us-ascii?Q?+UZrB1IC1hJTfzOCt/MagE9+uSPGPGxlj2WWKfasdKGu8JXeYLQj+Xmqb48N?=
 =?us-ascii?Q?erEOYKw0MAMVyN+PO+n/7My+ZwF9D84V2TJ60uLVfWe7pNLfTYYaxoUroZWt?=
 =?us-ascii?Q?6Ee3TKdu2ukGHqH0sosJ12743B7ZKYYdyGjuvptJ1JItPGlfSKj4/qsdlQ/q?=
 =?us-ascii?Q?IMso8/fdT7QcW8cQ3S2vR89Kyjx9n8t3MNCmtJyElISuinWwkI8RGkxcVQiE?=
 =?us-ascii?Q?h32iTaxO+BG7dHq4rHiDfqwTVsAMZ7Zq7hsgIn1BtsGY2V9wakwU72Ion8St?=
 =?us-ascii?Q?stkUClmTQQdU9DrRTqrp+eyGnfh7KrAg0Qf8gdeN46dO/8CuUnLvOgx4RTWw?=
 =?us-ascii?Q?yxnXpCYKMvkz4dcFKqmhMYX4H+8BOrX9JFdB0iI89LRYFp9spVFrQABHdao1?=
 =?us-ascii?Q?XLXFiI67fmCr1AgP3I+eECz78+tss4fGweqiQ6QUN5iXyk8x0QFK1cosoDc4?=
 =?us-ascii?Q?hlHD+87lS+BRnJd5V9WJOH3m2uzT2VaO6lK2hdd5x+zeTO7WrEy9/JXGubWq?=
 =?us-ascii?Q?RhjJ2aFjn6oauLVUqqKWGFsaDQArdmylhEKBPxphHmIbPQkzmMv5AeRhVkhr?=
 =?us-ascii?Q?lgZ1YCZiqWBdxZW3CAlfPnypGc2N4tQ6L+pURV2RSp65vFyze+rPoDEOACSX?=
 =?us-ascii?Q?1FllS+6ioXyCw1pEUMLQqIACQaT2hyTfV/KpADBHrUJwayLgbwKHZdgsZYZ9?=
 =?us-ascii?Q?W7TkaEesLHw6lieP22vBXCOPW9IvIz5uPdeaHzhgn44byNaKtY3+nX9DEqqY?=
 =?us-ascii?Q?3+QxUuwZ0T1slRpYjT9cvOlvHMNROgjkbILDeN7AkXjdQepBRAQJRvmfmZfp?=
 =?us-ascii?Q?QXAMpliLHREHtja0KN5BnJEMeMTChJ9kMlKB8TjQOMdfjHjBeH7W7njGCMN1?=
 =?us-ascii?Q?Hsl/N7sQvL5cYpfE2X1SdY+qTgpQfhjiefrWiNop2iSBg7zr4z5l7ngv3lyD?=
 =?us-ascii?Q?MhwoXBizdwp+d1ckhIIZpENGWDEU26KAo6Khyz3qjS6irfDoFeWCL4z1Bxrv?=
 =?us-ascii?Q?arf/w9O7uMDi3p/b9EH3sgLw47kgrfvdBUdOCYva?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a1cc7f-cec6-48ee-abae-08dde3910185
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:36:49.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1ZtQOSoeExbolLYEozl7aPzEKwA5RIvVqVfZHZo24m9Ee1Wxs3p8TuUriL6+b6ymb5/BOi6YZk8qTAwEPwOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

NETC V4 Timer provides current time with nanosecond resolution, precise
periodic pulse, pulse on timeout (alarm), and time capture on external
pulse support. And it supports time synchronization as required for
IEEE 1588 and IEEE 802.1AS-2020.

Inside NETC, ENETC can capture the timestamp of the sent/received packet
through the PHC provided by the Timer and record it on the Tx/Rx BD. And
through the relevant PHC interfaces provided by the driver, the enetc V4
driver can support PTP time synchronization.

In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
not exactly the same. The current ptp-qoriq driver is not compatible with
NETC V4 Timer, most of the code cannot be reused, see below reasons.

1. The architecture of ptp-qoriq driver makes the register offset fixed,
however, the offsets of all the high registers and low registers of V4
are swapped, and V4 also adds some new registers. so extending ptp-qoriq
to make it compatible with V4 Timer is tantamount to completely rewriting
ptp-qoriq driver.

2. The usage of some functions is somewhat different from QorIQ timer,
such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
increase the complexity of the code and reduce readability.

3. QorIQ is an expired brand. It is difficult for us to verify whether
it works stably on the QorIQ platforms if we refactor the driver, and
this will make maintenance difficult, so refactoring the driver obviously
does not bring any benefits.

Therefore, add this new driver for NETC V4 Timer. Note that the missing
features like PEROUT, PPS and EXTTS will be added in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v5 changes:
1. Remove the changes of netc_global.h and add "linux/pci.h" to
   ptp_netc.c
2. Modify the clock names in timer_clk_src due to we have renamed them
   in the binding doc
3. Add a description of the same behavior for other H/L registers in the
   comment of netc_timer_cnt_write().
v4 changes:
1. Remove NETC_TMR_PCI_DEVID
2. Fix build warning: "NSEC_PER_SEC << 32" --> "(u64)NSEC_PER_SEC << 32"
3. Remove netc_timer_get_phc_index()
4. Remove phc_index from struct netc_timer
5. Change PTP_NETC_V4_TIMER from bool to tristate
6. Move devm_kzalloc() at the begining of netc_timer_pci_probe()
7. Remove the err log when netc_timer_parse_dt() returns error, instead,
   add the err log to netc_timer_get_reference_clk_source()
v3 changes:
1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read()
2. Remove the check of dma_set_mask_and_coherent()
3. Use devm_kzalloc() and pci_ioremap_bar()
4. Move alarm related logic including irq handler to the next patch
5. Improve the commit message
6. Refactor netc_timer_get_reference_clk_source() and remove
   clk_prepare_enable()
7. Use FIELD_PREP() helper
8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
   help text.
9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
   confirmed TMR_OFF is a signed register.
v2 changes:
1. Rename netc_timer_get_source_clk() to
   netc_timer_get_reference_clk_source() and refactor it
2. Remove the scaled_ppm check in netc_timer_adjfine()
3. Add a comment in netc_timer_cur_time_read()
4. Add linux/bitfield.h to fix the build errors
---
 drivers/ptp/Kconfig    |  11 ++
 drivers/ptp/Makefile   |   1 +
 drivers/ptp/ptp_netc.c | 418 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 430 insertions(+)
 create mode 100644 drivers/ptp/ptp_netc.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 204278eb215e..9256bf2e8ad4 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -252,4 +252,15 @@ config PTP_S390
 	  driver provides the raw clock value without the delta to
 	  userspace. That way userspace programs like chrony could steer
 	  the kernel clock.
+
+config PTP_NETC_V4_TIMER
+	tristate "NXP NETC V4 Timer PTP Driver"
+	depends on PTP_1588_CLOCK
+	depends on PCI_MSI
+	help
+	  This driver adds support for using the NXP NETC V4 Timer as a PTP
+	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
+	  synchronization. It also supports periodic output signal (e.g. PPS)
+	  and external trigger timestamping.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..8985d723d29c 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
+obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
new file mode 100644
index 000000000000..5f0aece7417b
--- /dev/null
+++ b/drivers/ptp/ptp_netc.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC V4 Timer driver
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/ptp_clock_kernel.h>
+
+#define NETC_TMR_PCI_VENDOR_NXP		0x1131
+
+#define NETC_TMR_CTRL			0x0080
+#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
+#define  TMR_CTRL_TE			BIT(2)
+#define  TMR_COMP_MODE			BIT(15)
+#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+
+#define NETC_TMR_CNT_L			0x0098
+#define NETC_TMR_CNT_H			0x009c
+#define NETC_TMR_ADD			0x00a0
+#define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_OFF_L			0x00b0
+#define NETC_TMR_OFF_H			0x00b4
+
+#define NETC_TMR_FIPER_CTRL		0x00dc
+#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
+#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+
+#define NETC_TMR_CUR_TIME_L		0x00f0
+#define NETC_TMR_CUR_TIME_H		0x00f4
+
+#define NETC_TMR_REGS_BAR		0
+
+#define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_DEFAULT_PRSC		2
+
+/* 1588 timer reference clock source select */
+#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
+#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
+#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
+
+#define NETC_TMR_SYSCLK_333M		333333333U
+
+struct netc_timer {
+	void __iomem *base;
+	struct pci_dev *pdev;
+	spinlock_t lock; /* Prevent concurrent access to registers */
+
+	struct ptp_clock *clock;
+	struct ptp_clock_info caps;
+	u32 clk_select;
+	u32 clk_freq;
+	u32 oclk_prsc;
+	/* High 32-bit is integer part, low 32-bit is fractional part */
+	u64 period;
+};
+
+#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
+#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
+
+static const char *const timer_clk_src[] = {
+	"ccm",
+	"ext"
+};
+
+static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
+{
+	u32 tmr_cnt_h = upper_32_bits(ns);
+	u32 tmr_cnt_l = lower_32_bits(ns);
+
+	/* Writes to the TMR_CNT_L register copies the written value
+	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
+	 * register copies the values written into the shadow TMR_CNT_H
+	 * register. Contents of the shadow registers are copied into
+	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
+	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
+	 * register first. Other H/L registers should have the same
+	 * behavior.
+	 */
+	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
+	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+}
+
+static u64 netc_timer_offset_read(struct netc_timer *priv)
+{
+	u32 tmr_off_l, tmr_off_h;
+	u64 offset;
+
+	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
+	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
+	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
+
+	return offset;
+}
+
+static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
+{
+	u32 tmr_off_h = upper_32_bits(offset);
+	u32 tmr_off_l = lower_32_bits(offset);
+
+	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
+	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+}
+
+static u64 netc_timer_cur_time_read(struct netc_timer *priv)
+{
+	u32 time_h, time_l;
+	u64 ns;
+
+	/* The user should read NETC_TMR_CUR_TIME_L first to
+	 * get correct current time.
+	 */
+	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
+	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
+	ns = (u64)time_h << 32 | time_l;
+
+	return ns;
+}
+
+static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
+{
+	u32 fractional_period = lower_32_bits(period);
+	u32 integral_period = upper_32_bits(period);
+	u32 tmr_ctrl, old_tmr_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
+				    TMR_CTRL_TCLK_PERIOD);
+	if (tmr_ctrl != old_tmr_ctrl)
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 new_period;
+
+	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
+	netc_timer_adjust_period(priv, new_period);
+
+	return 0;
+}
+
+static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	s64 tmr_off;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Adjusting TMROFF instead of TMR_CNT is that the timer
+	 * counter keeps increasing during reading and writing
+	 * TMR_CNT, which will cause latency.
+	 */
+	tmr_off = netc_timer_offset_read(priv);
+	tmr_off += delta;
+	netc_timer_offset_write(priv, tmr_off);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	u64 ns;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ptp_read_system_prets(sts);
+	ns = netc_timer_cur_time_read(priv);
+	ptp_read_system_postts(sts);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+static int netc_timer_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	netc_timer_offset_write(priv, 0);
+	netc_timer_cnt_write(priv, ns);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static const struct ptp_clock_info netc_timer_ptp_caps = {
+	.owner		= THIS_MODULE,
+	.name		= "NETC Timer PTP clock",
+	.max_adj	= 500000000,
+	.n_pins		= 0,
+	.adjfine	= netc_timer_adjfine,
+	.adjtime	= netc_timer_adjtime,
+	.gettimex64	= netc_timer_gettimex64,
+	.settime64	= netc_timer_settime64,
+};
+
+static void netc_timer_init(struct netc_timer *priv)
+{
+	u32 fractional_period = lower_32_bits(priv->period);
+	u32 integral_period = upper_32_bits(priv->period);
+	u32 tmr_ctrl, fiper_ctrl;
+	struct timespec64 now;
+	u64 ns;
+	int i;
+
+	/* Software must enable timer first and the clock selected must be
+	 * active, otherwise, the registers which are in the timer clock
+	 * domain are not accessible.
+	 */
+	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
+		   TMR_CTRL_TE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
+
+	/* Disable FIPER by default */
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		fiper_ctrl &= ~FIPER_CTRL_PG(i);
+	}
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+	ktime_get_real_ts64(&now);
+	ns = timespec64_to_ns(&now);
+	netc_timer_cnt_write(priv, ns);
+
+	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
+	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
+	 */
+	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
+		    TMR_COMP_MODE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+}
+
+static int netc_timer_pci_probe(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	pcie_flr(pdev);
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (err) {
+		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	pci_set_master(pdev);
+
+	priv->pdev = pdev;
+	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+
+release_mem_regions:
+	pci_release_mem_regions(pdev);
+disable_dev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void netc_timer_pci_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	iounmap(priv->base);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct clk *clk;
+	int i;
+
+	/* Select NETC system clock as the reference clock by default */
+	priv->clk_select = NETC_TMR_SYSTEM_CLK;
+	priv->clk_freq = NETC_TMR_SYSCLK_333M;
+
+	/* Update the clock source of the reference clock if the clock
+	 * is specified in DT node.
+	 */
+	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
+		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
+		if (IS_ERR(clk))
+			return dev_err_probe(dev, PTR_ERR(clk),
+					     "Failed to enable clock\n");
+
+		if (clk) {
+			priv->clk_freq = clk_get_rate(clk);
+			priv->clk_select = i ? NETC_TMR_EXT_OSC :
+					       NETC_TMR_CCM_TIMER1;
+			break;
+		}
+	}
+
+	/* The period is a 64-bit number, the high 32-bit is the integer
+	 * part of the period, the low 32-bit is the fractional part of
+	 * the period. In order to get the desired 32-bit fixed-point
+	 * format, multiply the numerator of the fraction by 2^32.
+	 */
+	priv->period = div_u64((u64)NSEC_PER_SEC << 32, priv->clk_freq);
+
+	return 0;
+}
+
+static int netc_timer_parse_dt(struct netc_timer *priv)
+{
+	return netc_timer_get_reference_clk_source(priv);
+}
+
+static int netc_timer_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	err = netc_timer_pci_probe(pdev);
+	if (err)
+		return err;
+
+	priv = pci_get_drvdata(pdev);
+	err = netc_timer_parse_dt(priv);
+	if (err)
+		goto timer_pci_remove;
+
+	priv->caps = netc_timer_ptp_caps;
+	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	spin_lock_init(&priv->lock);
+
+	netc_timer_init(priv);
+	priv->clock = ptp_clock_register(&priv->caps, dev);
+	if (IS_ERR(priv->clock)) {
+		err = PTR_ERR(priv->clock);
+		goto timer_pci_remove;
+	}
+
+	return 0;
+
+timer_pci_remove:
+	netc_timer_pci_remove(pdev);
+
+	return err;
+}
+
+static void netc_timer_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	ptp_clock_unregister(priv->clock);
+	netc_timer_pci_remove(pdev);
+}
+
+static const struct pci_device_id netc_timer_id_table[] = {
+	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR_NXP, 0xee02) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
+
+static struct pci_driver netc_timer_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = netc_timer_id_table,
+	.probe = netc_timer_probe,
+	.remove = netc_timer_remove,
+};
+module_pci_driver(netc_timer_driver);
+
+MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


