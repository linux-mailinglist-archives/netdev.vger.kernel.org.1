Return-Path: <netdev+bounces-124850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C955296B37D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544B8284221
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010941527AC;
	Wed,  4 Sep 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h4gEwV9I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAD154445
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436286; cv=fail; b=PYQS3a8KVQxED54No29hd895wK9c7fSYBclvZDGuaZDKMcyEFVFarPEIKF/kqHXNeIi28o6JmWZ/s13/mgOQs1PcnVqqxeeaC85PPiobKTCWUhDnOCaOimtGD55tU+CLebazvAkyAf/y9Y/v01kqxbRqgefpLiBspcBMlrPkipY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436286; c=relaxed/simple;
	bh=41TGnhZBSDZ9XhyIDz9YCqf+7ify7JoBLduz7Z8oXq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShC2pqLhxVsY5gDKcmSfv/ZBhNQ02/mWpb7uvztYFp9tZdpGnyKnrNWV+RbVTSCdAgnnnkU9bhK81URClZknRm+9CyHa1NQTu8cOp5TuURlJgwboGS03stxv2qsOXv6IBSIbWGT1tpy5HgNBV9a3Gw+LlQtA6JNbNpfV6RXAuTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h4gEwV9I; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUtCPWkBNE0xnT8sNgLcII8ebjYkEnKaaPxvA20KEPvpiFZjb7J+cx8S5WoijYCajfF8R7LIz/CAEQIsHUAjO4GWKw4BhX/owR4t18TaKpabakd6Fw16Y7VoN6HzLBiMMtA6q37vmz+lXbO4FNhBkUoFKnl4hrYPFetJ+FrdQY7jtm+K2V0UK/F49Qwr5/qZnySnUj1pjCBUmY7sHWWy1EbhbBMuIShWSHeL/2aLsUnen/NfllAcydtPO6IFc1Ldu3+Zp9VNHjgTWHthlbi7BI3o3YvS6uFl1cVohqhmpiIDV89zrpvGM55GV0E/XhIH69GJAQSUapFcWk9/vjgk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gvl+4m5GNwOH+wjaElc5iMVuEPHOVHCG+JXafE1hWI=;
 b=dtv8jypsQKhMS+w8rIS1+4S6YpUtV9WqYJuzKRbJuPMuENEEWIuDpCH7eycOoecaw0bbxeKFtEwUHB2Or+qpbrBMB/chGnjty2KP0gw3Kd/GwwKtaO4bfHGvuYsGElZmAL6nlABt/MXOsmOAiTEFO9sUxTZjBn9dGJhhdwkpaAK4e1OA1PhorxBovsbtrQX+qPZmKYhSMU1kiiuU1iS/gf9+aunrqMBGnAYTDrOLMwEhwEw4yZ7A0qiSwg2nRNdmS5sFYwy94r9fxeQWXSBbEBNnE420WVhMA2NB91Zq4gOw117gB4rZS+4rZDUVnzNf+E9gOwVP7uGQ9uTK+ZfE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Gvl+4m5GNwOH+wjaElc5iMVuEPHOVHCG+JXafE1hWI=;
 b=h4gEwV9I9AaUzsuPjT/3+eKp9hInblObHOUm2w80N+Rv81tOyDlC/1McvnprOUE4gpOt4C7IM+xhI8P/n+uC+0egD/uZkBEl8Nf1di2XEAcJefRszoWhrB7OX5GdApnxixHEjmfPlrEr6qvArtJ/XEz0b1tTvqsnp9JemtHz1SXM5q2YTcxHNajuckPhvIZKDVdeC5YKfTPd2Z5wDwR7XuqKw+3DG6AD8mAuKWxyYhfJAC5kXS2uIyEF/AnNpt08bq9I/pq7LM3U5Cqmo20nMzzpvrSEsl7NwcXxsht/Rk0X+XQzh6C7FqjcEDYHynRPZflnYF51XrOhRtJLaw9wsg==
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:51:20 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::24) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 07:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:51:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:51:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:51:10 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:50:57 -0700
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
Subject: [PATCH net-next 08/15] net: netcp: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:15 +0300
Message-ID: <20240904074922.256275-9-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1ce4bf-3a5d-4bf6-fab1-08dcccb65d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ITtIaF1iSQaMsOXywNkCQ4yDuTJNIyEULlDxBzl0a55lT0IyKCBNt58keRlY?=
 =?us-ascii?Q?hMvHkEGiA6Mq8v9IfNQUKRVGjHzLaOrXMMZ7KWpglez2Tq1z5UEP6aTQcQoD?=
 =?us-ascii?Q?7Pbz5gdda4tlkp8kCUY+mgEc0cIwIGI0bYav7JPxU1MtzS2w281vkZDhtHfd?=
 =?us-ascii?Q?Xr7NVLOrFVDHECtOUxQ3ecAG5Dz4ywJ1W83QC0I78Hr6QsVJHlAoyr2+w5Ej?=
 =?us-ascii?Q?VNWrNI2EnArn5Hydmqg+yM5xL7DecPYPlwO/qdlR8GfiFxDjIZunNF6DPoK/?=
 =?us-ascii?Q?Pdhtomke80ax2UCvH6HK5+Hai4P34z6TTyOzkATUmBg6Wsn1ijqgxFSAKIze?=
 =?us-ascii?Q?n+Te2r1iPSkXL5RdexSYcuu5JZdj8stsm1Os09KHDHFQJNHxi5kP8AVIdGGz?=
 =?us-ascii?Q?DP1OBuHQOXuH8Wr4sjaICvCuvsTY/F8cvdUmARWhkZ7BDLZC717Ts0t7ENx5?=
 =?us-ascii?Q?WPVI0HZ5wq+/IecTzBGuFBjQu5fQ6KdOrVIbaxxnwhyf0uA1YAKRElCToTZp?=
 =?us-ascii?Q?B9HmRXUeiFESkjN+cPr3LkCmuR4Hg96up/9jhI+6ZixiBno85v0BvuDFqziX?=
 =?us-ascii?Q?9AmnB8VLr0jtdE3IdPJygEMnpS7NxSMSlIgJuWHUgjSU5nZOtftKNoXYyn5B?=
 =?us-ascii?Q?AC91r99xF04MhKL7f994lrp+Hhk4UwBo7niQcunurMIDy7DaWNzvZ38G3yAk?=
 =?us-ascii?Q?8lWB2q0bkj68h5OH+S7qwIzUkGtC55nf1jkmlX3NZgySEAiTk23G+RhR63aW?=
 =?us-ascii?Q?9qaPiCZa2NSpDpytIYeGE2zbRRqt9RyGHXVLt5Kuqlu40hLfpJ0vqai2xMv/?=
 =?us-ascii?Q?mFNBC5vdAILK1T30zIFx1iqvgwjMH1ctfr8+hYuD9aZ6UyVtLDNU9uKSABMu?=
 =?us-ascii?Q?9nKc9u+GytDZrFyfl64AjUxDnOwQ8EVtL9l0fWkeR7shux8lADImmuf6u0Ma?=
 =?us-ascii?Q?kXDqOo3/mXWMAcTd/yKDpTn7xz08aJpsWTuyl+mofNkNjMPdJD2Tdu8a8LWu?=
 =?us-ascii?Q?2WSg8S3kKc5kjdKoZRZh0pmRZsoIBODyamjbR30uj8oDNrFIrD+c40Z4mvjg?=
 =?us-ascii?Q?mcDHW6/W8DaUOKpmwvDwUmbzSUVlSP8tm0f1SB3b+fPcX8g6dGT3gznLQrfT?=
 =?us-ascii?Q?hGTvPYzyc1VG/uXvlha5YNGWv6udZplE2eLYFI20oVO0a0uXuWi/wC46qyKh?=
 =?us-ascii?Q?1bMB6ZLzsZKTI5W9VLNsyv3Gr7Tmq5GqDBHGAF1HAOP4nKVmSlxAp2fhQiBl?=
 =?us-ascii?Q?Qy/BDkhIV6rpy20RVn8cy89aaxvBwC/SIYKOcKkamypiMSVEfmjMMRasPv2m?=
 =?us-ascii?Q?m0EVq30dg3faZQ9w6t60NDGyEQ08VpKoLttDi/5TnC6hYlQFNe2G9RqaSwOD?=
 =?us-ascii?Q?fZyiv2zK2CaK//U3XD918hIQVIw3jZkL8OMQ714yFcBe+xC+IVUDtLMKNOgq?=
 =?us-ascii?Q?W6Hmiw3ZQwLfRmmEOO+iBmIk9exmHIk0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:51:19.8974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1ce4bf-3a5d-4bf6-fab1-08dcccb65d3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

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
-- 
2.40.1


