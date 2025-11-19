Return-Path: <netdev+bounces-240127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA4CC70C4D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 421034E2456
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F19371DD0;
	Wed, 19 Nov 2025 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RmHvjonw"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712936C5A0
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579784; cv=fail; b=QPjl5vZpOZr0fvNNLDgvPwob3lc41odUS5mUjN1uEFnjTgcEpe/nAEVYH8D7oTdGQl5P7l78UF9bZT2+XZ5kTGl1bWarxI4ooWTNCUQ1DpCJA7VBVFEbS/2Il8EihMOLEQdnZZbYRwA2oa6MHyiTJ4KfFgK5e2wV78IJjMfDT4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579784; c=relaxed/simple;
	bh=kpqFGu9RLdKzHoh5VsXzUQ8X0koEGhwoXLrMTTiTnBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PudYUtNC8t/PggU7ZWEQAO+km7dCzL4iurr7uU2DXwFQkgRxvCYsdy6uOKV6bLy0JwcO2jHlj0twTEd/LF7z12vqCJIgEI4rgQzYbUPwXG2DSu3dI1EHf5Q/Qnfg+qSxAZDQsPYPVd9YGqGqt01NOuNls9o/Ml0laytlx4YQZW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RmHvjonw; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU0ajth4Y04YpP4iexsU4o246zvoy8rkDcitbMOa1rJODjaAZ/2tiT1pAOFvpgXwgbNnd73e/pQOmeNbEUunyYBFKGfYGe1wo8ayni9X0WTNKVivt89xy8jjELqswfDfvVm7zBohosSiFR4spV1aFs1+/nY4uWisCmVvOtRLSbI/vWbzSZb0swcL8gPXR4yMRQSnQW0td+fwVoWDIs/XVw0TKGZ3hs0kBkRbzNFNepiWnEK2bN7sVW+wxkPdg5R8QRxStOPEdIi58JD5TzMV4JnzI0+ziPh6VL30sAh+lJKH6Zq8BCFhuPcndOX66ynoVh/xjAATvv9pJY0s9wTnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zba6Uql0yelv5u1x/rE/yT6c0FtVALPl7xEhTAN0dtI=;
 b=uMEOeMd2nqhsawh3Xn38Dr1pbe4ROlxADDPFbbBZlcUUqv+Z5rmULrpS4N2r7AKJUedyROVH5vZytzJX+6RFNAHh3Vm2jLx7/X4nK/kTHyodYPOYXPbiJoyP01S3TXxC1b2hEGbKDBbZ1A7pa6il8S28rpvXEUZ9CclFWDLEwpN2TBBT6LGycUkktzdxJeW0lquIgnSpt2GeS09IuoAxv4bH6ff1FDDyIArjTFEh8VjwEurxOuCNa1n+RkFcbsqKOMLX0aMF9/ypFfB8PVFTBIMacDdaPHeeiGZuJyDzrWhKDgt+ceVlCqkTBu7NIKa2oK3eM34uN8T8Vf1UmetBZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zba6Uql0yelv5u1x/rE/yT6c0FtVALPl7xEhTAN0dtI=;
 b=RmHvjonw/FEpRtI6ZLggZL7s6nYSEKtS5We9+ZvB7H4t5jylLUuRRueVr8jp0wKeFa2ecIEKTVv/uJlig9T/AkAQKaRrYu9yEH01I4NM2l9bInb2N22q4+5w//twb/cdVaCmcLqvju/cxu39YuQBt8mvGlt0XMhFmenvf02ePqAdC866XM+YO74+Ll5dxYAvCrC9Bqr5rl55tPmiZ8z9XdSjAf2d8HDtAQFWmQZsqEYEmjXMSCLIwZDbMxdfJPPcvlCpydBI1URyERR9YXZp6+l+aLab5PHHZv3RmqJLrkHvom3DyQTRolUzG1wzhqnD4yAk9kKbGg2QSce8u1Q77w==
Received: from DS7PR03CA0193.namprd03.prod.outlook.com (2603:10b6:5:3b6::18)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:16:04 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::57) by DS7PR03CA0193.outlook.office365.com
 (2603:10b6:5:3b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.19 via Frontend Transport; Wed,
 19 Nov 2025 19:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:16:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:41 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:41 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:39 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool flow rules
Date: Wed, 19 Nov 2025 13:15:18 -0600
Message-ID: <20251119191524.4572-8-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: b56bf98c-699c-4ade-8298-08de27a015d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibxksaHVDr7Th7N35UgRuKWENq41dggJJDUNUJxY/gnQIWNbuLDEYvFFmMhk?=
 =?us-ascii?Q?Tw8fv0P4ELHUKRQMaYN87m0Y9zXONMQ9eLnrcmAo3BwCT0kHQA0LWSMuHGs+?=
 =?us-ascii?Q?r+ZszRBIYVUur1w4qTdophDkUUEDPS23/w3hp98zYLC0NMmMX7jST3iL44TC?=
 =?us-ascii?Q?sRUVo4jJBqxJ9wIH0gPLzbJwXJIqPNL14MCAs7Xe58O44TXtuJfU7AqxZnWu?=
 =?us-ascii?Q?5AupgmEUy0b8f1LnuzYU8JkfFNNCHWMP3txWrw3cuJnZUKLyRLtVGVTzi4xT?=
 =?us-ascii?Q?D3TX8YwDaVGrTOgurYLa2kXOjxHjlrG2GO4seO2Z3iWmKYKf5eLGwKSa7n08?=
 =?us-ascii?Q?X2WW7BAPneyiZyWHZsI4avF12p3S/QHL2ymupgKZ3keYlDg/J9+X5QaHW0lQ?=
 =?us-ascii?Q?5Hh2073F3LtCWP+SqcmW2rnUZedtVtzNdyShVQ7pvuIPt/ZZSvN752G3erXl?=
 =?us-ascii?Q?csUZE2foJhJgmCFkKo9bl3j2z391teBt2zwjfxQT2mE9myLf3ML15Ix6HBnu?=
 =?us-ascii?Q?RfdQ1+ab+doX3b97idoY7VvZ0L9VNv19HRfMH1muwxVkFbLD6yAX39H74GX5?=
 =?us-ascii?Q?lev9N/P4u8IuWp2AMrtpJNz2MF9pQxh3/6gn4ZS/b+YX9saU/TGnXoXvyR24?=
 =?us-ascii?Q?7k26G5h5Qa+cXLOhuFclLc14dlAioJPkMRQ5NVqHWeWEy/5xPdO85sNelGRB?=
 =?us-ascii?Q?lA12wjkTWj3Pl3IF+IJM02xkLstHycRNDnN9W3mK2pyPmuKJxso94bWEuchF?=
 =?us-ascii?Q?EO6wcQAQ1f3oXCH8MRftsTuBh4ix2QpEJCLvHwBys8KkkP4GLgyHnAo86L2Q?=
 =?us-ascii?Q?vU93JuVo4DAO+25+2wgtFx7/EZrYZya0QvUp3+1z4LwBXxgX7IcBywiWxmjL?=
 =?us-ascii?Q?V3ERSZs9QS7xhpP04G6vAb/t+bVTq+M8NXnD/7llkUWEi8bbWsX5ASM6X0hY?=
 =?us-ascii?Q?58Xwul8QZfmKavKLg9orTo8atpvz93Yf/h/n8sv7Q2VW1C7kF906sAWumPyS?=
 =?us-ascii?Q?mlgj8SueMPFHC7uMFHKjdC5/76fEU/PkPr1IG9fYIcMvYdNeSt/ueMuTpbRR?=
 =?us-ascii?Q?zusdya+ypUglTNF6Mfq4ZYv1bCW2BtcqTjJoO1++D5Y58hKtmR+A9WCNIK+r?=
 =?us-ascii?Q?14pjAgicBM1UTYWdHoMpGPWeRwQY+0KElm/LOOde5LmAc7jdD7Y/jSIl5R/E?=
 =?us-ascii?Q?AoLZ6va1B08dWmx+Q870rY0UyoS6ga01Iv4ko+RoNtTfBPSjNwr6NfnnR5HD?=
 =?us-ascii?Q?bwMYCZO6SlnCv8ke56++AiNigKWuexugUlhHJS8We4qXSZP/qUANUTYRBHq1?=
 =?us-ascii?Q?xQUUUY7NHqEfpTjc4FIPpguwqaXYMpN3svmHqi487HRGm+WusgM2JzpYd/n9?=
 =?us-ascii?Q?treTFNwYS/Zgz6xsw9MaNuIzgFPOzeRAlTMhTwPXZXmwPpkiXH0zoQvhWLtc?=
 =?us-ascii?Q?3l4fZ4hn5K7KEipqJ1whq42ClXI9F6mU5DfGOj8TuaZEFoJwj0Fpik2iQBHV?=
 =?us-ascii?Q?CCW7xvvm9wqxfq8Pp/b1Yqaek926xFsBqznhJH2oV7QrczZRqqicc2lZDalW?=
 =?us-ascii?Q?dPGbt6MUILK1FtWquwc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:16:04.6541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b56bf98c-699c-4ade-8298-08de27a015d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

Filtering a flow requires a classifier to match the packets, and a rule
to filter on the matches.

A classifier consists of one or more selectors. There is one selector
per header type. A selector must only use fields set in the selector
capability. If partial matching is supported, the classifier mask for a
particular field can be a subset of the mask for that field in the
capability.

The rule consists of a priority, an action and a key. The key is a byte
array containing headers corresponding to the selectors in the
classifier.

This patch implements ethtool rules for ethernet headers.

Example:
$ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
Added rule with ID 1

The rule in the example directs received packets with the specified
destination MAC address to rq 30.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed double free bug in error flows
    - Build bug on for classifier struct ordering.
    - (u8 *) to (void *) casting.
    - Documentation in UAPI
    - Answered questions about overflow with no changes.
v6:
    - Fix sparse warning "array of flexible structures" Jakub K/Simon H
v7:
    - Move for (int i -> for (i hunk from next patch. Paolo Abeni

v12:
    - Make key_size u8. MST
    - Free key in insert_rule when it's successful. MST
---
---
 drivers/net/virtio_net.c           | 464 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h |  50 ++++
 2 files changed, 514 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 22571a7c97e9..7600e2383a72 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,7 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <linux/xarray.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -286,6 +287,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ethtool_ff {
+	struct xarray rules;
+	int    num_rules;
+};
+
 #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
 #define VIRTNET_FF_MAX_GROUPS 1
 
@@ -295,8 +301,16 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_data *ff_caps;
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
+	struct xarray classifiers;
+	int num_classifiers;
+	struct virtnet_ethtool_ff ethtool;
 };
 
+static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				       struct ethtool_rx_flow_spec *fs,
+				       u16 curr_queue_pairs);
+static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -5655,6 +5669,21 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	switch (info->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
+						   vi->curr_queue_pairs);
+	case ETHTOOL_SRXCLSRLDEL:
+		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
 		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -5681,6 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
@@ -5778,6 +5808,429 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
 	.get_base_stats		= virtnet_get_base_stats,
 };
 
+struct virtnet_ethtool_rule {
+	struct ethtool_rx_flow_spec flow_spec;
+	u32 classifier_id;
+};
+
+/* The classifier struct must be the last field in this struct */
+struct virtnet_classifier {
+	size_t size;
+	u32 id;
+	struct virtio_net_resource_obj_ff_classifier classifier;
+};
+
+static_assert(sizeof(struct virtnet_classifier) ==
+	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+		    __alignof__(struct virtnet_classifier)),
+	      "virtnet_classifier: classifier must be the last member");
+
+static bool check_mask_vs_cap(const void *m, const void *c,
+			      u16 len, bool partial)
+{
+	const u8 *mask = m;
+	const u8 *cap = c;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (partial && ((mask[i] & cap[i]) != mask[i]))
+			return false;
+		if (!partial && mask[i] != cap[i])
+			return false;
+	}
+
+	return true;
+}
+
+static
+struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
+						u8 selector_type)
+{
+	struct virtio_net_ff_selector *sel;
+	void *buf;
+	int i;
+
+	buf = &ff->ff_mask->selectors;
+	sel = buf;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->type == selector_type)
+			return sel;
+
+		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = buf;
+	}
+
+	return NULL;
+}
+
+static bool validate_eth_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct ethhdr *cap, *mask;
+	struct ethhdr zeros = {};
+
+	cap = (struct ethhdr *)&sel_cap->mask;
+	mask = (struct ethhdr *)&sel->mask;
+
+	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
+	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
+			       sizeof(mask->h_dest), partial_mask))
+		return false;
+
+	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
+	    !check_mask_vs_cap(mask->h_source, cap->h_source,
+			       sizeof(mask->h_source), partial_mask))
+		return false;
+
+	if (mask->h_proto &&
+	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
+			       sizeof(__be16), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_mask(const struct virtnet_ff *ff,
+			  const struct virtio_net_ff_selector *sel)
+{
+	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
+
+	if (!sel_cap)
+		return false;
+
+	switch (sel->type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return validate_eth_mask(ff, sel, sel_cap);
+	}
+
+	return false;
+}
+
+static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+{
+	int err;
+
+	err = xa_alloc(&ff->classifiers, &c->id, c,
+		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
+		       GFP_KERNEL);
+	if (err)
+		return err;
+
+	err = virtio_admin_obj_create(ff->vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+				      c->id,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &c->classifier,
+				      c->size);
+	if (err)
+		goto err_xarray;
+
+	return 0;
+
+err_xarray:
+	xa_erase(&ff->classifiers, c->id);
+
+	return err;
+}
+
+static void destroy_classifier(struct virtnet_ff *ff,
+			       u32 classifier_id)
+{
+	struct virtnet_classifier *c;
+
+	c = xa_load(&ff->classifiers, classifier_id);
+	if (c) {
+		virtio_admin_obj_destroy(ff->vdev,
+					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+					 c->id,
+					 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+					 0);
+
+		xa_erase(&ff->classifiers, c->id);
+		kfree(c);
+	}
+}
+
+static void destroy_ethtool_rule(struct virtnet_ff *ff,
+				 struct virtnet_ethtool_rule *eth_rule)
+{
+	ff->ethtool.num_rules--;
+
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				 eth_rule->flow_spec.location,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+	destroy_classifier(ff, eth_rule->classifier_id);
+	kfree(eth_rule);
+}
+
+static int insert_rule(struct virtnet_ff *ff,
+		       struct virtnet_ethtool_rule *eth_rule,
+		       u32 classifier_id,
+		       const u8 *key,
+		       u8 key_size)
+{
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_resource_obj_ff_rule *ff_rule;
+	int err;
+
+	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
+	if (!ff_rule)
+		return -ENOMEM;
+
+	/* Intentionally leave the priority as 0. All rules have the same
+	 * priority.
+	 */
+	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+	ff_rule->classifier_id = cpu_to_le32(classifier_id);
+	ff_rule->key_length = key_size;
+	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
+					     VIRTIO_NET_FF_ACTION_DROP :
+					     VIRTIO_NET_FF_ACTION_RX_VQ;
+	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
+					       cpu_to_le16(fs->ring_cookie) : 0;
+	memcpy(&ff_rule->keys, key, key_size);
+
+	err = virtio_admin_obj_create(ff->vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				      fs->location,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      ff_rule,
+				      sizeof(*ff_rule) + key_size);
+	if (err)
+		goto err_ff_rule;
+
+	eth_rule->classifier_id = classifier_id;
+	ff->ethtool.num_rules++;
+	kfree(ff_rule);
+	kfree(key);
+
+	return 0;
+
+err_ff_rule:
+	kfree(ff_rule);
+
+	return err;
+}
+
+static u32 flow_type_mask(u32 flow_type)
+{
+	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
+}
+
+static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
+{
+	switch (fs->flow_type) {
+	case ETHER_FLOW:
+		return true;
+	}
+
+	return false;
+}
+
+static int validate_flow_input(struct virtnet_ff *ff,
+			       const struct ethtool_rx_flow_spec *fs,
+			       u16 curr_queue_pairs)
+{
+	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
+	if (fs->location != RX_CLS_LOC_ANY)
+		return -EOPNOTSUPP;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    fs->ring_cookie >= curr_queue_pairs)
+		return -EINVAL;
+
+	if (fs->flow_type != flow_type_mask(fs->flow_type))
+		return -EOPNOTSUPP;
+
+	if (!supported_flow_type(fs))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
+				 u8 *key_size, size_t *classifier_size,
+				 int *num_hdrs)
+{
+	*num_hdrs = 1;
+	*key_size = sizeof(struct ethhdr);
+	/*
+	 * The classifier size is the size of the classifier header, a selector
+	 * header for each type of header in the match criteria, and each header
+	 * providing the mask for matching against.
+	 */
+	*classifier_size = *key_size +
+			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
+			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
+}
+
+static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
+				   u8 *key,
+				   const struct ethtool_rx_flow_spec *fs)
+{
+	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
+	struct ethhdr *eth_k = (struct ethhdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
+	selector->length = sizeof(struct ethhdr);
+
+	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+}
+
+static int
+validate_classifier_selectors(struct virtnet_ff *ff,
+			      struct virtio_net_resource_obj_ff_classifier *classifier,
+			      int num_hdrs)
+{
+	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
+	int i;
+
+	for (i = 0; i < num_hdrs; i++) {
+		if (!validate_mask(ff, selector))
+			return -EINVAL;
+
+		selector = (((void *)selector) + sizeof(*selector) +
+					selector->length);
+	}
+
+	return 0;
+}
+
+static int build_and_insert(struct virtnet_ff *ff,
+			    struct virtnet_ethtool_rule *eth_rule)
+{
+	struct virtio_net_resource_obj_ff_classifier *classifier;
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_ff_selector *selector;
+	struct virtnet_classifier *c;
+	size_t classifier_size;
+	int num_hdrs;
+	u8 key_size;
+	u8 *key;
+	int err;
+
+	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
+
+	key = kzalloc(key_size, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	/*
+	 * virtio_net_ff_obj_ff_classifier is already included in the
+	 * classifier_size.
+	 */
+	c = kzalloc(classifier_size +
+		    sizeof(struct virtnet_classifier) -
+		    sizeof(struct virtio_net_resource_obj_ff_classifier),
+		    GFP_KERNEL);
+	if (!c) {
+		kfree(key);
+		return -ENOMEM;
+	}
+
+	c->size = classifier_size;
+	classifier = &c->classifier;
+	classifier->count = num_hdrs;
+	selector = (void *)&classifier->selectors[0];
+
+	setup_eth_hdr_key_mask(selector, key, fs);
+
+	err = validate_classifier_selectors(ff, classifier, num_hdrs);
+	if (err)
+		goto err_key;
+
+	err = setup_classifier(ff, c);
+	if (err)
+		goto err_classifier;
+
+	err = insert_rule(ff, eth_rule, c->id, key, key_size);
+	if (err) {
+		/* destroy_classifier will free the classifier */
+		destroy_classifier(ff, c->id);
+		goto err_key;
+	}
+
+	return 0;
+
+err_classifier:
+	kfree(c);
+err_key:
+	kfree(key);
+
+	return err;
+}
+
+static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				       struct ethtool_rx_flow_spec *fs,
+				       u16 curr_queue_pairs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	err = validate_flow_input(ff, fs, curr_queue_pairs);
+	if (err)
+		return err;
+
+	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
+	if (!eth_rule)
+		return -ENOMEM;
+
+	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
+		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
+		       GFP_KERNEL);
+	if (err)
+		goto err_rule;
+
+	eth_rule->flow_spec = *fs;
+
+	err = build_and_insert(ff, eth_rule);
+	if (err)
+		goto err_xa;
+
+	return err;
+
+err_xa:
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+
+err_rule:
+	fs->location = RX_CLS_LOC_ANY;
+	kfree(eth_rule);
+
+	return err;
+}
+
+static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, location);
+	if (!eth_rule) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	destroy_ethtool_rule(ff, eth_rule);
+out:
+	return err;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -5945,6 +6398,8 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
+	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5969,9 +6424,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 
 static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 {
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i;
+
 	if (!ff->ff_supported)
 		return;
 
+	xa_for_each(&ff->ethtool.rules, i, eth_rule)
+		destroy_ethtool_rule(ff, eth_rule);
+
+	xa_destroy(&ff->ethtool.rules);
+	xa_destroy(&ff->classifiers);
+
 	virtio_admin_obj_destroy(ff->vdev,
 				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
 				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index 5883fdf4d37c..1afe69105076 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
 #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
+#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
 
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
@@ -100,4 +102,52 @@ struct virtio_net_resource_obj_ff_group {
 	__le16 group_priority;
 };
 
+/**
+ * struct virtio_net_resource_obj_ff_classifier - Flow filter classifier object
+ * @count: number of selector entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: array of selector descriptors that define match masks
+ *
+ * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER administrative object.
+ * Each selector describes a header mask used to match packets
+ * (see struct virtio_net_ff_selector). Selectors appear in the order they are
+ * to be applied.
+ */
+struct virtio_net_resource_obj_ff_classifier {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[];
+};
+
+/**
+ * struct virtio_net_resource_obj_ff_rule - Flow filter rule object
+ * @group_id: identifier of the target flow filter group
+ * @classifier_id: identifier of the classifier referenced by this rule
+ * @rule_priority: relative priority of this rule within the group
+ * @key_length: number of bytes in @keys
+ * @action: action to perform, one of VIRTIO_NET_FF_ACTION_*
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @vq_index: RX virtqueue index for VIRTIO_NET_FF_ACTION_RX_VQ, 0 otherwise
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @keys: concatenated key bytes matching the classifier's selectors order
+ *
+ * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative object.
+ * @group_id and @classifier_id refer to previously created objects of types
+ * VIRTIO_NET_RESOURCE_OBJ_FF_GROUP and VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER
+ * respectively. The key bytes are compared against packet headers using the
+ * masks provided by the classifier's selectors. Multi-byte fields are
+ * little-endian.
+ */
+struct virtio_net_resource_obj_ff_rule {
+	__le32 group_id;
+	__le32 classifier_id;
+	__u8 rule_priority;
+	__u8 key_length; /* length of key in bytes */
+	__u8 action;
+	__u8 reserved;
+	__le16 vq_index;
+	__u8 reserved1[2];
+	__u8 keys[];
+};
+
 #endif
-- 
2.50.1


