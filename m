Return-Path: <netdev+bounces-152295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B47D9F3586
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB75816A223
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B83F207A11;
	Mon, 16 Dec 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NGmn+Gg9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988981B4124;
	Mon, 16 Dec 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365484; cv=fail; b=aFyHkqON7fpUg3CCWr8KwL84/boHcwgIT+CR7bPtmLHqQ7oumWxlM4D1NjXUcQAWEZ3B6piCQXUQ56pNhpf5nRhKAAZagGk9Tw4oqjTTWy4X+3XWn6D4D8Ztax8C4Z13zFXtyvfXHhR/X/B1htgNq5SpSan5Z0D89TR7x0wjlaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365484; c=relaxed/simple;
	bh=oVo5/wqy/l1bemZW/oKef4sO92Lk1CF9aZ0PGR3OZ/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AItkvzZqK5orWPE9G/oepXuMSpVfh8m2zT3V2zeMbUEAPy/hk2BF+IeT3JxRFQSQcZa1KvleaG3MUKvkvTGbw/sX7z+3hYlloLBY2xCIRghcn9+UDjiwRSitbLurLkjK47AwRFkNTnI06fPMg/A3CDEkh1EmODh28Bl5Mwf/EVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NGmn+Gg9; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krai0A7kvrvtHy0r0bidiU5vQC3qNV2OP765ji+ZuWBwS48jfKYGwQJmYq5QQVYXQwjKP+Yhl3gxiFsQA6f26mRNNh5OY+wFywpXoThPz8hJmC0fE7POiJA0hW1ExnqKw6O67pIfM6QCjBFMG5dv/I7in0em7qZaMecbbC7K78ExDoYhCRB9zSB3Otu3o9/gssPKg8h1bOzGx6inhwVC1msULYjXTOqih/GJmRug/v7uw10iCCcWC9KbQVlJM1ZIO5en4j+uZoKMz9fmN/BUz2priPLJ7nEZoG3WJNgdtyxU6/JGnl0tHj50qjSRjlsNyCoVp/gXDvA0IDDxzgT7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3qgdSfXgcDutcWnv2ZtmRqQ5jDX16Mn3uSdKYpMJ+U=;
 b=ck7jrGEYxF9QuWQze9Hwwk4/dldIq7bIGhhJO9RMWi2xGT48Y8hCYRngm+/tfrQNoCuZY4iaD6jm83quUs3cAyA4LLVX+Co26avittoSUwX7bDSNUeoeuQqmH/7yoBEMuO0Qn82TUBoORX4GLY1jutgoUH3YQkDYvYS9AB+Lh72iZE0fGvNVrUMq/qsKD3RfpEl3W9Uw1QXZQT9Sgy29/bW7BsvMU7+OtKbu74QV61vs/GPZIf989ckXq9Q1bJKPaRHr7Kuy7B6jJn8AOdBetxDKG6OjL6nSeREAMmYk6T8kn/TQ6WDiAQCGydlvtOqvcPwhAtTDVC4MFHBVxbY5ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3qgdSfXgcDutcWnv2ZtmRqQ5jDX16Mn3uSdKYpMJ+U=;
 b=NGmn+Gg9VyJTIy/gSB9eeI2pveL9MKZopbHN2BGTTIxmOp1RM3UEoASc1ObipCeyHP1DC5V/wWpQYWd0bGa5QrOmB9vz0yfz4/hYdT8d2JMEwjMpAjybs6wIMfzPwad/Ocy77cx/lLOHjcYA5nCRA9eGetF9cjjU5EaSeAQwJSM=
Received: from CH2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:610:51::14)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:17 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::65) by CH2PR15CA0004.outlook.office365.com
 (2603:10b6:610:51::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:16 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:15 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 17/27] cxl: define a driver interface for DPA allocation
Date: Mon, 16 Dec 2024 16:10:32 +0000
Message-ID: <20241216161042.42108-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d02f6e-90c5-4239-86f2-08dd1dec459d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OyDCvFwrqaB6MpmoX4UViEFeRSWquyMzQzKq8QPIuLOigX95fBJ8k268lbnn?=
 =?us-ascii?Q?s0fzzfzQoUZoRZSNdvs091PJb4X7pKedt7lDBxUTkuhVdwXFg6BX7ppcdZSw?=
 =?us-ascii?Q?IgSgJ+qHwpyH6Tm6EhornBkyCXuyVbCJVB58KB/mOYgJ6Etbc8CfkbiyzOXj?=
 =?us-ascii?Q?51rqE0pRdQDWuZ+wrvkQ3RyW0reP/go2OzYMhWgWvQ4aFjjU4VeRpQXOBY5J?=
 =?us-ascii?Q?zyJbSfMTp6kYlMV0zh4xz/Au02g8iMmgOFR/iMrFpuT61wp+VVzuYjn6fIx3?=
 =?us-ascii?Q?0j0fqsotZDQvGd90psD0LchsZc7ULe74jZNh18stYAuCI73dQLWAC/2d7YfL?=
 =?us-ascii?Q?rcyikrHNL2q4UXp8EmblHQN9WVKvZeBhM3xL55zCmtpSH/T2PUbkihsh7Zon?=
 =?us-ascii?Q?p9J/ea/XH52Y67GQV80OodIGn9sy8PZ96SF4v+E0hb2N8QsZpOXkgFnSKwAa?=
 =?us-ascii?Q?5GO96XZhUoMhHXnYP7KQ5/mEJjG9xeqP0ZOZhuj2DIyHXTFYs0uBFFHuOZqh?=
 =?us-ascii?Q?A2kpIK2cwYO8aKEl5GvK4dNwdkOfCxKMKIPOQ55q0tnrx9jI4YWsxRXG7mS3?=
 =?us-ascii?Q?DaLDFYXEKASBsaze29I6kP8OEDOpAfOYQJDfzu+AoBF8KMz5nJXfJYwgLzuI?=
 =?us-ascii?Q?g6Zl4aGtYNY+6C3IiDeV5XSQENL27DvfTbxsqd2mZrxwSgsBa8pVmdaPUpID?=
 =?us-ascii?Q?K25kLMzeb2J/jkKp4b+k41fU0sVLPXV4AW/sVsP46gQn+NoqpKUn5muxLZ25?=
 =?us-ascii?Q?tPpIqQT/KlOqtXdl9Tn4iSFHCBz/26IR6snTOamn+H4/68zJKLa/NHkI6g01?=
 =?us-ascii?Q?13LeRERzbODjzdYh3KcYQdPVeXGpPJSbtoVbBQvzr5vKIyecjmiOGTuzEOWz?=
 =?us-ascii?Q?ciLWyfWVGKoMWz3bge/SedjgnsKtXQ5WZx9fzW4vYGDp6STIxnLS8BGDV39v?=
 =?us-ascii?Q?O9Fm/Zkr+KsjKdmGewiVM8BK7Q5WwZUiVM1fMoZGfpbQGf7AaJgf0QLxmXfj?=
 =?us-ascii?Q?NRJR4Ub7ryUUlhB2irArB80rwidZyWOq2RL+9nyNiExDkgrVKNM4rPxUspZ2?=
 =?us-ascii?Q?QndJeT/iHH/R/lrfseOtfHKOEiMspXMgZ0nFGmN3Vrxe+KW9H/3MfdOrPuRq?=
 =?us-ascii?Q?/Bd+mmwpT7k7cAEIZk2//+xXGTYfp6nCbuOdUvGkoKT5a8eqJ6QzWyMwM5nJ?=
 =?us-ascii?Q?n0dt6HTs3v0Vk7zNL+SqI/dvmTHPJdOWEP6XhCU+Mvy4V52GannokF0C8uHx?=
 =?us-ascii?Q?na8Mlb5Y/W/5UoNM80eIWRcBRauLFhCRbchJIbAcQ8YjuXpQvAzR4SBe2kr9?=
 =?us-ascii?Q?vQLPdMd8NaA5UifEUDsHlEbQrFrsK/HuephIojm3Q9Sjk6MAzog72tFwuMzk?=
 =?us-ascii?Q?291GXTOGxI/CAcxBPJsi/bIJIsm5WaQBKpsevDgKJvBERAukUtoeAar88eD4?=
 =?us-ascii?Q?IZqqLhXn3sFOQUzUH12BVtrZQ1pd08rbGPk89m8mgQsOnbem9nnVpD3x7omk?=
 =?us-ascii?Q?8+Ett1RmmASEeMSj6iUlWG7SxC3nJFbF6lCH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:17.2979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d02f6e-90c5-4239-86f2-08dd1dec459d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925

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
 drivers/cxl/core/hdm.c | 154 +++++++++++++++++++++++++++++++++++------
 include/cxl/cxl.h      |   5 ++
 2 files changed, 138 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 28edd5822486..4fa248ec56c3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -417,6 +418,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_dpa_rwsem);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode)
@@ -455,31 +457,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	return 0;
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
-
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
-		dev_dbg(dev, "decoder enabled\n");
-		rc = -EBUSY;
-		goto out;
-	}
 
+	lockdep_assert_held(&cxl_dpa_rwsem);
 	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
 		last = p;
 	if (last)
@@ -516,14 +504,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
+		goto out;
+	}
+
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "EBUSY, decoder enabled\n");
+		rc = -EBUSY;
 		goto out;
 	}
 
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
@@ -538,6 +557,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
+ * @cxlmd: memdev with an endpoint port with available decoders
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
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index eacd5e5e6fe8..c450dc09a2c6 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -55,4 +55,9 @@ struct cxl_port;
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


