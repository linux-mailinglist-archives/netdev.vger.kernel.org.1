Return-Path: <netdev+bounces-152293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326C9F3590
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1AD1887582
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8D20764B;
	Mon, 16 Dec 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rif3eFr0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0E148FF0;
	Mon, 16 Dec 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365481; cv=fail; b=JsAetF3QwUOsPEvxW+Pbip9fa7HOZgZHw7wP/FtrqtZif6+2MHN5gsc6KV+DN/+SV9c58bMWsl3xQIdpm47vmvLmv5+P8/L7RDdIpf86486Ens6RsB9ROnQTVLDJisLQEnzvUDHkJgOLkn3FqednRyro/pwiKcoVDvnKsFQmCek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365481; c=relaxed/simple;
	bh=48rBvXVUzmUNr8j1KQwaILdb1gHu6QFwKBg8Esm1J/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsSfKIIaSGPsh9aZYaLZREt/93tedkRWkwnHZGWbGgNImDe9olgzon1BjEF9f/rttytUooEj+fj7++PwEOep9Wz8vNFny/7GRO4AjrZNVOzoAmLpKUXD3XhkktjvCqqCKDJ1OR6nAuswLDuu/fNFYp6qvHpmb3gQHFIUHcsrWwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rif3eFr0; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqrAKIwO2SnjKcKbcmT+4ZEILtG8MwNMu4eQNKMxUbI1ImpUot0COX5V9Otc43BjxXDLzmxCBnaxa7TtE0jTKxMpqaSSD+3P3L4hy99MW+/SibVA5HS46rY9SGmCckf0koMoWTsKbl+4mVidPQOSDODvaC+/Sg4Pemcq4IrirOlWyVxIco62bY7cIxP6EG7onZ+kovEml3Y6MFtizKokGijicCtWBcyPOLfc78FaCBU5b8OscFeRka0XSKMb3T9Dp6YTg0E21DnWLclDPctacMknFXrhOMafjFfOxBcSEdnUdIgjM9LvMHwVLhUhK7EOLEfig4gzMfCBNoLqU0e4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA40pLtY/VnUH09aWOO/VBtnONua6ZlCV/KwE9dB3xo=;
 b=F3NlUAOeYpibrSdLQ5THAtbhHf+vVPUyrOOJsBwShGKUSEXgVcTAQRoKnRdOGTsTj6I9inBgzdW5fzDeqh3z/J2jVnICrYNdVfwRe0/wDZOa0kTGPomxWmVNYy75DcjqN3+y1lLjB8Tk+9sLzTJML3SSg9qF4igB5Z4hACu7KbKxzKafJIHAglgxOqGkld451Iykgr8e7lcA+yd3ONDRM55ZvphyhDXjCQkYft44p1no6hEmmuy9Por5ULrpFCvo/VBVymvQIoeiuGgkQ/99V5NzS+oIN058XHYtWndzjZhGQePe0dJH1SsPVXQWj5KTLQqmX1fe42fXBQOydEqAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA40pLtY/VnUH09aWOO/VBtnONua6ZlCV/KwE9dB3xo=;
 b=Rif3eFr0C1kedP8FbgZvHBtU5gy/D6QFkGHxPo0IbHMPEAS7KP8p8Bn07AP1Bwf9ok3A0GILRwjOs+oBTfIEHBDC2xmxdTCdpBnIKe9yfLi6NHnX6xd+HmGmMM0/WWeYyuF5QHfHI/CoyfbZzDwXCcgbKzDDa2GjocNN3bHbmWw=
Received: from CH0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:610:77::25)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 16:11:14 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::2) by CH0PR04CA0050.outlook.office365.com
 (2603:10b6:610:77::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Mon,
 16 Dec 2024 16:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:13 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:12 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 15/27] cxl: define a driver interface for HPA free space enumeration
Date: Mon, 16 Dec 2024 16:10:30 +0000
Message-ID: <20241216161042.42108-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: e32aaf6d-5e41-454a-578e-08dd1dec43e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yN5LyQmfCTbvNO1RsBYoEZkWhTvEQvODlwR84hU8DykN5Gl7qxyU8MUbpn9w?=
 =?us-ascii?Q?g2Kl86jUrlXbtNpzGDC0cHfjlAo8aHx4cqYxD4Gqv44AhInzk+iRBOOdsKyl?=
 =?us-ascii?Q?T6g9+kmirLSa4KY57hu0Ht692bAY9XU7+BA6MzijivhYU+CLSps7roJrGIcC?=
 =?us-ascii?Q?v1M6QOtIke7/FPYhNm8leOTYiA7aUYjThlUvuyI817Pzm1zmLPi/dCXSFecl?=
 =?us-ascii?Q?OCTWblsB/61+X1wFwshzU9yHX+9BPYWDeXLuFZIT6PjOGawIvRxrQv719ael?=
 =?us-ascii?Q?dRoA4F/ipJzWaiXmz2fom70tV9udvjQBz8Z/gj0oSPJy48BqNwkQlssZSDS5?=
 =?us-ascii?Q?fMI1kTcHjEypPP9vXLLW6aXX0Dar/S7thc8dKEpBDPVC3rdNkA8y9TVgPWe7?=
 =?us-ascii?Q?LqrqjuYHSJ4HjHWm+dljU8JQ2UXbuhoXqlV/iL55dAV+e/lYVIf+GLbUsii/?=
 =?us-ascii?Q?si3cBci/veWMQqjtMXDjRgHPqBfJXzPuAAwikXt6We/f+Iak2Z5FxRvo86zt?=
 =?us-ascii?Q?FmkTp2OY65at6UnsxNiNOCI4dBUMkeQlIY9cTLHZfvgSIOUGBg6jNuLJBTI0?=
 =?us-ascii?Q?7RGdMZDxp42DzBuVU9nhr9BcwLwh63YvRCUDcohjzdnqWSbizgqgZXnKA3wx?=
 =?us-ascii?Q?Kp2Pg09jAvTjyVlpIkNCx6Ztl4uXPR864T2/oPzhk5W2oSr955kWheLnZlXT?=
 =?us-ascii?Q?n8FHPlde3tGQMSw5r9ismAkDpbibSOyEyd+hSpI03JCvW+7i7gIiYK7wY/fY?=
 =?us-ascii?Q?sQBgieN/rK1bB2o4Tv4Oi9AlpZH9vkMiswuLktYAE/QR7qigMHmKficKW2Eo?=
 =?us-ascii?Q?adOY4ksASlTE2+nDJeWcA6CoHhRQ5SLsCitm4R8Z85w7627s/+G3ANdtNXJA?=
 =?us-ascii?Q?LmQVQlBhz23QD6oToRU/DI6roCgjAMsig3wkjyaVc3T5njLu/axK9BgQRJpb?=
 =?us-ascii?Q?kB8lpRLAfTRvOYf2jxckXY/8xa4N7Vdct8uwlAYCvrgWnbRK/Coak3AcEUT7?=
 =?us-ascii?Q?LPE3h+RRWSg/LHA/1k5R7TdQ6HuqUKVNAyNDDZo7KZDjKdeLrr3YFPTMtjic?=
 =?us-ascii?Q?wGhK8QY0eHUX8uWrfl0Fl/r0Ung5QMIqVPNtUQwLOafP7ZV4xrugEUR81RVo?=
 =?us-ascii?Q?LVZRtQ6rlaGA6P0Hy5in1DHZjn9KD//TohHYlT2UzbIlGXwTgZ/Nib9jGZwU?=
 =?us-ascii?Q?G65L7xJDgQwNIkHvZa4jqudIGolrOw3zhLETBSqyHAtHrY1UbstwraQGDQyO?=
 =?us-ascii?Q?4uAabRG4KHd/lzmjUHv80R5cwOWT2vPk5JdX1MK2xLKowkowPWZczGMH+Me+?=
 =?us-ascii?Q?ihQr2tRvVrTq/0njRQzNMV63iEz/EOeG0al/t42RA5u8WOF9QIhpE6TffVj6?=
 =?us-ascii?Q?A/6dd/rRlBjw4E2zm20INC+anGebB8ytXPp20Gv3ay3j6Bi+V7tqAAFJiiz8?=
 =?us-ascii?Q?2UY1iQz5YgTZ1MZbsAgnLWjwC6Hs6KnWlJLEjWepUEikY/BUY4WbeNUy3gM9?=
 =?us-ascii?Q?bl0fPc1ZaWinCIrlW220nYs39ptAUidf/R+9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:14.3868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32aaf6d-5e41-454a-578e-08dd1dec43e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935

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
 drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   8 ++
 3 files changed, 165 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 967132b49832..eb2ae276b01a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -687,6 +687,160 @@ static int free_hpa(struct cxl_region *cxlr)
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
+ * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
+ *	    decoder
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
+EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
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


