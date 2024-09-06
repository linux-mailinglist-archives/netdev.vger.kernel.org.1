Return-Path: <netdev+bounces-125985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB296F76B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0811E1C2177A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393251D2F65;
	Fri,  6 Sep 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J81gyzZ5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D41D2F61
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634205; cv=fail; b=pcZvHew1V6oZqM2GyVOM5GPkN/oApKevANXnskEundJxPePr2WporzJDaecG36UFJFrIBX8DwLYdvVofpj7oqPdI7e2NVe1lWfIPA3vUdeDSzcBwJxogntOGpCXw8mYBF2Ij510Jzd/3p81klHlqV0mZDY+W37iyiqMzpFOVhP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634205; c=relaxed/simple;
	bh=MJ9nQH1hR7TJBM2d03QIaupJFKy7ED1xeztRzD9XBgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9W395jPNAGjdkr36D4ZS0ZyFLW/vT7S41kDCOVlkAj3bRLPxcwBdO70d34XZ43OO1bpZi0uA8sMwFdZJm25kQQPdByq0zBZgEVp36utUhjipNO4Mfgi4S/qfu7ZfW/WGsCn7YznRYUD/1O1FPrD7XFqsXP3C67u/hjhRbubqGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J81gyzZ5; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBgT1Kw0zggJkNid9vxHJmrcU0n5W8LcvQxe6m9vwY46plz+Tzwo9LAHX2Gw+q9K5p28/3uLReRkD714wM5ioITDw2LZiqYZVW7hZWHqNXmgdWQdmWvSs4/0Skbx3UwJRX3wRWbQVkEdwo2xopkjoLyzhkpF4tsKt3k7MzuqSPBVp6g+LcDKnEjtzxjpFRq2bh3gHXKjh/Nd0cpLmkC3wI5zrsrD4nQQKOpxkHxF891c844lgkBzN+Zvf696BZ/ePLEURxdK6JF+m5+WFoo0oUqgxJUWVyquQM4mrbhb3TJjb75kagVo1VvVNfQa+zSbS9N5OTPMgmiF4HswmTL2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7XCt7yz1rDByxihyoVZi787QAHWKKvoOXPkKVbEJTc=;
 b=snSXpS8GFSrV1MsGqQ6T8/bHJ3T5QLSad3BjUxIZkHh74//HTNlu9RLn/YIbcJ4cExj1clip2zHd2aYyk5jzf6J6hv7oRDcXQu7sR3p5gujsBYL0lPzgVdmbdvk2Y0mrqE1nM9lVJLFWO9/Rph2LGOr7LxtDPP1G+CiT8a8FP8OR4K5HQASv04wL4WzWBHH9VGULrWDbIFAMGFKcen5XZmb1q68FmQx20Im/31Kvp1eJykPsrJ9qMAdRhvXLPATHUsOQQVyxYTUsY1TiCil77TJuvrngLdq4my053xZB/Bi+jHB8w8fY1lJ4t0qE5SEw3LTBDioK5BSCEEugasXlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7XCt7yz1rDByxihyoVZi787QAHWKKvoOXPkKVbEJTc=;
 b=J81gyzZ5it/Q5V15CoGntCLFSlp4M3SGZTG7C+BeYonzg5wynZnNvqvJ8Z8r+bPwUKgqxZo8ydMeHohEsaNLL2NQjjPkPoT3+9y6OvscRHN/xW/6vu+PnCWJjlNV7hp8k7bhyY4mHjpOjulQcbauwGLPJQQaZ2sKDXYMl3624cHpmo/RmFGoVoRFIhvG83v5YnB+hsxY5LCJaJ7Hh+hCxTgBIhFBhsTFt80TKwfGc/Ihqj6TjC7hgAgNbjN048aZeC7IPw647RrHGc4xzzMwW4DD+aKPod3UA7pFEtIsNTKTHhRcxHTr9S6XQ5J6S3BR929fphDRd4AGdWVrGwgdHA==
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 14:49:56 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::fe) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 14:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:49:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:49:49 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:49:49 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:49:35 -0700
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
Subject: [PATCH net-next 14/16] net: stmmac: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:30 +0300
Message-ID: <20240906144632.404651-15-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 268e685e-8cac-4ea7-a2ab-08dcce832c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3pKc8WZFNFVv0ktMsyqr/3o473VSVuPDlPx6j4lcJj/EnBlVWesoUJGWQ6L?=
 =?us-ascii?Q?nSp2JMGEi6Uxf+Y9k0iZvCNipOPUNT1Vx/yBsn3jKcsT2WdkOEkEODJYC2+O?=
 =?us-ascii?Q?2lu4/IIl/ctWYFNqsIlSz5IXgUapfQc2ZbPpzmWp3Y++hHUSnhi+ZLK7vSIt?=
 =?us-ascii?Q?A6bagvBZpsJIZXL863Q4/cC+n52K7ZCHOwUPwHmjViaAOGt2nK7yWOKxjLjn?=
 =?us-ascii?Q?u6fCBLHfsVoIniPWYNm+2Ho7vn/CUCt346gdCJaWCdD4wHug05tXYZRd7Jlg?=
 =?us-ascii?Q?VTnsfni8CuU6jdO7T/t9IhXPuhy8Q6YbYWB/jtS2ozh02X6BpvV382/F1lYq?=
 =?us-ascii?Q?ycglQQq9KPVJnGNuNfr45z8d8qA2oCZX3uu7aTojGkKk0XEla0MGoc0Nkk3q?=
 =?us-ascii?Q?Pc92kOyK5GmCw7HSSA6FkCGGG+TUA9sDjNs8B5R0NU97GIQ4Y2wVDtNE57Nj?=
 =?us-ascii?Q?Iod3drl+i7c1R9G45HIRXm1gbYOf7sOIMT8oORYknFuEAuT2rfHxhgHwkr/W?=
 =?us-ascii?Q?7VWtlyok/i5+vAgM61tpOsP+O9Ee3TLgsWVxNZ4oWHCASUrB4WNodj9RA0Jj?=
 =?us-ascii?Q?y2GpHD0J/pKExSTynBKMD1fhp96SQl8cmhqIlJelsBIpc03VphXgoHyxzRE6?=
 =?us-ascii?Q?CTqSLsnvuMvMmHb0lhUJSd4/Imw/mN4DTCJfcwu0sw8Lf/qBUiSzmJUcU09W?=
 =?us-ascii?Q?ljrbZDvfrfWLC247p5ZvW/w6+oVJi7cA9Ysj2ApUxVKHWEzqCw7YIKpwilIe?=
 =?us-ascii?Q?41QCuysakVV13/M2HAWpgjuYX2Yk5QQeF8m2i2wgcMzJpqFxW0gRn2+Av1BG?=
 =?us-ascii?Q?vAb69R3mk8Ye8c6vioXAfqGE50nvdJnohhLPgZwf8EncxfSJcm5seYCAeB66?=
 =?us-ascii?Q?VTkgFJTmFycQ/+s8nVBaJYUWdpsoJFvBps9x3MwSvZAFAHf235bY1zUGPpF5?=
 =?us-ascii?Q?fmOfulz1Wj41wbp6hy78KVHKru0F/x3bsKF8nzrZre/MvIsLjVCF/fF97Tz2?=
 =?us-ascii?Q?mB3GbHf32Iuw+UFWhtJpHIHyKKbF8j/83pM45lnwbROqebv2QNemerrLQlp7?=
 =?us-ascii?Q?SiEQbKuRAjZGUiWkLRT8/GSeftaE4N3Pm+fEj3O9caGg1JKGOKhk3P1u7n4q?=
 =?us-ascii?Q?JL6eVqyaB6vjDImfWYr5qdvYK4pF3SOD3t4dcfb+z3AP3rbp76d6+7isazGT?=
 =?us-ascii?Q?2M58pWdUW469RZ+sXxZOs5sFWF1euQDN+yfK5WtzozOb0qCq6xX/V9XO5Mve?=
 =?us-ascii?Q?/Vn+uX+JgCXTy5ry4yyr1V0jvgJ7UwhC5uMmwMRWjkABxddaYi409ocIIqHR?=
 =?us-ascii?Q?3R1evoiee2ocC6B8VtIV1GzCjmfXWIEZaMpLhmocOGthPBUe5DhXTVCn8idR?=
 =?us-ascii?Q?NWh/U2ONkXSr+biF0IvdYvGvdjoCoJlmfJ/9Ro5EcP2GcyeNBcgwI6eaDxyx?=
 =?us-ascii?Q?bjHzeiwJ9DNC131cML1CbyuXnCjug1gg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:49:55.6973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268e685e-8cac-4ea7-a2ab-08dcce832c3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 7008219fd88d..a7b8407e898c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1207,13 +1207,13 @@ static int stmmac_get_ts_info(struct net_device *dev,
 
 		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
 					SOF_TIMESTAMPING_TX_HARDWARE |
-					SOF_TIMESTAMPING_RX_SOFTWARE |
 					SOF_TIMESTAMPING_RX_HARDWARE |
-					SOF_TIMESTAMPING_SOFTWARE |
 					SOF_TIMESTAMPING_RAW_HARDWARE;
 
 		if (priv->ptp_clock)
 			info->phc_index = ptp_clock_index(priv->ptp_clock);
+		else
+			info->phc_index = 0;
 
 		info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 
-- 
2.40.1


