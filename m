Return-Path: <netdev+bounces-125982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9492F96F765
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685391C24121
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046A11D27B8;
	Fri,  6 Sep 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V4gVuxJq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D421D1F75
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634177; cv=fail; b=sXrovawQE3q8YMzJSNdNUSoTzbeS144WtB6I2nNOORz3wBseeNpOLZw9MSPQ2y6ZOFwqFfR+lMk0rjt7CddcmHkxsBzKsaoI4e8K2js31tAKZ4ljFTaRfpWNW/P4PSrZjwJZAYDADfD9inOMifREZOU6j7MmeZCkNLiTTzJHpYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634177; c=relaxed/simple;
	bh=h+xom4HpbWXCigjHZZOz4Y2x3Ym/7WUcYCKXkG5Dals=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFpKMLrrEwWdsz0CRcxtvSGY4WhVuuScCryySGavGyZi43Byt/QMYt4NrYFWXXZ6GlYKcmj+h9in0b19F3Ad+qt1C5nmrRH7t62nOyoV2qa7+wqaK4/a8HJo71OI0QDkVhkg6ACIZMYtoeFj2+cBveL1H7A8/sk4e8yPspQrev8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V4gVuxJq; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCYDJd64KIubsHHHcpXqpTphYK69xZ8W2Jj5fylZ32n3bRDwxfEQUHNzO36P+wo78LruZfpMa4+0UJvNQCl/uo8h6twg9gg5PmIIVaw2xwOf9xpxY2hgLA/L1HQUUCjoDt49NTh0iAWdYHmu/lDfMh1Ib7oVJF72Wdr6Q1XSXgS5OQPUFSp0+ntSmT7DBgueKWduz5ZZIJVkZbq3iG1fQtA9d8p1XD/+MJfqXnd9lSpDtY1IYu7jiGmR0bprggXB3fP18mkTlhriiJlqgeNSejLL71TAlo4ylmM53TKBbqpFGVcPELaNILVUugfVEbvq84zXAYu1BpytLFiBs86myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbE521UnNTkNUn3EMvUZFtyoIL0yQcW/T1ZIGweF+pY=;
 b=sDlhjbre2TXYjl6LHF2I5RQUkxZIoi1PJEFEyT38AZCk9n++dxHLrBzb3M78IcMrNh1PH2VbPdDgQEbbqfD6FKNoqBW+y1mcstIN04OZIzRFrTnWKNZDNYN95Guh3QYG/gUKQz8cl1lUVEF5xHRvysKJ49VZ8P6shu9kyleDGN7iI4H7v9d75h1OtXaSvVKNZBxcDIhXscZn6H2CdnOxEAIOzqmdc2TuSYL36zU4y8xmzApQQZZH799X+/XPg+d8BsT9seW8qq0KkPsMnTlmmBucMZl1DWHQdY1j34/OkG/EgZQ1eYijr/VBayr05y5CBAdiUlTSuQThxKYBfeYZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbE521UnNTkNUn3EMvUZFtyoIL0yQcW/T1ZIGweF+pY=;
 b=V4gVuxJqQ8n9lkONZItnGMpiaRdWiMPOzttIHxziEM9o0g3SGYEG5LNkI9T2eOwHbTrKZ+HmVADQ+BMXTD74OS2BhbIAYFPkDeAJD9SvaVXdvBQ9w2dofspYZGKcZsGqBZQUs44tFkIqfyCv8Xl5BA9PVQv48u9OZpe/++S+c0GvhMQ3qUK4QbngkD95dwKMbT/Kn5NGOXLzPh4nhdPn+JVJBZn88k1sAMBziClfN+dH3X9Cyj7iLnb7hhb3IOeA4/O/MQstvSe7oWt0xDknDVQQRgz9o/MYmIvTc6ZtWr6VQUDqJfx366EqXl3JhAMZVuV5lwwVcKNOKp9FwSXy2w==
Received: from DS7PR03CA0245.namprd03.prod.outlook.com (2603:10b6:5:3b3::10)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 14:49:30 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::a1) by DS7PR03CA0245.outlook.office365.com
 (2603:10b6:5:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 14:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:49:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:49:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:49:20 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:49:05 -0700
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
Subject: [PATCH net-next 12/16] sfc: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:28 +0300
Message-ID: <20240906144632.404651-13-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 38106ea6-f7c2-43af-3775-08dcce831cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N3Q/121lPWcPUCStebVBv8IPujL8jBTClQ+BhsZyaFw4ukOpxcoNzUCiIQeS?=
 =?us-ascii?Q?FLz2TN4apZGjQejLVW3crDy4jmWBcTurJBfmoLlUxzHuKdlPavE8plFYRL+y?=
 =?us-ascii?Q?dIIGj8+HhgCdycIZ4NaT/iw923o8XoY2Yh55mdhOvOWGl7NzwYtvDRBsH69L?=
 =?us-ascii?Q?cK5LbxGoRoVJAmypgW+kMvpvIWOu25Go5huoacimfv44jIgMEBoqmmNkR075?=
 =?us-ascii?Q?wrPGF//ES7hUa+mt35FE0DYkW2JLUOR47J5ACGx6vpndXWvlP5F54074oft6?=
 =?us-ascii?Q?SXR5FKS8iUfldUHVYSsI899FM/97Ig0shsPIrbbuhJOHEUh+KnphWxOSzlZn?=
 =?us-ascii?Q?r79jSJMKAotAwTO6FgF0ktP8hUZDN91lUbF8BdZ/AqeIfL0sUpomxC6RdEUy?=
 =?us-ascii?Q?J8ViUSs2KcU9UdZmwB8Q5fIx2bSJ4Wrde0S/PzZq5SWozUym+dbeXFo0E4wU?=
 =?us-ascii?Q?Btaw4YKxkfZZChkBHKWh87rZY/0t3dwCoOCfGG+oMkdAwyNbQ5VBRboNXLqQ?=
 =?us-ascii?Q?4+v3cqgU2jaDUd3kYvVeGhfIlTJEoEjvqAkbLszOLx2zCgoQMie/fZud/S1t?=
 =?us-ascii?Q?3ex3Bs4F7w3Sv5eY76O5uBV7jBdiPYtizibJJN8itlc4q6rv/rkkMxYxRvQG?=
 =?us-ascii?Q?um6PfS4O05fLtTFgEbb3qrW37kIqFBwBVRGa1BQz3V5W/kyI24aclBqlnDd0?=
 =?us-ascii?Q?MYtpUMi7ONmqpDJaxsFf0fY5UNkUZELOgR+4UkQnFLlYoIg4eGTKHj3iCUN/?=
 =?us-ascii?Q?ox1NypFVv0dooETDRAOGpo9WHhf+fnfCE+0XOVIeHUK+5cYW7l+I8ZHy0zzN?=
 =?us-ascii?Q?HEvvkbx61rByluOjW1wSeUJla6iYdy6m5i9hv2Mc/FMabWmKyYA3lkQFt/ZP?=
 =?us-ascii?Q?V81tFcT5l3EDI0d0xelpWDdVHYbw4LeiNLNrryclyePJ2HRmN7Y3QZ63j+sB?=
 =?us-ascii?Q?Tw+bILVdd3UTjlF3nZxijT3a26WSDODJCINyaG0jCf6hLcMP2pLs9aHD0jKE?=
 =?us-ascii?Q?QBAzx2Sv7fbhcFnl0/jxSdx1FnjKPjavTXXyvEM9KewlG4hxb717NbACzme3?=
 =?us-ascii?Q?67SKPjHFfkYFrb4chgSk2C9KLK1mnPjS73Iax4HKvA6DM65knk5/12Z5K2JU?=
 =?us-ascii?Q?qfqCvqn+FszBTMZSYqO/cDyHBJ9fXLNvF9NzATSauO5Ud7+z+8dwCNkx/kZM?=
 =?us-ascii?Q?sd3hF+xH3OPdw9C6WPwus6J3vZb+oPU8gbzegbcNqnxhLKgxXexuzb/xfq7C?=
 =?us-ascii?Q?xtb2C3gqZC82n+nzqDvk8ijd/lJM9CX3PNB5z5EHA3R2SmsUiqq/7tbvuhKY?=
 =?us-ascii?Q?n54aMCreVTLALG5Z67+v1QrPd7gpx4vjLbh3BZ1c3CZT4FwRRuSV7FX/5cyR?=
 =?us-ascii?Q?/HCikU+Q8cp93vpqILfgMCBnOHB9/hMVBfwcF6L1+J8jxJnMcxOQ5U+wKYhr?=
 =?us-ascii?Q?aZbUAz0QMZKaIpf9jirISk0FaPNEw3/o?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:49:30.0493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38106ea6-f7c2-43af-3775-08dcce831cf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ethtool.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 7c887160e2ef..314b41d738f2 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -230,11 +230,6 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
 
-	/* Software capabilities */
-	ts_info->so_timestamping = (SOF_TIMESTAMPING_RX_SOFTWARE |
-				    SOF_TIMESTAMPING_SOFTWARE);
-	ts_info->phc_index = -1;
-
 	efx_ptp_get_ts_info(efx, ts_info);
 	return 0;
 }
-- 
2.40.1


