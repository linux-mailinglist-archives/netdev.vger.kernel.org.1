Return-Path: <netdev+bounces-239595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F6C6A099
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 227ED2AFFB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336DF30EF71;
	Tue, 18 Nov 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tCgWBKD7"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126C350A1A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476776; cv=fail; b=YDFGFLndTB7rVSKlOmC0a3FnvfMchS986bUiTxCmyktkuwuzl7wCTE03rcm+wTEp0b6IfxgrlXsAxA34zVy1qY4hUBWXvqS7gI0o56R9+dgQ4QYeHZAwWrpBKoHMLDtzIRIx0SSdZFat4TzU5zpMXaxCq6PR4g+fzXjjNJweboY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476776; c=relaxed/simple;
	bh=LgrfQdJ8q6uHvbyNj8NowPzzkcXUK2ucGtb5cCplR34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg2fblww4uEYDrh34h8TO9ztjLEgvMQ2GZiwCagcJ+fQHA9a9p4l9Q0qABfMFpXZisIo91fsTDGc6kPk6lmQhfXUvtNIP2MgXE3HxjOgj74AA+oOYnF5YMEohZwMxxauTLgRqJcz4E9S0mRlmNKxKHO8qW0UPPuj3mg2I/eSGzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tCgWBKD7; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnqOL45FeXI3wM5Bb1KwuNjmaoOFXERwe38K8VtKFZinYhoRKUjmCKJodcMkLRdUY+lcchcxbOtuXb3fD0I8wLjtXq6jhPuklWsEMG/PCmJeYHxaFUeVmwy5iUiuYWSqb9rEQJh4wKQbA5C8agbyoLfw3v0r72YolOAUEScipVwM8/hQald/4TiJfABpQGgxKcbm0Mj6bxbRaXH2TQTKmcW4T40WlUn+5RKhzzgP9q5BYxkTsryJCRz2lVngS1s7uu+hwTgpmbTHZ6WdBkrLNkINiCzEWWJms4HtFAuxcJQn5I0RlvLIh7plvoeGTmf2mb3ZVl3SQqxFGc8zHgeDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFgQcDA4RBwreDPieoiO8jspyq5XE7ojDG50KqUBLx8=;
 b=WT2Kk7LA1GpnbLLlEibUSQSQXkPg8mFatGQUR9WxQQ4d7pI14cojE7ky64rUxHh43H7FhGMeIEI2vMO48Xbh2cJfPlWHCowV/BcSEc2DGhcCBMGkfAYZkWprVDWzpGhC/4Pbhh7q7gaMwOjONAHLfZyLyFz2au4Ep3TqEqfjA4NuvqZLQW4Veh7KhO7cAkSEAQaYSw2q0gP8OR2dojM3tsj/mjb7Dm7+kBqOPI62QyW6oSolNRgyXj8Rc6g8zzC8JvuZasTPHJfeiartYeRHnVXbQXwtnHgHIB0wXuTbkl2zqkLJC4i+NImpoykij/zTN832+zXDcOo3apG/kRXoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFgQcDA4RBwreDPieoiO8jspyq5XE7ojDG50KqUBLx8=;
 b=tCgWBKD7C/uY9/GZh/o2Qh3XC9vuKQfb8iiI+uD4MYus8GJuHVFsM1OfBXSwjgg92AFGsLS82tno1og6k4zZb29dG0TJ+vuC+i6hWf0M1shOHHMU8Vs1CLSJ4Cq3avEXIpIyBsZtj5GEQAOmAN+hxZZ6XBzHNbQctEZ6XzVNQj0Sdhhqz8ijK6zd+AncdU1fEYddtIaq+gi+2iEFJRWbUVRZ3WFG2CwkzztTNfPfouMkeORGi+DSrxnR6/fgqcI//wR6UB0CjIB2Wq5TESH9UiPWdEJlRVYlMn6AzUOvkmaADFuD/qO4sGOMr5Luf5re3WFCJVGeolf7PKB+Jf+S1Q==
Received: from PH7P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::17)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 14:39:30 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::5) by PH7P221CA0018.outlook.office365.com
 (2603:10b6:510:32a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:17 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:16 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:15 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 06/12] virtio_net: Create a FF group for ethtool steering
Date: Tue, 18 Nov 2025 08:38:56 -0600
Message-ID: <20251118143903.958844-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: d02ba1ac-266a-4856-9e66-08de26b0482b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFwkv5JTmbYO+uDfS2tzvkYkrdnZVJE+3fB/ob6RjztwYLuIPB5cGk65HYnm?=
 =?us-ascii?Q?mohoAoBED+tlGWBN8/CKfl16kiBf9O38FmJNMtn95r7m5N5YvkESFAyP0t4G?=
 =?us-ascii?Q?ugGCTn5zXiS9kxShdtzfAGFCanjB+/lh40p3cOWOiwuHyRdl1SvnJHCuItxD?=
 =?us-ascii?Q?QMqHwSTXXuJ/mnEVVPqKiiNBDXVxcNfgdEbskQHQdTOk95NChieNhg540TUx?=
 =?us-ascii?Q?BOqq+mBpvz4Tq9zTTl/nKTGG2jTUy/K5SG1KraIIEA7bfz1a3ylvpVQQQP9v?=
 =?us-ascii?Q?agx+EligfF7N4Vprg6TDWCHwhQwewChanvhAl+ottp+OoEP5n1/RCEUf9rP0?=
 =?us-ascii?Q?gxfBxxaM+KaHyWFOvJ1uw6dQxj4rGxfZAxpMsSejd6NVxLJQzpt25WkBVrk6?=
 =?us-ascii?Q?crpJ+qEt51ImFWtNj+LTGiEmlcRW30WaDy3un603VZWgC8IT2neIZdBZMf09?=
 =?us-ascii?Q?D/LRmnwB3EmCS8maMe9HGdD04Dutx1viiVZVG0YZe/UcIdlOdpNmUB0BpACs?=
 =?us-ascii?Q?Kp/uQMhwTnJFYEr1ffuZ5H9cVbLK4pwcFHBIFNVfpJjtV5gx+M1sVZToTisy?=
 =?us-ascii?Q?RdQRmvPAZ6tTVoTt+ggrnjkfz168L/AjjJ5BMll7WsxgbBpY3wTqkgQKDgGI?=
 =?us-ascii?Q?vW5dTsgOggVottej9wyuCsVMCBK3S1FVXQunWNO3IsQfMgG/l4GNr6vDrjRS?=
 =?us-ascii?Q?Un7o+yn1rPdSpIQ9XmnRLCLgDaD7xV1rAcaXHS0uQkU+Ijn31TgBZVFzBXlH?=
 =?us-ascii?Q?7FrJlkVK4sgrCDVe9AwgnRwaBnZdzSxijUqPB5INAHQmENgIYYG5suA2XMXZ?=
 =?us-ascii?Q?JwZH+sRZQrHZsqHJBXzkj3Y+lRCqRokZXKAUK2j97d1ko6EdDPJmTnhFD/VH?=
 =?us-ascii?Q?TqE8NWyJlVBKl3oLKv2HGCIu3mbbNfSEzXhWaGH2ps5Hf72/QlaFkEMRRTEt?=
 =?us-ascii?Q?LfHkIYj9NJ6QibEPoZ/Q0bAl5MoCRKfMr+QOEr6pFGOLwsg1He4j+35D8j+O?=
 =?us-ascii?Q?GyYuw5FEitl9IuG5P5lWP6KVluXx4EDytMLglNZguJRd4e5AEHGui4mk3vo4?=
 =?us-ascii?Q?O+IQ7yi8K8f+pnRGXuYBZYEYQGSgIlb0hT7k0c73WcBCuGRj0389SJjxFtLi?=
 =?us-ascii?Q?rGI9c7LeIPzVB/KPh9AqDgB2/Y/8VUWwvnmGHuQBxezhgk3+hBUouE063T4y?=
 =?us-ascii?Q?NeJwgm4X96s4Uue2ifqjp1KnNL/Oahet5f0Lmm3FKjwaqqhQcjp4DqGRfLTP?=
 =?us-ascii?Q?S3qKWs9Uv9aZUnd9jhMhE1bwa/VzKlsoaZgoKVBwofG+MWcPDVkd3q54OZ9N?=
 =?us-ascii?Q?YW2PCm61m7iDOZ8bk+TgDD/YncictiLCpFfiQPzkQFxX4OmHdLCBN29qWCqP?=
 =?us-ascii?Q?SddkWITIfdd7VUsqjKYIYKcQ0035MC5en7gplG3LcX3epYbfivMXtgmxRcbE?=
 =?us-ascii?Q?hFECNx296ni9LbrdNhEe2qEvSYEsvVfcfr90Gjem9wB3nh2sPHXCN/WBjsx8?=
 =?us-ascii?Q?ze/JeZiKFU14NnUk3flENVW0Hc3fwvjmAioOcXLk3YJ1Mvko416GSCFiRl0e?=
 =?us-ascii?Q?eE5xqgtun16RyEDKmhU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:29.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02ba1ac-266a-4856-9e66-08de26b0482b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Documented UAPI
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3615f45ac358..900d597726f7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -284,6 +284,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -6812,6 +6815,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	size_t real_ff_mask_size;
@@ -6895,6 +6899,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -6932,6 +6942,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -6959,6 +6982,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
index bd7a194a9959..6d1f953c2b46 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -88,4 +90,17 @@ struct virtio_net_ff_actions {
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


