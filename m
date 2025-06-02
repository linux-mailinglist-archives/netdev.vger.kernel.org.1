Return-Path: <netdev+bounces-194619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E26ACB88C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9721C25826
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7347F221FD0;
	Mon,  2 Jun 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m6jlKPWQ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D999221727;
	Mon,  2 Jun 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877384; cv=fail; b=blgmTOOzk7HkyjdP6gXAdVTQJ1LXmDUmaVEkDOgydmukMmGkWI79RXQnZbbOfFXUfyM3cthyc/I9p3KGtzCDbxja2KGpwQgNrWWx9HMQ6vWTwOV3VUBchWExDME63RnJD2ERbKxBz+m+os6Obn5x8Q0biT6TL6fgkEyYf4UbYQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877384; c=relaxed/simple;
	bh=Inp8kcP2PWungG6UjrHkI3W96kRS/UTBUuh5nVYyybE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dLOw+RbmSBLlbW8I13nqtZkl5lMAKExJGqYjSgQfWVsspo4tzudTW4pVlvD5kL6rrRTxHgqizjWJR1uZS3k6GdUs+3ePgtEvMC5V7rrE4Hb6mqBTXyZAczeJFuWN37X1HVLw1aVEhkL8XJnYEdvFMo3cTr7n5ATS88k07GymbUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m6jlKPWQ; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7HCudOkFNPz+nKsecUSixNaeXddv9Q7u7ZMKE24Ht5+UZ4y610SCQxldj7hnt7ZZiP5P1uVmwc2BD2aJRWpg+wu+L5g5IoSOUIq3jv6wdjwdEJgRQrCN1mpGBlDMet24xC6rg7fcKEKLDi1QRGL6AYhLfBx/LRvWQSuB3/UnUdvunJGTag66SeXbQ1NTLwDW+WifEXKq7NvUh8OweAqYumooN8cjlNkCqIV1ra4MGyv0eKgDHyvjuyDy4fqDhOLSZdY6q8H9dGigLahk/FZCsVbcC0TSX60gn+1UpIX1xeOSzeWoQvSri7K+aN819rMpYhVsQQFLNoVQkuohAP1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOrFIR4D1rtz5BRI2crejJyPsFPwBB1sTKVbUapWPEk=;
 b=s8m1ZMLVjwSPfwiMOgdSL0xNLtI6fX64tbe+hKkCg41pFVak1n8EOxcGO5NiQymzHPsxqanO1XtbhBWzmMNINLE8wQl+gM2jj8/L6wWYXlXENnUtz7VN7ID9j0mDXZGzEqMH8mGWWOpO4GbjBDcGgFGCNRwjh74Sf22Fu3loMov+7QbVxK6g3OXbZ+T5epMwo01sxgz9FDxGCJeakO0RoxSPMIuVOu7MW3hB0Rl0hPIyz9UsxIPGlkFyV1kCMGnIIr6GToWaLcuI0PJeoWSfoQl2scK9tbCZx1Z4Kqid5kVMpffecqNxh/BsoRKwdyT5i/XpEA2TUhOZN8lbJxAhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOrFIR4D1rtz5BRI2crejJyPsFPwBB1sTKVbUapWPEk=;
 b=m6jlKPWQcKu6wY6BiGEMTgyNbDPEWflNhw1PrDNgk75xfGzmGjeFf7hSqAlLZACAGQf78t2Qvb/h6sE2z5rcdZ/TLc2xq4RgeEg+gUsdAz7zJZyni3Mg7dHRr02XsmRJyz53nnsUBSwmFMBOeszxSMecOFwRVNBdrJhdsARoE0xJAH5G4APmgUuj4jn4a4kRcr9OF5U0CFRsh3b+i6nEJ2/JJdCP53pIHj9ulll4ZjxeAe0jOzzXzhztFtsPcJ5jK4q6OXy9osVye+j4d6+jAY9wgGR+ktV4+p/FDc7hJymlx6hobFTmDrfx7rOZhH3fjCjLL2a1ryDKSlm6sZgakw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8279.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 15:16:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 15:16:18 +0000
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
Cc: imx@lists.linux.dev,
	wahrenst@gmx.net
Subject: [PATCH v2 1/1] dt-bindings: ieee802154: Convert at86rf230.txt yaml format
Date: Mon,  2 Jun 2025 11:15:58 -0400
Message-Id: <20250602151601.948874-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0095.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: da4c758c-0976-4441-5bbe-08dda1e86c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbdr81F1wmmrWUsZajZ2TuN4bxJkjYcCL+GZhfmip1zHKgYDXZDELtu6g2cj?=
 =?us-ascii?Q?KGJoOSJQaDnVdxQDHW2vVqOjYp4Jgzcd7qnD5+UIyW95CnDe8cNbsW64roo3?=
 =?us-ascii?Q?GYX/Ii49A8/zKmZu3K45C+lx1Q07V4TPloHRBCwJq/NfhoTanF8rKMYW7Au7?=
 =?us-ascii?Q?/ghI8t2CQjv3z6tMAgYEhaDxpGojyaujxrva1Cna3sgdVU5lu/PBcUSXGDIY?=
 =?us-ascii?Q?9u1xoGLL0KA8oU4OhRZqgRkOcZ1hnv7dUWGbsJoTpcoqmpUFWvZl4B9yHsX7?=
 =?us-ascii?Q?Kx2vjuBfTG5T5En+yQ/uF8tRH9jOhf62fv70jQpl4n27vCAVEnH77ka9ssjP?=
 =?us-ascii?Q?dxAxH9ceF3DBetCFCTffMHHsmeVP6b2/qE0a/BjR1dSlwIkwWXZQrQeGEttq?=
 =?us-ascii?Q?O2s7rgop817iL5Dx5dlZdt8z0JZO1+2riAfj6yefqv6debFAY7ekc3HBZ7uv?=
 =?us-ascii?Q?7CzSy9g1LoASFYbKFXXhkUoWXEfOHARU8V1OvBY8c24opBEULWyOev5rFLDB?=
 =?us-ascii?Q?dQLiwCrIuT/s0XtEjDuDNTRGK1pJ1dmGNLbC2eGPxOO5IisoXPmDd/YBzHzl?=
 =?us-ascii?Q?kcwcPWYJmTqWB5ycBzsf/eY69m4JGaQv6/Rb2/F28lur+MYuIGOPC9J+MHs/?=
 =?us-ascii?Q?+6BQKrazxYp2LPgGjEubrFG2P7SNtOqnqryxQoQ9vVimBM/P+NP4fdoYEjGD?=
 =?us-ascii?Q?77kEVwi0FsS2eP2rPizXil4u+Z7ausNHpyu8fbH7703Sm3dPKkBHT7B24EvM?=
 =?us-ascii?Q?+RSQyulK053u9fulKSdIxji48sm/viNuC8UxmnSos7OCVdNUjs6ZOR4XboX3?=
 =?us-ascii?Q?ukl/ND909Ek9eRrOjCJ+OA6AybmccfJR2/d7Tnn1OuEsUGZ+2yXb6eEla28I?=
 =?us-ascii?Q?a2wpIgGo4skVO2p+erqVJKnW/E7CQTbv3xCJb0pjnYQvBOutYE7+WtJ3fE4f?=
 =?us-ascii?Q?k9+xhGVIfu+E3yudR57xIO2iNFtEoXuOzVquJO64cJjrvCRcyME9fGsreOSG?=
 =?us-ascii?Q?VEMsVEVUQH79TVQlJENLnO1KaL9Q/HioTEY+ObPPYpUbsQkomJKCyGEiowKK?=
 =?us-ascii?Q?5UM0tysWDr5nm7nte819rGxmfaLVK4m78oiQngEYFcDo9h2JoIt6S8mdnY77?=
 =?us-ascii?Q?Fz77j6Cs/WqEoX1dgc8j7hJVxJR7dMz7iI/TBk9Ic0GT7DOUH4yX5HEFNS13?=
 =?us-ascii?Q?4sUOVihwZ6OPW2YpuiJ6A8SddmRHLsDRI9ymBCQW8dc0eTLD6Sr8DfvuGQZB?=
 =?us-ascii?Q?cJYZ+iUVVgvIiodbtvQYGul7TaIpX61vuN36YZ2KcXvNLUXhCkHfAkcpiCfW?=
 =?us-ascii?Q?3Gje7PnIFz+141H1b3Xixiy9PcRbLSG0EG1AuKkOlT0dLgJfN8hHeudi/QQI?=
 =?us-ascii?Q?n8hm3TH9uK4VYtrkZCKouf1G+2tk7jm3vq0NnVByjAlUrZLMZn16amfEtxlb?=
 =?us-ascii?Q?7nGtwrsmeVLa0asIwI3RPrNlCOUZWXpR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9brAxjJC+98aUb/h5l75HWvIapDkyfEN+lJCVqK+ocGc51gDLWQ5v6fETfR?=
 =?us-ascii?Q?CxA3E/qcoHmUdMBreODWNv+QNKhGNIHgqMnObOdFvQROTUcqp0KPrJAf6v3d?=
 =?us-ascii?Q?SaZ5Fg6674QzMVrKnEaAyUhbf/dM/f/MGgQ6YOMr29UpfsNg5JHDs0mcQ3O7?=
 =?us-ascii?Q?pH0/MBnAfRk+QS2IadmQsN7ayoGXeORXsKvaR1tRmhE4BtrRpFeDSDnDdHAm?=
 =?us-ascii?Q?65Zy8m8Qx2d6CmmAaV3PUupfvXImF8LkIoQb9u/kCXatIYesxtObB4pptvwX?=
 =?us-ascii?Q?5BvQsdu7JowACbKXOBLI2pNZLCl230IbDKjMDM4EJ7/B5Qt5/phGYCtnkdRc?=
 =?us-ascii?Q?fpmtbvIrB8NVRw1PVNbpJqTar17T33RB+1P+SLQeAbiHHjfuk3lE00ZyXXmD?=
 =?us-ascii?Q?pIrtcMSoKvBOezucaoPTKGpYNRGqP4BI3vkq4GSKz587pdxeQUqj7m2FSAMF?=
 =?us-ascii?Q?LVcIjC/D8WX7YKngWSK4rWo67Pu3RMZCnwcg+j/Q1TPkTZ9w0L7WsdcnOx/R?=
 =?us-ascii?Q?OdZOchIWgTcc/3uqsya0xTgD9JMoBp6iK5mZlznnp7xWZit/fNTtzy8bg+i6?=
 =?us-ascii?Q?zW5iNXgIksEh91OwOb1rNQUYFTzral7gV9B59W5Dp/LCf/KdNvTDw1AXADFl?=
 =?us-ascii?Q?lYkXSgVLo6IEd3N+u5Y1r2gw1LstjEeFuOHdm7IEFOsNKJcUJx5OSt5U7lHZ?=
 =?us-ascii?Q?AHQ2d2FZBEG0XcPZqa6KTZoZhO4nhpwLWHf/wQ8DSxA2hVLZ6VmAqbAEpz1W?=
 =?us-ascii?Q?NXGd0ugYngO1F5LoAEpHKI81aLEOVKpINr2iJ1UXQsdYAmQpAeOp7Qucy+yc?=
 =?us-ascii?Q?VwUrnddB37s67lNQeUHaBtjLupXyfuoYwy7xdM0bj4WYag41VX0/ffpILXQI?=
 =?us-ascii?Q?uhA5KOOiijsGj0eaud0zWR4XelTQpUjAh17K8A6Kd8BvwIe8rE9X+SIA7AMm?=
 =?us-ascii?Q?zx9NlbgxXxGug/OswcLAB5Vuwz5/wKPhUCZdTWwAokluMCy2rjhBPbyyhpYq?=
 =?us-ascii?Q?MiAyn6Ae0H3c3NhNdUCRhUWRWuV9opsSw7np47oqJh1itbLADkZ6oLysjCgb?=
 =?us-ascii?Q?TdKhkObiQwvlVNou1RqV8iLhslb2Iw26W11qRblFGfpg1scOuP1v9Lsr2j6B?=
 =?us-ascii?Q?W7u5YSH8dFGbY52wOK/UoMZEOEgOSz/O52GAH12448ScdXfjsR4dybYP5D2I?=
 =?us-ascii?Q?5uMXEJUXnmMIrPQwQwsYr2+9OFC2gj2nZHT42hnPNF8B/8XrqvIwLzf7eSZM?=
 =?us-ascii?Q?SK7v70WYGM/PSZL+Un27WAaA2t93K24bkvBp2NU9xgY2De7cAdlVx3HU8M2Y?=
 =?us-ascii?Q?vWjiRTYLev0S1vE5KA5s8F6NAuGUKuhB/lRxcFCq9twlyKKTw9rXB/LNLE0Q?=
 =?us-ascii?Q?rnt66vIZQ16awlSEjUmhf0aFNvyvMlLIu7TCDctQdgqUFz27WJaKZadIRdZb?=
 =?us-ascii?Q?l26bLa84pljqX+vzyTWET39I8QxdriXEdbxaP23SGpTLpOYX592HQuiMY9Vd?=
 =?us-ascii?Q?wi0MZB5Ypaw1Vlj6zN+UI5oM9jrAzEJzis3XTZbQwn8C5JH0QfbrVEDv/V5Q?=
 =?us-ascii?Q?UXMJ+xC9sWCyhWvoqmU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4c758c-0976-4441-5bbe-08dda1e86c46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 15:16:17.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10qzuDNanqF5MmPoDr40ZhA50uL3qcrfXaEleUSUo+lh5WoLSW63o0rUv15o+MhiiDNzuD2w4yrlm7Pkebg4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8279

Convert at86rf230.txt yaml format.

Additional changes:
- Add ref to spi-peripheral-props.yaml.
- Add parent spi node in examples.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- xtal-trim to uint8
---
 .../bindings/net/ieee802154/at86rf230.txt     | 27 --------
 .../net/ieee802154/atmel,at86rf233.yaml       | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 27 deletions(-)
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
index 0000000000000..d84e05c133710
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml
@@ -0,0 +1,65 @@
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
+    description: |
+      u8 value for fine tuning the internal capacitance
+      arrays of xtal pins: 0 = +0 pF, 0xf = +4.5 pF
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


