Return-Path: <netdev+bounces-200198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C37BAE3B72
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5359817605B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D33239E6D;
	Mon, 23 Jun 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mg6zuDf5"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8C239E6A;
	Mon, 23 Jun 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672797; cv=fail; b=EPUQwaP56aQ4grgJbuPmee4O+CXx62rgYfp7DV3SLLHMDIv7kBjEr/9AJzAt4IlKYXBcuVLBQ7ytE3rvcRnFXfHGz353h42SPeaJBZZlaWcU1dkwIebfJnC57sh2W4S9Ve7NpNkXJG8gygwlBjJfQvVL3fE640fKqBZwHOcghNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672797; c=relaxed/simple;
	bh=T5cJoCGAYw9t8IqYusdwsDsQ6T8Etf5uAewM/+K5KJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VlLzNCnuP57Jb/CLZsoCdOkZE9CaRI+B4Y4j1plcUnZKrIomhgPOdwMzt+gc89871ydtlsvaHXmxXZ1sepewUxBVCyXK2FwYjjtOUZqFqvmIaBueEadJfNJGCHhIBnI8roGa1LAXhQ1bKGoHwme3uzRsivqEuHKJtgarJBwVVHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mg6zuDf5; arc=fail smtp.client-ip=52.101.84.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZeRXCunvmA1M/e0eXog7VV/2fzKfnsfbHnAokklkE1zT944YdhLs7cVkCTtFx5g4pG0+1yuuWZJksuE/9RhH8zZUb+D2t8mFv4yWjCfc0YDNXQtVA+rEjtEVsh+ZA5X5NTe4ok3alzAjAAYk//mNKqn3e3gehNngdmFsHdo1y3W+lEK9R6G/Xq+etff5TsNN4zJ5j1sWyM2DY7zK0ahkkVxuo4RVKWI93hJJEU/StGaUxDjbPVvfm9EpaFBNjT57OWAuFKdlaKfcN0F/F2CiJlQ66tilFScNGGb4Fk5QsVUFWYcva8lbmuMQFbf9KHM7jcdkDpt9pk8quic1+GlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJlIOEwp4722/s1x6R3Nl5+d2ZPBDWrtI8ITEOSsFQw=;
 b=GDeY+sYYnnZ44U1RDRZ3DHqoTcUYA0+boQIGazyWbktCIpnOkcILajdbrKVm849ehibv9gS1pwnXGUJSAQkEbuATd6n7FDU8HvA+Yf7yQufQSJ23V9raw8RN1Snzutu3mxBRofynWiKFziDhmxUAdjk7tKmoYWUeeyAXQnY/ODNo9xmkcbm4A5YWrS605gywdVZyGvSCdz7zI/ugz9hH4kpsOMpC/udJ0uqniuC1AlqrLDCirorZafHQyKwmoBGwz9pA+usqjMhaqa5eu6BpsvV6wlhfpFnXeXnn+Jjir8vnZHznEQgYttusFl3lsKslccO2l2MEJMkvOYUsOZx11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJlIOEwp4722/s1x6R3Nl5+d2ZPBDWrtI8ITEOSsFQw=;
 b=mg6zuDf5FKt6LVI8ptoajhqrPea74J7PKBiD2IkEE5VMWjYljxgKb2ROJO8zZZNetZ7bvNBuY1y7RqGLcxaP/C1co0+zc80CzQ5RIojoI8DmiZqAXOBD3iHrDLm0ECVPkH6EfwQqpr40cis5vq7Jnu4CRw8rV9ojZekLiRhok6NwelTTZHMhFLYoXXY8KYkTbJ2nRX+ZEtciBWP9RiF/S/wVY9BvjB1wZfQ1PQh6hE8UQQwy4BrnpLZg+NnM/D0kjQSorwEvoFThMh7RXsyM7oHmX4oq7xqx9j9kQar0mbl4J8Wjp/8POxPLBEqD6J0790VjOsO2xe+WD94YJPCI4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB10841.eurprd04.prod.outlook.com (2603:10a6:102:487::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 09:59:53 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 09:59:52 +0000
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
Subject: [PATCH v6 2/9] dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
Date: Mon, 23 Jun 2025 17:57:25 +0800
Message-Id: <20250623095732.2139853-3-joy.zou@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA1PR04MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: 22896807-6508-4a5b-33cf-08ddb23cb2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cL3iHFiGAt7fWtDLN1rwBTiEsFHi86fAtv4XfSOgEMwGOmHQXTz6dj4Xoncw?=
 =?us-ascii?Q?vtpNUQC+uBK9b9eYatRm1Ocsib0ZavBx2ZWuLl1Teq/4TcL/CUpYo0dtuJUT?=
 =?us-ascii?Q?GcEfOG1yO2PA5onFuOIjuPTaK3szYNDnhl4C7EEkLxVhWQTwrszKNl/ZDKrB?=
 =?us-ascii?Q?/BzzNfeYO5UdcYtNCZiOl7aJ71lUPWL2I/iIkDRYH8KXS0YZ06NufGF2/7Fr?=
 =?us-ascii?Q?pDOSkw2YJpSEJsODGST9mmOnjBd2TMoglSvCSCKkZCj8BPRsYNilMPqr4tH9?=
 =?us-ascii?Q?NVoh9u3a/s8FEqCj+/Wk+Ho9BW6g01LsXOh4jmsP8hqkSpL4gxs80GNYhIUi?=
 =?us-ascii?Q?Y2ThTEagfPbfaZGtHnPs6eWjRZ950D9sa5qh/mKd/UYoLfv9EfG6TzLWS1fE?=
 =?us-ascii?Q?iQ+RMY4SfFmpvLRTE6AN3p4Nehp1M+aROPwaFxLswRso7LtRwjpS7TbQ5jJ1?=
 =?us-ascii?Q?Ea/MovdgNv7hwLgopGHtKX9kcdYrFV5Orbvf7CgQ2rM7GMmN/pKZ/W0d1ag3?=
 =?us-ascii?Q?WR6DirCigtuYwVahlOHJztuQJFzA4TlfA2f/VPblvqZAJAeMAuN0UiFnGYIv?=
 =?us-ascii?Q?plr6raPwT0wGD5HDrDp2dZsJAH1KzhLLqKlpStAS31F4i8doPJAu4cPXxI8h?=
 =?us-ascii?Q?ZOhpKSFQLyjCx+d9IaJs2Ti02T3/TE7FJgeF+ijewzJ4UxuvOFskyYDE7mwD?=
 =?us-ascii?Q?BAehZMHHHG4eDY9CyMacencsD5cPO5X0zwxX3M12H7aswkFifnuMnXSRGyf4?=
 =?us-ascii?Q?o4eNKJsSUFq0tGLbvf8+QOtUAC6UfsyXM1tv2IovEUYOVnMh7O4wfZ0st4Hx?=
 =?us-ascii?Q?vJOFeEGrxkUgHX4GCfsOORvjUDLXze7gxMkYFUAoaMF5HUW+gILHGeCxQOxo?=
 =?us-ascii?Q?lvBnMDvljSAqS1J8uQ2PTpKWtdNZBVjdaYWcVa/Jl3VkqyKe03Si/YoBn/T3?=
 =?us-ascii?Q?gpAHEnbVPuM95A+JFKI4Kl9c9BHTTrIwKhr35uTqHbh2giSzFqXmNWGur3v1?=
 =?us-ascii?Q?CeL30vTQ9Gb6+5ikZgHbQRSF3Yytae/Be8Cv9YRrkp/Z86bqhuTo9Sn7XGdJ?=
 =?us-ascii?Q?i9DwjtchZ4wcU6sI96fG5MKWLsGo20gXdAELglttpIgAFKbDyw5egQwGuev3?=
 =?us-ascii?Q?SIZFw+2H2H8MTCBxkUh587jlk6vNwylJron9gowOpn3pzpxvZhghRe/MT6pr?=
 =?us-ascii?Q?1GbIyUlStwkN7qB5hKXTRZAJuwCDREh16gZxPX2nPf3vHdLnpxYWFOIPpkSy?=
 =?us-ascii?Q?Zu2OS3cy3RKHtqbSXU4hJM7yLnlP52FpCU2DrgpNg+4mq9YVdNUH7AcCjVO7?=
 =?us-ascii?Q?WqMlEnL4bW3omPIfzQxMNqimOaF3P6I1YSwravlsvRsg3WdJQXZzsAZJ/jD7?=
 =?us-ascii?Q?k9+MFOq8VjxQ1YBYQtXZaIt9EcxtxnDppX/r+TozKRJDfreVGwerGSTn57Gh?=
 =?us-ascii?Q?omvGA8iJHdSm2uvUGJHnRcSUsZZqvqTEp5T8lV8XPHxoWR7LqriT7MPbdhA8?=
 =?us-ascii?Q?RAqGCA3UuXHl+IY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqzLChvpAMwSoG4Y+q6fn5pZ+fMBnAZIJ9dvQrRjt248AlbRca/Y7zBOze0R?=
 =?us-ascii?Q?x7YM6n/i8X8cUdrNYzoCgzusl56KczGLikRV6jbq46YK8QI31tUz2WeaNKfu?=
 =?us-ascii?Q?Fy+e6LQSfJ738AsDmkyCKTfI3XGIbtn1ViUX2ZMwAqe8hAsrPnKGEnU7pTo3?=
 =?us-ascii?Q?RS/DyR5eplcQV8G7s7U4WM7M9iPOzTMUdjlgAUQODqgksgmaW1N/GjJXXHap?=
 =?us-ascii?Q?upVdl5+oGQZq5kYR5WkAPXJyN1BruEvUV9Hi+JlOoEOjOdfpIuQpKihS731y?=
 =?us-ascii?Q?G/YGJBB1IUJbipWZ51s+hwniSh7mKkqHc+1tLjoefxu22IZMrM5tNbONe7TJ?=
 =?us-ascii?Q?GXx3hNOeWZcaXhLcF9nLa0hFW0hUvfWExKSNH2AW5C27e627p055EzmymxNw?=
 =?us-ascii?Q?GhnSMohcP9AB4uyRt41c7mPwLiNn/jn5VbvGEvXieHLH71BkxPJc1bEgw2Cb?=
 =?us-ascii?Q?99f/fawguPp3ycDG4zCPjCJaekrNNORCO+3mLl0sXFpfNGRf1mlkxxg2cNnk?=
 =?us-ascii?Q?NRDeftMFqduu9QWD3areN3HwYceda89bbK/50w64/KSvT+oyt1L24/hLfIgm?=
 =?us-ascii?Q?j2rvGAXi4um7R/fxoGEQUjxJSOqo8Y+i3O8769Av23uDHTz9IRirWenJLWEB?=
 =?us-ascii?Q?x8IdwIoKwKzXhzNnpJD66hp26bipXw46/+fpB8rORpYpprHzyemuXEr681Hz?=
 =?us-ascii?Q?lbHlE08offzFcjxq1Ji6whrfvSv818JnxSS45UGd19eWIwckXVerAqUCe1QD?=
 =?us-ascii?Q?lkvlBGFzF5lp6Td+2uXpG7j3uLIAOf2sXKcXYu0nalunDPSUGRMdEn4Q3G0i?=
 =?us-ascii?Q?pEwf4gKgNTf0/1ZDj3Tvno+o6KWzTbYfUplYqFQcOGFYpm9cKVQgnehw92ki?=
 =?us-ascii?Q?0Reca7wqAh4JrU+8W2ocaBkAkBNlEJV0tFW5sQf/S2mGtMKDLfqy9G9FFK27?=
 =?us-ascii?Q?TWgPiEJD6RMXhdtiOvvDyhkgpM3goObXk/QiFD3ODrzlYsECI3ZIcUSLy0iC?=
 =?us-ascii?Q?HHj3Fp9FdAXmEsBBjrqfqrS3HcydCIrjnbe34pea5lpO36K9tJG4hKR63hTn?=
 =?us-ascii?Q?fk3pVxCT2BHHbIyRQ2DDn2xKITzsGwHLKQ0/HDXb5Wuooswex7GkwpFX8JHK?=
 =?us-ascii?Q?OCkkzztxddiwGeqwNZLBNWUVpd9kPKaJanZcGkfrXxR8J3YYmgdLccQ5XTny?=
 =?us-ascii?Q?cbCrfb+QfQ0O94DwlyvekOuD91ICNmwCWOHNy3nNWhYg6LXledn3DVV+kUL2?=
 =?us-ascii?Q?xIh0SKEmmdQHXQRlGmWqNVwxbALWKhC4wBPYn+o6A7hH3etFZBNWxjTPaVkx?=
 =?us-ascii?Q?EMz85FVTpa/p/YFV4NYw6G3G81sBRSg8575UXNiq5pTpROzlt1ugNW7mTZ3q?=
 =?us-ascii?Q?sTz4T+nBgo/xXHEtpcgeuhQQU66eDg8HaNDQHk5GTRMzWlj5Bz6u8swx88FO?=
 =?us-ascii?Q?hSfzijbdaznjQ1doijI58unan8LYd0HmlsGPtRVNGLZCurro3SInyLdP+fkh?=
 =?us-ascii?Q?QfrteCBLrLSYZS61u2PUBnu2WIaYA3BedWx8/Df7DLx6SOnRaQlCm7yEALj9?=
 =?us-ascii?Q?Y5mtOXn39+LVU2aJWxy6PaJjaxsnlgWYJObsOvEh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22896807-6508-4a5b-33cf-08ddb23cb2c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:59:52.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybDHcwzL5LpZ9H3qpj560P89Gj8qtPgu8xh4cGjOIeFlaovS5NZZrSdvB3ceQR1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10841

Add new compatible string "fsl,imx91-media-blk-ctrl" for i.MX91,
which has different input clocks compared to i.MX93. Update the
clock-names list and handle it in the if-else branch accordingly.

Keep the same restriction for the existed compatible strings.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v5:
1. modify the imx93-blk-ctrl binding for imx91 support.
---
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 55 +++++++++++++++----
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
index b3554e7f9e76..db5ee65f8eb8 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
@@ -18,7 +18,9 @@ description:
 properties:
   compatible:
     items:
-      - const: fsl,imx93-media-blk-ctrl
+      - enum:
+          - fsl,imx91-media-blk-ctrl
+          - fsl,imx93-media-blk-ctrl
       - const: syscon
 
   reg:
@@ -31,21 +33,50 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 8
     maxItems: 10
 
   clock-names:
-    items:
-      - const: apb
-      - const: axi
-      - const: nic
-      - const: disp
-      - const: cam
-      - const: pxp
-      - const: lcdif
-      - const: isi
-      - const: csi
-      - const: dsi
+    minItems: 8
+    maxItems: 10
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx93-media-blk-ctrl
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: apb
+            - const: axi
+            - const: nic
+            - const: disp
+            - const: cam
+            - const: pxp
+            - const: lcdif
+            - const: isi
+            - const: csi
+            - const: dsi
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx91-media-blk-ctrl
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: apb
+            - const: axi
+            - const: nic
+            - const: disp
+            - const: cam
+            - const: lcdif
+            - const: isi
+            - const: csi
 required:
   - compatible
   - reg
-- 
2.37.1


