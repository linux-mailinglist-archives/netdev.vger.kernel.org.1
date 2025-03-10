Return-Path: <netdev+bounces-173664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47913A5A588
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CF33ABAC6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5B1E520B;
	Mon, 10 Mar 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Trs8W/2V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB41E51F6;
	Mon, 10 Mar 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640654; cv=fail; b=MTiSFz2GUuWBYUUPxrTXxLCsL0WZ9KjGTd6FS2HrzXrVT2pATznG7yCurNxzq7V5I3YrP+L6baiOIS+OLGCpbPyAvXh006zG0jjr+nOmFWWYqvK30neWNE2BVCi8YyKhH8fazW6aBq15VeW9BKMYxgQ6zsCCDeQRGcOds/I5dzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640654; c=relaxed/simple;
	bh=zpU20klglVTFhKrYSQJSJjq2Wzysum1lu4uYuZ/jnFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTK537q1K7vQeM3I8ABjjVPay/MGGTioGQESA/Ck5+aOtKJmUkH5lSHGTuX+4BdASR0uEAqUqhNV8I3GtJtTwdHZgh0CuJSPT+GSwW+fkLp6XPb3tmf0IyYS4w/WXjVbqlpwlqLb3Qio3k57+81yaP95Wu+PK+k7uHsrJGk2fzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Trs8W/2V; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9vQshOK7iQKgRWHrAWt0opAO7QhIWTCXsBztvltwuZZGtuk13b1d6Q2170KhkJ6xMInunbelPMmp6IqwNlKqWz4ey+O4DdzM3rFbFH70YQia7pfaLeR4mkuiSuqvihY/did+M5aKbsMPlb1ncN9zP7xfnuao0oO66MmKd3EKOwP8K8JMgwziL+IhuqrYoES5OCbYWzcOkjlwG7PftcfYmdkvG4pNbA4XXygu3MhFT1ZJA6OXCLnhaz/GFxsKwFBGfFTM/d4CAVAWkI8ZcoFtxtPYw/tvpChc9YPUO4UTKNaBie+BmAEywhORQZFB5VK8x24Tilo3YO5esklHlei8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OROKJuW6WwwVveWy3Gw/MOruCx8F5kA9zOkpjICugtI=;
 b=SDbOHVqIktav9uL1tJ0X+mkLNMLe6QNV7ZmFEhg7zagxvnIcrPp1chNQABLHGAeJ4kqkfYRJcT2weaWy4D/MBv/IIAY0HSGB0eSH57NnflCpI30Dpc/DHFxdhKhjPJXwGUWAhTsY4jmVpQAZjMhczzI/3I5DcXRWbXaJzNAaAEtFPmtyLFn0XD/YOuw9MDvGpk6xkOKpkv7LzLIrwFx4wIezuQXCWaQeAbBgJ+Z1BrE3d4UzoMqbRyRU+Lt3uX1CFcjXGc5PVdAO4s/rUSoC53HiTk1omCThs+dqDnVlOLd7l2q3Eg7gJTLUBvSUlfyfMJiiBbV0qomZGYqzP9f8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OROKJuW6WwwVveWy3Gw/MOruCx8F5kA9zOkpjICugtI=;
 b=Trs8W/2VzY6r6sDQQ9xixIqwYHRqmmiQHJZTh9i/R46Zc74PhqdXO/OtvZiwUpiM2lNsFjYYxDz6MU/1E4qZwUUlCzv+yquT2gGKQV0BerU9NlQSZrItqFwg48yPTBV7oWFQpz35ND1rk4yrpp8vF4gDNZdPdwyAg07VJQVFiT0=
Received: from CH0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:610:119::32)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:07 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::fa) by CH0PR03CA0363.outlook.office365.com
 (2603:10b6:610:119::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:05 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:04 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 11/23] cxl: define a driver interface for HPA free space enumeration
Date: Mon, 10 Mar 2025 21:03:28 +0000
Message-ID: <20250310210340.3234884-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 0401dace-2cee-4150-b35e-08dd6017185f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMShydmIZB0T6PtnYos5U2HbN0Eo+joPp5UiJu/8q7jF38O/CNp2Nf+s5tII?=
 =?us-ascii?Q?XVkF0CBlgpWx/pVjSDO0X/qv9to197oj5yUNKjeMGjmOjjk6B3Ll0/0EVmCd?=
 =?us-ascii?Q?CY5kN7PEuAE9WAThiXun6VIDWriwgLOpKdLO6eWqoKG1UnThRFDKxpsqNPrd?=
 =?us-ascii?Q?RbY0KYnpV/85HmZLGvsl96ijsU/YMwc4F1f9kzCI52WCx+6S0IQ8S1lbbS5A?=
 =?us-ascii?Q?KsGDAEgUS0WsH7wlLaU5Wb3n53YQjGhxRMZqgTHnn/yjk65kUp0ws1oZFvs9?=
 =?us-ascii?Q?M2V29GSBu/sePNTbWMnTC8ajbp5OSZPF7etIiEnh20rf4pEMhSeYztMCLwFM?=
 =?us-ascii?Q?ehZaAvXJQlUzOy01TlX6eurE93Fmf8t+HIgf82VIaMRYEo1VdDPz/DfKLevZ?=
 =?us-ascii?Q?XZQdQ9AQ0ONj8e/KE7Qtg42jUAYKlIj9+wZNU0zemUWaiwZa2E6+4mUSgYbW?=
 =?us-ascii?Q?QCPIXAsZ4Gm9Md4Axz+dXsCx3Xwr/7aIzlictSoSYwE9QJlXZ0fpjah0JPO3?=
 =?us-ascii?Q?sYCHqF7ynMe1bEXZ8m5vJJPV/KtDrLkok50rrnrvrhnceSlT4kBSxVy2CtVu?=
 =?us-ascii?Q?ufZ9EJZ0W9KP+DCdGHpzzybdXs07lsklL0mhtqaD75Q2MyPpupweN6RprcRt?=
 =?us-ascii?Q?oxspuppzNjyi1eSxtGQ1O+dKGe9z14F3j978TG31m/HPJo33tjlAdM3lLIax?=
 =?us-ascii?Q?Fqe6IjnN1xxQofPHR5ZRxBRzlbCxG9RSJBaMDmY3hUQLyP3+OOMoaDKZgeDY?=
 =?us-ascii?Q?JIiKbqnl9BS+z7r359nKzEO82O2Id5BJCdYpnP7fCpoiApvvQCpl47Bddqz/?=
 =?us-ascii?Q?Oo70EwmUd7qlAGcxAt41HlGa9Garx0UtWEq4grx9oYmgcY47R3r0W2+esilz?=
 =?us-ascii?Q?yFcaOL6VQoKyteb847qjQgyPmPCPBwrRJJNXVW93LRwCNZauPDQI0+N8AdkE?=
 =?us-ascii?Q?mY0Vn3MItUZTi/j2QxU3OCaoslEs4+GrJwlLBQRfaf6LrgNZMyW1xvp0g8iw?=
 =?us-ascii?Q?J75nRGmdnPW2nl42hpPpAsktYCOAz7SPlA4dRc6/kkBCcatmY6a7h7/lryLN?=
 =?us-ascii?Q?9mvnGHgufrttDrWRMeuhgoQ1Dk76UpzFpO5DF0ytRvaJZ758fcsetgl3gcRh?=
 =?us-ascii?Q?A3+gnPTsOkbZjhQFqYl2Yw1Bg5te64VpQsRHDyMqkz7WHaF2Vo/lu8ApFIAg?=
 =?us-ascii?Q?BhqAcqA7iDor9xGcUThh9FV8ykDssgzfHX/r17C0AQ9t4hKrYMqnKGKuKYq0?=
 =?us-ascii?Q?wS7NdSkoWA86Tn8ag2C3PsE1Jn72vkaaPpFT0i9NZ6cz6UzgByQBKqU1m2DH?=
 =?us-ascii?Q?heeWkvUMmI54h7W6QamWd2N6SfWWdynXxjXEWUKrRcH2vTEU+frZuhPulDSG?=
 =?us-ascii?Q?SD7vpMewWONEKjz7asBJ9TeZvssg5MenG+VLleVu005cSjJQBuQcDZ5WP0/Q?=
 =?us-ascii?Q?gq4pUhYgCLwbYWUs+vrzPh3yEp/T4La5NF+f2FtPVWr9cJdt3dFWm+zXzJIl?=
 =?us-ascii?Q?IsZ88Mk0hMjG72I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:06.5136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0401dace-2cee-4150-b35e-08dd6017185f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358

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
 drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 drivers/cxl/mem.c         |  26 +++++--
 include/cxl/cxl.h         |  11 +++
 4 files changed, 194 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8537b6a9ca18..ad809721a3e4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -695,6 +695,166 @@ static int free_hpa(struct cxl_region *cxlr)
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
+	if ((cxld->flags & ctx->flags) != ctx->flags) {
+		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
+			cxld->flags, ctx->flags);
+		return 0;
+	}
+
+	for (int i = 0; i < ctx->interleave_ways; i++)
+		for (int j = 0; j < ctx->interleave_ways; j++)
+			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
+				found++;
+				break;
+			}
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
+	max = 0;
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
+		dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n",
+			&max);
+	}
+	return 0;
+}
+
+/**
+ * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
+ * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
+ *	    decoder
+ * @interleave_ways: number of entries in @host_bridges
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
+ * @max_avail_contig: output parameter of max contiguous bytes available in the
+ *		      returned decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
+ * in (@max_avail_contig))' is a point in time snapshot. If by the time the
+ * caller goes to use this root decoder's capacity the capacity is reduced then
+ * caller needs to loop and retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with put_device(CXLRD_DEV(cxlrd)).
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
+	down_read(&cxl_region_rwsem);
+	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
+	up_read(&cxl_region_rwsem);
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
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 9675243bd05b..ac152f58df98 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -130,12 +130,19 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	/*
+	 * Avoid poison debugfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (mds) {
+		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_inject_fops);
+
+		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_clear_fops);
+	}
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -219,6 +226,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	/*
+	 * Avoid poison sysfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 340503d7c33c..6ca6230d1fe5 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -25,6 +25,9 @@ enum cxl_devtype {
 
 struct device;
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
 
 /* Capabilities as defined for:
  *
@@ -244,4 +247,12 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlmds);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
 #endif
-- 
2.34.1


