Return-Path: <netdev+bounces-125970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D180796F747
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8E81F25406
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB691CEAD5;
	Fri,  6 Sep 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UO89nxwH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C03E172BA9
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634014; cv=fail; b=foL9C0HfdMhDrb8RnyL4rXd2YSWbG+BneqzMkk1DYEYdOQV7PKuaEFWAlxXD1pXePpXu3wVMzMbwyE07mxcbAWbuyUggdi8o7Z/0nLSc1286stKBn+uQoBUJ64msrPV0x4C4Fn+tmioi6V+YcBHo87LtD/MeqkzVjvu+pe6/53o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634014; c=relaxed/simple;
	bh=j+GManABEN7r4mfD5PfdWI4XTqYt7ykCjxaaCQOvs0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XE5C0gk2Tonyc3IO/qPii3PVW3Mf/3Lo52abATa0fC+6hmdLgg3a77eHoA05bVT1IK4e+/8cARLwA1QD8ZQER5u1eiJuc7gwdNavyDquOfKHAoeClC9jJ0YINHC7P6WT1XaYMy88lOIpr9BM3zEOfROn2GxOPWg/NtnSLV/REbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UO89nxwH; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JytJdXtisFG7v7gR2v1mQlllAZ52MX3rHhgwghLH8802AwkVMkhtcE1WN20iBE+eUlJZS9mL2zTxyfMEaHAUoKYbgEHBHgMMxFoTMwQCNHEO+kCYy+lhaN4hwxeFID2RmugLSUY5lhbpIZzz8SDmtflXeK7YrzeQQh6olkISYJX71tEHJanKOb70BVPoatffLpY8LZOJcmciVl1rhXZl4nEZTnluvOlcBPXJCUebkC5UFQy03qoPd9Ky7Mve0s7RkoSqyOEoQZvf7h/XQZU+qDl1XOHmBRRQRl6/ItMPPYcq5A3H0bRqwm6FhYMov3FCWlIpNmlul75yfSEUoOPVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g80kLxFOhgBH7LFpOiuhI25Gb62tr7Hw0l9dq6crUDU=;
 b=rHGQP5YVuE4IFTr5T3odoJS/lf59WfyydJ+T058sJf1O5KR/wk+fFdT5kTWZxHEbyqgwm961krOnY/7rpOZBfj3M99eWCqeH9DLniDBOtYqI26SkPkz//U2D+GphBgWoyHMRSQPShv9zTIOEVOEiGAskfEg8XWGZ6//iZy0G7yIRVSJ2M2bBluR8CatEoj/5xTYLcfzMkBP8bXSlNNgvjOwe7aaqNLkHt6DjldKjjJY8Q4IRm6sYlNIn+uupVJc2DUf5vMIjAME7sKHQ41n1MSgah4x88b9UKG4LhqqFmkfTxkSU444+keEYchYUL8aXohvXzRbwRK/55TyAF3+62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g80kLxFOhgBH7LFpOiuhI25Gb62tr7Hw0l9dq6crUDU=;
 b=UO89nxwHRQWdJyq0H6DwXYlenJdGESThTxxYPAytaJ53AgSm7wcTqc8tNGlbzQlC+GMKg2Xg4D0xjOgTm8BXnHCAKn83fIEHctSde7jKDGjewjQQDR+1sET/gpxsfYGAsOAn1L7wiOWRRMmL+MJzZdSac278DyRYkCvWio0dIvGFNejYU4YyTzCawzSJV5PU2rLi96R+hhOjue7lVfcVGTKxobDxqpX44DmsH6bls3gc1F0KLefg5M1VPVgEcAa/ZnWfcsMYm6wvulspFG2SSJPS83VCSaScGrTjnX9cBV3gP9tvi/CJczg1houxbZWgfHbqXeEFe91P6Qe1Bu+3Jg==
Received: from BL1PR13CA0398.namprd13.prod.outlook.com (2603:10b6:208:2c2::13)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 14:46:48 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ec) by BL1PR13CA0398.outlook.office365.com
 (2603:10b6:208:2c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 14:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:46:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:46:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:46:37 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:46:22 -0700
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
Subject: [PATCH net-next 01/16] bnxt_en: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:17 +0300
Message-ID: <20240906144632.404651-2-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d8e9cc-059c-42de-98c0-08dcce82bc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yys75WxOquE1Cb/1MU9AUuCPV8WiCNXY26NQ8q60Kmj0/X9T752+hSnVp0Ds?=
 =?us-ascii?Q?s0QmwzvnLhf0AZnixDQPmNDp9AwacIiGr1XDCZOB6mLWTC2AZ1rcC4C3dVSo?=
 =?us-ascii?Q?HaC11jCbJe/uef1yTL4FTBzdrUECvFptVUaZLAMYVfxMkLozR8CSe3NyclGP?=
 =?us-ascii?Q?inl1dlo0BPPHOuuJ/U/0ULzE0BIv1oi9GUhuBpHoFeBDAjQHkvYvuNceook8?=
 =?us-ascii?Q?Fm3d0fofpMyeBkUDdvjeiJzNlz13lwSdFnV6MnkKrbZAsFREMtKP0Mceik/w?=
 =?us-ascii?Q?xk01bs67AE0MjHARBmhvFxBG2Uq/cxRVswWclSeDQGv4MUJ0hMQ9C94fU1jL?=
 =?us-ascii?Q?L9luIbNuEiEjzDsk7q49QQ4MusHXfJt/fxG+KATuhcSRqrAEdRZM28x1f6D7?=
 =?us-ascii?Q?REkQ2bz/AJyXntiz5ZJwj2X7wzl6klYzS6EH45NdcQfmxvKsTI26cuySyWrv?=
 =?us-ascii?Q?pZHeF/BcValDcc+j2YeL7Tl0uI2GZ5fbmu/kYShuFAsA3d8esQnLketkvQPl?=
 =?us-ascii?Q?hLcs1P74KMxInPqXYVxcjRm16v6JuChlHXYm0KoO9mCC5q3j+h+m9Oq4yHgG?=
 =?us-ascii?Q?Q//Gvkg8SBQx4yhQGcWEh3CKvhxWj/qTZpZnBwGJQkQV9ZGuysrtxmRfbfcR?=
 =?us-ascii?Q?1DeuFQo5L33dBBZ5fHF5gPf8QC+dBq0E4MAldYljhLgzyTbKZhRbKeb6ur5N?=
 =?us-ascii?Q?Rt5G1kv44h3GAx48XbE18UYeXwASKjA0MqFxwd2YQHM3xNFG9rX3WLX/iPeE?=
 =?us-ascii?Q?U5OWumm2lIRKqNpmrlZgA1iKhdz5oPVhmZCQtj1oGdcnvDbLf/Zugq2J/0ga?=
 =?us-ascii?Q?nb6pby44aLGh6mMpL42QNgI4MCIB2sPy9IR7IsyDdHZy8SoJ0HuoF94vVZo3?=
 =?us-ascii?Q?zMNtzf4ftD9A95Cjrz2w147iVxBgy/gE4d06Ef7+gnvv55U792X9iH7Gzg0d?=
 =?us-ascii?Q?vr/nt5/QwzdfrxxttH0Fz1IZoMCn/MriKgyx/v4XfV7dnMJ8vrZ9JwL/luqX?=
 =?us-ascii?Q?24M+s4xkAV5/r28btC6YO16yEAGWX5uYg5TLDxOWsbqAnbA/W41E3PWodJRz?=
 =?us-ascii?Q?yfHOBeYyTdc87phGm+7cusfbMfmQRm6lmlkFLy5hKKmlrwynnDZWsX51U3PY?=
 =?us-ascii?Q?Il5amUsFCZBh631O5k5suAZ04dMF5m7oa3zWB8G3PB0qFClm9ugAU2OjiUYn?=
 =?us-ascii?Q?/+8QefjD277Cd9AWL3bd1fMkqptv6BdcE2/GCtOh6TWM2LIN4KcCw+aB2VrX?=
 =?us-ascii?Q?ZVppfQxBdU1DtHecr2bHr84WHtEA3yAFlN/JC1lsTQwUAJFi+yS0dTSJOeAJ?=
 =?us-ascii?Q?j6Zd1zZSy75hmRyD4qRGRp2yxnhSyvYED5baAZyXhmesocwbZyhw3qtKGDk4?=
 =?us-ascii?Q?vzfS7Iq51u5adFTdaJTknwUDp3S16vcA9/uSdisRIxFx07GF7cWj8kOLVo9M?=
 =?us-ascii?Q?DhUclobuAcG5TTgSjhGVODph0+vvphjy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:46:47.4323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d8e9cc-059c-42de-98c0-08dcce82bc10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

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
 
-- 
2.40.1


