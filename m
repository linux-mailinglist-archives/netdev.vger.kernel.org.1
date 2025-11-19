Return-Path: <netdev+bounces-240142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCFC70CB3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06B494E2ECB
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972831AF18;
	Wed, 19 Nov 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qU8+wHhk"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C28366DC3;
	Wed, 19 Nov 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580202; cv=fail; b=W/mDETOx5niynDKosslOOYvstxmhXXR+KPExuZTrMdhKPne0HOzrAT3uksuX+ekP9IpyYSqCmAu/GZ3VzibXIIVI80An7ke2M7P/m784c+qyufKudQ1pk7k42tyVpcnBtveu5lvqNUdphiwq5N9CgCKPYQuQnd/zHsel4xnXWCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580202; c=relaxed/simple;
	bh=wPZtBGfeQrvVcVgAixgRgdcEDZsG1M9dwKhmj9LRm24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWjnBJ7goWT4lMMiFEUZRiZY5CMRuxx6Cdlmuk99AC5/MtcMa6KG8/WDy7IYMA5uKL7LiM83xXziCTkZhFkQf1tgZ2A3nUQZJdG9bWK822t6g4Eoy5r/x+IBvsDbbrlbwdSsCGQkvJ17ZJi/jzSN2K4Nn8En7QYNbKULbCF6QSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qU8+wHhk; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwXBXwijE+dHeIsoZNRZZYncx7evhVmqecyYGVnR8236Et5bLPhiWKbHHFrqe1aet1lMLOrVNSsvEmIukH2//09dA24EI+EgCo7FiNzjzmMq3K0yam0bAVvkYPBY90ZVeUwa6gRPnn48Fr5SZVWv2UJKT/SBxD9kgX1FJur2lmdFVDFovMthTTATRcbrOCUtlo/yoYAQyxUAlQT39B2aFziiJmnrG87wqN1PPZBNQc4F7mgld/IPr6j+FKdTYSg5nkfPyfUapXEFBiDiDliiZq4nXmSetQNyWVI0Q8hIuZytCmkg9hN3WGPKYNke7lDcJaTtqzZLms8aEm/oRsF7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfX7dCI1oXmma7OabmPcHsOowILItqnv4SJlAsPVEY8=;
 b=etkVVoW9dGUmSFB/o96RTjmOt1ZPN3eqeQ+dgZNhNAqv9ThfoReVnMg75as1Tmzuh5KxLZEjTDmoX21ziJuSw7fbjMCnXIa3krzLC8wGxcx4VBps0YniHrRQ/rKv6zRRzOY5Fmce894U4Jpj6fG42Pc5tm0RG2IwkwSmXF40OmcCVUC+ibYdzoV3Q6UtdFe3buJJc89f+5JpUHTjDI3VVOgDhY/2v4IRhUSo2RQ03ZadsHQtJazO+/iincz7/hZCsLs8lj1nYtHLQku7FTcLII9wSpRf+22bp0CE2SFrs5ZDLhtHCJZ3UOc6sW/s0ufW+10LrmmtL1VArjnuh5rrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfX7dCI1oXmma7OabmPcHsOowILItqnv4SJlAsPVEY8=;
 b=qU8+wHhkInAL2/2KWc3wl7D/FsgzPMebGzK/Gz0aFD2lKRdv/XuuyVz+rk5qSis6QO4SZBSJbzyZlXty/A7nRi9q39c8KNlaAsJesOpS6bD4LyNAorQ7d/HCiaCxARnZY7bNkgE0/f6Eb2ZTEKQhhWUjoFbMVLaiUDID5t6lvv0=
Received: from BN0PR04CA0172.namprd04.prod.outlook.com (2603:10b6:408:eb::27)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 19:23:11 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::29) by BN0PR04CA0172.outlook.office365.com
 (2603:10b6:408:eb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:04 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:04 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:03 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v21 12/23] cxl: Define a driver interface for HPA free space enumeration
Date: Wed, 19 Nov 2025 19:22:25 +0000
Message-ID: <20251119192236.2527305-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 29558b76-1214-440c-f322-08de27a113f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcErzhLY6Of3cf52fU6zXh2tTctvVRRRyXKeeD8mdk4BZcNKR5RCz/j4X/m4?=
 =?us-ascii?Q?s2PHOegMBfT9BgBnnVIOvDTfkL+u6FxvypdqOe3Rkn5oqG3yxUAbO0r1lpHJ?=
 =?us-ascii?Q?KcJ2JWYXk/4gYB0XRWho10Jyl4oV3bA9/Vz54S/SZ8qb7QaTY1HuEbBhGtYQ?=
 =?us-ascii?Q?5lHd4fd7PlwrxQhE/9y5augl2WhKoRa5669d9D03uX5TYr1jSXUGEx0TDHfX?=
 =?us-ascii?Q?8lfnldSw3n52Dmi+JAwpe1RryDxyvVD0KH/siuXiTKu0uPrX8SRiFZAvRSVR?=
 =?us-ascii?Q?estaqasa0MHfhZIB7jl9bPemla+M6wvQmuRSys5jCq3gqgGfsHDYDj04+sz8?=
 =?us-ascii?Q?nZ8zRMUD1lKL/kfyuj6kNLDQ2+QdbfASBr1umc93Kv06c6tGjQBKnUSL1hJe?=
 =?us-ascii?Q?ZfQb2hILUPKreXoK9sB5JPTpWq0ljEG85vPQdeT/uaznryyE0xTaxsPSN+Vo?=
 =?us-ascii?Q?gFw63SI0OaTzuxR+ui/PIztWqqyV0wre2365GV3E7BRo0n/xWmOuL2O6YQrI?=
 =?us-ascii?Q?pbGDUPURqumiMOhMTcOn4wBzWrTKIed1eP0E5fFRfChM6Wx8uzeWow3qF/SZ?=
 =?us-ascii?Q?l2kDcs39M5UXkq6+15qC++7caiQLFR4mxfFwjM3vuGPgi0LwQIlIfaH/aJhq?=
 =?us-ascii?Q?wF3XbcljRJH82Xj6itg6xlXjwm4KDz3KWi6uDy5hpyA9tEg9aPUlHMeo881r?=
 =?us-ascii?Q?TjWqhOOlhLSOS/Z35jQx63ZOJMOBJK2IbbzkNPwNjsBkzM/xnfJ2VdPzhwgx?=
 =?us-ascii?Q?c3f9E0xihjpLp080HdeHP8QBLnnr5k/jcA2le28BBwl6OCM+xQt4t3NaykWo?=
 =?us-ascii?Q?Oq/IZDC5xkwt6vQXE07aC+eLsOlEpSvOHoe7t6liM9rpucIwaiZ6zJwddLfI?=
 =?us-ascii?Q?qxHaHb1n9kZTDWJZMsf+h3myDwijj5gywuF2YaV/3BQGZNqKYf3cKkdjkEP9?=
 =?us-ascii?Q?8NPh+B0cQGyRYIbL0LVzk9O0f6E9RmnzLqW4Tu1nfSkpoJshFxkE7Ftj88M8?=
 =?us-ascii?Q?HGKG7vGgd6tmB5bnedyrj8Ly+veF2MeptEKxuQ/gGjZW0e7/byTDMLlgG/ix?=
 =?us-ascii?Q?ki48LioPio8FcWG9MBGFvWSo90sQPQAuR8Hy6L5G87rV7aNqHvlAcvBD4Z92?=
 =?us-ascii?Q?Kxt/PIAziKFZuPPmvw0TeyuXFnM+z2xIY2hj6PdD1D+wNvkI41K8cLk9sCVz?=
 =?us-ascii?Q?ZUDaALQVtZbO2GUCszFLEwyflq5ev5349nnMaxvqvagO5i6/jnLVOLTVYQU1?=
 =?us-ascii?Q?Eip5AiguDpN3YTww60CtnfUK96S8gKmpBFBrfulw/3ObxcuLrAzHnyYgRdVo?=
 =?us-ascii?Q?XRhaOuiTbfOM2ISCCVxA9m9z/V8HUbSQeL8AM38DxfKsGzFssVDZtxs4H3xh?=
 =?us-ascii?Q?V7BL0DXeDSbIov4rdJxKDHvImSYkBg9fEFDsIpmfOIxQ6hEEJAoooQlpMfaM?=
 =?us-ascii?Q?7RrhIpEHuk71k9dCYBXSeu1QYCjWAHUkisBwfoG9FAOWW/YaSGJWY4ErXGHF?=
 =?us-ascii?Q?Zx+Xjw3cVMw9dwKlNF0AV2Td24xrSAhfSfdgytFw3E9Di8vMiK2E9XyZpBC3?=
 =?us-ascii?Q?/yObtJJ9NAcovNF3uGr5R/yg5ELwSDLJCtvLVy8+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:11.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29558b76-1214-440c-f322-08de27a113f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984

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
 drivers/cxl/core/region.c | 159 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   6 ++
 3 files changed, 168 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..c9bf7415535e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -711,6 +711,165 @@ static int free_hpa(struct cxl_region *cxlr)
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


