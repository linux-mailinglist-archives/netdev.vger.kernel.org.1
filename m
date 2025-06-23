Return-Path: <netdev+bounces-200201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0997AE3B86
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB1A1897E6C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77523BD0E;
	Mon, 23 Jun 2025 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CCslU0xI"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5623BD09;
	Mon, 23 Jun 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672828; cv=fail; b=eNOb/WoPWdDTXMlikzQb3fqXtcIvGf8t1D/JJxn70kzFueGX8++g2nnwAQY8p5SIk52XJZeVSOitefIBJx79DTKSno/U1rqRPI5sXr0acKcViUTaLsraED3ErBzIzWFFHZDkFrVQw5gJaJNGPTsAO+s3jsHGs2f6RgxWU1ByrVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672828; c=relaxed/simple;
	bh=2s+Oq/JiuoFZ9/M3KdfHpcp1ixBQ5tu7coQVlaB4ISY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRygOrq19lypolQhPTmxo7WknAQfW2lCvHGlaG/uJGbMLAh9SZuToRjaUK/lYP8UnfUqrbNj3dKoNc8omgprW6utpeW9IOyF4Vcn096ayxgzOOiiKxYbTPxq/FJh+bAww/ySHoLRSTPAK0e3sHSMRI5ywDN+5AWISPCa9CvsO8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CCslU0xI; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzejgGXaUEJOmjfh2Fh+leqBeCY8NCEPY36bz3I9yyEVeLu/U/T276Co9i+x0Yfay3VhB6Co5nd83MPsotqv1KGn8RJUzyerqFw0/Fz/FZePOgws/jp6rQlsMHcVXM9QZ5PB3mnQVjqbnXvy6CsTK5shLC+kxWPuTv8ksijG8ovFnRQhFVkG4X2igiNPwr0ONZtQQsDVfNBcn4ec9U19NxGEjk10DRoxqXKFpHFheG0dL6gG3Vn58UInGtMG0kJgYlDoqnz6gTMh5XeumvnIAs/tHm8Ju6XJ4953jZqRn8wDJIWH70MHXRnTQpzjghM3l5UFABwV+feHLTNzFtj19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjQ5LVJzy/wDkG9qO8W92wX8uwH6hD7PU+RYBD+S5y8=;
 b=qhrEiRc13uDVPgk22vKYNxG1uywVIHEy045b3e2rDECy0wjEuH+qcy5KTi4gl5VMT3Ty6L6fFKB6foYVJ7WdnUHDoR6RlT8g5/AyJpqbSqZQmY86tsAknoUviz+ONWN68Jh6tCVpJlBOqIMimxUmIzCMeem0w2c8Ysa5IlZ8SGNFE39GZpceeSlCDApqN1L8BEMKGnAjJD5t8AHsF5qMaO14iZgydgOZx0pfDqNJUg1bVWugJQShmSJTC2Q0c7ctgPW78guKwOvyPyrSnD0JmFbqR97ano2e2GawB/8nf7NnHKdlTPQbVajvLw5pMY+fMNuTG2s87a6ZhHXJyZDv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjQ5LVJzy/wDkG9qO8W92wX8uwH6hD7PU+RYBD+S5y8=;
 b=CCslU0xIPD07F2/rcZDLl5mA1dMwjZ6qzA8nTPPt5tgYgrFNRZ1sHy4ECTDSagxX6p85vdSIFJCra/V93Lqqbe0wPx2ByKPRlZ8JcyuctRCSml4uHUOf3haC7lCpgEa2YGvv23kzn6ENNld69krEMIjKdgMnx2o/wxeoU1d1oFn0zneSUIEZz5bZOW9hll8LhFqIu4v+Cm9OuWoaM1Rttcro3L5ambTxSZPzwou0c9wKv8/QzeKSSFgHFM9/OvuLx+ewyob5T35Kz9y0m0CUsAn+CJqLoi3rccrh0wYx0qNCndeUQq8f27qTbQ0AUSjVCtOLam2PkU/kJqM467LHdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:00:21 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:00:21 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ulf.hansson@linaro.org,
	richardcochran@gmail.com,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.or,
	frank.li@nxp.com,
	ye.li@nxp.com,
	ping.bai@nxp.com,
	aisheng.dong@nxp.com
Subject: [PATCH v6 5/9] arm64: dts: freescale: add i.MX91 11x11 EVK basic support
Date: Mon, 23 Jun 2025 17:57:28 +0800
Message-Id: <20250623095732.2139853-6-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250623095732.2139853-1-joy.zou@nxp.com>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b302b63-541c-42b9-4121-08ddb23cc406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCV72bw+HNhpNjD40FZN38uftTjP53qVkTp9BkM2fc3W+ax1rJkgGZ9gDaXF?=
 =?us-ascii?Q?OyE4+6EI0w2nVHqF1yGw/Ecl8EuMIp+W2lV2d3iJsuHR09HoNi1kLqFzp0K+?=
 =?us-ascii?Q?9IT6bT2Kj1V09nAvRL6IZBpctPVFpObtkLdX1Gi6KUcwkYsbT/fyxcELGMC6?=
 =?us-ascii?Q?TZRbFk35S3BE79Efw17pOcOJLOZUhu18DAa0YMeK/0wzDoZbFrgOKsJSblpA?=
 =?us-ascii?Q?RdowWTdjXSo9Qo74x3nT4NMgmy+xGLoZLpnFLD6NdzYqQ2UVoyvCxYs2gBLf?=
 =?us-ascii?Q?uL4ZioQ94YUEyY3hBcZZnCRWHKVfPadRqaNS2jlwZgSyxHNR/eBdH31UcLyP?=
 =?us-ascii?Q?j0lWxDcOUlamaknwB/MPfy7VoclJkDge7aSdkjniumW0045j8lKBZGX4MrTe?=
 =?us-ascii?Q?zvUiVnbRUpyc1HFDriVAOI4SJiICBmSS1xFPWPCe6LxGoXkr80LAaIIjJCR6?=
 =?us-ascii?Q?ZREOf+ruzNFcMG42TY+JbsxU1vqt/fSDgLtsc3AZ9Iejo9ZLjj2K9mD+pk/Q?=
 =?us-ascii?Q?QIZyJ4mNNyFVRxEq9VNPLSV1pv1EYFQBaS3fb3Bre6hUsXHOC++yPDi3VBhf?=
 =?us-ascii?Q?B/uAk61TY7FTpKISjcn/WmFgmc58V1AbLZIkpKiP8zh45kEYED4KXUEDCLeQ?=
 =?us-ascii?Q?X+2tsSLpqyaGcWDxfhUKbgJp+GWXm+FjLLDRv5eNlEypF0QNJU137wGmhaTd?=
 =?us-ascii?Q?DhJJzmFli3F5YjIEP2H9v96rE3uf2W5I027EyHRO2hzXLvQAurYjydQq+D1o?=
 =?us-ascii?Q?I3oNIvsyeEEDq/468Prn5SALPAY3ze+yGwGl7fYmNPTLuAblrbfeziBpSOZw?=
 =?us-ascii?Q?HFhhSu746RLsiQRY4QNDuKBCTo664q0aNCi9LdDvkB9w7wHynEt037VWC1fY?=
 =?us-ascii?Q?kc0Ftyx/XYreEHn4vuW4dhReRM7AgE2nlKQc/2LY11kpu9cZmKAT0Ohbi28P?=
 =?us-ascii?Q?O0Il0TEmaBaPnTqnDVbGHVFZ4EyCAisbrWR6eNpvTL0AFmAkKMS2oTsmniHP?=
 =?us-ascii?Q?cfqMmC8YddCm2vRGZmFhHvz8ep8NQXOiikZ/Oxhtm6yo+G+0TTHWvXZaHpp5?=
 =?us-ascii?Q?vrcMKXSI7caqy8k7yTXfmWmPxSSodMmCsKkFiZ0WcKlA9br5ATsJEU2ihkKA?=
 =?us-ascii?Q?e0u0KvCSsuGT0QeLMzcN3vox8ogjPsYYfczMHTiqJLWiIpmfkEYcp1DmavMs?=
 =?us-ascii?Q?np7078DTZpLdq6yr9zd3D1tSS+n8YFO1bERAoWgMY7vnEV20++jqytSOeqD8?=
 =?us-ascii?Q?nGLnaKZYW3wwocX4646EkWtoAmMo96y0hQgjBd2yJCBMH6QxsQJ1w/6NLZIT?=
 =?us-ascii?Q?4j9IaRUWSesI4+RTF5m6ng4r5eGEas8X8b+nAACvowU439vLpKDNaaw6p0wf?=
 =?us-ascii?Q?TFD0IebEMhK625P7HMn8UsJyGsXOrsbw4bhR9HA2pS+t4PYfY1VN032Wwd40?=
 =?us-ascii?Q?QpTsDoj0fVF0dBW0NdsUW480tbq7hHb2q+gbcVdFrgP8FyM1VDrm7805PveL?=
 =?us-ascii?Q?ZqxcK/3y1CHybHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LXE19DiKK9HPZZwj0hmukr1R/q7lCamhkRCOL1wrrbvsQ1CKf75SoWitg1EG?=
 =?us-ascii?Q?rQW3Yi/jG3Zpow3C9+5ZdVXh1BBUDpXV6HZIrKqagSYMxL8rDb7SgLkk9Xyt?=
 =?us-ascii?Q?wNGOVyKonkC6zSxkddoDQMKIGuBt+67P97isSlmk8Tyv6l78/Pq73vUGDrRn?=
 =?us-ascii?Q?SsSuieQ7qx502jZMIBC1aonQGKNiAZK/j3yviFlQA/XAoLTklWCOSGERrk0l?=
 =?us-ascii?Q?RGyimh5lkRBnHQjoMRbAoH6+eHVl5u8ZRwt/7MhsyQkq1OIHQ/gKv6D20Ll6?=
 =?us-ascii?Q?gQtLG2XIjo37mzJgptCJCu0p6jMmTpt2DJUEewjcLS6Yf7aPXmlqkoGpMPAG?=
 =?us-ascii?Q?zXtrjnGtB2Rt1NgllOjvHHEWBPXKdN9dZlRw3HxjSkqdl9VZTjjMeE/+lGeW?=
 =?us-ascii?Q?tsuIcpYjQwhIpHe5fMO69Fnri826aXZlFvanZHBy3qdF8k3AQTzvdKwOFOJY?=
 =?us-ascii?Q?mV8nJqn3DHkq5fGPLkkBnD1n9aLqsu9BvM9t1vKGdA2LTIMDFy3Pwya5aUUi?=
 =?us-ascii?Q?sobQnT6JAMZ0uJ/iIxkoGVj65Yx9BD3DToK+jQJjfmy6JQ2meKT5wpzCWhqr?=
 =?us-ascii?Q?//6e0HB1se71o+zl/uDqSjO668bcK3uIVXknj7kj6bVYbm8skTFXB5ZFmSGG?=
 =?us-ascii?Q?1tyNlc+BMDD8WMW+K4btSwUoY1RuU/gM1puOI7HtJt6dtlgf7xFEi9dXWPZC?=
 =?us-ascii?Q?EWlojLyl1MMuKtkFDUV9/9Xxb9qVLhFebDi8YTXKSGa6dBbpFjSn2zhvqRo2?=
 =?us-ascii?Q?Jb7slGmJdsXqOB4SJofPpB5hDJZlivWd5CPqz3L7GgVurnRQ9w5pNZGfoJzU?=
 =?us-ascii?Q?+t37Kt02OiW/PH56REzd3sWhjT0y5YAQ4/15cmwfKnOqoFUirr8cLM9dVy2Y?=
 =?us-ascii?Q?hQ0x6qq7Q+MvuXS72saTXdsGY7fNjAUrdftN1smKUdGbae7n51YLq0cUy+Sa?=
 =?us-ascii?Q?0LkQcd0BR3cMhT5W10MqII1yLiSarT8pYDnpFB8rDl82ASmdUseOyFG2ZSAV?=
 =?us-ascii?Q?t2VnPNNpxqJNzN2W3gm/vuMVtWXoMPBhtEFP19ptbZ7MrCYy8XEUYnIM2JOA?=
 =?us-ascii?Q?aiXFPUZAvJsX1GWqV7mskjioum7fpvqWt09EQ7tN0gNrI4JcjBsmkPzHfJ9J?=
 =?us-ascii?Q?9qfmLObAm2WLTdJ1OttTwBMoubyx4Nfq1wD1MnpA0vqwhRmChirSPWWd7FrM?=
 =?us-ascii?Q?mKD0XA7iyaWKaHYdET5+LvwzhFD197rPnQpjQVoBZS7g14ZuiAtlRiTDI9WA?=
 =?us-ascii?Q?0PX2r7TGmn6ly2qdCB3+RkDuABF1K4NM2t27/AVlSk2lRVIpcG/cxPs7LimK?=
 =?us-ascii?Q?B6HDevAMjlj1rsL0kAcPXFuwttPuLPxVFR/VZUZjyc4CQHABHGMtEDv3q+uy?=
 =?us-ascii?Q?TDEXvKaedSTm1k3AMV49QbJY2wh4Hre+7ucQ3JyTXPTk/qFBYulg/L2VOCqi?=
 =?us-ascii?Q?yuSKCu5MeS+KCf+7VcR2ljOvmH2Gzk+BPoyNNs65mz/NCyEMe8oNeQ0ggqwi?=
 =?us-ascii?Q?Mykt4CmrF7z1XryC9GNewZ+4rQi92MtVpadTGIG6ZVl1JwRUdDPthbtDGwjw?=
 =?us-ascii?Q?exnWi+h2AcsVPRib3SkqHOMa9h/EXZNo/KiAMILA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b302b63-541c-42b9-4121-08ddb23cc406
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:00:21.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHqWbag5F4d7L5LnRJ/XfqUFbNkc95eVakNXp6CD1RG9s0oHD0TTKsFCPzZVSdbf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Add i.MX91 11x11 EVK board support.
- Enable ADC1.
- Enable lpuart1 and lpuart5.
- Enable network eqos and fec.
- Enable I2C bus and children nodes under I2C bus.
- Enable USB and related nodes.
- Enable uSDHC1 and uSDHC2.
- Enable Watchdog3.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v6:
1. remove unused regulators and pinctrl settings.

Changes for v5:
1. change node name codec and lsm6dsm into common name audio-codec and
   inertial-meter, and add BT compatible string.

Changes for v4:
1. remove pmic node unused newline.
2. delete the tcpc@50 status property.
3. align pad hex values.

Changes for v3:
1. format imx91-11x11-evk.dts with the dt-format tool.
2. add lpi2c1 node.
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 666 ++++++++++++++++++
 2 files changed, 667 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0b473a23d120..fbedb3493c09 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -315,6 +315,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
 
 imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb-i3c.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
new file mode 100644
index 000000000000..0acd97ed14da
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
@@ -0,0 +1,666 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx91.dtsi"
+
+/ {
+	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
+	model = "NXP i.MX91 11X11 EVK board";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		rtc0 = &bbnsm_rtc;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vref_1v8";
+	};
+
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "audio-pwr";
+		gpio = <&adp5585 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <12000>;
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			reusable;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&eqos {
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&fec {
+	phy-handle = <&ethphy2>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
+	pinctrl-names = "default", "sleep";
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			eee-broken-1000t;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+/*
+ * When add, delete or change any target device setting in &lpi2c1,
+ * please synchronize the changes to the &i3c1 bus in imx91-11x11-evk-i3c.dts.
+ */
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	audio_codec: wm8962@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+	};
+
+	inertial-meter@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-parent = <&gpio3>;
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		pinctrl-names = "default";
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&pcal6524>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2237500>;
+				regulator-min-microvolt = <650000>;
+				regulator-name = "BUCK1";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2187500>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK2";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK4";
+			};
+
+			buck5: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK5";
+			};
+
+			buck6: BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <600000>;
+				regulator-name = "BUCK6";
+			};
+
+			ldo1: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1600000>;
+				regulator-name = "LDO1";
+			};
+
+			ldo4: LDO4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <800000>;
+				regulator-name = "LDO4";
+			};
+
+			ldo5: LDO5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "LDO5";
+			};
+		};
+	};
+
+	adp5585: io-expander@34 {
+		compatible = "adi,adp5585-00", "adi,adp5585";
+		reg = <0x34>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#pwm-cells = <3>;
+		gpio-reserved-ranges = <5 1>;
+
+		exp-sel-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+	};
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x51>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+		status = "okay";
+
+		typec2_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec2_dr_sw: endpoint {
+						remote-endpoint = <&usb2_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&pcal6524>;
+		status = "okay";
+	};
+};
+
+&lpuart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lpuart5 {
+	pinctrl-0 = <&pinctrl_uart5>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+&usbotg1 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	status = "okay";
+
+	port {
+		usb2_drd_sw: endpoint {
+			remote-endpoint = <&typec2_dr_sw>;
+		};
+	};
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	status = "okay";
+};
+
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__ENET1_MDC                           0x57e
+			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                      0x57e
+			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                  0x57e
+			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                  0x57e
+			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                  0x57e
+			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                  0x57e
+			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                  0x5fe
+			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x57e
+			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                  0x57e
+			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                     0x57e
+			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                  0x57e
+			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                  0x57e
+			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK  0x5fe
+			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x57e
+		>;
+	};
+
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__GPIO4_IO0                           0x31e
+			MX91_PAD_ENET1_MDIO__GPIO4_IO1                          0x31e
+			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
+			MX91_PAD_ENET1_RD1__GPIO4_IO11                          0x31e
+			MX91_PAD_ENET1_RD2__GPIO4_IO12                          0x31e
+			MX91_PAD_ENET1_RD3__GPIO4_IO13                          0x31e
+			MX91_PAD_ENET1_RXC__GPIO4_IO9                           0x31e
+			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                        0x31e
+			MX91_PAD_ENET1_TD0__GPIO4_IO5                           0x31e
+			MX91_PAD_ENET1_TD1__GPIO4_IO4                           0x31e
+			MX91_PAD_ENET1_TD2__GPIO4_IO3                           0x31e
+			MX91_PAD_ENET1_TD3__GPIO4_IO2                           0x31e
+			MX91_PAD_ENET1_TXC__GPIO4_IO7                           0x31e
+			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                        0x31e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
+			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
+			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
+			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
+			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
+			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
+			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
+			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
+			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
+			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
+			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
+			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
+			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
+			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
+		>;
+	};
+
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
+			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
+			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
+			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
+			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
+			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
+			MX91_PAD_ENET2_RXC__GPIO4_IO23			0x51e
+			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
+			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
+			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
+			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
+			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
+			MX91_PAD_ENET2_TXC__GPIO4_IO21			0x51e
+			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20		0x51e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_RESET_B__GPIO3_IO7                 0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__GPIO3_IO1             0x51e
+			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
+			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
+			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
+			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
+			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
+			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
+		>;
+	};
+
+};
-- 
2.37.1


