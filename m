Return-Path: <netdev+bounces-125979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8F096F758
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682D81C23957
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345DD1D1741;
	Fri,  6 Sep 2024 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FSk+qrnF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C581DFED
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634148; cv=fail; b=Cogdad9VuPQAEMGtVeSoPYomJwmBT7j5btCOSk4Onya5MfVb8LSr7sxM4BfbddXLyFVlGkro7y4EKLI3lNaoGyeFJmoF0VupOEexqZZqFhLVk2LVvmOdBqxu/zYENv0VaqHAHZrwA4C/QpdyeWaq40Qa6X9ZrPvJQwjLt1HOM6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634148; c=relaxed/simple;
	bh=Voe+IuzCrqzIP4Bi4atRPPjFsteTeffPIoxxBUpaHq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUh9bB73G21ciu7WBSZJNFx0OLGyZ9WWZcjTGTBTJnbYnhPwDaa4HrSPjPNvmWOgewg8M9Fw4DF6Rx8K+UtTBqzm1mDFy1T9QMoo4+y+PTCsj19sQKFKkEdaf/tgU6eRYg9yUi/PdC58vXu4QRGyV70goB3csTeZw9ws7Q/A06w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FSk+qrnF; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWZ9a91n2Y1R/pcQZNh0lmSm++3bEJ5Y7yeETa2Y2Qt6GZ4QHzK5h9CzxFDShMGFsCI6YJf0PE4ZDR+7FBkbGfadLq1VUfO+LpQah92GfA4rVrwSRfiRmW/O2YWlGF638GYaiA/39lCdT+rnDQcobSMnvLq28AHFR/J+iUsDCwUgw6nFmaD5Myz6XZN0HLl56ak2rhot3Ev5FlW/26JGLtbflxnbY0hKNnpTfqW7lb1ygnuyDVzVzLVDmCXzQM3qJ/bQy/mGKIyjCuG5vKU65AsZDFwzjxCcTyE9hE/IE27PnDHBq/bFZ6lQ6YcmKXMzcPJ0rEn40EECHAnkUWzynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eXpxy2fenNfqpzHK7/8KA6v28uhALYqBpzT7WAFQrI=;
 b=xuiYH6C+Q40pSImJZryfz15Q6dVdkJc4tR/bxR6DqhNV0FQiklf7HjMGCJCO6dITpohHZvwIGtYBkdRuIWY92Ir7ogDfFMSW+DqpWA+Jr4/Qd4gyWdwl7xPy3f+uu0unaE3AMdjACozOFKsHPaAxqfTS5EPOoAe5VyhsBHu1nKcOS8CZV5YYbV5DcPA5y36ZD/aNmUAjdHNTpog33Fmg1tjr7a4FFVkIw7do5F89YGnvf+ikbe5CzugySheMbTekkDJ1xzccZp38g+A5ozEzcdcnAtdEsB0dHTGbaqgvISZgudYmae3D3x0pZ9Xo+MAE+Lxz4apRCuwQWGGCpWDOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eXpxy2fenNfqpzHK7/8KA6v28uhALYqBpzT7WAFQrI=;
 b=FSk+qrnFXZZQRReVNNL/SMAHmaXpfve31J4aaODfE5Xfpd2DJ+Tpf9R37NlEMj2NMYGZngBhKNdCuby5mVkolBHyR363u7nnb1v9OJz2RmhnVfj1TZubkuPX8ldoTfy7K0PE4+MtYFYoVS8a6jwdYTLAknT3MPriUw7lJDaKH7mI0if+bUJtyiIrDSIUn3AbfRl+dvKVGjzQySRQvkuV/NeUZ+fPwHwMWDNs/dOUMcpBtIIWGbpp3NU0Nhlg85KTD7DlpBx4Yub8i/Kr2JV8vThzDAyrddpsP+qg5VCXoG0SKv2qD1wIa+P7W5rVyOtXmTqiJWvGMnDrzBQew9++Dw==
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Fri, 6 Sep
 2024 14:49:02 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::d8) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Fri, 6 Sep 2024 14:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:49:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:48:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:48:50 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:48:36 -0700
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
Subject: [PATCH net-next 10/16] net: mscc: ocelot: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:26 +0300
Message-ID: <20240906144632.404651-11-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: afa84082-86a5-4d59-3307-08dcce830c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJqJL2LcHyxOfal74vO2g0m5lG1f0tQedDb5szrhk5x3lnc0QZS1ZMWbeAXC?=
 =?us-ascii?Q?SDLP7y/Ddk0ANbdXL+x5NV/iERUGvRDnxno5v9CxqsBHMITdpR4dZ95aCJkj?=
 =?us-ascii?Q?hszjM8/aKgAaK5S0s489AIN8FWm0/kDjc0UTjRMZTWi4hUvNqleZSW6J/A8j?=
 =?us-ascii?Q?JwRGVlfWgPwAbW6e7AI/rxW9eZBDVnH9CpsyZXHvTf4hR6G6v9caTcWWfk2+?=
 =?us-ascii?Q?T6FSmGobe4Gl+heuzqd6wKZLWZJX9rfKKUZdKbloe1DYpdq5A3U4Xbs6ElBb?=
 =?us-ascii?Q?PZWXWi4XNF1bXGHkF3mlwYNQXgMmk8wGitLzm65UCl5zREEN18rmhfeU08P7?=
 =?us-ascii?Q?5eRGsIBSDdIu9YXnucAenXyHYYCJHJf9tjkIiDjC/xuK8mUl58m28LVm6rtF?=
 =?us-ascii?Q?HxZbvSgf8n9QIuMIFAFgStrEhaFNCRreQTyODRzyU+wUQzqIRsnbMyzplZRn?=
 =?us-ascii?Q?lIerVOrOtsNMa0Eg/ljVFzFygU+nCn95a1W3v0hiXiy3w6/akutt7+hA/WJP?=
 =?us-ascii?Q?aul7aNFLSqvLi7LzelCk+1aT35gs0y71PzR6sSgZK4O0WVYOzWGS9Bvg1tVc?=
 =?us-ascii?Q?/VXs7X2DeCZHyHzf0o/QTNuznCncTnbxB/enL7oOyoZOE3qHS5OJ30ckXgx+?=
 =?us-ascii?Q?il2XfnxqxeUwJgvrr/qAI0uEpaJF0C8gGJ5v7BmhGzn6LSAyoBeK1LKMYHVf?=
 =?us-ascii?Q?8TMBxNtt8F08HpFFVVWhb1kml6kl/f5C/uDqREjmdfo5bw2vMtBxKgeU0OQX?=
 =?us-ascii?Q?am0SzyKmTYLybHPzvV3xMQIj5jkwSCnup5IKVI+gWRndTUKcwDGcp94RcNRp?=
 =?us-ascii?Q?m8purPv5QUR+VAKBD53jQyDoD5/S4DfOfIx18YSJXYviV25Bv739wbOBCY1t?=
 =?us-ascii?Q?Yng9bagLqO2PyfqJB1DvXCqytfAynLTcfajFudzcwtqKVzlxvfvZ3ynZkrI5?=
 =?us-ascii?Q?PIn8I/DL+KQ1NgMIxzKRPtgFjxCcXoZwQPRGLJ3a9fkEcuFlCfi4iF9aVibd?=
 =?us-ascii?Q?EGnbx3819hRRMOLvgEWZUp56Hjse7T6hIRnMIDbbTAg5HBQSsbQckVdVgXae?=
 =?us-ascii?Q?jHyv3lXGDwKKKkJlh7fULKP2TrxQcGiKPfHC3BT6hxF3z5kqimBVK21a9iNY?=
 =?us-ascii?Q?+N/JsnX+2Mw20LKYTG7s8XVkTJ6UMhB022235X5ZhWpkVdlZzohT5vYTF6m8?=
 =?us-ascii?Q?9M6Be0DRh1P+b4rl9aizv4AEHIw1xmRUcGuRx1/uHuAZ8gSbkwxLb6ZfZxFj?=
 =?us-ascii?Q?CRaSctrsoqfpojR+JoCIDSIq7P6cGurOJJa8J3IFSWeKQNUbrZ9ccGx0y1KC?=
 =?us-ascii?Q?1/qZ4Jx5ZphkLLb3owYyMLZTorAQ5ZXNrvkmK1s1Vhp9ZTZIgpTUs/HNqB79?=
 =?us-ascii?Q?a/kbkvVcxttWWWz6+1Vnt3ZJKtdLlxYe1ZCtn0SVDL6CZw+sOTA4vCRVUKL4?=
 =?us-ascii?Q?b+OrckgA10KtzZte3nfM9znG3NX89bZm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:49:01.6026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa84082-86a5-4d59-3307-08dcce830c02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index b3c28260adf8..e172638b0601 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -582,17 +582,13 @@ EXPORT_SYMBOL(ocelot_hwstamp_set);
 int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 		       struct kernel_ethtool_ts_info *info)
 {
-	info->phc_index = ocelot->ptp_clock ?
-			  ptp_clock_index(ocelot->ptp_clock) : -1;
-	if (info->phc_index == -1) {
-		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-					 SOF_TIMESTAMPING_RX_SOFTWARE |
-					 SOF_TIMESTAMPING_SOFTWARE;
+	if (ocelot->ptp_clock) {
+		info->phc_index = ptp_clock_index(ocelot->ptp_clock);
+	} else {
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
 		return 0;
 	}
 	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-				 SOF_TIMESTAMPING_RX_SOFTWARE |
-				 SOF_TIMESTAMPING_SOFTWARE |
 				 SOF_TIMESTAMPING_TX_HARDWARE |
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


