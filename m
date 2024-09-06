Return-Path: <netdev+bounces-125977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7C396F753
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFD41F24F47
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B651D0174;
	Fri,  6 Sep 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZd7hJiJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91D1CCB2C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634118; cv=fail; b=sdrAiTWWXMmIW6qnjGL4MDheY7yj41sPX43tO3iTeNt3Zcbr1VVwEN7r9q2vzwvSo5oS+KknAeAQGGkv23+59DA2N+P5EV2eMUmk2kCyW/LeDwTSygdN/2tICOmidV637oOcN7mna8cRnLa+RiJWN2oDkLQ4UboEFA3wuG/AP4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634118; c=relaxed/simple;
	bh=cGv32A0WGyKfmKEbaoiVLr7xH8DeRt3KrGjjxkL2DG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W11aoADKVhiMJNnm7KU+6g1z/kz+7lHGHBnJCx7+aRNeutpxZNHCGuJ01HjkvuWT3l/fmqNWCseHuFk80CYRbxnS9BaTH+37y643k2UnS8ViR/vsxAvO6qRs8GI2UjDIuOGpYqBAcCl+p5+hqUwtZ7H1eXc8CqN3pgKqCVRdpts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZd7hJiJ; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxfkF1TLW5UrZ45D3ctam3kgdMlzni1KD2yxNYpXyBoUZzEMDC3sXkV7YtT3/tb4+yHGhmYOVMd7vlaebIym+XrMEnzUMLpc4SyWKthN+SJI7aID2iSPA+stJNVoZU15e4ItphdMd4TFdOyfnKqPBttSpHzx0xUtNkHFI7E9akN8MJHRp1s5Ydokwj0jNFEtvN8mmrxP6F94mTPBbwMxWSzF6X8C65qFzq3mCrP7i301aE+MMOLO+0Xn2FBxwZH6fw4VSMM9Ik2IfSbxBuv9U2xb0jsEJWonFVL6d2cINNi99C0YHRNro4uyqHt4iO7Jy3qdBt81yHFcGW74ZDjDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdQ8xnzZLl/ZMJQGnDTRHc+QmTPf7/FawNLBAX6Qec0=;
 b=bnslUzcvuHKxe76Dq8buGZrDcoDBhgVaBYoke0cwe9kiIv5FNXCp7fPoLnU+gvW7CJ0r0cZnbc1eZlIrQA26z1UgONi3Lgx45f4A2iN4vpEdkBqpQBcv+zDSJZPDWsCd7jSrd3RR1991YTwE8xpQ9BR5dZFmnBdZr9f5wLpNkeCzz7F3K7DrDQtrAMh1YftyXVkZa+ZwUarRSLjia4mdPD9VNUomjJo58VELvabXruMTOWHJveg0dXNnd6xfOSOWFYcymfXn/FF/piSxbWJAyvtumOBpLbNaOKBoMwbwRYvr3dc76xPttlZpp3nkQQkKIzRYWAJPHhPJX6fjp/PQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdQ8xnzZLl/ZMJQGnDTRHc+QmTPf7/FawNLBAX6Qec0=;
 b=mZd7hJiJi3rBbBxJ6mtQ5pV5dexjjLq9jBLKkYd3molDTCk0Qh4unpAvHJ0jta79K4nssusBlq3b/PT8wEK5FyWGXHjApII9ugl72/NZrDTuXCuUNtCAsLQxhBdbqv4IHCQcolL5bahE9rJqAfOTKVfaAVHndb6/yXUjO1W/ml0t504vYrcDfhaeaDTK4OR25P2/cd4jZhJ2IE7iekpIZtCnt48dhAnpcHWzPxXJgoFM81QWTQEZj4XjvnJKFnfLdkKZ5lhlIy0diFqWInkjcATX/en2HqfmtKVza7OCnNUdUb6Nh4roviNJH3xJeLCPdhjW3BjXlHSzWUopd+cGCw==
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 14:48:33 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::2a) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 14:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:48:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:48:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:48:20 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:48:06 -0700
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
Subject: [PATCH net-next 08/16] enic: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:24 +0300
Message-ID: <20240906144632.404651-9-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 82303dae-8df5-4e4f-3a77-08dcce82faad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vcLhbbF6PwVEecuITSTohk6FPSMgtMho1a/IopX2KQXoIwzZnhVDlnwSktLM?=
 =?us-ascii?Q?qYeS9Zn9Oc+eew5YTm/A5g+aXLsj9Zyg4wKWo6W/wZWWYNFNVTyf3ap30IA2?=
 =?us-ascii?Q?yxBuLW4hQFBppZqX7S0ObIY9y6FSi+TNHV377/xCYQh55kDM7fRFqbliGfIE?=
 =?us-ascii?Q?zgMFXc9Yd+PRQQu8be5J9oaiFnJ58NlHd5i97kFOtZwDtb+N1eqISZpbjyb1?=
 =?us-ascii?Q?yFSruruMndGI4cCrdwOsvG6JGw3ig7FJTS0DWjOLSmU9C0IU63aYlsdu2usL?=
 =?us-ascii?Q?ZE1vvyBb5fX7JRDj2LkiE2F5Ta74YInN1mDIQkTnrNzFtzg4XLKKDQicOYga?=
 =?us-ascii?Q?o1/g7OmkR4Hj3+Xcy4nwlX5MXd4JVmEDAlN6gRH7vYUgxm9GwN7B12nqEHdk?=
 =?us-ascii?Q?B+xM38km0l38/aIHLghBWm5BdVIzopk4tn3PcksTU4mmp0ZNGC1pEaarpMyj?=
 =?us-ascii?Q?sURO1ukOeF9aza/oGlzPStVEdLAt8+UmWCRWhy3uqBYyI3KjVTXvhmEGVw5R?=
 =?us-ascii?Q?+/6uDP0MMQjCqYyR1Df4KmUeZLdUGjxhILNvCV9wZ5KqMkeYU2g423vhayx3?=
 =?us-ascii?Q?IrtSDFKzFSXi3+hUQArm0vvHvwnOLXwhe898foybXZcXcziZp3JyhhC/Z/Tv?=
 =?us-ascii?Q?ZK4PstxLUZ/nYERSOYZS1AXtBSGt7+/1gQmCpSy6wIak6pdSbnfB+rWBndIk?=
 =?us-ascii?Q?SywcEpIWJR7xaPrhR//UKstq4R6pfv6N9eGJMp634RdxEa2xcQHYEZzLTR7h?=
 =?us-ascii?Q?jqdN0uZGhJRJy9ODk7LBLdK71g1hl3+eLFDBH/inJ16/r7AoTzv/T2PFzpLL?=
 =?us-ascii?Q?cppZkp1f6RZD8jOXd2UAP7AI1/VbSgZgBl+wkVJoh1hxMQGVQa+fjlNcAC1f?=
 =?us-ascii?Q?XjHI25BUM0VY6i8nZa+sjreMRtmQEKrhTlR1k6j4e6Ev0tFpTysDJvMGWEqp?=
 =?us-ascii?Q?SCIGp+A4+TcMfJewzTf+ZO83Vz/BPLrcDhUwoxs1ROFPUiT+mnnbO7uml4pg?=
 =?us-ascii?Q?vzPwGfvnatlPMG2EbFHN4DRd+5poFHd3yYTTiEq6HZEewv2oTF8jkEMvF0Rf?=
 =?us-ascii?Q?D5QPWv23tMMPeRZVUu3y4FE4esGJY3cuNDqhWIfqi5iZGzvLHcMVdeQ64rJc?=
 =?us-ascii?Q?jydoguNTzR4RTuvNEiUK5KVR0U+TqXa7cdxMz+DQgNp6KG0t1JacGObTxOwa?=
 =?us-ascii?Q?cAyijT7Jrk4LU9XEEXNoW/PYDGtJJksxm3fickvegwFV5WMTKzuwK8GFum/K?=
 =?us-ascii?Q?jlHAAaXjegS3fDmu/aIYEC/hqteJoC5KHlVivATDBbIsdWhkeQVicaQO9K64?=
 =?us-ascii?Q?TPSF5e/oIot6OkjK/Z2kQhUzkQVsk9ndEmBFfS/3uX3ljqLrw6QSd7xswMtZ?=
 =?us-ascii?Q?hQl/G9V+0nPqk5UdXLWVph1ol6wXPolnISw3Bo6Nvh1PmskMHt/sbagQl1rS?=
 =?us-ascii?Q?QxBzm4/Z4+ITnZHE33CWtUdEyGY3LHZq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:48:32.5557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82303dae-8df5-4e4f-3a77-08dcce82faad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/cisco/enic/enic_ethtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index f2f1055880b2..31685ee304c6 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -601,9 +601,7 @@ static int enic_set_rxfh(struct net_device *netdev,
 static int enic_get_ts_info(struct net_device *netdev,
 			    struct kernel_ethtool_ts_info *info)
 {
-	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
-- 
2.40.1


