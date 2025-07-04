Return-Path: <netdev+bounces-204138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D5AF9279
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3391CA77D4
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B946B2D6400;
	Fri,  4 Jul 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i+T/oBo2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8F2D63FB
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632114; cv=fail; b=QOb4wB6ja6jJPXZjNb0mhreJ09OK0wkxoMLSD33yw68Q8F5w8mVi1GOG+2geCQVLBKygG5yXCJE57uSPG0e8tcXOIAjYzzte51VulLNHWrmI3dgdLKf3iTtjL4sOCcK/FIZnqBH2uNFkrDbmyk6HSCicV5txJX6B4nwo53b0yjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632114; c=relaxed/simple;
	bh=6Vme06U4SbBfgYBVa/NJYuM8c8O/1urhnVFGWm29ATc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tP9HQcPdUGNbCchmnJVGncnuz7xZimRWFGtIg0yRLWWMF7KzRvOmfmp7NZruvRmYv2wBRsNGjWLtnswi7kIP3EWT5BsadXUsmmfHiM8iGtLps2DjGartOm/2aFReBFiqxNEZXmxoTknMrkYWNBowxHa4LSW8XGc9pbKYOthv6uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i+T/oBo2; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2AtcZs4Ucw8N50zm7m+P2oNIY768PpjMEG6MHDw7/u2DbebUkwRpmpfT1pTf1rdmlZRdJj7fuiV9ESxakIJ2k67LXbSTGwKKV/6b39jFSXHfl2wZ/MVu1dfZiDFaRSu0SiuIJulGk4Cp8L0Vw4/uO0Z+ys6xR+GFDOrTEXICHZ070AejN1k+odoU0NXeZLS2vSQ7FPbQJZLbgbHBp3sGX3s7K1neEkDEnsYIuUghNU4yw1ScTJo3tsrYL5MGKwfqX1l469MKkP40j70OYKa4bMjayc7jdZ28r1PaznSpQj/pt3DFFif8VmIfgGhJ/0xxucysdvQqFOk5go0Q+ng1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNIkUYFF0zwc8nUJfm1tIEbo8MsOfDEC+83yDmKLyX4=;
 b=Y19fiBlbNGe+tHTnDcWgFqfFummfR5qmWQu2ORtSZy8JNfMMhdFt1gLEWAe912rNsDlEN1nbaQVGEjFNJ4ju973UA7nTKmBPUQuxUu7GRWJAxrRKOFKIwTK3FnQUYTQAd05mdmyWRIzhkYmvNzymPR+7NWOTqISY95LFDxfw3RGz6VLeyaYbcK8lkILtC8XKlUSdtYg/YH6uqxCvLYdbztkMAdVSRlmBUV03K83Hc2fNBwpvnEYsnqrsEBxbg91Yxy5xY3aF6+h1/E+Od/TnuhyVdJhoo1WQuV9cHp69PZl6/EkMNJh4QvMDbRVPVLdkgYwVexfGMYEIBGleGRKz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNIkUYFF0zwc8nUJfm1tIEbo8MsOfDEC+83yDmKLyX4=;
 b=i+T/oBo2gxp0383GN4U/YBozmky84UnXXzfEk+OHb44sDgaWYre9+eCLjpJFTMBX0sF/TV5UPm6bF/iLvhzdBBN4WLbEBh3qZDwiJus7Tv6QSwIm4dYFRYaaJYcGeW26f/v1w/0EzSeosqP7tsJE0/VyNtYrRsHob4hoUran0CXRYMhpHyHozUaseK3DpvEmi8GOf+FiRPSv16VcbIlXbHIHmK8OAfaDsF9rGfJsSrhPKv16qvnq9F3fH7KV+XGeHD831PZVavAQzdwBF+qu1tbJFtP8fupmlSZ1SEwa514jKCaQuAex/UWywsnvATM8VcHVtChM5zyr523DWlsgqA==
Received: from SJ0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:a03:3a1::30)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 12:28:25 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::7) by SJ0PR03CA0385.outlook.office365.com
 (2603:10b6:a03:3a1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 12:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 12:28:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 05:28:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 05:28:22 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 05:28:20 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: <stephen@networkplumber.org>, <dsahern@gmail.com>
CC: Jiri Pirko <jiri@nvidia.com>, <netdev@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH iproute2-next 1/2] devlink: Update uapi headers
Date: Fri, 4 Jul 2025 15:27:52 +0300
Message-ID: <20250704122753.845841-2-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250704122753.845841-1-cjubran@nvidia.com>
References: <20250704122753.845841-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8e0b83-2fde-4c74-5baa-08ddbaf6456e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BaMDV94pgOnq73zOv72hjF8hM+h0Nr1uLMBIA6SgjBio6c+SHAmh0sbcTa6h?=
 =?us-ascii?Q?VIojAn7mRScAfNTjcbqoIne5JUiS6WgKF7hhmQGEFoInyPRI8GPg20B9pdoa?=
 =?us-ascii?Q?Br0ZFN6g/CsmuOSe6WhxwrVGPcr+J9Ed4FitpJMnlhcNmFOKSsIWUdrfYb99?=
 =?us-ascii?Q?2ul50xzo31TivxDPQXkEtBEQyrGu2UVeGIEhlR9tCftkGluABA0L10D9bGUn?=
 =?us-ascii?Q?2iIAcnfzndlzugNVEodny9K7F67TgZ7jbvoU1L1ej2e4xi7MgduqZ4k/UX4w?=
 =?us-ascii?Q?GYqMcqnQYe2TVXoyff3ZbAbHsnMOx0QqUmO9I/aTsut61JJTEWjbAqKE6o2i?=
 =?us-ascii?Q?vk5ifS3vhSvftu4k5CbPUXCettEmjZp5dFljK4lEbWgxrJkErZq7NIhSYTjf?=
 =?us-ascii?Q?/Myu3oXmk1e4Zv196ZU3j8HLQF8tY+Uyj4J8KxZ1GSIr5rPfnuPEtVCVlDIY?=
 =?us-ascii?Q?AcKkMmhozlH9/5LWf/Nn4P6MfrSTAbdMgt/BmQbxhQ26ix/Xmi/AchyywF26?=
 =?us-ascii?Q?O/Hb3K5L4XIRVndXiAXiixDrY0NEIpj02wxQtQ/6WOkm8p19xM89MZIcYLKS?=
 =?us-ascii?Q?RvWOxEj0tBdERu0hnSq7kI/12lzgA/YGXI827I87E/lDM3gm9mi6q/rF8WZc?=
 =?us-ascii?Q?M3o4h1Trou59cppqKVRqlwZK85DkZSW9BRReihj/DiDu5bKlLPr6btwmkT6K?=
 =?us-ascii?Q?FqHOoTGX+0SG7r6/TXkr0BT841alOmaNSFvlxaTviA4/ICIXSErrufZp5SAU?=
 =?us-ascii?Q?rzgkSuEgn5hK2JQT48cIJHZIi0mJdfxyhN8pRfP/lIrvEMrm2T044kUPrLQM?=
 =?us-ascii?Q?JYJ4uMAwrw5uqzbwyGBl6rIb3voEU4YN2+VprYjaDxgHJuyyVdiRV+yOb9Gn?=
 =?us-ascii?Q?ik/4tpVcpRMyaripQNaixlTIyERPverfrTOJIchlITjOhdChePE7kfp1zwIx?=
 =?us-ascii?Q?b/MGzg7nr2mXYndednvUmC2kw2wpJLE7wziB/s4eullhBbpP0agDF4769GKy?=
 =?us-ascii?Q?c5s0Ehg8bk94On4yX8TPcB+Hsv7o3XoP49xlUJAMGMLJ1It264CmGQqNHmOZ?=
 =?us-ascii?Q?MFy/NayAq+3fsrCOcdxPyN2xVvAwDDRwiRv19UCFZFFLzb+m4rIjh1JB1ido?=
 =?us-ascii?Q?tekMmq5/eymECENh0o7DyfVGVcs5JSet2vYRLSVsTERJFhOLZt6dc8b+NvhB?=
 =?us-ascii?Q?MZj0nF3SIPxdqiYk25eSMldd1vbtgu3vWesh09iHNdoQutZ1PxvvbKkw99pM?=
 =?us-ascii?Q?re1wdbCO6UvRVe+mll3nEbBHAM4biVz7h6h926P7yjgpGygm8VB8cZR0Iufi?=
 =?us-ascii?Q?P1aF/l7JXuX6ghBz7RsG0KsgaUc+qKTIqz3DkGT/12tReu9j3ax58pe/VsMZ?=
 =?us-ascii?Q?t8btp07Q6gUsbtaJ+FzBKxrRa8a8aoTXmiGN+mIaYGVsEQgo0T2AF4KkF54n?=
 =?us-ascii?Q?ibcpWy51VS4XKHdnm1s0ayX5ZQObTNZVLpxI/UkTGtpX2ErBKznoX6BIXl7D?=
 =?us-ascii?Q?aEwZbpT8JnlF+Xz1xz5934JEVm47TI/sd4Ur?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:28:24.5410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8e0b83-2fde-4c74-5baa-08ddbaf6456e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607

Update devlink.h file up to kernel commit 566e8f108fc7
("devlink: Extend devlink rate API with traffic classes bandwidth management")

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
---
 include/uapi/linux/devlink.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9a1bdc94..78f505c1 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -221,6 +221,11 @@ enum devlink_port_flavour {
 				      */
 };
 
+/* IEEE 802.1Qaz standard supported values. */
+
+#define DEVLINK_RATE_TCS_MAX 8
+#define DEVLINK_RATE_TC_INDEX_MAX (DEVLINK_RATE_TCS_MAX - 1)
+
 enum devlink_rate_type {
 	DEVLINK_RATE_TYPE_LEAF,
 	DEVLINK_RATE_TYPE_NODE,
@@ -629,6 +634,10 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
+	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
-- 
2.38.1


