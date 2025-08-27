Return-Path: <netdev+bounces-217407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D8B389B2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F407AD032
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA92E11DD;
	Wed, 27 Aug 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tutie7if"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E92D8398
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319963; cv=fail; b=MHhS8Vp4Ks7SMPGb0+SqWAGCrPS277xo99cIeebx/enbPH7H8o+ijA1kXGfrSy7RaVA4RiqBfcvj0qmSJjWj859E+Fjs2TDXnAW/xoLeLrJHllEa14J4O5AdU81THHfs87mwDyDGvnk/GXAXclOX3/2Qi17Q0kEBpekEe1ihDVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319963; c=relaxed/simple;
	bh=hez1QZt47g+YLyivWHFbxMWhDOpIOCyINFP/EkmuQuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZB7ouaPteAEbYuLrVMF23nlXXMnZPEWg3wjPZUs2anoE5Yk2PKSOdSvr8Ve+ddkyvM5k91GCMWyynmXHb4g2aHbZoAOmIRFc+jGysnA73ZmkZRy2sHB2Ob98CzcCnzuVpx8YLFVp3Qm2VVNSv2YCbm9HklQYYqq1t68KQ3avkp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tutie7if; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpnknd9oQ6UK6Uvwi1Sm/U31C3jLHDBjGsE1wZVtc6z758FZhAmqMrzssHwzYR4gQ3izS62oM5kX9seNQIsSGUUcM9qIZby8sgfmeoQt8MVBuvBnDLUWaXQi46izUIDHXzpLcOE6vAIVUbkVs2VKeqZkoaGQ8ZXPCq3C1WWA45S6hBOlmUmBJE5fywiC6au+v5Gp/SZm2oFCrl5YdvC5xb9Y8jnw3FCgT41M1BI+/0LtsYCS5A/T5+pRRlnpqUteTBMY6aWgzPiT9WzKs+vq3Rt2oZBTabpGDc/hk+4IJGEtyAJnerBW8sULQJ/dZUGzwmQnq+ihn75nP/ZXO6rYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMgT4dI0yQ9t+PSjM+ceMUW9rG0TsQY7ief3mz0m8xA=;
 b=vGd9MVSLpTTjmOE08ZCjEzxawhxiT7Ri2la8hnpIAoZ1ov3jx/ko5zN1kmBNS2IAgPFlsWWnRxyMUtC7bRWcTGQC5LDprKmN2SGGtUI72rpWTbykYYU65x+5VIpaX3yCcK+53HBxpKeYcXgeM3GIKZEgW/PlV11sksxndf9HAz/6VlyegB2Sno2YdbLRPfyW6usYoCrkTLQW8QBer7hqwov8Luv7bTA9OmhkqGZ/ynGEbjy3zWv4dQYWk6kwHWCEFIrcTHlydKlkhpm7W4+oawrhXDnwK/SYrArxH3DKziOcRtOHH8kA3p7FQYcfOhYfmPekZyDQFhtv0bNC0yde3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMgT4dI0yQ9t+PSjM+ceMUW9rG0TsQY7ief3mz0m8xA=;
 b=Tutie7if9alHUZBuRWOtXt9BIO3gaWDj1/2TWkDeLtLutqgAMFV7FOzN+xBO5BwnlDVJ2XSrIFBVXkId6Xi2I0zfmDxafxTSsKmvUPb7T7uFH5lj8ShTu7EjkkVyX9+nly0J3l/Qbsja0+q4eLmT7wEZoWlzJGWMK8AVnJLV96zxD+MNDxQXcSOUl7+serOWAV8vdaymXwMSfMLx7kel1CEZev3l3JF9hlm2eFJXGvEaf3N/ZDNiRLaJC+7Rt6Yynl+4R6In4pnRX8uSTMnX2zpdFR8bVdkTaNePe+gkyZrVT/6YUygWWQ/JaIAZ5oJR7OAbkJSOaQQP1pm01Z7o6Q==
Received: from CH2PR07CA0041.namprd07.prod.outlook.com (2603:10b6:610:5b::15)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 27 Aug
 2025 18:39:17 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::75) by CH2PR07CA0041.outlook.office365.com
 (2603:10b6:610:5b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 18:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 18:39:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:04 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:03 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 03/11] virtio_net: Create virtio_net directory
Date: Wed, 27 Aug 2025 13:38:44 -0500
Message-ID: <20250827183852.2471-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b5c158-7912-4cf0-2ec9-08dde599075d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2IgmMtdWkNH+rKcu60MGdWyHBlWw13/6xB7QJQssKRhTTM2l37bS7+ed5b9Y?=
 =?us-ascii?Q?74BtCfyTrCxrv7Aee5XDwad/PZI1MMVTY+Wn00yEgUjwaRewhp7/g7c2sHBg?=
 =?us-ascii?Q?RGf8xSdlUcV2S1xUe7101Gj6oE/J1ChOeIvp/hTNx2kr2PbOcLfMWt9Wno1z?=
 =?us-ascii?Q?3lYLdmwDZ2x7D7liNchiWud5PzA5Je5JavuP3817cp+KklmJ2SD+H+Yrn0Fy?=
 =?us-ascii?Q?0XK4B1Olm6z5iWqVjlJk70XD/hJsxUn3MkzsfUUXWDV8eHJcThciaKWO9h96?=
 =?us-ascii?Q?k5vn9XlOiWp2dSwh4uyqOcV1H4kk9il2Wi9HcClQg4s33NBbX/rLi/TPEnuy?=
 =?us-ascii?Q?JJlAG3G8ZNPNA5k+RCQptqQA+IV/bMYWnKOuEPgQ9AVpmisum7ujCt1Y8Y64?=
 =?us-ascii?Q?jN/wkil7WL37WMehhZYf+8SL69a/4/S17eRQm3A5yyldoC0eP5Rl6bs3J9dq?=
 =?us-ascii?Q?Yv64u9PwVtQRgNTDoR9+wvNaMyUfs6shVbI9I19msbhfaRzr+X0hXKtP/Yin?=
 =?us-ascii?Q?74DKa59MGC+xv7EGbJstoQvmh7Lm5TaM7SQB4TagnVRmAqtXGTS7w6A/vT9u?=
 =?us-ascii?Q?uOWjqlJKKnEOlyB4ciW9hwPhwl9HUZ/a0FG69M7QrVosSLWi2biKGNTMg0cr?=
 =?us-ascii?Q?z8GOBpNK/Y4amn5LkLM9/vnH/xLSHA3A980+N8ydZPQq/0dXb2o6+cmmD0CI?=
 =?us-ascii?Q?9IfzQ44OIgnci2xSWQf4tyQ9Al/ASwcgh32kHxtzkpfBtwAhFEsiJNbt5ERI?=
 =?us-ascii?Q?W6DSV8LTwc2N2RW6wqCguGhctd+7ZFez7y6rnAAJJziTfzsqrXn1pKJtOCav?=
 =?us-ascii?Q?izSzCxXAVrjVaku2qoYwdUlh0NWXv5wvieIkCs9pwfgkzLvFV/XRJj8i6nQi?=
 =?us-ascii?Q?x6wrNBKCbHGcWLG3Ah+k4nwKc6bRyswlCbH9F9Sv8DWGWNnx3KMLaC62m95M?=
 =?us-ascii?Q?8+nicT4lde2QEc6PszEkrvz1Mn3c1vzKN27tlN83kq4d3ix0nx2/GcdPCYR2?=
 =?us-ascii?Q?aPOWVnVHk6iGM+vx4Z18njbAMEn/Z+VslvkRsg2AzBe/6b2ZyJlZjwn7pHAz?=
 =?us-ascii?Q?k5XngB1ZVE4zfBaCFAp8FIT7agTdn/T3pkN0TaiXMNyF9vBhJg4BOd5pCMy1?=
 =?us-ascii?Q?UuqHvHVVbYf2zB6MAvu/oZzHRKiYVIcDnQQ7Paxq1/qbJC2ohhUYr2nXsiCO?=
 =?us-ascii?Q?cXzF9CYGVD4QUYSaB2P4XkiBt6Hl7bVYHeUKSHi/m4k7p8cKs5wK+Vw9rKh1?=
 =?us-ascii?Q?rdctRw0WNBRIomYLR1MxbKfl4Pi4SgHlzV4fT3Aj57Ar60vCb9oUsZBSO4GS?=
 =?us-ascii?Q?09CX0yNBvW3uyhklX/WbQSdq00phlkICQF+Kn511m+GWWeT5+E4o3CSuhrzC?=
 =?us-ascii?Q?LByD4Rx61tznZQfHLLslW2SAa2R4FEUzlpHfmCGIMDmDcifmbzNRMUIdVf4/?=
 =?us-ascii?Q?OzITo1KPy9GVLp9aBV+KjudVRjAoP6lZaHiBDvx4CL9ZjBsGRcRiPFisOMtu?=
 =?us-ascii?Q?rKPIFcHWiW7/4GVwGUj3TOm3HAHo45+pD2Gz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:17.1376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b5c158-7912-4cf0-2ec9-08dde599075d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153

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


