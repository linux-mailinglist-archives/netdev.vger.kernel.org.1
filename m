Return-Path: <netdev+bounces-189829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A5AB3D38
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9806119E5605
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBFD2512E0;
	Mon, 12 May 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V15fRe84"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F91248F62;
	Mon, 12 May 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066301; cv=fail; b=MFceMk1kTCsSzg/aPuc3H0EWqoDN2p72EbhNoogRQ//JMpCoLbjiyEoDjwdhG0r08c7a3unzxpVVYCUGt0dSnHRGXZoc8sk4CIt8otCsJNNn3v14CqsjzNcIK8SZliSPhrVzeLowktVL/iRoONm9WEiPaEz2Ea3be1LOx0JN86I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066301; c=relaxed/simple;
	bh=rAc7/aYgkRzU8lh3wQaLU+iCjWP1Hu64dMrqNoBvCJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wt9qaiW9tmsQ+tUhPa0gdTBKeJY6QrAXgEyB5mdPKVHYBZNYQGXhTPlcSWmgfzxNyZTG3lGo5Tk3bdINoctB9Ko1ykulo9evfSC4RuKyJrzIwOVWBQtOLTg34BsMoBhilVSfNC3tm4nFaQGTijHixjxv8Tz9VwG18jCE9nfABEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V15fRe84; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drd6X+CWf3DddRJ7C0w3CLwk07JcPSCfezAfCADV2mBhxkKW56ikEKUFbaSbLEDoylRSvIhn09RxKKmqYjEd6m5HXc1olXepSnGjj60k5Kx/lofYGR6avzbqNB4jeXYs7aUuCfI+E7aEIhaNOqsxaCB8xr6gh+1y5Q4UnIzangyyM6YkM/mYzf6EX9z4z035bNGxL0kfhmDOgirGO4+LQRFnYm5Ds2//SUT9bzAaOY3LtQFPSfUcPobJ/GDmZtzTzJYDRHKpNGQUbkMOSJ/uiEnEs5HfxrxSLp9VjghCRKpHoY+KE0VjPcoSjecaXUYWnDBnBn4OOdi416K3FeckJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5wvbc4nhzuvQ7y+dh5KC/DojZNntjMG0JCwQj47EiQ=;
 b=rCTBOwWDRPTyiB8rCaONLDXOuXWldmbbtmb8DSQrekaCqCf1Klq2On+A/3EVTH6+Dxhu4iOhxTSsH+kf7hlIZPudxA30SVYKj30cp87O8voPko4Jn1WNI543pkMdO/IBKlOsb4+MXug6jEsRe5zFf2BEhHxSIR02YYk0HNcftqV5HU4fz3m8gWdNbJDg7Qv5ZQvl8h+QUC9NTVLXwbDIwWbaPrmnm2KGC6grtcYKJ19TP/cQWOOJM8T0L/KwAjvbViPD4jagQzZjUvvzEgK0bRDZwiZWPm7H7k1GJTG6gdl8hhFlK0sSwnpYEgCYljucHrS38ZL7JhJD53pjJeRykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5wvbc4nhzuvQ7y+dh5KC/DojZNntjMG0JCwQj47EiQ=;
 b=V15fRe84nQq1DW/kPTMdZyZ6MUabEWNVD+wMTum/FrTToRC4iKaXGLsQ9WfYOGQpllNm1vrVk0EKPblORfKX/k0uc0b5XZCGI35kfz9QyxpvVNDDEJt5osybY13PGtAMoPXzFefiMC5qzh1v0OlAT6Ty7Ck0baX6bYa5pv95Lec=
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:34 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::92) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 12 May 2025 16:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:33 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:31 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 18/22] cxl: Allow region creation by type2 drivers
Date: Mon, 12 May 2025 17:10:51 +0100
Message-ID: <20250512161055.4100442-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 5055b778-d29c-401f-a760-08dd916faa37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vlQnFxoK9717jKjr1ek56dh/+J/fGETKxU0zNgKKwNRgkHH8wUn049Klt7cc?=
 =?us-ascii?Q?eEx4PnzBH2qSaTWIoGUruUwnXlTq+eJ7/nA5Ql8yDJ56iHImT9LQSOHb9ipz?=
 =?us-ascii?Q?EHEWZYKHY5pU3IPNGjRq8GvccEBzqMPfsHts7F8lgrKpsn0O8xnyap1x3abu?=
 =?us-ascii?Q?nXOwHlmZiBiEw+3qG8KVnXGxL6uQATKKWgJPFXUMuteQXlY80QAjnN6uVCfg?=
 =?us-ascii?Q?d81Pm5E1oKRHGaTg05pb2hrH11fupU7wiEBqsU6MZAwhoQdOtMKNlCH43Bkk?=
 =?us-ascii?Q?DbomBosZjmIQPT4PVjBUdz9pxn13pNJCC7N6ysI9xoc7EN2rRrlFkqplCS/7?=
 =?us-ascii?Q?dxbUEGxShHMepxkM1gDJyoqD9UlbmUBKQrnpor64rOCcHk3XSabRCprckfJ3?=
 =?us-ascii?Q?1mtnol/Pmhloochh8Icjjl5qnzbTzvE0kEWiFOd1YdmYfPHaifzrVkYgG5PE?=
 =?us-ascii?Q?bPqRZ/WOzOASsGA78yav7ppvPGwigOfUD1ZU+z1UAGFmL0w0uuc9KpMSzLu0?=
 =?us-ascii?Q?7P+oAM02ttu+hUxR4xWmFh9ONEchuIlNTclyl7Xy8TMWfvZu+WF1HyvqWhrl?=
 =?us-ascii?Q?8ZiBXkf/umK7yrI2TFPElM20fHv+j1C/vesQzOQ/LEHnGsyhBY7WgkNToFxl?=
 =?us-ascii?Q?3CMTEiY5ROsOz5STZHquZJdKmwZVJenBHuFuHLy8Yp3Sc9azOBNf8/WbUP0T?=
 =?us-ascii?Q?sVZcIa7l+wnT7lKdajpyErFLaDUqGk9IeN2gOY/ypI49tbr2mExWg9eZfRP0?=
 =?us-ascii?Q?3L0mgOR2aA3mAoonC3G99OwEi6LTJ0wA5NOwX1gy4LBprcjFGHahJxED4U3Y?=
 =?us-ascii?Q?3afA/NTFmYe+IfyPXVXonfDisLrbnAAVu3HIClNYT5EGIgqkQeRjE165mAYV?=
 =?us-ascii?Q?w77AgNGOALrxpO8rCDR9/fTUzx8mo4v/F9nQ9AHymIdTG6SEjCmbGGZ+1wmO?=
 =?us-ascii?Q?D4F8L9OYk6yzkPuQ15MkoUiMgdndQ7JzdMAvRITBPGXllZHFsup97RUO0mIF?=
 =?us-ascii?Q?e9o3Uux/ltjaGvnR22jrBuZrwrSF69MsKEO+WrofvrKEcLtACwE7oBWN7shs?=
 =?us-ascii?Q?ORTbWTLpylGaM7vCe6dLW4G14RhN6C6owVF5haM2+y1hpfdDigkgtcxjBJSy?=
 =?us-ascii?Q?Zm1++aFpGP33PZBti5t7ZmZLhvAaDteAf0kK2o+Iv8jS4I87KF6ojHhbDfAh?=
 =?us-ascii?Q?MAPradtEFd1jQ2YtBXpCFWKBJxbos2FsHU6wavqRZYIduj8oGZzl236+OWob?=
 =?us-ascii?Q?QBthz1hZ4h6XpFGBZ57RPkGrKH4W2DNhGa6hVLKzAShPwdLRTQD61jqRh0FG?=
 =?us-ascii?Q?cEbffWeO+aZNehHhh1iU4jdQ2tM9LHByLruq22f90vrK5NbpLiyhgzJtFifI?=
 =?us-ascii?Q?TsWiEumVK2BwNYKu2WmEU8FnV6JvQI901ulHE1e2wNTlPvtXTJADIRhtwX7k?=
 =?us-ascii?Q?ssoNe31KZs0gNP3akwjeYzTMolKQMFnICGSjKB0Sf/RuqtrWLGhjWdtTMRe/?=
 =?us-ascii?Q?glQgf8mchvIXZep32wU0YDVSh7M6IOv8naRAdehW/cDQHoeQTN4w22Dd5A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:33.8828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5055b778-d29c-401f-a760-08dd916faa37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 141 +++++++++++++++++++++++++++++++++++---
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 3 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5fd45a879af0..e1953f566004 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2329,6 +2329,21 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+/**
+ * cxl_accel_region_detach -  detach a region from a Type2 device
+ *
+ * @cxled: Type2 endpoint decoder to detach the region from.
+ *
+ * Returns 0 or error.
+ */
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	guard(rwsem_write)(&cxl_region_rwsem);
+	cxled->part = -1;
+	return cxl_region_detach(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2841,6 +2856,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -3574,14 +3597,12 @@ static int __construct_region(struct cxl_region *cxlr,
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
 	do {
@@ -3590,13 +3611,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
-		return cxlr;
-	}
+
+	return cxlr;
+};
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3607,6 +3639,99 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__);
+		rc = -EBUSY;
+		goto err;
+	}
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto err;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto err;
+
+	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
+	if (rc)
+		goto err;
+
+	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
+		rc = cxl_region_attach(cxlr, cxled, 0);
+		if (rc)
+			goto err;
+	}
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return cxlr;
+err:
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ * @ways: interleave ways required
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_region *cxlr;
+
+	scoped_guard(mutex, &cxlrd->range_lock) {
+		cxlr = __construct_new_region(cxlrd, cxled, ways);
+		if (IS_ERR(cxlr))
+			return cxlr;
+	}
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 static struct cxl_region *
 cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index fe4b593331da..d1b481775d2a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *unused)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *unused)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index ab5b40e657cd..332cbaefa7af 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -282,4 +282,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


