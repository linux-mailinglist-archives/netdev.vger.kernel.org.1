Return-Path: <netdev+bounces-217410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C122B389B8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7805E7C3FFB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AEE2F290A;
	Wed, 27 Aug 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O0dTk3ho"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89102EC55E
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319970; cv=fail; b=ZNc2IK4PGh5SO0jgocWBZJhT1ySIH1g2fYyg79cab61aJTt6ztj4QsRwAgLzuMIsohTdmyTc3+4TWdUzurkV2niFpnTpBlVLHkYOrBh8BrYMQxBWEE0vF1wYn+ZIUUjnJWhQJHbTe4cv7h8Awqx85ZOEUQeT/Y6LYtRQFlu7sNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319970; c=relaxed/simple;
	bh=GhHFzkOFh6C80P4o2LuPmFAPNbq3Rvek0ErQx9m5yGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9QyzHuj25hSpJ0styE9RzGXZ7eqUh+hOvSvPc1LkvLTzeSoNyGJLyZ3VSG9yLuxamaBsB+GD74TN2bg3HdvPIbLRbNgZvugVM5dJp8nII4VBQoSIiMTXcDG5kiN/wWpkUcSBwZk+5m6GeN+yf8RFAxLuNFd7YtKJNcpf5W0wTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O0dTk3ho; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI7gAai3DjCDw2EI9X0Tg14i9QmTqwrRb9qykSTl3Spt0Afq2MNNP+Zik6OrrrO8cCC1vSc9JVrisuj9EEwS9RvIA4LINkTV2rWEbBLdULeE/NhME1hsCR+qBJJfxRrvinZ42oTkbO9sSuW8HyfHn96mkKGMW3USSVKmIlvKjyz9Hc8iBQxknjpIEgPEKqYWE5b8OZHnmhQ539V59dm+IF2DR7QZmVfZFd3qNw7pSECfma9Ddm1x3p63idiGMTm32f5gp9opwSpM5hHp/IUwyp9GFrVFp72K1Yry+PXjKjPVWYgHLBtjwG+OxbZ9F+EcHnvkM1f2vfAu4xvxUKSPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rYbwsAX28zy3hw2yj1bnC8JDhWZMMZQgYahlc1WpLc=;
 b=vbKy1fGAkUm1ziHVj8h6jxE8895RVysOrHz+bJ4imaVZBuJ+J04zCRVlA62/0uMSLFBB5aN3fZp3tJDyJLyB9MPgmw5aPEYJ4ljeVn1THxk6CMW0+jPpg0IqCxYWSYQS8WHbQb06kCjk8XaMH84IzsN/kK+kxi5H2mo06Kccetrylz13e4UpGb8kvgHxN0ic6tIrCMT4MxC35RucB/Qnr515fJFv0WhQugEMEPQiYRj0X7yVRyizjmDKlUVUAohY/SnHuVEkmroWjcUjicVBeZOv+XVcYA3Tq+1Bnhspnmf5XQGVCsgINqfAgE8pdMA2iaelihQOQ1uKtoEhjwtD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rYbwsAX28zy3hw2yj1bnC8JDhWZMMZQgYahlc1WpLc=;
 b=O0dTk3hopDDOnQG9S+Larfn3MD/eiRblJnQLNT6MMOHUgZSLW/PzJflKOr/mBvzWxx9Wxtxy1TDZdveLDfnkxht1AF5pbwhOJihCNHeSYAka+8lgTuwnJagF7bn8Bn4VYpnsEHaI32auPEVTUaFxpKGFLM5r1rK6vbmiL9eoE0MTtLxgskUDe2yL0rBwoNQLfy5gP0zxcV9cP3ye3VxKNBh5eqmSJ2irT31mXdby4YTmt+Ls5zl5fh/+G1kUw73lFRwImslLjjZOBdzc+MKWbN/9f3b9Tdr94fDBzgCjiqkE9z3LAfOMPAKRVXyYx/Np+H4ZN9KOrljNYXP0lZIaTA==
Received: from MN2PR04CA0035.namprd04.prod.outlook.com (2603:10b6:208:d4::48)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Wed, 27 Aug
 2025 18:39:26 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::25) by MN2PR04CA0035.outlook.office365.com
 (2603:10b6:208:d4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Wed,
 27 Aug 2025 18:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 18:39:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:06 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:06 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 05/11] virtio_net: Create a FF group for ethtool steering
Date: Wed, 27 Aug 2025 13:38:46 -0500
Message-ID: <20250827183852.2471-6-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: e89dd6d8-73af-497f-a17d-08dde5990cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oCU6cfMrjQJjOrCf/JGKm19P0xTz8mETijLlPOSTSF49+SK7grW/zssrQnqx?=
 =?us-ascii?Q?aq7f0tX35+QWbUOIip9fpcEnQXO7JXVx7Y1ADKtciegTqfIdCnxzuvOy+T9G?=
 =?us-ascii?Q?VnJSYHPlNZg6nT7N0d52rEpSyHKtqxZQFPssrHujJWRcLetOKeQFhb/OnQ4h?=
 =?us-ascii?Q?mgGLpkz/AL2brR4NrMmgq0zd7kWEhdQfByqL4U7YXm6pjZ3Ko8hsdg3sLNI2?=
 =?us-ascii?Q?F8BjpmItYvqAT8MTxEuG/aqVL4VHH7+ntzPfoaIG5wRk92TMwZJ49kIDDTVc?=
 =?us-ascii?Q?2bB+VvS1CR/3DPA4mdb0ubCf3EFjKWNl0G3fVuEoqRUnMEpWw43A49O6jB9h?=
 =?us-ascii?Q?UxUo9ZBTJyP3dxHZeHuPKVzKEDG+koPouRxVLlWBqYIdziX+F4GVir/QojK9?=
 =?us-ascii?Q?BeMQJ4cGXNCYEG4BC7e1nW/vdC7iRW/UljqHJp6kSYZIpvISq/xN7VmxfW9/?=
 =?us-ascii?Q?tOgzLe4KWl9EoG045NXMAuecZ04Yb+fIdjV03JAA6CV5yyT+fGUHHB4zZoZl?=
 =?us-ascii?Q?OUQsLiyV43+ptgyk/USDbPblvD2OXopBIW7/9lhBwltqRT+d1s3po02JUcre?=
 =?us-ascii?Q?O5yYZuh1Tz/K7I5MaucxKNiu50/GKO0aPmgOO5I2rBoRQ9LpT5GzmQV8/UbN?=
 =?us-ascii?Q?nwPrCPVdZ0IeF5fvxgzXx1PYqtDC03ClDCpqxzIsSPx9nQJrFjug42EMij94?=
 =?us-ascii?Q?AYEfdoK5F40J+Gy8V9ALZSgl93eNxLnN+LTfjyEyAZOs6XjQsSPUbQYERVcO?=
 =?us-ascii?Q?8CM61WRQRSqawkhTWvhPH04dZWolrJDGhE89gx99bdYP5YWsr9LGuWEv2t8d?=
 =?us-ascii?Q?wWROSbO/qDoMSHnKP8MPY2XloReomt2kljc4paOK283PqreAkyK7cv+Gufck?=
 =?us-ascii?Q?ctxdQ4BJwwG/sTpCeeNAY0u1ZEqVNXgy6zeD9q0dyFwbPrYGPQfw8ZHW2Nhm?=
 =?us-ascii?Q?JCAtbctKHIHBOXcB4qDeI9HWJ96zCGHp+lSHIVUUuyvATMFnQu4mXPoKf4LZ?=
 =?us-ascii?Q?OWevi1EW9lOHXKRXlb+eXCvbAwvQVb0QhhU6YAhyS/1HSLOOe0z+W3qkN2q1?=
 =?us-ascii?Q?r0RKxFqBHJAR1FR68Cylw++AOWrhClSybSAPDbWAiSu7ZHigupFPQmsZ8xCM?=
 =?us-ascii?Q?kw9qAyU5Yqsl+gxv3umw1Nq3oo09DWpoanBvVrpXRmkHW59LVOojlHZbgt/e?=
 =?us-ascii?Q?rQyqqaDPd3gikgsm1rssRty7YKMaR9OLSUJgSx8agfSelHUjWAGbnQTXZPY2?=
 =?us-ascii?Q?RZXoKC6V+y6HmDKRePHLn9OCOY9Wg6/+Im5Juu7Ej/X8LEgajjOtkEluSg9Y?=
 =?us-ascii?Q?K15BGC4QkTaO0af0S7OEUm5evM+ZTWgEE52L7EoQa8K4pyJs/TJHozVwIksW?=
 =?us-ascii?Q?iCIn/kv1knCyTuycmGP6uykndIevTh58UvCUSqOK1aQR0D4lws/GwS/pbi3O?=
 =?us-ascii?Q?+zqFbDe0UWdp2Nqy7F8cqAEOL3lFPkN03v9scaGgVt/CrGpOX3nvn3JMaRsY?=
 =?us-ascii?Q?c3DSzBVCdmJTodUvdQ96Yby1oro+P727fgi3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:26.0122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89dd6d8-73af-497f-a17d-08dde5990cae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c | 25 +++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h     |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 61cb45331c97..8ce7995e6622 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -6,6 +6,9 @@
 #include <net/ip.h>
 #include "virtio_net_ff.h"
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -30,6 +33,7 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_net_ff_selector *sel;
 	int err;
 	int i;
@@ -92,6 +96,12 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit < VIRTNET_FF_MAX_GROUPS)) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = VIRTNET_FF_MAX_GROUPS;
+
 	err = virtio_device_cap_set(vdev,
 				    VIRTIO_NET_FF_RESOURCE_CAP,
 				    ff->ff_caps,
@@ -121,6 +131,17 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
+	/* Use priority for the object ID. */
+	err = virtio_device_object_create(vdev,
+					  VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+					  VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+					  &ethtool_group,
+					  sizeof(ethtool_group));
+	if (err)
+		goto err_ff_action;
+
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -139,6 +160,10 @@ void virtnet_ff_cleanup(struct virtnet_ff *ff)
 	if (!ff->ff_supported)
 		return;
 
+	virtio_device_object_destroy(ff->vdev,
+				     VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				     VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
 	kfree(ff->ff_actions);
 	kfree(ff->ff_mask);
 	kfree(ff->ff_caps);
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index 930851190964..bc1bed486db9 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 struct virtio_net_ff_cap_data {
 	__le32 groups_limit;
 	__le32 classifiers_limit;
@@ -52,4 +54,9 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[];
 };
+
+struct virtio_net_resource_obj_ff_group {
+	__le16 group_priority;
+};
+
 #endif
-- 
2.50.1


