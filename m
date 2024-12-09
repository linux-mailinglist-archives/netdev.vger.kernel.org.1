Return-Path: <netdev+bounces-150350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312509E9E9B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954CE1889204
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A081A0AFE;
	Mon,  9 Dec 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CX+wW8Ev"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6B19CC31;
	Mon,  9 Dec 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770512; cv=fail; b=Cm+wZ4au7+ft6gxDe8unCl6Ua95MnNY29tKwr5blO8O3rpEhRz50W+WorHf/29RtQGoKKs3KIEodtEKycZIg8IkS6EEcBIdRE5AFgIQ04PD0LYknKMA0UD91VWMUv//fBnEKaejcEnD9iiSpnNAoONaeYBlZ0d5BIySqTQGp8S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770512; c=relaxed/simple;
	bh=Uk9q7C6HSzGcOkVoWzK2OljOPRa4OLk7PHeQQ/ibSS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zcl5JXyjG5HzV5XHXofLMidNljo1KAA5toe4iMDV7OLx9dKHtunaKMnhs+PnIKIyMUn0QrsTI4g71lgml8UXBl2UaYy4xbIpWGu/qlLKHt9c0nRVY6kcRjc0kQ0lwyFeOpx63HdKgh49S55SO6AYZI+oippFacQJqdpOXf3p46Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CX+wW8Ev; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B61bMiX5qqkkAyuFKuWDsdO/dKHznSewhozH82CYdea4++CJA6Ehh0ebxb/N4FcBKJyxTT8YzYpAVXzbA43rdxHHJ6JtYOwhjIVHElxPWYMWCct/hn24jbVFKjtK1KwpUgZSF2OLLtmp21cOgwngFU7egkK6ijuPBIsdqQrS20flk2kdk3ZnBDHZ5BS+io+z/rq621l2jHucnFFWAEZzrrETVpG9rO1aTrgrOBMa7q1kh5O5MFb71wJ7cUIZ4PP3pM3cr3zG1RlfaVzTMeQQ5C662bdLUmUWiNrvmwpHyBlZwy3y+qOvjKd9mNOZY6zeyQ165hBnOFS1xW2m0Y7o1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRTlibYAETk3Mmk+st2X0rfQlSm9zs/Kc8465Jk8DvI=;
 b=gV5TbCVEzzsrdeqxzTlhkqr+3FVGTPYf7BkDNVhKEHNh9CEFTzsQyYlj1F9ECpQ1bL74wmWhRCPy24gjifajRAQGMOBqhzZwr5zBghRd2uRCUQjoN9/NIol7o+ruIzSAs39mA6rRdnCG2Y1VMTnf1ZaumPvRKEQllkg+TcNOwMZJvWUmUOxtzGc/M4zqHZHpjxCwkGX8WrQN+nhryx+xKQki7NPgPKq6Z/1aC2XnLVbsLhpYJ97eB0n0NEwle2DsGg89lUFm8P0hm0KTt/KPA7Dq15SJv03afJw5gWaGNzr+o+MKnXdCdNZHiWQu5/TSlWN01XtKZ4yrsw7E+Nn0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRTlibYAETk3Mmk+st2X0rfQlSm9zs/Kc8465Jk8DvI=;
 b=CX+wW8EvH67S90YNEH8Awmv7foACxh0sjEtftBVF1wO2onZUwK4MS+fz8L69oo18PM4C4SbxORQBkzpVprtwoam1zrU+zXkGyKl4lsXFsDOKUXPwIFTARdkoWBa5fNbr3bHbXVixLDok1mOGUcX4G/b2Wl87IHKfI4zo+wXp/W8=
Received: from BN9PR03CA0787.namprd03.prod.outlook.com (2603:10b6:408:13f::12)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:55:04 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::34) by BN9PR03CA0787.outlook.office365.com
 (2603:10b6:408:13f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 18:55:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:03 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:02 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 17/28] cxl: define a driver interface for DPA allocation
Date: Mon, 9 Dec 2024 18:54:18 +0000
Message-ID: <20241209185429.54054-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e57854-09ee-48a3-9dee-08dd1882fe47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b14teoMMrh0DO6O+4fpx9JOvee8N71lYA2D4MOiIEgLx1qSDB+rCaOjZCrSL?=
 =?us-ascii?Q?qZk6iJ+WpI3pD3Vw/LxGkLsgQCRC+cybjKA0ZC09gJ5oVEhyxXzajH1glRMM?=
 =?us-ascii?Q?fPuiTuPPEXKF/J1aBEMaBnWf22qFpgQcxDcJ9ckIPrw+po03/mk9RWyQ5WVx?=
 =?us-ascii?Q?F4Wu1X+oIVopgGuRlTwvamHz/K5Mna69AHWWthSFSBgKvk8C8O03Th7ZDBS7?=
 =?us-ascii?Q?vRr/d0WQL8Cl/iGtg4qHh7Zt0M0719lkwAUPrRtclpU1a/seUgf6m0UXMIYr?=
 =?us-ascii?Q?LI+nJOV7frNhSJqqKFjBbem+xKV5MrjkDXnaudVHl1Te/0usQSf+ECTripsC?=
 =?us-ascii?Q?QH3KbeYoiPLzcbu0Ez4vj4jHox1hbdDzk0sQktYeaSk0x6EmuyXpDGWL7jrj?=
 =?us-ascii?Q?AVpT7vUYE3mGhwm0NZ6w2KeU1SPxAuBnnswnL6vU0LEfRO+WnES9qHiEB8Co?=
 =?us-ascii?Q?+1QQozT5r3Ql+eaJ1Tpm4f8EBrmmM6xn9Sl42HtdMlW3v3VC6WoSU3L2Cbbb?=
 =?us-ascii?Q?ELOLAfHzXoSqFQHO9WSc2ExuQUvl5NPKFADS0uz2EBqY9M3+wxAvt00edJpG?=
 =?us-ascii?Q?z8HRRC+7VBjzNLFexm+g8ntDj7vfERaJupyISi+0+jnAWANXvjYp7fQEEcxn?=
 =?us-ascii?Q?hkULsNdKCPpRR7ZaoijcC686MHXFK5BxCGeiHcpBuvqYeAZOx/wObTrn8+6g?=
 =?us-ascii?Q?f32FBY2kjolY3ZmdStX0AI30DKJbiOUUUuQj4M80rmtHA69S7HeDUajWQv3/?=
 =?us-ascii?Q?9z82g4f7jw7oR2hhDTmOAoUSg/dxoSrNB2QspKjW6Oj4XnguJBtFVdvOIn4D?=
 =?us-ascii?Q?qBhYnxK7HvOtQMJS9PyDvgFo78IuU84INVU+5xqILHWgTXitf8UjU+3wjKYm?=
 =?us-ascii?Q?UGulsRraNWTgsrBsb3uXcU/weqRuWjIvsc3Ldmj7NChIYCSGurpiYuibTq8u?=
 =?us-ascii?Q?Ze8LNLeFym9QXhBAej7IcxLB6bzOiTd11zoueJ+X6wMjCxEOsv+J1Rop64qY?=
 =?us-ascii?Q?SihRQ8aYDKrlshcnyPp78a5KBSXoqMb+DRjE3yBhyS+lGwtzk8HLD4aeV+JF?=
 =?us-ascii?Q?Y4A7sP/V7TZ8fEaHMOVFDMkrIRSM6ZEI/DsQFP66K7WH0VqCsvEX7A7tr9nO?=
 =?us-ascii?Q?0bwzdXoeVY+hUYvNYubw0gA/hW+uERsjD7N8oOGyKwZBlWYZmugIjDYIv+Ox?=
 =?us-ascii?Q?eNoPlxtHils2alAF8SyefIkOoN9etnJKJ8aO35Mxd+4a2b2Ets59cNem7yzF?=
 =?us-ascii?Q?SVPhp2OuCHAmIOewbvtl1CChcHcRqTkfiu6q2E2T4KQm84pRl9Yqc0X6Lp2F?=
 =?us-ascii?Q?twGY6yOkH+ebLZJhuAIEcv0m1HdvXG6CEqmgMGsezHZsflNd4HlUFpBBcIZu?=
 =?us-ascii?Q?AJczczksCr8utj9NaTQcjB91PH5iVpC0StqUvH29j/hK1pqNX0j1RLFwhg6z?=
 =?us-ascii?Q?ZmzT9Y5T4kY1EqS4GjQdaVZ0ax+k4I5eQTF7MV9j9A9hbGaMHS+zRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:04.6618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e57854-09ee-48a3-9dee-08dd1882fe47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236

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
index 28edd5822486..15913d999815 100644
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


