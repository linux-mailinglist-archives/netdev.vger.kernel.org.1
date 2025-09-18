Return-Path: <netdev+bounces-224330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C076B83BFE
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1990E526C16
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83203043A1;
	Thu, 18 Sep 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f5vuUU3P"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F2302759;
	Thu, 18 Sep 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187116; cv=fail; b=PCJLDmYZPCCrWdLoXV6jAp5kospRgpf8c2fSM4ccOFLaVOg8uDF5rgGn1R6BfNtUbBXVqPU71Kx4pzK5Mf8rJlmG2XGyvs3U1laggai5gLEcHNdeU5nl+Due2ZOs9lS1BREYRpFZcYspKbaS3K4nEtbK8xCyAj57HSHO+uUDbjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187116; c=relaxed/simple;
	bh=0Um6hyKx7ygcYoanRIMRkkxJZhjGX4csSo+WEsIGwHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHpL5Ov8eL0BCU2THE6PFF3dtC0en3oLjo5JjpA/vxdc45ljljug0ktLKza3KEXNRC/ewxKMCazNpD5XjCsoVzzcy7VjagE0msV8FG+S4aGu9yYlLQCgrz8y+paD0cyfPPpgmF+YsRbVCvRqizQLQEuoSeR93BcT9lc9S/JdZ4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f5vuUU3P; arc=fail smtp.client-ip=40.107.200.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKN2hWpxcIZwf6JzN/Vy4c2xybhU8Upo4y7tmViqBJCuWOzmrQTgKe+STtUZDnPKjS6EAG6TxuriapRU5Bb5+WQgkuWVaFuHLCdnTejRt74xTUBvScB4rIoFOaZcwnHjfPzp4lFfKJOl7NBsaCkA+m5/kqgYzzGGfG+9513YYs5hjDxuh58QCCRBnQtmi2N8LWw5nUw9TZMWPZktGsETfyMUOLE6eTTw95spXPlIdAsnMLKdJ2uQAg51A9XSn85AVfMckBMNRlZOW/jduTWDteTPf95fPdM2QZFOB+JhKjRCcKt5ez0J6eJQnpre8ublIm8wo+8GgvazOa62zVWjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8G0Lh+80Bo+ppMbz8FKxW6JwLuo4DEjW/SfIxIOzU0=;
 b=TtHcK9kRk80B58/ZckaiO9n1e1xhZY6+PQbJOdsMOpGJaLpOSl8eD5pVGNmShvmW9FLFve8uX9yQ1LqfwbnF8dHug/7AmxWkKw/gZHO2/dWxMgWiTCtmNUShlQWbJJspvkLoWwwD88l8vcC82XXIepNHmVXfBdKvIfqritR9VDBJ/4OfrotEYltLm2n+L8G9JecQ8ldvUyhbjtZ5s+fLh4qrT8Kx+0MjdogMlc8KskELmHLqWHZ9JmiTv7iT/yBWgzRf1qTUHUGLlYY6JdfHCNx4lPuYngIDA6Xcw3aGYOPw3ie1Vl0oGI46b2CAeaXMRDCot8r06UIF+ea8gRcXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8G0Lh+80Bo+ppMbz8FKxW6JwLuo4DEjW/SfIxIOzU0=;
 b=f5vuUU3PNBfP5iIBS24KKh0xqItN1ORObAQTd27dEH3u6thLVdiyn3ajE6AModjNsCpmouXoMCJwq7ATD8/eyQzxTg5Vx85AaoBgArcQAJuwVBxJhahCHCNWOxSwXwHgJWYQ5RlXa7n8dy42yOHIQSsFNm2uIIgfFw0mHiBpSfY=
Received: from SN7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::26)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 09:18:29 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::7a) by SN7P222CA0012.outlook.office365.com
 (2603:10b6:806:124::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:15 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:13 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v18 09/20] cxl: Define a driver interface for HPA free space enumeration
Date: Thu, 18 Sep 2025 10:17:35 +0100
Message-ID: <20250918091746.2034285-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9970c4-cde7-4114-8d0c-08ddf69454f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rr4w23t5AOnnPUy+EZwQYdzCqfOkk/6FBxJoBgDSK78msOTJ5rjYhK2NeVTs?=
 =?us-ascii?Q?oP+PxJovR4OqsSLKHeLquFTCtsQfm4xrhreHB3AsBX7+Y/3hu72LKP3qgIS8?=
 =?us-ascii?Q?lHsIraH4VehayyTHstGOWbSUXcZ4spDptwb/PT3UoYNHy/nPErvVeLF0tK4j?=
 =?us-ascii?Q?zGJ+KhPIhuNVp8YMU8Nt2l49iq3NuMFkNqeS8Nda+uY3eKj3bStH4Zg6XI5I?=
 =?us-ascii?Q?oUiSvlNSyWEkaKNDrLhWhShKyc+14gZTFkeXi9RYaJssRBmkp3s3cJUHywZj?=
 =?us-ascii?Q?8VduadLcE5DQvgN373erD1e/7Ppeaivk19r7vuna9yCNuEpL2NmwLDem+2hF?=
 =?us-ascii?Q?fsm4s5T40NidgXszAYuklsI1cdAz3cLpHKJUbKIaD+Fit7OnmBhwHzTD9VKC?=
 =?us-ascii?Q?F0UjexffdJnJdY//g+JvGQ3ZXS8vxRgVz/PY0BlxoG8snpQc6vvvKXXwFjVR?=
 =?us-ascii?Q?CB+p2RHDxIfSy90SKd+y0mgRxODLzzC2HEgelxFCuPcIMKhSK624cDE7TvuK?=
 =?us-ascii?Q?P5OcKS71z2/iZnKgiaOgE9F/s5XDHpYIyWn91lXSgi6Gzr/51diURN/P3MfU?=
 =?us-ascii?Q?j6hmmBSHupdgcPv8K7kx4KRFkJ9WzLY0HbADT4dRgRVUn+lrXmJ8t4l62oCj?=
 =?us-ascii?Q?IXcKQL8dQ+wIpY7ji37BDIDE2KphUBgSvCTlrfiJ/FrPItq/mK+9APFGwd9z?=
 =?us-ascii?Q?YQRL/5Q7ROaDkiExLkL0X/2jUtYlS0crXTZUr4OWljNN7bkj3mELzSWzbBSP?=
 =?us-ascii?Q?EImfiJlcY9pDFrwFPzgTzCQkQtSqGqqabkN+RGvt1r0wD5ZelTNa3vUf0HtV?=
 =?us-ascii?Q?c8Kfp4XwgYszDzqtgtBPnYsQZFJwXMQ3VwGELQl5y2Vz/eFyPIfJpxy37KJE?=
 =?us-ascii?Q?mQ9l0I7HEZTlKxTWUbz6R50aSDnTD0vggLBXaYH1mSOPeC5tCzwKq82cg2nS?=
 =?us-ascii?Q?PPekNJPFSuewhB7Hh1M8axuuqggxlH5YtUWpgARgV/vVJ+uaVibpbt51oeH1?=
 =?us-ascii?Q?iwkgS6CyZ+6O8e+RiglRYokRyymnV/VAMnDdSVZGubdl4HaG2eSkqLpkuf8C?=
 =?us-ascii?Q?/KGurzylVecrvViWHsTr/iuKEu01cIy33OMatwdihnJEHbbtJZg/EqnlX7RE?=
 =?us-ascii?Q?JMVb/8rVSjht4H70DYm7t6igMBdDrBrnV+3GGdaSyL0PxyQhSFjoCDWVjyMx?=
 =?us-ascii?Q?naIbMhVGpqNx4+S118EJH8nnmSVPJV1I2shvL6yAZ1TaT4Wg0PEC7+bon8v1?=
 =?us-ascii?Q?n1oHLXTB1tyRXtDOCRsp9pBvx/HP6lY+WBLdTLQX7zq9yChrO7LRXEkJjfc9?=
 =?us-ascii?Q?vVfoWJeBUq6ofME2ezAp4BpoXkTjiyke4b05HBl4+LsSyeF2poV0F0K7Ug9u?=
 =?us-ascii?Q?JOuPIBXV7HnPncNsqRIfuTDO5eA4N5uwpngDY87vIm3zLpSUvlGsEgQWZNq8?=
 =?us-ascii?Q?8ii9Kj7PwZDaFvA0FZdHFKozMFE6Qmg4mxoWrpHGieVJRbO1vR7aEKcbMxDa?=
 =?us-ascii?Q?9lrgijv75OTT9vk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:29.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9970c4-cde7-4114-8d0c-08ddf69454f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737

From: Alejandro Lucero <alucerop@amd.com>

CXL region creation involves allocating capacity from Device Physical Address
(DPA) and assigning it to decode a given Host Physical Address (HPA). Before
determining how much DPA to allocate the amount of available HPA must be
determined. Also, not all HPA is created equal, some HPA targets RAM, some
targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
and some is HDM-H (host-only).

In order to support Type2 CXL devices, wrap all of those concerns into
an API that retrieves a root decoder (platform CXL window) that fits the
specified constraints and the capacity available for a new region.

Add a complementary function for releasing the reference to such root
decoder.

Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 166 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   6 ++
 3 files changed, 175 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e9bf42d91689..78f13873397a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -703,6 +703,172 @@ static int free_hpa(struct cxl_region *cxlr)
 	return 0;
 }
 
+struct cxlrd_max_context {
+	struct device * const *host_bridges;
+	int interleave_ways;
+	unsigned long flags;
+	resource_size_t max_hpa;
+	struct cxl_root_decoder *cxlrd;
+};
+
+static int find_max_hpa(struct device *dev, void *data)
+{
+	struct cxlrd_max_context *ctx = data;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
+	struct resource *res, *prev;
+	struct cxl_decoder *cxld;
+	resource_size_t max;
+	int found = 0;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxlsd = &cxlrd->cxlsd;
+	cxld = &cxlsd->cxld;
+
+	if ((cxld->flags & ctx->flags) != ctx->flags) {
+		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
+			cxld->flags, ctx->flags);
+		return 0;
+	}
+
+	for (int i = 0; i < ctx->interleave_ways; i++) {
+		for (int j = 0; j < ctx->interleave_ways; j++) {
+			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
+				found++;
+				break;
+			}
+		}
+	}
+
+	if (found != ctx->interleave_ways) {
+		dev_dbg(dev,
+			"Not enough host bridges. Found %d for %d interleave ways requested\n",
+			found, ctx->interleave_ways);
+		return 0;
+	}
+
+	/*
+	 * Walk the root decoder resource range relying on cxl_rwsem.region to
+	 * preclude sibling arrival/departure and find the largest free space
+	 * gap.
+	 */
+	lockdep_assert_held_read(&cxl_rwsem.region);
+	res = cxlrd->res->child;
+
+	/* With no resource child the whole parent resource is available */
+	if (!res)
+		max = resource_size(cxlrd->res);
+	else
+		max = 0;
+
+	for (prev = NULL; res; prev = res, res = res->sibling) {
+		struct resource *next = res->sibling;
+		resource_size_t free = 0;
+
+		/*
+		 * Sanity check for preventing arithmetic problems below as a
+		 * resource with size 0 could imply using the end field below
+		 * when set to unsigned zero - 1 or all f in hex.
+		 */
+		if (prev && !resource_size(prev))
+			continue;
+
+		if (!prev && res->start > cxlrd->res->start) {
+			free = res->start - cxlrd->res->start;
+			max = max(free, max);
+		}
+		if (prev && res->start > prev->end + 1) {
+			free = res->start - prev->end + 1;
+			max = max(free, max);
+		}
+		if (next && res->end + 1 < next->start) {
+			free = next->start - res->end + 1;
+			max = max(free, max);
+		}
+		if (!next && res->end + 1 < cxlrd->res->end + 1) {
+			free = cxlrd->res->end + 1 - res->end + 1;
+			max = max(free, max);
+		}
+	}
+
+	dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
+	if (max > ctx->max_hpa) {
+		if (ctx->cxlrd)
+			put_device(cxlrd_dev(ctx->cxlrd));
+		get_device(cxlrd_dev(cxlrd));
+		ctx->cxlrd = cxlrd;
+		ctx->max_hpa = max;
+	}
+	return 0;
+}
+
+/**
+ * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
+ * @endpoint: the endpoint requiring the HPA
+ * @interleave_ways: number of entries in @host_bridges
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
+ * @max_avail_contig: output parameter of max contiguous bytes available in the
+ *		      returned decoder
+ *
+ * Returns a pointer to a struct cxl_root_decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
+ * in (@max_avail_contig))' is a point in time snapshot. If by the time the
+ * caller goes to use this root decoder's capacity the capacity is reduced then
+ * caller needs to loop and retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with cxl_put_root_decoder(cxlrd).
+ */
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max_avail_contig)
+{
+	struct cxl_root *root __free(put_cxl_root) = NULL;
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxlrd_max_context ctx = {
+		.host_bridges = &endpoint->host_bridge,
+		.flags = flags,
+	};
+	struct cxl_port *root_port;
+
+	if (!endpoint) {
+		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	root  = find_cxl_root(endpoint);
+	if (!root) {
+		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	root_port = &root->port;
+	scoped_guard(rwsem_read, &cxl_rwsem.region)
+		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
+
+	if (!ctx.cxlrd)
+		return ERR_PTR(-ENOMEM);
+
+	*max_avail_contig = ctx.max_hpa;
+	return ctx.cxlrd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
+
+/*
+ * TODO: those references released here should avoid the decoder to be
+ * unregistered.
+ */
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
+{
+	put_device(cxlrd_dev(cxlrd));
+}
+EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 793d4dfe51a2..076640e91ee0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -664,6 +664,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
+
+#define cxlrd_dev(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
+
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 64946e698f5f..7722d4190573 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -253,4 +253,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       const struct cxl_memdev_ops *ops);
 struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
 void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


