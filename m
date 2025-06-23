Return-Path: <netdev+bounces-200203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A89AE3B95
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E40B3AE2AA
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93523C4F3;
	Mon, 23 Jun 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aj5ewtVg"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012024.outbound.protection.outlook.com [52.101.71.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FA239E73;
	Mon, 23 Jun 2025 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672851; cv=fail; b=a4TH5hruPRtKEpPmW7HGDSdaAWTN0U2AqUFin7katkQQeXVmC9TKoNyaRneR5NVTrk2EuuVB+O/Rl1aNaCu5pM30AIC/d3y9jXkV+XyTS+S7UdgHAeojwF2JPxDHVLSYEgkukkQu7jxEufKRhSC5mJkd3LrB/acJ1R/hPd1DeD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672851; c=relaxed/simple;
	bh=e8Wjr2j49MOI2rnVaXtcUKzeDDA57nfRWX5ausQdEtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QO4vWSQUkl+tYGR/B32u+kuSMIfi8Wgr2ipPevGcgNxd4rCQDb943ouuX/r6tK9SBvWzle0ODd5OdErnkrixOX5pDc6xAeOgAV3n+3Vz3SxxJ61whmHr3/XcoElR53V46umqJnbDnVU14sEoY84aq4jg1EL1mW26HMSVsl5Fo9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Aj5ewtVg; arc=fail smtp.client-ip=52.101.71.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DI5pCpMd5/o7Zkg5y6S/pBi+FM3s3i9lk5YOL0WPeFA/2ZI1iU3GH7xHyr396rT56R2/NIamMpkkODrzmsPPmmrkeDQi46sar7VMrf9q0Bce3BR5dYmr9XhuB4CWKjsTfmz26y5nt52w4tKwnMWYXYuzk69vrI4beLo+n9rDa2SsUCROr/WSwYlIOtuN/aGYPsbWmgzwA1a953QVeJVAvtCw4+QRKyLqk5BWROPNS8eHjWXvVfUXOy/bS3J1LPsH2q8FviFmOJ/Vg2Vv7X6RWTB37rChOYxVf4E0TaA7HcRq5+uro2W7za8mI9gYuh2Bn952n98HZAPNWkn1B3S94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqB4wUHixpCre8wzmEniBIBtzGuAS2riaOkSF5iFvtI=;
 b=SYpmuEil5WKVdoMZwOC9IvWr9Z+OaGeJYeKohARFD0RrlV3Brdh9W/X+Qd4E2taVPLTT2ewdrDEgxx/866WkinagKq0aZz9seitpu2GipFDOQ7u7jrW9+TVaaf5MlntzqVqxhthLhUDCMaxgCxGTSRmZcTdEW9JcjzQ7RxupdWtYc9OCo3VmEM2xol9TRMcKiH7pGb/f8rhRK/ye3zDhtuWC3sdT+FI66r/7Q2EMQBtMlom6En36spkG7csdBNIAcSm+cHYGCIvqlTfELGv4Y+6jxfpP7lrbONdKT4QyjXko7hWwg8SIj5HPfCfm19/U8XAWRdJ84OlLVVjnAzrKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqB4wUHixpCre8wzmEniBIBtzGuAS2riaOkSF5iFvtI=;
 b=Aj5ewtVgl/F1aoSq75hmXJy9C941c6ihfXEe+MjOMrK1H1ZBdqBKDDVGHf/vG7+Due7YvgGtpj+zM81eTr52QXFNZAnw2P38RpQ4I/oiHq4YmsXMV6z9fhHun7OioKc4ksz+am5/jt++3alFUYleWsPTvwuGhR/fPZsHcWz5Z5rPO/BI5N4BRB71JcmQuxP4gaXUsIdeQvIE3ZjuYr9Opg+xdKcdp1cjFXxX+GiTJs4FYejs8DKpn1Hxj5c6IoiD8/Ci7Tb6lL744O3/CVswDeDhGKNMfFFRYn1GF+kPRV/mAHWpdXEY5O+EnNnVqyliqYQOTkVJYDqFE0usqNU87w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:00:40 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:00:40 +0000
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
Subject: [PATCH v6 7/9] arm64: defconfig: enable i.MX91 pinctrl
Date: Mon, 23 Jun 2025 17:57:30 +0800
Message-Id: <20250623095732.2139853-8-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 191c10bf-869d-45a2-f435-08ddb23ccf0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GPn/Pwk6h8dI/qqu53m8xDHFklhAgykKgb2vHfM801JGkEhdhHbhOcNKRICI?=
 =?us-ascii?Q?A86t1LrrojMKTMLYNlLK9LX/UvcwukD6KTVN2FGzxXVpB4UWwGWlcdINBwHA?=
 =?us-ascii?Q?HfqgiEc7ozFpYXBOaLn3evL707jbzaKZcRphXLBTqPzpkbsE1C9aPwR1HpSa?=
 =?us-ascii?Q?OuWgfgWoh9Jg50jFEw9JuNGwpuqCcQFsyje4laM21KeH4ng2lfgohC8tIq89?=
 =?us-ascii?Q?VL2BiHNL014ubLBKOwDtWrEHHU+uJhBNUUcxPwrYoEnZTW/V13sqg8rA4i3b?=
 =?us-ascii?Q?Ju/egKFF1KPPu3qqAK/bbVpjUEyKbEapxAEBtnzcXhjRWThYNyMvYURHspjf?=
 =?us-ascii?Q?jfT0kTtdAdy5Vr4pTsJ/EbLtEx94a/tPMNLP0TjvLAdinHRY5w0goKF0NW58?=
 =?us-ascii?Q?Z22RmN3tzGzTxYd10lTsy/D0uytka11WALrOxj6J5xCLf1c2h27JfS9tjsb5?=
 =?us-ascii?Q?RXHMRalFjm+aSfr4hsBQi2lASgfyWNY44OqXKK5DdytTkVNzCHw0UD+hLtjK?=
 =?us-ascii?Q?5jRo3RxlBRxuLOr/gyzdL5Bk0/c6H7zv4B8ixo9bs6MBkG2ON/BxFiL4Wsgf?=
 =?us-ascii?Q?VWih9IjjK9B72iyF96x6n9Pijx6vQdl5rz56uJ8SJXZqHqk47R15exFv9Zvz?=
 =?us-ascii?Q?N8ixJ3RD3uS5VTxs0CgnFKGcOJbNMUCvSRSMVNbN7es4riADTZBnQ3mUDMzd?=
 =?us-ascii?Q?w+c0MDNq1Qnk+qRrpa04p9ccVnZ9ijhVX898Zg6gj+axpznNM8Mcsu2LRCw1?=
 =?us-ascii?Q?Pghp/abQjy8GCq+T3w/ni8Jzk5dyINe5iuPHx6scPzP0C9Sra6HAl9/E7+rQ?=
 =?us-ascii?Q?S8LFl1ksQYSotXbdlbpcAthxVZV6I6mp+sjvMjL4qjmNP9sS62TcZ8CUG+62?=
 =?us-ascii?Q?wZPbm80MZLJ2qhiP+fGVPR98iCRiyKXpksRiD8beeLM5ZkotOmh76Nn2PSdv?=
 =?us-ascii?Q?OFJbCGear+KnIo9NbkB2hfJbGLnwIT+uNIKvwxALEyZg5p0JPnuERN4yjJp2?=
 =?us-ascii?Q?X/584EOgiiq3TnyTM3u9pEa/l70HKrNoBuK8Kgb6VGXRmdYQLqoJSjv+GfPg?=
 =?us-ascii?Q?uzLWhFGM/awGUG3Gy69uFLiTez6opO51IpUCSSzwO3nPq5LkGdOBUZpJYkYl?=
 =?us-ascii?Q?pjRxlxW6uwZjgrQVoAJFFv1sz1bdm/ipsus2Jaa3npal57jnRaPidyd1YRdK?=
 =?us-ascii?Q?aiMQnVddvykAAO4U33cWtFreUTVPhbqtZ3eGLV9kVIGvaTyjJUFvhkVZ4f9G?=
 =?us-ascii?Q?HOKIJQq9PHdqcQ7g+xLL6USMCVcETzB7VES+aOpE3sZKhfrWcRdl+aWGEwMs?=
 =?us-ascii?Q?0FfKlwXsU1tylOOzMQzcW4sn/r9wqy+LtXXVyd/G2lNvwi+C+Vl93OQjdxcz?=
 =?us-ascii?Q?n0bjnM79xOPa+JxeumupHOafhG0noyQI6/MGmQ3WbQXMQdS/yW1FZ64fmiSk?=
 =?us-ascii?Q?TS+e2qojnBb6UH50Qe6Biww2UJsBcj+kdY6uylcM4RcCyoyyJmrEgyfVBOB8?=
 =?us-ascii?Q?AkbXghBEXvP/u9k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnD5tZBDbIEmsS7k428pLHTZnjWyfi99VzVn4gXn/Ox6DKLuDtOfskLCP/XV?=
 =?us-ascii?Q?1OIoh/IO2kRcx4sZqcxnDop9VVmq6sac7OHa5xjlrUowSW3aAPphumYcZP/i?=
 =?us-ascii?Q?K8le1KPPdsCja3ffGZLxXEHN8XwSRaqT/R8xU/ui+VOn0GzgxEApktFdZzDB?=
 =?us-ascii?Q?GiCHMEuGXH293UuFlShhdDCihwoBRIvNACc1BaJIgcbvPQRrrydyEw+lEQxd?=
 =?us-ascii?Q?a3MnzjrFhymdt6eniY1gxpdm6LfJF6ploj+0JUIiBOgpCikOSqy7FhhKeU35?=
 =?us-ascii?Q?P3hZOp5rhhy/Pt4IVUeWBxcY5LK8Qk+hxqbpj/uRIi/OMhYjwWmee0C2wX/n?=
 =?us-ascii?Q?U/Z3Sqvxs88gp6OQGhX9559GrI7mbqRchleI1ftqEwsfQKesQTbLz9ewGxE5?=
 =?us-ascii?Q?6pa9h01LXsZMcqHaP3enG89Wsved0K1plpnYLSaN4Gyeac6lcdMMCHikZi5K?=
 =?us-ascii?Q?8/tBliczTVh1L1gU/obt1uMUj8OnZFs6TdLWOUfheIk+VXFQPbfE5ujWR94I?=
 =?us-ascii?Q?DY90fa73JuYr2XcM7gGqN9vgkmDSC6v80dcAv6Y7KWDT+g8hBvlY8GZpptNm?=
 =?us-ascii?Q?oH35Fk/1h5BV7/XHsqGbzF91QzozlYG/5Ih40wRCmMxq08xnxB9aADDybLvt?=
 =?us-ascii?Q?bR+QgzhbKo2yAXl6ZHbWRFGntfDqoLoHmt36RxI1k826hHO/D15wTD4L5mTO?=
 =?us-ascii?Q?ul+KIk3oH/qwtc1JDKQA147mVljdj/ULnnUlAqFqrZOwzGr90GKlJFdYHmGa?=
 =?us-ascii?Q?HYs6+gQRlxL7mZXOQrK6bAzJk/Kb0LaIreDZE/yD2L/xln9F6C+IKiVKMu/m?=
 =?us-ascii?Q?zvl+Q/z9vLNdWCnoUjoxpQkvkkk6De3EeiFby5XfzmtgdVGgIxaPeaM/AzEw?=
 =?us-ascii?Q?IuBv5li7sw8r/Ib1pQ8Mv4yDgniCrGU2u/wCpAwSjkQbPN09m2/IL3KLFnTD?=
 =?us-ascii?Q?qlO2C7l53/P/Ni42GaonKvpQqAIz+ojL1EXHyYH1ZvCoHxtBzJeOinHe8IX4?=
 =?us-ascii?Q?1vgkWaiMgDCTbaacn3knAr4iNNCxSvxKbsC1ULu3Kc2BK3M13A8EualfsSg+?=
 =?us-ascii?Q?0+u+Hq2J9i8YITvAi7cT3WSrcpJ6rUo8KkjCvL9tjWsslXDgrAg0nQ49DsPj?=
 =?us-ascii?Q?GfWYHIKXB/Vvc4FimfnhIgWv+0PePSuU8AY3yMSUgK+ZlegV1fUlAonOsTs+?=
 =?us-ascii?Q?6/FvlYZ+zGvaEDe0FJXbjfNzflTbbLh79MxOTGAX0lhviJp+0rgNBlb1Ji54?=
 =?us-ascii?Q?uWSKX86wEjtRpDtJgxNbET6/bDlmjB/BTowDNRQ/TQ+S5QU0Df8Pu6DZhySC?=
 =?us-ascii?Q?RVv6lzPyf1BwI+ZxBfhn+KHFCxhwxLRIDk5ZuBiFaBuw54Mz5GWLUY2vN8A2?=
 =?us-ascii?Q?EDEFZWzmIpQRAxZjhCGF0MOfm/QeinetnKRcu2XnKaswzWy0HlOUZFpbEkHb?=
 =?us-ascii?Q?Oh+/B7/sXgldHA+re3UjIYISSAOx9Hg2YK9hmvBQXifnVIkiCe5Y3ludcu7n?=
 =?us-ascii?Q?GWAZiH+Ib5R7JfAEVUFEBsIg/KWsVfpbApzvdtX0PAzkK/fofXsGXS+MC6Iu?=
 =?us-ascii?Q?vh4WjrftRw6ZBv1yahnlq+o3CmpDrs4RqrOVz1od?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191c10bf-869d-45a2-f435-08ddb23ccf0e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:00:40.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFcygXzVZXMcXtFkLdSuG2mGp0MZsM+eUjqgj0XGNePnyVFZUERhn3lqnLWJProI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Enable i.MX91 pinctrl driver for booting the system.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1052af7c9860..2ae60f66ceb3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -602,6 +602,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX91=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ5018=y
-- 
2.37.1


