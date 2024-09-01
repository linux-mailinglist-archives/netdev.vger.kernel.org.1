Return-Path: <netdev+bounces-124031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98DE967638
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FDD1F213A4
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7C81684A4;
	Sun,  1 Sep 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nyXtG9tC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE714A61B
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190224; cv=fail; b=LWk+FISUu7RLvPUuovgJHVx28LoYz5VgV7pnOqYR1AxGjfZv6Ob4/0XqSLQMQtOjowHoEqgbOVPWZO4Xns0wiT7kwYxHinlBryx3T+tnximidu32O8dgvBefSOD79eA7HxWaRz6Z5w72xYOTgvY1jPxtT5EPQSGFWn0IyTpK4f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190224; c=relaxed/simple;
	bh=xv0uxta8+TuTtcndmDNBzfG5oKQi7q/hv7VYLrN+qwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0dFQwdfPWOwq5Xk1DTp8D4wc/NbXBwZX+90HEsMIiAdsbdNZM59DGzac6OC/UYBCX33WC86lBo8MrOSO4cLoJQ9Z7ElTOoYJNXBWLoMuNBIa/OthP1Ln9FHI3M1KmkauRC5WpXuyRDDQJcsxfVE0ixOeJzuvsDvw+0+d+Pcg7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nyXtG9tC; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmzKTUkEGx04rOleEE1jd90MWNNbv9qZsrcnuWwSb71AO1sXSgMSZe8OfBvfp9ZTsX8Fw/bM6cAnXAANtnjQ2Ds/UW4avtd05oAkvPA+yEeoV+9dFxavdsCodnGydvfnszhj8NsN5GUT8OnUmYzM9sk2XbHXahkO9V5FiavaIkga9zVMGGouQjMDuJs5VwPRFP2wuCf17qHPBGU5o0UgyFC04JD+287iEN0LHT1OIxDZ/e4jCuBKpv3+cQhIx/fpNwVEagrW94UWpy6CWZ007KuMddM8y9Bqfe5e/3PKsy+vbbWUTwfKmYmXPukmDkq6+6lpJXvOlzNn9NMJ2cfTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb6DEx/2X6kR5w9NmoT3s6AZI9qqkKstdgoCS4pJ2QQ=;
 b=GYX6P880KMHcJfRDA85FKrrQJNv7JnZzNPFCTZW5x+k+R/3QPN7QeNZMOf+jkyGGjzXK/y+Hg2gPhqu8MIPi1ZpSEzK3ki2xqRX/qMEN9IUGqTyYL5WaDVJwVVOFnGncQMz8znr0GyP4APXGaMZpLYtYaI0bXIljr8owzSlVky3jR5ph5eNOdvjfw/P7a99R4MHy8sDetBdngBQ9Rboz+YJVPGIcDCQJ3/tb/HtaKZSubji/I2goonWfgRwUI95d2P/+2i764eJQKa/WdHVIJQ5hm+lLZJNd+OI+WlfLo/pc0EoASw23AJPWxrwVxmtOmqFVrWam7BfzlV+lc4SMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb6DEx/2X6kR5w9NmoT3s6AZI9qqkKstdgoCS4pJ2QQ=;
 b=nyXtG9tCFm6hXtFBLM5DKfWSkOr1RKIc73cExuwK8vFiBKysOYBLMNIEPrISScr1JDSt0v6cz1JAozJ19d2o1qtCkmKPsNJlPj2xTaC/4t0G74zylEJ3miwXyVCIZByY6w5SUHzThe+iJKsIOYBAt74drxUwFTnghvWgEKlKu7gLj1tqQVbwpD3uU8dZzKn/GHNg+a/b2ElRqdqUifvqT0rNj0hmbT7MyWm0mRZ1OE/SW+zkaFz0RAqsGj4ESCk/Qu3+HIPmfEYDvMbiB/9uVGjyB/+TeOLZWwIJ3sbNQV5PjjjTgFy4eb5Un6zFbQF597Mt360paZa2UZ3Yx3OK7A==
Received: from PH8PR07CA0042.namprd07.prod.outlook.com (2603:10b6:510:2cf::8)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:30:16 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::2b) by PH8PR07CA0042.outlook.office365.com
 (2603:10b6:510:2cf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:30:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:30:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:30:04 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:29:51 -0700
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
	<rrameshbabu@nvidia.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v2 09/15] net: ethernet: rtsn: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:57 +0300
Message-ID: <20240901112803.212753-10-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240901112803.212753-1-gal@nvidia.com>
References: <20240901112803.212753-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: b722eb6a-4f18-42b3-c30d-08dcca7973ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3VTVXZpUU8ydTFUQ1IwTVZNditOS0tTdUxBZlVVOFlTU1pxYWtlWmUzbjky?=
 =?utf-8?B?RHY2SWl4bzQyTmRFVGovL1FzMjh6TVpEZDVqOXk2cFg1cmV3dkhCSGlFQk95?=
 =?utf-8?B?U3I3bnhsUUM3RnNWaUEzaGhDS3pUQTkxOWdLZU9DcTdVeGh0b1oya0pRRXVM?=
 =?utf-8?B?MGVBUVoyYW5yY3A0WkNFYUNXWjBQTjgxcGJ6TkUrV1RkN2hqcDZGbllvN3Av?=
 =?utf-8?B?VlN4bUk5U21USkduU25sU2xsbitYTHV2UytGMFJQK3BTUC9uaVMzUldkL3p4?=
 =?utf-8?B?NnlHSHVJRlZyaE5uM2xETUFMQ2padXNzS2VwbXg3SWNHMVRxZytCVzRUazV5?=
 =?utf-8?B?eGhBbVNjTHZDRGw5SjFibzZDZzh5ZkRQQWdjZUVEc3g4Q0FDdkh2TmVSNTVy?=
 =?utf-8?B?Sy9odldCMjNONmVWbU94cGRHU1pIRHVlaDVlRUJUYklkcGxYcklxS1VxMTNF?=
 =?utf-8?B?YWZvNGJ6R2Urc1cvazZzdkNic096TkdObitDNStLT3l4ZlBGcFVDZTdHWSsv?=
 =?utf-8?B?N1p6STJpcVFvMlIyR0tCL2RXSm0xKzdXWjRpamNzckI1a0hFM20wdFIzSEN2?=
 =?utf-8?B?QWxFcXNONnJtSERzUkw5dmJLVkhVZnJHay8zQmVQenhnMENxdFE1cGxlYjhw?=
 =?utf-8?B?RmdTb3MrL2ltbEpLTzIxTW12NDFTTzdmSXlLNjByVDhZYms4a1liSE15SExC?=
 =?utf-8?B?d1BQUnIvdjVXZmI1eVQ0S2llNXNJUE41MzR0YjZzTDZ6bmtpcXpwLzZNZVVm?=
 =?utf-8?B?M0Z4MmluRFRzRE5vTTNyV1lrR21DZWRGN2NmUFR4UWptZVoyakZNeDdLcHhD?=
 =?utf-8?B?dVVWUGljVWFaQmJhQldNTVFDQjdaQzFsVFM3R08ya2NpYkpYdGhxcWszTmc4?=
 =?utf-8?B?MjNyNDNhUjZYZ2FFQmZkWDBJbHQ2SmU2VUxZRHE3cUhrcm9IeXpoVFRwRUlz?=
 =?utf-8?B?OEl1QWZ0TlpJY0dyVU91YnljV01XN0NXeDBjSUszSU9kQUhzWG5iVmdEV04v?=
 =?utf-8?B?d1BlVjJCbVZWYmE1VjU4eWhsc3A4VkZzYnRITkFEVnd4aTZGU05weGVGTzZL?=
 =?utf-8?B?TjNab3B6RXNraEwyTkpHZXJhUmxtZ3VMeFFMU0hsdDFQaE9XdlRNZDFiSkdF?=
 =?utf-8?B?VEFZc0QvV0pYMkxGUzdUUFZ4Sk5VbkNqQ0hudEp2M1pyRk44NzlpdVo5MmRB?=
 =?utf-8?B?aWhVcFowSEhDdXVibThuMzVZQ2tFbnBFRVlVRS9GYWRkSDJNQklLNkF0emN3?=
 =?utf-8?B?RTh3LzhES01YNjFIV3RWRDRKbE5xVHdTRHd6dkpZbWlFLzlSVFMrYmExLy90?=
 =?utf-8?B?Q3FwV0NZVW12RkFTVjM5d0pqMVpSc2tuNFdudDRTdnhYbEFXK0FETmhOWVhX?=
 =?utf-8?B?TmdBUEtGSXdsSWFCRGZDSGJGUWJUUnl3WkdudzF5T05mUFV4eC9zQzRQRndx?=
 =?utf-8?B?eGk4V2Z6cnFzWk1heDB4Sk5jNm1TVllsQmdZWHc4S0djLzErSEptcG9zUVBi?=
 =?utf-8?B?aGNMTnZwdkV1MXV1dEhJWllnTHlJTkU4U2k4UVY5TWhRVDQ4WlB2YktLZnR3?=
 =?utf-8?B?SlpRaXVWeFhyVmJnRjVrVU1BTE1ELzM5QVp4cVpyMG41WjVjQTdvdUdxMnJH?=
 =?utf-8?B?cXhVR1R1VHhpUkZ4MkZSbEV5aW1iQnVEWEEwdlBBL3FacUQ4YVM0Tzl2NE1X?=
 =?utf-8?B?UGVvVExRaFljeld0blpyQklxeFI2YkpINHA0OGVMTnAvRWpnY0VZbTUyc0Rk?=
 =?utf-8?B?dytSYWxXWUJDZzZ1bU4zeU1oTWhmUXRVb0djQkxCVFE3Sjh0OGo2RUtUeTI5?=
 =?utf-8?B?WmtRYWdWekp3YVczWFgrWE5xcmV1dVMyM2JDU1VDZkZjZWRMSkYvTlNmeVRR?=
 =?utf-8?B?YmY4a0dnK3BSUHhNOW9YZGkrZkh2eWFQbnBuUGFnUXB0MXBiZ3JtVXlUV1Jy?=
 =?utf-8?Q?irKoujSU8NnJMPoSCaTneL678WTLgygd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:30:15.9451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b722eb6a-4f18-42b3-c30d-08dcca7973ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/rtsn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index 0e6cea42f007..f9f63c61d792 100644
--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -1219,8 +1219,6 @@ static int rtsn_get_ts_info(struct net_device *ndev,
 
 	info->phc_index = ptp_clock_index(priv->ptp_priv->clock);
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


