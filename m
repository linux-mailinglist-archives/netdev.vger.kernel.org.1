Return-Path: <netdev+bounces-220883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B9FB495DB
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C93B7EE6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77B311C37;
	Mon,  8 Sep 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVWZJiIW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7F3112B4
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349794; cv=fail; b=tgKyksfjajST72JZecKkwFZbc4kmlGKqQT2+jrnrIGGolCRAt+/14DOIfNJiwsEGK8+I/iZvvPaJa4+Q/bEkoZZMwbJtFxKbg9i2F6ha+JcC7sGm9lzSw1Eawt+t9KrUJrI7g91SIOhez/6yf8LWQUjXXOWAjQ0T4f1uDV7FsfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349794; c=relaxed/simple;
	bh=hez1QZt47g+YLyivWHFbxMWhDOpIOCyINFP/EkmuQuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyFl/wzf9w3MHSaNVVNAQv5HYstY6FMUnCwLxbgy5b4nAYPU+llarav4QV/iAOeyHyNdV7W2YNk2c6Dy3NIpFpfwHEENXNTsh1SPyQpsxD/nNZgCPBd2NaQPxT8f8KJE+O4iHYcfYz8rDy/2o4+ZikutLxacraiUGiASv6UQmlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVWZJiIW; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foMJKx8iL0qJPDzFbmP8h0WtutFQubw258bepFy7kLxZqujKSvHFYMfRmVsT+HkBuzd3seKJQYcqXj7vI54hXS7ofaE2zGACn4bXRJ4wKin803vX7hZAs39ZmEbWmGwj5amUpnLK7QX4P7SOJkg35STq0MlsXlAKPsciaHrq2lm+s6iQRCN3FRFmCpRX2omKQUsZzbuecHkgUXZIvnVRemh1Z49hzzjmHNL5xr2+TjNvgvx/2GM2UpHG8dIhIAQPkvw7HoC2PRQkIcf8EsJ8fDwayadSsXV9mVs9/eTP6ZLyRyQf0GQ+QAd/v7x4beQKKq+8D56jS9kyxTrA72jWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMgT4dI0yQ9t+PSjM+ceMUW9rG0TsQY7ief3mz0m8xA=;
 b=MHlI7QC3jp/dNYp6TUNoa/Ii8zplFDTtM6dijFtDzohXRYiGpld+0pb9qQvxwr8uEL15T/vEtNCwOk/RNSgDOHcxntOeZ2ajJK36je3klunE7+01d6L32z+JRs8+p1KXv9XpIvXJF66AzPaHDYF2rl/1uLNNleXMGdhoS4CJZr9UnckCpcCTvlujxERIrXfb2uBz+ayy6YvoXCyhW2N2D8O5aYm87vSgfhctgBn4ixru+u05u9yvvfVF1x5GUyO2C09ZPHpgUAmCDdufIWviRtCh4naodW7EX/rlF02Ego/b9hP9yXgr+cmIREXosNFkZv+qmJCpsK4eC/WVMOaB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMgT4dI0yQ9t+PSjM+ceMUW9rG0TsQY7ief3mz0m8xA=;
 b=UVWZJiIW1ThDeNo2X3PHVilMxK7oya/KQ8IByiLikQWdcrT+xSODL6L2F8oLN+BhAtqRhSzeAjE2HV+pmmosuv8NQ1kVlDsEpi+fvERACJARwFp7+xWnkA3p/v1dO61hrMyz2MQTsy4aZdPDQloHq1762c3OIFsfLqOrtwnKJnCTXp/IzTix+/mNIMttVFbqRrnyEacna2YQvoY46wX/V/3zo3x0Qg4Dmnlfkj9y46fsdLuqpb86w9VHuK5PuUugmHKtpRhIFj7H/RjMpRhOvugQky+k45WtVHtfuE5BQQfXhSqSUN4BmleQK1eaACDGRdzTcDJWn99p3Ibz3Q3Rsg==
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:43:07 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::6b) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Mon,
 8 Sep 2025 16:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:37 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:36 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 03/11] virtio_net: Create virtio_net directory
Date: Mon, 8 Sep 2025 11:40:38 -0500
Message-ID: <20250908164046.25051-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 725e1dcc-c774-42b3-8bc4-08ddeef6c9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oajf5N3zaPIwNuAGUklRi6J6RngDksaE5rjDrW1kTuta3ie2q+QmMtRoIfAk?=
 =?us-ascii?Q?u50CDwGsx/5U7x610xW4Rcexaw2BwJ1ddd1kOy7/Fif0IUlKNvH7aSujBpvj?=
 =?us-ascii?Q?BWqHrGlO4LnFfroFJBMntxpMpnG0M9gqfh7jgU6EIIglcc6DgCrpaSUSK6ZZ?=
 =?us-ascii?Q?tbxsgz8mLc1RpAzyRsScRx9f1Y1YxVTA+x3S6F7yS79RFOxBebHbIUjtWEV1?=
 =?us-ascii?Q?TnWGX7PJz6v0roW7xBm7eI1426XUsVavbBXFWvJ7txj4TD4L9k0Jz74iNKN2?=
 =?us-ascii?Q?nfbdH7wSq/2yFhqhIKRi2PBX9/8SuqH4kAf5ZeXG5ZJt4F6JQpeiwy2fwSne?=
 =?us-ascii?Q?FEnC8IGUsIQm1nPec2fIArf4apZLLfG+WIs0mLaoYd79LiPJdkHKALrIETMg?=
 =?us-ascii?Q?42YLD9a21Ob7Unnox0dPFy5ut16jYO2JnfI4ViH+HXNefeQNsoY0A+Wc1Tif?=
 =?us-ascii?Q?5t6GODXc8jmLGGO0+X/9QfnSaAKX5OvRShVJO6wW0psWKAcTfblnJ94NwxsH?=
 =?us-ascii?Q?zWF/aJCeC6cdWU1PXlJpygy81ZLOsnUlTMMVHeJ2eZx7JZ2kC8zEGrgGvtHl?=
 =?us-ascii?Q?OLbQbQJUgv4HGc9GPWwCgpM+gO59AqlwYjEmsF4R+KgwHUXvkZwA82jsRL5S?=
 =?us-ascii?Q?6+JXfpXvE9n4Pa4UVEPiclPincx6DY8v5mYoHU8yrf9N2fQdURrzf0emMx9p?=
 =?us-ascii?Q?3bU73vxZiaJbZB6yHM+br6oC3NhtqY3UlD5QVC7MbD3ZUE7aqqyL1kIiSSmB?=
 =?us-ascii?Q?3PasPIjaftqr6W1DuP8iGFXzRoNMPV/at9Y5F/vtOJvz81Jbz09cN8PckopZ?=
 =?us-ascii?Q?2L2NTgK/lyAkL+eU3EB9rUWn1rj8h5Xt/wyMODBFCJnJbxqYICCJ7LShmt17?=
 =?us-ascii?Q?w0svO6oKTMvLvSb+2Wfh72Mc5kMyfmIbHcsrVyI34kOZYxVrd9tpS5ZJZKCh?=
 =?us-ascii?Q?QdrxuPvZxZEKrc2YdIms1oQFuBVHLzEyyYsaWVMij67sSNONmkISb0oX/B9m?=
 =?us-ascii?Q?h8K8bo14kCfaeteZpob6c8VO4UUUb6Hc/wbbTox7TUjSFlMUL9Qldvsj4yct?=
 =?us-ascii?Q?S0pRF44bZ4kPMR1Bu8OMHIa43nG/uLPrvrR6YiXoZL0hRMp06s0v7A56p90S?=
 =?us-ascii?Q?ttICJRktBEf3mUUUyIEaHVXkR1Iuvd0ToT7Lsx0i6t4+sUgEWZERTDGtqIKZ?=
 =?us-ascii?Q?k7EbbJDwdW7481kXiTIWhTzgUvAiX+1HzQwwjGQqgEon031d06hu6FqOh2bi?=
 =?us-ascii?Q?tSgqCwZahzEV0HTyPP/BIpqG4WqMgJ00jEyq+DZA3F/+7CD1ynUXUUddZ6w0?=
 =?us-ascii?Q?K+v6o0qWhdIrbpaKrTbauB1QY2bHcUjJiIxBqycGWMjpOsGwBBI6DxyqpYKA?=
 =?us-ascii?Q?zYmyvP2sS0UmDEDuiXiaTVouFpOuh1TxB/xqtrSWrZf7YFFLCjXlweXrC9Zw?=
 =?us-ascii?Q?rvqJ/Np9LBWXKe895C1jzjFnPiIi6nCZvmvdOe4v9/Po8zVTseUBjqOZUmdJ?=
 =?us-ascii?Q?Zb7WpTPBKf8+v7SGR5kM0G2piMe84F0ef7nk?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:07.0799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725e1dcc-c774-42b3-8bc4-08ddeef6c9d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619

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
index bce96dd254b8..588252363a77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26625,7 +26625,7 @@ F:	Documentation/devicetree/bindings/virtio/
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
2.50.1


