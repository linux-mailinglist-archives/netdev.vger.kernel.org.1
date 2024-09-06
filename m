Return-Path: <netdev+bounces-125971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01D296F74A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F201C21915
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869A1D0174;
	Fri,  6 Sep 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QkXxXxLX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D231D1F70
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634033; cv=fail; b=CP3ZHBKrIcqaD8HvDFcgfFAEk4V7veByVBwHzz+eXr1jH+LlaSpUEtvZKcMJ9Yo41vjer9w7w5tP0BDSXYRBMtNnzgfKfeEbf2xHNKCppilYRXHeRHK+BuFAJotJuwr0Smezc5bd5MymA6R2O657HcLuPfpG/NudkrP0/x4fAms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634033; c=relaxed/simple;
	bh=G0mXXIjTAXM14u3F3BwTNut/wZGVS5sLh11ghxiMZ+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOnJ+lSDBsgaS90i2xzrcyhLqwyO2tW/NnyiSSN3NdMkBeddy71+MOAZsqR8K4kQU92A9fSf0mhvOmtx7vbTXJp/XzNaPljY85uUSfpCBpSFBiJbsPO2wor54PSlx2Ay4C5zeWYacuX1YP83dMApjYgNgJUYMEEI/e/V8SfCYBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QkXxXxLX; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enhMKhgnysuPaWLpaR6v/O4iqfrDFLdOZa7lK5l7yRHdEIpynnEBUIoNfcxM+C3qhNR7KXvV7ERHPQaQ/CAJnmRTG/mP7nPpZhpzoVDPmNY/uxFk8A5ynPYUZDFz+zMW80vPf+6gSQm/CBp7a6fJtwxuKwQtUqNtHtd4AyytRgTKS7xbsLQRkKA/pAGw5c3qJuUtv0QL0COFIq5xPy9hb8Ieb29YEsFSUpnnXHlVQAZACBIcZ1hqpBKCJBXDWqZI7yRdiV6rCVr25b8M8tgXVcNVWjk17nBS07+ukbrnjq5T12iAvJY1YgCOmSUr6WBKANOWprfses5DvKjyg31rPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lACi6WFcuTp+71Lj4LE3f7yCGDGN96Ch8OWQOo5VmOs=;
 b=J5GTvKkaZCXrFRBjY8WT1gFQn2EEoQGHORM8vvp00iu+IgfiEs8W+H6JQnK/qTZhoPRbdUoSdolp40KfiCe1rqQ+YDf+kesV4WsyvrIvFwemdlYe3cyaPdxaCf+htPb01MiUS8A7/l1FSN3I6qeAhyamd+cs1eWl1Py2jdYER4yzUXC0qeBk1FF9n1x3QPVtTTC8xElra9g4UQlPq9esOHAJSDIwTyDuyopxPvxCGpV35V2uD3DrkyB6vDivMi6kc06Xe/Y4vKvjD9FJNgQPVoE6XB0r95ZZSBkCAHe35GUbvkTZHJEfwk64JDXRd1oJnsr6V/+iAD7zsD9mYSlKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lACi6WFcuTp+71Lj4LE3f7yCGDGN96Ch8OWQOo5VmOs=;
 b=QkXxXxLXpawLtzjwKzQgNlmsEifMpauhTi/tuEXkHX5BNauOX0BIl1dHyzwkc8Ktek0m63Ui5WaXyP2KXPHZtlm3aUbJzof8tZa3n4aQiv/5IdOegy2g9nJg45pfRCezU2ezcmB++5NamLyf/GnO9WZnabTjS2p/OTfejtWZBsPqS4x4IIHNjGY7HhcBr8PWj2/uXnr3t8EZ9+jKvy9cRUxLYgiEIb7wE3pCWJIZ9gm5gMfhGWxYmze1sFpxCpqaSQ8kiOc5tRTGNSChk0UDIzGR5MJg26EY95AoLL2wiSzLT5iXBnMAr2qCDt+3gPFuS8yaTjSV9h+PQbCPDmmVww==
Received: from SJ0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:a03:333::12)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 14:47:05 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::d) by SJ0PR03CA0097.outlook.office365.com
 (2603:10b6:a03:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Fri, 6 Sep 2024 14:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:47:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:46:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:46:51 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:46:37 -0700
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
Subject: [PATCH net-next 02/16] tg3: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:18 +0300
Message-ID: <20240906144632.404651-3-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 484cd6d4-a9dc-4c2f-24e0-08dcce82c5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvVrRwV0FPr/nvhTrBnqBOVlR0P5yZbl00EayC5SAYhk98l6i071g7iIGKH0?=
 =?us-ascii?Q?br5YQmRc3OvTsCpmn7HtZQeZZWFhyLfY8DAvoNIZOrkdaZxvCfI6jjdQfNnw?=
 =?us-ascii?Q?h4iJlWMT5n8gfqJglZnwA5DCsNu0arIcZ/Gt37dhnxSIDTBUxFLOKP2M8dif?=
 =?us-ascii?Q?IHI+oioweo7JNPJPHPWNuSCdJqYkjTy0yUiolcjUwGv4RM6xhriVmV+9Gd8M?=
 =?us-ascii?Q?f06AqiR0m29tFp/30IbJOz4hk1pB7Jf+Hc8Df2BZs6QtXccfQfqyMfShLRN2?=
 =?us-ascii?Q?3KDxTiev8BOuChFAYIAkBZaKEJqXAGJ5s48My+n3nVxuq97/lXcqZWZUvL0r?=
 =?us-ascii?Q?Yk5kRmtz7yYekQvdJzuuflkNh2LTSZ1E9Aovnd7TOBqgnbZKJpRlf5+I8REM?=
 =?us-ascii?Q?Q4d29VaXGHZDiJSKL/Q0cl+rAowZpVrmFg2Nmk7j7HCEUEppgSi9xvCX6ll9?=
 =?us-ascii?Q?ACzhUikRMagzGtv+uHwVQ6E1l4KCOkkXGqQ9pufDTnFws3RVaniICbCQbtO6?=
 =?us-ascii?Q?IEFOX0cL3eEqoU0OVNiqTRmd/hIuG9jsUmO7w5Ho5gRX7BtLDhcqsuC+RSc/?=
 =?us-ascii?Q?LeiOW018Wvm0lcRuc1KYZtFmbuE3zFsq0EXD8NRcf/isx3Zmi/XKS1n4P2jh?=
 =?us-ascii?Q?KZ74rXAoWyv4LP85J/iXDqhTSk8EoLgXxtFfVcnkOw6MVtNkNzFZZU2/AGfF?=
 =?us-ascii?Q?WOsJk95sdTxPriTD1WeDzBf+Q/lt45x6pXa3Y3gNwZt4smQRCN43C9+hQAjL?=
 =?us-ascii?Q?Q5JsGpOArsGpiutgT5M2pHjzd/2ZzPjDAevG1uD1+WSzdhMnnu2QEIbQbnTC?=
 =?us-ascii?Q?+V32uSDrSG3pwg+RrV76IJ4T1AUHym4l1i6Pj2/xW7ZrPHZxCXSuMiO0jaEl?=
 =?us-ascii?Q?XXXlR4QYSnrMUj+rvRAuVYMxVFmLn7xEah0z+WGUduTsJ1hEMBToFfI4XT27?=
 =?us-ascii?Q?W2bKkIsP3iAcj9DZJ09Mg+DLbnHOLC0KczgFWSG0yUHaajMmJqxmjQCK5/x1?=
 =?us-ascii?Q?Ah2qFX/OQwaBsrz2Nn3pGl4BcL/A3V0APZF/To8FBii2kNntm3o3kl3z16Ig?=
 =?us-ascii?Q?w3zDA70LXM4TUmCwbeov3Yk1hls0t2mm47dXLJbGJnhAw51zC0mf+2pk+St7?=
 =?us-ascii?Q?+vQdcHo4kBfJ1i04F+yCCOg1XuUOnUK6h1sTxfEi6+JBCH7RbPjL5wKJzJhD?=
 =?us-ascii?Q?FWAeRX975vgjugPJ5dr6ljIo9Qf5vU9h4zCrOLNwrVlqBiKFD/xuOc9pUrZt?=
 =?us-ascii?Q?JSVbOR+hhY6AzpXSAnm3GM58OwBYkjOWTEqG95IFYH4QM/T+lF+2AxzyulUG?=
 =?us-ascii?Q?QSVv2Kv5aqeGhpvQ71RQKZlF1eN0PzQYL7+XwN1K81m6n2xJcXhpjSvvRDaf?=
 =?us-ascii?Q?l21OtX2AJLAGO0ptiQPc1bIy8KS3q3nXpT153kXbFZ+friADOhWc3s5IrV4x?=
 =?us-ascii?Q?68Hz7K4/QuMlcpOW6KfZz+lOp92aj44n?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:47:04.1511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484cd6d4-a9dc-4c2f-24e0-08dcce82c5fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 0ec5f01551f9..378815917741 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6145,9 +6145,7 @@ static int tg3_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info
 {
 	struct tg3 *tp = netdev_priv(dev);
 
-	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	if (tg3_flag(tp, PTP_CAPABLE)) {
 		info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
@@ -6157,8 +6155,6 @@ static int tg3_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info
 
 	if (tp->ptp_clock)
 		info->phc_index = ptp_clock_index(tp->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 
-- 
2.40.1


