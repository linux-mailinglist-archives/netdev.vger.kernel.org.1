Return-Path: <netdev+bounces-241009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1191FC7D66F
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4DD14E0F3D
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E04C2D47E0;
	Sat, 22 Nov 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f9B50gF0"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A72D2496;
	Sat, 22 Nov 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840054; cv=fail; b=adu5Qxc8is7tUfzb+lKqW6XB926O9dMZY5AJQkNq5v/buPDhAPYB6kGFwMzZyxdAB/PjKxcVIofNdNgenRf5ZwBzu+BTzw0gRq6jlnBazncmlvYVGrz7gNgLW8o+EpX38t7Jeg7MdBKnBgY1KMaQW27euCCrz61jGKGfqEICD3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840054; c=relaxed/simple;
	bh=fDGuuCGivdqRZJDGJMqkCAMolvFGzP8NAeTgMUkQNHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcqdN2ObZErtKyBFVER4xM9qgIXhxKffSTv2yWe6XwOrowOZIdXGay5kotrvhP30wPPDezfWUyxnhigNg3NhhZTfPJ+rdInwm4W5Ls/uiDMGeFKlEKa9vDXPM4So4Ng/vM0lsIW+mB+8ZeNC7WcYxSU4M1ptRGTvLjGaRAUhbPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f9B50gF0; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVwfBD+kdT9WjBKM0QnRLG1Ul9InYQG+hD1O6oSA4vGJuRq1FqnjQlkAl2MQi0pDrgt9vsCTDS53qyVD1vwkMG9CFUgx5oHrXHpPrugjVqOe2ZH1/sb5zvL0/XFp9fPg9qu+nxgmcm//44bN/lNZ+oSNFHOpi50t9ST3miUvEqff4SAnWvPzQmXQQDlK9F40EzEprmIWEvdNjPVojfQPkUjdgIKHFI8SBDhl6fgnitkpyx/vxI2cbgaxxb+JMFzkwnTU/GlfNsg7VrHT3/E1xdWF9kxkpnPxAuynUj6lFHhSaPusGsLJFw61ZNXb3LSNEvu0jCdf+cXJur4FIUmpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIoGWUo2HZFP5pGfOBEdCiN85HWg8SWBdHlc3ctiZM8=;
 b=v1qKO1G1iBASxlYGaYD+99868ftpYwNJIpwH79FN4dDduW5Tkxpa5HoVVH/GV1dVXa3KaEACJNzowihLHWtE5aEyMiInYBi5fwLa2S0GhDdbomlxYwz4agaOd/MigCjjghWPR/4qK4tLHTR1auqWnZmdZPKrcMwihlRFlSbIUJrKDvBWLxoqxRq48f6afXWFhAV0s2fSa1sfxwkqbeYz+5SpYJvQdI9a/WUP51iUNvPrjaCbH3zYiJPE6OIZUyMZVqdYFy2vc8VucfDzDSLr3gx+GI9FaE2mq36InBWeianmFLeeR81lUZyU9ehpoiy7o9oTXaKxE1XsvYx1RdBoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIoGWUo2HZFP5pGfOBEdCiN85HWg8SWBdHlc3ctiZM8=;
 b=f9B50gF0lG3TSj3vVDlusCy7m881vZJi6ZvqPBqWzBMNjerllvOb471VeGHAECKAFge/gwZLKRh/Pb2AuPkGEPKWYjOb1dWT3MJ3MPWqfLSYxik2tdRmqVjxalZX/MK5VX3WN8Qipd2dGkh0F3IlVjeB3H44jmiNY/QVDQr6OVzOO/GyTVDoYHb3KMsK4lFPrC9LIQwSXsdICLAg6jj0jZZ54LUm9ZGvuTVbfJsYHJddVSmDt9Ed+l1sgrnJ2hDe9Yb+vvBdu57cZQ/FhTQ65EaXRXreCUltgozxjRxMT2kmox69fwWb/LqlpBcEEmEhTn9e9YPD2mFcGlFwPlmmyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:34:03 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:34:03 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH net-next 4/9] dt-bindings: net: xpcs: allow properties from phy-common-props.yaml
Date: Sat, 22 Nov 2025 21:33:36 +0200
Message-Id: <20251122193341.332324-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5a6489-ce71-451a-e8bd-08de29fe17d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYRXGp3AgvX3/tOVc8bh1LLGDfup8hPVAToHd+vTV0tcw1o6AQQ6BkkNFb5F?=
 =?us-ascii?Q?JFESFJoyucrbeplCO04WAtit38uzWuXB+Ns2Ffb5UlAaWFtaMknhBd5rADES?=
 =?us-ascii?Q?G2ueeB499o3OIwXDSysGM4jbnJX+cizWlh8QvbiQRlRApd0y2zsGke7JnixS?=
 =?us-ascii?Q?L1H6At0Qyd6XFVllyPojTeFj8iXsJ5Gqopa3mGyM9SzBLZnwUtA2TfG+iLV9?=
 =?us-ascii?Q?6ljnWaiGP3NoDv4Q36zFJaXZMe1YUzEiBNpsGXTOF/bLd6I/FP7DGLUnNxbT?=
 =?us-ascii?Q?qb9vGN+QcpL7AW+oflm5qQtKzTZ+dmPXv/tYc3KHrF8i0AASmlWkpdy9lBBp?=
 =?us-ascii?Q?Kojul2u9PPio1Ed3O5sH4NlKzZ+pE57HzdSOjtz3GpChfLFdBwpT1HMSEfWt?=
 =?us-ascii?Q?ObjxwNJ0rNJqRYWbVKnVN5cr9LjRA1g+z/AtSLtim8Sb0CCSq61ilXQUcmUm?=
 =?us-ascii?Q?cKFHdUQTo6dEvBzpeUNh25MmmySW23lvm6ds2gNQAEZ6i41LwHocQZPo7o7C?=
 =?us-ascii?Q?Gy/MgWii1956P9+byot8GDz4LGuB5ffcaSEecy8ysKamRxPEm4LeD6nWIBgs?=
 =?us-ascii?Q?CvTiHuYOUwJp05VU9FJlsQBi5aHrGcEzo8FAwCfbj1Pfds3E2oc8cow4GCsX?=
 =?us-ascii?Q?86314axswCb/5F7HJPl8/njqFoM3ejEm6iTEXniZG7oNPKwN5oLDZ64TMnT4?=
 =?us-ascii?Q?D6rh9CWNZxZoxJdA3u33nuYksoxenc16RpDBXLeptDQr3+N/WuKrWhtaplrG?=
 =?us-ascii?Q?Eb+/d1MXD7KlCtBghR0joxkosxtZUxUqEuafNui09v3wFZQV2Gk2R+hbgMEn?=
 =?us-ascii?Q?1GeGRKEnZ1CIwwAH/R6rYeDlkFowLLbtbCXH+RJIlEz2aUbcKUEXCXnMm/+O?=
 =?us-ascii?Q?9mS26KjuvUXTDYaDB8tscPb8yvxkU92ANZJCQPOTSyU/CqUNtFawBGjMjgWm?=
 =?us-ascii?Q?0W0yz05Qjz50ofsRdah9v34Oz+ptMxYymb+6xrMFlptq2X+fZDh4bUuY0tiE?=
 =?us-ascii?Q?tb//GGAC/2PLD1uCPNhQnKTkamhk3wr2nMTPIiuGHGn+JKtODieLPzRc/4VO?=
 =?us-ascii?Q?A0tHV6R/jw4Newp/4SJPmYNYwvneJ5NGdvGKJN/izfb0Os1iSDSNV/zDNuM6?=
 =?us-ascii?Q?WY3oLYkzxfVwVnZpPArl6j8mFzE9kl+yLY37s1Pxld9DKg6HohHawjGVJN5h?=
 =?us-ascii?Q?o2MhKImWv4IHznFl/ChBSLC36LUcWN3yUmRFspk4ERSdpbqkf/QgQpFlNSuq?=
 =?us-ascii?Q?OafzQ9qfD6cOxxActGx+RAvEKdyYQYZq9+VaKfNT3kggrl3sVB9UpnXVcm4o?=
 =?us-ascii?Q?erdTbM73Dpbu18JAdh9STRRH7duMj+8E27wwO+euNbjQeVgMLt9dt7Z4hxSY?=
 =?us-ascii?Q?v64oFw19digAIkbkENe4L1a/y4YMUUcNMPJSqVNFFn/2vEihwGeEN3koxkw3?=
 =?us-ascii?Q?o8f3d8Xo9C+/1jkCfRcNW6+jNFHrCviT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yceIMjfXziXY274hQpOzQQd4hqQCA1h1vHL60FZi8232rWlDytaKhvLKRhv/?=
 =?us-ascii?Q?WbonYRNxgjX9KGaJrnWd0qguehiAnDgSXcXxZodO0Jm0C2TFdPFCWR9ztxuN?=
 =?us-ascii?Q?hAeGXqclkFbxXTetzKEvHSixlBzH27ruHgQk3zvYIOfta4ulBelCvUgviu97?=
 =?us-ascii?Q?epnxCFj78e/Ng6jluKEpi17ffLoXYDgXXmEyGbrQgOg3v0HTAi88sPVB+4LX?=
 =?us-ascii?Q?iVT0vGYOIWDe/iNYrT6P+PUBNI6wVW7oECzf2q/CLOCnjtIowuQqXif+zfiy?=
 =?us-ascii?Q?Rbeqd4cJi7z9KZncNNRCCtNG3fbsAtZ6QvuSWl1pHWV9xeZgw5cDyg339xnY?=
 =?us-ascii?Q?ahqQnITfbB3FfmrTfzksIyYFOufRagqOV3t7qi9sAd3mmNr4IHryPiK70WdI?=
 =?us-ascii?Q?PQFD1b5bXvaa438UEVoUmtuLEjDyuNQ1i7T7aW4/TAKQsSBvjMjHnouZxg8q?=
 =?us-ascii?Q?KjcbUiY8wMcafOpuQIBZduw3CG7HEHbpL61d9G3IeSI4a0MIGHee+8djrvin?=
 =?us-ascii?Q?6hvBkNDaOmqiRmIsKa0Dztut+n18AZd2CbEV1J5dryNMf3KVF+qSZVT+qlkk?=
 =?us-ascii?Q?ggywYv5WbNy1yMJRB6PXFoXI/XX0PYjaWCQTFEEPfgNBoP8834O23QadAmja?=
 =?us-ascii?Q?36sAXY2URVgbsdvdnOEg67s2M4lQT+3W75X3sm4xBrIaPjc5iW+2nW0fqL12?=
 =?us-ascii?Q?1JMQd1hKINv2Oa1WW3WozzG1qPcBgo/a+OhAzKP6c1rnfzeMTcM4BSumFTkd?=
 =?us-ascii?Q?sWElnxjvplnQHzDbFJtL5giXr9rFlwvVAKS7YYqu8khkCDhOyr4lgtnJ71Jb?=
 =?us-ascii?Q?7CZuAScfdu0Nquu+djgIjMAgBhtKi3EcsjtmnWs5n7AZ3e/uSOyVcLG1O4p/?=
 =?us-ascii?Q?vjFlvfzBl8IopS2YQlKlDAXkZblgWULg6T5ekYctM9ZQBV0Ygj9JxtFnCR8k?=
 =?us-ascii?Q?OxnXTqM3yjW/lgLx45u0OSKTo/PueCUUUKDf4+PDiL3Le4V9ZOjQX/KK4ewW?=
 =?us-ascii?Q?gLwjZLtFOT0frhhaT5IvxPPWx/3PxRzddSfOnVxKFM2A+lCygjSZCap0Jdc/?=
 =?us-ascii?Q?kUTmAyl5pq5uqr7oZR+ciiczeNrGfzrRABVh7fV4mAOl0JjqlXOMi/mVohjn?=
 =?us-ascii?Q?YmHaf6/nVfpQiP6M1EgZLgC5lsimcW4b97n67DETu4s5klOk6p78cL1NVVS0?=
 =?us-ascii?Q?6R213Gr+0vttbZYZi8l/9BXjtp1RO6mVuU3n6nh4Jh4v3aSrf7xO9hdZ3c5x?=
 =?us-ascii?Q?kcw0XJKDCEgdDlignZFw0pQ+N4v6xk1dC31HN11aKyBgeAK2KyoeAR6fl96+?=
 =?us-ascii?Q?VP/ghKzifOQc90F1W6ln4d217yxi28TUR5gRPzf/AbCkhWv1t4ddaWm16Qq9?=
 =?us-ascii?Q?43KC1OS+F4PthbvCFfMQrrg4xLEQkmxRNaSreEwdDJF7i4W3aR5ihKiZS9m/?=
 =?us-ascii?Q?m2Rsz7H9YciRyJhXVlRvHlPz+Ubj+fGrPeiIAptXd5NGzioui3tdJe7H2i48?=
 =?us-ascii?Q?+6Vk5coszQ5Y8QbPvr30MTJ1C/iDamPIpUQNFTw6dKhch0As+hCFCzBQCe4I?=
 =?us-ascii?Q?q5lIBFOie2zrD4ZBF61k3Kn6LrUoASg73YksHXB+N92pOzybortWLWqnmQ1G?=
 =?us-ascii?Q?h0SCej17CLlBW0nBZ+oMggo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a6489-ce71-451a-e8bd-08de29fe17d8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:34:03.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMws1IO/X4t18VAUC6Obqcr9i4F0gGwe2G3ViGInaL+FtcHOzlFZxulS+db5TG7HmsGhvQLXGA1beM39EM5cPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Now XPCS device tree nodes can specify properties to configure transmit
amplitude, receiver polarity inversion, and transmitter polarity
inversion for different PHY protocols.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
index e77eec9ac9ee..9977a3153f41 100644
--- a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
@@ -22,6 +22,9 @@ description:
   by means of the APB3/MCI interfaces. In the later case the XPCS can be mapped
   right to the system IO memory space.
 
+allOf:
+  - $ref: /schemas/phy/phy-common-props.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -102,7 +105,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


