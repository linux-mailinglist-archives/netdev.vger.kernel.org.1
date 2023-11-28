Return-Path: <netdev+bounces-51751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA297FBE96
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E21CB216DE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437535289;
	Tue, 28 Nov 2023 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fd62gCn7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA0010E7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:52:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDmrS3XeLHu5g+pKAO6XGCd8RkRjSAmz9qFCUi22/QeFWIKZ2K6knwRjoN/tHsw44i/0rTX+DfHQjX2Yy78TpwGADRER19nWI0MHAoxunL2i5nH19+vY/jzldoyjtIXIMjUl82J8HPIYoxWT6sxgTD36I5+MyBwxjp/GuSGds76IZYyy4ACfOimx4LhIBwTmwLV4LR2f2jfutFDqySLHe85zeG/V5ZFIdvtDCto3ogC3CHH/bxv4s4KWbdbTZFosE/vNBDLC2f+VYG+jzueTZIE0Dqowxpt3uqQPWKf8tDM+qYwIgiVw3M8XGy1GpCmQld6xZllezEF70ihFWgrMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+dDZzDiO7Cm53vfw3/q9SdP8VtXi+eBl4p3x+HXpqQ=;
 b=W6CwyB6otwmOnYDSiJuG8mmNgMZIcRRqSQxVyZOB8A12Wgm6x9ozsDej9Z2TdNxHaFbf+12Gp27lDvfzlRqwz+6t0/rv4pGs+jWrLXu17x/0qlg4NCg3LzXfxUSLHI91/9he06t8MY8oXhXPJTno1k4PaUJA2fO0E59ASGSA+ZyArNRFPVjiLVRlHOI8dEBZzz7G+zIrWF5gbQFZXxc+Dme6R/tPaFaj1urOpb1tpQahAtMRCX0R9Sx9W7O0mlUoUOLmFKe+HGAd919tflRqy65i6sBGHcwlMmM7YM3vCuLsM9FwITT6qWrJ/KgEprsgd5B11Q8zrDNZnXrVrcrwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+dDZzDiO7Cm53vfw3/q9SdP8VtXi+eBl4p3x+HXpqQ=;
 b=fd62gCn73yVIjtYkZJ9Ix4JGt9s64i9ObIyYkAYdio3Cm4R5GgeoI/F4CWrkV2FuxRjSeiUnOyeQQ+twz0Lv44OjfH3EHn0Y0QWMdb/bwnyrwR38+D8G+jVGWpp8YFs0iiWT52c2JnaRlrzEVWfdm5xqjZOuZPI1p7a55Y6giaa/zIRSXyNFl03+V+ax44iZ0payhhMpPw81T2Mbvne7sMZa1xxtopIygV9DmHmP6xO09MUMD8Y/x+MsuXt3qy9eRVVXk/UdsTXL7rSBJ9Iu3yEVaS25028F6vNB5kpjMd0QZ7q7SLfvDiaMPuzHU+6GasoFCbLpAUc20LuaTtoDDg==
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 15:52:07 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::99) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:52:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:52 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:49 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 17/17] mlxsw: spectrum: Use CFF mode where available
Date: Tue, 28 Nov 2023 16:50:50 +0100
Message-ID: <8a3d2ad96b943f7e3f53f998bd333a14e19cd641.1701183892.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8a5e0f-db4b-4322-82ee-08dbf029f94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K3IfhUOk8wIcEdiIxr6SEI0ZCz6dODfOLs1pcUmUyvtBflbwkkHwsmqMYnmw6mUD5dldfDMLN4if1YpAWnCXFer75qwbkrkjQ2mm8XqcF3Oxb5SgAKcZWyIej7nYg1NF2KCC+dbVyMiX/HQ3zAkaotAxyXGCEcrzkucuDjPyYsUywCtvPrRc3KOUz5bqnIORpfgrTOwng3QLa/ccO1B0s+Wosk6eUPqR7liXVcLTsZvGdcnBiXb28JCIomtz6HgyH15UxGZ76pI+YdIGJMYn6hSiaKej0jQW3TRSdA87JdyQcPrJLWxuoPZTt4WOIevIlCf7757pNdPI8E6MpBQUKxdGKF8kdwNr+6EpMZyPmbSyG8mY2E7kZXPbGawyvq1eCbPfW+FcYBG7e69QRiZHzD1k2O2p14Ce/VYa1wt6nRY/cC6wXBj4IcA60WZB+jDjctGjKZVcPZT2Baj4Hxa4ez5ceYHoZAYvREh+4MuGbgXwR3iCRr6M3vUKgfiI0wUOvjw1U/KfcVJZHxYn//KzjmEkt9w3cJGiq3PMtVaoHErLmEM30wjHZTBJOLX9Iyq7CGBAKpEZIaaIzirQRoM7YV22V5gpZo+LXT3De/3YxHm8KyOrVJiAI2uh54cTqUnjMs6VwX8G75BrKlmjrO9xqwA8g+jwkxfZKEOPFrRbSBIP/SV7zSnNG7tvlbzBnoZzBie1Imix+Yof823GDBX6SrUdYD/SjcUFvWFrmHyj235tmeMSl3NTlpyUQqv00O0Y
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(107886003)(2616005)(26005)(16526019)(6666004)(336012)(426003)(8676002)(8936002)(4326008)(82740400003)(5660300002)(86362001)(478600001)(316002)(70586007)(70206006)(110136005)(54906003)(36860700001)(7636003)(356005)(47076005)(36756003)(40480700001)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:52:06.9182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8a5e0f-db4b-4322-82ee-08dbf029f94f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

Mark all Spectrum>2 systems as preferring CFF flood mode if supported by
the firmware.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index e3ef63e265d2..5d3413636a62 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3598,6 +3598,7 @@ static const struct mlxsw_config_profile mlxsw_sp2_config_profile = {
 	.used_cqe_time_stamp_type	= 1,
 	.cqe_time_stamp_type		= MLXSW_CMD_MBOX_CONFIG_PROFILE_CQE_TIME_STAMP_TYPE_UTC,
 	.lag_mode_prefer_sw		= true,
+	.flood_mode_prefer_cff		= true,
 };
 
 /* Reduce number of LAGs from full capacity (256) to the maximum supported LAGs
@@ -3626,6 +3627,7 @@ static const struct mlxsw_config_profile mlxsw_sp4_config_profile = {
 	.used_cqe_time_stamp_type	= 1,
 	.cqe_time_stamp_type		= MLXSW_CMD_MBOX_CONFIG_PROFILE_CQE_TIME_STAMP_TYPE_UTC,
 	.lag_mode_prefer_sw		= true,
+	.flood_mode_prefer_cff		= true,
 };
 
 static void
-- 
2.41.0


