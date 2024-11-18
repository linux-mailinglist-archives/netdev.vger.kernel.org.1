Return-Path: <netdev+bounces-145953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4899D15A5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BC5B224F7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68561C2432;
	Mon, 18 Nov 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2qtIEVqB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC01C2DCF;
	Mon, 18 Nov 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948313; cv=fail; b=QloP0iqZllBnsmU2j4nDSmd4uSGwGrXkdrC+yKKJF6ocjpjskM5KEMuGtPJMhlzUp36qtZx2mGFHAbB1Q0XFyM65vSAd+v70QG95e+yAdR1Zigl7AH39T2oNY8vi60sAUZMEI6T8HTHHnd01gpdAsMLeUXdlnpNZp4cAVv/aB0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948313; c=relaxed/simple;
	bh=xGeiuFmLrLZaVKe/5uBJmKf2dTCgm6MQ+Qpx55bz3UY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtfHdIyMqY2IoHBdm0E/kZARhTcdfwXqjna1DcBZHSIBjv6KvguEH5pK5dZRjFcLgtEMSKsYyntX/fQhNGCWdWkP4YThgNI5XWwt/6K7wdtmsRUD5w906EUHbZIMT6IrqIKwhfYM3dX7Ha409MDO2I9nFscGCD8wlhdUG5BmyXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2qtIEVqB; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6DbhKtDlldyu4JMKcKWBrhQTf8XNgX79vCvV+KIm0wCINZrWUYUJKJ1OtJ49DilgY4LZhveCQutl5Xv6qNNkUKejp2skaW1uHlOAE/AwwAEinHqBORtJpllUP2qkcw6XRzbXUqsGLPu31Zn/aViFgvTjT8q68Fli6PpAJfs7qXEAiopvz7kcvErtdeOQ3QfW6AABtUv7D/cWupqqDqQqrxDjy+oj0+gZsuSbb1cuQhrb4cCDASrGNct9eXzqDyJXPoK6YGQTrt1TJzO0cJG5KchRqF1AUx3UPJ/nORCsE7SXxLMT0NqMRP3i95qQbymB+LobAZQhbAB/90lwSETFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ6jzOoeJWGGzUOr5CYGUaAU/lwtiU1zntNhTpYDVdc=;
 b=y+xOOKXjNkJ7sfGB/Rc9S/paVjhavkPCkQUg8yyxmkOH/mn9gbrqbLXEnbOLAbSLd/5v9Upzw6ufIma4+yyxJ27YuHwDZAcLaqJTglgr74D/9IOXi63aT/tRyl5xxmDG+e9RMiQU3xH1BiSqUlJgm84tO+SlpVO0u9BNvExqLeXaYrYlRvnjN/RqqptZO3fXJVJc8Xtj1Eky2y9sPjUG+ka7eFkOg3BZ0YAwzfUmAya0WbNY20IwJjmEjXJplhg4+DB5jIi/2nKUY0mKTXFqgGgFjorEQDbLzyeh4ESAvZxiH2aJSHAk/+sda6m9Jnc3/z5cP+Y/bg8B/G037BKzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ6jzOoeJWGGzUOr5CYGUaAU/lwtiU1zntNhTpYDVdc=;
 b=2qtIEVqBCwy1sBR8U6QMeL1ZRJyJgZhmyxLoJeL2atKSkBT0D8++UiXOnKF77jK0tuCcl1Uu2arh3WBfRSKNWhU0Lb6asD7cpRyb7ACsVWlrvxg3h3AiVZM1bASZ3iCCjAv717GkAxlsGe917HVNDX8ySz1QH7ST/uLbYVlT2N4=
Received: from BN9P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::15)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:05 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::5d) by BN9P220CA0010.outlook.office365.com
 (2603:10b6:408:13e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:02 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:02 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:01 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 13/27] cxl: prepare memdev creation for type2
Date: Mon, 18 Nov 2024 16:44:20 +0000
Message-ID: <20241118164434.7551-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a0910a-b5d7-487c-7cdd-08dd07f05ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wPrTNUj7tYsIcWV6N1w42WG3COUwrGhk86Cz3gDJg+XB18J0B+RrbSY7Mgi?=
 =?us-ascii?Q?syvHY5rjzR3ziYJuoQZrbCZcIlyM17yMVkKsuW3kLwE3mDrXbC82vI40EM5A?=
 =?us-ascii?Q?qBa0m4c9pXnavZJ4loxpgA7uA3FUWk5wDlq33RZnrhT8gsTkEXULKageXvqM?=
 =?us-ascii?Q?UCbrn2xjvjiz3V+zANoZ9pWRh3COJrvevnLfcEJJdRpdFmmDPdi2Htf1cZ4d?=
 =?us-ascii?Q?pgLPJQPBcCOjqJLPWJiIUWPbpcTk+HoAMWw2F3tq7JfW9W44ILlt207Sfrl/?=
 =?us-ascii?Q?mD3x7qsdPP3H4gUk0mxhx/4sjmfbUpwKBE6benwBpJpMD5oNzJYXqsJhXmgN?=
 =?us-ascii?Q?4a51FxFEYaLn1B5MDbucfjFlouEQG9DGuIhLWmASAVwKLSUCuYDM1IZy/lcM?=
 =?us-ascii?Q?AvXxp0ONx5UPjTTHZS9wqwo7M18ON+eu6/o2+XMSOcrzSG/DtJkzze2Istwi?=
 =?us-ascii?Q?Y6eugYAkFIcXaPIGiwPbf2tG5trsknBRrAhsRpPCUIF9V2a/hrq5+qcPTrHc?=
 =?us-ascii?Q?nQB7iN6UiBnz0N+4/WPOq7gF8/gbsx0IDQ73breSwb+xbV9BDkJ5rSmm11w1?=
 =?us-ascii?Q?4G/u17dLEId7juZqP24/bvE0MJEcaWn3Gyczg016QOhnErOA1O8XqR1nzuXS?=
 =?us-ascii?Q?ZYXeoiJSY8Jc6RHTS0IGAk/jPRexL9L3pn0qMORIjzPQBCgCIQ0KjyXK4xhG?=
 =?us-ascii?Q?9odDyMUsnIw62mTdUH3FxFvfmykYymUxYTbQWiFrvjDzOuZ0M3kFD9gtaCy2?=
 =?us-ascii?Q?LlxlVbPNiPFqksUNeHDjEn8SVT6FWlp1Lb2i0U7U99mcy92YfrLG3UKg5PDm?=
 =?us-ascii?Q?24LiaprMZvPx1QJXQlYiskHLIaaBYMlwTE0fvbloVuAfEoA4J6ZLYd0T/GYC?=
 =?us-ascii?Q?jZ9JUdv6IJhKjXEQ5CjjmkU1JcwmrPjnqTgowfIQln+NaUcDED8a9AcKg6Cs?=
 =?us-ascii?Q?8Oo7+yy6owmSpl7UkA78WEhuoLOlE1MH3aLOVHVjnRTipL0NUrInKDAmOBUe?=
 =?us-ascii?Q?AS26JZ9dqZqxwk5ZUPiY+19ytuEELgwUR4uEC0V4aGZ8zcQXWo875JpbkSGi?=
 =?us-ascii?Q?9RzsyRY7MFtoyqZ7LCwU/+Kd7EaZFQ9I0OBG98OsMmg6X6H49yqWYx8xeUdI?=
 =?us-ascii?Q?TzUOzxz1wMNBOvZn2fLBSSDlXW+0mesOxj/riW4O7CdBtcoed+2xb/N0mkYG?=
 =?us-ascii?Q?KTwGW7f8bMxf3zsugkkgjopQ6MG+BzVdwQ0gXQovS5jmhoED1TDTGOYZ/J15?=
 =?us-ascii?Q?GNqcctfGlD0eA7pKnxB9WeV8OXrzKaXAx8xeOOf0zwUbrQyvNTB90F5tWi+U?=
 =?us-ascii?Q?TUs4yVy+wtaUb9JfoRyttUegTgkxN9VPz/u0jCXW5mSRBQYste22uuxxq96v?=
 =?us-ascii?Q?yDQa1W3FTiKLZQWYyfWnuxOwZNNlUqrmz1WlRWpn4AW4oGwT7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:05.2134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a0910a-b5d7-487c-7cdd-08dd07f05ac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type. This last device type is
managed by a specific vendor driver and does not need same sysfs files
since not userspace intervention is expected.

Create a new cxl_mem device type with no attributes for Type2.

Avoid debugfs files relying on existence of clx_memdev_state.

Make devm_cxl_add_memdev accesible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/cdat.c   |  3 +++
 drivers/cxl/core/memdev.c | 15 +++++++++++++--
 drivers/cxl/core/region.c |  3 ++-
 drivers/cxl/mem.c         | 25 +++++++++++++++++++------
 include/cxl/cxl.h         |  2 ++
 5 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index e9cd7939c407..192cff18ea25 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_dpa_perf *perf;
 
+	if (!mds)
+		return ERR_PTR(-EINVAL);
+
 	switch (mode) {
 	case CXL_DECODER_RAM:
 		perf = &mds->ram_perf;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d746c8a1021c..df31eea0c06b 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -547,9 +547,17 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_accel_memdev_type = {
+	.name = "cxl_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_memdev_type ||
+		dev->type == &cxl_accel_memdev_type);
+
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
 
@@ -660,7 +668,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dff618c708dc..622e3bb2e04b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
-	cxl_region_perf_data_calculate(cxlr, cxled);
+	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
+		cxl_region_perf_data_calculate(cxlr, cxled);
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		int i;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a9fd5cd5a0d2..cb771bf196cd 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	/*
+	 * Avoid poison debugfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (mds) {
+		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_inject_fops);
+		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_clear_fops);
+	}
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	/*
+	 * Avoid poison sysfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 6033ce84b3d3..5608ed0f5f15 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 void cxl_set_media_ready(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


