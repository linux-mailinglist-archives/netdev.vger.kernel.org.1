Return-Path: <netdev+bounces-123328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2269648D1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B322EB22165
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86271A4ADE;
	Thu, 29 Aug 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dZSCvw9S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47541AED57
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942586; cv=fail; b=HDzRoF33hTUJfyXDbnS2plgBMEGyK1MzX+8suqZJFofGvKFDAyMgIy254X73fapsMdaHaszgc/kYFtBfyMneFjZLXFeyQf/DZ1sZZVTyYdkbujooj3rP/AUMeQqEewpbrhjK+FVM6Rg3EU0zbAnylkFIwEel9yAQbxc/C6FE8EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942586; c=relaxed/simple;
	bh=FiW66kRuCC0zoxszgMl6WVJiiKHUZhZ3ukhFaR+Ve5s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GfHgnWsKJv/BWs/NIcpa1KK8xIg4Z5ZVgcUYVDXPkqFGuKmJMfonF/UE65CyDUaP6kzadKRs+2+ls0s5Vs6z2qisKR1z9xiu0dqiuVkmD9ySC1ePRgjraeueZ/6+kRucadjrhhwlrHKIHeZcXXc3oG99Dyy4aRF96C8sAAfG/K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dZSCvw9S; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1LoVCiqO5Y2c2crcLXHGMHA9XjE56fyHp8Zn1ob93U9qui0BAnuZwTKtrBuSH6lt0ElVr1YVK2xN+QwcHJMmwKG8CaW2vaGzaeTbtoVnqQbSsWChHfIRV/ALs9+7kYEmcdrhPJj0w3sKV2BZnsWj3jbXhxo6gJ2JQUYshsmcbx912/NqTflPHnTgpRHCzEzZ+sHNZ0sc/zzumt+9tN2g4f/cLKR1JD7jC+5UcGaN7r2nrkGAl7SG/OyS9k9dKDQ7FMaALcOSIWeYPFe6sAfAkG48FT0EZ5/TdKe7Dnb2wbvpVLjsJGQQNfL9xYGfj2m1cYKndgR7CU+PGU/qdJ1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10agkcbbTvaLnfDOH8xV06WSEnOudby3U2iRPWA1/Fs=;
 b=uYfpdiyCMBENjaNai5Ag18XF7sskA+Wimdbl5EETN7sgtVa6EeopnrytuaQdTeETuNeEXBdJhy/h3CkI4L1xafz4ZsOxLM76USKqZKGrJTJjt9g4JKjPeGBtLidSSEsHflqh+Ina2JyjPC9C9NxpRnvZv3iYyEwtw6WIGNOqhT+2twoMTdMlPZrUBDSWMMcGTeX1WkFYnWG3TB/OIKePKPjyhzBpcYyfGZJR7HKbn4qoqMg1f+OtEpLLOY54+eE0NccPwjfmfRf9pg1Ftyr2NJzExVjqzXET0f8S7E5TxKZtsK+hRNPMsfuKCCIGWGYHJ5ZuRIeGJnlzmuvcjkAvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10agkcbbTvaLnfDOH8xV06WSEnOudby3U2iRPWA1/Fs=;
 b=dZSCvw9SHpugc6sqrMjzFd27PthlugE0axYy5IbspV+WUEjQAzcymEd97ck/K+WESCel+I15DtgFHt/34d31/mjs5CZawvsuoerQE5SgEikRTeOnnxkIYePQgEtdAxsVx7BIf6VmvoUhnlYa+0gG/sL5PjmIC1mAjHr+qkH12xNC2xcWsO1TyykS3PjVBiNwu5ETXLw6l2hdlAJS7RYpxS3DYW0WB9sDt0Pz1Mt418IbzQ/pcWM88YOx6/ptan/lF0eyif6xY84SkTazvtFjIG/0zxZVCQUYpxKPBNRGlFqA9R1McHrFNmevOuOZHMQ2nXG8UMf6tlEdMVGoBF/Xdg==
Received: from BN1PR14CA0005.namprd14.prod.outlook.com (2603:10b6:408:e3::10)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 14:42:58 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::75) by BN1PR14CA0005.outlook.office365.com
 (2603:10b6:408:e3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 14:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 14:42:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 07:42:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 07:42:51 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 07:42:39 -0700
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
	<gal@nvidia.com>
Subject: [PATCH net-next 0/2] RX software timestamp for all
Date: Thu, 29 Aug 2024 17:42:51 +0300
Message-ID: <20240829144253.122215-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d2ac3c-01ca-49d7-d358-08dcc838dfea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0IzipW5nW/YXZGcJL6hQPAIwsrkSZveW8CxM4OtvkmgUVWXaO6Yb7Z/SjXbB?=
 =?us-ascii?Q?CL2QHDQEY6rFL006iHOvl0+Wj5laznvkBelxclOjCNxNRJAdnfO8HNbVSZNh?=
 =?us-ascii?Q?Ve2kKTleqcGNl0w5T1viK8hVjOQPKCTpKLw7hQzSkIIZHMLQq+9jc6lNhARW?=
 =?us-ascii?Q?/3LZgHE8uUSwzZR1NWxE4lXUOg2cTFmte40fmpRzhRAO56lhEyR4KzmNey3V?=
 =?us-ascii?Q?AAI6QBatYhzR2S68IDOFsZPKPpHoa+D2zCMlbwr/g9bX7zbpiDcKIOVkf2Bc?=
 =?us-ascii?Q?vRK8LNLpvTdgWfD4J69Gg484OHFScs7fOPMX8gc9Rt7flG78B9W5b6zVNe7g?=
 =?us-ascii?Q?V/+r6N5mCgB+FIvlqmxoIE37m5yNhZxdWYrXJ7cmVL0DcvjJZvP7L+pA4Sfb?=
 =?us-ascii?Q?GNOOnfgrXq0Mmd5g4dF/646jm6Ljlm/gTy4UbDcgBG1TdHtYzO36ACLmoy6C?=
 =?us-ascii?Q?WBZnZPC7kDCsoPA7bXlQWfFS/bs9YGgKmwGjGbV4YoPxDLDrcID8UXCE0qsR?=
 =?us-ascii?Q?tewm4cszpcU4YlQbC+WDZ5fPwB7Pj2GBdMKcCcsPfscgG22MlA1RnnVg9ec9?=
 =?us-ascii?Q?CLMgUvXUapPbp15o+6l4q7YpSActHSehyk69VNnCmXH8GfH+0GiLSZHEdGyc?=
 =?us-ascii?Q?Pokypt5QLKJI712JEKNsMF4bF0yQmLtuI2duWqPvPELjT1G9CLSG6GecxO6x?=
 =?us-ascii?Q?YVJKf9OSHFwuQuqQEfNCY73wRASHeZbCl5QqlTCx278yWhP495vykf9vz/+H?=
 =?us-ascii?Q?gKcNUAf0twril6ZoH5fYf32KzJwegNraBWGlXknAdHsBDdqYAu7NcR09DNvL?=
 =?us-ascii?Q?XVv1NZR6rd3w1T7G+Z9gH/EIKG4W9zx29RqxZtQR+tqsGFExp9hCZyWXB4nQ?=
 =?us-ascii?Q?fuubBhwRnj5EC6akJifGUYDhVniZ1SnOZC4cbbe5GLG4ZwIC0xEtIOsd7af5?=
 =?us-ascii?Q?eZjDf6Ltxt/W55iXKgkX0EHgeG5uDb90K1uCB/MhQmRjAi0Vj5xo3QLJK0xr?=
 =?us-ascii?Q?6ZYm5660ly8GLb6T2b6SqjV8968zwCjE0YfBSLI/b3PWtJlyqqYT8oh83hRD?=
 =?us-ascii?Q?01MRKZ9ilUDeX8e8kTNvnCe54L02yTIyCIhjrtjaukZrUgjegFsRCzoFaCp6?=
 =?us-ascii?Q?PnwkQ6GsSU2ENHa8174Dr6eyH3SOqtKcpwr7OzEej6WXb5K0wWkKmujAH31L?=
 =?us-ascii?Q?HrjgMgEYePKMx92vNABVRFS9xEqAXzPafG1U/8dD1fV/6MR9+YdANw68vCNw?=
 =?us-ascii?Q?4Bv6SFudK2/f17U6vkgrp9tBWNQeLJ/es9JJPy2/iErQlVOIBsnJ0ngO7mdJ?=
 =?us-ascii?Q?gX6H6KSGUZV+oLuyo0aT+41DrcKIIgmzdPQHd7GykV23CseYsa47vyIzcCNm?=
 =?us-ascii?Q?l7EnNjnr4fTpihTzeKjUWVWUC4LuAow8RlkeqRb7mAm+/AO1ji69RnxifPMd?=
 =?us-ascii?Q?gcS8Bfzr9/RnSjTBQkmKsgn9cQlG9C3z?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:42:57.8481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d2ac3c-01ca-49d7-d358-08dcc838dfea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366

All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
net_timestamp_check() being called in the device independent code.
Following Willem's suggestion [1], make it so drivers do not have to
handle SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE, nor
setting of the PHC index to -1.

All drivers will now report RX software timestamp as supported.

[1] https://lore.kernel.org/netdev/661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch/

Thanks,
Gal

Gal Pressman (2):
  ethtool: RX software timestamp for all
  net: Remove setting of RX software timestamp from drivers

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
 net/ethtool/common.c                          | 19 +++++++++---------
 47 files changed, 57 insertions(+), 217 deletions(-)

-- 
2.40.1


