Return-Path: <netdev+bounces-123332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCA9648D9
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B602C283C25
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95B192B7C;
	Thu, 29 Aug 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g3LR+hck"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027D1B011B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942642; cv=fail; b=WqpG89BIi1rbLnKvvBPaMluJKNZyJK1JCvbwuS2Amjv9vYHYUounwYGo2Fg6vjDO8buElYaQivU0hmTow0xw3bFAJoVhPHWwMYvInhTSSuEtYFBlEoBTjr32xTMYqfB6u7+0A/7Q2rCuvSTtqkIUj/uzlYwPDLljKI4S30P6CHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942642; c=relaxed/simple;
	bh=ylMb2XGYObQwSP+/wZ+/6XBci25thmaA/omTgQbO3Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfeqT+H5NVRN8ZxLRDO+iCG8W46znkI4wikYOG7+jCjz1CzM8tSFoUuJPWrmiL3IsmTVw1eD9Bsj6F4kpVbY2SC3Y+o35LYib4IzSoL5KJqH1GoHKotDjkbGMJnY175OkVf4hgNqxSJVRZRxsemI0xxQakn/JJu/+/x+7Gf1sGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g3LR+hck; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z86HUIFKg0gG0FHzRrGP+FQRxST1NS91s1heWCAiZdeUZLW1InZIFlZMvvfU89PmWNjakGtsNaBhGB9nbfWfdq5QyTzU4trohNiuS2rwKGDcXs0RkI8GVso5QBuD36N01BnbNPfqI0nCfW6rB5BKFYeUyqBUxF8H5mW/IdluzLEffg+925vIuoNRVke6ULQHG9hXr5BWSNzLZ2rKn0ZRV/U5M+xwOF+oc4jXGz4YIvfA1xdRodghdBgsLV0rhw8lBo7qQaZwc81S8wn0/Jwigr7W0vt4ZkYvcR+oRQ09d89yOz0txLnKqzgrikUbuIR2QAAjRx5CEUhWXrT+KqlVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRjLStbXeFuM+4N1K2epQtt9DM3WfNkxrxUMP0xBu4Y=;
 b=oEm01bJtWj/IZBsPmRm4o2VdlpQxKka0Vrh61xtg1CE4i1RdJTVFtOj4LeI1esEBo8r+brglnHoXV1yXDPm5VWrrHsFn5wrZLtBt48kqe0zxGPVRo+qD3/nAy+HPHRCoo2CCL9RpDeA0LdGse5sIb5VuykWrnvWpD0WK7abmOgAJDMnelwuepYYWgmrUWTOo1r6QzhG6brOLuMdeRq9MXedFi7Xktvd/h+zHjrhCY2CsWec8uqgVpqv8sxaRThIf0QevKv5Z3MOS7L/wxRhGiWvvO8MhwGePE4X011RFuiWar0NHajzm25vHbenTHcBNn6BXrbDn2ZcTvB8qOQPg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRjLStbXeFuM+4N1K2epQtt9DM3WfNkxrxUMP0xBu4Y=;
 b=g3LR+hckbVJkZWRIxvycNey5P1vocCfeCmmgLKOe0Hdlb46k3ZEhJBxb/Cwi5fJ+qut4jL+RRv6/eEukBAzUGHk9Rb+6dvTy6RFs24pQnUWhsawctM4SXpaOXlqFnXqc+Tnqhr2fZxYQnlIHHUNs9WXqQnhOcKR5eUghnCB4K+u0nvGuibz+Xeb28d4vIK1vKjRVkfeJL7eLnJzfNmuJgEMSW/CdVcumZOz5jQfTr0T+Nk9zvh+OEIAttllWcpz6xqcFBkddyS/Kn7ku62bYr4mclnOWykvtLPG6QukRTAYJ6i3lR/yfcmy2wrAbrMere5mfdcw4GPnhE9w3/g4QPg==
Received: from BN1PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:e0::11)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Thu, 29 Aug 2024 14:43:50 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::fd) by BN1PR10CA0006.outlook.office365.com
 (2603:10b6:408:e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 14:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Thu, 29 Aug 2024 14:43:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 07:43:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 07:43:44 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 07:43:31 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
	<manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Sunil Goutham
	<sgoutham@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Christian
 Benvenuti" <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, "Claudiu
 Manoil" <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, "Yisen
 Zhuang" <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	"Jijie Shao" <shaojijie@huawei.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Geetha sowjanya" <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Ido Schimmel
	<idosch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, Bryan Whitehead
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, "Edward
 Cree" <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
	"Imre Kaloz" <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
	"Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
Subject: [PATCH net-next 2/2] net: Remove setting of RX software timestamp from drivers
Date: Thu, 29 Aug 2024 17:42:53 +0300
Message-ID: <20240829144253.122215-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829144253.122215-1-gal@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 99552280-7bf8-4938-63a7-08dcc838ff0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPEP/4EtFEp+u0MUFuQIW1ubwSgM+gVjckXBxJIn6/r7M5Ud0RpNtD8GV7VR?=
 =?us-ascii?Q?YVl4ZSIkr9KGHImHGomUc4KM2m2F2/2E791obRMXm4vV/dn4+t5rju25ANtq?=
 =?us-ascii?Q?H0Jx2znEUeokqiThA7/qtk0IgWFNxhQ+n2esj3fG487SdFbRg5zh96QEanFV?=
 =?us-ascii?Q?h3+klO6krRbcC5+gT5IseP90kynXLHqrKNpVxJbfuONXQlDoaGa37FzJgGl9?=
 =?us-ascii?Q?7J/2qpBc+IDvB5Q6eMzXsbh/1SW/EvYlzfTzlsnnNAUOejStebqz8rNuil6G?=
 =?us-ascii?Q?35OM4U6mlTm9fGaNDaKO54uLbEYV2T+OkokcvG1xLqUuFq0pOP8NMkQeUO1M?=
 =?us-ascii?Q?gfl5/G4Y8vaoN/25Xd51KxbVpZRLlVnEJ3/Z9NNvCtkOg0t2RVWEo/s8hKgJ?=
 =?us-ascii?Q?fsYKsWIxtV+qSsFGsF/zmBnPt6LpXUDEGD/6GYdqAEtryBXTFnzhfXK+LF5G?=
 =?us-ascii?Q?Hj5Qc57FC9/UnMI+Ryr8pDv3xMBSRtCWSJNBtumDrGrg1U9C/w2+0P8S8ath?=
 =?us-ascii?Q?ydMvzRQvY2+UUBGBfVW5wJA5DffK6/aSir884+cnPABYddq8OBzp/RRAeZOM?=
 =?us-ascii?Q?n6LeNxvgZebWg/2v9hH7Eg0Wo3dCC/3WOTcW6l63MwsleFfeq5FKVpXp/6GU?=
 =?us-ascii?Q?ZaIuH8YGJxmv3eSBa3xrf6kRUqQ8IDtneJuIEGF6eBhRvro55eZWhtzJCgXj?=
 =?us-ascii?Q?B4DmaPuPq2S76ygEaV8yyF76T6nYO3gzmIZgXnCH9BdwM1FhrRHxbkrwE9KA?=
 =?us-ascii?Q?weslGD39zK3KcRnhtv0JD190Zwe7bSLQZoUIqalWOKszcB+kfoXalcQ7NDYy?=
 =?us-ascii?Q?FqNqb51BF9ZPafMal3nGiywq9fmj121ZvLL9bLkLS4TAmELv5UYIZtz5MK+X?=
 =?us-ascii?Q?N67ju9MtRmQQjl0y1v3a6mwGlCTicz6lwI/NBLnIYNmGTvkGRjd0jYhF3aD0?=
 =?us-ascii?Q?T6pxAsjPzYMjlXHUCOHxWLEUYBx0OeWQl28wgCrIsbDepprnG2a29CLrctCB?=
 =?us-ascii?Q?z8lPDiaqL5lNUyPbuRCm0w8tkWcN06NmAtF5TAPe/hvJ0gkhIchFRQXyej5m?=
 =?us-ascii?Q?2Ej4fcLD1B8yXkEa4MTtEckvyy3740UiPus/RF3Up+GOaCJY8tOpfQN4S8s4?=
 =?us-ascii?Q?TtMxplRW1UV9iV4fYoz0u4mEaLvWtuLcicnIFs/z0M6W3fHv/yP4Uw/y34CQ?=
 =?us-ascii?Q?FW0z9MTxvqin2gI39ObLHu4Y6sBhsuhMlRwYZe4aSQMw913x7+liCSf1Tizk?=
 =?us-ascii?Q?6c6M1lELGjVICAIhi62HGgFPuh+YzTuNNFt5A+zet9+NO9os+TY9ZVlh6FRf?=
 =?us-ascii?Q?sizvUO5y7r8dlVL2Nr5xL2BJwgjgsq2I7DDcac+CLvcgBj36eO/UmxgGWd9Y?=
 =?us-ascii?Q?u/KtwHEYwuMNWxvCasU59i4ZAw9J33KtnKTUZgHrfAJHuxjedIq/waEVegxp?=
 =?us-ascii?Q?kI99ayFqo1jYeGxeGm/XW1hfIuP94nVy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:43:50.0906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99552280-7bf8-4938-63a7-08dcc838ff0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/bonding/bond_main.c               |  3 ---
 drivers/net/can/dev/dev.c                     |  3 ---
 drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  3 ---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  4 ----
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  4 ----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +----
 drivers/net/ethernet/broadcom/tg3.c           |  6 +-----
 drivers/net/ethernet/cadence/macb_main.c      |  5 ++---
 .../ethernet/cavium/liquidio/lio_ethtool.c    | 16 +++++++--------
 .../ethernet/cavium/thunder/nicvf_ethtool.c   |  2 --
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 11 +++-------
 .../net/ethernet/cisco/enic/enic_ethtool.c    |  4 +---
 drivers/net/ethernet/engleder/tsnep_ethtool.c |  4 ----
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 10 ++--------
 drivers/net/ethernet/freescale/fec_main.c     |  4 ----
 .../net/ethernet/freescale/gianfar_ethtool.c  | 10 ++--------
 .../ethernet/fungible/funeth/funeth_ethtool.c |  5 +----
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  4 ----
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 ----
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 --
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 +-------
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  4 ----
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 ----
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  2 --
 .../marvell/octeontx2/nic/otx2_ethtool.c      |  2 --
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++++++
 .../ethernet/mellanox/mlxsw/spectrum_ptp.h    | 20 -------------------
 .../net/ethernet/microchip/lan743x_ethtool.c  |  4 ----
 .../microchip/lan966x/lan966x_ethtool.c       | 11 ++++------
 .../microchip/sparx5/sparx5_ethtool.c         | 11 ++++------
 drivers/net/ethernet/mscc/ocelot_ptp.c        | 12 ++++-------
 .../ethernet/pensando/ionic/ionic_ethtool.c   |  2 --
 drivers/net/ethernet/qlogic/qede/qede_ptp.c   |  9 +--------
 drivers/net/ethernet/renesas/ravb_main.c      |  4 ++--
 drivers/net/ethernet/renesas/rswitch.c        |  2 --
 drivers/net/ethernet/renesas/rtsn.c           |  2 --
 drivers/net/ethernet/sfc/ethtool.c            |  5 -----
 drivers/net/ethernet/sfc/siena/ethtool.c      |  5 -----
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  4 ++--
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c   |  2 --
 drivers/net/ethernet/ti/cpsw_ethtool.c        |  7 +------
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  2 --
 drivers/net/ethernet/ti/netcp_ethss.c         |  7 +------
 drivers/net/ethernet/xscale/ixp4xx_eth.c      |  4 +---
 drivers/ptp/ptp_ines.c                        |  4 ----
 46 files changed, 47 insertions(+), 208 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f9633a6f8571..83c406b8b12c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5770,9 +5770,6 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 	if (real_dev) {
 		ret = ethtool_get_ts_info_by_layer(real_dev, info);
 	} else {
-		info->phc_index = -1;
-		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE;
 		/* Check if all slaves support software tx timestamping */
 		rcu_read_lock();
 		bond_for_each_slave_rcu(bond, slave, iter) {
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 87828f953073..6792c14fd7eb 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -380,12 +380,9 @@ int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = -1;
 	info->tx_types = BIT(HWTSTAMP_TX_ON);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
 
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index b50005397463..28f3fd805273 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -781,11 +781,8 @@ static int peak_get_ts_info(struct net_device *dev,
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = -1;
 	info->tx_types = BIT(HWTSTAMP_TX_OFF);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 3d68fef46ded..59f7cd8ceb39 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -901,11 +901,8 @@ int pcan_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = -1;
 	info->tx_types = BIT(HWTSTAMP_TX_OFF);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 21407a26f806..5fc94c2f638e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -582,16 +582,12 @@ static int xgbe_get_ts_info(struct net_device *netdev,
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 
 	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				   SOF_TIMESTAMPING_RX_SOFTWARE |
-				   SOF_TIMESTAMPING_SOFTWARE |
 				   SOF_TIMESTAMPING_TX_HARDWARE |
 				   SOF_TIMESTAMPING_RX_HARDWARE |
 				   SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (pdata->ptp_clock)
 		ts_info->phc_index = ptp_clock_index(pdata->ptp_clock);
-	else
-		ts_info->phc_index = -1;
 
 	ts_info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 	ts_info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index c7b56a5e5425..adf7b6b94941 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -3640,16 +3640,12 @@ static int bnx2x_get_ts_info(struct net_device *dev,
 
 	if (bp->flags & PTP_SUPPORTED) {
 		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_TX_HARDWARE |
 					SOF_TIMESTAMPING_RX_HARDWARE |
 					SOF_TIMESTAMPING_RAW_HARDWARE;
 
 		if (bp->ptp_clock)
 			info->phc_index = ptp_clock_index(bp->ptp_clock);
-		else
-			info->phc_index = -1;
 
 		info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 				   (1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9dadc89378f0..8fe680e691a3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5040,11 +5040,8 @@ static int bnxt_get_ts_info(struct net_device *dev,
 	struct bnxt_ptp_cfg *ptp;
 
 	ptp = bp->ptp_cfg;
-	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
-	info->phc_index = -1;
 	if (!ptp)
 		return 0;
 
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 0ec5f01551f9..378815917741 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6145,9 +6145,7 @@ static int tg3_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info
 {
 	struct tg3 *tp = netdev_priv(dev);
 
-	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	if (tg3_flag(tp, PTP_CAPABLE)) {
 		info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
@@ -6157,8 +6155,6 @@ static int tg3_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info
 
 	if (tp->ptp_clock)
 		info->phc_index = ptp_clock_index(tp->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 95e8742dce1d..e41929c61a04 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3410,8 +3410,6 @@ static int gem_get_ts_info(struct net_device *dev,
 
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
@@ -3423,7 +3421,8 @@ static int gem_get_ts_info(struct net_device *dev,
 		(1 << HWTSTAMP_FILTER_NONE) |
 		(1 << HWTSTAMP_FILTER_ALL);
 
-	info->phc_index = bp->ptp_clock ? ptp_clock_index(bp->ptp_clock) : -1;
+	if (bp->ptp_clock)
+		info->phc_index = ptp_clock_index(bp->ptp_clock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index 5835965dbc32..c849e2c871a9 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -2496,37 +2496,31 @@ static int lio_set_intr_coalesce(struct net_device *netdev,
 	return ret;
 }
 
+#ifdef PTP_HARDWARE_TIMESTAMPING
 static int lio_get_ts_info(struct net_device *netdev,
 			   struct kernel_ethtool_ts_info *info)
 {
 	struct lio *lio = GET_LIO(netdev);
 
 	info->so_timestamping =
-#ifdef PTP_HARDWARE_TIMESTAMPING
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE |
-		SOF_TIMESTAMPING_TX_SOFTWARE |
-#endif
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE;
+		SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	if (lio->ptp_clock)
 		info->phc_index = ptp_clock_index(lio->ptp_clock);
-	else
-		info->phc_index = -1;
 
-#ifdef PTP_HARDWARE_TIMESTAMPING
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
 			   (1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			   (1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT);
-#endif
 
 	return 0;
 }
+#endif
 
 /* Return register dump len. */
 static int lio_get_regs_len(struct net_device *dev)
@@ -3146,7 +3140,9 @@ static const struct ethtool_ops lio_ethtool_ops = {
 	.set_coalesce		= lio_set_intr_coalesce,
 	.get_priv_flags		= lio_get_priv_flags,
 	.set_priv_flags		= lio_set_priv_flags,
+#ifdef PTP_HARDWARE_TIMESTAMPING
 	.get_ts_info		= lio_get_ts_info,
+#endif
 };
 
 static const struct ethtool_ops lio_vf_ethtool_ops = {
@@ -3169,7 +3165,9 @@ static const struct ethtool_ops lio_vf_ethtool_ops = {
 	.set_coalesce		= lio_set_intr_coalesce,
 	.get_priv_flags		= lio_get_priv_flags,
 	.set_priv_flags		= lio_set_priv_flags,
+#ifdef PTP_HARDWARE_TIMESTAMPING
 	.get_ts_info		= lio_get_ts_info,
+#endif
 };
 
 void liquidio_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index 6a04d2530176..d0ff0c170b1a 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -844,8 +844,6 @@ static int nicvf_get_ts_info(struct net_device *netdev,
 		return ethtool_op_get_ts_info(netdev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 3d091947ae00..7f3f5afa864f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -1556,12 +1556,9 @@ static int get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *ts
 	struct  adapter *adapter = pi->adapter;
 
 	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				   SOF_TIMESTAMPING_RX_SOFTWARE |
-				   SOF_TIMESTAMPING_SOFTWARE;
-
-	ts_info->so_timestamping |= SOF_TIMESTAMPING_RX_HARDWARE |
-				    SOF_TIMESTAMPING_TX_HARDWARE |
-				    SOF_TIMESTAMPING_RAW_HARDWARE;
+				   SOF_TIMESTAMPING_RX_HARDWARE |
+				   SOF_TIMESTAMPING_TX_HARDWARE |
+				   SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	ts_info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 			    (1 << HWTSTAMP_TX_ON);
@@ -1575,8 +1572,6 @@ static int get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *ts
 
 	if (adapter->ptp_clock)
 		ts_info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		ts_info->phc_index = -1;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index f2f1055880b2..31685ee304c6 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -601,9 +601,7 @@ static int enic_set_rxfh(struct net_device *netdev,
 static int enic_get_ts_info(struct net_device *netdev,
 			    struct kernel_ethtool_ts_info *info)
 {
-	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/engleder/tsnep_ethtool.c b/drivers/net/ethernet/engleder/tsnep_ethtool.c
index 9aa286ba1f00..228a638eae16 100644
--- a/drivers/net/ethernet/engleder/tsnep_ethtool.c
+++ b/drivers/net/ethernet/engleder/tsnep_ethtool.c
@@ -310,16 +310,12 @@ static int tsnep_ethtool_get_ts_info(struct net_device *netdev,
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (adapter->ptp_clock)
 		info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) |
 			 BIT(HWTSTAMP_TX_ON);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 5e684b23c5f5..47c478e08d44 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -849,17 +849,13 @@ static int enetc_get_ts_info(struct net_device *ndev,
 	if (phc_idx) {
 		info->phc_index = *phc_idx;
 		symbol_put(enetc_phc_index);
-	} else {
-		info->phc_index = -1;
 	}
 
 #ifdef CONFIG_FSL_ENETC_PTP_CLOCK
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE |
-				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+				SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 			 (1 << HWTSTAMP_TX_ON) |
@@ -867,9 +863,7 @@ static int enetc_get_ts_info(struct net_device *ndev,
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
 #else
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 #endif
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8c3bf0faba63..acbb627d51bf 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2775,15 +2775,11 @@ static int fec_enet_get_ts_info(struct net_device *ndev,
 	if (fep->bufdesc_ex) {
 
 		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_TX_HARDWARE |
 					SOF_TIMESTAMPING_RX_HARDWARE |
 					SOF_TIMESTAMPING_RAW_HARDWARE;
 		if (fep->ptp_clock)
 			info->phc_index = ptp_clock_index(fep->ptp_clock);
-		else
-			info->phc_index = -1;
 
 		info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 				 (1 << HWTSTAMP_TX_ON);
diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index f581402ad740..a99b95c4bcfb 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -1455,12 +1455,8 @@ static int gfar_get_ts_info(struct net_device *dev,
 	struct device_node *ptp_node;
 	struct ptp_qoriq *ptp = NULL;
 
-	info->phc_index = -1;
-
 	if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)) {
-		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE;
+		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	}
 
@@ -1478,9 +1474,7 @@ static int gfar_get_ts_info(struct net_device *dev,
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+				SOF_TIMESTAMPING_TX_SOFTWARE;
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 			 (1 << HWTSTAMP_TX_ON);
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
index 7f081e6e8c87..ba83dbf4ed22 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
@@ -1042,12 +1042,9 @@ static int fun_set_rxfh(struct net_device *netdev,
 static int fun_get_ts_info(struct net_device *netdev,
 			   struct kernel_ethtool_ts_info *info)
 {
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_HARDWARE |
+	info->so_timestamping = SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = -1;
 	info->tx_types = BIT(HWTSTAMP_TX_OFF);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 5fff8ed388f8..5505caea88e9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -389,16 +389,12 @@ int hclge_ptp_get_ts_info(struct hnae3_handle *handle,
 	}
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (hdev->ptp->clock)
 		info->phc_index = ptp_clock_index(hdev->ptp->clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1d0d2e526adb..2e57de16368b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2555,16 +2555,12 @@ static int i40e_get_ts_info(struct net_device *dev,
 		return ethtool_op_get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (pf->ptp_clock)
 		info->phc_index = ptp_clock_index(pf->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bc79ba974e49..8a32c225e22c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3792,8 +3792,6 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 		return ethtool_op_get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 06b9970dffad..ca6ccbc13954 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2387,15 +2387,11 @@ static int igb_get_ts_info(struct net_device *dev,
 
 	if (adapter->ptp_clock)
 		info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	switch (adapter->hw.mac.type) {
 	case e1000_82575:
 		info->so_timestamping =
-			SOF_TIMESTAMPING_TX_SOFTWARE |
-			SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE;
+			SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	case e1000_82576:
 	case e1000_82580:
@@ -2405,8 +2401,6 @@ static int igb_get_ts_info(struct net_device *dev,
 	case e1000_i211:
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
-			SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
 			SOF_TIMESTAMPING_RX_HARDWARE |
 			SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 3d3ef4e1547c..fde6f2b3466d 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1565,15 +1565,11 @@ static int igc_ethtool_get_ts_info(struct net_device *dev,
 
 	if (adapter->ptp_clock)
 		info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	switch (adapter->hw.mac.type) {
 	case igc_i225:
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
-			SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
 			SOF_TIMESTAMPING_RX_HARDWARE |
 			SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 4cac76254966..9482e0cca8b7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3196,16 +3196,12 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (adapter->ptp_clock)
 		info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types =
 		BIT(HWTSTAMP_TX_OFF) |
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0d62a33afa80..1f01c6febc6b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5268,8 +5268,6 @@ static int mvpp2_ethtool_get_ts_info(struct net_device *dev,
 
 	info->phc_index = mvpp22_tai_ptp_clock_index(port->priv->tai);
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 0db62eb0dab3..32468c663605 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -962,8 +962,6 @@ static int otx2_get_ts_info(struct net_device *netdev,
 		return ethtool_op_get_ts_info(netdev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index f064789f3240..b749879b3daa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2784,7 +2784,9 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp1_ptp_ops = {
 	.hwtstamp_get	= mlxsw_sp1_ptp_hwtstamp_get,
 	.hwtstamp_set	= mlxsw_sp1_ptp_hwtstamp_set,
 	.shaper_work	= mlxsw_sp1_ptp_shaper_work,
+#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 	.get_ts_info	= mlxsw_sp1_ptp_get_ts_info,
+#endif
 	.get_stats_count = mlxsw_sp1_get_stats_count,
 	.get_stats_strings = mlxsw_sp1_get_stats_strings,
 	.get_stats	= mlxsw_sp1_get_stats,
@@ -2801,7 +2803,9 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp2_ptp_ops = {
 	.hwtstamp_get	= mlxsw_sp2_ptp_hwtstamp_get,
 	.hwtstamp_set	= mlxsw_sp2_ptp_hwtstamp_set,
 	.shaper_work	= mlxsw_sp2_ptp_shaper_work,
+#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 	.get_ts_info	= mlxsw_sp2_ptp_get_ts_info,
+#endif
 	.get_stats_count = mlxsw_sp2_get_stats_count,
 	.get_stats_strings = mlxsw_sp2_get_stats_strings,
 	.get_stats	= mlxsw_sp2_get_stats,
@@ -2818,7 +2822,9 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp4_ptp_ops = {
 	.hwtstamp_get	= mlxsw_sp2_ptp_hwtstamp_get,
 	.hwtstamp_set	= mlxsw_sp2_ptp_hwtstamp_set,
 	.shaper_work	= mlxsw_sp2_ptp_shaper_work,
+#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 	.get_ts_info	= mlxsw_sp2_ptp_get_ts_info,
+#endif
 	.get_stats_count = mlxsw_sp2_get_stats_count,
 	.get_stats_strings = mlxsw_sp2_get_stats_strings,
 	.get_stats	= mlxsw_sp2_get_stats,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
index 769095d4932d..c8aa1452fbb9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
@@ -11,14 +11,6 @@ struct mlxsw_sp;
 struct mlxsw_sp_port;
 struct mlxsw_sp_ptp_clock;
 
-static inline int mlxsw_sp_ptp_get_ts_info_noptp(struct kernel_ethtool_ts_info *info)
-{
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
-	info->phc_index = -1;
-	return 0;
-}
-
 #if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 
 struct mlxsw_sp_ptp_clock *
@@ -151,12 +143,6 @@ static inline void mlxsw_sp1_ptp_shaper_work(struct work_struct *work)
 {
 }
 
-static inline int mlxsw_sp1_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-					    struct kernel_ethtool_ts_info *info)
-{
-	return mlxsw_sp_ptp_get_ts_info_noptp(info);
-}
-
 static inline int mlxsw_sp1_get_stats_count(void)
 {
 	return 0;
@@ -226,12 +212,6 @@ mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	return -EOPNOTSUPP;
 }
 
-static inline int mlxsw_sp2_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-					    struct kernel_ethtool_ts_info *info)
-{
-	return mlxsw_sp_ptp_get_ts_info_noptp(info);
-}
-
 static inline int
 mlxsw_sp2_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
 			      struct mlxsw_sp_port *mlxsw_sp_port,
diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 3a63ec091413..0f1c0edec460 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1034,16 +1034,12 @@ static int lan743x_ethtool_get_ts_info(struct net_device *netdev,
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
 	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				   SOF_TIMESTAMPING_RX_SOFTWARE |
-				   SOF_TIMESTAMPING_SOFTWARE |
 				   SOF_TIMESTAMPING_TX_HARDWARE |
 				   SOF_TIMESTAMPING_RX_HARDWARE |
 				   SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (adapter->ptp.ptp_clock)
 		ts_info->phc_index = ptp_clock_index(adapter->ptp.ptp_clock);
-	else
-		ts_info->phc_index = -1;
 
 	ts_info->tx_types = BIT(HWTSTAMP_TX_OFF) |
 			    BIT(HWTSTAMP_TX_ON) |
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
index aec7066d83b3..2474dfd330f4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
@@ -549,16 +549,13 @@ static int lan966x_get_ts_info(struct net_device *dev,
 
 	phc = &lan966x->phc[LAN966X_PHC_PORT];
 
-	info->phc_index = phc->clock ? ptp_clock_index(phc->clock) : -1;
-	if (info->phc_index == -1) {
-		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-					 SOF_TIMESTAMPING_RX_SOFTWARE |
-					 SOF_TIMESTAMPING_SOFTWARE;
+	if (phc->clock) {
+		info->phc_index = ptp_clock_index(phc->clock);
+	} else {
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	}
 	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-				 SOF_TIMESTAMPING_RX_SOFTWARE |
-				 SOF_TIMESTAMPING_SOFTWARE |
 				 SOF_TIMESTAMPING_TX_HARDWARE |
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index 4f800c1a435d..d898a7238b48 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1194,16 +1194,13 @@ static int sparx5_get_ts_info(struct net_device *dev,
 
 	phc = &sparx5->phc[SPARX5_PHC_PORT];
 
-	info->phc_index = phc->clock ? ptp_clock_index(phc->clock) : -1;
-	if (info->phc_index == -1) {
-		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-					 SOF_TIMESTAMPING_RX_SOFTWARE |
-					 SOF_TIMESTAMPING_SOFTWARE;
+	if (phc->clock) {
+		info->phc_index = ptp_clock_index(phc->clock);
+	} else {
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	}
 	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-				 SOF_TIMESTAMPING_RX_SOFTWARE |
-				 SOF_TIMESTAMPING_SOFTWARE |
 				 SOF_TIMESTAMPING_TX_HARDWARE |
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index b3c28260adf8..e172638b0601 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -582,17 +582,13 @@ EXPORT_SYMBOL(ocelot_hwstamp_set);
 int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 		       struct kernel_ethtool_ts_info *info)
 {
-	info->phc_index = ocelot->ptp_clock ?
-			  ptp_clock_index(ocelot->ptp_clock) : -1;
-	if (info->phc_index == -1) {
-		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-					 SOF_TIMESTAMPING_RX_SOFTWARE |
-					 SOF_TIMESTAMPING_SOFTWARE;
+	if (ocelot->ptp_clock) {
+		info->phc_index = ptp_clock_index(ocelot->ptp_clock);
+	} else {
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	}
 	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-				 SOF_TIMESTAMPING_RX_SOFTWARE |
-				 SOF_TIMESTAMPING_SOFTWARE |
 				 SOF_TIMESTAMPING_TX_HARDWARE |
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 4619fd74f3e3..dda22fa4448c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -989,8 +989,6 @@ static int ionic_get_ts_info(struct net_device *netdev,
 	info->phc_index = ptp_clock_index(lif->phc->ptp);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.c b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
index 63e3dac4d5f7..9d6399a5c780 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
@@ -326,25 +326,18 @@ int qede_ptp_get_ts_info(struct qede_dev *edev, struct kernel_ethtool_ts_info *i
 	struct qede_ptp *ptp = edev->ptp;
 
 	if (!ptp) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE;
-		info->phc_index = -1;
+		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 		return 0;
 	}
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (ptp->clock)
 		info->phc_index = ptp_clock_index(ptp->clock);
-	else
-		info->phc_index = -1;
 
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
 			   BIT(HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c02fb296bf7d..c7ec23688d56 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1744,8 +1744,6 @@ static int ravb_get_ts_info(struct net_device *ndev,
 
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
@@ -1756,6 +1754,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
 		(1 << HWTSTAMP_FILTER_ALL);
 	if (hw_info->gptp || hw_info->ccc_gac)
 		info->phc_index = ptp_clock_index(priv->ptp.clock);
+	else
+		info->phc_index = 0;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index ff50e20856ec..b80aa27a7214 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1815,8 +1815,6 @@ static int rswitch_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts
 
 	info->phc_index = ptp_clock_index(rdev->priv->ptp_priv->clock);
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index 0e6cea42f007..f9f63c61d792 100644
--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -1219,8 +1219,6 @@ static int rtsn_get_ts_info(struct net_device *ndev,
 
 	info->phc_index = ptp_clock_index(priv->ptp_priv->clock);
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 7c887160e2ef..314b41d738f2 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -230,11 +230,6 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
 
-	/* Software capabilities */
-	ts_info->so_timestamping = (SOF_TIMESTAMPING_RX_SOFTWARE |
-				    SOF_TIMESTAMPING_SOFTWARE);
-	ts_info->phc_index = -1;
-
 	efx_ptp_get_ts_info(efx, ts_info);
 	return 0;
 }
diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
index 4c182d4edfc2..f4f4df687708 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool.c
@@ -230,11 +230,6 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
 {
 	struct efx_nic *efx = netdev_priv(net_dev);
 
-	/* Software capabilities */
-	ts_info->so_timestamping = (SOF_TIMESTAMPING_RX_SOFTWARE |
-				    SOF_TIMESTAMPING_SOFTWARE);
-	ts_info->phc_index = -1;
-
 	efx_siena_ptp_get_ts_info(efx, ts_info);
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 7008219fd88d..a7b8407e898c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1207,13 +1207,13 @@ static int stmmac_get_ts_info(struct net_device *dev,
 
 		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
 					SOF_TIMESTAMPING_TX_HARDWARE |
-					SOF_TIMESTAMPING_RX_SOFTWARE |
 					SOF_TIMESTAMPING_RX_HARDWARE |
-					SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_RAW_HARDWARE;
 
 		if (priv->ptp_clock)
 			info->phc_index = ptp_clock_index(priv->ptp_clock);
+		else
+			info->phc_index = 0;
 
 		info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index b60976947da5..539d5ca82f52 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -714,8 +714,6 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_TX_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 	info->phc_index = am65_cpts_phc_index(common->cpts);
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index 53ed23d68722..21d55a180ef6 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -725,8 +725,6 @@ int cpsw_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts_info *inf
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_TX_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 	info->phc_index = cpsw->cpts->phc_index;
 	info->tx_types =
@@ -741,10 +739,7 @@ int cpsw_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts_info *inf
 int cpsw_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
-		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE;
-	info->phc_index = -1;
+		SOF_TIMESTAMPING_TX_SOFTWARE;
 	info->tx_types = 0;
 	info->rx_filters = 0;
 	return 0;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 5688f054cec5..a2df9e527928 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -118,8 +118,6 @@ static int emac_get_ts_info(struct net_device *ndev,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_TX_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	info->phc_index = icss_iep_get_ptp_clock_idx(emac->iep);
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index d286709ca3b9..63e686f0b119 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -2012,8 +2012,6 @@ static int keystone_get_ts_info(struct net_device *ndev,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_TX_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 	info->phc_index = gbe_intf->gbe_dev->cpts->phc_index;
 	info->tx_types =
@@ -2030,10 +2028,7 @@ static int keystone_get_ts_info(struct net_device *ndev,
 				struct kernel_ethtool_ts_info *info)
 {
 	info->so_timestamping =
-		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE;
-	info->phc_index = -1;
+		SOF_TIMESTAMPING_TX_SOFTWARE;
 	info->tx_types = 0;
 	info->rx_filters = 0;
 	return 0;
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 56df37f8d50a..aef316278eb4 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1026,9 +1026,7 @@ static int ixp4xx_get_ts_info(struct net_device *dev,
 
 	if (info->phc_index < 0) {
 		info->so_timestamping =
-			SOF_TIMESTAMPING_TX_SOFTWARE |
-			SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE;
+			SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	}
 	info->so_timestamping =
diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index e6f7d2bf8dde..14a23d3a27f2 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -562,12 +562,8 @@ static int ines_ts_info(struct mii_timestamper *mii_ts,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_TX_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	info->phc_index = -1;
-
 	info->tx_types =
 		(1 << HWTSTAMP_TX_OFF) |
 		(1 << HWTSTAMP_TX_ON) |
-- 
2.40.1


