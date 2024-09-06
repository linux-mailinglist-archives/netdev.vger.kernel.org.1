Return-Path: <netdev+bounces-125987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCA696F76D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F161F216B7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2537F1D1757;
	Fri,  6 Sep 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ikw8zzVJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307D1C7B93
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634240; cv=fail; b=aendK1RCKuBYkI2eTCw0XLaq6hZzdhD5wTdR/LmRWR0lIrXquD/ELJey/k2eKPh/36vVb2w1zktm1uGcr+Ca/9l63dy8PwEzst326ZidphbkdA1EuDkNSmd9JdKueG6et0gBQdflGqgv8TslUeVWQo2XxmT6Mo64LdUsCGBbfI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634240; c=relaxed/simple;
	bh=6UTMtUGOl8EodM07py3RvqfJJ8hVrvuhJo0HrgMxJCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKUwZOahNYQlELvkBWiUvdwBPUnattokZo4pErIAi9XSv6YuPc1dswaZangN3tUaKSfeXgqXOz8/ifUuRJMLroHPtU6RJfrbDCWM3G2Vf6W5Cud3hXr8L/hdueqI1CrvloDuluNfW0FPGSRv7H/czjeeOgX18w++TIjK469hmhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ikw8zzVJ; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEIbzh92q/ryIVZR+fAQOpb9kXaOyFgvVlhsu3BiBe85nFzHAasOYioVrAyU0UKmIeKJRbas8OKWdIQePhRb+9/MGYHkkYFcOlYvjyx7GzvxVpogVX2DKPBovxBcWzxhM1HDdCoekCNLvx66KWboTfgzsRzw6dDTgrZO6Krd4zaeo2r5SBAQz2igjuzsaE5SF/tdRSCp2tIxyofLMI2XSISguOboYm4U9msJcFdnl+XgFjqzwTEt3MTfAnZ8br4ePIzX0zV3yUWeYCH3AODphzxreOPjaS7hbYyjCCi0lyZmSVLzZZ3hTRPTGf0ZeiIUohz4i0CRb0v8WhY+YtcMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83cwKY7PXy1tZjB+SXJdErAXQlL9CjTRmcmBOqCiTj4=;
 b=is8qi0mlmQoAxAxmb6UrtG/wwB4zdyG+vHBGwh4WP3P2+OwYkTHZg1jYICE7Lhphb4DNvwwuoso99NT6qOtRMqrJr48cN1Uf9Un7GW3WO3hGQd8ehDjznHEdqcjhp+j9eEOEWgW2/jhQELbGwH0oL3kLbUS30DD5A8RlKqg1EtoqRij+4qe6eFZPJOR4jB0lEMSfTSMxXBP/azIiwW1MgWMSOOv6EYeuSD2tJT2oiJqaM2mYvRu9ugm47EL4Dxermmdpo/bMxLCTFAZygRmCFpqCn14rNPdfauFbUkzD1NVBHatoqbhflgsXC+qq1R8NIypaVcOE+AMaIV1OfR5A7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83cwKY7PXy1tZjB+SXJdErAXQlL9CjTRmcmBOqCiTj4=;
 b=Ikw8zzVJhqMoJZ1a3GQh0l/cs69Wj1d8TFxtPhKPQ4WVRX81pIwCFbVo4RR3ttgqsy3Dr3083S9fX8rC1cPVDbDitRK/ujZSbVsxKYUsPBCzTRavs/kNfL1ynvxq2c6TpearijnRPFHmYSsmZL6kdzvuv+0usY2UIo84E18Ead3r3xld84Zrj+9v+ssfTq2h+KYcPpy/6QHZGmKZnBUJ/CU6EKiMptyTe+3wYBVocZCb7QHc1yimCNLy6PBazjWWWS8msbiGfGVvQq23qLcaY5uB9ow4LGdLtxemKOTvMnL8CboAQlpa1x/D7NoWMDvug99KsjmlzgtKRF11H9RYPQ==
Received: from DM5PR07CA0058.namprd07.prod.outlook.com (2603:10b6:4:ad::23) by
 CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 14:50:33 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::7d) by DM5PR07CA0058.outlook.office365.com
 (2603:10b6:4:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 14:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:50:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:50:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:50:18 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:50:04 -0700
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
Subject: [PATCH net-next 16/16] ptp: ptp_ines: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:32 +0300
Message-ID: <20240906144632.404651-17-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3e164a-8208-423d-3ebf-08dcce834211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1gagoF2FtMO9Dc9VIq62RqIaXxbwm5ZVTCAADG9RK0IKdGC/jnlLfNXEoZZd?=
 =?us-ascii?Q?h8hn4imv57ESqAp1H7k6DI4Ms8cGjHQs78Q4dp1SmHzUB6W2P/n2WIGBGJp/?=
 =?us-ascii?Q?eM9IEmV5R2e1524Uzk3TxHdeIGIoWyo8iCnk9l03YIV995eJUGLP0ttAmvTd?=
 =?us-ascii?Q?iECryXeLkb//eCt+OuOvrRHcRdvKcxOrY5B+zIbjvDBAdCrp48LJwCZf9eVC?=
 =?us-ascii?Q?Y2OB3Fz5ZvjsFm0pFBsAi2qCnkk1wiPB8aQWfjiLvTTMCDdsOAiJm1p3s7cr?=
 =?us-ascii?Q?htuWn5sCfLiFvMSN9t5VeLW/Bzra2pKIc/K59U32hEyD3UfNgigGtBqfCRAx?=
 =?us-ascii?Q?4bfMDXyOO9DGKjf+zBfa+j4a0Jj8OQ63CBntg2avL0Jn+0W4jYWF/OqT4ZU1?=
 =?us-ascii?Q?2ztxQ61Xs6hLTcxO+wqycG4ECFCw3e/VAb9FUGtCod70XdpcXgg+HNSTgpHH?=
 =?us-ascii?Q?6mSfZ/QdiW0vnDdagPDtcUKr6sWMiMJZid58nyiIq+mw93eCcXeas9WCzOE9?=
 =?us-ascii?Q?5XkE6l0RrNcCg1YzAFAL3jffdBvRDr+Ayset7xxqaz7wb35LGvXG4agRFMrM?=
 =?us-ascii?Q?SN7kQ1eRi7tsj1+b7Gnx3geUXSrKKERuIOGV4YSz8IRhvFkMUTScGZl0i58b?=
 =?us-ascii?Q?9zjP0LaK147x5WGkCfjTI1yPihQ/2g6hkett+JhhcPOQG+VAGSMPzFrq6Yho?=
 =?us-ascii?Q?Oj1vxN2Jllg/Zc6/WS9EHk8GRO9mIlQMLBHL6ZQ0c6wywST0IHCQ4hdb2rEi?=
 =?us-ascii?Q?CcDV9rgi8lS1ocn4hSQZsM1lA8/0rRHLrnWtVVV6AXX8hmSAaksTeOUU9Wn4?=
 =?us-ascii?Q?/Qcmu0/4h+PrqSfWAAlmss6FD9rjlouhu19L5pHX9R6MOF3QDszvl+ap7pGN?=
 =?us-ascii?Q?obmiCsmpIfxiYf5KQNKQncj8PY1ZnXh2hHqg02RBwUaBAu+pG53dYbKNKsQ/?=
 =?us-ascii?Q?Az62ggg7Ud2xKJ1cHKX31+WUkE3Q2bUbqaNvgI2zZXABFfrI15Do2VYedtE2?=
 =?us-ascii?Q?APFxuJNsKGyiBFXwEteQNwa8F/xUmE2XVfPqJq+6YqxOiA2SE0EYBC1awlBD?=
 =?us-ascii?Q?IfA15+i96oXJ+G+8zzUScgAwqNvBuQxwS28od1XwLbHm4pGd3ANLUANTn/OM?=
 =?us-ascii?Q?UdvzLgzCWncm/ghjX2loBC5iuiNv8PiRF7n4115to3jSyESgCd4HdDQIU0GV?=
 =?us-ascii?Q?gLLlnTsf/KzNwGwjx1uybK/Gtun6TELH3UOkycsZOnCVtdkyOVPLqUK6YUwF?=
 =?us-ascii?Q?OjgI1pYCx2sbiGIhvyrUdWeXGTzg970OZiYvjC6P2iDjq3e6WT5rrw9ITMli?=
 =?us-ascii?Q?P99VXexOrqIu6WgznIrfRbmLRlzbMn1ysFg/0r9EV8Y3MG13odcbvHHuJw3Q?=
 =?us-ascii?Q?ZJwAwpsmJKxw74885lkZFnRRhaUt/0f2M8HSil4u/ly41c6EUmSwY7oLsaIN?=
 =?us-ascii?Q?fN9qiZbvDaiMjPXRhBOY784sN23383S9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:50:32.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3e164a-8208-423d-3ebf-08dcce834211
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/ptp/ptp_ines.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index e6f7d2bf8dde..14a23d3a27f2 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -562,12 +562,8 @@ static int ines_ts_info(struct mii_timestamper *mii_ts,
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_TX_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	info->phc_index = -1;
-
 	info->tx_types =
 		(1 << HWTSTAMP_TX_OFF) |
 		(1 << HWTSTAMP_TX_ON) |
-- 
2.40.1


