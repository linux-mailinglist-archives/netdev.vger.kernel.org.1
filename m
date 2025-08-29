Return-Path: <netdev+bounces-218266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94106B3BB9F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EA3585177
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658231A552;
	Fri, 29 Aug 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="THCPOyKM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150231A059;
	Fri, 29 Aug 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471739; cv=fail; b=esw/GSFtHHBASzkdBnBDyjKXDPEESCqdG9xIdWjyBbU/gvOdauLXiW4SadZg+p/LT2Nt4btZTRxCP8Yac3Ap6srId5j6DBXkolIN3uGvVPe55adBTt+sokN9MHh33YOTG2lgsKqSesO7l+aTjAoa84PBZQrWXyM94m2+INF2fmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471739; c=relaxed/simple;
	bh=lBeoibOvc9U83TrjGnkAyRZapnt1yCfg6sIRlvmbD7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TF+XqN6Kk1jzL8zv9nr6HcgGZ0tfu9ZgaiWMhqFQ94dqS+8rE4bghaocgCnO+JYXfTEG+OBZ4ED4bXqXcL7H9wUfaVJhLeajljwowfLa8ODgwsIkrv5a9EBXv0e6pnXR+xB0phpOdfNCsBpleOs8bqnmtfebPh94YNHhZ3hw74g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=THCPOyKM; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSUf05AkvwMMZdXGJjnh5b+9baCOLblFkZLB96Ytd/76KjpYm3RDPopG0hBN21Q0aWomdqyYnw6tz4VmXaA7H+yspIQCVRORLeLfR2tMhqBgm75rBjK2FUXGRvfUax/ny4YYr9ULc4zhLUACpF74BPZN2IdTA63Dz9m+yuOBQEHvqmGRHEytIb8Qz0ur5U3QlbMKIvWzCXa5sImzALzC3vXiN1MGbBMjD/bZuvo0kEs5vstlm2y6l76bz5w8Q6BGULJH1yqQwA60NrIEX0+6Wvb0ydc1588By3zP9KszK6MAXr7MA/NTvIwgLr3mbj11yrNB0XAd+Bg90H5lv1hsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds6mBWBH7BxsHZk2Phy0+lw/6jP5/jwGE392a0NEJVo=;
 b=aso1bjtLUX5afl1NIdUtuamZkjW3NBxcIt7czCxhzNMNcC3LvHraofy1OX32ZPHNruM3PqGmyQsm38OCH40IjN1OAw6ugPhcjRGZbiDMgwdWxjZbYgJZj2N/jVjbsq71uGYZ5uy5RPcFk0aKkxC3j/up1qYLCIM2NTUFYmNDMWowNNc1NCX3s/4FJb20L5/vrAVTtMIqv9WqiatcY08RLtcdXVG0y/k7JCZGNEhm3qe0/t3raCke5V6UX/hbw+Lc6Hy1mvgUACd+RIOtMThk8maLY4aep0aT6sqtIKpy+mNnsDwtUm4xu3+rWgjrRMkyftCc04op+BQpQvV1+FIR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.92) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds6mBWBH7BxsHZk2Phy0+lw/6jP5/jwGE392a0NEJVo=;
 b=THCPOyKM5148eqpwtxk2y3V044OpM6G8y5laH2R829SQ4yqElXzlmGyjcON8Y1m2nxpKY+XzKlJmMBWaHBVWIkpH6khJlIW+7eFfRB83wI2t0yEcq+hTF1MeCNMLQlq93I4Kc6sICpZw3DURvLCWcfOrFgud0gfen6z4gPu4wahuLLkQa8Y+uf+DoIVwJumlR6qIVXtHaufFKt4ouhlbSbMEE2yvX3L2Kyhrm1ZwR7l+75h8mMIPfzH564DCg9Y3h64PYEa9qoKbEOh9twyTNeMXMrQ140n3Wp68M+heawCHZzt3cdWSz8hG9JwVH+RYVoXzptiefP9VFU4CGWYt2w==
Received: from CYZPR14CA0014.namprd14.prod.outlook.com (2603:10b6:930:8f::12)
 by CH9PR19MB9684.namprd19.prod.outlook.com (2603:10b6:610:2dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 29 Aug
 2025 12:48:52 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::c8) by CYZPR14CA0014.outlook.office365.com
 (2603:10b6:930:8f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 12:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.92)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.92 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.92; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.92) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 12:48:52 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.31) with Microsoft SMTP Server id 15.2.1544.25; Fri, 29 Aug 2025
 05:48:48 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next v3 0/2] Add MxL Ethernet driver & devicetree binding
Date: Fri, 29 Aug 2025 20:48:41 +0800
Message-ID: <20250829124843.881786-1-jchng@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH9PR19MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd2623c-f59c-4f2b-1fe6-08dde6fa684c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXLrNZ8XjE/4bwqTvJuCKMmd5/td6ILpINU4Hz0x2PNN1ddpEsushq08kLt7?=
 =?us-ascii?Q?N8VtywtfEf10t0k8/9XHSQ2C1MFQXC/g3nMvcbBBZ598he/hcbDx9YY2xD6d?=
 =?us-ascii?Q?97rkRaBFXPZrHXYHnIB7vixHiaKdwyQt+VJq5sLA/R71F1xu0E+xe1d+7OEb?=
 =?us-ascii?Q?TxWYxnn0t4zEI9OTr/j+azEwK+MHJVbK02XssFgXiJdeW+cRWFJGlY0FJWiZ?=
 =?us-ascii?Q?yYAgyv7hTBmpcU/kVocZy6Gq7ST/NaR4AblijcI4CCnMSuw/RhVUu9HLRWon?=
 =?us-ascii?Q?KIW5qy/aMJ+M+PjzzGDeG3d7HD2kXyibno6MEf78q9y+33iCIdow5kea9foK?=
 =?us-ascii?Q?099ru/Oydf5QAtGXaDtQ8UPoTffhYLRdGnhXvm1HUmJsIAiQIbekKADnW0VH?=
 =?us-ascii?Q?JdjgziWt2eUCMVG8BT6pth++r4a1i8c3ktyG8CTqqRZHAYZp2I1QebYetngq?=
 =?us-ascii?Q?eVqYMi+4HT8s4uYpSGKl6FRPmnuSmRJbkJZH2oIjQN9CNtP0U/18nqS+OsyV?=
 =?us-ascii?Q?MhZiPBNqA19YboWVLSGO+oAIsa7sFUbWEtsyeTqUkO9hywdd6KFWzKXBQp35?=
 =?us-ascii?Q?pW7lEUEsEKpZHZ6z2t2jP0P4IHZJmXrZF/r3MLJTBNMprvCFU7P8MAAgnWwx?=
 =?us-ascii?Q?Fzjv9eVxyHjqfv7p7sGPZnSzrfPSc1V+d0ptrbRpGBbE0l5cIfVzfhImbupE?=
 =?us-ascii?Q?WooVMh+LG5pElHxyUpwde1NXfVIUPGibdJiuuoIh+FbiEcIvXuX09/YRoF4j?=
 =?us-ascii?Q?mVV0ga+raD6574pXmmHSSrEaIJWYSocVViupYAFzMT1OZ7xlxZNoCSCno8ox?=
 =?us-ascii?Q?YSbGTzGAmR4fN7VcnMrL1WN/sWcfwLqCS6nw0eUeKcfQOpG+LTPgeqgZy7qu?=
 =?us-ascii?Q?bkLHtrVL4/uLVL10s3rdsH42T7dnyrK+LRe5oCaFLaWN0LiIo4zHk76te5PM?=
 =?us-ascii?Q?KGNl0i8WNplR3Q9o3Ba/XAF2nYKDryr0ObTuca2JtHAR3XwVs50aMS8dtGv/?=
 =?us-ascii?Q?ENRLLPPnUgf8TYPy3kAJHWhxc6uwcZj7dX9ok290YtJjxSar/cW8NPvnEN9D?=
 =?us-ascii?Q?sqUusGYRvET589LWI11N5tpSlH644aBriaGZn0pFT/EvSTYS3IlOofI+hjCo?=
 =?us-ascii?Q?eXkJ4pv4PvnQP41XscYrhVGEQKOd5jeADrPqieGKZ2LjzajfPnxk9Okrepuh?=
 =?us-ascii?Q?4+E22eAAKUhU012k999QRB6UABZd/YEvv1eXBSsry6o12rkYhszYHq+uwVPF?=
 =?us-ascii?Q?lSeEue75owmUpLhj4zQ6DQbl4vkZC6wxh75vcGUyS9nmmDhoN0kjqvpduZYl?=
 =?us-ascii?Q?GryOlJTW/3bAgT98PlKZh6ToXVX+C5KVvZfU8Ek2Gp4UBJid86dUgEpRN5mV?=
 =?us-ascii?Q?EdP7mSUYSQsqEDon/ycvNLGF4fiDr5HP/7MxZnv9XW5IrfRJVpn5z7+eOcor?=
 =?us-ascii?Q?NEwmOiOOSBFgbIZYOpJ4VhS/ydotn6QIf9B0eoWuCh9uAi8aFCl/UaKq+AMf?=
 =?us-ascii?Q?JJsGfwaGi7UoR1guUY2A4CRmP7Agl19ooWGjojuElCwfdP6GutoFn6wr6w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.92;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-92.static.ctl.one;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 12:48:52.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd2623c-f59c-4f2b-1fe6-08dde6fa684c
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.92];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9684

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
v2 -> v3:
  - Renamed compatible string and YAML filename to maxlinear.
  - Changed child nodes to ethernet-ports with port@N.
  - Added reg and mdio properties.
  - Added schema references for port and mdio.
  - Updated required properties and example.
  - Add resource management and better error handling
  - Improved device tree integration for multiple ports

v1 -> v2:
  - Moved devicetree bindings to the first patch in the series.
  - Verified bindings with 'make dt_binding_check DT_SCHEMA_FILES=mxl,lgm-eth.yaml'.
  - Reformatted commit messages to follow Linux kernel submission guidelines.
  - Removed redundant code and addressed all reviewer comments.

links:
v2: https://lore.kernel.org/netdev/20250826031044.563778-3-jchng@maxlinear.com/
v1: https://lore.kernel.org/netdev/20250822090809.1464232-1-jchng@maxlinear.com/

Jack Ping CHNG (2):
  dt-bindings: net: mxl: Add MxL LGM Network Processor SoC
  net: maxlinear: Add support for MxL LGM SoC

 .../bindings/net/maxlinear,lgm-eth.yaml       | 119 +++++++++++
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/maxlinear/mxl.rst |  49 +++++
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/maxlinear/Kconfig        |  15 ++
 drivers/net/ethernet/maxlinear/Makefile       |   6 +
 drivers/net/ethernet/maxlinear/mxl_eth.c      | 202 ++++++++++++++++++
 9 files changed, 402 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/maxlinear,lgm-eth.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
 create mode 100644 drivers/net/ethernet/maxlinear/Kconfig
 create mode 100644 drivers/net/ethernet/maxlinear/Makefile
 create mode 100644 drivers/net/ethernet/maxlinear/mxl_eth.c

-- 
2.34.1


