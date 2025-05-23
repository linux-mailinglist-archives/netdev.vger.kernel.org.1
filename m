Return-Path: <netdev+bounces-193075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CD0AC26B9
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679A1188BFF5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED5293730;
	Fri, 23 May 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JSy241/G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE351459F7;
	Fri, 23 May 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015287; cv=fail; b=tXJK8UsNRXoGJKMLS19Ysu3CIEtorJMUXxdvL9TmX8hPVA6QG8O1EFr6I9nCujW1AlncIAjg38ljozchJ1Z2x30KmXpgV4N7rzzf1TkqnQBZZKj1ZrRCusdg4kL/iB9GP43cTcgZUS61rYuAXR8LnzxPaY0Q0o9LBymL872Om18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015287; c=relaxed/simple;
	bh=N+1UAH7HaLAU89T5llhSQ/Yf4M18Z7XQLfhb0PFJ8Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RDk05lJQVdVA3Eo6tbZM1hh9pW6s4OPotTvuUtIwoAP4SFoxYGPmRfhFrHw51l8YMEYf4s6CP6f8L4RQHDqN4YzOzGV9f7Ngokp5/DGFUgnqcOf2rGAYMIrjLEGEjCJNjbO9aoTtO6D/JS7RFey2s4jdNbXBfRIyBfDL5ALF5+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JSy241/G; arc=fail smtp.client-ip=40.107.249.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ2Tt1TBW5uV+flPcdZB7NcF23DDtrABP4fllWaOt+zumI9/rTCGZMUVjGooR8zhxN8fTsNFMtrVbEMUvZPq4FLzuyVYJrGi4217QDFj461XVfv8bl8yD58b0OTDWkzPM2sELVkVOGqIRYpDml53vjCQm45o+WIL71rzCYX+fLGC1Z7ZkNFtwdArZq9adCKpnCUscSdQxBe5SSRex7h1IOIndrj6nD1BpMmrsTtXOiGvF8t7A9bNlIRlGhDiN9NkoUkDppPBx033PJvgNF9JNYKnSWy3w+AuRgYjkPaObElK2TBD5IHh2bQK9P9rWlKqNcF8eY/2CN/PT5Tq3wYQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e78Z6/eI6up9DS2RmppNPjAhE2n1oqChOB6IHg9F0yU=;
 b=sn9MjJHumUhHhsJwp4/3FxoVFayH6dkGxnDCBN27UyMoEHH8aWAavy3kz3K6U/RHTAQZ4YSNoa6uOCdir7K5FGZIMPIw0PDpdRpT30Apfx8TTolJiidfXBXQDSPtyYrkDphOYHOQApCGuM2BH+wA16l02fgJelnSvVP9/tRFHcX8ESYWDw14dG2OSzKn0Pq0Li/eJZ82hlXvQtRpD2SOYfyVgdny9QduqLZe0XPh1uEhKS6nQEqNTKAwksBuWYIKkmljUD7smgKzEjhdCUI7Y+vK+JvwKwQWKIggJ8rqHH0L/oLcqrk8M+qrlJN/ssUZHDDSDhxnX9kUNlUsj2oYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e78Z6/eI6up9DS2RmppNPjAhE2n1oqChOB6IHg9F0yU=;
 b=JSy241/GCpNyVxoG3qQIwendtL9bk/5zncsdX52unr/oxsrqD5tf1NSWHEDPhwXeDJDKbSuyCqYlcYlZ9k7lY1ktdfsDyb06sOFEQQjBcAEEcfYCzCJhS4Llv7vfnJYsL+gtbNgh5Mz09kgkLHuZLEE5uJOBtAGnkA6rwlE9YhVl6xrbtcvZX79TwastHqItWrgiGAMKriCaUjWbhlt6HJ5TMz7BHm13Qr2xPJqMUYPlx4Qu35vOs98he5haUHY//AjBKeC1e4XtJLJ0NBjYf554atFDIifK4xYrgHOHX6czniQr0fr22CwaQCyadJQlCa+xMAzXxhS+Zd7mpT3RDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10303.eurprd04.prod.outlook.com (2603:10a6:150:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 15:48:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 15:48:00 +0000
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
Subject: [PATCH 1/1] dt-bindings: ieee802154: Convert at86rf230.txt yaml format
Date: Fri, 23 May 2025 11:47:39 -0400
Message-Id: <20250523154743.545245-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10303:EE_
X-MS-Office365-Filtering-Correlation-Id: 922b552f-a40e-4e25-fd19-08dd9a113217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LTYydI0Py6Wb3LUmT9/Bd8Iz7VCfszmFegoJc/15dwFRdMVz3szwImd+w75l?=
 =?us-ascii?Q?tqUVvLXH1eumbHj2mcdZ5HomG7CdjivwkBY4wMUNexXSg8nGmqr2JZFpsGOO?=
 =?us-ascii?Q?UWcAje8WzbnSLRwubid/PrFOAifgclK6/3e+PquFFbP1V3x1HcF5SovEA7GI?=
 =?us-ascii?Q?3gQ4dIe7a5k0M6L+jItbDA9v+Jcxc/bAZpgbV/wdUgV6icE5svVUp8c1/KLe?=
 =?us-ascii?Q?Uztf/WpqsCllpV03Jiz5nVa5VWsUXJhGFMZb0rTJ4a4Np67Gvsi5nIg1g8Nk?=
 =?us-ascii?Q?ysuJxYktgvtCfLn3c81qtdfZC70RMckV36XLrm0S4nt0Dx7EYcZQoaM48mNM?=
 =?us-ascii?Q?2SppLS8ZUPBQdelUSk/5W1OtEI1Y+2Tw4ZAG2ZHgSlZ8s/frmYsjMz4xQ/Rd?=
 =?us-ascii?Q?VTFTx02aCE5mtHs7IchjgRqAl0z04CTlfqMfgZRimwNmFoAFh2Lvb4kSZrw9?=
 =?us-ascii?Q?GczhZkBBdcpIaQzJfeYRwfzefhaHgm+mDHTSqSjZeUA6MITAv0WtD2u/UJkJ?=
 =?us-ascii?Q?/5R9Hv2Gkhg9pCmknwKx/gcKZHJbvm3/KPjYnoRVdzKUwrfFjuoeBbMSDA+N?=
 =?us-ascii?Q?4Ml0kTqlWLXKj0U6XH/tRNDLpIyDcap7kDeTwgCxhQj8ZE4M+6x9dkzkSmlx?=
 =?us-ascii?Q?baRG6a2eBdVCIpNM7/Dy91XxRIDtZfGwdQf7VqReMTJ4LV1JeaOs7DWgcOGx?=
 =?us-ascii?Q?e4bXduw46+EgZXr4ocna/t0Vf+Gq7TCG9BYy8LgXk2xHwC9ESlj1NJyDx3NH?=
 =?us-ascii?Q?ZUDmets/10uMSaww7ivsBJrKJn52QDLmnbbnd0OsKKA2wAlPlALRis1NB4Ee?=
 =?us-ascii?Q?hh6rRv1DsIwR2pky+4X8E+OwLA2GiW0ZgB789zMbtXet/3hRgBo8XtOGAqRE?=
 =?us-ascii?Q?JWWPZuqKxgXhwQv8wjyx9HxlHqrRg2+fg2JrrtuQcPYN5UpLCz5qRaZKwJy+?=
 =?us-ascii?Q?rt5AcPyxifUnQMLwYA7FsleU3hAzJl9hufvUoX/kYEvfqxLKBknGKXI5ygL4?=
 =?us-ascii?Q?7mV54NeJzav1m74TSrzOmtoH1gZDvqTKbuHapQuFpR+yWD1eF9X3fF7zvFla?=
 =?us-ascii?Q?aDvUchYl4mxAZ7pV5VsmTBg+gfKMOdCLNGWDqJE7p8pLShqu1FA97+VEYn/r?=
 =?us-ascii?Q?AQ1SeSY2HhSPyEq4D7f/RR6X3eVz64RehQD1XzOnjAQk5vXdERSkZ5y+Jss4?=
 =?us-ascii?Q?pKfgX6clloYckZULX2faGf7n7o7GFbhE/GcdZYEUegdc6g3lNnEMV7LtR/42?=
 =?us-ascii?Q?TISwqRWRQapTSluS9FKOO5DTTYGONRHsKknCgYviJleuvccQ436O3jLTJ/OO?=
 =?us-ascii?Q?byFHcUYpwHdCXNvGtPY1/O0rTUM84EmlGgH9Dj6apdHag2u4yd/e0nUF7lGd?=
 =?us-ascii?Q?lJf0MgUBHAJpGnGeewTSJKOIuU5jvnf4oI/Do3taPlKbfNfQ84wnxtitJf40?=
 =?us-ascii?Q?RjOCWyM401ghq7I6ZC81up+EYeYTnnQu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fMQ+ki6kEXeBOa7nfkWM4ARJNAZiP7AwnDGmiox2GpT0qm+ryh6+79OZ07+p?=
 =?us-ascii?Q?VzuuJIYuv7qfkNpPdEgSjVQTpUbVtCHnI+r9CdVyV902jzM6o8uBpK5ERWuq?=
 =?us-ascii?Q?Ezy7xgHFGhRRXLr4bFAxZ4ufutNC07hi7/d9VloL42o8YnJeLb/uLVE+bb7J?=
 =?us-ascii?Q?VW8h+hQ+IW0lGgjNdKAHXZP0PiZ4hfiprabqroaqpRAIEwPp614Y1wPHnGp/?=
 =?us-ascii?Q?AiHa5CDsIy0wYGR7kBh7xy4u8SJkMzOKHWXa1yNCCqHDiGb+KYVF0TJwU75t?=
 =?us-ascii?Q?LwKrSSqYyyESfeYiw3Am0w5DW4Fjljk2tIu8wrjsjinELmrIOBJ7n2HLCEhT?=
 =?us-ascii?Q?cLDq8qW/7P0645TFjqDTs/BDkKK28wtv6d0I1ZhrKLXPFVce9ofBGMWVeikx?=
 =?us-ascii?Q?ysUXcP07Xl2f/a9WL5Cq9pKMIUIuMQQXserMieJfmaMwG2tkAmRr8lUVwVSS?=
 =?us-ascii?Q?SVd2Yhnh2TNhquWUBWO4yHwGPetAgh54XJ3ENYQ5QpCyjEheUVQNss7DUa7S?=
 =?us-ascii?Q?H4Gd9Cs3C09PQmjG4Racg05LZjIp4o1A8V05ZEyF+eXayj21h3GNIYSqhV03?=
 =?us-ascii?Q?tvN0tM3PGcV4FvJRmztwntJKh1uavXVQMcbZ5hgj8M12iM98n9Vb/Eho7R2e?=
 =?us-ascii?Q?4bCl2rZ+cnKTbDo1Ib0s8tP9e5REDKUcQ4yYChOfpX8NhUCFf0NY5M6JbueJ?=
 =?us-ascii?Q?RtpBPy6nAI1v58kr/KUusZJjXNLfw13wLfsOczbd3qg7CsQCrl3A0L3Zg9a7?=
 =?us-ascii?Q?JqomKqmWJ0KAW3K5fQSEJ22UbIPPgNxXbJWAAE89AKq9T6QUSINMbM8Um2I+?=
 =?us-ascii?Q?KwH1NPP6R/0ta5O8xwcsJDE6okGnXGkbKAcsaATAfoAJU/1MzUvjuQUSdUpu?=
 =?us-ascii?Q?XHVhnTG5JpaVFrtjN4JyFAz0l5Vu+KzuQiWFgZ4x0fG9K2z6vfaWg2dz5Tup?=
 =?us-ascii?Q?Y+lLLslyax6Xoig9ocPnCsRwZXbF4fDRGDLeiX/HL4zaCp9kl6CUL4ouHv6N?=
 =?us-ascii?Q?V+q12wPbd0oDNkNJRx5rJ0zjut7eSCu/gzLWuCgXXEGd6C5FcL9tLtYAyZmI?=
 =?us-ascii?Q?gvscJG4u0no6s+LZwRFcYzw+7zTaAXkuJh+jXpclIAsg0Cs2MBw1iMAYvlVX?=
 =?us-ascii?Q?xg0y+8ZlFDuJacfRosmWmSgcMoDzpcTtd7gkC1kzqFKW0xCmPp6A/Z4pfsg1?=
 =?us-ascii?Q?hHIRuuG804w5vXdpxcqOwOU8opYf3u4JNMQ55YQ1Yr1tuoj3q6d3fbofq/Yk?=
 =?us-ascii?Q?so7GbeqFo6Ib0h4WCcbdOU/LDKmpWEqvg3CKs2uq4FUrq87DCOuDDD9spB+6?=
 =?us-ascii?Q?xTZ3wo87CqzARRIYV1h8c4P2vcDA36kFPDKVKqqkyFuGHMx8D/srNKdWllSd?=
 =?us-ascii?Q?7uOJbgFjtEcilxzfDwXmPXp5TDf4rgoXfd56Q4Kfl/0Mq5aW3FKxW2oc1j1e?=
 =?us-ascii?Q?RXJArDtnPKubmAGEGRztzBINIeV3aB15ursAb7ZB8e5GRy5m8FNz27eH0MNW?=
 =?us-ascii?Q?p3u+a3YGJvRfFkVxB4I1dQKbwUK+rrW+95VQGtgaoVbVK5r8RzEy73E6/S8O?=
 =?us-ascii?Q?NhUEX3sDyBL8h1agNLs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922b552f-a40e-4e25-fd19-08dd9a113217
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 15:48:00.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk6acTlVRSB2W35sIbzh4c9Hl0NXo2jEbd8EXRiQt2xb9gbHPyrwIQ9hdW6uKtTqKkkeuuNHmk677L0Ujq9zuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10303

Convert at86rf230.txt yaml format.

Additional changes:
- Add ref to spi-peripheral-props.yaml.
- Add parent spi node in examples.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
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
index 0000000000000..275e5e4677a46
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
+    $ref: /schemas/types.yaml#/definitions/uint8-array
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


