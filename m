Return-Path: <netdev+bounces-228828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20971BD4C87
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47283E17A1
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2D31A067;
	Mon, 13 Oct 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AdSK8zaw"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520330E83A
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369305; cv=fail; b=tvj91RWPIcQAnSO7uqGc2zXOUhRR69zvgGMGWebCaEy8PxksAso1dJWFc4C6KPoorrnxhNA9KMEGXVafqkdkx2Estfy/hNOc88cjs2MJQZhe8x96F6datMawWQ2sq2CvECyBfVmz1OMMf0x+rAbFkNDDjG1MuQwUa8/7fFWLNkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369305; c=relaxed/simple;
	bh=qTIPQeaGL5AIjiJRIA5uiFoWrLQ0fAg3wUOTK+VW2Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOVa+v2TU8lNl+8LBH/e0RKh+F7YU0jTjgK8YMxF6r6HBh4Tglw9SL90DohJLQaAL32Dqz/XmBafEmlg2vKOZt0Atz0VClv9DZfI9Ar1vitZmmC/rpWqpMp544nP9U0fqbcSdrcy+PpkoxtD9vee04GxZb/0nF4LWxAABO0xeSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AdSK8zaw; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GerJZIQDyDe4Q8owWrocC/33W+e0QHSHwcn56Qj5CH4bwXQ0cf5NMoDUGj4AnE2JIO4Lt9zQsIwvEwBoniQLR/WsVI3uyq32dgQqY9FCBQYIhdjt/PbW5pmgAnCwy3Is0t6/LyQUHW8Za9y8SD198tto1BcNB07P2CrZa+zLZeGlw9wxAZ9Owv6ABI0xX6sKglK+pFKhsd3itxEEwdOOTrtg0/WIEz+7pkRxwvOtAYYc2ZMfz78WRwppMsoyzZG0MW8175ANEfuMfnbWXn1m4qSTRgZ3L6Sg6xZmqVSevVi5tWKhuJJe836KlPolv7vYKFYsyTOVULtme6lxVWIclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwHUaOzZQPYJ98jwwi6jnFyvYDRFbCW+OkPbEzrSB64=;
 b=JzpDSNav9m11GgCaY2wF61JSV9nL8M+TY3jFVsb+crQkMQjCL3qWq7x4BlpBTryRkgVfMVhrTqq8eoR9VSxLELjHylJ15wZOITT1+iJiPszs+tnbO0+MoFufkVV/Ja4poUo1FqYq2oumjB8neG5UQC40TMlgqwhLOJFCU6pDj7MoszOY+cBhPLeSstQky1j0RKYpIqQx1STTEzOVaNabjQ0h7t1T9p98kKmxOU/jPkxP0p7iLawE0dbNF0oFQQQSaBEu6LPtda98p6NO48MahnbQ+vk9FphXSRGvFvmxNWO02PWmbjfnzbEc+NRZe5JG6Dumc2lt39bRQ38VBKDM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwHUaOzZQPYJ98jwwi6jnFyvYDRFbCW+OkPbEzrSB64=;
 b=AdSK8zawQmw0/uuvyuxuCdx88FLLS8XDHf5ikTfd1BVytuIiWV6bpiV3mJkMAmOG3u2sHLm5BPz7HZxzYH5ppddsTSOpokjTs4rllXPsCoD+kfIh82GceiY9AopS5s0yF/Cw2JgS1JFft6Ukiyb1dh53+XVEd88Dm0cUcI31LFJyp2VjOMaJMaUItA+Yk/B0tJEuMYJHF5+LFB4dvgeKrn/qM0r0RUFvg5DcoFTAb8R5yvA5rCQ1q4TTty6ERkaQ6BFqkNhqKcuU9fSMyCb+QUDHn6yybP888vjJuxTDQcZLu+cc3SP8Zl5XLVorijszt1cb/6kx9rCGo8BRe6iRIg==
Received: from MW4PR04CA0279.namprd04.prod.outlook.com (2603:10b6:303:89::14)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 15:28:19 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::87) by MW4PR04CA0279.outlook.office365.com
 (2603:10b6:303:89::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 15:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 15:28:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:07 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:06 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 05/12] virtio_net: Query and set flow filter caps
Date: Mon, 13 Oct 2025 10:27:35 -0500
Message-ID: <20251013152742.619423-6-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013152742.619423-1-danielj@nvidia.com>
References: <20251013152742.619423-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: bdab8f19-813a-475c-b3e9-08de0a6d22f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ho6hNrO528XXTvlhPOwsUEHZghiPA43j9y2wg2/GORVJ3oK06zj0MvOgLXZ6?=
 =?us-ascii?Q?NBB9pmFkzO1PEi2N1tbps8Ajh/J1SPiSLP7QlTlJLIN1lzUE0hLfFGX7cmvv?=
 =?us-ascii?Q?JmxuajWsSKN4jSFo6FyFPWwmKMkZqMlXgKeqU4Jrkars+4rJfZ/GufGonSTM?=
 =?us-ascii?Q?iKOpIWUiE1PBCx+7k//tWzGZWDzF+xjoQs3CxT/49RJaZl2jLmRwM/jH1myL?=
 =?us-ascii?Q?zchph3dekiGc7wLGTsEAKYARR5MSGslUJP6pe9JjqjrwkE6drh1I8v3y+0Ij?=
 =?us-ascii?Q?8k3gqu/0UWzwJQXKy/4PcFhqIcRbqkGa92VDOovJKKtgmKdt/p742yPb+XW9?=
 =?us-ascii?Q?8FZNhQtP/DmdyW6szuto5Pq6ADeZTiMsTO7hbVEMCpiq2ZqKjKf8sscCFq6j?=
 =?us-ascii?Q?KgIgtLVufFpC3HDcXJ0MVbQA7pqUbb3gAwWoHLyMsJF9q1Sx4dVZe+ZcCuYT?=
 =?us-ascii?Q?iPEOEFDwXSHA3o2LqPEG6JPN2LvVFRVCjatDZ2p9nc6dGDsj8G7iTJhNwUkh?=
 =?us-ascii?Q?Mga4E20yD7bAZJ6sB7oxmS5H70RRISWwXK1II6cGdmZxEKfcGOOfXGHNTRBP?=
 =?us-ascii?Q?kAbi5uigzvqya3h9EeMr3BT0iNr10dIGNxaYAG6OPBcJ/fZIkD7HqNoUihdZ?=
 =?us-ascii?Q?wRe28fbW7QG5gaVYK5PTL9A1bg89Ym4minyGeMChdAApwb0LqzGsPysLM4v6?=
 =?us-ascii?Q?JDR3mPB6zAMPJbP1JSE3YRhlyBVMdBGEPjl9icIbjdnfwP0XMFECwN00d06U?=
 =?us-ascii?Q?Rl2Mr3anvhhlAtozulTynBm9NFkPnB099xhTw3o8Wu8TNrxYOjboYBMBVexZ?=
 =?us-ascii?Q?GZTyN5BnqtjKyIj3xWPkRxp0Rz2yCJfjZQDJiOpMMPZ6Mg6KPeT8WwUMQVOT?=
 =?us-ascii?Q?IVLlT+URHsmq68rmWa+FIB3aiTWdMeVBisSZjEF7XSf+AFsBujHodbpPBq0o?=
 =?us-ascii?Q?WUm8l0qWNeMjBhk4TQqF4LDmPbgN+Pqu6da5SJj79AF8MlEkRj+UJfbJxkOo?=
 =?us-ascii?Q?34ifaXmwc+qxbGgnW1epq+VyhFovFyboxgUuNyjgSK67kZKBFlGR2t60OBlG?=
 =?us-ascii?Q?siXKt+apPNYOwyM3j4cuRqa5FclHpRYjlnmH98SNdng+2glahKH2Pg2UMWvO?=
 =?us-ascii?Q?gVsK3WFSSQAijbnstVMYSv6n41vgiydMetYVRp4W2t95Q2r6RHJa7AaNr+QS?=
 =?us-ascii?Q?4KwUQVNWORX7R7H0p1OKSBLi2fnu/g5fFSO049ZPq0w+LbZLAoUsAGZQXEMV?=
 =?us-ascii?Q?8DNCbbfNBqFL58XgdJU4sHMvklD7woTWDo3YKm3oaRsduClwE7XUHwwE8AZN?=
 =?us-ascii?Q?Ku++TEmniwZDG/+Y4Dk5Atntxopl9Ln63Z23Q9BA1vw+SEHIb5ZybMxFC856?=
 =?us-ascii?Q?7POYjCefiXnD5ylUbwu18mwhB8IzNC3mYN5i5Fx7WAcrqQsWHT/4VG77Q6/N?=
 =?us-ascii?Q?ULcwzuCmKBo/3nqRRbmJmoRujhXM/cIFe2uwr0BUeg8ZXO07Pn8gF2hyL467?=
 =?us-ascii?Q?mxr1+xLNuLhBuc1GzLjbUrBhGoUyW9ypBRvdyuM6iFqyetbwySiVSmc9CQN4?=
 =?us-ascii?Q?C+0zckLezGuaErjxWUo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:18.7108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdab8f19-813a-475c-b3e9-08de0a6d22f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774

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
---
 drivers/net/virtio_net.c           | 165 +++++++++++++++++++++++++++++
 include/linux/virtio_admin.h       |   1 +
 include/uapi/linux/virtio_net_ff.h |  91 ++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..520162985ad7 100644
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
@@ -6753,6 +6766,154 @@ static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
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
+static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
+	struct virtio_net_ff_selector *sel;
+	int err;
+	int i;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return;
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
+				 VIRTIO_NET_FF_ACTION_CAP)))
+		goto err_cap_list;
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
+	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
+	sel = &ff->ff_mask->selectors[0];
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->length > MAX_SEL_LEN()) {
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = (void *)sel + sizeof(*sel) + sel->length;
+	}
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   ff_mask_size);
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
+	return;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+err_ff_mask:
+	kfree(ff->ff_mask);
+err_ff:
+	kfree(ff->ff_caps);
+err_cap_list:
+	kfree(cap_id_list);
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
@@ -7116,6 +7277,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	virtnet_ff_init(&vi->ff, vi->vdev);
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -7131,6 +7294,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_vqs:
@@ -7180,6 +7344,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 99efe9e9dc17..7a452c6e006b 100644
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
index 000000000000..1a4738889403
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
+	struct virtio_net_ff_selector selectors[];
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


