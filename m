Return-Path: <netdev+bounces-212853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057ADB2242B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B82505F74
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2A2ECE97;
	Tue, 12 Aug 2025 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gr+YCyTS"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5A2ECE95;
	Tue, 12 Aug 2025 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993286; cv=fail; b=FRVrQn6qY5PwccDDV4zFKhrY+75e3IJCOka5FVy2hyy7ASok9KXGvy2Vtwh94PLYv6MtbVAR2XJ3Az23bEgOpatrYgXGMJZxG0rIm22RcKUjlJ7/hmerRORUjh31ugn5AvN2+SeMTwUveBksp+0Tosx5Zz/3YISfZoM7OchqQtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993286; c=relaxed/simple;
	bh=rkfb75Ee5jtdr4CzujiF9tvZ6RzIqFYolmBSb79x3n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=buawx6I08UQUdrjZLGUEzp0nmelFRavjY1Sf4n8zg951wKxJ6lBRWoC+FZbdwIL80m4vAciy9bC/kOZj3meP5s4kcGVnkbkOKXwBx7o4ZfOdiwBe9c16bIukfa/0FH/k7znM3F8waNnRZeOuR3E3NSt0rTR2+LZM1723OCnCNPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gr+YCyTS; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG7+nHtSmoz7/4QM7PweFepRF5goUM6TsyGumllV1GfG3uesdgsgxWqDsYXKBDvHhtL9ut/yOAVuT24VdqnlvpyqRZzxh2DMxqNdE8Ze9hyuAuaQYW9tHGIPwljYHap/ZDO/2DDBRfXcBxKDTGoNlSZFdx40vSQEozyngoryBM8OMGxDFH0RPmEBB+cB8kSgy/GbrkdXq2mCJRo8Rr1y+i9jBgowJWYf1KnS8hpvfRCmtcEslb2nfeEjdh4K9QbaJVRZlw5J4SDSrtUGGPAe6JRgsKUtGNfjVdfT6UtjG1gokFBHvGI5Pay4skUPiE/s8MIBqIZ/GExEprRNorPevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRMQtOgWwP6gF0A213xB9KoNkOS/+IyUliW0ZXBI6Vw=;
 b=WUKA9mN/9tjD3FUStsV08lar5m34KeogNug1xTUmoLEsv1yLdslx/A7o0CN9Sm9glrOuy5e1bDVGpOUSShf2a+uVndgwk4mmSr2z/DfEg7AdcOS3SvVzJ+gHo3Djhk8gaUfrWWkFyDSLZ6YDfiQmpX5bg+LnX0Tjdb99wJIK5VhhwPbaUOZitI5HNZIp6Paq+PDL1ZvyZSodePUEhmMys7dUH7TTI+B2yM4KdznP8aAzc5kRPT1qcO73XeA5RD3UCnHd/iPJAdZNWjGCqIay7bJZbPtu+xfMrO3QLcG2Ks21Pk2jh9lx0zfn0DzgJ/LxDLcW5rLFG8kakBaYB/3Pog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRMQtOgWwP6gF0A213xB9KoNkOS/+IyUliW0ZXBI6Vw=;
 b=gr+YCyTSjp593tJ9+ejTOVqdhg/hljTXC+1vG1v7tK+Q5my+ePvRaWj7e6hPleCbsES1wp6njO3oRwr3khh9+qA/E9dllSQXMf60TxfdmBVt3Np3932aMUp1WsEmh8vPm6y0Nb9XvdstnlV7Ea0OfJxsTRM5jNituz71A/NNIazTSxFFJ+N0pLBOygmoRyR62eNzgQAVqtCxVqXGX4FNpKKl5oIlFXK5L6BTpmmi0fnOxYw2gcaSFVf4pIrASAg7cDBHjdjJCAKiOC/ZcPk7x2oWmrr42tma0bNTuCTbgsOBja7HnxzVsBPKmBMfu5G67gzI9mcjlXmRD4pWWL1U1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:08:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:08:01 +0000
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
Subject: [PATCH v3 net-next 09/15] MAINTAINERS: add NETC Timer PTP clock driver section
Date: Tue, 12 Aug 2025 17:46:28 +0800
Message-Id: <20250812094634.489901-10-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42446587-3d0f-45fb-0394-08ddd9881edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f3Z4uA2UXlzsZ87dyZxHL4KRv4Oy1b2jEUMa5LDV4nnTAmZCpDpvXCRMZ6Jk?=
 =?us-ascii?Q?OQVQsKDa6uCSkfHXAPQj/jAkHzpYso64z7kiB9Kth+79fpVlTFsGOUvF7e0Z?=
 =?us-ascii?Q?qBnf8T/3OLusEr7UKmEc/WkJgvVF+RVZMtQYoV9CulcfBhKOcRaDJlseknVv?=
 =?us-ascii?Q?H57b3aq5Eu994d1K274t6hxxDOcFT3BN+L8hZi1CWzBGarh56kT0kSuzSpvB?=
 =?us-ascii?Q?yIRHpbkuHdw71mNQgzGROFKcVJQaR8H0VUx4Ftk3Gqz3CcNZkiupXGv2tkkc?=
 =?us-ascii?Q?JKxGiEU9aqaMRFsKKGOvghRBLrZJrS1cY8M3tF5kakuA4AcG+Y7ZTGukimgw?=
 =?us-ascii?Q?HmhJb8sZMmMBysdon8iBieiU7WszXEDf02qAQrnu52PmgfRlI2TvmvsBKxcW?=
 =?us-ascii?Q?kd+ogi19/jwSJu+n9lYGNNvQb+3waLQDwWbc8+6Y6tVOKOfNlr0PIiXNq56o?=
 =?us-ascii?Q?g+tWj0H1KlscAbyYvWgDWHumINKWOYhRUMcj9gZ2/Ppfj/kUhiw6LgOiBQig?=
 =?us-ascii?Q?YDbSo0F57UOKoNL70oTFXh6eavdIDPyauK0SuMv7UDaTVRxxRvf0g4Ctol+3?=
 =?us-ascii?Q?HwdKLI/C9QPleO8J9T1xBuT1M56efoZBjnJ3xWiMuPtZ7Tm+uX91YD7akT5W?=
 =?us-ascii?Q?gLbrRphXQ7lDJkCLy1XRlnYUTKIEUL2s7L1IyLmHbGj4RgmEbIFhPfNr4wfv?=
 =?us-ascii?Q?SrO/TkD4t8sAnBZBN9au+/9l53cPjKsmiDbDOwFUfnab8yoxx0y3eI22P5+/?=
 =?us-ascii?Q?uMMkwAhv703jAnBAgAWkgh8i20obimec+BdAa5S9lQsS7U0ASyoC/3YTPIPn?=
 =?us-ascii?Q?lW+z8O2PacSf7DitS0vhemIIFZdeID1BvcUH0oo8/WR1NPlphA6voFYbhTew?=
 =?us-ascii?Q?pzExVKAtXjYMfH3sbOfM8TWQOC84VBO+cmjXUqx1ma54V9kJRw+pvjtoj+wT?=
 =?us-ascii?Q?KTZ9MZFsEdcDYk33N4HLOboPLOdoD5QjnjYK+ruvX/IYwQ7vM5iGiC7w0Jox?=
 =?us-ascii?Q?xMZf1QIdoK8FgfrHrtx2ZasDWMprNCa2QvvlphI55UtTpNrzMFhCvuBD9aa8?=
 =?us-ascii?Q?bBgmWwAoXqF63mg96hR4vzvLjhYa/d9l2MYAPk68S80AOfwhoKfvAINs4KOp?=
 =?us-ascii?Q?uxAcKS+dBQBstevbg9JjxhgLALR+ZaJoNBV9uz01/FCz5KN0QvW4W1pDGw1p?=
 =?us-ascii?Q?yk20FgaM5dHobKciWepF8HsNIxypzDjACYw0fuwhBEIUrQwqgr2E4XD2Wbrp?=
 =?us-ascii?Q?HEIK2c05tQCY+Ugcw9V6+vDyRX4pdEALQMf4dCx5OZTewRcEaoVztPm5fJV9?=
 =?us-ascii?Q?W51ErhpVDOu2hBeQLkI/8+SaoB/UTDMr/i95YdIuVLiHW1zGMlMm6E40uftW?=
 =?us-ascii?Q?LgMltZqEbrinAcFp7ucLmcNpSSq0g3rV2qOGfciusx26OTCRZaxHBz7jGsJ8?=
 =?us-ascii?Q?ty+ZW+eRKxYDre28KiaWX19JmFMdlXpC74saeuHv5HkzCzb+aBG7a5vmugys?=
 =?us-ascii?Q?u4lTWTSh9u1AH/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?68Vgq3zfW5rx9suEiDOoq8DpcsdrIjdLee7mH46sJDLDgoxnwUiWAAOXXnia?=
 =?us-ascii?Q?WYGPXIWf1MhshK3V0k533LhDuQYf/DNvG1rJAgl2Ort9axOh7ERx5qYrAMHd?=
 =?us-ascii?Q?mZzdywUPr4GEyaylTRsltA9NBdRVyxY5BgooVmyrMz5cM9C7Rx8TknJPgkWD?=
 =?us-ascii?Q?QYJseN2zwf/3FV9KSX/cLy0dQZF7ulFJgW4ztUVRlGVMAJezfT9rPJW3A6S8?=
 =?us-ascii?Q?IlYrkQl/qtlvqfAXADVt6BQBgTl6TyAAbkiVCSvYLszZ4xMJo9mIZRM6PKYk?=
 =?us-ascii?Q?lzGWr1zlMMtCdYAT363AKC561LQ/tcX6StrbsjBgRTU1TdQQ0/xwAbpWNKag?=
 =?us-ascii?Q?nU97CidRi53W0YpVgO2FQQk+AAKnkjRmHnRZ/I6Nb0bcnjTn9G3t3FMlq3xP?=
 =?us-ascii?Q?j0LItj/zfTYHCL1ZN9uIU4VXVajAeo+YzD7nX6xXAZ3LXwW1VMBlulasCRBE?=
 =?us-ascii?Q?j/XYjmO/g2slhbBdJ6gRwquPCtsp1mWR1g/k/+OupXx3xaJ8w+KdKjE2DLQD?=
 =?us-ascii?Q?i0OzCSMgkQowD/95dBrNXJb+Bg92kbRuUlQRK+iov9yEyYUPvUo1s6elbHXI?=
 =?us-ascii?Q?cXD8mwBSUhRUTgvmm3KsSZ9mBCtLijrFoIFXF1zFJfWPfgETkv4IJhZVWEPh?=
 =?us-ascii?Q?BIR4OFnydGtJMeMJpMLWtSaM07A223LBGAq+KQ8BymHal1SmE1Mqkj/mW9ox?=
 =?us-ascii?Q?wu1kjH39RDz8QFc/sWUwHUJjbkhQcpAw+m4xGpkAZEmG87rRMe5thokb66MQ?=
 =?us-ascii?Q?cX08yeMSD7LfpPirZqdzOxrbCf6OARTA1U4o0FIsiKeKqaOkbi4JlkWaZt8b?=
 =?us-ascii?Q?U21bXY+ay8XGMAIZrwVORiwOtdzutgN+NJvRx+CLVqifaLRGfr5fvfKxl4mR?=
 =?us-ascii?Q?8kqW167aTT9hSmQdGL38hr0PgTnkIwNIe4MhU0UNr0MYClB8ppIoshid2H2c?=
 =?us-ascii?Q?oFc+Sn55RYQWr9cj82x9kYmeur6hn5P9VA8moqsaYEMZ26+qqIBCstL9dEPk?=
 =?us-ascii?Q?0A3Apq283HKgTNFTE2m5nvCX61s3IDxoqPD2PotO09ciIb3AOc+P7R9BomIX?=
 =?us-ascii?Q?7Ob/XY09gYnFVpGuUV5v53A5yeP4nBq8VpzzuMzzxfAju1xhVBI52fnQMN53?=
 =?us-ascii?Q?JgA6GDyjectruIlq5vxj0XhziK08kymidcEtHZ3wbyL5xL8n0QD6K/giuGX0?=
 =?us-ascii?Q?vJ8tSnrBC097Pih5i3xQa4o3/sQxb71Pvq0nAlauRammyzoAvK4suOeHFGq0?=
 =?us-ascii?Q?HAVLhWHx0pZQxNnH7zog3azxHeCspj5kmhD8lwPLaeseE2Hu2AJtRiZ8yrd7?=
 =?us-ascii?Q?uMDiqL1TKg7SMRU6/VzoNtZ4MBxoLHyZU9FD8dRcd3ev15OhTawgRDHHdWkw?=
 =?us-ascii?Q?H+YBsofELL3Cg67BLReVd7xoqzsHT07p+bKaeR7oQvrJwTio8UMqmB7b3WPI?=
 =?us-ascii?Q?xvTHrC9ZOdiJu5aZhQ2cS817WOwfXtPeLD+zEAghgV1Qyd2JmwFkoPOoIyQj?=
 =?us-ascii?Q?vWQ0ZGFyeQ4jzi6J/J089SMGbGE7dlBWGs1UDJR92yyWJH055C8KLcNDUmlH?=
 =?us-ascii?Q?e0ChXuvYnxSVO4zCX5774F9UipxqNw+avO9tgMlk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42446587-3d0f-45fb-0394-08ddd9881edb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:08:01.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AC6grpe0Y8tUoOS8YZbhVa/qaPoYNjl7xn12M0/a6MBAx3Z22cs6C8/EWPI47Hu2EETBlrsr6Rd+2eK3Op1umw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

Add a section entry for NXP NETC Timer PTP clock driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2,v3: no changes, just collect Reviewed-by tag
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd62ad58a47f..5384bfbbc3e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18264,6 +18264,15 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP NETC TIMER PTP CLOCK DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
+F:	drivers/ptp/ptp_netc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


