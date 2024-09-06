Return-Path: <netdev+bounces-125986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3A96F76C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451B71F22911
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238861D172C;
	Fri,  6 Sep 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bh2SwBXO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998E1D1F73
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634221; cv=fail; b=CHDtbrDGYBW2J5PcMahzQ1A92LqygKIFDj93Idd6IGKB9c5nyFy/MAZaFD2uznsMgkajiqAUaqCta5kL+1vrsaN/6iKe/4KzgC5LJyR9SlYKLExXKbH9HfTjwYKVHpDv1AzM70Ov2g9OIE9HbIMY4nq/7JExmKFB3y1CXaJhnXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634221; c=relaxed/simple;
	bh=FRpb043KStKgkQ5ObXsKZdB3mXJiZL8FHqdAppqECl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkApOckmT6UT9iU1LZsSa0clYb/uvQmGIrWJ80EVytSfamc46Yp1oDxPRH5SfeEtb+0FZPQHQPaMCItvSoJH6Qp1n+yvHD2+GPKMya18YLLfh6NYg+vLHkKbsn+5TMPeoM9FrKXZQ/l2yg6ToeeXoGKiUp4Yt3J1gdEaXU+L9zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bh2SwBXO; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Khs+vNluoXI/gfDfzdHy7f3oBU5JyBICzfUjOly/xpwB5jIGGv9pJoF5Ojuc6ITYyEZni759wagNynyFLlk9ZavYLde1N5b7hOxHd3pWCbFhW6oZol3SoSdOkPbY2H5K9dxY1nNYmm4MGov6P5ECS0hNQtrJkPp+FjlMCKo0zhXxxUgbOxP2B62rMaF+OiOv9BTnAloFh+haaKMp/3MZJL0MnWGYtWeLPZIXr1d0SIln+b6qaWCUsvGZWk2TN+7QhRkqV0acH5TBCrDOgtSjXm0D6++NcMpN5JHb3I67zyZTyrcm6bTc9Omk/CbdAyU83Wo2HY/LjUQbd413wj+dhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZMKSzz/jZPDs6tSvxwP1+fs2Bf5jZmg74dVXWzJNFg=;
 b=IumwWWcfb1iLtoBxOxh6WWPUpbYLXwBwm/Xyidia484SXFwI9awCKwiYm7GvJtbZxuR1tuUJ5aCybsxEG4ohLtz3dHIcvYbXaknSo42vZHVWD5ioXHTEVR42O/Ehpp+XaKC71l/s8iKdTDiel60gm1U7u07XDnent062mVFIztCoJz3woiIjwWNoDnD7PPIMI9eGzklVVrbk0G0RNKXpIEQx8bISFmUHbw2hvB9Xcf3tQaODCV/lh3SkOIQPxgsLv9bN82rPZ2yT3/RVqDukSIPWfGHpGxac4Cznqa8Veqa+ivMfSOoizDgFszS1fQ73hGSdYDFojEeUXTdqDMaSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZMKSzz/jZPDs6tSvxwP1+fs2Bf5jZmg74dVXWzJNFg=;
 b=bh2SwBXO+2FY2qpjXd5+JF2oDe3nUhg+M7BRJVVaf0gJyn1waX6IQvCf6eAEqFDxkw5Oe3RSzaLLzR9RFo59SZOXiWpvpUAM/wrsK/LphkPuAMz4IjUkyeUbqwgCEPBVPJ5m3/+F0gofZ4tuZrcngGceKxfDBGuRb0qSH1CtjPAur/SdecQfYanhJ9qZ6SvuHZJvLGuGpGF+qBbheapZaX+UUTc96P0clRzHhj7Klv0SHlxfg3QL9PqMMhuguNAyMw5hTiff1srxMBrpE2uuitqLa6DrVgTjJhIaAiMg6yaZkERLw4tQt9stldx/6DVQgWYL+aow51G/fbnRYz15SQ==
Received: from DS0PR17CA0021.namprd17.prod.outlook.com (2603:10b6:8:191::16)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 14:50:15 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::81) by DS0PR17CA0021.outlook.office365.com
 (2603:10b6:8:191::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Fri, 6 Sep 2024 14:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:50:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:50:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:50:04 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:49:49 -0700
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
Subject: [PATCH net-next 15/16] ixp4xx_eth: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:31 +0300
Message-ID: <20240906144632.404651-16-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b239017-6a3e-48bb-b19b-08dcce833757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fZjGzmadwfNOZmwJUU4UlJa0ZZOuJKfI7QZL73RlLKlS52V3Blu8Ar6BvWOa?=
 =?us-ascii?Q?hagop6ryNfrvfinyz+hZKSMjILZzN7slSfqkCS/sxheLGc5uXe/kYJF9s5+x?=
 =?us-ascii?Q?D2DaC8rgZowyTXx5QxzLJPLbRcnRSNH+Fmgyh/eBIwgD92EhMqX3i7SIeQ7K?=
 =?us-ascii?Q?3cA9NqpF65k2JHMpNvihckCNngZw9RnigUfGs3/ybpSZvluOb95B8Vf8kccF?=
 =?us-ascii?Q?O6raGyz6MiO2m8v5mYzlUpK6GUQLbO/sbX9eSVjLlFz8FKQ4TLFsir1IWvaG?=
 =?us-ascii?Q?pG95H8kToORR/xd5H0HqKQQjsIGogaJcOSUnftsbXdN8rGMhla3brAzeuXiA?=
 =?us-ascii?Q?C+0s3c8+f3U9Dg4XsajGuOAMh9GmIKq5VRH1JWbjftGPBB9U0uTtZTolm/3Q?=
 =?us-ascii?Q?nH3n+esVuf36PSaGcNyTKfukg1DRXh3bEnpyzKDlMOK3veYenyDnyMwiAGPs?=
 =?us-ascii?Q?XloBmmc62igIJt1Di2VcfvIvNJIarY/CYy8NWgbYOMMTeJYwTVnwbSoa6zCh?=
 =?us-ascii?Q?w6zx7EH8aQGOdvCDwqfJ/zBbMW8RYg0eIrRx3RnAwnwuy9kDK4gPuXTImcnM?=
 =?us-ascii?Q?R78fnXha45fsTDjn+kUkkIScDXzf6NOFyjqpB86lhYVkg2B6sjw8nwiM8Ka2?=
 =?us-ascii?Q?ech24LUHuOVUkILzq20jmoCVhbpPUsHLCOuRnBPmeLRv3ldTwXchwgdjAeF7?=
 =?us-ascii?Q?wy1k3WVUlOdVHwqTaV5P3m/d30W6Lnl8RmyeJIV2bpSNEV5nU6/rdojrYlym?=
 =?us-ascii?Q?TGk5ca5ot9GQZbuCdaTnO9KRo1DjY5vJ9XyJ47w6T1v8Q3uvP/L06T8i+Pc7?=
 =?us-ascii?Q?4dSY7l9pTSsJl/i4I6llJqRtZUJkNAREWfQcWAvFJ+MX8eAjPBlbwAE5BHqw?=
 =?us-ascii?Q?dZ1sdzLQQuTjIUw45mG/LwdamBijk932sTKjM+jq/kX3YZ84OT/7czT9nhF7?=
 =?us-ascii?Q?kbj10f/QMvm7iQHnERwMJuVb7mXDWR4n+D38aEUBashQohegAtG7NP3NqL+x?=
 =?us-ascii?Q?KLpliJRP21aa22PsilW/9WtJyH93/5214ThriO2pIyAM0mlucNEPDU+E6MuK?=
 =?us-ascii?Q?fouJo1HzweHb5FalFoE+/bFkD2eyJIb0ko0yin+wyGvQCDamsMbVM+yFLnT4?=
 =?us-ascii?Q?8OzJ/RAc7MzdgCyL1kMoY6aOhfcnDtNgxObsHSM0CaDwfSI5FPuha9adRwp7?=
 =?us-ascii?Q?Szx6auHkExZGSW9kSuQWPQmDGOtG1FGCWbamziirhD+hwOJ83wqvyQfyd+WF?=
 =?us-ascii?Q?ELbtjb6A00oSi/9zQSkzcglc7gpZNCuLdpjbIvkT7ftD4SU+8Ar8NScv4KH2?=
 =?us-ascii?Q?U24Mfb6jhLe/qxzFB2njAaKVQkPzNAiDv5uD6BQSQWiijrO/JwrA/a/BTDue?=
 =?us-ascii?Q?xul5FhbYSPA0SXH5+Ime/kbaKGMVBw4E7F2M8dmBJwU/42yvf/0kE2QorWQQ?=
 =?us-ascii?Q?rZ3hBvHmp6Yr8nfzKQNdaOshAZL9YXKV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:50:14.2268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b239017-6a3e-48bb-b19b-08dcce833757
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 56df37f8d50a..aef316278eb4 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1026,9 +1026,7 @@ static int ixp4xx_get_ts_info(struct net_device *dev,
 
 	if (info->phc_index < 0) {
 		info->so_timestamping =
-			SOF_TIMESTAMPING_TX_SOFTWARE |
-			SOF_TIMESTAMPING_RX_SOFTWARE |
-			SOF_TIMESTAMPING_SOFTWARE;
+			SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	}
 	info->so_timestamping =
-- 
2.40.1


