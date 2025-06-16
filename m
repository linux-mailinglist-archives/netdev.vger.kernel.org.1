Return-Path: <netdev+bounces-198197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC74ADB90E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6647E188FF73
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E5289371;
	Mon, 16 Jun 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G6BrQBQL"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAE20DD42;
	Mon, 16 Jun 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750099719; cv=fail; b=Q/UBBGLyn3gSQOfRba2ut0JQsThLzkmiejejpaQ143CHCYGJaVbSrQMz/4n+pzdKqVMCpZiAllTsFk3BP7qpCMA5W+J0TK3Nlmay17pIi+LqYFFyDj5JLzxfHKQU8YxzdTTFcSer/OL8+K3r+8RnKJez9woWUzHRC26Zt3LTRcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750099719; c=relaxed/simple;
	bh=XeU20Giu/O3e54MERZtnmG6tE+1fa6vImZbAUFqwW3o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XndyZ1asRyEq56wm+edqpKmdehhCzQegZR9lkqLWHwgVy2YlCnfHU4+kgh0Tq+yijrLy3BBnBSbLyT3G40+W0b/VdzEJWA9D93jhqXJQwsrlmPN0lLQFG6dCGXL3xjN1iQjQXKy6tQUavX4Dzyxl963cnFiRchoV7IdKnIZrChE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G6BrQBQL; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5U0uDQr2D1yNBAee6vsxufGe6J8Vi422JJhVwqKfj3f/e5tgc3db5LDJGC+0Z+2V0kkk4VooBHkdunhA9DSj3J9fAJweRcXB3ym5hO2xHh0bH1E2tDrHb3WQBlb4RW5CsvuOKXAzIeLQ+YmdlhcCuHC2uVf1AQj+qxQ7cw/hwKtALHx4CFh873pV4wfmguh6Z9qRI402dmzx5LhWp/lXub//nEPEDLsb4jtpsaRIXV54Q16ScUci6a/IYzbxuuPpNKkGXm9zql//cvEV3mV7QV4KUPT6SRU3tSXO899tAQXDb1LEwbcP9myzPwL+C6L9z6jXIZaoktWufSv1LitwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7ZVtdQw9+8b8O2YKQZzdcDWKqWtBlcqWEtif3eSS7w=;
 b=X7Zn2TOKGS3PaWgdcZMrgtwXIJqj8ZTkPIZt/Yb8PGy4E51CKhNpJgI9vXUAXx0fGaV8aJFlu8ukO1oKFluFTvZBl6xu9rypL2D5Vkl8xUHI8KEIi+rky3RWTlKJQTW8NugCvrg0f3tttnFDET9nmDP+TJVZlQYvOq818K6e+t3LuucvMP6xckKrK1Xk7OiCV8SHpwnf58x8jJB7t+JffkjpF/OOE/8P9FEH5yBiwehH4wAkqWszRNlDX83lBwJ8Y1qH+q5dHXHxb5aeg/v8mQwaePV7wly0utJ/OF2Zau5dRRyqCW2lnRbSu+t24bwrQ58tsT5Om20R1WtDFV0+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7ZVtdQw9+8b8O2YKQZzdcDWKqWtBlcqWEtif3eSS7w=;
 b=G6BrQBQLtUirI+AaLtca69BKErtWFnOJEUb2s9492+gDWR0miNQHFtDgowug2pRM6bN9b40tk+N2HWXs7FMw07BCWQWTTivSapqgoh1fVbTxlgK8AxxyzH8UTZyJiZo7Uj6j0B9GZu0HSjakwzR5TQtlYWNgpJcRwhVjydSrA39bIS1D472bfct8gVER4XK3M86BzRZHzA4SiO2KwfbJiNJ9cQCTe7aHy3/0ibleBr7wDZZOb2J0miIsQbXbPPvnpJUQZdpTBPrvZnW4mjZhBqLTx7Knn/oPz4sXsbsgSAKjHXs2z5bBAG1qlkwjJnDAMcJNgU082rp/bncs/+Nopg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7429.eurprd04.prod.outlook.com (2603:10a6:10:1a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 18:48:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 18:48:34 +0000
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
Subject: [PATCH v4 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
Date: Mon, 16 Jun 2025 14:48:19 -0400
Message-Id: <20250616184820.1997098-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe626b1-c819-4f16-fa10-08ddad066552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ilEGJ7GEsV/D/of8a7cBUgxuX/Vl7w1qtOJ9dX2++wSEXEbxvSYiQpDaSw8q?=
 =?us-ascii?Q?hMoPzzbuewMTwAIJyxiuejjIeZS+fP3fSYrK+vtSn1pI59JMHObOXowoo6AP?=
 =?us-ascii?Q?eZe2WfIaYFO5ttdnuN89ll4PpMRD74C3NNMz3xQps1pr+i6sP0R8k2gBOFYh?=
 =?us-ascii?Q?3bED9Hf6ZDGk/QsYyMZjsLdfE5IWJp3hGI5ZM6sBjFUFBoqvB7CjfzaZZgb0?=
 =?us-ascii?Q?1FcZ3Bpt4XxcEqeebWqaiofQ+/IDkBw9JGLCl1YIiiefSfa6xnq/m08Vd2sO?=
 =?us-ascii?Q?j6WW0I87eaO+FHs59Qqkb3Q5EL9yDZtt6U66xHDXZPycmWmrnPdvQtXoZ3FH?=
 =?us-ascii?Q?zDac+NzK20VFkbKhK5AymCN38p8G5m1Sa04NpjSCmaW5heGgvbTJO/vLPuQm?=
 =?us-ascii?Q?5tKQWeSszE96fFC+5fMB9WUEimmM1mkM2SfzW3aivsE5j9KLjHwyC3RGqVXw?=
 =?us-ascii?Q?KPTCXE4SJnmmCuhV3YkWV10Nb7PH+6OFpqA3h0KtuM+Ohl6h/wRn6mW2v35s?=
 =?us-ascii?Q?Bjm36mQS88fJkl2NwLLjpYGh5RWzZ8ZtSy/d2JqW0OPa0m9bChMf4W/JBfy2?=
 =?us-ascii?Q?GxympuHACxRMO1GbsseOfW6WCMn/9EIY071Q0UXONQVYAy3EigzUPv1LhzCp?=
 =?us-ascii?Q?fHVcu4BhSq/iQL5PTg89tRHrVb1Paw0JYa4F7jlPfP3Yt5UFiQXcDI3cXMWx?=
 =?us-ascii?Q?1pPAENTzGZ43VfD3d+kZBDmraNNwgt05Iu3VHwJv4429dk6yBrls3b8k/3iQ?=
 =?us-ascii?Q?f84FM3GvWKH1hazjpxf307PAB6n04DpaP+BTeKNOVM5aXPhrOihYAOBL6Ct0?=
 =?us-ascii?Q?DiwTg1UKrGBwTDYBDDuDXTOSYwHOlTT90IqFo5nFrb+zLawXoXX5M3UegcoW?=
 =?us-ascii?Q?xkWtzv9KTbYN290+lMp8k6rJ7a6AyNzr++IuteAI30X4yuyUYrdoAQxtiByL?=
 =?us-ascii?Q?YU31kzwfDW/OoUBqa+Jr062KFeo+1LLcpTq0G6wKSn4TZWTH8cIT0UseqRse?=
 =?us-ascii?Q?fsaJnJmmktKy49l4COUH+4pHaHwSh/C8W6+lzZOMfIz2iAtu6EbvsBpCr/WX?=
 =?us-ascii?Q?L8H6HDaTinp6m9Etgicf5rQbUwcMcWCb43qJRVSSCkZKOsx8b82BC0lbuyB/?=
 =?us-ascii?Q?aoragNWTjR7lnqx52WowonwKYzH7IAJqORoIz1gAtqh/tz8SvNMNxeoZQxSE?=
 =?us-ascii?Q?Cfm6u5GEmsA4s3+K3CcC2SZJbbkbXnuJ3WURc+4m/+oNEaN0dchdLwkRdm43?=
 =?us-ascii?Q?wwf5ORIee/XihS33RU2IKCGWVh6zJGU82cGrMhn5xIS+UYWsxwSLrgPFtPGM?=
 =?us-ascii?Q?IF5HwfSye3Uqwel9wzjmdKrN1HlxsYeoRdBByK/zUDRym11HSxUReOht1FyC?=
 =?us-ascii?Q?JUJV4gvnwxxoh/CNqJ2CMr+It+51m6skS1rN+6SASGRHzvrEw/4Fiz3XxTcQ?=
 =?us-ascii?Q?fC7aCQjeOboFftSLmItfQnbGFBovxjr/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HsYGtmie81Ibc2ZmsJrbE9zCQfrYn4YBFBQTcpZNMcK0D8R6m+exBwi14Pj?=
 =?us-ascii?Q?6YJWIAygyQ3AFnq5NrwuX0DkYfdTBQ3FIzejLKCU3J0yHlwcRSowWFT1y1nt?=
 =?us-ascii?Q?rqo5Mhkztm6wRki2rYoYb4c3Wgu7TJVsepXVFx3yGlG3yR0HTAL06J4QYanJ?=
 =?us-ascii?Q?ByOrJQt9SYy/avGAT9V01FW5iBJerfZwFemQ9Ck5LRZFcppIsNu/s5jUkqns?=
 =?us-ascii?Q?uxiOn4fbYdYtJNF/EON+SF4EJCPcJuVoxDhCOYt1j8nN0HXH6xxIeKO7zVlf?=
 =?us-ascii?Q?E+y2QBh56FRpzUOI/bGqVAcXMBe/4NPUh6OdKiuNQAu8ZsV8A0+ldfzBVFTw?=
 =?us-ascii?Q?wZSFQeM5DUG3a/dZEbaBt07KJ+7lGPCVw+7jjTpJ8sOdPJlTWV5A9F7D44tj?=
 =?us-ascii?Q?qUbhe1d3py3N+ZpnPYIkPR9V6mZCj3GhKXFmKRbAjLZgkz0MMkubfvejb6nB?=
 =?us-ascii?Q?YJ6MbI7wvxVgr5MK30p7fKcZn2wIUT4iEy2vc4aI5iNySt13PnQaMyMFCo7U?=
 =?us-ascii?Q?qp1CRN/R/6uRszX/NKBOW5E6pqtKT8BXgFVelnJfzLoc6oXoBcExlA3IBYP8?=
 =?us-ascii?Q?TxjOa9SzAgDQNQVNlniDzkfmCxLjHlj0IuKXzp/H0yBAgZ7lS4VkhCU9eo2k?=
 =?us-ascii?Q?RGZ3FQTVL6gBNNNx+AYN4ugtPzGsweoZi6bISDuhpj22UUKikezAUbhcEuz4?=
 =?us-ascii?Q?jLGiTEuun20PEfkm19M5bsV+MKUZvCG33a+I26Z16iLvVFEpars5t+PLozcz?=
 =?us-ascii?Q?tbLhgMCFqxrhxnr5v73UZJ2VDrkaBeXM6z47Hc2uDcFq3Q1KaKzTFTQQzKcd?=
 =?us-ascii?Q?grfYHeHNv0FTY1Q1L6Mbw367VmOELvXotuBhW/wFWVHIjRDBG42tUfCtxmr1?=
 =?us-ascii?Q?DcDWFkWTVw9uobf1aReTK4UXpivtA4AKfYL+0zc5qz4hJ3mOHSSDoPiuij9w?=
 =?us-ascii?Q?Ywh/4/3Ayk7LLVvWH/xwFoTxJXqOXlHtmId+vCrrAmAokcNp2pRddSRGMoDv?=
 =?us-ascii?Q?dt9ExDPdJlK5jbb3P4x7jEuFBEGjyc7sh56Wj652a2BRNdL1+zPwESQoIfN8?=
 =?us-ascii?Q?0x+s1Ezvay49FDRD/ImRbX0YDJ4Y6mT8uN6u0Lr89NYfCAYjAsmH7bpgQFKz?=
 =?us-ascii?Q?dXsAs/oELPmI8Pi20h0UyOEkNNUMGmP/XPlSYg/GDraFSQRQtcVHe16+QLyP?=
 =?us-ascii?Q?ygUzjVqSJrFrHAfodJbtecLMlC9nSGmN5oCdt5pEcnUz1vAqeecPnHxABM5W?=
 =?us-ascii?Q?YLptumP+CGZmJoq4pWX+4Ajan1fcBiUdCZugUiNseGW28/LsPnzHI7PnNiOl?=
 =?us-ascii?Q?bMVtsqHlavq1oeOAqvJAxlyubXSmWdvkD6GQZyri0eTS/ULQIbH7h1hwoAir?=
 =?us-ascii?Q?XS7PRw1yNz1mo9F7ix14j7tw4jazijf5MfVK9ly6eWxI3c5yODETRTt9gZYd?=
 =?us-ascii?Q?ChC0udbbpJDNF+LBLu8GOTBp7I4DaxqvM3zvDAwlx/0wIZJaUgwewjPtH0HS?=
 =?us-ascii?Q?6pK9G85ql+KMmMKB+zwXNnDQCEeTHg6rthKuKdc7UbDbcyEQWfkZI2+W8PUZ?=
 =?us-ascii?Q?3XGq2qufbWlZn8PynrY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe626b1-c819-4f16-fa10-08ddad066552
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:48:34.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Qwn3lkZP1XJ0iT9uiBhrvXM06ZphZcH4f8Y3anlZDinCpKrGN+I8/RcXZqhSVjrQ0Zce4InDQiklmYpHHRggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7429

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
change in v4
- move if into allOf
  move qca,legacy-mode to top and use qca,legacy-mode: false to disallow it
  for uart

change in v3
- move ethernet-controller.yaml# out of if branch

change in v2
- add Ethernet over UART" description here back
- add add check reg choose spi-peripheral-props.yaml
- move spi related properties in if-then branch
- move uart related properies in if-else branch
---
 .../devicetree/bindings/net/qca,qca7000.txt   |  87 --------------
 .../devicetree/bindings/net/qca,qca7000.yaml  | 107 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 108 insertions(+), 88 deletions(-)
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
index 0000000000000..f786f0ab38bcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
@@ -0,0 +1,107 @@
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
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+  - if:
+      required:
+        - reg
+
+    then:
+      properties:
+        spi-cpha: true
+
+        spi-cpol: true
+
+        spi-max-frequency:
+          default: 8000000
+          maximum: 16000000
+          minimum: 1000000
+
+      allOf:
+        - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+    else:
+      properties:
+        current-speed:
+          default: 115200
+
+        qca,legacy-mode: false
+
+      allOf:
+        - $ref: /schemas/serial/serial-peripheral-props.yaml#
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
index 2c74753e2df41..ffc80ec9b3d6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20383,7 +20383,7 @@ QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
 M:	Stefan Wahren <wahrenst@gmx.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/qca,qca7000.txt
+F:	Documentation/devicetree/bindings/net/qca,qca7000.yaml
 F:	drivers/net/ethernet/qualcomm/qca*
 
 QUALCOMM BAM-DMUX WWAN NETWORK DRIVER
-- 
2.34.1


