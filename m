Return-Path: <netdev+bounces-178324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDC9A768D2
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5D916B220
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA8221550;
	Mon, 31 Mar 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fY2KJoUE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED302206B5;
	Mon, 31 Mar 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432397; cv=fail; b=f1/0TbWOwFPjncHP225UAVIerz35gA6VigGl5NtVfjwaT4GjUZrfgVIdZYUHcswXhDN0qzydjN/PQ8xPanCzcRv+p2GoEHEE+0yzmIHO3Hkz271SRdmefF6hmzzCWf6wijdtbf0LfqAWdpgNGhI/9UIToCm5hoKv14+zmFQ5c3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432397; c=relaxed/simple;
	bh=F5bO8YSJKHT2+Yd7aFUMQZ3hIv16mnNX8XYRtbivWSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWX0jeQU3/aUM4f7rbV7Y9LZmr7EM8yDgssc8/T/+VX68fd15GNGMcA1ZxyRQxsdxjncWUhnH/yPRvJqpoWCz74dwSVfJBpJ7Swyzn00RHRDZb43mv4BG1oLzNGGnOGCrgGwDiNBE8UhzbwEsBjLNCZ2/5DiJymExIHlKLfZV5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fY2KJoUE; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIjzW+NTraKtjW9ssbRW9ha8lDw/jddg4FWStbIuBnD6cKiOaj8vx0UVvGXOK8LXGfQOIG3MjVi9EevWWog/wk0ME3l/QMwr4QWF5OaCYUQFJ9JmTeh3qGyjULKtupNxqt9GgozjnAYudp3yUbfZ44fyT+Ih46nFByihAM+ouQ1R8vWNzHxN3EyR3OiSSvRiYH9x4+jdhwXCNMskMZHShvc5oQyhQEkP8E6ef9limfZLjIPJibEAx5szqMj7oQQOFUakkOqe40KIte445no9oMAhH+ogChqWfDGv+k44opXrOONd2V21W8ijAPtwYNlsTrjGIDoEG6QCGI0Qb++ZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBJx4p7xSNkv2YpXmTJswM5uHnHhCxDsWseKPFALnjA=;
 b=Iaesl2be/Bb/eV2zc84+uuCYn31y7gnvGBtp45zl/n3QP06Vy5XYlnRPT041p0m1sRI/nk5zaWPuZhO0pVwxxJomPWmmIu2I31G4MtWL7WJhEMFEagD/Z+tqspl7i5hFZxcKZPNFMGUnqz6ZKUayv8DGZWGuwocrgGlxjJkKO7yvs5p7D+cCR0V/JSb9TMl2JKGvVxEWllA9RTCJKjDh8u6+WYUwLMxGntVLFj45DWQ/rbsLmHyDsnb3t1qGcLw1IiThYYKm/nHHEHN+eJ2xWooMrDz+jeif5lPSLWNe65vCu0cUkYLVweMHHHzTH/0InHzCRDYGyQL9ewFgdEz/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBJx4p7xSNkv2YpXmTJswM5uHnHhCxDsWseKPFALnjA=;
 b=fY2KJoUEJv9UZmbV0yBGNvnAheAPqDd1PVXIpZoPxtTUzug50mJ057gTDU4XpgyDhnw2s6VT8oq2UdAPtUOHsAIdZ93etidlgX0sjuEMiHPAMi1e9lAZ/Gw581JVk4VZi1H/btQSYTi+jKYjM0vQGo9f+Qsym27jMWmziyX8SLI=
Received: from PH8P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::11)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:29 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::6b) by PH8P222CA0030.outlook.office365.com
 (2603:10b6:510:2d7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.36 via Frontend Transport; Mon,
 31 Mar 2025 14:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:26 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:25 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v12 11/23] cxl: define a driver interface for HPA free space enumeration
Date: Mon, 31 Mar 2025 15:45:43 +0100
Message-ID: <20250331144555.1947819-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: cba10f01-e595-477a-7156-08dd7062d22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vl30lVMfpdnihQ67VGVoLfrqjvl04aOXRoRLnfQLGhqjMDqml+zZhlbuCmkB?=
 =?us-ascii?Q?kR1S1Obr+DZm7+qVOSWKegWg1UQ69bQOIBko+btKLXeavRbUFvr7wr4goQIe?=
 =?us-ascii?Q?xZOG6wYAIqL+Zys88e68jfEY0JJka2680xIVx1dTL2NET9rQVRMYEvYutLot?=
 =?us-ascii?Q?/bWbXNaIpyAI2590A+cNCRqgoBC+GlRYOfcJN2cHMomDjv85R5vARCDby4kx?=
 =?us-ascii?Q?/VF2cibJnUZ6tUiaz4DC8WFNiZo8vzIlXTK7nrLVqlDtmASm4A+inVsn1i+x?=
 =?us-ascii?Q?HKpfBgBPik1moob5BuK3fQ0CFRSBMdB0lv77k6YiQ32czTYlWpUDH4t8VqpW?=
 =?us-ascii?Q?lparVDM+gzt7cf2wVSpA+0wEb6JVgju/3dxscpQYHwxpH9bq77SKY8LN5iXB?=
 =?us-ascii?Q?hwuH91rwj6scAPjtHVnBK60UkFq87XG9Dhnf3q7Uj3ZFoeV5f+fFRRapPueu?=
 =?us-ascii?Q?b5F2c5eM5L9wdHDisYn9TcmHtFk6mJzrIz8g1ya6cKSrWc76RoQxAhEm+fq1?=
 =?us-ascii?Q?CDS8I9q4QqX5BfjTaoI7y2Ky0LY5cjtnGysb+DJM2Ycj3WE41DcFAzvluvDb?=
 =?us-ascii?Q?sdI7x0ZyDE6IZYJC3UzKfPxk6hhUF6xMl97elSzBXj/0iF6CtwErxB0+STcV?=
 =?us-ascii?Q?5rmJH53MMjYmStJF+B6KbA9o5p/jkHxBdDAZM4P2BaI4QPP0q4pUulvKltPM?=
 =?us-ascii?Q?BdQ+47LUyqOaQlNDcND0pDzVBlgsjX/9Lc4NjKPQHLE435pgkh0tE6G5kdaQ?=
 =?us-ascii?Q?NQsmNd5s2CPEKzx7KF7hhAonMJpsWcriyhqiAFiyWwJ8MJQ35wIPyYX5G7pB?=
 =?us-ascii?Q?MQ+fMAUIuwrQtctB0xwAOCjVf9M0l73k20OW9SBT4I2cK7J2bdecCIRS7qAr?=
 =?us-ascii?Q?6Kl6c8SS++t19S5JnIHuOO0y3Yvn4h755v0UrGyE92UFj0+U2URTTEq4iE0l?=
 =?us-ascii?Q?mmL4nxTdhaB4urRW2rGnRryj5M+Sb4Cxj5NTFzS6tBCS2p0a9x3otyjBDGuI?=
 =?us-ascii?Q?+uGKsx8VFQsSGcEtWqAARdadugQJszpR7CRq1BQsOFn+Epd696yw6oZsaxl0?=
 =?us-ascii?Q?PlRoy3tTPWvONTOTmDUWn66C9vKzCI5r0BSXelwiCPoP6gQm2/G1kU4YbK7x?=
 =?us-ascii?Q?V+3m9qWr6JQAFAcHDS4hZdAybNfRvnjaJj1zChJkJ8bjbtSbgNMmuEVTru9z?=
 =?us-ascii?Q?fH2My3UYsTyUJL7+Hw4RsHmAVu2JDfKMZzkgSTt7BRVhWhpjiB82QzgT1yoU?=
 =?us-ascii?Q?jwmk2kMDQmaghjAruioxHgmQrRS0IWYFLLo+sCJRcFoSNVgOwm87HILGbjAx?=
 =?us-ascii?Q?JQvuocKhs6/eJfPljR5MvvzZqhKSui/LpofQXxJKVkPi4yLrPKn+FBvLr95N?=
 =?us-ascii?Q?s+mcYiCk5o/iH9elwlmfcq6cG9XuyPF8gXFki/Rinsfhrw21swXSz6/I1C3S?=
 =?us-ascii?Q?FQdSf89nzynyP363VPod+yerxa5j6y/2sTM4h/8HZhvBO4nAZ83Q6UjKxcWb?=
 =?us-ascii?Q?pFcGaraifEiM/Rk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:29.1283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba10f01-e595-477a-7156-08dd7062d22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

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
 drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |  11 ++-
 3 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..59fb51ff8922 100644
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
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 3686a9532d55..a098b4e26980 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -25,6 +25,9 @@ enum cxl_devtype {
 
 struct device;
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
 
 /* Capabilities as defined for:
  *
@@ -246,5 +249,11 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 		      u64 persistent_bytes);
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlmds);
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


