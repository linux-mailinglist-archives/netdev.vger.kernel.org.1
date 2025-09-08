Return-Path: <netdev+bounces-220880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A6B495CF
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB9116AD93
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD630F55A;
	Mon,  8 Sep 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uPKFHTKt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3385213236
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349788; cv=fail; b=IsO1pAy0xQnGJaHj2JOUSX2Kj8rjQGbOy1wQSQaWJBQVpZtJsPZZfEv6rsssN7vbUKzkIlGXopuB2xhAkzuQOQVdaNF9v11xQ9Kx68lRsfqFzcO1EEdHFBDIgV7yU87Qxm5LZbXC4qhqEt5WG9nfWPPyY3mD/b1Z98fDW7upCMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349788; c=relaxed/simple;
	bh=Gpb04uWINtoHwtRepis8lUgghc8at2m1wMG5nYr5LFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuXur1+fCL3oZSAQFmMVIYlhtHEd1ft6qeca5nNtPIKfBMd7jQCqzaOnZuSlFdIm2tf70w5+ENL1RyZwYaWnARmaVXTWHMVS/HFS6u21kMXOI/xhTH+pKRcEPRCqSXfWOcblIChIKPqDqj7Y+1t7nxSSXZGSp9Aw+yUeTiRwDfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uPKFHTKt; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkrZQ2jfs0YlK9vFNx+ceeFOh9+S2583OQhHxjdCB3sNFQDGH4NwYR9AWyfhNRchfml6Igc48mDyAnIfCYnOEGVSMPeN8KCUkfyk6J7puJU6MxNbPoym/4tnxEEiwdsoMBg2Vokj1UXMR8F/hqSGYWHqpKveKOKWzd7LBPvxePDyk/k7oV8ZwY6RtHlELubo1Su/bTE9mpr3N9f+5m6ha/hliWinvRJXNCETiUfDyW4vsGpNsgNMAGRCyX/F5pyrXns9QcqT/0cydgvHUwkshCdZU7N+j0dc4ZuY+SYt5FvZ3yiI/OsGPOaQzQ5yRZMVUzrITY+YegkKXKTWdgjWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r72QgY16XWMqSnPNzmD7XNoaW0LDFgzkMT7X4gs5hBM=;
 b=xGnScyTjn0/gf+habGMAkjuIjVMKW7AihRUXWJw/9SBcVTUDOeNKLlg2IG+rupJsMOxp1TvJ9NcvNZtfp2SJIsn9/ORX6tpur+zxrEk5Wylr/Z6EHlZitmNdFsLNVsaPonlm8soI8J5vf1nSPfQevAcuLm9Jzn7lG15SYhc/y/cTdHflbdK5RqyzSnOvtDkmCWw2RM+j/ey9N1lx4N5TDk/yPbuwV14A69MkIme1bDUuXFBLgB63eLDY0jv+Fz6lYpA3NICl84hIWMhpqtetBoHGb0nUj+FjkO1BatoZzoH9RhJpJQAYzw3J6eOeH3fS6/AjUNAGWPy87W7UHG25qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r72QgY16XWMqSnPNzmD7XNoaW0LDFgzkMT7X4gs5hBM=;
 b=uPKFHTKtSstGMbZPgHwZkTtIxKbI4yOF3qYYMG2gbo8bkFIrc/XxFxXp8+q/+Mdkztq6z+079dFDQ18j6QHkABpz0vN9fnbcLyt9ZakHvq/egmgXhL+H9+n5bqKdpV0l4mn8iG8eAP207DYDxBj+GC8Knkdw/GCKm1G+tWCzuO7f0fUljYV2c0nIZxOMP2eyI3RxkZ1+6pkUG6jhszEeRp4fFsexVeXehPfRPWqirCs8s8PGIbcnEAU0O3hYzNiTBXTyhO2dXJfRyCj8R8zCYo/rwExhkFcfkVTrcKG8Pl2fCcw74kDw81whyzT/HRM/sSHwRTq8kToX+3Sp5/24TQ==
Received: from MN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:208:530::33)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:42:57 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::cd) by MN0PR02CA0011.outlook.office365.com
 (2603:10b6:208:530::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:42:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:38 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:37 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 04/11] virtio_net: Query and set flow filter caps
Date: Mon, 8 Sep 2025 11:40:39 -0500
Message-ID: <20250908164046.25051-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a469fc-0595-4d62-74f5-08ddeef6c3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z0CP86QNpGthWe7Mw3w1V4LS4McZPNFWmhkXnrewZ+lQcuEvh9UBvP9LxeTk?=
 =?us-ascii?Q?cuB3g5C3RHBN1ONKRUfXT2NMSNaWsaa7A1RsOmRg90my0QztBqHa88HKfdAT?=
 =?us-ascii?Q?ZLLt9w7ZIAnvxhHK+Uqp/cMfdpcW2lyFBzVQgVe4enr7TFs/UM9Qw2BilOnr?=
 =?us-ascii?Q?p+t+QIwbKKZX9seFL+McOPgXjsJpESGlzceh0DfV1lIFV+ju23OVb88HDdlp?=
 =?us-ascii?Q?OGqPf3AXPQZKzs/NkgssO4tO0HwZmihIiIVaZtcmuCqGvRS+iA4zOP+sEndB?=
 =?us-ascii?Q?3OhPCd+HLSs7dOzjkfIMpLXe4AggDeoORMAiMPi8iU7GZrUWkosv8e+SWLg4?=
 =?us-ascii?Q?KUxMqL4mSnjTjRr65vzriOo05R82jA0FUIv8pY6q7dSYLvaU+KbIx0+slntd?=
 =?us-ascii?Q?yJbEGZo0gZvzO3JWDakyh2NV2PWNRlIXS6TsdDZvwgo5vtUFwvg/2GXavU8J?=
 =?us-ascii?Q?CWypc3Vpt2M4HkubE6iEOdeDNuJnv6mMbw1flVURScbKL5LtwrxYU7pyQTZl?=
 =?us-ascii?Q?4H1vhZhK5SiXTZ2FxTQBGEFX8e59g7hWzrU1rlBZL9jCL9zav+6iK2I4ogyL?=
 =?us-ascii?Q?5Ps+lftasKN6TedpbvXQbwJD5hDJspNsjnXyn/fYfppK33spFqoEpF+6K9yc?=
 =?us-ascii?Q?FoN91035fg7pGjxKdtmHbvfHHNVpoqq0lWnVAADAlaO6HMARyMjhvg4ywcOK?=
 =?us-ascii?Q?9WEuBZmh6lkihDDz8zOIzLDBlLC7+pzGHZEW8WI13BqjPYt3PBAb0Dp/JSMp?=
 =?us-ascii?Q?lBvszBl6r9Tf6+vHH6gb4dL/uj5SRoncAjXmy8fJXa0eH0nsPWYYkA2I1TSJ?=
 =?us-ascii?Q?JsUozujiddUv3Pru/w/xNU+sq4YCfYTRMoL30JlfF/aBOvg6gqxOJOskTdhn?=
 =?us-ascii?Q?kKbi01UmKbDoRxTXq6gwmajGpTmC3AoEH1iGs/9dVDPeLxiXNuXyAdUsD7LK?=
 =?us-ascii?Q?t9QdHK0Vp3BEnqawoL9wUyu3rVvRBFN+FBPXVqgkzvTkm3zqySdsjsE37l8Y?=
 =?us-ascii?Q?jnHTb0b3Yu7VjS7jKJSAUmHdr6GqYe7cUjoCHCmstNCwNp5HgUt065dh1ApH?=
 =?us-ascii?Q?aoHw5XLuni9a75oK+sRl1rDfXo7ZS8fvQRO+dCpWQp9tVm5zTb9FcTahhdU8?=
 =?us-ascii?Q?GlWR6mth+gDAiKi4HF7lw2wGu0MLx/C19RMdpCVxMpwBwZEAHJqsnsp37bzo?=
 =?us-ascii?Q?7fAMqI6Qsi5TYivoUOStK9GboYpXb921sX3jxTVQkJ7pOZZiSBLX6akoa6kU?=
 =?us-ascii?Q?/P3NJqGlkOZT7I66NnEAyx1SjkhMhnIgAhaPl69HYP/2FfEcBUBE4Ssam9UM?=
 =?us-ascii?Q?ZwYuWNMI6ezB6QqY0bLnDJ4LTXizppUXeQsvdZ/ya1rtPNDMB4UjmtlPVmwT?=
 =?us-ascii?Q?WQgbhIjlk6zjlYYu9QxCGAXsePvGjPhbP9VlF80cP6hNsPvXh/khge1wLvuc?=
 =?us-ascii?Q?vFDTtkgyxNW6y8Ww6hnmidudAx+6eFiHfyIz/3IT3sx3VKIZeEYsEF+TF54u?=
 =?us-ascii?Q?/SGNtWCU+TiSYe8ZAWNK2rnQHyAJq36Ko46K?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:42:56.5716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a469fc-0595-4d62-74f5-08ddeef6c3a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

---
v2: Add syscall note to SPDX
---
 drivers/net/virtio_net/Makefile          |   2 +-
 drivers/net/virtio_net/virtio_net_ff.c   | 145 +++++++++++++++++++++++
 drivers/net/virtio_net/virtio_net_ff.h   |  22 ++++
 drivers/net/virtio_net/virtio_net_main.c |   7 ++
 include/linux/virtio_admin.h             |   1 +
 include/uapi/linux/virtio_net_ff.h       |  55 +++++++++
 6 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.c
 create mode 100644 drivers/net/virtio_net/virtio_net_ff.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
index c0a4725ddd69..c41a587ffb5b 100644
--- a/drivers/net/virtio_net/Makefile
+++ b/drivers/net/virtio_net/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 
-virtio_net-objs := virtio_net_main.o
+virtio_net-objs := virtio_net_main.o virtio_net_ff.o
diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
new file mode 100644
index 000000000000..61cb45331c97
--- /dev/null
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/virtio_admin.h>
+#include <linux/virtio.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
+#include "virtio_net_ff.h"
+
+static size_t get_mask_size(u16 type)
+{
+	switch (type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return sizeof(struct ethhdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return sizeof(struct iphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return sizeof(struct ipv6hdr);
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return sizeof(struct tcphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return sizeof(struct udphdr);
+	}
+
+	return 0;
+}
+
+void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list __free(kfree) = NULL;
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_ff_selector *sel;
+	int err;
+	int i;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return;
+
+	err = virtio_device_cap_id_list_query(vdev, cap_id_list);
+	if (err)
+		return;
+
+	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_RESOURCE_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_SELECTOR_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_ACTION_CAP)))
+		return;
+
+	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
+	if (!ff->ff_caps)
+		return;
+
+	err = virtio_device_cap_get(vdev,
+				    VIRTIO_NET_FF_RESOURCE_CAP,
+				    ff->ff_caps,
+				    sizeof(*ff->ff_caps));
+
+	if (err)
+		goto err_ff;
+
+	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
+	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
+		ff_mask_size += get_mask_size(i);
+
+	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
+	if (!ff->ff_mask)
+		goto err_ff;
+
+	err = virtio_device_cap_get(vdev,
+				    VIRTIO_NET_FF_SELECTOR_CAP,
+				    ff->ff_mask,
+				    ff_mask_size);
+
+	if (err)
+		goto err_ff_mask;
+
+	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
+					VIRTIO_NET_FF_ACTION_MAX,
+					GFP_KERNEL);
+	if (!ff->ff_actions)
+		goto err_ff_mask;
+
+	err = virtio_device_cap_get(vdev,
+				    VIRTIO_NET_FF_ACTION_CAP,
+				    ff->ff_actions,
+				    sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_device_cap_set(vdev,
+				    VIRTIO_NET_FF_RESOURCE_CAP,
+				    ff->ff_caps,
+				    sizeof(*ff->ff_caps));
+	if (err)
+		goto err_ff_action;
+
+	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
+	sel = &ff->ff_mask->selectors[0];
+
+	for (int i = 0; i < ff->ff_mask->count; i++) {
+		ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = (struct virtio_net_ff_selector *)((u8 *)sel + sizeof(*sel) + sel->length);
+	}
+
+	err = virtio_device_cap_set(vdev,
+				    VIRTIO_NET_FF_SELECTOR_CAP,
+				    ff->ff_mask,
+				    ff_mask_size);
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_device_cap_set(vdev,
+				    VIRTIO_NET_FF_ACTION_CAP,
+				    ff->ff_actions,
+				    sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+	if (err)
+		goto err_ff_action;
+
+	ff->vdev = vdev;
+	ff->ff_supported = true;
+
+	return;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+err_ff_mask:
+	kfree(ff->ff_mask);
+err_ff:
+	kfree(ff->ff_caps);
+}
+
+void virtnet_ff_cleanup(struct virtnet_ff *ff)
+{
+	if (!ff->ff_supported)
+		return;
+
+	kfree(ff->ff_actions);
+	kfree(ff->ff_mask);
+	kfree(ff->ff_caps);
+}
diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
new file mode 100644
index 000000000000..4aac0bd08b63
--- /dev/null
+++ b/drivers/net/virtio_net/virtio_net_ff.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio_net flow filters
+ */
+#include <linux/virtio_admin.h>
+
+#ifndef _VIRTIO_NET_FF_H
+#define _VIRTIO_NET_FF_H
+
+struct virtnet_ff {
+	struct virtio_device *vdev;
+	bool ff_supported;
+	struct virtio_net_ff_cap_data *ff_caps;
+	struct virtio_net_ff_cap_mask_data *ff_mask;
+	struct virtio_net_ff_actions *ff_actions;
+};
+
+void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
+
+void virtnet_ff_cleanup(struct virtnet_ff *ff);
+
+#endif /* _VIRTIO_NET_FF_H */
diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
index d14e6d602273..1ede55da6190 100644
--- a/drivers/net/virtio_net/virtio_net_main.c
+++ b/drivers/net/virtio_net/virtio_net_main.c
@@ -26,6 +26,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include "virtio_net_ff.h"
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -493,6 +494,8 @@ struct virtnet_info {
 	struct failover *failover;
 
 	u64 device_stats_cap;
+
+	struct virtnet_ff ff;
 };
 
 struct padded_vnet_hdr {
@@ -7125,6 +7128,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	virtnet_ff_init(&vi->ff, vi->vdev);
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -7140,6 +7145,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_vqs:
@@ -7189,6 +7195,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index cc6b82461c9f..f8f1369d1175 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -3,6 +3,7 @@
  * Header file for virtio admin operations
  */
 #include <uapi/linux/virtio_pci.h>
+#include <uapi/linux/virtio_net_ff.h>
 
 #ifndef _LINUX_VIRTIO_ADMIN_H
 #define _LINUX_VIRTIO_ADMIN_H
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
new file mode 100644
index 000000000000..a35533bf8377
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Header file for virtio_net flow filters
+ */
+#ifndef _LINUX_VIRTIO_NET_FF_H
+#define _LINUX_VIRTIO_NET_FF_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
+#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
+#define VIRTIO_NET_FF_ACTION_CAP 0x802
+
+struct virtio_net_ff_cap_data {
+	__le32 groups_limit;
+	__le32 classifiers_limit;
+	__le32 rules_limit;
+	__le32 rules_per_group_limit;
+	__u8 last_rule_priority;
+	__u8 selectors_per_classifier_limit;
+};
+
+struct virtio_net_ff_selector {
+	__u8 type;
+	__u8 flags;
+	__u8 reserved[2];
+	__u8 length;
+	__u8 reserved1[3];
+	__u8 mask[];
+};
+
+#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
+#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
+#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
+#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
+#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
+#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
+
+struct virtio_net_ff_cap_mask_data {
+	__u8 count;
+	__u8 reserved[7];
+	struct virtio_net_ff_selector selectors[];
+};
+#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
+
+#define VIRTIO_NET_FF_ACTION_DROP 1
+#define VIRTIO_NET_FF_ACTION_RX_VQ 2
+#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
+struct virtio_net_ff_actions {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 actions[];
+};
+#endif
-- 
2.50.1


