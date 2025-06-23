Return-Path: <netdev+bounces-200205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B908AE3B97
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F541898262
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B423CEE5;
	Mon, 23 Jun 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KP4aeoPe"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012040.outbound.protection.outlook.com [52.101.71.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5623C8AA;
	Mon, 23 Jun 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672863; cv=fail; b=BDsFO18cQWRIPmdPDxqeZHvY0FrDyXYPewAcZL4+VjWCgyAUycNT7qS9DV8iKGHF77pVoXmP6K70wPZ2opwFRSVqySPQD4Dpikl/SJU9LYJvTwPoEZxJzcgNkVA5zQ7fj35suc2iiEc0XICpzpUS8eKE8GeyT6iWMvT7VXhG54E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672863; c=relaxed/simple;
	bh=CAF9o6KR8IL6dizjhFyRQiVLcyMX9ncxjaTJ1aybzFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R72DqkzmPnEmgo7e37AWRbSVbGep58pPdbaXWvIdqnZTUQrlz8TiJdohgAPVza4TLdjHY7DcESyc0mQdii6t2OjeX3O/qD5LJNOYAxEi3gr/EFOQP7QYaMk2oHW53MV28QxR+OlBp/0OrzF3yFftAS4/6uG6TJsH5IPu8xNdDFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KP4aeoPe; arc=fail smtp.client-ip=52.101.71.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfZtT7BGQCZVktIFgNywjA95ZpGfHkmpqFVOAXwmLcoSC8cQGd+7VcJ2SW7OlPI+lkzwr/Yw0zHzv5EQXaHISeafS2jlMaeqkPq3dV5A4PVMO4r27I2ixyF744wwpCy4Uqr1iQ/gtWo4mPd0/qbRGv/5xQrobC4enbZeSamNW01nL/IBYckFV0dLGlurEfqp6sR3L4x25fxVihmlKxHGtzU1NJ20Xfu1PN55N9EN3paDyOhahbECOE/vQzXxwdDJVRVLnGzODiYdSoWr2zx/SCLcfuabaOcXT0NJab0IjDBirFct4vlhdVj1FWntUuqyTpuC0UGggZchz+r97htM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/ewjz9MSfSgcneQZg2VwqmZsMYvUuwnlFGfk/j/pLA=;
 b=WdAJN1k/XyEjH1DQwNRg+ki/axPPaSdl3UoZ9fV6y6NYHgRqsfzaJkXI3da2qQ7kBGfNY+9D2OHK6QMNF/Su0sUS2ycIPOEP9tt8tedTZmL2NK/xnTkU5baYOPqIZj1CknxUBPWSooVQXlELjx6iJiAvC7FU5Zz4RlA+V1UBp9zltK8xkhBtbnm81ncc6+4NyhLyGNMvtCFRTcJj6BsKsTSUg3METlS6HlNUAljfQM0cWbO5jmkxevlywZtxqEJuzRRsy0MjsmSxUJXNq+SfG3PevOoWdKkUUIb0kBjTqnKdaPNzxaofoACu2JtFLM9Ro/XIg1p7VeEexanh3kLlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/ewjz9MSfSgcneQZg2VwqmZsMYvUuwnlFGfk/j/pLA=;
 b=KP4aeoPeCtltReWR34c4NoT7eHVlEWr6c3PAGCpUAnClz+aMfM9xAFN6tLmu+h7C0SL0vnJ/Usete8/TNcrdI3UdUZk2VLt1FnAtSbDF0P1bjE2RlYHDxxBLwe+sAzO7xOPynW3He9Ag0yamP3sMtfYVl7yKioquExpgVDp0WMUj6Ad3VNaFyqD59/Zori8NRMWt8UHFZWSBZRifNfme01Elk0beJiAZFmdKjJLQUi3K4t2V8Uq+a4K2jx4tJTzNi1Di5em9wstLy99Vb5bbDacDNvcsaMRviEjlBo3NxataUAHPcuPQp8WXA3Jgg1VQdEpS1RJbsVAvXszqZpVy+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:00:58 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:00:58 +0000
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
Subject: [PATCH v6 9/9] net: stmmac: imx: add i.MX91 support
Date: Mon, 23 Jun 2025 17:57:32 +0800
Message-Id: <20250623095732.2139853-10-joy.zou@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b4350237-626f-4c0d-0946-08ddb23cd9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+YTwBlmSXIV9iR2qhG/cfpPvmNdVR6XqAb7owT/+zLZho13CcNCg6miYVAVZ?=
 =?us-ascii?Q?hU6diTAAUNWYLaWxjgZaSyFlNOrsZz+4ZOrGlYOpAQpU3zg2wM/12+4ZwKMf?=
 =?us-ascii?Q?FmYM97bbbjdJo4ibM/VNJ+VuJabEqNMBVjoyLoJ24/nG3Le1CfJ+1iut+DmB?=
 =?us-ascii?Q?OF9bBsI6/5gy0u/26N2R12zvd1zqy8s+s+FIWASEEqLG6t8WLPIoTeAEhs1m?=
 =?us-ascii?Q?N+k/Zy+wm4NMCv0VLa2BUb55cqVaF/coUx7SZ6foCyadBXDqJ8ohWmeCQcF4?=
 =?us-ascii?Q?HM6oKo9fDcdIdBNHGjUqybBLqRVC3IrELncB7hGRJwcLw+qJoOi+foROMJin?=
 =?us-ascii?Q?XJzrYWTMX/aJDH+srAAW13b9GgA3kIwzPTwCkoRvwfaEgn+Fh9dbyMMyk4aK?=
 =?us-ascii?Q?OerSWhWW/2uIhjPaohA9DgEZ+ZIYPvYeDEOc1Q3N7QKmGLHlXvNnqKB59wdw?=
 =?us-ascii?Q?45OW2se2gT/ZLQbeFEZmdZQlRUFXE//IODWEaQUb1wPACSHEHggOjJVeY2nM?=
 =?us-ascii?Q?nD0uteuRF9xjrqCNGU6i7IdhGKOn4XNlBkYDJ4Rq+sU8QdQGyH6KW4wavmuh?=
 =?us-ascii?Q?a0OiGE/I4UxLXj/RY5rXchMZex9tM2JdmtCPoIi33zu9PeSo88mv6LyCG2Vn?=
 =?us-ascii?Q?5FRo33PixojoKqQj8ybzkWIhthafGj9+pevwqw0c+P1vwooxzfzillY+nq8n?=
 =?us-ascii?Q?000r2V4qwB1RG58WTyBr6OPJ5GBWjKkRIxYaUOa2+kAvZf8y7lo+NZDuXA1e?=
 =?us-ascii?Q?l6kUE0R2NvA3TKr+7mS4IWtEelvks4GL6aG6uOLe/sDMi+jKIFSj9O6ORiXf?=
 =?us-ascii?Q?jpP3Xfy8bkVaMqVyLsasHkWLMpE0hDiqzsiq8w/xjvSw7ieZ9nnz1rlKQErH?=
 =?us-ascii?Q?eHwog6VsJnEhlVPCUlSU96kmzdBNSKVD4aO464IpES+Q+usRokoWK7gIRpil?=
 =?us-ascii?Q?VASgWI8iA4/48ouVRbKGO8hLVq0csMalliyYJfJRjDlXJthh3zzGon5MJ4Po?=
 =?us-ascii?Q?0CGY8EXy5vcEkGeKl4chkgBhmJ+ppQP7gXWCk4mRU3Jirz5+6nVFg3V67uAD?=
 =?us-ascii?Q?5m88wBvspidQ3l7ExvzCV5JuUMz6zDs0Xb1MtRkK8mWFpj4jwXNdTHg5z14K?=
 =?us-ascii?Q?+IiwhCJpXx1C9FggjBbxnKAznS+3VtcWUlmykBNTS01EUZkw2NPx4V7Oth89?=
 =?us-ascii?Q?a/GsFIV/mokDTfldCPmf3mrKS23Pb20FqcQzF9ZREIVHo2j/dSz+emd4mwar?=
 =?us-ascii?Q?Rc4eteM7ctiM8bbZsLFz/ENgaY9mZnqWs71g3x/2Gd4vhqpezc+0zJ/3WVF0?=
 =?us-ascii?Q?aRWA2monmsAQQyARS9yUXcDJw1XXlyvyneffozAQoAskrCSUFM+2ehJ0GpXS?=
 =?us-ascii?Q?T51TwwTxmd5HSndC101mSYib3TJwYL4H3aN68H3BSXdwtajSxbh+urRtbYsc?=
 =?us-ascii?Q?KSSuP3gfnERs99qMRGfsr6JUnV3YG9GKkALWC/UKc7bT+eRPyls4WUyKxR2g?=
 =?us-ascii?Q?QnjgLdLoemBuZek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?at1nHf99Y9ibBsGeT0Y7mlncllmt8vCJKgYr5FzWFupfKdI46RVrAoKx+rYa?=
 =?us-ascii?Q?jB/x0bSo7RU0xIJ4AmrIIuMVz8ZvaiSf3HlFD0hDi4sfo2MHsYXkFYT8+G35?=
 =?us-ascii?Q?TZCaN8uKbhDX7godKsxpDwjoR3/Hw/UuwDnxfY70AA7R5HE0LXFQUoQaQV4K?=
 =?us-ascii?Q?MckKkslmz28uNcPfIA99bdqFejrkIERzJiDfMu3bhgdtCJqp83LcVr9Hv9xI?=
 =?us-ascii?Q?wOn+YXSoBQ96/LnbVmJDaf3PwNVONrPj9vRhw42W7ZWVK04LVsFsVZCKy1Xr?=
 =?us-ascii?Q?7pcbVUOvTl4sT4DHdHyNx0KrJbJsWPDJUn6WawsUZtqRF26VnslyPgon2Msf?=
 =?us-ascii?Q?mb3clxyEPSJkQu+wQqcIFch49VTdHLS5Hr40l9QxvcsD0xlqOY84qpTMCxkG?=
 =?us-ascii?Q?3OjsFrgWwz5PrGyfEawZTVWVXgyISkPKv9e8Cj5LY2ALUc93WVyLohB7+svY?=
 =?us-ascii?Q?E2wxkHmViJp7cdhAD85j53aFK3TE/vIDcPOzp3Brs6+nj/BW6UIY+9B1nSQ3?=
 =?us-ascii?Q?XzgPeQXlogtD06sQsBry/mVfGLa8luVcBkS9WkklcdL7XT/iwzYt1xNc9iWU?=
 =?us-ascii?Q?wZzaSGEPfcJV72eacGX6pR0tb8D6CM3hew8qOzcSam2ZGbShGYLV+BTWaExd?=
 =?us-ascii?Q?Hvbum9oylah1rWMlIKecN3feYolE8dcpMc64ebKXSppJwAyKHcGIOBEW7r05?=
 =?us-ascii?Q?mwZcJos6+EToiVGyDwLRRuwbQKw8WFYbcTHA8QAmQ3GydVwasVrP4zVMZ2pg?=
 =?us-ascii?Q?UMxCAWP579oVDlvxCjgn9PmXRY33o5EAl0JBgEcHtbULVTMgBWKCM/8lk4Cw?=
 =?us-ascii?Q?/7M6CoC+X+3WIy811VIbpe+YbIomUQm8Mu+cMTdMmpPNwbQmOj8OGiSvg/8x?=
 =?us-ascii?Q?OmZz6urak1Ac/TViZ5yYfbKeEBF2Xu/k0rWhJBMJdIvNU1ejy5Y/FulJXMiP?=
 =?us-ascii?Q?c+qPo2FdZGVIJaF0AfpDwok/Vp2G1j7ba683JCRX2YGz5bQCB9qWa04wTewM?=
 =?us-ascii?Q?o4T4abD620WdC11cJS5DzyCjwEDwCeSXnbGAebprqMr2im5VNjBqTBiuML3n?=
 =?us-ascii?Q?y4LrIjBgvxJq+TLSVqRjH6b8OubY6T94VB4h+xUnPJcx8jJqZCxvYj4+cO86?=
 =?us-ascii?Q?wJzH+ZZIseybBE+bemFp3l3IA6hE/f1NAxq24y9louWRcc20HXTgtABXpLqe?=
 =?us-ascii?Q?p9wGWTMt665YufXaPOJewmihdUAg5ec3VuXzVRKgiUFYGRBs6aTxiAO3e+CB?=
 =?us-ascii?Q?UBeC01NgXrrp9zXhOrF+K0Q3DbdF5UoeeyEMQ7Iwf6784EKtAR2YctCnSTjw?=
 =?us-ascii?Q?yJuYalHgtS1G82VevFntwgTIH/SBR5d51RA0K2Mmqz8oh+EQIRaPzhuvLr5q?=
 =?us-ascii?Q?fpWlAKHQ+zn1TixMXg+Br0WmQ5wtapofGTed8KhJZzwkb1qGYH6bPl5lhMeX?=
 =?us-ascii?Q?jtziokMf6K08P8g2JP+kVuTPoEHFtxOF8qk6JY5BLxa45F2zIbWOE5sOGXPJ?=
 =?us-ascii?Q?tNEANfF51bPkSvfRrL6e7h/mIUhGF0QtUVZHSeMoJqSJCRT12M9bD4z585dM?=
 =?us-ascii?Q?nWWkSNlxHv9URf+p9EiI2+4LBam+idB/6KqLg4yG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4350237-626f-4c0d-0946-08ddb23cd9e8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:00:58.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BD18daKdLVC9CQjf9pGgo4kgWm25RUypcHDywIv2IHVTjE26qowbAhxndRcsrjWL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Add i.MX91 specific settings for EQoS.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v5:
1. add imx91 support.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 889e2bb6f7f5..54243bacebfd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -301,6 +301,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	dwmac->clk_mem = NULL;
 
 	if (of_machine_is_compatible("fsl,imx8dxl") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		dwmac->clk_mem = devm_clk_get(dev, "mem");
 		if (IS_ERR(dwmac->clk_mem)) {
@@ -310,6 +311,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	}
 
 	if (of_machine_is_compatible("fsl,imx8mp") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		/* Binding doc describes the propety:
 		 * is required by i.MX8MP, i.MX93.
-- 
2.37.1


