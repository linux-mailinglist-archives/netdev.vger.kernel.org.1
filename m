Return-Path: <netdev+bounces-124025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF8967632
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925DA28131F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1C216EB42;
	Sun,  1 Sep 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c29BjAla"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A5165F11
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190129; cv=fail; b=eBTqNErVhZWNJr9mBia3qiX06kObiYSAW7sMYeDv91C+uYugrX73USflxzfR4WfgVfvxucrEc5BZLdI9eF17UGzmOz+Zqh6EJ9zBHNxx/jCn/L185vBG2wUgewoXxqRFLStZ0KBjW4zheXbl4I3M08kIfa1i2r7Tox3fqULJsIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190129; c=relaxed/simple;
	bh=rQElQbWMKVUfiTjT60quLxR6uVFFBq7+TcYlyXagyL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcRHlZQpWODLONOss8BDiAP5EuJUjLiHBsP/RxfFoXNBnN//OUbW3k6D4w1u4BvcJlCxEyFczxWr2pZE8wzhfcuYmOI6yPAmOjMNAYpx7s46ERDwJG/tq6I06aPVrDtyflVgJr1n+DiXCivL0Y37pM2Ef3IAi5BljBpHem0H/ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c29BjAla; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhsfyR/6zmQQFmAQ5h+zkDcmD9PVZDQDbPwxNc0KQs03Nj/Ml5e4meUD9p7Xve7O1a0o7y5dtOLInMfpEFul2TsNcULrFCX9aLe6gDTd6ioaD7OuUriHXjRT+W48ep/Js79Mu06V5J9aprZj2s/b2UZtoCSt8wmzEWeE+BPseff0XbHE8glWtpSoxU0eRchI4TjUjeMQRwSAZg+KJ5ec/zIKOS86T/o9J1AHZffUYm5RWWijiiqQbG4SlVH8PbQj7SJENQmFMDDU5NazIcxy80+R5OVySih3NTWDmTv8NR6aWUnFRzwiPMB+1mM4dGP/IVbu1B8NhXHijkoYoEdFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+zlWdiCzZdVJJWL1+M/JcnlXVyY7EK1srO29RH/yGw=;
 b=ElU9pZbgjpJb9fdY+6Bn7vbfhaDsNHC3kFca9T39LtM1wuG2R/Ydc6HnQCoLL+OVgItH0bGzrJPCNgdU5qNf9daSQYqwmPFiQtc34YLnuisokqaWSDfhgoKaP/A6hDkahP4VplRL1krcKoJx+JhRzn6Qnxz83F80FEjDQYFZrO9IYlr9csg+JQHoyW59qkWqXdfHYp0erD354JAWugyjznHoo4YN5gVSiK8kEv5Z8YfKLUTYXnF+m7lq3U422ydJz1Q17qxMSLfBXby7EvONZNDkUXET4fhZJWdMoKlnl66VNOL3soEjkAwGfaKM/YSqzipci0Ieo3ng3sQiHqLy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+zlWdiCzZdVJJWL1+M/JcnlXVyY7EK1srO29RH/yGw=;
 b=c29BjAla/VEkvIaXhKrhM1dq7H41ffp3zdp88/mLsiU8SEmSY3x6S62q8Z1Wg9+kNs3QUy6NOvNUklxPDNbCQWTuuGOfRPpGdPEPwI12FueTuSfOvovtct9dfGm20QgqUi0FDrlT9qGfs66iH5z6CcM3H1pOaUzau1eAGtRQiiYCrGTP+1our3hXW76Z8xBVIzZ3qn2wVgFMWjlOll8oWs5MXwIUWknFMDvFHSJfFiQH5H6EcXyXKbnU1xI/GD4EvMWXzEtVcy1A5kkhr74XiYTv+mveuydSRHmnJ6iWBbJYsfXc/gc2M54K8u5pVd8LrMNMsfBXZ9nkihkHbKLq5g==
Received: from BN9PR03CA0711.namprd03.prod.outlook.com (2603:10b6:408:ef::26)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:28:45 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::ed) by BN9PR03CA0711.outlook.office365.com
 (2603:10b6:408:ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:28:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:28:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:28:38 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:28:24 -0700
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
Subject: [PATCH net-next v2 03/15] can: peak_canfd: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:51 +0300
Message-ID: <20240901112803.212753-4-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c037f83-02c3-4b3b-d48c-08dcca793d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZW3TUrL9xV4fapi0S+kmwclNxrHRyJi3g6K7ZJj7X0AeD8S1TxOOIr9C7Ybz?=
 =?us-ascii?Q?b6csLds3rPTuYSmtDDFhkWQLynIl94pAukf9ckmwA3sTio/mEpsjlmjOmUfs?=
 =?us-ascii?Q?PG3e62kXsfnWKxJmwypUqeQ6n444GaILbKHJwkqUav5fwDv2jKxIBFUEBa4b?=
 =?us-ascii?Q?P0nZH6K5tur7nP6CPVY41SlvC3QZlp8BXwGRmxWFWUF5KIbr4ddo4fkKeUkk?=
 =?us-ascii?Q?xCf7RJEJNxvZYgIvZC74YWeWf0MxVvlWS62SSE1JlRP4gF0crqwvgf5BXcCq?=
 =?us-ascii?Q?wG5dAALU6qwHf2TWVGClO+tnZoel1rLiDp40s9TjivAQVRQuPgmdyRsTN6ra?=
 =?us-ascii?Q?UxMnyU7PxiIbOsceJE410hK/rXYJBbuDDSic7r4LRnVApmeasBUZLR06LvWY?=
 =?us-ascii?Q?T4aXQ1MFpQIkNsBlKbQZdHEKOH3SP+/Co27k8BTs9f1lU0f7A3Ouw5kutO7V?=
 =?us-ascii?Q?WHzlYxQkf0Q/K9XiWR/iy3D7gEUAhiFHPB51JhEN5UMBGxW7Eo8ljUSlZoZt?=
 =?us-ascii?Q?U56UT/cFcUIg8AUi+MHKJbLAFMZP+M2HN0jhCPrA1oKByVHVJwhmVsrPG2C9?=
 =?us-ascii?Q?/blRkOeiUnY8n5oxvR5ehyKTaY/HTMLVdH5SJZBfgspBE7Z3klXkuP740pVO?=
 =?us-ascii?Q?0f1ZecjTvgLO+6P/6+Qxq3jIbIBPFUM31d+1uuL/jlW554VKG3jMXDtWlpcz?=
 =?us-ascii?Q?GCsnkKK549HpGlVIz47VIKORkok/mUeqpU4MUgi+L/2zdET712/jGdoi/Cgg?=
 =?us-ascii?Q?nU7qUnXMnCAzqN0u90XBhxZ5DCrpyc7n4nF/3LuYfoDz6opCOHxvwQlX4DEz?=
 =?us-ascii?Q?dxkFAor9eSFXHMRntYx/oqH7doiSEvCuqLrJgVjBv4iDY7aKkMOUoSf+Zmpy?=
 =?us-ascii?Q?p0qb6PI48XWKjToSWJ/I42c4VknO6t9WC0KGp8O9vaAywGZ7zbmYjiCeAw6Z?=
 =?us-ascii?Q?0l1YJSxOL0OWdQrynB4FRdmjcQEJgElCkNu8wDpZSPl+/bEYIeCtPVnwpjsu?=
 =?us-ascii?Q?opL1JU4xvGg1aiPoA/fIKJHBBWxCmYqr49gri7Xfu3K3kHUtD63Qi5FfTCKU?=
 =?us-ascii?Q?II/VcZBn0pORC7JAchdiOPgMDKRihm5ektJyo9+brrbtOAEP7vGHiPwCl/gq?=
 =?us-ascii?Q?RRUn05LMfb7ufjVRsuaHuMhWMNrxWjLyF+TNaR8AMBDNm+YazrYhlzuzTwtJ?=
 =?us-ascii?Q?rLnfNHJ0zVf2HfHcEtlKEjeI1IpRyIk2YR6MoFLoIQEfwG9gwAHp+nVLlyUv?=
 =?us-ascii?Q?oQCQ7pp5HOEkxF/CzvKMHm39wowvH94n5ezbOhhkJbNVojpui4jAB3LS6pxy?=
 =?us-ascii?Q?1AblPAOcDYiWyYt43LgSu64A+6+efgBjDkLGkmdxHkyPgMDT1CDPeWxj84tz?=
 =?us-ascii?Q?HQeGzagl0HMu+B4lFE5OCaBsuTZ+TNJxQyWB8BlN0tZavLC0rX5T0yKTjNdp?=
 =?us-ascii?Q?vWYJAyOQYWlbHm2hPttDSUKXomvjkG5o?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:28:44.6781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c037f83-02c3-4b3b-d48c-08dcca793d55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index b50005397463..28f3fd805273 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -781,11 +781,8 @@ static int peak_get_ts_info(struct net_device *dev,
 {
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = -1;
 	info->tx_types = BIT(HWTSTAMP_TX_OFF);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
 
-- 
2.40.1


