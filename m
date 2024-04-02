Return-Path: <netdev+bounces-84044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462E8955E1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C157E1F2267A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5485268;
	Tue,  2 Apr 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hIpdJ7VA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4565BBB
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066236; cv=fail; b=VxGknOVXOGGa6urnMYSk1xoTSfSvUmVK3g66pd4a7xKaGlsywGh0yUIJRCYLWE8+5i652pZXs2TJ1/0l3hVCVMYeOAtjUzLp0T1Thyn4Ld5yy/8g3fH9hVP50wrBUEB8eZkPorkrEhfDxhJs6WZds4+BHp9h1UwUY2ngBoLxKWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066236; c=relaxed/simple;
	bh=6A0mQCgRHjrCgZXtKHapzmG8Q6F+Yv9A0+URSrfupaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyaPodopMa90oOkOsLwcVLSuYuKnH7BdXGjeU4uVzptOgrT/9qS4dWVVsQdyU3EvAhooKPWPAx4yHYmAz8QlvYp6AjjYi17ZGav3VQlJXEIyMueA8QMP2bFQZ0JGoMn/AOfCv8BTi3AgJJsR5FUuiQZTxcAKfX5X6wjNa1YWJ5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hIpdJ7VA; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBlu4InJzeJQdFTlOTYlmWjkACLDSVa5ImHCuKExcPSgWXdH5+m/5PuAxiA6GRHXQON65UBG3S60Zq18+/zWoDSTknJ+MFCw14xiPC7pLN/GKx7p0c4Rrm+fU3GaPEJgQlo3YaI/HB6jtomwm3leDd9nTxBUNGR07R7rWxx+HAXZ6D/71pyo0aKfYPetaW2CU2Z6QlT+p/hxiU0sZjt8pFzHugYhRZIcz/GOKEWf1dKM4hu6goZsKVnpXCyBnHW8rmGVeJL2nUN/npdPDwz/1qrIAhvb8nt1qQFvwTmhVQ15YAvZAifcggvItWx7plU8yqDo9IeGgbhXDuHQf1k13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i/JNwRYzRv5nL6xrOADNA2u8iiMeOpjvfPuVNkHHjc=;
 b=ZyENE9neZCPfMLN3c7bkOmbMTUFPq0g62LoOvSjpssvNupXJmccvYrDxz9PI0SLz4g3NojDK5YvpzqdCBlMfjHS8yXDXFUcfkTzTUzjqn2qqk1T7m9IRAlJvyHofaK2zlsdbk/Ds7q9KQ/fl5fqYS/q9TKw/7pLdtfHVVGnvddZdn2yEGmvZAozYBozPpAGjGoEHa6MCHcCwoqfHIXGcKyjf9Ssa1dZ6AchgjXqgqW9iDCPqD8q8tlr7qX1Zjl5V9hAvy5Iia2/tU95vxUHLOiUV0GLRa6zm/ulsgW11G/dLA1bjQGSA0h3z8S0N1cSc+aectqmVqLuOs2F5MZ0pzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i/JNwRYzRv5nL6xrOADNA2u8iiMeOpjvfPuVNkHHjc=;
 b=hIpdJ7VA6KsdDf0H10YFOB40m+SqspefgE73JwJVb6eCbXAeJ5vFFuTVYQjU52qA5JGzhD/KSoQfa+KiKKslaFJgQCBtsKMPNxksCu5NuqgQPGGZFtS7xpSP6NJ/qIf6JV5a3E4zUAo2wLZE/GLjfcMP7maG15RxHhMxEYv0Co1Myc21ElqAkXQSk7RoUuKr/bLCodDmt6FKmzP5FPKhmHbeL1EWnfoIGowCWIGwbRvix+1WuC8ZR+mpHTpC6AwGaQGHE3euZSaJL6mNvrR/wXlXBbad4e2UUFqc83XjBQ68U49boGF5uHe9dM84ec+2SL+TLtMIcxzFMDLmCNXoRA==
Received: from CH2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:610:60::26)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:10 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::4a) by CH2PR14CA0016.outlook.office365.com
 (2603:10b6:610:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:56:55 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:56:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 01/15] mlxsw: pci: Move mlxsw_pci_eq_{init, fini}()
Date: Tue, 2 Apr 2024 15:54:14 +0200
Message-ID: <7ae120a02e1c490084daae7e684a0d40b7cce4e7.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dab07e9-2bc9-4274-c0a0-08dc531cca4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bRY5ZJRSDYrt7WviZTJpyOXhRm2GnoApFQHwF4NnlPfC9LGeK7YAgoV4ubGCbBr6JzXwfI4d9jW94ttKD6Sexe1wC7iq95BAxgZuGhhIrmhDAkRZEDOADtY0Zo0S+L8Z98gmU4r079favS8g7EPYYPxb0sPZI7CGPJDu3vB3F2mr+v99pel3GRbtCM01us35DhIvhxQncdPSDLGvGKekOp79Z+Xl5YztoT8XUN/0DHWE3H4lYRwZe26rCKL04vmrPiWym0FoRiiDanoTKxjj4j8JrJRSNvgHf7BF3hrdKHGhOH48PHHBdG5K/LCLmNs7+1BT9hHNJh9wv7fe6HrV5UBXJpXZVqnaTq8p0b0lBDHcH/NjsIRJ6U2n6LR6XJCPmhULhoz9y95D0aDwkJbjdqwMTbvi3zGkEH6X1gQwmkVooIUz0VPgFcU2Aqu+GwTSrkbFOr+6jgRSyehlkpWcLWmZ5yqP7dP5LUOX6AL0PCJXx2oDoXrRlhXll2gWXfu/oyhBUIVsqacZomuJN3pscalCnIT9B8P+T/9obj1XCJeQqdT8l5Ly+JY8rVwpZBwd6OwkmptkCgaoB+ZpBKiOjgrORYx7XDidMf/yEvH06XEI6RcC63PWprEtrciJFtx4Zkzjj3Vaw59gMI1CX1GrCTXzSsCh/5fcN1RLmG5NLPakre2s8z8uiPwANoD1F4QI73eDoOJ6Vvc7vZYDbtDih0Ym2qcw7pSfjGKaRTrx9weyf6JQzBHqQt7WBsdb0xb+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:09.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dab07e9-2bc9-4274-c0a0-08dc531cca4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

From: Amit Cohen <amcohen@nvidia.com>

Move mlxsw_pci_eq_{init, fini}() after mlxsw_pci_eq_tasklet() as a next
patch will setup the tasklet as part of initialization.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 72 +++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index f42a1b1c9368..93569b14b357 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -765,42 +765,6 @@ static u8 mlxsw_pci_cq_elem_size(const struct mlxsw_pci_queue *q)
 					       MLXSW_PCI_CQE01_SIZE;
 }
 
-static int mlxsw_pci_eq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
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
-		mlxsw_pci_eqe_owner_set(elem, 1);
-	}
-
-	mlxsw_cmd_mbox_sw2hw_eq_int_msix_set(mbox, 1); /* MSI-X used */
-	mlxsw_cmd_mbox_sw2hw_eq_st_set(mbox, 1); /* armed */
-	mlxsw_cmd_mbox_sw2hw_eq_log_eq_size_set(mbox, ilog2(q->count));
-	for (i = 0; i < MLXSW_PCI_AQ_PAGES; i++) {
-		dma_addr_t mapaddr = __mlxsw_pci_queue_page_get(q, i);
-
-		mlxsw_cmd_mbox_sw2hw_eq_pa_set(mbox, i, mapaddr);
-	}
-	err = mlxsw_cmd_sw2hw_eq(mlxsw_pci->core, mbox, q->num);
-	if (err)
-		return err;
-	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
-	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
-	return 0;
-}
-
-static void mlxsw_pci_eq_fini(struct mlxsw_pci *mlxsw_pci,
-			      struct mlxsw_pci_queue *q)
-{
-	mlxsw_cmd_hw2sw_eq(mlxsw_pci->core, q->num);
-}
-
 static void mlxsw_pci_eq_cmd_event(struct mlxsw_pci *mlxsw_pci, char *eqe)
 {
 	mlxsw_pci->cmd.comp.status = mlxsw_pci_eqe_cmd_status_get(eqe);
@@ -877,6 +841,42 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 	}
 }
 
+static int mlxsw_pci_eq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
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
+		mlxsw_pci_eqe_owner_set(elem, 1);
+	}
+
+	mlxsw_cmd_mbox_sw2hw_eq_int_msix_set(mbox, 1); /* MSI-X used */
+	mlxsw_cmd_mbox_sw2hw_eq_st_set(mbox, 1); /* armed */
+	mlxsw_cmd_mbox_sw2hw_eq_log_eq_size_set(mbox, ilog2(q->count));
+	for (i = 0; i < MLXSW_PCI_AQ_PAGES; i++) {
+		dma_addr_t mapaddr = __mlxsw_pci_queue_page_get(q, i);
+
+		mlxsw_cmd_mbox_sw2hw_eq_pa_set(mbox, i, mapaddr);
+	}
+	err = mlxsw_cmd_sw2hw_eq(mlxsw_pci->core, mbox, q->num);
+	if (err)
+		return err;
+	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
+	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
+	return 0;
+}
+
+static void mlxsw_pci_eq_fini(struct mlxsw_pci *mlxsw_pci,
+			      struct mlxsw_pci_queue *q)
+{
+	mlxsw_cmd_hw2sw_eq(mlxsw_pci->core, q->num);
+}
+
 struct mlxsw_pci_queue_ops {
 	const char *name;
 	enum mlxsw_pci_queue_type type;
-- 
2.43.0


