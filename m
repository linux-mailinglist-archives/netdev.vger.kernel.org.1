Return-Path: <netdev+bounces-242000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 981F4C8B9C2
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D54B4ECF9C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD1342CB5;
	Wed, 26 Nov 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q1rr7pBw"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E414342503
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185780; cv=fail; b=rQy1bUnRxiNROZ7eLSoPGe57WtCwt8Jo1/uEbQ5AzkrI+y0QBNiHxlojJ4s3T+rl3bt6QNJEsyK9TYmK7vLOW9ouDaokXHa+xOCdUpoEYheVVdLG6pS6maR26ubsBga1xrAUwTIAU8k2oxD3fLi9Z4wnOCPnSovLHrwesalOKos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185780; c=relaxed/simple;
	bh=oREltwhNzwCC4QRJ/pZcucFj4u84HebNbu7VtsW/YiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlgZWJybvJn1XGFotEsTBB6venbPmL1d2zytE58tlKTRjwSoECdWELCnUyAUZOyu6KRHiRfXQcb/VhfF8KpAF4FS7R/+K/j2fN/T3Mk+Gyqzy7m1brE1cI2iUklFRnDDav/UqJ56N1aXPisMKS7dOcxRROroQdagSawTUNo9FcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q1rr7pBw; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wc8bq3OmJ+miDbOSyhZ6OWFekZI0tewiqC8mb206L9Hms/68ygPMd2c9lVYkxxUfpbHTKVH4yX1n+gCJnF+xbFdwMJfKR+ruQNiFmNw7Lbx7wk/vrgVhx/6VggRh7x24YNYeu5+Vruqalzag6guWiTkAtj9sQdFK+Kl0kTZD0SS8yYLmhibGc9YJGq5vFXtYjAjSW6NtIv8gLWBSiukIjWvLP4ae/Sco0SP86Uf34TMjRlYbXbcvkdnE9J8T7Agg4+IMdVIie3GguW1ssl3Nx/EjuFdoIhVNErf3X99q7zIHDmTxqyiYVO7xFFtghe7aaj5JCzFyKVeiYJ3JGJXVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5bjZc6RVyPTcyL3qsIzy1qTGlI84zO9epp4ZOCa9OE=;
 b=uJmw6j6zO5pMg3hn1aJIFHeSayT/4xugFnUU7LjdWUutktuZ1x8ivyH/M6gLvHg0zuV7a1GMSwb7VjIpVD2hCNckbYCq7d6vCj6fpLWJIRfo6MVPeLcSQhISIoAJvAbBIxNKFSARCBgAOAAzeOKqQJo0e1GhUIPG0JihvjF7ErSTGp+JUCV2KpQDGM8x0QUJujAtjMcDwLTdqbykc3/J7xau5ocwCL0x2GJHGtxkeUgWZQD6TcFF4MEIibSj3awIlKblthFv3HmSOQG4ssE4LyIIBdtqPZatO3QZjeo9l/7p3v/1s7jWLAM6CyO8TYIgfYIZXGLBu+ZY5uOye5P/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5bjZc6RVyPTcyL3qsIzy1qTGlI84zO9epp4ZOCa9OE=;
 b=Q1rr7pBwpWelnL+qpdUvhbrgsnBtoFI2AvpnOJ6XqEJg9nCpoBKlDD+jHVzGrNQXDZdnh9A3+dIqfQsJOosXz+3SAL6B5XHkXcrBGycOqmmREELjtxJ2gXs/BuGnbJsfi+yvMdyy65DhPR5hKfklkT5wLmxHKYYrC4L24c3cE/9/Mf6uVdPxnlcjM3ECxWoaXBg75tqkKGxR+V4LMfheY52PUXcMPZe2VHzvDzbKBDnmSj7zBHxO2UXVfZLFBlXfJwzogRBW2XWo6cHKK3QzW+ALgUhSNQRhsGYBNnQOIZjTKo5oiiUO1t3u++WYcuKKMcdRcqhQWoAOb2Fh6Ytx2A==
Received: from CH2PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:4e::22)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 19:36:14 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::5f) by CH2PR02CA0012.outlook.office365.com
 (2603:10b6:610:4e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 19:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:35:58 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:35:58 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:35:56 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 02/12] virtio: Add config_op for admin commands
Date: Wed, 26 Nov 2025 13:35:29 -0600
Message-ID: <20251126193539.7791-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126193539.7791-1-danielj@nvidia.com>
References: <20251126193539.7791-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a01eec4-fcd4-4007-c228-08de2d230f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XafPq98/2g2rr5aQpofU6ANYQO9tstlt1f9vmEArF352kHHlwctOI07yfPwY?=
 =?us-ascii?Q?6CkDinLoa8lD2WDuKuTBX3SYDm32C5dZLvEmtvNLhg5Oza+00efge3EKwtCr?=
 =?us-ascii?Q?Fb11ssWBJDZOLBAtk+fShsz2OqA1SxMNy3rHxqN8ofumDO6FPKS/I60bejtX?=
 =?us-ascii?Q?GnSHDmiQNOp8gx63yuEO+qNRE9WaghnrZyKvNyK77WeCZuru8GOT0tGoEM6F?=
 =?us-ascii?Q?YH4iRuGOgxK7HTSqzSGiHXdvtux17BoyuiwLhQB/bOuAJxk3XQ1Kr3rdL4Mu?=
 =?us-ascii?Q?w/MDoruA7qfsxI8suhAQGIXB5m8s5McW5hVP37vBrXKAXr+ucCTLdYLwm5Xj?=
 =?us-ascii?Q?WaoIBCdZDoEN7vpkTZHUxJx0q7JE+f8dzalNPcO5G65YsnO3ASYw6xs3fHk1?=
 =?us-ascii?Q?xVhnzjSOCa1vf5ULu+uE+QjS055lhy0IgxTrkaZkxTaxdctAGoz9K1ueB8D/?=
 =?us-ascii?Q?4YCVvDBZ5uE59wpw6hBzFbvlb60Fd4G6qi3FZogCkaLLYIDIqi7zjANYr6uK?=
 =?us-ascii?Q?HJ71gR7puUJMkjGHqO5SMhhM7+55VB4sqqB7v3QYdZlcfBBHmPTQsdBuL4Bn?=
 =?us-ascii?Q?ZTv3qeiWW+O//bczKAvo5mIBVETv1FFy8pOSQfih9jjpUIrDZurrB+n58dF8?=
 =?us-ascii?Q?dWOXWF9rB6DC+ibfjCtCcLthGInc5ayHOqEul4KbRdaPEvrLx9B3kQggBwE1?=
 =?us-ascii?Q?gGOArtHJjWnMyzXK+aHLc3QgzyMX8Uh1sazAUemJ1mxOGwg+O0xGmkclCu/5?=
 =?us-ascii?Q?71m7/y9p/Xusbu8Lc0WYIwQyr+kD1kUUsh9f/MhisJRIMeyiSUHgy2NT2jR8?=
 =?us-ascii?Q?4nFfcdqCHsQXisDAWsPAp1WlHNxHx6koHsbFDj/uFvizAW/zXsJk/6vNlTGX?=
 =?us-ascii?Q?GQjWwwe3Nv1nlFwJZ1A1eiRZWtHgfg6B4o9NxHi8MovHtLwj8xqnmWFQ09m3?=
 =?us-ascii?Q?aTnzJP/3XKpbClN3vFmwW+N0P2VyJe4armGgLpHcaXFpuVVRf3pE1q1CM5h0?=
 =?us-ascii?Q?Ucq2A6I4IVcWc/i0pWgxDKmQ89ADQ27Cb6FGhME2FS+xd75F3/n8Z6otMlJU?=
 =?us-ascii?Q?Ikp72sD9UVeyqhG8QBtgUBZS7nNJM+pIspjngpltqMPksI/JjqG6i2vsAsnV?=
 =?us-ascii?Q?g49xcLaoOnKjjzf8HDUSTRqI5M56b/BtCTRQvqt1rcvRtv2hVZ7ndBuNR0KK?=
 =?us-ascii?Q?D9lYHXSK2kG8L1P+ooVH1Vi17dRPUKu/lUA9WgKmplUmmnc6dYKYqlYQyl22?=
 =?us-ascii?Q?IpwH4GRLS9OBTqWdpk0oYq7nuz5AzUig6WSkt4cXjbXvJgoJGdomicM1TdBN?=
 =?us-ascii?Q?4rZmXhyAkd3miF2JQIr4T+U6pOGCnbQkhpfqvcTqsGvlmpFyAvP7e7gcWPxU?=
 =?us-ascii?Q?+tLw7hqJhdq1st6Kq99B/yu2D67Wu8ZWzDp44IvDMJ95QVdbT33+9mr7q8Ku?=
 =?us-ascii?Q?jIW969sbXtPDoHMo/i1fS/ylxmITCwzVW2zXb6wzuJLdrMGsc4Q6QTqqZPis?=
 =?us-ascii?Q?STJdvANvC15KrCuosDlVRPA/dhS4h7M3Molg5MCN4vQtwtoDQbQhGd5QcVM+?=
 =?us-ascii?Q?tbc2dPYUJBRGB3pHb1s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:13.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01eec4-fcd4-4007-c228-08de2d230f6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

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


