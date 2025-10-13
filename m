Return-Path: <netdev+bounces-228827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D0BD4DAF
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722E43E4174
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6D431A056;
	Mon, 13 Oct 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KSel3rFn"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153630E831
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369304; cv=fail; b=Q6KQO7eDdvvj1ZQQCBSccdVPMd7GWf2cKmPSEnh7Mnz5PYTkaD0Lml0DS2e4gw4n7c1Lvm2cPralSIn/BHPpcsFjf40uGTaXdwi8giUFbds3S8wqI9IMuhFzUVlRZPFK7MB/agFdjHiIORyHwVNBjyPL7qhCXKWwlO2IRF3BQIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369304; c=relaxed/simple;
	bh=80/uofdv+1mx+iaHpaLk9ZA81QkfinDOOtInnn4+UmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWf0u3iRy2wYWK0IWv1D6MMg+5qxY81MHlSrzpy6mUjBCWAlDswiC1ItTmpefppTZ1f7c+v+mIDfpP4CiSC9i7kkP5Cac/CcGMtscVGsZKlg9zMipHtbRPptANdAho4oXqEUqdRsOVnfPtBW73hyG6FjOeQv+3mD+mygenkqF1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KSel3rFn; arc=fail smtp.client-ip=52.101.62.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVlWA2LaNGlMWcQ/pmQypz/yBEbuc4VI7fn8om7crNx9cGXog8o1Ai1k0Oz/qE8ZoHF+F3hdijpUWMxKPNv8tnpQE6VPUVv7JNfIQQkt96uluBJK+7jguEWS3ZMIvr0vJKXupL0gOMMYrgQnDD0eJduLmpustg5n43ONDIbaiCMv3pPshHjyA9Eg3edEasbA82+F/bLBU3eqtPwAQiKVHWY9vc52LJY/TIuZcE4u8XmzToP9TZoc42BrDkFyPxXc6QVmI4FisD1dmWNUe1gcijH3CXGoBPqv8g1noFukHH5FAJPJg0mmGtkJZzpE4BcemdouvzUWsAiztfn3Tw7Rtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx1ww6y9wil6djliuxPrmldtHUwkwfj/Ed/q9zS8gvU=;
 b=SiLKSMk3vf4u5Wg2KF4/UDtDc+yT/N8+l5NzpRiHwhcoNDqPjVtMIH7mr5eDG2ODCofvFzd4Z9zJu4fkXefmwzUn7i9CN34Dxh9g7maQwi8d5EwFYRc+d6R/d8i45/rsUmxjr68qln4DFZIrFtlYFwcmq+wdCpCA5D6PcHAur4k7fXGVp+/Km64l4OviDT/47/YD/Fb4wiEtK1wqcEbd0IJNGvwEpvW7/D0uuFcShEvJl7ncbu/eyFT23RX9vrfEpAi9uausL8e+fLJoQxDkRo2MHG8iWAvKA/WowC5K1De2EwN7yWTyc7vntHPWBI8QOmXhvtf/QiyN9IDZjgKMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx1ww6y9wil6djliuxPrmldtHUwkwfj/Ed/q9zS8gvU=;
 b=KSel3rFn3BMJ7qRCDrI+aIRj5DMafD3f2RJ3wodcu+Q8WOnbP/rRlw/VMt8Q7BnD8ffGZ6yq46M8Gp6Vtj1QCoilJUe5N5kbxxyDg2W51v9BYwV/QmA1VYbAMxqKNrtoG1qOPTjAZb+E/WqApT3T7t5XE7nZl5e/G2sNTR2wR0Ujv8s5wvVwE/t+26o6/K0FQLDP7Z6prPi2YUm2UDzeyMRJJwLmkfSxRPFpPW4VHX9rUqkLzt9n/9FqsGOaygr9xMxOft2fIifHxNuv0RYS/L66DRrTTWrMTQ8N1T/o8uCWA5vi1P7/nppKEe/v9eg6YNh5O+oEOIwmE73FmRMnXw==
Received: from PH7PR17CA0036.namprd17.prod.outlook.com (2603:10b6:510:323::20)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 15:28:20 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::41) by PH7PR17CA0036.outlook.office365.com
 (2603:10b6:510:323::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 15:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 15:28:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:10 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:08 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 06/12] virtio_net: Create a FF group for ethtool steering
Date: Mon, 13 Oct 2025 10:27:36 -0500
Message-ID: <20251013152742.619423-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb16081-0f20-478c-6175-08de0a6d23d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLuzuAlqflSVvOnE9je2XK4D2kN/bpSEojIakvJBP3tskZYcKOcmDk6K9NHO?=
 =?us-ascii?Q?XBtMCVDrlRihRYVMCMT14HMtLD/VTxf0jHjq8CSEy+efUXbiXBWGj1MTsmPr?=
 =?us-ascii?Q?7ziR6SEatgSHwLNpdrfyQTqY58mDhVda6AXIdoY8xRoWucBXHw9sN+ORTXBs?=
 =?us-ascii?Q?CR84Oj5JJb+yVBSq7tsPvNpnkgI4w1Cqu/6RaStnwqwAfW47+k5h4bhnRKLq?=
 =?us-ascii?Q?2RN5VsWLwYQrAmoYqxqVE0a5NhlM553jQzm2IbnEShODyk4gjjDGfa41ZLuj?=
 =?us-ascii?Q?oKcm0tSnI2uffA7ZSNptDrmtkQY4TpKiuGsXoWuz9hwHwcL5LS1zRho4WLCQ?=
 =?us-ascii?Q?WolOezzX4Mu45P0RQZG9gE0tRdGzTDFNypC7+2+i/72MPGT2kqUDFH774F2z?=
 =?us-ascii?Q?F+gC9LU765iiw1qFcTzkMrlKzMLPF6JJHKAL6YfuRKxMpSUYIlJ9w5O9jRRl?=
 =?us-ascii?Q?iHrjaWKr/doCChUdKRkiLESZxqbipsopCc/1MRp6PbOsO7EKhe5Jcg+vrUga?=
 =?us-ascii?Q?/XDW62gu+eY7ieM0hsFS0iYN18RdmGSwFOXVieUuvlqgdY09qF+CcvV5OoyZ?=
 =?us-ascii?Q?/i3WZr8VS7uDckfUFzmNHUeOAFE3LA4xtSdpSv/cqEYfmuUha2rrjKFwUM1F?=
 =?us-ascii?Q?7o1OI/7gO0CwrJOPLjspUMx+vSRpbtd9dYvuZ4LGslv9ImfxxBW8bARb3XbN?=
 =?us-ascii?Q?tOEg/zX8Gum70Rla+7gBVFZZTrxq0WdXXqN7GimDXIYGu9q4yQeUpiW8pQbw?=
 =?us-ascii?Q?nNCq/l8rb/KfodunNB6dU7TSAMiTvjSijqZ+edkvS2dXgCf+OUWfzBSGbtlP?=
 =?us-ascii?Q?jrP5u3thngZl7gVapAQFWtoLUiEudhliPT37FX/yi4hXPmVVtagBGF2kbE4N?=
 =?us-ascii?Q?3CZZAJCjumjoXX1kO8imORV9m7FUykAHO0UFtGgS/AqguZPHqbuS3HINimb7?=
 =?us-ascii?Q?p//JpHwM3MuLwUbvuEhqHGYWVZsBlxmcObDNphjIV0pXaUyAQja8Sjx60DPE?=
 =?us-ascii?Q?6heoVlvXXjH9xRpiSVLuDyhPjW9DdfLC7wiQ2UEkfIdwPnS1OpX7+C7/XETL?=
 =?us-ascii?Q?LXAFHibtUWkHV4R8Q9TB5oqKux8gIxg3rOld8tEq1wiYb5V+LMDCEqleXi16?=
 =?us-ascii?Q?uSrk++Gb1A8BCZJqvaLpM/yVb/EEI7DZaQ9mxRCeQ+z/N3Y5R+49PRfg2XdC?=
 =?us-ascii?Q?nnwdo2Xu2TBrqM4+6nbBXcvOE0+7BTSDiyjLQIcjalvuGA8WWI/Hmk366WDy?=
 =?us-ascii?Q?1O5/tZoGn4WP1LUtzqf2TZfbXcfRiuHYb5+VVaKR8R277NZp5Qj07ijcbVe+?=
 =?us-ascii?Q?vL0ppGjVkPejaUIwEfRMsmOB5DeGX0gvzuGctWlJXBlLVDb6OuUwM0nOJG6J?=
 =?us-ascii?Q?lQX0WSmiWyPNMXopT5PWTSMIig0+7Kr1yneJO9jSgZLbugfzyXOsxf0lFEjp?=
 =?us-ascii?Q?u3TFfdHI6zZ0wJS+Svkduml1q6GQ25JOApx5zvoaGr0vOFEXCQQV+6aVp7aA?=
 =?us-ascii?Q?rFHWE1XhzlRWWewuAoucDSkqTONxcSDSN8wv4DXaqdRzhqRRd1wwT9nv+lya?=
 =?us-ascii?Q?5SdMcwRCt9X/plCM16g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:20.2102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb16081-0f20-478c-6175-08de0a6d23d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

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
index 520162985ad7..b38fad407ee6 100644
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


