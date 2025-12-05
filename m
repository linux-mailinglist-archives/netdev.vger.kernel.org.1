Return-Path: <netdev+bounces-243794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706CCA7F17
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE58A30438BE
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7415632FA3D;
	Fri,  5 Dec 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MPaMDWOd"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C43329390;
	Fri,  5 Dec 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935611; cv=fail; b=aRsM2LcuraM0N5L51JBEEqBlbPLt3RO8uJpLJqrsctQGo/BZbA1FBgyWGJjMGJqe007cOQZfqish0Dk7e2fRQtbOzaYz0F5YRTYuaPxrLnx1OmSP7W4ffMOjQ9mGf9e/21Eatw0vI9pg3MyY60jU865mx7oq5jB3DaHKnqez0Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935611; c=relaxed/simple;
	bh=Ll9HOofLPpJVhSzMn//GEMhNY0sKk0iZEYocjk0nVVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO268CeuiS0NpiJ8IR0ehEsaFJ92iTvIpl7fnQAsri5raNNUHfQj1ZOk/WdIHTIyvlZa6HWlCVqtT4KVnyAgz3/verIT03MukZd1pvd6qznlQikshm7QocMXBhyzVNIqpGE7McX3m5VIYQfeua3462qiAusjyjR6NUl2U1J6i4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MPaMDWOd; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtxnFlzWYkwKpdcKAQ3Jd5I1fN57PjLzdt607v3N68Y81QMPyViuIqqH3HeHs9iDJ/mGlN/tRmnrvwh9DbzbCGKEhiKCBKo3tY9uIf2nMZ2KsWw6siIwNc7WlXaFK+Cmu+lTNc3cD2UCxSWJIMw/ub/PyiT3TJ/ARDs6+eMfQpkWwIGZraaCVy3frlQ9lNAtILhudl5ZhPodC8Q+rcIbM9qTV3OHNwvx/HK/0BwR4rBmfz9hBXzBm6evnRvz6IuaLiF3KXnpfEQ2GxgvAj+Npx3xgxKqzeiEcVgDKGZHJjp52peh2VQgl5UISBUwxAp8crdZWnbbxZNC7gZOsq080g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlYAEKITvkG+6+9HDBwrpsbJQZy72tfsLjikZMgv8wM=;
 b=uw+fSrRQ4ZpRjwYnHPwV/2T2Mn4B82WGYtck42dKYnpTVSKjPe1gMjbBn89xVSfkg4SE3fJ9hL/QbzSRb45YSwK+2aYeAtbhG+0jTf5DHDjpQn+bNZJesDyj+JcaKy9v4mt6kTVtCluOm8BILSvtJvlSiQThJUBpAQom44asN60F+qqLFgJ790LZ7ftUR1Hk6IsvpiSfh73h/ZFQmFkV/Zw7kY75M42cPd67ynnQqBsPWP0/vE4cSmdh59hdoryJVcLR+WQ+/95tnrOyRo8qDvOgY1Hm8+Vtpsm9RCToFxkFz2mXaVxXK6etwFIGWtxflnE7yke2nCE9DVg23Ckv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlYAEKITvkG+6+9HDBwrpsbJQZy72tfsLjikZMgv8wM=;
 b=MPaMDWOdSGVty3EmQGxsebRqAzk79kLdkNGjGJK61b+sOWb7eyS1pDErPL8OIxsJzaKci04Tso4oKCJ64yAdWfAEJHxu1K2sDu3alRQRojZ3gfoFqD4jNe2gfq5Z06YOffvfpa/vpU/Vl3VSxVz+bBwX66uSj/txBZGMTEBY6BQ=
Received: from SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::12)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:20 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::a2) by SA1P222CA0169.outlook.office365.com
 (2603:10b6:806:3c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:19 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:18 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v22 15/25] cxl: Define a driver interface for HPA free space enumeration
Date: Fri, 5 Dec 2025 11:52:38 +0000
Message-ID: <20251205115248.772945-16-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: a20e5d1c-9f0e-47a0-d2b4-08de33f4e2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLpNnotqMFItvN/OLYXaqKldHWwetqbNsEUWqyUMcUUXiixV8B7qHWeGgleN?=
 =?us-ascii?Q?uqyU3A2HRXkT29vgXLDTbYi2OT+PCor3epgFDNLAU/KRlLl4s+RdLr6TAAQS?=
 =?us-ascii?Q?Q1EM+Qdb0igPaFDLMxU+NOMOtIe1/y0Mw4zcYEbUoF3vEiHTsVUx0JkENHvJ?=
 =?us-ascii?Q?0eKFqxsG70TOzGjvcx88gKfR37qsVqR30dJxMt6jd/gAi8GwzPMv1/RhkHfC?=
 =?us-ascii?Q?P6wjHjSqHTIVNrO5pg51p9biKO3OQgZAPGBB38VX6Ia6nkPEtNLWEzb1oszO?=
 =?us-ascii?Q?lUK0be8z8yl05Ar7GJQlr+5NxgU+8SLi4hhplr42P6aSzq/ZIuKUF+0X7Qyw?=
 =?us-ascii?Q?IeC818fL8g96rrLmsUNkbFPdLLpjAsxK25xeqoOg0YzDqtNILFWudhP+q+3n?=
 =?us-ascii?Q?z42vlPPYjkEuY27UVUWdxJtzgDqmQgP8R375LU08FJC476l9sHicy3WcdoQ0?=
 =?us-ascii?Q?BvagObezXVfRwinehw/cM2VlQBQ7EU9ne8Cuc6jb7tVcCdFOs2ZxoQU5P6y/?=
 =?us-ascii?Q?C+3Nb9Enl68jeRGd+b+1psRfEbNuXscMuVAzv5ugdFnJZDE+gWoloZiPoGEW?=
 =?us-ascii?Q?Hf8Hwbr845w4n0thzGKpBnylqDQeD2YleVALYqdwbqyqSNEyIE4//wWKqc55?=
 =?us-ascii?Q?4TVAeV22F5oUB8UH6DqX64IIJuwuyU0LZ3u6ZINNzHzDyCSV9QFW+KZtXJE4?=
 =?us-ascii?Q?fjGV4+pIswHqBRGhVHNs7QkxGYMyqXQ+6VGhTPk2sDuioxMZvTNdXr0dd8be?=
 =?us-ascii?Q?w6mSFtF6rBpCr43+xQYz42Yw+uCrTYaHdiA5BSB962feMkLtcokh5V1CMTkc?=
 =?us-ascii?Q?L+FW2vMr3tsoleRwd+D/4zQJB66Uzp7HZ9VQbpgOXeY7dqoi0A2Prted/6JC?=
 =?us-ascii?Q?jcxSuEbaSN7l61DVIk2EfTXnegqfvYl4IHRzYij05oTtBcx3mOCCucsi1AjA?=
 =?us-ascii?Q?f2qqFAe8VEKCK5V0Zrr8KlQAMmSb1GYlFvEoKSbd1Y27e0OberybFAaQTOim?=
 =?us-ascii?Q?tGuv55FcaMX4fVJwz1if/jimT99pffZJHdSzRJO284liAGRvAR95zXuSjXZW?=
 =?us-ascii?Q?TdmXRXc6mRfNo79aEtldAtdtiPW2tdS5AESAP83o4mMFoSDkz3OI75PMVrHl?=
 =?us-ascii?Q?84V6aI9RV1USLDeCog+8IkaKWrXS0wAnxgNfEkk0rBW1y/MRJRnQnWitEHPU?=
 =?us-ascii?Q?f8t0COqKIklyf87Nr1HrqEW5aKpOfmQm8LuA7yv2BydOeWlq8EBdmpOSUSIy?=
 =?us-ascii?Q?Yoq1t28Tuogi54SE8NPD/vpA//RnGA05Oa2zeSSRGPpDWXDHBvqXp+vLnkst?=
 =?us-ascii?Q?grNmhsBbk+i2jDqDZ9myet6tiCHrwul0vhmeSV+vYa4jgLEAO0GCC+aApe5M?=
 =?us-ascii?Q?u0f08/BHh+YDzrJ4AAVJo99Ig+L5gGYZ5XNA1klmEA/pPgn/D1zLqxDgL+i0?=
 =?us-ascii?Q?IBGcjOgXXznqYijMzFy9W9CIbjuIAykabb+hboisDy8lV8D6bSFkz6i/fGqd?=
 =?us-ascii?Q?UodS/vTIEHMTTV6FB1c13B2i0BypXvR3mVFYuAjx5NmBZuj0bW95oVAoy6oh?=
 =?us-ascii?Q?PYVG7yiPpLww1tNF8ZtKrFf2wKOXOsZivYu2+7Sr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:20.1291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20e5d1c-9f0e-47a0-d2b4-08de33f4e2b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903

From: Alejandro Lucero <alucerop@amd.com>

CXL region creation involves allocating capacity from Device Physical
Address (DPA) and assigning it to decode a given Host Physical Address
(HPA). Before determining how much DPA to allocate the amount of available
HPA must be determined. Also, not all HPA is created equal, some HPA
targets RAM, some targets PMEM, some is prepared for device-memory flows
like HDM-D and HDM-DB, and some is HDM-H (host-only).

In order to support Type2 CXL devices, wrap all of those concerns into
an API that retrieves a root decoder (platform CXL window) that fits the
specified constraints and the capacity available for a new region.

Add a complementary function for releasing the reference to such root
decoder.

Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 165 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   6 ++
 3 files changed, 174 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 104caa33b7bb..be2b78fd6ee9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -711,6 +711,171 @@ static int free_hpa(struct cxl_region *cxlr)
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
+	resource_size_t free = 0;
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
+
+		if (!prev && res->start == cxlrd->res->start &&
+		    res->end == cxlrd->res->end) {
+			max = resource_size(cxlrd->res);
+			break;
+		}
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
+	}
+
+	if (prev && prev->end + 1 < cxlrd->res->end + 1) {
+		free = cxlrd->res->end + 1 - prev->end + 1;
+		max = max(free, max);
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
+	struct cxlrd_max_context ctx = {
+		.flags = flags,
+		.interleave_ways = interleave_ways,
+	};
+	struct cxl_port *root_port;
+	struct cxl_port *endpoint;
+
+	endpoint = cxlmd->endpoint;
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
index d7ddca6f7115..78845e0e3e4f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -679,6 +679,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
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
index b8683c75dfde..f138bb4c2560 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -264,4 +264,10 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 		       struct cxl_endpoint_decoder *cxled, int pos,
 		       enum cxl_detach_mode mode);
 void unregister_region(void *_cxlr);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


