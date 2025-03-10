Return-Path: <netdev+bounces-173666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB660A5A58B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401EF175818
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD41E5B8D;
	Mon, 10 Mar 2025 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G3ef79/A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64A1E0DF5;
	Mon, 10 Mar 2025 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640656; cv=fail; b=OEbmhBSff27hzHiUCWf7sForcOcwYuxpIQucSSQOrVbY33johE0K4YSuK90SdKIqMw8QQTepOeSQ0FCeRK/la91dxFcdTy2lDdu7Yd9W1nkRee3OLy4IoXl/VPtAGOmpGQYJA2trJaxhvxkogdbXmVsO/cC1/b95cTQAHZDMxYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640656; c=relaxed/simple;
	bh=Y/X6wE9xrooxjXprAKxqIu2+u+mJ+oRUdNjLyYxdGhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQZkzl19bDoGUGvGHr1UxDtaCyxwKhjR2vBGjFd4Bcou8RSGbd86P/rIJGj5+wd54S/CF4KjyL/gs/oNieOIVROeCGZ694vSOoZxmPDnJFracIVXuubyy4TxvLVBZZwXkJqGH3oLU8MOdzobq7k+E9Wy8ZWAzqu8GurOuKPSvns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G3ef79/A; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcdf+jSatO8ahTeo4qg/sF7hFO1ZqTl3xASjTwpqfzr2kBwF5Tl25wQmE/9KnfIGu9EWOeaTbx7XexnUFXply/mAPi0VN3sCV/ce+M/ebySUHEv77AriZjRFUd+VuSmHS/i1rtr5pp7KNn9YkvG8mlt4WeWgFCwv6laylElkp7c36rRQFNtcCPS00H9K6JGr6BbT+lBXBeIlRsiZWQNb4hdJR6nkR1DgWlTcdOdpfl2hrvObMC3ETaLVDsRsaxFl/h9nmUR/EVRajIgioLfynHRC5csmTiy8A5fsOZ0PqilYo6CCK8aOBJM7i0bUjEgIEkD9R00oOjzSmY3U2srMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTHS4zSx5kSC2JsVGRMXtG7aIY/0Fp4aWNXf22eQHAA=;
 b=S91g9oxnD9lNglroMFKGDJ6e4m2+SpXhrz/mD18Hb7hmq4j9XGhGwcx5idc8ylUxGJB6OTRzsiSNpBl9cocc7Fbto2Lx4CKoqbLj5meatkAel0Cde9xlfH1mvwSnl5YSENomqPoDHqea/na6UWvmJ1lCrZHorsr2UZPUuQHTnviNTfg/vTe4ozfoO8+jUozQ7kM9ITmEqz73R5tz3OWPZDtV/ytsIx3WIpzTar/D2sXu9CoUC38V2DGrimTYbKnT7wJS194F2iTkI0aDmc0UZYvGm/o3A9qKJvjHpZLU4u4JjOiNMFvGVigvI3JKwdMPQU1JsVva/1kIfkg3wEov4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTHS4zSx5kSC2JsVGRMXtG7aIY/0Fp4aWNXf22eQHAA=;
 b=G3ef79/Aj9WkVJO3ZGMrT+jSVVwYYpPO8SevqvgVO9attAcIDNMXz+F8Rn4n2oQvyCswMrTjZuKe8hDi50olqfQKha3f9+D3ChqdHrtCOA7GLEEy+gOT/ckZoV/XOAg3XOQXXln4NvW1Z+8jbprmjg2sfpcwfxr0Ltwobhez4g0=
Received: from CH0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:610:33::22)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:09 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::d1) by CH0PR08CA0017.outlook.office365.com
 (2603:10b6:610:33::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:08 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:07 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 13/23] cxl: define a driver interface for DPA allocation
Date: Mon, 10 Mar 2025 21:03:30 +0000
Message-ID: <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 401edb75-694b-470e-0db1-08dd60171a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NI1Gd0wtZd04du0Fj2sLFoQ0QNqF7xwI24hOsivmo0fV1imnv3qiOxXmeiFN?=
 =?us-ascii?Q?fmcu+lmtMON34VN0sUKre+gKqfBTg1C7bSaAagnWEC9piWqQL2uJftaXSBHx?=
 =?us-ascii?Q?abWSSrIrq/1CXt78cfpTgYsQZiTvGkAhHPa3hz0N3FndfdSd4FZNE854Ry8E?=
 =?us-ascii?Q?BMTlsTwsIWL4ITjolu2QFm8A2xauLeN29PqFN77AQ0u6ZUpDQwsSy2rUMpKc?=
 =?us-ascii?Q?MgThxLxyHymAMhS77vof0B8lhiohf3d/x5grcozOYWXzKZKRHxQB76uMMzjk?=
 =?us-ascii?Q?+1USa2OR/bCydRMGLFVzxO7RTstRhpnjRHodIePdz02CDq9akQA/L+Yhaobk?=
 =?us-ascii?Q?GHmCThiiBL/Bvx+Xb8nrJmdrEvCLLLxfvN4p8Z0bpJy9n7PlB1CraSDyXJ+8?=
 =?us-ascii?Q?pVqLAdEKEneaH1iI5f3HDIiZYclkx7dRMV7Y/Ds2+GoGjCiF1XBFq2p9ZMBf?=
 =?us-ascii?Q?A0aMqoC64DCoj3tob7ImGx8Vk/SxtDnMpcUP80ZNsM/z52mD2fYSpVBEB5rt?=
 =?us-ascii?Q?T/D7PwZAPEdW2smha+8WXfeaLhDD7ddwtf5Y8I2HxGWcY2MkwzszbF834Z+U?=
 =?us-ascii?Q?ueLffd/erceekP7IzaCeD1JrrhdaBvEZ2bKn3nKfX4OqiZ04857Nx5sovf3s?=
 =?us-ascii?Q?BIa2zvos4tYjXJZ+uR4dIcU+MCXReEqfXpRFDQ7uKkd8Y8TTFHFMMyIv71No?=
 =?us-ascii?Q?T3D8QWat9OFbql3cr1WvHRqcbLoZnejCpzqKSfzAxIdhXpMU7dIRqB9smD8H?=
 =?us-ascii?Q?VZRL26jBwiIIKB+iWpyk3aBJRjGf4Gxx8IDXA9yRud1dsiODzG76I9c/fg/3?=
 =?us-ascii?Q?/qH2f4qyiiSiFZUPeXfxMLFQIkaFzhHqBYVX/GlaDlmSieNOl2KMk1Me0CMU?=
 =?us-ascii?Q?ORISkh+w93U8a4F3u0KvuNoXBsnQOBaHJwpI7T17/u5wHZA+wqzIe+D/xzQ/?=
 =?us-ascii?Q?EaBAzIdmBSsibaUuxZMRjYUc6dPPmRLC3ojFNr1T9crc8THDlr8AyxbvkDyg?=
 =?us-ascii?Q?f7IBVXf1y/mjIFdSmqS6L135rxPRa6iWFZotQzCGUejWHx70z01X810IthQ1?=
 =?us-ascii?Q?SpMREhc/nODXFRakMuSTvwb6/LCFqXVvgO1LJ409ECfrqN0kj/6VbpR65fB1?=
 =?us-ascii?Q?uZdc0Y6rjZshRHmDfwbO3FU5oqh7l9/HGTPKa85LhAGGjxiVfx0mbHXixLtK?=
 =?us-ascii?Q?ykHJ3PvhOvTqXIOwVT24ym6trXvLQxhUc1EEKmMwyLFbmvRat+tjXA85/xRm?=
 =?us-ascii?Q?cmYddjf157bZn4hQtHh6ulO/adnZwjYi6J1j54f//b2zC6tVuuxc6STNnD3X?=
 =?us-ascii?Q?Gy1e+5RKxdBizMElBCR7ViE8thBhxRqZZ8Rg4e6OoFBtIUKTFn0TXqLhS+pB?=
 =?us-ascii?Q?2Dl+KuhhM4UoY+jMJQPCXOMzUw/Ycp4it8Y8wm/jIpiRQOTfqSUD6Hy7Uu/L?=
 =?us-ascii?Q?q5EuLAcCV9ZQKIPCmkbMi65KA4JNlHsIHKsNHoQaF8NiEHO2/FjaXRJlBBo0?=
 =?us-ascii?Q?fbmrvvscFZPjDUc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:09.5306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401edb75-694b-470e-0db1-08dd60171a2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Define an API,
cxl_request_dpa(), that tries to allocate the DPA memory the driver
requires to operate. The memory requested should not be bigger than the
max available HPA obtained previously with cxl_get_hpa_freespace.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  4 ++
 2 files changed, 87 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..7b264e82440d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -572,6 +573,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -686,6 +688,87 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_free_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	port = cxled_to_port(cxled);
+
+	if (cxled->cxld.id != port->hdm_end + 1)
+		return 0;
+
+	return 1;
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @cxlmd: memdev with an endpoint port with available decoders
+ * @is_ram: DPA operation mode (ram vs pmem)
+ * @min: the minimum amount of capacity the call needs
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. So, the expectation is that @min is a driver known
+ * value for how much capacity is needed, and @max is the limit of
+ * how much HPA space is available for a new region.
+ *
+ * Returns a pinned cxl_decoder with at least @min bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     bool is_ram,
+					     resource_size_t alloc)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	enum cxl_partition_mode mode;
+	struct device *cxled_dev;
+	int rc;
+
+	if (!IS_ALIGNED(alloc, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	down_read(&cxl_dpa_rwsem);
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	up_read(&cxl_dpa_rwsem);
+
+	if (!cxled_dev)
+		return ERR_PTR(-ENXIO);
+
+	cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	if (!cxled) {
+		rc = -ENODEV;
+		goto err;
+	}
+
+	if (is_ram)
+		mode = CXL_PARTMODE_RAM;
+	else
+		mode = CXL_PARTMODE_PMEM;
+
+	rc = cxl_dpa_set_part(cxled, mode);
+	if (rc)
+		goto err;
+
+	rc = cxl_dpa_alloc(cxled, alloc);
+	if (rc)
+		goto err;
+
+	return cxled;
+err:
+	put_device(cxled_dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 6ca6230d1fe5..d6b2e803e20b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -255,4 +255,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
 					       unsigned long flags,
 					       resource_size_t *max);
 void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     bool is_ram,
+					     resource_size_t alloc);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.34.1


