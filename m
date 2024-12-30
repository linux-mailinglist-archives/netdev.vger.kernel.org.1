Return-Path: <netdev+bounces-154586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8869FEB23
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C3916237A
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DC019DF60;
	Mon, 30 Dec 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uAYeETD6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037219AA63;
	Mon, 30 Dec 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595130; cv=fail; b=fKmUDZmDP9l4eG4/lZoiptcXLmRzjt4dBhL7201YI3WSVTZOc4RzkoAQWD60Th63ApT7/LskVjXN8qcl4Cw3lTppXhny0kPHqmv5p8SWH2AkV6RRUaBzAq2Ck4Aoo7sbqH1MlgpC9GobkiH5vPsVa2TWkP7nHqtP5HcTMLNq5ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595130; c=relaxed/simple;
	bh=ulxPlpfwwd3+yTAoOSPQamewnkoU+s4S76QPm6aHW+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwWnK9lH7WFzJY9R6Rnkh5kS3F7IY4Mm4LSwKaqRcMZ4UKCqunP6ifbVx3efoBLlGb+pFrSFoHM0EGiT1EIL5fpRSc33yc8v6P4fVZrCeI2LtuJmmnVTkUSwMCgfvb3Kg3tBeo027XuHbaqDsVKi5/taGMr47UQJMgSEZRohahc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uAYeETD6; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpVmJIaljQrfyF/c/h552OyVMF8+Ax6VHjfgWcO1TP/uKD9qM6ajk03m5bCDzPd4j/IgdEJcALMOl8LrKUagVCgrzz2/wcbgxf3gE8TbPC8hLKybNBrEuWJFM9c45qaXsFURJducjzITaUnhvq33dYr42B3KBMqB1SB4KJybCp0oiKJWAslUancwzpOLeMP6HXtI1OdwlWiNdfJz+4IZjXTV32PASe6IoWzg1yQSgKpB3uVZZiinzje2fii6uy4CdHRzwG6NoL14TZe7FXwvquceAJJYPyGIt0Hzge0jptUYmDYOf0jLQm3x5aLluaXAT0FzkSxfRXsnXf71uZNOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xW6YL3bOnkJOwQcpu2Opk4fsL7CSIoCk7FYbCyFyMs=;
 b=VfQhVTs9B9ZaY5fbxz89jaTcwm5kcGVWMfqD3z6fC+VRLGypx2iZoI1ku8Ta/ljrwziC6QyjaHeyvlkC9PR3eS5Qg7UwY4h+msMKFtpuQLUdlUHHTAM/+Rgsi4+0R8bNGeTbNFQiYi7ak6XMaV0aL6n8jmh3EZ/oM7hzwAAp6pWBlZbwSBzwWKtCgBphD7CTEM23eezVguElwwOoo5dJjtdQqIt0TNV6rCu7E3AywoF5jwqCHvr4TVZrZD3lopCMZ0Fz2aO6217WzFCkt7PGN8YALjaVCcEdd+VRpVpt4Ul5DAurrFDlonAcjxlP3HkgpWT55NP5KU1twj8R/QQhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xW6YL3bOnkJOwQcpu2Opk4fsL7CSIoCk7FYbCyFyMs=;
 b=uAYeETD6xsLSI4RSVZ+nEEOEvbVwBg0BaiQDuOGvRdcZfkn3blZl0mQxGVkYLAZmV+xPRYt0tVazPn3Nwi2Reoq15H19WAUZ00MwdHmswTP7ZkT86v4KpY3bCllOkLIX0hp2NeknBDH4/Mzjmz4DVWaZbuuvO1avkvCcDfaplzU=
Received: from BN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:e4::31)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:19 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::9) by BN0PR02CA0026.outlook.office365.com
 (2603:10b6:408:e4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 21:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:18 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:16 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 17/27] cxl: define a driver interface for DPA allocation
Date: Mon, 30 Dec 2024 21:44:35 +0000
Message-ID: <20241230214445.27602-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: e59621a6-cdec-4e70-3659-08dd291b4111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkaM3TQpR88LyidKHcaZRPmTwzhLECf6nFM63SzkGzlvt1EGbZgapOngJ2aW?=
 =?us-ascii?Q?2fc/kqQA1UZQbvp+MIgTj+9mrq/3dmqsg1gXPRT5YGScD4yeEkIpobxdl46l?=
 =?us-ascii?Q?ojz4XAI9RXYsju3WZPpNAbzwiIEp0v0yV4UwHNV1VwrHFtMM8Jo8NJ/ONPp6?=
 =?us-ascii?Q?E+Z4OufilWanXX0qoU9o+ZE93X8U9LCg6L5PInyi/KPTCndv+Efr85st0XaJ?=
 =?us-ascii?Q?jLtaCdm9IrlpI/WsGHb+0LNf2J48VxqfYyWn+cLPzOwPBqRmXuqE6R3LcH+u?=
 =?us-ascii?Q?Mh2AAHA4QujxScVb0dSKLxURVf2Pv8SiHaCCrHOATwb6zcg+VxDsUeEJFxzl?=
 =?us-ascii?Q?cyV5bfSux+Opk6sPE1aDmPqe6b5+Th6Dv8PTgsgE7MpDlyI0nm0fRq2C7pcg?=
 =?us-ascii?Q?oZWLD9WLeE4dFRGzGwNl+LnKxVGalvA6WOMLf58zmuJ5yYb8cm7xEEjXDI6Y?=
 =?us-ascii?Q?wCQr4XAeU0V3FuH4/Qn6xqFzmfZIZ7nAr6C951jnaKIUPXAVCpCOmhSsAeFZ?=
 =?us-ascii?Q?HdUhJdfPmaCwVE56TG2dkKkgHmql4upxHroxKbhUQ77tyNuopL3t2FL5rMZR?=
 =?us-ascii?Q?VmmD37hkXfaT65G97u9RZm80Te9qav7dVTupQ8FPW/u907t8xQkRMcPF/0V4?=
 =?us-ascii?Q?o3yqMw7Q58LbqXLcs3gwhpZ62YrgDzGt+G8YOwwbin2yTlnG7KzJYEEszysW?=
 =?us-ascii?Q?adK72n3VuTEkHq3DS3/xJVSsyagaEb6c9ALNina9Vz87hUWGIIVqwYDjOoUn?=
 =?us-ascii?Q?e2KbE8WnaONU/2FQgiahLzu0HHHRhht6bbXPf/JFE5NOx+RYhYDMjU86DGOf?=
 =?us-ascii?Q?6prTrfUQv+XPDTlKacC4N86VgxsVl0XR+y2GRGezVHkg/0CWQcP/lzyE6vYj?=
 =?us-ascii?Q?Y2X2OSQkag8XiDfms3YpbMBTVJapgriKO4Oq8V66yJ3tx7Lo3pLmR6jVc8bG?=
 =?us-ascii?Q?tz065vpdsj8H0VP9KjhooAsbrzsec/OKuGfmMI8aL9AnqYYbN5bZVFHboAHf?=
 =?us-ascii?Q?r2y9C6kFScnFPrwuYoLot9qjV9uALKi5hlYANtPFXkxCEzc4+Rnayhw7b80S?=
 =?us-ascii?Q?/oqCXTKhKGGrGihl+lfkgKp4A1gVlTYXiz6F5SkzbLSkE5q3YMLhVFuxnWMh?=
 =?us-ascii?Q?cwpipVxLoUPDTDZfHQAS//WyldoPiCkV2BJucV/gRlW5nKA2xOilJ1vewRYq?=
 =?us-ascii?Q?8afr8YN8bDSKAq3P2HGOozpJx8JJUrx4vL8JOKmw/bzeGcHpK9U2IhoL6y/L?=
 =?us-ascii?Q?fnhaug1U+mFWuZuIacfHU3xK1dGJKGrf7xmAQSoBQ8h4+RzZU9uUIK9aXkhy?=
 =?us-ascii?Q?B1nlfBUxkksgbPQpHXa4C2Ju3nWL4BuKsogKyW7w/cMJmRTigMGqrQTU33F1?=
 =?us-ascii?Q?ZkpUtoLbFbkbUD0xAC7YexoZAL8iUVF4TraREosBFPBZco+h+bCcqwS8wyAF?=
 =?us-ascii?Q?F7JPwZnrz+VqQhIp+2iqqRVCISGdjwrzcATrAC4iFV6AbIsFUO3kwmK/rVMM?=
 =?us-ascii?Q?4Pk9yFwM3KJkMR0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:18.8356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59621a6-cdec-4e70-3659-08dd291b4111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Given the HPA
capacity constraint, define an API, cxl_request_dpa(), that has the
flexibility to map the minimum amount of memory the driver needs to
operate vs the total possible that can be mapped given HPA availability.

Factor out the core of cxl_dpa_alloc, that does free space scanning,
into a cxl_dpa_freespace() helper, and use that to balance the capacity
available to map vs the @min and @max arguments to cxl_request_dpa.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 153 +++++++++++++++++++++++++++++++++++------
 include/cxl/cxl.h      |   5 ++
 2 files changed, 138 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 28edd5822486..9275f435f838 100644
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
@@ -516,11 +504,41 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
 			cxl_decoder_mode_name(cxled->mode), &avail);
@@ -538,6 +556,101 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
+ * @max: HPA capacity available
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
+		return ERR_PTR(-ENXIO);
+
+	cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	if (!cxled) {
+		put_device(cxled_dev);
+		return ERR_PTR(-ENODEV);
+	}
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
index 4a8434a2b5da..e05414e0a415 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -58,4 +58,9 @@ struct cxl_port;
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


