Return-Path: <netdev+bounces-145951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED2D9D15A0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812812816A9
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8D1C304A;
	Mon, 18 Nov 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ow3KCoLi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2A1AA1FF;
	Mon, 18 Nov 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948312; cv=fail; b=Pvpeucaqnu/6pcnkR0rKZkRw7s/9sDedn58rOP61UR8Opm2xbz5pCSikuqOG0x3Hhid8GqBG+7ngMpbz/ExVjb2zajjgD0vLex5ByhT8N4PFO7e8U/sQBInbWpHM3GwAo+sW2G942fUIwCW2xc0fVjaqBQ7tqGnR0Z/oSeXzdl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948312; c=relaxed/simple;
	bh=UlWIalgg65iIEn2D/5F+OH87TeYedvng4SsufzY56Dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5Vge85hWmzARbv1MMvkdjVPP/HhyM723Znb2PyLB7f/GvAt339WVBs9F85aEndndIjwNRKj5pZ6Kemp2MuRDn2VI6H6fZd8tauKuMBxBGCzeXAA7TFWLsalfodYM/CxrkyRYN7XseRXuBGkmuFXksVIOAA7DWcx3VzoCJC4NKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ow3KCoLi; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVN4kkejly5nmk2Pq1+Za7uH8TyQU6jR2TaYtx2FNiZCyF/6SkCu/70QLdTVQJhxsdJlLpSTbup1ef46JvTiv57MaecAs05VVDG+aNAm8MuNEeX3WGhAYHICgn0gIXoPU9XJUnnWxNpLWDfTz68QfarooIRwQgg5KPK2uTAZvnOg9rMmKTTQ0CUU7HzUg6VNp9P4UZwsUBn8r20CPAD07mUvtAc6DvmRE6FHBM6MwN040t1tf/0YPg5q2l2+ZSBTgifD0iew0d17ji2TTgifGbGILyAzuSchPE6qNOc2BJhEALDRju+aQqkkPhUF0vbM9jmsN7RXBz4feYlbQ7KVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZmlWyY60fGyVxcfHHIouUQ8d0SdqUhrYmlcClg91zI=;
 b=zPWnqKEp7vBsZGfbeg4Grd0n1EAOu5EoO0XgqLk4AIbSutNtC4dLnLmI2Xv51inJtkWMMKrEgntWuCs+iD57fl5bpYNtCIwXmYuIoPRY4/aOUoqWjkUBkZY+BKNwF8Mu5FVhvRTq6Bchj1981F33IlJMYPzzfyQZHPeLXaG4REmcMU53sf57K5nFLI5g4Rkreo+/QgbCMJFQpwO4grVbBfkJJOx5H7TcxMGIwjBcy8dYfP8lIJXOC7Vc0NqCMX4UXTDAW6qCxeFG9AZbIG8B3GQCh0NNicjBT0bEVg5LHqD+DxRUnOvF/HlqdCqkHD+e54TKuvx7urJvYCyJnkecFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZmlWyY60fGyVxcfHHIouUQ8d0SdqUhrYmlcClg91zI=;
 b=Ow3KCoLiUt/LOhshQTLANLdNqd0aeulouZjaEyVbLVHURaotYE0NDKJZ3zcH9ecofH6mrYK7hvYHV8QLn6kw4pLcKOrgqghMdIQgBTzeoZ0IOHJepXmyl22ZZTl/9+jOf+l89HAEWNh3N4FLopH0i3KgkUUu4d0sbfuIfTaUzkQ=
Received: from DM5PR07CA0120.namprd07.prod.outlook.com (2603:10b6:4:ae::49) by
 CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Mon, 18 Nov 2024 16:45:07 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::55) by DM5PR07CA0120.outlook.office365.com
 (2603:10b6:4:ae::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:05 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:03 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 15/27] cxl: define a driver interface for HPA free space enumeration
Date: Mon, 18 Nov 2024 16:44:22 +0000
Message-ID: <20241118164434.7551-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 03df19cd-cb30-45da-2b07-08dd07f05c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YoxLGH4cXgZIdSORmCOiGYCDyMsfJOwWr0C09rKquuyNefJEHTyqKQTwI6LT?=
 =?us-ascii?Q?ODUTgz+/jN21UMozQQxjfqf+nOiYu+Na6ouXNm3uYfG6dczv/pIwUyHa2RZA?=
 =?us-ascii?Q?3ZiWuX/O095FmAESErzTqbyTdyXT6QKykBwMh/xSvi3GH5Uql0Li4uBet+r7?=
 =?us-ascii?Q?ZnDRNIbjvrx/2GMlgDsa3u5MYQ6ZPDvVhjDoDX0UyJHIqNSUwZcyKZ7woMrL?=
 =?us-ascii?Q?l2hmTZqfJYbN5BTcHjTQv9fI8BtTAS4U+/xZDpqxlXCmdQEtTyuZNORHk1TD?=
 =?us-ascii?Q?1lukojea6U0bEGAi2Yh6rvqV8JcjzERYBcVvvXYXZkyvtcUD1iv6Z58OeKk9?=
 =?us-ascii?Q?PpbuL3uEuqdRH3qhF8m6gz7pD9oD/GabgIObQuQCG15WwL/5nve2hOIcGiaa?=
 =?us-ascii?Q?F9VbF2mkcbgiWr9iK4fDpFzL/YYxp/uCqdEh1nIe4crwxKB+1c2jaDDfAWQe?=
 =?us-ascii?Q?62cxJ77MlG2H3v7Z6736CsEsbiM3Zhioe5zNGKVAGMdxK/lVE+aIIJJTQgGG?=
 =?us-ascii?Q?D2GPnu5/q9wLKFPotqOTKGWOl0LnbYdxOMvZQcP+p1Ty+aYqUJ+IoIjqeFrc?=
 =?us-ascii?Q?W9zhNWOj4OXWhl1094x1JylA5Nd0VXb6mvkQQvC0x1f0cfOjORb7URl3kbR/?=
 =?us-ascii?Q?pqoZ+frQjXmyzguFmKoB+OcWnu31U2OTWy1fUSsFg+p35CJtB/CeyZCZTaj3?=
 =?us-ascii?Q?l4kCa7oJ0OWdmgcq50xBSa4AqFKXd8s6SrttIPoACj2TbWeZRSLECKC0Xopx?=
 =?us-ascii?Q?4ZtNeVspYZbs7e4WoCKl5IzwRcNSJKPqnAxvrQkthrIiTG07EMgudkU+8cnA?=
 =?us-ascii?Q?Vo5scX2rinG2ExVzVXQHbhWu8ABna4w3KVdq0AmUDQzncTHp/9xVoPLiqtDl?=
 =?us-ascii?Q?7iJq6XXG2jAQWTmO2rRwqfs2Xee/hl+jkEskvK6Qu36SSFxTuga21GhH1wW/?=
 =?us-ascii?Q?vRh/Rvp75cD7FHOkI4KJYnOrR9DB9BclwjwfayxnKAdw+WoT7XO3R0y31kvI?=
 =?us-ascii?Q?HS56uLfUZqM/AzZ2NWT2QYU3lr3IKK9YxhXyrUzaX7/GF5S2PkX3PkOd7+SB?=
 =?us-ascii?Q?afmkdGNS7rNCJ0M653CyKXshChYz5A4cbFcRYXfwuQSrvGMxF+hISovoqxhl?=
 =?us-ascii?Q?PsyaQxPJTlj0nHJH++9jVJ/CbFMJu7TDo3FQY3N1ejimEKhxGgDeKltLRLTi?=
 =?us-ascii?Q?QAacgF5QM4HVJSW/N0u0UajcAm8IH58JSb/3mRZEOdAFtu74K+91iSPO3K7p?=
 =?us-ascii?Q?TEOXGvYZUYIOsWARhBPu0A2kkc3AgN+XlUtOVNJN6HWSeRprNgHASbW93xUw?=
 =?us-ascii?Q?HNpXHqAOg1s6/1SNyKaO2uKwaxvvIIp6fN65uHuO/lmqSQgV4bIQcqb9eD9/?=
 =?us-ascii?Q?lH1qQOxOEQ2jjgUJIf5etnMlM2rOpkvet5I1oBEWzEzr60LpXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:07.5641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03df19cd-cb30-45da-2b07-08dd07f05c2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457

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
 include/cxl/cxl.h         |   8 +++
 3 files changed, 152 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 622e3bb2e04b..d107cc1b4350 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -687,6 +687,147 @@ static int free_hpa(struct cxl_region *cxlr)
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
index e5f918be6fe4..1e0e797b9303 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -776,6 +776,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
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
index 5608ed0f5f15..4508b5c186e8 100644
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


