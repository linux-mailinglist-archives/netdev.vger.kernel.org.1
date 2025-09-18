Return-Path: <netdev+bounces-224331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B84B83C01
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF42D527026
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29D3043CC;
	Thu, 18 Sep 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="goGQ+/rX"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC573019C4;
	Thu, 18 Sep 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187117; cv=fail; b=GOccdTmTMpVgGVrhGcoz7EuTxcsIPz8xLqBz2/lHXzcM0sLlcu76sQS+tBmV6n98yoW8oNLX3aNYHLGjPFTXCqI5mla9R2GGOuIPcVG1O4UNNtQfRZkmCEJKSKiYKq9dNe5ILqcPt0260iXGwkN14HEiSQ5cwQU02d4jxgmJPAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187117; c=relaxed/simple;
	bh=JIMe4z4TCLxpV/Gmm5oeEHu4PPPl14/NFe9vRx0Z+ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mkuf5uD/+KO4FNKsZxFp8f19rhqBGSZWLEFMGjv9iE04ZPnG+5UF5bTNfQm7rH1Qg2SogPzcrAqdqk6oH84JGo16NKYc/2+p7YRKRI+uvE0gvq5zoHKGmWIS5YSVxngHYINExfmBPn20G6P7c0yppfcgR1Ep2sAG9Jz5HZIya0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=goGQ+/rX; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujNZ51AVC3PZaArSiGWZIAJkINu0O3XxqP1qkm92RESFvsX4sLnUD4irCtxWkYAuooVxcWEdixfi8xkksYSKApikcnz/52xiWMyd/0OAsvWovAYPNETd0RxBjSsLrfN1w4dU8+i35OWGsyBTrVcB1xqlrCE0A+1uQtBmOgRBndVkgjvhiODMI90zksJJYBpRhqxlQSPLCwWcrjN1+NUo6peYESl3v5/o0dOoNXrIfKmiB5lUHgjwYtATby2wNVQoYVtWqbHHr6NPfIRJwEbWPpMbZr1Q8kgZhNp+lVLjFic3+TPLw3RWPbmasAcSBWL/n6kzAG//g7EXGTGVVCJ8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5s8g3uuZCdM2NDxuiO7uKnHlRIdGbbdN+6IWlnqDAI=;
 b=nWjJZa7tqZSe6y12p2E39Lhmrd4bQOSWZLHWCuqQPX083vnhCJ1+lNosuqL9qcnUqc2ZLtoKMHBejPLrdmLLEDX3AkVTvvFnLPZm1g4lzvq52MWkoVi80aPjx3kfXmMXoUoybZPpq1aOLc7nGKdFvvIrCij34aYoFCeCbrey0Ysiq836uN1x/+7GDHqwjvxbEzVfFlM8Vcn1ZXKrUDHw3ZVrOuz+wMVlfGO5egskYcXJz3IaoJFXezlA2oF2oOo7lS0clLMwgabBaTbGdUdjRdFhPvsBIEMDMnv+03YhaKXIzmqVVP1DnrQ6nGv6Ow5D1WsnZ5QDMaS3j+HWfHn3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5s8g3uuZCdM2NDxuiO7uKnHlRIdGbbdN+6IWlnqDAI=;
 b=goGQ+/rXajAxNDqPgclRcwdYuCuaoiUOPYg7IZN7xVjlIdK6nhHYDASz2FEqfsq0HX6MSxAPnNPzSCYuQh9Nid1aQNz2ADHXr/tC3dD1GIxCLcJA1cxeyU3JBc4b4zudThJlN5yhcQo4ojkMCsgjbkP37CWxmuYY9eetMx4XdvE=
Received: from BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) by
 DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 09:18:27 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::8a) by BL0PR0102CA0044.outlook.office365.com
 (2603:10b6:208:25::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:25 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:25 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:23 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v18 15/20] cxl/region: Factor out interleave granularity setup
Date: Thu, 18 Sep 2025 10:17:41 +0100
Message-ID: <20250918091746.2034285-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 52566f7e-499f-4490-eac6-08ddf69453b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iK1r7brJ5iWKjlxhx+HWRZU8Ec9b+UhxsxQZ8Tiih6sATELjahQ9eWOKUAOk?=
 =?us-ascii?Q?cnv7r4lN7y+F+ERIYoHKJK2Q3ufqThCc6Cnp/WsKFArSgnF5UZRzXkmEBwBH?=
 =?us-ascii?Q?1sFSTMjoY69iXCTfCoU606hcMBGFZfk+OqLU1VpLo6ba9bmelqQsMTpmyIln?=
 =?us-ascii?Q?8XIA1z9rLmZtDgHIdLPtjLXjdm20tAAioGeu2bqK8pjjB1KMKFRa4eBX7xJP?=
 =?us-ascii?Q?5UnDFDf2XaSUN5SB55xrMlIsU1vi8R56yknY+4/NPPGRJo3jvUSQ4ky9HO+E?=
 =?us-ascii?Q?HIPnJf+H71MTCKW1jdyj/b6/KnetpP/eOQ+VutzIOcduyUQQAMkpi57q3c/A?=
 =?us-ascii?Q?SB1v7zQxS0owlSymRL4Ll1/bN7SHv00Xy5+Zwpelr/dY/HBBbc6FoYPTKn+J?=
 =?us-ascii?Q?DVrtLm52I0RUrlcug9xoKyYFqBR9BOaAWwHBIXvfjnsRMXRwrmSziBuvtngt?=
 =?us-ascii?Q?Cup+sZojWkTsWK89CTmJjVGk8LJBJ1VBPPJ6oQ2h18ZVvbUVme39UzhG9IaW?=
 =?us-ascii?Q?hqc33GzWsJLwKO4FZyjwic86VUWjsW02uQckvoimQOnQa9AIu7RhrdP6G1Fj?=
 =?us-ascii?Q?61ZHWlXIAA7UzwXbHm1dm/mCi9/f6QRhrEdS03UjBK9LAEd6j9a1W9LABGPP?=
 =?us-ascii?Q?4ptiDqNR39SJR4Yqo2YzOzVdfP6gNTEpbG8nFrflm7BEOPR8A/7m5pLv7+A3?=
 =?us-ascii?Q?Qqoxf7ARkMOoqNyRxh4Mp4Z1uEx+F3ZtHbkDE5ufPdzNrgQaA0VVaL7Uuu//?=
 =?us-ascii?Q?4VAmYLLs7Er6TZRpPjsWkS9WPmiUVMUAnlXYJFg1oECURh+bDNomZEZKWsD1?=
 =?us-ascii?Q?Z1qmfehb6smD4MumLl0GWMgEeezPMkPW5GYbCy59F96mSQf9AMz1f5oWrNtA?=
 =?us-ascii?Q?lZjZG1KA8j1tV31m+IIZbvumhDBmeklHEVxPsaVwvOjXHY2mnzURn62Z0+wN?=
 =?us-ascii?Q?6D6IjBcAf6iR6eU9tNnYyWLKT7HYpE0V+QVbIMASWSaOGFUIy9dhXeIxidhI?=
 =?us-ascii?Q?QakQRzpVLfCoVNM0Vzl3GI9pcQYAwQDW71Px6MyBEvyB8131ee+qtIDIJRlr?=
 =?us-ascii?Q?EuwBKxUzI6pXqYZQkOe7yLRIgYIGpHc0C1aerGFo4oBoAqyB1g49mRqpvBJl?=
 =?us-ascii?Q?RYLkM+E3kkEB2Uqr+nX8dL+eW4ReD9AQnNScsaecCleQkEyF6W62CZxe1IKx?=
 =?us-ascii?Q?/S2RgQMfDBqhxzygvf+ck6L0fY7QN1msZ4THc7uZTojRzZw2aPubYWnFKA9w?=
 =?us-ascii?Q?hp2Cko0PPU35TLnWr6kD5yhykpUK5BqXc1dfo4pargSQlu7xjToARWD4o41i?=
 =?us-ascii?Q?XZI6s8kOW/VLHeb18U5k3cekzzdGb9WTHNlA6CrvzCtsc9NeRKxt6gsd4821?=
 =?us-ascii?Q?nwrIeUk9RVBlLng6OisJHj/z14wF9CMfj/1KhUGcAjWGqL1p9wLzI2HJGNjG?=
 =?us-ascii?Q?fCEiHdz+los+B8R0bS49lMq0ScRozPyF9fF//QkQ5nMiC95wKmSPngXA51vD?=
 =?us-ascii?Q?f6O8yUHiosabnZjuUyKD37HFoTj2Hv6vdUoA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:27.5749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52566f7e-499f-4490-eac6-08ddf69453b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup forinterleave
granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6ea74f53936a..7b05e41e8fad 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -557,21 +557,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -587,14 +580,32 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
-
+	lockdep_assert_held_write(&cxl_rwsem.region);
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
 
 	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_granularity(cxlr, val);
+	if (rc)
+		return rc;
 
 	return len;
 }
-- 
2.34.1


