Return-Path: <netdev+bounces-178320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB18A768F1
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D12188DB67
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E4821E091;
	Mon, 31 Mar 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I687x+9L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04721E0AD;
	Mon, 31 Mar 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432394; cv=fail; b=AFNFC612R11uAteebREv2M1g6VwHAKJeintiHeV3+EaFDHZg3/6MoH61dXx32ILn/Q9odc4a6OEOhsUWI/7IdwZX3tu95fuRbWVRWDAWio3PJHGE1FStG3PhdViI7uUd+TTqWnX1ZSV8k3qU32ZGvn859A/XqosQW7OsflNDjXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432394; c=relaxed/simple;
	bh=dL9H6RFTnw2JmnZTOSzQXwdZHSRSGa3KTusqpSB4U/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJ3YyUQog6MjsXnIB320i/C4HdxP3mxAQDFXTrVhX5/AMWDYvdywA+bKCkNTT4GfK5gE+jGI8ZuWW5zFJ4HDFPwh5OUN8ShxcvaRD4UkyLB8XV5HZhzAY44A1KUy25lbsFGaMB8MCmUPwVsGjUsFZIu5Oggd/FJgJxygWgvcpfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I687x+9L; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIAEsvDMbMhW/SZFf3jE4x8RQcinQUKn6H4kfIja/dofnKzg9ZA/0DtBwoWuY/FQYn824sjy+67Jt0AENuoQZcjoet6vCcd8BUeD2I9UqBWVTSxE9YfnRyxZLmxOAWKzuE/1a3enmYY3RZL/qeeMRMqmBrOtYQKIsCcjBypgQchjq255Emx7MRiuhNU+y2Iak/jVQc/DLjf/Izsw8noibQ8z8qZ6YwhnONOB6uryWEy/ssa9SDKaeDyrLH0rzvFuNPln41V+npn/bodOyLSn4wAQWDDS+xOB3J9ZvKhc2kAouWKu7yq1eQcjc1mj0exvt0Kpztz8cGvITzz/ctj/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9LRC+pPZmFOaeR1yWa6MNqku5ln+0+O3P1Go+6BSA8=;
 b=kb+cRFnHrDtbOhZVR7xkZh9XXSDoc+MCuEU8Uotz5iV9bBsqgqFAwu8ruc4Rr89pdAif99roXsCLP7YZ64tbsLneP21IKjUDZgtXB1+UOE2bUaHyp1ogf8cDYqT8O4gLFa9gvkpKfnHGWEsdyYibzxVpnRaH/Lto1mHsGqzZGpNjwCnD8mwhxgKFsG2ZCzX86S/BANEE3HO0DGRH9Ur4sOJYPkSI4uvq8c690OlxMrMMZ+/Ut/WtCtV2tenZQryc7CBKNv44ujN3ELTYGdRzwU6BGklhtaO2NVdP7LJIBFLpU0H0uoVlNHiX4JrSPJmmLs9LpO2JMQzXnW6xsHrGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9LRC+pPZmFOaeR1yWa6MNqku5ln+0+O3P1Go+6BSA8=;
 b=I687x+9LYRNNBPgxeobbaBqxdT9x+GvS5PT417p4G5h2leuOaj+1457v68+CDr+d4G5F79eeoZ43ZU2FfVyd74aH38d+OiQ4Xlm2NOlFW7F88jLRqzsVEYZLhLUxr2ziQDuFsxMN7EMbYzxRqBvncFjHtirG+/M+6D4GvkRDqhE=
Received: from CH2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:610:58::12)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:30 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::5f) by CH2PR20CA0002.outlook.office365.com
 (2603:10b6:610:58::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.37 via Frontend Transport; Mon,
 31 Mar 2025 14:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:29 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v12 13/23] cxl: define a driver interface for DPA allocation
Date: Mon, 31 Mar 2025 15:45:45 +0100
Message-ID: <20250331144555.1947819-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 425f3e0c-5f71-4c9b-994d-08dd7062d2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|34020700016|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r8bhUmf8zCsbWAAUmvgtBVWpj8FbZ7FgTLWsR5xUnHPhrDnUCpWsszdRZg18?=
 =?us-ascii?Q?54Q3xM3h4edEBSZ7NiSoAhEKX7Jn841UIN7bKJlyaAosAnWchVz/U0s7UbvE?=
 =?us-ascii?Q?TURW1Dsc9Ku9Pf1hX0TD6C7TofLeelLvMiVi0LaCxOQFdVOInJDaX4baD20b?=
 =?us-ascii?Q?Ix+QchfnGbCTegLPDYMwf/tVHEKcvcZWConpkSN2WrwmQqPqj98I0ve76UcQ?=
 =?us-ascii?Q?9HvNdVbPq1dCQaZw0OJhNNzma2g06fGqyQXskSgD0ch+Oeiy4cH5KDWOXXTm?=
 =?us-ascii?Q?+Kb4S+gS2PqWzJpk/YZVCt7OOxQ/J2bMaIjiFP56FCh+GpQPeTIrwptYvC81?=
 =?us-ascii?Q?yGnYIQeX//XfFDcTzD7p+Pd0MzBvyxU2tWFasd2UvifJYKkZz9MUUT0Vhdk6?=
 =?us-ascii?Q?eIL5hOVargkgJaJbq0GHVfiN/LMAu5oC8Z8A85qTsZkavFOn5Rj80srJdExZ?=
 =?us-ascii?Q?OvejM8tOUkd50vxYqlelE2nIUYo9MGYKPkH6bIbghR7k/ZWtY9RDTRlaYQYv?=
 =?us-ascii?Q?JEKU9y3Fd+zZ1/pG6I/BVPfRvozkcgqkZZR7LaJOjwCPd0AXvmKZJrJhZIjs?=
 =?us-ascii?Q?UG32SiUinQpYvLW3psMEhkzstsfV44lJDmM2qGf77Q40Kvo3xRkZuIadRniW?=
 =?us-ascii?Q?43EX92UadWm2B5BrFK8Il5+BciXmW3bH5TzVWzZruFTSqxclwvCzEkVAmE9l?=
 =?us-ascii?Q?LXRcEhEijUGheLuAzG77kLQkLtEOUQXP/CycdZqvov7qupquWr5OjY3u6DxW?=
 =?us-ascii?Q?oyzifx1LGAvDn8aJNZtyVbjbIwKCf73Vc0Jvk9VKo5UGDr1YBtka7oopNvcn?=
 =?us-ascii?Q?eR5kyD99UAR+jMtvYV35qsHIL7QamWxqcBkHKoQCSLod59siAjluA6SBY3wB?=
 =?us-ascii?Q?NBsr53nFU3dqJZsadUrF+q1Qcvyk785PiniMJLcX9SLOYnA0pIGCddoXLQNF?=
 =?us-ascii?Q?zK08rI60SDTTLuS0EDxAsz7N9V9sVTitFGA2yamp3b8+1NMJFkYgMyY8nwU1?=
 =?us-ascii?Q?69WgvHJ24l/FrqcJjxIV9S3JRCShinfWra/HDGe3N4rU6KFd3b0+UVWspPUe?=
 =?us-ascii?Q?69cO9PtKeXcOtNqkn5L4D8iOC/m9ELNPiGLXXpcKyD+BcnT9FsByyzKhw4sW?=
 =?us-ascii?Q?tLRG/rbPshv8y00/QzlofdQAgfGvbI/WFj5rk/aFYV/DEe6DHiloe/I7Myna?=
 =?us-ascii?Q?D9uOK57RGBUT199gWPo9tsnHKPCXfqbwQgPFJdCbdLSmoKEUMeh3RafcWFSS?=
 =?us-ascii?Q?kbQ0dVsYCFMelJaBkxVoR2OwSBa+iioRT8W2QAasgqGtRozg+yxOdoDgfS88?=
 =?us-ascii?Q?+EtSlkkZbLcxrZeT2T1bA7k1I30RIG6V4IEh29eiF2cr7XZ6/mgFz8l3jnxU?=
 =?us-ascii?Q?koT6l77Xkm+TSQSYl/SePF1GDqb0M8PXjAp8WBeQrvKvGcSb5VdJHVvJqpC8?=
 =?us-ascii?Q?exwWRXKOobBNy6+6AdZz5gKBZVf5REWdC7EWNJqvewpM16eGlzwnWzHERwWk?=
 =?us-ascii?Q?Aqi2PkFateOPU48=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(34020700016)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:30.2712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425f3e0c-5f71-4c9b-994d-08dd7062d2e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Define an API,
cxl_request_dpa(), that tries to allocate the DPA memory the driver
requires to operate. The memory requested should not be bigger than the
max available HPA obtained previously with cxl_get_hpa_freespace.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  5 +++
 2 files changed, 88 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..db6d99e07d45 100644
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
+ * @alloc: dpa size required
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
index a098b4e26980..22061646b147 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/cdev.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /*
@@ -256,4 +257,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
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


