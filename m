Return-Path: <netdev+bounces-189821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE1AB3D2E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C8B19E44F4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772F2255F3E;
	Mon, 12 May 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FYAQ/Y1f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC62248F57;
	Mon, 12 May 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066286; cv=fail; b=KEAP47c7zPwtQznY7NQpo9by2QFu72Yhg1rIBmlvC0/x3lmShI/CBh5LtgDveWZvpb9MaIgcV3dGkU1CrihnSaQTNX7wawB3eqMFOgVcEO43BvOy2s9PbR/P2z/dO5vkm+Exl5syT3uPFLXItBlYR6LS+UE0U5hW4Hj3ZveQq3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066286; c=relaxed/simple;
	bh=2wSDK7bhT5q7HaZ6PrjeybIvnDlYOyE8EmpUbTftLNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CU037MOL+P2Iqn0YoO0kzr0awy1j5kaIXED8fULAnAeOKl6hjvaHeVMrLyd5LwszIs9C6fMJzusNeW0Yu4n/g1GplHvbqUX5EiFemT9HbAoxAAChMAs/ZalFrusxfMTAkYKnreqqN0xSodSUqnUihW2w5j62wTekkB4L1nH4X+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FYAQ/Y1f; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZO95llUGEjc6mmkXU7+dDdJ0V2VCebjD3kdY2br5xJ0FWf6xsW3wOTz+kQZ9YM3Yf8EofIW6dXeq2wvV9eULvJt/0ptxku+oNo8c6tr6e7UCQoS/iZCxBaZN6Q0fIY/9ZMnHw6iw1KD44Hpe7+bwRBMZsUKJ37gjWt2v8/+YFt4C/SoRACJwL8uZszJU+udWbHCUv+jdjBTsik9TlQo6et+BEG1grbRXWIM4q07+PgfwqYWjW9d8RZjwwjVW46WfYfVRmPeVka6+H3l8FP2z2URI66g8Dq996wWvW7mVXBTs7SYXanvp15YxcU0yBavC6f2iUtnJwdNTsp8kOQAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJg8fsUhUCE53Kiw6w51Fk+yo/nh8zUoDeoBqyZQU/c=;
 b=rvz6UpPc3MCMCQMY8YKtsqQRWMtpKRHyTuL2qVP6SbXGCJpL0VBOIm+yxdiWRCj8eUCtYGIu13m94p5eFbJACj8BK3ACj03jcfx9BaJUIkhwCMyjt9ncnEXVbT9n8vZ92W71e4Qerc4CuU8Vb1Ywv1TPodRf8IVTE6OZ6DzBlKVhsBdlRhcKgC9QwzBPkD3EwRzvBp7zb1gy2Nieo7N8k7mjUpjmN8chQgZxlgsRWrtqqNPi7YnW5wJ5MKaSFz338LJBmL5UM3Ibmj3tmOmYF7JgCWnsgZnICxCZhV7bR/s8EudBuuFsyKDEp8Qe/V2dna01jxJ6iRCznEK6I5yptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJg8fsUhUCE53Kiw6w51Fk+yo/nh8zUoDeoBqyZQU/c=;
 b=FYAQ/Y1fwuFVhlWKETT4z5AvLnb1/LbK/F8ewFvLR1Q7DWU5y0j0N8YEmBpJ2IP5e0T5ShTDogRBphSB+qsA4fzSZz5xH7gWrxBrCAdAoyrCNtQaZEsbTn1djW+3teiBm/hc9O6rePPXdey00DXqV03m2zJxo565s+NxOu/2fw8=
Received: from DS7PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:3b7::7) by
 BN7PPF683A477A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Mon, 12 May
 2025 16:11:22 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::6e) by DS7PR03CA0092.outlook.office365.com
 (2603:10b6:5:3b7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 12 May 2025 16:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:21 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:20 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 11/22] cxl: Define a driver interface for HPA free space enumeration
Date: Mon, 12 May 2025 17:10:44 +0100
Message-ID: <20250512161055.4100442-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|BN7PPF683A477A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffbb461-b7ae-43d5-79d7-08dd916fa37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXobi9KXRChvw4z3MoCBn8SUfMGqJutVziFTZC23nlOUbCV1Lg7uBK2wFAmY?=
 =?us-ascii?Q?OIxfvtTerbLA+rbIWu0an/XNdixs0L0QZqmazLy+p8xpz4kWfRbQySkCb5ie?=
 =?us-ascii?Q?BlD97odVpYFtT1i25e5froUn09KuzBX7LuO5sUCCsqZwiGRe/X3cf9WAX3UR?=
 =?us-ascii?Q?y9dFVZnRTw8cvxu/Lpa/YUK9wPUtCLwyFJJ7IQ1cntJWMB44OXgTh+B8sHIa?=
 =?us-ascii?Q?bJeIlm6q+amnJ00uX0wGwSbToNtQg0Pbef6HSysTTYdrdQ+x3Lf3PQB+B/D6?=
 =?us-ascii?Q?JvR/iMcWfE7/VnK4hsNle/mOBICeAWNw+xLHI2FV2iyuDOw6ETGlc0afRXET?=
 =?us-ascii?Q?zM8LbTM1FBXPb+uj+M57bzvFslxN7iamNQjXdtS/nAm3yzeuo+HJMBki4EZY?=
 =?us-ascii?Q?FBVckhNrX5UcMsO5W+qsJrrQs1+0O4sLXQnnruWwX3UqgwR2NiaETsviKg1c?=
 =?us-ascii?Q?otkMe41/9BFJpkucge0KoaUoMzgh1pAZVmPu12iBfEM5OI8aTRbG4ATV8LfS?=
 =?us-ascii?Q?94UvgbjFOAx5TGIrNwCKBt95CHwOs0S4bFF/DeF5ArdAzTjcs5HZvJPh+CVc?=
 =?us-ascii?Q?3Z9TGLBO04HmNyAjAaQUFtmvy/Np9XsU3BNu4iuCPNhb8did7VSlwUPZDMOT?=
 =?us-ascii?Q?buZ/p7D23kmsakuYdZKQ/lPwKO7Xz1TuKUNuB6USJKWhXl8OkQs4aWgQSvjU?=
 =?us-ascii?Q?kEsT9dZYHMVWl6APDhbaxDHnR2AC9bW2JCfad+DBT148LG7CactO1VfdmmYF?=
 =?us-ascii?Q?8afVOqnOuy1O7cjWmmUc1u2XJCaXzjxD2La0dDxD/gWP5gtcPloU7WgoErWs?=
 =?us-ascii?Q?dpgUQrGUoVsA7ZjkUouG6GJe5FqOTVj4CljqmJIAsjNf16WTm9+HIAjYMRTl?=
 =?us-ascii?Q?ITA6IzJBe497oA+OT9eCtfjG/MA7EbFB9Z3xZZytlkamDhzwVkEOQtfvt3nj?=
 =?us-ascii?Q?bG2Bz58VBtfCAFnSMPOC+RA7FxfnjMwFyYi9y2G+XR8e5/AkD5v8ZqeiS1kR?=
 =?us-ascii?Q?/bwDIQPofrHpoLhzHuGBvWBEwPbmlp89WuEyCDvIx5GIvkBkzto19ugZPqYN?=
 =?us-ascii?Q?F90pK5T5ARFuvcL58BPXX0BULxbk/z9YMzCdUxxXPdww3+m6pU09GhzXie74?=
 =?us-ascii?Q?cvIee2q1h+I0MUkFYgTpDu5gahssDM+U/ZDnebQqGMujT+nhPBjO2arD83yz?=
 =?us-ascii?Q?wKt5tvMrF270m7tNukDX3Ro0N3StkjQ8zlngq/Z6P7725mRq1iyw4bwhzddw?=
 =?us-ascii?Q?bbEDiMnz3uAn4u4voZIBvInlpWC2mXcte69C57llvhhrAKwX7k16R9Z+6LtE?=
 =?us-ascii?Q?+Z3tXAWT7+3zC8kc8KEG4b2vktMWdbBEW5xfUcnwJq6CWEY1gXD6f+mTs4/C?=
 =?us-ascii?Q?gGZJa9s0a+eWWHH30Z9SdpCqzxqV/kP9pPjhk3TZb73B+CdETUKFoAlIo2pH?=
 =?us-ascii?Q?ZcTuh1gbZnZvQkPBEc2c+FZ2B85ZmMSm2/fdqH1CEh5f6IGfFyoszdxOEJEi?=
 =?us-ascii?Q?m8TgEi0knSdet/uc5Ce48yEwiGxHZ+buVjqBNBgOcdMEHcbWAIm/SibXlg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:22.6030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffbb461-b7ae-43d5-79d7-08dd916fa37e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9

From: Alejandro Lucero <alucerop@amd.com>

CXL region creation involves allocating capacity from device DPA
(device-physical-address space) and assigning it to decode a given HPA
(host-physical-address space). Before determining how much DPA to
allocate the amount of available HPA must be determined. Also, not all
HPA is created equal, some specifically targets RAM, some target PMEM,
some is prepared for device-memory flows like HDM-D and HDM-DB, and some
is host-only (HDM-H).

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
 include/cxl/cxl.h         |  11 +++
 3 files changed, 180 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e6e737ac980e..4ebabae67f1f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -694,6 +694,172 @@ static int free_hpa(struct cxl_region *cxlr)
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
+	 * Flags are single unsigned longs. As CXL_DECODER_F_MAX is less than
+	 * 32 bits, the bitmap functions can be used.
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
+		dev_dbg(dev,
+			"Not enough host bridges. Found %d for %d interleave ways requested\n",
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
index 790f7dcb9500..176b63cf3d1a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -675,6 +675,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
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
index 138a0b69d607..fcd6ff77c6f2 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -25,6 +25,11 @@ enum cxl_devtype {
 
 struct device;
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+#define CXL_DECODER_F_MAX 3
+
 /*
  * Capabilities as defined for:
  *
@@ -266,4 +271,10 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
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


