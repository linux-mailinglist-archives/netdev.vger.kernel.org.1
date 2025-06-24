Return-Path: <netdev+bounces-200675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC09EAE6835
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA8A3AFB74
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB372D8776;
	Tue, 24 Jun 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h76ZRx1q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F732D661F;
	Tue, 24 Jun 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774475; cv=fail; b=rzby9r+SPPGkSUB/coGh5SJzZZOAaHQs8kaSWbJT/fxHWbws1S9MpRR7TttOFokkln7yW7DFA1n3gSqckqmogy8Gd4gTBU9rboGa/me9/9C7gWG4fmBmp9FIQLhXCiBHU+xqY5X4hFLZcu0tkB5J1wmMhlGY1KcwVt+Oixqqv8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774475; c=relaxed/simple;
	bh=ywU1OC7dmg9I74TQySL6wpnf8RnvLj8ySIy+1YDUJHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLx2bgNQBPlu39TYdB0TMFnv3ZMbMbt8dVuSYqCHH6/2YSKYwQ4zwcizj6vcZhUwfeaDLjN/lUbhjYgEQKIGfuATCihZ6LACSIOYrkZ1Xhf9hU7nIq5g5OEfpIrEAGjkj69djxEpIqFjzV3T43ns0XER8pKiMfbSk4IXpKGjnfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h76ZRx1q; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDDicAnoxRU6+Z5r9o8TUDaC+zacFflhJPLSQcceg2UsNjXOf55UJi14/rF5zsqw1W/ntiO8aUZI+gIKJXO3ewphoiw+pCVcWz6DPWeVfkqM5qqP6DuVt+PIkakKcnouS/FRlDv/okFcLHThikjxA3zcfj8ZbfCUdbWdikIpp+8IL4MOk0TmddrMzvydCT/doAziO83t948tAYGV60axE22G/Swd0zaVwJ3+wMbYOb/nuZ3OAx9PfiKxY7kT3rfvezUmEXxQZHpRGnETCSHPH8EsHOdwFut+6oes7NevmMFbdUMEoVr2GsK8Ve3LCu/8G5vKBGSTixht7yD+1uik9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glcBVUlynxlUoaySEPXpfXM7h3IXJ3QwBZcnZPAQZxg=;
 b=uJcA/ztFRoEHRqmjlgsidJbnD3nQ0TCSYGc0oM2UbSprvdkzcfqricnExj1/D75GHxCMTlsu8Yje9Ky10qPvwdYjzP3GujKnacaXTYz1wAion38BuI/rZxzIL+Nqje27EBAQqlHJaXaI2NZAUvDYS8PyonSuvsdbdSbcOJRqbmOnd7JOSroLtlqdyEF2gzAN6txR2V6BhMXYkHxIBlKx1XwpQjmzASAJrqGAasOGXXM9pUIH4GVDaKRrIT4NwKRsi1Dl2x7nR7xDNpC83pkflu55Pqd2gAqkv+Ie5Lojf5I16CPZqu8AohSHANXCFV/cGXppOpR7yi62oF5/hvRosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glcBVUlynxlUoaySEPXpfXM7h3IXJ3QwBZcnZPAQZxg=;
 b=h76ZRx1qFBjKy70ecFZjsn0UydezxzyqpJa2MGPrXR9FFnBdcj9WhgPXKCCdNrJq01kLwHE1iLHXMrhyT3op9VWWZlUhlPWneCZnFoZqn99sMV1LRWwo78eFfIKWKTKXdCd7Yiedcyi96dFaML4w8e0WTAnTFMma33FcBAX9RuQ=
Received: from SN6PR05CA0020.namprd05.prod.outlook.com (2603:10b6:805:de::33)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 24 Jun
 2025 14:14:30 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::c2) by SN6PR05CA0020.outlook.office365.com
 (2603:10b6:805:de::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:29 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v17 11/22] cxl: Define a driver interface for HPA free space enumeration
Date: Tue, 24 Jun 2025 15:13:44 +0100
Message-ID: <20250624141355.269056-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c94b5a1-1cd5-400b-e87a-08ddb3296fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P73C5CRJWVgs7p5Eo5JfYcqAVUAZzQMEkEL7m0QgAXRoKV+uhrs0jvDXPV8e?=
 =?us-ascii?Q?r9Xh2ghAvafjmmgQudxaIHq+GlCnBCm5GWTB0cHbg1/mZ44YtR+Ul+jR9dy4?=
 =?us-ascii?Q?cIfkJfc2czaiyLVKujwiyZjJv5qIxszLK3PxL5SPG6azFvyI9YSpVmFshJ+n?=
 =?us-ascii?Q?PHU8nHxvOQgbSsw1KxJRw00JzzlAlBoVTmnGj7w+pRFzBInizjKIX1HN2imX?=
 =?us-ascii?Q?nY3AJTBQ4/xz4+viTvvO50dYTeymkNwRRPifvdYjOqiZxqv7EV6Lz8owGnLi?=
 =?us-ascii?Q?Ja5gj+h1Zs4LWTkDK9kIfCbRuflPLAMow6IdVL50lOY378rafmiYMJqfZrLu?=
 =?us-ascii?Q?Lw00afk4DAjSDdxsru7Don/mvTJTPMBV43e2w9+v3ejgnoRo/F+DILxHjF3e?=
 =?us-ascii?Q?SH/KEt6WVHI45y5m/rqWV5CeIm46Bykm5AJupf2FEMBMxUdcsdFdVcI73VbA?=
 =?us-ascii?Q?DJGvBdyLlfK5IGjrUeXziYd8slSBiMGuxSsiwegGFBgyjn5xtQpXN2RjxFNY?=
 =?us-ascii?Q?IfXhfKtlWG6aeqEQcA961h9AcYBaCcfa0gQJ55OFN3qcL36vY3VLHuekCCo9?=
 =?us-ascii?Q?+wo7KZPih0avbCF82nBJTMprDnYAOSFFYMV9PPDaWh/5oLpdG+3UAiIdnLah?=
 =?us-ascii?Q?Gg1nvpEpZY7xEODTklD2lE1zRj+gdiYBvuzOXDohv4SvyDXMLYgJZE0MkA8O?=
 =?us-ascii?Q?5W+rUsGHsBGWsP+mbQxXDNf/VDc+pdUOdP6KVuxkXQiQ6Y/ziJZJguXH9Y5o?=
 =?us-ascii?Q?4CIKSs5AmcObk6WU5pbT+nDYsV364FWdUrR2NWizB5SpteEwZnzAxSpAsRpB?=
 =?us-ascii?Q?cyjuiqIEHWnyD05n9LNDkMoLm48tka8fxV1e5wgqEyAZj31buK3mC4Fw6h2c?=
 =?us-ascii?Q?HK6QFIfLGkPEsEUTRO9gcr708q41HeqK0htSJZtOQnARKJZXzGPrvmcVi18E?=
 =?us-ascii?Q?/Uc9dUsIimbv71y+dHen6j4akvoR+bZDvlNpERSjn7iEOiJ3Jp6O5Vcp5IUT?=
 =?us-ascii?Q?Lnj5K19bx4ehZJfKzabukgZOd899m3oDh6AOmpmP9bfOU+S7KQdNbF41kXVT?=
 =?us-ascii?Q?iksJDsaPfmCJhCmyzOMU+r4kSiV81IlLdFS6AH6M02DPk73EWQhE/jWBIaV2?=
 =?us-ascii?Q?3CauLyYX0KrdhoDmSzBwcUOLOI5zlEpQmCs8uY0tKXMLAspn2/AEDYt5sn4u?=
 =?us-ascii?Q?BjCzFp0d9y9OhyiWRTKx8+pzOUD+ZrewVxw6AhfqEbAf2CEWY69MQZgxvOAe?=
 =?us-ascii?Q?6+8UtbsWY7Y/GAR1D+oTJlWjxtCDUYuo0V38mIRMLtWO/q5ydecv1ZfvFmzH?=
 =?us-ascii?Q?NTsneHMQGRSdWkL8JRU7e6UJPdJ7GDl0If+LXV7EyzMu6M2ybwbnw89Ojvj3?=
 =?us-ascii?Q?L7jbtFwhpSzgd1HVF4CC70oZK9vb5oBsWwHKIB/Uq9f1LxSSwMr4ZHT0nbaz?=
 =?us-ascii?Q?IOnNxO4mZVDnN86LxplcQYfLvh3TEM7SmiGbZE/Y6LLPn6VLC1+n1TrbsY+5?=
 =?us-ascii?Q?rfU8exuU+KA2gtNrYcgZ0WyNJA2URq1waPNEvUUGk+ui3QQax1auYZOLRQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:30.8066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c94b5a1-1cd5-400b-e87a-08ddb3296fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335

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
 drivers/cxl/core/region.c | 169 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |  11 +++
 3 files changed, 183 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..03e058ab697e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -695,6 +695,175 @@ static int free_hpa(struct cxl_region *cxlr)
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
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxlrd_max_context ctx = {
+		.host_bridges = &endpoint->host_bridge,
+		.flags = flags,
+	};
+	struct cxl_port *root_port;
+	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
+
+	if (!endpoint) {
+		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
+		return ERR_PTR(-ENXIO);
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
+/*
+ * TODO: those references released here should avoid the decoder to be
+ * unregistered.
+ */
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
index b35eff0977a8..3af8821f7c15 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -665,6 +665,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
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
index 2928e16a62e2..dd37b1d88454 100644
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
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
@@ -236,4 +241,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlmds);
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


