Return-Path: <netdev+bounces-126219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA89700D3
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C46C2841C4
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0D14B96B;
	Sat,  7 Sep 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Br27qmS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61111586C7;
	Sat,  7 Sep 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697188; cv=fail; b=kk9zr1Q6+AaTvFH6Ce3aM1PVGUX57yAVwtDcixkpQmP3TDfgIizxqEDf2Hexwa8Upy8oHQ3SsIwrQs3toG5xbfmTtjqWAYH4yDDYOYkIln0MGfmcark+I1RlZiNGLnbomlKj7pW1hTfJsDJlWdQfNYH68mQBZ71i2C4rhwZYeig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697188; c=relaxed/simple;
	bh=Ejm9PQ0n7YzoouzOj7j/GQBQJ1EcEZS9jgksBJj4MYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfUBpdhfRuECcjnqOY8Hw4yANdGJIJHgR+eyAIm4ZOPEG1ElNdZHEPoGsTcOc4njU6NSlDxgeh5aRWZ8TVmvTU+x+WVWy7lBG30Og49BRJ6HzBGN1OmVEcl6CNYynWQyRqdbgQw3Hmb0u/UrEVFYD2ycQpuMVZNedEjPN2JzD7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Br27qmS; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtCZWPASOnQoxWGz0/pmRAO6EpEy9I1IiRM5VTBOXt4muBi8RMYKV+twnMXWfGq0miXZ2KOKzuAh2MmLyR5cTKNtlXLik7vUc3vMgj7to7qyOI4PuQggVhhPlww6nqyFU2uk99RfsZL1wpmOffGohtoEzAhSB/A33rpLhwhlfEjJV9FJca8hQj8U3ZmqlvQlXyfBUCjxMY9rSjp6lXZjmtXzbknWbbnmAxu23J5/ppG1TQF7OZJ1r7qJMpHJyFVIDRsPV/1322y/1jOyQ4abiQMHtr18ioAO2FNKtjWgtpGDE9Po9Nv36ATrkS+AIYB7u8j1ut9oAfgsSrCuktAS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0wcPiin7P3XCLhVL9i7ZYhk6urUVeP1QUBpBE5NR6U=;
 b=rHiZCAEMWvwdxjsS6Q3vlZ3utpmAUCXhFDVlNaRjyEThnrtOabwE3EVzmA0HsU4nkSnEArGtBHOt3nD6jg9zVqetF3cTxoPfgHk/okF+8+9C34K2Fj1PLcuaiG4fupgRQjR3uMxvdSpGjCwnAP3Rcl/D9SWBphOYm0VIJkwnwnP7eMMD1OmztXnrPvylKxA5dr9MdCc+uw84YihFafSkCxf2CZsWyJ+Dvbe/VqdQZeRQd45d/2GqovrfwgURdzLVVRhwHc9pLxKJYs/WFgOuFMyGJ334Zk47N3Doi3dGrdH2Ky2jHVkkKzVYNd7DIFq4wnjKwVtjMmzoBUR+3epu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0wcPiin7P3XCLhVL9i7ZYhk6urUVeP1QUBpBE5NR6U=;
 b=1Br27qmS7EAk5AVqkrKhE4Bxj7fo8hWQnR2dD+FkF4LHb/UOuGbCUd1czJVCgoB0pzWBl9Xk8kOxmBxc1vmaUCmHrGYH7NpQM0EvrWhlQ0e2GkM1yZsxPm33BKG51q096aQlhrGsf4eaY60RAdpXeMyvhERLFgGh9A+enGosS0o=
Received: from BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37) by
 CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Sat, 7 Sep 2024 08:19:41 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::98) by BYAPR01CA0024.outlook.office365.com
 (2603:10b6:a02:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:39 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:38 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 11/20] cxl: define a driver interface for HPA free space enumaration
Date: Sat, 7 Sep 2024 09:18:27 +0100
Message-ID: <20240907081836.5801-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4678b9ea-fcf8-4635-bebd-08dccf15d23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1A14LeCMWezqx44hlq/BvGwCc486tiDx2+g9vjmhJpwv7+IoimJNKMlsgDGi?=
 =?us-ascii?Q?AUx29wHX25HxqrNiYtx2YqaCTNpHUo2Zi6LkgS8o0nQ3KAVKIX2tXNnhN0Ul?=
 =?us-ascii?Q?P1JMWXqEtUxPMqjeiTW8v3epJs8ezJE64Z+Mb8nOAKkxF2tNSPSw/VZ2W0Af?=
 =?us-ascii?Q?eSBOJDNLetiycILSA9H5M78vwGUHs/ZpZIANQ9WH0E2Xxmv76NJO2zPARPhB?=
 =?us-ascii?Q?3h4QB1SZPUK0UsN0I1ssTxK5EjsjIr1FEQaNJafeZmurNO3pA6voRgnxzSaQ?=
 =?us-ascii?Q?8Bpl3EKldEzvoO9lvhevGN3y7vsW2QLIxht7+lbINE7Z2th6p7pi9irupO8s?=
 =?us-ascii?Q?/LK/9Kp+dHvijXSaeyznCirJgZi13n11XArUwFYWNZOvdLGBP2KbI+7vwgfj?=
 =?us-ascii?Q?SKZDH+EdKSKVVcJRDGXAlyM3r7oGnviLBdAX4FutK9uPudcqBxv1Fq8lUJqo?=
 =?us-ascii?Q?y3Bo9IkM0zzk6HTHMDsbGYdX+kEuDeBgvlAVHykIpjjvxUZrBTQaLLwG6f2/?=
 =?us-ascii?Q?jVA3CGowUc4Z2I7+s41Bcqv/FCoUESY9W/LKM5O9/oMtn7PtUEGiLLHd3z/r?=
 =?us-ascii?Q?eDteLVcCY8GsGYSq1jsOa+fhvnZkaNMx/7mpZgsMh1vcykKX1pNetA6WiC7V?=
 =?us-ascii?Q?5bgTjbY56iOh+SkTYH+aFu2wRgQBjPzIw02M/CPwpxSPL5r86+j65QLpw81s?=
 =?us-ascii?Q?JOZB2kxZQA621tk1Mr4zNakwFbCsxnWiHYTf0f+ArIz67RTsnn2F0+GhpSbM?=
 =?us-ascii?Q?1q92XZYd9MuEf+RQgeuuHS/d6sLclpIARoO/stfIzOVMXWH/Y9jts8tsXT6H?=
 =?us-ascii?Q?+ygv7+01e9GdaZ7bRfdsZ/fgN66apkxQ5zH7nCkDwUykJe8rwR46Jv1oWKHb?=
 =?us-ascii?Q?OXG+sCS3ZlVwb+M+XZwZfjlHz9JK1NPRbIhoHneTm+kDjhkW3dnASRWAaF1z?=
 =?us-ascii?Q?RDPOfF29Dl1/OLlnLNICyxVveLEok2F+CTwY0h99X8awYgONOJcOZkvuKWV3?=
 =?us-ascii?Q?fQK57u7WUE0KQXBPlwN1v2/Opvh0cSq/2knWAOA6jyVjU0va+hV4Ttsxfque?=
 =?us-ascii?Q?yXQKm86lZiB561PPKKjLgYhC1/ppZbnkAc8CRI8QOHYKYYh51Qgk86OEFKTx?=
 =?us-ascii?Q?gF/MAJJdwFVcxglKhUZDTfCzykeZq+fVJ5rx9fKXoQSdsEFj7AzKXyxK/DX6?=
 =?us-ascii?Q?DDwzNeqtR9Siv2td1dHQHmIgKNGMKtJax+Wu5tZw/MOP41nyRwY4KiFoJTNZ?=
 =?us-ascii?Q?Sdof2+ayo7Ugt7QdR+CE1WtU407RClyV8xHctTef8KtA/M1xExsLqglYVo4z?=
 =?us-ascii?Q?WcTlcy7Rw5zkZLjAwp2QatUXhcBdBjkhQlImowkDO0XFVFrg23MdBKA/26jW?=
 =?us-ascii?Q?E1KJQOfOAuq8+uhFTE7lcDQ2tBsyKpCIkIQX+OSaF0sMHUZjiGBzw9g0rdMN?=
 =?us-ascii?Q?R51oOfE691+64c6pOlWsgvp2EIOo9iB7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:40.6639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4678b9ea-fcf8-4635-bebd-08dccf15d23e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055

From: Alejandro Lucero <alucerop@amd.com>

CXL region creation involves allocating capacity from device DPA
(device-physical-address space) and assigning it to decode a given HPA
(host-physical-address space). Before determining how much DPA to
allocate the amount of available HPA must be determined. Also, not all
HPA is create equal, some specifically targets RAM, some target PMEM,
some is prepared for device-memory flows like HDM-D and HDM-DB, and some
is host-only (HDM-H).

Wrap all of those concerns into an API that retrieves a root decoder
(platform CXL window) that fits the specified constraints and the
capacity available for a new region.

Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 141 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 drivers/cxl/cxlmem.h      |   3 +
 include/linux/cxl/cxl.h   |   8 +++
 4 files changed, 155 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..bb227bf894c4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -703,6 +703,147 @@ static int free_hpa(struct cxl_region *cxlr)
 	return 0;
 }
 
+struct cxlrd_max_context {
+	struct device *host_bridge;
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
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxld = &cxlrd->cxlsd.cxld;
+	if ((cxld->flags & ctx->flags) != ctx->flags) {
+		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
+			__func__, cxld->flags, ctx->flags);
+		return 0;
+	}
+
+	/* An accelerator can not be part of an interleaved HPA range. */
+	if (cxld->interleave_ways != 1) {
+		dev_dbg(dev, "%s, interleave_ways not matching\n", __func__);
+		return 0;
+	}
+
+	cxlsd = &cxlrd->cxlsd;
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
+		dev_dbg(dev, "%s, HOST BRIDGE DOES NOT MATCH\n", __func__);
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
+	if (!res)
+		max = resource_size(cxlrd->res);
+	else
+		max = 0;
+
+	for (prev = NULL; res; prev = res, res = res->sibling) {
+		struct resource *next = res->sibling;
+		resource_size_t free = 0;
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
+	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
+		__func__, &max);
+	if (max > ctx->max_hpa) {
+		if (ctx->cxlrd)
+			put_device(CXLRD_DEV(ctx->cxlrd));
+		get_device(CXLRD_DEV(cxlrd));
+		ctx->cxlrd = cxlrd;
+		ctx->max_hpa = max;
+		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
+			__func__, &max);
+	}
+	return 0;
+}
+
+/**
+ * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
+ * @endpoint: an endpoint that is mapped by the returned decoder
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
+ * @max_avail_contig: output parameter of max contiguous bytes available in the
+ *		      returned decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
+ * is a point in time snapshot. If by the time the caller goes to use this root
+ * decoder's capacity the capacity is reduced then caller needs to loop and
+ * retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
+ * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
+ * does not race.
+ */
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
+					       unsigned long flags,
+					       resource_size_t *max_avail_contig)
+{
+	struct cxlrd_max_context ctx = {
+		.host_bridge = endpoint->host_bridge,
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
+EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 07c153aa3d77..5d83e4a960ef 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -772,6 +772,9 @@ static inline void cxl_setup_parent_dport(struct device *host,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
+
+#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
+
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 37c043100300..07259840da8f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -875,4 +875,7 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
+					       unsigned long flags,
+					       resource_size_t *max);
 #endif /* __CXL_MEM_H__ */
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 7e4580fb8659..60a32f60401f 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -7,6 +7,10 @@
 #include <linux/device.h>
 #include <linux/pci.h>
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+
 enum cxl_resource {
 	CXL_ACCEL_RES_DPA,
 	CXL_ACCEL_RES_RAM,
@@ -59,4 +63,8 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
 struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
 void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
+					       unsigned long flags,
+					       resource_size_t *max);
 #endif
-- 
2.17.1


