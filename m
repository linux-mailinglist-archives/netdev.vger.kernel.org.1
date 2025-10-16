Return-Path: <netdev+bounces-230006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2021EBE2E8F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2950837D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4C3314B3;
	Thu, 16 Oct 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XvBrAX3w"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B93314A1;
	Thu, 16 Oct 2025 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611418; cv=fail; b=cyVSavKShka6UdkREyLcAXKYZUyokzQYjwfpwZ7FwdzmP+gMHLQdFU/pj79eSJbplMZNRhlKtUWS/r/uIQDqDcx/pr94uk32aNh1/jLxwMjceqZiZBIq1++m8A08PYSoM5Xp1EbxdFBALePN+Fl2PdncJ1UCkkciOE1vFMeZfzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611418; c=relaxed/simple;
	bh=92dmqAY44VpNMWWeRWsRepxZkWZRDtLdWIuUR9GNHHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBK2Y0DqYfQMviXMomKju9ZIq/UZvvzWq+rjhBhXzrPt+HXsZtphRMOF9dtbT0do6tcQVrOt01P44T3EQq87EN91AGlMJiVHxoEavwslTO+3uj/RQKi/V8kgO+gKm/0hbAKm+0EZKMimOnKjFlv4tU41/fkYyku/iz7JHvGnArw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XvBrAX3w; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUqCu3m9BKAiwMhv9yANXcMJMuhngbVjNodACuiwi4/c5Irwey1qjdT0L0jib7H43KzVeTy2L1pCKUcftjTC22KtqW1or0KnOsK5nspDGMeUxK1PHJARrg1vWouL/fRgXKnSvdp5IY7gobCEzy5VTqv0rNFEjxWyzu2G6MhAi5bRJJhJ6gJN4pHo0G47jMb6iahsOo6wzcVGvuDRfLVohaUKKgKKV6wtERLh8GWJWe7NFfW8HPnO+/X9dB8cK5NqKoXXsG3YoWB7n5ONnRB76LmKbArV4HlJBaaoPvLRu2i+mWgk9FTVVn5S6ZmLLKV1L1eiLmeM6kHNon1ygh4TAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaHmohhqSF4ekkaWtnwCa+u1MwgU1GGDT1UNVgDD+jQ=;
 b=K/SyKwMAovy9W2Qxucbx2l93WBYr4resTS6rVthXm089mI5FOcDn4IyWw5/v2wWg27Zt2ebLwvfeMIkxdrdvgu1qBWlXdvOJnLulJgc9JiHKUf7uHRC+TOzCao7YfRjjVphFRVWXiaX/6kJJ9H4b6LBOVBNEXwS0NCfeNvpRz28VjaW3mGiCV3r5/LBVcs02+JSIMFY2PZbvukvIyjMs0ohmPRnU41fa6W6PzPUiDGLF0tt7ESZL/qs0zTN9Nf9tGFDXKjjXKgzDXF9wytVCzaeqUbi9yZXoxPwVM7Dj5eoGIx+mH2li5PuEC8NoWMKk1QxogyrR+BZXF0JxOPCQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaHmohhqSF4ekkaWtnwCa+u1MwgU1GGDT1UNVgDD+jQ=;
 b=XvBrAX3wRf1tIuqgVQcClbiwh0+NCayVDswQIAC+zCCSIJKYOGD9588w9HUdyrOaelBMJSKOhD4N8RUcIZpVA/JI3n2cmDUT0YcffWikA2wgVexagQJOUl3pVuzU3WIgLYwLHLfZ/SoW2RNmMS8PqvwHRMSszv6sq+r6qMYWMxB70TL0KirJUVv+2q6OzOFP5lrgoLfxLKwEc11KA4MR/P9K7vzILJli0DMxzGC8+BiFLh8fdqx5uRR4wXONbdXxkCYIAkQr1hdrxMVaQ2V0WS0bxDAeenB+zRWnMuslmL976xGrMhDooygeRF9t+0YiiasIqZPAe+3iMDJGtyEdcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:43:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:43:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: imx94: add basic NETC nodes and properties
Date: Thu, 16 Oct 2025 18:20:19 +0800
Message-Id: <20251016102020.3218579-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: c4304c9d-8069-430e-74c7-08de0ca0d9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p8ZJyvsopgcZ+aKQQrCdbutrpvuDHXvvZg4mpDJufY2KwuLYC027CsjxhsQ9?=
 =?us-ascii?Q?ZIFQVCr/176kAYuRaEesriQP49QLrbGePABQzxRSR/Gxs58opBkdaPWNNO3+?=
 =?us-ascii?Q?pd6x8lhQq0VXdKoYvPOyl00vNSf4hgrd0Mus7f0vS5DHbXEMlCg/qlW9N9CB?=
 =?us-ascii?Q?awdSJyDNx1z1zwqyJPwC8J2QNvaAvnAXYQqAiKMvNt8D6S8gls8QwARm0p9n?=
 =?us-ascii?Q?sFY3qoC/1XxkUXQVtoi/e9LuSv8/nDhfp2ZWtRZ2zlwx3204WuL4F2Q9/+5t?=
 =?us-ascii?Q?3MT+UOpR4Jq9TiyTu9V3AaNHQUpsuCwEYvjzR0yVJEaPc70r3UFAXEqC9Tf1?=
 =?us-ascii?Q?Nq7GlS63MmDOTnWTNJds0C9j0wYemjp+qvIx4EG24CqQHe3Vt7L4+wlDO5It?=
 =?us-ascii?Q?8F9ybCyyVxsfs0+iV1pZejKQF4ua74/qKPkFJs263B4KbdCXoq4NTsPIqPD6?=
 =?us-ascii?Q?BJHellF1tiuNBYohoeEJckzLA8AWqMIyAdtlR5jhM5pVH6djZgsBACEqRq6q?=
 =?us-ascii?Q?v2gQJrsO0sduy9z0kZ8EpZ1+tgMfcmoxp5u05E+Ym94I74OSsKJRLe3fa7Gl?=
 =?us-ascii?Q?J/krYKhNK4VGUHmt3zTiWIf3gOD6AYHxY4cuJc0kq3NkjWMEwsQ3Vpx391QG?=
 =?us-ascii?Q?KKKjbdBqm3syk7eFAeOtENW6AGUm1QW83ZuI1zqkA6HRstkj38V40MuYDkmD?=
 =?us-ascii?Q?spl8B4cS9s5XjvE3a++uYotqyNmRgu+G0+Sk30JGZMVJY3BHqKzrIbICmvZw?=
 =?us-ascii?Q?pypHANK7yV2lbJvu+WjWs2fK8lJ2g8RwIIlZ5tBw0q1TOQMV6OghGOBDDrCJ?=
 =?us-ascii?Q?M1r46rkzxsLzUOJITxsYT5ecc7d8SvTyo2KlorXTA558UEdIUH/xsVITzaVI?=
 =?us-ascii?Q?Y+lacB4W2/k9UxY0oF8/jmIlk++o5SfM8Ay7+e70/y3JyK5FwD1nadpnAoEC?=
 =?us-ascii?Q?kMybO45I+elukVuoHNT5GEh5RrwZQbHwget0vixXYowKvTw5cDZC8knyGff5?=
 =?us-ascii?Q?MENAk0lWjV4RMu3+dmq2b5IMOxEmV6BHKaXaCW5h+AE9u/b3PhwHHaXhNZ6M?=
 =?us-ascii?Q?UjSbfv3zr57Zl4IaXtES3gDxV2GLMQI4nAflrf/baM+U8AieQtCmFfgDk9hf?=
 =?us-ascii?Q?bM1pCtInHJvDjbhn4xV1isVpjDLEb9W0K+Gi+InCbUB7AUflSnEL6ulTkHrr?=
 =?us-ascii?Q?3VvzLDIC5hXpg5bNpi6EnspPzsD5tiWcfLQpLQkEZY24WqtS5w0m+1R+WGxo?=
 =?us-ascii?Q?IvFwuJgvTjWTQK+nPUfjHQaY2HS5OHUlZYwtmA5yPaP29daWKumF1o8Y/U4K?=
 =?us-ascii?Q?L1naOB5jJS6JptPF+sOQ346D2/gfG8jrsxcTmG096GKTwwgng4SVfsy2Mlx2?=
 =?us-ascii?Q?u8tx7MvlSMuHLc13NO6UiLxD8JQkug9XkkregHTYnWBkH0Vg3xccpiY+5yHQ?=
 =?us-ascii?Q?tr4++P/E5aAJSR7R+KQs2wU4xzp01oSvqIcLvbq7u+LI9G8StIxAVqGSkJSQ?=
 =?us-ascii?Q?zpEL90esfvo/tDNE/rM0qkuEXtW5GEz+Ey6FLSLsPrphH/db6CtrmTUsnQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tX48YiD5oFop11sKzZavPHQnBlQn8yovL4o6tbKeDHwBL68TJbiFPD2ARSrf?=
 =?us-ascii?Q?zIwDzl2mC6rHWH09ezPRKtWW+PnAX0aZ+kHZeOphCCPNyr0gUd3wkBDAnh9F?=
 =?us-ascii?Q?B6AcxfpjpaTy7oPDDrlc2kaEfhv+17bCv+CLw7SuaADAJaKdaS9QdQZr3dte?=
 =?us-ascii?Q?1o6WJH1KyS/A9JSXp9UNO3aj6+MSn5b/hj0fgvpOABooGh2DKhZ4/o4v8nx4?=
 =?us-ascii?Q?FyzwU0E1MVJ80cFSADVAhn87vvuJNJxcLStirpW/VOWZuqnK4bsQyS8JThrv?=
 =?us-ascii?Q?NVAPVNO4LGhROUu6UHtwEL7XD39RTrNeCEKgA3oyqT3Df1PHjn73su+Z7Pjl?=
 =?us-ascii?Q?SNV7jMWmtIx5g63wHEWQKGAtLaDUYTfOGRIca/OiFAI1mXyz55yiIxbS837d?=
 =?us-ascii?Q?sfOr7fCADqNMkA5DMqMYYT83Pnh0xy2bb2qAw5NKn5Fv6Mi4Yyk//V5zXVTR?=
 =?us-ascii?Q?dY4DhDeIwplxfLAN7jZezFYQVfJpML2jNSB6tl+l7acmF+wsLMFa+q9c+yn6?=
 =?us-ascii?Q?MziUd0sKlR48n4JmOaj+UkK5HMxHLJ4fZCx1VVZTYymwEDUFiEPZmvXfRhyO?=
 =?us-ascii?Q?tQuLYP74Tbcis9GK3Aw8DaD5t4J+ZhnSI/D205MMGT/3/IGFPWjiWtZ8lq7o?=
 =?us-ascii?Q?1uMxVq52r9TAvnnmQl0z+N5HvfJN/OA3tRF0JyoWYTzliQHKe7mPxWRTKOOL?=
 =?us-ascii?Q?tu53myo26eq8j/LSfjthjN4Ubr2lNNPX4gaJX5D0vofWt4sePaKvGmCi3Yaa?=
 =?us-ascii?Q?TNACbQ56eKqQUc3yDg1mZt6Qs5PWThwZFxxo6zx7OH3ckR5WzfzkZz2Erwtg?=
 =?us-ascii?Q?2aCQrC0a1X3yEoaeMDrmj0I5TrfoK82QEeaXxQA1FJd59ABGd5u657/Y+GP3?=
 =?us-ascii?Q?B1wBgDvoO+cSAl73VI+un2SjtZWO4SJGP53wucshmUZY9DiVJSpDUQyGkoxy?=
 =?us-ascii?Q?r3ckEJr9C56dwdANtTC1OD0DFuh4//aQhDJ+BWQluwGMd98uSm+kxs62xSZC?=
 =?us-ascii?Q?pXeUBesWrqsJrJWtpAGhPIbZW7DVd0PcjjQsjX1rCbqssKoIi0bMwwQRZj/R?=
 =?us-ascii?Q?MptnvcYED3Htry0eFbi4lz1zJKCaGuWLUbdY0PM1WY2OfHkMoI3zLL6HkNcr?=
 =?us-ascii?Q?GSLFv/Y/Ee55EHkqarE4IpoBtnRibkqcvV234hKd5wJtqDp3kH/bCtwMtbfS?=
 =?us-ascii?Q?Z0Mu6PGwGwNEY5lxo5ftdLiki+OMNev1ypbvhejdA9TuV6kKQvw9ubTBIZKi?=
 =?us-ascii?Q?bMUqvPuG9ViElMmT6+yJ8WgvEdRAEgsWSu2aK9x7VvBm9UJqNPpT1+Pa1FEY?=
 =?us-ascii?Q?8P1UENPcRwghpNbyshB+oXzDKg/pIZLI2k8BJRxp1VplK7noA7m7ZfDnCziq?=
 =?us-ascii?Q?n1N117S4/hLYev1J5hPYp0jI9V53kbc7WrTj1hwa6C79+J0nVxPXiTiZPEfx?=
 =?us-ascii?Q?778LYLYA1wemr+ge+wFX2KYkhG74OU0rzqqjO3KSSjgzySYe5HNsPxGxW4eh?=
 =?us-ascii?Q?clb6uyGeybfeHYXo4ql7QtYsr5GBOers69f3KImbJDcBEICo/hx3XAHBWUti?=
 =?us-ascii?Q?bAPe47tZ0lSRwro5oeoyVoXYeRH9NoVUsFTEH7Jr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4304c9d-8069-430e-74c7-08de0ca0d9f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:43:32.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8+OE+KglIFcOd4h+P/WDfwJlzdLKH5uGCYVK8/u2cTAnuv8TtBU4IY3NERhCEfjflmgCL/Z2l5rRfkHCdbeVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

Add ENETC, EMDIO and Timer support.

Note that this patch is for reference only. It will be removed once the
related dt-bindings patches have been reviewed.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi     | 118 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 100 ++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index d4a880496b0e..0527046601e5 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -1190,5 +1190,123 @@ wdog3: watchdog@49220000 {
 				status = "disabled";
 			};
 		};
+
+		netc_blk_ctrl: system-controller@4ceb0000 {
+			compatible = "nxp,imx94-netc-blk-ctrl";
+			reg = <0x0 0x4ceb0000 0x0 0x10000>,
+			      <0x0 0x4cec0000 0x0 0x10000>,
+			      <0x0 0x4c810000 0x0 0x7C>;
+			reg-names = "ierb", "prb", "netcmix";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			power-domains = <&scmi_devpd IMX94_PD_NETC>;
+			status = "disabled";
+
+			netc_bus0: pcie@4ca00000 {
+				compatible = "pci-host-ecam-generic";
+				reg = <0x0 0x4ca00000 0x0 0x100000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				linux,pci-domain = <0>;
+				bus-range = <0x0 0x0>;
+				msi-map = <0x00 &its 0x68 0x1>, //ENETC3 PF
+					  <0x01 &its 0x61 0x1>, //Timer0
+					  <0x02 &its 0x64 0x1>, //Switch
+					  <0x40 &its 0x69 0x1>, //ENETC3 VF0
+					  <0x80 &its 0x6a 0x1>, //ENETC3 VF1
+					  <0xC0 &its 0x6b 0x1>; //ENETC3 VF2
+					 /* Switch BAR0 - non-prefetchable memory */
+				ranges = <0x02000000 0x0 0x4cc00000  0x0 0x4cc00000  0x0 0x80000
+					 /* ENETC 3 and Timer 0 BAR0 - non-prefetchable memory */
+					 0x02000000 0x0 0x4cd40000  0x0 0x4cd40000  0x0 0x60000
+					 /* Switch and Timer 0 BAR2 - prefetchable memory */
+					 0x42000000 0x0 0x4ce00000  0x0 0x4ce00000  0x0 0x20000
+					 /* ENETC 3 VF0-2 BAR0 - non-prefetchable memory */
+					 0x02000000 0x0 0x4ce50000  0x0 0x4ce50000  0x0 0x30000
+					 /* ENETC 3 VF0-2 BAR2 - prefetchable memory */
+					 0x42000000 0x0 0x4ce80000  0x0 0x4ce80000  0x0 0x30000>;
+
+				enetc3: ethernet@0,0 {
+					compatible = "pci1131,e110";
+					reg = <0x0 0 0 0 0>;
+					phy-mode = "internal";
+					status = "disabled";
+
+					fixed-link {
+						speed = <2680>;
+						full-duplex;
+						pause;
+					};
+				};
+
+				netc_timer0: ptp-timer@0,1 {
+					compatible = "pci1131,ee02";
+					reg = <0x100 0 0 0 0>;
+					status = "disabled";
+				};
+			};
+
+			netc_bus1: pcie@4cb00000 {
+				compatible = "pci-host-ecam-generic";
+				reg = <0x0 0x4cb00000 0x0 0x100000>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				linux,pci-domain = <1>;
+				bus-range = <0x1 0x1>;
+				msi-map = <0x100 &its 0x65 0x1>, //ENETC0 PF
+					  <0x101 &its 0x62 0x1>, //Timer1
+					  <0x140 &its 0x66 0x1>, //ENETC1 PF
+					  <0x180 &its 0x67 0x1>, //ENETC2 PF
+					  <0x181 &its 0x63 0x1>, //Timer2
+					  <0x1C0 &its 0x60 0x1>; //EMDIO
+					 /* ENETC 0-2 BAR0 - non-prefetchable memory */
+				ranges = <0x02000000 0x0 0x4cC80000  0x0 0x4cc80000  0x0 0xc0000
+					 /* Timer 1-2 and EMDIO BAR0 - non-prefetchable memory */
+					 0x02000000 0x0 0x4cda0000  0x0 0x4cda0000  0x0 0x60000
+					 /* Timer 1-2 and EMDIO BAR2 - prefetchable memory */
+					 0x42000000 0x0 0x4ce20000  0x0 0x4ce20000  0x0 0x30000>;
+
+				enetc0: ethernet@0,0 {
+					compatible = "pci1131,e101";
+					reg = <0x10000 0 0 0 0>;
+					status = "disabled";
+				};
+
+				netc_timer1: ptp-timer@0,1 {
+					compatible = "pci1131,ee02";
+					reg = <0x10100 0 0 0 0>;
+					status = "disabled";
+				};
+
+				enetc1: ethernet@8,0 {
+					compatible = "pci1131,e101";
+					reg = <0x14000 0 0 0 0>;
+					status = "disabled";
+				};
+
+				enetc2: ethernet@10,0 {
+					compatible = "pci1131,e101";
+					reg = <0x18000 0 0 0 0>;
+					status = "disabled";
+				};
+
+				netc_timer2: ptp-timer@10,1 {
+					compatible = "pci1131,ee02";
+					reg = <0x18100 0 0 0 0>;
+					status = "disabled";
+				};
+
+				netc_emdio: mdio@18,0 {
+					compatible = "pci1131,ee00";
+					reg = <0x1c000 0 0 0 0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
index c8c3eff9df1a..91c579ef31fe 100644
--- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
@@ -12,6 +12,9 @@ / {
 	model = "NXP i.MX943 EVK board";
 
 	aliases {
+		ethernet0 = &enetc3;
+		ethernet1 = &enetc1;
+		ethernet2 = &enetc2;
 		i2c2 = &lpi2c3;
 		i2c3 = &lpi2c4;
 		i2c5 = &lpi2c6;
@@ -127,6 +130,30 @@ memory@80000000 {
 	};
 };
 
+&enetc1 {
+	clocks = <&scmi_clk IMX94_CLK_MAC4>;
+	clock-names = "ref";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth3>;
+	phy-handle = <&ethphy3>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enetc2 {
+	clocks = <&scmi_clk IMX94_CLK_MAC5>;
+	clock-names = "ref";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth4>;
+	phy-handle = <&ethphy4>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enetc3 {
+	status = "okay";
+};
+
 &lpi2c3 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&pinctrl_lpi2c3>;
@@ -396,6 +423,39 @@ &micfil {
 	status = "okay";
 };
 
+&netc_blk_ctrl {
+	assigned-clocks = <&scmi_clk IMX94_CLK_MAC4>,
+			  <&scmi_clk IMX94_CLK_MAC5>;
+	assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>;
+	assigned-clock-rates = <250000000>, <250000000>;
+	status = "okay";
+};
+
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+	status = "okay";
+
+	ethphy3: ethernet-phy@6 {
+		reg = <0x6>;
+		realtek,clkout-disable;
+	};
+
+	ethphy4: ethernet-phy@7 {
+		reg = <0x7>;
+		realtek,clkout-disable;
+	};
+};
+
+&netc_timer0 {
+	status = "okay";
+};
+
+&netc_timer1 {
+	status = "okay";
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX94_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX94_CLK_AUDIOPLL2_VCO>,
@@ -431,6 +491,46 @@ &sai3 {
 };
 
 &scmi_iomuxc {
+	pinctrl_emdio: emdiogrp{
+		fsl,pins = <
+			IMX94_PAD_ETH4_MDC_GPIO1__NETC_EMDC		0x57e
+			IMX94_PAD_ETH4_MDIO_GPIO2__NETC_EMDIO		0x97e
+		>;
+	};
+
+	pinctrl_eth3: eth3grp {
+		fsl,pins = <
+			IMX94_PAD_ETH3_TXD3__NETC_PINMUX_ETH3_TXD3		0x51e
+			IMX94_PAD_ETH3_TXD2__NETC_PINMUX_ETH3_TXD2		0x51e
+			IMX94_PAD_ETH3_TXD1__NETC_PINMUX_ETH3_TXD1		0x51e
+			IMX94_PAD_ETH3_TXD0__NETC_PINMUX_ETH3_TXD0		0x51e
+			IMX94_PAD_ETH3_TX_CTL__NETC_PINMUX_ETH3_TX_CTL		0x51e
+			IMX94_PAD_ETH3_TX_CLK__NETC_PINMUX_ETH3_TX_CLK		0x59e
+			IMX94_PAD_ETH3_RX_CTL__NETC_PINMUX_ETH3_RX_CTL		0x51e
+			IMX94_PAD_ETH3_RX_CLK__NETC_PINMUX_ETH3_RX_CLK		0x59e
+			IMX94_PAD_ETH3_RXD0__NETC_PINMUX_ETH3_RXD0		0x51e
+			IMX94_PAD_ETH3_RXD1__NETC_PINMUX_ETH3_RXD1		0x51e
+			IMX94_PAD_ETH3_RXD2__NETC_PINMUX_ETH3_RXD2		0x51e
+			IMX94_PAD_ETH3_RXD3__NETC_PINMUX_ETH3_RXD3		0x51e
+		>;
+	};
+
+	pinctrl_eth4: eth4grp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_TXD3__NETC_PINMUX_ETH4_TXD3		0x51e
+			IMX94_PAD_ETH4_TXD2__NETC_PINMUX_ETH4_TXD2		0x51e
+			IMX94_PAD_ETH4_TXD1__NETC_PINMUX_ETH4_TXD1		0x51e
+			IMX94_PAD_ETH4_TXD0__NETC_PINMUX_ETH4_TXD0		0x51e
+			IMX94_PAD_ETH4_TX_CTL__NETC_PINMUX_ETH4_TX_CTL		0x51e
+			IMX94_PAD_ETH4_TX_CLK__NETC_PINMUX_ETH4_TX_CLK		0x59e
+			IMX94_PAD_ETH4_RX_CTL__NETC_PINMUX_ETH4_RX_CTL		0x51e
+			IMX94_PAD_ETH4_RX_CLK__NETC_PINMUX_ETH4_RX_CLK		0x59e
+			IMX94_PAD_ETH4_RXD0__NETC_PINMUX_ETH4_RXD0		0x51e
+			IMX94_PAD_ETH4_RXD1__NETC_PINMUX_ETH4_RXD1		0x51e
+			IMX94_PAD_ETH4_RXD2__NETC_PINMUX_ETH4_RXD2		0x51e
+			IMX94_PAD_ETH4_RXD3__NETC_PINMUX_ETH4_RXD3		0x51e
+		>;
+	};
 
 	pinctrl_ioexpander_int2: ioexpanderint2grp {
 		fsl,pins = <
-- 
2.34.1


