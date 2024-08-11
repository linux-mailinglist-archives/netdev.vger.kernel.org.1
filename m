Return-Path: <netdev+bounces-117526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7062894E2B4
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 20:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D463A1F211DB
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997015689B;
	Sun, 11 Aug 2024 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K7FZnsc8"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBF848D;
	Sun, 11 Aug 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723401675; cv=fail; b=CfJj++Obojae684s2e929duwDB1Cne44vLNL6NVrgh/IB9S0WqXfxOutZc6EoeWRmHtPtJvWlWnb6cXRzY8G7UeldYIceTK080DezSNgqfk6UjLRxpZ/Sjn24aELe+bSOrtkWLVc5ApVx7CtgLPczl94m0WN/dqXIxL4Plbl4kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723401675; c=relaxed/simple;
	bh=i3oI6ZvQ/u453+nUSsnsnGLfXteaWy8DspBbuY1ZXPU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Wm2+xRaFy7yWvvz3bbAM5k+BVGky1u7PCMWzEFqP8rAMNq+JNXrSqVntenxV6KsoEMaPH5bVDCgLbKvsjkkSFXg/Xd4ul6HY95jMXhSYyfO/0fT6VwdOtJ0dsyo6VyFGfLSp3CzAgGGv2JcZBzY0QK6TEE9Z30EuVJfQ8KpPZGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K7FZnsc8; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcLSeHoMv5cT8NmoGD6FM59Cpk2w8V+YZzAJyqBeAsDpgmmtndnH6+gfQsA7ZWpisEexs8kR9rnrMcH4MLqovVqeHl/H/hwARkwp91eGSwAxPjfiVPtvmhbwr1LhUnjJu0Yk2/KJGUQj8vYXbOeaUNmsy38IoUpWOqZgZbFOz96oXhS8t9b6asZm9CMNirmMQzBhkU9HsHXv+/23nEeRXuDcK/RqVyLe3f/rtuj7fDm2BpQqMUJ4+TeuBHpdq8SJLzrNPyvG2fsR21y5yhV27xiOwIn/J+P2A5w9QI2yreSsC4EhDPQro0qZC46FssivCCpzCEnGH6KK1ChLFiKLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXDpHDsmnuhm8BT7j9G5JnuIZUhuefO+LtHfYWqV0nQ=;
 b=Nd1oGjaKPF1Tp9MaPMDMsMUfUk2AMIcG2/yYsUXNJKfud8XfHt5a1TKgqFoKRwBJsdYXMLYXYs4zSuzMtzlE7QzsWTbJ3WYcgfPaotE+uzeskdrVFhgfvcS3Av6R3NiMbxx7S2uU2mv1936G/SdL36j44YzLLtkFTzAI1aSOSmckOKiqgGrgEIcxK2jPoY9jzIzqUJxnlg2CnzZTrivJvIn87SPoohFI4/O97J8GYHXjNrIOWYhubfs+4V1+XKjxQIQxqg74Yee7rO6cU64fmJ8sCl6+0Yz9K9YfOROnVdcw+crrzhonhcgz4SDE/yHKj3AtBbcz/diYiR+bpAR1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXDpHDsmnuhm8BT7j9G5JnuIZUhuefO+LtHfYWqV0nQ=;
 b=K7FZnsc8vNJoeBZB+JJFPOdb04AiyCyFp1PDTM/fXv3liZncwGO3o8mt7VDHdtqRPSlhYrkOLegtyxTwYsbYDO+hZYaMe6u3mhMlNi9RrjSMTq/htRZzfW78OsEpPubiwRYSOOyu/lSSdi+e8Z8mxixP/bEfJhzEb0+1kg/qV4pkKNG4TBk7ngGpT3On3QwUu1vY8+9TuulidVy9k5J4eY95yzPc+uXfdSXuLu3Bc/k3SobhYXo6hGF9Ry25zorwmQEWWIOs0id9S+3XOR5sRuhzxHl2W6t1WTw4DV6Wxdt6s10qQYn9nEInlcud24gkB2zGUjPmCD+waSIWe2xcVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10276.eurprd04.prod.outlook.com (2603:10a6:150:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Sun, 11 Aug
 2024 18:41:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7849.018; Sun, 11 Aug 2024
 18:41:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using unevaluatedProperties
Date: Sun, 11 Aug 2024 14:40:49 -0400
Message-Id: <20240811184049.3759195-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10276:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fd4079-d2c8-4968-f565-08dcba352977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/Z/EnKHoDcsyKX73xys75MvVW6x1FpfbgiAehzA4mAN7yIVBsCFKc151N6U?=
 =?us-ascii?Q?imyucoxdczI5TD7wI0H+Uhw1SNLKhvJut1WSqWI9RGzdwRshnf2GxLj8HOhJ?=
 =?us-ascii?Q?EsS1H8Bk2+stsWF/AO8JCFuRWkzjXgR2h27g5+nd3AHAjaagHLacS7937vZy?=
 =?us-ascii?Q?rpVGRcWcFPkFTAjZ7KQg6EAIRHY2rcf9G/GtKnP1/35gt8MZM0Fuo3f4Zz1s?=
 =?us-ascii?Q?sO107HFxif8JHgXI4kaLuTtIXAlWnLO7eeySCqobwJlxFZbPhwfkBvKTwLTl?=
 =?us-ascii?Q?BRJkFJByjHS0TinYc3EB2QINcoiTAvwgirKU/HAFmzEcxR730/l+eQp3djBS?=
 =?us-ascii?Q?E8FHjZdsowTpnyqufNmppA++h/HPX8m0i0B6aSC4zTy5V6tqK8yQ1+c+IdjQ?=
 =?us-ascii?Q?0tmBt1BdCyVC1feaui5pUuCWfuNrTZRk2vH4htx8zfLmHz9F0g8jmWp6Cs24?=
 =?us-ascii?Q?hKqGpPp6C1bAuDv4NEMLrUAxVH9SDMHFFj4Vtv7kfnZcUnVUXHRavR4wcuIu?=
 =?us-ascii?Q?g2+WYGvvWiAwyNr2TXyRaU5Uyr4e2pHR5NVCLeogOOw+3BHL416Qr3hmcuiz?=
 =?us-ascii?Q?vFS01RGQ/YL4yOvJyq8VNVam0wFoJ+KzUq4ikCtu3WzCecOKKBVnO3exd9Yh?=
 =?us-ascii?Q?r+3CKQd7Yn7gXZFU6foxNZegnvFSYFXD+pj2hOYVI0cJm1722Kp9fEmwfkS8?=
 =?us-ascii?Q?6w36eS7pjn2cUkTlYsuem9QGdN6P+2kf+T5LKPbBjp3CdMdWnjJqWU9nIWRD?=
 =?us-ascii?Q?kWgETaI0UPQL0tN79p5pZ2hcMZ6TYPFfipTBmnk6L7w+V7IlYen66zCj7+fz?=
 =?us-ascii?Q?8XvyKp9Pg3iQQ0tutaer1icyVu6olTvWrAEd2qSsErqbRwf/NqGO1myz+p2a?=
 =?us-ascii?Q?PKLUjTx2kNXFKJPQfT3P9jAkPkw7A4QznOaHRa3ysvoxkQOh/OO30VGK2Rj1?=
 =?us-ascii?Q?4/muC1XwvuDHoUOtdaCCOnrLyii0JGxnFfJvXXSpZYNhqCBDm5anHjJvJfs6?=
 =?us-ascii?Q?x6s1HNEnsGHCUwwLpL1jU0lGpaVOGAWFX2jK/F6x0C3IFvr0FgASLfoS08YM?=
 =?us-ascii?Q?Um8lVvTW9Ml4R0W/WCt+YaptBUqbShsPjYvfWtvTyNrVDMmPa85fx7Z2ZHyH?=
 =?us-ascii?Q?HnA7vrYq7U9tYdvYKbNj59JzwpFd0a8HwbATcTIwYeB75HUBGjJ0srad5tVB?=
 =?us-ascii?Q?HTGyJk+eteWharf8YW/BEbxNbB0mAIwOeEn6/Jvgy5Ip3k3s76dXwAmV16+r?=
 =?us-ascii?Q?GHQRkTTtnazIH19U8usOOoy9NrAz7nlRUapjgRIp4iUIbU5kKkocHemfuaHl?=
 =?us-ascii?Q?6u3f69WWJ4/fx83JtTfDcWlDBZNkOhGhUpIuLO+bnoRTR8xYBTj88RpjR4Xg?=
 =?us-ascii?Q?j7tnCzTyt2/Rj18u1g/XSJUBTWOC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHELZ9dwg284r98rxSJbFqlEFQ41/D4FlOSreukXrmAGR7ZTlrEXgLI91XrU?=
 =?us-ascii?Q?rHnZDZN3zAwYbhtqRMp1QSBJFrFOK5S66vM8EN4z7H/qfMyVae7U/sgX+xVs?=
 =?us-ascii?Q?iy9FsbBo90/TSol6ufFMcMpsOQI89+Kibs0Sb3zySzFDjmVUW+JP/hUEDPWr?=
 =?us-ascii?Q?tHJSziOAVVjgwb92i5By0sba3nHLtLXz/d+StFsaNoPSmuZojpsDDVfHQo5d?=
 =?us-ascii?Q?xe1RDFyX+p1u6wg8TgHOmJEuGzctCZWWtfFEcUz5/qOHbJpliszXF4sgwIZY?=
 =?us-ascii?Q?f66k988WbjTYLQ8e03Jv79sjIbJ4CmZNM8G7P8+RpWR/PhgDXX1zWi2mswxb?=
 =?us-ascii?Q?3zCIYHI6DR35AiRaVAvbJ3/Vw0K9deSVPcsGxnC6fLI2l+E3BXsMZu/83zvT?=
 =?us-ascii?Q?J3DloaKYr4qunTJeMMNScmm/r6ZjhPeQV6AlT/ndmMt2o69ym36oOyBMuKlX?=
 =?us-ascii?Q?k/nHj36CkkXw7QDdTJQQNDyeTQRW/eJv7zmpb8wcGpxI3SuBF5SSnPuteta1?=
 =?us-ascii?Q?5BqnYj0P5DaE0uuLVmX5lbiEow7g08RmsyYozt52peeW+ENh9COeSnhnAFUb?=
 =?us-ascii?Q?FwC+qfGfeTKJ9nWisiztMgSiLHgeSwdiwKTJFkK89Wa5d7LtJ6PQrlY5fzVu?=
 =?us-ascii?Q?7g72en02CUa2zoY8VCyNtrOJ0/YJt2yoHXmyKactEPawapp1fdIGX/B+HeRt?=
 =?us-ascii?Q?Sv1lWp+6grQI2AyyHR/Nq84DtjSNnKI9fTWvDiOSAjO2P9uDeN1qElynNRm6?=
 =?us-ascii?Q?ItZQv4iBjwYR2cOxHQGpaRQzVzdJ/Ag2NpJ1R5jBcvdgZYUGXkl9qrYKouWC?=
 =?us-ascii?Q?gTKZFumjxIHYd+EZ8Rv5N8V8XaX7BWG41ZpTubCz71dqp6w1CwJqhgrYDHWr?=
 =?us-ascii?Q?oQ/VBwxdHeAfvMEpJARtXbIVdNSyqmzqz45jZne/O1/wqQNuLFxmyEjCF45S?=
 =?us-ascii?Q?6UFi9mhInH80hiKZHvINVIYCccAOaurbmHz8WXHVNzCaJc6fo9MXC7Zwzttq?=
 =?us-ascii?Q?RNoodMc/K1TX5aRjfrkSG4Elxa8HT4G8QqkReuff+UBmkR06OW+Sn6JIf+xd?=
 =?us-ascii?Q?Q9w01RlUZzb43tVFLsd9ZBvTTRa6oLKHaa+Wecwhx8WfNa9iA4fyM1Iy1fjz?=
 =?us-ascii?Q?RHIRmQJetUSh3f32PximWtvCtE5JvZCRSzAYFGDDZcbHobTQczZhI40qkp09?=
 =?us-ascii?Q?1D1DN3Bloa5gaSVTxwFrJ4IZbkcu6H1AAe31exc3vDqAE2S1eNXdjdLipS9I?=
 =?us-ascii?Q?SAUZ9bzqhhwWoVlKlIqIZEFTseTW4NOTQlyeizfD+Yo5vU8yM5aPOw29k8Lr?=
 =?us-ascii?Q?jXKF2w89M4Xm1sOLCKVsqcIWKTzxPIyTh3XVALMt5mQOFapllUoNtgCRI79k?=
 =?us-ascii?Q?LO04M0wGkS5G3kSpw+tyzsSHybR+Q1MxYGaMavF7KibOWZclt+i9PvWVf5s3?=
 =?us-ascii?Q?QgcAz0plAvSYQrmz5jCrO4G2sYkV+mmZ26qCCKTz17J23U9MmL79Rnu4MUka?=
 =?us-ascii?Q?P+xrFrIsw3MPmTuUUDuOJzUU8nx1OBhQLY4rIFqdRL6gbZRbynFjEgBOUIWl?=
 =?us-ascii?Q?M9ffQQ1iBGkByUJ39OghPkFrYdNrI8+i9N1wXneC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fd4079-d2c8-4968-f565-08dcba352977
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 18:41:07.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGMByf9z25yOF+BsvMK43G96VhYmysIWmgpp4Wx8OB9EBacVW1QhR0+yGpihGhyAXKE9SAirb5TkM+JqOq1wnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10276

Replace additionalProperties with unevaluatedProperties because it have
allOf: $ref: ethernet-controller.yaml#.

Remove all properties, which already defined in ethernet-controller.yaml.

Fixed below CHECK_DTBS warnings:
arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
   fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- keep pcs-handle because need maxItems

Change from v1 to v2
- Remove properties, which already defined in ethernet-controller.yaml
---
 .../devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml    | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
index a1b71b35319e7..f19c4fa66f18b 100644
--- a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -24,24 +24,16 @@ properties:
     maxItems: 1
     description: The DPMAC number
 
-  phy-handle: true
-
-  phy-connection-type: true
-
-  phy-mode: true
-
   pcs-handle:
     maxItems: 1
     description:
       A reference to a node representing a PCS PHY device found on
       the internal MDIO bus.
 
-  managed: true
-
 required:
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


