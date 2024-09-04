Return-Path: <netdev+bounces-124845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC3996B370
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99CCB240A2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F1148FF9;
	Wed,  4 Sep 2024 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sqi0KhWQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B39148857
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436219; cv=fail; b=rF4m/m+iRSUl0/JBsAV7IgY/nEPCoxEe7WvfTS+gl7DXDeBIGrQh4QA3Ogzf91r6+6kEymmdMugxJrPpavN8T71acRo5M9/z/7q9HgorQfdri7t0blXIzTDa0QRbaopkeHVoASPo1vig0pdbzfhRO/p3HuFiKNjxaCPQMSGi60k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436219; c=relaxed/simple;
	bh=5e5imLt2wSWew57+phbECpCrw0lV060aU3f2g+jxYck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcvfDzWTrW9L19jKX/O0ge6H3qTvOs2Ux3n61Xs9ORfxPPNg8JXK5M/GlL/U/bky4T08ILuKUPH14S8A2A2PCJ7d2gxsEKoPASzesa2r9sj1pA8nkIjLXpD14c6AeTuDQbCNjOqzhkmZb22E93FzhweO1AMB4pH3x1uVu7LWhD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sqi0KhWQ; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1nruzTx1PW+DSCRitdmjwOH61Gho4sF+i8nH/sICrSTNfL18hdRs+s1eCXnjkfXivefuf0eL63nwbuwwSpFLcF0oyhY2J75tq4niaybEJefKXYBWSVZVpTtechT2bQ6kAPykksxHdx9BAgacgwrQmyrb5vv8HXhIsZF49BDRexV49LYKp/LR6Z+HJ3E3e5CtvuBGbcRxNVZAQhCGCSZ0Ppa8BlHZuWzSSxGD6ASQ0ATmpdo5Me9IQ9EUKvg8VnYhG0U76tv6QYABAop5CJp7Xc7iK6v+Ukg+tFSexQFniOFuRBIPsPbVPObpIfubqN0oqoYKrfJzixNQxZwPf+cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnRXfQ1EIZ20qADpWdVHETvsN2BUTPfbK9vPsgInU0g=;
 b=QVUvb70XClpT3NYsE9rPoN/UZQ2gXauB8dWUuC02vSuEYCPxPcR/waay7W/zIRjEjtc8CyN9QqGhkK1paAvQ1Mcy0Up1Ofql0ChDW5vhLWwCDUqO8F2wJAPFUfuJx6vqYwfKZ3iIk0fQo6kH3NqxneubQa35UzH852q7pcYMB+ygPCmDPBcV+WNaL/1QlSWT20kqZ322uNcblhEZ5F0bhVhc8p9f2cX3immJ9Gnl9RlarEXJ45D3fAkN/4kubtGG6y00ohBeCaTx7T2FCLq6kEnZzd63jA1rdbz+T6LKNLqaWUP5CTlXY7csrMTAxrAg05qXWvFmF8qegJsgxuCY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnRXfQ1EIZ20qADpWdVHETvsN2BUTPfbK9vPsgInU0g=;
 b=Sqi0KhWQl0PRc9RvEj2DEU+tb0/Y6gb5JKCepnB9MYHvuwApfEBQr2fGIT/zW2RCB7N0xADDjF4SYiVCfaT5EokPejYIjkR5ItZMTA8pTB6/NZncWeqbQGA/Q41q2cxVPrO9/VyWZdZWL30ew7KP67jpHNoZ0P4N2KzW6VrPBXJxtqE+6vo4DXsCQjLIdjcclUyzBmwxYnWCAtgehJe0vSkvCkFwQynx4/Cl8NGiI+yaZdPZIPqSluC/qOBCzTeAx9xAn+YCvMfypWKiYWwYZDQRlrRWULX4W2/1JtJHbpv3VmaGFS1yNhqeXoTmaUTxZWeKDlLoexZHOVR6wAQQdQ==
Received: from DM6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:5:1b3::37)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 07:50:14 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::9e) by DM6PR17CA0024.outlook.office365.com
 (2603:10b6:5:1b3::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Wed, 4 Sep 2024 07:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:50:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:50:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:50:04 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:49:51 -0700
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
Subject: [PATCH net-next 03/15] net: sparx5: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:10 +0300
Message-ID: <20240904074922.256275-4-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f167a64-7723-40ae-a1b6-08dcccb6359e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4/RSJWfIzD+Qig5ghf6YZU0XtThGJnuyUDxUFbf+QJAxOnNw2Us2mQk9zcK?=
 =?us-ascii?Q?8K5L4KcD3Y+8wGQ3Bk3S91yZ7tB5aX/1zs/nLAzXePd1K+OKOeip5qshtt+K?=
 =?us-ascii?Q?Tt8DT2ZL+1PoQ250z07kTXoMR5lP17kOCdfPvW0Vk6ihdMdH0YbEBVJbr2i1?=
 =?us-ascii?Q?DxD8xYShJ7KHhgTj+8lUipUPvLdFpNTiAE4H/iZhtz7u1okmrXfh5C/m1BZ2?=
 =?us-ascii?Q?yqquhGkivW5lbJO+IS1HTgOT0JfENdacxx+3SFhsotd9LXTP7bGDh50n8uqq?=
 =?us-ascii?Q?F9QTFwJgB3J8qYep1hoNZRbI0dDSrgWuEYjuR5O1fAcy0H6LswxCY4CzjSa9?=
 =?us-ascii?Q?KNeR1Q7031R4sCcB/X/xYUCCXoTVJr2nkCehzn4iFWmghZz/4rAEiEnNDSS5?=
 =?us-ascii?Q?oWH46E4mkbGtkbvys6cIaf9g2Xq8jngoHkFyPHrPUO+jCNYH/N7aln6r/Zas?=
 =?us-ascii?Q?y7UDy0wd+2oonGnj3FxKSZaIfLGo6gNS9QdoJIXYNF49bWQiahJ7bk0piDn5?=
 =?us-ascii?Q?DdFJttjd+akuhi1LZZXw6C8k/O6lLMQ+pxVXgEdCq81bYxDbxwASSjINVtGj?=
 =?us-ascii?Q?E7nz5v88FNRzlUNZy+b+pYorMcPKjK3WidgLJxIA66YjQLP5pnMO4in2ngd2?=
 =?us-ascii?Q?kCb6fw8mD4GHFWqcFhRzsZrJyvSHFX2Q/f0niz3YwMVfumn/jXBPQKxalHuG?=
 =?us-ascii?Q?IWK85PBXsUXRGWEk7zLbIn+5UUG0mZTbd8PvJRyrSdcc6O6kvcyH38zDoH3s?=
 =?us-ascii?Q?AGn8z/UrUZR/Ju/Atf07e3PO+JvYy0ydwhkrm0G1+44L17eXwUUTAB7kKuCg?=
 =?us-ascii?Q?qfp7n9p5fNltqKFeZbi/DZvM15rSWBsBBRioNzjIALcnb28Rp5eL2WeWwu3+?=
 =?us-ascii?Q?Uursm+1PcG+3OvriVbppIQfru+RPM0EVBwJ3FrmBL4fF93xvMW01rMjL6pMk?=
 =?us-ascii?Q?0E3yUoE8/VC0dDLMF6xfotRnsTby/4pxoGpcceGTlQIMf4lp3Puj83Lp/oCb?=
 =?us-ascii?Q?C5W3MaQuuMMjXY5scf2o1pYgGJq7gRUQu5WXPNewZghebq5eTj7QmFls/Tie?=
 =?us-ascii?Q?VOIP2rOrAKcOg6/YHMlvGBTh9xzAUqPmCKzPsbh+TQsMl1A93gjmCmfCnR7o?=
 =?us-ascii?Q?wmaduB3kBFxaYK8zCO6bGuE/G+6bs+m57+CpOIRjP8BEYcH1SnQu+MIqFJDs?=
 =?us-ascii?Q?pPWF8ynVSBT+bWfd54H7iGcAm1OJDWm+ZaEw9oj1s+82EqQKk5r5OhSI3e4+?=
 =?us-ascii?Q?Vds/MQQUOWCgo9Qr4Y64dBORywq62OnBjIHzurWA6lZ4vtZfw2946wtARUG7?=
 =?us-ascii?Q?Y4Thg/qObeQQCHROpXPLao0NSUaBCYtdrHxsBb2Bcpa5QMiy0ia3ohbdPnV6?=
 =?us-ascii?Q?S/HnSJAFNtNDSemDF6AJwxlywJQFFoJMiDueZ4ufO3mXShc1cAEqllRU+VSt?=
 =?us-ascii?Q?Nm0vPQZkP4RLmv94HqzJZA25SODYails?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:50:13.4376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f167a64-7723-40ae-a1b6-08dcccb6359e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c    | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index 4f800c1a435d..d898a7238b48 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1194,16 +1194,13 @@ static int sparx5_get_ts_info(struct net_device *dev,
 
 	phc = &sparx5->phc[SPARX5_PHC_PORT];
 
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


