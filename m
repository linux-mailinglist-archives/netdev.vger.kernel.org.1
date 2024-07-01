Return-Path: <netdev+bounces-108272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E2F91E959
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C79B21AF5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1124E171E72;
	Mon,  1 Jul 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5Eg3eUr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50D171671;
	Mon,  1 Jul 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864910; cv=fail; b=brVAQ9/jkijxoN8sOP69Sv7j4dbSRC84hoJK+xug9iaCdw348K3pKh/giBLtLcP7jx6hy2WBxaxkRdKZl7arqLbLoFtFTrtoV2cw/ThDUlyZzuU8dSGPQJblrRA7JXCURoX7jhsnl28QxO6uU2KRicgngsMd2cki4zpPZ47OHMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864910; c=relaxed/simple;
	bh=JByOaRcHNX2v1pdmxD8hqUOrTWdzv2e4Lo9tzabj3ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6jZPpD8PyDvHJIWhGqpVRzoLichAFcJsx5+wtR+WQJoZdg0Njg3iHblDM03EQrrx5k0pC6oCl5NIhwWDKedNM7CjrVGIZqv/M+NQigGi1UMvRcO3FQkpByPRqorBykCbq3CIvEbzvCVoKWv31BuczndtjqAxKMLB3YhCXja5NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W5Eg3eUr; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+DWFDHxl0vE/UBjFfdaga05nuam4bdAe1nxEs0Vkh9ZfMI00RdQHYWOORzVkXi28X6JuaUQMAknzvwvs0ELwCyVzeMharvw2+UgpTsME4A5LsTx2jzq9XOlBEK7NYj86spOI7psVY1dnlmADkdWtTa9fPYh//T9DBHRPM4HsYIkSC9xwFQHgq9P3mIc6uguBfe3xVxbV+t/kNukMWcDqCgy7GNLl0jLimTGrk6tq6wlPiqzIEh69zPbZ85GbV+T8MfmyFMxTQlDqIBsujG4803I3gKDwk0Nyj493qVgwmasgUTjnFpszERmgIrnH66ZvP+/4SAe1ZH6jsUqxYU51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpo4L2aLEoX9C8ac42LXt9a4CSsNNF5qx7tVQyimK10=;
 b=KT1Qc/NYkEYSUJLqLWRU9JKNrigUPIotij03e3CN/TzI6W0taIEnLj60PYU5WMpXtRBG8t8cxN1irs6uIfu3W7RhQTpDO+wVz8RPgViQnSR+dAn3gxNkKPaLVJWPQNoFzqhiy+asLL0wdYk/ZEwYed9WNsQa5KXjUu46/iS/Ntg9jbdlZCGEONY9TOuw7sJsJ7qAgnTi1QBqWFLIOT/AdH24XU8ef6KWfA7FCif44lfai+IrsSukbwIZTHuIVD3rpI6/KBVAt4XW8MGf1nVn7pqgllkswhtZRD6zuVg/w1J2yziH1qVc9TGl2MDZ27uTdwhURaHAhJ/SSeSGOYRRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpo4L2aLEoX9C8ac42LXt9a4CSsNNF5qx7tVQyimK10=;
 b=W5Eg3eUrRMNz5iLgB+ReNpOIkt0lB8Vk9D56Yfdp6WAyCxsii9+XZCkgb8m+CYl/BN0iiFC0CVdBVa3sTReUk+ts/kWYdWzTNn0xVdAl5ItQZSvsEmYAbMB8gn/ao/21ctehZ+Rei6tLbJIbTB/xXH5W7HQXp8jR/uh65sLH7Ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 20:15:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:15:06 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org (open list:FREESCALE QORIQ DPAA FMAN DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 2/2] dt-bindings: net: fsl,fman: add ptimer-handle property
Date: Mon,  1 Jul 2024 16:14:48 -0400
Message-Id: <20240701201448.1901657-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701201448.1901657-1-Frank.Li@nxp.com>
References: <20240701201448.1901657-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fb91d0-8a4c-4875-42f4-08dc9a0a7f87
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?3BKmGtiimIJ52ONzOHNwPAWD66q96A0GQ8uHwZAdT3OQYyVE5ub7DCjgyXod?=
 =?us-ascii?Q?kJPslJlUvrb/dkzkK6MsE9xwBTVHlEefUJ0h/6DqJEYnHA0PfnQV8gbczJ8F?=
 =?us-ascii?Q?/AQmB6Goo7n/FuO8FW9Y+VeT9OleKljA8Mxm8ElX9DykWj7agZ0JIQao0SrH?=
 =?us-ascii?Q?GKW1i/vGVBZyAGpqPpOimcMdg2Ffd0CahwY+3lGmK7Eh58sut3EG4W4Ir17G?=
 =?us-ascii?Q?5eqJpQfRoXvbvU7CRGcFK1y9W7usgcL9bjTi6/iEGqgB5ROxDK0QYvZJLky6?=
 =?us-ascii?Q?uVOeustwGgwLVFfE4jh+FqV5FhQ1maQNbpYY0nUCg4eccWYMtFIVDPVQTkD3?=
 =?us-ascii?Q?aSgfC4+2bWG6lPH7OvVzxSSquhZh0YBcEwYDVq25LREcya7Sge3dZCrCj2x6?=
 =?us-ascii?Q?ZQoTYx/eBOwIw6Z359w9tQdTqCdcBB9I9FZWU/jJQJljZD5t9GnQ0Cq8G4HD?=
 =?us-ascii?Q?ndDG6Go93G4xeMD+D+TMvt8qG5EutoO466PZUIJqy76ZhLDG+d3HXHSL8+0F?=
 =?us-ascii?Q?uE2W3mNlIhgtYuk5eNVr6NnSbdwxCzSPSNfh5aCmpa5ANjJwSxddAMchdABq?=
 =?us-ascii?Q?7MWXygIIocnFLaKrpWq0q7Tz6vuigGBOOsEE5f6Bf4hHK6q1l/M+JTbiA6xi?=
 =?us-ascii?Q?gbXfQe+D1pB43z9x7BH8T0rbYroFOpmmZ1YUBH9IYCNqQW1gmG+XH8TEnjuY?=
 =?us-ascii?Q?+BzUZA7JBrIiW50aea2SxAiIiPhORgY5W21urvRqf2q+v/n6vh/tWQV00kr7?=
 =?us-ascii?Q?pBMWYkO+jcuANk8p5umkXWjJWvMfO7SpyHUFEv6/0Hpvmq2wAr0SIqkPjnvF?=
 =?us-ascii?Q?IOBBzRLA7AWanD/GaTH8SMF4SWj1djH49PNQdZI6Zo7dOBVdpqglraYiGV3g?=
 =?us-ascii?Q?1fVRaiiVcHdprdDaMy15GsV/cHxV9jvpiO6AbjeunXvek+W5Ha3LJ0D2fbF8?=
 =?us-ascii?Q?dZ+eAXtMGxJycDDM79fcNcXOgZs7lsKnuFDl1Wp8CblAFFbFnQyhwv8Lzynz?=
 =?us-ascii?Q?Lqjn7fF/kDKfLaWBGmmi9Xv/My49FXOumRUqWlq5YTDSLNRx7+ph4B1qIE91?=
 =?us-ascii?Q?+8OURS91FY9SgKfkN0pxRRHZsUEAAZvxg3artjCk0OGN/BTeCQNhoWZb5Dsy?=
 =?us-ascii?Q?UHjkAQrtT5aiYIese/2oJUbQ5DLNdkOFsJxcGME/P8cb5eVmI4nZcVIrXeSp?=
 =?us-ascii?Q?rNtJeyne5s8EFaIdqArWuYExUf2oGPSQh7/QzKHJRQ9H3ExV1ypnICqqISzV?=
 =?us-ascii?Q?BnKEncVuNBHvoM84pCk2vyBLZdQSukYeso14waZdPCk12xw31edFpRr2cLzk?=
 =?us-ascii?Q?1J35Jk3UJs1BiPuA0V16OmKL62bKT1liAl7NmiLw46HgAZSEqJuxc2LOItNN?=
 =?us-ascii?Q?NxJ6B+n/gZJCXPdaMPIXFznNfHR3iNIfP6sAT705V4pFgTkHBS3cC6hPEXan?=
 =?us-ascii?Q?v476+i/eBRI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?MDNDH8mxA0q0B4+UG5K5LQDYr6t9Cr3X/ANhficsR1OFmn2Yi057onh6sgRk?=
 =?us-ascii?Q?scoeGYj8myHiCM8sRxl7yKNuEwD/HhWYziMwsvgAi3mLJSss06ovizF1QBB0?=
 =?us-ascii?Q?yaRQljQ87gcbZHJHyXF54rImJPF2jaz9HOdqCh2PenYS0daY0Gekv/vDp3jo?=
 =?us-ascii?Q?XEzfdPtksdUH/wDHDT6a181eiYtDFj1x3i1pX1PSdmQFre7yc+ditCvJSfTY?=
 =?us-ascii?Q?acG3epiEqqBKqc2QRcPy7Th/uI47FMmCGmwZGJvNTiKDpdsB5Qd8XlcaoR/x?=
 =?us-ascii?Q?F6e7REqzug3OMqd697a/1J7y4OdAXtvJla+Fr4n24QL8nJRcZFctfNcRDbGt?=
 =?us-ascii?Q?CSy4vF0sE47294M8VnLup3hZdC4o1PIFVsPX/lwWMyubUrp7cECt60EsrlJz?=
 =?us-ascii?Q?ZW+9jcHpz3XeMJj0G1ywNwO4Rj1uDuhlqfDq599Zz9Elj/DqxGbFY63eJeZs?=
 =?us-ascii?Q?iNiBoKPa25tnZBqEBtveDPjXZpQlNsVg+lnsYNfDoculkrJwi6tOyfqXYq1T?=
 =?us-ascii?Q?7Ma+Fgw03FLccU46sn8jOhpSduEtZmr5VxuKG6ySa06zNhY+iAnvXCD9HTB2?=
 =?us-ascii?Q?TUMLNZUuRAG827fWMkmx/QPJDW6d0EPKwWY+Fz2EVmGKCLOic00adn8EywUl?=
 =?us-ascii?Q?79Wmw0Rljg2Xp/B58a2vMpm0pNIpDlIAGsX6tO1ul+hZeTOULtpg5b3qP8f5?=
 =?us-ascii?Q?yzmzWWqyjyLPkiuuPLOXmQZfnHJ59eYq4QVkz3xRIFquGjdyEGrHOhtewbV+?=
 =?us-ascii?Q?29OP2IymZPFCo2MRzMCbpwMe0XJn8PIZFcsr+NkSIV7Gu9NdvuY5h/a2JPbW?=
 =?us-ascii?Q?8bGcu/FltCPn4buu4s+38IRslPKoIkgMbq55q/Xz7AdTYT9JnL3I0s45XTU3?=
 =?us-ascii?Q?P/8blsPrzAoFP+CkJ557yEjesux//G2tySZ8mvUrdhUCZpEypecWSrYeIVqQ?=
 =?us-ascii?Q?tzH6BI4RCi4lowLwpytAPgBSG0z9z8ba5Y8PQH8z1wqdJM90w2zBtqAO/d28?=
 =?us-ascii?Q?f75/sR4z5RaT3H69JGFtt6iRryJcbw+HXoIMZ8YJfkk0do3Ju/LagcK7XyIY?=
 =?us-ascii?Q?U+0/vxv4FSzxW1rdQKCBPIWvETX3bfTqaVUH1V4Ah52M0J37kMc7n0IdML/H?=
 =?us-ascii?Q?xFLxeFAeRTKAnGrQGn2V5mfuCiT8VcYCEZ8GvVwYtnEiZaRuTYQWeDYZb0zQ?=
 =?us-ascii?Q?2+adJYkON0Jc03zWpnmY25S0RqXA9qDqgU0lyER/XOtaFAykcWY3aLqEMTNw?=
 =?us-ascii?Q?ncpv85qn9oc0ybHjGJBfdAito0Kcde+1rww49Qa1LwxXU0vwcuepDqfa9HVn?=
 =?us-ascii?Q?a2/9jZOTJmNU7PyHJbzi3QkR/9jtlMg1a3ZVzJudhbFYu6CXv9mKSv1hUJRq?=
 =?us-ascii?Q?Hmlmvmbwr+77Y10ucA7QRxKRvoDvh+B/Ev8G5VgIEsJlE0dn81PzILT78PxZ?=
 =?us-ascii?Q?FXHA8yrLtxQNTYtoj0fitPafbTd3O2ZQhlw31J4ZsQ5nkQg0chgIZ+CNwV0Z?=
 =?us-ascii?Q?JIKUUBJwaVD4NlwmslCqA/54CAYJYVn1s5k4ydsKYD3aI9xxwJmAh3jj1PIC?=
 =?us-ascii?Q?X8aVd13FMVqsTqnEu+A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fb91d0-8a4c-4875-42f4-08dc9a0a7f87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:15:06.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+SgRZwfsKQ3GYad4HI17Q1UwOiurv0YLsT5ChmR3Q978LfNHct3CYzwZf0enVLrLIo0k6wp4xNOi8SfkWmaRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539

Add ptimer-handle property to link to ptp-timer node handle.
Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: fman@1a00000: 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Add Rob's review tag
---
 Documentation/devicetree/bindings/net/fsl,fman.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
index f0261861f3cb2..9bbf39ef31a25 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
@@ -80,6 +80,10 @@ properties:
 
   dma-coherent: true
 
+  ptimer-handle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: see ptp/fsl,ptp.yaml
+
   fsl,qman-channel-range:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.34.1


