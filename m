Return-Path: <netdev+bounces-233267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89157C0FB65
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F93463E2C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA2A31691D;
	Mon, 27 Oct 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Adt9t0Bh"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19A1A5B8B
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586834; cv=fail; b=I3AUiKls3oNCyS7Uh0wvHRdMwSFAZeaCQE6onwEVEa/DRfFf3KODWx/VmBu1Yh3zzLyCe6/ozf+rUYvXvnKa52jFO+ArtyCR8ZzlRhB+hVs0sHtbmUQiy5mFyxH94tdIyLLhYwP9ygyd2MXDlIwgRglSIA5+FvZvNpYP8j27GfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586834; c=relaxed/simple;
	bh=RLF8OE4X6nY598EI4Hqm14JlqpB8DRKg6kV2yvQJ/DQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOe6mJSJqdFateKjZFlb9373hnK4dY7AZTDIPEgYJGGY1pdEWsWbqBz3Htm0BcrtQXf8BjVouF1HwzbMTTSlEIWcw2T2Y2T+wDeQcBA6zb5WH2mMxPJBSqFT0tmuGIWKVcT+Z4Ys8NvkWcMI4pqmxVD6j6Gc87RqKDADfOkJHvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Adt9t0Bh; arc=fail smtp.client-ip=52.101.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hszmx6ljDNagzQQixE0cEGz7OSb3L6TQ+VKPWvlgBqDHNP+RczgbqMhaDGFLFa2laRznRiG9L0xeCNfqEHnHssxThyjHtONBxGFcNtbWk0I0Ijb8rj1aA8MqfDr7tpYihAAK2aWJkyyn42uxJpc/QOfLIX3bnTwDa1dQC0uezqA+8Zsv4rwytyzirNX1Yc8mhOUTzlHbzhBap+S/wJ9GfIngYIaGO4n76GsCPCqmE76t8kJEGFWF9db6aFEft397pK0njHdLw5RVvQZ3S+DCRe8WMEKldUagSPx1soVSffFZlurvIEgLJV7kYuR0CeFwty4Wl1ruyv3AHSojsbG9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWrmXrH6+j1q8eKlxn0+TCznDGFH8Xg/Sn1vR2wcvBg=;
 b=d6eWVGZRMqHcl8n79Y+XqmKgf/ZzbH1WK0aipvKIAGYxJo4k9qklNmQXGVFznzbZRObePgwjkcLTH7/0fenew7Rk7DetVufHV/ZWVYmlAlzknUHyG1mB2m1At2JP0pDGHOsokLR6sKh0/f2Lds8+SMnzSG/Gouz0pIst5AikVACA/dEVBZQyPIIicHlrijLv62B7qDL0zwxoGOmrrZT3VC/o27XsMNvgUTctaxk6Rby8kIWfSYcPP2sMy4BEjelaXSS4IFhMn1G7E1Kpz065PJcq+b8tubCXSuVPCN5uGAdAX5JaqTNE56atu79cCzItOjUs6O7IWGEhPeIiS57bVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWrmXrH6+j1q8eKlxn0+TCznDGFH8Xg/Sn1vR2wcvBg=;
 b=Adt9t0Bhd0o7OeEdfcj02aSdpM4nuRwg0EK55/G15ifWp4nlsUUpCLQb0mbWXWKLcu9B19uau48xQ7yU5DXkcDqIfk0EmF9qE6bmbUhUtzfeqEGUzdlpp/nMNfx0LRdcIxfYhmPlR4aw+dkHnZ11BVZv3gNL7p0KXzJdxzA8N346mtFZpnNdtTlGvGlOQ+kfImR8NzUy0PRXI6YFSjiY/KPcYd1PHqU8cj/2brC3SFPP6zNxN/XZmx6TmHlOtOTEp7T7cjVELc+Q3ZKc+0kKqbI+iGxQp0M/TPr24u2zex+67WyeXeB+YK3YlT7+LRxYAM3ugtiZdODWNEcfMUGNLA==
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 17:40:29 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::77) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:40:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:07 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:06 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 02/12] virtio: Add config_op for admin commands
Date: Mon, 27 Oct 2025 12:39:47 -0500
Message-ID: <20251027173957.2334-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027173957.2334-1-danielj@nvidia.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 1800b061-d83a-458c-1096-08de157feb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4u2VuVBs3dwkbFCSdgE/Wm3IP6sH6qThD9ggv3VvWwBJzTQvv5bCjZ+Bgwc6?=
 =?us-ascii?Q?3l9kHjAX3JUWJqKgH/MWshwQ7myZnpP4Idgt4Wc0x6vhS9MteWUuAfvUTF3m?=
 =?us-ascii?Q?8edgIQWKuOxUzQRdpceheSn7y7+pi15uXUZyBwXCf5h65iyJx68VNiAK08Sg?=
 =?us-ascii?Q?3hjvAVtxjzp/g6rWFMyIgB8X7G0GSPXIBM72a1PsvfReu5JFuFFfdOOQn+sA?=
 =?us-ascii?Q?5JS4vKvVjzXiuRKno1KHU1k4+wKcqRjKTkyPonKPKtciyRIuOJ97zrkMOdzv?=
 =?us-ascii?Q?MD1baLUyWY+h9bpMvH1kTfr+mDIVQYdXPos1AeN0aQcDWdOS4NIUiZdIJJb/?=
 =?us-ascii?Q?QuVYx3dHzycMGdlWmwFzloAAyUYO3zrmmZK6sVB08FP0+rXDmiUTRC/V2mz9?=
 =?us-ascii?Q?H5Nw1yEZh8D049XvJK+avN6VdS1wUwE49qzn3SA9zXYAEHPu5JzpCbbe98pi?=
 =?us-ascii?Q?oHqLI0ZidTW7DfIWgmaqOCeBpq1BsCJ0bpjTveelgVOZ295rX3BGc6CC7kNu?=
 =?us-ascii?Q?WkFzL+I1AfQwuX2bLJ/rBmMlVkkcYZYO1tICulMkZCqOvswiAOWOxPC/eSfw?=
 =?us-ascii?Q?/31Wr0bZ+aROp90CglzhsK13+lmd2XPwQqpobUsJclKm3EbSUO8QNdvcxPP4?=
 =?us-ascii?Q?siEwuk38l8glCF2Tv1GR5p2FNiX6DP9DKHEIZWYsVRyqotvGF2E8MaJEl5mn?=
 =?us-ascii?Q?cC0RqnooewUcQm5fnaXMYI6aYCXdIWxGaLt/IyMQpZc6rX2uKHLpUpuFGqQE?=
 =?us-ascii?Q?QDtUfGOozcJDM8PzC7VnjiBtgkivm7rReW6GJ5ODdQBJPvYVGIHNGmUMmg3m?=
 =?us-ascii?Q?TOI3UBx5r2xlEU8Nf1X7ofiHPRkpUva7D9XM+yJ80pUEZUR2kFkbWBCNAavq?=
 =?us-ascii?Q?UvmZojELExEXBNCRimw1JMcFr1Q43JNT+KeHjs6rhwhZ6aMoXrsSJ1M/6peq?=
 =?us-ascii?Q?8Fje3Mh0UydeTLuPiqsCakJv3xFKCTQAXeGJh3Yp2ez6Ltyn4OKAlR1krqfL?=
 =?us-ascii?Q?aDoNc5hEV/wIvD6Ea2HK7Jq1fL54xppjhaNJfnSKezP+S7Eh5Y1nKQzajjya?=
 =?us-ascii?Q?KV3h32MVfpwKcoF4lsnVy4/tWhp2GYi29IOvYZmltjOcmscY3jzxCLBaEmOg?=
 =?us-ascii?Q?WMIMPtecPcnnjwp4fEhUA/POV19WehnyohHScT8arXsAMpTbDrkqctOSsW2C?=
 =?us-ascii?Q?zD9wQZY9DVWbeeXzuuPOl6iXZdtdSWhQ1hG7Xo1dhfTXN4O0VKXmgMYHwzue?=
 =?us-ascii?Q?KmEXkYyrVGA0GmfLFEznjRSHAUsFYo9jkDIG1b0oXJAPwYRsw8KPlDvY4D3p?=
 =?us-ascii?Q?Z3TSzVVZFZX8w/mE4d8tDB5CCEVbz2fADzP70oHnH9v+EeLpkq55HhBx04B8?=
 =?us-ascii?Q?Txq90o8DBH2o1lyZFLeSESsiShblG0rNCFE2cI4JYHljxqT+FH7DPJAv/lqa?=
 =?us-ascii?Q?N9+5ZJzeoEW+xfnsk0/XBbDI7ReMTwFXraaJdMS2Qu+hFXsz1HNS2iFSuQMY?=
 =?us-ascii?Q?Z3UlpMlqROkr/c1lMyMGM8laGT280zM9yxqgn2Rr78S5uY1JMjaDU/gsZy9I?=
 =?us-ascii?Q?NQrw/oaCUpa0P/ZRgYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:28.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1800b061-d83a-458c-1096-08de157feb84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

---
v4: New patch for v4
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ff11de5b3d69..acc3f958f96a 100644
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
index 16001e9f9b39..19606609254e 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command.
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


