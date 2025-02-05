Return-Path: <netdev+bounces-163049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8867A29476
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCFD16610E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8E19883C;
	Wed,  5 Feb 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zz+NJJjm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6951953A9;
	Wed,  5 Feb 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768822; cv=fail; b=mc7U4C3OVrDdIe2q0PTpZcyZGQqMKPpSBvgzbtUf0yuGr+81JDQmmpCkkInH2o8F5q71Qx4T6vzh1MQZOIfgsXQQmmZBJiTW5RMIkNzzSUiW/vqoDi7NYHX48Ful3sON+0ehDuYr6Q4yBQTMhasNxuQRLYSpwrhByucmmF1fLhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768822; c=relaxed/simple;
	bh=jkPJ3tkfv0prEz/F90ViE0uxqkixccuAxc9L8eT4rVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyxrjE6XZu1seN5ciZLpNxNXoTr+K33mF1F2yIogWtAeHiCR1o8PJZ8qlAzBA0dF9hN7SVdDscnNxXeZ0T6OnzMtqCdDxlW5TG+6Rttc7oPMFSEAzWoSoi6hRrzwb8y66851QlLsccTlrY8fHj812XLtSlZhmS5YizyMMu/R9o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zz+NJJjm; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGZtThh3c0kSI+xjlUdVG7ZxkqQav6KjMxILcu1KkgCxim7l5jE8FvmoN5VZ64xFGFIvJYK5QMpS1u6QzGtWfOuZqOf+kizjDoqLLAMwkCn5fgAjF/UauZzuH/9Ak/XuNugCqJrbdr6haVQRvgGdQXUV2Xe04bsrjViLKNN/z/vq1+biLcDiK2NGTsRDbGROCjKpw9PJKjfTkTCIJeOdp9NSjTZFI+xgRNFzTI8lhtq9iDaE4cKbidDIuhGBY0IlpwVJpRHvB8WoOGWLE4EQUMInI+qs3G2I71hy0dRd/nFT8snFzWDnG5cy1y0t7ikrqUO/KP+dSyzlOoebzAhk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ourvPtaY/8IqvHel+Y4WgwsEhYCsFwtVtvOGBGPXH0I=;
 b=uRYmEGkMDFDfGy5uxPpJw2RC6uzICrsak5QE4Fryx5/UOwkBIw7PeDgIwarUVPjwRsG3lTZUQfxarrKnev+QoVrP8YLEMYwUscUln63hdOvzLZ3ANCva9ivxHkWI0yt4xFq7yztJ03lyG4cjkJsPbw/puSg3CGYTRSDGNQLfZExAMbo6iMq/w77Rxq6TuKLehSTuo+9J/G+SCRvEVEtl/ITxv3L5q+jEyOLWyK10YIfSLDi/35T5cIjlOAj2PBjQ3nnNL/Ap8tbelYJFGKFMLcFg0iSp6WVXgCWGIfdoswdb2IP3nK3WjRPfA4w1+qWUlUfaR/cYUcPm83shmsgnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ourvPtaY/8IqvHel+Y4WgwsEhYCsFwtVtvOGBGPXH0I=;
 b=Zz+NJJjmKeuHOUBz4d39FaQAo/dtFqAiJRXe6cZpip/uha+i5Z7lbcz4cyvYo/98kNPwPLvYIxPnzmRbGP86Hje7mMY30TDaQTSoJVwHP7xdeWyBF99usePBHV6zPvsgdh0gDrzVVL2asfb6eU+5XpvcK3q9C2S5wh4H++2mznw=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 15:20:18 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::e1) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:17 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:16 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 14/26] cxl: define a driver interface for HPA free space enumeration
Date: Wed, 5 Feb 2025 15:19:38 +0000
Message-ID: <20250205151950.25268-15-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 859067e8-9836-41c9-5e1a-08dd45f89983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?67C5a1EoEBcVI4N+rqEk1P6BLTMtzxlD91iKpze1Aa/Wze7F6ZAIhboQQeWS?=
 =?us-ascii?Q?3H2HxZVStoXwibwq90yPuwEfKgR5oyg+pfn1+GvB+UsfygsgArDddOm3Om2q?=
 =?us-ascii?Q?JiEoy0VaN5uhxKfTdDW/43K7BEpwslv0IsjKOfU9naDQIYMBK/suGvl+SjV3?=
 =?us-ascii?Q?1dkEWj19pc2QGq0hCeGxCaj5Xo0AV8yJx6LXzfjZM7Dtg+Z/HhgntTCAuQM6?=
 =?us-ascii?Q?dG+3U6qcLAjM2loxtwR9NF+m7nb0d0la/juaSo5yqaKqfW7fIL5HtEcMcjHa?=
 =?us-ascii?Q?osdviZ5soLaPculp41uQIYlb2eSwJ3cya0keQzD/IVzSp1/FXBj+deylMpi5?=
 =?us-ascii?Q?QCJ75QqOy5GujtUQVo1iZa+b8xemQTevgNRCLnqFrTCsHOLenWYlHjq9S0q4?=
 =?us-ascii?Q?U4x6HzfQcpICDB2C6VHE2C5e7UuHGuhuB6chI+Vlb6EZdgg/3ToBEmrUR1kI?=
 =?us-ascii?Q?bzEvTDgg3fWPpk1B5xT5WTBj03F84Q9H5n4+P1NY77coYtImYBJWLN03rHvw?=
 =?us-ascii?Q?SRZCAljQbXu77m1fEi+qhCHWXcbB+lHvgX3l7pSEi7fpkL0kt6jvus5U10eR?=
 =?us-ascii?Q?aakgYIqmvPnebevP+nKNa25flYVLFh5pwDDKVh12mC7LQdZk2Zsz/TsoGYVC?=
 =?us-ascii?Q?s/Bqo6tz0jQE3Er6cBIM3ntYK+7dUaNY0th5rrAEv4xzq6Oxj//htyOY49v5?=
 =?us-ascii?Q?TPPPQa14aEdEO1nj9/Xms6Bub1bOiKqU8YDj2JhwBx1ln323NNBJbHVvhosq?=
 =?us-ascii?Q?2IlK3kxvDo/K/0LCdk07N+NCW2ib/BBH6v8LzQ3QWXELqNwG70x5x8VgfyIw?=
 =?us-ascii?Q?rOdIXbZwJDP71HxwZGGNwdW75zWtJ/nv0htjsrQtgnhfmoZSgWCLfKs17/iw?=
 =?us-ascii?Q?yxQO0G6R0K//mAc3/dDyouvOl3hFuxeVlvt4nQNVf/ZaAjIZAqm5pJ7EhRUs?=
 =?us-ascii?Q?ROGb45ETpAatlhjdTQ52BdBFJbe5XsGWwG0zVByIePleqA+7Tr1Yme81JBx0?=
 =?us-ascii?Q?Kjp4cd/MglBwut5t3SKNX55eeMBuX4dIHl4btNztbtt45oCw6llG6uFY+5tv?=
 =?us-ascii?Q?xiniR86Csx4rIpXQqKCxaP0JDzaL8ICOaNgXqG1oBLFNP+qdGSW55/PpYLJ1?=
 =?us-ascii?Q?P536LrwLZumKD0nUQqUaXXSUz16C7q5P0iqBQHKj8OpoCLjkInk2sJ0KMXia?=
 =?us-ascii?Q?a3DC5bCkotg9wmiOtqAdGcFe9xRGzWHiFo33xD0t/twWb+z8KrqaQcIt9kzV?=
 =?us-ascii?Q?0GVnaPBPlAeUAeQv56NsK7d1VwdDCgRFGeeWTESO7B+0Q8XhB3JHL1K2GJe0?=
 =?us-ascii?Q?FFBingMSJYVWSux+Yz7SEwB2KPlGIvlhxQ55eEvNU8zgcV11a38QSyymM+DS?=
 =?us-ascii?Q?PLLP5XijEx4F+txnEz4NKfepwHiqJ5nfAzKIiUxcR1ewoc6NX0h9PRQ25Nk7?=
 =?us-ascii?Q?uD9ZVnRwMvwd4WGMHNLhO9yz1Iw7yLdkUadVhwFOwHB/zl+kpLTgsZ3Ula54?=
 =?us-ascii?Q?OENdU7+dku/yJpk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:18.5270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859067e8-9836-41c9-5e1a-08dd45f89983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622

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
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |  10 +++
 3 files changed, 173 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 84ce625b8591..69ff00154298 100644
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
+	int found;
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
index 3faba6c9dbfb..e1a8e3d786af 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -759,6 +759,9 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
+
+#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
+
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 592aa5e75bc2..3b72dc7ce8cf 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -39,6 +39,10 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+
 /*
  * struct for an accel driver giving partition data when Type2 device without a
  * mailbox.
@@ -80,4 +84,10 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
 int cxl_dpa_setup(struct cxl_memdev_state *cxlmds, const struct cxl_dpa_info *info);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_memdev_state *cxlmds);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
 #endif
-- 
2.17.1


