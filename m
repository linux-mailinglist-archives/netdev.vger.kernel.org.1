Return-Path: <netdev+bounces-124853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D796B384
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F60B1F26597
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3919415099D;
	Wed,  4 Sep 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzlUIZXQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383E155A4F
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436326; cv=fail; b=kqkd1Btn00HetWOBPJpEo97nWv4S3xj7ZQKPcYVuqHd1KgbjGxVS3/SYKSb4znJgzvD/o7YfNUkJYnM7rOdhZ2tgHvolLDwfIxj2HYTDjb9G1UbvaYjOiw6bvFdbk8cINcybcHktFf0dvUeEdUxSquqbI3uJMsSZIE24fHt6ejc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436326; c=relaxed/simple;
	bh=VuNM2RokQvzGLvXBDsL/w670+Rwb8iKOzmSHJimHQmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqXgd3utc7hFTFjcoZHc2Mgarn8PlN+vs6wVHjwdxuhKppzDkt5oP5H4qOsKMHm7IXtnlTaJmLWTy4yAergDjXtMxXGLeRu25f4vBjBuHgRDsCUc9rCTa4xFXoSxBGny8pD9wN1VhnftbqmjTRVwqQmIFLtLwcr/m5JKwQHJrzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzlUIZXQ; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN+/iSNVcGJbtuWgAB24kefJ5D4MfXpXq5HB8FnLzleX2Gb2yBIVsk6qOsprmzXWkozPi84Y7vGc/Xz4O9ycyg50f2e/ErO08vQPGGzixiB6bxL3fkpFeWbqV6rZziMWuLwp+rRJ+Gielmi+13RLOfQ5/0XZD7nVmzPX2d0WFWABW8iLv4BSQNxT4M7VxNwkpbbF/qkrE198fYzAApkA9ciW7bbk9Yulu0WtZ6lmis8WsbELSiC8o9cqS5vkt5dOf7MP7iODuSkNETMyRVX/C0tQPWp4KVe9e/Z/qNCD95qbkH4R5CBMnchRwOS4qFcvHG1SDt/9/MraxLgqTUmhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bgGOZq/53yGzqCvn3p8pXH0Sve5eUIfmPF9/ku3Cpw=;
 b=krsn4hnY2j2PsMNy+Cs81CEF9RqsHEkALRP+NssWxkiPRSMK11wJizZ1Aoblx2wnrqLKnh3Xj+Fdos9DSroXkSyv0o96xpROjFi7sIKFOiPwhsBcL8E7VPyLwrdTNUKXH69lbtF462KEM0MZohFQ6WmS0AUdpG5aJDbBPYRjNRapfPz6N/rs1E2exJHTg8AMqEPvh6YCKd81AHngAK2LHcQwVVKa44AkK5O3rfWxZMsDWJqAe0gVC212S+J0IJCSJyoXSjFjfGu0dQbY5X9uX5c5NZnfe5mv/bmVetzMnxSwYe3/UbV3l+fkQvShdMTzCxgfntf8iOjw7spLVOVcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bgGOZq/53yGzqCvn3p8pXH0Sve5eUIfmPF9/ku3Cpw=;
 b=lzlUIZXQIQPC6VD2EXju1yZES3gZnlAtB+PrQ+eHUBIrBkthUFMbj+6IXR7KJSevwEMVmw8elrh3PqCd9BxvNr0P0tk/GtOfAXSqTGZb1IEPDE/22KqC3Yw7r7ifk2Lo4xRK+fCdPiCnA8zMiD2PKx1DupX6CP6lFVNzj6mwZdfNb3Fu9/dOTqGjMo8qaTFcBSz2O80qNIC5dZH8ybvITisInJqrMWQ0QjhEOMHFOBewmEQ61gQWkCXSklUblFBBfGHNeZviW1bPT7wrOYssxsR492guABSnUoB/9oEMCF0256jSntXpdGS7b0i2VpYrhBsZzP4uP4pkYfzfYVG6Lg==
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 07:52:00 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::4f) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:51:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:51:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:51:49 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:51:37 -0700
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
Subject: [PATCH net-next 11/15] igb: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:18 +0300
Message-ID: <20240904074922.256275-12-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: f08ba1c8-2a0d-4995-f5fc-08dcccb674ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txb6h4hhFSIqCuJEI7Pc+8RUozo+E52rI//Cq5zeeAInPPI1iRsJEuA+g3EW?=
 =?us-ascii?Q?JDgHV9ALHt//0UN4zQbZZudBbo8yzl/3xrjQfR5VioSfxEOpxTLx76Gglvj/?=
 =?us-ascii?Q?IynoG8Omm6YSw1Iv3Ae4DHFTQF8QBqr/GIvSU7MkEuLxvySgeI8VExBNzD0Z?=
 =?us-ascii?Q?ULc1w+7iCRvYdOfOowmMgd27IfBr22/4ua7G+9L6J6vPgtuy3cJgGpgbVJHi?=
 =?us-ascii?Q?YSpegW4rpRDa9I7ys2V/hfjmT/MIgMQWiOvgOL0jH3D6gLGthchZ41kka45L?=
 =?us-ascii?Q?Zcq9AVbiioB/7qoE6YG6yaCVPhBH7Br99xtYbXFluz7/+Kg2448W1/zp1Lue?=
 =?us-ascii?Q?jqKg6RkhZMG6ktXP4lz/vTtVLuvvJzfDS+WtcX9qMNbOwUoJ7Iy8K/r5HfpJ?=
 =?us-ascii?Q?E6t7mjVVtoftWttoABDUKjf99FFrZ3m0jEQyL2tYTyhWErCY/fLr68FFTqHG?=
 =?us-ascii?Q?fcJ6d783gTUynyjVio4xlu6gz6KV4+jDDAm1fuzMS6t7WApzQCAEQpRseSwE?=
 =?us-ascii?Q?0/7VRr5UT1XFE2EP9o7nla9vGWAkK4iarWssp1MsaERrWaVLl6sqaLGBHplA?=
 =?us-ascii?Q?t0IMCM8l/sbjQMNJghiKNHynwoJW5RElDXPpc0Wj3s7VP3m8tejL4d+Ezv5l?=
 =?us-ascii?Q?V5+RPdmKX46K8U6Y/1oK+rcdp6PLQfntL+97IdhASS9MgB4hvYRPZ2LNtRuK?=
 =?us-ascii?Q?G1oJ5XAVJn1j3eF0pdquNtzJE+XpnHYVoac/c9+tuCkZsxCoQWB7btxcDgK5?=
 =?us-ascii?Q?YHI36cJexO4bvJV2IJuw6q8o61vKdG/YNxJt9qkHCJu8DxPiEPzQzk28M71n?=
 =?us-ascii?Q?EpCIFXseRsCXEzxdawAGHe9DF1qu/8lSjbujPf0JctOg2AqYaLfjxLsDRjbl?=
 =?us-ascii?Q?4bq45aHjhwjZiKZTx3EPjObGwFCwaaH2r9cCEALA1pPjgGqMYx32nmV+ry7G?=
 =?us-ascii?Q?h4RvgDyCqqG/DD7xyeqUhZ5OrwAvoqWkEGxGhG8m+f8Q+iBuAJD9/Vs7raBK?=
 =?us-ascii?Q?vtOa/II7QdrZxZhOuo99yqjla/E0Zk+QvsvhnhMeupehjdcYagS0+jKaKqMl?=
 =?us-ascii?Q?UvP20HU01f+nG98nZzilUcAhoxTXtCd1UZLIjyfiqu8VlIUpoqyFuUfBm3et?=
 =?us-ascii?Q?tJGqIDQqQLeczw/fSsx77Qa9jlu4QznwDM/kOR6St8pji+5fNQu2K3UWMpEJ?=
 =?us-ascii?Q?UTClYExUn/bSQcpIpW/VwB9PLDY/z9HAkuQqQTjogeX5XCV4wdJos+PfTVes?=
 =?us-ascii?Q?Qj4tSJc6dM8wk4x6rzoBmSlqXBwxFy5VfCESIg4/lJtpXwvyLNRwHU5hPzNj?=
 =?us-ascii?Q?4FvKMOubkMhCu/RG+mXzZg/gBI8GogUQWtlq+JfI4KnaoxXcJ6xWltLiJw8C?=
 =?us-ascii?Q?xLK1YqtHslaTrTdbgT2dlAUki2nCuTxObF/MWe1/obu0QCy5dLV6CMa+qnyg?=
 =?us-ascii?Q?kBHvKfZJXeUg6LbdH9ucCE/xav5KEoCo?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:51:59.7719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f08ba1c8-2a0d-4995-f5fc-08dcccb674ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

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
-- 
2.40.1


