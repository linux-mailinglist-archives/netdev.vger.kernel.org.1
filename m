Return-Path: <netdev+bounces-190435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB55AB6CB2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F0E168044
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F3280336;
	Wed, 14 May 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gYRNj4yw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E127FD6B;
	Wed, 14 May 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229313; cv=fail; b=HrPutRSepsgAaU2EJdp68e6Oe5Nptq/3ey2Z3M4MxgiDqlv9dZ24fU8T3b0nTgbw+FwkMtfFBDmhbT2X9pqjYEgod2uU7ZmUL1+bfjZOF6NzDUE4CXOJRVI89ZyyrAxf8vB9sMuJ+CXwKdH7mFCJFnjsKxQciOik+dZddsl/lqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229313; c=relaxed/simple;
	bh=TmL+H4NHfLk4wZjfuvCj9Qs0By81a9akjoH7le4YcVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODQZ0o6sSyou9sJzyck+RKWcqkQCIDPKLc4qrKRJfbu2YhWBEw85h29izyaOmDXneeAQAdLQKwjU0uCXu1Un+x/sVxrPuHWiw2GdSCK2wIulmr98khQcWct4HIG3MsdphCknp3RPdeZKIgF0k9vGjAj+6vgmvhran2ly/oPArVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gYRNj4yw; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtCe6G34wOwmqxIHwIKf02kTuQc9BDVqEEEudy1zszfSzaVBcMtsiBcGZKguOl3jizXVSCJUlz5gIr3w4GMxdG3LkTlDTpai3ae0f5uQmgXkxpUZ4oNMf4G9Gv7H5WEbyci6MHtps0q5vwFKF8PdjhbFc983XdeALAmThV79LUe6yrQ20XFfxxAwDbGogVywBoKgm03A88/amOHoLzM17wn4SR7uzz+1sx1gbjeDVpN/hm+uIEQ+/eG9i7wVpMqDHMWxz3XjJbiwknkLmJIc6uqauIsUwKppaxQO7GEdUBI65DBtYM337PHXxvsLX3wH6ZlArbutd0sSud74plHRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HxO5fj/B0ql2LMlX01OhWp+hH53YlOvAvVI+MskCJ0=;
 b=HverduJx1zBsfEOgdb7VJ/yX3g3ZVyEcTxwdYEEhbC/U3i+6ScaAg0YfiuUniI8jHMY5Y7joUjeibZ9TkjtjFCVeW+IHAs1qbBGFEA9OhE4vBjljVsNfELJG9gEpIrdj6vvuIm6mLFkuUYURhu/T13p1PICYnPe/rWMJwSnFDoSSx9qrPNkdWbrDpWEneT0tdmzzwy+Vk0E5T2e0joIGQLJISMte/2s1US8i2vtgY9S0zK/YjjE6t8/fgJ6mcqjGkQ8BFi92PluCCP59vI3w+d241BWyWw+NiBONjZn/UINRiVmEN2jHyqUW1JyYI4CWOMXjlPb+G5bi31AS5mb5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HxO5fj/B0ql2LMlX01OhWp+hH53YlOvAvVI+MskCJ0=;
 b=gYRNj4ywb6Zg/JrtQTGG4EM9mqwuFwdJQMGHJAheTihTQQMESA8IjduZEsHki9jgTqSuWB/NfYBbQrEE/WwgYDpDcsYqxc27wGo4moeu7Y2Glr1rNwNcNwm+MpA2TRZ2neajMb9GRUkoUiiLS9Ue4PfLep+ijPiAsoanla0/mgA=
Received: from SJ0PR05CA0169.namprd05.prod.outlook.com (2603:10b6:a03:339::24)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 13:28:11 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::79) by SJ0PR05CA0169.outlook.office365.com
 (2603:10b6:a03:339::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Wed,
 14 May 2025 13:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:10 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:08 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 11/22] cxl: Define a driver interface for HPA free space enumeration
Date: Wed, 14 May 2025 14:27:32 +0100
Message-ID: <20250514132743.523469-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f429be-6d35-478f-7473-08dd92eb2bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/hsvSmi2pbIlY4unH9eVG8BN15mearVSxPJdEloSGfS9qWQ4jUf0RHnsejr?=
 =?us-ascii?Q?TresMF6UwgDq8IONM7wETe6oREu/gxcgeOvpS1BSst3QTgSocRmwW1yYLXMx?=
 =?us-ascii?Q?ImG2ByIJNOFQsarGe4bhQM/lSMQRzc3sWpl/2aUsPrP4HA42k8nOoSfIs5tu?=
 =?us-ascii?Q?6pEpi5vxHhfYaswQhqVySVFMITT1U7NHVYfKTEnIXOGKXd6k+Se4x+PmP4PX?=
 =?us-ascii?Q?EpV/w+lSpyAv04ev/8W3hBL4EY7B1AtOD62K5UaWHawHx8piAP7f5iw0GW4D?=
 =?us-ascii?Q?T3ZHGx6Ec9kLOWzdS+9F3krD03TiwIEaipuXNkX5Gk5lXNs5F4MD4SSg1OgM?=
 =?us-ascii?Q?WgIndLRc2DliODCymO85ohvWYrl9yXP/SrRIatR29T5xTsI9IJJ3RMhIPBvi?=
 =?us-ascii?Q?SmzF+0iD9ASOfq45IMdQqJKFpyQkG6XyMczBJ8mZuLBpgPJWUMNgge/zZsxT?=
 =?us-ascii?Q?pYx14fzLBFOLL/ivzn9JEDsEoIDMa0fNy8iTyVEbgJrTmk905DvS0UAN2l50?=
 =?us-ascii?Q?TiK6U6hquSEgUGJL+n2ebTq7Nl3zbxMhf2GkDfL6zZgYdCEWAh33OmLBwEOQ?=
 =?us-ascii?Q?QmnT5LBkwh/atZIzzCkrlF0IP3PqBoogrSQrOppdqUoqeKhx4w3pg6TJ2rXv?=
 =?us-ascii?Q?bZxlqRmwx+ef4dX2xzBBsmzflN5OF5d3S04Kw1QXpe7wyaXuPYQztH9V0joe?=
 =?us-ascii?Q?eMPTOj3l6nZ/Kh/4tO85TkI355lfxo1A+hchlnZXYmm8+dPRZGP22aLEjkuC?=
 =?us-ascii?Q?/xog5Hh9jGbBL6vSE4wZRDPDlLLsvigGI9BuWLnf/Pzsc/Ejtb0cPgpimPmZ?=
 =?us-ascii?Q?9oL7+CzBQDhk5eVvTd/DPNcOnyNqV/FrZXqHc1RCYmyomjYHOF4wu8va69bU?=
 =?us-ascii?Q?kdXH8qj6JT7dP9ngLJ4Tx8MK+6uL31gKxpEzA+l/f9fMHUc/z5Fj9vGo4b7E?=
 =?us-ascii?Q?eu/Sn79x9GSAbboC9aooKd8FqCJu1vUJksErTIb9h5XDUvsQAiiM16GkXr04?=
 =?us-ascii?Q?4CEcwwveBqMD0P39YDH5nLfp4uO8lQeFHviu4OEASZ5qtGLdLnDZH6gnNHo9?=
 =?us-ascii?Q?wQRdpw90n3tT3hQb6Z4CVoCiKKbwuHbUjgYwyL3F5Ja5uUQXCsQ4TdQXDCBX?=
 =?us-ascii?Q?GDKtH4LrztuhV/VQdq0mZSeh5xP3MYKh3JYP01MZTx2DRi4p1IPlDKlC5yYX?=
 =?us-ascii?Q?bX7DVqOnxkXGCLum5FIk7hw4innVUsvOgt2SA3hVMYydQ9MFiNBiuR2f2+1e?=
 =?us-ascii?Q?q+22zA2N0R9BUOGGq7BAT90rSBOsdyYXLy6L/JCypkT8WZzDvmt91ugUHhJ3?=
 =?us-ascii?Q?sWWE1rXc1xBMaEx8TazIkjcvBkwQGyWjWvwVu/JpuwxtZQwNwnRdnon4dtYK?=
 =?us-ascii?Q?OS+3Wm/CkFADUVtcUjUNNuvxPIfPqixA00mY5s9+pdPR8VJd3aJ4wNTSgXno?=
 =?us-ascii?Q?QseM71FkotgyBuwYXcrhoMBJtbITZp7wd0asy5XkW9O4m8DUZRFZDhiB1lOA?=
 =?us-ascii?Q?vfLV9br0vLBvtAK/iZD33xOs/PVJXJFkc4SmSO6AOVvT9IPVYLLqhY71ow?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:10.8520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f429be-6d35-478f-7473-08dd92eb2bfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

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
 drivers/cxl/core/region.c | 166 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |  11 +++
 3 files changed, 180 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..4affa1f22fd1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -695,6 +695,172 @@ static int free_hpa(struct cxl_region *cxlr)
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
+ * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
+ *	    decoder
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
index dfe8a04b0ea2..6fc6fd7b571d 100644
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
index 19d194d98665..489faef786c4 100644
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
  * Capabilities as defined for:
  *
@@ -266,4 +271,10 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlmds);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max);
+void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


