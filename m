Return-Path: <netdev+bounces-243802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485F9CA7F26
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D8BD33A9ED4
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33232ED53;
	Fri,  5 Dec 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ivd1+K/I"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCE2FE07B;
	Fri,  5 Dec 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935625; cv=fail; b=OtA3LfukKGmPvsM8iMORligP7AlUgYWRpP/er2Cw2go42XJ75e22x/3tl+A+McD+0y+EQ8pzK8ZiCMTYW0cIjZHIJthN0BBcXP9cmfxQxLSu8H+RsiTd/nnNQGuL+s/tWcuXy5lCEU4aqdKiFvK6Ru6Pk2yj3sWnSNDXQIi02lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935625; c=relaxed/simple;
	bh=d5uI/1W/5ol8NelyNDR5uMrCH30IXxksifIVDT0McaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MonA6wYFT7Lw/EQWS0z9Ti4TiS1CR63NdOGQWB1v85Kq807W++Z/7+GL2RBZ58IGRZAfHB6KEiHVUUf3G7jDJ773iQ03PY2WaX0OVnuYfERn/rwTd7Yw/s+soPzGNj8OGBGddC3O9PZ787JYcf/RuNW0OAesA4weBbGpJ04IG3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ivd1+K/I; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmYC6TD4Tj1if7D3FNBu0ML0Bf9WMccA7zCfRLyYuPn5qakLC9Kj8YJNTZy2b7d5WU0ZjVRAWvwtLsfVIk+zamBdpd7PRcMWOHyf3zhU6eLODIvA8T4GuvAr+MSkgYoCVtoURwL06XHD+b4QBU/yDBH07MilzL8VWVQlijzhrd0zN+2kpe3b5p8g31oeFGYTDtOoCWowhuAFQUGQaCyARr9P+gz293x38RhoNkwtkX8GeNi938/1rrcxBRWwWzIdhgpu0Vy+LBXGuDzzDdzF3a+mnbWFAq5ce/GYI48TJ/0Li3SvlPyfCEqV78qYj1jvEJLbOsH67D9odgMxuLUNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXT4hMsbEq2lz3ZYW8nJtLJJTcOMN4MUQ4KxiywyoX4=;
 b=HhGpC9wpnHCN4t0sqvrnn5jI/HXeznykZUCGvEGRKQl6zTma5vE5UTpE/W9OyFYsYIvRQbxBFZzDOR+ODp2C9aQ/NjxgOiMpycFVtnq7xsDgB5MDj0ginEj2KyGmQVhAcYQB8a2WLMmNdnG/ysHpVoGZz9PGCjQwfDD9WA0p6Utj1sDb/cDDfLMTuyyFxqsqLcG8gn1ICNcaIOV8o6xlC32/fahD6B3mc1y6Ctj9D2iZKkQMf+cn6TwrISPehbOe/+xqCNrJy2Pfis031OZcWqmpg1O/tFiDO+yufCavo9fRRWl4F/G3nhpIhaunIIYqS9IcbkB2TRcMGpVEXN1m8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXT4hMsbEq2lz3ZYW8nJtLJJTcOMN4MUQ4KxiywyoX4=;
 b=Ivd1+K/IAOO0+CdvtIkPmWlOZCitOHu0RVjAKC9xQUn3r8ys1mYxf19I+9ILmOHa0jtMuRew80VCa9Qv254EhQuVDlJOSdQtbqzQ/XdpdFCY0swCNI77hgCorD1ljohH42TPH1F+IFmx1OyWGhWjBZmPVMFBo6gapwWVDnJyyTQ=
Received: from SA0PR12CA0004.namprd12.prod.outlook.com (2603:10b6:806:6f::9)
 by BN7PPF28614436A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:34 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::e8) by SA0PR12CA0004.outlook.office365.com
 (2603:10b6:806:6f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:33 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Dec
 2025 05:53:32 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:31 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: [PATCH v22 23/25] cxl: Avoid dax creation for accelerators
Date: Fri, 5 Dec 2025 11:52:46 +0000
Message-ID: <20251205115248.772945-24-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af6515d-dac0-4afd-49ad-08de33f4eac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWYsrDBXEEwAhFXYHdySkdqyeX8nu9NwXK69ce5nZvzUen8gIL7TG7atput2?=
 =?us-ascii?Q?uGcagV0DbclL10EwiJg/vVGrtCrS7EP3Ft++etMhzcHyywxUXX6zDb6vq+ED?=
 =?us-ascii?Q?tblPBH7eL1ABSUUx7ay66nd3tHthyj5mnUHGGvjwlclp5Yo+wNdS99JqBZ0h?=
 =?us-ascii?Q?nv2bKOX9PrqNKAezj5oJjAhlGwgE2XbNJqgXy500eOiVPeW9lNgYnSzHMKC6?=
 =?us-ascii?Q?lfNCZrqYMJ2UHBvCGd1LEmk/TzzX5SPyUjzXCs2j8FJEdo+Q7wGfTM0rmZaV?=
 =?us-ascii?Q?hV8bLXj4sQP4u59dNXrHpDPnRysVywgrD2vTftNjZjzkKG9LtegVkaJIMC1R?=
 =?us-ascii?Q?hVKWoizkBqGpoOBNdSy1IbBz13T8Tkt9Ibt+lkdv3g/pLZQRLg148deFSi9g?=
 =?us-ascii?Q?S2rd8W2EPuCavn5Pjr3bSqrkqXk9qPXqnCNW4BZ/czt+MBAvk2DU2U9ODpYl?=
 =?us-ascii?Q?7+L0fuf19UzOyacSfWjA/JiKu+92lhI14Olt49rYoA5z5dbXchJpNe9tlX+G?=
 =?us-ascii?Q?b14OI4gP+IOa+j+/n4iWY/RlfMAV7f415XQ2MawxoVdz/HGbHToxie0ip9Or?=
 =?us-ascii?Q?IdFdYGeYQ8iDhHVatlHDdTVaNvO2pNBM/f/+2/htEDCcQ+5pVKoDocVqa+29?=
 =?us-ascii?Q?SO3lQl7ULdjTuRXcbFvAgxk3YGGYkcCtvxu3DQg5uVG5Y0CWqZKwsDk8GdKA?=
 =?us-ascii?Q?mlRbqySNkwpBpSD+6VR78Uux/+2lna8fVvxMUuHIBlAoD15gyYdGqa1gevcY?=
 =?us-ascii?Q?+h3L0Lfu1UkZzZGgLbAc8qCdWbVnhCjSVyP+94ge54e1nF5oIqNLSOXeNSN8?=
 =?us-ascii?Q?DQwq6WdxAJPjqGLW+bFsdlb6BrQxORfsB+6P8u0EMJzt0IvN5a7p9K7DNCs9?=
 =?us-ascii?Q?v3eju6rtsu4j78opMDjRh8WJFzAK4ofkvj3iwFhiy/Ngu+bOXhf3Igr9GuDC?=
 =?us-ascii?Q?z0eiHbyYKbHl3cf2Fmgjx/VXPJR0kW2W0pq642qYoACtZ4DFci2XRXAh0TGl?=
 =?us-ascii?Q?JKxi3UPyck6Y3UDqTJVx/33sC4mm0ElJux8kfIh6fSR2Z0yJlBVpvox6ViTu?=
 =?us-ascii?Q?ivPC493g7EcqUJ9BEzGkosaQGvJf0EBSDuV0mdOzSteqEaE0UYnuCpYyzhYw?=
 =?us-ascii?Q?WzNJcT0cT1w8oYpZonCSMieBjxZtfoXguLu+DJ5uzz19jZ6LA7IbNXIfIQVt?=
 =?us-ascii?Q?oDWdCxCoAkmOIg2knemm4jlBCk94SLXEZksDkK9sMWEYOC4h/ePqBltxkC5y?=
 =?us-ascii?Q?lA2erAj33O1fVU102K6Ptyxs/vlcdyY9/hLUeRDKB53hIXgR9Hoaf5wUZYwi?=
 =?us-ascii?Q?U0gxa0wKQUQc9scJIt+OQlEL43hk2j8iWqcYaUCa+dE3QV2hRqdlcCO8Bwsz?=
 =?us-ascii?Q?tYGN+JVksF9fveeWPXHilBrl70w7YPOeItSEJgPqSb0D+Ws/V376xyZA1TUY?=
 =?us-ascii?Q?RGKb86H0UClg7ydu3kIPn1CqduXkbYAVh8Px5qgej+rsO5Y3vJTxHyqVjhcZ?=
 =?us-ascii?Q?GzpSNmmETxoqBwyBjA6zFjAo3ehlaJu8a/OK6woHsbjqS3fu2V/murTZlB+e?=
 =?us-ascii?Q?idpdPmULI7Vqi11E8Hk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:33.6513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af6515d-dac0-4afd-49ad-08de33f4eac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 694bb1e543cc..4d37561c07b2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4116,6 +4116,13 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	/*
+	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
+	 * Skip device-dax registration.
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM)
+		return 0;
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
-- 
2.34.1


