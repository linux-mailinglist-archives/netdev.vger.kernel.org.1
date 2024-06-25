Return-Path: <netdev+bounces-106484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A2916951
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7551B28114E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C742161915;
	Tue, 25 Jun 2024 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WKSX4piz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713615F3E8
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323301; cv=fail; b=uM+TSLvPO28Lk+GQeBJVIAz/GVwR8S3FRr90JN5q3PbwuRRkApPAsHts+3kcXdIvIGaX9d3udxjvQfPmQ+3SQBPkQ4aRSVWyZGMmmvfo7UIbXdhtMFsAJUFcq9FR8nehqeYAgqdJTs4jQkKoSv+9Xiv3rtPL2yr4TD7r7PPDpNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323301; c=relaxed/simple;
	bh=/9tb9gt0KA4BRJXoc9Ed3xC/SdSE0QL8AyQuP/0v+2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeQ+Xei2xHQfCz9wluOotFhcj1vxcWXruhpu2vGD+WsDwAl5nwcbWwbgJO4pEyDoLUScmR4a+nuBsy5WJNqZTBQ72s5LRkjzj1fCKxIZn6uu7u8/u+pYTYyQmsRbr3KWSaMFy7EYvMvC80NXhayf9Cz4UpaiaRaQQ7acDDqcszY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WKSX4piz; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyhpglVBqk8ShowMkjRgYY810ElG/bb387gkFsLhhu9x0tw3SQYGWm9be1+qhmWBluFw6j8CZLMn0nNzgBhOtef2eHVxgF6vgbdmgt1PPwrqbHvYjIOMRouGKQH/2pYJhs09BlPjhS0IRgd6V4jMTa1EJL6cNASpoNIUZv5Wiej7gW8RK2yk3CCFU4ULGe1aiioTUIQN+t/Tob4ycC5Pp9IqbkGVwXajLBDxuN8An1DAfcTSeJdw7PqBEAZ51VpddsB1zznag653hqY9ST3WUGHfYzCRV36GjwpLBFoOx8QFJm+PBvxdv4DMMQWqPZB1M8J0t7wPQ+PVWfrg7bPG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6yN430vh7S5PHAOkeoyWCgCIsl19fuK/6lFsNI0Kp4=;
 b=MgyadJZ7Cc8BA0mHh2KUkPYAF1+yffu4oaf9188Tvwr4keSV6y20jE40H+JBAHWRPghTn3o8Us2bXKrJKDEnU47tXpAcbjuPEcAv/wPXZgBbmONrl9K9W+FLeSMLIss1eMHSQ/SbuZ1pQ8r4Fd+i/wAcK64XtGbSxPjSa2Q5WyEi8XTMoBACHV+bSvhp1wD6jCfk1P7zL4puAoE6fovSMnozjlNlHXIZhmYNp8puSP8UHguQYCu3qKLZY1wdXAxP0r0sNgkAqb4YW7N/7tZqgOy9GvFn0MtfboAzo21AhCILcY0ARSdlJxLLTmRXVIFXYdU6mWiAww9l/ZCKAyT7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6yN430vh7S5PHAOkeoyWCgCIsl19fuK/6lFsNI0Kp4=;
 b=WKSX4piz/oW7Dcw/IhVqiPIQ85MJJeXfDTWXnaHlK62UZ0yEXkUMVlqqude02dkg6Iw5OH6BKH3vlgD7OgwlQr2tkjaBsMlizsqVwe07WVTr0OyIWyS1rUiCxyhZt3taM6xXE8gwOqbqXouWZ3+dXV9aKuRnCoZCqnKvE5U1GjozXC9551JXDxJjVVmmSOdiyWlKQLzHtnj1wCtvZ9eu4aVbwd1Dvb6I46/pPfWXK5jKxb42fFHlcXfQToFrQr4/2TTUm6VXhWnqYn2MCN2HyNv+32Cm27T9+y5VK7XykOQzpaN8HGXzMBrRrtnMJNBXyWPIV+kjf5KfAH8sJBOAiw==
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Tue, 25 Jun
 2024 13:48:16 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a2) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Tue, 25 Jun 2024 13:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 13:48:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 06:48:00 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 06:47:56 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/2] mlxsw: pci: Store number of scatter/gather entries for maximum packet size
Date: Tue, 25 Jun 2024 15:47:34 +0200
Message-ID: <98c3e3adb7e727e571ac538faf67cef262cec4fc.1719321422.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719321422.git.petrm@nvidia.com>
References: <cover.1719321422.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: dc59554f-2625-4a11-02de-08dc951d771a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y/a6YB6u7tGW6KQo6o4aMSJazK9iS2Ch8I10SQXK1pus4UkZ/BSzAn/fWxD3?=
 =?us-ascii?Q?iGBDWLVpApuJamf2F/EuGIU5bDZ4Ts8eZGem9EuNBP7gHAabWero5z1tH5fI?=
 =?us-ascii?Q?z+3PnXGGU9PVFst6elt0hiico34ZIAYGP+ax/aVuLMAsF20dMV1fsU3kUhJG?=
 =?us-ascii?Q?a6o7OWbAjSqjnywgJtZXDq3hQn1gP133U1US3VSKhDE6aUUuvanJmdpu3X+F?=
 =?us-ascii?Q?dWwV2I4pROGRwxClvHWfs6/J9vDxbfTD5KGSNesNe5THO9cQTnL/iy9pRTll?=
 =?us-ascii?Q?QM2ai7KN6TEk/pr+cbDjiS+GwWvly5cQ9RpfQbfIg1XhNPKUFCEcFRShMJqr?=
 =?us-ascii?Q?EP7KyyHKtBHaMw5xNhbwIbhE4SgVhnW32Wbgz6f/iphuf8J2U1Yva9edCiPO?=
 =?us-ascii?Q?zwHYPaU6o9Ptp6Z4HRVjgdjmiGuGmYFmiMbrAH3U5T3u/P0R6P3cGTmC6fnw?=
 =?us-ascii?Q?1cySOb7uLntJeUhy6wYhIxWABAD1/lC0KIZwr3CzZBkxL99bhlURCtp5gXiy?=
 =?us-ascii?Q?SRwYORiRRt5fKMjAxj/clQIUCM58npYLUYm3fqHeB7Jbixz1Ow3XJE7eTjd2?=
 =?us-ascii?Q?uehDKxRejCRqieJEEOnc6CjDj7/SGrLQDM9Mn14NYNll+Eki34g5ZYdD5k4v?=
 =?us-ascii?Q?YILpr3UDhM/o3IkaQs3yjoLQJO5A1SLQgSC8/dHMeL8qBw5AdVbdYq4UPts6?=
 =?us-ascii?Q?s6LhL3Rfgl0OMTN6rIz/l2vjxHq02/AECVH2nGAwYFNIdb9aUjaaeMN44+ON?=
 =?us-ascii?Q?tDPXgSrlw4fRQujWwAI7azyDVD95iO2+rZpx0UXZ8GWUtfDM7vRYK+zQOhG/?=
 =?us-ascii?Q?CuiCzGvn6gQmOvK2UdRVN8mIRb5ou/ppG9VvkjqahoNXjctEBmDWqGyOMXjQ?=
 =?us-ascii?Q?NPcp1tUNvWO/ISwv/rGCIQ/B3DxhYJPDoG35Xu5jMpn769Q8yqsOcQEo1VIm?=
 =?us-ascii?Q?wrqGnYUMUCKC/D3P8CM+CjQCJ37ILVbrauxtfLJZPE7D8yFeoxiXnLwMcB52?=
 =?us-ascii?Q?1Uz3CCvS/wglWLVaIfM9+H10EdsDO9dygfwlUgrbzXhr4U77VJ5FfaUqx2z9?=
 =?us-ascii?Q?acSGSng1YybdH1R4h08a14/zMqiMSnPpXV9g0KaliTYQxY4BNr1ct3UYyUXM?=
 =?us-ascii?Q?UvS1Fskv+8CJ9kvIMCb61WvRLh/PNuq99H/0dTDj2zqXGvQkf5m9xJ0wYyU5?=
 =?us-ascii?Q?lmjvG/A2v3DP3tgzbxRpa9QoPNlMRQJEPaiNIp/FlGDFt1PLyYSjWsIpg5k2?=
 =?us-ascii?Q?Vnns1Kaf9EZB77kv7b9n4GFwuc8v07k8FY4mBMzdHpki39ziHHF5csEk9WLp?=
 =?us-ascii?Q?DIJ1Qmm3UIzaEC8wXk6wy0bshdcg0q3xE+dc4QVHT7imVozxcuaaeCon+dTK?=
 =?us-ascii?Q?467eO6joklqzlnTz3dngQaC+RZLFA7YxXJY69j+xqGVkLL00tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:48:16.2988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc59554f-2625-4a11-02de-08dc951d771a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

From: Amit Cohen <amcohen@nvidia.com>

A previous patch-set used page pool for Rx buffers allocations. To
simplify the change, we first used page pool for one allocation per
packet - one continuous buffer is allocated for each packet. This can be
improved by using fragmented buffers, then memory consumption will be
significantly reduced.

WQE (Work Queue Element) includes up to 3 scatter/gather entries for
data. As preparation for fragmented buffer usage, calculate number of
scatter/gather entries which are required for packet according to
maximum MTU and store it for future use. For now use PAGE_SIZE for each
entry, which means that maximum buffer size is 3 * PAGE_SIZE. This is
enough for the maximum MTU which is supported in the driver now (10K).
Warn in an unlikely case of maximum MTU which requires more than 3 pages,
for now this warn should not happen with standard page size (>=4K) and
maximum MTU (10K).

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 2fe29dba8751..0492013aca18 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -111,6 +111,7 @@ struct mlxsw_pci {
 	bool cff_support;
 	enum mlxsw_cmd_mbox_config_profile_lag_mode lag_mode;
 	enum mlxsw_cmd_mbox_config_profile_flood_mode flood_mode;
+	u8 num_sg_entries; /* Number of scatter/gather entries for packets. */
 	struct mlxsw_pci_queue_type_group queues[MLXSW_PCI_QUEUE_TYPE_COUNT];
 	u32 doorbell_offset;
 	struct mlxsw_core *core;
@@ -427,6 +428,12 @@ static void mlxsw_pci_rdq_page_free(struct mlxsw_pci_queue *q,
 	page_pool_put_page(cq->u.cq.page_pool, elem_info->page, -1, false);
 }
 
+static u8 mlxsw_pci_num_sg_entries_get(u16 byte_count)
+{
+	return DIV_ROUND_UP(byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD,
+			    PAGE_SIZE);
+}
+
 static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 			      struct mlxsw_pci_queue *q)
 {
@@ -1786,6 +1793,17 @@ static void mlxsw_pci_free_irq_vectors(struct mlxsw_pci *mlxsw_pci)
 	pci_free_irq_vectors(mlxsw_pci->pdev);
 }
 
+static void mlxsw_pci_num_sg_entries_set(struct mlxsw_pci *mlxsw_pci)
+{
+	u8 num_sg_entries;
+
+	num_sg_entries = mlxsw_pci_num_sg_entries_get(MLXSW_PORT_MAX_MTU);
+	mlxsw_pci->num_sg_entries = min(num_sg_entries,
+					MLXSW_PCI_WQE_SG_ENTRIES);
+
+	WARN_ON(num_sg_entries > MLXSW_PCI_WQE_SG_ENTRIES);
+}
+
 static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 			  const struct mlxsw_config_profile *profile,
 			  struct mlxsw_res *res)
@@ -1908,6 +1926,8 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	if (err)
 		goto err_requery_resources;
 
+	mlxsw_pci_num_sg_entries_set(mlxsw_pci);
+
 	err = mlxsw_pci_napi_devs_init(mlxsw_pci);
 	if (err)
 		goto err_napi_devs_init;
-- 
2.45.0


