Return-Path: <netdev+bounces-124028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9686967635
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1178280F55
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329C016ABC6;
	Sun,  1 Sep 2024 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ObU0alUe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB497152532
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190178; cv=fail; b=E/hBOzNCpB/SMCkGFEMFcYeHVhfAu/FUCQxBmGq/mV3ommlRacXGcXMRc8XSST5y9Xr6h2/ksHAbyZImHbPe6ByecveAN8ARDDo2Z9ohJ01zk6mr9ThR4bwY1GA+TkVg0PBJTfokMzBu9DUyqJLDZXlYvoS6++YJJm57JR/f55g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190178; c=relaxed/simple;
	bh=Vu+3LwR2S6W9wu9+kbW8PSD26mNP36yyNZG0/0taYxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auc/TvgnNZDjl9uuEPCWu8HwDqfRCPgPyzePSFtfwisDnXsqNLneRaysJ5UBYM64/mcoZjqfknkM1gQLONHcqp82fS3WR5EQvzP0ajh3UC+ysd7l5xd09b+YPQDZItXtc+UfGIIS5zN8R5/wQ3meV4XDj3bSm9Pr+11uPWcFK6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ObU0alUe; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TB6GwOLQDEyPFBRt7CUbJvn/skWwfAdeVzNtbeO1MQ4cIs5+lZKWISfxWYTX84vKaKxWeDzWSnqK4Up3TLSabfEi1J+HLbWb74Kbp9vhshOt+4gjB/vGm+eC1872T42WY+YcqFCqc2H4cVMxhm+Joh3Cl6pH4jSd+dy4HB2aWcny/ucVdM3GG9Xvk8HZ7RpzHDrHJOLlH1sQh1bC5C9PC+Cl9fpfqWSRyD/lCNMrvBvU+l5GdCnTL+9lS/Ennz0dCAuSXzRF8gpmU6hAqk0EJRYk+FCvams8PnbVH3fz1C181PTOsAeEnNlJjVbXenxg2V2JtKrIbQBiwBjJf7MYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhURlVKXts97JggoBql9fpBQI8Ix2FOZ6zmzy56UTz4=;
 b=b69wqGpvYgNqZwSoAUq//uSNbyQiezFOvw64HKMq9BCWq4QFlPkvGpzAZNStvye1M/L/CHjuALjdQzwXoS/xlHfh0crFe5SdcrvalfTw9yk/1QV/tg5EaoJ+5s7wSIyBeDFHt40t678uYMpO8us3v47GROSJeNaurZ77ydixjisKKwoVda5HuEG9C0cEN7uPtyBfowJ+AH2Q9W+NzWk3QD1SM+iP7rX/1G/G/BfOxrmn3dsCNzsxFAzKGU8kiDUw7Z7LmXJggqIRrkJlFEVo9dc3Ef+RC4704VqgjNyb+13NEMqSw55DLKX2lGO/baNwj7WCQkDGDQL6rOEhNlKeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhURlVKXts97JggoBql9fpBQI8Ix2FOZ6zmzy56UTz4=;
 b=ObU0alUeFHYSZF7pGecaPBY/vpEll2WmWo5uPN4l6wfFeCQxalApeaLxMt+qIedXmuzm/XMjYZY2ausBVTus2kKlYjKrnfCnGmGAw2gYpQf+/LSiQ2Uw7fGF10b2ws6Kc8NyQAIlkftplCJ+lpaLHd/vUgGk68P5mRHt+dDsu21IPFAtqWjSvnqLuJgvba4SJZ0XLrZ+5vKPrOsnTVkk6cppRU+IlXGOgDRMzv0DdJ2Q35Pgw/FmyHIwr9Rx9eLpErW5IkLBn52M5xJ/OjWl/DsG1I3sEDxKfAXUVyUyM0I5kHqQL+SVBvNmRrJZTmMVPIEg8SyrbwL7yn7laiM5jg==
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:29:31 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::24) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Sun, 1 Sep 2024 11:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:29:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:29:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:29:21 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:29:07 -0700
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
Subject: [PATCH net-next v2 06/15] ionic: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:54 +0300
Message-ID: <20240901112803.212753-7-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a03e50-85c3-4709-bacf-08dcca795856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o7ev5fNCAhLaUrNnkdz5zaO4ryOZmEKFtc6P/eEVIuVuxdQvXDgfYW+/GsUz?=
 =?us-ascii?Q?rM/dRcX2sEnC/VdEuvd8oH8Zianh7t0Jd0Uja4xYab7p4uXOkZGLePx68gS4?=
 =?us-ascii?Q?x3EMtPmO2RrjX2fOljCQ8rMEwNLwmQbmGbmJJxEuznHxrzka9TlTf0bX1Lhj?=
 =?us-ascii?Q?YUbVb/HuzhUob+HBHJyGWNsY9Zp8qjap3uFNuDPqaR3FS0F3+qGzfPnIFaFT?=
 =?us-ascii?Q?HHeYklcC7bGdwscOEPloi7cTA8v/t5PAm5thKGiTC5vB8rKOeyjNlzUQZ+nE?=
 =?us-ascii?Q?lV1r7SsDazfV2iTsTrXL4UC/lpSG8r8wp3zSPfLYTUa3HEHYB/2zqJEWgg5r?=
 =?us-ascii?Q?Ekly/HmHQBbuerUrlra6XGHrIfu7st1P+i+s9+pTDsP56UPEIzSUFgjRFN9T?=
 =?us-ascii?Q?WaFer6VieS5LyRG/5IXCtKH7wHJ9Xtbr8970ymdid2TgShi7z4qad85vFYRm?=
 =?us-ascii?Q?aaUwYpD7D0poOAZOwNxhHDRduAlSo+kdMIDWbWl7CY1xkcvt/51rjhkMgtY+?=
 =?us-ascii?Q?Va9AgawvXmxMyufPj/b7CxYAOagsydhP9KuCSI9L764AcQWy2Y5g97B9oVWv?=
 =?us-ascii?Q?d6mo91iXpbA+0ZYhMRMZkAK4HbpUdkkxN3hdTyoIA8WiB/CPkzwOZcN1aOhb?=
 =?us-ascii?Q?iWrRP3ZR8JMtEHPm8ZDehSab8KNAko+mt62j+oJyra4pPxwvinn4cPL08O7+?=
 =?us-ascii?Q?jrBW68ExgWxDw1GS9ZEQfmrpL9A7eFZSo/kDBNaaePBxvjUaFNfBU4SP1aVD?=
 =?us-ascii?Q?DAKuCprwECzu+KlFZnNOhoK75WMeDqeUCG50jH+CJTKIMmtJMa/7KkvKnsvN?=
 =?us-ascii?Q?cnhPrl5w/L9qsaj1gIp3d3ewHO+mQ6iz17qDiIEwqtW7Ym+iF0GDwWLW3Xje?=
 =?us-ascii?Q?2HeaURSABUhD9P7QEJWTNjjJIjOzFKmF+PPB0/JWeCVABfFz6QqIAnaNi4sK?=
 =?us-ascii?Q?1Uwzg4HanTybaI9wjVrvLs0doA18jHBhsSImMxhW36Zii5wr8Uyk8+4Y/K1H?=
 =?us-ascii?Q?0shvnM8TCOCGJmJCuSLKEcJp+ppFmhPDaN+j170t5fieU4/dipX5TKHRen1A?=
 =?us-ascii?Q?AaBsRqvD4rauHHEtL+DJlgZH5JbTIX4wZnDctO3AkOOlCtSSJWF/zxunp1ov?=
 =?us-ascii?Q?zHZEwqb0i9vUm4MaIeen8lujVsju61xaZDCABLSec+Ep4t6fxZ8pAgpl03CH?=
 =?us-ascii?Q?5zdf/JFKpPYsugxSvKf6eAb257GQmV1a+e5CLhKlbjk3fsS5/slxnSEv6Lj8?=
 =?us-ascii?Q?9lFRaM2qhDgkr+u6ovybVI7t4DrvkYQXRWESEtYjwaffYMmF7Uy+Rq4XZ9BY?=
 =?us-ascii?Q?YbvJGTasHDacKMUONstT6XjCqtbF/uSCNfuChODcjmgXbKMvuK/ZhOMK11VH?=
 =?us-ascii?Q?W26KVndBjs0NOyBXdITwXMjfesXfzxTjWUMMOMhNJtg9yg0A8dABqrrh6p+7?=
 =?us-ascii?Q?OeodRBaxbdaE6Q75pS07zYHtUMRUaVKc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:29:30.0762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a03e50-85c3-4709-bacf-08dcca795856
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 4619fd74f3e3..dda22fa4448c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -989,8 +989,6 @@ static int ionic_get_ts_info(struct net_device *netdev,
 	info->phc_index = ptp_clock_index(lif->phc->ptp);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


