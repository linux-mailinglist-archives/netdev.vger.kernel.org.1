Return-Path: <netdev+bounces-182293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9EDA886AF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B47167075
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1A274673;
	Mon, 14 Apr 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="itSFiSSN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262F275111;
	Mon, 14 Apr 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643649; cv=fail; b=DCU/4Rl6QPA2zk4VoRYy7RGwam91mC/m+31dVMESZRPlFr1165G+0HpSTxrjeTqAsNEK5Qq+2Gdm/swpgB/1uw1fARWlU3F7jFiHQ7A1jzQzxt6wCggxI6i/Ng403YcrO7ZRfbh43EyVv82Uz8bNzLh2dOfuM02nttGv6YpVL8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643649; c=relaxed/simple;
	bh=X42wFbj6VEjYMHErPRXkDN/K8NBCCno/bw1f2ixHoq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iu6cbOurHuvqyncyO0hbhT930tpWrEmq/FAL3D0SWdlUrYhLdpEydM3qWQe+pr0U/9m0kcKHX6+7GWVF2isI7ThtklroPV+GTbguXs1DrMSVjkfc7FNSq97xy3MDKG/TeIB19ugFYhZQK4HVqVvWVQ/hVOtvpqfzHdEwatGj+00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=itSFiSSN; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiY9oWdqBf6UxDblBdy9unfNUmMnYE6J4Xpcj3DAPOqAoVkKcmk++2XkEevzqpetyTdGzReHycaueMC+iz+xHbLHMK5wXRit3za8klgDfHa7ryU/SiTiZlfojg5jGQGrqt9CSkxg/qAXBBeCyzn289knRIRMwd6NRVhMPAmr0oVy36rFbW7bK0bZZZHn5fyEAC82xCp1Lor9/dbIvquAIKCn/GI4sMKgHaYsgALIOwx5V6Agp2BplHWYw2BQS8x7alos8MwezYthH37i45VYZS7zn1FHDDI1Ht8B57Jq/oST2npcMZ24zYM00HlcTvqebkGwk5SmcDUVYWNM4Uq+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc1EXDApua1bmsgLePSu7cFK+KFDhMU3czunYzK8YdU=;
 b=Qtu+UTJSgJJu6OVC7UwhbebuhBPYayMHd5p7B0lo5EQ0OGEYvh3CcRqYbM9rhMDWxevcLrtR1pYYtYCdotjAEu1F7uFe8d70k3UJEwgAfXmiCjDibKkHK6/lVdMYXTUpWQMcM43v+PAEM4V6kSLOSzWFZJDPSuPGyUZC8bwOT2QbDxWib/lbP67QTn3UmpNn/NIWJt2HebJsdU9vyeNinwD9zf8B/GWyF59/5Rb45Y5EuPF8otrrqhEQi3I9fz5BpgERN/XdFZnvwSVaiVpM6wl2Ofiaj6+hf/VGh9hyjpRFEdsntI5kv9Yctg2bfhXDjonBLUVjv/AvUlNKplc0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc1EXDApua1bmsgLePSu7cFK+KFDhMU3czunYzK8YdU=;
 b=itSFiSSNoFgOz+Pl+nFTv6w+OFYYnd6dJMi+NhWa1Lpvcg95vdZkxexNVRVlh/uBenLktg3TtrFrVPt3NJdJnflokKwJmwVWrmQ7b+sT9IOSbUDH2o4E8BazVtuN/AuyZHZBSEaxgZcpqO+yjySqQQQuF5arlqYJzYj+1Dinyno=
Received: from BL0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:91::28)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 15:14:03 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::ad) by BL0PR05CA0018.outlook.office365.com
 (2603:10b6:208:91::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Mon,
 14 Apr 2025 15:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:02 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:01 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v13 11/22] cxl: define a driver interface for HPA free space enumeration
Date: Mon, 14 Apr 2025 16:13:25 +0100
Message-ID: <20250414151336.3852990-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a82fc1f-e80e-4f2f-0c51-08dd7b66fdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TuRSUaglqHDhoJ0/BS1DrY0V2yVH/16PR0uwHrbtWS9yxK7Ed/7bEj/W+teQ?=
 =?us-ascii?Q?5TS558B3YJUThzFeNdD1QsTJvlq94n89EpDjDkoxWa+HGtOTAWKzbTRHpzoc?=
 =?us-ascii?Q?8uJjzFf/GMKdqlxP7c3103uQvp62uWIXkppXJcTA5QM4g4mQAZCePIL8iomT?=
 =?us-ascii?Q?O72YKcxuJGGFY3/phJrSTJepS7NAnqkQOI29NqDznULBlRs0/TlCP9/3pZKZ?=
 =?us-ascii?Q?xdl1zvupLqeo6mfvfEvKY+8UHqOIpxgoGj73qoVgQdKWYhovveQkfTnfHy6P?=
 =?us-ascii?Q?a7lr+1l3ltL/280rOvWIEvmJ8ktiEXHXoPi5eb02W2u+kaZxQHTL0Fz0E/Pk?=
 =?us-ascii?Q?2QZP9swDlvrvRHRzjpHIN+b2kUPrV9HiAYAakj5LYedNeMOEjGNmXw/ENKbu?=
 =?us-ascii?Q?kUSUjigKbF3qM2pipW1rnTrwzBpuSGdIIDjYhs/FL+khhRQsxjJUfPtyr6TH?=
 =?us-ascii?Q?lqr36wGplrt622YUCFNdIH3kXwZTm6rk+3b4goykGLfWkBYuM/3g4TQKQ/Q9?=
 =?us-ascii?Q?7x9K9cY1MguHAa7HfOH6o8H9ZONotZnyT7W9228RFFKr5KCwWsPAZn6aWC58?=
 =?us-ascii?Q?k3D2nVmKle/aKF1h8FJGaKYo/FkZ0gNSTw4moiv759qfqXAMacAUJ8Y1f1Co?=
 =?us-ascii?Q?BA6K7+3jsehcW3sDfUzg52kTa2uJVDY4LbRhQOi7HXIcr0xDHhNI3Y/W2UUL?=
 =?us-ascii?Q?c1VuOTzizsF6299PN1OdGu55Ip3iFrBwk/Jeqi56s1dNxikjC5uIiZw4AsEg?=
 =?us-ascii?Q?w/IQpol8X9XV0ervzwUY0dZxtfBw8/y1nm2/MCdMCIN6Oh0+px94QDgkap51?=
 =?us-ascii?Q?NDtkskMS7cejEPBWqdxbLhV+kxvceTihE79wgxsPfFDxDfMKOhL/Du167QgC?=
 =?us-ascii?Q?qOrkUkmgsmFuKt/+7l/hzd+pwVnJE5Z9nkpNLUC71o58W5d9yqOLy8d6FRqG?=
 =?us-ascii?Q?ZmqxF9nFGdv/2ikZV72X1Hqph39kGUjjLMNAbfK72yJZN3VGjDT+Dx4vDbmA?=
 =?us-ascii?Q?BgNGU8HdYka+e6WumqwWvk14iIfxIEGuE4en7wpBfTYN/cGA5T7a157u/1SR?=
 =?us-ascii?Q?PjhFehONa/XswcCGW39utOOmC/O5hvfdv1APZXzzrRyse5bVg91DFb1zzxuo?=
 =?us-ascii?Q?pvkGQ3JwMs3whq9EVVKWhSaslvd03gjQ25MhU5yP3M8D6Sq1NrCSD4Fl0TNZ?=
 =?us-ascii?Q?cZo+dL4mr/98lagBKMQdN4EfINUDLk7PfOBiRR4l3eL4bTBOpeUhUCF/OXsa?=
 =?us-ascii?Q?q1TZppZ4jp0fQlbDoarrFV9jd/aC9QvWJI4pWdcpYmXmGWnd5sFvbz/66W+J?=
 =?us-ascii?Q?BlEfMmNm20Y6MErv5guvpqx/g/7vXTIO1E3S4oZEJ2nT1WFh3TLNXZbUJCOb?=
 =?us-ascii?Q?gIKSTOncJPtcis0td3tgOkBtyvgPi+10pj1MzI2tc3JOaZEthQkrJdy7HMgy?=
 =?us-ascii?Q?f31s08V0yf+UV/VFXKDQlHJWY+5vVdJzUeGm+6yL7bf8GdEG3SDywQSYt3t8?=
 =?us-ascii?Q?gaWjD4FKPdfIQ0knPy+QFnXwu6CxPxLHa6d5gDAT41UlF0KvWjfOfhhMYw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:03.1160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a82fc1f-e80e-4f2f-0c51-08dd7b66fdd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798

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
index 879725793f38..0334c8cc9a01 100644
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
@@ -251,4 +256,10 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
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


