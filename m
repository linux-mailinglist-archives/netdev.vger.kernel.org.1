Return-Path: <netdev+bounces-195327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D396DACF8FF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 22:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A257A4BFC
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 20:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079EC27F198;
	Thu,  5 Jun 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q+HrzrIV"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A827CCF3;
	Thu,  5 Jun 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157152; cv=fail; b=rgMZ7bJC9dtI4g4JK9CEovdOD+G/+C5La64HAxvi8V94G8qUxm+tY9saw3zAy/hxrdVAw9vskpyaSpv6dgI8zOKOrIWyb6Kgc4tcoOlfc6X8hl//vvWEowKgdhPsDJz+ETedanuJtlPngxfK4yJ1r7EjuhhZ/8mzgBf7GJy9VWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157152; c=relaxed/simple;
	bh=7f5rYS/G5Co5ezbQ0qXbvFtJlrX8bqNiyLDDZP7R5V4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GhCv6e10muLoMsp6VQEAt0OPss5tA952dqECRMwfeZne+8RzodyKmludQ0jjGUwKzsgytRii91PAqPHppMJIRy5UXarK/jOJnbYC0jkRgnekPl4VxWBCiJiMkN7GDwPvLBq8o50sKt+yIJyo4y/QBwmVo+aKAlj0O7iQrmZ0+34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q+HrzrIV; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6BAXqRA1i+rXZrCW4qGF3V+1AbwZYl9HgqiNGYjUPCxdR23SpCpzL50cfYC1Lc28qXJ716Cassy6m5SynxvJjmz0kBUq/sEle7rekPtWqyJmNYvGpapfsYW18tv+TRwvikiiUhSXx+4TtTlejy8xLFsUsRymJby7Lm9oV/7RTLbz/VcY3V6i3QLkvQMyUMNhtL5GVrmy+4zOvs6+mnvCgky9PcFDm5hmkzAXCqUyRblFcO/UwER0EJSLXILP0fg1FtUqbLfRYHG/OK9csFmTClnoUMzDEuCLQmE3S8gzX/X7IGuj8XrljDfzydWAqFGoprY1G3InujDuWChHTyiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJHORHEwOzhyfbFUF4R5IGYc98WpcYh99P2tAVRCOCg=;
 b=L6Rqb46KcA2Mq4MOmUlWbsMttuOrCQTphCiL1qEDqG91AoDDhIuC6pH/X+ZkxLt8Hj6UFVypRKFv1+JnYD09XOlI9ig5V9caKYLhOQo5zcbfOf+87pVhgbvPND8OLxbSZ78oQno1ian3QBlVwnKYl2F0N0BjIAt5dyDFhf+V/MgLDbEoiZHsSpHs86xqVkzGjVL6vxIm8oA4gYuUR6g4Rx6v7LW+TPQIwziIdQNhss/EmldU6d5q90QQE7KAS00p37ta2dOdeUVs6z2XUEAtR//MLMFbT2RRthlGOlKBje+UwwMeXHpjK2qfQBZwS5LKXBM6TFW1RqX6IANBMTtYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJHORHEwOzhyfbFUF4R5IGYc98WpcYh99P2tAVRCOCg=;
 b=Q+HrzrIVN5h+pXH9lWPFI00lS8bpNxGIXqGnzi2brtH7j7xOcS/kfvGQsWgsqWepzRVjFjVXv2mwGlJe9jYP6DFBJaqcUKnwwBaH5Cd1gDFCygBQb7FZCYarZdleev7pfh09qhRya6S49hUxemtlo4A7XdOAk7T9bOmC6/RjZ2uvgVYUF89UzLW8TSw6OcTt6B3g1z8qod41apQkNgQ2151mmT+igZUnlCAZmjkBWWLnR2PXCQhNCTwd2PlzIVDq1/ZFaTmUYU4V99UPJrc1ncPNa5cGQwLBO4TFIbiVvUFznKSSN/VwrNWg0iv/HdWsRaHYGQHXtpm7Z59mDe7d5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9697.eurprd04.prod.outlook.com (2603:10a6:20b:480::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 20:59:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Thu, 5 Jun 2025
 20:59:09 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_))
Cc: imx@lists.linux.dev
Subject: [PATCH 2/6] arm64: dts: imx93: remove eee-broken-1000t for eqos node
Date: Thu,  5 Jun 2025 16:58:49 -0400
Message-Id: <20250605205853.1334131-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605205853.1334131-1-Frank.Li@nxp.com>
References: <20250605205853.1334131-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF000040A3.namprd05.prod.outlook.com
 (2603:10b6:518:1::57) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9697:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a44e5d7-5504-4b1e-43fc-08dda473d117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kQzu5Uuq3vOEqYX/u4WjRiguRbwtdbAryrIsQx03KZ/EtAdbMC+ee5+/XXxb?=
 =?us-ascii?Q?9HI56a8gQHfGkFB0kjSWpQ5q+fLmhjqmDJ+7BMSy5Frm1/K63sBsP2KHbusV?=
 =?us-ascii?Q?I41J1PH+mWpSUeDZiFGoFSbo51wNkNS01UHwFWKQuzEKKMnTxkZ+/6Q/TTTC?=
 =?us-ascii?Q?fKE5VDG4E/MrA8oh/vVbLs2ub/JKdgSGtw68ADJKKf7mtkgKpXPzYDfHu24Y?=
 =?us-ascii?Q?Ck+sGasnRExpV8Np9eOeWZXS5ExCXLa2teKfXyqLLSeVWrlfOvr9lbU9YUhc?=
 =?us-ascii?Q?pQbQnopBlCoHxex27LzmnFaQ14MCSC48mU5UniIrmdC76hJbSxmKFMKJ+hDY?=
 =?us-ascii?Q?XWyng7X9hVyUvDGT2tJK1MaonvdoJ2MQzGuyq60/kfAnWhJYhZAfFDqCUiSJ?=
 =?us-ascii?Q?JiBKbcK5/M3iqnSZjbIMRSMvTWUFNe/3OGSlr8gDN3AmljnFDLRqpALbLFCX?=
 =?us-ascii?Q?kaG9FLs2WaxWB3BkgSaQawmswH2n5Q3EwE0oxH3sYSUCI4PJKRw0b3klHSJ9?=
 =?us-ascii?Q?mJFibRR3OFEWKTwf/k7UhbvoCLYnuLZM5eyXF0sGZBDJFHKDBK+y8ol7ZTxb?=
 =?us-ascii?Q?k1r/XRmhrwzsHps5G0YO/WAApi01d9r/imMafIm4x1iCtqTrv9wC3l3YrS1c?=
 =?us-ascii?Q?+AqLjV9DxU7wiWtkKHychgHawFLREpmhUIoXZWVXJygAdTh3YwpBVgG4gODV?=
 =?us-ascii?Q?yDyCWWmQX2Hh3vtSJsIf6N2dkc62LmMpGAnuYgPFitiJNW/ifo11ISFH21wX?=
 =?us-ascii?Q?bDf7bHYOFApf72z8keYyTD8OLJW7tz9AqO2JdRfkKU3uQFTXjbl1EsULgBMS?=
 =?us-ascii?Q?mxx2USqRHIO9DotlqhEWYUmmdRoTWqRkaIAc7HnSG8SZYw1Fc4+Hc0UkaH1o?=
 =?us-ascii?Q?pKR2osMWpQbcf1K2OQ7c2JTw1pgp32b6hYWrE2VihPz69eZZvcg+TVxsVESH?=
 =?us-ascii?Q?l7+6oDai1WYSmuhSnHfZFPSXYj59DZ9bEYbE2FmMG6Ax3+BJ7UWrUs84gvA2?=
 =?us-ascii?Q?lrWUo36RqcxJ/8Tb2q2AUIfwURonKpvPCTFtfvlcX7KP3fNZ4MBA2jBT/YUz?=
 =?us-ascii?Q?wCR1OeySyzw9bCYGm17VhbVmKwP4CCWGq37MuHUQQrCwZrZ65vIV1if7BnOE?=
 =?us-ascii?Q?b2ZNPoWMSv5zyzrtP/bXpRMArpHHcFGoO2AVByF5/CSPIYaWKiX84klulYUL?=
 =?us-ascii?Q?nC/Q30YB0fcR/8PzN/CTtoM+lDJcTaJDUzyXvkP39u7TzbM1FhUqVYqfK2i/?=
 =?us-ascii?Q?NEX8XF+iwBWKyb+szy1LZvryJWmnwHu9a1sE5BqAn63O+VuYnXfV+77DtMEx?=
 =?us-ascii?Q?cz99EFw/gkA545BxPeNHY7LuLw3PnRGWxhbVHJY2zaK2GsGzU8VTlpN4orKd?=
 =?us-ascii?Q?KDhm5RvwLt1QtKmClwJl/Ysw2Wv40ML053BhuNY1tFSnex7leVRZv37T9teM?=
 =?us-ascii?Q?S6+hheqv/lS1sF8zvDmnelnro7nyvnQ/Cm/YGBGER2pWag4gTsXqgiu55/6K?=
 =?us-ascii?Q?nvQhqsRYXbz+LrI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rYZRZ8naq1rxoB+pdAJBwr7r0yhwN7F3NDxbDc6EeJQV9JuhD9nGuGcyx+c+?=
 =?us-ascii?Q?WY0l6mXbWbAxrkhaOZr6VlpxqG7YqK1tlI3e+WVN3l8HEbfkjdrUih7IRjvx?=
 =?us-ascii?Q?m2TFLGlfju3GEdT9t/ltxclQIg9WTYLEt1G5BUoELasn8U+IYIMLLfR60K8N?=
 =?us-ascii?Q?xJQ1NRSGqao34ltZ73X5kv0wxN+LMq3SkUTulVXjUugpfoiDtl+EpJee2+HC?=
 =?us-ascii?Q?oubYT6OyEGOYtJDmSupGeVnoHayIBMk0eJNDjoZWMhJfmNjXuLO/wDdkY/R4?=
 =?us-ascii?Q?sgvM7iV3yhp/jxrJMNJR0SbqGq+MXoqVL0c8Zr9hZoggFuad+L42BUd+AChC?=
 =?us-ascii?Q?/5qiVSmvgYScBgSxNGw66BIGgnSrwclDCn+XDuWpjsPhRxUSpwL6N91Gp26i?=
 =?us-ascii?Q?wPJ+DDX8s79eQAz2S+Gwt5Os30+5L03llLumaeDJ204tdryJ3Zu9RTWr08ek?=
 =?us-ascii?Q?JK3f79QTXNOMJGNjVKLhK5e9+BX4G5KvnHWHosBKsVrneA2hp9+1DW0smTYm?=
 =?us-ascii?Q?J6NZaKK7zfLSkRY3Yuix0XqzA4ZT3C4PiphQgpJPUwHxLlcFBcqHvk7g5x5+?=
 =?us-ascii?Q?OtoorGei/ArxBhIJiVjBOCDoJg8ehlxnM/wSpfM08byupiYjBuX+8y8lsouk?=
 =?us-ascii?Q?oW4H4/tCM9hMCi8oN2dS+QJ55xXn9wb3HfDgwEqK6bUhLeEU/UYjDVRZZzG9?=
 =?us-ascii?Q?EZgtTnwEKD/iCFqKRwog9+7QtBZxXL10ebPwJXLgahJEFdQbXX4raIxq7mvJ?=
 =?us-ascii?Q?p8CBt3aGFYHLoFPSZOFluIyfrY7WAvKt10jIhako0oJk/92vtJHvauq1yM7F?=
 =?us-ascii?Q?++INywW5GB9qK9CjvTj3u5QprMn4ttSMLxeibYmDuSSEc5L1oIjT+ASxEASF?=
 =?us-ascii?Q?1XjoXBGaSgtGHd6OiKh93CAQsXckj6yviQWvKkQO9K4ivdojTX3P9GP8UlTW?=
 =?us-ascii?Q?xoRu8FN4F+RMPK7hv8z696nbILnk9rAFfwGLY96eqg3oaOfGP5g1SaOALLtJ?=
 =?us-ascii?Q?5LU8MgdDIg9r5gNcLm0noBzPhEpjclM5CEDjxPomDbXpZ+b5lESOW1bjYM+J?=
 =?us-ascii?Q?nQHYkpuUhjEjlpvYoEoLacIKfDXsOaeNKVWDPtrTJLkH+bOURsX48gNd5u0B?=
 =?us-ascii?Q?DZkd37JeyIYEAi2mU1Zoc1MXjP4rd19GpkmVSV7rPVGmJzrciifb4furCAI6?=
 =?us-ascii?Q?0nhgFXjQAEhEOBaOMDW7gdePwCs8OAOuDl4U7DpOQBxMO7Fli7eg/GKvQESV?=
 =?us-ascii?Q?U6uxTcHfdtHXiIQs8Aad37FqHD4huxipZNdirf1lQJYkB5pWMCYxlvHWhoJz?=
 =?us-ascii?Q?TLkuEiJCVzzHgRt4mk9lL0A82baIwdEY1HadXqqy4frQ37a4OBIEhTcjlQRd?=
 =?us-ascii?Q?dNK/NjGkk7IUkyVx5GNSxng09YB0MJIqE+Z6mDzHwskpSXpEci5J3NRN6Hsn?=
 =?us-ascii?Q?647zxDISrr62Evqq8EZB45rHTKQ5SlxhwAVUThbYbNXF86/P6dImophjlDOF?=
 =?us-ascii?Q?7Yg9b32eNmPnLdDiaYkYVwiz4uJn0vVAz03vqz8x7uHhCOgtVvL9yXp+K843?=
 =?us-ascii?Q?ydf0MPyuyg8Zfd8E9+NLO2fIGhToACiB2jNHM9P8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a44e5d7-5504-4b1e-43fc-08dda473d117
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 20:59:09.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+MZk1Ee/yF1rXrsgc/yU33Njn91WFpll7Mk4UwYmoDyhDN4T7GxlVTTG6i5OzUAHnTdlxgLXKzk/foSJzBUgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9697

From: Clark Wang <xiaoning.wang@nxp.com>

The "eee-broken-1000t" was added on 8mm for FEC to avoid issue of ptp sync.
EQoS haven't such issue. So, remove this for EQoS phys.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 1 -
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 8491eb53120e6..a6ebeb642eb65 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -217,7 +217,6 @@ mdio {
 
 		ethphy1: ethernet-phy@1 {
 			reg = <1>;
-			eee-broken-1000t;
 			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index acbd981ba548a..cceca130c5b4e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -184,7 +184,6 @@ mdio {
 		ethphy1: ethernet-phy@1 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
-			eee-broken-1000t;
 			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
-- 
2.34.1


