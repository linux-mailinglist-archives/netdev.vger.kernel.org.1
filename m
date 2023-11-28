Return-Path: <netdev+bounces-51742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE47FBE88
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B3B1C20C6E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F135267;
	Tue, 28 Nov 2023 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pAh+L8oZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8E010CA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOb1dxqfN8kjWzNQQusmgVJwa4K+yiqtVqlzEjez6O+3JuRNiX30OTLskCqOI+ayiaSIUQd5rx3UIMbLaJJgXrD7ir+nLCZ6Vzsmz9gRhc52aRqqeXO0ylPZkb8y2iSxXeTTKPjEljlvjuvz0I8yxovDqsSYdp3irvMtZQwUbQ3rQXgFnMXz6rnkQk8Ftz6ISgmZY+oIQwvdwtCvgo8C9EQnIYfRTUsODDIKVHcnb4Hl0wVsV1U7EmeR+bsMCTU5aikU99lPl7P25CsmchRlu6WpBU9Zi3CzoFybx5RlHAAXEPyBUZgz4fBu+VveXn+f66zYMVV9qMM5bkJm/5cagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ1TU4toMqa6xqJtiaoXgW5I6g0tl28OPIe6ex5hnh8=;
 b=dpwC48Pt21knSC4KCJ09TfUwaFnEk22XuUqtDFNWhEYG/p+O5DVMFk2UMxIm7/uzjcWoXOujrQ61KjmdqT/PO62KcFGoI4Hhokhaqtfv6DVY6qPGjTyeSYxTV6cyB0NAJnyrWZljfjpBRqPeUo7OERx0tejbXkqahIorTDGjkJXTwhQ61L787YojR2c8cO+lQxnGITqzODMlJpa6aTZ6urXYx2Kk0JX7WBILyUzg0kcMr96CL/1kt47pcuCG+YZc7Mo26yRvrYhE0WCNzb5KzgSvbVdhukuZ9NHaV4JQIQnXNzjV7fJFmxmgkW/Y5kbyowaT7kiRGOhvlpYPLUDQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ1TU4toMqa6xqJtiaoXgW5I6g0tl28OPIe6ex5hnh8=;
 b=pAh+L8oZoxhTki8obHMltzJOiCcaMfIrB4h1FrH5NxGdALFLTchmSjRTcL+dfthKntdvNn1rTlpS6nQ0O4QdcRfn+tkyiS0UGT5bILAi8Ft05UV2du1KN9D+2f2aNOkr9MMxsl/cSuKdZjlE3FiOu4ZH6EThCRq3FG63yA7UStZsUf5HyHWJQmw2gLv1eg5TAfTygNokeowdD0D+JaC0YZZ+T8ASSi/OdbvS3XG7DTRXrahKmgo1l4pFtEUqoM9Zs+m5n3JFUWdbN4qvNDm+rtcdu3VxCJOL5lHIVZJ/w3ZFjbgyJraYR0i3i6OLIFUjptOFMZZs3+SeITcNvZXppw==
Received: from BYAPR07CA0068.namprd07.prod.outlook.com (2603:10b6:a03:60::45)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:34 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::b2) by BYAPR07CA0068.outlook.office365.com
 (2603:10b6:a03:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:18 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:15 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/17] mlxsw: spectrum_fid: Make mlxsw_sp_fid_ops.setup return an int
Date: Tue, 28 Nov 2023 16:50:37 +0100
Message-ID: <75f1b85c0cb86bea5501fcc8657042f221a78b32.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: ca473021-41d9-476b-ebb7-08dbf029e59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XGgYMdmiEmQCRhqN/X+Dkpg58eGDqWaFypRfLadHCagY2i9q89vWBDWkEc9pKWk3elqafXStQ52JlbWf1b51D7htwL7Fi1vaqsurbcmQSWGszJNbcL4Q1iBFy0udwzVOTMA/RyPYHxphf6cMiaw3xaWqIGu4enLFw4I2iUZKGjYfOLui7uJplGwDQ9JzWEcga6cWeQJ4vyxWaLPRdykgRpJcxA5/QMXBSWMZGdgSbLY/rWRNnPTXiDQTZkMchNDCMZ+qXjsviEKzebubXDiQTJPKObudsrYgbhg5tCwyPFnSKvr+kd2bunUnKugoFtebDGvOAZKGFRnqetZvPDMBnRSo8wSVipt8oCDIbE4EbgXzMD3cwJosc3R0XGrzV0zYB0oByL8bTDtIwM92IiI2EjJhFWGxNEdazjMUF6oAtE/bn6UD+qPxcVefLhoM/4uurG5qF+0zoW10IYos5D2eaYN8E6ftDsV8HQPvHvPxfbpkP4sjIi+wwvpReo7AD8cbjNvPOoVvLpKMqzYYKPbHlMckvtqXoWDZ0dUm01ANyRMAMM/iL2bi7CKkqhQmTCHOnqKXhim+taNU8WhLMmu+A7IvJZzaRlbu/iDbB+uEmRHfC2O9EH1X/3/yV2tP5SSWJA6Xv/H+2po7pqCUy+94To6LufvXaLk8vQSMpN+9ja9b58y4ugMmyxETZND/NFF08Gee2+j1QaJduuywTK8/iqcFBDTj0IM6Ad2O9hEEq9khTK45eBroG+/6bLoraskd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(6666004)(8936002)(8676002)(4326008)(54906003)(110136005)(70586007)(70206006)(316002)(40460700003)(478600001)(2906002)(26005)(356005)(7636003)(47076005)(41300700001)(36756003)(86362001)(107886003)(16526019)(36860700001)(40480700001)(2616005)(83380400001)(426003)(336012)(5660300002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:33.8802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca473021-41d9-476b-ebb7-08dbf029e59b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503

This operation will be fallible for rFIDs in CFF mode, which will be
introduced in follow-up patches. Have it return an int, and handle
the failures in the caller.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 96cedc241bf2..ab0632bd5cd4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -76,7 +76,7 @@ struct mlxsw_sp_flood_table {
 };
 
 struct mlxsw_sp_fid_ops {
-	void (*setup)(struct mlxsw_sp_fid *fid, const void *arg);
+	int (*setup)(struct mlxsw_sp_fid *fid, const void *arg);
 	int (*configure)(struct mlxsw_sp_fid *fid);
 	void (*deconfigure)(struct mlxsw_sp_fid *fid);
 	int (*index_alloc)(struct mlxsw_sp_fid *fid, const void *arg,
@@ -417,12 +417,13 @@ u16 mlxsw_sp_fid_8021q_vid(const struct mlxsw_sp_fid *fid)
 	return mlxsw_sp_fid_8021q_fid(fid)->vid;
 }
 
-static void mlxsw_sp_fid_8021q_setup(struct mlxsw_sp_fid *fid, const void *arg)
+static int mlxsw_sp_fid_8021q_setup(struct mlxsw_sp_fid *fid, const void *arg)
 {
 	u16 vid = *(u16 *) arg;
 
 	mlxsw_sp_fid_8021q_fid(fid)->vid = vid;
 	fid->fid_offset = fid->fid_index - fid->fid_family->start_index;
+	return 0;
 }
 
 static enum mlxsw_reg_sfmr_op mlxsw_sp_sfmr_op(bool valid)
@@ -785,12 +786,13 @@ mlxsw_sp_fid_8021d_fid(const struct mlxsw_sp_fid *fid)
 	return container_of(fid, struct mlxsw_sp_fid_8021d, common);
 }
 
-static void mlxsw_sp_fid_8021d_setup(struct mlxsw_sp_fid *fid, const void *arg)
+static int mlxsw_sp_fid_8021d_setup(struct mlxsw_sp_fid *fid, const void *arg)
 {
 	int br_ifindex = *(int *) arg;
 
 	mlxsw_sp_fid_8021d_fid(fid)->br_ifindex = br_ifindex;
 	fid->fid_offset = fid->fid_index - fid->fid_family->start_index;
+	return 0;
 }
 
 static int mlxsw_sp_fid_8021d_configure(struct mlxsw_sp_fid *fid)
@@ -1127,11 +1129,12 @@ mlxsw_sp_fid_8021q_fdb_clear_offload(const struct mlxsw_sp_fid *fid,
 	br_fdb_clear_offload(nve_dev, mlxsw_sp_fid_8021q_vid(fid));
 }
 
-static void mlxsw_sp_fid_rfid_setup_ctl(struct mlxsw_sp_fid *fid,
-					const void *arg)
+static int mlxsw_sp_fid_rfid_setup_ctl(struct mlxsw_sp_fid *fid,
+				       const void *arg)
 {
 	/* In controlled mode, the FW takes care of FID placement. */
 	fid->fid_offset = 0;
+	return 0;
 }
 
 static int mlxsw_sp_fid_rfid_configure(struct mlxsw_sp_fid *fid)
@@ -1272,9 +1275,10 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_rfid_ops_ctl = {
 	.vid_to_fid_rif_update  = mlxsw_sp_fid_rfid_vid_to_fid_rif_update,
 };
 
-static void mlxsw_sp_fid_dummy_setup(struct mlxsw_sp_fid *fid, const void *arg)
+static int mlxsw_sp_fid_dummy_setup(struct mlxsw_sp_fid *fid, const void *arg)
 {
 	fid->fid_offset = 0;
+	return 0;
 }
 
 static int mlxsw_sp_fid_dummy_configure(struct mlxsw_sp_fid *fid)
@@ -1590,7 +1594,9 @@ static struct mlxsw_sp_fid *mlxsw_sp_fid_get(struct mlxsw_sp *mlxsw_sp,
 	fid->fid_index = fid_index;
 	__set_bit(fid_index - fid_family->start_index, fid_family->fids_bitmap);
 
-	fid->fid_family->ops->setup(fid, arg);
+	err = fid->fid_family->ops->setup(fid, arg);
+	if (err)
+		goto err_setup;
 
 	err = fid->fid_family->ops->configure(fid);
 	if (err)
@@ -1608,6 +1614,7 @@ static struct mlxsw_sp_fid *mlxsw_sp_fid_get(struct mlxsw_sp *mlxsw_sp,
 err_rhashtable_insert:
 	fid->fid_family->ops->deconfigure(fid);
 err_configure:
+err_setup:
 	__clear_bit(fid_index - fid_family->start_index,
 		    fid_family->fids_bitmap);
 err_index_alloc:
-- 
2.41.0


