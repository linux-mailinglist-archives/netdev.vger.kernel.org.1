Return-Path: <netdev+bounces-207400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB95B06FAB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30BC1892F3E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA72EA492;
	Wed, 16 Jul 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HqW109V8"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E12EA48D;
	Wed, 16 Jul 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652369; cv=fail; b=LrQX2WAPhb4qdcaE/DgF0LR4Sp8xXHS2qsHj9/8vkcyocHYMCvtRCHBctsat97RkgLJu4zrvVr09QnB1f2mRORfGBr30zfAy1abVuvdEcDQO2VT0Mn/+VKrBh5Ty44krN4msWOLOzytdxCIEiiweDRma5WcCy4Gujw+YaO+2xfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652369; c=relaxed/simple;
	bh=2zZrul4n6X4nk7wOuvKT683UJRb9oFLJ34rLFLvPe9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7J1iba0EjKayi20tJ8uqePGfwAm+h7WCf36/8u5cCjjB4cqm+MsGnBidtRiNP2zFQwBcBGjUxPUcSa8EEP3piH/iURuXe4hsMibj2zxK6Ida5nXr0aMAT3xSgLzWXA823YaoVKQEXkWeXzXvpqp1nfcNWl3ksfJpjh6x3QY1W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HqW109V8; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJjeDEazixsMffpFN8U1xswaAUEAEaLWmp3PDc8LPWILEn46n+bEk+k147V4NR47JyUBlaVG6fOePC8V+hZetmc9fhXc+8Cx5728/hHAm9cutxdlkRZA+8oc7iJ0SpxLPHKZ3QbPWjXq0rJWSasay+K4R4A2ssVQzF/CDoHECNLNv2ccHTuU6qEqpYfELZIV5O8Jbi1nDJzlMAzD1Sv0ostoEgLRgnpMSZK2Oo+WQpVr2M2ZhrSXLvbobI7B5JkC9af9xLnpvwEv4uffGmg+sIN7emZDu4NcaR72Sdd5xMgO5nSRDy0+MCrT86PokhZPpjEpsGiRnHrpDFibbNADdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTzRcy5hYPFOrVHbOmLq8YJhcAtw/KRwhXE5GEfuDk0=;
 b=Qz+iy9BCNeMVGjNvsWWojxsaB3ows/m5QtslWHlvx926upvKexkmsmVRfiS8KKgW4j9Y3p6elzMYX0kFBN6K90j35UYRAknNVRKCbS+h6TlQWQMUt+fXDEBSt/y3KeLg7wtTgxuzuyIfoF2ylFKqjsKMs7OVyi31qKQzdmoetYUzsNUip1amf0hMX0SEaeTEMoWs2vM97b6b325soW/liKBJSheqqarHIub4G4MQ1HyNbVqoneWDB7Cq0jC7OLdC67DEc8qA/JFdqOJbNicfsSJUQ8kQix92Nl7SsK5XSED1Kxw/1U/n58f3RoEndf+e3Doysnuz5AGkM5160jSjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTzRcy5hYPFOrVHbOmLq8YJhcAtw/KRwhXE5GEfuDk0=;
 b=HqW109V8nCbA5kXj0WNzoVh9B3UlDeVTFwLIOFuZScXzeUykl7jPmJftOU/bEnyiAxddjgrdzqlkjPVZC6RCBSg0hZUOw3T+VwNmvSOtcDO3nxWBRqX1Y9Il9T76vFbgxRhbgqq8EBStl4xwf5qXUXOUiFwQHG+v8I6i60TEPUeCdjmU7fka9e/Mo7ERHiiRxOA4rzFN+shxqwtwWdII6j6oXKQg/XTMu9jEoQk4a/XJn3QoaovbxzDTZVsZQlhGYZDshNZ/I7XmEJBcPxQCbMp/1bhCZUrl5/u+72nL4sS+p/KDJPRK4J01lxFL2B+NlXDqUsKzEF6ewjFXjIHwqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8736.eurprd04.prod.outlook.com (2603:10a6:102:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:52:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:52:44 +0000
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
Subject: [PATCH v2 14/14] arm64: dts: imx95: Add NETC Timer support
Date: Wed, 16 Jul 2025 15:31:11 +0800
Message-Id: <20250716073111.367382-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: e148aed7-e7bc-48e3-a8fe-08ddc43dbf8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gx2BM+WtsCX1U+GzwD0AQrB8iB1UXvpqucNF8qHm122nzypn0HxTolpac0bh?=
 =?us-ascii?Q?SBWljv2Y6AhkoN9Zh57Ay7EeB/g75Vy82uFkEEyPJnOXORap4w548RyMqiFo?=
 =?us-ascii?Q?gcX+BbEICSNaOpM7IEIhIlWVfjg+ooOiEX/Jqg23iojHLmQzHVc7+p0+b3Xf?=
 =?us-ascii?Q?OhCKx6MGxlO3UoewZAnGv9JMZiCyESBswPJcaJTwqw46DKFgxYZ/L/7mldNp?=
 =?us-ascii?Q?RbijmK2P/MuaJvdyPHRuzWEWizdyHlnYpmSd8VNA9gXxg5rVXFPA414oF/FT?=
 =?us-ascii?Q?SP6StuT9yfiD/SwyCtJEzfzxbQ/0EQOXghszRvB0aA3pQqqk2Uaz5vtbLAoY?=
 =?us-ascii?Q?vJvdDdZiZ4rEwmJYtJgA3d47+J9QhpkUkWOLB6Aub9hs7Ys695kKXm2FfQfX?=
 =?us-ascii?Q?77yraf1ki03Noqx64YsbeNBgMMdmWZhT0In/O7Tfo9k9jZ/2p8E9vpLfT8Wy?=
 =?us-ascii?Q?ziJgUhIbxhlYUSvggACeJ20X9IODzQir7MFyGMijdcaKQy3EiNaJgpd7hlJt?=
 =?us-ascii?Q?k2l6WNQR60qSFVGCqyNB8USsxbu6HJVnORsfPHObnCmdrqI2SgT+jKf79CP8?=
 =?us-ascii?Q?RJPGQzvDCvJZhxvTZvkuCa35Ft0Wrr0+BoGgbSVe5IBm7QDThETdv25H+GHr?=
 =?us-ascii?Q?u/AbcRmeXZMkjBzWr7eR75/H4+h6JRHM8zhxDS/v8OpfiKxA27KKUxYhvucU?=
 =?us-ascii?Q?Ru3BSovvF0qA2jiI9BbK6IX8AGVjfJ1bxEflKLuRYd69JeiQ1ez7jNouwzQf?=
 =?us-ascii?Q?3BnwtI7bJiVjdsLk7sEG1TfIpsPFvp8vXwOBc32rO3joMPSm1DUKI5SUNXs/?=
 =?us-ascii?Q?WDDRr8je+cOW99zIDh3z5SQQe6EH59LKBeJY5XsFqao7PIBtSCl/0Xq3MiCa?=
 =?us-ascii?Q?Ww7V452W1AAVZCLrl7zQKwy/z4kCmSV9Ql+EQ2zx83I5ApEVpQNfRUf9sbQj?=
 =?us-ascii?Q?0dTO/ftC3lMmBhDSufs02hCOVmNjMvH2zq2OzlmzOkDNHNXdqp3M6ME/Wu8t?=
 =?us-ascii?Q?a1o0m6zp2mMJ++BPtrb8F+u/zrUa2f11rtno9bCsMR5V1G6IVJ2goNV9AxRp?=
 =?us-ascii?Q?8JdErYBcbdKg0AOsV2un8m+hK0r/0auv7NtChEMeLqAG2E7d+0bHcedYBEKo?=
 =?us-ascii?Q?J7aPiId1CkewEq+9HSMddRT4y2BPDrfyAo4TvFkLhGupGZglWAF6AqyAWDmZ?=
 =?us-ascii?Q?Y8AheM4S1hKhq36uBMdVabNc+7g++Yx1HOohhxPJDXwAP9ctuZ/Asw/VR/1e?=
 =?us-ascii?Q?5tMmORy5kcjIxwmX/avJSeKtE9ayq5xgUcyfgYEDDB8C3LitcxXS8yjD50yO?=
 =?us-ascii?Q?ceH1ctgTgj0P0IECCsGwfrnsueYZ5lp7HNOxS6ictmm/cQ8O9VQS4irTIrn/?=
 =?us-ascii?Q?4Y91dM8t5Hm09kDQDY53GvMmUYH7xa7+DOiMwnyi3WH/Ty+NB4eVZhA40FiG?=
 =?us-ascii?Q?2II65geHkhuba4miUTHDM+aV3X5R0cFIo57SIPuNYFYrqB/eExVm8Y2s0377?=
 =?us-ascii?Q?d7X7eZSEn5ik+a0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4A9517dC4Powuy4UrzM1gxi8DB0ffy28fZUgujiMdekAVQ+vg6dYx7K1QI5?=
 =?us-ascii?Q?Cv9AebHaQJBsT2d9cbdHRFSjyqIxU5ZJHa6BNUCTBID5DVeTH365Py1Xkp6N?=
 =?us-ascii?Q?ADOHOa8YSJvocgFD0JeD7JA9libP/qrVj6i78Wdzp/vJx7VnaT6la5PjHMYQ?=
 =?us-ascii?Q?8r2GpfkkIUNsFDKRjQ9F4PVZfs/X767TO5+0C58KzNmF52jv8RRQswIts2UZ?=
 =?us-ascii?Q?HwCwtq/m9ld1/xHFUANWlKqWiZIQmpZePjp0vWc/v7vMSjjXwWc4LIXMFyNA?=
 =?us-ascii?Q?TTkkiLi5110XjcjtxPciTauauucB12i5aG6GILjesk+b0n33znVwar1lbveH?=
 =?us-ascii?Q?PK6BSlgrlTF0hTELNmr+KZ8VvNR1Qdsjf1T8Fdp9BuT1Tk9ELerQ3KLzGw01?=
 =?us-ascii?Q?SeMzU3F16A7zkxdLtfAE3wTudZSecrFsMRAk6COvfPKWZyAI98KnSmqwlE67?=
 =?us-ascii?Q?L0ym4JZ80Aa1tG0mElynZGmfCrzB9UDesEgLqcoqtoS9VVJDliOS1zYidQvS?=
 =?us-ascii?Q?9uKMUFUzUGZ4NNeHnndcxZGfsVm4ibtnItQxVjJoooUAavKJpK6l4ce/Kcs+?=
 =?us-ascii?Q?Cz/DxDIv/2CsjfGoVIdlGJXqksJxXWXkxHFIWSj5NtNOMJUmg0MIe3x1JdMv?=
 =?us-ascii?Q?6nPJfWgjmWwsOqQg3Vz8PuHMiznThK8/vABmJKrZXZWgC5/ucmstpS73MbEP?=
 =?us-ascii?Q?JB/WEuhATQ1v3p5xYQnrFpTaASlc4iRdql+uqBxS2y44cFC2nbFQRip8FeP0?=
 =?us-ascii?Q?Nt45sGdHlCRfdfKFt9qJrqUJ9arcVnwTG5XI1V9mQ5mTDlezpQD8pJsihYQK?=
 =?us-ascii?Q?7OqTtqhVmrwUSH4Wfl/NR9chEwM+mTfq/yC5nQdyHt065K7H0XfnVzUGi8nd?=
 =?us-ascii?Q?jbo92z19GoLinLe4HSTgI434dwN+8eZHbBaNvNLfFHsu06sGym1mrrzsfKyu?=
 =?us-ascii?Q?Bc/5No0xE2hvgbkrhb0L5vaFXQSpmvPU0x910M7i/ti37LHWvnf+LAyrygQM?=
 =?us-ascii?Q?ba0gTkNzjTh9ZQJ4Smc6F2N20wvHGfUY67KZzGe1mVI0COjKHDgkcgRD4qgS?=
 =?us-ascii?Q?xFkGJj/wYKFwHTZJoweZyMNgnt1pB4jjoVcuosKO6a+eT7VxqrWfDMlmz59P?=
 =?us-ascii?Q?XaAnyu+9eL0HjmoBWfTUM2peiUEuR6Be8b5uv+kyZkjdbfgFpJogGK20ovNN?=
 =?us-ascii?Q?hDXJyH0PJA1z6FD8CTHG334OEWrZcD3w9arKOr5is/EEfA+vl2JK6O/XgzgG?=
 =?us-ascii?Q?RfHHgiBPKv+B7+v/0z8qQFcCP3fxUinW82/AAa3xDA0v0u6tAf7+XP4gj0vh?=
 =?us-ascii?Q?QfEGujoFXv8SAwF2+0sEtju9Pn7/zAmkOT+I/GYdeMN480C2qGjyJvJgbyW8?=
 =?us-ascii?Q?pPpqjVLm1hBCJ/1XSQd5iZmtpvxzSiREAoLYi8XE6CvxSXltBfcWt6eM8EyY?=
 =?us-ascii?Q?IaTVk+pWBPMAIFhbWDdk2SdYhtLjS4zC/RZqPujSrYlon67pLD0VCdepzQXL?=
 =?us-ascii?Q?Zm7kTDwMxwE6+J4HFB5Hpp0QkEBzVnE2JBQly5WmaOqCDvn6vg+/du8YW8LU?=
 =?us-ascii?Q?FJ+QiQ7RkppW5nZbZ5bnq4YIr/0PiiJMxEhxM+Aw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e148aed7-e7bc-48e3-a8fe-08ddc43dbf8f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:52:44.6422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAV0ANpVDFZppJ8QxcOJqaVQIusEgs1yHaGc+PFw8wdwQL3Bucy0+PqcNmNjWvZ7cjs3I4F6P+QcSqRSXVsUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8736

Enable NETC Timer to provide precise periodic pulse, time capture on
external pulse and PTP synchronization support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
new patch
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 4 ++++
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 6886ea766655..9a119d788c1e 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -418,6 +418,10 @@ ethphy0: ethernet-phy@1 {
 	};
 };
 
+&netc_timer {
+	status = "okay";
+};
+
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 632631a29112..04be9fb8cb31 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1893,6 +1893,7 @@ enetc_port2: ethernet@10,0 {
 				};
 
 				netc_timer: ethernet@18,0 {
+					compatible = "pci1131,ee02";
 					reg = <0x00c000 0 0 0 0>;
 					status = "disabled";
 				};
-- 
2.34.1


