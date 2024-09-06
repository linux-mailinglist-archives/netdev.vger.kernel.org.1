Return-Path: <netdev+bounces-125974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A096F74D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D475A1F2182C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1911C9EA1;
	Fri,  6 Sep 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="URTC6JYj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110E172BA9
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634074; cv=fail; b=jyDItV5VM07MT0uyIBnn25e12SlNa4Voqhu0gXvv9YweL+CaUOKWKH71xBsBZdYeO0NcaOUGJe3hUgH32Ooyj0emObZj9WR1tNFn0BtNA2nok1xT9K2sn1ky10ng+dG1hhJEycmw4R+Rh5QRsd0f7UfKb5aIa55yV+y2/n+JyLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634074; c=relaxed/simple;
	bh=hG6Rtj4zT/RsZa8MmRZH3jmyYAUgTve3utzeXjLELEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F61ziRsQEerBAUNZFZBBkegMINkEBbeie1X0Mfahnit2HZo7dQyOHgVpQz1x2kP3GA6KwZDdkpPQEAfEvq0I3BYfToCjduHKaSpasG6jqd1A3RoHL9ltJQqWgFu6jiG6d0e3qcq6eEfq4jLZFKlixaQ24StWxt8IoWB1ZmHC1+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=URTC6JYj; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAGl8i1yjxCoimdx8KARAveORXHUqJ7ivTnwoK7QZ3hNRU7U60f+ITCpryd1i7PFqP0JXiEovasYdoMTQ/hchvmBx+3LQV+UrO7MuGZY0q6kNyLhHIpzGk6Qsy5nLgfoPly4ICRrURR7f5EbMLAAIY/cZcATAUwtoTp91HUrKAOa8UGsqdjL7p+FaRWz9KSlmyNN2fAScSc0Dv0eObdpvqvUINrMxRGvPw2ymKHPAm8koWghyAgt1Flpz/l7za/fipwfP/oFSCcEEd2oo/SDYuPrPehj4v73OYKZQCNwQOcxuAndGYqLu7V16KrtfSWX62ECCbm2HpStN2svMFvhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Cy152HuT5gGD1yarcfRz86ovri7kNtKhzteQhYXYDc=;
 b=QynLgkWxqNMP7ii7NMTnHSXNa2Cq3hGAA8eo0V47B1yKbALKRRh5BF/E6aDUwQ5RJhwI8VTpuy1hovoY77u04iyWpaSsQeeDqj/wOfrkWAebFICzJzc+wY0Fqnj+N/TuAR5I8C0VdfjI9h+sL3Ebr1wC8UYVG+124eAMXZskRq1cawLQo0i1PxGEGtb0lQzsdBGT2pLN4be6bQjU6h/2JY5XAsZneakQ3n/T3CAq903amEuuNdXPUg6U4ggo0nyvOfSLUBoWNoLo61l3QHv/Ic9n59+v3aMejAjvbVjlOVSk/1T7matBkcMqKyXJH5DeBJfvb75KnJVgqeh7QRKVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cy152HuT5gGD1yarcfRz86ovri7kNtKhzteQhYXYDc=;
 b=URTC6JYjM9WjxMLk0eMAZzkUh4oZscaE3aG3FNSqkv2UyM3QlXbXJhahT/lTqbH8ZPCN+7/MOYYbaAnhfI+QyKsP1VnnAKw+2omtY/st3dl2hPMolfKbxCr9ANfDOM3FezmUzVLruXWTQENcKLV1QSFDJtSqe8UBdTsA5R0BNkY9r0fJ/oKmDV85wlTuZxX21kRV8WFa1nJjTZIcdd5KPsp3aLYlct/wC8anrd+THc3e4wi/PYJEvJHEzGTgfNKCef4nOsfKYhvTm8rVEy4wq68ByqKcajpP98G1I8NotiBhBFyUSVve3FwnnLCa0wIlWCksVh8M5JrYAXGwX8W2Og==
Received: from MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33) by
 LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 14:47:48 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::d9) by MW2PR16CA0020.outlook.office365.com
 (2603:10b6:907::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Fri, 6 Sep 2024 14:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:47:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:47:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:47:36 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:47:22 -0700
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
Subject: [PATCH net-next 05/16] net: macb: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:21 +0300
Message-ID: <20240906144632.404651-6-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240906144632.404651-1-gal@nvidia.com>
References: <20240906144632.404651-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6152d41b-fb82-4840-cd8e-08dcce82dfed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FoD/Ma1FEtPv2/kiC+v6HmNQdSqCy1TJcW3FkhC+lra3kEVWf+58G88DoCVV?=
 =?us-ascii?Q?YT6OrTI9pbW2WF9NQXf0BBdmIXAsHcvXMy6u3saytnN1jxfBpEqJdDIgZtYk?=
 =?us-ascii?Q?lPhDGYpOLHtFewKOO1uB8B2D0LhzMUnbPZ2JZth+/hkTKa6/b1MOYt0kiQhB?=
 =?us-ascii?Q?VF2/OPorPtnMcyp5Lq6uPpXAxbu/wbMF1WYu0abz4ruHiXVmqKqZ2eZ9aOxv?=
 =?us-ascii?Q?jMzpXOJbFdshjcYMcDYgarvO2fNO2WO+6bgT7rSnK/6SdDSFhddYhqE5jyh0?=
 =?us-ascii?Q?RA/qpDHgHTd0omxLiuCwddbyWUpcucxsF2w68ENvxwpdwsZ5oIdC7tO1b3HY?=
 =?us-ascii?Q?w+R/YSu7ggCN2FxCXlqXjRExUrdmZbrw1HjMubRjeuo/WcVKj0h3bxOYzV1B?=
 =?us-ascii?Q?pgvCl+P4jQF0AQxROdkyb1zJW4+/gNcf0TueHAXxYggXsJ7sSA5j86Mgxlit?=
 =?us-ascii?Q?kmh9WPzQ/M3OG/ltqJH4sgG4Qd9UympYgVyzm6nrcL2MHoWQpo+nEZWY5jIf?=
 =?us-ascii?Q?kYS/BhXLaNKt/OSUDCaSo4zH70QQpbQR9VZP1HTfww9Wjvh3MmHIgcFS4ig4?=
 =?us-ascii?Q?xcEdlDBveIqc0Dq+PcOnXuo9Iq14tyE+KRgkpcgwM3BmqZ8GXAuEbnyhb2Yy?=
 =?us-ascii?Q?+3I/DGk6lCP6uxQvhAs4vugU+WYfB6/3YG9SrKaTuSCBkOm43aIL2SzAUmXj?=
 =?us-ascii?Q?xL0ZFKtMq8QVrxdaZI5Xtovb4h3xhudwwEDXBWBo+6U0wmN3Z727TD8gu2cz?=
 =?us-ascii?Q?C4iPA+52CGMnRVewqzclPihqYP7sG675o2ZXfjdE1ZlHwH2iU3Oe755v+1Ry?=
 =?us-ascii?Q?RAoqWcLff1BWp3gpCm6fiaAVEVxLV56U/pPkiCmytxbPjjCuBKYEwHDXIxqC?=
 =?us-ascii?Q?dfaATvAWyq7dmvCyyZQe4chBuf9uU5UX9lXsiP+BJXm00LkrrrjiR8D8+n6s?=
 =?us-ascii?Q?mbpbJtHC4EawssAxepibumUdpuaWKkoExfDUqUAfsp/8IPrJPnT994/25jBQ?=
 =?us-ascii?Q?07YA0OIeTX1/9RWdVSo40b2VQXwzMy1my5kWo/oPqGCi+7Cm45BY+9pY5n3l?=
 =?us-ascii?Q?AFVRD90nQfVs0hPCrEjwZ6dr9K4UxYRMZqJYqgcSMxIIzIcJNXhCpMsXHbWw?=
 =?us-ascii?Q?IHhBMMYmMcLcCEchFKVK85+uUpCPGNmWvpNqOAF18ESq05JhDb6XP61emtl7?=
 =?us-ascii?Q?wUIt4taa/0zFKGSH5Qr1/vQgCA7s1vDBzXQ3LP4ieh9W4J31c2s6RFByqrL2?=
 =?us-ascii?Q?3bhCEfV5wizL4UpLtKaQ6V5rqBw+6YyI17204BEFWLt5K+lXshk2DEPcSnqH?=
 =?us-ascii?Q?8T9GdldH76DHRKhO65CUcKqraDAosxG/uJdxibyVokbP/yrY/btBfO2MW7VX?=
 =?us-ascii?Q?YwMrti+lm2Z0NOxjCtUZOvY4RV1PS+eEMiVVKElvDflaQ6M5B07IMXYepLQf?=
 =?us-ascii?Q?BzCUd2sCiwk+hlMGDvrugdpUl7FHaPuF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:47:47.6648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6152d41b-fb82-4840-cd8e-08dcce82dfed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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
-- 
2.40.1


