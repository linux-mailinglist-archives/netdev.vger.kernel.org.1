Return-Path: <netdev+bounces-247398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7086ECF97CA
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD8030EABE9
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B651332ECD;
	Tue,  6 Jan 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3jiRK3I"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4C15CD74
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718319; cv=fail; b=ONXhrCs+KYektCuKGNjYX85wGU+dRJfsebhNsg6nqtzwOB8wFFHqNZQK7RswH+nZp91Wgx215eZXyRyBX6ekV7JHciXmBq8Q5nCNgqW9d++qF5u3UuEGA4lL+lj8PJoYvI4RkKGspmFE9ENrLs/Acj3/Mjog6kPx1US2ROF4hlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718319; c=relaxed/simple;
	bh=oREltwhNzwCC4QRJ/pZcucFj4u84HebNbu7VtsW/YiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCydj1KgGRz0Uppgh2w9R/60g+wDWipllITPa++wbFGEGwOuysrHaByx0rHbp6v8c41qlaeSAWD2YoagbOBToyGya7jveIWESjYUnCyTPOLaWZ48k+5g7X32fxoM6etnywWe7whlcDao8+HftItnTKZNkeKB4GzwXxRsz/8FvZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3jiRK3I; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNX6wvMKAkmhnTrcyI92stf0eSaI//6s0FHDct8485y5jXwPDOgEyTei2TLP/BdTZfRv3zy2E66eN9z9bQPJt5/NwuQlUtF0pbiai9VEBMyRREkTy2VGsdrbo8PAywwcAPs4VLAsmSQtreVECjrLO3TO4YSmyNTlhVHRWC812GKki1bOjjDvEhJJIY8lZgJ9BKrKoLaSMyFLBrSjcMAHV1S4AB4Tpfw78seZ/W9GX7qdKXDE+RZHSui7eCmPds+8xGJx5Y1nhki5RH+Kx0gZRCcpMyQ6m8C3TsIOuEkjlMS55FHcLcnk4fouLZ5kpMhsOQ8qXUmT5bYCufZqLgbxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5bjZc6RVyPTcyL3qsIzy1qTGlI84zO9epp4ZOCa9OE=;
 b=mV890C/deycepht0irIf7Ln8Dew+G8KfaxIsrADS6aiq2PouZF/2QaEO/IRrfLNMc18I/TOIO651kETgZpnzhx1WtTyWsTXMeMpcWnYlRhEwws6l/NUgCBYHdo7IFyhAYYZiWPR7+ncE+Iv8AtE7f4ZSPkR1GcMsS5Zre0RlPa9pO/5xoVGgvJHozubBsAHpX2vy1Jk7iMbKQXIOE6cxYqgXrFc7xOa+bDwUI4sB3+A3uvguq2ClhQhY2x9N4wzZjAfqgss5uUqTJCcBfQayetM3omVdtKSo9cnCYp7eIms5J4SYqJ2bNueoTH3kvD2N8+lc/iJ6Zsgbd3TkUPDfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5bjZc6RVyPTcyL3qsIzy1qTGlI84zO9epp4ZOCa9OE=;
 b=q3jiRK3IyrLVyixTySLLo7bx1xuSQU7UDuMRjCdMNBFkknNaC3/o8ZyfCgSapl6Hg0FPlXBdLA+fn4zyqn52grmcVUkns/nKtIgQ4uzHLZXGGacox0kUAhi5c3j1nZZyoyjNJTPVhLFckVHl/K4kTIqO+iAkbFdrGGxjVeEHDFuXJj/XMDlWCoQIm8AHe39YtmZILDiOsguyq40E5Jk8XSnZnZgYNGloOi9R2JbaeXzAKTDRaJaXxJ9B+mQIFnM2z/obwaEjQrU/K9/ygxFw3SFQyj+fS5Fxlf2oZUqd1vYPFXwZ4edKYPMFI11fflgzdEmV5+IzsYLZnMJz3CezaA==
Received: from CH2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:610:4f::38)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:51:48 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::92) by CH2PR18CA0028.outlook.office365.com
 (2603:10b6:610:4f::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 16:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 16:51:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:27 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:26 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:25 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 02/12] virtio: Add config_op for admin commands
Date: Tue, 6 Jan 2026 10:50:20 -0600
Message-ID: <20260106165030.45726-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106165030.45726-1-danielj@nvidia.com>
References: <20260106165030.45726-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c551dc1-115b-456e-7621-08de4d43e1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOeb24aO7Zik+rHvvXinkdTmNvVkcLfJnyEPmrBPKhUCgPHZnpCNHJz1Ozah?=
 =?us-ascii?Q?Njf85mI5U6syhV17ICN2eTJEOsNZ4F5gwJ0xiuKSAyFSxBm6jeGGylFgAJcm?=
 =?us-ascii?Q?LDhDVU1blW1fitgTIXpmqpFVrf042siJEfK6hbPeyDcQPZAVEbyyODIZFbNu?=
 =?us-ascii?Q?i6z8pg0tjX7GdrcYs0NyhXngDh65y97W9a6sbyLItw85xy/DX+v3syQrvjJx?=
 =?us-ascii?Q?m9NUPWLQcYnhOOy2q43K7ltPRPzfDMN+qvb0nzJQDlpTbgHgdpBJYTVQXVvu?=
 =?us-ascii?Q?UU78SsZ4BqB89R2ljbQuu1KLAh015OHkNwg60Q8x0mz4IQeeK742TQcHqMog?=
 =?us-ascii?Q?D/jbErTAxnjWVfJxyI51ng1CSlLEEMomMT1+g26WiuLHof8FHfKkhdypovbl?=
 =?us-ascii?Q?fMZP6WMXkI9prJsDPPR9xZ/9J1UWk9w8ALSDZuuafGmp9ZFaLbJQYeVFHjE2?=
 =?us-ascii?Q?LTm25aTUPeT5giDp/h9spyQ59B5K9IKLO7ZttnmGn4q1uqWJuXSvKlNRZlfk?=
 =?us-ascii?Q?wsjWfpfNFh8XRO5RR2a4SBj5z3SC//a4JrMBnbksO57zmWUCO+QAz7WD6ULm?=
 =?us-ascii?Q?ZyAYzxRF/+Ua37yoDMHLzbW2P0FP2+UR1DKAEyPEqqO5518WgiL8e+Y7Ie84?=
 =?us-ascii?Q?g6T6L4Ui0PWOtuySIlQ6RkdAUJIXODyg9jlQiNG0DRzCENFMM1TZ7E4QtiI3?=
 =?us-ascii?Q?FIwlxnrV9gg3BVfjuQ+MT6x8CpGTNyWFjJE70OmWyASjT+xV460/Y892v5G8?=
 =?us-ascii?Q?xt/eZBGGf+45liRzNctxguiD4j1FSW/IytPfpcmqwrKLHA3146KS1rdAov+u?=
 =?us-ascii?Q?k0/vnrEmh4t5ILELYoc+JAd+Vi5xdXeY5Ulhl4gpf9O/w3ZCD2n6qTx3isSh?=
 =?us-ascii?Q?Gh6kxzc2+6O6o+pyGhfU8AqGhbqvfcCGOIDv4EVFkvp7YHDrVCvfFGahp8bQ?=
 =?us-ascii?Q?TTZbhdWSGN8FqPlQjjbjv7BpIw1G95FnucihO9stv9jT1Tpj6+CUpWfjhV5n?=
 =?us-ascii?Q?+RAESlb6bfQySD+IN9a7yLRMdaKfYucNPGnoNo2vE9FwiC4fOKRQiJvvTLJZ?=
 =?us-ascii?Q?jxA/+HVyommf1q+bMXOVukjAI/123dC2LlJFa8YrwcGutaV5GbhPXwUxAP/T?=
 =?us-ascii?Q?3PyQ2QFqITvRoKCBHbM8r41E3XZ7jB6PYaNKqQC0NLgZuJ2WophVTtz1c7rD?=
 =?us-ascii?Q?HF2mBnHnZ7mQ81F4oj8hpvikfoE8exestl3msYN8CsGVyfxQqUHYosTfbEWH?=
 =?us-ascii?Q?jPIHvrI7zGOFemfhLvP9Dt8evDrv49iYvSnPAYNAFjqqMs4Cgk3rzLp9Rlhf?=
 =?us-ascii?Q?G26QEdfBO/Ltj/0FoH9Br8OtMc9k0uf7j0gk1et9DBfoZZ4/EFirNRN9b3IW?=
 =?us-ascii?Q?yxKH/uW3U75GvgBP3RT6O6FgkRpxU6WmE9TtiCZhnkrXA9odst6zDnrnywRN?=
 =?us-ascii?Q?H2z0pmZWxAR+SW9f8usll/TNgF7WT3PUod9Y9N6OrX9o6U88s2+fQp7BpmRe?=
 =?us-ascii?Q?H3tEPQ6coAh0XxhbpSyt8IzUFj/urv4opZSQ3yUz/mIwZIvkooxqZzviYUlR?=
 =?us-ascii?Q?ssmJzTg6KqI544etH6w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:48.1004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c551dc1-115b-456e-7621-08de4d43e1f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

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


