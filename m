Return-Path: <netdev+bounces-150347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D79E9E99
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2348167B2C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17861A0728;
	Mon,  9 Dec 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQYtbs4S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB119CC22;
	Mon,  9 Dec 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770507; cv=fail; b=WJZ5J++nEOtibh8oMZ3WMfKyAeSfCfiwahOPCvkm2vfjtzBxnCBIXN+nGzMtBevoKOXIDXwb/le6E+d83lhvuWxPQjIczHBa0IS5ZrZu5dwnbcyvlhW6veWCrLpEhMDGXFZcymyuhz7bxmL4ne7CrgwYTcRI5HrCvidgOHeUMl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770507; c=relaxed/simple;
	bh=hOuT6GZBgH751gQsUdDTGozpuuFtNYNVsG3ltz5o8o8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/a4UisyMDbxnYpyZCDszeGVRvlGSoFv/F73KKyK+2aMoTX14t+ve4AvJxPhPtBsk/jvmgAcJqyU+jiFdVHZ4rpW+U+62R6B/no04v0Oqp9zMNShWMTOmHJ1PHwA0bsoGRIiYLXjdgXtdkRLI7Q1PfA/DR6ODuKx4ZrKShMsILk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQYtbs4S; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHXHfvCfsGYbyj3oIJlIaFSAPw7y4Q2uVx7X1Vdf9PmdbBKbopwvg4POTJV5hYY+volLf+SzqoqF/pL3WGMqqPXELP+mzGTtDRIeUh9C44LIBROWG26x6qNp6C950GS61jun/2OHhMi5Rrk5bERYzcavT1vMVus3ZUGdGQdmA7Ps4XmR7B5liwhri2GJBnaLu/JSoRZMjSjFSmkQZTh2lttg0F/baxvMeqnB56i+QppTyeRj9xCigTpaMS0PPa2Y9eah9BWcuPQWOoVNMifuxxxENJDcP63yC40LAI7GQtCt1/ugexfydBlPARpD8PPfQ9mED0pO4htI1GIu2pkd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO9PkbCUNs3Vry6W/PDNueN8Ud0rWCnvjLky2MOjG3g=;
 b=SJPXaXT0/Zw+G2GkWzoe07hhlDfTdwzSUzxyoYeIbPbm34155YaPxHhjs0fLR86W30vXCsIWgXS2NWAUo68G1ADCdewsiqam7o0mfs+Gv9/G1NhdfiNC6ix9Py29jkklkbtqWc7PEEhhKk/++F+4xvG0/F9kr+QEcTT3SeCfnySfC0QrVGadimDlJRehxiuvnv+D4Zv6CXplSOiTpKhAkVrrwryaijFyNL0wJOTN9KM+1QBN8p8Bc0bK7fh4GZtCCc1DKqLKh90kPegj519UrrZSv9UaDxHA4lp0y0RiV6oPJJAn+abukalsyW7zDz4/ZkJgP2HPuPNxT+NLO4AksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO9PkbCUNs3Vry6W/PDNueN8Ud0rWCnvjLky2MOjG3g=;
 b=hQYtbs4SOFbItmAqo+qXcoWUmfiEozsvHVJ7K5sUCXI1Sg+hE4W1Z2dJcD7Hel3sPemkFjcKV/d8Y1M13cbWsw7DTs6mOvoXACMxx5PZQpUkxHsGApiJl0zDewG8tRkCWw/vzWoDVwTtkgRicnDezO6CEmHwyVLz8Wq1pgsBOeU=
Received: from BN9PR03CA0501.namprd03.prod.outlook.com (2603:10b6:408:130::26)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:55:01 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::5d) by BN9PR03CA0501.outlook.office365.com
 (2603:10b6:408:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Mon,
 9 Dec 2024 18:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:55:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:00 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:00 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:59 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 15/28] cxl: define a driver interface for HPA free space enumeration
Date: Mon, 9 Dec 2024 18:54:16 +0000
Message-ID: <20241209185429.54054-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cf8dd6-0b95-4c9e-66cc-08dd1882fc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vCxFdko5uLG26aiclEJdHZ3ObGA9XHZOAzSyqpPvYpDpULxzgm0bSyI9xpMl?=
 =?us-ascii?Q?+UwVMLOd7wwceQQ3CAbMvsZ/W1s6kdzFFpj1MnSdfqONXPT8mXW4NZyN1Z5S?=
 =?us-ascii?Q?Yro8GlMHb8X/0Elj2bzAwiptXZhp4rgYRy+CnDxJ7iX6mhrrrmM8PnP/EIMY?=
 =?us-ascii?Q?lxOVH5MaCTmIxCiQd5xBKhcNIvgt6xIs1My4j7vr27achLReoKI2AqGXyMJa?=
 =?us-ascii?Q?MixsbVKi36vN+gvCGfdj+LP7E/utndauyHmNkYCnXhMzO1yq6uglpdyz95U+?=
 =?us-ascii?Q?r9jjRGg/bC4B0RaBA3xCsZb6Tv/XUP1aC827wp6htALR7o+OH7Q8T4xw4beq?=
 =?us-ascii?Q?O+6kcL/sbqLjByvt0BGYltiqi6XzG4tqaQC/lmNmf3jCYrhjnI/kdHg92rkD?=
 =?us-ascii?Q?2qzeNjqI29lMqD1LIV/Y4kUnOkEPzQf7Rt7mFE8L0yS1mkqwU29R0sKz//MF?=
 =?us-ascii?Q?8THQKuVMJflk38uhfIHb+RU9nkz3d7ZZqd3YDSyPDi5piVLY0D0iFmfIpnM6?=
 =?us-ascii?Q?+cg4OK8mKJNzWbf9FHZKSj+gxRJXxHxcUfh/uRBMFSd+Ea0R2Al6SixT6Dto?=
 =?us-ascii?Q?OLT5HNnC3lggWlvGdDoNFaGr7GnImaOn/AXzmXD+NcIzS5x4Mh0fxL4PLI3R?=
 =?us-ascii?Q?seayG8mt3IuzUnQlyBQlYDMMO/1smj59eUS3DlPdnn0S4vnIoU9GcZztNf42?=
 =?us-ascii?Q?FJY9pXJzmywYaA3N0lsp4vyq49Ccw/uqWBBn4P2GTllYmk0FPkwrgYxYffBV?=
 =?us-ascii?Q?P6CmoT/yp2vW8Xlu/SWVpRKFbGdSX7i9OzpHLDrWEkt41pNqXbxsI8FwNfl/?=
 =?us-ascii?Q?hKdhLEX3Iy+eGQSbWEVd8iLnXAWoWiEZv7yYsm0MlHW9tyuYAZIKNmRjZA+j?=
 =?us-ascii?Q?dvV4z5XHEpP/q0Nzcr/ItsrEIy50UTrCAAzU2lV/A9ZABpAcbl8UIfMgmZvs?=
 =?us-ascii?Q?xCLm1mm0LaZAprKw25oKCEyIu+5cvyMnxbp7Tnb/i+YpI0m7bcOKVgCYsp2r?=
 =?us-ascii?Q?I61nCQzSxgLLHNetFrnPLBelGzsasaMRaq/tr/HPGQs3BeqCYN8iCXlW1lyT?=
 =?us-ascii?Q?cKntjwV0G5goU50h3l5AUDIWCC3/2pbTSTH5rOLWT2APBERmOgtdkty58MOB?=
 =?us-ascii?Q?D9dQU84BY1x0HGyO07kGiQbapGDPXuwmo0GzVZ2ato10TPph6RKKgMKzOh4T?=
 =?us-ascii?Q?DAIOFWNLux9sZVXnDhMUmEWIG92bVNJJYGveIexjFA5iu9GXs54WczHCAl2P?=
 =?us-ascii?Q?qy+O1N2YgJAss5k7IA0A3zQKxTZf/8+WVrAkVZb9llPJCtlXDKYc1mfg6o8N?=
 =?us-ascii?Q?H76au0SVE5CLD4DHnoGBXqOFqTpOSnoNYO8VS7+m2Mo8YDl4g1cv2xuNqtvI?=
 =?us-ascii?Q?Pp4WyUGnvFCTZbL/QFYxsSTtPZXWbo8MttKsU20EA3XFF7ZztqtIG5jxCtyR?=
 =?us-ascii?Q?aKmdh36Zx6X35UiMsCKEiHdVo5PN8Rs6H2Az57b7UJgUJN/hm3NyJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:01.0166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cf8dd6-0b95-4c9e-66cc-08dd1882fc1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

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
index 967132b49832..77af6a59f4b5 100644
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
+		if (!resource_size(prev))
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


