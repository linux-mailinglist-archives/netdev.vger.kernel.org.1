Return-Path: <netdev+bounces-111571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378393194A
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DB61C2198C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F45C481A3;
	Mon, 15 Jul 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqasE+L5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EED7173C;
	Mon, 15 Jul 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064544; cv=fail; b=KwDaTPwe1DvuGZYJgN/2qG5g4HqHG7g0qfNfKOtehQvF7ElXWv3PRoOudX2lIGzW2r0bDbq0zA6W0UxLsvvdacZovLypzYXqLCt7veFvOB8WMHvitzdOPl6IuEk6e4k9OmBA/3YaXGD23FE6jV+t3EIG3BMYfi/FwRECgLNuF2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064544; c=relaxed/simple;
	bh=pU6ylkH8U/vWKVgxV1dXn2pBW2C/ATOuIpeV7kiKAPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhFsNf0xR2mRGkNJt+B4JdoNsJzcWXcVDZlSB/bJER2U1QpX6x/RWLQ5MUYIFHNII4JhrIiOid6lubYVtrEDTd4YwU6ch0eem7uY87hSNONxIjBlw+YyJ0XWb8/H+20Op+iaMnR/cBb7QocWwWikJgTcZ55jHhcXSQLMsq8P1EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EqasE+L5; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIiod1/egHUNNqR5cEM0JBjuNEB8sYXNtX0XNRkzKNp3Aqu1S29CIMOjLcBux6cGtQiR4QbAijog9N3Dl8bJgKnoan20FIUYVWQsDebguzmWvWkVoZpflyYAvaZyOAfE7GtjBjBxNEmoP6xxlL66iAnJb/xNP3Qnbnh2obbqfycfNSM50+FdpCMHMoF0BAZNP2hL0wto5mqAPEJyv/H/MQKEOoTmfxx8ed/gIBAjotImcipuWtI8YWAfrkkYLe9i6aqwEt3y1ey75QjaAyUmcFdOwVi1swijb86Nhcq2w9Vv8l8ZOCAce2N7nqZZkeuPzBwHj2sWEZQrKW+8Pl5hvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjXnjXwhOwLS5GKsMstS8ETSnnG0c+V+5JINt7DPHbQ=;
 b=wCl4tLwdFWk5uN8FtD83HmMN+LyXBhgqjIpHeKQCFhNIvXs1FFDTedQ0nV7sF8n8fHH92hNARlFdDBE/eeTpsko6q/x6UXVstfuiA8HxbXp46hWQT32jxuuBEX0L5fP0UMeqXhgvo+D/pXSPA+42C4D+DoOZKFXtjA3m2+bIn/yZS/exnyp5L5dm7lJEjTxA9O9uZgUpQ8F665tJ45poVPxR5J0rl0jURlduuKSKCv3hGoMzlrWL4KxWWIZOOHLBhPbpulAx8nnvGAELrJDVt4DsP1virKsTGRBS0bvRyCd1mkaPpyJjp+e7bOE/agedYQvd9U8FvOg303X4hpor7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjXnjXwhOwLS5GKsMstS8ETSnnG0c+V+5JINt7DPHbQ=;
 b=EqasE+L5XdDISp7204Hp0AsN5CEx+7h+S6QwbMMBuqY8HInDjebBS5d3ecQmEIA3dxrcoK1pwaRMQaSPxABmEk9jMkFEG0Ok0mGxnGzKauhmpOIt/oWx4bHiSoq1pPH6TG6LXo8QRGrN4lF+zbGF2x857CdQkudyzD5YaS+1k64=
Received: from BYAPR02CA0024.namprd02.prod.outlook.com (2603:10b6:a02:ee::37)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 17:28:59 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a02:ee:cafe::81) by BYAPR02CA0024.outlook.office365.com
 (2603:10b6:a02:ee::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Mon, 15 Jul 2024 17:28:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:57 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:56 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 10/15] cxl: define a driver interface for DPA allocation
Date: Mon, 15 Jul 2024 18:28:30 +0100
Message-ID: <20240715172835.24757-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d8f4c3-424a-481f-0742-08dca4f39c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CfMT5XW+m0bI0jWoz7ZHNx3qsgRK8pSvjdyB0nZCGBBHdu7W+90djFTaA9is?=
 =?us-ascii?Q?Q2rZ8DUB9Y+gCHvXPZl2DiAghsgW7uiZXYJaQrN8bdNUgy0j43RHYpJL9Iei?=
 =?us-ascii?Q?t1uQ0nfHOfNZYqdPZwhgU9xFfntn5bhey22y5g7SyOTYTz/9i2B8M8W55n2R?=
 =?us-ascii?Q?ZJ8DnDJemI6JfoT8I9YTXiomWxNccojgrGtYPvQU8gaQX4gjppoH3BHp9bku?=
 =?us-ascii?Q?7n9hk/L5z6cckDyXzsxr2OFgfK2s0RRtvDkDz/qaoB5z2QMJhNKlvoKgnj+H?=
 =?us-ascii?Q?6MofnplfAqyZYOHHXYJtubGIMQa6J/eb5R8Xp2AptJhtnw5DW5uUNiDODjzG?=
 =?us-ascii?Q?P2ZYtaEPaUvbzkuF4vjd9a5DwrHVuZH+HCJhJh3SjGsjJb6Qp5ZLN4vBX0a3?=
 =?us-ascii?Q?Uoj3hgAT+moDs0FL+mp6+OF0v7xSWakv2aYsFCv18SF7aaH0WRdQnx5VHAAs?=
 =?us-ascii?Q?e3zh3AnC6BD9djZWPO9iU1LEUq0qpCT2gHbfiE0H8Kjd+S/JhDuu5vSMzeKp?=
 =?us-ascii?Q?+KpM+93tjANyRf+Dn4I6ePhhRM8BaV2uLnnXWbSCBA9OZ+X9eG2JTNXZU1HK?=
 =?us-ascii?Q?lYOtaBZwkppa3xEcir6clVGR7zhzlXHSBEda7jrZWA2MGiVVkaV/PiFPYvyK?=
 =?us-ascii?Q?8ISCcBYUCcJIaKmOwldFFHVmIg7LDPpNRI+/9sdSwNO/wkwcHV8zTptkHVU8?=
 =?us-ascii?Q?nZ//2BRGlgSJ0ZokLB3R1BjIFJeITDKcdDFXJCe+xdDVP0GrZ8tGgkhRCYGS?=
 =?us-ascii?Q?OXNDERN4QFeTRpRyN88aPpZRpMdiGwL6bC5DAjw21J8cUjA1vavcGQrZbJWz?=
 =?us-ascii?Q?JUtWbcIsWUxSygONo9JslQrzFclJmFcn0j3WXCDr7+dwzepv60B55uu1vzpX?=
 =?us-ascii?Q?fZ/sLDzUn+akxppVYIJfNCK2wyL+jMFhk/PPUU/sRAeiSrcziHoWqe4P1NJQ?=
 =?us-ascii?Q?1f3CWaulCCuajUqe3cOY0jziDunvYNbbMgakcU3SidG5kjCHJZa5EJBZuyPI?=
 =?us-ascii?Q?/vzNJRoxo+IvqW/THAp0vBGE/O+kuoYygx42SLy/BBglejEoksmGXsvFEn/x?=
 =?us-ascii?Q?1S3ylSTUUJR/eJ+aaJPh46mTzWHC9u0TXdXHjI/KUoyf2lUPZnyPzbSh/mOn?=
 =?us-ascii?Q?GZrsvhhOfHKon3+HtC71sgfYWx/32tPos1BliGmqz5o8pA/5psCle9f0LgA3?=
 =?us-ascii?Q?Z4b73JwXsrzYCiTIWbuwUFAYqieFz0/9RUl41VG0GxIFv3yaEp1PbcOww7ne?=
 =?us-ascii?Q?7T3IHYaz09P8iKGtvKh2Ibg5wbrH5l/CRDwNk0WDXaZ93Vmg1gN9KnpYDzXA?=
 =?us-ascii?Q?3GLiH9pvEVbx5aYFH5jlRawZyiUWRSlaZp6B7iTElVITfx09aLnHEOoIqgFb?=
 =?us-ascii?Q?Lbg6e3G9gjLMUCcZnxWL+ZmDDvXi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:58.8333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d8f4c3-424a-481f-0742-08dca4f39c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Given the HPA
capacity constraint, define an API, cxl_request_dpa(), that has the
flexibility to  map the minimum amount of memory the driver needs to
operate vs the total possible that can be mapped given HPA availability.

Factor out the core of cxl_dpa_alloc, that does free space scanning,
into a cxl_dpa_freespace() helper, and use that to balance the capacity
available to map vs the @min and @max arguments to cxl_request_dpa.

Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m4271ee49a91615c8af54e3ab20679f8be3099393

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h            |   1 +
 drivers/cxl/core/hdm.c             | 153 +++++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx.c     |   2 +
 drivers/net/ethernet/sfc/efx_cxl.c |  18 +++-
 drivers/net/ethernet/sfc/efx_cxl.h |   1 +
 include/linux/cxl_accel_mem.h      |   7 ++
 6 files changed, 161 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 625394486459..a243ff12c0f4 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -76,6 +76,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
 
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4af9225d4b59..3e53ae222d40 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/cxl_accel_mem.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -420,6 +421,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	up_write(&cxl_dpa_rwsem);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
 
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_decoder_mode mode)
@@ -467,30 +469,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
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
+			     dev_name(&cxled->cxld.region->dev));
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
+	if (cxled->cxld.id != port->hdm_end + 1) {
+		return 0;
+	}
+	return 1;
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @endpoint: an endpoint port with available decoders
+ * @mode: DPA operation mode (ram vs pmem)
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
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
+					     bool is_ram,
+					     resource_size_t min,
+					     resource_size_t max)
+{
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
+
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	if (!cxled_dev)
+		cxled = ERR_PTR(-ENXIO);
+	else
+		cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	up_read(&cxl_dpa_rwsem);
+
+	if (IS_ERR(cxled))
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
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index cb3f74d30852..9cfe29002d98 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -901,6 +901,8 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 
 	efx_fini_io(efx);
 
+	efx_cxl_exit(efx);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 6d49571ccff7..b5626d724b52 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,12 +84,28 @@ void efx_cxl_init(struct efx_nic *efx)
 		goto out;
 	}
 
-	if (max < EFX_CTPIO_BUFFER_SIZE)
+	if (max < EFX_CTPIO_BUFFER_SIZE) {
 		pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
 				  max, EFX_CTPIO_BUFFER_SIZE);
+		goto out;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->endpoint, true, EFX_CTPIO_BUFFER_SIZE,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled))
+		pci_info(pci_dev, "CXL accel request DPA failed");
 out:
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 }
 
+void efx_cxl_exit(struct efx_nic *efx)
+{
+	struct efx_cxl *cxl = efx->cxl;
+
+	if (cxl->cxled)
+		cxl_dpa_free(cxl->cxled);
+ 
+ 	return;
+ }
 
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
index 76c6794c20d8..59d5217a684c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.h
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -26,4 +26,5 @@ struct efx_cxl {
 };
 
 void efx_cxl_init(struct efx_nic *efx);
+void efx_cxl_exit(struct efx_nic *efx);
 #endif
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index f3e77688ffe0..d4ecb5bb4fc8 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -2,6 +2,7 @@
 /* Copyright(c) 2024 Advanced Micro Devices, Inc. */
 
 #include <linux/cdev.h>
+#include <linux/pci.h>
 
 #ifndef __CXL_ACCEL_MEM_H
 #define __CXL_ACCEL_MEM_H
@@ -41,4 +42,10 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
 					       int interleave_ways,
 					       unsigned long flags,
 					       resource_size_t *max);
+
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
+					     bool is_ram,
+					     resource_size_t min,
+					     resource_size_t max);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


