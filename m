Return-Path: <netdev+bounces-104676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B090DF38
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07C0284580
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34685176FA0;
	Tue, 18 Jun 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ubFHkoQH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420C1849E7
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750732; cv=fail; b=GhuP1kHpyz/cqT8HpfXlobfOTTuQA/IVl9gI2LNVO5qN6pUtzv26rWvw5r/xvHDMiAQ5kXIT8dn4Y/4razRIzWzJHUZayv6+BaWDh/cyyD/umRO7YJN6yu/HPlMyHXCewY2iVWH1NyruX7f3NVmI0Qsdn683rUsketDlV/8eaHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750732; c=relaxed/simple;
	bh=fW28nZcN2ZKZHTidXdoeycNG0iwO0O/Un/z85wwJucY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFlvkOOS6t3b0nFxoI4Tkwv6YNnI5+wTlOmm28vG3dFSPLf87NcGXGDuiIr346eVRJq8aGt+AJidYrBmhvRFqRx3SleisllAZEcQ+RKPeL4BRPsQm8Le6O/kn64hEOugHtV9tmXk3JKkGvFVhvdW9d3FYQOdloEhcknXUrln1CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ubFHkoQH; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdfzAoz6EEVR1ZqIi4WVXocBWG8BFMn5f5UPiTrnoruUg3YmArf9tr2XpucwvmAWIyzItuUmb0mberrCuLZUXQhUDA+2vQMGtwhfjhI8e/PPqNUiUVwEK+YZXe9LHFDQzh6D48jr0MzuwryJS3S7RIKdo8N1yTl7x8JjAQCtCCLwG8WHN/P1rlqIowH4cAAazkHw9+/9w256QG4qwxAqOhYMRdZg28TISaWjMeG3w+jhcFPkwCM36melXQsFYW3P3Q2z7I7ZgjqjSpmOQ3sB/MPKiHMU9Ch5bgvIPsOFMhG1APROA5+Jf1/0lpPFcYytOVphFSCAkCcOMhvYkZQU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMuRKWMlXWF8UnYtFZnKBN0HFTtOKPGEKnk5Ryx7Nx0=;
 b=gVVlWBCmPOtHf7a8hAYklBFIJ6EJuyYq7xw5ughZP+ZQU+HDlCFq7+NlYc6LWNj4y3T1GIqeXQXvJcLs5+8EKIr2Ud2NxhH+6K+zCV6F/qdysloi3kVWR4KSTJv2/+ZcvWEMnzmQxm6LcgVXmrM8qzBCQ6SyNrFAjkYHUc1lcghFA/LnIC7IfsUPRzjqwBOx31eXItOpWIHRTCIQcNHsHIkCyGeIuv5mxEVNGxCXapgvUpj3RqBG0YdkRC5krPbbqrQD6MkFNqj1VvkqI/gnsAGX9b5wkMd5m5KtDQGhVU0TGrZG96zkI6Py2x4Dg6yfZds1OoQYwPCJuaCMc8qaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMuRKWMlXWF8UnYtFZnKBN0HFTtOKPGEKnk5Ryx7Nx0=;
 b=ubFHkoQHytcHCMFYvsj42pIrUxl+RPiRksaqQIH8t5Q22rsKG63pq3wSvGZtMPkGn+VTjpVgJGXlv8qri0zXehRIy7pH9EwHSe9ldK/NuxMLVlEqCAK5ubd6s3g49YN/IT2QOyh9tmbpzpzXQ3ngsQMToxuBJqn/xvDNkMJSRNc=
Received: from BL1PR13CA0172.namprd13.prod.outlook.com (2603:10b6:208:2bd::27)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 22:45:27 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::2e) by BL1PR13CA0172.outlook.office365.com
 (2603:10b6:208:2bd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 22:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 22:45:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:26 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Jun 2024 17:45:24 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v5 net-next 5/7] net: ethtool: add an extack parameter to new rxfh_context APIs
Date: Tue, 18 Jun 2024 23:44:25 +0100
Message-ID: <7cebfb7668baa16d559fc891d1fe149e6a79a51f.1718750587.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1718750586.git.ecree.xilinx@gmail.com>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 24382901-4d03-4713-a815-08dc8fe85961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iCSDfu85FPC/15vPJ3M5rGGJAGCxQ/nbVeu7+4TrcDCAxyvJmn959vWwgUAd?=
 =?us-ascii?Q?haYz3nwp4acmlfu2YMprwYOOW1WNGDe1+Sb/zSNZiJ022sCy4/wu5gc1phxg?=
 =?us-ascii?Q?Uf9pL3R0JmvkdpZRLkp96vek8t1ewGHHQrNWgKPZwPheXGjbD4sXLPHAEVtN?=
 =?us-ascii?Q?rbPMZVnxef70hI8qsbrkwJXl3tQGDwzxKjBIJ7/xJHuRAaMMXE5VtlTYq8wN?=
 =?us-ascii?Q?/3LuiJGW8I4E99/FHG/dHFlSuR/u8zc8wVjX25yBKowIZZ1TTMobcUX3mvW4?=
 =?us-ascii?Q?C4TusmRHom/hiNgiPCJkpU/khSLvNKng8RNd0LVqgoqGU4+eDkVx7N1X0VYY?=
 =?us-ascii?Q?owBKV3LiNTYueJzruczC/VkqjMY2bQ+KhrBQeC7c85acvoUydIAiQ10k9zx+?=
 =?us-ascii?Q?+W5i3MnQWnHQWC/hfs7q8AJULA9eRZftwOL/9qQuEpb+ch7eWOIoZg8kGIn0?=
 =?us-ascii?Q?Ccy4GTg0NxSI9NTcMCr9VadTgyZhJ9Ahmkjuq5EXpKf/sXAoK3BKE/hK0/zU?=
 =?us-ascii?Q?wWXetU0NBHeG8TupS75hpIy22OjzxabB9hEAU8dkU37NzK/I6qB9JvhNs19y?=
 =?us-ascii?Q?L8cyKt3Zp/+pNYn8syHT4QJocTsx5tw/xnZ5O6/Qg0Nqb6Wuv/MrZeR5e7ZS?=
 =?us-ascii?Q?htURYDH/f+OnyzxqBt/diGkesG2g6EYlZI5rOCValAKDCDCIpUa0cQn7R+qF?=
 =?us-ascii?Q?HeGl9MFia26oGIbywFK/I3KGYabZEO5J1v0us24qLeuEXxVPeJjb84ArFOQQ?=
 =?us-ascii?Q?kmgrmOhj0cTpZgYtmeS758oasf87lbAuoDxq/8ntp0aGeZv4lJ126+0LNSv/?=
 =?us-ascii?Q?S3x1KPUn8Cab2bBe8Tb1I3NQV3RqtmtJYeoFEIEmwNi8J6JbJ/Z+kNgHMfqP?=
 =?us-ascii?Q?iRjmaKaBhUPTr6H7TSn9aTFII3nbhCArl/47j75S4WGCYWkHSR7QhRJxuQwx?=
 =?us-ascii?Q?YxlErFYNyiZDPjh7UcUzRN2Hy8yGjX0G8ai5pN+MzXHESDegGNAXso13eiTx?=
 =?us-ascii?Q?yj0ZPuT81xWqz8liLeIDkidtniDqocxVFfT685xyEDv6QykHw+Pq8SWpFcyT?=
 =?us-ascii?Q?m3p6rWlkbGFLowSPtKNRLA27/MXRQQR1jnN4kZRHGnsUxAscGe+Q3jurXoxG?=
 =?us-ascii?Q?rvfXNPDI8UEpIh5FwQCDY/gQjeJedjkxmipGbBvrDUuwXFNp05j1V8OFxAVA?=
 =?us-ascii?Q?mpyN9i652jwhErT3xQAbChZjk2A6mSOJmYvTyjrrQaDxclPbxOCDnKQLZH+Z?=
 =?us-ascii?Q?7/IDIWkURqCEHJsPaX/vnBDbqLOoQmlpIgG+g57aZqRDOkb+OthcLbG/4VJ6?=
 =?us-ascii?Q?+G2vfZdyBebgY+tuHpAffmIZgJqjShaovVOznzx+2zfjD/ioPMxny0LmxRC9?=
 =?us-ascii?Q?Clyb80tVp/xW5cxIpzMI0eUXyHyywqCUKjxyzalkyo0Wvl5HmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 22:45:27.3743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24382901-4d03-4713-a815-08dc8fe85961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

From: Edward Cree <ecree.xilinx@gmail.com>

Currently passed as NULL, but will allow drivers to report back errors
 when ethnl support for these ops is added.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 9 ++++++---
 net/core/dev.c          | 2 +-
 net/ethtool/ioctl.c     | 9 ++++++---
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 4fec3c2876aa..f781894a7cb2 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -998,13 +998,16 @@ struct ethtool_ops {
 			    struct netlink_ext_ack *extack);
 	int	(*create_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
-				       const struct ethtool_rxfh_param *rxfh);
+				       const struct ethtool_rxfh_param *rxfh,
+				       struct netlink_ext_ack *extack);
 	int	(*modify_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
-				       const struct ethtool_rxfh_param *rxfh);
+				       const struct ethtool_rxfh_param *rxfh,
+				       struct netlink_ext_ack *extack);
 	int	(*remove_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
-				       u32 rss_context);
+				       u32 rss_context,
+				       struct netlink_ext_ack *extack);
 	void	(*get_channels)(struct net_device *, struct ethtool_channels *);
 	int	(*set_channels)(struct net_device *, struct ethtool_channels *);
 	int	(*get_dump_flag)(struct net_device *, struct ethtool_dump *);
diff --git a/net/core/dev.c b/net/core/dev.c
index c4e880397c07..09d01b49a414 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11205,7 +11205,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 		xa_erase(&dev->ethtool->rss_ctx, context);
 		if (dev->ethtool_ops->create_rxfh_context)
 			dev->ethtool_ops->remove_rxfh_context(dev, ctx,
-							      context);
+							      context, NULL);
 		else if (dev->ethtool_ops->cap_rss_ctx_supported)
 			dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
 		else /* can't happen */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 2b75d84c3078..244e565e1365 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1423,12 +1423,15 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 
 	if (rxfh.rss_context && ops->create_rxfh_context) {
 		if (create)
-			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev);
+			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
+						       extack);
 		else if (rxfh_dev.rss_delete)
 			ret = ops->remove_rxfh_context(dev, ctx,
-						       rxfh.rss_context);
+						       rxfh.rss_context,
+						       extack);
 		else
-			ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev);
+			ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev,
+						       extack);
 	} else {
 		ret = ops->set_rxfh(dev, &rxfh_dev, extack);
 	}

