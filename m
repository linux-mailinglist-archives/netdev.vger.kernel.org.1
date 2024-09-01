Return-Path: <netdev+bounces-124036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AF896763F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C651C20AFC
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1A816C695;
	Sun,  1 Sep 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k1W2BM55"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36221350
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190295; cv=fail; b=BYxd0xnI4by+sBhHraZtlHiky/Aw4HaSFGdODCI8TAzSKJDXVsN3iETzO+4OP5ZOBkgBs+/TQ7ini/YKDq7oVYl6dhGq9sbc02sO+1mwDph4TcAr1cqD57wrqw+cr++xDyMCFZhC4cQq6hghaREpPhqwa2kmWhXyUTY3z6s60Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190295; c=relaxed/simple;
	bh=o4QCUJ/gh8s1CLGKa6X96eptN1mrsI8QD+5zZYTg2qs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZrXSmtrGg1QNWF60eliPpMOfR3rCKqQSuiOO1S7gReEkwtQQ7M7NYZ+IE5a/N+M46Xs0RgUiImlKl9Lqn5cPSmAk7Z13j9MCUVV7sDWfpVVcHFyddJmCvH/oa+OM4v/lNIOMaWskEsimps38QGeAQ1ZlWwgaL5W4kwlty1s3lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k1W2BM55; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDdx55aSdctGDBWMy8tOG1JHm3j8Pz+Mx4j/Yu1rNNiqWBKzFZ8kvM9vsetW0WwS2SNmKGAhA9CLBSv0wI7WIDvvNVbXDSQk614aFJz1t675Y92cz2IoWaz9XDFDaTp8r/G2FDkhQFzV3Cvg77H3/VaBk6SQXVflhVwl+3tQb7p+AnKoL8P4LRRgbWbev5D0zJ7L7KKlBAaj1GQILljGCP3j8kbsyu/A07x4tdMRKxquVZHoI9W4iBijxg7NONl8mKUi4swfBs/Z0HVmI2wL7BX1/gOIAA4hSdEYirxVGaI4GaoRrGvbIJd/V5PXbUmJVWEuwAHL+gNwy0Rp0EjQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMOFvZx8e7A7WjfLzthoMRwholUb8610O9Yt1jvuZFw=;
 b=j4ieTxmASTom1GqyCe/MUhLSDXNYTyUe/fD9lem3JIq43GRB6dy7/AyqgtYD/8HQEFbcEh1CuiEeusaIVoxDmTCAUud0ROHlXG7c5u1twWtjPRLRjCsFAJ5q/d81nSBwWNvzkk6gUobDsgfOZETpvgxmOcrO6dkZ3PbhI15bVxcE/z/eESJGHH43OXhZzd6gN4vx5DTzzc4OZxTPlL1xaBpMJEb+3U4gyzUl/esieGsAOOdfYX+B2HUhUYbLLQZex+UrJ7UpvNyQ6jfnbuoWrFMmztLHrkmUzGHtMf2TadVWjX2ag9B9h65UdZffFM5fpuwvK3uAo8J772uMEZJpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMOFvZx8e7A7WjfLzthoMRwholUb8610O9Yt1jvuZFw=;
 b=k1W2BM558wxCGJezTfVvo7RC0w2pn/yG7RB/pv8YrcRp8lOGGPt6Yy3qUba/JDve1O7VR0vmMkjGBWrcsLP1CnR8FpVbgQ3KiKXmjjsiHUQ6jcryF9oKO7vZkz2TKFE91uWyZaCetkzQzD9E7QsEinh25K80FgLP7FibmpOegdWSUI7GjPc1+Sp2YRpxZJfk0EjEsmG4ws97b0SJjKB4163KQKZiS2pbFL3h9gKPwUyDp7KCtIqhIGsYWufQ15wAJWFDtft3Wall8h44q+Dd9nVnjhJoWV3Ojl7q99E/+7A9JsqVlO4g2T0txrNNQHaZX2X+pU188n8Zb+bzfotHlw==
Received: from CY5PR19CA0055.namprd19.prod.outlook.com (2603:10b6:930:1a::32)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:31:29 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::cd) by CY5PR19CA0055.outlook.office365.com
 (2603:10b6:930:1a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:31:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:31:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:31:20 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:31:06 -0700
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
Subject: [PATCH net-next v2 14/15] octeontx2-pf: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:28:02 +0300
Message-ID: <20240901112803.212753-15-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf7bd49-316e-4718-8231-08dcca799ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jv6TRyzFMgWnOEUOVxPz9wAXZ5AYkOaErDkxm9it3xKfpI0LPk64tP2ERIE3?=
 =?us-ascii?Q?+kEtAE6oxvLZPndIQlwUN35lUAQSdV1RAcVJFew5PiFfw0VLoiatNDZMgnCm?=
 =?us-ascii?Q?9ViQPVbvjjo/4Rh7JN4tPxScNSRL+8gyDir23jWwUJwm2cPZJ/e4L/AMKp1b?=
 =?us-ascii?Q?7s1PiAGJXrZnxA/Sw4vH5pSbjlxp2qLoOiXLHtMwBXGlK/Z2RvdLOpcjThLC?=
 =?us-ascii?Q?iL3BTW9PyN0j8GlOVUyPQ+xpwd5W6E1JirCavLCWaQTNYfeYd+BppC58tjdj?=
 =?us-ascii?Q?N9eXxEYui3ERXBGeb8ZnWZqjqBCrGnsBMsXq/Gn3rr44V7GBm/zVqVFLuVRT?=
 =?us-ascii?Q?2fVsTzlVbD6dbpdYrB88vOY8GTm0HjTgQ3UJS5BGY9oavBTWaajA6kXR/oXo?=
 =?us-ascii?Q?gS9TTaXEo9qNiEV9Q16kGhDD+LVh7jE9VvVjJM7DvWOswpjiWDIfxLzyRFIS?=
 =?us-ascii?Q?jFWQhEjrOhukcUJxboeo8CtnHO4/Z6ZL2UreaoZ4FQG9CGo2qc2gtFDZpn0b?=
 =?us-ascii?Q?n+F1ZaEQB4zP2H4+uWT1w3VddcXJdnGUj3R03PRfvc9KqrBVnSwr0ZcaZSsO?=
 =?us-ascii?Q?uF1omKyCQkEfGRdz5AoABWEVV+7hTxCubYrQoqsa56N26joGGHVq0yAPzs9Z?=
 =?us-ascii?Q?ukMHkInpayNQxGiNu2ESzHjW2tHgS2Btf4cXaGEAWq7F+cnzsutCgJwA3N8y?=
 =?us-ascii?Q?GH3Hpwh/MgAnbLS8p0PO8MkrlgMAbq3IZE6aPo46HGGlI3o0DiCMoAJXwKtm?=
 =?us-ascii?Q?SnrFiSMmGAsRT/noQ1+MhpZfV0Kmr/soIHdzcLoOW4n/OFfNO7wMo4DCZEYd?=
 =?us-ascii?Q?DdOZHqAi9VVjp5afbyEpqBkM3lECIwZx4Y9q2oSioya5v/rM931v8eS3LwgF?=
 =?us-ascii?Q?7LexqFTX14PR1ULTIEX76KW3l9JiK2a8gWczMpFCbPDrku3bRdd/Q2P/tQ3L?=
 =?us-ascii?Q?uTvXH2k9vSY+kzfo2g1kzWyBSifbjdaexkMo1NIiQLbNTSluM0491b+Od6G3?=
 =?us-ascii?Q?aTMUI6DYgq3/0YfAW/wgGZR3cfER9tYiY9rC5SNGleSXhOOtDOmhGj6+kyLb?=
 =?us-ascii?Q?wOfLEVo5PcimQmnXC1ytKY4fWRcnf744tg7NKX2yNdCZWwVkQ2P2mc+L8QWa?=
 =?us-ascii?Q?8e0acm2/yiK3LL5K9FewSQZ6gK812VDy9/6TAPs7gtG0iNadBryZr2I4+nbY?=
 =?us-ascii?Q?1PjeP2r2mdgBvijAt4EPAXd3/VRhP0S+wci9/3wx58hvLeNhoZ9Qemyz+SVJ?=
 =?us-ascii?Q?AbQajD2U6DFxTZTFj+FhWwzHdzEEguPCZmobn6mzRybaHxRDMub+Z/JKNYx5?=
 =?us-ascii?Q?RO8kIxtChOwODU8jm1V063trofM0D7oXteRFT6pVc0AqmGprBYN/QrnHEW9l?=
 =?us-ascii?Q?TqQh+zgi7dW+5gLQAFyDCBrYYLJ6BybuAdvljl14yI3i7OHorcsUa2aYahgc?=
 =?us-ascii?Q?RHwbgN3O5qW1qHMWSrXYVjt1ciB77UoE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:31:28.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf7bd49-316e-4718-8231-08dcca799ec4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 0db62eb0dab3..32468c663605 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -962,8 +962,6 @@ static int otx2_get_ts_info(struct net_device *netdev,
 		return ethtool_op_get_ts_info(netdev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


