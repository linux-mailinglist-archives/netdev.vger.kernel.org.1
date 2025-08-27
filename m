Return-Path: <netdev+bounces-217411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2CAB389BE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017F03AB150
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740622E1C7C;
	Wed, 27 Aug 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PPkeg0wx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D72F360C
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319972; cv=fail; b=K/L1tggFjwmBSI49PBzBaP0BoencKt/9swsEvjR8u86rzaeb8tkxMrr88lVXv0On42MV+Ki68Ga/M31iYtNW1UVO41oTRhjGl0zWs/rmUlP4nTgwi83AP9AqBga/pmcTEmAbl3HR2puEwburIuO0RMdRl62UHOP1qxxxKO3gzdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319972; c=relaxed/simple;
	bh=iR1cJn2gQRNE0oNROSy77t8+bgAJZGB2Jo9R/sjxWYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrAklRM4wJ9mprFlpzkhzRse0mPx8Occ9NS+G8cfAXv/KwfjuoNyXkJtwrARMbCRsk13O8j/2wl6THERaK9watwE3fI+liPXvvrxKYqgk1rQVx3zGJ+TA4vUhPUoRlCN2rFyEnroSLiG+547ftWUwymoXZtOW/8BwolAI/kH/Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PPkeg0wx; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkonj9FX+PB7CXiwVA25KFaRXGtzsPfkBzCsUNBtESrPIIzhcOaOPKsh7PFdyyuO6LU3/X2/zulX8rDfROJYQTMibqPL35fBDf8Sw9Acx1fSIJhF4S6HhfwOeZ0Lsx5dNphxyLNsFiadOB+miV72CfD6cvna4RgqDKhW92kL6lydO8WAZg4E1mwPmKXrKqheyYnI23wYTjQp3oEqfxmzeuwfIFxldl+KukDwvsJEt5Rg1XUnEfAinanzV4xsfPkhvVtJgzR/I/Y+JZGYjNRooiUTUS8fvcfzR1ABxbBikB7LLLWWTk/Xya7PEZFttKcaqORmU6AkMszJptUN5N/Png==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaG2PCpVBM4oQTrS3ALcAAu69N6klTwWqIg74n9U01Y=;
 b=jfEwC3YfjlVAZpd6NDtyTmZeWDYS39CkH3YpWn5ndNmK/Xtuw9P8rFc4aWCSXZQiopnpawEoAvaDSvwyHyns2btBc0KbUSow+yqsBC/xHvdlfocor4Ej51Syab1l9lamhd/VdmA7WdNQjc4sZmffldNXOu86CUrxHNafZ+Lr2VTF4hAeRXdn7p1X6Q4LmJT8OjglPMkYGkDVCHr7OH8M8zipib23iAnFVrwvWnQhferBg06hXRDQMmSx0pSq/QYGwEaSy7BYbNe6V3PIwPSjY+lE8uw+Q9o6IIvS+PySDOJCe05NbXSaw+X/RXfmw2w5XtzNVdhwMwto0Aj6nfgBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaG2PCpVBM4oQTrS3ALcAAu69N6klTwWqIg74n9U01Y=;
 b=PPkeg0wxj+HCNGMIYKzG7QfTNqarTuYTuB7ltZQdssE+x/KPStKN7U2aXuv5voS8I2fTNghpWL0lOeltyh7X9kH5fmHe6Mvmhjl+mV0H6U951QYfkGcN7dh/rH4MIgkH5qTzqiQ+X0Qq1X2UValLk38Z3nZU7MmvylJTgTnd9i+hfzZaJiMY0lliRvH4758xbWe30AF73TYKwC+NQxN0Q6Z8k6jQUn8+xDMdDrdE0n2nah5Ru7pNk1UmvWX/UxrYx4eeDAjmFqswlu2C7LKHSKOJz5emU2xfPi2mlBHmrQFlNh6sj6nQYkZoRMcyenBM0LuIfikS0GpO156oFE53xg==
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 18:39:25 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::23) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.6 via Frontend Transport; Wed,
 27 Aug 2025 18:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 18:39:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:05 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:04 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 04/11] virtio_net: Query and set flow filter caps
Date: Wed, 27 Aug 2025 13:38:45 -0500
Message-ID: <20250827183852.2471-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827183852.2471-1-danielj@nvidia.com>
References: <20250827183852.2471-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4a57c1-b81d-4bf0-2a37-08dde5990ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZ9OSY1mih9O5FJLgc0GXvcdGnhc7jpFSzT/HiWsboDPIYfbxnaCoqDqZ5Ew?=
 =?us-ascii?Q?XPEESEyBRbHc9gA0MhVq8QNt2p1jI8ySKkpjU8+Bli0FHVfNroer648JZ/X+?=
 =?us-ascii?Q?pQZueYtReHe85zEGaghrHEAMmXWjKyb+ffpjXeaTjZc0HTr2CWgMbb/kXDga?=
 =?us-ascii?Q?mGj90y5S7doU10x0IAjziMe2IQEleToKgAX6VS+3yNSiAwPoV2v5oPh5Q+67?=
 =?us-ascii?Q?ciTbmbEgfe2cAL3XDo220pi0Q4weYXqQuCidTj5MJBWQuB2s1hXlz0aFrqgo?=
 =?us-ascii?Q?Gq4ceSPbtjTQnIMR2dXQFV/STBbPYElaVF9aavzaeUGQuRb3okiDiDtPJaPz?=
 =?us-ascii?Q?aNTnWHppFVVkkd2J0Wj0vDgXjHgAMHCvNTBddwYMIRVfk6qEnfOmlLL4Eu/v?=
 =?us-ascii?Q?0g/sRhxkpXkNoJ/xyRtiuZm5dRQ4B64Yzt1vNt8HTKLTPZ0T2ml3YeEXrWLl?=
 =?us-ascii?Q?zl5O+LQc6C3kk5BMzh8JE2b5tZg2woMSI6DQLcALwKfHyP64duJmjK85EUGl?=
 =?us-ascii?Q?U2qjq3n76AvNUOWqqcslrLMuuJeP87YCZrc1PwLhGUgXcsUq2bjHy6DoLouQ?=
 =?us-ascii?Q?Ga/ztXzT1ZYIRFHgz8xqNaAZLocTZIjpwheMv0kKJeSePbHbXMO+JFNYtA+q?=
 =?us-ascii?Q?P1jBbZIrvpibaRa/dhYckm4WD8y2GQVZbJdrObbLskiL4wnRMLvrBBvlBOcy?=
 =?us-ascii?Q?EWSeFkND4apahYf/yGubjsW+QiqJeY72ITbhoIKsjoEouX5Lfi9aF45+Ts5I?=
 =?us-ascii?Q?fF3LVKRij5gt9rK5XNeWDPAGNw3tSpxzJ2T+qArW1/KsMkNLoo2IyAxlLwdz?=
 =?us-ascii?Q?4LkQ9uG2+7AESncc3Vi3SoCI7aT0fY2SRwbt/kbG/XMLDdbaF+cUfdL+etkk?=
 =?us-ascii?Q?jMOzlSP80neJOvwHekUPdRs9V1X8exsXaIEcuULTJgnhS0ivHxUWT6A/KSLw?=
 =?us-ascii?Q?/3MKGPaKBkbo/rFpslN2U1g4dhUPbG7jPX/BPw5c/eB0W7nfWa+2Cb15UwsR?=
 =?us-ascii?Q?v5FCbrieVjiR3U0y0t3As0eBbS6RpYJJgPXlPMgf6gPChIemf+WysD9SP5IZ?=
 =?us-ascii?Q?m+XZsXwonBTi9BHHhwnUuXtTQa+rIMkZK5Kh3l0rGootLKv8ahjghHd4S85M?=
 =?us-ascii?Q?2gjTBAY9l/Lkn4f7BuACWgzTKV0MwURgPPWfDqdvB8RzaXEhpWW8Sthb93PG?=
 =?us-ascii?Q?TJlqRpLRyCjZLJCr4sRIppWUJo6MXT2uu7QQ2uPq55eyP0Be9F4ermWIiN3v?=
 =?us-ascii?Q?XaKn10Lchc3PGNqh60sr7gvmmkczxKa5rtL4hT7V3LA91esCR0FiNd8s4sAl?=
 =?us-ascii?Q?fFdWIUGPRW7eG/mSkXqedHpvy4hIuLnRQ+UEUSzjXbxijkbiPRS7QOPiFAJ4?=
 =?us-ascii?Q?bmunL6Lj2x/zeeyUPSx7eYT8E2YYvSvQOwsmHTHKa20c30M7OtxgS4hwSAsW?=
 =?us-ascii?Q?x6RAoA197ydxwKeW/EUL/Pag5yuxtG5DevPkopI4ePMb7cQUPQkbxqK/tcwE?=
 =?us-ascii?Q?gtY6HfAZFJyg7ERICK3YQkEzfZr4mnxuMwfe?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:24.2841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a57c1-b81d-4bf0-2a37-08dde5990ba5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
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
index 000000000000..930851190964
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only
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


