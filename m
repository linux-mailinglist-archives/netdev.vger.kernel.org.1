Return-Path: <netdev+bounces-124023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0F6967630
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979AF2808B5
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD7B153800;
	Sun,  1 Sep 2024 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NhXTABaA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE6165F11
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190109; cv=fail; b=BIh9QeKMVoPml6pdYWOXz1K18jRgKuR6DOflwo+iFZl22Wvn+206hw3YsNVgnxTsbMvfYQ912WsvsJ/6QTKgDJRvNvK1EyPP3AW/xoTkfqMAusl8MVOm29CIqk6RvY067uj7Npp7RuvRGoicrjke9jdzb8VExPsTvMaZDxOh0To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190109; c=relaxed/simple;
	bh=Y1em4mmNlGqgtp+VUCwvHRYtqzpAu7AIQcSdMPERJSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoeYHQ7X1512264w9vsJRZFxFjtraTlQY1ufUT3gUqFn1EIwnFmpAUh6Xd4k23f6bb/N6bSHYH6hvnbI0aTsv4auNFf1GebdyxHXFcQVWcbBomPsZyhzopwQDO1uVR2BUVKO2ftmITPkWEDITnJqk+LU1NhZYclj4PSvsoL1kfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NhXTABaA; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFbMuY7ibF+yL3WB8+Fr7lyOQ3VyjwJlkDd84hjrW+wIjtR61iioPE2D0dJWuSyg3kNVn2DXuvMhMJvogicZjIPGYrqCouYUFilPkieNGQbf3H7jw/S8mDte7CbuGLulGb+W0sMF258YOyiAXkYbgWZP4akR5YzcXv7bfvhH1+2k79IIBRqoyH327h0cvkbQ9VwRUsQ4ZuBrgr9jl7A4Um58mbiapU2KVK7HLdz3yse+TWp48aTcbEQGOLlgjqBO3NFSNjma+SIZhElUURAfpPwjsBff//QfCarjGBjgkv1fSKFCGUyQWqnQURcOyP1Dkr0JRTOU43ta/mPQc/7f3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrXgOaLSTJVwh9UtymSvMc+fz07VtXGxt9/EIBW9558=;
 b=HSzj8PZTc3qLQNSxTT2v/ZcBJHJ8fa6sVQR40se9WB0aKqwa/o3kXkcSaBhjjPSLTq40bo1dOixIq+Zt+d+FJ79rQ5Qy3Nen/ZPs50rLOd73JbfkGlmzs5yrn4lO0sksNfEvOSAcRFa1OFUdRltAk6FEYNOIEzJNiqrqrIcsv+e8HpHcuKoyeMWL4bfFe9oMjorY5L/rPmmMu41sVUEPCuX7cJrs/yEEqMHh9Tk9KMrqQ2VxOVQUtvxTsmCNTeBJfTfM75dUM8tZ7RYFdpK1tS+H6IlQt/b3pjpJQIHil5/84q0ePuNYFOWWC3XoiPXPFg3hqxeLYtqYOuO9DipqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrXgOaLSTJVwh9UtymSvMc+fz07VtXGxt9/EIBW9558=;
 b=NhXTABaA6yDPCahB5gplzXUjrbXH6yor6j0FD3lw28ZcmPfXzpECxKhcQN9QTsrCdmY/b49pKNqUJWPLtZK3jcyDzhgMR//ICW6IropLTIjuan5t53YGcXD4yeb08+EIo3nwqEOpmh2h+gzx5PD8WHVVZqBtPq4rhSR/HH8k+ebfHvT0iLL5pfM7exkcxJqOQeeWJwpyMowgXmp6MX8yrC8gU5cI5RGnud2ZSKFkqrUlwcyuC8RMIyX4l6wIDHswYmHiRVwBIBy0B8l5jzFcmklkA7JOz26BN0K1uhO7KuXc7vOj+sK+E1GsiVn6JUEnhyFPyCuvQaDYq1+1PXssfA==
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:28:22 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::b5) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:28:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:28:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:28:09 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:27:56 -0700
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
	<gal@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Willem de Bruijn
	<willemb@google.com>
Subject: [PATCH net-next v2 01/15] ethtool: RX software timestamp for all
Date: Sun, 1 Sep 2024 14:27:49 +0300
Message-ID: <20240901112803.212753-2-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 3969a38c-3794-4940-5f0d-08dcca792f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rv9j5QcCTrLuP+qpgWD0ThnebX4pNIvw6LvJaj/WfnLT2GTWZXNHwGBbxIUl?=
 =?us-ascii?Q?U5XoiQS43kLHdeftIyU+WMjhKAN52LqbZzTGVPIqkCflqJjW9/vv9LVhwvMF?=
 =?us-ascii?Q?O1rsGgUdXdEaPeIUsZq7hv5zVP4oKQYSKCGDFZNedD43jubn1T1DIv/tOOGi?=
 =?us-ascii?Q?CQE/V4txWRTRCxIy+z/PBnvC1bNvJJCAUBVYySzl+CSDpK7cCrtL4IV12m8m?=
 =?us-ascii?Q?2HZ//bYWyKq0LoowrS3YZAsUQViLe5RsgPeP//zVYhDI74JiWK7PmpmkNFKh?=
 =?us-ascii?Q?9koVTWb2psL2QhL+SdgcrnXbx4PuqohW+/X1T6TB5xfTLMo1PKIIP9j2gIsU?=
 =?us-ascii?Q?LD+O6QYTTP8ZhpcUIDUBRcRTOQDN857REnBTvc6CV3qhMaz25zMOuxrvHQ7o?=
 =?us-ascii?Q?0blYu9YhJ18dBUqwhtTzBZqA259lr/CFR8yPR1Y59RV/zCv4GSteK9TmMOSL?=
 =?us-ascii?Q?PLdFdLjQ9bxwPoqqbX5ypHqXbdbYRrAFcXcjtnY230lz+4FNOwwO41u/kjYs?=
 =?us-ascii?Q?YsomT1NgjrR0cg4b7m79szDXbT1bRo1OK15qEAYhfa+qJemBsE47jrpTcLNQ?=
 =?us-ascii?Q?DmlI2DWM6RB/O7i458CbsV/r0mNhbnRZ+roWXp1y0ujDpMjykhfbQ8OusW3v?=
 =?us-ascii?Q?Q7bBDgvgliDo49JUPKFRk8wcECVQIF09cfIknmue/JeRp01+HTwQXtaEpfxP?=
 =?us-ascii?Q?SS9HMZjy7OkWlP7livFaq4x6ZrGt73Jtim9cvq3XfkwgMyL4GJlR/iZHDXs2?=
 =?us-ascii?Q?HLC307q7Hc0ch+EDqdIZ29l9xU03YVp8/fMmJcot3msrbe7olShYQRJHgmN5?=
 =?us-ascii?Q?GLtKVr/yuxLAoKSktqbsu7dpL4OcVXqOKkzKrK/k62ubvff8Kywv94esftk9?=
 =?us-ascii?Q?Px6W7W1QAEzNUkT+0LwVpFljcPj1X1Qvtec+V5UrMpx+xVtge/2DkyRShLvt?=
 =?us-ascii?Q?/ulDXv5XXEm7vdpt6ALK9R53uM6/kkPk1lcAdpcr1Qr2GTNtUgAQceIz2kGE?=
 =?us-ascii?Q?xvQSEcud65OEmCybFHjlbqldqwlqEZSZxAx1IX+hW6s7vfZO+L2aHpIpSnMu?=
 =?us-ascii?Q?BYk+wHTVZki0WW9jqi0FXYFAvjgQZttEgoKwlWaYCnGRxkbx64e9bCiLQcS3?=
 =?us-ascii?Q?S/FPnGjJdqhiLdFMJwBW7Tqb44UA0craWCai9RxFfAVsBDy/4N3Z9Qv0Zanr?=
 =?us-ascii?Q?oOj8BWL0I92qdgxTCmsVFtQ4StN1lusQOrcQEDjGH7psx1Jo6ZuG22k5az9U?=
 =?us-ascii?Q?Mc3TY3tGWJN1lpJpiA/iyxsQ25Dfny4Mp0VwPWS41MFAl9jt8xcMZVAHk9pd?=
 =?us-ascii?Q?wF5JjNX4fxRNIMqDt9t6PGUYL3cujb8+eOjaoZxW/HdcnyJ1ZAYrDNTIdU30?=
 =?us-ascii?Q?ndF7tdrtcVwO6I9lFkgWXBemkDQVaAe/3YMYhTGBOB/TqwQ4U+UVasUSiUXi?=
 =?us-ascii?Q?U6Qfy8V4TmNa6GYiU0hpIM4E0n0gRXcR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:28:21.1346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3969a38c-3794-4940-5f0d-08dcca792f4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794

All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
net_timestamp_check() being called in the device independent code.

Move the responsibility of reporting SOF_TIMESTAMPING_RX_SOFTWARE and
SOF_TIMESTAMPING_SOFTWARE, and setting PHC index to -1 to the core.
Device drivers no longer need to use them.

Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Link: https://lore.kernel.org/netdev/661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch/
Co-developed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ethtool/common.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7257ae272296..aa7010f97152 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -695,20 +695,21 @@ int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
+	int err = 0;
 
 	memset(info, 0, sizeof(*info));
 	info->cmd = ETHTOOL_GET_TS_INFO;
-
-	if (phy_is_default_hwtstamp(phydev) && phy_has_tsinfo(phydev))
-		return phy_ts_info(phydev, info);
-	if (ops->get_ts_info)
-		return ops->get_ts_info(dev, info);
-
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
 	info->phc_index = -1;
 
-	return 0;
+	if (phy_is_default_hwtstamp(phydev) && phy_has_tsinfo(phydev))
+		err = phy_ts_info(phydev, info);
+	else if (ops->get_ts_info)
+		err = ops->get_ts_info(dev, info);
+
+	info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
+				 SOF_TIMESTAMPING_SOFTWARE;
+
+	return err;
 }
 
 int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index)
-- 
2.40.1


