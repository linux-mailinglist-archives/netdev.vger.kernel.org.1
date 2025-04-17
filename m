Return-Path: <netdev+bounces-183926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2148FA92CAC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54810924A56
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8439421CC7B;
	Thu, 17 Apr 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AF2TbBBD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BEC210F4A;
	Thu, 17 Apr 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925400; cv=fail; b=VGXffyHAzxWs1fpPeHHcAtwUQ9xPwSDtgLSuJitU6uPj6BNwmF6eYUDjUs4m6bpIwW0DaWARle9Cu5JZm+FW4Bs/XSH1yCJwij8IimfYM4d5F5IXIpvVDSwmeE37hK3ZEfc2U/VQ9FRffOd6J9CJLSiQ1ahqOOzea0H7YM3PDO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925400; c=relaxed/simple;
	bh=uXB9AUzYpp4xM+gbhGAQcQOSng7KlsTBouk39mtmB8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP8ZK8G7hdI/vvsM9xsp3SL55vyfEayO7Rl4N21V6oUcUYIY6H//dr92l217QxXjIL7PvLt5ukPVP5P8mOlnM5wMGBE1HWNNNlOHML5b7R+SAJDqEX5W+Ao0yDIyXGLumfViiZarxCU1Lo+cTR+X9E7zaDuybS9XNSc3zDawaeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AF2TbBBD; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujMo1VYRklrQy0VZdVeX32u6k7gMXWPyKslHBfgLIsGgMlt5I1gSWTH4UMaKoeMNmHmOmrRWd2MwkgQwXrbt82yNWEf4z+nzo8f8QQvzJuegVKEC6LySv047ntvgMVo9ouLp+qV//0Kgxhnq179BUU7LDVz6SuZvXCMywT4qE2ndUV9r097i16HNNGwE0iN4zPZwzBdiK5w17MIRTfAg0bMExdeI5g3yOr9szdQzuoHFwxThCuhHlplBnaUOIZ+NHGfGseuzMkR4zdCGk266zihLD+emkaQjNtvQ465EiPWRdASrdIwdDhDBT/iSwd1c4brwFf9tRAFOI+SEi1NvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnkxDGZ02qA9qzuun1LQgQisCgB61f3bJpBTF/oEFJk=;
 b=fFnfaJZUMvfh8C96/BsxrEVHzV/xTtoGI4TWKywpiPj/IUM1iXrcK7fqwipB3YO6RJqBpNgy7WcXj0sLkEy5v8H8h/oZ5ls+zRFSiTtC2UdisL55gGQ7Q6xjteRAHKycWXmQkyVZzO3skDSPiyyWxEZDOr7ag0SFH2pvJau37R2KYmXsyaGADdxbqclzMsvZY4jEwdG0pH2ds3e7rMKVbxsp/K9fUAd1Wl4seb49nmG8Ickavtyq51Bf6F9ch65rkBfQz5JSo6IZ2Ou/svgCpCzgAj3isPOShvXfAqv5nvZRuz8nPkv/JjEIvGWhDB2x8JrhvVZYFplaaZtAy1Nx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnkxDGZ02qA9qzuun1LQgQisCgB61f3bJpBTF/oEFJk=;
 b=AF2TbBBDo3AnBU5euV9Dr4HTyWFHgHA3arZ5B5WDfg/ZxuBHrQIOy/AmOozuy4ukWNtvBHkgKxJu6cBBXxq7l0SFDA4Px8Scu+ZM42zNmnIhdjDGx1TNMusK5zbwiOhdEpCHkhCBv0u3JzcoLm9MY58RJPNiQ6erriETBLnT/l8=
Received: from PH7P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::32)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 21:29:53 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::9e) by PH7P223CA0020.outlook.office365.com
 (2603:10b6:510:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Thu,
 17 Apr 2025 21:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:51 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:50 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 11/22] cxl: define a driver interface for HPA free space enumeration
Date: Thu, 17 Apr 2025 22:29:14 +0100
Message-ID: <20250417212926.1343268-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 337f1cca-93b0-448c-0d49-08dd7df6fdbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VfRBoUy33C9ctSPRWrFg5/H0WL5Mu1nsyDDgoj6kIC+VMsgxFoFtnz1dR4Tn?=
 =?us-ascii?Q?EFmr8H2DfNvpFrhzAM1yl7pxtiHnAvc3/oydN6jLcegE8u8DDFgvxc6cp//M?=
 =?us-ascii?Q?kjP6y2q+bwgPkV6jI61UNCEoWG2iLn2Ro4NfJL69UbkdAApHOTCdPRFI93xE?=
 =?us-ascii?Q?4EFP27MRguiMowTicIBGWq15Bo7a4xqjcE2b7MxK7QFB6yV9rdlCpXxv6lk3?=
 =?us-ascii?Q?YGmVcKyIb4VpAzu/DTOhds+Z5K+rpIEw6cHRoxHroU+vqWBQK8cRlSNz1rgg?=
 =?us-ascii?Q?9ZfQaQ89N6RTeLfsrxAJNm6Q+tONRloUjZpnAwyXDTy3K7CCiUvLScF0cbke?=
 =?us-ascii?Q?Ci6Ad5UlzH7q5gIW66owWwtzXCdcENEEJOuhacskjmblDNqMCQjgycvkvhaI?=
 =?us-ascii?Q?kUC06KLgCJJOnMK1FIIPwWtxRjUCxKN6zzyETYJTW3qwvUMlhs+nzwhFYIzS?=
 =?us-ascii?Q?3aTRpBC0zIb6rPi7CkXLp0NMFWsrMiUvYpmmmgsqRwctxUom54NmSKdsFziu?=
 =?us-ascii?Q?prVuQEBqcbvkYzXrLBtNEkelkuY3zk8fblr6HE1rb97oPjOF9oAdR/mv1dFn?=
 =?us-ascii?Q?TKZssI86LxzYE4Okp1bmF3VVgoRnva8ARjm6haziAJ6TxPVwFCFWqdq9VmeY?=
 =?us-ascii?Q?9qIezDvl+J/X4NfImVNab/t7IDEym84U3bpyOYXRP5LrzLbeqyb3cpXBSgVV?=
 =?us-ascii?Q?cK3ckQGUma3bUL2XL0MeYtHWfsm9kuliqOFyQ1L4QBPm8Kxs8lauES9Py4d0?=
 =?us-ascii?Q?UPLggGoPnoiiYm2/ozlU535Di1e19I/Fr8Q+w9aws7A+1ZNRbtTxdilAsIfk?=
 =?us-ascii?Q?FQR5QjQsry2NERLLWkUCUkcDznfweqvoSX0wcTHc5lPHhk1y9nm8/86SKyk+?=
 =?us-ascii?Q?PqeOKg0A5Xs5bufBVDiXy/LLviJidqDqvH/FkccQIDOk6gE0bGSENug05ZW8?=
 =?us-ascii?Q?C7I3myaXzENhRfkgAuGNNDi/uGJeCT7XNBNKczAHUNeSdJHr9NT9I4rsPaJv?=
 =?us-ascii?Q?RYvrmoRGcW/IeuY1nGdP9IWMCOHaH4Xcsr/oX/WuxnzRd++KHSU6owWpOZQx?=
 =?us-ascii?Q?50lxowVs2EdbddnTz+mi8JklRkxgFEb3ytBm4yD0InTwg7Zz3g9ZW0+DQkX4?=
 =?us-ascii?Q?D6lIIjviGqAIvu0LuYjpPIOnWCgJhQuEfWTOYVL9s1Vab+87beaeLOypVQMr?=
 =?us-ascii?Q?QImEdSH+09T13g2wjcwVcz3FkBuYHKXE6Zo72/ax8KuURE6Ffcrwt7ghh0/U?=
 =?us-ascii?Q?EJ0eVOWTbBvJlZYI3qoujFR3pBBfFfXiQwFLTPnhHMwXQ1KI/k4rPC81fuOJ?=
 =?us-ascii?Q?wSHecVFtYbVcMHZKj+o3/dVJfpkeJjFLdnbS6xGsOAGufC2JWsG03FhMXJcd?=
 =?us-ascii?Q?+/LDokv9QhbMkUuvwW9HRDOqdNg3GHlNJahQdG4u6ckQkSwU8oGC2vdzIcOD?=
 =?us-ascii?Q?yZUgkKeyn2rCxPAP3dJI9MUSF8IoY3WnjwaXzO7BHGiIEjG3QjazrCKBSysP?=
 =?us-ascii?Q?+mZwxIlpe7tkla52cJ+7ISAhY8Fjujenw/Crt+djJE7neneTsaWPoJGWfg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:52.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 337f1cca-93b0-448c-0d49-08dd7df6fdbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785

From: Alejandro Lucero <alucerop@amd.com>

CXL region creation involves allocating capacity from device DPA
(device-physical-address space) and assigning it to decode a given HPA
(host-physical-address space). Before determining how much DPA to
allocate the amount of available HPA must be determined. Also, not all
HPA is created equal, some specifically targets RAM, some target PMEM,
some is prepared for device-memory flows like HDM-D and HDM-DB, and some
is host-only (HDM-H).

Wrap all of those concerns into an API that retrieves a root decoder
(platform CXL window) that fits the specified constraints and the
capacity available for a new region.

Add a complementary function for releasing the reference to such root
decoder.

Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |  11 +++
 3 files changed, 178 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 80caaf14d08a..0a9eab4f8e2e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -695,6 +695,170 @@ static int free_hpa(struct cxl_region *cxlr)
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
+	/*
+	 * None flags are declared as bitmaps but for the sake of better code
+	 * used here as such, restricting the bitmap size to those bits used by
+	 * any Type2 device driver requester.
+	 */
+	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
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
+		dev_dbg(dev, "Not enough host bridges found(%d) for interleave ways requested (%d)\n",
+			found, ctx->interleave_ways);
+		return 0;
+	}
+
+	/*
+	 * Walk the root decoder resource range relying on cxl_region_rwsem to
+	 * preclude sibling arrival/departure and find the largest free space
+	 * gap.
+	 */
+	lockdep_assert_held_read(&cxl_region_rwsem);
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
+	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
+	if (max > ctx->max_hpa) {
+		if (ctx->cxlrd)
+			put_device(CXLRD_DEV(ctx->cxlrd));
+		get_device(CXLRD_DEV(cxlrd));
+		ctx->cxlrd = cxlrd;
+		ctx->max_hpa = max;
+	}
+	return 0;
+}
+
+/**
+ * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
+ * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
+ *	    decoder
+ * @interleave_ways: number of entries in @host_bridges
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
+ * @max_avail_contig: output parameter of max contiguous bytes available in the
+ *		      returned decoder
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
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxlrd_max_context ctx = {
+		.host_bridges = &endpoint->host_bridge,
+		.flags = flags,
+	};
+	struct cxl_port *root_port;
+	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
+
+	if (!is_cxl_endpoint(endpoint)) {
+		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!root) {
+		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	root_port = &root->port;
+	scoped_guard(rwsem_read, &cxl_region_rwsem)
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
+	put_device(CXLRD_DEV(cxlrd));
+}
+EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4523864eebd2..c35620c24c8f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -672,6 +672,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
+
+#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
+
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 9c0f097ca6be..e9ae7eff2393 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,11 @@ enum cxl_devtype {
 
 struct device;
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+#define CXL_DECODER_F_MAX 3
+
 /*
  * Capabilities as defined for:
  *
@@ -250,4 +255,10 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlmds);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


