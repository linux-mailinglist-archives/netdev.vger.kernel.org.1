Return-Path: <netdev+bounces-240145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4A4C70CDD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61931352F0B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CD371DEB;
	Wed, 19 Nov 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4eS7ecam"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141A368266;
	Wed, 19 Nov 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580206; cv=fail; b=S5iaLSGrZbEGtlZuOvdPk1J4wRS57pS3eGgmq9IhXe8pK283a84LtzdYRDK3is/DOcBf7Dab03obw5WhLD8IYAf2eZPKqNF+oAZlGIxUImvH3HShzAEdx2JVpnM4uID+Ja1FExnqrT9W187iKVaAybR2ZeQ1dJgEeSdl9oY2U7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580206; c=relaxed/simple;
	bh=Eo1j12EaJYBCzG7wKVw4oSSTEILUmBjkS9F4Botj1Hs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT5uCCMXNyvAutgGe95NYYlu05K+z5SFYwD34wAT6kgyT9TvGc2M35fc+6NKUSlpWKf4hBtdHqfH79uL40GV4B2xJimwp22yxI0PKg/zRirFLcN8T8wwc96ywl7e7fErQIQZwF3V12d17TTx/f+4xcw7oGTBLOIFs2ALRyWHRLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4eS7ecam; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcEc4TMO3EhamHLndr1iZWn84maa6gcRjiPWGPkT6fZtRx3sTyJSz3h3xS2C4PksduQE9KqY2Um2XfLfpV6G9Ab182TfwXLE7YqJyFW/xwT98bru4RLRV2TQuh70hX89FHvzLeoHkWrVZT564k+parGT01IdUmR0dmQwFyZsEYDXWgF0xv978sEB5p7CsrMH6E/msMFSzFvVere69QQzV1JDMIjiNJd7MwJ7EZN7LQ14LMKtbbCXJPo58VKgU8xsO6wBUpUiCMq3hDCjCMg0ppPn/PZvR6I8ikAkArrKZyDXIzXaxZWX2dVrLo17MSs7EGZKwoX0h4YcjE9+Kz35tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS+iICWAyolL0zBJPwjdTDP0fN2T/rRpqjh71DYaizg=;
 b=dUv7iRM74YjMwGJUMixDj+eG2KcawfGhvIZFjFefdcnJas494qJaVVDt51TPOmijMlsXZeflj4nCoV5GLdoVnJ1rDC54mUITykCudxAsjL0rUf184HGgciXTtdQpulJSN4QK6lVz/ULcsG6H1lpKt/YUGEXGEgoXe3yJ/WNUVOWSA6flkUzEKIf8gBKg3YdapN8D/JVTiGVA0nTR9ZCkf0mZnfu7C1BObO3GJq3nMvkuGPwawzoXmaYTt8A5G13Ew0Zka/oDu8P6OLeZE1zWLrAargps690+d8EKXL9duxKPHr7TA5PT5O06Toy4AREi9HcGWQAxqGk3iRn9vjmxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS+iICWAyolL0zBJPwjdTDP0fN2T/rRpqjh71DYaizg=;
 b=4eS7ecam6UdlLrb5uxWfjbmn1U1Zt6XjTBCvMCnA1/I73f24jgRcJiUrsGKI+I6jf5eAbc6G+9TMICKToZ8HCEjp3RlhNyMuHqByCZbzLa5cPKj0Wkfd4I/Rc7uLeh1aRsWGHAcVPyNhs91aANd+yCpXdRFAb8rU0nASapa8UT4=
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 19:23:12 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::b0) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:08 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:07 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:06 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v21 14/23] cxl: Define a driver interface for DPA allocation
Date: Wed, 19 Nov 2025 19:22:27 +0000
Message-ID: <20251119192236.2527305-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 4671c9f8-a0d1-4261-76f0-08de27a1143e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z1tdJSzyI9GsrPazqyrO+G09Nxnn2bvEaD2CYxDtB0RJB4iqyn+qu1AbxtSd?=
 =?us-ascii?Q?c6VLuvtPK8wkNY+k/4Bs/ZMNt6VfySmoXiEUib1SHtF7W0cfjD+efFeeopY9?=
 =?us-ascii?Q?Qm4yYcyjg7EsfO/40ZTnQvinBfothqWFJ86eqGY9032gSG8vffwjXPo6AUY6?=
 =?us-ascii?Q?uHygOdBmxkZXkChOlWmQCAUJAfnNdBtGOgzoeiOtnDxuAnWGtXgdk6Ue8ksG?=
 =?us-ascii?Q?emjKJ+szH86MSPN/rxJoJC0KlarJ9NR0IrxVHwK5K1snhi99i/udr52+HkJg?=
 =?us-ascii?Q?MxWHnB9h9Q5un09ZW7qZ2ZelY0W7eayi+cH0pKuwnl5w9PKPuej+F3ilIHD1?=
 =?us-ascii?Q?czLMCmSKReqQV2ke7brvMden5OJk0qGCrBzc+mNgmAcZc7i/Th9czUumoaQd?=
 =?us-ascii?Q?+6R9Onc+SpV71cWiffw/SdKZbMy3C4w55NATO4CU0I3d8nvte9FEO/t3MbLN?=
 =?us-ascii?Q?FYPreLFdwiAyXuLyK41Dard8JYygbCKdKdo/9bCK7m385KRw995TC8Y7xv3/?=
 =?us-ascii?Q?gjmOsE6Gh6gQxr0VM0oKAwGQsfsD30Qz0AK7gEKarede+Q56khuCpV38g3GI?=
 =?us-ascii?Q?YwmCbR19Vs+Zu0kIVr+x9QJ9f5sNw9JV7IJVRyIsBGGpN9oN89F9fIYMMlTU?=
 =?us-ascii?Q?szEpraYD3iA0JhhHPfrNz9bOgg0cBfMmiaXC6KPRPP7XvicqKPuvZfzT+111?=
 =?us-ascii?Q?xi4+WFK0hQxat4s/2vYp5/ufcWgCfCKj3OurTGCiFSUcvFBHBVxXStkzlKcO?=
 =?us-ascii?Q?vjc/MNxpwgExlfNvArlQzhQ45cavf1xohytLqCcMHoqzArvoSO8UeWpjwWiS?=
 =?us-ascii?Q?nj0ES+qOqSv9tQKai2zKPt+IkhQtWFqAfWYjTE08cqWo0VMfXief0mZue1e/?=
 =?us-ascii?Q?IU3iYkOCVN8/poSng10nwd+nzhonX6tXqn+uREYyYUVvTxDsB9IMFxQtOHvJ?=
 =?us-ascii?Q?Hu+ZvFeH4TeZUPdk2I/cRv/GhuJoL9BcNXloROqHcti9MI+UGM9PbRT76+JI?=
 =?us-ascii?Q?C0TglBEpzl2EufM50qIwKxxea9FwzwyUtEpVd+gJpTGRE0eRW+slWaDBuAzN?=
 =?us-ascii?Q?4TYYlGlqvvNeJVlKty1YVnAxbCtlQVUZEmtyzse0q1hQjwG9dBA179GpYUj5?=
 =?us-ascii?Q?qve8BxbywiLLWyqYBz6Sbb64fDUvVqBNDjGeqCwls3FoY/IPDJYcr/2QaAuy?=
 =?us-ascii?Q?LTpFmIIaf62Z4ZGhU7zvNRImuTGEhuqwYC7wUQldQg57vAk6EDD/3BeZnnZ/?=
 =?us-ascii?Q?5amRWwTx4D41WonJkUaW4dGQAeMB7lKgBvJvh9s5AAuSnPMWUCfrPTZdMCyi?=
 =?us-ascii?Q?7FNrmirwNzlyeaTxWgZYfuV4xrflKznN5vaip5LNmTQ5wwcQVQJsVSm+I757?=
 =?us-ascii?Q?shEQPn6RVbEq9TKeJs3TtYQLqhb3qVA76PttS87+d7zRaxq+oxoIBrmYF/kL?=
 =?us-ascii?Q?le7te9gxYtwGM+O3WGW459Xslca4YA2mx2WAjAhXifLwrqqB0KwMo920UyBe?=
 =?us-ascii?Q?UUzjXJmTtX1W1bmsAHn9SdOn+U9vPBs5bj4XN99Y8T17aWsDGbBSIT9RndVY?=
 =?us-ascii?Q?sSGtmJiYkrmEnZSe1T//GbfLb7y0inYb1j0hFPXa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:11.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4671c9f8-a0d1-4261-76f0-08de27a1143e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space.

In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
that tries to allocate the DPA memory the driver requires to operate.The
memory requested should not be bigger than the max available HPA obtained
previously with cxl_get_hpa_freespace().

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  1 +
 include/cxl/cxl.h      |  5 +++
 3 files changed, 90 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d3a094ca01ad..88c8d14b8a63 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -546,6 +547,12 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
 	return resource_contains(res, &_addr);
 }
 
+/**
+ * cxl_dpa_free - release DPA (Device Physical Address)
+ * @cxled: endpoint decoder linked to the DPA
+ *
+ * Returns 0 or error.
+ */
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
@@ -572,6 +579,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -603,6 +611,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
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
+	if (!dev)
+		return NULL;
+
+	return to_cxl_endpoint_decoder(dev);
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
index 5441a296c351..06a111392c3b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -640,6 +640,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 
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


