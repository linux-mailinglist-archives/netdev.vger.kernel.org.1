Return-Path: <netdev+bounces-51738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D197FBE84
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BA8282577
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A35B5C4;
	Tue, 28 Nov 2023 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/2iF04b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32A90
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlqiHvLaWLh76R8QUl88I+kiPjJWNqS8VpFW9pH39oNC86sRu2WVsbsPPDe6z8HHkK/3bEgMw6Os+8E79Q8rdq4CPth529RZdiwBEnHK78j7M4zVmNbZ1L4ztC+o0ESN2HMuYM7ApCW+GY+1iCgl8oYqIZQr8HJgV70u8ydw4w66PI9oUSBr3qBriQHmqc2+RiD7R9o+QHdOohZM/qXxIjJpU+MsLukv+xRODMhZeiVCHIlj4AkpXce9Ulj95T6kL0Sq/WyefX+HReuUBlM586qMTGi3RGGIFlnF3qIkcowAJ39xVZCorhAXaaC95TbrsDAwQqdlusFh6PteNHRP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTs2nsXrEnxj6dv62R6C0UZzV5W5of6+6wLi+7HaEKk=;
 b=WI33FC4P1h2/XHBwFIpZDRdQYrcFDEQljXPIB0zDNZh2JrBwvG7AkiOs2IeBqUUrbDE6UeEyJnFadtNcQ/GEqUsR3KunOPtfibpotX0z3XaC4seRrZsRjVU9IzJCqlPDrxo7u5iFIJxrchC0LWCoppYrNv56q/ghiImt2lz63YIBI7XR7q2H3wcAEzHvDVHx5NjTL7El5afGuq6wySpE0ws6Opm7snjTEYYFTcNYn5AHV+P2Sz0gl9ly05lHtL8Sd/ioVwbM28xIRYpnRDX990VbJ65H+/ANgfoEUvYLYBviQuzSwcEG8zOyCzs0rs2ALJZx+kPsW8rwS7uHV57iyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTs2nsXrEnxj6dv62R6C0UZzV5W5of6+6wLi+7HaEKk=;
 b=K/2iF04bg8K3/WPFZQjg604YiLbeo6+lh+NhA5eJ/uSL+LMVBERaaAgW14MDYqWRv2px/6d2iBZPXyDXjnFiNMERPQYy4QdRvYhRt81ahUimQ5pBB7xIV1h/EOq8VMHQeG872UurpxfCpJCXCvCxUgGr0XKWgQoImfmM989f5D3jgPwP1Bau+cgk4NE9222lfdKVv0wzzw8HdgBuYJ14gTVQh9fDG9fBShim4ifjEw7PTsTrBISSooTwQeW7XBPgmbk6U9Q+dXiiAormXctTn6NFJEYkORk8+EnLPdPBBmPkixBlFsyqi40n5TjErSyGWehPQYvfdVyanqBgiZI1lA==
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 15:51:29 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::63) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:15 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:13 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/17] mlxsw: spectrum_fid: Split a helper out of mlxsw_sp_fid_flood_table_mid()
Date: Tue, 28 Nov 2023 16:50:36 +0100
Message-ID: <fd41c66a1df4df6499d3da34f40e7b9efa15bc3e.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6869a0-12ee-43bc-b4d0-08dbf029e2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q8/tYzttCAIWdmYdgZVQItr6G42JUmpdRjKki1qTsoPjNxlWF9KGdF4X/LRqM3mQEzR/1p6TnLSEYc2guzcekfBdeJv02JNzJQqrbhAgYwAZ0re5m9aEX9K9Oc6bM2BQhPfXPQHWai9IrI0WeLA2G5KGtfkzcQIiIEYMzLAD+xigtpSsdev76wYtoPUWxIdYlqnNkmmEmcV96m/x6gH9p93um5kb0mrIp/gd/VxzGTdhEAT4lI9r3/gVDPIIgv5sepVPEraVAq3VED+qW1dsY48rYaMKaZlYLJA9w2F1hRBQYYLdlQQHqs5hB5Bk4CCS3ps0zgMl4d3AjJhzbf7kicodLSi0CFvdWQ2rVyRZJ3SgeW4+0I6kxC3Gbmed6PhRkjZbHC/V5uPQ+N5rrQRI8aDSsTfs6UTWwiAWZhhycyc3kN2QH9I319wAkxVMrxAp5++VyVzR8hbWUGKPsdKeSXqFoTMgX9AFrjOf3zmu2fcfagCZXGyiztBHEav3gfAVaM5VxA7RVrLZ7vYT6hr3++t6CwTGGDubJxG2BsLv+yexJLnfhF6eTDgdP5dDdYnvUXJkYwQyIWkgMIaznZPinkExsQCwUzSTKK28IDev3FNxeFbbd/Av7smJWmxvW8Nb7nKsX0h5fNbX6VOrumB/Hl7P9chKaNa9N3tFf0iao5PZL4tNDv6L4x7lsPT2fkOimjeDDjOqIwXgl/+QqVro2d7yGgvHg014qnmgMA2DyCaxCzJwyJe66Uq1Pni11oYw
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(36860700001)(110136005)(54906003)(70206006)(70586007)(316002)(6666004)(478600001)(2616005)(107886003)(16526019)(26005)(5660300002)(2906002)(4326008)(8676002)(8936002)(86362001)(426003)(336012)(83380400001)(82740400003)(7636003)(47076005)(356005)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:29.3870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6869a0-12ee-43bc-b4d0-08dbf029e2f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

In future patches, for CFF flood mode support, we will need a way to
determine a PGT base dynamically, as an op. Therefore, for symmetry,
split out a helper, mlxsw_sp_fid_pgt_base_ctl(), that determines a PGT base
in the controlled mode as well.

Now that the helper is available, use it in mlxsw_sp_fid_flood_table_init()
which currently invokes the FID->MID helper to that end.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_fid.c  | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index d92c44c6ffbf..96cedc241bf2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -328,15 +328,22 @@ mlxsw_sp_fid_family_pgt_size(const struct mlxsw_sp_fid_family *fid_family)
 	return num_fids * fid_family->nr_flood_tables;
 }
 
+static u16
+mlxsw_sp_fid_pgt_base_ctl(const struct mlxsw_sp_fid_family *fid_family,
+			  const struct mlxsw_sp_flood_table *flood_table)
+{
+	u16 num_fids;
+
+	num_fids = mlxsw_sp_fid_family_num_fids(fid_family);
+	return fid_family->pgt_base + num_fids * flood_table->table_index;
+}
+
 static u16
 mlxsw_sp_fid_flood_table_mid(const struct mlxsw_sp_fid_family *fid_family,
 			     const struct mlxsw_sp_flood_table *flood_table,
 			     u16 fid_offset)
 {
-	u16 num_fids;
-
-	num_fids = mlxsw_sp_fid_family_num_fids(fid_family);
-	return fid_family->pgt_base + num_fids * flood_table->table_index +
+	return mlxsw_sp_fid_pgt_base_ctl(fid_family, flood_table) +
 	       fid_offset;
 }
 
@@ -1671,7 +1678,7 @@ mlxsw_sp_fid_flood_table_init(struct mlxsw_sp_fid_family *fid_family,
 	u16 mid_base;
 	int err, i;
 
-	mid_base = mlxsw_sp_fid_flood_table_mid(fid_family, flood_table, 0);
+	mid_base = mlxsw_sp_fid_pgt_base_ctl(fid_family, flood_table);
 
 	sfgc_packet_types = mlxsw_sp_packet_type_sfgc_types[packet_type];
 	for (i = 0; i < MLXSW_REG_SFGC_TYPE_MAX; i++) {
-- 
2.41.0


