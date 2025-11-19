Return-Path: <netdev+bounces-240119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F0C70C2C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 008E62A294
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37A369239;
	Wed, 19 Nov 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b4IDHT3B"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF302F5322
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579768; cv=fail; b=Km109iJ6znufScl5yDqyMowYt8oHhn9AjI2d4E6Bo0lawyr2E+DKZz2d7NwtLJET57lQD3+BinNJalY4U5tNmEipH3pArG8SGdehTuU5s4673gw2j55LKjN0u34spPn44zvKIkpbR+QUNyyUQ0vvhqZf7Ai4s5nXJHtvj+/EDlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579768; c=relaxed/simple;
	bh=oREltwhNzwCC4QRJ/pZcucFj4u84HebNbu7VtsW/YiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+0jP68Pp35imGEzHhotAqFOVzSdHve/qriIaiEKq2d+L+sDizQn18BdQc53VZqM094ShJSSoARyILfufpvAnU2fZ3grr6TkAKDa8E9E/+tf24KdkAMofdVN2xYIIsiI3LkRxyQKwSrTMGhw4IO34N88jBKptLTpssli3QkW6D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b4IDHT3B; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk9GQUs6+EjGEw3hd5q17+ghNjoAJuCTKkeQkS7IiSIoFfUlXvs8flx4JK/pJgopDl6y0sehe3dfpHDaKTph9AhPFQw1ZFPtXJhocC8nz6JgpHtNB4YiH6e59ixibbk7axogRgQbIUsEAIfnNlopepE1L3dfIFpLLzupeDa99X9EgMdkTSNbs0Bnajh9FhC2sD+PeU19aBZDmCbMk3jQw+wvm+lEmcEXeMTEX/82R55MuFowprXPPTQLG3XG2a8jpKd99zSGKAEE3jpro4X5JT7Q7k7Vv5ZL2EYQTkjYlpPr9WqZXBRxLDZtVbbbS2eHa84SOhnYZ7ByDReSprKGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5bjZc6RVyPTcyL3qsIzy1qTGlI84zO9epp4ZOCa9OE=;
 b=YG8nBbTvu4oTQzU3dNOUsNPlW4OTnpyVdiOUFXJDm+0CcFArSJnczP3wf2MQRsEjQRTJSeTmEWl6+tmsqvltIeHYspkCfw5aNKTUUknbl6gB21a0jvcdFSpC5n6tG6Ov5QCJz15dMW+YZCaEnkJG0cntc/xDiWosiiLqU4fs8j4Nd+DJBK+vkcj4MqNBnoxAV8NNyWMHptkAP1b4TOmQNgF7guvRMp5SXrKPIT5VRph+CSNup8cMcX9/ppJuMP6UrzcnWZ6v3SpZKz38Fp7wiIf0zv74shpgtkhJz1vUTqfP0tATTeX112w5cQe0PwCPsYHQO6fyBMjZangZEX/aQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5bjZc6RVyPTcyL3qsIzy1qTGlI84zO9epp4ZOCa9OE=;
 b=b4IDHT3BArkVckNu7wVPMbBOzdHIBslvnPujQqO/k4eO/s5zGayfSeGIx+UcCEixwPr/EYYKO1xW6xUhA5sp9aWari/UqxzzxfP9urwbDwpp5/FnXFsMuuWmBZv75NNEXyzxaGn11kkYul5EdaN4Ub4/4GMq5BSMVUjhY7asVXtVxFsVBAC9k6EX9mpaEP0odas/uEB+CXCyb9IqGQEbwTuflk+iRp+x2yx2+JftRhSKRBaUFLhtaCP4L0RZx+tkSpdURv8HbSzuo7ZMmLmZc7c3Zp67J6VldCMRvflRGEkCyqJysh7yaEvs3k7yq3t3OH3rsJkqGaGwBNy1lyiv7w==
Received: from CH0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:610:b3::15)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:15:51 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::af) by CH0PR03CA0040.outlook.office365.com
 (2603:10b6:610:b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:15:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:32 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:31 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 02/12] virtio: Add config_op for admin commands
Date: Wed, 19 Nov 2025 13:15:13 -0600
Message-ID: <20251119191524.4572-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: e1724303-bc78-4e99-ab83-08de27a00dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a2b9DApYO0uRN04q4ZJ08yE7pA2wDz9K3d6VzbGMUrToGg4VzVEq8Zqt2+gn?=
 =?us-ascii?Q?PcBwwUK1QVWl0YJpqQeZpRQHiir9ZTMw4pMqMI8ipCfI+B0mWMx+oLZiTPvj?=
 =?us-ascii?Q?6Nxpud/lfhz9XQeFJmFllUhh72jBGir/Ah7nCSCw31s0FZ8FoviUvesaXsZI?=
 =?us-ascii?Q?jae3jWsIUfeqi0rlKdoGZyQlL44rEEKtOtLKO/cpEsU9pbKV/g0WmUGiPU3G?=
 =?us-ascii?Q?wbueoFinpwF57iJ23VAgfiApo07owzWrjTg0KUzdRCHu9FFUwW4SpHQHd+pG?=
 =?us-ascii?Q?LS6OYNHXLLHy1zMEmBOsocUhNufO7FC2dIej6aq6FGEkwQ7T6ZrJigUfA9tP?=
 =?us-ascii?Q?K+xJNMcX6ADrzqJdqH6jTDTTUxf6J/yMbIR+f/z8+i8bAhkKRD8P2FVmDTy3?=
 =?us-ascii?Q?Z7ZrqFYFYl3AOHNLjmqIrhpsQxsnn2DcI7IKaHU747gFMmZcAawuqY2WDLif?=
 =?us-ascii?Q?ZhZl7URXyoVGJNMCyL31EzCA2mqscwcqokdQ7TTD5mcEXD2YgICJVPypA/cg?=
 =?us-ascii?Q?94EfbnbwhgJpgFxBOkJd3gT1YPO7wcol/LjlWjDYv/+wnzMe017cZAAIBeFB?=
 =?us-ascii?Q?oRa77KVaWvhyJTnozqe0iTGVV55QmxRY1C7ZcEcSr3NFrgyst/zqVTUBJKUu?=
 =?us-ascii?Q?P9utId7QqbujVsYoOmhn3PhBUwmynBiDwCxPZ+1JLnvZStfiHMNhid2PJLnd?=
 =?us-ascii?Q?idEuxzugXs5kI5whYY0Dm+MQF72zeZV9PfQIkAkJSZVmt9VFQ7FoEhv8iI4O?=
 =?us-ascii?Q?MTyRxvJDdRIbTagc0Nqstwb9Pc8vlzsR+zHb/Sdkiv9s/TD1ZrEYfhjBdNzV?=
 =?us-ascii?Q?t3NuCNE2pkoR4Wikf2NhT96VgSjsHgOiEqHCfVVh8Au656V5CZvFNVUGo0Ws?=
 =?us-ascii?Q?UGgLUxv8bkEx9dkwI9tdGO5Jdy4K5BADl+t1Xef+f2sGxZmB/NF7hXIXx/QR?=
 =?us-ascii?Q?MGcyC7PUQzPaR7u6LfFrqAgFzHTJ1nHJS31r+Lalh7xe03rDmaX50FrOMYND?=
 =?us-ascii?Q?RfezjxeqAXA1hGaFUAUVCS5FNeRCXKOIWI6jrQHXhCwS7sZW4DNoig2Bz9rI?=
 =?us-ascii?Q?zhANwaJFEZxug9s/kF2qbiGCJkzXaFcSRcmUMiEtCaLUQjiJFH5w3KK5l/zC?=
 =?us-ascii?Q?jDq9Nie79KQZOxNz7IF/WvOFF5O0IBCK7QmkS7d+N16QJwcdjw7ye+iXln1P?=
 =?us-ascii?Q?woAU2vDFssw/LtxgB8qlYB7JaMGWmm7pk046BZtpCaSOPx4M/Zg1+1Lqc4uk?=
 =?us-ascii?Q?HchwIL7O5sgjMLnIUU8Q2gw2LOURcMHjo8Wo0l/o+45G+OBV4orDJMi8f1tM?=
 =?us-ascii?Q?fCZd/gUFIBys1KgD225AXdaAEpvn9BQjzBUBivLk7dhUijW5HxjIj2Y8eXqM?=
 =?us-ascii?Q?rEx/q6jkLf+B5QoI6YOpNADK9Y6RRXDTIapS0K/vsmHieV1hroD3xqo5tWB3?=
 =?us-ascii?Q?vaQtBbEcepRUaF5HBpPOhi5KqtwUt3PoVtGfquhLInhEnBszDi/5ajPG128S?=
 =?us-ascii?Q?rnrmtRQHs0DqJ7vp1pMKHIGluLrfrmWb+w6PgnvgyFCwC+6P1PqxOWUNW9RU?=
 =?us-ascii?Q?Pf0IVeIZmijHs/+nPvM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:15:51.0500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1724303-bc78-4e99-ab83-08de27a00dbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for v4

v12: Add (optional) to admin_cmd_exec field. MST
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 1675d6cda416..e2a813b3b3fd 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 /* the PCI probing function */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 16001e9f9b39..d620f46bcc07 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command (optional).
+ *	vdev: the virtio_device
+ *	cmd: the command to execute
+ *	Returns 0 on success or error status
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -137,6 +141,8 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	int (*admin_cmd_exec)(struct virtio_device *vdev,
+			      struct virtio_admin_cmd *cmd);
 };
 
 /**
-- 
2.50.1


