Return-Path: <netdev+bounces-42564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0937CF545
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E1B1C20F90
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDDE1DFEF;
	Thu, 19 Oct 2023 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T9qRIcmC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B518C1D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A2129
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSTZgFWGEBU5UYPgCGjnUxqbPqIp4KYX0cfu4GDh/HbXd1BVoFp6pWvOr4aFvM/TOBL2V2QO3yKuoVyKFPcMVJRpQTpydQdEvWfEgSLxPEej2LeSpSy369y68UJiU2vVYQ3FnbVJbpmLAiJKbzVMqZ9KDohySX8wkAwcqahttucQV0OGO0776cTNIOxeCkvBIpO0UBmK4qlmSMAUcmSOrBWIBhg6pO4SexLlkHecJ3gXvRp3yU27PkFMx719BYEYabXIWj8s98fMzjv2z9IarDXwzoBbYQgE73U389mTrjVL36ImoPckh0vK/aoRCMOY7VpHLHTM+LS6uZJ9ZzWeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYcBaw6XqfGcrj8B3yNG/wGcwXobKANqrAnIC04sCww=;
 b=cZ05fb2QCeklicJEsa0MY5GV4/7GlXAmuA1vbhLXsnmT1bQ3aCbqVzm34xHqXxTyggShgtDW7AJgBpD7X5T6l/u/V7mgWUxDa//rAnI1rJXh9awkDTMyeUJ9gIzv33L49lmnG3JBLb4admMvHPnQxbmyABmyxQBQy8/Tm+VtXYm8+bau+y5m5D8em9ZRfns+ouPh/3DQOTVgGTiXYkk6t/mVqY4uuGFW7GvIRcAQmQ2FaQEksGzm/f4fXeFclJBDS2nisKkkKIQuVi6C99NKjr67p6PLJZlZcOZRz7io8u7q0zmDt6YxI3K4AL0S6eWXcWTuQ+QyEKVisd97HVtKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYcBaw6XqfGcrj8B3yNG/wGcwXobKANqrAnIC04sCww=;
 b=T9qRIcmCtkF0seIX+KE/ecPWiUG50S6zjyxq7GmAfJHS1sSQ6ADCmABY6YIJST1YZh0fHqJkICxLvOZXjLz933WaqUvUb/aW10p4tS7YJ2uVxAap10yBzej5vNZlwXyc2IY9MgT5MzDJevRs+r3YbJ19Y37enCs/loNleJ4e+Ofc3660oflfmhsmVt9FH3vpIqHQC/97Pb7jTDW/9rcUkDaNLgPuucrGVoE3j/crgpYGEr8yqep2tQ57LmGVXbT4FIWEXwuWMPPsnmBg+aTkvZ//EHGuGSvXmXA4TlZLMLFc5Lfpkt4uhH86i2CCjM17M8O2hn9e6pEL4R66jYtxJg==
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 10:28:24 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::fc) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 10:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 10:28:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:28:05 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:28:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 11/11] mlxsw: spectrum: Set SW LAG mode on Spectrum>1
Date: Thu, 19 Oct 2023 12:27:20 +0200
Message-ID: <478c8b531ed8a733fc5c621a648ccccb25361de1.1697710282.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697710282.git.petrm@nvidia.com>
References: <cover.1697710282.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 692e00d0-2c70-4b39-bb88-08dbd08e1f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5p7Bx4JtxNUuxsiVA7WUm/9lgp1ktglyJJVcb16GFjLnR57IMVpw6Zza0QVMJLRyi1fFHZfBbUVHfeu8yWGPHAVggLWR5SOf/JweX07VUTamCS4S9GNySiZBeAbTxhMftaECeLwxzU30oOq5UaGCkmUly5o68nFF5YaO8YaU1p3v2xhyCBlkYCwc9DTrx8tygkSi2TfSTpOiyTj4b8C0bNJXNd8yGxBmpDlkV4wTEzPOgTsqUBgoGKwrCMZ62limxT8p9Kz3iHDUIBs1kKdG9YOkdbp2T4VXEgE4+UG5g6IlgSqewWxNLdI4YDu2w8X2Fx9SqpgbMHkf5RTqm50ea5xKKhz5WiQpjAsqNPuX6W17Qfopnop9JCf3i4TShr6GJYsUwFIrfqVu1kg/aUGonJgTj3Ip2CLXNelr6P18/UjlOWegOdDOi56pbeVI5F+DectEmJNrUOzMHsuweevckrf+i42rObJ0OR6xeciP/rcYJZS9sUHRhQPUm6FWtt0lB+1EkCmK/ZMFeu+Q+azvn14nWZFmk/X1/mH2i2l8yapDjEApUbRwkVEoeKPt+ZmKdiWwdQAS2CZ+CZsBtwywdEkZeLaHaTEEXohHPGPZs+2g9tLyi9htg0bL8UGkG+Q0+7p3biFQb4v9OOlWjKbSYrr8P6tiVrlqb8mZkFFH2rWIPVsUZ/ZODbaCB8uRzeOBCRpepinMpROWWtYi9S4YrYDvo6aXCwNRrFPuHlRx2SleLj5Hz5Iq5pb4YkCzMQcb
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(5660300002)(8676002)(4326008)(36756003)(8936002)(40480700001)(41300700001)(316002)(110136005)(54906003)(70586007)(70206006)(86362001)(478600001)(6666004)(107886003)(2616005)(7696005)(26005)(426003)(7636003)(356005)(82740400003)(336012)(36860700001)(16526019)(83380400001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:23.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692e00d0-2c70-4b39-bb88-08dbd08e1f7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823

On Spectrum-2, Spectrum-3 and Spectrum-4 machines, request SW
responsibility for placement of the LAG table.

On Spectrum-1, some FW versions claim to support lag_mode field despite
quietly ignoring any settings made to that field. Thus refrain from
attempting to configure lag_mode on those systems at all.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index d383d00dd860..cec72d99d9c9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3597,6 +3597,7 @@ static const struct mlxsw_config_profile mlxsw_sp2_config_profile = {
 	},
 	.used_cqe_time_stamp_type	= 1,
 	.cqe_time_stamp_type		= MLXSW_CMD_MBOX_CONFIG_PROFILE_CQE_TIME_STAMP_TYPE_UTC,
+	.lag_mode_prefer_sw		= true,
 };
 
 /* Reduce number of LAGs from full capacity (256) to the maximum supported LAGs
@@ -3624,6 +3625,7 @@ static const struct mlxsw_config_profile mlxsw_sp4_config_profile = {
 	},
 	.used_cqe_time_stamp_type	= 1,
 	.cqe_time_stamp_type		= MLXSW_CMD_MBOX_CONFIG_PROFILE_CQE_TIME_STAMP_TYPE_UTC,
+	.lag_mode_prefer_sw		= true,
 };
 
 static void
-- 
2.41.0


