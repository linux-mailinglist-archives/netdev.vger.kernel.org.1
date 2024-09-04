Return-Path: <netdev+bounces-124848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E52596B377
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEC9B27289
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92414F9FD;
	Wed,  4 Sep 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d8yC2u2T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B783CDB
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436265; cv=fail; b=G9Aa/OlO1jHPM7ck6S9o4ILVzNvOY6OOG0rHuIJcOZUtVDyG5c4CU7nNCOU+HFIuFm309TZ+F3AQtW9l2Gvn5tgrbU4oj1ttwC+Frg2v10UZx4vh9URG+EzgkUdi0eyOrGjN6poIYMmmayC3PYe3WwfQhAe9mDEchG0mXR/+0U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436265; c=relaxed/simple;
	bh=/jnahzwK6uJaOCsghMwIu91jcUje80RzJ82jsmquXjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GB8JJd+CG+I4oCR+BWYcnBPtCrMqm2AB3l585m5uhVJ2Y3Hm1LejwarUboLUj5Bgq8AyGlZ2asVzYj7Ke97ndJINwSmZHKjRjO/pzvbsDGpx7ni/6t28OjNWA6RMaoxIKHHg2APOSd8DgJumzjE61J513HRW2tP1sXKM+J4HUaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d8yC2u2T; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySb5+gEeKBueVFskCZOXR9PQCJLDnjoy4zM7FwdMo6QPKT2mf0AWqVdg2TkSwbjjI4trQV5fOqwyfI1m3HCRsBR8mi3MO8nnJ1J5TxyZaY6rtC6XT2Lyt3RHcy6RVEIqM1AAx7Sz12tKyC8Ykm3J13UjchRYQInex+KrP2rgQaXjU9ShN4NgSKn+ruMfiWHNC4h4H3R2RSV2WrKoLNimJbHqDsnmeHAxjBug0grQiNXHj8cybMA+XGziO7aY3VNyv1gv5g8Ql02q+RKUkoQAMo+wZi0S81pXJZ1qTmiw3J4FUYrfY9Ep1BLzByszpv7TXR3J8CUJD+uXz1VXYcl7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDjRAz1aj/2LgEnlYuWdGxzGFgaMWlqM3MkjsPGQucw=;
 b=uebvIcRkLrYf4V1PEtZDY9FAHJ7vCTdOO+COCys9RvvQ7aT6BX+zo2kMES5l03fH+E6y0Augvg2ekmISQkh0/ACaqoKt6oYghD2X8hBlQtAvtjrwfDrBi2mRTWZax9YVaSz5wc2maqnYATdX4PV84zy89E9TZgp/nvkqG/c8Oh/I1FmD2kxKbpYdiuFzU6G0EK8eSzyEW4BKKQib4bWstla+3lBiTa9sRNxsPqo9mMWLZd64oiir6ZPGzcb/9YoXDMIlYst+lmXZWxdlvr9cnAS6IGMn28X0aCDfjeRMdRpDWUajlKZ0uvwn5SOvxoSnsx0tv7z5Wz0nadnLt6sSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDjRAz1aj/2LgEnlYuWdGxzGFgaMWlqM3MkjsPGQucw=;
 b=d8yC2u2TTYZbm56krO3TgF5phE3ylqz/tKnLuJfFVhUAYiRgC7+hiASVTHVVolTIsFSfCRKwAzZ3vReYkFvP524ZcW5POADw3itFRlVn5oh0/D2CnVAk+WEd3eNsFa+hYZAemUWVjlbeZaccVOfWpLIGwn0Pze7o9Qb9L3wlYV66kgc+h5eLBnvUC9j5w4+jl/i56zpRijdYLhl6ldxZqLR+nw1F+8cjL12N+v/qrcJwaPxgw2H2hAvx8wyPeggteJbhl/M1uJJaB7NN0q6Wh2KU1oJl6i5GeVgNJu/E+vonf3ahItJxICAOoM2XlG4/cYn+tnKNiUaIXKWbZESJQw==
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Wed, 4 Sep 2024 07:50:56 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e4) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:50:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:50:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:50:43 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:50:31 -0700
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
Subject: [PATCH net-next 06/15] net: ethernet: ti: cpsw_ethtool: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:13 +0300
Message-ID: <20240904074922.256275-7-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240904074922.256275-1-gal@nvidia.com>
References: <20240904074922.256275-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de33523-9115-4454-7b4d-08dcccb64f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ZmM4/k3/Y96eZrbQyiFl8uETRs9N0r4oypV5k6YcoA3rE7ciYSg5COLDX8u?=
 =?us-ascii?Q?8cnXGu3frQ/lbwyEtfGjDvpzUpKfwT9639yHortd81e1/iOnOALpy0Q2HLZf?=
 =?us-ascii?Q?gN0wb38IJciRmumfCXrg1XKumFI+cfUus/qdF2OOALkMoCJfGPeroZNSuCzb?=
 =?us-ascii?Q?PXqjWUOR0xSz9Kzu8A+EfTBU8nd2OwmfsVH9v+mGaTN8Aoc2PhsAujwfXXxj?=
 =?us-ascii?Q?yREBNEYOfaoq7MOjKfcFE/TztIWGNaLK+Vg2uAHOKKSFUt4NIvBifcODNORU?=
 =?us-ascii?Q?gGcuesayKY1dM/dBLfGBZ/BSk7qlQRROouOGO1X+X0IpfbwpSctwn2tWhjrU?=
 =?us-ascii?Q?Gm07wDn09pSjcMWIN6VXH/Z/oWDN7GC2xMnos3CABHSdox7hZRzc/XW/H8FT?=
 =?us-ascii?Q?Lzwp7NziXzEtpqHCVBzkh6mximdw96AIPgO1v3FiMnIcYg+oNbw9wYSXjz5Q?=
 =?us-ascii?Q?eslKezSttxKK6E/lVIQxnwALyazmvggwdYY0lbih4uINHfdvnIXqepwivOI1?=
 =?us-ascii?Q?h/WlITktynd8LSDpGTY2SJNJ2xkKsdu1I8+RxPSXAnNMJAqHOhhppXmkM/bD?=
 =?us-ascii?Q?o+OkLHL9dkbSEyJHhUJYQdbZTw46Oe1q0xBEautJxq/dzwy2e+qf7vP+f9VU?=
 =?us-ascii?Q?LV2+KBIN7nc+EpXUXIJ+hXU/B1T+q9mPFG/x/Ok5o0XKWFba/zDE2qly6gQZ?=
 =?us-ascii?Q?Ut6QEcNcfVyCGwJHqVxIMWUkdedDhWEst+3Ju4QQLR7DavZBNdBACJaoXafx?=
 =?us-ascii?Q?gEEkLDEelPiy/ew5faMzCHdGU5TAX11DJNaSS4pDvNBMjNqTpd0Z0xcNIcLO?=
 =?us-ascii?Q?QQfRtlMb6btS9UgGwE1Qa5ssSg0+YGfuKdiSMPgg5d5+THWl/qrCoesskYb5?=
 =?us-ascii?Q?jDdWdz54R+fR4gT0cHDeKoetdDcJtkRguSdjX8prBWyiXynKNPCzRAEUP8av?=
 =?us-ascii?Q?+XmcEPn04bRrvTc89mf4nPSvDgYWB+PkslzDT7A2Fl4LCcikhlo6xbZ5npB8?=
 =?us-ascii?Q?PkvQhbk46z0ipOBDCKk8Se9hG73Zq3/fjbCaR4BDsqI85dxC0ycAW80D8xlp?=
 =?us-ascii?Q?HhTnIrQDKVSz5+Zr66CfM/CwLfI90KxFRR/0kPiAU/omMwSgpv3XWWbvZ1wn?=
 =?us-ascii?Q?XZPAxeHcKxrr15AdPEG+Smg1MZKZtuss1eUXmi6D/0UJiDslGCZ2cIP8xcpC?=
 =?us-ascii?Q?/AteNd0KxMJmmEkDSzSMjlicuOrWaD0Cizs0FnqHo7eXcaLYGjzHYoUZFrXR?=
 =?us-ascii?Q?3eZI1jFyu/zAp0AhVnx0bD5z81tM26JQNficlzAuKBxwixdvWJVoVwpzOoP2?=
 =?us-ascii?Q?9fK5lK3JmlBJVv2Urt2HkNPqcu5fQzM3GXI/4Dx7WeoUvdULuB/Cz7aKtC9G?=
 =?us-ascii?Q?qxfN6B0Ps7PtCklLlqaPIi1y35W+684b5DreZ546ox2WWI6A029N+Lr9v2yK?=
 =?us-ascii?Q?IAuRidD6hzqWVkj9X8fevaoPzJHtCk3/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:50:56.2659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de33523-9115-4454-7b4d-08dcccb64f2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_ethtool.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

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
-- 
2.40.1


