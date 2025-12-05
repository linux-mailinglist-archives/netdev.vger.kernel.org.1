Return-Path: <netdev+bounces-243795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FAFCA7EAE
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7FE232B1FA3
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70832ED51;
	Fri,  5 Dec 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1F6LOD71"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2F33032E;
	Fri,  5 Dec 2025 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935614; cv=fail; b=Vi4DSN72OQm7VJM+wvSI42Tnifuxgz/cq0lwdT3bt3VriCI5ypdHkK/b/SMYmZ7iqSc1RRaHJ3SvJUx+nUhE96BtGkZXr4nCuodSuPFVN/WKeOusWahpc69X4BOb8xJe32y+eXiaK+fmbTm7zLekGcC948wmt5qGJI6zgBE4v9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935614; c=relaxed/simple;
	bh=4oCHj5FtnM0dkhJDuvT8FcG9dEF7o+zj5s8pe/XKBuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDdKuGtCnorUSLpjbvzLnMlNrAtSKWOM3MdvRRHVxS6FoGbVgjKLqzEGJ+/r6zRpWZn+sOGgjh87RtyzSd85Q298X2qpjj7wUOLRG4VoFTUtQFcvD4UVYghcLURuXQ1YJr4Q5glKJ4pJwdXY7SciL2M7GxrQaxfsyipSbkQjoSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1F6LOD71; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2ONYU6sPX7rD2DbLXsG3hCfqdBGn64xE00843+kA2SJ0VL6GbIyGuqp5yLPGLzCDfj37W5GujqW29hKRFHrdshRACwjVE6xghFFBAw9iBYd1mRtLJrKI51ymJDdRerT3VuC5cxfZgm5keez3o8arZCjw6S98sm+BEa8eKls80jrdxQssK35m4zxe1bYrqe1bU8N8loLmySywTtRaKqDYL6hLIXzSVXFFhct8YQ56vfayTt+pQjkBPlLA9ruykWYvvp2+aFm3r2vU8AnnGiT6VfW9SvAYmKp4vPqqk0Bcx4OKZPDj6JSsw+BZu69xSvmAeSq3iohKvl9O2NQVTct+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ogcpb3x66HrBcq+Ut541m6hUcpxQHbyFt6j76eY7+ug=;
 b=DAyS3rvE32JvXhD6xwsNLaSZkmwnW5mL8uUVtpyIIE43C9yr+GZEMTaupFEoy6aDxJYyyS1MeF+MvdGpYhvgO9w7giXg+e8atLifNQaB3WcbpI8/MaawAq/mc86aoi/UI7XCNO9dgF6eselPatGSS24Bht78rd8DSBKf0K9X69bxhr1FhhBmUv/dJfNUmwoSF6fPV01aIKlGihYCr5nHvXObIkx3C7ZLAOK6Tq+IAANRig3U07triOKQ2oI3cDct0ClvrkH6xPfKuXfHnEDX5JnofgOA3k8eDYyNJ/++RUnWjaeN5HB4yKT3IhMsg7cFdGuIKrd9Mfp02oKzCIvnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ogcpb3x66HrBcq+Ut541m6hUcpxQHbyFt6j76eY7+ug=;
 b=1F6LOD71KyMy15HeqDFkAomr9JqLd8rERoVpD6nWfieX9cPvexJblp+L5egzwGGQdG0Uajb3MO6Dr0SYlV/e/2OdwPhYImUdzS3EcfIfsKcB0MqoYEQAjnlTxCUXzvnjtZx7eSoxDAkXoMd4HpwCBJdR3h7tMW5sT8UTsFUD74w=
Received: from SN7PR04CA0171.namprd04.prod.outlook.com (2603:10b6:806:125::26)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:23 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::78) by SN7PR04CA0171.outlook.office365.com
 (2603:10b6:806:125::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:22 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:21 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v22 17/25] cxl: Define a driver interface for DPA allocation
Date: Fri, 5 Dec 2025 11:52:40 +0000
Message-ID: <20251205115248.772945-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cade19-40ef-4880-9ff8-08de33f4e49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I7bldcEj6DO5z2dqUIQ0k4D/FClabcl9IjGbHPZnRZyWmK41om9lIYA37vC7?=
 =?us-ascii?Q?3Dxm8evvQmAp3XOyFeI4WX79dXj6vArKmxChmik2HLbAz3XUakFBAflJd+My?=
 =?us-ascii?Q?yIz4JCOGWsqtDvzLNeUoP0GODxgx5v69bPk7630t6MqGnNiQ6PUrASWzCQJa?=
 =?us-ascii?Q?t/xvr8C0ogQ9o4Eig891M3Eubpxp70aIDoWsyFpbf6W+kSm2AuFfyul69N4E?=
 =?us-ascii?Q?TOibgzfkAcYbpBeEA9UMmdquGXCJbiPunwmCCp+M+dIOc9NeWHyNxae7e4ek?=
 =?us-ascii?Q?NsVR9g6WDK5ZgEsfUJG2vOl7F3o+KnfctL4s8ocN1sGh6ppqOqDdtMk1nvKo?=
 =?us-ascii?Q?OVleqh1DyWTdXTPjsVrz2IMz+0SwvD5FHsVtTNNlaYBJH5M9UqO7aG4bVuIt?=
 =?us-ascii?Q?4XCHHK9d6aTQXhI0YmP/3rE9UqcMIie2wn+iYpEwMaJXrFCP9c/aod74DKj5?=
 =?us-ascii?Q?jAagrKZ5YAMijU2CB5wVFOAwLoh8qd7Xvz3+bl4OHMOArlhhDFDb0o2z6bGF?=
 =?us-ascii?Q?obhmMs+rMeUebyORDWFFgSxBesIMP5mX3W6QfMEjzqrLT7gMAVgQQBQyawG2?=
 =?us-ascii?Q?qIg2A355n0oH9naqeRKusIaAfuauH2zTJAOGM4wyVvqNXMiY9vEI305rgYtm?=
 =?us-ascii?Q?y+oljrnGqG68Fn9JN0WiokCiFBIabsQ3SEGWvQVuVI4a+vDkLL3icDnmZVfA?=
 =?us-ascii?Q?T2e5nMIQmNjK0TqbPMlx/lpH1JBJui6MvXfK0YjD8Kv2DsQlav/qUqV/UOf4?=
 =?us-ascii?Q?8p0sJQhpKwZHkcThN+uUulLle8f9WzRWgzztXM5Dk1d923EZzKpormdCdA6p?=
 =?us-ascii?Q?L0p20Vek2NYUYeo42DRq2GPghiNCFZFLH/ehfjw2eCb+phj+oizPJ9IGswfW?=
 =?us-ascii?Q?ISqQle8uwvtzUWFAJxkM6NC4heumi0h/Mm8wQbcYkGCU73pVwyEkv1OZcYO7?=
 =?us-ascii?Q?0ty8lKDW6OsHkfi8cW3gWEX6tNT8Z6cSwY6in8LTKIcZArSD2OCYxpBDMpNn?=
 =?us-ascii?Q?a5UV8VK9sxMyQBxLc7DcUK5bsGbfiq2J1mvsw4/QN7zOcRXQkmhL5vw/RwQM?=
 =?us-ascii?Q?LZ31a4v4XFIOsTRlH7IEp8MfyCtDSfGG1LYdl39HloC5pOBEuUM07MZVNWpj?=
 =?us-ascii?Q?Fu4jlV8JHKGt7jswHBpRZVHIWryP+IU5/FvYcv6+BKUr8qeCSYNqAW5c+Pfy?=
 =?us-ascii?Q?UE6SGfqmKZuepU+EJRNjKVML6+yc//lQa/PGimbEgQxzHehewcEuwNSpUgp3?=
 =?us-ascii?Q?vfKECrTxS1T7CPKY1iVO0PH4ouYEJ4uA2jwtvhzMXlirLPvi1fKQvS4OSyE2?=
 =?us-ascii?Q?UkViYVMfwp1wQTymL/EARdZL93Cfk/RgtbRYwsVaQNCHeuQRdQsMiAthFV/k?=
 =?us-ascii?Q?qgpC0pCpI53108htRSF90jIwZaDkGFsSS7SJKPiOrWaTYRYqJ5zrr5kPtlpc?=
 =?us-ascii?Q?JQIGzQnn/Q3fs+eVJ/vDo4SZukluEYFMIf77Cu5DgmVZUCx27JW7khZ3Q7Ut?=
 =?us-ascii?Q?dy9litUnEHdRUBG+PVkddcKtDZLELCrWAKKyw5hLEr3Dgn/wSeTi8p0Fb6Iv?=
 =?us-ascii?Q?wCdLoWp1fLnoRAMQBSbiVaRc3BBTU8ho0D2KT3+X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:23.2970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cade19-40ef-4880-9ff8-08de33f4e49b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159

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
index fa99657440d1..5a2616129244 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -551,6 +552,12 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
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
@@ -577,6 +584,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -608,6 +616,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
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
index 6fe5c15bd3c5..7bd88e6b8598 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -285,4 +286,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
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


