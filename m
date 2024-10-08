Return-Path: <netdev+bounces-133273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AECB9956AC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE51C23534
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6521503B;
	Tue,  8 Oct 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZBA5mNMH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898C212D17
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412441; cv=fail; b=hPkYwCDlVTq2tcangaXJdyyO+m931dh+VG+NnWJAweuekmejlkSB8flj9vQnmWAzG9pb0yQAVbOF8kJaKn5Q0HLWRC3DMLUoAY57tOo7L+p2Ih8AbuuxR4cVSi5HlNQKRX8lh1KcjOlq8ia9uhr0wKvVReHqTWCkBSbFwrvFX5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412441; c=relaxed/simple;
	bh=kbkJOv++vTX2mCVHEaPPN3aq41wADSV0LRsAN8EYpbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcTH+GnzkgO/WHzYllEwYOGmYcegwstCAhYI4MWkNWLhEH2H5awawFkNjG7g60P5VlqGjsykg0RgVr6Ydpl+ZgTb2OXB+tGPepIxiCcbjLnrHyRhLF5p2lhOwQfcD0iThibyzPNsEtb2+yCJXsWwz/NX8sZjpu+ZXIWF+NuTugw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZBA5mNMH; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6I40MPlbBvo0cA1SlaKbbiZqHsvBXqhXUN2/Aqjk4inWGPaermMoW8zTuxwMthxbsqfKjbXiY/EcCCVpFc/LgHrWfj8xQHmuZ8mgAACar6psC21Cq8Rj+ZWwFEApuJafYfemHvrF0WYT+nNZyLhSEclkVEVFUXAEsJN+ce+Uu7LhiPPUyWvKAB1jw3280tA39IJhi2n5FDLzCPbBwA9YF2pKlbCTP70H7vMyzI4yqlRx50JzCipxkavxRpI/2EK1DTbbiHcBsrwgw02eB8ZwJx7QYT5CeG8/fPqs4PsjI4t0upfRwHQKUDxy88G6kbPR//UNqGRI+9NzOw1W/mgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA2bEXaWtJGPc4jKsovtrtOPcHUWBPydYKHHCP2fZ3U=;
 b=QqSW2i1R1b7BW5ABq+GF8ptUudpbHYuJaAcHe6ulleeU7pfKftM03L71BKKiRIJe4Pu7emtm0ls1y1r/jbPvEbOADsy+C2qwd+h9W8+g2/YZVfLCPTWJ8KCBMIbuB17gG+obnrrBJcclGCEiMjnq6fBINJksYRxGk4/VnVeaXEMj8NQk/XcoQ7VgFoJKekOZfQyrlR8G5Dqk5AXDfZxlDJTK/AKhz0ynl4lFydh5BWoZw44+uyOcx0H0yvWC8ThoYfyuVM0p0f1p1HZBj9WfZdwaG2MmTMvxZ35WmcIlT877qQXu56zm2XoCv991Om4APsedndq5leHG0prA96yIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA2bEXaWtJGPc4jKsovtrtOPcHUWBPydYKHHCP2fZ3U=;
 b=ZBA5mNMHuZJzbON6XCR0WCsWuX00KZcgR5/H1I0dgDuzKBAuCE85JNIwHhD7FgB4W6HjZ4khZlDPL408cAmbH6N6XICu9BD/jElmWbg+LJe/Mk5p0/AECVzfUMjucagJq20m3kHz48Nta/kkZXhcpjorxMMypj8xI1lS3aO/UgBxD8RagtMW4a7QjFlooGDgESCnqqA6GGU9lbQ+ZlU7As8Be8h687JnLC5FYwbk/qQWzOG0IHt1rgEAavBu2rYnJ1MVq20N40mZDiQRf2X7eTKKYt/aG4cRqqj9JMbmZSCJetuVnHr9qPCZFMi6mPZ6UW0R2eOeRJ46jfzHCLqSbA==
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 18:33:56 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::75) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 14/14] net/mlx5: Add support check for TSAR types in QoS scheduling
Date: Tue, 8 Oct 2024 21:32:22 +0300
Message-ID: <20241008183222.137702-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241008183222.137702-1-tariqt@nvidia.com>
References: <20241008183222.137702-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 65efe0d1-94bb-4045-a1bf-08dce7c7c461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2FFhb2Ov0bTTni1Lh6TQas1cBBTCTV5xQgzaJYTd+YapOBQorrYVhZD8iYUp?=
 =?us-ascii?Q?OgQ2gyvMSXovVZGZKmpTg4CpCumIBTWn9UyQwx/aXcCqnnMrthh9K124NNJ8?=
 =?us-ascii?Q?1gyr4u6//3djOBWcFSwEtl2NxqW+0eksoLGz7tSCcPY8n1hR5bNZ6k6Ia8Y6?=
 =?us-ascii?Q?lxOPd1rPCdIWphm59/3xbRkixeImC/02UqSFlZ6EbBLTt+O2tZUC1x4pMfRk?=
 =?us-ascii?Q?2arcRANu+wepqaIDVduotN6GI1dUdV/lvodFzUSDIg4OZC/yLUrlmgFlL/Si?=
 =?us-ascii?Q?Xj0Wwnj3OxYZIpbZEGjq60rDJPPFi6qSvZHnJa82Yw0gEGTUNrjsONVH0Jth?=
 =?us-ascii?Q?b990WtXuLxVCpJWSWTOTFWOA8+UH2xpgQI4NUQ86NHYlY+ed0SIe74WuXk21?=
 =?us-ascii?Q?L6Kg2B8B0zyZ21z7BB+uG9JjVctSZwzvAh6/ZjZaEifvddFrk4Bpw56pYyt7?=
 =?us-ascii?Q?nBnhePXGX9S7fQduetQuk72uWXYpHvopgIDd0H1b8Kh9lqF1GzSkbiuob0qA?=
 =?us-ascii?Q?j0E1QOyumRUz4ANJ5xpvI2BnUqJaonb3hgQvcmAaWEa4OJUvf3gGxw+N7+s3?=
 =?us-ascii?Q?dwDmDU4ueK15ffMGwJT92MYhdb8nQEEfSTytQafIQ+ZM/DVRPjC2gD/yYn6l?=
 =?us-ascii?Q?eGQdbi0TE+zVm9T1JED5cLSxqrOMDMVBcMuGN1AHP4DInW6dhHJl2d71qV/k?=
 =?us-ascii?Q?32zKOo2+O4+1xtu7G6OGteaG/1zgRhKhx58iEBdpk0fVvmYfIfm/080ns+uc?=
 =?us-ascii?Q?KUCZoTq0Zu82kqP7slqZDboqr9+PxoY63i0XiWKh2qDH/WfnadbePFUH1F/9?=
 =?us-ascii?Q?WaaBKpjayXVbXkUdKvImxFEuZ9RMO8J2Dn179ljKTwdDcjoydB0o6n4qr6Gq?=
 =?us-ascii?Q?AeRy/vxaGPEy3GPGQdzmRyhHwFZ9AWJwoqLm73u85f/TpLetouDIGj19Oy7k?=
 =?us-ascii?Q?kryyIOxgNgplaRGi/ViNweWXENABaH9J23vU913FAGqlxJBYeFs78qYChPgE?=
 =?us-ascii?Q?CtZnjZrxNypPKCMQVFLhB6+RyzDuPZIGdkqkY7TNqmO0MNidcLYJk/lgY+e7?=
 =?us-ascii?Q?xUi/ANCl8UBsy+Fce5UVLc7nJWoOKu/xfW9MBt5iGZhPcU7vtmhd6dh9/6P1?=
 =?us-ascii?Q?9VVo3EH8XusT1sMBh1gvINCzsb5K1EzJkuC6lFexkls88Nf6TBQgYWaSi5kC?=
 =?us-ascii?Q?WO+QPxAerpBXbYEEPzZfxJfNZzkCrayYNWj6fS/XNvFB9znZCIvFon/SSb2s?=
 =?us-ascii?Q?27NtZErrp2s0I8YbNTmPzowD1B1kl1MDkLw29c329uwJDi9/h84rn4jOakMO?=
 =?us-ascii?Q?qXgVFhfqwMCI3QVOv5sJx0YIBPG3SRL+HpcO3Sqi60xGa4FL2uVYIj9RHZWU?=
 =?us-ascii?Q?g7amcuNPns2j5mfmfSgQRNPakhSB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:55.7602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65efe0d1-94bb-4045-a1bf-08dce7c7c461
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779

From: Carolina Jubran <cjubran@nvidia.com>

Introduce a new function, mlx5_qos_tsar_type_supported(), to handle the
validation of TSAR types within QoS scheduling contexts.

Refactor the existing code to use this new function, replacing direct
checks for TSAR type support in the NIC scheduling hierarchy.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  4 ++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/qos.c |  4 ++-
 drivers/net/ethernet/mellanox/mlx5/core/rl.c  | 27 +++++++++++++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index ea68d86ea6ea..ee6f76a6f0b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -602,7 +602,9 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!mlx5_qos_element_type_supported(dev,
 					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
 					     SCHEDULING_HIERARCHY_E_SWITCH) ||
-	    !(MLX5_CAP_QOS(dev, esw_tsar_type) & TSAR_TYPE_CAP_MASK_DWRR))
+	    !mlx5_qos_tsar_type_supported(dev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_E_SWITCH))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(scheduling_context, tsar_ctx, element_type,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 5bb62051adc2..99de67c3aa74 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -225,6 +225,7 @@ int mlx5_core_sriov_set_msix_vec_count(struct pci_dev *vf, int msix_vec_count);
 int mlx5_core_enable_hca(struct mlx5_core_dev *dev, u16 func_id);
 int mlx5_core_disable_hca(struct mlx5_core_dev *dev, u16 func_id);
 bool mlx5_qos_element_type_supported(struct mlx5_core_dev *dev, int type, u8 hierarchy);
+bool mlx5_qos_tsar_type_supported(struct mlx5_core_dev *dev, int type, u8 hierarchy);
 int mlx5_create_scheduling_element_cmd(struct mlx5_core_dev *dev, u8 hierarchy,
 				       void *context, u32 *element_id);
 int mlx5_modify_scheduling_element_cmd(struct mlx5_core_dev *dev, u8 hierarchy,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/qos.c
index 4d353da3eb7b..6be9981bb6b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/qos.c
@@ -52,7 +52,9 @@ int mlx5_qos_create_inner_node(struct mlx5_core_dev *mdev, u32 parent_id,
 	if (!mlx5_qos_element_type_supported(mdev,
 					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
 					     SCHEDULING_HIERARCHY_NIC) ||
-	    !(MLX5_CAP_QOS(mdev, nic_tsar_type) & TSAR_TYPE_CAP_MASK_DWRR))
+	    !mlx5_qos_tsar_type_supported(mdev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_NIC))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent_id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rl.c b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
index efadd575fb35..e393391966e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
@@ -34,6 +34,33 @@
 #include <linux/mlx5/driver.h>
 #include "mlx5_core.h"
 
+bool mlx5_qos_tsar_type_supported(struct mlx5_core_dev *dev, int type, u8 hierarchy)
+{
+	int cap;
+
+	switch (hierarchy) {
+	case SCHEDULING_HIERARCHY_E_SWITCH:
+		cap =  MLX5_CAP_QOS(dev, esw_tsar_type);
+		break;
+	case SCHEDULING_HIERARCHY_NIC:
+		cap = MLX5_CAP_QOS(dev, nic_tsar_type);
+		break;
+	default:
+		return false;
+	}
+
+	switch (type) {
+	case TSAR_ELEMENT_TSAR_TYPE_DWRR:
+		return cap & TSAR_TYPE_CAP_MASK_DWRR;
+	case TSAR_ELEMENT_TSAR_TYPE_ROUND_ROBIN:
+		return cap & TSAR_TYPE_CAP_MASK_ROUND_ROBIN;
+	case TSAR_ELEMENT_TSAR_TYPE_ETS:
+		return cap & TSAR_TYPE_CAP_MASK_ETS;
+	}
+
+	return false;
+}
+
 bool mlx5_qos_element_type_supported(struct mlx5_core_dev *dev, int type, u8 hierarchy)
 {
 	int cap;
-- 
2.44.0


