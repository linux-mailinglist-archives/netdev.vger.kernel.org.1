Return-Path: <netdev+bounces-124844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36DE96B36F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EF81C24595
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48612154445;
	Wed,  4 Sep 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0dXOQ1F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0E8121F
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436210; cv=fail; b=e4niAYZ7alDnMEEZx+CjPA+wHV0dnusd6EwA6pJqehlw55jmPsfZdMi/FpksUZ9BqmICBJ3f1XRdtgvg2RSWaqNEn4ucMhviQPxfWtD3KxDpU7KBSiy1n3NeUbswx5CSUkT7RgAGC1Qmqn0lRhdoQYp4z/IjSDI6CGpmSSa6iLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436210; c=relaxed/simple;
	bh=E0J6NCTrNZRytcP9SGNKLfORzZS6oVQ7xaCGPpI4aG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO6XukbSLaPIzzBqCQ1iagHVC3RyjOVkYDgV4VJ0iPQiLMkESqaKQhpp+1xIsiCtxUxPafx93HsCIAxKEEHtOjVJdDYnTbDM7jtCleM0eQwEtYNZBHc43VSZPEUJr3oModVP713O3KrGaTCCFQILeKO8yMDZYUb6ZNxilhBG8mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0dXOQ1F; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSxneuilMsnRHVK2W//o83yoxEyWOUrtk0fGxVrRQxBhgWPXgmNBHj+pV05m4hGulu1P2lrq1HDGgw6QwdUJYjBUh6jw4HtexRITnk1W205QDfxS5GfidbAaucDb56QcPoQwRICN1JUKCT6KIMKW2UrJ81DFbnJaVZgQS/eZhDgbuUZsdCxrIcyw1vEPJD4WGxFdCxem4d34NccYGx2HLM0J5g8wWg7p2ey04k+UYE/HUsSnml1z4D2VhKzbAUL1Ufep7u6OrJrBQApQKg+rEiYKu1Qma1lbppv3gURmlDZe8v3QRwAD9ipWJK4eh4IJR7npKdgS5qMo/NHAq06EbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36r8ifTmzkbRX8ogXzOrmLzoeig6djW7ZWW+N2Fjd0I=;
 b=R7Paeld8rCh45/mR+FUFRXnkYxTmn8LeWm2qWE/RrRHwhzX7xxaKeJsSXrz26QzRcM0hRg1OinW8ghr2RWgvP0ZPb/YIR5IQHUpCoKkwv+kzd6xP61So9GF80m/RTqdqEXunRxU11zGDHxfGEtL77KkwvSf+djE+WFte4Op8UtaodBXrZBk7esEF4VpFLQHs2nE8N+IhM2ee76Eevlpq5MHMcam8k553xG/yyIwRVv9Jxn2iOqLNy8jWPKIHRNc2eOimWx8s/eZb+HD1FTdbQMe+w9giOWux0nWodGvfMzI5/TtC0XBotlG9f7ARep/FFi6GQUAcjvpe+lWUC92pQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36r8ifTmzkbRX8ogXzOrmLzoeig6djW7ZWW+N2Fjd0I=;
 b=C0dXOQ1FLFmDnK1j7gxtTCXcDhwBjWiLEz+eNGFByKTjYzgjNpYteqW2ooJlF2EoqL21d7vGSLyfDenvSrCoVTgtOft4igTPYmb6teiECl8TjFIrsqo50T+0P3x7ugao9HZnw0K2TPFZpJkTCiv6WR/W7uJWcRLj+x70zVBl08vGQiTROgTGAAv1C1ObjtgHZFD1wIp8DrRGKiLDPFz+b6iW2YgXod4pB5w12jBbGg6sl3UJqusz6+Lt90tEGr6X2lB4144Ifq85t89YZU83eeN//eygeJUU1qFFcm2KujBkJs73xdMXiLQEkirVXy0QBw2bqLs8KnBGV17IPWWc7Q==
Received: from CYZPR12CA0019.namprd12.prod.outlook.com (2603:10b6:930:8b::27)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 07:50:04 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::44) by CYZPR12CA0019.outlook.office365.com
 (2603:10b6:930:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:50:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:49:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:49:51 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:49:38 -0700
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
Subject: [PATCH net-next 02/15] net: lan966x: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:09 +0300
Message-ID: <20240904074922.256275-3-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: e35d59df-99e3-4e4e-116a-08dcccb63013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+NyZjPr+mxxJGNL/jm1dTpufSnCAeDCfUNuul/dJ1HYLXoWJTI8ydRHkaSYB?=
 =?us-ascii?Q?gWjjtQRNEpubNQmzcZ6YdwmhZipL6c/whT7xFRM47kqZaBJqX37WtIRrYNOv?=
 =?us-ascii?Q?vWPy6Dw25BYfjmoUA+PQ72sEx9ROsvddqyieAr8/xmo6F6Bsz7wtkY+5uIk0?=
 =?us-ascii?Q?PsW+Cx90g8dpv9JSI8TnFzeNFj5pkqQRnzb0A58k04NzaBnB92Sbh/akv6b9?=
 =?us-ascii?Q?KyD7gOziJiJbHZney8mW/5vElNmMd0kqlV5UJqffw9+Y3QNlINY9MwZ/D/Us?=
 =?us-ascii?Q?zOG1P6Gnt7GLV33o9XbCCl8tNL/bguE6wf+BGeSqiMmf9PlydyIfE4W4Yfzl?=
 =?us-ascii?Q?ZUTUkcDaVw77r4gn5FrfV03wTN6zaKkkOiHTZIry52urbW9qle2+YanK8huV?=
 =?us-ascii?Q?TLxW8dM4dsV1I+Q/+xn49oiWAzmuBX2nktg+dRhscRy8rKoKbYayCRl5F1TO?=
 =?us-ascii?Q?ICOVPQylhv/1W3zYlK3ePUUrMKICwfQNSfv270r2P0NlyeSSKphpimETi/vY?=
 =?us-ascii?Q?G5DfIQBoCiYVd4IKJDk/SvV/JvxE8hZSUMG8s+armFFcuUeVmhp46BOKJxUN?=
 =?us-ascii?Q?zf7poJ5L240Tg/PNyfYNw/ZetAWkc0dXa45p44By0Te29fQ62N5rOUo5dNbS?=
 =?us-ascii?Q?iNI3KTjWDg5IeH0LKD15eyD31lQYKsApSZkqURFkzaui8D++oND/eksDFoR1?=
 =?us-ascii?Q?M2H1VmwaxEyfwBwuDi6/MjUc2ZL18T9K12DKSsgA25P8X1P8Qr5uTTIg/zwu?=
 =?us-ascii?Q?bBJySqkTkpB1lLtatMrqp9cV4JvLF4WnWOorK8tBckO0HNbPT+BVdye9AKij?=
 =?us-ascii?Q?wZplHON3PgUOHriY6v1tBYWucN29I9cazlM8QW/FtDB2PwFvz1UshHC4zvSZ?=
 =?us-ascii?Q?V2kb8RDuUtkpCm80zi8Smsoivb2hNuFpbZ4D5RNY01U4lzaXEAqCoqYVdbJe?=
 =?us-ascii?Q?zZ+yJ/skIo+HJ1gAduUEM0bLRx49RLhBiu7TDXzzoueKuZz5KfrBsA9cJ0FX?=
 =?us-ascii?Q?xEqezUXRP7P6WizoIh/mNLSVY+8qTuuKp/1VReIXXXP9Qy/iLggnT/VDIhpk?=
 =?us-ascii?Q?3V60CF6FFHM2rUbzhoZR0QJGG8T1GdnJc31RsN/tL1wRya8tzBPZwus0w/y/?=
 =?us-ascii?Q?GyH3RCm850wBNN0o7mVVO6VvReSvzixO9uqHVqAibu3rZy9WtSPNnfUNODF2?=
 =?us-ascii?Q?dwBVMWePELHYu4KbjWBs3F9glgidWbPU+ImI0hYj7Ld11GGaBubxCJPr2S42?=
 =?us-ascii?Q?IpCcM7eqxSs6usvKW6MSFEJfPbht6ERlz/enzc0+hlorTy+fyWlmVSG41feQ?=
 =?us-ascii?Q?xpAvGAX3XTaSNHa0Y86RDBkzYrCesMNP0r+cFXygCrADlCWIa1DPzaasmeSl?=
 =?us-ascii?Q?m9vF9f/0OqvGSOhzG6iDjeeniRs5xbJNVCJra7RFs+IK2Se+5dYS4EZQ7+0T?=
 =?us-ascii?Q?kitW6jJdkqKYqVBEZcELEUygrlZ6xrMS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:50:04.1655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35d59df-99e3-4e4e-116a-08dcccb63013
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_ethtool.c  | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
index aec7066d83b3..2474dfd330f4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
@@ -549,16 +549,13 @@ static int lan966x_get_ts_info(struct net_device *dev,
 
 	phc = &lan966x->phc[LAN966X_PHC_PORT];
 
-	info->phc_index = phc->clock ? ptp_clock_index(phc->clock) : -1;
-	if (info->phc_index == -1) {
-		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-					 SOF_TIMESTAMPING_RX_SOFTWARE |
-					 SOF_TIMESTAMPING_SOFTWARE;
+	if (phc->clock) {
+		info->phc_index = ptp_clock_index(phc->clock);
+	} else {
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	}
 	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-				 SOF_TIMESTAMPING_RX_SOFTWARE |
-				 SOF_TIMESTAMPING_SOFTWARE |
 				 SOF_TIMESTAMPING_TX_HARDWARE |
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


