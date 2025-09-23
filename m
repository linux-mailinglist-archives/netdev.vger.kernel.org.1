Return-Path: <netdev+bounces-225633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EF2B962F5
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0355D7A50F6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73D23C8D5;
	Tue, 23 Sep 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m+vxrVGe"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88723ABA8
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637196; cv=fail; b=XdYKI5mXn4SRtJtyX9o8uD9EXzUS5MH2wzONNSWALTYlLi03z+monL/3ZUdiCfZEVr1RPxDu8kd1iH0C6AcfjM1+/LkeSHF2jd9dGMZU7pYpF4fYqWC4UlK+2WImOU6F/ccw1MOa/yWa0qacelnNfsLLuJnGW0nxNg13xsoA+Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637196; c=relaxed/simple;
	bh=m+N7XdmSqWocdqrTAgbWNLPt+ESkhKWPvP89l2bXdUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+rZIgrgarb0TpSYGQrSD1ZuBT3Xs4KbKCnMoZfSbk0q9mv7UcAlRVerrw0QYuSg67fAYnwFVUDNqKWiVJZ9UfPMDQ/7BCzqXY4feRr/mZ/aJiH6Dn6Mnc/JNNFiEn4tdC7X5aIIg7tYXTaYQqs72X/K05V64FcYxXFxAKC4yXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m+vxrVGe; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlT4VmLb0/bXzh0YkgsFF+/ovNg2Jh9ujZTUMjT51JVXI0Wngu/aS2ylmA7j/hP++OOeUtbjAvDWy5ARWIvIS4xSDTUjmC3Auo5WPVHT0yhkkMjT6RY6FNyORxCUEiy2aKVpBORDTDlJki9WVOvHnlEVZWNztizw+u/GoZB2AMzuYM1uWvZxf3KxQTQjEjHjujn+lLExxNnmAv4uFECfyR9Zy4sT7ND8RBnF/wU7DGiZ3dQii42GZYh65+XdYv8Ja/ucsDcI9jroUZyC4ifi1aYJ0s0HsTq5fHwUexX88N9xMpB+eWyjOElAfo+Ph/IX7ypiyQ7t/iehSDS8ZEEUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/jPs6b9yQbB1TZnF/vw2sioQtuNpjgPEgBcb92ySz0=;
 b=NLRJigS9+Ri0zaoAhB9wJ+Iyv5ClbXFbH4PwTqq/58AlJDPILTrb35TewbJNZ/ykMYI4Dfx0gYl1TMHU1YwWOZv6gLJZMzVKbsqz3lugC9rdVNsTsZ7ZkVD7nsls35t5PWhgKGlAluZRd+76HtMDGvKW11cMFW8o4V+WZ72ATIUTDdYl82JzRP8qo/oFah2IHdBwJHWrA2R9DW7PbnJvhV1+o3OikQaiok1hgOt4LjNc5M+S3uOH+Wb0tQP8H9yNFcfWtbnvbqCbgKTEJtouD5aoEfjZgMQISZ+14CxC6S4wD9C5b+gkxt03OBOtvt9pr1Gi87Rcc2i7gqHMV4td3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/jPs6b9yQbB1TZnF/vw2sioQtuNpjgPEgBcb92ySz0=;
 b=m+vxrVGe1amJyVxgHD4c6MHyPcWrXeOdM6hPmf6Smt3rRp8Sn/2J1REJzDhO//lynd1fTizVSZwXtlIBp9wuDNIwX0oGxUrjyBnIs5BPVLXO6kabgclTlTvDSYi+LzX717Qpx1vWOeDMiftd6/9zL2OLvKEzGwwSbfrf87Kb1G5ktSGNZyCCqRRNqAO/GEg10V0mhYBZGhGqEixhM3sSBNM4H/HG11UgusaNbNj/aVkNJXYQWCbAP3zYHQYMMEKPvlAbUgKBhdqAffEgdYzYhthXmCUciB+NAsKEiwGXVfdaboeRVYhoFvTWRJlPoEW7bNo1GjrdC8Coe2qRhUCO2w==
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 14:19:52 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:114:cafe::e9) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 14:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:19:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:36 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:34 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v3 03/11] virtio_net: Create virtio_net directory
Date: Tue, 23 Sep 2025 09:19:12 -0500
Message-ID: <20250923141920.283862-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a985194-b07c-4489-0f3a-08ddfaac42e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+9fiyS0El3RLob7XNQweDOl2OAp+KapEs/o8iKQ8tBDfU+U4CkDi9deeAACP?=
 =?us-ascii?Q?x4dQeAE99R9gZBidf8o33jsxB33ckNMDG6mDuUD37QXT7LVGS3i0rotQ3THo?=
 =?us-ascii?Q?Peq0yLekhwd42dZmVj8WktJw9EoRuKbPM1xFesTrXxJxqO2TfEF6CMlNuVjT?=
 =?us-ascii?Q?9VcYBZ+8hnH3/cI7v8XjrU2LmcphFZrsloJ1ZRdVRIRTxj7yIS6o1m5CmP83?=
 =?us-ascii?Q?uO0dBZz7TepbTwm+wro1P8GFKYZ9/X+vXKaoP9rU1k68EBdfW4isTS5Zzsp0?=
 =?us-ascii?Q?BcVBOH7yS/T0FmgfgT/eBUl7hOPdul6/JK6fQ8M8Ouh7v07enrVBDlbr1YJc?=
 =?us-ascii?Q?w3O8zPzX1ZBdwUXtSHrcYNTHO+5wESEykpolVu64CC+tcaT86TsUeoREASNA?=
 =?us-ascii?Q?rZul7Kp0fBd/c/Xt+gvd53omQMJ4fsJQqoxHuJpA3Ev8lWmahK6uXaQ2KBdd?=
 =?us-ascii?Q?vFm0zhOrWbfyLwZoOZk2Y/q/p2oRTlpS8oKGZ87oNuCpX02ls24AXdZX2tqJ?=
 =?us-ascii?Q?UYHxUz7wAj3XtrhwlyI+HaJYUulLdF9U6z83ZNzVvvwffvhO1ldvaNDldP6J?=
 =?us-ascii?Q?3yT/Byqi+FSRFWLN53bdsaFdWzXTag8E0wGunI6j/uccBlYMaC5XYGzhVeck?=
 =?us-ascii?Q?jm0+WOhW6MAJk/MBuuFUYYvWLy6hyPfb7npdShzY2UXIRS4KIhM6B0xYz3+0?=
 =?us-ascii?Q?GbZzEZMKrc4Z9UnxmayKQUQa+g1Y6pgyPj3/HUuuUcGlo+6nx7n9e1C+f/xj?=
 =?us-ascii?Q?bV/No7GR1ver5cveM6DSPOurEIVc9qsgMR0tOb543R/OSmXCzyRQYjks0HA1?=
 =?us-ascii?Q?C0efNPef+8b4f7xmzkpSKESmoHRKEve9zhuDhzMYKeEjTxfoqqggCmwqlvLO?=
 =?us-ascii?Q?trnSpaeo1hsaefz6vSIMEJxTK7jY73pneYEOQGdVI+uZxxs0ccdNsthehLS4?=
 =?us-ascii?Q?PFKcf7CHm3aqtxokILCsnWmvrwA/gCj6mhrOm/LylZSjQK6+fC4s/GTKwPca?=
 =?us-ascii?Q?1cj4HTzg1BFeACgWmMQngoJ+ol0y/APh63rBr8VKcr7TWlPeVavzoAs64JBm?=
 =?us-ascii?Q?dusGKFVOiDL142Q+ICWJZf9wf+nnjThwh92pchVfFfB98c3LfyYgpNcm+XEY?=
 =?us-ascii?Q?o3iCwhXu4QOZhnrDm6z+xhmegHKG1U0m5aUZ9302En7p+9RNFEP4kfmTWSpW?=
 =?us-ascii?Q?OJFgVYdcDC+emi87nrwDu8g0ZbShaIpVj5o9RPKkENTEhp05o1y7Ss+PkF8p?=
 =?us-ascii?Q?JTPp8MArcII6wEa/bElP80H3J5x0qJ8pQnhMzMyBrJfwx9U8fMramA23jbuY?=
 =?us-ascii?Q?zymehWLtGVtXMa8RQ+t3wvvSIu+jItc3fLYWOzTw1mX7ZknFUPinMjbm/Wy6?=
 =?us-ascii?Q?cMqIZQEBnZpAgRwKDYrF9aOFUgnfoVKytkGi2fDQKBmlMT/1M+vQgPxT/tXD?=
 =?us-ascii?Q?Q4Clb00UoIkxymIPuUplLBGtbsfATUMUeu4C5HIAUKylOE9uQZeM6nze9ZSe?=
 =?us-ascii?Q?Nv0Pg7H/DXUWDNeYsjuYay/Rq+/kxykaUx+7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:19:51.9018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a985194-b07c-4489-0f3a-08ddfaac42e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

The flow filter implementaion requires minimal changes to the
existing virtio_net implementation. It's cleaner to separate it into
another file. In order to do so, move virtio_net.c into the new
virtio_net directory, and create a makefile for it. Note the name is
changed to virtio_net_main.c, so the module can retain the name
virtio_net.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 MAINTAINERS                                               | 2 +-
 drivers/net/Makefile                                      | 2 +-
 drivers/net/virtio_net/Makefile                           | 8 ++++++++
 .../net/{virtio_net.c => virtio_net/virtio_net_main.c}    | 0
 4 files changed, 10 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/virtio_net/Makefile
 rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8a770714101..09d26c4225a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26685,7 +26685,7 @@ F:	Documentation/devicetree/bindings/virtio/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-F:	drivers/net/virtio_net.c
+F:	drivers/net/virtio_net/
 F:	drivers/vdpa/
 F:	drivers/virtio/
 F:	include/linux/vdpa.h
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 73bc63ecd65f..cf28992658a6 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_NET_TEAM) += team/
 obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_TAP) += tap.o
 obj-$(CONFIG_VETH) += veth.o
-obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
+obj-$(CONFIG_VIRTIO_NET) += virtio_net/
 obj-$(CONFIG_VXLAN) += vxlan/
 obj-$(CONFIG_GENEVE) += geneve.o
 obj-$(CONFIG_BAREUDP) += bareudp.o
diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
new file mode 100644
index 000000000000..c0a4725ddd69
--- /dev/null
+++ b/drivers/net/virtio_net/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the VirtIO Net driver
+#
+
+obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
+
+virtio_net-objs := virtio_net_main.o
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net/virtio_net_main.c
similarity index 100%
rename from drivers/net/virtio_net.c
rename to drivers/net/virtio_net/virtio_net_main.c
-- 
2.45.0


