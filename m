Return-Path: <netdev+bounces-163053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB0A294D5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008453B3B57
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AF1D89F8;
	Wed,  5 Feb 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AE8jmyru"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30944186284;
	Wed,  5 Feb 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768828; cv=fail; b=cXEJeN7Avs2xLtG9UCJnLtAnUAR4d14tHPhyFU8Px8qR8K5yFEB+7Gw1teVOKIIhSA0WiYNMaClpPfIBMMaD+98M+CRZqzUGD9OW/2tb8Q/wGQQ+EIiM9SKxIqkp0oOp9fSy/ZT5Zm+PFJDFUfsvLXkvHFPptteHbc9Qf0h2jAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768828; c=relaxed/simple;
	bh=ht43CWK/Y4syoFGfJt97VslfwjG/d9MjlY4dd921qTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ln6zBfk4ksLX8OywcCzIA20GWtZXnrP+RYATSES4MMtKDI5Je9u5cobWySyB5DcWCqco7l6XF0Sav2sxZNctX7SPp82cuPakdJAYKRBe5A6/qqWCywUfWv4eX0vR2WTKtNHRNWy4t3d6plWz53PrCaIflqU5aRt0sNdV4+2pPBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AE8jmyru; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FISmMg0oF6JQ9mnv4lUSzLX3RGV3S9TRqAaCrAb399peB8RF/SRRgFuhSCGXgmHQjPRtrMi5n/KNJAFZBb8BVpiXYTUDx75fHhs5lAPwOO/zNMdxK3TqkUoga/qKZXUByjzeCySQwtWiP+TVPlWLbKF0QbTJhC62JGOGRhLpcLOE2KGIx5bII4dbOxsDi7+neDf8VayUcicXfy3td40oSVzEFEJVIu86t37nKARF7BSIYbtY5M9eCAUYclZMzGb9BehYLjWrFeWPusbneQyISyRF41nCqGtuQabpO0cW0o4gnWYOqXF9L9JyaT3BePOblarIHJ8YRKMiPusyXIVCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/FkiTg9LYoEmKvKk4X9+iEdbiKIaCoGPLQOC/9FOsI=;
 b=YCUriT5xL8GIt70YWFKNKPXogWxPMflztHW/k7zEpTt3b3P/djQP/Ai3fdkKlUyC5nEq3o/Rrtn/Qaxgskz+Ko34SDDGJnnQsH1eXSHc7wAR2gA0yc2FPayv8kDwuk9O4rsCJ38H0TDklZKIrT75VZloRPuKxeV3cvhcxuD5j40C7M68o4VcaeNxMtC9ABnUoi9zLyPWTeAhcvWWHFuQQK+xw1NNPu9a81wKee10U5m7ZBMUSdZf4fmR+Z//fVDUlEMw+yv2R1z5eh/m0AzCi6GG3h8xB/KGn4AMsiDPFDP8jr77/Ld05sHgY9A6oZB5GXdUXX4coWQSnToh7mTnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/FkiTg9LYoEmKvKk4X9+iEdbiKIaCoGPLQOC/9FOsI=;
 b=AE8jmyruk3OEQWFyRT2cepwbpix74agyhr3hoExU8jLrivCS+Ckruc4wG/xmwaa+tJgV1PPET8awMQyrTwbQ/WATt/Gjz8EZuOVVVWINUB1VdkxH6MYR+oQTx6CLyl2vefP9Hl5dZo3qK8PyoOpecJMoUVqIuS1ictVHwgUbEKY=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 15:20:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::af) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 15:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:20 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:19 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 16/26] cxl: define a driver interface for DPA allocation
Date: Wed, 5 Feb 2025 15:19:40 +0000
Message-ID: <20250205151950.25268-17-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 257792ff-11de-4c01-4cbc-08dd45f89b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNmXmcLyS/ClasSnW/NO78UdfErwk1upH+4l6BRpBCWw1my2yLn9nYAr6E1W?=
 =?us-ascii?Q?CkzkpBlWQHJTVRfR0icnxxXUSbukIiXLJo21a+kmLKXuO6TDhcfK8hkV2vN6?=
 =?us-ascii?Q?CCUExYtDSd4CssK6ZXMmvq8Yv+aZqSkGyS96YbfV59pc9SsEQmEdp8Et9yqJ?=
 =?us-ascii?Q?UYx9WejQvpFrR0C0HFcvaruhnwyyMbwvlPrlw/GOCgpx0gNG09ej6/Vckr6Z?=
 =?us-ascii?Q?FZxUFQlwcMZr4pJndkvdiP9CtI3hpeK+sS7SqiFusrjIl4J9xbAADDqJm2QH?=
 =?us-ascii?Q?OmHPwp8dMyW/VsAcNqk/Z/JNvO/NAXIv9cBbvs+rp5JaboFYm6/be5qi9uAm?=
 =?us-ascii?Q?VE35JeKSqYwNsuwzTDb05UTs5c0ELdz5sM6jBWy191cH7zZ4xsuVnHzwsJ8J?=
 =?us-ascii?Q?u0RfUXmW93/JBs6hVXOMScKcG68yDZqfhY3cRSXtVsIjhj7sst/iFRz5ii0I?=
 =?us-ascii?Q?dEENBQGEIBj48BFcC2hfbdnmmhYpeY6Z7v6UEjNBCD11FPKmj8N2FphPzYd7?=
 =?us-ascii?Q?eZlBIOsV5EerdPpbs4hqH5msZRx3ivnrgKWkaaxT/VK9qBX1D7MVWdbgQB/W?=
 =?us-ascii?Q?bZwvVJFJdNR82zNRONTidYYRjvdEMpD2svR1QaHcrAk5VrMnHxw/eoLeajG0?=
 =?us-ascii?Q?IJr34pUkJZlj70hr9dWObup+rPyPRr46x6dhmLzsI3Oj8MtDBdcwo1L4VLzN?=
 =?us-ascii?Q?hdQHwS48Tr2SFGdjcZwpQn08B+Kr5T2pnGiuyUY6kDLEWRRe0ZPxjaXhl+BE?=
 =?us-ascii?Q?QDT7fNQ2lMGnHaQHvAGsHqODVMe+HtOXWgToCMszne+Nsprjz51OAMAXaiKp?=
 =?us-ascii?Q?g7ZttEXTVPgooJcRIuH3aPrXaxXPaV7YGoHckCoMVobRDDi6vVe31tEmfQGT?=
 =?us-ascii?Q?nLp8YrQ1cn4FjMQEhKzNqSTCJ7o3yTy3K2N7D99+nSrO6mjcTL7/R554UMvy?=
 =?us-ascii?Q?xk7LfVyiVwP84YcRPyEGNrSuLg+Lmz71pBHLHV8T2nUs3x0nuvgxBf+i9XgU?=
 =?us-ascii?Q?8HLTwgsTEGMIVQ2QKd262cA9jBFly6Ex6H+YkdMGEr4mn3o4EdK0j8R3rGKR?=
 =?us-ascii?Q?uEoVXKkxQq3ZKla+QKQxLBrXyh4WImHEY2nWbk5iwcMpuldDXWU4x5nAfLW+?=
 =?us-ascii?Q?7hHO1RaR2rJOTuRIEeuMzFDXwyAeW5LIDrYbo3RgFGxqnifF4L82tn827OiI?=
 =?us-ascii?Q?MzoM9UPS2jYhUpYH8OQVrCsMhaXPqp/4oGKgZ5CKyvO3DZaqelqfDuOHWWJi?=
 =?us-ascii?Q?nE3FZ5TlBHSJAG8bV6MxfsveE+CMcs33gqREcnfRjbANkwutS9+m3q1bRHAj?=
 =?us-ascii?Q?RzIkkIKoLr5jP5vqs/rzLAIhfY9E/wrdEvLyiA6wDTer1dT18tlOWbntHpA7?=
 =?us-ascii?Q?kktbQM8ZXAc3yV+xHDMv81NTV0yUgpS1sMOjDzWhfoJiyHFpoyKAfbRRTSDD?=
 =?us-ascii?Q?HHbzUZMsiBL77aEQOgD1Eu8XTNbemfHknnrdcNqAarSlShDIRuXtTYVBp8Mx?=
 =?us-ascii?Q?r/cxnGfUxGqseJo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:21.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257792ff-11de-4c01-4cbc-08dd45f89b2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

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
index af025da81fa2..cec2c7dcaf3a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -587,6 +588,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_dpa_rwsem);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -701,6 +703,87 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
index 3b72dc7ce8cf..3fa390b10089 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -90,4 +90,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
 					       unsigned long flags,
 					       resource_size_t *max);
 void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     bool is_ram,
+					     resource_size_t alloc);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


