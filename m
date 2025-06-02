Return-Path: <netdev+bounces-194676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F1ACBD72
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 00:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C31891F15
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 22:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1E25179A;
	Mon,  2 Jun 2025 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dt2qXwBj"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427D1E2606;
	Mon,  2 Jun 2025 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904267; cv=fail; b=lPXPiqzVLNkUB0/VICsYfKRE2NU8XQi5Dj1+CouRo7n1GhNiFa8EQJLJPMMluR00+/v45yK31y8YrtyJU+aQshdqitWMV7h7jEKswhbAHpFaro661ATIAtn3QuBKl3YYCS5V2uVcG7kvSAhchDqxyrRkkQZ8lNIyTrUubRv/IKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904267; c=relaxed/simple;
	bh=mQXhCADn+udLKdGtDDLoS0uwaT49tPuguIwH750pYRY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IXAhWsLe/lkXalWIAVXhyrVHv2I6Aufo4LGqzIlsqIPKan0BmqQ6++UEIiL/+NfNK3E9fsYEPyIxzwbuC0t3QdZrLsOKZjNTI6VXgvM44AKx/nubPqg+eNEuiThJJ2mr48GUY/xqdR1XkbqmIqso9ve8ZO5wyQAWwk0is/RSStk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dt2qXwBj; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=of2Z7JKsD604PgVVrFocxeATK31ROTf/qDw0I81rPPIwmJbqmIiE2hARlvpJrL+cEOOS2y7NwqcE3Wf+SWVNYhJU150nuh6o2JLGBllJjMA3IwvkL9pQwJIYy4zOt+HhSlI1JQnLLHm5UdLebl7HHQ6vNOj9F3flO84bpagLr8RH4XOxlnofKh9/wXDVajwVVsEF/luBYg9Gt4U0hGdjBh2e6n1nRk9OK6qLiqkVE9ZJwb4VwdlS4qlLZQlIKu13v4J/uGutCBUUjVccm41qqtK/FqF5TKGrViqf2oPWzTSDIWPBQWouNQIGgfWwgA1TPGJjO62Uhq/tGI4zC23UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lzZLNjlGOpOCiRswD+SdkgDah3b7KmkBRwzkFA9GE0=;
 b=mwoh61W5H+9ywGm1vpndjzhQ9yXbiK84otI8PszRMf0PIX03mdGr1LmMQlnAmlspOHNDbn8KkCJrpMjUeTAWJyjpdeQ3GioK0AwggeL99VMey7ICEGPecQ8VxRPP4Q6dL01Tox48V/d+MuHfshJlJ6sNQs60ghGVxm5/iqQvG/rq+W+oDSi3SX/8NlP2lDuHnVvbxQxG80HM6rRuPaoUj8yZa5nDz4h5tcrGPQljPOcX6wXCBVHItybqsAL3E7v4y3bZUGPwtQEpWLrFBufy1uIRKyU3FkHdXduXNn8/B4I2PLTnNd93s0LrDdzMxgN4/ywnMbOevwvGFQ3i4chtKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lzZLNjlGOpOCiRswD+SdkgDah3b7KmkBRwzkFA9GE0=;
 b=dt2qXwBjtVkBqMOUjmEROkEEURy0bOw7bqUpzPskdx4XTpm7Qw0jqPbz3SdN7SUCejxLMorugJsZpoN0oBKEYw5Ne4paES/e7lj6Q4BcKSYnke0a2POKp6BdWtaD5Qv8DlfxUBdq3FEB3p3XuHnq7SeKhFFNr2IQ1s8rRHOAr7SfwkFhtu3u1gaZGxbDws3I5OXzm4U260JltzLj9jShhI/dMfthjGy6nBiiXbaDi4lThhJ+yfsfqtjIXUqukITHigagVVudlpSOMXo2GtT04ozlFqi3Ubt7scbcLoWYwPfzKAvcVPxmQvphfQRFyJIWWjEZRgstwJT2XIkx/Xk1Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10994.eurprd04.prod.outlook.com (2603:10a6:150:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 22:44:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 22:44:19 +0000
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
Subject: [PATCH v2 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
Date: Mon,  2 Jun 2025 18:44:01 -0400
Message-Id: <20250602224402.1047281-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10994:EE_
X-MS-Office365-Filtering-Correlation-Id: f1623b2e-d9ad-4f66-875a-08dda22702f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mgzz4SDBBd41j2jeiEYmEslJTRTA9/sWR6N1YjujA+TWiK9awZfJdjgHMMAj?=
 =?us-ascii?Q?h7YAzOz54lSdBCPj1vMnIWrMnoJtENPDOvER1sIgDeB34E5+h6eZUhNAwRZf?=
 =?us-ascii?Q?YagWaol2B730MR6ArXv/id7KRs++hA34yGOYCqJnTe51Pgwfp/ZLcKiJymf/?=
 =?us-ascii?Q?YcBIb8x+YnYRe0Nd0ZDBWnKj4zAQ0qv1qJL56DLwzZ/7QIFlV38XYqkbTjJT?=
 =?us-ascii?Q?dT++9YiAa/s0qRTAr6eFuSs+Wb7pmEXXeIjwpNR5PGHb/Nj6+Av2FDEkUPAD?=
 =?us-ascii?Q?LIB7WOmfPq5X57Hay6Ifmq/OQzQ2B1PYPe3Kni9XXr/Gl3HSC0+kGhoT6xoA?=
 =?us-ascii?Q?y6hks5gmVACz3oaxa1hQt1Tsxeyw1TVpjiuuPira4Xe+7IDEFag/598sjoF2?=
 =?us-ascii?Q?Yg9YItxuC8IafWJUWb8/jildmcJas6dbtGW/o3uLG6/fSnK8bI25OfBLSt9I?=
 =?us-ascii?Q?D5cB+rnfqB9xWYv4GNhRMey5ECk3jAlND/JeKI8Dufy9bAy0o9YmeDyk8QOM?=
 =?us-ascii?Q?3e7VwejTTaJABIY7T35/jUroZ/osNKXtN81c0fHNMxH0J85IAlznUvgQXeFm?=
 =?us-ascii?Q?Tj2LN1iIvsqWPgtl2DXdsnlUdY1vYVFP50c+p9qpOo4Gi7VmGtPZur4UFnl5?=
 =?us-ascii?Q?fDk2AUkHCiUhkSN9+G7LEbGkt4JMMtd46eD0qtWTgS6j2AEzI+JHNhhuK4mz?=
 =?us-ascii?Q?FrN51AlI+PGStBkJD1zcMn0fA5lRzSnU0YTDeKYNOLTfMLscJFMsJjnK1kY8?=
 =?us-ascii?Q?nDpo5iA+OvXF4XowpyebgKwI5Q/gwdI0u4to0eAYfuaDs5bYK1rrsqJCxSvK?=
 =?us-ascii?Q?wk5AGUVFvmrl5geDFfggbSQFfCcYJAwN0nxVOJI0fgxCU6DGQwkx6IYVFWPE?=
 =?us-ascii?Q?b6o9idIpN8Ui5k9IzUzRnSKSLBf+x0HiUpF1CsBx1mfpn2J677MSyyhp9Nmd?=
 =?us-ascii?Q?QtgghJmw2wIY+fAbpFq6TOl84/k3/v8ij1tufSoKKyQiAmvGVKQi1v4nK+C9?=
 =?us-ascii?Q?afO3/R+T1T1f9DwktiJuzSrzHfbVyE7QIEdXrQoKYfLaVor8AF/Yz/nj5k2/?=
 =?us-ascii?Q?qlhbeADgC8u2X/PNOhncM6wXdqEhHIEkH+apPp+PJDplYwLXv6ZJ/sDkRoOG?=
 =?us-ascii?Q?E6N+jd07TeN33gADX7RopQJMU4TzJZ+Jb7BsGrpbUWHF5DTwe1x3VYmKhK+p?=
 =?us-ascii?Q?xtzj7yvL7AIXGKUXQAjboTNE6rjm2IbGYO7411ysX0s3G6C7QjBWael6JjDg?=
 =?us-ascii?Q?C+dLNcRoqyXE5A8e9JWpy/ops7YcqV+GpjkoQdY7pPtu1fTlys3tDCAKeZW4?=
 =?us-ascii?Q?DosCEoEoSU10rIdyf10UENPwwAAmNz/MyufIPTH+ZMPjnHzOGI8Hu3KfiGXj?=
 =?us-ascii?Q?ATnWSiXObe1qusdFmJ4s83qfLu2mz6pl8yYOEV7edVdVuJi+znf/uZ5s++2O?=
 =?us-ascii?Q?IY64GJPATrMn4gaLGv3m09HGTwQYQs0G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RR91kDBb3JQfvy7ePPpKWcNFwVfcyJpoyRTS8SOxgu+Trz4aAlydTTGs56Nh?=
 =?us-ascii?Q?YcnopTLJt98PVhUkvZHwUp7rrgleTVjoa/pKO7JSWRSmCO9ZDp8r6NcECA+0?=
 =?us-ascii?Q?7dLTqRgIE2blCZuxANOIjwl0IkZENWByFRxQZrnt4qQglXEwxK/J1fCcbsJK?=
 =?us-ascii?Q?adNYZaKX7xxPdRLYioWJG2SEgACn6Uw3cDgLxiJOv747PoFfdH4feWzh2n/+?=
 =?us-ascii?Q?DyAB3rPzY+UzOTE9vbd96mHuT3VFoj1jUWvQ2LRb0KTySDlMBpATxXp6Ps+6?=
 =?us-ascii?Q?nPZKjHkN0fTbCEqfmzXKsE7R4Gr5qgWrekPVJ0Cjg5hnKAQ75tqjenbIsDC/?=
 =?us-ascii?Q?YbhJ/6sAPtZI/AfFmTCCClBOYTYkP6QvuT0Tbx703j6yJCHR0qtDTI13Q+yz?=
 =?us-ascii?Q?jhZD/uwb8kL7a924UOPCoADbIsXCA9wIL9GRvoOsJs6SUEoX40jiXTVo4Wgz?=
 =?us-ascii?Q?GNmrAhxk0a515cIVGb6Ta7Cv7l1QRbYpHPYFLKkSXgcCu1Gft/OjN94GtFLb?=
 =?us-ascii?Q?qV5ErFPXRE3YJeUf4FatLYQzWs38lZ8EfGxXnbRT4CnunajSHUopsAcF1vT3?=
 =?us-ascii?Q?41edV47dbFTUZ6Rro172To8KHqcfHW9d2GqRnIP3BnsfHmYEfvqhfRn/vrmT?=
 =?us-ascii?Q?VlzCad/hZIkP6tC+wL67d/BzjdS91vsV65nsUV72qkPbYNA060SPWJ9ck3y6?=
 =?us-ascii?Q?P5wSKFnX5jnGvAiUaGvE2XrD1v66uomhSimVyUstGqiIUuf+ddkGkB4U5Byi?=
 =?us-ascii?Q?1viBrnIdBZX5Mn9WF53z9vLiJPosWRMBS88cq+IsenPnFgFWJSqG6aW5/wXO?=
 =?us-ascii?Q?rCvC6qTpAPb1Sn3R1GZGS0Mbiz3vy7uWEjWo0S+wznqbOCkA31NK6kQms3Ap?=
 =?us-ascii?Q?rRpto7qxB89br9aJspsim/ZLOZORjWnLFyX9m6EitM4Y6URzlaqxHIuEo7Cc?=
 =?us-ascii?Q?Q4hFi5i1UHwKqVQxUtHZAYr4kYZW5fZYmQAwW0FdPePbo9aOFxt+zCoaG7rG?=
 =?us-ascii?Q?WPM+Ho/dFuc/4soA4CGGcXzJ2xCmHxD0ubbe1RQadLEptjYv6/UPipDMdO4U?=
 =?us-ascii?Q?MwN3EdXehP8OEW7pEfDMdb7ZMiAcnhXLnfJhepmGz3EVm3yuAluxIuGHpuxG?=
 =?us-ascii?Q?X/9MXagqC/SbuPWCzUsFgHVH15yqSXLtUCygdGNIEc8rN4HaAAx8Ytc2XIym?=
 =?us-ascii?Q?55W46TvsUCGBBU4+adDYS9TuI6gc6AH+KwtD4HWvqDI6kDE5gPRg80fwsQlK?=
 =?us-ascii?Q?ohfHRAQG9NuL23orCvsLF51Xv4il/X9iF541VrjELH/X7MBFM75bZCJfhk4b?=
 =?us-ascii?Q?a9vrTUmsrv/FaK0rK4rIYYDHg6617DwqJgzJbXSiuhKTd7Ao3iDNunF+v8Xd?=
 =?us-ascii?Q?iKhOil1/zop0ZRuKp0jKOWEAkhSc8v1bV+/PwrwIrOOFptRLLvqgls2M1/FI?=
 =?us-ascii?Q?hhIlxJ3pew3Mo+FseyUHvepgxgoX3jCjBZXBMgER69HVN2jW9gvlfm6ENq9L?=
 =?us-ascii?Q?c6dzStvlw9Xqbt7CDvxtroJblm4jTKxjj0tav480Qg9Hqfo9zBpO2h+ZxKcb?=
 =?us-ascii?Q?0bXWpnsjZ4MvY0L5JaWOvNZNkbKmbogr1sOJJ7G+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1623b2e-d9ad-4f66-875a-08dda22702f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 22:44:19.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dctF4zJ20mKSc/7+uN3TaJrb0MTYlF1Yo/UbPzVNWRGXP66S6c6Jopdlm0rhMcCoYPlQP9bBdUvol543jkiqJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10994

Convert qca,qca7000.txt yaml format.

Additional changes:
- add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
  ethernet-controller.yaml.
- simple spi and uart node name.
- use low case for mac address in examples.
- add check reg choose spi-peripheral-props.yaml or
  spi-peripheral-props.yaml.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- add Ethernet over UART" description here back
- add add check reg choose spi-peripheral-props.yaml
- move spi related properties in if-then branch
- move uart related properies in if-else branch
---
 .../devicetree/bindings/net/qca,qca7000.txt   |  87 ---------------
 .../devicetree/bindings/net/qca,qca7000.yaml  | 104 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 105 insertions(+), 88 deletions(-)
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
index 0000000000000..5258288132968
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
@@ -0,0 +1,104 @@
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
+  (b) Ethernet over UART
+
+  In order to use the QCA7000 as UART slave it must be defined as a child of a
+  UART master in the device tree. It is possible to preconfigure the UART
+  settings of the QCA7000 firmware, but it's not possible to change them during
+  runtime
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
+if:
+  required:
+    - reg
+
+then:
+  properties:
+    spi-cpha: true
+
+    spi-cpol: true
+
+    spi-max-frequency:
+      default: 8000000
+      maximum: 16000000
+      minimum: 1000000
+
+    qca,legacy-mode:
+      $ref: /schemas/types.yaml#/definitions/flag
+      description:
+        Set the SPI data transfer of the QCA7000 to legacy mode.
+        In this mode the SPI master must toggle the chip select
+        between each data word. In burst mode these gaps aren't
+        necessary, which is faster. This setting depends on how
+        the QCA7000 is setup via GPIO pin strapping. If the
+        property is missing the driver defaults to burst mode.
+
+  allOf:
+    - $ref: /schemas/spi/spi-peripheral-props.yaml#
+    - $ref: ethernet-controller.yaml#
+
+else:
+  properties:
+    current-speed:
+      default: 115200
+
+  allOf:
+    - $ref: /schemas/serial/serial-peripheral-props.yaml#
+    - $ref: ethernet-controller.yaml#
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
index c14da518a214c..6416ada9900af 100644
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


