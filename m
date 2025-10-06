Return-Path: <netdev+bounces-227934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C1BBD985
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98ACE349E72
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D882236E5;
	Mon,  6 Oct 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BpIW0S36"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15BB20A5C4;
	Mon,  6 Oct 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745072; cv=fail; b=dUkCFfBjqcoJq7gdmXv+g+axoHUfmnzsqq+kVOAyt+8KzUUiapZycdPqmwOeV2Tq5UmNZY8ckm2lWXl5SuJcyOcUj5llWMf7jrTyfq0huhyx1qREvQt7deZ3Bl6YqyymTh8RoUmGflfAqFp+rs5M2i48UEDdGPYCPVcz1t2W56E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745072; c=relaxed/simple;
	bh=bUZjrzSWRtrcbICMIGo5CRA4IrQgIrV3qakXMR/dAxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS5sPumanOuVaIMdoxcsM+QkO6DV74BxpiG0T2su3pYBb7eAGNIvI+/X6wmFeXTO3WlkHXPEr1MMXxxaxFUxVT0AcudNbsh3p6UPCt59Jhg6AtCs/6L7ZZ42craKfo1RZWivQ++djH9xWd8qzW+N3XmxLxUmmdzhDd6URvwLxPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BpIW0S36; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7TSrW3TbNtAW/TwTshu0IHTqIihcVi0QLVdI4s8dWIACM+mydNFs3thcEIW/LraoURiT7EagPt8AhuJetzfOEoGQVnJwwjlw82YnMosAELSy6PGs/hxF9P0avnMAdDFjVvCxskPmIRD6tTjLUISofh2hszUBpcQ27KHmD1P2Sl1Z0rl7OJJMi9evk81FnkCUEkpCxDn3EidjhPP8HQVbB8pUhP0zkIfA+DGY9sktiM1BS34tn7l3X/0lsh9rljZrkU2MgimVjLvwFTLnSAdZ+bUvs7T7RW5SE95yNtYlefZS6CDbcsrGnAC9Ew4GApd9R+5EQXJjrIF89y39lYboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YXZeYsEVVGZUWrlfLx353ovTUovX4eelNElWd2Zn+8=;
 b=vHDblPDELNj6OYjw3y0PaofXDWbYRgU0KNt4k9q5P0IxsQitb7q69lsfBR+S1LpiWugJW1bCf7pR8mEIvrI7k/QCrwk5sIBBTL9K6EWcuIDvczXhXZeaTwiv+UGQaPiQ92i35acLxMxiWC8QR+2CkIH8717rX0nijMC+X6CjlW87feG9nrggWwfnhxF2CHB+mc9ssV8PwiZ/8RzEXyO4GEYr0zAjEPB/5CStwm5sgWqROEWIBgAYLJJvkUMF4g/oy9zHXi/t08rLrp6Savh1sC6263926nGmSeuXVtJYbTtcAwV1rSMOQAEAZv3Z2pNgI8lfbTvPazt8WWAcDKCcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YXZeYsEVVGZUWrlfLx353ovTUovX4eelNElWd2Zn+8=;
 b=BpIW0S36ssw9tkufrJqj+Uev5EMSAoQ9RRalFPeqI0aKPAfvQXVv3uky6IVORbqKNCTp+5ObSSQGl+SeqrxdS3kTQX3mc1m5/yjPkgLi2JEe6svWoL4bBXWvjc6iQK585OsP9Hv2/edFRTfGcmNgxztsAJ84wbmaSpLOPg0oO1s=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:04:22 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::94) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Mon, 6
 Oct 2025 10:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:04:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:28 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:26 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v19 13/22] cxl: Define a driver interface for DPA allocation
Date: Mon, 6 Oct 2025 11:01:21 +0100
Message-ID: <20251006100130.2623388-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d570b3c-3410-4d25-296e-08de04bfb8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7U+VXhc1h0fLXCrGwD6QSr1SfrnKtHRWcA7wxS34QKqdNf9I3pP0ZZG79e6?=
 =?us-ascii?Q?BPDw76PJQJFV9DH18gTQ22v2rYwxSGCL+z+HAa/44ALzijcTtVQf1/YDXt21?=
 =?us-ascii?Q?40ZrrmO7vzBC7J9BlL4CJWopWSIV0aUzB1cTFjeVFpkGQsKQsaP6GLQwRIXy?=
 =?us-ascii?Q?4MumUxCJ0I2nU4ugi94JSHypiQIw1ATg8Jnd1onOmmAnNt5XpYmhk2cjLlAb?=
 =?us-ascii?Q?iwFXTZZekE5B3PP7kGAI0qoeCHZd03bv1do0/ko9W72TrG3/DdLB7RSJgmEd?=
 =?us-ascii?Q?IZC7/RqGn4wQVv5I4MJqnXVTXnDf+2pV531pajkyCqODILwBMFWVF2gfkQOA?=
 =?us-ascii?Q?KQZceqOG4GwHAMyRp3geJRjhItRBIAYkhS5oSgbC8pdfjYjAi5jW7W8E+Dzc?=
 =?us-ascii?Q?hll5SLgYNRnFDKPN5d1MZrP5/S/jJ9xM0abAZHWCiiBGnCyC6oeeQqB3hnsq?=
 =?us-ascii?Q?iMSgNuiRDPyCRBvfX0FJ4UNiWx1B4TE2LZBMHMeuGEsaAxP/fMN5IFN7kqLS?=
 =?us-ascii?Q?Ur4HP7Fq9WJd80khnH+B0SspNUsJWfZP6bK9Q0MqEHL0fTUPJujfuWHEdT9g?=
 =?us-ascii?Q?/fIz4kVrf5kG5mDq/oH/6cmKGaljxyfyO9KFOXQAiktAw+5AwHJQ0v2SbgQu?=
 =?us-ascii?Q?h3TQAhIynyBPfjZMExEh5VRrkJb2r4Ms24W0uxU50P/v5QXm//iPqP2emcRV?=
 =?us-ascii?Q?od3GOjLpfpPB8UQ+VIPnMmq+ddX3ofsU6tl5yR90L6v0Q93Mzw7xcXdu/5Gg?=
 =?us-ascii?Q?0Be9IKkop6jOffz4mtmiAWaMOQ8vghlokMWi/8iuTkhPUNjK8Ml74uHG+OO/?=
 =?us-ascii?Q?Nbi+euKCfEAKM/iEntGePB8zKNExrWHDh0yHMnV3JW4JR9GjMmfDmf+i1SVY?=
 =?us-ascii?Q?Wzpb246f3WXuq//SHYDu0JAcAF579/T/xnVrQ0iJAwItU5RrEx4PKmpB0qfR?=
 =?us-ascii?Q?c2Snfch6VMKrR4RyHM/F6WA+cTKoLlVNad4c111N0UQtw3w0MPNWFv0p4mT6?=
 =?us-ascii?Q?NKlZlsQPeDc39R8pV+f75egDgHL7Tym1EilghXVjIr/KPnl4+AYeG5NBe06l?=
 =?us-ascii?Q?utsrmMjAGMP6AgLD++G0FlZtJjRqMM8CzGEVsCfNKAisFa4mwHsCTNpyPFsP?=
 =?us-ascii?Q?ARIJb8WeVF3AIVBbt0ZP79hKXO33QC1ACRZda/dm6wWtDdsZMx4+Wta7Ou0T?=
 =?us-ascii?Q?TaCBoFamuLisc3eSSuLd/aufXl5xVKrb20EEb8Vz+zma1uO9RkZSnrNLCCcX?=
 =?us-ascii?Q?uP5qtbC9sWxD/uIG+7mz9rUPoEXFle89NnSJSBkP2CHAynXPkOIxjQouJuTp?=
 =?us-ascii?Q?5ULG+e0NMF++CohmhQJNCnr7xQoGbYktMLXmlYHoRp26LQbeaY7ta6y9RBl5?=
 =?us-ascii?Q?NW7PYfuOjlR+vGJSc1u659FwFCvaTOyqN0FNapQ9C79vYhR/WNtnI3pSGe0Z?=
 =?us-ascii?Q?BzwTiFN5YKWFH/t45Z0xm0EzEjW5RN+w8fqAhOhb7BFl1DUr8Xi2CY/tiLrs?=
 =?us-ascii?Q?ugmwcQcV5zVEyV/QnOwZxfqHlgKBLO5xwIcR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:04:21.6134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d570b3c-3410-4d25-296e-08de04bfb8b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space.

In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
that tries to allocate the DPA memory the driver requires to operate.The
memory requested should not be bigger than the max available HPA obtained
previously with cxl_get_hpa_freespace().

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  1 +
 include/cxl/cxl.h      |  5 +++
 3 files changed, 91 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e9e1d555cec6..70a15694c35d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -556,6 +557,13 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
 	return resource_contains(res, &_addr);
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
@@ -582,6 +590,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -613,6 +622,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	return 0;
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
+	return cxled->cxld.id == (port->hdm_end + 1);
+}
+
+static struct cxl_endpoint_decoder *
+cxl_find_free_decoder(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *dev;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	dev = device_find_child(&endpoint->dev, NULL,
+				find_free_decoder);
+	if (dev)
+		return to_cxl_endpoint_decoder(dev);
+
+	return NULL;
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @cxlmd: memdev with an endpoint port with available decoders
+ * @mode: CXL partition mode (ram vs pmem)
+ * @alloc: dpa size required
+ *
+ * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
+ * an errno encoded pointer on failure.
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. The expectation is that @alloc is a driver known
+ * value based on the device capacity but which could not be fully
+ * available due to HPA constraints.
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
+	int rc;
+
+	if (!IS_ALIGNED(alloc, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
+		cxl_find_free_decoder(cxlmd);
+
+	if (!cxled)
+		return ERR_PTR(-ENODEV);
+
+	rc = cxl_dpa_set_part(cxled, mode);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = cxl_dpa_alloc(cxled, alloc);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return no_free_ptr(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
+
 static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ab490b5a9457..6ca0827cfaa5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -625,6 +625,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxld.dev))
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 2966b95e80a6..1cbe53ad0416 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -270,4 +271,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
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


