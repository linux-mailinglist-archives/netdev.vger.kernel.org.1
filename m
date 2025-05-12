Return-Path: <netdev+bounces-189825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F89AB3D3B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF4864ED5
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C726157E;
	Mon, 12 May 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RxUVPoIt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369442505CE;
	Mon, 12 May 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066292; cv=fail; b=YMPXScZNlm9XpFzl1iQANlt257vNDklMaEhtKkHi9sWSrq+fJbnn3LMy4FUnrU1wF4FW7u0N6sNTRUIlntLJ6KMwycHg+ydjKCUn6R1hdk8FY2i/8qU26Z7etY5oLytz3HUoJlXnnL1p550kEpSiX0m4hKU/ANmew6LSsawjIxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066292; c=relaxed/simple;
	bh=4mRA4LVRZMSoCUXDZWI4xyCKxW8bICJIJd535usALoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYC/Gflx1u2XgFhC7hg7sFN+6jDwFl6fu0nB2qDZBsRVzt5CbaJfVj/N4PQvHDHzoAZzhDcNGvXhizrTF4LrIuKhHFie0pwj/BXtqIew5kmvcivPgoERpqrwBPMD6GA7HP2e/P5wKprLOSzFMGrClY1lzT7I9pyhYElg7Sk8rCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RxUVPoIt; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChrSk4hYkTzxmav3cX2WEbdog/5t3Z2OvQ60PsWztZImg7XMeTD5JQxgHEpVIslONI+cQWNfBU0hA8IGz2cTK63eg68IHbjGZuPfyuZ/yt1wlph+ep+T21XbUeNAEw4Nong14MP6SvZAUvlQGPZ3pa2E/fN95QdcoceKO+lRmI0sdG26wouYB/k95pA/TtsS77D/LZFh2+YZ9snYelASrwbixaorHabQmZ0KGwoj8AU4wfyZFVHUo2k0c9pIhRyVoBjA+A3YEOfrmf3PaNljg+HJo1xpGcHFKssYrP7UuVwvbji6UDhwu4Flx3/qK+7KEXvpuSGxEo8Q8mCXF9XgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OaYsj0T5TxK3O+BHQmiD2EFhVwUAqwvobnA1CRupVw=;
 b=A9fMDGGguhX7SxmSJAJD88sLrtDwYL+ijJgjZwfzkI6jY8BYGBIspXyDyWVxCwsiF1d7cyCU+2wTwF0lYFreDZvb7ks53htxFsdhcq2PBClq39r1YBCBVGTaBiNk3EXxoptdeiAUYVsxm2Ql4TNjmQZQ7hBKDYd6BpkYMluPgpwYzsWGrTOUYJegILQLkbE+N6fX6fbpQK+0ElkyLM6AAqlpayldfUPnIV2R6nilHQ4XbGkUYUbKKqlscqKlX+BS3xc60OysDvtuWaLErFr9OxbI8sZMjXfEj7mLXaWXRYamri1qTreSRQGbFfy2O5NoZNis8u5HSFfy0bIXIz4f5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OaYsj0T5TxK3O+BHQmiD2EFhVwUAqwvobnA1CRupVw=;
 b=RxUVPoItShxm0QOQgAVcKOBdKiipPlJzTTJrZmy5kN0b+9qcDKpHJbzp/pnQ3BO/3hv4VeEGv2VvvWxP/JRjM0LNXlWWvSSZbfSAS+LJ8mUyvlU2n6GB2s5/TcDqsk+K8RZi/GLoZ0n3K8UtktQ8yJBcYXLfjyZkoHSlB+gKekQ=
Received: from CH2PR07CA0048.namprd07.prod.outlook.com (2603:10b6:610:5b::22)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:27 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::e2) by CH2PR07CA0048.outlook.office365.com
 (2603:10b6:610:5b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Mon,
 12 May 2025 16:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:24 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:23 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 13/22] cxl: Define a driver interface for DPA allocation
Date: Mon, 12 May 2025 17:10:46 +0100
Message-ID: <20250512161055.4100442-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb1cb2d-91b6-4175-2972-08dd916fa535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I8a+94qzy97yVmR7CoCr4fmCyC23nbD2ZgoDQ6o3A7/xygeCdi+/+zuueTFY?=
 =?us-ascii?Q?HQH/faSPvpVyp/aS9JOMZpbxgGqv107/x6dS1Z49Kchn/Pj8n4xCBI1vEelT?=
 =?us-ascii?Q?EBT2u+mCOGC8Va1n+btZa0pigvOYCmWiHR5ciNqR5xb9ASANcuquTYAQ3CFL?=
 =?us-ascii?Q?UTRwCD/oL5Q5wn2LGRGH49AoRdeYDnA9nvpKIG0zTNW+akVr0SGK8HY911Zn?=
 =?us-ascii?Q?V6zzLBkQFeAgokkIeqzpEv+EevXL9NKTIRZYx4wg7lzKViUTgn0D+Ajj79PF?=
 =?us-ascii?Q?AR2V3WRJvpQhX6s8SsgJ6gn0s14u4lJ5HCq+KslYAviQsGiZMQUGxAYW+wtj?=
 =?us-ascii?Q?WqkDltg4v0DwRxb8Q93lykVFinS22PjzaP4OYJITaMriyIs/pZC1WEhYKdy3?=
 =?us-ascii?Q?Zk4BYsuzmJjWRGti5mnwouHIWIz/z5Ae+vTWHxk4UgBKyA5cZLUsAK53ITkq?=
 =?us-ascii?Q?FiLkTSJqTiBlTA2FBqvnKvoSSrl3qBtp2P7Oo60g6PdRHRiNMbuNhGwDZi1O?=
 =?us-ascii?Q?k9BfGxTpsaB+op0dbDEVnVGZZDdLnKNWEaNDqm5q3LoNTYZZq44STp1P5BF7?=
 =?us-ascii?Q?iF7+zPbg8gP5vteWYeBGiZkm+8vZrV3BWnQcLL0fao6gDF8TjWeoVEdCyQyK?=
 =?us-ascii?Q?XyswY/g5rOCJ/aZIt4eSUbj8teuaSNQ7kQ1mAEuaCNDiZFNLSTF/9YF+1ogR?=
 =?us-ascii?Q?UPHHYhvu8qw/LhySNGV9hDLlQsf2FEg84MdIXfALlUtI4eOJ/UvsDsllgbVk?=
 =?us-ascii?Q?/lgOIXRzwIv8gqfgbp/bejzp4C1z30X24J79PY8zRv/3JZrffWI8CaRvTbtA?=
 =?us-ascii?Q?gWXVMwY9cVn2PDgdCsn2zLm9XnvvyLSbI4e/C3uu4qgIjLSuokT8H+yY1dLq?=
 =?us-ascii?Q?MrclViVUfP75knAa76OKX+R6Pj2Q+Fn5hgQyyc4mGsRjkwEkkZ2hlL9gtjMw?=
 =?us-ascii?Q?iEqUHvq+x1MqTGEK7CI8KGG+2aQV4TmDMxxYERvwBSE226ICKEDklzO457OG?=
 =?us-ascii?Q?yT3NweP/sj244eO6pXhSh5dvZTqFMC47sXRltVuzrbsnGCClW8BgE6P68YTE?=
 =?us-ascii?Q?2iMb34S6cE/HW942LDdUcHdWDfS25/gGzeZW5orVW6y9Cg+enwUOMIa9dFir?=
 =?us-ascii?Q?cE0qwvWONenIj6CciZ5E/Cq3+pb1mrQOVRc9dEparJf4ICjDiHkfsTR6bhVC?=
 =?us-ascii?Q?Vd7PHwqXKslHCxJ1gr1LRc0f7GMd0wNi2U4TM4+qkTKn+YhbSe3rTFO+cB8c?=
 =?us-ascii?Q?z1/KXx0mjU1/VPvTKA59AW4R7+GfMmsyoMOaelglYuYcgSrdv1RQcL+EWtxE?=
 =?us-ascii?Q?KtJsw9ACiBjWzRykK/bJ0AWwSR1vQaYXc/9BXAWjoxvy7dfOYueC+aUZhh5n?=
 =?us-ascii?Q?4kib9PqveQs8adxtTtrnwyWl6LH3PvPXFohwMqaf+FwDNn9kQoBFuMTsACK4?=
 =?us-ascii?Q?JYeQ7G9gG1h9TlzLK8D3adrMaObh0E5HX9apWfuhlaNCRA9b99NpbG4KwO2b?=
 =?us-ascii?Q?MMZXB9HVrsUgcyrUOJC0eGATcfqipnUQ1KiAykl3yukJjRYftzSzohOVEw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:25.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb1cb2d-91b6-4175-2972-08dd916fa535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space.

In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
that tries to allocate the DPA memory the driver requires to operate.The
memory requested should not be bigger than the max available HPA obtained
previously with cxl_get_hpa_freespace.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/hdm.c | 86 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  5 +++
 2 files changed, 91 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ab1007495f6b..571847401469 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -547,6 +548,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 	return base;
 }
 
+/**
+ * cxl_dpa_free - release DPA (Device Physical Address)
+ *
+ * @cxled: endpoint decoder linked to the DPA
+ *
+ * Returns 0 or error.
+ */
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
@@ -573,6 +581,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -687,6 +696,83 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
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
+ * @mode: DPA operation mode (ram vs pmem)
+ * @alloc: dpa size required
+ *
+ * Returns a pointer to a cxl_endpoint_decoder struct or an error
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. The expectation is that @alloc is a driver known
+ * value based on the device capacity but it could not be available
+ * due to HPA constraints.
+ *
+ * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     enum cxl_partition_mode mode,
+					     resource_size_t alloc)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
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
index fcd6ff77c6f2..ab5b40e657cd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -277,4 +278,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
 					       unsigned long flags,
 					       resource_size_t *max);
 void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     enum cxl_partition_mode mode,
+					     resource_size_t alloc);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


