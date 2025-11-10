Return-Path: <netdev+bounces-237245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0971C47A25
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80587420F1D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D331961F;
	Mon, 10 Nov 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yoouVnFG"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2E26ED3D;
	Mon, 10 Nov 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789068; cv=fail; b=izmxmXkf1OaBXOQ5VeSeiKFiRT+DZ3i9q1rxaR8MjTMgpULxiWLGbUyQltIZWy4Bc+Mp0ZYjIB/boyaJES4a3d1fTI32GXtwXFj+ZmzbKqWkB5JO8V17jrRjivosJCwG21Hn/3zeG9V4FfbufBGIETcPoXFETtvJiMA7QrB/rew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789068; c=relaxed/simple;
	bh=QaLI6k4+swlhlQ25G3lclJaEGUcoIqr58u3DBO0kv9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzE1MjlWaMOJD1HdObesKgRnP4L2++nD9Cg0zO6zZFsy0NhppciY5qB08Fo4TDdM3FHEzCCGmSv9BqiWniMuNTkaERLDe7tDqGmHB7r7ryy5t23ZuteXhmOTC6N1/rHZfrJRT2erMxyDO9URK5A5oJ4CN7s2CsiD8PCrN3E5YB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yoouVnFG; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqve8+LhYkMZtfgC+toXTuGzSuKUZr1WColCxNjTtQGUKsTaHDfL16vtdFUneiMf90TwkpQBX83mxTmhuzS7l7EwMFPcBZJiyZWJK3MvnRIU/RArg9A87KG5x6aTEa0vfY853b8UqPGbcwxFCC12NN1BA4krcMIeRNJochbO+LIYozxzww2eleAU3O8FP8w3YaTXr6OjkXqlsH5Q/kV9N9hNT4FejtsP726aLAwuedPt4Hcg6nmr78wRMsQGEJJOOeB+VboUVd59ctfFnKj9mIJyx4JA0CyPylFIgQJeiMou4WkQbMeQb4ibvggKGLSJ9WtE1Izl8J7YEle8KzCzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmO2aAQeMgXH45iKfHRBVLwcJaWG3iRiuTCcdvJyiiA=;
 b=IdNO0GOxmO9fzFPlUD1mPS8TSvOu1NQkl4iCF8m7T4TJcWjg5LOqWczBAUJp4gzwIY4HBbuN4OwoXQsNNZFmsV4vitvg6ILRLqLe1MO71zGrbgkZa7RARyHMuXET5L1+R2Zmk7YKeVMJiPPae4310b9aq+SEmAS2J0Xdo1FUgxO0y9p1jROpZ5ecxep0KSn4/OEOu1x+36UfIxG4bmEMhj2Qcjg3GnpOB7ymxGTnCNJonU1eyHfJ4ZNZaDMfGWqARpX6f6srVEoYhanR5TWJfHRESZuxlza9qrWEZ8Eu4GLYMPjWjq3RGWq41krwra8bd773oAXp90aVVo3+OTbueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmO2aAQeMgXH45iKfHRBVLwcJaWG3iRiuTCcdvJyiiA=;
 b=yoouVnFGwJAGslvgc2GYS5zode+LO1mulQ4hqDL//VvD8cjdlXRcD7Lj69jy0Kq6V8EAGA/mh5iodig1XAjOE0+NqidosoH72WZH93Ge8p1P75RD7Y6vKakydN8bdtcfNrI1CfpxkCizZ3vNktNzGLgSnRDAQfCG4Du4AnOooNs=
Received: from PH8P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::6)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:39 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::2a) by PH8P220CA0002.outlook.office365.com
 (2603:10b6:510:345::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:22 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:21 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v20 11/22] cxl: Define a driver interface for HPA free space enumeration
Date: Mon, 10 Nov 2025 15:36:46 +0000
Message-ID: <20251110153657.2706192-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 975382da-9afd-4b11-22ad-08de206f1429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1k6nBaA08P63VRlwvKaS2sUpsxcdwpqdhMCldx7908igz+2sr8K6cfyGtP9?=
 =?us-ascii?Q?1+ubFPgfP3NvmkQe4wlGy4W8p5eYQstFcp+PMl+EOrzraMU58WWhzmZyczM5?=
 =?us-ascii?Q?gNI57Ibqvubb6rOlSpoSV/8akPWR8E2VoljZ73PNuoBi7m8bTwZO1Ce5JyU3?=
 =?us-ascii?Q?PH7oxX3DCCCrbuqCTA8kgJwPR0mq9Nyrc2NMTiALsBWqZDifbaHTMitecVJ+?=
 =?us-ascii?Q?kvUhJMWXGHvOJ+C614FjZIaV94sTzSVKtp4oUnof42bTzsjjOiTAzJPEDbeN?=
 =?us-ascii?Q?ceR+BfW+RV52cRiLGtO7/Qh8KAhlJngHoB0IiGsTAGqdVFAf9wzZ6N6xygDq?=
 =?us-ascii?Q?CsrWXFskJpHiVXOGEI62FE0g3IlfaY4D+zz2o3n6SRhypEKHKdPu1ppZAja9?=
 =?us-ascii?Q?CywbV/xIriDyr9vtWyHOXyMG2vwhTkIVLsSBnx9g1BfZlITo0k/tkLQWtdhL?=
 =?us-ascii?Q?kL5nEZhDke1v8OxzQhD76CZNu28RVs2QE1dzWuVs5RZZlNy7caoxGvJXS0oX?=
 =?us-ascii?Q?jzc11PL8Phqk+JTwEQU/spUdoFicV5cJcE+UPl7of0ntZp2JMKqmeGHK5mQ+?=
 =?us-ascii?Q?6/Jw2l000l573bVOYhuWc4aNwDIIdgUqB9/MHYaz6P1f31G0zh+N3DKmicNe?=
 =?us-ascii?Q?Eb5vrBsxLZyNIdwXFRMA0kIK7hG8/Ab/E81e904nucrWsSu2VUAfkD3F+I0I?=
 =?us-ascii?Q?Z/yLTUg62R5LK69yTwajyQFe2APXkUEkdCOVIDyOoWk6SR3FOmcni8S886EF?=
 =?us-ascii?Q?uXk7abqbORmixTffsQnPe64gHQrvo06iNwcXyNjWFdK54BMuOkkERM5kILde?=
 =?us-ascii?Q?Bnekwi+omwRXiZWNdnDNm8iF+F1jkfAmaU6oMdQudIa2P5RdDS+w/H3A5aQF?=
 =?us-ascii?Q?XNiCEyxqM1lzpdL+FcrYSHFnG3ZTBxdFZAQqC732ATlb48+chkC78+rTTOZd?=
 =?us-ascii?Q?4FyNl8VLeawKwflcGGRqAR1ibAdykKFTMCP6Imh+PsD/cWA4r/JZvoEDZzLw?=
 =?us-ascii?Q?3y3CCY2hB3WeyryxiJmwHadZYp90sxkzFQGkkine2MmrqzayEqc5XB7ZTEIa?=
 =?us-ascii?Q?VzRWY21VR33cF11xUjMNlLhL1twGw7wZJFVcN3a0qvEmm+RiAxkzBjvm//Aq?=
 =?us-ascii?Q?ApYAv5KadbaElIV6P1pAgcX2nEvRZeuRuA5BKcVzZbn+oN3RxjVErAkEvOh7?=
 =?us-ascii?Q?dNMiD2y+MYm/+WMK2tRaUXOtX+7+75TdvwGrlEp6vAJ2ncrHUEyKgo45K9SY?=
 =?us-ascii?Q?NoTCkNkwTz9b9nfCZyWYp5CCskDske2i92MgIpGq/bnIHzGz6bg+k0cb0fSJ?=
 =?us-ascii?Q?dQNUPReAaqr3K9u2Mawb+UEn4/iLJcc8TSUzYyqd8/NJNO0a5H+fNEDKkK66?=
 =?us-ascii?Q?CDhnxdUFV2ekdpLyOKOwmx474pxOsMSIz0jJTexEZmt5Bqqmzg3eXzUUaTB6?=
 =?us-ascii?Q?KIgK/vBwy3XKprdTbAQA9a3dJ8BkLUPMvM3wkBck2t1jeEefIkwbYho8a9Zf?=
 =?us-ascii?Q?2P38jneUDRcPFln2ZwOp3n6U+qDacLJZ3qQ2J7LYsR8snByJf0NB8Nk1odjp?=
 =?us-ascii?Q?TFTYmWPg2O45yBC9Kzg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:38.4227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 975382da-9afd-4b11-22ad-08de206f1429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

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
 drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   6 ++
 3 files changed, 173 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..99e47d261c9f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -711,6 +711,170 @@ static int free_hpa(struct cxl_region *cxlr)
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


