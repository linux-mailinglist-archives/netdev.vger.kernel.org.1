Return-Path: <netdev+bounces-195474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DFBAD0633
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B913B4702
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049A19882B;
	Fri,  6 Jun 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jvK7vjnP"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500914F98;
	Fri,  6 Jun 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225097; cv=fail; b=W10cx6/jPrOyfMOek6686XmPvejsnh4V+c0onLxjR+1r0iLLstACkZ8N91kUVB6IFSHE9yTKqWVOFf1rkmtOW+CVItrtiB51FDaKeKSrYGFgh8gzdvi+BrLYFgKATNthxo0Vpa1gqooJGBVbxXiqlWCZAwdmSE4jywSjc0VFxE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225097; c=relaxed/simple;
	bh=Z2nZxw7xlM74pEjcBNcRtdgv+G7nkPYLvLnnzYd7qKU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mXPBPB7GooizgEofQ/aYf329i278Xo9A5079/XKD/axPn0mYWeKw46sASqYNSZTvxRYwNWwWXxMR4uYQb5bUtsKtijzbow+g0cvo+SHhmJd2SxMZ5svSNlc/nsKs7Z63PpV8KMR0ks28FSBGcwlQmZ1VGwwQ5aY8NmQGHd5jLcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jvK7vjnP; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWonhWv1o7kQitC2W1FPbQg8B4jf5CpnOoCPsiYtFoO0ksijMDuMTmWLIVLEBxccqarAboedc+FmDcZSBWaGtyGzMOBrX4I8+cDFOqKkiy7T0t90Ljt7Y+Z6VH/1/uEIkAIrBQPijuwwEgiuTbqf/utoqSDlnKYiCewTb5YjQJe6bJTS6vcl/egf2+e4riXpFh6iTFQ0/J+RsbBYQ95y3FFixW6qfFqDyDYY6dz+fPVTYtbuMa7GQ76Di5SZDLb7WAUsn5b/Y7vW7a7UDGXa/mwalc+molMBI/DWlMF1omEjE4r8fxoWxa80kZgzKQDd/Bp7DVaz5eZ3d5mta5NAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1Mo5uKBiQLLM8CnQZ+YBABLMtKSGePxDMPREtCC8Ag=;
 b=VpVoEXS0BKmTMMCYHnklSNFCRHVt/DlBnQLwTQfjuWsKpnlHr0X1tWm3Yo1DZdfox+CwZr8MyL/lA7GXg2zbj19XiC0+uwxZNjD0gqk9oK7eGo1b5DmrVaHTyfPDeyBfigCHMKONYW82ja8sI1paV7DREIA2DSeouxKzPS3M8lvnRWppNYbNzVuepMtoZzTGyFrFisSz4ATl5qvgd29qaLVEReD++KC8/9o7H1HCL7sF9ur/AhWqb598iYwTeuHgU8IjzWxhNH7WMzsOGxeffw/Y4aP2vP7p9D99tIhBSWM1tNnzqURixpP/6ASXE4/9lWUpCfAFXwR7R+SUJdeicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1Mo5uKBiQLLM8CnQZ+YBABLMtKSGePxDMPREtCC8Ag=;
 b=jvK7vjnPTa8C0tDqpfA5Bs9t2xIVlYgtOcRe1yDQ59mG514Muj634DuGzvZrjcmmCR7cKeJpz685VjpBm7nSdTtyLmVyuhVkuADmL5PSTFWHDynvh0hF7kiCkNJhtDP+UhQCok3rANer0LikS2fdYmIlh/fwav9UAXvx5nzF47MBoz86jtiXxGl45HcBag5WPRwnRhMdsTdpsCTlt5coSlZCXchwR8MY4rADipUhz65hGz2xkmCCxp0hmKvWh+X7SYQVsoR2XOCvqD/nqIKylEgH3bsBR1g9iAniZ+3S9CziJDAYA0GhcCVl6aL5hJJBzMnQ1Px3zBI+MxonS+Sqng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10796.eurprd04.prod.outlook.com (2603:10a6:102:48e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Fri, 6 Jun
 2025 15:51:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Fri, 6 Jun 2025
 15:51:31 +0000
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
Subject: [PATCH v3 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
Date: Fri,  6 Jun 2025 11:51:17 -0400
Message-Id: <20250606155118.1355413-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10796:EE_
X-MS-Office365-Filtering-Correlation-Id: 99339302-6916-4283-ae3b-08dda51201ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+WT4VZuTq9dBb7KNzD+KLMbiShbknNyt3rVcA8lpuUZQdYD7UR4HiNQ6fdP?=
 =?us-ascii?Q?or+tENdEdbyOxHc+pYIqKP0T2kvtN94S5SeDKBTvX2drAt8V6VqP8DfePAFx?=
 =?us-ascii?Q?mm7ttTi7fUA58+y2s3zr7tgxzvy0xt7h3EcAi2J/rffAWJpduQrG4hT+DYKx?=
 =?us-ascii?Q?j2Oj4pqQNGesIVaio/+ypvLh/bnbGoqCufGGPRN4Pc5fUmOpckrKATNyXZIs?=
 =?us-ascii?Q?+bOlGxGSME06bnfEWnj7q9sYw6JiJIejauSABp+u/vSQKc9mgIAFlfJsuLwN?=
 =?us-ascii?Q?tOZ1GFoFa9DUBrwCJt91O3TUmXvB2GSUs32XSzqjb+aiK50SK8V+n0gInN5X?=
 =?us-ascii?Q?mfeRv9Ts0nrKS5jVDRd4lUwiLmSCtfHTJOdf9EDrvuYS6dosocx0gal4VVEy?=
 =?us-ascii?Q?1k+2iUPk2FQSRKyU2J8A0XYzssFcwEBzQg1IclOHRDnAff0BkzzApZlxLhKa?=
 =?us-ascii?Q?xRpwolqCXxQxYItcXZurVclevwwIbpz8c5KWjCY6Qtg9AoASZtfesVTG6eHq?=
 =?us-ascii?Q?MhYcR0o2RAohrC6/oQQgJZzMUbNpuJfirtd6gUBL33sT6/1CxrPSepT19OzB?=
 =?us-ascii?Q?4LczT9RNNnSsGvOY6LJpdVinTF/3UBcnMXtmaEMa/fmu8PPsK0YOaxNhnoo1?=
 =?us-ascii?Q?8bsPMbRzBys9vN6gv2pMImh0KRdIYU3fgVe0fjW5H1q67Ii4zYC5OOwa1gY6?=
 =?us-ascii?Q?9GRYG/bC7ZyWRqh1ZZfAM2ndukTE0iP9p2dMeyNUWdXqxaXqKJtAVmIYfT4v?=
 =?us-ascii?Q?Fl8D25mfDPIhNXbxtQDSTw2CDg0oMvSG7mu9R1Q3b2PT9ZlmqNcLJngPLdEA?=
 =?us-ascii?Q?B2dDtPCiA8tx4tnWzZQc7jbvHsyqj6VPcgcoZb+AUFE7JrJw3s7G0bbYNi5O?=
 =?us-ascii?Q?X0VVoumb6bDLn8GioIgkS4kTD7hk9F3pFGa/L3Z+ar7gh7YXVkQ01MqUYMY6?=
 =?us-ascii?Q?JJUz82CUPrngjJQY0y6dg8XxCxRcxXgel9yGsI/hOFHSHTErFdCu/HrwxOju?=
 =?us-ascii?Q?Oy7g8MU01OyM6vSZ+/gEc8GJ4BAHYmIeE0RWkOlPrrx/P6DgYh/4IHRyn0ZH?=
 =?us-ascii?Q?4vnLgEzZmtaQTEgbkQw+Id//9b7JoFcn4p9cJLhYx2rVV3vstlnkyh1Lzpf4?=
 =?us-ascii?Q?9Xe7kWtmQqkJz/xBSlIhVIbw/1/y+bfR36C6Vr9/0JqmuPYybAfXXZ5lbhiR?=
 =?us-ascii?Q?aiV85DymMTLgycEKseviCOuvRVUtt2Bc6Ev2HdImipizJsqv50HlKQuATwkG?=
 =?us-ascii?Q?12wex3aOr4I1H5xRLlHasMfVL9+73oENTmvj/+Ik5/52jIBKkklNqT5p1eCq?=
 =?us-ascii?Q?lsaiXfmovcHwQ7a85OD1sGklk8LJrxXUcKmZCoGpjtv1woXQkROpqO57GYjF?=
 =?us-ascii?Q?sP7Kr0oCI05ey2z5jEeb3ieLrXjAciW859w1wC8/T3tJhmkyThi800H9sXNo?=
 =?us-ascii?Q?vidu4ikjCV/nFtRPaqywgMo+7XYE8yi6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KtTup7c+xT5VGvGYn4RYh62oL3b4o9hWz+N2utWGbCahg1YhLeuBoI2hn3mg?=
 =?us-ascii?Q?dP2MZAggHJKSEkMfeOSJpbouAd2mwMlgVxHyAQ8EKDGIe73aa7SJ8YoIx33b?=
 =?us-ascii?Q?LJ4zZu/4D0b7Xnfz8T/KFQULCyMpXcK/VwuW7oSj6DlLdD9yDPRP1dGEfMki?=
 =?us-ascii?Q?g/+y6A1f1EGalP2RiX0vcPNZtXXhSshh9Lob4Ou1y3byZKAlfOooFHlSh23+?=
 =?us-ascii?Q?PIukWRVAKPUK7k7KVnbDucLhM3hvA7ZThX5V3gfQqfR5d4mltzdkSJNFe7Xn?=
 =?us-ascii?Q?l6eIx8I/k7Z37QaB70jivoywIpMBP4Ygi04yk73dG+YRLbHwf8mkRvMXRln6?=
 =?us-ascii?Q?I56gnALTx+RKM1V6SfhEUGz5mER9Pbjc5IWAusgNuy6Q5hLRWT32VrHQ0HPm?=
 =?us-ascii?Q?mZ1n80bq+UuYnBF+Yn8MPj7Xz2jxRayEXiVhfIH6w4YgHN3gH+BAkzxVLNzJ?=
 =?us-ascii?Q?hsFgbRH/8IpIiaLjsu9sFkgsXaJfnRwoYsiQMcgDahY0rHRIfcRT4t+SKHal?=
 =?us-ascii?Q?azMUXQ4E8A7ybgOF3AN+HzLAfG4FOTgvnkBib0BaAfjOjNzjl94d+bsu1RkJ?=
 =?us-ascii?Q?DcvAab887MaXbeApLll6p1ja5dm8BqhAqy4aZOxbYaW4Ls8OHfl1mKX0Gy8y?=
 =?us-ascii?Q?hgITs8XIcaFqapEL+f6U4rBtYt9cxVaQGqRBKlkcmhxObWujiYvtHGnMlegw?=
 =?us-ascii?Q?S4UqGnQf3PKGaq9hXX4s2EECdQIDiFatUp3tUfhJDdBbkKhWiSfDGaUUCeP8?=
 =?us-ascii?Q?l24oDC9UbIxzwhpVUXNA47yc8PRn559a8GCWpZU/hdmLnz07sPXRm27Z8T7h?=
 =?us-ascii?Q?mkjJZCI8C0smIGawjdz990pzsck2Kjg9MfYdH7H2gzEc33EwhMjCiS3n4n3a?=
 =?us-ascii?Q?ef6QWWzsJu3lWTzXfD2pSZ7Dc8otGYixjNan13bLck8oE0i2PjbfmmOqRMDF?=
 =?us-ascii?Q?sPE0C0wcPTePbdZqT2mYu+vAKKsbbMM7GDyabh2fbAlAdvajUWpK6EpYhXhn?=
 =?us-ascii?Q?tR4+wtMReP5qgDJdQxqVl+7WWfe+hgRUQQ9n21p2CyRSW0F9h0L+YaHFK7to?=
 =?us-ascii?Q?5Eto9vTe2gBafXM7/GVsYAy8OpH4E2WIYDci6OCDuY4119+i/F5yPkUKB9Sz?=
 =?us-ascii?Q?mk2PfB9eAUc8kjCs01Dqhbp4OoRzmowEpVXnj8j/yh23l6qlEaQKKCF5YWyO?=
 =?us-ascii?Q?BEYOOdi4D9MBjbebzRzbUahOLOTTofQn/SKqkBXkZVzGWnR932jWLPdUf+3A?=
 =?us-ascii?Q?ioxc7daMk7+w/L0TOmhx/i0B8hlQMv1D+RPlLwQcq2+uG+rpPBEcF2ap6lj+?=
 =?us-ascii?Q?OEJAwK1I7PaJ4HyX+aN+Gf6EYYtlwmVAAAHk2QPb3meGHeULt7VnmEBwLw3c?=
 =?us-ascii?Q?z8mX7s9KUz0A4Uc4CgEw1UEf3JTdwC18o3RSgD9RcnYcdOi343B35461eZKT?=
 =?us-ascii?Q?P7+vlYazGu8IbeF2JOEtKqAUf2fftA7+YMjKSQdTLVjp9NvRkQIrfU+N/CaN?=
 =?us-ascii?Q?0yYFc9yJP2OR/OCBmqN1ojZ+spDKnEU0jYhlWXzu9YqamBtb8sDxWhbmem3s?=
 =?us-ascii?Q?uvf/xODVC3JTAux2GaeRJ2FiFMTN5rX+G1OtUY4o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99339302-6916-4283-ae3b-08dda51201ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:51:31.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cF9oQMRx/9sY9iP3j0w3ZGTLTqcPHE7+mG7w3FzAb0wO3SIZkuWI7i8MpDio/mXCcTfJF2BYBYwr8kskBJuLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10796

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
change in v3
- move ethernet-controller.yaml# out of if branch

change in v2
- add Ethernet over UART" description here back
- add add check reg choose spi-peripheral-props.yaml
- move spi related properties in if-then branch
- move uart related properies in if-else branch
---
 .../devicetree/bindings/net/qca,qca7000.txt   |  87 ---------------
 .../devicetree/bindings/net/qca,qca7000.yaml  | 105 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 106 insertions(+), 88 deletions(-)
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
index 0000000000000..1851055a86af6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
@@ -0,0 +1,105 @@
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
+
+else:
+  properties:
+    current-speed:
+      default: 115200
+
+  allOf:
+    - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+allOf:
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


