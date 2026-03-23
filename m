Return-Path: <netdev+bounces-270483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II0zFcokwWmTQwQAu9opvQ
	(envelope-from <netdev+bounces-270483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:32:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B362F140D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CAB93012850
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D5739098A;
	Mon, 23 Mar 2026 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tsUM90Px"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF61395253;
	Mon, 23 Mar 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265531; cv=fail; b=oPPse0/YW4OEuQcyqsyWumoFfCSy65vICPBnBdcPmCkiT5fH/speTkoCfs2OfuBEtTTk1ZGHOzgdwZGSC9VaCcy0v8v1ACE8PHEYgxi2cmLtcEaqHTjgKVVRZQYZHEMeQHn9TxoqfKGj5eEx8dHUax9j/C5yr7Zxmm+BeKUhTdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265531; c=relaxed/simple;
	bh=pnDxxH860zweNIxOtraP2NqKmiCZxv4AUwjUCHQ7VB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6uMXdfC1T0f5xQIDDmqpLdn4zfMCPVjs+SryQVVFBIs2SllZqZpx+WtiX1MmV0bjHFeqDzn63q5cNNp36t3gn8/5y7rMsRg0yuh+KKr0OVe1TMjw2Nogp6qp6VV6Hk1XKEno/RS3uVb40tmYMImMZ/I+Vt1B3Vl2wj+WMy2a6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tsUM90Px; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y12+hVq1/VHJ/LiVTXLKMowNQetafsXWJchOhY26SDBIvz5x2uBMwz134OV+hnRAr1WuPV7td9XpT49T0BC9PWGW/+5Xm3oTMYggd6XptrNogZIyDCAO+OENNOiQ65DkN1y6N/SAUILX5REux/0On84ZBch77h7O64uxGX/kJMqxL7fvbib5WjYwhxXi+2YA5TWV5m8s4shcc7Z5CvPkyfigYv5Jl1GKsFv4qzKsmvTXdUxdDLCeMqrN+PJu/oulokfgYKN6C46xqal5Hb6rE1gwbyi32saGu8cyuB9FHrwDAi8ka/3dgHRHodpoOponnExznw+MIWAOmedvHpe1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbUD5fXmbR5LEvU8M8WiheDV6yL6b8efHuXS7Jpm1l4=;
 b=k9aqSZKwBQa05rrEwbPXaQLLlTNjdA52qnHZ3JubXARiQG0hgA8LcdQLCIx45Y5nNg/ksLkGs6rdUmwTQDX6OxSsplrxGIpC9fhiUfpRsFy6CLxiqkNCxHWyvUOKiepPVtgPYNmdX4ToymH95H7RJvsnOO65JouCUpvLWgHMq+DA2yvrQi7XbsTAcKrvViVVi5Ycyt9e766ZbnbRvfrsvobcrvTTBlIfC/nAogJOH/vfhwrlBFrViMH6LQtWkxSvyqgjOvWJbet1qpQ0EtgefJIGM2HNwYAlXP92xys/Ji4QrHo82LxdLJzS89xFoRt5br3SApeYvn3iiQ2DsYmu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbUD5fXmbR5LEvU8M8WiheDV6yL6b8efHuXS7Jpm1l4=;
 b=tsUM90PxisScerqx7R/27gDN5eezjDzQ66/VLXllHWAEWQLx5qIjmUfjZCC6c8HB5SSIJrjCEDfSX3kWuv1pDjImGile6W5ddiRy7P8eZB57uaMFgqgGYmOzH4eJ2i/yB3b59wOD7+Yqo9LQmLBnu8BqOPyQb/qLiudvuYALJPE=
Received: from BY5PR17CA0005.namprd17.prod.outlook.com (2603:10b6:a03:1b8::18)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:05 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::67) by BY5PR17CA0005.outlook.office365.com
 (2603:10b6:a03:1b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:32 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:30 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v24 04/11] cxl: Prepare memdev creation for type2
Date: Mon, 23 Mar 2026 11:31:10 +0000
Message-ID: <20260323113117.2352709-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b48a6e9-b6c5-4fd9-798c-08de88cfcf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H9wlsdC75Xn/xUaDwH/Mobz4hv8ECbKOtE7HV0hNjNjHobnC+3jm6wF/Dey53Z22CydAGWC2UlhU3clbM0v1Hrz5aUFgmjESidb0D9p0gyJox0cfMiOgeQhjn3ks8SSXyHohXYjo+mjvkUmQDYVz/xxv8NolS0h181PS70iDByN01hT/4QLrECuEcMbGcbCimY13asgiPojwYEDkneXw0BMSBp7hpAxP2+CW7WSteo5tIXTs5Rcjj3c/+BKFwO4yCz7IVtCEno9cHNkiVePNy17wgi6fkQ4z8tlSWmSqmp6YykaBs3VLi8nRaE8HPPA0a4c2I4is0Ej/S3YYF1iiOm0EFiNHW0BLp9x/NZUGn+UJ98DOmpRcNGthS1DVSXeY39fLj3sE5qIOkAS+x+HNS20vOQseQh9hT+3RSVTk4o5xTYEUfDg21WpuSxil4cD5BNwiem/BaSdOFhdAOFi+YIIyY5CNGSud+sOFhPqHLDZ5uBzeg/wsj1WDbq6y/tmOa7NvbgyguKALWxmb+py1oI8+dZCM91bHINoWt8r0aWd1VYrTv5aHCYOM7J3JKw5IS/1psFvSmUmywGXpCdsnS+W1jPEIIogLFQGjYvB1YrQ4Ce2+wbQPqDWbJ45ksbxeFGrhCmxHcqp0hJzFXTsclJGJ/pnBubdnWosLd+pPZhBOFHzMGcx2eystB0W5fZmYCpxyErd41wh57UZ9c0/YK2cgWYYAqgu0+nxAd7C93/4sfXMzH8th1ER2HuMuginpoAxQ7kyNh0rXxNVIUGLnqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pW+By/15TsHWBnhNISF2T6sgJrLliBoPnpK3QC7oJhgrdrF5bnFXqQEiaCupTOZfGjSTHxjIYspmaBvijdAPD9fl5DbiPYhbYGSMmKwmoKStQUNm5w1DKyl+rq9WaSvn0xxb66uVjMbyhln2EANTiByZsHDqWlGjfgpIUaBZBgJKw3wYUjHMbRc7jbH3SKF5Zs/hhom1g0hV+dgWTdEyiXsGU0itL64R3/+1UqZ3MQyY0sX25WuRQyXCFlaRmI0ZsK+qczkFEbDVOnQJnwMTV82m8bCn6cw+l0fO6e1Ic1ZKX/d++i+aquS0dXM51r9vCAqFfOgp3EbPBPJerYWGDthh2ipyHkcKeEtBK8iEWFxaHc7AqS2g0CJIOvPB+47lt4Wboob9s6prony6SWYLeH+p7ux0nrDdVcIfK/I/fLvub1SBnEng5TJ3QDn7x6vg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:05.4245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b48a6e9-b6c5-4fd9-798c-08de88cfcf93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-270483-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,intel.com:email,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 30B362F140D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accessible from an accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++--
 drivers/cxl/cxlmem.h      |  6 ------
 drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
 include/cxl/cxl.h         |  6 ++++++
 4 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 166ec6b7d041..759b43364ed7 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include "trace.h"
 #include "core.h"
@@ -576,9 +577,16 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_accel_memdev_type = {
+	.name = "cxl_accel_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_memdev_type ||
+		dev->type == &cxl_accel_memdev_type);
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
@@ -773,7 +781,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->parent = cxlds->dev;
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
+	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
+		dev->type = &cxl_accel_memdev_type;
+	else
+		dev->type = &cxl_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 281546de426e..c98db6f18aa2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,10 +34,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_memdev_attach {
-	int (*probe)(struct cxl_memdev *cxlmd);
-};
-
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -103,8 +99,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 
 struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 					 const struct cxl_memdev_attach *attach);
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_attach *attach);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fcffe24dcb42..ff858318091f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,6 +65,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
+				     struct cxl_memdev *cxlmd,
+				     struct dentry *dentry)
+{
+	/*
+	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return;
+
+	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_inject_fops);
+
+	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_clear_fops);
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -92,12 +112,7 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	cxl_memdev_poison_enable(mds, cxlmd, dentry);
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -206,16 +221,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
-static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+static bool cxl_poison_attr_visible(struct kobject *kobj, struct attribute *a)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (a == &dev_attr_trigger_poison_list.attr)
-		if (!test_bit(CXL_POISON_ENABLED_LIST,
-			      mds->poison.enabled_cmds))
-			return 0;
+	if (!mds ||
+	    !test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
+		return false;
+
+	return true;
+}
+
+static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	if (a == &dev_attr_trigger_poison_list.attr &&
+	    !cxl_poison_attr_visible(kobj, a))
+		return 0;
 
 	return a->mode;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1346771edc4e..10a9b8fa2f6b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -149,6 +149,10 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+struct cxl_memdev_attach {
+	int (*probe)(struct cxl_memdev *cxlmd);
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -225,4 +229,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 	})
 
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_attach *attach);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


