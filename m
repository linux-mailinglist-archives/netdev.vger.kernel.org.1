Return-Path: <netdev+bounces-124857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4396B38C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A07B1C21E9E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228351779A5;
	Wed,  4 Sep 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m3QJY/wp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F2C1714C8
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436351; cv=fail; b=FM08G4GMWlbkdcLrx3D9AtoV/ePEI2AmsnoQqR/LwFrXFomt33oIz8gP3Wbn+1IpD5vji2CxVYyQJAlZuV2hhqvMsWKoJMDYdlaU8Po8C332a0YtYsKS4utZi+lucyx+BYLXLP/q5PBNswjwa/EwSLIw7N1YzFdYXdfYO8zbEQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436351; c=relaxed/simple;
	bh=Z+EAbKMX3Bdd6z91hnVbFo5Ba3NOIWTIO9EWKyIyYT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h70heSGEqAz+9sT/Plmw9wJdkFoISywEaC4doMNOdi/g/uH1TY7OJp6PwVXVil0rJLsHkiWU15DyS7uaHUq3Aryp1dq0C4Jb8smz0hq7oi4L0Lha0hi5zkX8V3oWC7XKY3b9CkO8CyRfBJ3Lf2fpFf22e1LoAMcaVid6GATOk1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m3QJY/wp; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFUPrDBbHXKGt63c7I7mRAkr8My5hubgZYlW6ORUCp+04n+hwmxAhhb44BHAe2RfqBrVnbVO6vNT1Pp3IQHqzzVNHR70EvflbVclEd2RVRLVZrR89Mh84Z70PnYUF7m6mlH0wL5lv5RcYrI8NJI1hYvnO48lwoNfbNgoB9y52l53LnRlLoH8cVwh0VMmWUpg6eCVs9+I50edW8UrZPN1A6gjtY2xv/pnbAFYza7EEMjuR9ddAh+8vCKEcP5TRYbp0+fOfZUrZWyL69osr/o0LR+85nuEnpsdCIQA31+9aj+ZB9uLGmQe5GqgrFijAs/1N8QTKDaWovArxoWJ0jVmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvrDe0iuA5ACfHG0Am3ROfJdp1/0BR/G8sIA49tcN8o=;
 b=Twy4/Lvspz3nWUwtsYR26AaFtJZbTHM+a8MEOzxPRKyEPnaRcR4Qgi3hY7GkYgW6fOruKxqvZYb7u68i1tjSrs5+Z9T+O/CJz6JKDW/8KDepEEB97kU5kq7WdZZVt5yvfyeI2yataHa6+dTbg/8/Deu8uQE5kL/gHZwEaLlsZv5+m9AaS5a28p3sbtecbJYjk6FiIfb0QBTA1g0bIiSbFvM8dpP2THyNEc5EyZfdyZaziRnMHeE0wv66w208vakgK+bu7XNxyAtluLDdDBzmYU6y+kgNF8ZskDHt9t3YSPKVAnp+ldsTFWanqJaDwLEiks2EeXPyJ9i9pVOtF6mvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvrDe0iuA5ACfHG0Am3ROfJdp1/0BR/G8sIA49tcN8o=;
 b=m3QJY/wphwRCgo2PYUl7hOidvJhb6FhUntrVjiXfWGzqr+JbE7DJzdLTOIHfOEPP8cOSG5yQPc9CeV0WZLemHoJSdN2S7p9GZiUSga2y/tj7KiaddqpWpcOl2evcavQr8AULs1I9ldnhVPiKj1hO0A1rxKGOJxIEv5opWJe5uaE8ZDsGjvzq/8/L2/idnxDVfugG5q6rm+okcD1lGygowyn2IBPTn43UG7TMW7Sl4K6NwBJoQXjW3MaTDp92g0A0DV13oxy44817moGerlg/IcBpHLGLWh8UGuNNyEiV/7bYggockbQyiObT5gxvsO8tU7A+ualyCHwSSa+9sFr3hA==
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:52:26 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::aa) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 07:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:52:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:52:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:52:16 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:52:03 -0700
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
Subject: [PATCH net-next 13/15] ixgbe: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:20 +0300
Message-ID: <20240904074922.256275-14-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: c90c0949-8e39-48ad-0978-08dcccb68497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w81vSrfhWcwvafTFAzYIttGTl5xrOwIqcincJHUjlD6IhnnLYq6lFE6SSe1C?=
 =?us-ascii?Q?ZQWAYW0Nk+mrJYrUphfNHn0Y6cqUZ3l8HirDhDS8T3kzR4ipqQ2hnfZL1UDk?=
 =?us-ascii?Q?BTXhJM47+rtOVcuTlbemcw2AcYVT8Tq9PVJCLB76DX64Zzf2O/bVzT9jTmFW?=
 =?us-ascii?Q?7ia4JikrLpkk9Dk+pAEnXo5+ASsGdL5tPd6J9NZ89nOT3/WqnS1bz5szmeDK?=
 =?us-ascii?Q?VLW0ud5pc11SlbVMdjGNmB8ja2E/FroE3IQGuE3WyXzppn8HQBtzk1K0MITe?=
 =?us-ascii?Q?kPU57C4juzenl5SA0JvvlUHc/svlM6cqG4FVAi2i1MlN0O6mai0YS8CfOmG5?=
 =?us-ascii?Q?A+PI790Ld5bxWjriCgNm3KzjifyIH0Ee7pP9G9jFsKEVSUBIvi7KDTrmEHKJ?=
 =?us-ascii?Q?/GdIalxTTISuZ3n2kzGOxSMBSvlijMKoHjN4O6MNK189YGhbfYmYeMMy6Ryw?=
 =?us-ascii?Q?dSp85MzU4DRI8PEi61LG8HlVZiFtl8hl0ELtU922FOLzhU//xZMKl/ZWYYcQ?=
 =?us-ascii?Q?r8Etwj4JxE8nUEg3QrpkYaiSUUip6QTfXcrRNU0kcgcVTLw2YFX0vOwxpHFc?=
 =?us-ascii?Q?vIHhvWoHZYJgC1Bs/Q1NHuXDMYYUmpL9ynUJtVTMM/ZU9CzYCz1GD3dQL7H9?=
 =?us-ascii?Q?YP/Qr4l8zAAWdSqdRmVojGsMmMQLEcmGeSsp7FuVgPAfV4y/xQ0FcITZMRlG?=
 =?us-ascii?Q?GmPqhWNDjSIffWZvXlGDICSwYD3urtdgfU5orIa9ocyA4WyZLPfZXeCKtHCf?=
 =?us-ascii?Q?d8lSlq+p9VAx7rK+iZrluryhCjMcIIp4PtbPrwSx9URC1hIRN2Jmp6BJImr/?=
 =?us-ascii?Q?qLzmx8B0RS5ufEGtE6cmCt0lV7cI+aoB1Honjgai+gIb1YX3Gx6JjlYVaupq?=
 =?us-ascii?Q?vQpfGBexfe9MU7M4nJehxsJ1NxkcfRGXvzNNolCm5StmENsqWkJxqfYmzVAQ?=
 =?us-ascii?Q?K8v5/gWUxI7D8gnLCThHQfsPmVcbggrXi9atwaUCJpU67hts7LgyTLcmbjnd?=
 =?us-ascii?Q?kfy4zVWLqkXf0VVS5dn3gvCTcBClbihkTXdRJy/PRNuwPgNGPMvB9HMCcbta?=
 =?us-ascii?Q?CWStrgvq5WTAe8VhZw1rCOaBAwnZDUcsOGGfSz8RMOsTHg8Mik6oEJBN2XmC?=
 =?us-ascii?Q?8wGrIOFpzKkqUPa8E+4v+lFnIcx8bSj8JlLXRfUp+/f/RYd+HdzKe6Kr2qmr?=
 =?us-ascii?Q?1Y5C7FNlVweyPa2X0LdHlPzDOX/hn5oihRxpXxLfQfnCw5t9jurgEHAWfLpf?=
 =?us-ascii?Q?zQoGBHRG3e5nRcaKNKBOr7iDJlF86gflSjjfCvN93UCP4wO8m43c/lhPc/iC?=
 =?us-ascii?Q?lvC3B5pK4pXCTVYQQGhu13l+NHc4HNX6xB8IlM5CtevY2ugLcxnqCY9qXRvd?=
 =?us-ascii?Q?UBbqcAAHTsBZYoTJG4EZhf0iQTkO5OCkgNSGSCMZaz8GM32XWdfRFhbkUj/X?=
 =?us-ascii?Q?kKCMe/WNPKY6rRjV1i47B/N+ryaI/SS/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:52:25.8810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c90c0949-8e39-48ad-0978-08dcccb68497
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 4cac76254966..9482e0cca8b7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3196,16 +3196,12 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (adapter->ptp_clock)
 		info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types =
 		BIT(HWTSTAMP_TX_OFF) |
-- 
2.40.1


