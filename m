Return-Path: <netdev+bounces-195476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C44AD0643
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6F18813D8
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C204288C1B;
	Fri,  6 Jun 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jJdQIME9"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A201B040D;
	Fri,  6 Jun 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225418; cv=fail; b=HXaCO1NnG0hkahCRf9xgpNDInKnmSvKezhTx0AcxRSVmCYBAPY2jKyKn/39V/WDi6S2d9BcUW6vOzfqyP5lckIymYyfQWPiI1E4V0sHbLowms6cjU+bWfPAtKT62BG9pWm/PeHgEkefaY7r8agmGGDvn9PfKI1SFQo9loVTNwiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225418; c=relaxed/simple;
	bh=DjWqW1kdl7gJc5laNidO5V0DJUqKyAu+sQ+WhKYK3Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L1b2hZwIPtsMwIFaErUBJzl9o65fxguxXP0RuLrpYLNMY5fjTnxF5NgT8lVKftOuOxHZko++fAWSsh7PAXSXVYG5RIKlbv5NFBsBfSxs0ngjka5pmxYV2SiST6GpbN2HIg830dSBn7aBAsnzPBivzfBqPtlucfyqDWpAWQXwWtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jJdQIME9; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAgqgOhHaCswN4uSRfzjqb5Q53t0n7JvAqmazHb2/Qn9Q5sva15pJvAXzNwbEhfzjZtzXGj7cy7IJnmCZyi/EIIt6Q9zaOwcOo4NzxcA8PEzHnFCiPwc+LSyk6IEzX1T13JOLYfrwgOlRGQTjlfdLJZkaWl7uus/eBEiho/b4K9PNQyxj3kCPKc1AWCg89+PQ/vPRGr/UwnaYU8D1/uZAA87VxQz72u3giRAfrT/T1AXAiuoktmJLZesUW/nfA9SY5gwGUK5q4ph6deva+8dvDM0WimhSMb6dDMCyUpsJ1JcdZAT0IZw4EckAXcWUkPhHstXpTT2N0gaz6iPOYff9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKKpqt7bYD8BpfCD9Jy07xmrYOoRXiaa/RTP9F++AfA=;
 b=w0kv1SeXQWUlHXgVel1egmW6NUYTEk2/A0YGLxLHoOGOSocO+icQjvoxscITg4+vw7n4DiojMQAdwihV223aOd4scH780Bm8b7YJKxV2CLisc0Q57QlYoVO1SO5kL5Vul5fYWar0sDML6F0WAPbFo8xA9NBYwUCTI8j9a3gj5wbY+zRlEulF8rjkoI8t/0eja5e/ae8HgnoSUyRpWogH8ReB6st8S4Uh3gvZcX8sIE8gif1DofGgmtDpKChMj+rth3FAcNkVDX0JIbDM6o3Fx/ITdD8v8GcWKN0m4Sc2RZydDqOdVAHO4w+yFiBSht4O7iosLWespqp6WLSjKl9TxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKKpqt7bYD8BpfCD9Jy07xmrYOoRXiaa/RTP9F++AfA=;
 b=jJdQIME91m0kd17GrCT8bpp/DFVOF3dk+J5fge7IT9IBWpg+/oe51XZKbVYRcFFeGCv6OrY7czxET+ropaEdJ//4qxiHgav7Cr4pwQK+iy6fL7FdjdXpzju/CjPQ0EgZIHC4Rh5p6tvel0UfiEDSaNb8RnmPa+4ra3UJ/XeXpB8WiN58f7wcEc3MZid+IBXjaOW6CpOS7YqPmBXE8Ze/aWDPBqLF7aw/Pkqbf8D12c4cQuio+oXGu7OlUqQRxJ31CcqFIZJPA7488QNHJJHPh6AzPLU6f7AHMEVwUtwaEN0ZwmLw+cP6LMFyEJjciPzPEAhMneEE5j8o8h47qeGYwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7187.eurprd04.prod.outlook.com (2603:10a6:208:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 15:56:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Fri, 6 Jun 2025
 15:56:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: ieee802154: Convert at86rf230.txt yaml format
Date: Fri,  6 Jun 2025 11:56:33 -0400
Message-Id: <20250606155638.1355908-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: d79e7142-1794-4c2a-4e29-08dda512c0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kD/Rnr8GNDaR+rp7xCaHXeTXIX36D4e0ldasvewbBBgqba2xGF9uPVHJ/i2?=
 =?us-ascii?Q?UpbUrkV75W1F2FagyIlX6rB272lTJCZ9vngL//K4rB0qOz8RFbfxgBfj4WF/?=
 =?us-ascii?Q?rSMc9UJ51beCAG4HrSWL3l0epq/ygg6TLf1wBUMEIpB+zziSwNFaUlNfp1VD?=
 =?us-ascii?Q?aVjjJe5ul+lIEvuBgFE1k4WsIyCJ2joBEcRJq2BFNQulTv5yIbnN9HVPs2Sr?=
 =?us-ascii?Q?p4ix6+YpEOoTwAbnEgUsm3yS9grkEY4uPmVYHVhGY8TZct/P/cComXy/Ij8l?=
 =?us-ascii?Q?dieYqrbFmbj02a7yjufkp5gO2at1hmhir86GOYVryKiOY0wNGRk/0WSrbJp4?=
 =?us-ascii?Q?BtmCj+QTEk3eH5CpGZqGPPYi0yhxDCO3CLHdR/gnby2QC0oJSkI1YXpEz6J6?=
 =?us-ascii?Q?dJZg0sYZCaR6OiBVs9Q/NGWdvOguy2+glz6TbXxpfWaY1FFfOeZzQm2gphMP?=
 =?us-ascii?Q?0j5baGAI1U2EKndkDY+dhFRBNjXN7/+rijLVM8JYEA169HuuJQmB3K1syRPt?=
 =?us-ascii?Q?pRz2oH2x0jeF1dxtVlU8odL9FQjHAWKXitE+c/h3DHg7f3li91L76gITbkTV?=
 =?us-ascii?Q?6ONTr6hxy24mqkaPAnjXnVxRJlNHk5DW0923n2P56qL64CF0u+0Jf2MFzGMx?=
 =?us-ascii?Q?qSDo+dG5Iv/HqwxrTBL/bbdwnJW1OF+6BPPpwcuW5bAOLTVoVPag+4D3i5Lo?=
 =?us-ascii?Q?7fnSIOSxnP7jLo/qM+UROHqjYO2/O5fyEWyn/M24615M5LpUydIHVTbTQuCG?=
 =?us-ascii?Q?ZtitOIgr+2X99X4zSMEyHYf6fG/rBBfR8gbjEukPyijwC9E5qKSL3hgCY1gS?=
 =?us-ascii?Q?6KojWeJ4wCMIPdU7ufsNyeSkiNL/plqD8rqC2yE3AFWpymyD/w70Oiv/apJZ?=
 =?us-ascii?Q?qD52aOiRHff25I9Q8U4uR0HPmhMWeOiIBVlEt64F6tcm7D/QO0vKYpxmHEOX?=
 =?us-ascii?Q?fQBHb4qZr3CDaMDE8H14uVqlROkA2QwbhAz+SVhCophB1OcHwvF9zVk2uZ8i?=
 =?us-ascii?Q?wGWtXcifq7K+3ebpE3edMTO8B9CBGB6Y+cT3Eb/xXExqyky/zXT1bVKtuuK3?=
 =?us-ascii?Q?SDwKspeOXTx7EbG0znaV5QRZVkT0oJbuVdN1R+oUmdN94W3Cmu6d+GiKzbuN?=
 =?us-ascii?Q?P2YZT1/c+Fhd6YLk1CT/6SVfkcx6QpA3Rm8TwcGQULhEAEZf7nEhu6aYB/Yn?=
 =?us-ascii?Q?rkONsiI4IAyj1Ow6wvrsQT1o4f4QjJOE+K9BJjKOTvDw18hOgrzGKGUU5EQO?=
 =?us-ascii?Q?L0Z1SoLKWTx088EmT3NvSjSqKeTBVFvXyXtvY+B95mo0UxPqU54GWwBYhTXu?=
 =?us-ascii?Q?8UamXsx6RbpzIOwyuMZLj0xRU6X3K3+NYp3iEvhyaNviNh586iA9wPNtzzsZ?=
 =?us-ascii?Q?Rsv+zfu6ok5i0gWYR0w7UNYGuU7Mo95I7W88iWTVi5VsBDINeG4Auz4Rc10O?=
 =?us-ascii?Q?JybUVYLJUJji/OccVvEkCHqHfLnlUYDd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZ5h64Je3wuHLu6sVthYs8Hp3d1/J10DJtjWe/mVGfwU54ws112n3AKa9GfR?=
 =?us-ascii?Q?o9dXC7NTWYS6FQ/KqLLD5gbTCAlYXCXKzKK8qDssiJm/qyhA+9zRGPY3pkBZ?=
 =?us-ascii?Q?loQsMyIgTGZDqt/wZcJ4CTerY+XSq8a72N9Iv2uNQu9w3DkmDahGUMZEyvPe?=
 =?us-ascii?Q?KNZlKUhNtsTci2zIo0PEvZeZu+iQi9546diPwb+rZS5QhKzIRtU+3kRHtEz6?=
 =?us-ascii?Q?1f4qGLlm2u6Fx1C1ZQMxkTYqnf8Iom3KXYwg2aKzS/Dq6h/W1XWF2vTmUadR?=
 =?us-ascii?Q?DHSQCn/AF3hIAfoKGo6QdHxB6CgsLeQ7kwuMfj9rB4deNeo9PF9ovGWkbRtD?=
 =?us-ascii?Q?ycJ+Hd0cLG1ffHYWX5keyFyeRgJup8IZCOC04OGprvUscerSVi8J+Z2QanuP?=
 =?us-ascii?Q?7pjT/kC0md8Mqt0/2UP0n0Z1L/rBlk9aJw+4ZOItdhnouEkcc10ExjsgSWOy?=
 =?us-ascii?Q?vPyBayr5YMhzyA8GhtdqJySanBBey4H8WBOuwZTS/66fi/36T6ROy+XDzaKq?=
 =?us-ascii?Q?GUZWPx7BDHfisbplsdD5+jpzPrFyieB5w1IAfMXRDnH/T2K/T/pAFzky8VWk?=
 =?us-ascii?Q?EAwGJG9X4ep+OTXf65KVvRTta0EwVbcqe97s4j7rlKZra540G+HPYcFtQ7IO?=
 =?us-ascii?Q?apgTmI/GV1pOHeVIKVSEYCeoh05o+d/j82v0YkGD4Ns2fjBx++EFk0WAjP5q?=
 =?us-ascii?Q?vjbaPjrixXFwF3XWYaVVANAvyS3RTFLAV1baCOhw8GQRdEESIOHG0N5FVqUd?=
 =?us-ascii?Q?aUtSKlml6TkTMGidqyW3sv7Mn/qyU0zRSRZFn288wIwZ71Km5P6YMjohjryJ?=
 =?us-ascii?Q?K1IEw7+BkEyiLRpbSD5SEqsToobaPbeS/FMbZ5uP9xGnEdrfK5g9W4kSQ/8o?=
 =?us-ascii?Q?/Rj7fhaicVCcEn+s47FktQZkXHZb/ubZjQseOtC2UVMi2mcHhv0YYwJBxqMJ?=
 =?us-ascii?Q?t9fD3wAE8jyfqWZgkW3aopVmmYspTsIQWSWRjTUAvqF9dXVyynvyIMOWcv4b?=
 =?us-ascii?Q?/W3vNOOak0unEP8tblrBeXiniAl0qtxuPGL8vJ171Mv1sILzixKvl+XjfsDD?=
 =?us-ascii?Q?2mrVqhikRDM6YQrgfZxJoK3XHDzx1UP8tNQTfuNuaxhTm6I21wS7TqF5/MYf?=
 =?us-ascii?Q?DXS0Tb8AY5NuqbVNKUjMF2RhKXvQXiC53dJ5WdGi01BOzHOfL9KOaZdXVw2J?=
 =?us-ascii?Q?wcQFOqLfv+wSia0fLu1WFpfndIT4LT8+sXf+pRf2B4I3U2DijJW0GcpSDu7Y?=
 =?us-ascii?Q?h4lA1TezpJEfb/GVuptvnrBaOX+G4q9nvnsEkgQkejlMI2Xcd0ojBLy+DzyD?=
 =?us-ascii?Q?5nqQaoy78+mLslV7EWfjqqAIK45Q4X0+ze16nFbbUr13lkcBQCwbxoNdC03y?=
 =?us-ascii?Q?J70TYX8vskyumABw+TzF32cjF4pU1aNfniPfaoTSICH62xK40K6dV7s14Biz?=
 =?us-ascii?Q?OFcHKHsUCLal+Ldr9A2fLjFpH0Wrh6BbLcPgalLnEw0dYOXXjKmNof4kEfMT?=
 =?us-ascii?Q?et9IOVvg9pc6A5u4WalkKy7IYuOYAlZe15Ljzdm0MbkqEIn/2i80Lp1fvJmP?=
 =?us-ascii?Q?3fO4/esQeTop/G0o1R0Hx72ErobFlTDu0aX2CP5y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79e7142-1794-4c2a-4e29-08dda512c0d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:56:52.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NKeSpYSG41nOjC5jr8Ya3B78+3ypnTQrnpLIEXDWgFP1026YIMoq3i1qaKle2Aqx2LTjt1aP08tdEx8Y+Jk9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7187

Convert at86rf230.txt yaml format.

Additional changes:
- Add ref to spi-peripheral-props.yaml.
- Add parent spi node in examples.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add maximum: 0xf for xtal-trim
- drop 'u8 value ...' for xtal-trim's description

change in v2
- xtal-trim to uint8
---
 .../bindings/net/ieee802154/at86rf230.txt     | 27 --------
 .../net/ieee802154/atmel,at86rf233.yaml       | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml

diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
deleted file mode 100644
index 168f1be509126..0000000000000
--- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* AT86RF230 IEEE 802.15.4 *
-
-Required properties:
-  - compatible:		should be "atmel,at86rf230", "atmel,at86rf231",
-			"atmel,at86rf233" or "atmel,at86rf212"
-  - spi-max-frequency:	maximal bus speed, should be set to 7500000 depends
-			sync or async operation mode
-  - reg:		the chipselect index
-  - interrupts:		the interrupt generated by the device. Non high-level
-			can occur deadlocks while handling isr.
-
-Optional properties:
-  - reset-gpio:		GPIO spec for the rstn pin
-  - sleep-gpio:		GPIO spec for the slp_tr pin
-  - xtal-trim:		u8 value for fine tuning the internal capacitance
-			arrays of xtal pins: 0 = +0 pF, 0xf = +4.5 pF
-
-Example:
-
-	at86rf231@0 {
-		compatible = "atmel,at86rf231";
-		spi-max-frequency = <7500000>;
-		reg = <0>;
-		interrupts = <19 4>;
-		interrupt-parent = <&gpio3>;
-		xtal-trim = /bits/ 8 <0x06>;
-	};
diff --git a/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml b/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml
new file mode 100644
index 0000000000000..32cdc30009cc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ieee802154/atmel,at86rf233.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AT86RF230 IEEE 802.15.4
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - atmel,at86rf212
+      - atmel,at86rf230
+      - atmel,at86rf231
+      - atmel,at86rf233
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpio:
+    maxItems: 1
+
+  sleep-gpio:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 7500000
+
+  xtal-trim:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    maximum: 0xf
+    description: |
+      Fine tuning the internal capacitance arrays of xtal pins:
+        0 = +0 pF, 0xf = +4.5 pF
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        zigbee@0 {
+            compatible = "atmel,at86rf231";
+            reg = <0>;
+            spi-max-frequency = <7500000>;
+            interrupts = <19 4>;
+            interrupt-parent = <&gpio3>;
+            xtal-trim = /bits/ 8 <0x06>;
+        };
+    };
-- 
2.34.1


