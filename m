Return-Path: <netdev+bounces-136678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FABC9A29CA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901AD1F22A6F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D01F4FDC;
	Thu, 17 Oct 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3hUNtUAJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4041EF953;
	Thu, 17 Oct 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184025; cv=fail; b=t1zbmoZw1qJrhgYRzHiI3ZHgpkGxcLNPfSb5+U+Kmf9RtP43yIZ4+5QOR77BNf1Ju5MTCAh98gD5VNh+zDiqri4GlOrdvmvHRfuVLR8imsWIIjqWtfJKfyPGVERnJITt6tjNh14fBqO2klz/hySvlbtPhfOXm0Sw4MTfru8PChE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184025; c=relaxed/simple;
	bh=RnRHpAZ/605EWO+M7Rpf+8MKsYPCVKvSaYGAuDXvfuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYHNmWAaXCcwjpJOtRuehY0K27MzRi0JQvyY/ccn2N+9cSfDwUccUo8j12vncTZBtwt3AHRhLN+HcYPQ7d90bm+GqGqOcP11FDLQrFGpuU8rVOJs/WRF0cKEgdWLyzJZ5Qe5hASYRDCZrNGpTly8oFWyO0Y6H8VJ8Kn4Mu59kso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3hUNtUAJ; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcTHblQ8q1FTW3Ne2wrVEWyWjKkwFxr/AaXOigLsI2i03Aj2IdaDEQgfJ29ixI6J3vmAe4kUXfQUoY5vxp3iQQYIvecW9LqAFNCwQY2SkGDXzhP1Eebds5gFZuqnRE5KhpYYOCcZOFZFB8XSR6F6X5fQKgijKWxLvbtud3Wh/tJxqMa5n/Rh6GRQu0O9Q/mXJ429fmR0f2v8by3VPM8xpD7FBpYOuZHf+07NJRH/KCefA49quZApQfweJeWYj/dIhnSNiltPJnO23Aiku+kPEa/a/NRsXF7j90BuQF1ry8pl3EkXjFB9UetKlNZKDZiW8iY2L5/OEoVtJA5mjvzsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rMEUtAu0d5VeqlvUN1s5A9zbcufJPS8L5rTPtHIOMA=;
 b=upFuuY3xVWvXyL9WocEiNGk0BzzmTdI2FD+MtqzFLNsuxu0kJ05hdaIrR8KB3ch9p/8s1ar8JZssjac+3fOIrozwRayQigtK2w3It/yPBBXzuReCau2RljrXWT9d5xM6q5abOqZGmaBZM6/AyVJEp3qp4CL6axihmMg6NI29fyyKHgK0RKUf8jhBVhnGEtj7RkfWhnFI0iPbOhiZ6Gw0Et6pW5Eu98vzea3dSh5eqhQ9n8g/+LgHjqxldBEaMirHfTAQ6auw2v1vv5pZM81dLmncPBBvoVt4lcnIZqtrFep31PmDlebRJOIFNyciswuTfRqOpnfXzim+eHl1zphVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rMEUtAu0d5VeqlvUN1s5A9zbcufJPS8L5rTPtHIOMA=;
 b=3hUNtUAJ7BGKM6c6A3SCOX2sjR6BpQaSyc6qh9GqRa3e4tryhJSrL2NQhi/389bp9C9uwRwMwedxJMcY47lz9R+EM79+t/z85RaLK/A5FWAwT1y6jN0z8jY2mocKGs5vR4L9US2m4zAUUdzbMjorhdD/SsCvEE8urTEfnQjHbQk=
Received: from SN7PR04CA0156.namprd04.prod.outlook.com (2603:10b6:806:125::11)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 16:53:37 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::e3) by SN7PR04CA0156.outlook.office365.com
 (2603:10b6:806:125::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:36 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:35 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 17/26] cxl: define a driver interface for DPA allocation
Date: Thu, 17 Oct 2024 17:52:16 +0100
Message-ID: <20241017165225.21206-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f2c607-26af-4dfb-1414-08dceecc3ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ml55Q0N/XaFq7hec2C4Eshpwj2XzyF7hOwrNSvUB+l7gLagtoruyWXzHaeLf?=
 =?us-ascii?Q?btJLwN/h3a2z7czah4omqM91FNYs+K8b0gYfeM12bqJuxDOsjMi4i+faMAKw?=
 =?us-ascii?Q?1AnA+JMw6dg+7hGPaWM2fa0ZaqQf1yN9t8VapxCNLjlwvbYvHlpmZbBQPNp+?=
 =?us-ascii?Q?zZ2XBFYUarIgpIWCu0HV6yTR4ZWJ69BEkzye5HrzQ1+aE86utTwsMfdkOzjV?=
 =?us-ascii?Q?vvjsd4/HBg/yGZ7BhkncJvujw1FPESNSSepCHCK15mi3dwXhh0vv/rMJKAHF?=
 =?us-ascii?Q?zRSe/LONhb9C5VqAYnTZCrHyAt2OFPHyo6QdXCn6u1XI1uGsPWmngaFeChuw?=
 =?us-ascii?Q?SOTnOM7v7glL4Aa/VImnmvsAxwWlTgOVmbvasfHjeOpEFoiEUtuv1/9Iq1rN?=
 =?us-ascii?Q?6AF7HWDld9aR9wkgM7AG9Ym4Cn38OOm9gXOu41WzwTrAodCVx1lEmQgE0Zw7?=
 =?us-ascii?Q?yEY6le+OkhM1NxtwzcLlUJ+VAAPR1rnK6TsZfihLM/PKo4q+UR+heSqhIh3K?=
 =?us-ascii?Q?HA0UMA+MaQ9TdPbNQBlPLE9NHdtAI3aLPL1iawLqYC85cjqD6CvkOeDDiHSN?=
 =?us-ascii?Q?a3RT/DV6L8jNHJ7Yb4v7SfrAV3gqpLKzaqKcJY4O2lxegcz57zf7aqw+tSs2?=
 =?us-ascii?Q?QMA82zOER3/ou/rtWbeYI/MybCI4ELUiBbfSTBVUifYmuOtaE/yY1LplQnFm?=
 =?us-ascii?Q?dLKrVyyJNkgv7vZoL2rToSI2xKd7Fh3Ss8xub0zt4GNSlK4jbtAqrOZev6eM?=
 =?us-ascii?Q?1oFvbIsY86oEGnJDJZSUONn/LDZfiQ3tzyuBqzAM+o7LQqyrKnnBTeJ1EmBZ?=
 =?us-ascii?Q?mviWYQuAYrfMSK+n3cWWRkG1wQAFzCtffLz+cS6Ml918FIh//XfGyOZCe/n0?=
 =?us-ascii?Q?7cAdxArGqG5ol8fgqEzEMszpWCbPKHI+Sz9B3Quj5ChZCCLdFyZISDgR51Gh?=
 =?us-ascii?Q?bSd9YcLcxjk7KIu9UO2XQ4sFK81mGjimo56Vf8NvdC0z6K5Q3fex0VSVH9VM?=
 =?us-ascii?Q?5FkEvfKiy99rjAOZdU/91j6u4t+7kwE7P9tW/7skF0FzZonvoPg2Q3nJI0j0?=
 =?us-ascii?Q?/oxhcLW4++6LCAQ0lYxSkRYeo/rMYtjZ8FfMWRMeXG0t0HFu4afBf2rHNa+6?=
 =?us-ascii?Q?LIehWoTrIXyOYtHEWJnrDUEcZb8EKSucHFKC0kvjIc7NamQUiNHN6OawNvZv?=
 =?us-ascii?Q?Fj4tcmMa9HcGO5OuTkfN/x6OEXFn73H0yuXZ3jhcwe5rySCrkA5Plq90UExB?=
 =?us-ascii?Q?7xrLjVdMrSX6d9KH6Onbn/zA51p36xTCA3ZFTsydoNqQKKry0nYcxGOzvlzT?=
 =?us-ascii?Q?LDqc+YGPrfMqFWG5OGi+d4ZGaiWTsRCWOZj+0TVhZRzZiTLBcACzNRt/tTk6?=
 =?us-ascii?Q?DPeXSkJe23eNcJuTNlGzjwTM+V2lVyNQUSsnvFbS6w7J7fxaZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:37.2697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f2c607-26af-4dfb-1414-08dceecc3ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Given the HPA
capacity constraint, define an API, cxl_request_dpa(), that has the
flexibility to  map the minimum amount of memory the driver needs to
operate vs the total possible that can be mapped given HPA availability.

Factor out the core of cxl_dpa_alloc, that does free space scanning,
into a cxl_dpa_freespace() helper, and use that to balance the capacity
available to map vs the @min and @max arguments to cxl_request_dpa.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c  | 153 ++++++++++++++++++++++++++++++++++------
 include/linux/cxl/cxl.h |   5 ++
 2 files changed, 138 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c729541bb7e1..d2afc9a1d8f6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -420,6 +421,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_dpa_rwsem);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
 
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode)
@@ -467,31 +469,18 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	return rc;
 }
 
-int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
+					 resource_size_t *start_out,
+					 resource_size_t *skip_out)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	resource_size_t free_ram_start, free_pmem_start;
-	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct device *dev = &cxled->cxld.dev;
 	resource_size_t start, avail, skip;
 	struct resource *p, *last;
-	int rc;
-
-	down_write(&cxl_dpa_rwsem);
-	if (cxled->cxld.region) {
-		dev_dbg(dev, "decoder attached to %s\n",
-			dev_name(&cxled->cxld.region->dev));
-		rc = -EBUSY;
-		goto out;
-	}
 
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
-		dev_dbg(dev, "decoder enabled\n");
-		rc = -EBUSY;
-		goto out;
-	}
 
+	lockdep_assert_held(&cxl_dpa_rwsem);
 	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
 		last = p;
 	if (last)
@@ -528,14 +517,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 			skip_end = start - 1;
 		skip = skip_end - skip_start + 1;
 	} else {
-		dev_dbg(dev, "mode not set\n");
-		rc = -EINVAL;
+		avail = 0;
+	}
+
+	if (!avail)
+		return 0;
+	if (start_out)
+		*start_out = start;
+	if (skip_out)
+		*skip_out = skip;
+	return avail;
+}
+
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct device *dev = &cxled->cxld.dev;
+	resource_size_t start, avail, skip;
+	int rc;
+
+	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.region) {
+		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
+			dev_name(&cxled->cxld.region->dev));
+		rc = -EBUSY;
 		goto out;
 	}
 
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "EBUSY, decoder enabled\n");
+		rc = -EBUSY;
+		goto out;
+	}
+
+	avail = cxl_dpa_freespace(cxled, &start, &skip);
+
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
-			cxl_decoder_mode_name(cxled->mode), &avail);
+			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
+			     &avail);
 		rc = -ENOSPC;
 		goto out;
 	}
@@ -550,6 +570,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_free_decoder(struct device *dev, void *data)
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
+ * @endpoint: an endpoint port with available decoders
+ * @is_ram: DPA operation mode (ram vs pmem)
+ * @min: the minimum amount of capacity the call needs
+ * @max: extra capacity to allocate after min is satisfied
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. So, the expectation is that @min is a driver known
+ * value for how much capacity is needed, and @max is based the limit of
+ * how much HPA space is available for a new region.
+ *
+ * Returns a pinned cxl_decoder with at least @min bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     bool is_ram,
+					     resource_size_t min,
+					     resource_size_t max)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	enum cxl_decoder_mode mode;
+	struct device *cxled_dev;
+	resource_size_t alloc;
+	int rc;
+
+	if (!IS_ALIGNED(min | max, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	down_read(&cxl_dpa_rwsem);
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	up_read(&cxl_dpa_rwsem);
+
+	if (!cxled_dev)
+		cxled = ERR_PTR(-ENXIO);
+	else
+		cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	if (!cxled || IS_ERR(cxled))
+		return cxled;
+
+	if (is_ram)
+		mode = CXL_DECODER_RAM;
+	else
+		mode = CXL_DECODER_PMEM;
+
+	rc = cxl_dpa_set_mode(cxled, mode);
+	if (rc)
+		goto err;
+
+	down_read(&cxl_dpa_rwsem);
+	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
+	up_read(&cxl_dpa_rwsem);
+
+	if (max)
+		alloc = min(max, alloc);
+	if (alloc < min) {
+		rc = -ENOMEM;
+		goto err;
+	}
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
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 46381bbda5f4..45b6badb8048 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -67,4 +67,9 @@ struct cxl_port;
 struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
 					       unsigned long flags,
 					       resource_size_t *max);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     bool is_ram,
+					     resource_size_t min,
+					     resource_size_t max);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


