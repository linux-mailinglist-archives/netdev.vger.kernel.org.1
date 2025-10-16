Return-Path: <netdev+bounces-230000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A120DBE2F2D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB2486513
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6DC32C31D;
	Thu, 16 Oct 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLcjKbLO"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571C326D55;
	Thu, 16 Oct 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611391; cv=fail; b=InAOcmLF11bYpzJxGGBrTajyK3My1+mgIp2x1W9tXfS6kYWWCoCRipmu7n/Gddy+R4TNLMD5nnWe+W63ceTO0NM3KqwBcdTGMs5FOED03Zb0cU2rWYXx5zrS9ZDOT9oOPly1BnYv3tixvnNyHalCrubblZ2xzspTipSudDCgJlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611391; c=relaxed/simple;
	bh=EKrG1ddKCq/D0cvGnwDwOm5T2I1Wzz4JjhmKzlIIqiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4FHVeF6/TVjvzQaPQUsjoWe935U3JnRGvn6FIKbCyCG3lVwjB6/c3/DWNbc07KEzdb8zvREk5eXjZPjCawdwI6gEXwX3yjhhqCd6c7Lota7q4MQ3H8ssxPqkw5EcWgL4WO9v0nrSKsuBfukR/cJF2M16jInLw6et+bOhXETHDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aLcjKbLO; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFBxobAlBjnfSlZGFJskUxZ7+kCEK21i7WUqR0V63UjY4KkCeEIaUXXbHhItyLpVJCgW8bCd7C05VblmqKO85+fatMla7bqwsZPWXAVE1hUNY6A0W9tcB8Db5d/hYDHlg9sgPW4mH6i8EI3XMWqkfUazeGZKeE98Hnz5ugPilvNYihyJh05nfg/c638InTPcrBVDNDy0reQWbKwFOjtCk72SKPfJ7GRFi2wY0t4zRBNy2hvM5poed8N0qs6ZrUrwRDptZLMr/MN0WnuWESrzmil+kkMn9YsZLlOtiv7XsoTkz5z2r8MjNYl9DM3qWawuXOSOP8LPFoqDfyv/lfhlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhsxhg2bNjs3nOhuvKg0X5YXhJ3Sp1ErDbo1R9KZVYY=;
 b=Gw3HkNKdDVsaR+Q5uPFv0fwQBqYJsEYDhjz66yj56QjRJPuUhLsF+nr488cKBTKp42j4psGjoisg9Px6Qd2DpLBQYl20tOdWji7FfFBUMgi0z0cNeQ0paWmtlSkWhU9Rn3v/LEvmEGtWzZZzxqO3kk1e2/pHj0xhdcqVIUui1qso0AxkcL+TTkr4+wWBsEjXeCpxn7eClocyibAb2ozAwKAAy77SbkIq0Ufyql1rce7XOMw4yA72Qf8ZN2wK6P2uE+zWQyVGwvRbxgC0YAmwe8JyH4PG4qKxls3syhAo1rzZX1enb1YSRWzxLE5ZZBaUiT1+9ze7WiQqTBmhjBCrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhsxhg2bNjs3nOhuvKg0X5YXhJ3Sp1ErDbo1R9KZVYY=;
 b=aLcjKbLOjSRFnXDCDkFnJ3b0XZxpLFVjIRJXmKYcBDbseL9tqA7c+dhX2X4gRs/V2nM1xdf92qS+ihimo98U5yif/cIlHXtTdmThuRcw3eVWThMubbljXIFzK607EDtJHkChiiJaUqInSlbPrmdlYBIjayVbXTzDDydi7xOtOdAesiJpGTb0vohiwLoM0vZaZVef6FiH8fowoeiGFn7CHbPrICwaAHqKiEfpnbzZ0p0Sm/udXTPnk8ixE6DdF2AHuME4aSVRNalmbWVsBJlywc6C8D08GKsS2VIY/3vynjen7XIe4gjXK6ae+oQ8d1V/ClYMV9b1Bc6CV/KKzASspA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:43:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:43:02 +0000
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
Subject: [PATCH net-next 2/8] dt-bindings: net: enetc: add compatible string for ENETC with pseduo MAC
Date: Thu, 16 Oct 2025 18:20:13 +0800
Message-Id: <20251016102020.3218579-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f39af879-caa0-41d4-15ca-08de0ca0c7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nrfrjw/QlXWsfaaULIdFVBPlvX9ePBy6rLkEyd2Io/xbQr5MXImRNsOV6IBy?=
 =?us-ascii?Q?1uxa9BSbj6muB1M/678n65cztLvQulGizOQ/X+zdKr73R18CoS3AC6tDM6hL?=
 =?us-ascii?Q?TiSfHT7nIvSE+PzrsO6gn6YIE5rJpD8W5c1CHLcKl8KXH2yVxFD1AXDY8diN?=
 =?us-ascii?Q?4xINDMIJDiEoqVtm5wpL7te+GliQERbMp7vpuQVl5ItaBQjqSh6kMpxLW841?=
 =?us-ascii?Q?xY7Fuf7t+bo0j8yXRBCYQyHGDCLKERJICkTdd3bIaZ/OP3CwpIl4YcRywhkJ?=
 =?us-ascii?Q?lB3FHWNwUvXbk3a+ArtmcFnQitMgQ37ZOMKzdQ7erBil6/cd8kk71ZK2gndT?=
 =?us-ascii?Q?enm6etm/hjrsAL6HWVATuQiWB6fw6D2VKm32p4N5pP+E/4RpQebgo9ydD6c2?=
 =?us-ascii?Q?4+/JEYf1PwLiHVAWTKGKTK2zDyXgkJILTdjTjY/bClyQSI8goP4cIXavupsD?=
 =?us-ascii?Q?tFfQtE4l5LtetEHXop1uiZXq+astXjKSAUMHUXaCatfAT/ESSeRyENr8usG8?=
 =?us-ascii?Q?BKs2HKd/xtzrsS70I33ZgSuMG9Cv0Tzzdw0HzpSzAynPRRNAla6Gftg28eJZ?=
 =?us-ascii?Q?6i8zbPheYsiy7K75j/xibHnSBpfo6aBs/10ElvHtKAW0cumKS/RpG2jpI0Pd?=
 =?us-ascii?Q?wij8/z/mXs+kOVDN652pWb4UBC/rve/r0aQY2JHDNiLEg9wbHrNYtMHsadyc?=
 =?us-ascii?Q?i2taEojDeBkzLROVYFNATrfX94U7xNuWJJiNFsoQR6EOXD7jcA60gdfzetZ+?=
 =?us-ascii?Q?ejzr2g6Pu7HQAK1xw0f6CLRcMZ1/bn+D8CyZPuqFnx/MVqfOZ6biYuWbPROt?=
 =?us-ascii?Q?sfLu14ABnIjyzp5zo+SqT09FdpFKft1ssIikpQkHJ+DERNDcgZh+1g8xBhvM?=
 =?us-ascii?Q?RcXNfErgl7oEnGRijp970VnFITqO3sIFOmKLG7CO54VuXlNG++C7NhqkC6An?=
 =?us-ascii?Q?bNMnJ1TRyuswuoFSr7GpGiE0+L6IjpLrqCiQZNsj3QKpehRs373+i5Q+Df48?=
 =?us-ascii?Q?vIW4bMtqf2gprMlC+K4G6lSdXHLzOD534AmiyVGdh4O2/GmyjvvSWmKV5rEf?=
 =?us-ascii?Q?Vk8gQdYoJoYAjbC96LTLe+SNanopwMiJ1upSNPcE1GcScs4ei/TkqMuKkzHv?=
 =?us-ascii?Q?A7GxTUyYGeeqWcn8tljdMArFG8uKIn4euAHcLOikDsxsKfovj+SBWjVJCdJu?=
 =?us-ascii?Q?FKszIkSl5PsHEShTY5yp4gPGQherc9Gs0cXIZw/OZln+wS1qOA0ZQYSDiAIi?=
 =?us-ascii?Q?jqhW+Q9+HsKgic2IVM/TZHWs1pMNnY3Jfn85PaWWDZwkxY0tRx0KqipzvLF6?=
 =?us-ascii?Q?XhC/W6BYKQu1caOFEAZxAcOL5idXh4dOpKHrs4UvHcp+ToT9PFgeWJq/Hd2a?=
 =?us-ascii?Q?C49mKe1S1wMXggwsLHXojfpeeBEVxjn2uhIdbQ/zRNhMfcJafx9XcCRp9DFQ?=
 =?us-ascii?Q?JztScqkWgMu780gk1PJO/RSXXEfGsCenu1MtlEi/YGhwRAudtiEtGV5d9MPd?=
 =?us-ascii?Q?LBVxAjJfCSd+007EOk4xmSgb0eTFGkIP/VKKRTu+a2o9YkYkx8+6fMaAPg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0JiFd90BpJUbfjPIiMdRm/R6BYggWKEk1YN2rjApdXiZECa3I41hmPFDJmT?=
 =?us-ascii?Q?9tWfHLOYO9SPnJ0wMjEHMFptqfqJ7+PJb+dpwBYVPsdPJgMLJvWaw/n6ChFz?=
 =?us-ascii?Q?S+13ev7Oyz5NuE5bGk8QI749qbG+PNMYnA9x5XcvtSErNpFxM/TM+Za0kYPc?=
 =?us-ascii?Q?LYN2qXpcSHAZhcH13ePUru3Ib9/Pfm/+lywkUy9zcv7usQ8GpNyf7ki9rdSC?=
 =?us-ascii?Q?OTWNw7HEJ46m75LEDC/lTU8DEj6Wni3VTXX2QHZL71AMuf4eKUc5DGl59ASp?=
 =?us-ascii?Q?REp7+8Gq7EntMrxQXYI0SOIpA9L8UcC9kQoS1ox987Xh36iR9IPqJ/vxMg6I?=
 =?us-ascii?Q?2DGLlkUpb2xjUzJ6gnAUb2+DvcfI5IEfzzeWHg3hZnE1C1c3wiblz794GADw?=
 =?us-ascii?Q?pzWcISmJnSiiGrCtWQVRrQnrj30ORXSZWi9rajLiKMasUR2Y4mf/ws3JEbhz?=
 =?us-ascii?Q?dK2DjWQVQoUFmBuf6ejNLfN1qutx5Mun0gWPzMrEpYYVP4+I1yYYz8mE+/KI?=
 =?us-ascii?Q?6/c4HfV8x0A6Om2gvh3hIBp2FgR1b/Pgv3nz9x1QEJ6YZWFKGRbl5EKn/qrB?=
 =?us-ascii?Q?Lk1wk1mFam4JxR1C1oavaVh9/5h4Waf/upqHJDwQagyUlFETZ2bG1ui8nsFq?=
 =?us-ascii?Q?z4RgyQZua7rtk5BUDk1M9+NM8bvSF9YVPZPT9mwoP3Vi5Fvg6IbxfxVpP1f0?=
 =?us-ascii?Q?jDA9CcY8R5cq+cwggG0elp4IKbeqdcQ6+AleR9cmVqSFlod3654jyvqOFEuf?=
 =?us-ascii?Q?jbMR2D50t3FNkD+IQSBYQYExij5FLDghEBwKw6djr/WDSHX8vfuvvrDL8IcT?=
 =?us-ascii?Q?SOI6aLdCNwS0hGAnkQsIR92ULIxdz7nuri+UXFHNknay0ms1kE5uFFc1SC9f?=
 =?us-ascii?Q?3WpDhztGDU4UEdGcLISXps1Bu8v9MNW24DjGEyl0NKlmqH168wSQi8UsjoQu?=
 =?us-ascii?Q?kBzOoaJ7JNQt2dHTiwrPV/qkU8oJBk7r/ZxrZ+8H4j+1KNATQV/znlBQlGMv?=
 =?us-ascii?Q?YV3fZlTf4Ghj0vcSi0DWgJXkbKDZhM7TyppJRU4jEN+NZ4ujbTIuz6C68WjC?=
 =?us-ascii?Q?7rM1ULvPrqsa0StJonsnKUGKgcwvYfltXMWGHdjwde1FLVDt294y655wx8ZY?=
 =?us-ascii?Q?G0LMJDMKdx8bsmkSdw+8M+n93XMpy74Xhw6vs5FKmXoZpv7MVRi4EwAJmmoX?=
 =?us-ascii?Q?p0Hnfnw2/FPnd0iWPXPmgh1ZeuRXl3r8z+V750xYtAQq3+kIrw2Z4mW+rjJ3?=
 =?us-ascii?Q?MuLmrkYBgqaif4991qJAL1/4guPUkmOT8pKfOHopcLYoOW0f/EGAqP2jdChL?=
 =?us-ascii?Q?bNnm01pRaVEi3DK7Z5d69sGtKxyliQfIQAOcIIKU1NPMb6XvbhWEalARdma7?=
 =?us-ascii?Q?G/CLBKV7QfkkzcfVVVgRrch3UJQ13+JfV/YVOrMHNFQs831L5Gt+riba9OdD?=
 =?us-ascii?Q?h4aAHbo4RuwEV2ITxIX7wLGqL07EmSe+imSUl78mTUpk80u5W4MkoQcESogR?=
 =?us-ascii?Q?oFfqI2rpeaceq+6IDaasjQah2h2/Kz/9OrNnXcVRmgCvExKN1725gHyd1Wms?=
 =?us-ascii?Q?eXhTlyzsaWh4WzxNvE2s4Kixc2FUu0a+6BH7B9g8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39af879-caa0-41d4-15ca-08de0ca0c7a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:43:02.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZdmOp4FvwdHMeGrncINiDt0FbflN4OKLtAntVvJgVGme9yhtGz6o4zv/VCN6izWoRff7NnPi0N57r8GbeiK9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

The ENETC with pseudo MAC is used to connect to the CPU port of the NETC
switch. This ENETC has a different PCI device ID, so add a standard PCI
device compatible string to it.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 Documentation/devicetree/bindings/net/fsl,enetc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index ca70f0050171..aac20ab72ace 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -27,6 +27,7 @@ properties:
           - const: fsl,enetc
       - enum:
           - pci1131,e101
+          - pci1131,e110
 
   reg:
     maxItems: 1
-- 
2.34.1


