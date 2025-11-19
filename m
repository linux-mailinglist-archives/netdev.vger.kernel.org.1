Return-Path: <netdev+bounces-240120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A5C70C1F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A54E1533
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A231CA42;
	Wed, 19 Nov 2025 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s6k6guIb"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60C2D739D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579772; cv=fail; b=iE52Cpza5xP0xbjuDaMBOt3v1UdcAuAYGE3OWy7p732pa5Rrx3tDNxFPqtDkEC2toi8TwhOa455OSaN/N2hCP+niJNslc5E6L5Wpw9Rkd0l9J4mhkwHzmKLFbnuhLPloxHp7bfkJJCSHqXwF7fggGMCdTpMOOj23Sn+mccXdZ+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579772; c=relaxed/simple;
	bh=kgvh79L7HpEfuj3Xes4HPAJPzLYXsfVQdba63mf36aY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kl7w18z9Dv8pg4S/TFtT68kJk5blIoUF9c6TepizJCWvfs0v/SqnybpG6EL+QmgBWQ5CgE/Enul75LMStXN9DJyOZ6SoPpaHX8wQYJTYfelV3wBVvB4RS94MbP5y9jLxDlikhGrOYSoJCqPl+8z03SW6GEnOdSDNo50mUscnRiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s6k6guIb; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWw70UffNVPymLiTuVDLO1EbwGjo04fd28vnvrhl9xxMb/UIF+bjoGB17RQbcdm+lqCfmuYf6Y5LeyZPERMHjxl9/BWo24t2I42ypCyLlkFRBsLMJ3nMBWEbtIOGfKHipYWAqdubl0LcTeJU97z4RL408/ZSMIFLvR3TR0WgcQ5NkGA47FOpm1NvMRkk/JOxmpnDTDhPzTdWY3Brrj87wH1kYEVmZ48oEv+Iu/fOK8pv/acyiwxOv2e8NakwfiFgHuq9B7YujBJN659pCu2c2U9KXWPw3/OmWBmSV4LBPARS9ysjIalHKUI06D3N4bdKhejwc9zBO6P0rLo6hLlfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acJtfDNYeXKlc35tATEkDiDqxwmm+cvBkFT+ZBvfGss=;
 b=cW9Phc8sZ3qaANT8j0zwSsVFLcsPuCOolunpCVaybjuf7OL3iQzAVPCqRqO0ItWe/inGVeV9SWyPOKAschQX0Mt3/OwUVTAduqrTuwJD7RlP8v49wPtrAGD+4WnC93ozf9ljGHbNj1J1xy1/5E4l8VqKW7Ksaavagpd7h8bS+TxZ3vxROJl5gstE9bWls5ubderkzJBRo+u5VXSj8Bttx13CXIsmtOwdOPc6vza8sYNOczEJhz37NoQ4+NCPX4aIHLeTLmTxKVjdVLFGXr/7IojjthOw9IeHFONTHu7e1ar55xMsV3bxtxv1lqd1NPw/VaTPQb5CGrrkQpusJzrXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acJtfDNYeXKlc35tATEkDiDqxwmm+cvBkFT+ZBvfGss=;
 b=s6k6guIbZob3GzjaOPe0i8sh3O/gRBeMsf5ocgfhGW2dY4ubj81VaG+rEaCNlCfxXYOVlmgpEFoIWSJUuhcWUvFROYDU5ytO8d5We8HfPLJjgnKQFCT1ywYetaHHxi/Sz6/c/8s+2WCMK42tg8beQhjZkH121qAmuf3jq/5E4ukF3j5jlmUYYtqmBZTTLCJh2mpwFmAJ3oPjyPoyhmQ5NJkchCjwHSiU5dT6QPDaxlrTisxfe0agG5XEeZURwjwDnQtRIaIvQ10cFecChRSjymK8Aq+aDAI8UenG6eNKWpsHShdKH9pifkg+ja8eAzh/W8ugVABaYqaTtvaznlEAGQ==
Received: from CH2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:610:54::31)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:15:58 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::b3) by CH2PR11CA0021.outlook.office365.com
 (2603:10b6:610:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:15:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:39 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:39 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:38 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 06/12] virtio_net: Create a FF group for ethtool steering
Date: Wed, 19 Nov 2025 13:15:17 -0600
Message-ID: <20251119191524.4572-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c202ab3-7f43-4bb5-3034-08de27a011f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ViGKnV8+xPPYoDN/h9EGzSzkZYTQinLeTabilvojV7CI84qB3l25jkKdJq+Q?=
 =?us-ascii?Q?beumlMuzcShOcIAb2jHQm0awq6tvZVhX6mzkN+GgalqgeD93asV5E1EmVT5P?=
 =?us-ascii?Q?GScxH7BqIAIR1ABVXuFJwDb+E7mtsa/QZO1OYnn40VocimgKtHwwxvPEs06W?=
 =?us-ascii?Q?ta+ePgnG7wl0tl82oRt2ZAveZZmOATtuew3X7kdds2wMu54jOtYT2h1HyQAw?=
 =?us-ascii?Q?24LU3UC5B8GZZrTMJFFWJGtct5VdzML0z7+z6ZJN73rjq5GROfywxew8WnI5?=
 =?us-ascii?Q?KBtkES0yOTkC9PxwskQmNOvkv37uZ7Es0aeOeaGD2R3G3DwV4gC6Glrv3poT?=
 =?us-ascii?Q?NlOmlEOxsGBfzcjjrdsi2zlO0SQYHgNxkF1HnwYXqU4RwOj4+SruyQoKgYv1?=
 =?us-ascii?Q?YWIpmDDoZu3xMILXXIfly8LxWfWsjEgwIHlQR9++Bv65ZptZQFHYuuivxzYs?=
 =?us-ascii?Q?Zt2LI1bNQGHp8HpbMkQibjObM9V+GtkNtqBrdqClXQ/g4NddwEsglMnVBtfP?=
 =?us-ascii?Q?iwfSjl6XscrSDE46E63uGULLmnC2aN/2fWkdLxNcowI5H/jbsEgv6qCYL38e?=
 =?us-ascii?Q?G9c51pFuU2ojbLHjR77ws49GXLj+D3m9oftFa9LYHBk1fT2FF2XvYSFh98wo?=
 =?us-ascii?Q?Z6R12lNMCow2u+gsPi2bPqeSlqtH9mpRYg0H3ipbgjwhPyUB/SsuvfV4TOpr?=
 =?us-ascii?Q?QEkGeghtAXV5bjLqNrSgwNvVFmUSjJuRKNTPK4b7tpy8qcCKZRq10DzlsSb5?=
 =?us-ascii?Q?bmem89lqZC11dObcaepRzuLSnAELKpn33oI4WvKmz81CFOvMSvoqtM6BcBsO?=
 =?us-ascii?Q?JzLcRQXCDsQkQfeai9JWyDa4UAwT3YGCZobgBgbqXyMi9xa2S4gudH3wk/qf?=
 =?us-ascii?Q?y3+9F3qVgpAuqIMXXN5aVsUPCrZX+bMkfQdIzx6GiD52q4cv0TxpXjZaTo25?=
 =?us-ascii?Q?3kjyGOsW4uKqVD4QlHHd63yjTIRUMJuoaHyNmNboZajgG1z7Cny6UbdRDeRW?=
 =?us-ascii?Q?LWnRE7XiI+5yxTG0wK/oSnPISVlv8WDDRMp3bMLnv1uiSlP10QQKx72XBZea?=
 =?us-ascii?Q?S/iPk9fVqObtXPGRz+kRFe4ZxNHeopXM391eUj8pJz6NzUez0N9C8t/aabr1?=
 =?us-ascii?Q?80BzK6zzhVd3TL1oSGnLGsqAnJQgQwPvG1p9sn6JT0E1TPmgF/W3Idy9FhJ3?=
 =?us-ascii?Q?ftN8MXvMdrDu42Phoe9hEZj2lKFO8MbU40GhRH3yzxuNNEDbbnnbARdgvwBS?=
 =?us-ascii?Q?yzKzGQ5R1snK8ZTRdsH5iA4faYHOBPuvRR/dhj8WJcny+eMrQgs02AYR+1IO?=
 =?us-ascii?Q?u462spS5qJbsp9PIU56LZqneoAn8n7UZlfWMUypFbjrSDisw++6PrdvvqmxI?=
 =?us-ascii?Q?vNFkW0e96DV69mEI7OYQRtIuPuU3M9tC/GmgSk+Es+ZMwiLDxPmoed9DLd/M?=
 =?us-ascii?Q?Mj+lL2uQdkz9iFGWdOjrM6mmPexZyj/ZeLJUmcJ1wH/wZEMRI4aTfvpISd7w?=
 =?us-ascii?Q?e1fhGaPq2F2s9cMMMj0U/Mr9wIt98IhXBamLQNUYFw+gHGVDLOeihuxHmTAa?=
 =?us-ascii?Q?D9UPOTQIxN67zLrM0oI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:15:58.1129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c202ab3-7f43-4bb5-3034-08de27a011f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802

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
index 2d5c1bff879a..22571a7c97e9 100644
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
@@ -5800,6 +5803,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	size_t real_ff_mask_size;
@@ -5883,6 +5887,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -5922,6 +5932,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -5949,6 +5972,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
index 1debcf595bdb..5883fdf4d37c 100644
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
@@ -85,4 +87,17 @@ struct virtio_net_ff_actions {
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


