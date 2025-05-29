Return-Path: <netdev+bounces-194265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D33AC8284
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 21:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F4F1747D5
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334B207DF7;
	Thu, 29 May 2025 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ReKOhiva"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB04685;
	Thu, 29 May 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748546272; cv=fail; b=S/qnJ9t/ZsLPWb6F24LO5JdiVWLy2u5Yj6tlGCJ5FVzFqKoDS45G4aiS/pNzI71NKE0Brey9vCERKMHNC6xBWDpRP5bEUNtwgCvuh/v5geEvkBxkDV+gUWLy0R1tzhwpraxzgiT1shc2kmqw1M00IPD4hsQX9gD4+KHfOLkbdBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748546272; c=relaxed/simple;
	bh=zHoIYoltDHzVsq+c/T2aFqrB72xgvLnveQGWWIQn4wU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PcCTyKSIBxKXziW/QakVj2jwkN2XQIiv5UFkX27Dah7K4mGbnddOi3XFmwef2cFRabuOlXSl2UrzQxE/J8OTIcZ7PTZVKz3/Rg2JM/XcOivEhvoZF7A3Vw9qyTcvH3z11QFRo4FvPnTRZOwZoeyNGeRYmAjr7J6rW0XPsrEPOTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ReKOhiva; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BX7OkvzHWC3X9QNgHdou0+B1Ybroq+XDr32seHldGw3zvnYyxxzV0obZj4DxwGkHQ2o2wKdOdTc+hTVDGTq9sRtUHrLdkwn5v6xH9TAz4fmmnR0knVq4Xc9dhUKsCL9Xzm/eDif1X2xU+GIOeoil9XLDxU/R4hvULAJC9nAwUAcYYtpt1UuzBmT8RZfbIv+5w27LDFmIVjL9fSEbgWce2vNHaZmJucJAueDPLsW5Zcn1gWwQalbHDTEz2ftNFSnXcSZJKfRFymIr98W60uBhO+enJTKnmLHlL+2aIZ+P4uAl0Gg9UZWCyTf1F5fFrweSJkzzcIUQDUJzuKIl4LJFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZABEvM9BA3cBp03HFKfk4iXp76JSmGdLSf1WUQdeBs=;
 b=a8W2Kbo9Wi6SGIR9gB0+w2MTDlGHA6nybSsCBya+qqAR2NNzr7ia/3WNfdgZKYXuLbBWt/AzdOVc8WYyRLibKBEPHmsxzLUVqhawvWS+NILqUS72qsLGJ+OPeiiKqw0pBKy8QrnktvB/v/g+5ftirFZ1Dj6lZW+BXCCpOF+8yJ1EiS0DpV9qcTL0YaDk7MFpySODSJj8ju9srlIvG57HYLO1h1sCJ2Q1Xwhp9RN4KZjjWryrIpd2hIYWFVm/qRrthdVivmhru9XG2c7OBG3FARFtXGBHx6tCoH4Gf2wXrMT67sbRbAUcdnTbcINRjUrkwIodHIGgM+bo+FeImEngSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZABEvM9BA3cBp03HFKfk4iXp76JSmGdLSf1WUQdeBs=;
 b=ReKOhivacRhEBNdrIKbcBHvJ0U+6GKDD+ZdUZWu7QVRZHe0dM0m3RJMdVQ7q6vdDGxvFTpbpB1FamyTyJgcbGR7x7hCzXnehEvMZbiCMUwFhdX2bIC9u6U1n7yCmpgSKQ9d3qIc1RpRZpvH0HmXev2NpE3XwdLzuGdr1opMNRL76C9mtU5ei9XyM1y9b1rWD6i8zfRlfU/bG78xEWEnJSQo8RYY1TGyWHdtUGvFrJCvAu5f2RaEElUTdq6N929V0xMG1l7Vxj4kGtxE2leNmIkT/F2k/zcYvx6uwJGOwoqFhd/87KLkVVb97T5BDE6Js10T3KzcfFU7JYsGW3iZktw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 19:17:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 19:17:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
Date: Thu, 29 May 2025 15:17:26 -0400
Message-Id: <20250529191727.789915-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: b27a43db-ac54-4f28-c0ac-08dd9ee57ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgAr9JxdsjS3JY27wqgZwmagF0cTZCF2GuF4IaHG4yp+kigkEd9G/gaSrDAx?=
 =?us-ascii?Q?2o2m4Y/QfYHUb8fMX1huzCzgxSlJiy/mgphlD/ccVOUWdD8LJ4+Y2JOI625N?=
 =?us-ascii?Q?mZZC4H7/Hgo/ELD19MO7kBalC/hEyTWpJ+f99uKbESm5wkmUUSkr0qe6/Ukn?=
 =?us-ascii?Q?zsuUUqm+RHWWRqUn91rE7LnZvZH0dQuG2VBEKFn/UMNXY9ggH91pEP4E1yYA?=
 =?us-ascii?Q?WyzXSVPatnHh3mu8yKR+1SQXcyGhKLeP7DfFTw2kulsYJB5lRxt7vvjtPnID?=
 =?us-ascii?Q?DCUdeIBaDBT2OXax7aIn5QQU7DispRGdgrIlDVVL55DEYIzc2MlG3vOIroF0?=
 =?us-ascii?Q?m8uKc8fl2g/jFiLbeCn4cfEHX+eAiOFW9lNR08a8DYUvEpafDFX8pwp1aXCy?=
 =?us-ascii?Q?FAhLfnnAshKlx08T8Om9vJ4ViYdK0KoUMg+/nIcVgZa7oBDxk3q9zXJlb3yL?=
 =?us-ascii?Q?j7QV5avO8yPmza/WmGRVYiDHRjkmjefcVy5JFh+rTkuj7p12Wb5xhB4TH3Y+?=
 =?us-ascii?Q?HnM+Mqlo4KRPds32g7MZ3RE/5HSN+Q+LGwp87vYX94+DcBrY9mpHzqPCs0e7?=
 =?us-ascii?Q?S1CVfAf8T7tlck22iIKV6pY/Dx2PXjFMsft/rlR0o5NrywKOIGKxt/TayLpw?=
 =?us-ascii?Q?GfBEdZFj/G3gSa0MTtTCV6ULWll5vPCn26Xucb6uOLILw6CzTaFvocM4gjFZ?=
 =?us-ascii?Q?/ROKwgKQXHAHZwNRsKAVKEYlrYpw/ym73JT1vIulI5g9eDxaP/Oh4kQ6seoL?=
 =?us-ascii?Q?iNdn7E+7cReg7FwId0XdhAJbrADPFZVzxVIE2XTtVcNg9w05YnuVfTYl9N1m?=
 =?us-ascii?Q?vhZ0j9TKk8TzjJrkyoG+iTdhpOzfb9gVnf/h3ks7buOscUiJ+tGb/AD3Mx7h?=
 =?us-ascii?Q?hI0r+EDDQYKRynpZ07nZ1TuUNA/7i9AnP9neodoVZFElqNedFtP8/DGV8K2f?=
 =?us-ascii?Q?K3aKWL8rAqY5k45JHh1xkS4sk6uAwdusLWplc0MJoMWqb878HTTHHKBFkeFz?=
 =?us-ascii?Q?n5/+rAwbwgr/EefUjGnaQaTRrorKPXp1RMapC15LFtP34f+H8yj3TiElLA1Z?=
 =?us-ascii?Q?xpGmbF7Qpjh9rN86css8R1xsFzwXQGe2DU4tfuAqhLUzAB5DTcO1tH7EQXLI?=
 =?us-ascii?Q?IOE5CejmJ+NyCj3tkI4BvuaeKi5xB7dxFIuxDpfsjVloQvEC3vrF8i/Yxr4r?=
 =?us-ascii?Q?o1ELvXv/C/y7tAwbdSBThPp03r34b279hd+xo/SQQ9B+zeFn0KVa/8xHRrho?=
 =?us-ascii?Q?6PkLe7iC7duEMe1lEzzJb11VcbcQU4c6WpHRgJOdENhjCJtB1AoLEl2GZTGP?=
 =?us-ascii?Q?uxPLWZ2EOMvLhJ1yWW2BZu0UR70RjJd3At32bpPBaPLaUkfA/gg5af3nV5D5?=
 =?us-ascii?Q?wdQrJGBmu2iWifLU0F89iJZRGchuL8r1jlPRg0cd7NlaLuN3A51E5agop2v/?=
 =?us-ascii?Q?1ar4LwAJpIp6a6XOboAVkM4IaK6YZuRc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NjcotN/aS+3GmiPO/BzuM/brMvCDUxALXKfnHTYURODLyVJLUwYiy1F/s9C6?=
 =?us-ascii?Q?WwJHUHvb4U0Oe3x6OCHTSZFvZHvqQivEByv0UmoTP7YXJN3jXeRz0X/UerBp?=
 =?us-ascii?Q?WVfWpp3Uc4B70k5vp7Xp5Sw11gJPcakpbkvn6BXNe8+bPyrRl/QAMsOexnCX?=
 =?us-ascii?Q?/jlWwngDRxgylcYyIQrqNhS6Yp03h+9DVvNrnvAyEtrbdZ/qIITvr0Og8ekn?=
 =?us-ascii?Q?90cE6PQcDyhAyLr4vF/OeZLybYf2YwWOgpKCHTmSfh/n+biRI+FzyDJwkks8?=
 =?us-ascii?Q?FnIDHNPCIMafe1JLyw2S9UyU6tcPbd6t3iE6hXcxjyBJjt6WD97Ap6SxWvsG?=
 =?us-ascii?Q?mjYoo7vKvq5vmSjLIyu8JLzieeji8za/GAxnjU5LsRv6W9cdGHBRb2F7NlVg?=
 =?us-ascii?Q?qJNfNeOOmtqCMU5gKeYVlfwvVamP0+uH/BAsGzBWG8+gXZppOGMFxaifCT0t?=
 =?us-ascii?Q?zugEWbegQ1vdF9gyWkG6DHH8rv7sY3XdNDtaGlZlXWl/UqVoguzfViL/ln6B?=
 =?us-ascii?Q?ucrzx43nPRhI8VNNJ0UVQRszlF99sQrgBQuLas2q7YFc3GII1w1HE7UdYYbS?=
 =?us-ascii?Q?QIxRaSzPJKwsoHYezIuwsxoAEIb/l13lNH4DZPm2AbXsAKdcR2mEPqyInZWq?=
 =?us-ascii?Q?4hMJa0QK0hp9TuYQYGpQNMu7V1qYjShrzDvlk2KIfHGWjkhTwkd634DUDJda?=
 =?us-ascii?Q?4D8R2uilcaT6OU5zzs6NIqOD1K2kYKAGbcylUHZq94Ga2C2qIWVpJ2gkF7R6?=
 =?us-ascii?Q?0Bn+nlN4z2N3M+2zBw5FywepqX30S0+BcCPK75udWeffjU0X5q2BG97agnA6?=
 =?us-ascii?Q?lKT1B+JQYJiLtLpcY1gAjhiVmztmTAgUTUETg4WklkyCy/1C3saORlDNu+eA?=
 =?us-ascii?Q?gfx+L2iaCG41Stt7E/HMNl+N6xPDSiOlaBh/s7+o5B23SxV1sCR0ZFqNmjth?=
 =?us-ascii?Q?blMRtS9z6RuU7QRK71sglVX0Ny5SCIXdlOY2dqmVUYS5w/16QwhJoqxaSwFb?=
 =?us-ascii?Q?CYPQBFAK3nEaVqD4k1KsC+aiS1H35HOhBPi/lm8j4vN+IJKgFe/TEadr1jRk?=
 =?us-ascii?Q?wG5hmyJMnW/ECn93+uxpeNSvsL9OV/Ex2YjWlUnV+rDc8CM0AyNymzbI+LD9?=
 =?us-ascii?Q?yObQ1FyVGDX6KYZwCnfwLMKPotrbELmEOjsT+i+Exgyl6dg9HLW+AAQAKxUj?=
 =?us-ascii?Q?IdPP5z+rPLYvySsG8MXMpRlmoasSSF004Hfdq4jUpu5C9WEUMNTXkNGjkX2s?=
 =?us-ascii?Q?soa4HZfDQpEsiTiJiBcQC7OHMkTnYuUv6s8KVswNiQQIUPFja+L/EXHwAdR1?=
 =?us-ascii?Q?GVMGwct7ALRDoE0L4A7+qW3Z/q3adHQHwx5rlH288g+QFuObMlfnwDnIZj6N?=
 =?us-ascii?Q?gzlefoZGD79YqBzLgpj02r6xPpk5R5hSGNK8QqKhjv9enaaQiQxGObHQ41Gy?=
 =?us-ascii?Q?naPJNrD4T0cdBdfczhqAfJ9yC5MQO+TtLrDCMsazm7in90ffWIyQViNLY2+y?=
 =?us-ascii?Q?0J/YCmmbA0H09ypODI3pn8rea4VCpK/MZcPX7JLi7lZfxKwmOGhmUMShAMGB?=
 =?us-ascii?Q?NdzOuku4CgIUrKsROp9NE5gRjk4u4fz2rP90rYJe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27a43db-ac54-4f28-c0ac-08dd9ee57ee0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 19:17:47.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx61j5Q4I7JO998VffTYYvFwVSouNOJ/x8NQgPmlADyqAeBEnzXVq+lkDJjOw2iEjORAFmWh83BkOZCJ2y5Rmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947

Convert qca,qca7000.txt yaml format.

Additional changes:
- add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
  ethernet-controller.yaml.
- simple spi and uart node name.
- use low case for mac address in examples.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/net/qca,qca7000.txt   | 87 -------------------
 .../devicetree/bindings/net/qca,qca7000.yaml  | 86 ++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 87 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.txt
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.yaml

diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.txt b/Documentation/devicetree/bindings/net/qca,qca7000.txt
deleted file mode 100644
index 8f5ae0b84eec2..0000000000000
--- a/Documentation/devicetree/bindings/net/qca,qca7000.txt
+++ /dev/null
@@ -1,87 +0,0 @@
-* Qualcomm QCA7000
-
-The QCA7000 is a serial-to-powerline bridge with a host interface which could
-be configured either as SPI or UART slave. This configuration is done by
-the QCA7000 firmware.
-
-(a) Ethernet over SPI
-
-In order to use the QCA7000 as SPI device it must be defined as a child of a
-SPI master in the device tree.
-
-Required properties:
-- compatible	    : Should be "qca,qca7000"
-- reg		    : Should specify the SPI chip select
-- interrupts	    : The first cell should specify the index of the source
-		      interrupt and the second cell should specify the trigger
-		      type as rising edge
-- spi-cpha	    : Must be set
-- spi-cpol	    : Must be set
-
-Optional properties:
-- spi-max-frequency : Maximum frequency of the SPI bus the chip can operate at.
-		      Numbers smaller than 1000000 or greater than 16000000
-		      are invalid. Missing the property will set the SPI
-		      frequency to 8000000 Hertz.
-- qca,legacy-mode   : Set the SPI data transfer of the QCA7000 to legacy mode.
-		      In this mode the SPI master must toggle the chip select
-		      between each data word. In burst mode these gaps aren't
-		      necessary, which is faster. This setting depends on how
-		      the QCA7000 is setup via GPIO pin strapping. If the
-		      property is missing the driver defaults to burst mode.
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt.
-
-SPI Example:
-
-/* Freescale i.MX28 SPI master*/
-ssp2: spi@80014000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "fsl,imx28-spi";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_a>;
-
-	qca7000: ethernet@0 {
-		compatible = "qca,qca7000";
-		reg = <0x0>;
-		interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
-		interrupts = <25 0x1>;            /* Index: 25, rising edge */
-		spi-cpha;                         /* SPI mode: CPHA=1 */
-		spi-cpol;                         /* SPI mode: CPOL=1 */
-		spi-max-frequency = <8000000>;    /* freq: 8 MHz */
-		local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
-	};
-};
-
-(b) Ethernet over UART
-
-In order to use the QCA7000 as UART slave it must be defined as a child of a
-UART master in the device tree. It is possible to preconfigure the UART
-settings of the QCA7000 firmware, but it's not possible to change them during
-runtime.
-
-Required properties:
-- compatible        : Should be "qca,qca7000"
-
-Optional properties:
-- local-mac-address : see ./ethernet.txt
-- current-speed     : current baud rate of QCA7000 which defaults to 115200
-		      if absent, see also ../serial/serial.yaml
-
-UART Example:
-
-/* Freescale i.MX28 UART */
-auart0: serial@8006a000 {
-	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
-	reg = <0x8006a000 0x2000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&auart0_2pins_a>;
-
-	qca7000: ethernet {
-		compatible = "qca,qca7000";
-		local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
-		current-speed = <38400>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.yaml b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
new file mode 100644
index 0000000000000..348b8e9af975b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qca,qca7000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA7000
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The QCA7000 is a serial-to-powerline bridge with a host interface which could
+  be configured either as SPI or UART slave. This configuration is done by
+  the QCA7000 firmware.
+
+  (a) Ethernet over SPI
+
+  In order to use the QCA7000 as SPI device it must be defined as a child of a
+  SPI master in the device tree.
+
+properties:
+  compatible:
+    const: qca,qca7000
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency:
+    default: 8000000
+    maximum: 16000000
+    minimum: 1000000
+
+  qca,legacy-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set the SPI data transfer of the QCA7000 to legacy mode.
+      In this mode the SPI master must toggle the chip select
+      between each data word. In burst mode these gaps aren't
+      necessary, which is faster. This setting depends on how
+      the QCA7000 is setup via GPIO pin strapping. If the
+      property is missing the driver defaults to burst mode.
+
+  current-speed:
+    default: 115200
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+  - $ref: ethernet-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@0 {
+            compatible = "qca,qca7000";
+            reg = <0x0>;
+            interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
+            interrupts = <25 0x1>;            /* Index: 25, rising edge */
+            spi-cpha;                         /* SPI mode: CPHA=1 */
+            spi-cpol;                         /* SPI mode: CPOL=1 */
+            spi-max-frequency = <8000000>;    /* freq: 8 MHz */
+            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
+        };
+    };
+
+  - |
+    serial {
+        ethernet {
+            compatible = "qca,qca7000";
+            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
+            current-speed = <38400>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7761b5ef87674..c163c80688c23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20295,7 +20295,7 @@ QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
 M:	Stefan Wahren <wahrenst@gmx.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/qca,qca7000.txt
+F:	Documentation/devicetree/bindings/net/qca,qca7000.yaml
 F:	drivers/net/ethernet/qualcomm/qca*
 
 QUALCOMM BAM-DMUX WWAN NETWORK DRIVER
-- 
2.34.1


