Return-Path: <netdev+bounces-125978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464D96F754
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC628227B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F31CF2A4;
	Fri,  6 Sep 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RwoWR7YO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9991C9EA1
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634133; cv=fail; b=Ojv597UYx0LR0qAyEEBR9sb5F6xsC4R5HRTaNDAoWuFGAwSkVJ6vYBiFAz3rN9N0uD25svip8zy0DvQFttFV4Ij0WsHOPf1lPNHtTq0zfgvGW56MtMlKFUa07vE4dXnaNRDJZ/LZpm5070IbP2WN6ILLEEvJVOlQuU0a3/oTexI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634133; c=relaxed/simple;
	bh=/+b/6w2xmdbEma9Jy1yjO29ZW8dKUhA8u+giES0AR/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqNiq7mdj58tEX6tRC+aR/mBFhAyir9IXSBxsOmOBDn3VufXQsVBkItONOfWldCD9lVa47dB6g0+kFZIrGL/4f9zSrcz0DacJdYOa6UXE3hKoEJFwKpno9RuBQhkJmmAhKtQTNv/NZhLpi/YxAUbVQmyLhjhOmd6Bk6SgRY8WlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwoWR7YO; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0z0FriU67/hCVqL+5vi3IpFLlpB50pd7pSs42W/xCIefzL805CDRh+D5vtIko/luhYwU6sguvzV90gtAn2lmNQ6Ie7km2bJneFpDXvWvZSkMiaqXbtdyDpoz5KC54GC1LnA4Lwtwl6Cnl+6/MykgaODh2p95zMjtnOTDg06TrjqCkvjU2lxds76/X1MKjuoU1OHFIEYoS632iRKefRXUYZqluxrPePzRHJFo1z4SQwrBrYow7/Yz7I388ilZvcUsrk8d/lf/yvlJy6nrLXposSqaMTDSwCwxdAgNO9A8W9WbkrbbUlupUq4/xfMhKEPZO5UnFurKBiQBrLiR8udoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da64austCjYguQ711PFlJUAJ0xZrz1HcMqTT1x1J8/w=;
 b=ykDD2ZRIdGM5En8bEHXt+ZtQU6rBi4ScoCPJDqs2lX0OVWnjOL3Prezla3tSaxrvuRTI5FQMStw9tGqhgQgNuETc/vQfIgVHU3WdMQrzets+N82k7hmaBm6yPWyqXrgEP3Y6Xgq5J3OgXuMLmqBy2LyBVQKovYz4yDg3GB/9/zBPjfJ9vOK9KYeNfyF1G/tdxDZ12DMZgfVaHpH3GGoOD+pMDePhXtHnTJNIKzX+0S8jIx1L0MPY87Yu3Ju+lkngd/PWrsSQLDPG0JDeSpLDUOX/MCO7UyUspMpweCN8AQIrIBF8ZKX3Ib8kzKzb4MlOLTuoaPL65bBBauX3U61N/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da64austCjYguQ711PFlJUAJ0xZrz1HcMqTT1x1J8/w=;
 b=RwoWR7YOARadju36GvmD1mw0I15SU8lFCDw/s4HGzKo47gUWp1hDN/aCkZ4si/50LSBcK1MRW/ptCGMb+midYXfrn6gFQ5sUWNjZoUliHraJoVNjxtpR67UJVErjrSMMyuQGvphqWS/SBX17zLjP//YwiMaOdsmNcCA/WyotI7z22i6FrIER+A8F8upXewmat4Yt78/xU5qOWo08XzqMePCfVyQKiMr4ESuVIo7v5KMyV7bTOSYzGNWNcpDjufpcWvdgLfa1AFLyMkgwnzQ73ux160rIPopHixjNlxONsK5gTMkGVY4UZ3Bn2okHYjvYKHlFZ5Os039idY/qJJNRCA==
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 14:48:45 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::c4) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 14:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:48:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:48:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:48:35 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:48:21 -0700
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
Subject: [PATCH net-next 09/16] net/funeth: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:25 +0300
Message-ID: <20240906144632.404651-10-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: e86f9a48-2127-4bf7-6a17-08dcce830127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8EezfY84nEcIzME77wKpVius2DghrqLbPYZnHXcAbNfstkod6jK6Bv3NGe8?=
 =?us-ascii?Q?qt3qxOk8JtRaaNZz3gOuoeWulKyunmfVvlO/V/p/OnuiVHXCIgkibYJi+qG6?=
 =?us-ascii?Q?R7ZrBOCDQbML54P6NFQvM7YPMTnnCeOZdzlgGTn21dhwiG+fx8ZQ1JIHDh5Z?=
 =?us-ascii?Q?0Zwifa4mWgF31RzIe7vfNwpZEvw/1rZQS1lTwl3zWAd98BeZmsqljYXOxZt5?=
 =?us-ascii?Q?ipww+5SC8XW+caCLL5gz37jREF3TLTzT7fPqG8LZ9wXnxv9sB/Y6Ux2xMj5c?=
 =?us-ascii?Q?OoO94730WuzKf0+tbQNEiTK+IGsBsPVb9YDlLN6vOwP/jck72G3dCefpQj1Y?=
 =?us-ascii?Q?oQL0HmyRWFM/7TQw31vOePMCnACyehPe5VDOKyAhke6338qAkCBnJKo+uHpG?=
 =?us-ascii?Q?bIOkwpQaM6Jg1P9gvjbPAUjHj881XrEhkYjzCoKJa6wO3OYPyvpiqa9xkrga?=
 =?us-ascii?Q?ULgyUArNVnAjr/upx0uUz8M0IzGq+SCZQt4JpSXU7m4P7DRHtza1+QjD6ylb?=
 =?us-ascii?Q?6Wn9t58mKEEck0jyvyEKDE4lCebB7UzhBPF+EaSlmJiYzV9tRT5QZsqW9GZH?=
 =?us-ascii?Q?Y1AoP3i3k/jp14ZcEeP0R90l1dQTXU8tbKukk/ZyRQjYVKjAfrmRpnIQRd/J?=
 =?us-ascii?Q?J5+o1Pq5y92T1ZJP2MFfUxfil5PVHNFtkijn7j4OZupzN+l+b7Oj8Towe/vo?=
 =?us-ascii?Q?X4em95c0MYa0Q0+KPW1KbRuFGmeBy/SK2UH4U+gw+QyJdtiaLK3rpXqMl5D5?=
 =?us-ascii?Q?neZlw+f1hjdAtoO3Q8FC0bAi+BXPYXA7rBOEpm27uTKbjyG+SGqUSLvvy0lD?=
 =?us-ascii?Q?dqAGPDzwpzDmMAzurpA/IbEJzF3F/GS3LZftB0pawP+XGQ+hgCo0W/wWNB9E?=
 =?us-ascii?Q?+0WJznJbKKzOmMW7cetrLPl7LlCCfAlfstm7FLvD/EoY6h/9SyhIsA7of7ZW?=
 =?us-ascii?Q?0jrDltSSMyxiOB524SZinbKXIW+Pfdrx+V5rPHSUbKORD6JgC9yf86dGGJSR?=
 =?us-ascii?Q?98Y6sIQ/V4TSkpOaWWHswbHz2GqQhxlFxgjlhUQvPq7XLWxk3xW5ybOaGG/q?=
 =?us-ascii?Q?M/oiDls3H/kUP4T0I+pWGT5C/pzbqQ+zOmcdNHYRGDVV1g7bphILkBj1UTOq?=
 =?us-ascii?Q?+s6hmFA1ynjf/Ak0VW/7S/LhSxTtJ8Fbtwix5c3h7FJrT+URg/xPXD1rqZxM?=
 =?us-ascii?Q?PFfITvTNSdj8iRf7HDIaaT3RHVS5LU1mS8pDCYVfXQ/fKZJXZYJvUMfzDxNQ?=
 =?us-ascii?Q?S3s1K/dATgfBSMbtW4pPGmYnz5hihklbHViVP6QeruRc82Met/QcTdPiwPkn?=
 =?us-ascii?Q?sbtPQmlcuty+A43vjVK7VQbiKgQ1aJsCz3OBMgLtb0AlzeWu79IS8Ue3jY7V?=
 =?us-ascii?Q?oq0iNqItb+psHONrht09ionSLJCQNmPjLV8PzwHP5JVhdrv2hToXqw9Npw9o?=
 =?us-ascii?Q?ySJrhVEWCWRaxBfzxy1LUcdvHUOjOR27?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:48:43.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86f9a48-2127-4bf7-6a17-08dcce830127
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/fungible/funeth/funeth_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
index 7f081e6e8c87..ba83dbf4ed22 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
@@ -1042,12 +1042,9 @@ static int fun_set_rxfh(struct net_device *netdev,
 static int fun_get_ts_info(struct net_device *netdev,
 			   struct kernel_ethtool_ts_info *info)
 {
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_HARDWARE |
+	info->so_timestamping = SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = -1;
 	info->tx_types = BIT(HWTSTAMP_TX_OFF);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
 	return 0;
-- 
2.40.1


