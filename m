Return-Path: <netdev+bounces-217319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3359BB38534
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999889807AD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314B20C00E;
	Wed, 27 Aug 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K20mFCT8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0B21884B;
	Wed, 27 Aug 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305702; cv=fail; b=qnKHzifA9H4H+eWAPbrCihd5pXd93DXs/DdSPJH1qDXI0mlum/KtGQU34oWUAKD545+rC+7oP4JVQUHsIrqpHYu2eNYlXQUGQbzq4VXuED3ZHoKk7RL2zcGAohk+GwbbC7Yww4qgH2gg5PlausOPQPJcop1UNHZ89tRNxFGGoy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305702; c=relaxed/simple;
	bh=gpVqEzM++iS+MCO7hMUyBrxhvGL8NPDTqRk3GwvPDos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXCzfHsHkyNZIlhymss8i3mkg8K+4JmggGjwBHcbaJr0NPltA3pVIkP421KFfb+ld1KzldBL3/DdHzNoZC70i+P45m2Ol2AWw4zjSTubuRZE5plvnsNIvmpDJa6bd6yV28DhsehsEQocZFiqVXSvZxPWh1bupTRdApTH45w8r58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K20mFCT8; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNUPH0DwXZnI0osQcpZojyfR2Srt7ZLrPn2XsNWmxqYb22l+ry1CYaBvfPeA8h2bDW41nxiGgkZuxF/zGdJXFwRoLQ7ZoLAJ+s+0m6LFgK9vaDKzLH2r4JlIyapH5a/2SuVTiys0IlVWjgpK+KICkNOUu6fwxBH6NuZkZWFQqaoPRFEQ1ZKZcF/3S6pcCyh46A6bXzeTKyo8btXYdktSggr6qM/DBB22c9TA1Ob8VYOPyEI4eBAjWy6P2Y5dXBpm7YWEan4Z6rSq5AL12T/zsbUS8Qie72LYwq5Igi8P15S2cUikBL8LAcyZ1V4QKxaS3W8hgMp7cN0Jr0fLaxlw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usXVVuUSvWBL2seaykd7c125tV+xIT4bq0Rjg4o05CU=;
 b=TYXDX8mfN75hXVYoLzRujp3T5TWMp1KokjRxQ5R2i9d8cLX3SSrTGHlr2LJKA1kwKzo+njM1523Kh6kag+qM1qhG6uPPz8zRO4MTjZHWP3bRHM3o2zGHa3WwxV/BlupV9iQS7HKVA7kLKw+Mpp3bJXQGf9WqcIsr95cW20gKvXfZnQVzbvXTNP7A34owUh/+gphjp+blxcy4+7KPkOpACACUARVnAoFF7m7QvgSkBiWSY9eCk2IvINyifiVjIZqLCG3YIuOhgy0v2HTI920E+dSCpGXI0Sd/QoEmGN6Pg9vC8ZqT52EAg/PELQN53nwKaiYHmtGim+ru2d//mPFNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usXVVuUSvWBL2seaykd7c125tV+xIT4bq0Rjg4o05CU=;
 b=K20mFCT8tLhn5kpqJUTEE2fudm2X4grTVVeaIW6mR6piw1tTv+qOaPJ9YdtsIsCQObYHVXIwEQOFW6fhjrCz1baNlavp/MvuZnMl5aP3wSSHDApuOqjEOkT4XlZyQl3nv1yVGuPDbx6jgO1sYABhILzfdsmBwat0UWdH+qLJsSAvZ2q3/JwokFk7eQqp7gw4LMiYqkOrR0ICZFiPxfDpAVA/isoKR9aeACGphbCRI/xYO1Uwgq4z93ZWzkrzpYCCVbYoNMKjUazEoNl+oi6z3NfI1Ibri/tdFqyPkMoJ+IlnM5ClanhWdD3VQgKdMjBDARArojW/efNvq7Iod124KQ==
Received: from BN9PR03CA0924.namprd03.prod.outlook.com (2603:10b6:408:107::29)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 14:41:36 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::1) by BN9PR03CA0924.outlook.office365.com
 (2603:10b6:408:107::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 14:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 14:41:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:08 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 27
 Aug 2025 07:41:05 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 3/7] net: devmem: get netdev DMA device via new API
Date: Wed, 27 Aug 2025 17:39:57 +0300
Message-ID: <20250827144017.1529208-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827144017.1529208-2-dtatulea@nvidia.com>
References: <20250827144017.1529208-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: b365fceb-00d8-41e8-f610-08dde577d31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMHNSAmsyEqf0aNtkp5Gwr7ncrl5qcWdS21nogOXGP2gXwM0x8dgxV7QZEzp?=
 =?us-ascii?Q?E6Gl5MuJPXikhe7O+Dc8+vt1fOXK64KErmkHdUxrdz0fN7iaN/cDt/A8Md9W?=
 =?us-ascii?Q?hNwyR5aoiI7qQEExtbe/Y9aDzE7bi3sYSA3FKUxQKvSj0aeJ1d2dFgt/Kypa?=
 =?us-ascii?Q?B0vLRlJL37mFcqUbExt05FshH8x7gCMYcpxHahxmwj2L2uPVDguAFMR14J1e?=
 =?us-ascii?Q?G5FahIgSZnXgMtmsK3viKsXRia6fX6ulUuOGfEje4MloRUdnRldi7+2DypiT?=
 =?us-ascii?Q?5HXW4fa2NrWnc/cuDGFm8D9JLruEoI4JgPIwtVgzOQhUEP16BRLIOfDTTjX2?=
 =?us-ascii?Q?yFmRll3hinEHna166qZcMfVUJ8sGnLicWzQa6U1NDOWRt3xjoxMRPq+0+KBM?=
 =?us-ascii?Q?UZCQbvIuO6564/2ZL8hlAj4ZK5eMEeG07g40pTdKpUCUTDh8EpAa0TO1mS23?=
 =?us-ascii?Q?Omfuo+wFvYMYDOWB/R6u0k2peb/d4Laes4EBOCdT1VQZt41AFhS9VCKIrgMt?=
 =?us-ascii?Q?wQiZgEngjisoH0pqnoamrAAyRTEbxcqzr9qDoCFN6SXwuxhMUKuVn5FAjo4o?=
 =?us-ascii?Q?ijM1cat114VA/b7pz0YXWWP5NXdj4K55D2vCG1fYxXnpI7QMVtUtWpC+reeQ?=
 =?us-ascii?Q?YYT4pnAV25lHDtoNx1ixJCuA/xDFK10Fz836OBHgjGfK1U/tMhjJeaVPisyp?=
 =?us-ascii?Q?/0wJNsW5sgUa3g5vof5FsCHi6TgHRs9WxQr9X0cUliOLt0A4Ti32zrpowTto?=
 =?us-ascii?Q?VsFVEs06IQ0L8nSpYLJ5LFcHDvxtx2A+WwGyximvH1vcPfCBfr2PPub1cKNv?=
 =?us-ascii?Q?6qNpmC9PQjTvNC+4DX3rngaUgnJC+zYgsvdHvay6NZCLg8hvevQwAqvqS08C?=
 =?us-ascii?Q?gSrrcV2WRoFD9lWqlkuwlG/yg/za9vzF6KueErrQbq4Deso6MGcCy1CjQDpC?=
 =?us-ascii?Q?FAZ3odxbKDwwExNt7+BVIzDPHU2OzO05c5pSLnvwcVLx5Qm9NnK9KI4NlanI?=
 =?us-ascii?Q?tzvenlwwrOmezvAZ4aOspniMGfbjf5cQ3jwADhTaLUlZlaTllYqKpceKTbM2?=
 =?us-ascii?Q?OWTaIi87BhQ5GUchw1qV2n9THSLWCyT3ozYkM8NHHYAp8qrXNTINRh8QBUve?=
 =?us-ascii?Q?2zKt4zgv5j/lde48X5mT182qYBQcNRdgxIO0KFznpSejyw3ZEkFNN1gBHr75?=
 =?us-ascii?Q?67q95YHlzIYwnLzsRPzVSZyh5n7RqcydsQD/CCKvrThx+YYYbj5bJxFOGASw?=
 =?us-ascii?Q?H79Lthe+bKJhwWzi1OAyNYgIUz6xi1YK/5gJE4u1OdrQL4YOi0lgCBLqDFtB?=
 =?us-ascii?Q?0xqVIiExYAEPnR7Gw9gn0QReVM6GOHmt0e56Hdb4nc9yQ/P1mUpp6fbT4DkN?=
 =?us-ascii?Q?up7sZM3/05fZgCF48tkqY8aG1QpzOjwb4KUXXDAi/S21DBTyN+0pKo7cAQfk?=
 =?us-ascii?Q?3VwlUm6C4qys/q3ISbZCyXeQ+2ynIntSmQwhZ8cv2o6M/JgXlY6rWoCT1gD3?=
 =?us-ascii?Q?xN7pFm5VCSfssLpapFgC87ORGcU61wSSlcOq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:41:36.0049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b365fceb-00d8-41e8-f610-08dde577d31e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

Switch to the new API for fetching DMA devices for a netdev. The API is
called with queue index 0 for now which is equivalent with the previous
behavior.

This patch will allow devmem to work with devices where the DMA device
is not stored in the parent device. mlx5 SFs are an example of such a
device.

Multi-PF netdevs are still problematic (as they were before this
change). Upcoming patches will address this for the rx binding.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 24c591ab38ae..c58b24128727 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -182,6 +182,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
+	struct device *dma_dev;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
@@ -192,6 +193,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	if (IS_ERR(dmabuf))
 		return ERR_CAST(dmabuf);
 
+	dma_dev = netdev_queue_get_dma_dev(dev, 0);
+	if (!dma_dev) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(extack, "Device doesn't support DMA");
+		goto err_put_dmabuf;
+	}
+
 	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
 			       dev_to_node(&dev->dev));
 	if (!binding) {
@@ -209,7 +217,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	binding->dmabuf = dmabuf;
 	binding->direction = direction;
 
-	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
+	binding->attachment = dma_buf_attach(binding->dmabuf, dma_dev);
 	if (IS_ERR(binding->attachment)) {
 		err = PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
-- 
2.50.1


