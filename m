Return-Path: <netdev+bounces-18968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73027593D0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0627B1C20D71
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EAD1429E;
	Wed, 19 Jul 2023 11:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D514291
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC18189
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4ouNlvJkEg9l2vr2i+n0eDsQA85AAW/1/A9T04rPW2HsubOx4CvPoXTx0u3AFd7E1VkyUQrIdYZAeB9CTK/chLz1LDQRRG6ZK1UKTkDc6/ob6ut+Dw8pCiJ+d9VmHqwbdJdnyu6ZhZgn+sA7KLvb7nANKm3YODGDOVhc6b3AKarUycpFIBLH/T++d/hq0aFm7OLfsACydj/0oc4inj/9OjYHXeq3PokLlOs0YLozZgQGURSlAZIswSr1pFIow1EE3hJhnXjBv7iumuROM1AoZKAXIdH7caNX3UWLIUCBbYsA5uR7LrcyHjbAQHYddzSnRVjNLzhPcr0sOU9K7tXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WzgnRxfmV8Us0G+JG50PX5lI7Lbx0EwgBYbUL4jkx8=;
 b=itJKUphla8PWn/IPMvbY/DKuSqeVQ/vHKaAmZQQPqQI+a8uJ9oW1YmooWD14b9oIoNZ3UDretVenhnfi4rBlXIYacglnC3bjtqZ3xFqhKVK5VyIQYPkNdLFEGoFd4w3IDrT7vEAkdHicQqPt/zdPeJH0o6yJvzTl7ASSY8yr7V0LQIFSs1pfKgQIGPLIczCf1gE9IENiCuxGOBP5xoqSATfzKbJTyUwHyJY/632lbItkU36RUrgneJqTqKHl9pP87f5bxnJfLdMxYEguUiq6jWFLJYWvOSQtPRFhAuRIocS2iMMC7JRYzDt5iEIqP++WUQmvOuDHxw7QV2TK0ceHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WzgnRxfmV8Us0G+JG50PX5lI7Lbx0EwgBYbUL4jkx8=;
 b=T4CWTq3mAZf47MWl425CUK0jkSsMwabmgOfn6Q0DzmjSh8U+/U6kxEwcOt3j3RyILDaWsMWGiiwFY61Gz2fAnNBlzbcLLO0dcpdFBLxwdgkNVmeTh7uvcI2r9PhNY+6ZlIm7rb+1PwnCjz5HIV0BDJRhf6lHU1N1hDPKTRf3SPZaltnOoPeWStMH1hwDEC3F1XcdTTZv/Sx4TGM4jFn9qN6MUaipoXnC55k2/MLc3nC87Eo54/PrsADOlpSgD1uryH/uh2Fl8WUeA3QHYTZF+NIrzCGUigG77+BgCSVVJnPwZ00GDoQOEbABiGcK7QzjzGQvtFqWStZA3IeK/1JT+w==
Received: from BN9PR03CA0777.namprd03.prod.outlook.com (2603:10b6:408:13a::32)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 11:02:53 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::c8) by BN9PR03CA0777.outlook.office365.com
 (2603:10b6:408:13a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 11:02:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:36 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 14/17] mlxsw: spectrum_router: Replay neighbours when RIF is made
Date: Wed, 19 Jul 2023 13:01:29 +0200
Message-ID: <348ed6d1ba0ff56ecbf625f0927510b2712d375f.1689763089.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dd8d1f-0e51-41ec-4798-08db8847b285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/x68Kmdqa8gbyWS8Jp6uIiECxEJ6HtoyccLTkvTsTEZw0XHeJclfGFEijEVCcoMxREx8sgxnx5Ee4Y8XyQJCgApRVKwRczUU1fqgdzbznqsKn0cfWR2Mfq2xQGRi3HCz0Hdsj0JE+BvsEtdPfkEufpR9eWLrCxbmq/bebu0zh3eqkDcwZGLT+stzgm2zFX5sR6IsL79P1m8P8sRVk8hQci7Ga6O9vaCe/bz34YJ5TpJ7LqYB+Mgkb4008UF6B672ijBy3wGqVE+rPSGB5qMBvLWIaxZbQJ1MeZ/SFr6U8MbzUyx5W9cmJP38vvcOXI9ur3ZX4FgJD65EgPRYADzQ4CCicJPfrT/T8LEAPAQ7gQ86y9zl/NPwv6bgPjl2mEJLOcqDX5xbMXNx7TFCUG+BgnNe8rN+PJc3iZ83V67PdgmsPcivQudu1JQS7Vn/GP+F5sRHVYOWJ4UulO+NYvT42MU11a/fWvmPJrkZwoVygrMelPZvMq7L/zKw5vpjGd3CVsC+ggXYO7+Z8H4s89gDFsy4YQswJWvDYP4xR6rn6ffKj0R75qBIjnHxa93XiZ8SE9aZ/k/7isugWCEYFd8XhaeMZsrV4RnUcPU6cyQpqFu5/LWvu0zZz+VutE3lY5Q8Yg636I7Ac/P8FKaU2V2sxVPBhz2CyRPG586Su/5FBft65OCXtrgiz1dAz9xEtuOGFS9iRMK6+38/z4/qy+JLH/3O9zdFEA0H9V93E4f+BqLO7KnZwTqhy++s1P6/X8R2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(478600001)(110136005)(6666004)(8936002)(8676002)(54906003)(36756003)(41300700001)(70206006)(70586007)(4326008)(316002)(356005)(336012)(83380400001)(426003)(66574015)(47076005)(86362001)(7636003)(82740400003)(186003)(16526019)(5660300002)(40460700003)(36860700001)(107886003)(26005)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:52.0160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dd8d1f-0e51-41ec-4798-08db8847b285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As neighbours are created, mlxsw is involved through the netevent
notifications. When at the time there is no RIF for a given neighbour, the
notification is not acted upon. When the RIF is later created, these
outstanding neighbours are left unoffloaded and cause traffic to go through
the SW datapath.

In order to fix this issue, as a RIF is created, walk the ARP and ND tables
and find neighbours for the netdevice that represents the RIF. Then
schedule neighbour work for them, allowing them to be offloaded.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 62 ++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 2322429cdb72..9263a914bcc7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2983,6 +2983,52 @@ static void mlxsw_sp_neigh_rif_gone_sync(struct mlxsw_sp *mlxsw_sp,
 	}
 }
 
+struct mlxsw_sp_neigh_rif_made_sync {
+	struct mlxsw_sp *mlxsw_sp;
+	struct mlxsw_sp_rif *rif;
+	int err;
+};
+
+static void mlxsw_sp_neigh_rif_made_sync_each(struct neighbour *n, void *data)
+{
+	struct mlxsw_sp_neigh_rif_made_sync *rms = data;
+	int rc;
+
+	if (rms->err)
+		return;
+	if (n->dev != mlxsw_sp_rif_dev(rms->rif))
+		return;
+	rc = mlxsw_sp_router_schedule_neigh_work(rms->mlxsw_sp->router, n);
+	if (rc != NOTIFY_DONE)
+		rms->err = -ENOMEM;
+}
+
+static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
+					struct mlxsw_sp_rif *rif)
+{
+	struct mlxsw_sp_neigh_rif_made_sync rms = {
+		.mlxsw_sp = mlxsw_sp,
+		.rif = rif,
+	};
+
+	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+	if (rms.err)
+		goto err_arp;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+#endif
+	if (rms.err)
+		goto err_nd;
+
+	return 0;
+
+err_nd:
+err_arp:
+	mlxsw_sp_neigh_rif_gone_sync(mlxsw_sp, rif);
+	return rms.err;
+}
+
 enum mlxsw_sp_nexthop_type {
 	MLXSW_SP_NEXTHOP_TYPE_ETH,
 	MLXSW_SP_NEXTHOP_TYPE_IPIP,
@@ -7937,7 +7983,21 @@ static int mlxsw_sp_router_rif_disable(struct mlxsw_sp *mlxsw_sp, u16 rif)
 static int mlxsw_sp_router_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 					 struct mlxsw_sp_rif *rif)
 {
-	return mlxsw_sp_nexthop_rif_made_sync(mlxsw_sp, rif);
+	int err;
+
+	err = mlxsw_sp_neigh_rif_made_sync(mlxsw_sp, rif);
+	if (err)
+		return err;
+
+	err = mlxsw_sp_nexthop_rif_made_sync(mlxsw_sp, rif);
+	if (err)
+		goto err_nexthop;
+
+	return 0;
+
+err_nexthop:
+	mlxsw_sp_neigh_rif_gone_sync(mlxsw_sp, rif);
+	return err;
 }
 
 static void mlxsw_sp_router_rif_gone_sync(struct mlxsw_sp *mlxsw_sp,
-- 
2.40.1


