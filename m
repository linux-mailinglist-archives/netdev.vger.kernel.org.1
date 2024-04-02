Return-Path: <netdev+bounces-84054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4A8955F8
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77B4B2FA0A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083A86ACA;
	Tue,  2 Apr 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pLognDJ1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AF85278
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066279; cv=fail; b=SPHht1ZcLspZaPrIgpgN3E6XQLCWtp8JPrNSAsKOZ9FZlwM0GmOgLhotBzwutL957sCXhhHxf5Sfbgrx/AnQN0wgDdgvmdH2xVsPxzqM6yhkgUIqzFvzUlZkjD3B8Mn3+DTIZ8ZkvEpzawPwb/8AcrtQ/jkGQfKwv/vIkCe9qhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066279; c=relaxed/simple;
	bh=VivmZb2t+sBuvW+SgHwbpolhDnWiYVkXfKPIt8vtHwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7Ine9k9CcchgQTGNkUUtK5AR7AU71Mkw58mv2jkVMVSixcKhdY7d3evvxFxQFDm0Mx40NoJucVWvo+UdzYnPW3Yob17FL/kMaLyr0afGTTJl+J/D3DqgKa4LEtDtZvYpCRxOWepr2kEwUbba37vtpuk4JmyAcEa9HJsefoqky8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pLognDJ1; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC26961zupZzfulB4FTpeJ82GIt3cnCC4n1F0NXdDwZCPPPxGOX1MNd/SEv5VJzcTCHFN7ILBikqdznzVEjcTFVKYdHkhdsYDrUqbgXfHilEz0jh4MMmbXNEodDT6xTaVmUCAEfUuuuPKABDwfRVeewt3yRp6P31A5frehlz6zlLRkDrvVuT8e0jcJY76V9bhJWyrPO9D221Q/Wg4RJs2cRgN5laGkFMETMrrYUyy0Ai4njFwrlsrtu0Hs94WVv/plB3+lUkj7aQ5oLQ1eZqHjKI/FGaAv4aDshXNy1if0bt35JAmwsTOuWgkRXfOPVrV3QBMnkXYzpVo87lYh8MBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o23x0UK9mrWgD/xS/ZFkGAH8oSbU4h7+M/XBbvBEchM=;
 b=mfYRvRletdaPbwrxjQMKvTB3W30xIeILOeoNNGaU+r/Ds15jTweNj81Dq98td5nQayJhzSup76GTO4bBd2DT6URP0P07+6XzyKMs+QrdM3fRlQs1cJ9cgocZWLLlA1IrXt0qJ0Z8JL9GuHtn+oX4L/KKGQylRMer41G4tl8fsq08P86I0B6ju5VGQmxPt6NFRwkFpdt/uv5oGVdpfaFpmjeU6WK9qpBQNDfzd9Lny+cOXP139il/J7ShZitHWkWWgEq2jzddAjiAudb+6w+XAln3tBb7qAFY2wBJS5d9l45jObOFAQWzrTGhltW0pcLe4DAhTdK2a8TZTu/2FTC3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o23x0UK9mrWgD/xS/ZFkGAH8oSbU4h7+M/XBbvBEchM=;
 b=pLognDJ1IQAFd75Y5wD1C9aYrUS+eElGVyb6mU8rz6o5bPPrJ8kApWCGrYFDFUZS72i9V6BxV0se+Y4/n0brvHIN4+uXuNuJlzsOhU8t9vEYXwUrAZ1k6Z6avNy+vooW/DdrWod9oi7zAOIE1epExmLkuIlu9idMY51f0apNYgCHlLoCsVS/QfzFnwqRV1yjwLFx2V1iPyO1eSxtUmxaOu2cDEdXkWUSKC3Fo0oWItCu1r3Psi7xhFdF6qBzfbHvn7994Oq4kkBOI4LiSkYv5QCStglkM8N3SWeQOhhSvOcRSLqWIPMeWRSEz8Oq4Z1iOOJtXCnpusroE/lomm0CnQ==
Received: from CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::10)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:47 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::ff) by CH0P221CA0028.outlook.office365.com
 (2603:10b6:610:11d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:30 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:26 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/15] mlxsw: pci: Use only one event queue
Date: Tue, 2 Apr 2024 15:54:22 +0200
Message-ID: <23d764f5c032e4c363b98590b746a4b32d2bf900.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: b46b9d46-0e77-4592-04eb-08dc531ce0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CZF5lEvKYqFNPX4SsgpqDER0uJLAYj7at85WHfeubvxlfKwxw6X3gurIcBCKjS6QXprf5qOiDKOwVk1jrsJOFV3+XuVdzmWa0f31tZhYi7zJuts6eGVhy9hgUpstI/FMnfMekOMyTHXgc4OZezbwkx8oB+KXktDBgeLNzmO5nD/qxlIYv+H3B+EnDfZg+3nxlqFcT7epSdckGR6pdqvMJykkdp6mIlJGlAqSdI/M4pgx5w4texjnAYXXoUL6p8BF0xhcf+vfFQvKUNRpAe0yvrfitKtqny9LqxYlxTbdAUUcEUSin/ggqhWAQMA2bA3SU6SDqGnAaAm0btJ3we8tGZYIV+hbw5UROu1qcBCDj1v8KTK9b7mIy3mEUzWclFmJjJfgyk8iTPScZgjTsAO5nr4Sf/yOANBc1wRy/E4cieu4cTE637aIgRjDZeRZg5ACBjAw6MELRNvvvNI2kQjJkJP9eLsvYq6ZgOK+CEDiZF2i04V2eIGUjc3iP070lE2sb2Ksg/JhW/OLzs829rOg7Ppuxm4UJUNZd/5y9XCbt3hhXNc4oiK3BZpV2X4kPkxlFqlFxsajyv/PXrH/5xKnSnUBQPFfHbouRgejHToz79u4XqGv8nSLB1Jy6TPcA3OLJ72xbzzVFJA/OLIIJ9KXvbKSCuraEb7hqeatMaVAvO/wZoZWwEtZl8FmWsfIylbHc0Zuqwj3mU19IIhSXZAgUJ5q5/6crmAq/z36EoDFhDAVLN/bcxekvmLsME93kN5m
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:47.3115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b9d46-0e77-4592-04eb-08dc531ce0c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737

From: Amit Cohen <amcohen@nvidia.com>

The device supports two event queues. EQ0 is used for command interface
completion events. EQ1 is used for completion events of RDQ or SDQ.

Currently, for each EQE (event queue element), we check the queue number
and handle accordingly. More than that, for each interrupt we schedule
tasklets for both EQs. This is really ineffective, especially because of
the fact that EQ0 is used only as part of driver init/fini, when EMADs are
not available. There is no point to schedule the tasklet for it and check
each EQE.

A previous patch changed the code to poll command interface for each use of
it. It means that now there is no real reason to use EQ0, as we poll the
command interface.

Initialize only one event queue and use it as EQ1 (this is determined by
queue number). Then, for each interrupt we can schedule the tasklet only
for one queue and we do not have to check the queue number. This
simplifies the code and should improve performance. Note that polling
command interface is ok as we use it only as part of driver init/fini.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c    | 54 ++++++--------------
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h |  2 +-
 2 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index cb960917e462..3460a4ef7d9a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -223,10 +223,10 @@ static struct mlxsw_pci_queue *mlxsw_pci_cq_get(struct mlxsw_pci *mlxsw_pci,
 	return __mlxsw_pci_queue_get(mlxsw_pci, MLXSW_PCI_QUEUE_TYPE_CQ, q_num);
 }
 
-static struct mlxsw_pci_queue *mlxsw_pci_eq_get(struct mlxsw_pci *mlxsw_pci,
-						u8 q_num)
+static struct mlxsw_pci_queue *mlxsw_pci_eq_get(struct mlxsw_pci *mlxsw_pci)
 {
-	return __mlxsw_pci_queue_get(mlxsw_pci, MLXSW_PCI_QUEUE_TYPE_EQ, q_num);
+	/* There is only one EQ at index 0. */
+	return __mlxsw_pci_queue_get(mlxsw_pci, MLXSW_PCI_QUEUE_TYPE_EQ, 0);
 }
 
 static void __mlxsw_pci_queue_doorbell_set(struct mlxsw_pci *mlxsw_pci,
@@ -754,16 +754,6 @@ static u8 mlxsw_pci_cq_elem_size(const struct mlxsw_pci_queue *q)
 					       MLXSW_PCI_CQE01_SIZE;
 }
 
-static void mlxsw_pci_eq_cmd_event(struct mlxsw_pci *mlxsw_pci, char *eqe)
-{
-	mlxsw_pci->cmd.comp.status = mlxsw_pci_eqe_cmd_status_get(eqe);
-	mlxsw_pci->cmd.comp.out_param =
-		((u64) mlxsw_pci_eqe_cmd_out_param_h_get(eqe)) << 32 |
-		mlxsw_pci_eqe_cmd_out_param_l_get(eqe);
-	mlxsw_pci->cmd.wait_done = true;
-	wake_up(&mlxsw_pci->cmd.wait);
-}
-
 static char *mlxsw_pci_eq_sw_eqe_get(struct mlxsw_pci_queue *q)
 {
 	struct mlxsw_pci_queue_elem_info *elem_info;
@@ -786,7 +776,6 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
 	struct mlxsw_pci *mlxsw_pci = q->pci;
 	int credits = q->count >> 1;
-	bool cq_handle = false;
 	u8 cqn, cq_count;
 	int items = 0;
 	char *eqe;
@@ -794,23 +783,9 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 	memset(&active_cqns, 0, sizeof(active_cqns));
 
 	while ((eqe = mlxsw_pci_eq_sw_eqe_get(q))) {
+		cqn = mlxsw_pci_eqe_cqn_get(eqe);
+		set_bit(cqn, active_cqns);
 
-		/* Command interface completion events are always received on
-		 * queue MLXSW_PCI_EQ_ASYNC_NUM (EQ0) and completion events
-		 * are mapped to queue MLXSW_PCI_EQ_COMP_NUM (EQ1).
-		 */
-		switch (q->num) {
-		case MLXSW_PCI_EQ_ASYNC_NUM:
-			mlxsw_pci_eq_cmd_event(mlxsw_pci, eqe);
-			break;
-		case MLXSW_PCI_EQ_COMP_NUM:
-			cqn = mlxsw_pci_eqe_cqn_get(eqe);
-			set_bit(cqn, active_cqns);
-			cq_handle = true;
-			break;
-		default:
-			WARN_ON_ONCE(1);
-		}
 		if (++items == credits)
 			break;
 	}
@@ -821,9 +796,6 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 
-	if (!cq_handle)
-		return;
-
 	cq_count = mlxsw_pci_cq_count(mlxsw_pci);
 	for_each_set_bit(cqn, active_cqns, cq_count) {
 		q = mlxsw_pci_cq_get(mlxsw_pci, cqn);
@@ -837,6 +809,13 @@ static int mlxsw_pci_eq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	int i;
 	int err;
 
+	/* We expect to initialize only one EQ, which gets num=0 as it is
+	 * located at index zero. We use the EQ as EQ1, so set the number for
+	 * future use.
+	 */
+	WARN_ON_ONCE(q->num);
+	q->num = MLXSW_PCI_EQ_COMP_NUM;
+
 	q->consumer_counter = 0;
 
 	for (i = 0; i < q->count; i++) {
@@ -1077,7 +1056,7 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 	mlxsw_pci->num_sdq_cqs = num_sdqs;
 
 	err = mlxsw_pci_queue_group_init(mlxsw_pci, mbox, &mlxsw_pci_eq_ops,
-					 num_eqs);
+					 MLXSW_PCI_EQS_COUNT);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize event queues\n");
 		return err;
@@ -1414,12 +1393,9 @@ static irqreturn_t mlxsw_pci_eq_irq_handler(int irq, void *dev_id)
 {
 	struct mlxsw_pci *mlxsw_pci = dev_id;
 	struct mlxsw_pci_queue *q;
-	int i;
 
-	for (i = 0; i < MLXSW_PCI_EQS_MAX; i++) {
-		q = mlxsw_pci_eq_get(mlxsw_pci, i);
-		mlxsw_pci_queue_tasklet_schedule(q);
-	}
+	q = mlxsw_pci_eq_get(mlxsw_pci);
+	mlxsw_pci_queue_tasklet_schedule(q);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
index 32a4f436d24d..6bed495dcf0f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -43,7 +43,7 @@
 
 #define MLXSW_PCI_CQS_MAX	96
 #define MLXSW_PCI_EQS_MAX	2
-#define MLXSW_PCI_EQ_ASYNC_NUM	0
+#define MLXSW_PCI_EQS_COUNT	1
 #define MLXSW_PCI_EQ_COMP_NUM	1
 
 #define MLXSW_PCI_SDQS_MIN	2 /* EMAD and control traffic */
-- 
2.43.0


