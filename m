Return-Path: <netdev+bounces-236075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7055C383B9
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A733B9187
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866042DC323;
	Wed,  5 Nov 2025 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sbb44ZxV"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7D2D063C
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382711; cv=fail; b=YVAKaPV/E3ZWH2nC2nG6pxr0AgodVx/k7rHMO6eS2FTcao3b8ARiNL8JVzb/xCh7J/mCjEBrKjV4MI/Dk219I6Jt/deHNjE69PVFJJkXn12LQoSrB6aSFiTT8ba9aq+5kw1vnUGuH6Iq8234davyJWnxqhgtmfAO5n+74r7KnwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382711; c=relaxed/simple;
	bh=Dyd+hrJPUYo18fihyo+xDb9foYNLQDryPAtoBaXDklE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbENWCj7hj19u02ZujKYEaYzmAy9gyK1p4KqyQ6Zrc52NptOEn0NTMTuma+FacwP/OYIaHYKuhVqPvcLkJ79nVyejjHlacmFu5rJnVvRXnWGQM4po6MKOefUrHe2vaCmw51OX+tLiJrbkEkzX9baFKTePvytnQ+4er2ZWw9r4yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sbb44ZxV; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDMIC0BX8GvdWgwz2kGHXJAfgfoHRhGqF7o2fMOsBhr1gf+aQgZ2Y65wi+CCSwKieWsx1NhOphk5cpuM4/hnnDD31ZgJKiqwnw2YjTeqYfoUOpRmbzJn7S8i/lCKZ9H+p9zRPsQRHTNkqopDb/XfDmWVhzMwI4zk8gGc3w/zDPAGrSX+YHd0EedG3wJLhQzl7OLB4NkupnfxwcbV0eVlnaQ2+XjHx6bv6E67rYGDuiZvmSNjxPlT99ZA7/y+lBXAk4kEqHmzP+tCG9PhnEDQ8xA3/s2eyH4qNK4ADcbb7jziwXMfsAx+ApddQ5peZ4zrwpqOAQ3g6Bm6EaPEjYapmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbLvN2gY2PP21wLw25gn99lNd0tiYV5huONSiHaGdXY=;
 b=dxI5jTrIOZlP8nqB+5/9sPgfyx99J8YQNG2ko210iTvFjzabsahID+BXv2VbYo5gyMEH+50Xe0DewZpjfHsWkMAdh+5nSbJWgWZsnlzAeDGB3yJwDbKPOvD6vh/ZJ/W35hlDUFyq9cYBkoUhWsYFVy1qqkPkX4TYN2w4q290/mV68iFvYnAQlbGIQy0oKM+FLqXCBAWYbBymp2BYX0S4b50vbMpeaamRaPo1Qg+IvvPsE+t41zYemCk8UioQGBtE8G6UsofCfFUXLmHXiObf8KUBU8JzsCCoU7Wq6OHWaz6056GJAZhnUuCaCxXFTcfKO93q1IjJT7N7dHcfLxzfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbLvN2gY2PP21wLw25gn99lNd0tiYV5huONSiHaGdXY=;
 b=sbb44ZxV7YjDj+EW1nRba1BjLHNjpA/JhCca4t6e+k8sXDnaDIzfTXHAXTqnXNv7inz9rwP6LF0yEBxWFGb0pm9fgGml+kE9NO3RYBLntKuS14qlOvXGcU0cnP8rSFD/5GLfG9BSWT/gzFxbcvZAJeMkhO47dZ8oQ7r0Jk66eCg4UlslSD+IOKJCf0wgw/bLNgZBssSHeAkbyHzy1s3RdieMCKXienBzTMlHRkS+LSQo0h6R/F1sTmeFT00mRDmyX97dc2GO3WL5KcqbjlaIE2ZFjn4axzTacL2hZf/s7OXlynwBlYWbhz9wxqztwemzL11xdqzTl1XCuKZ0vFswRQ==
Received: from MN2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:23a::19)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 22:45:06 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::8d) by MN2PR03CA0014.outlook.office365.com
 (2603:10b6:208:23a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 22:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:45:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:47 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:45 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 06/12] virtio_net: Create a FF group for ethtool steering
Date: Wed, 5 Nov 2025 16:43:50 -0600
Message-ID: <20251105224356.4234-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: d5de9afb-84d9-445f-7803-08de1cbcf769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NRfSSe+wcY0SWLNmqiXlXmXBlpu2goRBL6v0PlgPx/UtocJuKyXXkCcLCIl?=
 =?us-ascii?Q?Yc2PjFdaEZnzNFhow+Bi3JvEeldnVN9OXuRKUMdHg6J7Rjf3uLxOfgvYkG5I?=
 =?us-ascii?Q?RV0+ASpuCD7iyfn4IsEdHrLL4Odk32nbzwjwh54VorFY0GGh9a/hW0HpFwi9?=
 =?us-ascii?Q?FKbNEw1Eu3W+Qh7Jk369A9WA62aEfME8R4W4VdF2K5F6deW/MC+fDojnrb2Q?=
 =?us-ascii?Q?TG1fDZdRwOSkFEf3ofQRXvDbM5cPqXqo9GbB1g74k45yymcj+rz+n0A2dJRe?=
 =?us-ascii?Q?50zObtdiJZgt4NC4WU6XLcSPkEFJso5aUKjLdWi4qnZ9Ro0xK82Z6RqvbabY?=
 =?us-ascii?Q?yVcKhc7ofrLhi0AjaPe3yHhW5Yc+khanj+zBXWoo9EWD/+VU7pDXH2/6UVkW?=
 =?us-ascii?Q?pOZF3bV/ih/V67VvjbdZHL9pwQJ6EAobZqQh7JbfvM5EVamSBmlPf3USrcif?=
 =?us-ascii?Q?eIMPmnA7mYFfmXMX+7VcjUBr8a1R7v1KrZOOO6CVvC33yPXVtFXPikt6/w8/?=
 =?us-ascii?Q?29s4XcRiHmQYC6a1/hiGahUeVgaAz4tFzFFq2XSCz6IuOSy0I0/wZkz+e1v/?=
 =?us-ascii?Q?nGqSA6gMhzrdWvGP9lzhGZIAE4j+OLvtl7yEw99ysLfW/qp1powG2K2D16cG?=
 =?us-ascii?Q?A1+mhssYvXxV7fFrDZIpjKMcMbc1mxOFjypGjK3nqJf3oZEM3A5wuD2Yw6+z?=
 =?us-ascii?Q?p/WXAn8ahkxbC1PyLB1LjkuuwfqEWktXD/rs12csToHEP0rMuA9DrPRn7RT7?=
 =?us-ascii?Q?8h9Fb9tXEvBRGgmrnodkK4UTjPhRow5CyEX7RDnNTSlvxNw+UupwCQJuBUCI?=
 =?us-ascii?Q?5LtB2e+jhXzf39+47ABrEPk1kKSTRP3xkOLkjjfo6/P0NTdG4/PmZGPgiMwv?=
 =?us-ascii?Q?UD31l0mBoAgqGvK0xPpei7MUwqr14vWjK68hpweZ2n4I/hw9Gn7DY186JLwS?=
 =?us-ascii?Q?gMQoCWfW+6o5BZiaDaEsokQqWiEWJXG8fCVbVSQTdF4HkVHla33B5qjhe5i8?=
 =?us-ascii?Q?ZC5x3sLATVvPdZWNsZi8dgevnemMeqd9GP2tJxfthLFutF5BhCxR6/ovpy7J?=
 =?us-ascii?Q?CdXUY82baFiZyupyeQUeDYmgLzuYbJ4W8KTs3HAzlt4kpL40dUMwXjCs7x+t?=
 =?us-ascii?Q?MgeX8TSjLE4l7nKtGQt3RxXPcOfdk6CNgD+18+jti8jrFRXif0hL3/uHXWnh?=
 =?us-ascii?Q?R0p0hnAjneEOittzLLHRZRq+d+nkWowkJmNAymLhOvvEjoZWpq3GRxMmsMLD?=
 =?us-ascii?Q?xCngdYbo9aCLqo5zUQ7pigv0+sZUgMEOqtPgAR/46SPMAmCofYKbfF++sQJd?=
 =?us-ascii?Q?dLNccKiaoosqb+xVk/xx0EiDsx/T+YPSm7pJeRbjhbaeL3sxDwK2AK4eRX36?=
 =?us-ascii?Q?YdTtGjzc0RDE5VydnuyS0TWjNId7xlmm/otlXFglK6ebhdFckELL4gpGiA0B?=
 =?us-ascii?Q?ifwpTmYvSO6t8bt71UdCCbsEpRlevHh01Bm9W3tNFA/DFtoWEGO91k+f0STE?=
 =?us-ascii?Q?1IhX2hVaLego8t73ypXOj5d/GSnYhEvCaTtVJaqNjSFzOGw3TGxtQOc6euGR?=
 =?us-ascii?Q?xxVgvSivfksDB+c23go=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:45:06.1506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5de9afb-84d9-445f-7803-08de1cbcf769
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

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
index 6bc50a989d58..804a77e3d3c1 100644
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
@@ -6796,6 +6799,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	size_t real_ff_mask_size;
@@ -6862,6 +6866,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -6900,6 +6910,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -6927,6 +6950,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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


