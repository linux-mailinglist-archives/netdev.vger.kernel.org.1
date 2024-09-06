Return-Path: <netdev+bounces-125973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA696F74C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE51F24036
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2A1CC8B7;
	Fri,  6 Sep 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oJxjJ2z2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F8172BA9
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634061; cv=fail; b=NHFjMTrv5ZD31vwNfzpIHOqnSO0EWCkoZYjkFqUBO0Osm+yOU73RilYniFQUqXm7G8fpGoFvIIrVuE1TWHmcv5uvly983i4wfCFV/u4UOkk2bHqIcD3q6PBMlZm6tJw113IK9SLVTFmuDJbbJkwY4ziL8Sjd3lwp6V+Z6TmEGeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634061; c=relaxed/simple;
	bh=/Dy/7Xnba4v5YETpCpkrUiwsYBXRWvtMyPp6oDeOBJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRPgkZfkRHec/zenPh7HuIjQ5JTkQtFnSC51CeVHAGKL91B9a2n76Ie5/EwxL40WXdmmtP59k/Db/0kgAjBzM2aajPFNxlQk4yJ4o/84eCC3Ltn3bDlnL3E9BVc9i4Gjn5/7nk/fk/pF8NLO1I19SdWs81Lf/NMmOtJNR/rSljQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oJxjJ2z2; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0j1tj6FLjyGGjsSnnedyjFHurrvSP7bsUhZFh43WoYt/ZI14koDehfS35PgHq7GJs/C5W16vR5KO2Er/VSTFVk0mBIXEZPUxs9HJoiK6EATuDYDf5VrrdvIwsKoD/Kh5hTn93V2aPdhpsQiB+bvfvBAUej+hp+fCop3whe95p7ctTohxNk99Ry4RM9wpjMM9PvJLXujv+uCppAptOOLSUoe5MsW6r3mooS8ZhVFmdA404gMqIcTjeabLiCsqcBPqzNOnfVvYQ3vjarMvMGhdkQaWz+dPAsRZMcSqWqFxoF03iO/O7X+s8o9KdEE+Ea+rYfxlQVYv4vjUwViTyhFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttyYOm2eSxRJ3GIjh624NWuMweJOKH/PW8kDWskfvzM=;
 b=mm2C30DnWoXxbW2/sXJxZujkFOjHlnWk+ERx9LGyaIZEDWYTNbjN5qvZuVjN0XflzcnAKxhz8+v1QWRpTG1uKR8i8ABwuHNbUpsJk3NrbELZcpTapH2pvqeTvMFU9c0kesdbrJx/IIhta4SZszJyjlX0so5owlQexEXpKzGZ7YrzPSqng1T3xJ3XJhMRLJsG7mwkJfCAx3cdPYnV9jtGd3mzIXdCpyV8jtKEOGNjOimwfClLIvV2SdA7f5VmHZKBPumNxPRTm/yeSqv7GlPWX87Q0MTPM7Zfa42E3aUC9F0W2gCh7KC3md5mLb+7/kzWjYRytVNw5bfdPrJT73btlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttyYOm2eSxRJ3GIjh624NWuMweJOKH/PW8kDWskfvzM=;
 b=oJxjJ2z2KirXub2VR08ZOyN38118zzN4iL2HzHo88KWVO3g9NuDb/ffnafYneX5RxU1pmuPNMc7+HSyJAPtjC4hVJnv6t67BIN3CKh+rd8jAba0aG+15Z24JavY9MM3c9jKHPPcSjkPAtZCG15Ih7E+TAFEw/+xQEbyJbsD7kbjF3WlDKGAmKpKIRLAnCWJJvfQkVoPCzMvm69X5v+cQ8TekXrpRQvDxxeXI7qiRA7riL9OY1X2Ias478LQ6nnrkUPU7lZ4K9TpIjA5gsNJa/JUscKDaQbOC+xyKx5gRTryRljTKGrXpWCDy8Ga94nSSSg7Ee6dEwsAb/0RUUfmQgg==
Received: from BY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:a03:167::37)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 14:47:35 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::7e) by BY5PR17CA0060.outlook.office365.com
 (2603:10b6:a03:167::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Fri, 6 Sep 2024 14:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:47:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:47:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:47:21 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:47:07 -0700
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
Subject: [PATCH net-next 04/16] amd-xgbe: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:20 +0300
Message-ID: <20240906144632.404651-5-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: c93a0104-f471-48a3-fc9e-08dcce82d81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q6R2L3P4T3KBE0kvwXN0OstX4AaXgB1egNprZxsKilpNTnV/g6hHDkl0BSsR?=
 =?us-ascii?Q?gYK3J3mHUKLiLl9htvdCobr7avNGj7anpOvxpR5Jk6ThJdZrTWg8FDA6co6s?=
 =?us-ascii?Q?g77fiXwXKG/kxvC6DhPrx9fwQsSrSgAi+bTLtdwHZ7oZT2+YxMTsQtFxVawQ?=
 =?us-ascii?Q?DKR0yvMVFP9moBJAQbTdh9ESYu+zxSAw/5eui07/6gADbXMd3qe8D8nYj9HK?=
 =?us-ascii?Q?uwns/cOUGXfQHY1Q/3SxEUKCO4arJRpzqJQNJj9TPe0c04ZGwk9JQDZyGZvt?=
 =?us-ascii?Q?fyTPBePQMwgRu/pjde/cvK5N84vI4YELnZUGRDQXOlXotszqHOsxPuobxfLO?=
 =?us-ascii?Q?D8PdbOCUeSQ7fgJAwwNAoW9oTu+UmIr8EcxS0JsYIEdejC4A9xCrqxwVyyTz?=
 =?us-ascii?Q?zKOChVdkuboDBNHGsI1HbiKqC+Pv3DpDHVJvCEo7+M60H7ZNHfoclu9bh/aN?=
 =?us-ascii?Q?ke9fDwFjxFleWH79+Uj4yqWo9gPXqmA+sL7Uq6sRdmIEkF4irCFJ3/LGtvms?=
 =?us-ascii?Q?5yFy1lf/44s4/433t5dFlWtXL7tCJwwPAdam6rdgAkGCgzWrh7ZJKYQv0qcs?=
 =?us-ascii?Q?TByLip+bFGT11jO1/FrZFqePw+XOdWqK1KP4olrlBGPj3mpwLOsOhWVXfzzO?=
 =?us-ascii?Q?84273ZT5P0Y9A308UODULmu7MgOVa1ddRIs9GcEu4SY2BdZ5PXxe5ZyLcQNs?=
 =?us-ascii?Q?mepTxFXig3fk6pQIvvpWoD79271QOYfdCNxJwevt+WqZbYlTXkDSnWiZ/m3T?=
 =?us-ascii?Q?NGlIYLegkqQLd6NPldHZOU9xcnKo6JQmUAw+dd1mgdhdvMoZVh5ozjDaWClC?=
 =?us-ascii?Q?560n4bE2TN/m8ZvBBOibGkESiCZfc6vDhwy0IjTmszLFR5c9cewZeM2qhOvX?=
 =?us-ascii?Q?8gc9aURcX+cLL02nTYEbPC6KmTN0WwVa2p173WA5WvrFvZsxOqAUQ2u5tc57?=
 =?us-ascii?Q?b3Y73UEhz1STvB4sfQNViASplRllXlYPqByHlh5mj7sUV6I0wABgtQ9xBo+k?=
 =?us-ascii?Q?qdMlBa09VAqFjTZ16rBkM9ToNp9Lw3EFdIG6RBzIHpaAIyC0kHhC5sQs/Ysc?=
 =?us-ascii?Q?N+Ml7Ex9quKmFFTgBP7A0D83FjGLh68PjBLEPrnNmaeN4dusShDLOEAmWWKo?=
 =?us-ascii?Q?FZtrbJfcE9lLxkFLe6EwAxc55xyXbfVX6QxMiXyv9rLXivkTzAQae33nU9UN?=
 =?us-ascii?Q?BLtmfi/NroWx3S8WxIQO/+2aQ6uKBI7B3OvG/jpPYEYvtLmUhQAO6OCJ58d7?=
 =?us-ascii?Q?fOfG77CdHODZPnO0Y+fI4xiS5dc/fxQR8Isn1nxYiTxrotWTcT4cLVYQkX1R?=
 =?us-ascii?Q?KF0Evzs090W+qANcf8sl6NrteW3Py/iJKEbyjDmKhvwlgxiVWxAE0yi/Tiy7?=
 =?us-ascii?Q?1pe2Ly/V1YGYdUms5zEXOYYnTlqL2HV4pBigGhuiovH14NVWZiFOQFlS2QSx?=
 =?us-ascii?Q?l2Hpf5lqbRuD0t8t0gh6bQhhT12yB62/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:47:34.5588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93a0104-f471-48a3-fc9e-08dcce82d81d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

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
-- 
2.40.1


