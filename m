Return-Path: <netdev+bounces-124846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B8B96B372
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0761C20BCA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D822155314;
	Wed,  4 Sep 2024 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T9TB8U3D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD88121F
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436242; cv=fail; b=EU/QJi0ts7Hx1tqAHAruFDGl+mycJY0kySBT7jC8llEBCpMN18gaMSZ4R2e/aB/Fo7izqeeWO+xbHgdI+milqIPihkykFTLMzQ59Ci149YtKP0FnVtfnki3RydnT11lOzaH1z6MDW3Hlk0eOgh0ho3uHU7MN4pDiSCPbmOuLU7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436242; c=relaxed/simple;
	bh=uDA96t2WMEVu03YxoI0r0+BNm9kg7LvFL918+Eyi26Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ellUS5AQjkcsDS/AqS5KJVyZ7og25rgj92mf/bL6XM6DIyhDQ+ORpZsWI3IM5phz7fJANd4MJXahzszr65ZnROM5y037xdGSPj6c2rn+nDYC+YQrBR6prkUwCXLMoTTq5kDbyaYl1+2El9sEunqqiAeTBC8oVzpbmWEMODuyj8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T9TB8U3D; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrQGOTyuQ23SbhZLVIzLzKjRDcInFvC7DUUVv3pH//v2iMSFIGlm4VRmZLsj0AnOxW3YwjbYR5YP95eTdOTb3Wwyg3plPfaAZx3R5VjdK0ATnE9PhWLKKM6UGRa52C9rafK58Tc7luj35FyO4N5JUGrB8eKNx7pmcsW0yn7mR1umM4tsvIfEQeo2TMije0bJeCDO3CegHDqqd8rN96L2q4X64ZiW8/HrbY541dttZm16bpEoPhOvXQlGW4ZFk00/5XQccuXVVLiL2D+u9AHD18NIuHROX3fObQ3G2KaT0+J6iDKEqYaR3AenPAyc40yzgxqE44vc0F9BCqMQTUggJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Utvebj1AMupXj3+axKD2zkt8cYYlJQJ+SdTElUmWvIA=;
 b=rKT+YhF7yHVecrKjtnai5b6DE0nktclq4SN4A712hmEClLtMaieJ3LWcqKASTYqMgJCtGF/1j8ZEfqE3/hE2x+TdjBKoCGFl2dBd1ZGyQPXTdToLu2Ayhbt3PhdUUnKcLIAymlLOLfIuUkrB9+MJiBQXfRT8XSAMYkMIdOo1kjbBbrFpzPBtGQO+TYX4SEQeZCr3SHB0HLv6t5g5QaqiVzZ87GGc2JgRvZ5Woi3FT7cLbdud1ntZR4YcPCbl8uEIwhVn/V626BkT07H2GPgXHJ0qpVzBQtwNzrAc66ZSl0FC1HNuZXmtsVT9j6by4Fa93ToqkiSGWWUD4RVfyOQ8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utvebj1AMupXj3+axKD2zkt8cYYlJQJ+SdTElUmWvIA=;
 b=T9TB8U3DImH6zvrz6BNKaO5q3oanhSJOgsd4vdV/qbxrh6ZdItt46jWcxsAx9/qVo1clidSwm+YiSzClur3UDL1ESSEWiTsg6AWkz0ZTPzdv+hEb9yEwmyOqzOfp9RYFKYZl93IRZYvSAMOOvLgKTabOTxWjiUIrWCHyTbS58pYjCRpjSrdxtPQ0OozKT1xBkltbxourl6o1Eqr+8iNDaiPtcV0plm6oI5gAmnmBQlHTSt56Hj/qeZjSp74T+cFkJfYXnua2GUsbVez4Y836Jyp+6a597jX+fR7gcGu+FshyuUs3Jp+9hej5c5xnYL3adXhGHmTn/QDr1XyjW1aadQ==
Received: from CH0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:610:e6::16)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:50:35 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:610:e6:cafe::9c) by CH0PR03CA0281.outlook.office365.com
 (2603:10b6:610:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:50:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:50:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:50:17 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:50:04 -0700
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
Subject: [PATCH net-next 04/15] mlxsw: spectrum: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:11 +0300
Message-ID: <20240904074922.256275-5-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 25aa6d62-f2d7-4787-0da3-08dcccb64234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKLvAiTyY9FuNb+jq/mEaOAsC9WgUrmJpVUT420owU5bTBVt1p7ARhCGLIC3?=
 =?us-ascii?Q?RLNYNCFboLGkZVdqbQALoJC40c53lM5HEuPDbs2Gq9+C+JG5PyulSw8hmpb+?=
 =?us-ascii?Q?pXUaipHO5GpXDJqvllnvqPbEZ/TDcnFO9F1dAiXke+eBqNXEQ9wuOeNWDR9O?=
 =?us-ascii?Q?9x6NYezupFuMJibGKXy+/lwcnph8kS4Xw0N8pSGQt1K8JJP8Hh0q0Xfe0oWr?=
 =?us-ascii?Q?JWkLF/nf8hnkPxn7E/Ds9D69+FGBM85kXGvaEA1Lzl9uI0AQuIfHTh5ICLO5?=
 =?us-ascii?Q?6nHzBmjsSpPfNaCc2zIut5dztEdqhQ+Q7bAmFCXYIul2Opm1uUr4AO8I/4xH?=
 =?us-ascii?Q?f3qFh43pljSV0JR5DW+B1yYKVvXrY/PM/kE67YxEwqKuiUxLGJFSaift06KQ?=
 =?us-ascii?Q?0j93Myb7rNUIMsK/04PsdyOhgRJdelVecLfEJZFxH85jI0yuR7opvYuyzC60?=
 =?us-ascii?Q?5NSUXRIX7sc9xVNp53JT4/HEt6W/Oe2QA+m9l8ebz+jRWDM9+DqfbJWGTM8J?=
 =?us-ascii?Q?ZWq9DQt+snbOnFa5ffy7R9N8jj5ZJPnPdroC6rmBCkdlETOAxM/E6kqwtlbI?=
 =?us-ascii?Q?lKbD7LfeYIBOB9WI0TvHsuVj1owLP/Zbo0oiUL4Rr0SaVIJCT8RtGU0R+ijd?=
 =?us-ascii?Q?Iwz7sw/2Vl88jKeyYI68LLrCNmBD+0x9g6IoXLHL5zScP6Ya1DEl2evKUMTv?=
 =?us-ascii?Q?f3u9MYe05/2ZsZ+kHscfGH9J7hHDYw6GRVKCj0qN5Wt5H7iYm9L5DeRUx0gF?=
 =?us-ascii?Q?/ySV8uamszy+otae3IauWJfzMk65CKzYDMd36u3GCoybYSoMQ5Hq1O6xgWEs?=
 =?us-ascii?Q?887xgqJrrApLoovo0r2lk+ENjVZMwl7m+sAMYsnjn1Fz9nj1mrMbmp2tcrQ7?=
 =?us-ascii?Q?aeKdOEgkf+5homa/Ll1nJD21bqKZlDeEZ6sjS/xZgwrZQO4Vj/3ycR7bRKT+?=
 =?us-ascii?Q?fpseEZafKvK1fSOCXgmVEOPywcJeyP7a5t/pW3uYWRSmNf+C0ElhqCQNcOkT?=
 =?us-ascii?Q?s4eRz6/PprLj++jOG9LVMjXq4nK1RXtJooPCK5E+veZIhcnjhTmXjGOQAsb7?=
 =?us-ascii?Q?f9byCElHyhL8Ehn/vysUEbDSGnKThXXADZ0+EYNqMWv9BuQqtrHsKDFiaGjl?=
 =?us-ascii?Q?Xy7LL2I7s28Y7ACKvupmbBjhza1aWjvUMsvcIqiFA16KaiZeNAwR+aw+rlPw?=
 =?us-ascii?Q?1qKHGnwpBVVhlmH5en30pEUk3bXhTfyMH/gwJAPMRQUynN/S8degDWtXsQeM?=
 =?us-ascii?Q?k2XPB0rOtep4ZecJqr8ImvLeC5jO021w+4mIB++vBV+aEp9mrLJ8eLaYeEg6?=
 =?us-ascii?Q?0ckqUjRHZOo/cUZdOeVNIiaVdqjkFEOl8c9wbKWOmwsq/D4DcU/xNkVHimR2?=
 =?us-ascii?Q?uSoeXc7c646QhWvF8yh9jePsj2dai/Qlaj3bZv2+cehfnOFoYyKIS0bTv8n7?=
 =?us-ascii?Q?NgmX5vHP78w+cJKiS6s1+zBiGTQhYUOV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:50:34.5652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aa6d62-f2d7-4787-0da3-08dcccb64234
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++++++
 .../ethernet/mellanox/mlxsw/spectrum_ptp.h    | 20 -------------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index f064789f3240..b749879b3daa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2784,7 +2784,9 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp1_ptp_ops = {
 	.hwtstamp_get	= mlxsw_sp1_ptp_hwtstamp_get,
 	.hwtstamp_set	= mlxsw_sp1_ptp_hwtstamp_set,
 	.shaper_work	= mlxsw_sp1_ptp_shaper_work,
+#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 	.get_ts_info	= mlxsw_sp1_ptp_get_ts_info,
+#endif
 	.get_stats_count = mlxsw_sp1_get_stats_count,
 	.get_stats_strings = mlxsw_sp1_get_stats_strings,
 	.get_stats	= mlxsw_sp1_get_stats,
@@ -2801,7 +2803,9 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp2_ptp_ops = {
 	.hwtstamp_get	= mlxsw_sp2_ptp_hwtstamp_get,
 	.hwtstamp_set	= mlxsw_sp2_ptp_hwtstamp_set,
 	.shaper_work	= mlxsw_sp2_ptp_shaper_work,
+#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 	.get_ts_info	= mlxsw_sp2_ptp_get_ts_info,
+#endif
 	.get_stats_count = mlxsw_sp2_get_stats_count,
 	.get_stats_strings = mlxsw_sp2_get_stats_strings,
 	.get_stats	= mlxsw_sp2_get_stats,
@@ -2818,7 +2822,9 @@ static const struct mlxsw_sp_ptp_ops mlxsw_sp4_ptp_ops = {
 	.hwtstamp_get	= mlxsw_sp2_ptp_hwtstamp_get,
 	.hwtstamp_set	= mlxsw_sp2_ptp_hwtstamp_set,
 	.shaper_work	= mlxsw_sp2_ptp_shaper_work,
+#if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 	.get_ts_info	= mlxsw_sp2_ptp_get_ts_info,
+#endif
 	.get_stats_count = mlxsw_sp2_get_stats_count,
 	.get_stats_strings = mlxsw_sp2_get_stats_strings,
 	.get_stats	= mlxsw_sp2_get_stats,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
index 769095d4932d..c8aa1452fbb9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
@@ -11,14 +11,6 @@ struct mlxsw_sp;
 struct mlxsw_sp_port;
 struct mlxsw_sp_ptp_clock;
 
-static inline int mlxsw_sp_ptp_get_ts_info_noptp(struct kernel_ethtool_ts_info *info)
-{
-	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE;
-	info->phc_index = -1;
-	return 0;
-}
-
 #if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 
 struct mlxsw_sp_ptp_clock *
@@ -151,12 +143,6 @@ static inline void mlxsw_sp1_ptp_shaper_work(struct work_struct *work)
 {
 }
 
-static inline int mlxsw_sp1_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-					    struct kernel_ethtool_ts_info *info)
-{
-	return mlxsw_sp_ptp_get_ts_info_noptp(info);
-}
-
 static inline int mlxsw_sp1_get_stats_count(void)
 {
 	return 0;
@@ -226,12 +212,6 @@ mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	return -EOPNOTSUPP;
 }
 
-static inline int mlxsw_sp2_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
-					    struct kernel_ethtool_ts_info *info)
-{
-	return mlxsw_sp_ptp_get_ts_info_noptp(info);
-}
-
 static inline int
 mlxsw_sp2_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
 			      struct mlxsw_sp_port *mlxsw_sp_port,
-- 
2.40.1


