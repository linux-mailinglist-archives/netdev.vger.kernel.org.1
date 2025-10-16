Return-Path: <netdev+bounces-229869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690CDBE179E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2E519C3E01
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2C82236E0;
	Thu, 16 Oct 2025 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOT+YZJI"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982622129F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590898; cv=fail; b=LZMie8MpJF9ZgMoa3/vEnnrDZfe0FQxi61W15vlf03NxbX+KuhBIcYtLkzx6+PU5yVkTkd6CeTwNUOylYhvECD7GuUG4j9WX3FpurbZp1Q0ay+lpUOQsXB1R522BJ8VoiE6of9WnyRnaYJUVLsqHLbGoUX2cRRl0Ry1cUQ0mRHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590898; c=relaxed/simple;
	bh=KfOEFdXlxj1Kn+EXTbQ9V0UQJ7yaRTDs5/2m3nfROE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6LR2jTjGn3BHm3Yd6uyNibIt0/htMuLaYRgkAMjYh9R6geR6e9GoGULlaoplTceOXbRvIxnPBEA6Xh3WPvQy/Dqu0TmB8pgoNXn2KRKGz6ycL8NORiZ/hRGdsX7lXvVsdxyEi7nYfuOhrIU5WRo2kGigKEZgKcTawPCfiaYlv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOT+YZJI; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuboUQ9H7iFBlnpQbbNXpaEOVygYgq8a/5eArsTNtFcLXwEp7BvKAREGr15IdDXrhhwCVT6chwgQJMoIdftlVBCyoIl0r30daIY9+dpF+kF8CdGmyrOW6MJPWd21m5ii2CmjZ9lg8OIeoH86VdHIttkly3eOhtULD/dbB28BGM30yxsT0T+8gzLYWw+uRG6ieflZQiCAdFcyi0xortlcKp/TcC2jcyW39Z2mNdyBqCE6tdpNNvB2xAIXWbn3QBOW1sa6mDiZNT1QlRkzHCYtRvVcs5B/yK3TSUVpSQvfC/Hx18YM4mNRRAtFQCfSPlobg5fFQj2H3g0G8+YLzQ8rlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTj18i8mEnbFmGK0F30c6aG6+gl8AYLMFfypYTbrxJI=;
 b=RiSDJuA3RlBxRaMfsLZR6UNXxsljMPwYHUBbvvo/5ZtrGsE2NHsoNCvveVycfKZad8aEt7dadiYgiedr733UrNRKXFwEXLQYPlgNXKJGM1jfD3hxa9fZZ4G8VZmzSLt+El/ZCYgu1Rdug7OGdJJnlCfnVzUJcPxbxV9Q343JqfVv7fTEaB+SB1esfLIOZIlhkMfjRKI2yRpqW0kiOLXSrR0savh7l/D15LHsFwJHgo1wTs/+LJ0JEnndMy3KjqAEspJLAf7r2iFOw2F/rpqlkNlK9TkKcYyqlOMpQ9mmk/LHG4zWwFvmgFZIxsPwFqdoJ9xq3G4OFmc4wtLmMgYwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTj18i8mEnbFmGK0F30c6aG6+gl8AYLMFfypYTbrxJI=;
 b=kOT+YZJIhi/2icw1Gbx3CFmGWvDxNiKGf/ia2jeOyMkP0v/YI+7zKznIUcXl2FMvicOkkm6D3De2gzruS2PDt+hgYAt68+luMz4k0vuCaR8sDoa4QtbFxWvN+lp0hpB1LIH/dB+e9JrKT8hixp5w4g/0ATTWrEArMMiLU88QDajWqaznFk4KO5OkczxXhj8T/DQvZPwlqg2ZJ7YvAfraJ/1AYyBNZgF/IsPtlCG8JHuyzNSq4XxGJF5kKimcYx+mlCSq3mnyfbMFQgGtv+Mq5MRviAT/eJQ8WfAEMo/b5+nic29VaTEha7rJoaM59vGYN/Crdpzee9XdNG3s3cR5eg==
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 05:01:32 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::a7) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 05:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:15 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:13 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 06/12] virtio_net: Create a FF group for ethtool steering
Date: Thu, 16 Oct 2025 00:00:49 -0500
Message-ID: <20251016050055.2301-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016050055.2301-1-danielj@nvidia.com>
References: <20251016050055.2301-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a0fd3a-ba0d-4648-bfc3-08de0c71135b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ObqngWK5yvC7kQ555vPiPjEC+D/xtLxa4O+m8LrQGj+FY5xyoN9+t5DmYnwc?=
 =?us-ascii?Q?old4YqYhb99IujXSJQM57oFe+mBABPnHtOI9m/cjMJzVv6EnNcF8ZEq5VpXh?=
 =?us-ascii?Q?EmqIBTN4q0DgDUPr2yE6+vsj6nIafpSnVkdIrBVB/4iq1hegTVP0+yfWYIYz?=
 =?us-ascii?Q?r+AlX64G60WJBwmUYeEWdWm5jKCcWKIG01pFt6Ed09TiYZ+hRwfUgt0evar+?=
 =?us-ascii?Q?JenqsYgZ+rjfFB4pWK9hR8DQ6acdJvu1SlZlQJpPFlxNrB7r7UxwdxbKmiZn?=
 =?us-ascii?Q?eO7Y1IGyI0G5jHT1DsRzj3RDmwkKbXfstiPcNTne6kZOShUIh04EVwybf7lh?=
 =?us-ascii?Q?lBd3liNBu0spjWVPpLZfovi9ge93apOFsOy5//KPW36TUzTLm5ypvAdnRQ6d?=
 =?us-ascii?Q?WTKe8v1l1BgP/FG+YuxyggKe81WgyF9wDEeQeHHkMdcrQu6bOmABeGwcwvY8?=
 =?us-ascii?Q?gfeeCdahd0IC7iYBQu0nypydpVhrFctkob165SEi/gDntncdagPsgYX/j1wE?=
 =?us-ascii?Q?rGtEi+/VAZhavMIYuCP25lqgHZURd1hhV9STY1JUDFrqQugd4Qq0bvaBXfZo?=
 =?us-ascii?Q?8GDePhSxU3miM8BdLUymo3/lKizyRj2zLonzjUCA6EiSbLp8IoWnaPDXLq9l?=
 =?us-ascii?Q?fmJ4KUBL7RN7CUpTs7H9Hepdft3KY+VBuT3yZIMxuFzGxjJZLHulnXiEBNgu?=
 =?us-ascii?Q?iqqEkZEG7T3gce0z3tyMdlU1BYX+ghtI5N+jNjAs56zUT12KrGW+xPIQAa0m?=
 =?us-ascii?Q?KnL8zVL74Y4BRU3MzHv6ce85UIHwBmCAgCw2JjltcGEDFLbe2N4mMk7B5vct?=
 =?us-ascii?Q?k18yChhqMUW8pIlfp9JCDALAKZo1+nIyjcmpKwzMLNSYiTWR2tFbXbCf1hjs?=
 =?us-ascii?Q?x6NTPBZz9rh6Hs17gTf0FKtAb+hMbBVwdRDikpFGzri92ws91741hivoGvHj?=
 =?us-ascii?Q?LXVE/RZhpkM8mIwdbCde7W8njfkCHmttaK0LzRWAltYhHqervJ4I4fRtFUDO?=
 =?us-ascii?Q?MX6rUTG31QpsnC1Yt7PIFbRN3eryFwwf5LswYel8ijRE0b4Oxkc0A/DDbxSK?=
 =?us-ascii?Q?Szubkq1v44x9eaforYJsOFFTTdPcNWZvJdPqu1WGTL+1H75J2R5/Dnjr+Vf4?=
 =?us-ascii?Q?mpxYFTr7duEAxi7iZo/pqpU1hxQWRODXu3SDgTrHfrFR3gO3XvEGV9bs4QPY?=
 =?us-ascii?Q?A8MgYL80xqkIbfnsntx5WK014tVtBt07Kn+/2t2K/Dk2XotblTFCDo3w6Mnv?=
 =?us-ascii?Q?uAInMeK1hN8XdVmmneAOEjoPhAcxlI74/oo2bEXiSJcoEjsps6QiMVHNvGvH?=
 =?us-ascii?Q?zx+56o55YyuIKtUbYp1Ahw2DC5GWi9IBAT2AoDHT/NOnhjVWxdG27NcL75+O?=
 =?us-ascii?Q?LmRVKsLGW3QV3XZP5ksVfY8PvHe7btoU8aatieFNX/v7PfI7t+1CN1I/SyX6?=
 =?us-ascii?Q?iruYCiCoPFHlmtY6OTJJMTBfc25CVg779sn//SSASC4q9cXOBtoGVTSCGBva?=
 =?us-ascii?Q?nv+OWBBz4arqhNBzeuZpJWx1aqY9dOtCuNTy773jyN/bgtKDTl9krA+snF8q?=
 =?us-ascii?Q?4jxYiagCO23Pfla4N9c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:32.6886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a0fd3a-ba0d-4648-bfc3-08de0c71135b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4: Documented UAPI
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 39e1694b7bb6..4b00a130eb7a 100644
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
@@ -6791,6 +6794,7 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	int err;
@@ -6854,6 +6858,12 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -6887,6 +6897,19 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -6909,6 +6932,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
index 1a4738889403..eebaaf8f9468 100644
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


