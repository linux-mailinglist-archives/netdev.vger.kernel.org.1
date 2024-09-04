Return-Path: <netdev+bounces-124842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7371C96B35E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983121C20CFB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDEE15099D;
	Wed,  4 Sep 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQ/Ne4mI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498431494AB
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436181; cv=fail; b=iOdq6pAAldpSUdwt4a9Ezz8m/JzU66zO7Gh0tKVtmqaenl0AL3d3Izmsb1W/1nmA+fuBlU2LoJltVmFVjNHOBRjokU/WneeBV0BvzZFwxq3rUR6JuZMlj7/6aJo/q9XTwEyxPUE/HIt8T9RTya9kKUThczh1rG9rWB0QbJeCQOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436181; c=relaxed/simple;
	bh=sCqtcteL7ZN63m+P8aESzZV8E9W4r8nNeRhf2QPi018=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AMyEbzC1pR4IgZO8VpsEGeH2VTdm5P4sW0MbLUnnz83yvyGZa8EByxnkgNto+GZrQ856bra7kCz5DWGRzmwDkG6LXSnM18CPObkfmN4HVUVeIoDcZ1LyY2wIk+R8I26vDSJpEid2UrfWcF58ovVEqA3QrqwV9Lfe+/IKjR4x8Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQ/Ne4mI; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcB4iJWfeko72SvNP6yWnPxG3sUDkEi58PR8X5B0jzTdf1Uv1YUs9xtDjwWg/m5YpijzUnWiFGVKLfa4/OpNWus2RVzq0mn9x7Gm8RRjs6XTxvPKq3PNJ0LQP1/+oy0++Drb51K/z+fqjDNDLsgPWZSafw3pQ5KKDwAJDrVwEEFuWBUzQjLXRkGED35IMWVsTOJYsgZ6UZypx1L+/hnyax90/EOxWGM2KkXy7xKpExdf9SkHG16MVA0mShHTrpav60ekgxG4kDLbTVOZ3d2yk91kMS0CTrC3h2ly7vHSWbQ1m9VAl5oGTOESgZPEBWR9W3jrDa32unOCW/DpFAwrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyFJQn3baFN4h7KYig4oBgviIGrwcQiCvksquS2xBUE=;
 b=jKsIm5rUwvsQ1Q/WudVs9kCA02jejEXQcBUEloOI1EpDEQpde8Bs9JhtF+B7ya6Ef7P+WB+A9hSJH3WENX84ellv59ug8SmivgxDmJx8fjJAag9t9NTRIfVuGBCL+NPlDb+Dn4NIBp1ruMs5mWRkHR96wdLgvxB15T9EJMzHoROmY17+FBWhjRdIuaFsjRL8DsnOJ+Bk5TYhqCIlVdATQpSsRZq3byRolCTEXQSaeO1CBORVF6VCaOPColZIUDpOrKkYGXO/rvgStmPmslRp7UvPBv62VsUMzFitEKcDmtqX9pHXoiaJVDKIQc2PK3u8mu9cQcDEgq3QVlyTL9otCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyFJQn3baFN4h7KYig4oBgviIGrwcQiCvksquS2xBUE=;
 b=oQ/Ne4mIQoMnZszHgpVjKoCLkc0WO+FeqsQMeFNvn1NGvvkQ5EH3WsZb0G4VcqxBAjtv0askfruUXj/lyzuo0hkLkLlYygLaBXosUDDbTRVSKnOP0J0ndKHxJHOK7fWfZEwh4Onm10dYvP8elwocOwe+zEh/gmk+nOUWUQAYgYgJGHtcs9656/q+4v8mAiCr4Ch1vjWJBWEjRMUqwCqFkCbiSBa0C6IxlvKtNZYEadRtEZQuyqj/CelP2Tc5d9rN1Admqp1NamSOTbQyNucnGxNduKPvGNMbfHUy0EoWE6RI3Jp12furcW8yP6O/ZTgdypZ3LkwShEOH0Uc1f3cYXw==
Received: from CH0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:610:e6::35)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:49:36 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::9) by CH0PR03CA0300.outlook.office365.com
 (2603:10b6:610:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:49:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:49:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:49:24 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:49:12 -0700
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
Subject: [PATCH net-next 00/15] RX software timestamp for all - round 2
Date: Wed, 4 Sep 2024 10:49:07 +0300
Message-ID: <20240904074922.256275-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ddd466-533a-4ed1-7ee0-08dcccb61f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aIcY1qms+uSKd2grAeaKKEF+hH4lPUZ5t/J5mZTLCN9+eYicCnenY7jioobr?=
 =?us-ascii?Q?KF4sKdvef7enFJROIH47hHHTix0Zyf/67PrHHbbTCBMMRtOtGZLH3QHs7aAy?=
 =?us-ascii?Q?WWt/8YKBKcOK+uftsfclRdbwNcaCCvNhnsxPQ8EypgzIocRfJnWFLAoIyCJW?=
 =?us-ascii?Q?cm3mZk9wI2dhQMWju9YwFu2V+lKiqHTcijmfORYk0cABNAJVYypD8tq7yyMp?=
 =?us-ascii?Q?E9qDqnmuozp39U/gCGeuAxsq830I7nDVA/qK2Sj6EEAzk2nqlSp/sjuohyLC?=
 =?us-ascii?Q?yi6ctU2fCgpnc8vt9V12Qoy1dfkqDTIMI2zeYE8U/ToKzdIGa5t4T5W1RbJj?=
 =?us-ascii?Q?eliIShmoJNwMODPQlhpjWwCRTpTXmSObLL89PVejarSg902aXHj+g4MERy9o?=
 =?us-ascii?Q?ojdhscy6dcdA9xorRN+tEDi6iItMK3SMc8q/mZ2kGjlvpC8noMhXrXbGocCT?=
 =?us-ascii?Q?ahliybLvF6LWfwcOZwi2vHphJnUHPEyWntZisJD0iIKni5Ybf+efnZbbtyyq?=
 =?us-ascii?Q?RRWhSd7jB5ReDdRFsy4NJ2KsOZnOEPpj2cdOyfCOhi0BUV0gHLwr/9lXTwcK?=
 =?us-ascii?Q?yjqSzZ49d/8gHZzfAyeQNLMHZoBn5itSU6X0Jg7Ryg4YyjLMCDeXci8Rkotm?=
 =?us-ascii?Q?iNA72GE+y3cgAcbkImxotQi96qvtOL7rGeTaYlnjSg6Bq4ij47S0tkhRxd7A?=
 =?us-ascii?Q?3mMK9LOJSSyUOGTWmq6RIKjD1humZd4eWWO9DpWHnb0LKQsWrDt99+lAWUam?=
 =?us-ascii?Q?JQKE1XoYIkXRznGddzqcBWOO3OsAsHE6reBTP50rzO6rDQmmAE4SULjDP81k?=
 =?us-ascii?Q?N6yOi43jceEDylt2qq3/3HItV9gASa7DcdN1p0SU4WDAu6CAJAVXxl51D+Xr?=
 =?us-ascii?Q?idOSZs9sYcQkLrgUlhrvLyI1rEryTDeu/1gZoBF2UAoOuHYiMtqVj6sXHX6k?=
 =?us-ascii?Q?wnUOTlXj+zv5YEZOhwTg30zhOZe0CbKMJca7zDvyND0vg3B9bXeKLoZ8dU+b?=
 =?us-ascii?Q?PQwa79fgZyR7HN+Uziyn1x4oXzz98vpW6bFQKNAHii2rVTJBA6ltTsNKhIqw?=
 =?us-ascii?Q?REPSAcajgoc3JTSPuAHxIMzI38PgiT5oeggokXTaXRD1YLMsr+5DqaMc1nOR?=
 =?us-ascii?Q?OWrvb/J9uNaxENYSx7kCvL02k9062DY9282qogdv9yWnUNioqUPNkQ4r1O5Q?=
 =?us-ascii?Q?lEFmlzno3Z3v0FKL94nFMAnlPugcwSDgoHj9ZjZO1SZyPP1hSTtDo1u6+K6b?=
 =?us-ascii?Q?r1vph33kJwwTK27TM+k0nlFjl23cD3GpAQ/wmeS+EvQzf05ZGNuSHRL6E1dT?=
 =?us-ascii?Q?PgCZx6H71lNL2OoZR/N39lUx56IZzZWPc/wrCSQEd7uMGRvgwDFaR+/KPyne?=
 =?us-ascii?Q?tGzYHnWgTUrXwsAEq8joVHEXTPBJbUEfke6jDPR9B1Oz1EpKeiKCH5aTSLb+?=
 =?us-ascii?Q?+tKb/S7QiyCmxW94HnBILI0m1HEirIyi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:49:36.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ddd466-533a-4ed1-7ee0-08dcccb61f53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

Round 1 of drivers conversion was merged [1], this is round 2, more
drivers to follow.

[1] https://lore.kernel.org/netdev/20240901112803.212753-1-gal@nvidia.com/

Thanks,
Gal

Gal Pressman (15):
  lan743x: Remove setting of RX software timestamp
  net: lan966x: Remove setting of RX software timestamp
  net: sparx5: Remove setting of RX software timestamp
  mlxsw: spectrum: Remove setting of RX software timestamp
  net: ethernet: ti: am65-cpsw-ethtool: Remove setting of RX software
    timestamp
  net: ethernet: ti: cpsw_ethtool: Remove setting of RX software
    timestamp
  net: ti: icssg-prueth: Remove setting of RX software timestamp
  net: netcp: Remove setting of RX software timestamp
  i40e: Remove setting of RX software timestamp
  ice: Remove setting of RX software timestamp
  igb: Remove setting of RX software timestamp
  igc: Remove setting of RX software timestamp
  ixgbe: Remove setting of RX software timestamp
  cxgb4: Remove setting of RX software timestamp
  bnx2x: Remove setting of RX software timestamp

 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  4 ----
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 11 +++-------
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 ----
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 --
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 +-------
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  4 ----
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 ----
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++++++
 .../ethernet/mellanox/mlxsw/spectrum_ptp.h    | 20 -------------------
 .../net/ethernet/microchip/lan743x_ethtool.c  |  4 ----
 .../microchip/lan966x/lan966x_ethtool.c       | 11 ++++------
 .../microchip/sparx5/sparx5_ethtool.c         | 11 ++++------
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c   |  2 --
 drivers/net/ethernet/ti/cpsw_ethtool.c        |  7 +------
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  2 --
 drivers/net/ethernet/ti/netcp_ethss.c         |  7 +------
 16 files changed, 20 insertions(+), 87 deletions(-)

-- 
2.40.1


