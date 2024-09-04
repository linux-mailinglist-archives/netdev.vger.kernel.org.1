Return-Path: <netdev+bounces-124856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5596B38A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A85B27843
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31717BEB9;
	Wed,  4 Sep 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WENv5/ex"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31717B4E5
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436334; cv=fail; b=XJhgCTJef6rdjirYTUo7TJWWgB0sD27uD4lxifwZSlTAoM0bB2KXmlf/um0wsZc2x7xbejX/gQUXR3t/R5r7sCR1poi/Tw4BpRzkoVcDfdZOMA4LlznYpoLeiCzAEw7qI0dSFo4GULzJxyAZRwZAF68n4/l4UmgZ9yxckYSpk0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436334; c=relaxed/simple;
	bh=KyJY+GiWAZJZTD9wQrAFBcUNjxJmDmvlIzxW8hugW1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXfmxhMA4GN/+EEnDu4Oeiz3pINhSfQjOBLxh1Tt5AUWlGrXxZM8Nnw+kG5Auvl55Ft9NwFHdgTpHWNjIGKJ25KFPYSmsIr+zfKqcRPMthFIg8PmewKp4+BR1fv1we3QYWPlk+PnyrXYra7mhcySdlTMaP+O5scIfOcVI3fTk28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WENv5/ex; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT9KoeqeTjzo8WqQwM3S/dzSdi/mlX9g+xEgxdh/XeG0IiBF/H1rrazPUwQpHdk7ZjgQIL8MNv4tW411/Bg7PHLeU1TAbZFVB6FPNerGgtiKqzNFRb0QiXSDuqYJEPKvoa5e4heb5Nv16EInvzQ2rkZpwyk8X56f0nVEqT42dOLY4Zb0vgJrAOb/QTLW2J6VxBzN3vzJoB+HwVK8rcysMlrhtuoRT9fU9+3pQJjj2iTm5TIpkCBp714i3+AzcPrlhOYj9P6jsaHIKuoKTz+rJFpo6/OcWX+7g19b4bAR1KP+3pf63OaD6SCrtorsAhidl6mVR7ZjSVB5D1H9LTTnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyqPveLGPpJ4tnFE1hM1TFaiU3FjTE/gOZV6pmhZ6Bs=;
 b=NDZD3oMASi/Fla3LlwxERd62mYzNar3qy+ndJ/MaYBVtee9gSpsRxrKAi0VwC0mWpjimwAt3TnPaXU+7WZJ0Y5l7O0Flu6I1KjVGtECgXwkrQCf1ZPSoq1T2NaJ7mk3lKOM86ozrrfSnTw4iehQ8VsDxrCXtuJn+nmfZabbIn2F+Zvy/T7klDTg+8kxV7HD0WkJ5/6amD6lRj5yBtDFmhVhZ9jpzp2yIkfktS7rmd76f84ebBix6UNtxbViVInl0fvOSqaJwJjTm95oALQns+OL/j/8gIPKsG6xjeE6lFJ+OYV3dc5rCtB1U+P2Bbk1io0SmiOVLerbGVa4iyB0Vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyqPveLGPpJ4tnFE1hM1TFaiU3FjTE/gOZV6pmhZ6Bs=;
 b=WENv5/exPoBjTJpK84+fjEksvlmo74hNzbxOMT8+NMdEA0Vw1SgaGNhKyBJMPers/pDOzMVTJMpLHj/0RiXVxmHz07sZkLeV2uku0Zr+H/BwaCknDHJL3jUslNXrs0FS5YX5whC+C/jh9QBOeabZcPDaB2tQxE31bxZw3wtE58m3HLeb9VXGP/BKAUS9irAiGSKPKJ/0UBrvPNBmWuvrDxblaSKSiIP1+3OPQLdaq52CaNDC2B29xY1pp/zYjCgCnbA+kk2yt0quCo6XxpnD+L1yuN4jOC/g4w5Jwwk5QiOLk13RaCuIjQhyOaC3NLlgd84RMVjAMwkeo/poLcTzEw==
Received: from DS7PR05CA0011.namprd05.prod.outlook.com (2603:10b6:5:3b9::16)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 07:52:09 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::43) by DS7PR05CA0011.outlook.office365.com
 (2603:10b6:5:3b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 07:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:52:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:52:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:52:03 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:51:50 -0700
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
Subject: [PATCH net-next 12/15] igc: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:19 +0300
Message-ID: <20240904074922.256275-13-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7856d553-5c0b-4c20-b0ca-08dcccb67a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yDgsaELNMIQNO4zT4CKVwf35gtf3i4LHqbvr9tYpf8o4J9buxRsbA47lQl3o?=
 =?us-ascii?Q?A3evPkRG5PDj0dGnmL/QvI3y5TLucUXwNXone0vxRyzFW1cqFKdFuTssw9ul?=
 =?us-ascii?Q?njlLnlwdif8qmTxQW3pLGr59ZFTttqJ3lfPq/XqDVEqNL5J+tr40B/rViUY9?=
 =?us-ascii?Q?MVtXMkqa+vTzna6fCjBTiii5TQtwuguK1hEqnmNipy1gv3azf9xgBbwNc+F1?=
 =?us-ascii?Q?Fa7k/6w4WnrovPp/o11HZASjZSmJ1W/nYnhr8KCjN20CisVG6G48d+7a/3zA?=
 =?us-ascii?Q?NJpkfKKTgYHPRJ4WVs47TeO08QHBzX1pRXlOt7IB/iEtSY4186ycnAFal7Yu?=
 =?us-ascii?Q?gKVWnI65QfNFSMBKtq8wtJQ9hXHO/9A+EV8ht0V/tx3wB8HX2cNFHtSMvuKA?=
 =?us-ascii?Q?GJ9x0IhRzUb9APoV5ezGo2HTUxXvNI68FeWLBT/agxhC4PlPm4J/7DLe1UHp?=
 =?us-ascii?Q?Too8+1S1Af+iZZxlelOx58lcYWa+h5sCIcoFIurT4Pg4Yi+L8yORxv+GbIaJ?=
 =?us-ascii?Q?8cHjg5mucdlyYNm5r2trYNpQRDt7WC2SxmRzAw/ucZjPOcigxxM14UJGbDlU?=
 =?us-ascii?Q?ByMJhUcCpst6t2kKSDKmdVtl+TVgyPP6BaLMEfRsQE213kZx/gr3UfSEd63+?=
 =?us-ascii?Q?gNCUVk7GQjlbjykOJZd0TrIO/DJzLWj+JEWCCvh0XJb7e43YLR4e+o3IpHrE?=
 =?us-ascii?Q?P5FJJ7VeAM8MAstwnPaIDzpgna97M9o1jsToh6Nv40NxEwI36ZHgPdo5666U?=
 =?us-ascii?Q?Te4KUjuxwv3sucfuq4XpyR2ctpz2Xrj5wkO9PN5/N9tWnpZKaetJ9EsXdw0i?=
 =?us-ascii?Q?8cqgVz/O2EpAME19pPyMV3TrJmN9z6M9j1TDFebtMY5L6Z6sGdTjr+wSyeGv?=
 =?us-ascii?Q?DeS/+xdrGC97RpB865HxhL1uquQhE1novmqciZqz9WExUrr+4v6Q+q5w2Nd1?=
 =?us-ascii?Q?wXSrLvyhvPF/byiWY2rb6Z2JR469Dd1Q8qhIomN+1J/pbuTjuxkBwd6Rvb0e?=
 =?us-ascii?Q?/waZTlFc5fuL9kRazGVr6x+zokrSPmAqrY5ph/Ng6QF3pq4J7zDZ5wil3xVr?=
 =?us-ascii?Q?6WpDqwBJ+nJHFSQ8Y2OW1RkApny6Ee8x9g7XB+wKcM+yy+LH5CDcC0z6l3P2?=
 =?us-ascii?Q?kaPldQsQty+mO2T+y5eanJFe0mGZQJDy8q1z8D51w1tztXzKZsbDBXavHRSM?=
 =?us-ascii?Q?kfrFPde1f2p481/voohQ/UhrtbrZxJbWGboV8FTXwKyy+XZpFbjPfb18mO+F?=
 =?us-ascii?Q?ah6qGKsF1nxp9MkhpiEQ+Dk3rSG0kdxLejIT6eskmOIsnepDXdzonTdbPgIK?=
 =?us-ascii?Q?0l6NfDOxCrCHAQ++8KL9bRYeE1/DBMe85pJz9d8fjmMvRXAsr5Y5mg/ACmbp?=
 =?us-ascii?Q?dGPgF9OEiaMp0i5+QEqJtaNUiQ8jRXkYVbFoTIJLc5Q0okyXXWZFNjmJhLgn?=
 =?us-ascii?Q?1V6gepLqShkHgJUDjvbKmYDFK9+Cq2Vr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:52:08.5258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7856d553-5c0b-4c20-b0ca-08dcccb67a37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 3d3ef4e1547c..fde6f2b3466d 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1565,15 +1565,11 @@ static int igc_ethtool_get_ts_info(struct net_device *dev,
 
 	if (adapter->ptp_clock)
 		info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	switch (adapter->hw.mac.type) {
 	case igc_i225:
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
-			SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
 			SOF_TIMESTAMPING_RX_HARDWARE |
 			SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


