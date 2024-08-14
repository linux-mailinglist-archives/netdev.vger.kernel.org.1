Return-Path: <netdev+bounces-118556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1429520AB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B021C216EB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCA1BA860;
	Wed, 14 Aug 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBp76mJ0"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9261B3F10;
	Wed, 14 Aug 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655025; cv=fail; b=W+Js17jFeYQfNH8U9HjxRyYi/oqdEtEC+186oGS35lFVV6MnkDwNbYYIF/IZi7691GVdK2jSf1sb0jC7wmqExTB+Sq3kUYQ6T1TP16DY799/QaiAJik8hJtdbK7oyTmLyxVPWaKAt2QOIO1ej+Sek1F1NbGkaxBwy1aEUT7Jj0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655025; c=relaxed/simple;
	bh=dyW2hMmqtsYd77p43Yx1kHx+1IOHvMbDqvnUzA5Gy2U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XNGabjPa+rRecaiEIVXnWMyWKkq39pW6kB5OMJvdZUbkKD2F1vMHImxRB6RfuX77hE2qMSOxUKNaZZXpmbCNSUKJ5rDSoMtfA1bK76Ko9IkCpoUEaCO/3msP5hh9IkvNmphSvkyA/38/rI4L+jgHAzNeWmrUdM74caWH3e1relI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kBp76mJ0; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRlgsQ2a7c5G4JrPdvqs4EfcieJ2se6GZUBEqxy+ypb9zAEwGcki2KExgCSYzNuV4KRf4MyQ9nj5h8nfJeC6kuBWHLxEbsgBNmIwKWC6HbpOdhdnMQ6Gnpah1FRBYf0prpHHCOYafl4nMpEQzqUEJ2uhWr2YxO8DtSBHYMp+uP25DcNQUD7vMdg1bm5M3XMzjZ5+2ZSMOwXmZ0Zoz7f2ywLoaIcFscjop6rHa/6rAVy7tJg4yMt10YsmyhI8cm8bz5fA4wQ1KBEvdyAwHdi75NqKo81EaAKPGkepaSUd+m7HZYyS5VHUBkvEZXQ7vqGRswy+KV2/DeaEzlXRDyHDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQSBEq0HtSaDSgPJjhgUlwaubJZxkxwz48Q8pwkvoWA=;
 b=k1VnfmVYRlXi2+qKkvejTdQJaYZcahjkuj1UTpFYHzXYbLRTGtak0DxY0FY1LYt5VXiSUj/2+mkjHmaCewOA2yFWc0Tu/A9qwP9nbxloAHAVejGhnpBhMXLnGo3HUCy1WlUTkNIK0yI/lBdMuyc3KzNuv3iiHPhrygP4IWvkNkZfxb0G9262umhjiPp9HzL5GK7ecxSHQ5+SGRzVQCgx/jfT7mI+8F8OpF47YGca3rpLaYKfjwrhbUw9V9YtbkjvPexecHNUuNUMhb9pgYurQpMEmdT6oaK5EtnyFSyhmPDMVysh9UfHL26bn9KIxK9fjvT9saO9RMrqN0NIHJcT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQSBEq0HtSaDSgPJjhgUlwaubJZxkxwz48Q8pwkvoWA=;
 b=kBp76mJ0amrtIdjxzpMrw9bF0TSux3tPUCjzm6z/iF2r5akXNsOn+ZXHe+4BJg3wxNRpAOCx5ISH1baCqKdJd8kX1do/wE2oAmUx1mRO50V7K2hJuZuV5ED6N5xG4+Zdsa7BbWF5WKuQzbwTh7hKrG1nsWSQj4h7Hi68RXEhVIabwY3izeVzH2SoF+GpmB59UtTJkPUyeJM2m7RhFC4iLhqoMFj2be4Ur9n/vPiLWrmrw8vgeDqI+sbFcTrWywJ2gYiYNw3gKnH3MXTIBKHmroTu5V2LNYSZYa6EhCI/phxcFfSx4ILWoHrGQcEbLJf0eVfOxJohomEBGsIDSK9hBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 17:03:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 17:03:41 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: net: mdio: change nodename match pattern
Date: Wed, 14 Aug 2024 13:03:21 -0400
Message-Id: <20240814170322.4023572-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:334::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 9771853d-7de0-428f-c619-08dcbc830c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKyqzmAVP3stRLi4EB5pYDd4g9MeiK17K3VqOwrwY3ENRF08BCH7W+T3ll1G?=
 =?us-ascii?Q?F28EjTo56MziX6SCHprmjPJJehCWPqo0hoT+eFMYXgAV982IGv9V1woLIivT?=
 =?us-ascii?Q?3ExYhRo2ZzSuIqdRF24n75pUP8a8l5/LD4F2kTmtPc5cqSclUVa5Hn94JTu0?=
 =?us-ascii?Q?LNJRO/d4L2e8qVa04hp9vzliK5syoVdGKnHodQleIrGFxa8HJPzWXmmjUpk3?=
 =?us-ascii?Q?ynOw9OuMcIpTul69hf/qBMsWKSWj2dYjeqUjuTrIp0NDSRjfOBmmuk79VRdT?=
 =?us-ascii?Q?5BvvxQnUwUjjSnyAdC935pi9hRUlgOOhQ91OLa1kImqfwbu9+9WYQySE+40A?=
 =?us-ascii?Q?4MtpfedT1jDflu5AIMMKDXOR/3OtfkN97QfLHXabtJjDtyM7V3P/4H7Kz8Ox?=
 =?us-ascii?Q?ubG9E+D/jeTh/5CU921VQnahkzwua/+6evL/Ij6vOMsqc+rwimfWTgruxonf?=
 =?us-ascii?Q?VVVTBhUfgwVVvCNajPj4HIWxew9NgFcGnJz+3/EU5RrP+ieB1fLmCwUCiHBr?=
 =?us-ascii?Q?IBrxKL6ekG3B08pd+IaXIv+5R1mFdWu1TxGrNnKvjYFMNmlAIXhDJ2jW0zwI?=
 =?us-ascii?Q?EqKwAMLbxXhurSR86R7CmS6YkfkQCax1wIzrVGHC/Stbyee2wcGpqAxwJ88V?=
 =?us-ascii?Q?UDmF6dsP+plPaCkNKCHNy4iIUyI8jvZHHmcTtYIUz15PerKuUX03VF0iTjrk?=
 =?us-ascii?Q?9H6F9KDiy66NqlitVXrB5gMo4x8WqeYvAHXsgv7CCIufkidyWEmaPMZW2CP4?=
 =?us-ascii?Q?UrFkA4m40/2VRu2QFEPM1c2JrR69kj8shi3L/mpyWgpir69pO7TRfITBiIrW?=
 =?us-ascii?Q?RC1NbJ7X8UEZISnK8s4aaQqQNWZtg8V3aukjtWGX8+cMjVgsd55VMniqzcHt?=
 =?us-ascii?Q?7f4bzhC7ovcT7nLqpDRrn02LZneAWjjUcPkq7GtfIXIrRD5n6InhasJpzac3?=
 =?us-ascii?Q?4/dg993cvQj4/TT6Hbd1/yIoPSB4ijrEhdKhZwODPSj94322tMhKgendlhgP?=
 =?us-ascii?Q?G+SUCueoZVEj7n+Evasmy0MbmPhgyMYb3TBHkQiAbCeRP4p+qETD0pVLLmu1?=
 =?us-ascii?Q?/vJbrzLVbznsgKuuLjU+ZvjAVcMoyDeXmbD1Q/HsNxzvhRxij/RtUtx8VkFZ?=
 =?us-ascii?Q?MYE4ZcPI0iMVTvZF/JzW/ma56VVkO/viHhJANWacIsK5xJdYKjV0MCrt9K7i?=
 =?us-ascii?Q?fWg7ad9otK4RJE9ai4zWOWxqvfrgGmqogiscQaTqTuOHbesXMKnkq61dMpxw?=
 =?us-ascii?Q?SdomMHOXizjmlPLL2dldxcWw3SEdnOuZ3I5Fa+yIefnkdDOPbvlSIxKfWucv?=
 =?us-ascii?Q?Hci5kD8M8M8l/+LlSXVI0oxJ3M8BJxJw5AGOtbvBhucPU084015YbahOwTGk?=
 =?us-ascii?Q?r6j4yR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DnF8ZyBTY+skrv2tl8ymvuFotAp09uI1aySO7/wUw34WbwBqRk/MsP6khw5b?=
 =?us-ascii?Q?1YCiAQwIO9H3W//jV/xpQySFtL0xBPbxA7jpq0hHGO0vgM/f65wCtfyGqIab?=
 =?us-ascii?Q?w3cTZ2OPgkgnNVEDCGFww5GXyoqYhIGlxVt4sKQNesy3qTzxBpRcNvCPsrtG?=
 =?us-ascii?Q?/3xgCjcUKBNOWIaOi1io2+oAlWxMrc20uthBthKi/fNutBZ/mZfObCfvoOMB?=
 =?us-ascii?Q?jzTAzOgw9lB+bYTqftqHoLD7EJ37aWN1FcKnqlybyUIElirUGra8Go/wR6/2?=
 =?us-ascii?Q?mlA3FalbT5gMEpInq1rWvbwohSZypjFogjsc/dzTx3rNv7dY3yX7x0tSn3EP?=
 =?us-ascii?Q?NjvdJ/nT4rQjyKzoXJegIRIV6zjCv9xs69CKxcngw0fZY2NGzpxEomyctvcf?=
 =?us-ascii?Q?CyDyzm3C7vqRQYBhgO1m5irwXy9JRQ+1fVxDsx2tGAKdQB5vEfIqDOm4afYW?=
 =?us-ascii?Q?Lk6lMx7dvjVU/ruPtyrYaf2RfUNLPCNKJ9vCZ+fMSe+9KGBG3GWgv/uowmbC?=
 =?us-ascii?Q?ZMXnKD4tNv11XFF5sVuGxqXj4uICkbaAE4g27OlqdKZQ1Yxy0k+HeQie+qUq?=
 =?us-ascii?Q?XZSwi6HMf+nL2tVSxK+rZbDORmYzN/X9iaUhkl0lnlnXmSLTR4O168MRj14G?=
 =?us-ascii?Q?CjHMZk4i0WHMFfhw8w9928YwpYeALw/CwEC1dIyIwilJm42jQvaFjN5u3IS1?=
 =?us-ascii?Q?dswKSr2EZaPkN5sfzbDj/KvrCtcd/35zhUy0lpq+XbQ14oWNkHEyj4JMa7l+?=
 =?us-ascii?Q?G3eskq8A4NrqUqE+vjLiemVY/WxaQxCPPJBRCrQnht4bfIfqWEByAjYq1gaz?=
 =?us-ascii?Q?tqiMYt/5T+jw2RhNflJ0Qg+uOob6jsusZly7XPcm6H6mN1S6M5I1Ie3cUcoA?=
 =?us-ascii?Q?S7tUyLkJ2hSr9r1nqUNMr3ozrdktIUpV2fd6eao89dgGMdK6bYiXI94QBnq9?=
 =?us-ascii?Q?I57YpvQ3o4Q609YCYSOR0WnF1ebnhUYSAtgHp9a70occJJiSfjNACl7GoYT3?=
 =?us-ascii?Q?tlOD/EFxyK6ImlqX9XFTa1sYfYsRI/MQpJt5j6YnzZaiStRpUYW0vvKA3Xi0?=
 =?us-ascii?Q?n7oQolgBMwLlb+qWceaFz06Vk4fgWmKw/+OOyTEFa8uuQNguB4WFYQk2N2nW?=
 =?us-ascii?Q?mjJ2FG4MBaieVSvshcJ15B8371IUUJmvgkJvaXBpl3Hlloa8EJeidhaU2N3h?=
 =?us-ascii?Q?LVvEv4mZWE4A71Mpk1dwlxzZqU73S9zLE25+XsHi3ClRAxj6qlW5nEgbnajR?=
 =?us-ascii?Q?3NVeEBkDE3iN0dZY0SNR5+19JnGKlr4eeu7EesC9PTKTUgD+WEbGKZC8MDC2?=
 =?us-ascii?Q?9b+ArZOBmamT2SgnWQgWh/3kZDW4kdj5ClwjyuKEGaBMbtqFjsQOrkkouObS?=
 =?us-ascii?Q?AacIxoamN1auM6xm/7I/zDQRoMMY1Z+rHTufITWy922ICrGvOYFxSFS2Dnzq?=
 =?us-ascii?Q?ge0wIccqBbQ644DEhJgwfnypxqaJ75HlZLGVNfQh5Gur/3LCt1FnGSYGnI1a?=
 =?us-ascii?Q?FLS7bLV0LDLhaZZri9rhFCqW2veOCl6nHXctdr4Uvd2dOFBg4ZAZMUtmVvBG?=
 =?us-ascii?Q?PBK1seYusd+BJn9Ukj4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9771853d-7de0-428f-c619-08dcbc830c0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:03:41.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qUB8chymBcKQZ/p6ZKMAxYBt6zmiXQwtws4MTe7xvd24z42yQi21GHlqm9X1rmpJ1s9UwCtANErR4eAgC7kVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

Change mdio.yaml nodename match pattern to
	'^mdio(-(bus|external))?(@.+|-([0-9]+))$'

Fix mdio.yaml wrong parser mdio controller's address instead phy's address
when mdio-mux exist.

For example:
mdio-mux-emi1@54 {
	compatible = "mdio-mux-mmioreg", "mdio-mux";

        mdio@20 {
		reg = <0x20>;
		       ^^^ This is mdio controller register

		ethernet-phy@2 {
			reg = <0x2>;
                              ^^^ This phy's address
		};
	};
};

Only phy's address is limited to 31 because MDIO bus definition.

But CHECK_DTBS report below warning:

arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
	mdio@20:reg:0:0: 32 is greater than the maximum of 31

The reason is that "mdio-mux-emi1@54" match "nodename: '^mdio(@.*)?'" in
mdio.yaml.

Change to '^mdio(-(bus|external))?(@.+|-([0-9]+))$' to avoid wrong match
mdio mux controller's node.

Also change node name mdio to mdio-0 in example of mdio-gpio.yaml to avoid
warning.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- update mdio-gpio.yaml node name mdio to mdio-0 to fix dt_binding_check
error foud by rob's bot.

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-gpio.example.dtb: mdio: $nodename:0: 'mdio' does not match '^mdio(-(bus|external))?(@.+|-([0-9]+))$'
	from schema $id: http://devicetree.org/schemas/net/mdio-gpio.yaml#

Change from v1 to v2
- use rob's suggest to fix node name pattern.
---
 Documentation/devicetree/bindings/net/mdio-gpio.yaml | 2 +-
 Documentation/devicetree/bindings/net/mdio.yaml      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mdio-gpio.yaml b/Documentation/devicetree/bindings/net/mdio-gpio.yaml
index eb4171a1940e4..3be4f94638e61 100644
--- a/Documentation/devicetree/bindings/net/mdio-gpio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio-gpio.yaml
@@ -44,7 +44,7 @@ examples:
         mdio-gpio0 = &mdio0;
     };
 
-    mdio0: mdio {
+    mdio0: mdio-0 {
       compatible = "virtual,mdio-gpio";
       #address-cells = <1>;
       #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index a266ade918ca7..2ed787e4fbbf2 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -19,7 +19,7 @@ description:
 
 properties:
   $nodename:
-    pattern: "^mdio(@.*)?"
+    pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))$'
 
   "#address-cells":
     const: 1
-- 
2.34.1


