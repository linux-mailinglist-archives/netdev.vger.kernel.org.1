Return-Path: <netdev+bounces-124852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6296B383
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675221F266C9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF704150980;
	Wed,  4 Sep 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PKVUUEZH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5A1494AB
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436320; cv=fail; b=VbEI16+oO25IYhgjN/PYNDV+1TmAhWeRta2hem5Bj8wI1yGSQ8sk1lsOMAnJjliCyAyv8uUDrQZWBY7Eyv9oFAFEPg/7NaMGp1pVpbjY9wCykVsr0P3uMdAyXGdBOt22ggIAGHWFc5sMbTAxk+PPD9t0fEH4N+TqbgQiCEEalQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436320; c=relaxed/simple;
	bh=fkB8gCuIioIW2TEyvoWy2C/gQnsXxQvq65CVEUKYmjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIGNErPZP73m7qCxDtXeHL3nJFIZEd6O1Cie+WCQ0fY0qR9k7nQ3Ejin3VlwcHNtosBnmVQd1QGTXHpPwoHfYRYWqWIsomfrqaJheAQAC6R5KcjfOvDH6D4fYazuFBsVUj+8aPfh8QbLgAFT8d+6Jez9hWDDOmUmxeyJmu2X9Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PKVUUEZH; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbWyeG8vuC0fDoEogr744e/PWYqB3XtZnqrrjhKfUqHFS/Xwdfl5AJWA5BWzH2rwEKcZtdAu5EZ002zLouLyafyHnqAreMZi+oGjjQ3sNR+PaS381n+5J4WKkElRsIaomiY6+QqQVS9MOIzcNClaiqMsXXTJL3xUFktC6zECCwQWFddpqZLDE2ew/YFh/Bea78/py2WTpaHs74Q/il5ecG/0pynKZRlXGUFQu4BFpN8IsBeJ+jLmeSJdcTRzrkEbXM34A82NlBPN/QrBu9Bg1BWtOtePYq+PUydd1kKItiQMkGs3CVAt+5FmioPfPPVRjoqLd2ILTf+6CxWycKWa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5UY4GqlVzfAlFrAipzA77mr3kTzSkgwACED7Oc9S04=;
 b=eppPsN7tGXwActeNRlShIwiJboVzuVPAUSuM4gKFwjxUf+033JHqKiPVM+2OnOmmhaDWuIhD6mMIzyFvp7/0mCgynY5R0LxwbWidcGVrSENzXVhs4kMCShA53+yyeABSzXi0SjhcQkTQ/AyHlSZo0biETW+7olhW58UrVS5R1UATX1ghcCL7H9Cv0WGkJfK5Oi1C7EL/pXZQoSrlZmQI3GJIGtyVmfVkrxD1Z1HxufVuy8rLWofJIHKPXbe/8ylk6yzZOZmIudeGo3vkh6kA5ku8OgaftZvMKUJ6gVX7PMlxMbU5/iV1hOCMnMDm13DQcrPax1b4kEjrJbB6blMjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5UY4GqlVzfAlFrAipzA77mr3kTzSkgwACED7Oc9S04=;
 b=PKVUUEZHzf60+UqnFmGhGm9EOKrb+jP4hMuv/+InUz94ikqDjYm2VT0Oint+9vTz83TcvGEbjSXjBjE1xGc+OF6mptPpaQE3MkgWXDAJRjNK03PaKA4+66VlbI1fBH99jLll8Y0bE8UNjyB9QSwWWkogdRRnZBKnKmY38+IquSjTGhHOIzra5vRuQeJMziLc+mmlxFekNXcYvNHVjpKswB6e/Qa6QY7Kf1MZYiq25OO24WV3Rt14AztC4NK2O19FWKBV2AWzAD1jASrHOwygrwJY6YXaikBf9ArD9/ZCNzj2nPXCVCcUSgNuoyHjwEPHo+LD2JMw4XX6tABPHZZRgQ==
Received: from CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::12)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Wed, 4 Sep
 2024 07:51:55 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::dc) by CH0P221CA0014.outlook.office365.com
 (2603:10b6:610:11c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 07:51:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:51:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:51:36 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:51:24 -0700
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
Subject: [PATCH net-next 10/15] ice: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:17 +0300
Message-ID: <20240904074922.256275-11-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 1370e5d9-049f-465d-0850-08dcccb67206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/vuyPrzPufOsenO4sMhJy7cP7cggBRKsbB4rqRN54Z4nK5nfYJ31aXe3wn5r?=
 =?us-ascii?Q?wGUROh//qwbEn970/TFl4EYtYILkLVIdWDy54J7knfSMLXGaF6YLlIkAB3HT?=
 =?us-ascii?Q?4TUTCZnlSgmoH8chhnJxwqZS087lyea3pSWPYQhKrVcypSOFDOnnQtacgzua?=
 =?us-ascii?Q?T2ETxw9FZOb7morSpk3cvjgb0MzXKFUpMp0VATgH3jZt6CTsxtcF7M5c5/2X?=
 =?us-ascii?Q?Ku3XdfuBV7X7nj93aQEzB7PAYiW1DIqCSudogXh78NocaU7/WL0l8BtdKSkV?=
 =?us-ascii?Q?K9YsSOsPRaaDUABmfGi4cXPk4C1bZmotGgDcHg7I0uPnExBMG4MmWkp9e0on?=
 =?us-ascii?Q?syDuaGPlket2gV1fegQduo7FyOh7r7jxKGSdyPT512TnAuUqqSa2Nss+xjig?=
 =?us-ascii?Q?Zsnu22GPXYm9wgWXCnAjUkY5+69XbgNPAJFrInJJnv1H7vxpo1BFVGtTZ7q1?=
 =?us-ascii?Q?zwvHSie5oQVSaJshoUa2HUoGbNfSo4mAL+HzJ6Qiil5z5Zq/3tZcAZZk3P8b?=
 =?us-ascii?Q?oNQR4CyPYs2DBosFlm/R8zPBzxzwA57mNmNeKpbP49Kw2A9rkT5MtzXOdHFs?=
 =?us-ascii?Q?GyzptdOrU3n1WDKgjE7/MCaAySMWDNx06/UcsEP6ivohZ2kLdL9koOxu9bGg?=
 =?us-ascii?Q?dm13RhNiSdFb1X0zu75NBhP7ROx1AZeiMZzZecqEICcyW3clT/1EsRoPPxsm?=
 =?us-ascii?Q?alvkAZo05pIc4ybWNGDRWj6fRw8UMjJenML8RCR8zWwES/U4uZ8b3H3iZgbw?=
 =?us-ascii?Q?06RKCfi1WqfbUHYkj75j86Qeql8/hlRJUUXnA5erHFWMvVjM2cyFS2mIrOq/?=
 =?us-ascii?Q?i7hoeyxC0OXKZfpuufUgnt6wOZpkPOd/R3fJQBFSgR3sj+/qFs/qPAT0zEFV?=
 =?us-ascii?Q?YNSkHR/yJLeeXhlsmpEOkkfLQVnAQBDKFY5GhpyTB+ShjO6qCTfbRPjY56d0?=
 =?us-ascii?Q?/xKzzbYcx3920wzk5UASnzYUcolVHz4L1MJkao+v4ed4YvN2wcl363bZsQmh?=
 =?us-ascii?Q?toiIjEnk5CGk8jx5vZLYTlfttmpbQJTCKRqJ4HW4M+24GSnf768v9dnyXGWJ?=
 =?us-ascii?Q?4uEJfKlcMsCXYtBbCQQ2N9s8re+vyudmP3TuH1rpq6vL9w7OYv4nYhwAoiL9?=
 =?us-ascii?Q?m2OWKM6r5XqU0SPMXuldUGrM8hqTAapKeM+JNzEE7qd6lWLRms6y0GZtmGEk?=
 =?us-ascii?Q?kE7cfVWbh1aYyvxsY472HLw4CoZH4jqlY2s/WRdOltyEWO3vpzZMEqb2VWm9?=
 =?us-ascii?Q?5m/M+JN0/wJWD9KC8Bq3ovST6XvTVKGpE8XzCOt15JkMPu3hS95WjxwHGkko?=
 =?us-ascii?Q?PuRNt4gkeeXZ49WZ7jMx7kee/+9gwsvfHTnPmpXUKMOI2w0vv5NYmIU4M7M6?=
 =?us-ascii?Q?y7VXRerCpm9LmT+OdDJ7H/GtjB1baK5TxwQ9GqhfK0gbGpf4X95z6TjILxCg?=
 =?us-ascii?Q?0bAkV2LCVTNUAURZRxk5iMsCUrTrrih6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:51:53.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1370e5d9-049f-465d-0850-08dcccb67206
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bc79ba974e49..8a32c225e22c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3792,8 +3792,6 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 		return ethtool_op_get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


