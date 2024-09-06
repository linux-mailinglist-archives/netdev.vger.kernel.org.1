Return-Path: <netdev+bounces-125984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA596F768
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151A51C22672
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03B61D1F75;
	Fri,  6 Sep 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tKY8eYzy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1471D278B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634190; cv=fail; b=oRP+CqQ3DBnFw+fXuCdlr0WSlsjnMTOq1QN0fb9w5r4MyCM2XyUNcG8t7pAaEVcGlCRyhRcygmz/9ux2l45M0EdG5cvwNUGcWahBheiNtqWMaI8H84Qxq4dWeCdFI8XuE6rucNHh+Hk+2FVvQ1VBrYfoiOcMnPw+3RybaMXNuSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634190; c=relaxed/simple;
	bh=QBO+X0/jovXIh3//8o3gRKdLEbdwMQPOlmF1i5xXJF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2Zh90nmGISEAA7XVBvlu/zmL4aIoqHNs/tp2+s68M7Y8k0yyZ/TwuIAURmm1g8+BtQ8sxNkrzYrQMLxw0rygi++cUsSW/7Vp/8jj6aWulWlSMsdaZKQTIddHd3MFiK/6TAXDF4hTBM3TNSyKIrav1bFqO4O9lDiyj2q+Kr/oxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tKY8eYzy; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umi5sYJmxaTG/7gf9O9Pt4XQjAx/dp8KsN+pRoKg0TEN1QFCGWxBOHqchidsLUh5VWCaoE0fJBzdZCx5UrVW/KkbY0kOX3mxjgMUbZP+oacMjxsb2tUz6DsL85UxhI35CYh8S4Tl7wy/z5DeOeCXF0t+yLNFAdgKlsQWvq5FXVTqSNwBiVxnVX+vWgEu4kddwEGhKEsLEr5KtBmibaFQdy+u0U+pwpuCyC+5e/xnRqQRjRbIUaYECsYiKS7YoQUQiTnVQeUBIlkRm7XrtdMvviIEoNzPjGby5Z1Plm8exZZoBkOfrYQMPaauwFuE6yR3iLkKZt+7T+B/IHo9Mq/7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b074w0eWMly0zkJrLTYf2pz1mN7CQ9w8yqOAjG3mAHk=;
 b=IfxPSgR8dsdkjQSnd5gWWF7cvJW9fikC1vFEQSEL/VRoJZpq+PFoEHLSzwSi5y+foDVqDKRRFkHxh0Lt7o23iSueO6pnYgSFh4WYGxRtN9AZVpVX0rlUov3I3beptTZPNpOFlrGvyiXvmg6uP06uK/NScmwPOshEkIfZUAtfJF9mslREo51/E66dLlgMEYNv1Im8q+J5M/0sUPGVxPEx7CA0nRhjYc/0fc4mKdK6U5L3IYAY/UranXMevsxla1AHzNBjCQDqeedM1p96QH+p/jQIh6pXT+IBxGdoqsrOPDBrR4KpxlRWQckFNLmjZXHbH3TlbaKMAZ0R2SE+VUa6Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b074w0eWMly0zkJrLTYf2pz1mN7CQ9w8yqOAjG3mAHk=;
 b=tKY8eYzy0AvMal7xb8kcgkGE9nv0YDyMqT+DhlQTqKXIkOKY+DgKrjUJHbMYOgmUK9PEITZhG1yBVIHnqW/7i8My3/JPyPVAka4tuoV0ro9op2srAjq1dr8GwfVGj6MhqAodMrbgb5gjyi6MzRSFSbrEfdTW4q7EnDetwSp29rAbUbQgox9NBb5R9Y5/Rov0lSmKaRX6shF2P7c55SJoLHtsO08VhHkDoGy9WH1e4E62JNxbBagszAi4V4x2fs6dwcxUgR7kI1JGYm/HwAfnyUnycbuCPcVt6Xg0DavujT8apJvxU6f+5T8mfMZMS2/GvHrBSbxs4CgZzC7/ytkeUQ==
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 14:49:44 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::93) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Fri, 6 Sep 2024 14:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:49:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:49:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:49:34 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:49:20 -0700
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
Subject: [PATCH net-next 13/16] sfc/siena: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:29 +0300
Message-ID: <20240906144632.404651-14-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: d0682266-9708-4faa-956a-08dcce83252d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wsnvy/qEB9HeTYpii3AWOJvEOKCpUh3sqlpzEhMyjrlc4YhEn9HKbEIL9WaU?=
 =?us-ascii?Q?/bjZpzmYVjIUmuntdboWQNtqOPBn3jypeSaOp95zRmqaqWoLCD3ICGs9PcEW?=
 =?us-ascii?Q?OVXOyBxfZM/uGT9s2sZa9JWAoUp70SELrgr7Vw9Hdit47GgK0GUf6U35f7r9?=
 =?us-ascii?Q?wZY+akWKPaAQjbUhQC2zDaQyVzcxxWB72dTKCdIRzkeI9rJ6ATYAa7f2uq7r?=
 =?us-ascii?Q?7fCqqyzdPaU8v1VbHY33NsnQUHTelSD0TjkrF8stYYUevxODgFjS0zVXrzmo?=
 =?us-ascii?Q?UgzypKLqGcOxJMoMpvLpuiw9eV/nMRA7Os7KoUnkc46kG2VOswJEjrpIoFDm?=
 =?us-ascii?Q?gbkfvCVzH8q4IuCwm/CSuTO+qVfLxN4wUGvbyMnWQDCgUni6bG/MpqHDC+Kp?=
 =?us-ascii?Q?rcMdg/biD9KppppL/lvaReIbOWiQFr4kfkBiRpFJLwXa/siuSmF4D15K6Ceh?=
 =?us-ascii?Q?PeuUCuniwWRMb6SZxa2Pr4P+FYZpgCraoapOSuHTXksgEEVd0VhQGW0LlBLa?=
 =?us-ascii?Q?9Ts8UxmYbJjzzJ43kvivuiDeANSeyMhuXnW0E3bLCiGgHDTLG/j0HxJNL0zr?=
 =?us-ascii?Q?0c/G0kTaEw+FCYn2c0tIJRtMFxOuEPltwHoOrrlfeQSAVgyuwtHI94fMn2QU?=
 =?us-ascii?Q?HWQI+GkcHleAF/j2oTaZ0gg8DAzU9kSJS0UghyVQVQC3RLst87fSY8tmCzY6?=
 =?us-ascii?Q?wr3OFrnSCZRtbU1cPUGazNyZVofM4t8aM3TucU/rIDCbQ87pgd6WriTpzhxB?=
 =?us-ascii?Q?Ja9pwyOMhIy9W305yC1Qxs0DwqCkt8/8Wkmc/AZc1rZ/tDLpS69gfnl9a8H8?=
 =?us-ascii?Q?HydSMu4yAjzkrnBkeRxDp0m7dnW8dgqTYkNzjWELhnglJmtdkMC6iTFDWBO4?=
 =?us-ascii?Q?lu6zpdr7JM2/YfzA2r3CpR+PxvTA/+uqsNR3OuO72swbIw/+3vScuziCsGSN?=
 =?us-ascii?Q?TbNxB0MUyCGh4149qHDfeOwTKYKSW5OSOkz10IzlMgp8rFhy2xVuttmSDEtD?=
 =?us-ascii?Q?ZkYiNtbXiJ2cyxbXPQkM/jxJQZqGnwyiyoXJ95Pd/6o3MqEn/+lR4wmDk+OM?=
 =?us-ascii?Q?U2GSodi5NN5Qh0a6+pGfcEbc6+Cp06iBwlOGagshBdB/wa1mqaOq7Nssi0Cz?=
 =?us-ascii?Q?4aFSbEFa8UQM4rxsDS6DCW3bsiF+cKk9XWhVRZrUaoVuGKO3wV/wrtMciBum?=
 =?us-ascii?Q?ng4q4DRNyF3z/tlRm8cl6qvTlT+LR5ULOQftITyegWyMsHzQcWTEHxsNk7ll?=
 =?us-ascii?Q?pmGMuVLUW9iEhTsWJzhCXzaZvfMGycM7+5yco8BkEJztx0haKkDLAI3u/R5t?=
 =?us-ascii?Q?dFXV2V/48QEB7MX7b2b2TAPk2OENrZlnNDsHHUk4aWe4xdrtq6VOCU0MH7A/?=
 =?us-ascii?Q?aFwI/+uuaZlkSDJokbF+uYvqbADaBXHMxgnpFMD4uj8aIjaksAx5v5L91La0?=
 =?us-ascii?Q?WG0E2xsBwTcmvh2LKVRXsBR+B4FaISDS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:49:43.8456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0682266-9708-4faa-956a-08dcce83252d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/siena/ethtool.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
index 4c182d4edfc2..f4f4df687708 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool.c
@@ -230,11 +230,6 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
 {
 	struct efx_nic *efx = netdev_priv(net_dev);
 
-	/* Software capabilities */
-	ts_info->so_timestamping = (SOF_TIMESTAMPING_RX_SOFTWARE |
-				    SOF_TIMESTAMPING_SOFTWARE);
-	ts_info->phc_index = -1;
-
 	efx_siena_ptp_get_ts_info(efx, ts_info);
 	return 0;
 }
-- 
2.40.1


