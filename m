Return-Path: <netdev+bounces-216780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB7B35218
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8BA7AA4A1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8472D1F40;
	Tue, 26 Aug 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="rknTMKcf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19D2D1911;
	Tue, 26 Aug 2025 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177870; cv=fail; b=gIfZHdWtGZQjZtAY0Ai88GoJq2STT0C9C81hdlt/TxocreD2gttes2Nowd9V6HWw24YB0INAj1f/8Le3xAN5DEDiKrn4s2oiz3npPQLOYcugOss30lf7PxV0DQk9pCosVzuIwFk/Zeq6tbXZZws3CSLkuOrkP4I/iAe0WqI0nuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177870; c=relaxed/simple;
	bh=U8LcLKl/85ThB3ZXyVRFTlgC1csH+MtMK6Th/DGb+Ns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MSGeHf6jd0sVtmAQSA0FNMOyyS5eOs9BUbfVwhT+lIIq7wh3OS0AdstNAgLupH5LNDaFG6RXK02CpPFvw5BuaxaJezEsqbH5hW1IL4KhvhZa1X92ocXyLyeu1JEWxIHgp1ZPS9QU1YOWdC9Cfz0JLirOk+ogQQqX0le6FEVUWWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=rknTMKcf; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6PVbgFg9+Ef03lqxbMMHQgmFTV5mPgzPjrz+6+O86uwJGNemOGTw30T37+34Get+emKQVBP5jVycKx+l0+P/Jv5WTUVUVR0gLiLkOFfAuz6HJ5qg6znWjNVq1ow4sCcNEOQgmEop0w7X9/7Pf3H2XQc5e4idQF4CQwB3iRVGfZnKLJNLdzBrBR+mXL1e+SQjR3KAwalp4PvXUGLZNhhs71kcs6cp067cMK5UDPSpB5tOiIYcFWD9c9NXR0l0t+/2tiRlF7IeKJYLSVIYZf6IYvi3IMqOG/SrR1xki9c9MaFnXFuJM5w45nKa1ygDdXF6Syn31gzSwLSJb+Qb4IcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oR1V7zd84yvxFXEjJre7wm9Y5wGBzobOcSi+RfxFTk=;
 b=Y6wEdHxGC4hoz+aa/ObUIQgL/SmXWKryK5DlWkrVAhTUUML23h3XbZsbTakYqryrAJUsXmyJiKZSQeWqGAfDSfGliRJFLk3AG9XJb3YLFPTag+0Nag1Kdqbx7TP1tAraR3H9h4fwLgV9hh3IiYn63VUVloqsZhCC9izs2gHzVDJQKjpFm6ngUndh5SMJ/geAy8lq4DDxwq6lhiLj67jOY276P8gJM4tNdxFuq101P3u2IGFeJHhg3ngQto1QCLyy5XLdnV/x4vyZHztdQlei3LEq3Y64YyuDbgEimYBNPvDmJ0oa/dvThk0QqFx5+dyEDJFdpEJgcSQ1uFEUsXwi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.92) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oR1V7zd84yvxFXEjJre7wm9Y5wGBzobOcSi+RfxFTk=;
 b=rknTMKcfCChm935CmAwE8Gczr1lkpjab6uk56ExV/G8fda9t61+wKC6ohrQSti79SU3ozpwBOl97oiQhcuq3maMnSlMkkyba/jZkBiEZByy+YGn8EEQfm+kAb22Xc8NN99h4M1YPWASEJbiMEb+U5T7nYY85T4/cckJXTTx97VvgWCdjivPFBJm10IJn5higQSGsxeaTEm1gAeJ8qp5HS/r/4GfDC+GrFM3RxgmNGAvtJM/Npg6J2/TGUV/9mGp0DPbjJMeI0iAHm3up2ZlVU2EkVLVAXq3LDWkxP0mmX/XsqJ429VaqgsONnIn3DkYEuIrDgOhz2cart6kTAcTV4Q==
Received: from CH0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:610:e7::18)
 by MN0PR19MB6432.namprd19.prod.outlook.com (2603:10b6:208:3d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 03:11:00 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::be) by CH0PR03CA0223.outlook.office365.com
 (2603:10b6:610:e7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 03:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.92)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.92 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.92; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.92) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 03:11:00 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.31) with Microsoft SMTP Server id 15.2.1544.25; Mon, 25 Aug 2025
 20:10:56 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next v2 0/2] Add MxL Ethernet driver & devicetree binding
Date: Tue, 26 Aug 2025 11:10:42 +0800
Message-ID: <20250826031044.563778-1-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MN0PR19MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b01c44-e545-47e2-b4d2-08dde44e2f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YcUek8WNjkSz1VLkLK0sdSTlAs+sESmqiSCqRoXzHu37S6xdKFD9BlwPe1uY?=
 =?us-ascii?Q?tLVHmmC2BxaLwTViL2Qbd0n7gAX1wCqw/QLBJ0zrd0oY9DOV9cE8Ygjm9UO1?=
 =?us-ascii?Q?+HmGl+ccZDSUHoh1Az5YyKAk4poBFs4y+l6E+02y3IGCgIhFkdob8PTmiXok?=
 =?us-ascii?Q?1QpL9+QIbAE6WwiEa4exLXi2b/NwhofG2cZ3KkuPC/bZoeHoxX+OzrH9csVo?=
 =?us-ascii?Q?x6HO1ypIFRzgUJ0IgGVuenWkkzvjSmtg+xX4Rvk8lPmdS6sTyERxwEPc8Hnu?=
 =?us-ascii?Q?Po2J3nWhWe1BG2zV8bSDYgVuotZE3sitKjKiFDPGgE0SZthjE2RK/RNR9bFZ?=
 =?us-ascii?Q?uPqVutJRJzMPiYRzz+rn6chpNs0pl8SAB5aYZ4L+XTZa30oqbjjLEQ+oXZgO?=
 =?us-ascii?Q?OcFl8hzgztIc77ytr/lqKi3eINRk+bYKhZspWCQ/WYujhhcGJB5KVma1eALE?=
 =?us-ascii?Q?RDcm5UheWuivlNJYEt0DXmj5qgeAQKEoaBE9hc+bhjDZ7gbSaTmGxL9DL/G0?=
 =?us-ascii?Q?aRy5NI/mG2JpnCw+fc1y8Es/PvWcFYHwW8x5xU6bbkrus3L9LpiDwt311Q5H?=
 =?us-ascii?Q?flDoM6vq1eNhFaY4FKZMS263bFGFHD09aMr9W/ZLuhanay5H5MRtS7aKxL5I?=
 =?us-ascii?Q?cZgMFW/pCLeNr4CdRexNjsysyLCZxwfy/uKMpYzBJmcVMpIaGkrEcvqJDsEp?=
 =?us-ascii?Q?aLfnAwEJ82B3FG4eNlyVE1qlc7ox7Ds7ynqVfwn5sHcPtoTQ/1FBhyUID83P?=
 =?us-ascii?Q?yozTBOO0WIhg1MFb2jRpoQbyB58kw7BWiUUb20CzLSNoLKVnoi/J7FQQKyWS?=
 =?us-ascii?Q?USyWW0t7PQIsL1PTCpUZn+aJdLxeWU156GwnGF4EwOb0uuAfVJwpPCLY/D17?=
 =?us-ascii?Q?3mklogo6/y5oMiXOlhQtDp7dtJca8U1aatf6c6rcg/hL+Pm/H4G8wjfRAJnL?=
 =?us-ascii?Q?bBA9Ju1A2avicBwaYuDPPP4bU2lIVfF5CFvGsxw4/42niqaOLrkUZs7E1NYJ?=
 =?us-ascii?Q?KiXwkdKANUlS6/eomMRovDEojt9ItMPWleOi85zr3lZ71mSdZ9BymKbsKdbW?=
 =?us-ascii?Q?jB+81ZEkWY1g2xuXEWutVWqhaC5bSavcBLBwmLXDbBMLh6sOP+ini9NIkRbB?=
 =?us-ascii?Q?Cc3BrdgjknCTsJU3APUpPGmNMG3iDyLIrhazWmXCpVXskSgTrUhb3ihLnr0w?=
 =?us-ascii?Q?yxN6zvr39M5Q/oEsj2OlY2ns1g4VVYD5kWCbqFuO/qBy35tzCM9dEPoGX7vl?=
 =?us-ascii?Q?RHCp8pq/OH3vKBxx68oqiXiFWLBzjHY0zX96Xoz5LpkrXzudFnmk8AzVSq8l?=
 =?us-ascii?Q?th4fpCexb/lOLZPFuKxw/zO4N4G7I+BEz9VHgRSvYJru8E2SSnQspwSaL3jv?=
 =?us-ascii?Q?FGnCnmnRUeMzcbiiSSvz6B3LyZzed6mIFgHk80JC4Sc0Rd+fd0LeTYM6tGDL?=
 =?us-ascii?Q?YQX0JF30mfnLexqGvVvzh00WJS7Eb20nDWcPbAACXlxtSWUhAIFa1W0+/6tN?=
 =?us-ascii?Q?gFb1Mv62mUX8k/twZmJLmTBk+XfbwAGO5x/GTuUwOO8Apz4/SnOI0TyjtA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.92;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-92.static.ctl.one;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:11:00.4939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b01c44-e545-47e2-b4d2-08dde44e2f26
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.92];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6432

Hello netdev maintainers,

This patch series adds support for the MaxLinear LGM SoC's Ethernet
controller, including:

Patch 1: Introduces the devicetree binding documentation for the MaxLinear
LGM Network Processor.
Patch 2: Adds build infrastructure and the main driver for the MaxLinear
LGM SoC Ethernet controller.

The driver supports multi-port operation and is integrated with standard
Linux network device driver framework. The devicetree binding documents
the required properties for the hardware description.

Changelog:
v1 -> v2:
  - Moved devicetree bindings to the first patch in the series
  - Verified bindings with 'make dt_binding_check DT_SCHEMA_FILES=mxl,lgm-eth.yaml'
  - Reformatted commit messages to follow Linux kernel submission guidelines.
  - Removed redundant code and addressed all reviewer comments.

links:
v1: https://lore.kernel.org/netdev/20250822090809.1464232-1-jchng@maxlinear.com/

Jack Ping CHNG (2):
  dt-bindings: net: mxl: Add MxL LGM Network Processor SoC
  net: maxlinear: Add support for MxL LGM SoC

 .../devicetree/bindings/net/mxl,lgm-eth.yaml  |  73 +++++++
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/maxlinear/mxl.rst |  61 ++++++
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/maxlinear/Kconfig        |  15 ++
 drivers/net/ethernet/maxlinear/Makefile       |   6 +
 drivers/net/ethernet/maxlinear/mxl_eth.c      | 189 ++++++++++++++++++
 9 files changed, 355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
 create mode 100644 drivers/net/ethernet/maxlinear/Kconfig
 create mode 100644 drivers/net/ethernet/maxlinear/Makefile
 create mode 100644 drivers/net/ethernet/maxlinear/mxl_eth.c

-- 
2.34.1


