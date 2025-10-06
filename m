Return-Path: <netdev+bounces-227936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B21BBD9A0
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B87724EB5DF
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AB22C355;
	Mon,  6 Oct 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hWWtz3Hx"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDA1FF7D7;
	Mon,  6 Oct 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745072; cv=fail; b=VQmrUZ5kJ5Gfzc88AEMed1zCnnBgvDR56MSS7RpgMKeS2EKo0diEVz8YOTKZOzaujLuESXrMrXFdf5XSXd+nr3/9O0tXoUqtmn5T1udOqZ8LUemppG6IBQRXum0BCVauxXnfP51Nr/uDtXO5zgayXE+Yfi2KCsZYp1mFP4rdlzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745072; c=relaxed/simple;
	bh=lA4VjrNp4JkKPaxn+xyGXDzE+rbXq285H2yYBjFeQis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjb+uVnT8IFJCgignQpdZMZ8KIWfxEvXelB0cBMEt0bHWMk4Zq1SHbF0id04AWpme7kv7SuoivDwO4Bvh4RQ0V+MYEOyuNlOreFpkaitBAF7gEyJmiyxeDTP3dBR8eBAmmtNJjR3G5wSIMqZVRlYlnsXujJFZpmfugh8jk39N4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hWWtz3Hx; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlU2057ZDG8WFEkZF/DzYt2XiCKm/c3k+ewt0NvmcohthT4MYjXfG9AkGiVlvUPJUL03RVeB3opQTT/Wcnj6oK5XCoqjCUhKgTY7w9XT8V/P6RVI5j6pMbviFEHNPvg9PH6XWoF6a0SJmdgSo68JxXQWjtEJSRIuVl9efGeQ072WrpR+K+ciqLmjrKRbVmdKlLIoEhWjs+xtukYTg7CV7F5/n5+P1h83vrPJONPoK+w0ssIZ4D0IOtqAeT7SS1eKIqCwJtgYLwp0vzASrioR+rToq1/fJobATsYLCKOIOarUISfVK+n0s3jPLRFRI+4AiJk+9ZVZzXAmFZyBda0+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvwzGHOmKShAylKEiG+wmTCD2/ywHjAaecxV7bLGnGY=;
 b=tCn8WLCQlXeOsTKSn+QGv7rAXMHT/l3AJgKlvnE1r8w1QFutfOliGmJLBMbe3ZmOW181IgLj+WeyAk0SlJmun851lgObKnMsrNp/Qu0cpIBVKnN8hGFerH68t/sIwumjue6jerz+1SMXb/YU+EmdmX0vOkkBb1D8lEq3c4m45hVYKCcBpHcDP7ay+XehPSxg3E0ZuKxECleQonKSNLuU0FYy0MDqiciPFrcBeEHUt34kD+5g2SZy+NQ3QeYUVHujTEQxavbVX8ZSMI5l4dKOgoN1S1p0r+tKWjJpS2yuhpG+xAfzxvHVdvhNe2ZlPtN9wuc/+IhcKvVipEqy2LFKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvwzGHOmKShAylKEiG+wmTCD2/ywHjAaecxV7bLGnGY=;
 b=hWWtz3HxR3aUYAVFhPi51FXGQys99/ZUP9cifJxPsp9Ynhs67oNUqiOdEr8+wjDC1ZE6fLY+KOBxkA2Fl5uTjQd9NNAY9rSEaQZkjikBhvVx0N4tMATqrFopb1CvqMQ7MhK2k2pO7CnwbChEBw7vBmDYTIBmwfJ3Su9zWKYaZGU=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:04:20 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::d) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Mon,
 6 Oct 2025 10:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:04:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:24 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:23 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v19 11/22] cxl: Define a driver interface for HPA free space enumeration
Date: Mon, 6 Oct 2025 11:01:19 +0100
Message-ID: <20251006100130.2623388-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 638d6a28-25cb-45e7-a12e-08de04bfb7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQJd/UjzX2sjtPQfiEGrWS0nV2rAuP7+OFEVoJhlamA1EuBh3vr6JhFMgUYM?=
 =?us-ascii?Q?/UrdNlwQJfn6HbN9X/Kre2ybX8TWEJthJ8GWaKlLuqpXZdq37pfd0CKcokgi?=
 =?us-ascii?Q?/7r0aCPYmhs8W/ksyb0gov2gAAMGDJTqNPDE+DWxqmZL/9xOb/GdHEB7inKR?=
 =?us-ascii?Q?jAVIv626UlabFtKQ6GRrWeq8Q3AZ7AnI9XCbi1gHpwhEbs0+3PE5OdzTQrj9?=
 =?us-ascii?Q?OtZwXaOa+GOLB3f+VQ/epA5CefPJacEYOwpVFB1mfTn9G8XrDIDWI6cBQYSD?=
 =?us-ascii?Q?qGqSlVanxCcdAY3ktYUiSA3GlBdSbCrruxwka7ZhmciWIUKYGb6eIRnxwo5l?=
 =?us-ascii?Q?eN/jkIUa8OBR/v5xTHPtvs5prC8N0jHdiI30DTFUlRGusGXzCGOEy+vjhJyl?=
 =?us-ascii?Q?l2U3ppGnL7+EnBDwBVh3Qlk1KqTlKLq8ixYrYK1Q5cfaUt+NnY5k5ApXcDfL?=
 =?us-ascii?Q?A/n9UNyTS0Ft+WLlgglYjkM2/Wr4/7fCzZB3COypqlHDeQr7KmlWw0LLCe+0?=
 =?us-ascii?Q?7Ihc4dRGfb1EKOpuu8tWSz9occUKhUGsBJ58R0VCA01hHll3tZf10E6wbmd8?=
 =?us-ascii?Q?HFa5NH5+A63gITY9rsq4y1yLLiWqDOUliNnqbjycqx4F8/lYWt8A8hF6KhtA?=
 =?us-ascii?Q?N5+u7DxqpcjejqyBwip4h5riDqkoxYYKFny7vXXKHzP8XVro1dL+Hlz/5w0l?=
 =?us-ascii?Q?sOootAe7bCQxZpea5LbRqTKAR0nUIHReJMsaUtF/MvfRLzlxhOZfOPqFKOH1?=
 =?us-ascii?Q?agx4kQKiLl/4z4vaN8eLndrRNhQC27atkwUrthu9zQdF55HqyNiFTnu3AAFh?=
 =?us-ascii?Q?AytwY3ECtzEXPbn9fBeL/j9+7GoEG1iL/P/9e4Ux8U/hm1lUc9d0uBJ3WCUN?=
 =?us-ascii?Q?/RaU463tnHKRXsxst3UgeR/kaC9UE/iSWd7jZllCOV3QhBugJa7D20+qH72v?=
 =?us-ascii?Q?vsLx5mWRrQ3R/XqzFkmlLTKtqkvu2vmWXLCxkqjSBfkkysYxNLv8VZNbmGQs?=
 =?us-ascii?Q?J29xDw4LFsNaamKcrweyMdqs8nsQQ1hShzyzdXteFWhtqc75dJkfLsKn4zq5?=
 =?us-ascii?Q?AU4aYmuSK+lguFR2waM7cVWaW9L0cXU7LEbBR7op+wf+W13HixTrrSHKzQ8+?=
 =?us-ascii?Q?rL+9gm9FZ7uozcfRcoMGFzRxU8vfRATRYsq1XIq7oO3TQQ6SPwwsOThtqXrz?=
 =?us-ascii?Q?GVAibUjgQzOBvCVXsRLY2e5hv6g0F+DvfXccZ0Ewn6CzYF/Yib75IqSRPT8v?=
 =?us-ascii?Q?g2iLn9/M/AifhxURnuTURRg3PGP8nMdEs3uoretnfT2rXYAI6/zKqvL2JiGL?=
 =?us-ascii?Q?fy9Rhn01QtySQFMFUScj0fJNALagJqyr0lBu83OlJ8XWCAlEjAVl46jfWyrp?=
 =?us-ascii?Q?FWSrUOPXL3esuEX1JhgjS1F9N+vmUPrFbIiCSTKiMIkOXuFtjaS6ROukzrzD?=
 =?us-ascii?Q?pTTJTmARP8mTaUEpHHW1Yuy9/aZefbwQJIctBvIjEF9UbPksYR+TaczCznH6?=
 =?us-ascii?Q?qyfBVMAdjTQfYHon1fjr9NwQbPUUjMrPNCCCMkoEK2LKcVzKJUzCtUAWYd1h?=
 =?us-ascii?Q?hc5ThOaPSlVrwItDbFg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:04:20.2919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638d6a28-25cb-45e7-a12e-08de04bfb7ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

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
 drivers/cxl/core/region.c | 162 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   6 ++
 3 files changed, 171 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e9bf42d91689..c5b66204ecde 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -703,6 +703,168 @@ static int free_hpa(struct cxl_region *cxlr)
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
+ * @cxlmd: the mem device requiring the HPA
+ * @interleave_ways: number of entries in @host_bridges
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
+ * @max_avail_contig: output parameter of max contiguous bytes available in the
+ *		      returned decoder
+ *
+ * Returns a pointer to a struct cxl_root_decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
+ * in (@max_avail_contig))' is a point in time snapshot. If by the time the
+ * caller goes to use this decoder and its capacity is reduced then caller needs
+ * to loop and retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with cxl_put_root_decoder(cxlrd).
+ */
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max_avail_contig)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxlrd_max_context ctx = {
+		.flags = flags,
+	};
+	struct cxl_port *root_port;
+
+	if (!endpoint) {
+		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	ctx.host_bridges = &endpoint->host_bridge;
+
+	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
+	if (!root) {
+		dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
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
index 043fc31c764e..2ec514c77021 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -250,4 +250,10 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_ops *ops);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


