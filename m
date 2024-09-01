Return-Path: <netdev+bounces-124027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC11967634
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6911F21213
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370EE16ABC6;
	Sun,  1 Sep 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KUHP4ANS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD9152532
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190168; cv=fail; b=qlFOOR8kGdIFcBqViNRoniecarvXL4N/488PNDltaFffThwbyMh4cX7tF+VpHHqksbEjQ4wH4myg7SW5HhaYLpXufOJawy7RPFLh7/kOXDKo3zje16kmeGXMU74GSTR2yn1dhms6HDFNMxDoCKDyakhACOrs1eZM0bYFt+bWdpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190168; c=relaxed/simple;
	bh=tHxanDhKw/72SwqfOXdlAfOZWo9Z3CBq/KN1QFZi/bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9XcPyaDb4367Iy8x/9wGaSV+bHHa6B3KJB4ZqmMsOMpSh9oD0Jiq5HOLSheFg+KiBM2l+YZ5zJZcKUK95/BYRlIj8N+Ve6mw2Val2CbWnNed2e0cGDD6gh1VJoeP3LSgQja0h9/dqNouf2raU1+2wKxDej0vix5+XioNHWsyc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KUHP4ANS; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUF5gFHm4RodXrfj3zpIA1MItFRxEl1n0E+/MQpJF15tF2gmDIppfrZLe7uwgN+RQCxiidEHwWpotMAFAXfLCT+oMU7wuGiV1UkY9A4/o3oj9dAQlN0ME3dzFfB3y4UPLIyE0NDAbCkObiRZPa/ps0vU4WdVbx6/fFcfdqiuloDEsn6+AhcUz23wZWZcB102EZq87LxTIjsM7AXKGYhyMsXIdoVNFsUbNa7EGFNwYFZBzXTe+4cX3XwI6vVcO5UKvd8K/Vtk4NXWCCW6rIy5TXX/T38jpuPuCvMcBfu16R9qyJdoAsG/DoTlS5zgyP8nhXWF2BtjMUqAc9z6D7neMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb0l2wgDCGCtetHLb6UXFkSfaLo/a2imGazWh+TOukk=;
 b=ZVk0soWrITI93r0uaRpn1voXOSBnr26AjK3ga7I9sqgCc+XJ30COLvMKha3dxXbFJywq7iY4R0DdJ7c5b7Ek/1EK9etgDx22uUMkf9mlpJHrx/bpOs8Kd2qG+V7GODnKhJ5DW6cs212kqLJF+RE0alrr6OZp8UMwYLdXL7++T9uY+Fj+gvQlqoIXrA52kuPzmilPsEdzRFzUFc25O3FGBE0806hFGeH5niO4595Sr8GwEYKD2m1EHaY4s4UIxKxH6SbEHOgg6Ij2YFFj/3QApoSenOzFAGeqyb1A2KA+DxGeXIu14vRNkZn2q3NIQ9IvvqOl4YddN6pj+VeTqV8oNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb0l2wgDCGCtetHLb6UXFkSfaLo/a2imGazWh+TOukk=;
 b=KUHP4ANSe4PZf/FDLAlvb/wFF7QWya5et+EnBAHlYwVOtRI1p6Bpr1SJ7D9yJG6uNHQh/1W42M9tDtokWKAlJdkOc80QEka6G9prm6oLETUovP8pD6pUTMf+YDAuQxZdxRAfjB49g5aiZo/XVGGTeSe7chahfoRHFcj+aGB3S5zjfSE3ZUtqok8/RuMdD4xv75UVOpRGxge5RlTNfpy/mUyFaSWGSv4uuQit7uFpvGhG2Pk5JX7JZocLVfkfYcZRHT5Sky6QIYrg0tXihlFaA5Ce9iYR6w4dQaOwKLG+d3Xl9Wjkpp4eNqX4MjmFyXos7F2wBhf9sxyzL7gL7oUwww==
Received: from CY5P221CA0108.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::39) by
 CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Sun, 1 Sep 2024 11:29:21 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::71) by CY5P221CA0108.outlook.office365.com
 (2603:10b6:930:9::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:29:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:29:07 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:29:07 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:28:53 -0700
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
	<rrameshbabu@nvidia.com>, Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v2 05/15] tsnep: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:53 +0300
Message-ID: <20240901112803.212753-6-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c13ac6d-a5de-4a41-467c-08dcca795264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ERMmLXFRVg6TIer4DIUI4dGwKmROBHKbrYYY6IYzpZgwcxrA6Q5pL08VQFgd?=
 =?us-ascii?Q?6UAsQQ57yK6fJ2K1GQ795JbTqQgb0Ra2eCnNyIHens/TBp530Nh3fum4xCSo?=
 =?us-ascii?Q?JGJZBaNzBX43F7kxl9DfEDos67ofcPAHxxp8nFXTX+4891oPF2nJXsu7yxgM?=
 =?us-ascii?Q?KJYMzsKzQoS+FA7MtdYNkdgOn0rrSKJbjnj6Y+K9UwcVKe80nNtQ5pEGec4y?=
 =?us-ascii?Q?IAKuaX2T15ah0nqvTSRZUK6aP6Qx9EEMvWN3G851lw94qXBac805VVP3u6z/?=
 =?us-ascii?Q?OXA5Tp92xNiOeXitjgO25qWHfj9YsBlmZ/uTEhqb8fotRtaq7e/uGMXWQp0N?=
 =?us-ascii?Q?UxUTkoZg8KHU9s0U8lo5Wily4Yy9L3e4gJe4sFkaeJN1FbRzy489n1pBmkbk?=
 =?us-ascii?Q?/LKCeY5LG/yhEoUSyDsLyrMZYk2hHXh0HrRh6/oLl5dxQ0v+S4mXDoGW2Jj7?=
 =?us-ascii?Q?28bk/dC2fwe8Qg98G6mo9HFM/KBE4JZblmx6xcAf2g2qEDhgPQlYVOzOvvCw?=
 =?us-ascii?Q?jqdP5Q11Delrjd+tmdcYunqSecMfZ5xsDXLxWCbioSKTY3wuKP97TY3yZHuH?=
 =?us-ascii?Q?3/BkgOm3L58cOHpTMlMCQWTL6rlxnNMB6mM0npujcLIy8kXuDQ2MV1lldiVv?=
 =?us-ascii?Q?SBXrKQiLM6+alVCoPYFgPchdrogu1FNdy8/K+NuXQ5l7ajzPWbW5RBDDksAR?=
 =?us-ascii?Q?2YVRM4vHgfuvmpcj/yth0o03sGBJlwG/0uvw3lg91HiU4LZ3C8mPsFxolSqC?=
 =?us-ascii?Q?n8wkYWBUKM3TOzjqGZRbaB1dJgXWljPasGLFxEs3PYpKfiPqZmEFIrEqv1hj?=
 =?us-ascii?Q?gAYqxTFVx4ebbinfz4iSge285O44sAcBX6nIKzg4repA24sNJW/lYnvlSIfV?=
 =?us-ascii?Q?Y/5CPERtpdqnLLv7ZRuEWdCDCVC+9jv1lFU0nRiJmiA0TGKRAbYHPGt+iJB+?=
 =?us-ascii?Q?1fljrivVOkNtgfESdyS2toEmYq0U7BWTXDNO0UmKgRzOHb3K4Q97UxCfIicX?=
 =?us-ascii?Q?TGLSO2o6YsJMFG2MPqEbSkNy49NqgDkeGg/pc17QP2ch8CHx5lfqX7GNeU+r?=
 =?us-ascii?Q?6ZUq9keuamKLMUYyTp4dIrLr65Y7NXCHkLOKzgvhWypozpulHBn0xM34mSbn?=
 =?us-ascii?Q?a32Q0H4QHLghzgUYvIhcwILT5dDc51ZdETPLjUQ103t/wgJ1ZQljFQkugtMB?=
 =?us-ascii?Q?slZGbzD1gds+yxb3/fkH9srLEGoM8D0edORmOEmLYi7NA4i9DgjqUbEDVbbV?=
 =?us-ascii?Q?NvUIzkYH0Bf6IPUL//Bxf4a0kx2+u8QrPgdNSINcvEb9NzfpXK4WztgHjcfi?=
 =?us-ascii?Q?2OmV0UfJ7xaj1DqdxD6QHYsrclcQqw8NmkixQe8wlcZGeE08yTxK+qJG2tQE?=
 =?us-ascii?Q?tweFH/N8PBkInfJ0MZK0OYWSGBHSf+d70Iz3x6LMIw7SF8La4zY2bBHrAHIm?=
 =?us-ascii?Q?kYoXufztLyPbi1SsZMEVoZcMcmHbVhDf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:29:20.1143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c13ac6d-a5de-4a41-467c-08dcca795264
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_ethtool.c b/drivers/net/ethernet/engleder/tsnep_ethtool.c
index 9aa286ba1f00..228a638eae16 100644
--- a/drivers/net/ethernet/engleder/tsnep_ethtool.c
+++ b/drivers/net/ethernet/engleder/tsnep_ethtool.c
@@ -310,16 +310,12 @@ static int tsnep_ethtool_get_ts_info(struct net_device *netdev,
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	if (adapter->ptp_clock)
 		info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		info->phc_index = -1;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) |
 			 BIT(HWTSTAMP_TX_ON);
-- 
2.40.1


