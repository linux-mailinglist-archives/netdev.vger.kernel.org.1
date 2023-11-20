Return-Path: <netdev+bounces-49345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615357F1C61
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F31282709
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D52B32185;
	Mon, 20 Nov 2023 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tzumGUWZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EADC8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHDfcCUdO/EJSPWZ5pwYZ2LqQGU6F7zAZz8ZB+wvuHhtqTtzdbR830a27fjh3hxDbSL9IjOsufqUWCmND9hz7Ngnf0jGsotfu/a56yLLzq2mmJKfmYL9o/5qabmDRrSxzdECqI20/KM9qLdQpTanX9XSMysbQj039pQuuh4FSfDHA1tJQgn90vcml4WC3ZZTtJK67WGMwR4PRarcTDAuXsj/o4qZx80JuI17yUBd9k1LbPDDcWtTPCOqT4sYzXW5o20ZWprB6ep4zIKOLEaFQWNJhKMwXblcYCMEF62nZUOxuBp8gGYngI/YVcV2rA9d2BwoDOsgefx+TnYDt8cZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zr/GaVKTkHbq+LWSuhA2qsIL9dlWbwKWK+EyiZLWQA=;
 b=flfBHIxJAEP/WoIpRlt4bNs2MpRlYjCoMSIy6gp8K0Bffvkx1Kz+DRe8Uy5vJZmdMoFtxcW25VsX0QLxfeCfwpRjqjAgTnlpYSjq8kMhVVv9rQabs3FJ+FMOHZBITDpiEbWZSl8R1Lw3T7NSQGO6KVliP6/V1GpIuFdfcqICl6n8eklELQT3hZyO7GxZ+ddbURenuJXwr4ZxIIopfGRKnu9TBqkNh9o8+YGKLsB87DYM4viSxg1CiDmHdJtRAHv/MoLDOHj+QIZdNu1yF5WLYzBOh6VDJWaPjRxVgy0gVU6pQMgV2cXANCBr1SjjXlJ6in5fAh6UA6eBBMxoI+iTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zr/GaVKTkHbq+LWSuhA2qsIL9dlWbwKWK+EyiZLWQA=;
 b=tzumGUWZ6gJas8VM6WeZB87z3a462LEdJJHELf1rBI3DoasjGtfyu547bxnBaFoeRd5pdNnedrPs9giPuiAghpKpcV2Nfr9/tdC5EGK7hZhWtFS+fsUIRzLjpu3ZdT7+Pa2LDSv0Kp1jp0d9Q9RsUANsCw2m6TaLFJOOToyOyxYa8PAGSzbqpcpqKGzwhopdhc5+aAI4CatPiq+IDI37z2yRb14Wp+En7aD7dzyRQxqPTi8jwwMdDqW/x+93tYsnFzTYyfvzikGSjDWU4dILNZqsl81Knfjc4zOVwwkI3xS/KEAZFGnN2ljYuH6OYmmohWsW2m424yA2WwxsVzP3rQ==
Received: from BYAPR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:40::17)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:28:24 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::83) by BYAPR04CA0004.outlook.office365.com
 (2603:10b6:a03:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:28:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:04 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:01 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 11/14] mlxsw: spectrum_fid: Drop unnecessary conditions
Date: Mon, 20 Nov 2023 19:25:28 +0100
Message-ID: <897c6841bc756ac632b797bf67ac83c6a66ba359.1700503644.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 838ca2ed-f5b0-4626-127f-08dbe9f67acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qOge3rM3C3wGhm3omWXX4G8ZbKhIhgNqasnqycmoE+IH7r2ysiNWUP0ukNrj8DHtbE8CGzsvhD3PvafcoWwRKAusUsueq9t/PVV2J/VPBdVlALGbCU2LP4H/OdXdNqifD9P2EHwqYBPQkYAlIiLPPWOS5GSLxj6lmGvqgVlMwPsV4v4Oi9/LynuIxg3wSA79o02hou6479HIHEKvl6BoL9JLU8K2fWoorzquEWYRk0k8Vrjtq9b6DxvuVpD5ODjtxk1vijWjOsSkGA+6oQ0QRDkKmgNuHjjp0XMi+O1l5iz6vSfLZfWgh+rrLKOllsJbiBmi340un0NGZ6zLO5K5nSULJG1u4dWpVs4Ut0tFeo9vEg7Z/olkb1fJ+v6uYrjpGt/R/M+gOzl9Ov3+YbacIVHK35QSUE2C/MYWs80l9wlMFoTaNqLHNafrn5wRmB+hOYVL3MXSP32v+kN2+vnixO5XRRTZ6bQ0jkHOooCCnd2pwOMA171rpC+Erihl17C1hOSldKBCH5bXXlx2N8DlZyNdM+5fa7k+HsqpIoxmDIn2xKQKGREnqxolb7iYyjxalcPMYxrl7RrgXpkYEZNfdQ/0AKkn/9EDxRY6cCIweltKy8VGsdbbQijNfcUf1jQjyGdJ9tMVAE5p6kT3NVUynTMm1UrDTy43dEM37n1s8F4pcho6628q94kFSb1sgdPqGWTyNAAm4lqRPx9pDY12olEgnrZCbIORDXVRcr4HuMFy7Dm/acClKVfGy6AhZnjy
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(40470700004)(46966006)(36840700001)(47076005)(40480700001)(2906002)(41300700001)(8936002)(4326008)(8676002)(5660300002)(40460700003)(70206006)(82740400003)(54906003)(70586007)(316002)(7636003)(356005)(110136005)(36756003)(6666004)(86362001)(36860700001)(478600001)(83380400001)(336012)(16526019)(26005)(426003)(2616005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:28:23.3606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 838ca2ed-f5b0-4626-127f-08dbe9f67acd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660

The caller already only calls mlxsw_sp_fid_flood_tables_init() and
mlxsw_sp_fid_flood_tables_fini() if (fid_family->flood_tables). There
is no configuration where the pointer is non-NULL, but the number of
tables is zero. So drop the conditions.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 6a509913bdc7..d7fc579f3b29 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -1692,9 +1692,6 @@ mlxsw_sp_fid_flood_tables_init(struct mlxsw_sp_fid_family *fid_family)
 	int err;
 	int i;
 
-	if (!fid_family->nr_flood_tables)
-		return 0;
-
 	pgt_size = mlxsw_sp_fid_family_pgt_size(fid_family);
 	err = mlxsw_sp_pgt_mid_alloc_range(mlxsw_sp, &fid_family->pgt_base,
 					   pgt_size);
@@ -1723,9 +1720,6 @@ mlxsw_sp_fid_flood_tables_fini(struct mlxsw_sp_fid_family *fid_family)
 	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
 	u16 pgt_size;
 
-	if (!fid_family->nr_flood_tables)
-		return;
-
 	pgt_size = mlxsw_sp_fid_family_pgt_size(fid_family);
 	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, fid_family->pgt_base, pgt_size);
 }
-- 
2.41.0


