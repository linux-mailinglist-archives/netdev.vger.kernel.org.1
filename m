Return-Path: <netdev+bounces-124032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE3F967639
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F38280FD9
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2086168C3F;
	Sun,  1 Sep 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P+VMTD4Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91414F9F1
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190240; cv=fail; b=Ornxww8eYG3vnfHMRA2AXmAZPQF7Ne0S+s+mc6GzhgzS7hCewSgaEdNq/0qCnAkilaAzW8JdL+G3NdkEAQPRgGf/0KqKw6Q3o7UR9UomNA7t3PizAJch90TODXJRAwJtBo7MP+bmTR57iE3ORb/z6XOUyfaHVFrWvrv9ZiC5DBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190240; c=relaxed/simple;
	bh=hVfLVWkTyLM5kx/E7K77KutBTD7djXA+PZpDvdGmmiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0YCA90b17oZKXBcHPUpT4BoX4MyDte9pb9/eyv6XKZxrr6qJuU3ZwZNq67gOY9sa4M3qtbHGPxYX1ut2CO2rLy6nNn7xFAx8yZLCer6L8klmApX2HC8wDTdzYZ8ZjspAF+uxkABwm1JA1YrO5Mm8VGjCBwoTjrK9FyosX69484=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P+VMTD4Y; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNaVrtUAn0nx93ltRiZq6wsHl/M1idMq9nNX+CeLPEiJc08kCUByefH7J1gh/55nnRqDIlHllmw3I2ODjXN0NQtze0CvJ+uuX3eBEqdSWhuueRT3s1IxcjV+LfRAreef5s0cjhUEUSDfL++kZJ8KxvdkGSdenvJvCRgZIl2aVJD/cHDEyqSQNQ5HCmfgaqEOuqkcTTJO6Ji7vcKUP7ur50/BZleMQlywXYBCvU3MEK6Jl2RBgOfb3YPKkh9N1NOuKVtUTf/oBlxbe2jiet2Tp5vjti9kFeRXGS0vpZGdD4NpWsM7hyG5l9lMXepipxrKLB7Vb42J7sAeAxGkwBjasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9zUijLyYkc+qJen1w3r984Qwm3OGDy3ph+yW/wG/o4=;
 b=ElqqORiLvsBduP5og7amt70q4p6n3ljkMSOJYWAGIW+lMfwe7HCyTDfllv6EhJT2JP6rfsYQCm5d5GjCvOAddAqnHeGWXme3Fa/mv6I0diQD2bNA8Ooc9yMtxUooXPXwjBR6tFj2pRn4sQ6Y6/jko4Z2GRtgwSx/SpkI5FUci1KGuIYIheW28GK0RZ2V5Fazc5ZvxtlDMVtWJhuVmuOrL+E9ktEBsR0lAuscz9VW5JeWM4iFiH/W7pM5zbOcik4XMt6zJjyLI6HjxaX56LWVeLN1IszpNFeDy0oahGc9NAFFT6S/OMnNlC338tuMlUh/VMMUfg/yysps8J1gWfKPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9zUijLyYkc+qJen1w3r984Qwm3OGDy3ph+yW/wG/o4=;
 b=P+VMTD4YAyceQuzhBAoQnCYgFNIOa+ruyhdVOCq5CjBSOzE/e3mOE0G9JTVib9dehhCSVxa/Lp/1FU2nGPz3RzxQYbk1WF3X879ftBRgNBXcFloHWh64g1NmoJWjXwkPHdgj0qi8ZxmhfDX+sOYPPHDCntgoexZIa9dVGIG29zTbikmivGiB9degYMgafkY9Vwe9lIzNXqK2l6/QBIrOGIDutNrsXGwKtLotG6BJALvljin9iQbknSlIMxfw4tl0Xhq15qVW7oBqqHusIC0pmeeTab4EcqaqRx3G2ZbvIkWWNs0/V+sqxSJzXDoiEka7lGh5O7nfWK02++rXv9wXFA==
Received: from PH7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:510:339::13)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:30:34 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::4f) by PH7PR03CA0016.outlook.office365.com
 (2603:10b6:510:339::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:30:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:30:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:30:19 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:30:05 -0700
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
Subject: [PATCH net-next v2 10/15] net: hns3: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:58 +0300
Message-ID: <20240901112803.212753-11-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: eb408972-dd19-4efa-7fbd-08dcca797e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WQrXRO2dW/b0+l5hFwBGRzk5dDXU7huBSqTCANhZMKnt11ntuJWVM1Yc1LeK?=
 =?us-ascii?Q?2iHz+cYAhFnzTY8RnCTi31zLpHws5XYIQMd6BMquC4OrVX10+Q71tWIiS55w?=
 =?us-ascii?Q?rxPLKxE2a/GoYM6jBXVkL7w/eT0Y67mOHQ9of6C0a5x4uHgnZQ8TJ1F1GgK+?=
 =?us-ascii?Q?VbT4GSltfTR9X4z7ChYPyRWhIy3ZXrTRDIIhBanop2usY3qrcX7PHDXgBka2?=
 =?us-ascii?Q?dJ8lHv8KSW4yncSRORtt0eu2aGQolTIvHriQ948RiXqXDeLfFAhJoswExDoY?=
 =?us-ascii?Q?t9sq2onzWsePNShq0FwazHFmXwcWK/W7dzm4xQNlPDTqANOO16mAWoqsKdU1?=
 =?us-ascii?Q?GoKudktATDFoVSrhUUHWOYsNSkQgmobhgjD4wr2GsSXk/O/Kqdp3Dyt8fnLV?=
 =?us-ascii?Q?mJ42JRmXzIZceozobsPv6scgkGKr7vue8PeFYmE4wxf+NrLXmtXg+7Qx7LNX?=
 =?us-ascii?Q?O3vrrUv6bdYRCuWsuCwIy9ZOSt/UIUKmAFhsr7MAQtVvQYdpPUbznLbFsP1B?=
 =?us-ascii?Q?eaWeJ5ITFqU2fE8J5Zz3drdLA5s4rgXybP0N7vXkoXn/kKX2medRmes1pz1T?=
 =?us-ascii?Q?XGE78nJunP6fP8lxmb52YjdMa5+D+wU7lj0HZb5/m9vJKV9J+WeUtROsq/eE?=
 =?us-ascii?Q?N6rhIwZFEIdFw0gW5wmcO6W7l/+hAAO6Ta+9kz82vczMHf/drS3lj0Nz2AOr?=
 =?us-ascii?Q?HavDnknwdDzrOkwhNOEZm26lVedir5CAK0DlwVsfDKggZ6i1glyXKDNZJOiE?=
 =?us-ascii?Q?hTBC0HCY0E/abhV3EZNPsvbiqgpHl9qrGJDrmgxN+24/83GP2Q5G019nRh6r?=
 =?us-ascii?Q?AOxrsaPebh5fBK2HtBu+GvjYMNjWyhWgvgZH5Rfb6d7FRdjTCCpah7W5vkRo?=
 =?us-ascii?Q?V1E7hk0WXSZaNre32mX4Zv9F4cJegdVSvx6RLdQzpFYviGQncatBFRmSCGFf?=
 =?us-ascii?Q?0kzodhtpAESfKO/6t8ehx0BGPEk8Y4qfs+KFD4UsKR59JGvjsulvo5/ddeMg?=
 =?us-ascii?Q?7wOicYfphScKWhYM2rx6+rVfosJoqKtKJbHgrw65tqqr7hVAOpH9YGmcKbu2?=
 =?us-ascii?Q?BSPh1qAWEp6MSb4DeOngVQF8XMlajFPIS2mahUMa+l5Axsf5FWj9ZaduWEOM?=
 =?us-ascii?Q?3W+R8IypQPMDS65254ObpK9VbGQ3M7nPnl8/2X4EP/P1G0X0YeDlRXUqyfzT?=
 =?us-ascii?Q?Sn7beHKfG3of4xGU22Y9oDO0kQ/crfBEx+BmK1uikMgZn0I9jHw/7SeL8FPB?=
 =?us-ascii?Q?DHMSydNt/xTG4xMaN1LgWRFSbyBPni5+FLZ+fPEO8WCS9lsNM4hFu65AL5j5?=
 =?us-ascii?Q?uW8guLZVmYcZXY6ulDd5/7Mdm/dCrnvSbTBGVM2K0uO28fmdolJfErdmHFvI?=
 =?us-ascii?Q?bNll/YPzEhbn8przvKLFEfpDQG4WtPAZ8TAzMWUqa7/ZeyvDDHrHs1WzS6vQ?=
 =?us-ascii?Q?OLqN0H30AgiCoZCbMWJAfh7hwCEH0V8x?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:30:34.1427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb408972-dd19-4efa-7fbd-08dcca797e86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 5fff8ed388f8..5505caea88e9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -389,16 +389,12 @@ int hclge_ptp_get_ts_info(struct hnae3_handle *handle,
 	}
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (hdev->ptp->clock)
 		info->phc_index = ptp_clock_index(hdev->ptp->clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
 
-- 
2.40.1


