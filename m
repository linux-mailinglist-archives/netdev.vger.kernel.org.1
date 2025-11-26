Return-Path: <netdev+bounces-242004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D722DC8BA58
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F643BB401
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CE347BD9;
	Wed, 26 Nov 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBr2fA4c"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B03469F3
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185791; cv=fail; b=p6tZpF0+vZNPKYUIBMNCA4T9yoVu1uwaDEeoPXiBZE9880gtorSr6PTkPB+U3qenTrRFnO73xy9oJJBxebb6CLSbEkWeviYQzORW7GoCbOxsST0HdiCEaD7LzU598gqeFo4x/B5/WINW4utMC9qwWHFbkmHYJ58lwLBi8iw70x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185791; c=relaxed/simple;
	bh=2nw2w3WYZ5xa8pA930jjQaswAJOhimTJzLK+q9feIpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq2W5NGzFD5joxjgPMFJMTjT4GNYuJDViw8s8nBePot11PegrIkibNCN1H17LhMMevITW1ukhwL86+bpoXWYGT/VoH5RZ/uCIHlWEY/bfdThNSqNu3WlUIngqu8BLwokKdhEYf6cyYeaaTTsoH7waavHCrN8B2HvC8iRA06UFgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBr2fA4c; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuQ2d2yXnR4AJ11SBuCdD5PfwsUpqSxcN2cxWO2fXx4MW68Cu7h/dC/iXR+/kB5fKk7fxoTSCXgzvpLaAKRSoTsaWQMEinMguzVJgsRzZJuR7gLJO6z63KKRuX9uUYcayod1hqd4ZFOZtNc1kn0EDfa601iaKsx7KxXNiHVpBEkK/3YWqpD5ZO2MkRa1A4dd18XGWZwOqDVEzk49lUtoqaIXMFxhul8vwlFVVWV3xzgTf68LVXP4I/iBCahcYPowxaUpU7iU2hntlu8MjgLt/3CP9FFNMXcpF91Bk99h/n7aLwpFZet/NLIWn/rkYuClXmCdxmz0o970FNdyx8KVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRdYTQYJqEAGjrjCMo+iTbCzD9kbyKikOTt2vQi/XqQ=;
 b=koNj43yetqLs6iUq5GlCx6fOT9UvBFEtsLBL1NhEFLDdl7NRfl7O9rSM/z7NuRZ62U8oKV3yX0P12pttdpUVWkkTZ6VjkY+MEbmn35Oms9IZNFPz/UwAW98Ce746BIgBmc3Lr88hPo93jCcbkCUSKM6jHvDj/bw/LTdgjYmEMF9X5DowUy4pERkwF26SrYhsZxWziD42xSOWO6ft3zgrPO4z3I8cM4RTwBpVNEBc9ZtxrUboCovAEE/6h0/tZjdNDzq3bz+oR44DIKd4ApgWb9wn0kDzOgmpGoMJbUQtzwINb9MEU2VWNoD70phijkohiWOqnRn2U1bsw5p27zejJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRdYTQYJqEAGjrjCMo+iTbCzD9kbyKikOTt2vQi/XqQ=;
 b=JBr2fA4cOWQT8LuJbpL8T26NXd9gc9dZmSa9jPhZSXi/hHaNrS+qs5dWZy5SjiWTS9RhXH6BMrQimEshU46VsYQxlYrV0YNZl0kjK/1euQXw5dujPgO7TX3AuTnHhttcwpTStTqlGXHEAMqMa9wkCb/kUtIL42sKMAnslCnsRm4NWG9odVUiLOjACUsucnMRvuC7pMnm9jO+oqg2yFShTCm7vUjK3PAi1THm4WfNdo4gaHfLWqdWv3f9bk3SfcR1oi5RBLKWLVXw0mXZy2FA3KVt68OiBXfgCWsyYiOeXSuY+3cfqODUf8X+igVXpfqSy5LTjQvcxurwkaGwse5zIw==
Received: from CH2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:4e::15)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 19:36:24 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::a1) by CH2PR02CA0005.outlook.office365.com
 (2603:10b6:610:4e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 19:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:36:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:36:05 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:36:03 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 06/12] virtio_net: Create a FF group for ethtool steering
Date: Wed, 26 Nov 2025 13:35:33 -0600
Message-ID: <20251126193539.7791-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ac2039-f6e3-4e30-3849-08de2d2315dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zI++K4z4C/PZV0viVmhkErX7R1i8K/lY5On2/AMWx9+7oHv2QKq6PLtw6qWi?=
 =?us-ascii?Q?IeiPf5mf8UZLFl8FPJD1fCiBHxtAhmAbluH7plkalKz4xZd7Y7U4rfO2bi4c?=
 =?us-ascii?Q?kRHK0BNv1xvKPAYCnV+aw97eoZx62s9BQiQcl/3gJNDU4xXovOASHLM8JaAq?=
 =?us-ascii?Q?II9anFUI/UnGCUrEEWqedKTlmG32X9N9+0y5iw/EvComCX6Be/LcV5Nwuh9h?=
 =?us-ascii?Q?8tYLSHw2useOBFh2zfzgeZXIfOJ/q6FoibprzxoapvU+L5grX+K32nXPLt9V?=
 =?us-ascii?Q?gvot4bkHUTRcoplP5JIMmMXjbnpoyx41p4QtfWfZxJVrLOH+hBAKJgvAe+/e?=
 =?us-ascii?Q?0RaYL5YgRKpOoGeFhTpkeojFPu5w1jIqLGQhVezwHS3RuRcme7+jnJHALh/S?=
 =?us-ascii?Q?4/KPsboaSL9aTShP53JwCRmS0AvHoSFX4eo8Hgp/1wJEgLry/MTAESHaL/qh?=
 =?us-ascii?Q?8A1gcMcCFJTS6cg8/zETVPLjqMkEJePXqUPDZCbF+WRbz9AY+ZJVTzAWRUrD?=
 =?us-ascii?Q?Jmtfl/KR6bl5YsLZpClxoXm2tGJnipjwr8kBAw2IWFN0NXjjhWqjiKs102zj?=
 =?us-ascii?Q?VYclof2agOPUd4FDeUSz8vZVAhzsHduW4wQpVtHw0CiDXsZ2irxt0u9d2Cqo?=
 =?us-ascii?Q?gf485LdhnxXxFIEsTBhqL+813X9H3/gOJnYeZ21ly3Rn40U3dYewBp+RQN4P?=
 =?us-ascii?Q?44sFf5KkBIdBFylThXVWd74uJlgts6JffwNNApm2YPmq5HzEgz1557hyeBhC?=
 =?us-ascii?Q?/UQcfB5GDPorrEX99z09HWb95wRKMKF5T2C+ZtpoO/BIw4j59af/cCbM5qwa?=
 =?us-ascii?Q?DCH7xSXTozKKlhYULRgCaF2aJCXlqkV4vUPjurdMGmRUHmskj6ygAFYCzuGD?=
 =?us-ascii?Q?9OXHQTKF38HBsb+GZvNarsJIM5dMDXxxY+rVICXG8GaNQjgS4y5zxtl2HCuX?=
 =?us-ascii?Q?iENABbRnMCijmkycIfgp29nuridtR26ODKaDOtscu0NjWEQX8kO8Lp7/ynCL?=
 =?us-ascii?Q?5O/4yQObQW26l1F/npbkgaVKnBqgOaTm8XLmnSuV59mPh/2fRCRKDBhyNIH8?=
 =?us-ascii?Q?k1pcyMOSnAYrW+bM0SHqk9bzQKgk4re+fKUX/mRZd5oajaiZZzK3b1te98E+?=
 =?us-ascii?Q?ParPQzSWPysyyDP9Peyls0PQ0Z0HNw1mT48VFD9sCHviFwo5cY3fyJtHKZcv?=
 =?us-ascii?Q?kWUWnsVybADtVGHE9fNetqTfU4Ojc70MH4ZvIFYFVkPBdPJk7ofDBdjhAGn6?=
 =?us-ascii?Q?NXWFvVkl3BhqNTdIYXAGZ7UstjHJWhnM6VgcFoytSGCqm/lejxuA5+QAYvju?=
 =?us-ascii?Q?g0EKm+QWCZTUc+Gpts5nLaj72XH3opVdCGoifrojPg+awZlPEmfd6udUnY9k?=
 =?us-ascii?Q?k9eIHnRmFaJtzH2HXhEk5g1ga+9Bfu2GoFQ+LxZFuwBD6Xh6tucUx5AE0/rA?=
 =?us-ascii?Q?EGFqvw9EepzyuG9+6NLgK9L3JiHhyhYMRRpUio1iDAiG7JByADAruI8ges++?=
 =?us-ascii?Q?MG4kFlP5sgpMO83obLVm9rt9ltvSYdJZ4Oa6xX7KEx8iuDQ+MIDhATomecSt?=
 =?us-ascii?Q?6YE2cWe/1PcQ3lP4OlE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:24.5643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac2039-f6e3-4e30-3849-08de2d2315dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Documented UAPI
---
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 40850dff61a4..4dfab53fc2d5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -286,6 +286,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -5808,6 +5811,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5892,6 +5896,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
+
 	err = virtio_admin_cap_set(vdev,
 				   VIRTIO_NET_FF_RESOURCE_CAP,
 				   ff->ff_caps,
@@ -5938,6 +5948,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
+	/* Use priority for the object ID. */
+	err = virtio_admin_obj_create(vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &ethtool_group,
+				      sizeof(ethtool_group));
+	if (err)
+		goto err_ff_action;
+
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5965,6 +5988,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 	if (!ff->ff_supported)
 		return;
 
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
 	kfree(ff->ff_actions);
 	kfree(ff->ff_mask);
 	kfree(ff->ff_caps);
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index 1fab96a41393..0401e8fdc7a8 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -11,6 +11,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -86,4 +88,17 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[];
 };
+
+/**
+ * struct virtio_net_resource_obj_ff_group - Flow filter group object
+ * @group_priority: priority of the group used to order evaluation
+ *
+ * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
+ * administrative object. Devices use @group_priority to order flow filter
+ * groups. Multi-byte fields are little-endian.
+ */
+struct virtio_net_resource_obj_ff_group {
+	__le16 group_priority;
+};
+
 #endif
-- 
2.50.1


