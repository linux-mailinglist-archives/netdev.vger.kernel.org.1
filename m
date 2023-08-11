Return-Path: <netdev+bounces-26836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941217792A2
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0542804D2
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC32AB21;
	Fri, 11 Aug 2023 15:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA91749D
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:15:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4619C30DA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic0o+o+tY8AcKPlmxf5mDlOjkcFgtCowJ9qL5BiYSrH9MCCWQcMwZeLUpGpov4o4/INtWLKyqhMQ17dzJtfRYRAurJ8mGIVshYEDPuDtwwfFDmcKB/OJKPZd1MiNw57ySTs16Gb3anf8zee3uoyvv80Xl8c8uZ5olJTUJcB3y2yNW3rGQIAtHwM4f+Rg3HXdvDbIRSFnOXQTYX4VLzJoMVsSA38o7Rjq9lpAFFShJfuyWcg09bH0KB1d442Mu9FYHOOR1dt5+GObFX8vrxMBYZLEJQiWKGNfJY2oiCvC77tpQKlwGI6SF5sg4CgCo/PiK7JExDwfrjZyPJiQf+JJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO+L1AlL7xuLh2tvYSU+qzp+F7VjC4wOEyPTf5W/quY=;
 b=MWwjjcA9pHT7EWANhj6C0tD5YjWQfuB0QKUZIAw2ViexyRUdkAEPeiLsm+qskjDhOb04m/5FMBwe+okLkmyyaimfCzjhjrDJtokxQ+BdjjajhOiubFGHzho05NtJoy57WBTBlY6foLK/ealZ8eTlifJnHHWZ87WaiC11pCEnmyMJS2bgV2cpMSX9pDBvGvAag37v54A8v2gXcv02QwfNhKzVLJSWF7BtSpsJPsgG0LCCqdkRZT7MxYjOAs5vvGK1DbLapObmml39wAQS8oSSXA2kHTxku6RgpowtBqVWeNgfejQGxh0cNQTBxEj8Qaoke9N3zHMAl+i70VOF5HQRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO+L1AlL7xuLh2tvYSU+qzp+F7VjC4wOEyPTf5W/quY=;
 b=Y+rtOROyLAbUN5CzLQUgMQ7wuMI3CUI+KVAAmTRsiJM2j5+7zy9PF/2gCSMoOXh2f0M+Z3eKPrIBvDafAZCjGl+LkQzur6iCUNy3/PUyMQ9ExBAjkkkkppV30WfkophukX8Dl2QebgVUMxSpu/sMtyHrUiypDfY56bxcvU+2LD5bWwXggX1Tede4yZJi1QhJYzJKDCovBxuyllYypZzk6S0uQEpCwRgYUuXYsgSKVwZjkd4u8YeTTdCWK8BsBBLM5Filikt+sPIskyGaNy0/QLdMbVQFs8q/oVRsvKjMdlSuqMbzrk8lpxTOLz6O9nl0UNXUjiGk2tMsWdAbiBquHw==
Received: from DM6PR11CA0030.namprd11.prod.outlook.com (2603:10b6:5:190::43)
 by CH2PR12MB4905.namprd12.prod.outlook.com (2603:10b6:610:64::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:14:54 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::87) by DM6PR11CA0030.outlook.office365.com
 (2603:10b6:5:190::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 15:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 15:14:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 08:14:35 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 08:14:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 3/4] mlxsw: spectrum: Stop ignoring learning notifications from redirected traffic
Date: Fri, 11 Aug 2023 17:13:57 +0200
Message-ID: <13bc71f25d9ee4e74a514e2e992cb96f87304299.1691764353.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691764353.git.petrm@nvidia.com>
References: <cover.1691764353.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH2PR12MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: acea16e6-e540-4e84-db5e-08db9a7db70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TP8bFO6zPjnA8K1steIdIGHhQwYBWuDuHCdQD+VJ8R4lVcp4G77NzvuvkTaMpHN/D4/xYIPjasvVelp+9GFYjLgc7lx2I5LaleEMUyqSIQk8/eWPULXF573UUVhTSjR3AoiHsYE70HuTZoTIwp9sb0uhKHCQn1Vv83aSGqKJ9crycF6l337dpLlONiX6qt15gA/ThoFKvjQf2bUZ7hocrlkKSH7vD1xDvk7dtd1ZF4JOXegX3qjk9jK5Z2IT0JNQGdsOv4/1IrXqHHS7s+eTWpuleziojt097JyWjDTPflQYBIFu6naTesAH7daH1p5iCZJ/LnFfyYEYIJB/kfN6sYCjweciPp8Y9VN4A+Z69756FmiGhC5hTuIkn1FVErNjjcCyVQ41/dwC+qJfmLphERnpKQwyUnHJNSHGY2VNWiS2RlzHjts4W2MZoqoXkf1zYg6mjmKbcqQDt00b8YVhh014HqF1nJQhvXLJCW3LLlibFjz0curaQz15tp6HAj2x2RReX/cNMFQ+hiuRMz6OELuQTOioCiebiqOZqKZcwmpoi1Ne2VpLDFZn4D2Gne+Sn+bCFwDWosMqHgo3SbPmMxkJedd7zH8j8y89gWKn+9PX6NnCx3y/fjPl0VEGpNq4zrMUlCAj7IW8fpTpD2HFTHmCuScILQXYP0+lZYuDaW33B6lU9cn2Xjn9lssw9XyBFz6I4qnZRBZtswy9gm/OKg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(1800799006)(451199021)(82310400008)(186006)(40470700004)(36840700001)(46966006)(70586007)(16526019)(2616005)(36756003)(508600001)(110136005)(6666004)(70206006)(107886003)(336012)(26005)(54906003)(4326008)(316002)(2906002)(15650500001)(7636003)(5660300002)(356005)(8936002)(8676002)(86362001)(83380400001)(36860700001)(426003)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:14:53.4510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acea16e6-e540-4e84-db5e-08db9a7db70f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

As explained in the previous patch, with the ignore action prepended to
the redirect action, it is not longer possible for redirected traffic to
generate learning notifications.

Therefore, remove the workaround that was added in commit 577fa14d2100
("mlxsw: spectrum: Do not process learned records with a dummy FID") as
it is no longer needed.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h         |  1 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c     | 10 ----------
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  6 ------
 3 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 2fed55bcfd63..02ca2871b6f9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -1271,7 +1271,6 @@ int mlxsw_sp_setup_tc_block_qevent_mark(struct mlxsw_sp_port *mlxsw_sp_port,
 					struct flow_block_offload *f);
 
 /* spectrum_fid.c */
-bool mlxsw_sp_fid_is_dummy(struct mlxsw_sp *mlxsw_sp, u16 fid_index);
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_index(struct mlxsw_sp *mlxsw_sp,
 						  u16 fid_index);
 int mlxsw_sp_fid_nve_ifindex(const struct mlxsw_sp_fid *fid, int *nve_ifindex);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index b6ee2d658b0c..9df098474743 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -137,16 +137,6 @@ static const int *mlxsw_sp_packet_type_sfgc_types[] = {
 	[MLXSW_SP_FLOOD_TYPE_MC]	= mlxsw_sp_sfgc_mc_packet_types,
 };
 
-bool mlxsw_sp_fid_is_dummy(struct mlxsw_sp *mlxsw_sp, u16 fid_index)
-{
-	enum mlxsw_sp_fid_type fid_type = MLXSW_SP_FID_TYPE_DUMMY;
-	struct mlxsw_sp_fid_family *fid_family;
-
-	fid_family = mlxsw_sp->fid_core->fid_family_arr[fid_type];
-
-	return fid_family->start_index == fid_index;
-}
-
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_index(struct mlxsw_sp *mlxsw_sp,
 						  u16 fid_index)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 3662b9da5489..6c749c148148 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3066,9 +3066,6 @@ static void mlxsw_sp_fdb_notify_mac_process(struct mlxsw_sp *mlxsw_sp,
 		goto just_remove;
 	}
 
-	if (mlxsw_sp_fid_is_dummy(mlxsw_sp, fid))
-		goto just_remove;
-
 	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_fid(mlxsw_sp_port, fid);
 	if (!mlxsw_sp_port_vlan) {
 		netdev_err(mlxsw_sp_port->dev, "Failed to find a matching {Port, VID} following FDB notification\n");
@@ -3136,9 +3133,6 @@ static void mlxsw_sp_fdb_notify_mac_lag_process(struct mlxsw_sp *mlxsw_sp,
 		goto just_remove;
 	}
 
-	if (mlxsw_sp_fid_is_dummy(mlxsw_sp, fid))
-		goto just_remove;
-
 	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_fid(mlxsw_sp_port, fid);
 	if (!mlxsw_sp_port_vlan) {
 		netdev_err(mlxsw_sp_port->dev, "Failed to find a matching {Port, VID} following FDB notification\n");
-- 
2.41.0


