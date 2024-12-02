Return-Path: <netdev+bounces-148173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA3B9E0998
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C3A162FB1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BE1DE4DA;
	Mon,  2 Dec 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N6YY/zhs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835221D8DFE;
	Mon,  2 Dec 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159589; cv=fail; b=uzk/dVvmfBCK78zB8KoZX/c/0jjulyyx+itpGfMujR1oWuR3UeM9s/bFNQKChDyqAC3bOjPZEf19fIOuHiL1tjZX5/GeGVcCbO/ONNHzuRGc8/1a1wPwaN/l/RXiS92mmJbHVg60qjVwq29OcydV1U1KDe94heu2SH/5BHCtJYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159589; c=relaxed/simple;
	bh=m8RCPQZ+25SocBXuR321P6iK2gZLhhJSiOL8iRPnGuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bq0acmQAG2/i/uvQSlmwIqT4++VS+WUAvtaY5alYGwZ4Ik/xE0jy0zdq8aze5ArRZwm4rX7uBxlGDscIBTahKWbxBSLoZLWNk+HdaBBfTCa6zlbchqqJ0AT93lqiF17vbAAB1/VkAaOWmGXdbBrXsB1P8Fd4+GNnx9gSEvGqDQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N6YY/zhs; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSnaz0SAtxE1uWx1tc3jwwsc0B2ihdnJIraSt9S0fj74/Tls3mB0EVYQJAJv39eq6SsfhPPDF2hG/hscRVe4wOPzLARZ+A95bVKp7pi5RkaLUC105ZCniL4vXPYfzaZlJ48VCq6QJRl00vopXJgL8MfLKqWmuLUyMFK6X/N2XXmrGYDNdulFYQFuA/1XHDJ6Qga5i0pyADm0X8JBkHluNyemnOYOf/+ei2iFaDDObd2bF++GsOPnTG5K++blTK/LXWq45zXmCLGZ/Me8e/FGXRmfpPt761x+JL4+leAn6+q6iNkfj3jGXC31nq4+9biAs1rtoADe/DEOgK4TcUBOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuIbdfRvrk2HoiIPc6mN6YkzFGYfGHm4csrTwH5bpLs=;
 b=C0KcBOi/Eckiv8QT0onKlv+sOe3uSf5jGx5qVStfnDAEvPCeIn/g8DwyP2dIF+TxJVvaFuWRmVCPnFWzncoDydQ/M1CH9130OgBmT+tL1MgYjNMVfSdtMFi3WJSXCNwao3Bjsf4IWXoBwVstNx2aL83HJZK707+cb8E3HWg9S1Cq/SaqXipUo7rpn2xj8A11sz0zAFz0PWapTLh2Q5mIZux4YZWF1VWdA+t8j+M1UGzheyg/jUgcoV3wJ57YQdxsjRWX5md7TWWdp8xYJEGaUVIOIex8YyPgaFPgj5fTyyVM3yhecymItk5BGGKP0MciXXf+mI1brNxGdgnD5sT2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuIbdfRvrk2HoiIPc6mN6YkzFGYfGHm4csrTwH5bpLs=;
 b=N6YY/zhspPYER7IewEwajKhIaEnXrE45xsBNNxwa4Ka88txmuqFYpzCpeH448KzgNq3O9aRNcWTEpMj33KmwLolQasAv5+OaQJFgfd0dzYsBH18G6C/02iZ1OE7KiQyofPDJT1X5qB+B5L+gQsX0GEIRHLrr0xn/QVINX9wuXDg=
Received: from BN9PR03CA0524.namprd03.prod.outlook.com (2603:10b6:408:131::19)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:13:01 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::a3) by BN9PR03CA0524.outlook.office365.com
 (2603:10b6:408:131::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:55 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:53 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 15/28] cxl: define a driver interface for HPA free space enumeration
Date: Mon, 2 Dec 2024 17:12:09 +0000
Message-ID: <20241202171222.62595-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: caf3488b-66e6-4ec6-a027-08dd12f493a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aA2jfcjeOwphHTYpUNLZulBZ5TRgUS+T93ZoF28TUEnDc0EQ9s5xAepSDY62?=
 =?us-ascii?Q?ejI7OZHrjFYOVFrL9pH+y5gpTuGNC89RU9vLUyaxwyXmTwC5YlCqH9OMsDfz?=
 =?us-ascii?Q?6NK2M7ryW5g4oqQGYm/QIhpg/8n6e5BEEhY18SJsMd2gBLfz3uTCIz3CY7CX?=
 =?us-ascii?Q?oglkw4nkxe811mem+OsaRlF+QLID87a3NFaK8qfq0seXp+Ozc9BpzOsXGp4F?=
 =?us-ascii?Q?nvo3DS7p3dZ1TQbi+gmxMVFU6a+ejdalq02MivdggSt2HOnMQFqRqVQE8YRp?=
 =?us-ascii?Q?aD0IFdIZr80UJi2unJhShjY5DdNvgD2TNwU737PrNBReKCIZT9wm5WpkaxOC?=
 =?us-ascii?Q?8AtH4xMJqJoJZApLYuNGma9NddtFLrKir/ohg7bcupCKmYKHQOYwxffnUClN?=
 =?us-ascii?Q?RTvgdmcvU7CI0wkf0Eq93GO/sMpSjg+X1KyWGig+j3gq3QCVW96lm3khmaLs?=
 =?us-ascii?Q?JuZOKR8LP2xC4tsXwJb/xpBvsF6k8Gi+Yp+svNpDHWal/cKN5Ipci6/0eyRA?=
 =?us-ascii?Q?N4aNJUt84SbxkxaISyuBhBcvNvZojk8SWUfw2rWBSSoZMhJIx8Mp3i8wtuBt?=
 =?us-ascii?Q?Z9pEUK9Aa+KBTsJMpMcBaVqGzXgrwMmxqOkgEAHCjalcZfH+f++eVFknavJN?=
 =?us-ascii?Q?VnckCx5qwxJ0krJEXpUmXfAvGYLNTJw50h0J/2pyTu4T0blnx5pEyLEqTM9z?=
 =?us-ascii?Q?/0lLPBhxYFnr5vjGS3RVKHv/4Y5Cm803m+qDpPCo9Oz+jZEH6u5NStpwTd0x?=
 =?us-ascii?Q?hi4arSxJ6UXS04WaGJsYU8LjrqJw0EZwoahS2ksto9GLKxb287hDR27vTyFm?=
 =?us-ascii?Q?y03kkmK+H+sLNtfV1nKhe1rwtZN61khoWyqae2kqosLyzB/2JWBSH48DJz9O?=
 =?us-ascii?Q?eLfuuAYI3OlTStuaKoQNzVNn9jzGPomwuFLfXBHXralm6h548YXVyi5UpvQq?=
 =?us-ascii?Q?zW/SDjslJw6zQUjNlAp7MeHQOHK+vUWeRtxssdfGgVGwxVZXwH0CPR2I0bTF?=
 =?us-ascii?Q?htNcj9dyYZwdxXJntJhgINmGnS4MqGsqoBYJE8+5mlqfJsQz0PAQhW86viS3?=
 =?us-ascii?Q?K7/o5ddu48I0vDYYTQK5r+08EjL5epZ9KP26vZc4neh0Hncbr+7rBMtqDnyv?=
 =?us-ascii?Q?1bVYZ3E/GsVXHVGsXsWfSAsVoRZRJ0bPoBsetsFSBc9rYMsX510p8zKqGKwN?=
 =?us-ascii?Q?W0v0hkE5I2QI43PYyZ312P1bXjVGWX7qDhcnf2xh9TakMoe0U8ob5JwMsJaM?=
 =?us-ascii?Q?TrS0UUkmp8gx3TssvW5GPsUUlA2gxq25KOj5twwo7jXC0Iq4ct7a7SD/VJZP?=
 =?us-ascii?Q?86ulSGDONdDXimLW/ybLunByWJV+eZjeK9E1AEJP0nMk7/ixHljGX9G3Y0/c?=
 =?us-ascii?Q?l/faP7EHqYMWTtIiN3iU5vDCax2OF7H4hLq1x9YGLvZ5NnbNz+QeQ6DuET+U?=
 =?us-ascii?Q?eLh0OtsihdubSvk+Qr8tJpGoDrmP2/9+nuzXGt7CWnQKxoE+sH98JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:01.4409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf3488b-66e6-4ec6-a027-08dd12f493a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

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
 drivers/cxl/core/region.c | 145 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   8 +++
 3 files changed, 156 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2a34393e216d..2ddc56c07973 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -687,6 +687,151 @@ static int free_hpa(struct cxl_region *cxlr)
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
+	/*
+	 * The CXL specs do not forbid an accelerator being part of an
+	 * interleaved HPA range, but it is unlikely and because it helps
+	 * simplifying the code, we assume this being the case by now.
+	 */
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
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
+ * in (@max_avail_contig))' is a point in time snapshot. If by the time the
+ * caller goes to use this root decoder's capacity the capacity is reduced then
+ * caller needs to loop and retry.
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
index 22e787748d79..57d6dda3fb4a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -785,6 +785,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
+
+#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
+
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 26d7735b5f31..eacd5e5e6fe8 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,10 @@
 #include <linux/ioport.h>
 #include <linux/pci.h>
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+
 enum cxl_resource {
 	CXL_RES_DPA,
 	CXL_RES_RAM,
@@ -47,4 +51,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
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


