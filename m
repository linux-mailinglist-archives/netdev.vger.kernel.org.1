Return-Path: <netdev+bounces-51745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 567DF7FBE8C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AD7B21A80
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183513527C;
	Tue, 28 Nov 2023 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JbrI8MwL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9901090
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa3RBdBVb4YBlNqIc6cqHh3vm4LcaKqj9oYakOHZDqQ30LitG5j8ibT9z5PyavA+mQzhwHmtaB2vRk7NXgbrpVfX2/DaY3Wc+WPRIwQYLk77pUbwEbhEn9qZINk8R97YUGB8ryz/AkpZwHGyss3mTBP7bc5AVNU6LEHacwujyJCah6b/7PXFFAm/nYCH93TzkbXMxxqBpBFTZtg3jdUkDKcjxaMKbYoJosI7R6+efNrkn3KvKHS6DmTZTjWXBJ0j35gRK9Kn1A8wRxz5RPqYxZEf2xfFLjTSy7Ik5O0z6FAbG+0WrYfJs63bPST+gWOoRC8ltPm1+8kY3KlZnPAs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPE/SjxWG9gdaDQCN6B8Pl4Tiaf+xnT/FMNgw+BFPsk=;
 b=BgkSAjX7TYdvJ8GRSRN0gz/Gw0ibPhzFTU9Mjl5mvHS+idIYX6th/IzOUCJ9U3BUyCGhzGeLHXa9g1lV1trp2pc93ZCZQbhDuzRP0Cp0Uh7QgAZokzUAVkvYJIvhhS1wEPwjm5JnbF1lxNgI/LBinWjSWBUvC0m6LjmWkQsNHYiazK1drPwtkAkgwiF9fKBpG2MZMmFRNywMO0z1NO+Z1dEitO8SuTQgY7OhXljXyZAOyRIzlVRwPUXzsE4fFMH9wIYxg+gcCnk5zevjL6a68jb2o9zsFyaibDRdmHLFexmth+TO9siuflLkk8zrc0RufU8/fzL0HcA54i6pJTPf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPE/SjxWG9gdaDQCN6B8Pl4Tiaf+xnT/FMNgw+BFPsk=;
 b=JbrI8MwLCsb+7VVITh44Ox0umwmWWhJAA99gxh/G6kBgSJU6UFrc9UR61d7JGx33wzJcFCHXEmraYMuDpTzCYA5HrA8TfXO1OVAeUSfmMp+Y7uzgI8t8Z+uP9EmsuJuQOnDo4xjUbntwKolRA85J1+CDfM0vc5iiJskAEuVboM3jVI7OQIV5RNbfHOpmCQay6upyGGd39t2GO8PMyOu3sAi0flIg02TKxwOP7uiPLk5EpqgiHsLr9g2WFhd8d7MCWogi62CiXF+cYoOzrT9gJ3Uklfksf3UhcuG8R34TWo8wuyvw2LN8dKBEnUz2gd1ASNHtH97qetrAgIsqCTrjYg==
Received: from MW4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:303:b7::12)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:52 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::d1) by MW4PR03CA0097.outlook.office365.com
 (2603:10b6:303:b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:36 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:33 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 11/17] mlxsw: spectrum_fid: Add hooks for RSP table maintenance
Date: Tue, 28 Nov 2023 16:50:44 +0100
Message-ID: <234398a23540317abb25f74f920a5c8121faecf0.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: fd91e56b-f989-41cc-25d6-08dbf029f0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D32iHPRmwz2r2zstF7zQmvLqNLkzPBOSI7wgrJ5ga+tyjE9yYfDDeTPiIr+tPpKtxp2SUpdOtJJiQwvHMWMiOxcVYXuMSSXqeTr8IYGKPb6ro2zdRaB5HGi+ReYNzDTjCR0lKtbrJgzGebIuHkPeb9fPFm69cpw1lvJdP8F0C+45fAKRScIC16Ce78vyL4LxVi+a6zJmNC4AqYL4ckVhz64HdmFAne4UsVLsQWQev5Nf8ONvfu1iNO9Al5XaYMqAIQ2jqE8LrD7LQKVmA5kiHHgxdedk2QmQJCtUguzJNzfJ1lGTHbN4KIy6BEo5BKcAEOqUzmqxM3JlGDm8x4oBFk7lk6vzsoSaWCHUmzLZROGZVH52ZVXDY5UrJMdVX+Xpy7EGovUQp2dMvbhdzwmkysX6ux+hm6hI44obtom5le/bZ6VnalCtWtKvWNNZvmbiydSUmZHFHiHY8P26YhaVD/WFta5SQhRHsPHDcz0JCOFF+J3Vugl4VOrfTSMpKW97v1I32NrLnG6VACnq0Ca1Si2oslePMMLRQb2D4uxRUhBPp4hi6+1uN2S52czU0j2WDRDrjqpAmw8+/mF73FaRoZQLK3IhI+lWEDL8+79D4ETEXM3ZhRqSWJnZVrxhhazVmxPwiNqNYlYIo9c5WKiejRh4kM5Gr0z3K6vES4nHUrARVmqKaCdctyo43HQzOdp6hdZzVDDmj/qv1Qz93Yq/huMJEKrcy0v3LEqUieRgTzRXCO1/hMDtI7w+HXZVw2CZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(36860700001)(41300700001)(6666004)(86362001)(478600001)(40460700003)(5660300002)(2906002)(356005)(83380400001)(70586007)(8936002)(8676002)(36756003)(70206006)(4326008)(7636003)(110136005)(54906003)(107886003)(2616005)(316002)(26005)(16526019)(82740400003)(336012)(66574015)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:52.4495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd91e56b-f989-41cc-25d6-08dbf029f0b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

In the CFF flood mode, the driver has to allocate a table within PGT, which
holds flood vectors for router subport FIDs. For LAGs, these flood vectors
have to obviously be maintained dynamically as port membership in a LAG
changes. But even for physical ports, the flood vectors have to be kept
valid, and may not contain enabled bits corresponding to non-existent
ports. It is therefore not possible to precompute the port part of the RSP
table, it has to be maintained as ports come and go due to splits.

To support the RSP table maintenance, add to FID ops two new ops:
fid_port_init and fid_port_fini, for when a port comes to existence, or
joins a lag, and vice versa. Invoke these ops from
mlxsw_sp_port_fids_init() and mlxsw_sp_port_fids_fini(), which are called
when port is added and removed, respectively. Also add two new hooks for
LAG maintenance, mlxsw_sp_fid_port_join_lag() / _leave_lag() which
transitively call into the same ops.

Later patches will actually add the op implementations themselves, this
just adds the scaffolding.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  8 +++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 +
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 58 ++++++++++++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 6726447ce100..e3ef63e265d2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4515,6 +4515,10 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	mlxsw_sp_port->lagged = 1;
 	lag->ref_count++;
 
+	err = mlxsw_sp_fid_port_join_lag(mlxsw_sp_port);
+	if (err)
+		goto err_fid_port_join_lag;
+
 	/* Port is no longer usable as a router interface */
 	if (mlxsw_sp_port->default_vlan->fid)
 		mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port->default_vlan);
@@ -4534,6 +4538,8 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 err_replay:
 	mlxsw_sp_router_port_leave_lag(mlxsw_sp_port, lag_dev);
 err_router_join:
+	mlxsw_sp_fid_port_leave_lag(mlxsw_sp_port);
+err_fid_port_join_lag:
 	lag->ref_count--;
 	mlxsw_sp_port->lagged = 0;
 	mlxsw_core_lag_mapping_clear(mlxsw_sp->core, lag_id,
@@ -4569,6 +4575,8 @@ static void mlxsw_sp_port_lag_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 	 */
 	mlxsw_sp_port_lag_uppers_cleanup(mlxsw_sp_port, lag_dev);
 
+	mlxsw_sp_fid_port_leave_lag(mlxsw_sp_port);
+
 	if (lag->ref_count == 1)
 		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 8bd1083cfd9e..61612c413310 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -1328,6 +1328,8 @@ struct mlxsw_sp_fid *mlxsw_sp_fid_dummy_get(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_fid_put(struct mlxsw_sp_fid *fid);
 int mlxsw_sp_port_fids_init(struct mlxsw_sp_port *mlxsw_sp_port);
 void mlxsw_sp_port_fids_fini(struct mlxsw_sp_port *mlxsw_sp_port);
+int mlxsw_sp_fid_port_join_lag(const struct mlxsw_sp_port *mlxsw_sp_port);
+void mlxsw_sp_fid_port_leave_lag(const struct mlxsw_sp_port *mlxsw_sp_port);
 
 extern const struct mlxsw_sp_fid_core_ops mlxsw_sp1_fid_core_ops;
 extern const struct mlxsw_sp_fid_core_ops mlxsw_sp2_fid_core_ops;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index a718bdfa4c3b..76b0df7370b3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -103,6 +103,14 @@ struct mlxsw_sp_fid_ops {
 		       const struct mlxsw_sp_flood_table *flood_table);
 	void (*fid_pack)(char *sfmr_pl, const struct mlxsw_sp_fid *fid,
 			 enum mlxsw_reg_sfmr_op op);
+
+	/* These are specific to RFID families and we assume are only
+	 * implemented by RFID families, if at all.
+	 */
+	int (*fid_port_init)(const struct mlxsw_sp_fid_family *fid_family,
+			     const struct mlxsw_sp_port *mlxsw_sp_port);
+	void (*fid_port_fini)(const struct mlxsw_sp_fid_family *fid_family,
+			      const struct mlxsw_sp_port *mlxsw_sp_port);
 };
 
 struct mlxsw_sp_fid_family {
@@ -1836,9 +1844,34 @@ mlxsw_sp_fid_family_unregister(struct mlxsw_sp *mlxsw_sp,
 	kfree(fid_family);
 }
 
+static int mlxsw_sp_fid_port_init(const struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	const enum mlxsw_sp_fid_type type_rfid = MLXSW_SP_FID_TYPE_RFID;
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	struct mlxsw_sp_fid_family *rfid_family;
+
+	rfid_family = mlxsw_sp->fid_core->fid_family_arr[type_rfid];
+	if (rfid_family->ops->fid_port_init)
+		return rfid_family->ops->fid_port_init(rfid_family,
+						       mlxsw_sp_port);
+	return 0;
+}
+
+static void mlxsw_sp_fid_port_fini(const struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	const enum mlxsw_sp_fid_type type_rfid = MLXSW_SP_FID_TYPE_RFID;
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	struct mlxsw_sp_fid_family *rfid_family;
+
+	rfid_family = mlxsw_sp->fid_core->fid_family_arr[type_rfid];
+	if (rfid_family->ops->fid_port_fini)
+		rfid_family->ops->fid_port_fini(rfid_family, mlxsw_sp_port);
+}
+
 int mlxsw_sp_port_fids_init(struct mlxsw_sp_port *mlxsw_sp_port)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	int err;
 
 	/* Track number of FIDs configured on the port with mapping type
 	 * PORT_VID_TO_FID, so that we know when to transition the port
@@ -1846,16 +1879,39 @@ int mlxsw_sp_port_fids_init(struct mlxsw_sp_port *mlxsw_sp_port)
 	 */
 	mlxsw_sp->fid_core->port_fid_mappings[mlxsw_sp_port->local_port] = 0;
 
-	return mlxsw_sp_port_vp_mode_set(mlxsw_sp_port, false);
+	err = mlxsw_sp_fid_port_init(mlxsw_sp_port);
+	if (err)
+		return err;
+
+	err = mlxsw_sp_port_vp_mode_set(mlxsw_sp_port, false);
+	if (err)
+		goto err_vp_mode_set;
+
+	return 0;
+
+err_vp_mode_set:
+	mlxsw_sp_fid_port_fini(mlxsw_sp_port);
+	return err;
 }
 
 void mlxsw_sp_port_fids_fini(struct mlxsw_sp_port *mlxsw_sp_port)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 
+	mlxsw_sp_fid_port_fini(mlxsw_sp_port);
 	mlxsw_sp->fid_core->port_fid_mappings[mlxsw_sp_port->local_port] = 0;
 }
 
+int mlxsw_sp_fid_port_join_lag(const struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	return mlxsw_sp_fid_port_init(mlxsw_sp_port);
+}
+
+void mlxsw_sp_fid_port_leave_lag(const struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	mlxsw_sp_fid_port_fini(mlxsw_sp_port);
+}
+
 static int
 mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp,
 		   const struct mlxsw_sp_fid_family *fid_family_arr[])
-- 
2.41.0


