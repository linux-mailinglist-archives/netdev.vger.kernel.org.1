Return-Path: <netdev+bounces-107830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD391C832
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 23:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB800283A3D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DFC7F7C3;
	Fri, 28 Jun 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="czyFJWar"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961C3FBA5;
	Fri, 28 Jun 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610659; cv=fail; b=NdWxV6fOwDayRWWm5qzGs4parKI9yXij4OOoHifAzFiLeao19jHx2U8eYpFr1d+BtaWPmNiEc60VY71K9BqaGJn9UFeVeFbtl3LDMq3xjoHYlcaTB0CfK1tn4FtujY0UCpba+V5ipVazeHNJxsE3ZYhdvtUu6g0ldQgnc7VweUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610659; c=relaxed/simple;
	bh=AS6CD7e8vb2FcvaNm/mMenQRk9Ljb5D7PXsgb5E9b68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jle0Y7Bb5j/foXTuY+uCqw5749qyRKHr3A00+sAyLQa/WvUsilEkRF+Up9wA+Kgza006xPHNPJbSTo1ad57xy31USZ6oqTS4H+by9H10+AfeTplOP2TcVp/CvtzoQ1W4nwTqYjYSluZAb6llLXJWwTPL7ZU4KUluMJh83ayh1Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=czyFJWar; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvaEZIfSNQ2BbLyOr6XVuZIgZ9KL0wzb+68s1DXZX3xDujcsGhXKeDf5w2rT2oChIT3KzadzKpdNmTKC5lezE7HwxRlUKAyEVgy0ZW8NIHiqkvrcxURfzjx+YPzmjaQPH1NrNUhjQiLAwxndkgMH0Juxb/9a9PE11Qsek+IH/MAZaOyLhFg9Ui9AuwjyuRpsIdkdYnQvU8QgrZNRsAQGVUTvDLg9S+rk2dKrlvtduoAj5rDdusLVuXvF0rRIFozjd2QRs4LIYYPPUorQ9sfe7N/ecZXF0UmfMTrxjziyMsAx+hrVGyw8Nch+FbW9urM5YYlN/dqTzHvM93UKYrLwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIzdQLzEu8sguOhtosnhc93kz1FfCq79mmN1SzRSPAc=;
 b=KnNOP4t7g8VWwAXCyK5GHTPXofJMOgzyXJ+hqODRQVx6GLzStTJNKeuiIN54xwFtDxDZqHUx4e4Cj4QP6qEBgDnoE6WwPaiBt+xZoCfTdn1art+F8Zg8Y6oJ5QaXYrLNfgPMxrixn8FC62o8stBJplf2pwRxYTsEl8x4q1+fJnjwlDcSq8bDgFCH4BrF/fdiZhWUDMzCxPpkmxpcECBccc1VXYU/ZNnN5G4WWVcdqLc8D9f5viiC4XbIujf+dRxtDN7Jh0b9jCT4gGhzrUuQgWwB6YLSeOOvMhY0cos0aijIbWvVBB9RxSm77QhLHXV6Qe6rT+mCmJAqEBIOpjMkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIzdQLzEu8sguOhtosnhc93kz1FfCq79mmN1SzRSPAc=;
 b=czyFJWaryQmYmCN3Bddl3dG49bejkuYpJDy62Y4cLKH53UNmsE1YU/ACPNrQYjPOmnbFRlndubmlZwy463x76hEk6qtkMj5hERSW/a2jkR0ld7WWMSgKl0SO7wlWVyotcNIIMrKlUpQq/m3fswF3HIQT/vog4d/W+JUEaMk5xwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 21:37:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 21:37:32 +0000
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
	netdev@vger.kernel.org (open list:FREESCALE QORIQ DPAA FMAN DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/2] dt-bindings: net: fsl,fman: allow dma-coherence property
Date: Fri, 28 Jun 2024 17:37:10 -0400
Message-Id: <20240628213711.3114790-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cf2c03-54a1-45e6-918b-08dc97ba848c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ewZsXwjUXTrkIpBCp9uaKufDf3jewc4H1rehYKxvla8BN5x228Mgz2FI7n/R?=
 =?us-ascii?Q?pE2Es2NnDN/pOCjvkArA9senkrO5xJD9MTB9XQ8A15Pqy4LEpsWW9Tx1wk3r?=
 =?us-ascii?Q?n47AQqM06EtVOWyfuXpw9z90WZvpkuF3yr+cSLt/zJRCZfxIb5j7uYvGAYge?=
 =?us-ascii?Q?fUKIxnBIJ0dZUQsEP+gnsODHveB15MfsPTs1mUmATlPhD8uUvxNU6q2oLGGJ?=
 =?us-ascii?Q?vaCDyga6TPAnY6BRULkEJxkUL08Mibv7erceQT0I5QzSowAZVzetJmQNBR0T?=
 =?us-ascii?Q?Ny7aOO3Y6GAnpSMcCNHMFHZzGG4wvQN3SDhEgtjhOFD4v9EQ9xa8D2CtLsBG?=
 =?us-ascii?Q?Lkbt8tz3lTa7E/n68ZL0pvWDi1Kw9tnZdeIqQYuKbXnrY0Hz9rY5ckHijbyh?=
 =?us-ascii?Q?wF9XMoFpQfS14Znjws8tUEYE3XVZtpRo9i8MEblKM24Set1/u/r+hU0wGon1?=
 =?us-ascii?Q?JqiBlGJ8zEfBySpYQV9IlRqHim0CW6D8bLNj2STowNoDQ889QefnAdk7XHfw?=
 =?us-ascii?Q?EnCVwPJqbCs4nXWBRfdvy4lqKihH5QpQWMPUgWGPfdNIYzVU11IlmJqgnCko?=
 =?us-ascii?Q?/d6QI0ljgaApVmqDYP9hjNYf1MKDJ4SVZ3JpnG2UjXZPG6Dg0Rnh9C8PHnmm?=
 =?us-ascii?Q?HMa3PCZff93cKgnuKKaXEz4fiMiDXNCeWsy2sdwm2g4POwiDVA3vhJHy+oh0?=
 =?us-ascii?Q?31sr9vjwr6kDldn7bOkS09xd4gEBhgMIw5by/iAU0WtZZsNHt8373utGWMEU?=
 =?us-ascii?Q?0dpjC0x0GOcaUmmC25rPKIE/2U2r5nDF1wwyM/jfhc09gNTIdXmKZuoGtp8M?=
 =?us-ascii?Q?9VTiCA1Vyn/8TKFPxTRh4uoGaybzZuCqIBp6Co2n4WThxF6P/4Q0xkGxSHsR?=
 =?us-ascii?Q?p8EDv5Joeas9StGXMkrynnLydbUjZBV0KgU+T+vvcDiHhgYJ2zFBxPycMszr?=
 =?us-ascii?Q?Rw338pwidLCEMc0n4f1pKTPwlPHQLQ4Wny1YL9XKjhGpNBbIeh3Fs0q3ts2J?=
 =?us-ascii?Q?sBHy1+Q7ZGN5VlskJsM6vTQI/nu2cqidIhzh9Ym+B7+7LBJaJT0J5uCmRJE0?=
 =?us-ascii?Q?gGK/iF0cZNswUbfVD6ncm0wMtfAadeRaDd8Y217T6lLb5rCXqLoz7gupG+Ih?=
 =?us-ascii?Q?bcS2tVGJAhL7e6Ccj5ITPZmA09MpaXfQryY1ipVcNOlVFVrrbU53Q4EjjVRA?=
 =?us-ascii?Q?hAcU4uz5iAXSH4Gd1OLEX9R8hgys1yBciXpZGYPN16MxXydxYdDQV1Bpmtsc?=
 =?us-ascii?Q?jyA8nW4u1B40Ij/GHp7ARyfnhxSi2OQouqiH/vqOgFn2gq08ncR/XBYIrvj5?=
 =?us-ascii?Q?6UobAUpKRzjB3OV3R2ilrbkDvaNMeL85xb+LRYVwVZa9OIEa+6YetZizaKwd?=
 =?us-ascii?Q?5Ci1WU6D+E+iXxwu8uFYnE1ubtk1?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ZgkIOYqmbzPZmLp2FuVQJmck5joDo2Q24bFJDcoXUdaoPw+cLa3LtshPF/NP?=
 =?us-ascii?Q?SGgju8L1IAea0N59pshk+pNGHuqYDmx5YiqqTRlgGPeP3AJ6AEIkzmnnCgyf?=
 =?us-ascii?Q?gGQthL6lpIplzz1SxzKt60vBpdRBeZ7Xg7A6Ru2CVOY4LCIecsyrI51/+xhv?=
 =?us-ascii?Q?Ys60oTh/TZrQyx+jEsO2qg8EbeRGGOnYzXdp4d7s9fVqw+dLvfiaduTpRp77?=
 =?us-ascii?Q?PJAAIJQgkdsCNq4xixDrslFwMRmfRCA7jvfIzL3rfCbAUxxDvgauICnzo3MD?=
 =?us-ascii?Q?TKLxY0jkB+/TkGmgQ497Mw31qatJnhcfCdWVFQq26cpeRGrrk4EhqTTwhaRN?=
 =?us-ascii?Q?w0Gcwih/DtxAJ+MKCPCuNoWwXPw9xE+kSDTnjKvE8l//7o9lV0KDYcj5daFE?=
 =?us-ascii?Q?w4CMf2Q/PBRY5Sy6cSDkMzx6N1MTgZD88Sejl6/BsZBuv9x2RGAxnBAQwx0A?=
 =?us-ascii?Q?V+7LLgqtlLX4wKd3gvbuMZ/segDot8zKTURT9UgBiROpIWqF92HaODqE+PYt?=
 =?us-ascii?Q?5ltug3dFaCS+dAR1ZGEQDHwokCT4+mKzfp4vQRZ9oE30yWkILM4wFVz69lGQ?=
 =?us-ascii?Q?GneXz0eLYPj5nfnxWy6KuwbxTCARglBEQ8jZTxQypn8DwbrP1zh0lfhEMmUB?=
 =?us-ascii?Q?Ziba2bL885StvG2XWbCYmj/eYNjkrZSPKIQ9AED66uhCJjSiT38z6wIymcDS?=
 =?us-ascii?Q?yLL/1+1jk6qiv7pO6I8LiL+GScCmPKE9EEY278ITv+aCouJxSTO0EZQz84+b?=
 =?us-ascii?Q?jvqPT2Z6GU+j2t8sHYk5wMyfJjhuacaEeObgWLnOS04i6N/Tm6xmFdAgd19V?=
 =?us-ascii?Q?2VloDeuvpZ87qOyOnS0ALEK4zy/rD+Nq3A/vvnGeMxfYV8EHyAy0Typg8wZJ?=
 =?us-ascii?Q?Dw2rp6Vtn2RFdZ4Ldc46sYzKbQ692WZ1X9n1OKdTw5MRyOSq7LwxBHW4Rs0g?=
 =?us-ascii?Q?VbDOSJGOz9Aw3AvZ/OKkGSN+Z1eBCuUhE0as+JC23xeknjUBTtBjQIVnARoK?=
 =?us-ascii?Q?Tr0N3f7x2mgJ/K3Z3il0S8HfVhk1m0tsv8GFyjPCeSIIZ58bM99VbXjfaqEz?=
 =?us-ascii?Q?qBqqf74p6ixMrVD9Sh+J1y59kRcJWBqb9McO8gWsZJa/5wUkdVkG+pQ+HjWG?=
 =?us-ascii?Q?+y45aBIJr8e01HDEesFK0MNnQGOiiu6ak/qSEJ6eS8EQf1o4BMFir2InEKo2?=
 =?us-ascii?Q?hfU7ZjzmxL+HXb0a0ZBKBsm9YlIxDzLVSZz6TL10HZISkIisLq+vTyorWSob?=
 =?us-ascii?Q?5F98hgETxk3W8HMvvmrGCimpnONLEg9cve5+anbPwDmiYdOFcHW9HARHw7cj?=
 =?us-ascii?Q?zp+yJuc8t/X4/uDMDNE8HuNfwztt71k9JYb3y//sXFa9ZFsRS1xQV2BW/yVP?=
 =?us-ascii?Q?8KG7QZqqc1wOL4f9MFG38zTFpzKe7oTza6qb8ObuUxYBpR4vy5xEeh3jEQSa?=
 =?us-ascii?Q?lyuTIv0I3nSQ8GDaLrpjXdY2tRgl2HQ50s1oLsGjdDs+7jDCw9N0/yOG2DNP?=
 =?us-ascii?Q?odanTFanPYejtxo+p/WgB/TiJTXgY+GUCOyAlLy6r/y5OGT+K7YPoyKe5DGW?=
 =?us-ascii?Q?/WI6nhePP89cGvxRvCBAWEByiQmfq8XwHVgIWfg8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cf2c03-54a1-45e6-918b-08dc97ba848c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:37:32.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHCgIgf6U81A0cRW9BnYck3MA9V8QCgFWf1lNaO6vHEFyAisDKYU5dxXYtyBjUUO8TmBXqoi8k1nNWsEmIF50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346

Add dma-coherence property to fix below warning.
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: dma-controller@8380000: '#dma-cells' is a required property
        from schema $id: http://devicetree.org/schemas/dma/fsl-qdma.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/fsl,fman.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
index 7908f67413dea..f0261861f3cb2 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
@@ -78,6 +78,8 @@ properties:
       - description: The first element is associated with the event interrupts.
       - description: the second element is associated with the error interrupts.
 
+  dma-coherent: true
+
   fsl,qman-channel-range:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.34.1


