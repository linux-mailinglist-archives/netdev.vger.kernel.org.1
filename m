Return-Path: <netdev+bounces-225636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B5FB96315
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7629519C4563
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C522475CF;
	Tue, 23 Sep 2025 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8NWV42O"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AC5231827
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637206; cv=fail; b=Zmq6QsRqTt1dMv0spfQcpZVlRGmesfJCSImUHIPzEKyPUIAVmYiRgpU6ZuoTQwKR9ev8kyDTV7TqWO2NM8II91g3f4DfXtLjM7ha85VCxxnHTL4VFt48FV2qGFZUAytnOIejFvTvuwfHuRjaKPjP8/eGJPkCn9oZpNAmAqZdqbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637206; c=relaxed/simple;
	bh=/lQ52OtsgfjEbd8CAiAgyOmfkMnv1npCOtg/5KV5z7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/r7vZSFicVVat/197YjCvf1hQ9TX8g0C3/IUjUj1lah14Cewy3SfzwseyhHR+JbSMNYcFTYNp9oYt2TLxTeO6zlU9VZcfyFcffN0ejp8eLsLEDPc3Zsxj4CilUtMdAjdRiYz0bqj4Dz5YycoS8pw6qGZ2NmKL7mAokuaf7N1bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8NWV42O; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2lvdjed2DH7GmA5N9FQf9V4GglkOD27pn+80wlON8u0mnyT3FrQzxyyQ6EXXbqNVBbTWCCovMvr6+/0GtH+WD8V02Nnvi29nrx1Jv3Ia882RriSEV5+cCwe+l95yj//G4LkweMXbEG3aGY5sgpawHnX4VCkD78amjhFQnEA0FQQ6JQ2PskVON0WvDUcuh6SEzdOvxgyIvMDFR6RRCwaTfDZj98hiMHaxODhgUZ8gbHmx8iyOS1N4YpHQsUzpSYEiW+9/y+ZUbG94cgGftrLKKpFQalsVouSqAo+n/DA2lYvHUPWWrXN0qluWK5Nc7OcWLdWUe5NHWyUuat5D1UIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV2rSlEOAwSycdRxfhk/H+b8KFWD4jpe8BSaGJ26Hjc=;
 b=c1q1752qp/zhCCqADzCg4jbNKFXdGocAWHO9zd/RrlU9vOEeYgmEz+CluUXXIKAXhSsMAkc04jRxQXbfD9ihxTxpGmD7AbdmbDAXsdVRRtFMUoFfNyYqI6G/IDFA5T2fS+GhbrF9ImLU2luZHN49E8nV/fNN/S1COqxOKg5QTvpevGmk1YCW66wmn2oVC/EJXCZlK427sdpk/4vtZysF6n15drit8ZUrwmkF3BzGlhS0pHsLzLE9MoAPXt6xqDe+7B9W9mi7W9wMeT6IUNVwv14HJL8Bg7g1mooHa5DAfoBjKzfkk9de9XrTTdqrOHMk7BjNY/uvI2yvkXyS5kxVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV2rSlEOAwSycdRxfhk/H+b8KFWD4jpe8BSaGJ26Hjc=;
 b=P8NWV42OXaBWynS2KuKV8dz0TWfEr5wHvdneAr9I3OiZ3pBVuksAZY9PmC+xTcnDTPgLZeA+uOYPkOr8I7DsdaR2BnsgEH/JkmhxNvTnwGoMRLF1O2fp8KWWquHkP8qvpQV5+2GdV5bqVeT/z3db7S+xIGBnYRIQo9sl8QeU7q6lenQfc3jFFCeZ6adyYzVh1AmJ0+5BNFltniB4mvVPI2c20UO8ujv8v5K+6xoIrjrGALyzXYtC6XyFo+1E6J9GMcwnmzmJXwTjDT4ih5AZFriDFY5PPuDk6mwbMZ63dttv3jly2UohbhWf3R//1gAZWg4RgIkYtWYvuYPhxN/yRg==
Received: from MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::23)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Tue, 23 Sep 2025 14:19:57 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:114:cafe::12) by MW4P222CA0018.outlook.office365.com
 (2603:10b6:303:114::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 14:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:19:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:40 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:38 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v3 05/11] virtio_net: Create a FF group for ethtool steering
Date: Tue, 23 Sep 2025 09:19:14 -0500
Message-ID: <20250923141920.283862-6-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6872fe40-557d-4f21-9b08-08ddfaac4646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4HKflILkBfCJjL+W2IF0dYJ0t4JJ9ceWAq47CcOmV4KG+jWT4f2TkPW4FaB?=
 =?us-ascii?Q?Pi1gn7l5pEakEA7joNwh7KTo8y6jh2jh25PNwJIXRxjme17dre4eV3T5dZC3?=
 =?us-ascii?Q?ucj9lxmGrML2Ds5wj9M7g0bzeHXq5ZGPDZRXHcA4Mxiu6Z3DcYymoB5nqXLA?=
 =?us-ascii?Q?4yZ7QMHpJkzKiHAHLCzgbCV8mhjDlcVBfYM2EXw1NYsNqVigBxFylnqrmNVe?=
 =?us-ascii?Q?OZE6jxUvYr2rPFeOoSGfYJUo5brkOs4tBlCOr2CdmaB0UXthtMnpO55Qw2RH?=
 =?us-ascii?Q?8picKImX/LEESoHIl+XiDK2TPq3XXw+/ZeYi7KgzUmMmSsgx9SzKQpnFDlRm?=
 =?us-ascii?Q?QYwVsCvDi+mWYLePSuoCaE/tqfhA1eWqd2IKH/hQxgnmeYoH46hKoaRdNTPM?=
 =?us-ascii?Q?bTW0QoUbbpBAogX89fumGmqlEk6P5n8/ty1X9Pt7HF9CN9ROiio+XqXHY40j?=
 =?us-ascii?Q?vIalqMa6pAl8uAgPF2cvsqtxZehz43FqToOGzeMMHr0Tc+6WsaLAYiisdF+K?=
 =?us-ascii?Q?eq3d3VNEUX2Bcgv7mnd5Y3yBGOuRO7ZTtGJU3FbuqWJribDMbi1A9izul1e/?=
 =?us-ascii?Q?l8quXlX+XP/jp7MBMjbGbsEY1F3mhnXZ1kXywBqe5LAdqHAAn5OAGzPBSDEb?=
 =?us-ascii?Q?xakh36ACXmNdWr49KcEpuKayO7oAOY8aJ45BhiaHZzl9SoC10/1eOWP5VOsF?=
 =?us-ascii?Q?TYe0C1gmYgC4GO/HmjPoMsLUjc6z6H8AwQSHVZbnAVc+TEwcQsH4zM3mjmDs?=
 =?us-ascii?Q?8t1r4680tLDnfL0BivcQIgtOn11HUoMm9AsDPwtI6b+TcTIpXPzc+VuCavdH?=
 =?us-ascii?Q?eePVjGuQphmCu4u5OpTJ0R7fUbyjLjF43hHzs50vcTywPwKJwxuspc0us9wV?=
 =?us-ascii?Q?X3+nK7nzEaVIw6wIGFxe2/cUx3A0r249Z1jq0DNbo4zNog27e+WqqUWT4m6b?=
 =?us-ascii?Q?3Cjq+9lRYirkIkazAIbjW/t7WKCJu0N/YXttaYDyhgbMqWw6M2fVLecJfrod?=
 =?us-ascii?Q?BHcmneWOPPLKIrsfnuFrm3iGDedzC1khhV38ROx3pkXmvc9xzmR90YpceEHV?=
 =?us-ascii?Q?oqlwYjHomdHmOpuJGnFlqXwd6/r1MrhRnIwUr6ZABk68Hh7tMtTqsI2WszLf?=
 =?us-ascii?Q?th9rY6CyggdsJ3MWZP1vD0uJIbh7S7BnG4EyF2DwctmU9DjIcWG/5fpXRlOu?=
 =?us-ascii?Q?5EBpwsOfl/Sxif1zwHhR6JXaF3T9k9meMxUgNXuB4xCJuvL3hiFEOHU4mdYZ?=
 =?us-ascii?Q?978v63w4kYhBHfRigcmJ8Vtzct63BOaoSKLKbDiNHKlMlv8pqPY7jJjmmwXB?=
 =?us-ascii?Q?L45k1CCcjazfNgQhPuZlKsuWywhwSEkpRKgZnnkqK7PfCB1vQ6aKUdSAeY54?=
 =?us-ascii?Q?c/B2sOfa1gScfAB5OKcoSIQ5rNxrgfTA2GczBpbcsWqBbhkf4RuYAYTkJyMX?=
 =?us-ascii?Q?dA2ZgURS8aYQfRUxVLf1kbm0EFZEO5NUfacKVEqQU3LyfRxiG99BWRGkI+i4?=
 =?us-ascii?Q?21wQDvzr7hIF93uCrnoc4ypA2LOdmUgcqn3W?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:19:57.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6872fe40-557d-4f21-9b08-08ddfaac4646
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

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
index 61cb45331c97..0036c2db9f77 100644
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
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
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
index a35533bf8377..662693e1fefd 100644
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
2.45.0


