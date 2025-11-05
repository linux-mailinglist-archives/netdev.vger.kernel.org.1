Return-Path: <netdev+bounces-236079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B4FC383EF
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8624218C285B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD92F5319;
	Wed,  5 Nov 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iRcGmGi0"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5B2D73A7
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382716; cv=fail; b=V0er0W2YBdXGGTzIjqvac3KzDH7MpMAZh90kgLlzxxreOA7kAADkEv8Hs8LzHMNlNdGUj1D3HhdfjTAhhuKX+WG/GI+RQqRlmCZLlbCUk582F8XuUHIUlBfVeWVJMnrPxFO/ftrklpmEXGFSiZnt155JdnVlvnpg9ZXSNCmQkZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382716; c=relaxed/simple;
	bh=GlmILyRqZ0WwfCLIhBR3/e0IbstqMBEs/rC4LIYqmo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fg2nl62UTDext+YxBAEnkYpvW1P+S0wSqg8t2gJp4+5WFq7g2vkkmJ1joBKB+pL+ubMXGStmgh8HzuaMDdY11o1r4Tsz5MBK1CkeQ8eH82fQ7sJNqG0EXFRmWZGC/s1muM6EKxmygpNyWg2rFMZfeMcwM/gGsPHRqqAD1Wv2IMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iRcGmGi0; arc=fail smtp.client-ip=52.101.193.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGBbGFFwIYZSGNYY1fxfzTPTjm05+AYdugBQUB1lZ8Vb8bpmMxcZUvadJS8HPcPeMRR2ss2cNdMlDoB/hBDcZgSvNzsCmVB53mLQGxniPojroW/SJAJL8Y6jxxmIxyaQdRHM7Hlwi47SHdF9BvqizAFlTJw48ErStjw8YHpnPUzLgDfYGli+oX7L2VZG03a8fw8hPFDid3pvlucGazYYDygc8mGc+6CfQ6SD4YqRD3WsxW/jtzLOcidOqryW/B4MOPSuC2KaKtPPWFQydKjAOi3xijyFO8FZt27yIkKeEosLiS9QHp8ODEE7qu5z0pHFhPeCfkAnSQ1A747Cm19twA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6uiYJt1vD5tNvv00njXR5eOwtTPHp6Q+OstvSMYkp4=;
 b=H7DaeKEChmKULqXprKoCNtp3vgstHf9HmhD7MaxZNXjywgg0AwYkPxaV8B7e8shcPMlpz59oWzHa9g6l2RD7arDuBm17EkWNrLSWEmAZ6Ym7je9RaIM1RHYgsPgkcVDrKph0kgWyRd4d9XRxu9G/TU8SijLTg05ur1yZC/leM1bLAfh0RGSDHPc9TkteZSFB2WA8bJ+Mw2YIUc8plqj8wN3+Po0pLiYkCveLUcZa/0myRQKQ3Bd9m13YoucciMcbduFuu+byX6Ex71o2pktSov3baZOCSRCWrcdnF4tR6K2MxjbGdMvUP22sJpfAe2hXZZA9dqBRQolVZJXCJTUSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6uiYJt1vD5tNvv00njXR5eOwtTPHp6Q+OstvSMYkp4=;
 b=iRcGmGi0xW697YfgcotDuHGRi5NUQYFP8YrynzW2MujqBotCEEdjYHZcLEUHKF6YXd6RNycSWEN/T+zBc0mSeYPyVg6JC37BUIo7f9cgObmxzzpxRAbWEWMMPF5JtdwgG7pX1routfrIv2HrUBvzF8K2bBR38HhvWkEjLgvCW8NaY0B42xW+rVJacxmB1bovYQ3rR5fOtmmQ1T3R5muWsPXwhMv0FRHIhMbp2kr2KJoa+0ShLe1AL5pW/8UfyxdHVp9UxkOl1qUW0zuJWby1IQfQuEupacDm8dvUu3M6U+FrFOlwr07I9orsfqMAwQud+iDks2RkMOO/lnrYYi5Dfg==
Received: from BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::22)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 22:45:04 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c5) by BL1P221CA0006.outlook.office365.com
 (2603:10b6:208:2c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 22:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:45:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:45 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:45 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:43 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 05/12] virtio_net: Query and set flow filter caps
Date: Wed, 5 Nov 2025 16:43:49 -0600
Message-ID: <20251105224356.4234-6-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105224356.4234-1-danielj@nvidia.com>
References: <20251105224356.4234-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: ddea251f-2c62-4800-0fdb-08de1cbcf686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v4t6C1rrIEydu9gdqr4en1HRRdYiEjPN6NBsuY0KkjheppfwqiMxTl8NQIsQ?=
 =?us-ascii?Q?SBlR4CXSjqerCCFIdJ+fvpSMGGosD1t8K1QZO8i4Q+vPNGK9Q3fyev2+8rFW?=
 =?us-ascii?Q?YFLLnlBHV97idVNwSD+OmNljy+jND7E150RE4OD1xNbRJ//XZJyXnkAK+Wzs?=
 =?us-ascii?Q?pZB/bWfe4Gpu4uuoeP1o4U8Xe7qmUcNTk53ZjX731qejT9R0PBQl/qdRtd4/?=
 =?us-ascii?Q?f5j88xajk9ax9/OGBTQFOc1gkQ/ckWSTx8JJBdU3W2uvvDYAGZ5zD6LAcEIb?=
 =?us-ascii?Q?7Q+2AFA24P6+cVA9HuKE+UsK6vDLfQqvBVoZ0TunDfm7iKHSZ/NrjHJHW50c?=
 =?us-ascii?Q?4L0Uhxe3+BanaB9uDItKLJvJkbv0aVXVS7C4qsv1PEuj3Wf3Oc0xcnyCRdYk?=
 =?us-ascii?Q?biTYNRU9y7jnIYzZxqU5W7CKNigE5lyqOmXj1WZGYLK/PYVbQgr8DVK6t4sK?=
 =?us-ascii?Q?AIxekqgrG7w26tFyRx5WMGhxU1Gy0Fd3JBPzj4xRLCn+AVfihECPmVpXJCkb?=
 =?us-ascii?Q?HEjJ33VJoTGXL3L12etcEMRcPwTtCI6hwzlNuVHT/N/WZfyvU7LWxaAM0Hty?=
 =?us-ascii?Q?0SzXTSRWQRjzNTaQhizCp/eowoiPxd9pvQ3Qldpw45d8eezaSdc/aZoz2BAf?=
 =?us-ascii?Q?rEhd2fSEZRk8i7ao0XAnirhVvzCSKw8aD15+Id9vus+Te4qPWp8Xutj+uSuu?=
 =?us-ascii?Q?jTGsGU8bhqgbRW7f0ZJQjMqRsGtX8tLv0chOh9RO/IACqU9n071UhOBhxqgl?=
 =?us-ascii?Q?/lcDPJnQ25qo1Lm8REVk/fIUYB7ladHmBWQFNXc1Roc4GXoMowlQ9rnWjrCE?=
 =?us-ascii?Q?ofwRkEawiwVshWwVnPtFUX0HztJls9MSCJ6FHYj5mTDZDN3ViMXHkZI6Ynvo?=
 =?us-ascii?Q?e8ZoYMIdpoL9dZrJHE1qInkasNhVaDjqQKCUs/ZasPlmlLcGETqFW19/69YF?=
 =?us-ascii?Q?dS2MYEW3EDNzmQIyHJSWYpW+yK+KFFIieU2C9FHik5xJosdrsoo1irTdYcW7?=
 =?us-ascii?Q?frqxqTXJ+63ohGq285ztl7pzYl6NgEy8t6Oli0x9idaiF4bLzp7weDcfAmX1?=
 =?us-ascii?Q?N2hZT94xPbGI2yaBXQ5vFpYEuMyxp+3++LoRZARU45EK629gR48Nen7hNwTv?=
 =?us-ascii?Q?i2dquHzt7GpraYL6IR3Z5p146dE9EbT3WMUFTU0Pot5dOkXJsTzbvCLJqIpL?=
 =?us-ascii?Q?4lAJRlc83QJnRPxVSA6s2kad/xlcOjcjEZcBoXSecin8nEUcUZ1biiSNbA5Y?=
 =?us-ascii?Q?3skkl6WzAqxi69xzp3KyoUzpo9vwzmCtUtG2oNY8tc/rZG0QJNiqk5u5uKrM?=
 =?us-ascii?Q?BJdeQ8oxtYQ6xVZQjZU5D6c+MDa9H5Y9hobGy3CkP6HyVhmxoArLDc+5qPQ/?=
 =?us-ascii?Q?XlmZ7libbvJ4ud+C9f27lllcc99VDGm8WnJVVak+qk6BGHAfJ8I38LeBe/RS?=
 =?us-ascii?Q?P3SHCRtk3Q/EiTk9MA9wqmvh0uak5nJ2YSJsO3VCYleTV4ZDjkVVol77UraT?=
 =?us-ascii?Q?CXlbT4XVwoPK/roc5nhZPtD0bSD4rQaf9G/XHnOeZSmD+RdnBccz1NhfERiD?=
 =?us-ascii?Q?nuB4aaCCPYpp3Bn03qs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:45:04.7194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddea251f-2c62-4800-0fdb-08de1cbcf686
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

---
v4:
    - Validate the length in the selector caps
    - Removed __free usage.
    - Removed for(int.
v5:
    - Remove unneed () after MAX_SEL_LEN macro (test bot)
v6:
    - Fix sparse warning "array of flexible structures" Jakub K/Simon H
    - Use new variable and validate ff_mask_size before set_cap. MST
v7:
    - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
    - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan

v8:
    - Use real_ff_mask_size when setting the selector caps. Jason Wang
---
 drivers/net/virtio_net.c           | 185 +++++++++++++++++++++++++++++
 include/linux/virtio_admin.h       |   1 +
 include/uapi/linux/virtio_net_ff.h |  91 ++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e8a179aaa49..6bc50a989d58 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,9 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/virtio_admin.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -281,6 +284,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ff {
+	struct virtio_device *vdev;
+	bool ff_supported;
+	struct virtio_net_ff_cap_data *ff_caps;
+	struct virtio_net_ff_cap_mask_data *ff_mask;
+	struct virtio_net_ff_actions *ff_actions;
+};
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -493,6 +504,8 @@ struct virtnet_info {
 	struct failover *failover;
 
 	u64 device_stats_cap;
+
+	struct virtnet_ff ff;
 };
 
 struct padded_vnet_hdr {
@@ -6758,6 +6771,167 @@ static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
 	.xmo_rx_hash			= virtnet_xdp_rx_hash,
 };
 
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
+#define MAX_SEL_LEN (sizeof(struct ipv6hdr))
+
+static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
+	struct virtio_net_ff_selector *sel;
+	size_t real_ff_mask_size;
+	int err;
+	int i;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return -ENOMEM;
+
+	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
+	if (err)
+		goto err_cap_list;
+
+	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_RESOURCE_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_SELECTOR_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_ACTION_CAP))) {
+		err = -EOPNOTSUPP;
+		goto err_cap_list;
+	}
+
+	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
+	if (!ff->ff_caps)
+		goto err_cap_list;
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
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
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   ff_mask_size);
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
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+	if (err)
+		goto err_ff_action;
+
+	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
+	sel = (void *)&ff->ff_mask->selectors[0];
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->length > MAX_SEL_LEN) {
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = (void *)sel + sizeof(*sel) + sel->length;
+	}
+
+	if (real_ff_mask_size > ff_mask_size) {
+		err = -EINVAL;
+		goto err_ff_action;
+	}
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   real_ff_mask_size);
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+	if (err)
+		goto err_ff_action;
+
+	ff->vdev = vdev;
+	ff->ff_supported = true;
+
+	kfree(cap_id_list);
+
+	return 0;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+	ff->ff_actions = NULL;
+err_ff_mask:
+	kfree(ff->ff_mask);
+	ff->ff_mask = NULL;
+err_ff:
+	kfree(ff->ff_caps);
+	ff->ff_caps = NULL;
+err_cap_list:
+	kfree(cap_id_list);
+
+	return err;
+}
+
+static void virtnet_ff_cleanup(struct virtnet_ff *ff)
+{
+	if (!ff->ff_supported)
+		return;
+
+	kfree(ff->ff_actions);
+	kfree(ff->ff_mask);
+	kfree(ff->ff_caps);
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -7121,6 +7295,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	/* Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		rtnl_unlock();
+		goto free_unregister_netdev;
+	}
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -7136,6 +7319,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_vqs:
@@ -7185,6 +7369,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 039b996f73ec..db0f42346ca9 100644
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
index 000000000000..bd7a194a9959
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,91 @@
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
+/**
+ * struct virtio_net_ff_cap_data - Flow filter resource capability limits
+ * @groups_limit: maximum number of flow filter groups supported by the device
+ * @classifiers_limit: maximum number of classifiers supported by the device
+ * @rules_limit: maximum number of rules supported device-wide across all groups
+ * @rules_per_group_limit: maximum number of rules allowed in a single group
+ * @last_rule_priority: priority value associated with the lowest-priority rule
+ * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
+ *
+ * The limits are reported by the device and describe resource capacities for
+ * flow filters. Multi-byte fields are little-endian.
+ */
+struct virtio_net_ff_cap_data {
+	__le32 groups_limit;
+	__le32 classifiers_limit;
+	__le32 rules_limit;
+	__le32 rules_per_group_limit;
+	__u8 last_rule_priority;
+	__u8 selectors_per_classifier_limit;
+};
+
+/**
+ * struct virtio_net_ff_selector - Selector mask descriptor
+ * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
+ * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @length: size in bytes of @mask
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @mask: variable-length mask payload for @type, length given by @length
+ *
+ * A selector describes a header mask that a classifier can apply. The format
+ * of @mask depends on @type.
+ */
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
+/**
+ * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
+ * @count: number of entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: array of supported selector descriptors
+ */
+struct virtio_net_ff_cap_mask_data {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[];
+};
+#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
+
+#define VIRTIO_NET_FF_ACTION_DROP 1
+#define VIRTIO_NET_FF_ACTION_RX_VQ 2
+#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
+/**
+ * struct virtio_net_ff_actions - Supported flow actions
+ * @count: number of supported actions in @actions
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
+ */
+struct virtio_net_ff_actions {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 actions[];
+};
+#endif
-- 
2.50.1


