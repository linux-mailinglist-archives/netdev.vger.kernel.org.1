Return-Path: <netdev+bounces-125980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DDA96F760
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403E71F216E0
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3E1D1F56;
	Fri,  6 Sep 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QcdHKY4R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C041CCB2C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634165; cv=fail; b=dkACy1THjFDWa7TiOda9nmH48u1iE34G4gLgzPLBRjs2nQG2mgdEHEp1GfREyiYWUH+iAzzL+JCkvM7qgksLg+w56g4MBnij1uhtbjd2u6VZn8BTGn5Lqv4MzXQaAJT+8N/a1+uoHm/k3u3vZT1d2/a0mgOENtdFeW/k/q65/xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634165; c=relaxed/simple;
	bh=FpfaweE/csBuIRc3qHPpjIrNUxp9AexLRg+ITHIh8ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2Kn9eqVPqBLcRjEl+OU3tuR+BaSmZCw7dIvLKNdHFeRtK0lNfRtbn59/l9O7Hjad2fxFORFIgi4DSIEvDKDsmKYo6mAHoi/Ilgwznh60x+K9PO5h0Q5rC8H+WIOCcmmRoUhDNyHYv38+17iojjMWuixhCwcCsPAA+Ff1LTgdHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QcdHKY4R; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6LH0q37Hi+TVeyDSFQICgiqqQXrfW/vFRYbgvw77iHGt02qf5rUIhy53ulQre/4RqZBOcn7/xvtfChDblxdChHQkuu4GqaYcNZgSyWLkrjXvwu1E8dixn8hDdtmguwHFGhn4l7NBzxjUL+kgTZ/57gpC+F29+objHSa7vXKJi9mwY0JiT0lGVFo4gs9Hh3uKUZHuhUpDMkcHP/p/osAInmOY1dBgfXBgEQK8oyPjeY7hVf5mHddYGj5L6clYWVDMYkPvis6gtbBtXkdKtSqcjGI5hlSoSWjnIGn5tDP6eUkY4ZOBM4Ev7L1rwysrqHpB8Fb+PiFx4wjqgkfi78OyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvEiPWVFBkC2jQitqj5fCa7ZwE108msTebVTuSsdLDY=;
 b=YwKpK1GdUPyLO8SJULkwrP1TQPpgrPub6jeJSXtkBGlzVX94tMv8NvPI6v0JspPfRjLKp2SeBIm1AsjmWzZfQiuUwJi0bJ0I3FsDwiY0KMzDcmSz+lO0PkciUEriNnKutFcchr/ZfGIS7fcajqRn5mCVpABQdQ3OeBU2UCTy15mWCVrau9GbdP/4c+2XVsrRE6Uu7yuqrKkx5q8w10sJIkmkH08BEV/1qPcOK4o8TIDsbKY0MWrWLrtGVzUQYOnB2oEEkAONfHWrgATbgxGpMYQLwnv0zRV9B8FkAupO55ETBB6qZTQnPLw/ch/mtLE2PA0No24PpF0LMjhqyFThJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvEiPWVFBkC2jQitqj5fCa7ZwE108msTebVTuSsdLDY=;
 b=QcdHKY4R9+b4fKgPQ70OmfE6GPimYLCjP49p3Maqpg99rOGZO63wbEoAupjdglMBf0u1nhVEmeH4lAkEdLHp4v2iXnvLN0RW60oCgLatFZMcYgw8hP4QOfJHKqJI+ZsJM4uhd6mlGfBvuSte8zr0e1Sdu/feqQN/E8E8AdzcKLL6zgJ8AC8rY0NkiWURiysw/44JhHs5/Da4V8zffOrU7Rvbptjfbcc9PsLGZZcZ2y0mVfxLgLoqNrYFuHvIgOwygwYrmJXs92E+5WykIkdXcBdsOTfhzRAVXT1W2Z57UHMWXw/y/c0B3PKiVa9JW64m2RICF7MFanq2SoOHiWxyHw==
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 14:49:19 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::44) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 14:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:49:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:49:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:49:05 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:48:51 -0700
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
Subject: [PATCH net-next 11/16] qede: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:27 +0300
Message-ID: <20240906144632.404651-12-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaa7d67-aeed-4d04-d11a-08dcce83168c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r3R+ElkhT1pwD2qgsPTg99HUoj0KnEk5VqnzPm+pr8Qqlz7sBdSKE3tzXMfy?=
 =?us-ascii?Q?67ycglIuxfj/QGJTKnXUBoTmwWoOzHQjPf/AnyF8uGbm7qd7Ohd59UE2vcB3?=
 =?us-ascii?Q?/tC1ht95Spxy+qAibI5k5ru1m5n9BcEbM59fjPSuoi9iVcvsx0lmzTOdWoBB?=
 =?us-ascii?Q?X3rSjR70jk8QBAWtkUkt3xzWXoKdn+sggf3Pk6VofEdUsa3wuiZYtUKvpHt/?=
 =?us-ascii?Q?DIzyyh6KZkUUq70AWuirSCCSaUS2JHgjQQ/WIGO6nLwRSiuqhUb+dLd3ll9l?=
 =?us-ascii?Q?N1kfrMgxiuFykkNAEgGYiH+BzGLvM6EZWkZLinlLJP+qwqqwNFR1mrrVXnDy?=
 =?us-ascii?Q?b+t+qEF9n+AiBkSQYL3ANs36d9658QWHV7RG29XZOptZW4Mox3M1rNEOrhzQ?=
 =?us-ascii?Q?bZe2a5/kvvaXHlfS1PdhzA0hZJN8qrBq8oJGmP2eh5X+7p7h1FyBDqz1/YSa?=
 =?us-ascii?Q?jgAkYEXyI9btyQFIDluUqFMZrFRT6DMUlxmKbT2kC5HXBlA9ZiC5alqVmUec?=
 =?us-ascii?Q?lG0+OkSkNklwdOaO/SmfLjZ/4VumKBGtCyMuX9yovy6cDgjctQqU4jJvKeS3?=
 =?us-ascii?Q?l9e27LAouq5/taroQj2TntyhP8gLZo3zf4P9T4imiTCPy6jwLj8svqVh0p1W?=
 =?us-ascii?Q?J4aJ7Mp92A+WbWfHcQs+MaHqXQdVMlF61tzyXpeUfPZLej5fA/QyvRcBirP7?=
 =?us-ascii?Q?iA94q3SVxtoXYp5fdkDJNsdzjsS+UeXSOtp6Fw8KasgEWR8sjJbI0OUG6mHu?=
 =?us-ascii?Q?ZO4csyTj2mmfmEiqCnXe3n0fTL40BuDOMVXExxtX61L6hqCaKmxyq8+B4ml+?=
 =?us-ascii?Q?CdGePjUwNX7L6V4mYbF7dn7d9I0OCzhR2pgG0e66F4GbN/GEAmykAeLTpo6t?=
 =?us-ascii?Q?HWnutsCt5gx/iuhT+4wmA4PB8IHAAnQmBES7ytbwB+fmOY2Maqhg00PW2vhI?=
 =?us-ascii?Q?suXjYNs7ksu0/Kfdeag3WPh2GMgCfColxVv9q2+CKDKdWzEqxAglE5ewArY9?=
 =?us-ascii?Q?XerRL5OdV+Ixqq6rk6bj1wPbG4TuGs85Xw8gevnEyGLurvfa9wpztzQSzVI2?=
 =?us-ascii?Q?0iiBPU8gSgZdbhhRSP4vUVvR1d0DAaKjbImvBTM3JLKDHQSu5RKrXmyLUGNp?=
 =?us-ascii?Q?H51rY+1a75SwhZWWiwDraO/MTXa0qmBYnOlR2h3ilkYdFt9VLUQ3U84WTTXI?=
 =?us-ascii?Q?1yv+pHig44qyyzkBnep7FtQB9exly+Y1Bwjj4Q8M41IzZy4VhGtrurgW68EL?=
 =?us-ascii?Q?+BvyIXckjRb/c57BwncwJNrw3JrLUv15H8JHzkEMBSqwRYKQznHyA4lgRycd?=
 =?us-ascii?Q?NgJAQlU4nE2oAqprKkr/i6+/EPTBzC8ceEevXR2Ck2DQis2zUSVCHmisCi7a?=
 =?us-ascii?Q?OqI3e5apBsjaUwVmE4+rFgFeKKbmYRMUmsbTmU5CVhEL8rBBxbV68zCCK9tf?=
 =?us-ascii?Q?TNDnS1ryyLbvirHhoUszKSq0Ofwv8l/D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:49:19.1945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaa7d67-aeed-4d04-d11a-08dcce83168c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/qlogic/qede/qede_ptp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.c b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
index 63e3dac4d5f7..9d6399a5c780 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
@@ -326,25 +326,18 @@ int qede_ptp_get_ts_info(struct qede_dev *edev, struct kernel_ethtool_ts_info *i
 	struct qede_ptp *ptp = edev->ptp;
 
 	if (!ptp) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-					SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE;
-		info->phc_index = -1;
+		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 		return 0;
 	}
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (ptp->clock)
 		info->phc_index = ptp_clock_index(ptp->clock);
-	else
-		info->phc_index = -1;
 
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
 			   BIT(HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
-- 
2.40.1


