Return-Path: <netdev+bounces-95776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62E8C368F
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394251F21FF6
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D322F11;
	Sun, 12 May 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqHfky++"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14797210E4
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517864; cv=fail; b=JqbBKId6ps4Z5ghF7i68r/HwyuXuRWyUmuRWP3Vr2Db/qazBg5kPqp1U5aHH5fsX0MuqHI1B09edwYi9dAxJ6d+i7wAUjPuMcRILX7UswcQ+UZN0Ot7RsnCv5Xj48lUgMIJdMo920193GoLTv9dToapWLQGe+hvSqhZmBW9du4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517864; c=relaxed/simple;
	bh=TFERUrNfxYw4QOpF3RQhVxsU8u0jmsxSNyQ89/UpQkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/3I87uOcSsmKQOK0ovGKSJZ4cg9uIYt5JWi1ag6dLzTcB5mIradQrG7/BGqz5vrPELhxz574CiW4e0GQxoUyflorgjUlVNStqK73Bv9/2aoAYue8bLXt1hfnbzCszlsYexib3D5nchmvsfJsw0TiZAb5mcy7fzbTjvChs+Hcl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqHfky++; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ5Nz2tTF4jmZPHkaxC2GNeW3k8hOudYXDeYF2xXIsWWkOiAw9EnoNap0fCJUG8wnMHmnemXShZQnZ9BciXoAfVVrXmCShiQ9u3/kTeQoJa49sFVnrPDriGWHbpaTKe4SO/9MB/zZbib2da3CRhI38Ss5jGRuPZIAdf/e7vQGRcaAGdHuG3KUX8x8g4r1fZVSqoj53J4wVFh6fILvY2eiYap8eU7D/z8LdEkVhklpsBtmriWSnVF2O2uYhgBCaQxmVhXkGU5tsmPj2JNWWJiVhZb1d1sEN4eD8TV557HVsVyVVYY7kj2A1CTfJJuoJMQ06lAsqqj4TAyurte7IUqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsvUSIy2Z3WeHJ06/RCiWPn0gOYePaVBONPuYoc/FmY=;
 b=ADug76hSOR1okLFVal7LmW9jbRnu+VKzQ02cZti0uStZ93qyT/T4I3Rd1dS//tOEQne9muuIAEyV/iYTcV+OGk0LuzR7Qjy30ciof0AjFcxcQ8HsT1XB5rvUY4Af/xIdGkwYgrQgquMoIccTS8jKFaJqoFDg49tgkz5/bCfL4f/bZj7aeAUXhiFtw95JWAUO14EPwP6UY4hZFF6uz+XZDA6A5J4B9rYPilj1zBgYS1oO0hyTlGvZHDteY1zeRuxiQn3Q1ckxfffEyROlM8w99rxbk8VEw2lktmQPfy4XTo0Cmrsm25GOp/QFh6xqdsLaoh8ud+q1OFwEkGSnK7FURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsvUSIy2Z3WeHJ06/RCiWPn0gOYePaVBONPuYoc/FmY=;
 b=mqHfky++seNo7sRozPM9v9E+TqgjsF10uzDhHIFw2fEBV9xoWV8uFnLR7U8qhx3rzelwCEj2UBFnMw+ZKY0wDTMwpXbyrSg7aCjry46P8yUQFkF74aXkneH+590MeccXiMQWR/4cnZSArajAnc0mbYGyP91yEMW+WdEThM7iDg6eub87L2XC1dbO7buxl5p6K7jvCbAGHTY3iBr7DkPvZlQUizB9L33LSQuk+eDPZs20CVSd/HhXYaAwv5StlXaxghTjyPwyrb+S9D8CorBckf85BvoU+E0s/YpuQ6OvQ1Ug3Do5uQ3LtaVU6v0/Nc+IWDqbixDT6s25hi3tGOESyw==
Received: from PR2P264CA0029.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::17) by
 MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 12:44:19 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10a6:101:1:cafe::c4) by PR2P264CA0029.outlook.office365.com
 (2603:10a6:101:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Sun, 12 May 2024 12:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 12:44:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 05:43:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 05:43:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 12 May
 2024 05:43:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: Remove unused msix related exported APIs
Date: Sun, 12 May 2024 15:43:05 +0300
Message-ID: <20240512124306.740898-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240512124306.740898-1-tariqt@nvidia.com>
References: <20240512124306.740898-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2ff29f-4bf0-4ac4-c4a7-08dc72813cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CPc6r+o8iAuzfQRpkgDheQmKcmJsjS+fz2ooHXlx5EWAwmuE3965ZvwDHAwY?=
 =?us-ascii?Q?wmrjtC28i98o22K3FM17pXCOwyOYvr2e3c7rpz/fAhyLzgUauZgZGm4/DXqU?=
 =?us-ascii?Q?3+FixO1SUE7Gpq/qdVqgapcqZuL4ru6D4pru4Xdc3Biju22GXPym6vmHEP7z?=
 =?us-ascii?Q?/sV5QkvbEHMiwdUuW+2H9t95JeZt749UnPfBB8ZBlydMno4k9XnnDkfKZcbS?=
 =?us-ascii?Q?tHQkJ4Z7OSXtc1ZFr4s5Oow7ZfPK6/V1fyTk173Xc6RmklLLfoy1a4prdEVw?=
 =?us-ascii?Q?zHa0m5NbL0pB5BBGVEA1G6nQ1sgUa7faAtg99tgl8JoUX0WH24mvL3sQH7cs?=
 =?us-ascii?Q?PC2aMRtFsO/wiEcLJrkYpIeLIuoX6nqTRqCrV5FJmx89incVsJEGRoZJ6mQe?=
 =?us-ascii?Q?XZFDka7oSghWnBvjLif2zKA7P+X2WpRKRnMGN/051IKQzL/8pC+cmbNiIqJ3?=
 =?us-ascii?Q?Uvh7WsmAphqfwdXgXwC0opwNlvT0xyArUGAh6A34VNgRAdiHs4PEluI6+HW/?=
 =?us-ascii?Q?c0Zdq9sVeOO0jNkPyIQ21blXCXjbsB78F8BshDHxkxD4hE2udONClfFp+O99?=
 =?us-ascii?Q?75yAPqO14CNWhL0Gn8t3L6+Q36AoPy1/AY0NuitWwTaDrTVsr3QRuAQ9E9oW?=
 =?us-ascii?Q?FfdR89nDvhd3NBuDuED0U9qcAeuwR/YLoW/T25wjmRTnRbLmhJyWvrD1rjSa?=
 =?us-ascii?Q?wKhlKSNnXE8BUQnDBXH/86uWi3zDOMEYA+DluT43RIznfL10CzZe/iw9npav?=
 =?us-ascii?Q?bTFk2qV7hImH2Hgb7L5yNNh+ca0DjGJrTcj7xPLWItXZ/5+hwwxLNAfp7SAh?=
 =?us-ascii?Q?hpHgEc5y5eNX0bWX0T4Q7iZVrrAvr1yfrdDZqzxC+lkhk9HCS78nYmYK1ITe?=
 =?us-ascii?Q?RXlNhvr27fw+hggzxSZXba1KAxfZe9iNaMCq3OHaViE0UuNw/LgxoVTATFpr?=
 =?us-ascii?Q?scdKjImwze0LwHhpODHwQ+GCVuzuwtlC/el9yJQC6PK52IhosUDeme7E/sfF?=
 =?us-ascii?Q?cNYQAECupo6zWvaIhYpHd/9ElpbDsdMcXOohinX7v9XU89QnSEHO/oJt/9/B?=
 =?us-ascii?Q?J4Dh67yTWqPTLHnlwRNauJMS9kuLrMZHwsf8kSzVq9vfHGmx110Mp6zTwq7+?=
 =?us-ascii?Q?qGbzor0/johc4AW1nJtM5pT2gDH6q6ZxnqwAqAfZ9dQ5fyCRd6RupdAaX1tj?=
 =?us-ascii?Q?JEXbcK4BJyTA8zqR67ZuhWggYEPi3pNfGIHRT3BZU0VVJUMTc+KqTsaouD5N?=
 =?us-ascii?Q?7aces8NcPna80qvocEMxIGS84iv39e/3WgNWnXRnXhanEO7PN7TpeOhW8dIV?=
 =?us-ascii?Q?QpgHnaS4+jYTglN0JjDvDDUVWm10QHDCky0ueyW/JuBXdfxMHYoq9Hsnp6YN?=
 =?us-ascii?Q?31P9334PAsOW006GcSEMy6PQq6bA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 12:44:17.5523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2ff29f-4bf0-4ac4-c4a7-08dc72813cda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

From: Parav Pandit <parav@nvidia.com>

MSIX irq allocation and free APIs are no longer
in use. Hence, remove the dead code.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 52 -------------------
 include/linux/mlx5/driver.h                   |  7 ---
 2 files changed, 59 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 6bac8ad70ba6..fb8787e30d3f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -507,58 +507,6 @@ struct mlx5_irq *mlx5_irq_request(struct mlx5_core_dev *dev, u16 vecidx,
 	return irq;
 }
 
-/**
- * mlx5_msix_alloc - allocate msix interrupt
- * @dev: mlx5 device from which to request
- * @handler: interrupt handler
- * @affdesc: affinity descriptor
- * @name: interrupt name
- *
- * Returns: struct msi_map with result encoded.
- * Note: the caller must make sure to release the irq by calling
- *       mlx5_msix_free() if shutdown was initiated.
- */
-struct msi_map mlx5_msix_alloc(struct mlx5_core_dev *dev,
-			       irqreturn_t (*handler)(int, void *),
-			       const struct irq_affinity_desc *affdesc,
-			       const char *name)
-{
-	struct msi_map map;
-	int err;
-
-	if (!dev->pdev) {
-		map.virq = 0;
-		map.index = -EINVAL;
-		return map;
-	}
-
-	map = pci_msix_alloc_irq_at(dev->pdev, MSI_ANY_INDEX, affdesc);
-	if (!map.virq)
-		return map;
-
-	err = request_irq(map.virq, handler, 0, name, NULL);
-	if (err) {
-		mlx5_core_warn(dev, "err %d\n", err);
-		pci_msix_free_irq(dev->pdev, map);
-		map.virq = 0;
-		map.index = -ENOMEM;
-	}
-	return map;
-}
-EXPORT_SYMBOL(mlx5_msix_alloc);
-
-/**
- * mlx5_msix_free - free a previously allocated msix interrupt
- * @dev: mlx5 device associated with interrupt
- * @map: map previously returned by mlx5_msix_alloc()
- */
-void mlx5_msix_free(struct mlx5_core_dev *dev, struct msi_map map)
-{
-	free_irq(map.virq, NULL);
-	pci_msix_free_irq(dev->pdev, map);
-}
-EXPORT_SYMBOL(mlx5_msix_free);
-
 /**
  * mlx5_irq_release_vector - release one IRQ back to the system.
  * @irq: the irq to release.
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 8218588688b5..0aa15cac0308 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1374,11 +1374,4 @@ static inline bool mlx5_is_macsec_roce_supported(struct mlx5_core_dev *mdev)
 enum {
 	MLX5_OCTWORD = 16,
 };
-
-struct msi_map mlx5_msix_alloc(struct mlx5_core_dev *dev,
-			       irqreturn_t (*handler)(int, void *),
-			       const struct irq_affinity_desc *affdesc,
-			       const char *name);
-void mlx5_msix_free(struct mlx5_core_dev *dev, struct msi_map map);
-
 #endif /* MLX5_DRIVER_H */
-- 
2.44.0


