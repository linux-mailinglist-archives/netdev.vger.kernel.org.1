Return-Path: <netdev+bounces-125976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735FD96F750
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029291F21D5A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D852B172BA9;
	Fri,  6 Sep 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kpvv+onU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D781DFED
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634106; cv=fail; b=pCu0KuCZzzq9SGHeH6NKReeIGm99r6EIifiSSQp/y4U9gM/6k2DlNymyyXkJiqCjfngpdgUVutc0NLmPyyNof3l7i70+8GcJ3oLkMLK2VPbSFZ9Du6xrZVQBx+kkRBykLF9hCjnt0toEvUHQwoGkhHwCyW5Hg25bXQgVrjPDgDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634106; c=relaxed/simple;
	bh=Z9SugJbd/InKDIGB04KxW2IU8C3UICIRKAGDIFoLDfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtB7Q23bsfbxrnv6ait9j2rFtPPl/DqpDDHlaMT7b3mcHEvd101FN79fWkgNcHvWlm/ac8QLscaJ71NfMzNEcgXMq96MvX7dJvmd/Z0fauksaCXBSDaW6M7TVNIxMf4DJqAsHIOfR7PnfZfBiVXCLpCXVd707WsSczEPI4qcQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kpvv+onU; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pjh802Ef//XlOf2SKAucBtCc1mnOECvujzWlxZgkePtaha5Ks0uwU//cdH8QMNcYwhtg/+tPZIFOuncFVoeCYF9ZX3mb5pt2c5fkZOp/sORgXHFTZBznIC+rXmRM2GybApWLpstWIggppiImYklMbiNiL2g+pIligbvvupvLCJCYICjO6tPcCe6gkSkymPxWtdkn/Tna4MR2SuBJDSLgPKvBIpsbTWHQceB2/yV3DOGl+wCMJ5FMoUxlIn9vNjCtNhKJfKcH23/CfrPV86t//6Z3+w6IkWnkn891Zc0k/Wzw3/CFMh1REESdjjogO7KvfK+nW89wC3ku/FrGG4YEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+M9PYZ0STgxTB7FQVJN2H8sQ86OaJ63giOmOXBPsD8=;
 b=RAk3UlIY/lyp4q4G6IPCPSFaypHspKhkWjflT6vmY/8RVJAFHx+RLlrQh4EYWV0EqHtMm4AbaggSae55d8LBK12N9g5aRDbqYClgIe8N6yFkRY+frjzLWhtzkYhKKcElOpUf8EATi1muAEgfj2oXJvMboiXsz9vXnWwecrIQ4Z9CWfBe13lU3KBo6OMwIKB/CCeo/T5lgwgGue8Gyy39Xv2Vf9epeOf5BGwc0xGm0Mp8grN65iLWEIuNBbYlTVYPcX0bzHJvZA51c0Gl+/J3MUi6lgguOXSsb4fCz64LskYzK9tJJrbMC1Zi/mFQB9ywSE+PKwGacRfsTZ+TiRzAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+M9PYZ0STgxTB7FQVJN2H8sQ86OaJ63giOmOXBPsD8=;
 b=kpvv+onU0WVcmfv8JSY8f0KD+fe2Is4bc51J3j96pP1E9Z/scwZlCIJcC4t22D9V02iNOI/ZPgxijyykHdBYg3/8og333brVv3K6QfIiVFsBhRLIueiM3uLFXQun2fLUKY0OE9RBQNE6Ri8TuavrjlnXkb7anzi7QtG14Ode0wLhxSJBLakC5MIgVVzTtgWKKPPzGTfmOq8fJlFOiWb4digyn9Gym/kGlIzIIH8W6Ebl8L5Tr97V2MKXcFrBpED1LziIR4nSxrnYC8QNWPGlLBFflN6v4ZFsbqX/KTInOFjeffRG+WUcuUKb+RpvGBkAm1xU6dgHNUszDq0HYoZFww==
Received: from MW4PR04CA0306.namprd04.prod.outlook.com (2603:10b6:303:82::11)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 14:48:20 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::b5) by MW4PR04CA0306.outlook.office365.com
 (2603:10b6:303:82::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Fri, 6 Sep 2024 14:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:48:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:48:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:48:06 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:47:52 -0700
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
Subject: [PATCH net-next 07/16] net: thunderx: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:23 +0300
Message-ID: <20240906144632.404651-8-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c04f20-7b10-4937-a393-08dcce82f376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3eV5m6oBkVN25OLp+86DHvBFM4Tat/3kG8chOr0UvZRRycpWE7vnLbSIRZqh?=
 =?us-ascii?Q?ksIJzQZ4kCCmV/dWMmtHRaK4jVRXDPH9knXjzPEcOp4RSO1j/lKeBE8PPRgQ?=
 =?us-ascii?Q?D2jHGKpWzCHoi3ZF48OQ5CkzYBbYO1AftX2B3xrJorKslRiC0G2bqK1VS4jj?=
 =?us-ascii?Q?RjpwLX1sIS6SUFH1Xl98/uwj5vR15N7nHNONuEU3nfghdPYgIvlFG8gcK6Lr?=
 =?us-ascii?Q?HCEHbbwdBgh768EBdUUhTzwy2fBEb9PY9OxPT4PXCWZ7MlGqSjUXBbuYfEQI?=
 =?us-ascii?Q?ubMvkcWlQ5fSlw5y3QxAFvHyPZcyIGGwz0q67WIebzsQmeq9BD2bXtoqdpAX?=
 =?us-ascii?Q?kfdv5QfXkq2lKHp5eJTm4f1Y5DEgF4LyoODTQ5vxYrF2fE5GaVv8VQdYACb6?=
 =?us-ascii?Q?4RaHI2wdIymh++olOHUlNmnMWBNgLFr7w3OTGkCbCKRnw9unasipvDskw47R?=
 =?us-ascii?Q?5ejFBLjp5W0/UC7kIjLzLorS/WLvasMDMipiuF5dPbYgdNph1GDKmHomNNt3?=
 =?us-ascii?Q?aZp+ffv6+Q6EbnLQJCRnfGcrBnOOgxsTp/AH+SzGYEh7xRfJ/cs07GXVO4NK?=
 =?us-ascii?Q?5njK5Q5pjMsBBTa8QztNkSsGi2bXyhRxnkC8sZluyUi0yEckdJjDNlWS9beB?=
 =?us-ascii?Q?tB43dyZFr+R5/6X58h+aGhBH62DRa1YJuBih6O4nDkrsMgOTuQCZb7tSm03S?=
 =?us-ascii?Q?NRCTykkO7vLsd2lvvv+aUhbDofCtNEGBpAkChIqqpZgf1L7naPYu5RrAkGXY?=
 =?us-ascii?Q?5fpHSSLEY2samUVArbfhd3fwLaNlFCI3Y9u0/Z1QxeZkeYwOTIxHxvPCZivr?=
 =?us-ascii?Q?9msuCa/hRtqPxfbzfTFHe5XolvvLPRJ8Q7VCfiMbCvSjvo0o6xMraqFN+xb5?=
 =?us-ascii?Q?+uLnZSCENpMpUOnKpH+NTcqKLkOPeSQw/Wdh257qxaHw7I9+t5y034pSPxdD?=
 =?us-ascii?Q?4qyhy+W0PRDkJMf32Cu+FpE3ss04TmUxnV1b7FtJuduVY9dpJ3PSLq6bgkrl?=
 =?us-ascii?Q?gCFjCYZ0gG8eI7yGKqvOOJhVxG5BjZ9dJ40Sqczj0h7ZWti7KHvkfQRwDyFu?=
 =?us-ascii?Q?78KSfs7+VaewAJSYlchGupMW1xttfJuC08cfMkpjqT/A118X1DTtomZUG2gj?=
 =?us-ascii?Q?96NFD9YczoeIt85hw6Otv1zIm9L7Da0+JLoIGD4ModD5OIV5qG6V38Rx7obm?=
 =?us-ascii?Q?OyeFN1bSvUlr5af5Uy9Dv+DeuvhRuLhpScuh2FP8DAEvUvj/t8B8Dwssq41o?=
 =?us-ascii?Q?72Ak93+5P4oOnsrgUtRSpiinqJmEhIC/LuINi8oSV0FB6wCQAJtxsazHs4ue?=
 =?us-ascii?Q?P5uEfmJzB8OvOs1VnvRLdMyqa8Pn0T5CfRgO9y0U32cci6DdUbqVzR8CePNL?=
 =?us-ascii?Q?/qgHQuP9v6Jr+ztd9f0RFJ87Nbb8mE1xV8/8mZHpJYIGU14+qgTp4rFXM4vx?=
 =?us-ascii?Q?kO7CqAGzBWmUtBf/vgr8VBZ54s0GbXYm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:48:20.4539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c04f20-7b10-4937-a393-08dcce82f376
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index 6a04d2530176..d0ff0c170b1a 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -844,8 +844,6 @@ static int nicvf_get_ts_info(struct net_device *netdev,
 		return ethtool_op_get_ts_info(netdev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


