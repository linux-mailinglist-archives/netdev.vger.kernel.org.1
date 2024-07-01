Return-Path: <netdev+bounces-108271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD9891E956
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108CA283093
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEBA171676;
	Mon,  1 Jul 2024 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="alExPhlp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466016F8FA;
	Mon,  1 Jul 2024 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864907; cv=fail; b=pG0RPAEA9bKJymQAPFEl/y50v5kWfaKcbtlOBQPfW9WkR/q2SGLuFvGh/KV9LjLgKZ3PqC0OuSWAqClPnhsjsPcOfp35642BovcHCNAcHAIgqrbZcbgY+WZdbzCr9vBb+ssifsfHiW6VzYBsilct9eopd4MJZeyWEZHVHzCeEN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864907; c=relaxed/simple;
	bh=iKc8c6EKkRtAcFVUzl4MOyuruIzfmG0LT0+KI0d1/Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n+oE0Ad/DNYj8ySl6WdG9LzxtEC/e2f5L2jcQSSEox+Mco+XzQSo6R9U9TIBNqXmXEihHMuvB9HIDAt+KJNXwQ1UV3BPfguXh9vf8carKqua1IV2yoy26jsX+CZEWwgYk0NAbm6YvBmynrooYTxNeOASn7FgBtuhmZd+YYvvQn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=alExPhlp; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWQ9RGnQR6FA/8aCWTh+yVQAT9Yw9yKAL+sKYJQNoH3zRnx90YCn1Q9q4WX+jxg2ywk4/sKEeCIEF7z0zalCebrTOudzOjnVU9DE5hhTAbmjCUFj2+4at4hLp313GgxK5tbIoIyTQICM9Ow1CnSz9z7DEMxFxKDqYBUi2Lf1fAa9GXP4Ht2j0Hv6V52BfmRM6VYX94veVmtiu4qogQX5dGUGswspnoXwqudOx8WdF8Jc+nFuhLloiXBtPvRAnoOSRGLrFyzqbDfj06+O6v5yp1/1uqB4fiS3ibh+2YJFgaCXKF4e4GevAyH4kJ/Dtp7j4eDdj+sxtD48+IYovjYpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPeVrclulDQK1RCoekPEvIMTWQwQo+9HuVT4LokEU4o=;
 b=WfLcBkAcbMi8QDYLz7z/imbVt5AN2y2UTQg7YO7oc30C9DlmqhcghMAvhXcSLYhFuSzKSrcZVfyfjPGohErdFMcLNkGCuT+YLWQ4S0hUC8+RpMnjS61HwmBKNVoQ5MoHgsCEoLKyAMA5YVH0cylI+A0jP/ZsvLMdbq0bdcQ0p4iG1/lUBrpS0DJv3CtGaXsRbgg6d2bHpVZeoJt3WpCRnxr8xG+WJSjEPL0TlVcvW2/IhXHyys9GXF0vfBA/94OM/DsJGJnIcTWSDjEhEIIo2/dIr2kGBCXxdVulKOrWxLIn5Vr0lwCbuFeeTZiOYbQa98AwpqS9YKZzfTVqFwmiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPeVrclulDQK1RCoekPEvIMTWQwQo+9HuVT4LokEU4o=;
 b=alExPhlp2ZQYy9cfOKiwe7ThKHpUwIbcpKworPZey+BDk06XYImKO5NSb4c6LV0t3ZD4Glmfz9KrSrIK+yZ8PiXFBEBT0Yr9fGbn2BmYFGgn/i60oYSJyWaWBD51dRWLcc/CdLo1xb1p9fnf0sM6+u4uRm2frYFLHh4Xzvcoc1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 20:15:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:15:02 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: net: fsl,fman: allow dma-coherence property
Date: Mon,  1 Jul 2024 16:14:47 -0400
Message-Id: <20240701201448.1901657-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 6725599f-00fc-4b5e-5d89-08dc9a0a7d1b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?48I8Bf4zUtuQjyiT1AoG8CbNFEeIJyXAPGxgH7ZdL4HaqidpoTukpzOoq0j6?=
 =?us-ascii?Q?0U9f7lhn2pOmezTEG8BwiUFOlc9dAVz0a/J+WjrrkqvKE7NiPA8urNs81bcz?=
 =?us-ascii?Q?8Xs0O5SZJWSJbwTgW5NCKxAzvS0RfO25+jcdSHQIif0czdk9rmD8rQgkDfOc?=
 =?us-ascii?Q?HTjmR424tclkz8D940BsitUXB+MUMuPaJpCHFBS+X+PR7c4GS05CJWCwo+d3?=
 =?us-ascii?Q?eWC6To8LNIF6HI66JZfywUOmQsQq0Qbv1N0hAzcOx0vs28bb7KZHPi1qZhiN?=
 =?us-ascii?Q?3HO5IO6j93OnlyhGDJDZ+aCmqqpU7MLv9ndcA9op4F/9JuLlDmAgvOBNQC03?=
 =?us-ascii?Q?DrT++ZlRyNpeWobLJUNldQWEVCQi3wOtme5NUaCapQh5lR2nLNXDIYAX5rhs?=
 =?us-ascii?Q?d2+N6LhEVkKr3SP0fp0IvWbbrzJieOvmHEjy80gNzYnLTohJtMZSf4qyeC8s?=
 =?us-ascii?Q?d5ygLMoLrpQyBVk6fLgAQa5M8nX5YCxSHbsGc95QzgqfEajok7UAQ5VeU1jO?=
 =?us-ascii?Q?V/MPmFKmD/nfMEMSjgMC74/boejZZLJ2FMZ413oLs5HeIhZHXK+SFy/gyHgV?=
 =?us-ascii?Q?fWqtQXSb9qABmTCv7YeZti2n+P2n7Ip0eT8nvIGchxf7kbgYCGpbrfIVIKri?=
 =?us-ascii?Q?Vgf7D567EXwCVFci4UgLDktsqx8lY9e8nhbDw9Lcv5/PEgTsxqtg6Wij37+a?=
 =?us-ascii?Q?q1pxc6qoMQrgL7Tg/9PMEyfiBZlYDN1aB8478X5u9sbbhFq6ulkCFusQieWK?=
 =?us-ascii?Q?uO99B38J7LGconX8Cb5xBT6ZQwxjHyWm7ti7e9vHCqFGODFZxSPIEERpW6Uq?=
 =?us-ascii?Q?Gg0lrewXEn8B7i98eMDmincKYtOrDLGipCyoAKAcdb0XxEigdSO8Wbc8e3oQ?=
 =?us-ascii?Q?RGHuOdCVChQJQcJAE0eYsiws67yo1jhSvf0xWQOeawT/Tcv+XdrNMNwzwvs1?=
 =?us-ascii?Q?gnkFavf/PsNPsT0UPa/mk/BWE0tdv20R2bgGyFhYdZT9L7zwR3jnbJlXX0sw?=
 =?us-ascii?Q?M3Xy7eXrHwXo/iccXa36Hn18aq3YOev5chFTtrjOEEEqLsLYA0gfvRT377Sv?=
 =?us-ascii?Q?cyACKZpLGg1qc+ggfZgbBKtk/Tj/waAQc8LHTvDLN2/lwvkTfFrncjIDV3Ak?=
 =?us-ascii?Q?rDPUHR4t6557afSet5m3saFJedXmjjb3zGY3lBotOj2Z+7X81uMUwO9ha+bE?=
 =?us-ascii?Q?wLHU7h3EgSEE5VGXU+bavl+eQ6j2raNfhbywFc3K/RTos5o6fssuNMp8txiF?=
 =?us-ascii?Q?HoIHCaAQA4P/MfdChZJ0hCEYwbH3ZRw0xStfXayNxzUIBsxfsVWaFt4EXEMC?=
 =?us-ascii?Q?4LsIKlSx094Xb+PiT6rARwouhzPeKGnDGx268AnqJVr+vDIKS1z80SdGpNC7?=
 =?us-ascii?Q?nAScHj/UdlJRcXyGDyopu1DU82Kh?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?nIqz+BsHnLVWFHaH2hPyyQ6yrPcjsXLysO+cQPGZw+fmwTA3VQdOhnUqimcJ?=
 =?us-ascii?Q?h4pzpSoYdeVr3M1z3Qn/tvVUP/G4JKBip3k99hvYSKHSdcLNepbeZ1U3qdjP?=
 =?us-ascii?Q?to8XnwlsBPMaWdyx+yo/nhJ4LfDNSLQZqvF3N2wTAr7tT9E7HtkkGH/D4C4N?=
 =?us-ascii?Q?Lu1teJwekg/O84oWmv0NaNlM4VYoNB+ZeNk7T8JHFWTmORbaBynfqZpNh37w?=
 =?us-ascii?Q?PFWbp2Owvb+MIHqczqYrfVLMFATa/9va6b9QlnY4URaI/f6V7Nh0EitzkDae?=
 =?us-ascii?Q?lHFFLmH5J7u97Fi0/W/cpu63RSdSbekBW9so5jHf6IXBJ5T4YH7uZ/3CAAEk?=
 =?us-ascii?Q?pq04iM1n+KBdFa+XCjxIktA4YGd9ujyzpb02kFKIMjUWXHFjeX549XMHKe6h?=
 =?us-ascii?Q?9S6TDNL2DDVCm33RlvAAad2fY+kbyneUOZzWcR9YEdu3wbki2KBXpLJyJXIx?=
 =?us-ascii?Q?gyRu70L1z3gNabyT53HT8kz6vha7x2JMSLcgofWiP68ucMrZVALrMCpuHHKz?=
 =?us-ascii?Q?VngRwtI1heLuju4k5Zdx2Tx0aMlYWjyJou/Y4cVLXteYEBAOOEgKroyMltyJ?=
 =?us-ascii?Q?qIUSykzjxhMzmCosZaKNzlgpM9RqgqLlg/6slYQTn8NslF0v+SMa6GalnXM9?=
 =?us-ascii?Q?53mq064Xsk0IYadr15nNjcyhm4E0ioD4kW8/p2B6P9F23Iy6HIHqqfC/6DEA?=
 =?us-ascii?Q?Y4AruxKps21uX9r1juhzkKiygzeR/2acewRPcP3wtZgd+OKNZtB10184A+9B?=
 =?us-ascii?Q?fTVBkn3CCKNH4rCn3KwyrxPXLaXnIKBygMXvSIQYA1pcz6iUM2TdHbd/gI0A?=
 =?us-ascii?Q?ON0sC8X2sZ7+h+PbhqhmdDEtITfCIPGZV+ujxirnmmzAZURODGziPdCWd3Dm?=
 =?us-ascii?Q?WyiIOvjs9ifFnhEHhtcqeyu4RClwXaezAcuky0/++ov3fyOD1bhIoWIQ2Jgo?=
 =?us-ascii?Q?ZdCG4mhYlnB+uScuHDxZuXS25u7choynkSUfrkE9LaGJcOS1TDHNY4QKAzI/?=
 =?us-ascii?Q?/uAXzmhyApdIgwTHDd3sx9bWNv/fF8GWRkMRrUAXKMNAoHLCmkWMlCY/nJ5+?=
 =?us-ascii?Q?9a9tDcZQh5VGah4+x6LNEKvmPi0u42k74dxUNUxrZX+igIOQo3SYJ946uj7a?=
 =?us-ascii?Q?BY31BHjJBG4lUNlIytfnPBz70KsTCUGf0FSbH45Uq3RQqP4+y+XRn3Pl+vpC?=
 =?us-ascii?Q?pmN7cZbmbjfSKwOSQQqeJsojbeZCbZ3j5ZWF+CcUEZOyGW9BvOsKvSvc9Etl?=
 =?us-ascii?Q?KHB0S/fbzcy6ZBYO48ZgufgqcAPhzh/1gtqIOoAxFJx+mdTHDwFff6+fk2z1?=
 =?us-ascii?Q?YLuUp4VQthdCzYADAImwbwQu/e8J75FP4Xy3MuEXo90MM+r3P3BikoTlNPwM?=
 =?us-ascii?Q?zVI+2fLygFcueHLkXr6tSH2+FBDd/FAMEzJvawlT61L+gianrY22WQ4EWRmB?=
 =?us-ascii?Q?w6htdzgkDZ5k+nSVr4xLzxaOZiXwXm4UqYfB1VkcH0N+cPvxvKFdYmVTRlsQ?=
 =?us-ascii?Q?TZrjl1S64kZ3SEQS1PgdWzWDL1xP8YtePOFAyR3n82DRP1tQRtpWD0UlYNn1?=
 =?us-ascii?Q?PoxMK5Py7hbgtxclVyE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6725599f-00fc-4b5e-5d89-08dc9a0a7d1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:15:02.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u49TV60cVUGH3ul6WjPQKB1QdjJ2RalnUUNbDl/qaTJwhcKyh1JTCUc2PI6KVzzy/jj5XRAwcJrQuFozaOLMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539

Add dma-coherence property to fix below warning.
arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: fman@1a00000: 'dma-coherent', 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/fsl,fman.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Fix paste wrong warning mesg.
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


