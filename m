Return-Path: <netdev+bounces-190426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC98AB6CAB
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6538C75AC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CD27A913;
	Wed, 14 May 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QBxdqIKo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A06277807;
	Wed, 14 May 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229301; cv=fail; b=B7GfwVv45IJUDxzw3YWM6zIrY8UX4Ai/ar5nPZ3ViNBENrcQPq0iwBp87mnc7gGUJ45Aj8KtJWx8n44HkllipjCWy1ewozUg1VSm7rxTLH6FxmOXgojNornGB0aQo6kzflAIUA2JL7ZHRA9eUpOjF7KRVeXPOXtVght122hFcvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229301; c=relaxed/simple;
	bh=hSC2jaMVQiEbdb4sajg27M2s3slUSUv22RpMYON2CHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZbD2LFrTaD6YzSI1XfCcnVJmhGuW0Ik4POJybo49H90s8IuC7txYk7ppKB2zxyyOuyyUatf5PSjx2oL/DTt02y0V5oU9gVMEO8FLkr/rlrSFs/GwtahpggjHXExGqEwk7Kjuy2Gsc27t0onG84w8wD/83RTzA5eALKeEVbe/UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QBxdqIKo; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlqNC/+ggloVxn9qN3IHaBAWmiLabrhwTwLHo+cN+Jo1ab4+lfyT+wuXExMc5VAIrCsf9aOe/xwHeXDFcMCTCRar+ATLL+aonekGD3Gpmv+cUhargJHtryHQayJUYEEUuW7nc31TQtBlMlv0aQa69FpUZ+o2b9nOIIG2x0VE10ux/CVz+fV/MQzCrt63u+Tcz1nrk1G+ujXTK818KxxKxNFDHOd1J6VTr/Pr0rfDAwHNBmYC+hJ04zDFRrjiw+oC6HIHwa+R9RONCUC+F6wmG4TDlIFHEMzV2bj3C+QCw6OMQ/8yVRN1HLmdsvjGXQs6dvJc76fawQr/wAMMQ+nbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/vb4oCdeUsa88mtQ90tsuy6TtkIQXw12lSstj9jSqw=;
 b=XZLUv/tkTID53bYeAPlY08PU0KsZF4N8nHaX0+SejMQBBUU6u1MQss7/UwqxHY3MSqTuEK9Lmz6jHP9rXfJrKwDo4ClPDg69Gj49NoHQQbfFSSSZ1UM93DXluRyS18CBz6SRgYKCf682dyi5xgYoxz7L+4/1EYWDg+w2/tUGFh1DOGH2tVxkrsaLwr/U/bOhIT/SLlmFw/GHPW6vPxLIarm6CVNBv0xD9kgDPpkncze6tFss9abHQRdLDRYdXLNCQqGr4JmAOtiEs5YyqB5XWosGoxFtmJPeELchE3yZT3xvunOm2KghrZx+doQNSsFj1nHCrQSQZMFP4hmrKKB06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/vb4oCdeUsa88mtQ90tsuy6TtkIQXw12lSstj9jSqw=;
 b=QBxdqIKoFaoO5r3ays3vENecT9RhPKTD429MGQ7M5hNky1bdCxkl5O0MsfHsAqvctutLI3O5P9i7hyMpGadky1SYniE3QJyXIa8FpCyZmTf7pNUyOE5NQYJZWrMEthqh0zmxxd63oSLThaRgka1g8PBI6XDRaNPF78wngVO7UyY=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:16 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::60) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.14 via Frontend Transport; Wed,
 14 May 2025 13:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:13 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:12 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 13/22] cxl: Define a driver interface for DPA allocation
Date: Wed, 14 May 2025 14:27:34 +0100
Message-ID: <20250514132743.523469-14-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba0a71c-0117-4348-8b69-08dd92eb2ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B2sF5Tad0LERiH9v/MGEazkALwxsswsk4PjZn8E/jG8JjOlb6LsXbxD/kIVQ?=
 =?us-ascii?Q?oeFL3rjszcR4LXAex1AX78awrRHsiETeGn3zs0XudYZUiXeN7X3csz/A9crj?=
 =?us-ascii?Q?HWe3IImOErG+FdYZcRL26C+eShm8btY23EGoc6mqubBT7opH06fCrJZgq+lY?=
 =?us-ascii?Q?Tys4K5mRYzhyXWRKhQ95sjd0tQEGKa9l7WInsb0w0t89EDN5Fuh4aREbrgI4?=
 =?us-ascii?Q?TIpARi7usX42JLLDQF9MTWm5QwMfZBcVmWJD3lAYfGwk6aJfMtgzjI3Ef+Kk?=
 =?us-ascii?Q?/6q2UzsL0veeWGj1ML4zC0B65DH2pRXhRB1g9gO/HP4V5V3dpcQutwiVT6Cx?=
 =?us-ascii?Q?QKHMAR/23mLij55yI+fXMHCTpm7eyMUmPjHe4IjwRiqod3JYgcGxdOzn5Z7Z?=
 =?us-ascii?Q?D/yKY05wjKOsbYNNguLzwbHqI7zPk8Q7lw8Vbnku0zxMF3J8WoEg3KF5etI7?=
 =?us-ascii?Q?oP6JeuVmq1YsvRYYeF412AxqTbRVp1SZJ7IVpJW062Tdv+Gxvsvlrzn+ORb/?=
 =?us-ascii?Q?tDuDFr+zfbGr015tKCI/e/DVAuD6uMQk3re0m85PrfY3dRoJ0XYMU41gke3t?=
 =?us-ascii?Q?pS7oq5HbYGrDGurnW4ZqR0Mb386p41nwPZUxnyWwNmTS46GJ8nopjhkPJlHW?=
 =?us-ascii?Q?O907ziZUMv8Y2dHKxw6ky8UeKwtRaORxIDbIlNMFP4MrxvysTQoAc4QbU1XG?=
 =?us-ascii?Q?yHyXRI2ICfSV58tf/2rI+aEzmPV5pyV0VDONMacn/66AloB3+gDTilky/1lI?=
 =?us-ascii?Q?4rdt5dOY65GDkvJhMrAIV0uy9XfLXSfNuYM7BSdTAGVmuqiS4MOLl+3Zom3L?=
 =?us-ascii?Q?GINie8VMxFvn11EWjpK+ATov7bubBymmK89gp/vzxGFYO/KRhSNU+moG1nZA?=
 =?us-ascii?Q?TM+dTDfBYCYlkDspI4YkqFpG7bWxsLwz8IIom8LO0hzHEn+A39FlrIbtEFKL?=
 =?us-ascii?Q?fEP0N5aQI6XapqooLuvT8K4pb8fzV3T1KVvCQ5JMOR8zZ9CG9Z6S9IKVSbYV?=
 =?us-ascii?Q?b2NcrqvXvYLzjYUKdrsv9OUIkHjqcDt/bNW5hxNjNzgZ/qXzt+XSuv1Wv97G?=
 =?us-ascii?Q?c6SBOSa6YT2U8PHEPYP6oj/KC1/xd77F8SJ2c9rZ3QQaRcrc6ssNcRMmQ+6U?=
 =?us-ascii?Q?PMU3N85Db32/PTJBzTcG0Tql2qFbA4xjEPDHq/OjN6J+sCy8MX/99ETGEBup?=
 =?us-ascii?Q?wL+cwVwsv58VZQGKrrB9SMVgadxz69cCL5+e8JVPc5IdWmzpyvg5QtOd+Wc6?=
 =?us-ascii?Q?YxW/Otg5Fp637X/uEMr52JRe4ygyeHnbQj8eKHjcF6nxhkxIgrG/dqQ3niAA?=
 =?us-ascii?Q?PZG6lt062tbGjiC1nvSocPYmYCr1scoqnIGX3mdiETWKSwJJaqMxauNummZ+?=
 =?us-ascii?Q?T0kQDsLv3GzoRIVoKAUAhCbY0uhkOOMKfjkA61LipbReIkBS5cQYQpHW9PeF?=
 =?us-ascii?Q?ZSWzBiobzpxUQBHrUkEVhuvv3wgkH6gf5ImlYofUPqKXjm4dKk3HUymmUkw8?=
 =?us-ascii?Q?O0PR6KfPVpSZtShbzW+bSK9OQUt3DnTSQ6YQJ6HtKbZBswBYo5phUnk2+Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:15.7717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba0a71c-0117-4348-8b69-08dd92eb2ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376

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
index 70cae4ebf8a4..500df2deceef 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -546,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
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
@@ -572,6 +580,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -686,6 +695,83 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
index 489faef786c4..b3ca0e988ae7 100644
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


