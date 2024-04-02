Return-Path: <netdev+bounces-84045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2F8955E2
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA2289019
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F784A4D;
	Tue,  2 Apr 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvJtcOGI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99065BBB
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066246; cv=fail; b=iJjP2+EJZ6WK/AuK3vyKHAevD38J+f5jnpSeRf8VmFrPIdwMCUT1CyiJs9xQk8HH7YJwoBRfq7HR8dnIPg6hA7lma5+0wJCCKp4J5Bfi5vgYuuFsvIigkIQcf9l4VFbRD3W24eeBVEV4RhuzJ+T3zeVYjKX5MN8a181X6CM0Ez8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066246; c=relaxed/simple;
	bh=lFI6j9/8SeqvFW5LCR4aYcDDIubVb1ogVaHDUyE/iFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVuKVyVfZ3ZVRa7vGcYL/9axWhXuK06qDzoWm6h7JBFcrjvPGuZiPiRxttdqxRUu6/rE6yxEE8s3SyvtAD4yFqiUGKrgKOBqfye1+7NrJj4jtbNDbXBzA3QyDEQSQC8ztuSTU+TIDFLrhCLNxVBljNkEqp4fXkSr3L6NGrcoDbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jvJtcOGI; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNs08nKO28+CKMsKHX1YMs49cUotqYnhKD8vghx0WbA2lQYFHjxrNAh/QBXkrr4bHNSD+rG6inuuj9Y7P/be/1R10IDf2JT+sm1WkvvdzYkIeRi7zRC1PEUSY92MvJlB4GS7saflJz9MR7Yu2LXoQrGMxQ1uPx9Y6WPqAUCMD/OSGrLyol5ogL2GitkaOqexUVSxjXwCxna5r0/hsgZxbRN1e9/Hp9Hg1tcPbg4lHzOmq3V5XfM7xvqEO3zTF57SLh4ViM7u4Kjzz3syJlWGR8QKiMgyy5gPk0HN97uLD8XW+SA2/HuwnH5nXs+fZ8uRZqo4VcL87RLN5jx6SvXc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRK2UZwjrjybNFnUPq80yRJx7wGhcSL7h0yBEyb4cYI=;
 b=XAhaymCveBCVW6LtX/ubJezVITjeJlDFewrrAZUnTH96BN8KlB9ob21M9sHr0m4O0RVAdqw0Rxexi6d6ksmmX0uQwQwZ/ZkIus8SSan9EMVBTbicDU2/xkgUIgQn+1LtbBpe/GztlOl3swv7L57eXVH0d72r7Z4wvu8FvxCF/VYM3/iqk/WPSm0oy/yPrCdux1EODd/qPyJR8gbZ24ySmxKph2t8uzoZCh5rwXCEytOQ1qa+6avrXUTo/I/ulEaUv06zhdSLAik9xbRQwIoBGnEhNlCCDeE03O5+MmDGfQRTsLYuy3QCzYUgmvlO779OFAppUGtKLuDw7iLyJaIsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRK2UZwjrjybNFnUPq80yRJx7wGhcSL7h0yBEyb4cYI=;
 b=jvJtcOGIwoIHmpFJB/gjG2eGI29HjA/DI6LLXEtvwoTION+hdsqtRat1Jl/dsLYpi4LnF6qcPI5U3akJX1TLIEFTg/vjiETbdiyXTYn6heq3L9NPazC+NclrUD5S4WLPDbe79goNh3NYYV0AYTX3tGRC4/P/SUPp0MLlZy3W1B51YeBGHxFobTQatiETtpVNj1t4as4oIJ4Xl4UFRrRBkIlfCBFdiiXxZjnzkz93sEa3IIy8KsyWriiC+25yuFIWYZ6OvHooOuxnn+QYJAAlpsHNRhSLKpR7q0FDSkcd3+tBWxaPIclvLOlC7Uy2Zrk007HdvWY6amRNe5G2YMtSnA==
Received: from CH0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:610:b3::12)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Tue, 2 Apr
 2024 13:57:20 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::d1) by CH0PR03CA0037.outlook.office365.com
 (2603:10b6:610:b3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.48 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:03 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:00 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/15] mlxsw: pci: Do not setup tasklet from operation
Date: Tue, 2 Apr 2024 15:54:16 +0200
Message-ID: <a326cae5fc1ad085a1a063c004983de6fe389414.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e540061-2175-4ee0-1ffe-08dc531ccffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bubUDuCbrLCWGPTVcqxhxr3UMpvGClTByz4z5d1ZG4FpdEOOWXNo4kES/cB4sdzd58+wKYity0yn4Xfz1Zbo6LtO6VqR6T4pud27XFmcxiAUa1vwScHFrGHZrNWATqs/hnZY2WIpeipLlNactE8zsk8AM/fa2CW4YpE85zLJ2GZVzNy2XH8gvC8G+lhE3X5dfES1HH4AZsD5SA0yRio28ibPvqjIg/P6OuSQD/C+OLo76++QB/sExfj5/WIhh11d6F36KCPLfQUbGYhtwxz4INF6zJmcfY84Y8Ugxf9lg/4kVKFX15xWDyTlt+X0rTRaEroNXFlJgcBbBD2ek0Qv7WcTTkYbArmdO/Ymmtq8ig32XZUOn02x+BDhRjgTxV3cCrUkiYuQKum+j3/NFP6G4eFy+hKggJ/BLDDOwS4RaPkl3TbbzvvFTuG/j2VLyc17tck5vUwdNGGdS1sKgS9yJuMdRJV3yYwAHwyjdaIqJ68KekZoy6j8AI9n3q7HMDzKZwAYa07FlWu3C+YYLPNAxckGc3G1PVsX0PhAVruaPhXnedTqxOH5Gx/t5kRlJpAZte8yUA/ahVWbhQqqJlxHvRa2u7h4qYQsA1LHdO21xOLOgmP3YRXmewqBGgq9IO+GgW7l5NCvEoWe3GHp5SlxHv62MRXRja5CNayrBQ50wLQWm39KrsDTn4Zp5GinudXbrnWOS7YAYF3uLei/0qB3yisRY5+/4HITLCJKU4GahOfEDdnPDjK7JyOO8psMps8d
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:19.1670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e540061-2175-4ee0-1ffe-08dc531ccffa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

From: Amit Cohen <amcohen@nvidia.com>

Currently, the structure 'mlxsw_pci_queue_ops' holds a pointer to the
callback function of tasklet. This is used only for EQ and CQ. mlxsw
driver will use NAPI in a following patch set, so CQ will not use tasklet
anymore. As preparation, remove this pointer from the shared operation
structure and setup the tasklet as part of queue initialization.
For now, setup tasklet for EQ and CQ. Later, CQ code will be changed.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 97c5c7a91aea..2031487a9dae 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -742,6 +742,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	err = mlxsw_cmd_sw2hw_cq(mlxsw_pci->core, mbox, q->num);
 	if (err)
 		return err;
+	tasklet_setup(&q->tasklet, mlxsw_pci_cq_tasklet);
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
@@ -866,6 +867,7 @@ static int mlxsw_pci_eq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	err = mlxsw_cmd_sw2hw_eq(mlxsw_pci->core, mbox, q->num);
 	if (err)
 		return err;
+	tasklet_setup(&q->tasklet, mlxsw_pci_eq_tasklet);
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
@@ -886,7 +888,6 @@ struct mlxsw_pci_queue_ops {
 		    struct mlxsw_pci_queue *q);
 	void (*fini)(struct mlxsw_pci *mlxsw_pci,
 		     struct mlxsw_pci_queue *q);
-	void (*tasklet)(struct tasklet_struct *t);
 	u16 (*elem_count_f)(const struct mlxsw_pci_queue *q);
 	u8 (*elem_size_f)(const struct mlxsw_pci_queue *q);
 	u16 elem_count;
@@ -914,7 +915,6 @@ static const struct mlxsw_pci_queue_ops mlxsw_pci_cq_ops = {
 	.pre_init	= mlxsw_pci_cq_pre_init,
 	.init		= mlxsw_pci_cq_init,
 	.fini		= mlxsw_pci_cq_fini,
-	.tasklet	= mlxsw_pci_cq_tasklet,
 	.elem_count_f	= mlxsw_pci_cq_elem_count,
 	.elem_size_f	= mlxsw_pci_cq_elem_size
 };
@@ -923,7 +923,6 @@ static const struct mlxsw_pci_queue_ops mlxsw_pci_eq_ops = {
 	.type		= MLXSW_PCI_QUEUE_TYPE_EQ,
 	.init		= mlxsw_pci_eq_init,
 	.fini		= mlxsw_pci_eq_fini,
-	.tasklet	= mlxsw_pci_eq_tasklet,
 	.elem_count	= MLXSW_PCI_EQE_COUNT,
 	.elem_size	= MLXSW_PCI_EQE_SIZE
 };
@@ -948,9 +947,6 @@ static int mlxsw_pci_queue_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	q->type = q_ops->type;
 	q->pci = mlxsw_pci;
 
-	if (q_ops->tasklet)
-		tasklet_setup(&q->tasklet, q_ops->tasklet);
-
 	mem_item->size = MLXSW_PCI_AQ_SIZE;
 	mem_item->buf = dma_alloc_coherent(&mlxsw_pci->pdev->dev,
 					   mem_item->size, &mem_item->mapaddr,
-- 
2.43.0


