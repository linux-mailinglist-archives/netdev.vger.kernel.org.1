Return-Path: <netdev+bounces-49347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F17F1C63
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9476228219C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2331C32196;
	Mon, 20 Nov 2023 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0E3HT7E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1FCB
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQXn1XjP3NT4wnEkGMduj+Anw28BKDnRBh/5ndHDTy7Z3i9FLgz3xUHCgtHWV5I5rQlhNG0L+KdvTk5jQ+HM4exoEB6FWtpZH3ajk2oJ19l/Z2wdAv3NK8Z7DyPNrv/dE3PxiR9rUn8w5Vd0LI46rB1RcytB0I89OC1RZFwsiIlh+/npDAmWgdF+jTAePnRY19ocms+G0zHtxmCDa1kpCHQCEghTZttLZTkNIy0U6qHv9re7tCXNzsaaP9VMEDnPB8OBNWpMn6IBI5fVgpBPQNzZeAv9mk9DiI0RIjfmIcBDqtbTv4SbTusMZMom3bT0eeZE+331XOMZAQh42o7SOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04dmNv8DhQrvHPVWuL0/GWFk4U5bdhfw+MzQyPg6+Y0=;
 b=B7oD6P/oh6LF6DvDNluh+dg/CphUEkPpEYcrRu6e/YmATPdGLFP8xfFe8owk9WhUuoptWA/DI/q9x4/N/pxjDXlZki0oapAaGE/TbsOnE/WtQlBktRC/GPy3UkmTsbVcKkemwrE9JfVO9t6nMI7AMFEjN6CKyBIe9wfZoSsPvFrXaY7tmjSMXl1fU6D1QfC0Hk7U4k9pCVsylUuEwpBZWXmYxQs4OFtQRoHLqtnxEZTmTnxJ5809DPQ2PV8R1UMWlH1yfGR0qS3rMaZ0BvMtIYAMKr9AWap01hRQz70drj04FOLSPAhqJaVPiJ7yT79u1/EuA1F7YqrHdCpMCUXHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04dmNv8DhQrvHPVWuL0/GWFk4U5bdhfw+MzQyPg6+Y0=;
 b=Z0E3HT7E46QFw3MxDISf4WfXlHzvRsQQoWiIj3QNCnp9e+ZLkDvD/nWU9CeO0LiGbfVZAziieVrrkUd7APbEGLL97by+rnG3jh5O+7aaFticUXGJLo926553FR1aSCsEDbvN98/NLf1Mih23LCokjB3M3/SI6LlAgFU0X9VlAh20kn0Y3RMS+gBoiGQJ16sIE9BS2htbEdx6eDoJdp8sFiWROWaXbFfeTAVGsVzw95v9f0VZikvTUoY4+MDGOfn5bIjnZdy/z5ICR0jv24iCRAAoI/7P38AjeEltTYeUu1kmvKjBDiJpPlCBOsUMkURklxf2XU30AXD2bFboMSdq9g==
Received: from DM6PR04CA0029.namprd04.prod.outlook.com (2603:10b6:5:334::34)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:28:25 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::af) by DM6PR04CA0029.outlook.office365.com
 (2603:10b6:5:334::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:28:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:11 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:08 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 13/14] mlxsw: spectrum_router: Add a helper to get subport number from a RIF
Date: Mon, 20 Nov 2023 19:25:30 +0100
Message-ID: <d7ab43cf5b021f785f363f236e4b6780d10eea93.1700503644.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
References: <cover.1700503643.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 45080871-73e1-4cbe-e8bd-08dbe9f67bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4QPaw9et5S4o+Ow9LOVhkR4bX6EexgE2bHBbZOBENksofAj92HResuZiCQlxN/f6t9erri/bZqadiYiPfU4+HZW/EysZS5AgXF6kzJeWaX43dvg0uvLxjJD14+0Sv2q9CT+jYL6pR3gDY2natvUILLsAjB1rIuLwHg+UsXX1Zxnc48VxszYy/r0xqMb0L5mUtgcO31H/HlKU1slmaGszeIorcx3W5IApJ+pukhZE0bCnjQBJeckXSXh02uAgfzm813SFyP7cLo8Flo6WQbI+o3ExoEcfMFp7awwIrhN+VGgx4t/nPudLN8YI4YGnRbHHDT+Q+7zaA8tmiSIh9uuwlFT651WW0ZvRvujcxXMT/jRH7KJszjK7UeKXDoF6EaaQ+NHi/GKMKu7G30JFRsP/udE6kFRAEk9bS5BTQgms46rjz971qyETB1Sr4b+wP2tF02zPPAkV4qTQuvvR5qRHLzrou+kr95Yez4/PZpG/vRHxpWCFjrLtRDYEgnZK5KXFXbvxEUb9k2R5de3HNpl1QaGf4GziV5q5zg9UnJQ39IcdTq8gmBjgssi1zMhaauhLxUw2iIapADbTLG/JsO/jKJdbHRwLxzd0QfwJ6VXPAHp+VfTgIRvqxtXDWSpZCzhL5pKmT/YSKIi90tTkMx4h32T6OwFyaURnSsqVwgQswYocekoJKSDDg/YicIDqaYbsmNyUnTDcBPiZB4kLOkohXeT2C4tgr/BGEUeGsnkxN1yn0GHDIAQfXjmk2fp59CY3
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(36840700001)(40470700004)(46966006)(41300700001)(36756003)(86362001)(5660300002)(2906002)(40460700003)(7636003)(356005)(40480700001)(47076005)(2616005)(6666004)(82740400003)(66574015)(426003)(336012)(107886003)(478600001)(16526019)(26005)(70586007)(70206006)(316002)(54906003)(4326008)(8676002)(8936002)(110136005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:28:25.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45080871-73e1-4cbe-e8bd-08dbe9f67bdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

In the CFF flood mode, responsibility for management of the PGT entries for
rFIDs is moved from FW to the driver. All rFIDs are based off either a
front panel port, or a LAG port. The flood vectors for port-based rFIDs
enable just the port itself, the ones for LAG-based rFIDs enable all member
ports of the LAG in question.

Since all rFIDs based off the same port have the same flood vector, and
similarly for LAG-based rFIDs, the flood entries are shared. The PGT
address of the flood vector is therefore determined based on the port (or
LAG) number of the RIF connected with the rFID.

Add a helper to determine subport number given a RIF, to be used in these
calculations.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  2 ++
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index c70333b460ea..800c461deefa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -753,6 +753,8 @@ union mlxsw_sp_l3addr {
 };
 
 u16 mlxsw_sp_rif_index(const struct mlxsw_sp_rif *rif);
+int mlxsw_sp_rif_subport_port(const struct mlxsw_sp_rif *rif,
+			      u16 *port, bool *is_lag);
 int mlxsw_sp_router_init(struct mlxsw_sp *mlxsw_sp,
 			 struct netlink_ext_ack *extack);
 void mlxsw_sp_router_fini(struct mlxsw_sp *mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 82a95125d9ca..a358ceb4e1d0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8660,6 +8660,20 @@ mlxsw_sp_rif_subport_rif(const struct mlxsw_sp_rif *rif)
 	return container_of(rif, struct mlxsw_sp_rif_subport, common);
 }
 
+int mlxsw_sp_rif_subport_port(const struct mlxsw_sp_rif *rif,
+			      u16 *port, bool *is_lag)
+{
+	struct mlxsw_sp_rif_subport *rif_subport;
+
+	if (WARN_ON(rif->ops->type != MLXSW_SP_RIF_TYPE_SUBPORT))
+		return -EINVAL;
+
+	rif_subport = mlxsw_sp_rif_subport_rif(rif);
+	*is_lag = rif_subport->lag;
+	*port = *is_lag ? rif_subport->lag_id : rif_subport->system_port;
+	return 0;
+}
+
 static struct mlxsw_sp_rif *
 mlxsw_sp_rif_subport_get(struct mlxsw_sp *mlxsw_sp,
 			 const struct mlxsw_sp_rif_params *params,
-- 
2.41.0


