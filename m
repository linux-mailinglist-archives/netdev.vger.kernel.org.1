Return-Path: <netdev+bounces-209909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C0B1144C
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 01:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4941C223A5
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 23:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7C23504D;
	Thu, 24 Jul 2025 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CuBK/RRT"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE761C1AAA;
	Thu, 24 Jul 2025 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398113; cv=fail; b=gm7EUG3cUSEVgMBKcloapIzdSHwfm92n9sw7FoUgWWEXm7I7O2sjUT6LO6CMfVX3mRiAK3EN6IxQ9n1KqfMgZEDWKUITs8xLQTMLEUGe9peDwEq0dPDUKfr7AeoBzEI2H/Ds6pGgJuJUyfMovTekLR0Uk5jEAqwb61iq3LKmrmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398113; c=relaxed/simple;
	bh=mYdCMFxyw+AIyLBi9kc6mBMmY4iOkMHm1QbljGrxPd8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PeV8rOfhWtgC3rvyLwmHbQH1JYG8i+cknh5KCwqXr4dVCKZrr+G0+br9CVpsxceomfmprEgc1eO0bLswNXNXkZ6l8Go9efvqn0DLWiK8XP15LTRTWXFy0o4D3ORqHDp/xGDTPFaHUogiJi4QnPvp1nWXxEofMyOIeLAsVSVpRg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CuBK/RRT; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qg4yhqaVXsgZj8o3ex6Zz7KyOrHy/lyM31tCHROvJVU5ZKG3fmWIAsRkNluZkfrHaFHJ97LRnyhTC7tpC3YYoZE4uOMBvXpISAGZ5I8Td6fH67uQr2p7n8DZWd49ghT24GMhreU68PK6Ql4NMikIwJAr5VnNZyCQTdPzN1Hh/qAs1zY5Ajm/X5bMSqtt3hTmsiY5CuHeSLcRdK7dQkrYnQL1NgWP+4vNvUjfAEa9fhqg2jHtni2Y+havL55jlPHb2TKkQjQNsKOWLxsIiMwj4GJYvM73PHjTEuxCLtraqj7zIVmZTfKA5oM8tmo+K3F4VrFFHuKYVhvVwTGbohonpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AUXoH0PNisA6jvSn2Vbpf5lgtJO78nHwoPYUibnP0o=;
 b=YdoeynRNcFjs22V8Bi3ckFn8/x/tuRrDumuF3ZxSH18Cq0eSydWDqr2Ce2gSK4ywdr+f8W0LT97UGaJW8bu8iLpctkELuN8omSUCW3jRDSg/PuUoX/tpsg9VVJLo1Uh9o2sZlARRkU9yE4HT4/GL1sbHEapDz971gMdjF4pGT/u3cpVyh4qObPUTJeDihi14opzyxAnhBlCXriv8PRFj+yrXxr5tqYzcRSOkLA4Lq4pemJIZn208yzG2P+nrSzELiGkKLzPwvEXwxVpKygKlpjteX73/ABRfQxhyQ41WjNuw6qG+6zSK0RJJNEF+SlG+IQemIgzH7/tqpVn/gx4D0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AUXoH0PNisA6jvSn2Vbpf5lgtJO78nHwoPYUibnP0o=;
 b=CuBK/RRTMRQEOqTDCvnVh7iIGkiqwvwoSjIAigh+q9oEOZ+ZAde4AlU8e6rzXpJq3aHACXJHR4uz6eD4HH1xJdflITXKz37ZaOZECFN6/7/R+27ypYvrBj9CMJui1AHPwEtmdHrd2bMS6xt9VvMutT//wKPlMgD8qe1jez/baD5xatacBzpTPDyHzIkIi4vnsDXrNYHvFKYGgJKGip3tviFHwgY1b+iuS/yTGhXiFehASX5Ckdz4n6nXbAc7DQf1v1uQkiubauolZd3aQZ6Fu8ygfrRQEKVbUwA8Rl6uQ2/XSR/ZTO4PH/w07vuv7hdtGjQAg4/vhImttINtlMKiag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 23:01:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 23:01:47 +0000
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
Subject: [RESEND v3 1/1] dt-bindings: ieee802154: Convert at86rf230.txt yaml format
Date: Thu, 24 Jul 2025 19:01:24 -0400
Message-Id: <20250724230129.1480174-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe81410-be96-42aa-f0d4-08ddcb06111a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFzPcBWi56Kw64rSSnvG/CTiortQbVa/SP0EOeZkK+39H3uqV4uLF6ET3LAz?=
 =?us-ascii?Q?r3h8n5YF1V53T+fDpy9SGtLVKVrGokMs8YB86O0eenKVo4s7zGOTAIhZPtwD?=
 =?us-ascii?Q?p+H+pxDMG76Q/3FHFbpLPaL718U+PAeprrP8W405MfKBHYHV7E4lwHxOt66e?=
 =?us-ascii?Q?UyVFC5cYU/hxZtK0/quGw1zW9eqMgCY2KAle5Qhf80Fegad4T9rFXAUf6Es1?=
 =?us-ascii?Q?hOyBYSJ5TIMXZSn9QX4uAzzGIh+JgCWi/buUmchYYeYtaqZYI9jVf0bmGOLE?=
 =?us-ascii?Q?jA5NbZvtyOEMC5xCYLYGVnWarVzYFH3n9qGEs2abXduHW8MHPxDz08j6inYU?=
 =?us-ascii?Q?d82yEOO/A1k3jno1oEzPIiU4SmBtGRvFpOrQZf99HUDf0TgYNgnK+sGg5L9T?=
 =?us-ascii?Q?jY7M5Ostpl8Nvt/N1oqGDNffSUfst7xIAgJQWEWR+QIajX3oxvk6A6VLEJMj?=
 =?us-ascii?Q?dBIEIvu826fXi2stSbKGf+J5N/hWy3KF5ANv7PqZ4Yt5pdZU33VKEJYDQ56W?=
 =?us-ascii?Q?YBEdIGWKHBkH4kW/Y9LWwac4nz5ZcxU3ndcD91hrBUxiVcVHa3NDbq5e6DXn?=
 =?us-ascii?Q?43InNgDjh4A+bWy71Am+Zs4q/9fMe55NsbKpSyCZATnijVluKUI62x9ZwXpj?=
 =?us-ascii?Q?ygA3ZBdeNL6WHxr61+XeBhIybG+nDKHsjmuLEww4z4wjduTNF5HlP+6tAEXK?=
 =?us-ascii?Q?hN31ZujujSe7aV1CyHo4q7E+NKdI8WOteg3+JqV9Ekzg4oho/cAj4+RJoF2S?=
 =?us-ascii?Q?gs1w++RowtTi79y3qXJJ+dk6JT/9BSiLm/x/sWFPw81curZaQdJyugx9FoT3?=
 =?us-ascii?Q?j5hZCF6QA+U9g68vCgH6SaqCxwBugOPfboc/EpZpaHW3FumiqdbxFf7FOZIa?=
 =?us-ascii?Q?rwUpCWSheBtVLpsWgf/a9j7s8wWKCSYNk7kTG/HThCb27/qRFobHhMm95VJZ?=
 =?us-ascii?Q?ojQlj4LmNTlPbuP5OxwUCjuR7umIt1hmMzCEeF1cfZo52jffHmw5kUjCs67y?=
 =?us-ascii?Q?z6S/VstuhcPyv9tjzOlB5ZqwjYxdHxvc0aPv2aOLzLnRGFJEqvAosPndJ8Cm?=
 =?us-ascii?Q?KOp+4HjhrRfdYm1YFmpmYCozWnViTRULHmGOqm2gMJGhWa/dxnieGzKI5ccC?=
 =?us-ascii?Q?f1SASYYebdGm4E2Ies3WA4RAk5Au9U4iVQr05JqgWOjhbNSdkyTb83Dr8xvN?=
 =?us-ascii?Q?MS44PE2Vob1u1f1Pp4OD2T4ppLL9QEU+GSNUVOFQuy38d7t8o7JQ1WhiBl3k?=
 =?us-ascii?Q?IL+QXG3NdcZUegA0Zvqn1AEY8iP/G9Q4bGTJX+tsTj0TXji8FPFOps3LVWOy?=
 =?us-ascii?Q?Ey8Xe6G0BbBl5idNToyjIr/dTvaVP0fIFNNdpBoFodJie9E8/oDC/bezmaMu?=
 =?us-ascii?Q?ww/mQppcPyEkMgkjq0gTrGmiLgvScf/hVVtb54UJDqw3hy5DS6QEaV7z95xb?=
 =?us-ascii?Q?UlM3r9UMqBbl/L+sWb0tU870XA9YWATn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sAaAipkNwyhDhT5pO1w+GkI7IauId6ia9DBCY0pNk6cVtnwCNUcBqoCNLp+Q?=
 =?us-ascii?Q?uYKmfFVtNCZlQXY2wQZtmIfoBzipR9HO+L+/UOgptE6Fd7l8ExDBlstbcnZq?=
 =?us-ascii?Q?CZZG2CozIrXeAhf4ZSETYD6w4JmdOB3QSIqyktRSnK4shzMSW7gn1LQq1Bbt?=
 =?us-ascii?Q?xUg1xIxmcCGxEkXRxGcAq61Dxbekx5aYrQV30TLBMBVIKyRRIMIBir8SDSuf?=
 =?us-ascii?Q?/LxRwAUcapyVETG71VeFu9r1TTqz80htgHvPdeLBgH72oWkEQtjOeoSGQ2OJ?=
 =?us-ascii?Q?9gMN/tD2aQhlRrSDF4FjqXEi7sAvrRNasEpXLc27q0XCrWTH7m0jcJyV2QOL?=
 =?us-ascii?Q?cx4rGqTfX2WuYkMGlB4B1OZSjrbg8G42Yz7Ns5sUkpbzRV/QOjmxB7591V4n?=
 =?us-ascii?Q?kZzwk/qKveKIQpTu6+15KLTZtK3OpqYBZtocJvD57KM8Px8XNpg2cHoY3kJF?=
 =?us-ascii?Q?IdbTVu1ZCGmQip9Pfmp1+qDCgdC+mrFuTpv83esiY47EZl4stdrXel98Gvvy?=
 =?us-ascii?Q?S0rQS+W8fmHDzo19PgZh0oAepoDWcW5WGCHONayC+sxdDLJ+Bd11loCVZyhc?=
 =?us-ascii?Q?prjEiyr6YmULRP9LWVTqgdf5P6gexZDwOjDszn566YSaAz7Mxlw2s7BYUljQ?=
 =?us-ascii?Q?Ae0b6BRuF3YVGxAli5FwQGD2Pdj2S5ZafFINgt9zTgbgXPWzwZu9yButUkIo?=
 =?us-ascii?Q?A9ByOk0fKoqqecBObn3GzwOJYl4MPIWocFm/mMQSICazYuKuEgSAYnrZ0MWo?=
 =?us-ascii?Q?2XPSSHfwZsZ6iLFrXvz7q/5qK7CnntSqaxruWCtCJ/gLO1q12wVrNnPzQD6k?=
 =?us-ascii?Q?ILylHXzpkwV5k1FJYclqMo+ceLMmQTb4s7ak9gFYu/rJuCIE5mdeTEa+iVye?=
 =?us-ascii?Q?xNCoD8PXR395Srjd3DQ1cfNdzO9Dxny1dxymtOCjhriWEgCGJFPnIVqzVXYd?=
 =?us-ascii?Q?qtmUAz5qVHXjPcSZoizj4csoCHZaTCjBCF3ciCtRBbyxh7/pN5u5aL4gK2Jr?=
 =?us-ascii?Q?6YyC8fjdpM3zi4fy0nZROPMQiXNhXr5RKORdes5sCMsdalGT9/+LSDKfbyJD?=
 =?us-ascii?Q?sPQe+RnJCV/rnLHqQraPFl1hub34luy60SvZ/vjgh3XOQM7YUdOCSGSF4SsE?=
 =?us-ascii?Q?SAsLQafPHFOVDlZaKsEx0E2RtLJyVchzqmzFovq4Spr8ZX63bMacZirjhZPE?=
 =?us-ascii?Q?3QgJTZLIcvqH0oLReSGQs7fh3LyDvg+RWYU0jqWwcWhKyIbp5EOubakqWBNd?=
 =?us-ascii?Q?Ki4hDVZPL+q26c5FB8bvavFQxiANbDVZiZx6wtOTC1csDWgJz4R/s2pKNoLQ?=
 =?us-ascii?Q?5QO9tfXpEQGAk5Q+iF0ZhDB2odbmCmJ0F+N1xuCkDXSk+65maaFcJgyHNglk?=
 =?us-ascii?Q?MZtFi0Ji+GP0X7RIj1Bnr/K6DGtf3M+R+gblSsq8ZKlGybehk4qZsYCSLZ5r?=
 =?us-ascii?Q?6kKCH7Z6bZCbxCSN5qnskGenDUEQ0Y+gBZ25lRURCluJDHtMhosMefRKJAk5?=
 =?us-ascii?Q?utxRRI+NgcGpAnZhVd3narYTwh3/YZ8DgRot6f8/uArO1U4QDJr7cYJKaXaQ?=
 =?us-ascii?Q?g0V4hLBHSspSwsNWZ1k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe81410-be96-42aa-f0d4-08ddcb06111a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 23:01:47.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcXnlhIaOqfov606C13m6hMAlQX39tOXujfHWpdUBddVhyNWsiSic1TSQ+4PWzTIynbLd8OfqIdbd05AdnBwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846

Convert at86rf230.txt yaml format.

Additional changes:
- Add ref to spi-peripheral-props.yaml.
- Add parent spi node in examples.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Resent v3 include Rob's review tag

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


