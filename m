Return-Path: <netdev+bounces-136679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E249A29CB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4A428302C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000661F5843;
	Thu, 17 Oct 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O96ri26i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C41DF990;
	Thu, 17 Oct 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184025; cv=fail; b=L3wcRp4HhmJrRWkudfKxM8HJddhf114Awi7ET1ie9xIkzdf4Nf74QpiBX1r+GDGSHBa7xHmgCycnJepF89iFZwjmpcwrz3fsNbqqmuYNTNhtiKmDaUMc8LFMMXqk6Gx5xbK+mnQRmhex7tDQne5solVNPQC0k5CXibv2F4Omqwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184025; c=relaxed/simple;
	bh=u0Ax7XKvvEpgeO9/qOE+KJkt7GHrGBg5PuePvdlA5fI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICA1DTMS1gMdoCUgTMRAjE4NB04EbszcBsd++DUkQ+yHRAEgGQhdIIXf6oNDqRQYN/ueq3YT/0FMfhQAfwTcUBpBJMZGbuemHmacqINJ9SGJvnFyuqCLK+mrGJIx/4w753Syw2PCld1eQW/px68roEQSotz9rgmWMxlsFHqZ5Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O96ri26i; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myUx1uGpJAwfGvNhSYWm2//jDZ0/uUmiDgm7P90WY+wEiP7KB+rQc9LPUdthokJ5kW0KwhruQWFhcF1zOS0TRtb2nj/7Kac0EZIwYWx3K4bMG88xtMPgaZYjmhgPdPq59teduuI+1ZHYDnzBqz0QWGUB3HDiuF9QlUGveXK7a7NFC5T2lvk2X00D8VZ50N8a4W7EFEbrX1/BPSoRw4WTU850cksUKrDYpTKhLsnsRLCBY+eWP8y7h40+woh1vuXwWi7pieJifYN+ZOkDGQ7W1LxU3Cimsp5YmZX/+7N3mRwva1sVnvYWrxe8JTtCH9NJwP5rZ6Rmzdqv2tIJ03gCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3H5DFia5RQBHwrK8BRzxh6+4UcndMsB9HFXJgQXCZ4=;
 b=sTL9dT4cXBc9tmqtm+EcpNvg6rFx2HhdcyKRGXAjDOEvCUyC9OMEyflDTNKCToz0BAt1AI3vS4zxmkJGB2C1vF2Zqna/LSpwoyuNu6N4ymGY1yvB5IAv+FXHztCpLV31V8akgTlVAzjmyzQWG/W3/w6erSniZ0sHd6guOqdfrn/OtKRPex4g3vF3KF8ACEw+Q5l5yHSIluswP5OIFqDD1Zg78lB5euOL3advACOHjMoymOmjqjTRm1JY7GLC5JiVxpYALIZk6V+92ldWUuAHHmHrupwdyFS7jJsw1h0x7+9blPmWFQwCI+EGqMgp1CMMTJKo9pA4pLWyrg4CE8QvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3H5DFia5RQBHwrK8BRzxh6+4UcndMsB9HFXJgQXCZ4=;
 b=O96ri26iSL8BplY2MEBu7ICeKMXystEDirhatDw+ESkDH9Bi1eKOSckYQa+gVva/ZBL5pi8l7SzIGH0L4CKzAFg71W1PHm9zcaZQKxeC4oci14YST3qxSYBRmxOJLPEg1lFXnn6qvqi649Z3pnWx7/l1tnp9bXRminMNQB4TaxI=
Received: from BN0PR04CA0160.namprd04.prod.outlook.com (2603:10b6:408:eb::15)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 16:53:34 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::f5) by BN0PR04CA0160.outlook.office365.com
 (2603:10b6:408:eb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:33 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:32 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 15/26] cxl: define a driver interface for HPA free space enumeration
Date: Thu, 17 Oct 2024 17:52:14 +0100
Message-ID: <20241017165225.21206-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 4772c3f9-5af4-436e-f3c8-08dceecc3d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mz1ucRUU3bov/Q5Kz/ZeUTGmK6IVZjH4XinLA96rCWSAk4cNGiZJN5ijXsEP?=
 =?us-ascii?Q?Ugvlt+ljoWIUECEYgisaIU8ku/pjQcTXpWCkUi9A/h3E6UXcYoA8twLN1RHD?=
 =?us-ascii?Q?lbW1EDQSLgN9DFaDpGIadpVB7TSF2RUyb5w90aLZuP6gsF9Lmdbt7gOkjxFi?=
 =?us-ascii?Q?6cZ6tXOr353zkvOMa0yu5HaS15CyX4pzVz/XG12yFRwhMHg9irevVaydP6yB?=
 =?us-ascii?Q?z04Uar+mBxlcoaJaOZz5lBJWuJkdgnYN7Ceg2I1pddkV+aAF0H9c/icmctPd?=
 =?us-ascii?Q?lbq+gdj01AKSonPboVCAu41WQ0EA5RvIErTtEiJz5lbtDqRWxTsFYzAHBnbg?=
 =?us-ascii?Q?Y06lqfvCef2n5pImP1O9242CkNTMQVKQ6DFybgjzQneg2nnHqUNRoedF2EGi?=
 =?us-ascii?Q?ixM+/87nCt39YEPXcTZuQgQFXdoh0oh/HM4hsaD+GktTGV4vVdaJ4ZimI399?=
 =?us-ascii?Q?yvR1ohkbkt20NGjKrcn2QJb2MdcrlG1ayZsCHkZcQII0cxiL0gnav8CSNfTj?=
 =?us-ascii?Q?bWynJy27ZvMncCIidG2eIuHc51rpjqu2Y1SsxrfPC/ZcmHB2RrkP7z59V4Fe?=
 =?us-ascii?Q?iz7Y+sFIqNr9pUxAndztsQh05R5uQAHeL3YgxG5AgSjGhNgR91nLZWRrA2BA?=
 =?us-ascii?Q?h34WrbQ2w1393cLvpfPQ3WbwFhpLm9AxVgu/WF8DSITt/UoB6AxTLsYPruye?=
 =?us-ascii?Q?rJJHT962KHn4YdbNsyBGhkjlVVYuEconKIEJ/nAQ4N2sCGtBqGtT7dRefpmy?=
 =?us-ascii?Q?6xsauGHZPugqCz3XTdAl4q5R+sgQw3ge+yUHdGWEfSVaxn8eF5xC+cW4S7ED?=
 =?us-ascii?Q?B5LM25ZBIV8Aqfvdnz20poD55XIh6Ko4QEHTSkpcuUBrj5FFiRuWs7kbrjqz?=
 =?us-ascii?Q?VP/wQbZVwVFF5ogDuYIOlmrpBf2XzOvhwsHswZICm5zQsD1zTfzYFIEw3PlE?=
 =?us-ascii?Q?ujNqb2DZLX5v7ZtszJ4pr6g3RlRTpuINbv6MjVD3u18tS6rm9f00YSh2Ymx7?=
 =?us-ascii?Q?6/x5KOXbg0EYLY9Fvep+GwcReTe5zyZmbRwm5Upwi+m83SK36+5Hk0DwkkWj?=
 =?us-ascii?Q?4SllmeSkieqdw2Fba9oN6GIoydj99mUbWBxs8hWCUklL3x/BSrw6AJK+CVNo?=
 =?us-ascii?Q?QmcuKCLpN2CbHI27QNR/3Uexcek6LEZNa4Wgn7IzqbSWv2phSIpiZIno+EdZ?=
 =?us-ascii?Q?blxi0+Rjp8nYPqLEbknZgKbFhHcLssa2z2CNKKEnVAm4A/ZI1kerOQk2VIvS?=
 =?us-ascii?Q?3bqTgd8jUfCXXnbkye/6aLc8OXzDkvE15b4bT0B0QpXDJI2tysHVseg12B8f?=
 =?us-ascii?Q?XAYe5lk1Ymx1F/nEiEy7GxwUpu2X2l6q7Ge9s7q/ZH7BTu0EVCjKity+lR8H?=
 =?us-ascii?Q?fE3L+XRNYwnKWUwEOHr6iAFnwn8uim0956WpMmT9Dje20SBkgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:34.5033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4772c3f9-5af4-436e-f3c8-08dceecc3d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

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
 include/linux/cxl/cxl.h   |   8 +++
 3 files changed, 152 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7e7761ff9fc4..3d5f40507df9 100644
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
+	cxlsd = &cxlrd->cxlsd;
+	cxld = &cxlsd->cxld;
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
+	guard(rwsem_read)(&cxl_region_rwsem);
+	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
+		dev_dbg(dev, "%s, host bridge does not match\n", __func__);
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
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       unsigned long flags,
+					       resource_size_t *max_avail_contig)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
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
index a7c242a19b62..2ea180f05acd 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -773,6 +773,9 @@ static inline void cxl_setup_parent_dport(struct device *host,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
+
+#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
+
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index bbbcf6574246..46381bbda5f4 100644
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
 	CXL_RES_DPA,
 	CXL_RES_RAM,
@@ -59,4 +63,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       unsigned long flags,
+					       resource_size_t *max);
 #endif
-- 
2.17.1


