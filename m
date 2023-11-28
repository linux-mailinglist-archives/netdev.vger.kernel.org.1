Return-Path: <netdev+bounces-51739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660727FBE85
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7631AB2196A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEEE5E0BB;
	Tue, 28 Nov 2023 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O0gpR8xX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D2E1BE
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwXTfYf/CTewLbzRkr6tKEC+Mt594NR0J9cE9Bb+/vLRtGfZEhV9wWltyRy3CXpLN68IpL2/Rc7vfRWyt8TkfjbbFpivhiuQBkR6sb5bDu0Ng9x7qptiaPfzEbg00YKyzc2YUnwEYUgbGW4zWVfOA6maZKo4DfUyZBKtUdJZgzZJnGfYc6LVCWU/rXG56BwvzBPMlQCupxfv2TgAy3PK+Vn6dmIcklmVPhXggpUkjiOR2JgAs8xXqnyDCUcBV4ZL5lnqMW7l89x/WmmhakzprLz4aQCKGuX71sBBBhLCYbUt3zwf5jsY/C13PIKhL18CYnrfXeqRSyvo/mVsJ6dYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krOepwLv6OrEFhwqEgNvsXku+s6tprdEgVS7mb2x64Y=;
 b=L9PQ1kSjaYqv9bQsgHulrYY2g+zgK9PyeLPVD93BRlsC6GDRbpi/ywI4fHo49xNzhgi/HVZuRHM3xO67MU4LQ2ym6PB1oPMUHsSJcoYw23FO8mkvcTCXj8SBW4lxqx6/MOzNIOOY3DXZk8qRfF2ZsCUN4PQLv/47yDe/eQaf4sqO3joxqm2l0KUduhZyNvqn86f5gjlsKFv/6pLJoF3SW4asUojfW3kYtULfCBREg4oWtz3lYWyqo6WQlaoNUdeqc900ASyPLrP/rzCYH3zN+wJm0l/Khd5CkhKp+BISSSi5bRiRcoYbhHWguRj2jDQxC0Da2/dVbEZUQFxiCFzVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krOepwLv6OrEFhwqEgNvsXku+s6tprdEgVS7mb2x64Y=;
 b=O0gpR8xXEAqQdG7uQ+G9zbWrsdUgoHILrrXtf2Vg2j2gS8iXfh44SV3BCnre1J8nASlDxEQlC1nj+fgpBTV0tJQWKS+nsPZ6Mqyc2X0+//F02qW0nPUNPZbwTFfJmjLD4fXeVR+EJYo6N7Rccmcsy7lnhNCwwEwc9RU+QwUVa524F26BOLT5UajqSZBkykY6i0ff1Rq3KB3/Nj0QOBOHTfOt00U4DN2zRVv5l/BW6SYfVTGuIQsT1/rAKopQ4vSweXuWdbvwcBiFwgA5DuNzqJ47cqHCCtrUgRNMKl4SApD8/q+/xqYdNIxOpNt35oDeKNHVxIP75kFa+h+i+bmCRg==
Received: from CYZPR19CA0020.namprd19.prod.outlook.com (2603:10b6:930:8e::12)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:31 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::2b) by CYZPR19CA0020.outlook.office365.com
 (2603:10b6:930:8e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:23 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:20 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/17] mlxsw: spectrum_fid: Add an op for flood table initialization
Date: Tue, 28 Nov 2023 16:50:39 +0100
Message-ID: <06f71415eec75811585ec597e1dd101b6dff77e7.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dbc293-8ee0-4dc1-dc1d-08dbf029e3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rUSKJEcZ3cSCWjbQctQm0Rb/3JsYN5578cRzw8VJ40nEis/5hhNi4Y0VdZKDGeCESY9i5J7KpQIfl9i+Ni8gHmPeKzbC2zTwSLZMtejYlJCta6tZ0bybKP37ZTroFMkvx1C7vz9/lI1xXCbHkC/GcT4S3B1DALrRPbtUd2+KVFk6Z7gVog3I7uVvNQIijC9yrZEvgMg4OPShi0tllhpmI3lift3Yk0l7CQGBshWLkwcuhykaQ3JLap3zPZsXzE6Oa7Wz/HxrbJrk61cGH9k/JaJ0KbSt8MdyJJjyuRlEGMWVZ+Bqld3n4gfoNIic59rZDmkjU4Il2Hnx9kikPvpR/62A6yrswg7Q9jykHpEeM//5vyQtQW/JZebHVTUs1h8cP3pEA0R3FGi7OieGuQyp6W3R5vBcES4XX+iF9slwT0Zo9vBxAfIMxJz8pTUFXSd0h9t1KvG2guCXEXSBOzw5WWCI7i93Crt2MA/ZEGTv+oVfH8vKXe1ZqyglUnoNAj0wGBLa/luz7SsXrH3DUo7vP6zoxk1cThkmwmPhVNd4GW+1orzyGxnWBQM8JRDpmz4pa36iaNasgyvEqfKjGEBJsg2pcveXvqU58gwG9xRPwcZMba62ogU1Gzt4GIK8fqm7XN3rCl4aIIa/CnXrgsVrPpjVBvxtxvQ32rS5M0HcXCtvbet1v0d2oOmnNqcqe/82aq20jErZ6GdQZY/29Yz843rH4Llf0Kl08ZoaFL/ZWW2NJG5McHdgZ3WeWUgVDa1a
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(107886003)(2616005)(26005)(8676002)(6666004)(426003)(336012)(82740400003)(8936002)(4326008)(86362001)(5660300002)(478600001)(316002)(70206006)(110136005)(54906003)(36860700001)(70586007)(83380400001)(356005)(7636003)(47076005)(41300700001)(2906002)(40480700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:30.7028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dbc293-8ee0-4dc1-dc1d-08dbf029e3bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

In controlled flood mode, for each bridge FID family (i.e., 802.1Q and
802.1D) and packet type (i.e., UUC/MC/BC), the hardware needs to be told
which PGT address to use as the base address for the flood table and how
to determine the offset from the base for each FID.

The above is not needed in CFF mode where each FID has its own flood
table instead of the FID family itself.

Therefore, create a new FID family operation for the above configuration
and only implement it for the 802.1Q and 802.1D families in controlled
flood mode.

No functional changes intended.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_fid.c  | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 0c7295d7e693..9ba4748e8d23 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -95,6 +95,8 @@ struct mlxsw_sp_fid_ops {
 				  const struct net_device *nve_dev);
 	int (*vid_to_fid_rif_update)(const struct mlxsw_sp_fid *fid,
 				     const struct mlxsw_sp_rif *rif);
+	int (*flood_table_init)(struct mlxsw_sp_fid_family *fid_family,
+				const struct mlxsw_sp_flood_table *flood_table);
 };
 
 struct mlxsw_sp_fid_family {
@@ -1078,8 +1080,8 @@ mlxsw_sp_fid_8021d_vid_to_fid_rif_update(const struct mlxsw_sp_fid *fid,
 }
 
 static int
-mlxsw_sp_fid_flood_table_init(struct mlxsw_sp_fid_family *fid_family,
-			      const struct mlxsw_sp_flood_table *flood_table)
+mlxsw_sp_fid_flood_table_init_ctl(struct mlxsw_sp_fid_family *fid_family,
+				  const struct mlxsw_sp_flood_table *flood_table)
 {
 	enum mlxsw_sp_flood_type packet_type = flood_table->packet_type;
 	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
@@ -1121,6 +1123,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops_ctl = {
 	.nve_flood_index_clear	= mlxsw_sp_fid_8021d_nve_flood_index_clear,
 	.fdb_clear_offload	= mlxsw_sp_fid_8021d_fdb_clear_offload,
 	.vid_to_fid_rif_update  = mlxsw_sp_fid_8021d_vid_to_fid_rif_update,
+	.flood_table_init	= mlxsw_sp_fid_flood_table_init_ctl,
 };
 
 #define MLXSW_SP_FID_8021Q_MAX (VLAN_N_VID - 2)
@@ -1462,6 +1465,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_ops_ctl = {
 	.nve_flood_index_clear	= mlxsw_sp_fid_8021d_nve_flood_index_clear,
 	.fdb_clear_offload	= mlxsw_sp_fid_8021q_fdb_clear_offload,
 	.vid_to_fid_rif_update  = mlxsw_sp_fid_8021q_vid_to_fid_rif_update,
+	.flood_table_init	= mlxsw_sp_fid_flood_table_init_ctl,
 };
 
 /* There are 4K-2 802.1Q FIDs */
@@ -1723,9 +1727,12 @@ mlxsw_sp_fid_flood_tables_init(struct mlxsw_sp_fid_family *fid_family)
 		const struct mlxsw_sp_flood_table *flood_table;
 
 		flood_table = &fid_family->flood_tables[i];
-		err = mlxsw_sp_fid_flood_table_init(fid_family, flood_table);
-		if (err)
-			goto err_flood_table_init;
+		if (fid_family->ops->flood_table_init) {
+			err = fid_family->ops->flood_table_init(fid_family,
+								flood_table);
+			if (err)
+				goto err_flood_table_init;
+		}
 	}
 
 	return 0;
-- 
2.41.0


