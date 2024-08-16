Return-Path: <netdev+bounces-119308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD095520B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A16286380
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767631C579A;
	Fri, 16 Aug 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VrfXfV2S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A01C578F;
	Fri, 16 Aug 2024 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841314; cv=fail; b=DYmC+fqON59wmpLqj7XHmldqL3y1EPEecolhbOdQU61KlJKrKW/EebFdx6wjckocWOd+0j76LDcW8XKJt5XFQg2UHO1svPzUdKYly+azA9UGaSXeijv3xT/8/44wLBRLhNCcvx9idaOWvrwS2xukRX0hbP/KZVYSYiUdSoVFgEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841314; c=relaxed/simple;
	bh=9VR8aCjOfNeddn/s+7+YcSjMloDCSSjtPUTUjtUfYno=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zy01ukugaQY50FMeTcHLJoSY9f00POt8B9quG4ZZbUqpMUI9iXI33HMMOtqtrIcBI6k70rtCc605kXdLyIkKd8rV+LPzlkhxDLku/L8Zs/DhIxcY9yrzKvQRDknl+WMyImysZgWfe0e+Y64lQZ3u1PIkJYHkHoLiVmk9Dgr7am0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VrfXfV2S; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHWvVipgxb6UqO6hs5pFBawjKwcdOqc5xh46pqiLBaMdaJY5EHiqFk9e3AGYjoGBIm4HudlhnNBLzFUDjQtic1b+OllFjy0fmAA3TmoPp8jTcYzeynQI58wTpESdmVPt63Lcna1P8pYea6yaViIS+2vmfzrC+srIhj+j/OsID9rnrJ/q+fNxmD7KF4eQwXx8ysfoUODQEDe/Qgwi2pMiGZfXI0YJEXFaRz2xAJUpvjup0YZbuyEeynABaox1r0rPi9VBnB3G5l8fT2oGeXnn0Y4YffwviENG8AOL4kk9R62xwmpK3poWn8vLnavlvtDsOeq3PWpk7lpmsHqL4Bhy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaJYPzzvkmruqXrAemQTLZ0LFEa64UATLtNMhowwbr4=;
 b=Ia+A5Y6SOrmKNV7EOzvVvEMnSV2LKi2omQJ/zQeOK/IlbYmlk6w078Xyx58Oun3begVpHYywEiAz2RcvkUW9x2Q3MpPwYwlAy2ySe8F4Vp7b2ErJw1tUtphTdwOVFWSOVik8HeKQeVWAgUZ9G14eruzsrz+Yv47HnDrLKpd4kL0Z+/rIHU2HzurCUW5KVgjUIQi3u+hfZOsYO4RWvGTiq/w+j7KIhRL+5PaN0YrN4azj433czmzMSdpE5P++XHWCGh/lJ4CS8B3b3lI+IPT37Cdq2ji/jsucX2Pd1keWw91Se9ZGt/f6yDhL2vM54UjKzMLC2rPYjXpldcS4PsfeAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaJYPzzvkmruqXrAemQTLZ0LFEa64UATLtNMhowwbr4=;
 b=VrfXfV2SCxTcy5a1diQyCEFPlFf3rtndskZ4txMeqAuM+pL2uPTYPQYuZdlGz9NRbMeAkNgVDejeRCyewyk0spmmUIagVefyEQO0VxRFCzW/CZFHfyogy+SdRF8prMlCWIcK+fLPMLY1SVuxJhz0iQFjoPp/42ciFOpAm8kZCDUQw+5K6h/tCYujQvNj+j7rO9UiHqwJANRucGeH5GWNkuE2O2CdEg+0H9QSWg41HmAD2fGpt18oLxl3bahRsNYYaZGab2VTLGgsf6AU2L3Fi719kDigOj4D0kwia3hSgFuV8MmDyj3b6R3SU7aRYajXWq8Snmjce4iRmsIC5JzEcQ==
Received: from MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29) by
 IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Fri, 16 Aug 2024 20:48:26 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::7c) by MW2PR16CA0016.outlook.office365.com
 (2603:10b6:907::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 20:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 20:48:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 13:48:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 13:48:11 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 16 Aug
 2024 13:48:10 -0700
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andriy.shevchenko@linux.intel.com>,
	<u.kleine-koenig@pengutronix.de>
CC: <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH net v1] mlxbf_gige: disable port during stop()
Date: Fri, 16 Aug 2024 16:48:08 -0400
Message-ID: <20240816204808.30359-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: bf57452b-0ccf-41df-a6ce-08dcbe34c6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GgLcaPJosYWKnTP72s7U3EqZcqY20Cv2nFa2FLatO//iSiGxN3PifxfVxgu?=
 =?us-ascii?Q?t3r9l6eeOM1DaaiAWPgRnngmKvmsH9sq8zQKZJZ3ozm3JU0kX2DuZx8Npn5G?=
 =?us-ascii?Q?Ne44uZw3W6fCoHXGzxirFW2imqk+BS1Epq+S1U71gRVqbjyIIutJIIyYKrHw?=
 =?us-ascii?Q?xbVguqtMjbO7cdzVaF3CkGPt/jO4eRqM48Vnv1jtp7ijBkNCzcMQotoxCaTc?=
 =?us-ascii?Q?HzHAIDs99iint6We7ihUb0R91v9NLWELJDrG+S+UpsS9IAEVEd0Z19Du2zpq?=
 =?us-ascii?Q?9RdkOPjmcbR1L9mTvUrqX9qN7OAQvSAU0AyZayb+3nYQkqMHp5HZ4lP0w5qP?=
 =?us-ascii?Q?yNBKfTPzGMQ0zdA3cGn4JAaomOpxLxHaLno9ES79Qyb3/KuAxSsQu6SqZCw5?=
 =?us-ascii?Q?gX3Mt2bbZPjZXjnYq4y59/+qJOHqEIYu4aHns0KCJcTLt2rcBBK/69FW+Z1f?=
 =?us-ascii?Q?FNlELSAbRRDTXZAPM2C3+Wk2sSdflsyCeZQaHXo0i6xwNF6N1dn/eJjbmHtB?=
 =?us-ascii?Q?j5qHPCOZRvl/YtVS1GdI6H2OdaaGZHWPQk+/ASJBXkV3R8YEKHnssh6ivR0R?=
 =?us-ascii?Q?1qE174VKEl/ZcbuOTEnGNrTiipkl+qx/dFpIIQtkZb73fJuwYGafVVRCGJhp?=
 =?us-ascii?Q?88tgXF+H1R1DZwgpbU3OzMzidZivrMFwGAcSehKrJP6JdyGHYK+cO15XyRah?=
 =?us-ascii?Q?jqy4z0gCKms9ztvfuaE1QgnGIxBSwfiNlH+juL/5xUVMagBOerTQ7i48WpLx?=
 =?us-ascii?Q?D/Z4XRR0s8d/iVDj3Z+/h40Fs/nqeumgjkn5jfMir4I/KW/g3luKW3EwUJIF?=
 =?us-ascii?Q?sXSS0Ts25AteZKpmhUrHKyEqcoCq4bqUC25f3NLdYihFdsajBu9wRWw3ZtQD?=
 =?us-ascii?Q?c4NDsi4TNJvv1+ueIeVw91Ave+mNViD3WhhVFBFVGbA5UrZ6/L1hVodn8yh9?=
 =?us-ascii?Q?wTmZ9zObPqfLxp1OP/8yM4hhwYSInwbtdn3x77kO6IU7R5n4dLHBfuRlGmPb?=
 =?us-ascii?Q?ODljEz39mVUBLj7dAjeBya0zL91dJzCC074HHBoKzUdDjuJmzyDFUgxlHrnF?=
 =?us-ascii?Q?l+kZP8VMtlK8PCuQed83huTVGTTv2B4MvUx9f5KQjioP3LsW9rhGthX3IJ7/?=
 =?us-ascii?Q?bdud9fsz6Ovo2ZNMqYjC2vc0LDq2y0vY7C9nfYTovHisVibkJ86rqF9hl8as?=
 =?us-ascii?Q?I7UqRigvhlSLNVCueclVvFC1iiCXCKYwVRWMDIh/hq0j1WM/QSqqy9nQe825?=
 =?us-ascii?Q?rT57WDqGHp6qPi/9WtlxyefRXfP4UtHXRoFud66juiB/kuylc1KZnJ9qHY53?=
 =?us-ascii?Q?a7XQTkVkxHWgXaZmmCGwSrL9Nlw7E0fp6644GeZ0hvA8Eoa4LYp+Uq2ji9AT?=
 =?us-ascii?Q?/evMADH+N9FNFR7QSVzPCeXI0TYXJJ0WBxitfdpTFIQVvCdcFqp3IGJolqBx?=
 =?us-ascii?Q?UXaje6wNPnKr+3dFPGnytkSscWwdFQLH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:48:25.9510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf57452b-0ccf-41df-a6ce-08dcbe34c6b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735

The mlxbf_gige_open() routine initializes and enables the
Gigabit Ethernet port from a hardware point of view. The
mlxbf_gige_stop() routine must disable the port hardware
to fully quiesce it.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 385a56ac7348..12942a50e1bb 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -205,8 +205,14 @@ static int mlxbf_gige_open(struct net_device *netdev)
 static int mlxbf_gige_stop(struct net_device *netdev)
 {
 	struct mlxbf_gige *priv = netdev_priv(netdev);
+	u64 control;
+
+	control = readq(priv->base + MLXBF_GIGE_CONTROL);
+	control &= ~MLXBF_GIGE_CONTROL_PORT_EN;
+	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
 
 	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
+	mb();
 	netif_stop_queue(netdev);
 	napi_disable(&priv->napi);
 	netif_napi_del(&priv->napi);
-- 
2.30.1


