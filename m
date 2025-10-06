Return-Path: <netdev+bounces-227925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36454BBD94E
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DA13B9E4A
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF8220F37;
	Mon,  6 Oct 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cvmT62Zm"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20AC21CA02;
	Mon,  6 Oct 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745036; cv=fail; b=XsliMXs37TFA4WMMBjPL/jjc2h3aTDu/e/Q30qDNnGo4oKwQzUhQh6aUSkBkb4/32cxuPA66GtoVomsvO8S9h0Uljx0rzoXDSV/DmsgtstnUEtaoXdp/t5qq4fTloKWVjp5Y24gA5PfGydCClSN0C2oNK/1CEsGxy1XrGL9+PGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745036; c=relaxed/simple;
	bh=5GdMqrQo8RQGtBX6P7qlvATQrz8EJN2oIl7NXXy6eIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZZVEwrZVYjAYKmeYOwAVpfpXm3uJHf4wujtg606ZP5UyTh8EcYuosxu1rpQNXIVxx9IFBTVmLsu1HKMO38JiPkCP/TkPdIxktso1J+g6upVg4SsBkwjvU8Uw1001gDDU8wE+4VepjRADvm7RzL+pqlxlr1und7aEsFNICpbVW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cvmT62Zm; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDp9J33HhBtQWSIklBlVbH8V2uMOrJ8KdxZHlSTkVN57YJLe4RNnl2GfUuZql6ehwyleOdM55K2ErfQYnvykgWiVE+YaTtXF8Tj+crRi4ku9unYAdUExwV68TxUV6qGDqGUI5xiu6/Hv15msvDNMwkFsWVZpfF5R8mW7xOwalT2mEyIDulz775LjI71VVsgXoXuzRMO/1YwcPTa3N9qs41elEN50pECm7ohWlx/OUCQFllUcWpWgysFY3dVs0Hh6CtffulyVBmZAZ7PvP3PH+3aqOC9gHRqQnYP6MVO6GuIijn2RbJZ8y1EaWfGD6Z/bvcQ6yVAvngCTMVJgg0BbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p18rIg4s3ZKzuOSyYNiPkw6ovqDOHiDlJIiLGzEYRL0=;
 b=L8felbASDfl8IDVG1it6KJpOyWFhhIWuXcRD6z31ty/8pJIk7rhG/heq+6rb1ji+WxRkyYlr4YZ57ham8d0EOScn/Gx2UW0FT8ZSJiNE1/rW4NSbHE03zAmU+MYDHbk394pKhejOnZXGTLrDKFjDxvqeaNCf4K2nHoMh8KadqUiOIEdhDLrhak4x+QLwrcpjfm6mm0RLKHEawrb4UiFlyfQ/CKbokyJEXnQmfdyVtulB2hDRg9+s6Iag0DxaJZ2k9qaoWpi39T4G3c4ThPy9fM9wGyERk14SMWLQBulrmcIcuZiCkGbjbTWxzI0/jqug5Lrh6LYh+hhZZqrm4wPLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p18rIg4s3ZKzuOSyYNiPkw6ovqDOHiDlJIiLGzEYRL0=;
 b=cvmT62ZmdUGafx2paHZRwJvC5E/u7ug0azNLnma8P5CrzaDhENGq51WVRUTecZ2tOL7AsH1kggi/0NfSp2KQBCARiTGOckoOjxqw56veaucWU6ZpEtqAsZKcQym8X293f/UUc+ChIhTbOEl0zN5NT4+aJrs3O7ZP/0Hac6T1/8k=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:03:48 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::ce) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:21 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:21 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:20 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v19 09/22] cxl: Prepare memdev creation for type2
Date: Mon, 6 Oct 2025 11:01:17 +0100
Message-ID: <20251006100130.2623388-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: de4ea92a-d142-48dc-b557-08de04bfa500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXaMU7IzxePsH9/rP6xMqkxr+MpHyNioKTQDfL2nE6kOnsH8DuRljOwo8gmj?=
 =?us-ascii?Q?4TLIRT6qHZsTm8l7BGUGY8eSsMNu9Bm61y6whhshs4uohI67Ccub6p76NfLe?=
 =?us-ascii?Q?SNy/iucKv4qDzt8CYuO6D85oQpe3KB/kuezIEXsbOW1S9+/tNQQpfpMZGSAa?=
 =?us-ascii?Q?51azLNFWrd9CTYXt7AK7eUWaehSKkwcNp/hPqueofqQOYBbLytc0Yh89aaDO?=
 =?us-ascii?Q?lVTlHyYHilItQy6LSC9kfiwbh//jYZhj+re1QasjRTxCuWV/mfeJZwSuLG9C?=
 =?us-ascii?Q?TC+GwbD++5q/3K1VQWRdBazvGnff+mWpmND8rTtkA9oHpjPvDm2vPXEQU8LN?=
 =?us-ascii?Q?KIfsumNOV1Sn8lrH/BMuJHkvhK6JlpeAn/s2KD/T9Gc7dTy02dm4M/LYhxJ2?=
 =?us-ascii?Q?o8c8pxgj68glD5+q1jHnAphO4NG8wcDee4/t76FnrwSEqIVuz9pD9HM7Dmt7?=
 =?us-ascii?Q?8gxx83pqbPHZU7towv444Xry1f3v3rZY4P92nhBANr+sh9XyJp7UFGvU16xf?=
 =?us-ascii?Q?r4HyJVZekAWsjefd1st2UQEH1q4f8UM2XjZnlVZu/REUfBwvafp2aBF53K0v?=
 =?us-ascii?Q?UEhFkMozXpux4j8NPxfIfVXkhUFvOKX2+UUwgXsjYyIj2yJbA3rz4Q5UM/oz?=
 =?us-ascii?Q?1+UdtZQnV3wrbdHqCTzJdf7jdqHuUbaCvP05SDDlnt0wlPls2gl/1fltBFQo?=
 =?us-ascii?Q?fPvQd2i3gUDdiIOpcmpJUg6JX95V5iZui2tDyZ8RV1dAqHOMTJcSb77F/n4y?=
 =?us-ascii?Q?i96kZVqizK6R8uGfJ8WQdR3YShK/HH2QX2OVHkHL7EOB3KQ46wlY8xOPjj00?=
 =?us-ascii?Q?EluRtJyt9rG85pSP5DNaoCkDXNcF0yBa/gx/3Y6QJYWVHECqVWuqZP2hFfHn?=
 =?us-ascii?Q?sNkJx+hXLwlOnbVQ+M06BqFuSCM3dvjtjL8cqDLecsOgZv5j+JmEZVcjvitl?=
 =?us-ascii?Q?wyFDrADFs78cssmbYQ0yanPCHw2mi2lzX+9X26WrMeIxwmLinYRSLBjOmGDp?=
 =?us-ascii?Q?Ka1sFZOV8ah8Zb0jb6T36Q6SZRlodqpWrz2jVjeTdB/kvida4PZ4QFGGtDz0?=
 =?us-ascii?Q?5+9yv7KbaoXuCcfHIz5sYRD2NUpvwdy26YNKPqE5q/A8CV1r8p8LCn9tPTB4?=
 =?us-ascii?Q?Usy/+Hju8g/nbivHHY2al091vOwhPHaFSvfj006TdVJ456AfmizArPUBfafL?=
 =?us-ascii?Q?CStDPXrtB66bGUkVpb5okrRhDZq9t2WGb6QbQ5322qVrvs0bfyimvQ4k3u90?=
 =?us-ascii?Q?uqIQEQ6uysNMmCzHxHibXDqHnZbMVtKVPz3ad84O7nBGgCuQvTD1/qGJ6iVR?=
 =?us-ascii?Q?etZrwa11uOejzXIsjd5HB8hk9iFfYyxxFyKadNxJvSw6ntvyMKIba1VN0eqV?=
 =?us-ascii?Q?UEbo2Q+5f3eUfO/4VM4UxC21xWfjPqs4AWn+fgDx3Y+kuGR2Syt/tZG9UkZw?=
 =?us-ascii?Q?HljiBSZPPhPXkl7/AdldhZajMbIFodz+GbEA6AJkxJWNQKmLKo5OxkNmWw79?=
 =?us-ascii?Q?UcB1pc3KpM2YleKpp1O7QllijJKobW6LJe6TAh5AqRl7AHdnPOK3zHx16c+E?=
 =?us-ascii?Q?PlR8Ev9Oo5eFqVU5QiE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:48.6198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ea92a-d142-48dc-b557-08de04bfa500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accessible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++--
 drivers/cxl/cxlmem.h      |  8 -------
 drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
 include/cxl/cxl.h         |  7 ++++++
 4 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1f1890a93276..fd3058638c35 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include "private.h"
 #include "trace.h"
@@ -550,9 +551,16 @@ static const struct device_type cxl_memdev_type = {
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
 
@@ -1138,7 +1146,10 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
index 86aa4899d511..0e02cd9f0bad 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,10 +34,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_memdev_ops {
-	int (*probe)(struct cxl_memdev *cxlmd);
-};
-
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -101,10 +97,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_ops *ops);
-
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index aeb2e3e8282a..f732e35507a3 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -67,6 +67,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
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
@@ -94,12 +114,7 @@ static int cxl_mem_probe(struct device *dev)
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
@@ -238,16 +253,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
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
index fb2f8f2395d5..043fc31c764e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,10 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+struct cxl_memdev_ops {
+	int (*probe)(struct cxl_memdev *cxlmd);
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -243,4 +247,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_ops *ops);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


