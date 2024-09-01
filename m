Return-Path: <netdev+bounces-124035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4566196763E
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BFD28232A
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319C165F11;
	Sun,  1 Sep 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HOwgvkLe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646615C13A
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190288; cv=fail; b=moe7/Z+HYMZsX5rAHUIOr2x/AjWuvOVOOJPUDQznssTeugtYkI1lei8YpW4nofdRoEfa/EBzY9HhqksHdJ1KmZocCjD9iXZs39JrT3+vprXMWQJBkfhfEP6xmvjk6yVBQxNtgzHxmYigUlE2m/P93A93GgQPf7bw3RE/5Dd6MoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190288; c=relaxed/simple;
	bh=/aNTUfTpzEjPFAt76dBITLc19JHkqcm41YOeMhqpNJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3D1Vh0X6IyLgiYdGluj3Qyn5+XlQ+fYcsYriwcSeqEWTZbfvEqIlI4POEYGvFKgQHXxa6K41r6Y4kIAGbapjAu/wihhe2v7qeS7dmkUcwRErsDyVLEHi+Sq9H5S8f5Shj38ZYYooJg1ygss89XqHvzplkeshR8CDBUxojfhros=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HOwgvkLe; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3r0NvFgOZNXfiIqoNSONeplfUOlZxH2eSNQyrVFvRmIiJuLkzTK7BFeX8qr059cc3g19dPgY7LOdWE5akaa1AYBh4n1CBmrI3h8ictaKAd8TfRrKpksbU+OnvducJzsT/TxU3VicG5Jo/wWXeRlVNsr0RckfTdu1DbwmfANEq/q8G+8jMEP2yNItHd7m3TjWvkZ7OSq8iosT4F5TG3Lftb7mqwfIov6IboFFYtzHK7CqtCTFu3IlaKsDgMGNDmyrir7EcJfCBpY8P60GPHLQevbuuurHQRFsFakoBiKJrUHbZXPqfYSXHOaHwxRErYghm5is24e4jyQS9tPp0FLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LQgHaKsaVGL16YOjciDVSTCgYYWfvzbrLEzj4+P+rc=;
 b=PBBUI+f5saBQKea4BHZVgtEG4C4qg7wZV/L5zVowwkiH4k9bJooBwVs9y32mtcJfhWLdNqK1v6iWc6NRF/SF5lJKbk9/Xam+eeQEOvnar8YjbOS+Z5ZG78ouC5I1ynSseBuBbi+4aK7FeJa5iIK0UopH4H38DT5NoYx0+U6Ukc7jR3HuojI1ah0uEWp2pWyA8OhSulvfQ8jODQhCQQ6rehrVQHnLZzPQQgEJHa+tSoDE22X9L4Y0VWPaocZX/sT4b+3+ko7mQdejPyqsVClIOstsgVQBUZVkJuG7npA9ci66xEZBt8+Lr1ZncaEx6xC9a1N2jrjwzyZ5ao9786y0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LQgHaKsaVGL16YOjciDVSTCgYYWfvzbrLEzj4+P+rc=;
 b=HOwgvkLeuw8IKpl0xrCyH/yhk3LTujhUqJVthetVpJZNP7CELCo9D7HNkzAV2LGpPmX0Fx04hXYvQKbim1rT5N4cVYEn4b8amjPPpPGs/nBleUENfrWOoQyhHM8+s65TaGXyakPVKwFcKb3KHOzzZ310ZuvEsSfKY2g/dddJ3eH8ssNBLEqmP04aDQsb9P6RAJLNwwtGDpT0POJPqzfP9fHP73QQTRanzgzTFTQVVGXHAwn4tV2RbIOQEWT/m32wmMn0y+HRnCtNTEVGDYLsQI+13sjAXX+yzrrh6NYjGhh7vEX3XtSDDzJxNmEiBlmeyjBL7ysC0onKLqjTMgTvlQ==
Received: from BY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:a03:1b8::15)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:31:22 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::ba) by BY5PR17CA0002.outlook.office365.com
 (2603:10b6:a03:1b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:31:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:31:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:31:06 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:30:51 -0700
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
Subject: [PATCH net-next v2 13/15] gianfar: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:28:01 +0300
Message-ID: <20240901112803.212753-14-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240901112803.212753-1-gal@nvidia.com>
References: <20240901112803.212753-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: de46145f-4787-4096-3ea2-08dcca799abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x5A0xBZ4n9wXZ2dVzTiHeoU5k5JAI854Yfm43fuz9H8hzG8Rkhc5aA/pM4KP?=
 =?us-ascii?Q?MAuiuaDA2CSVj+cn8oyMWgQaj2GcRbuD23R+6x0EQitvs12AVVQl62cExI8K?=
 =?us-ascii?Q?BMv4gz9zQl6rylBAEKFqK0Vf/2EB3oeZW3RTYNWVZXCq81KwTzX4OrM4EGtk?=
 =?us-ascii?Q?32VmLyXMUUkbKGaFlviK0i/GMtxh+YN735UQho50nWQGyHiKQGXHuxfqzhzP?=
 =?us-ascii?Q?kWwldnN5st8G84jEzDxc2dqPth/YxwTTkRlqsUFO8m2QsQ69N5fRKNsw/gT/?=
 =?us-ascii?Q?lGdlDVS2Ot88gEBi/n4E9098PYNFEwzN8IhsGUjsi+y+v0CmesJOb1kE+s6a?=
 =?us-ascii?Q?ofuMzNlYsEtbq7aoTTQ/l6uEqcV/IZ9OoDhDhExbRMyBYpGFjR+IhlkmN1AF?=
 =?us-ascii?Q?ddDZSntsN9fGKS4ShzF6duY62f0gDH046qrOHfkaI5sSvTROCEjy55uxOAlA?=
 =?us-ascii?Q?TlCwxjYPSMEYHcGKu64i3HB7EpNZW89kWpDAA5YoTwxK2kmUZV0SYYqCkYwW?=
 =?us-ascii?Q?X4Qm1xzyAQAOialBH03Zl4ik2jAW+A/Eg+rkVp/iZAUrizFfqEDHKKdFUd5c?=
 =?us-ascii?Q?OeaLHdUacVow38blXxDYZ0+6gxO+yutglORP4JSNQRHSbVW7qMPzEuMAnodX?=
 =?us-ascii?Q?38OEiJpkvUD9jSP6MH0OVpP4KCA2qq2RMTZYh+FC3gYoDb/spV7vI0ZelPti?=
 =?us-ascii?Q?qjQM9XYpD7vgo0c9z6t9W4Pp26allhDRnVPbXZRRnIGIqDBNWxnfg8gh87Gm?=
 =?us-ascii?Q?tHYRhS8i9S3OVm8FCB6PpFI3vl1yE3eWxAalAyViDPaGPPInmDs8f4HQ14rw?=
 =?us-ascii?Q?DpD3TQKHfllmYNI2/PvEOEUdTfP9ZWDrUAmNR3OpcwjBJk9RF9sBff6FUDKs?=
 =?us-ascii?Q?G932g9OKqKAlMY64aJ1lJ9xa2rDcwgZZhklcC+tfrMX0yzMa796JZyOmAYlW?=
 =?us-ascii?Q?6W2Mt78xtmTRbQ/oOi8kRbbYn7DUszNdheUQRGUPrLtnCPjNT79FDszS5rEJ?=
 =?us-ascii?Q?FUH5yQTEGRIDvD45WMotns/mSKBKmaM2q9ztci+2iU+NQJ675eFPcA1zg4nQ?=
 =?us-ascii?Q?ZsZ01zAiR76hD1bx7tYJTSdv3oTsALCfER2NrtnW8jdRmB3oIuM422o2ib6o?=
 =?us-ascii?Q?CgwDxncHqt6GCbWuoqU9i2/14X7wRMdsYEN5OKcg8iMW3vgdUwaKcW+98eFo?=
 =?us-ascii?Q?8JAlYnhMCxMxLIL5QAG3XdHU37xHDKiA0XuUAui8hfg9vJiYhq3os6c1Jj3I?=
 =?us-ascii?Q?qA3dXZK9vyOG8raDt9P0rxEYSpVhGUEi4F5Sx1xPMmZ2iy2iESoNu2chrY1M?=
 =?us-ascii?Q?6HuE2XtK/QD+J4kjg87p9Ye9kUzrhx/7ow0xLu3Gb2OAaJP/ZkPzZT3KK+Y7?=
 =?us-ascii?Q?cLKu0CgDCxt84GgjHvrLxiBJyACwof80vLY71bZ5CMUZEcdp8TKtnwvT/81o?=
 =?us-ascii?Q?O/gJ8J9KbnZlmLHlsQxjdfzZswiXm5yV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:31:21.4555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de46145f-4787-4096-3ea2-08dcca799abc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/freescale/gianfar_ethtool.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

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
-- 
2.40.1


