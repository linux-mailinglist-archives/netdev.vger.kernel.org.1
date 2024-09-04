Return-Path: <netdev+bounces-124849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D996B37B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B591F26368
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5431527A7;
	Wed,  4 Sep 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QItsHlxP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01116EC19
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436276; cv=fail; b=EIr4tyzxWPa+coqAcvG0MOx+gDuM5SXkLsbfFXoAq5V8dJPfEn+oPVFfMa2QfzzrxjcasS5PXOu4b37pyUDboF09vBcvzkuO3v22ivmdfvRNIqf29Sa7uuC6NAaI3uR+YUDa8BNrzBGt+8RtFQLNLlysrfBFDcXBxZVW0YJWDjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436276; c=relaxed/simple;
	bh=BxeF7pTDqZ3F6e2TyVHtgfeJD8031exN6a+1776WJKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHshNpvU3imdZPf7O5x7DcqKeD7UL4Rhkjws6AvSMMJQkUXHtKSXfynCOBM9exf3M2W3fTc7nzNbEYGxqEBBx+TdE/EMOZVz9oF8CttxP1XY+VW2Jg+KhBrXhVChz38HCtRcs94Dyi+eP1UQj9Wi5j7CX9nQbxx3ocM7G6RDgho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QItsHlxP; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhMVbC+1yM1/194ypvb/vfeoLo74syx5lj+8oPTHrdc2Fa0efPLaZu7d6BY+WGyRRSxee2YtQ1e1lIIA9E9M1ke0iApLbiyoIaKzE+3b/JPgOm4JzvsgpIjXZhkqP8YSkJxIfuRlIPfbeiS5WFbel+uazf7d3TtR2ksqNRr9xg4VKZdiTE9BIQyyUeBJaK+Fq8ZS2GOW50PFGB9hq0/doEbJOFKYWv+/aGfnZsJrRNErWuX1dDAMrFzXITy9p/a9qIzp3IZJHzR/3/ETTvfE3LRRBTBGLIg/MTWsq4owwfnazFgJtPAy6MxdmeUxGiGSOraKUEwvs1KmEOtAKICw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ht3UrsNE8xl9RD2EUy/+sNjQXWO2vyXZvfYYXDZyG9Y=;
 b=xj+yXs7f5g520h0QXDawF459AD9i4aLjvXXma4x+qivz9pifWWNr1LBJmwsIfRAbLNmGgzsBosMWe0KYE0fmY7iiYSYsu2FXyGMuEZG+8ugtbildbh7zAo6zUojcpnPzoxbVqrhp5LbRVRwKqx33SiO8GdUBf+YdKrt+Z+NY7+cZp4TPLrDrrj9uoTI1deJwKhc83ITLTbLXFrPa6pewi9wiilP1cCGlQSq8S6NqUi4qMTbavS6cSj9w72+mgF9oOQ7SSm/ylUPXWbZ/xqfowcdRyzMHHC4W9tFCQ7Lx7S6e3AmXCHWopuvIcZj4Bt+UVLlLAVpDjtxSLQHpxmLR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht3UrsNE8xl9RD2EUy/+sNjQXWO2vyXZvfYYXDZyG9Y=;
 b=QItsHlxPHBtfSZoFJXy8GLJrY/XuLfJFbQXud1OSwxKK6exwUI97IGckkt3LzKMWq7pEu/ZzMX02+qypRAzAVxGrQaQfXh6o86h6u9506qC8rv0wCdAsTbbBY8mBLyRdpVy/6Uz20qSv+tvNG3nRcdmh5soKtdeLYN4grjHRJ7vJIrlMeD0k1vEoHTFJ99ERHRHaxHN/PLNv+GIb6mNEU1FGYRbUU4GzbaCj4XiMglRHPyFrIsDZ791zYN3ckK/1VhfcuoeliWsX0tR57AFdTIJr42z71pz3rbb1GAK8AaJy43zNGqBNzBqnFRp2JVvlhCi0VSUc34O7SAAiap6FsA==
Received: from CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::11)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:51:10 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:ef:cafe::9d) by CH0P220CA0021.outlook.office365.com
 (2603:10b6:610:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Wed, 4 Sep 2024 07:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 07:51:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:50:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:50:57 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:50:44 -0700
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
Subject: [PATCH net-next 07/15] net: ti: icssg-prueth: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:14 +0300
Message-ID: <20240904074922.256275-8-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcc8184-b245-42f7-8575-08dcccb6576c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EG8d8d2yOPHaEi9wqa2Vq6ZJ2Xf0tWGgTjBIVWwHEVXnza06BH6zEQZqa319?=
 =?us-ascii?Q?SiAg8zacRsjCpPiD629v18TvQehMblP08CGu4lOwUfi6y5D4tF1rnPjSXAwv?=
 =?us-ascii?Q?gzr9iB/X+A9O7FuOWDyP8OcPXbONo9lK9nrOOXuPRaPWDnmVChmFsrKzWdpy?=
 =?us-ascii?Q?W0v1M6T61Q4ncOYWODasoIlz4hguwTo2GBJYbfvURZu4m+CPdSBTQALhH+Js?=
 =?us-ascii?Q?XBaeDImdoSQZprN30fgFyN974SjU2hqTUhVht794JJzom/FzIxicEPkSkxD6?=
 =?us-ascii?Q?ZtFAA7F8rT8B6on8z0k/Sr7gjSt/0AjJbpv3IFQ1K4wY5Ft5AsOdqpDW64vF?=
 =?us-ascii?Q?30YMWiB5Y6he4u6FdckquKOV5/LD84f5m1Ey38SnXW0zHQhtasN0C/hH+ZE4?=
 =?us-ascii?Q?xQb2eUuFF7+WGaDsLb4iwMcFMOUYR21RECo/uK1ae+eUGP7ry0wnU53ri8wI?=
 =?us-ascii?Q?LOFZc5h4t5CeAF2Jysj2Ho4AuvLy1Znkm7/z+dyUF/WXWgDU5qS6uVfCdtXb?=
 =?us-ascii?Q?FJaYjBZKulJq9umZCn8j/lH827yCK5PxZYEY9jlum0XaApm0CxYkj2ZonBU0?=
 =?us-ascii?Q?qhkWvu5YL/NYB7gjNQhxvTgQwVh+BDJFV+3Cud2HobThHIPKdUXN+CHfOcqi?=
 =?us-ascii?Q?4yDV8FlbdpDZv7BwUeK570g/VhYKu5boxQUu9Iq0fJO/61wmFLirvU3hIkvf?=
 =?us-ascii?Q?Z0ivHW7l4E7PSPl0hnbzpPIg7ON+/cyzaLxiC9jJSVloY1fNLEi03bpOoi8L?=
 =?us-ascii?Q?7J5ccWgbA//9OeZ6iTa3aJlxoy19ugz7sgUTUOP/mz5tycJu5U5/AngMis3s?=
 =?us-ascii?Q?L0TfRXBdO+a4cH9joLyng6XpdaYU65kQxzbq79IQg+rWeUAfghtF/dFMTOwC?=
 =?us-ascii?Q?Aq4zGzBdugOCLJ+t6RwCYTt8KseHoO7/38lwuuvYCCqJEquIEZTAzyKNy7UT?=
 =?us-ascii?Q?SW+vY3z5xzFS5X7X2AC2SMt7iDv2K7K+AdGMEW0uDsaTEHMHch1fqru8Mrgm?=
 =?us-ascii?Q?3+kSszwAES1RJh8GkCVpOxESxkeZdOJRNkyiy8nVeESuufEXeBaYkJRKub5q?=
 =?us-ascii?Q?RID60Mgu47nh8OgMSbJGAZPdSEFqKFkWintLu4aDJscT/jd9pkZkcGX8/EXm?=
 =?us-ascii?Q?wxqO8RAYupkjD04jP9huep2CQIF0ixYOpENtcbeFYSq6hWK+U9FkM+VNfXYK?=
 =?us-ascii?Q?oDUTrfo3sP2Ix4kQwvh3xiLCI5SJMSHkMxQOrLu+2vUvusqt3g0ySYlu4Aaq?=
 =?us-ascii?Q?s31NcT1atQmAtsm3O2zMT/0uJ4cn5wQPL59t3oXFrz7JSWlVMA8Kmy++J6s6?=
 =?us-ascii?Q?poJrfojJqiYvizy5MIkVL2idkiTWQJZGRY5UA9XG9+9o5wHBcK8qlmwqt/zc?=
 =?us-ascii?Q?vB+fPeGO2iVm4ix+84Ex4dPvyr1mRY5o2GH3Of+jIgfcJkRJHWGsLZvcKaWB?=
 =?us-ascii?Q?My1d8lf8ArTnu+h6XODLQaMe/XJKTneo?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:51:10.1361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcc8184-b245-42f7-8575-08dcccb6576c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.40.1


