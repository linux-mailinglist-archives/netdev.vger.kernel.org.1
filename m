Return-Path: <netdev+bounces-84046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8398955E3
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB231C22378
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608785277;
	Tue,  2 Apr 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="txGYHLmp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10884FC5
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066248; cv=fail; b=rz2g67pcCubsZT91mWxa69COl2RB1+VX9lpx0hA653wH+abvmnxjYFCi9yzDPQHp0GZSis0EVvAnEvAjLV2jQisri/vxZpy1L8SjQsQQq1qAqWYXglHgNKhAjVw9c8AfISMzhNUKSxFfSgCZq8UAhwIW69sPUVJq1j5O7WM4z58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066248; c=relaxed/simple;
	bh=9LsF+kRKibiU4PS/Sm+q0IFPFvLHUQsvbA3VfxOYOZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcUxYuTK2YG5asrWYmjdT18+Z2InXVs9iOqm5VwjN3NUvGC8WSL6uVKZcIqB7cVkmP0seY7MXfIUS+E+RsSyL7evHhYYBr7R3XTvf9vNKQi3M2HlWuixwfyaIv23vXERc5ITa1GKC5HhmdPOEPY62KnjEnnC8X4mxHh/xkyk5cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=txGYHLmp; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb823KL/yBM0Bf1cEr2H5fN+s9AVpjt1Z4e+9HoUQqwiqa8b1LMMfkc/ObzgdsbLz1BqIe/ywlB+IpAvpNbHDMZEOD7zml2+X6Skk6tsVHfoZzYXgd8lIfLha9h4chsr3LcVdxwGIbP9h6WeNSudm6aS3vgyjwQsRAE7htg5e7yUeNg0VVKuDw/4i5KWEV3co9NBw2WqXDDEewacBzCNia/BE4/uFem7apCMc6Vt2IyvCx9yAf8eONLFOO/tNbXYBkxRm7fuDjaAtzikC94nuR3yai1B8ihxBpBDewVhSy6T+urO1s6xAbrZDJi24Vu88moIGrIxO48S0ynu5H28FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TXBqPP4DvaFeGiOITihRAXxJb+TyoqLtPea6VhGfv0=;
 b=n3gfcR2vzT5ftfuGMm/n7q+lbTkwZmCiPk7ZC7GVk7qCj7e0HX495owQkCBDtpmnnQGoY+wUdgt1r+2pdVVpHxrG20zrOPCGkGiBQlsQF5daIyosHAG7ptKHLpqjY9p8/F8xeJFR7/6HlrCYUZ+lGBGJSX678+CW70mCZ1ukpuT76+LsTmACGa/0z5vvNJ6S1rf6bwM4TpgbtuNLoSNChqafvwuJAA6YhHe1vEDb1dfFY+SSxum78FYv9/reBIprZlQMe5uz4BAM10Hz9gtanFMOguWUAMqH4+Bnj9lcaLM0FHu3MIfy3Nyng6MMtrvh8n2K9iRdVPG6V1CWLlXkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TXBqPP4DvaFeGiOITihRAXxJb+TyoqLtPea6VhGfv0=;
 b=txGYHLmpXdKe1lpeXJ+K212T0cgzIhFN175dSBN0t/3IVj9MuYfwCP4xlJN6VIAmUeAdLz0IhdFGopOOfoFU7JGJ0ilB0IiWhCfrWd9BOZ5ZRNiAj7BUL/IfE1t6OZVItLq4CV9sXptDvSDlqUVbSpjQQrzPnS+cvbVaSKw+i3XodCmfEuMI5XDQlDOHiHNO3bszz+JSNUs3GmuLOOJcm3pBIe2pahG2eq+ggX6j+fKXwDx0yNmCK5My9dAr5Io/cPWi9PHpsbszKkTSuQ/TSqXMv77dgiR+9vvDnhylqQux3zmEKaHI/TxLYN4UNxwDyv1igIdn3EnoXX9N5zs0XA==
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:12 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::29) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:00 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:56:55 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 02/15] mlxsw: pci: Move mlxsw_pci_cq_{init, fini}()
Date: Tue, 2 Apr 2024 15:54:15 +0200
Message-ID: <25196cb5baf5acf6ec1e956203790e018ba8e306.1712062203.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712062203.git.petrm@nvidia.com>
References: <cover.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 3846c0dc-f5d3-4eea-0787-08dc531ccbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YfWbyn96/lH2zRDdUazoC+BAU6mMff0dzRDFP5CyL/KSEHnogpGdPezuyfRzLQ5U1t93GP+B4cieymFSX9KbcjH680yCNjwVsIipaeCSOqd6UvPsup736RjuJMmVIeyUlTO6J6i+1yvOhScfncNxsL81F3nW+oKJuB7onxEh3zOOuEp4wwz4g3LSlMUHOkfL4GJn6+LuOq78xx0li1t2ATSUkrHTFBhc/ewCf6tFT2vxtPh8g/MWdVppKmZFSGGhnAoJ55+VoS+CjHWYaRhY4xzeleuLV6Hm//Z6EYSAAvXbYFHNAKcEStJ8Uvgf/590ZtqcY6I72FInhfqQLXuFy95zFeRxi1RLqN4ZbM6lXEs87rq2r+sChRUXd/W/eJyEee9LNLSDMd5712+JJpvSxX4hfSwtOZUYiWLUe97fX71qhioXmQZxb3D8qWxmsshKtROHQMDi6PdreGp1Rok6mgF6G8UzRGqJUHqrGEENYMDu0RZPIgYBd4LG2eo39M7JO2F6naHTZR6KtAMK03gByw6g4ZrPUvXpQU28Io79EmwnsXpiTtvWEdDkYoYIt8sZk4rnb5ZH4ULcrI62tVhIvUDVEKXI6ARQCqAgsg/Dmz19FcNGmJ9afPLRHn3wkbVegLx0PlutKLD6mdmWkx+tZ+SAYMj7Aq47JdLbF0dRBgqMjUvHghPWEVjrFVQO3PzCv+j3J1MPZSlC03CsVuqvgVO6v6XfGCZbRwieM/YXLilGIsUOdTDWwOZ4lN9hKfQ+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:12.2110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3846c0dc-f5d3-4eea-0787-08dc531ccbc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582

From: Amit Cohen <amcohen@nvidia.com>

Move mlxsw_pci_cq_{init, fini}() after mlxsw_pci_cq_tasklet() as a next
patch will setup the tasklet as part of initialization.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 86 +++++++++++------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 93569b14b357..97c5c7a91aea 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -470,49 +470,6 @@ static void mlxsw_pci_cq_pre_init(struct mlxsw_pci *mlxsw_pci,
 		q->u.cq.v = MLXSW_PCI_CQE_V1;
 }
 
-static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
-			     struct mlxsw_pci_queue *q)
-{
-	int i;
-	int err;
-
-	q->consumer_counter = 0;
-
-	for (i = 0; i < q->count; i++) {
-		char *elem = mlxsw_pci_queue_elem_get(q, i);
-
-		mlxsw_pci_cqe_owner_set(q->u.cq.v, elem, 1);
-	}
-
-	if (q->u.cq.v == MLXSW_PCI_CQE_V1)
-		mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
-				MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_1);
-	else if (q->u.cq.v == MLXSW_PCI_CQE_V2)
-		mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
-				MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_2);
-
-	mlxsw_cmd_mbox_sw2hw_cq_c_eqn_set(mbox, MLXSW_PCI_EQ_COMP_NUM);
-	mlxsw_cmd_mbox_sw2hw_cq_st_set(mbox, 0);
-	mlxsw_cmd_mbox_sw2hw_cq_log_cq_size_set(mbox, ilog2(q->count));
-	for (i = 0; i < MLXSW_PCI_AQ_PAGES; i++) {
-		dma_addr_t mapaddr = __mlxsw_pci_queue_page_get(q, i);
-
-		mlxsw_cmd_mbox_sw2hw_cq_pa_set(mbox, i, mapaddr);
-	}
-	err = mlxsw_cmd_sw2hw_cq(mlxsw_pci->core, mbox, q->num);
-	if (err)
-		return err;
-	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
-	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
-	return 0;
-}
-
-static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
-			      struct mlxsw_pci_queue *q)
-{
-	mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
-}
-
 static unsigned int mlxsw_pci_read32_off(struct mlxsw_pci *mlxsw_pci,
 					 ptrdiff_t off)
 {
@@ -753,6 +710,49 @@ static void mlxsw_pci_cq_tasklet(struct tasklet_struct *t)
 		mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 }
 
+static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
+			     struct mlxsw_pci_queue *q)
+{
+	int i;
+	int err;
+
+	q->consumer_counter = 0;
+
+	for (i = 0; i < q->count; i++) {
+		char *elem = mlxsw_pci_queue_elem_get(q, i);
+
+		mlxsw_pci_cqe_owner_set(q->u.cq.v, elem, 1);
+	}
+
+	if (q->u.cq.v == MLXSW_PCI_CQE_V1)
+		mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
+				MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_1);
+	else if (q->u.cq.v == MLXSW_PCI_CQE_V2)
+		mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
+				MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_2);
+
+	mlxsw_cmd_mbox_sw2hw_cq_c_eqn_set(mbox, MLXSW_PCI_EQ_COMP_NUM);
+	mlxsw_cmd_mbox_sw2hw_cq_st_set(mbox, 0);
+	mlxsw_cmd_mbox_sw2hw_cq_log_cq_size_set(mbox, ilog2(q->count));
+	for (i = 0; i < MLXSW_PCI_AQ_PAGES; i++) {
+		dma_addr_t mapaddr = __mlxsw_pci_queue_page_get(q, i);
+
+		mlxsw_cmd_mbox_sw2hw_cq_pa_set(mbox, i, mapaddr);
+	}
+	err = mlxsw_cmd_sw2hw_cq(mlxsw_pci->core, mbox, q->num);
+	if (err)
+		return err;
+	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
+	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
+	return 0;
+}
+
+static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
+			      struct mlxsw_pci_queue *q)
+{
+	mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
+}
+
 static u16 mlxsw_pci_cq_elem_count(const struct mlxsw_pci_queue *q)
 {
 	return q->u.cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_COUNT :
-- 
2.43.0


