Return-Path: <netdev+bounces-237239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B177C479D4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D65C74F1947
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A3257859;
	Mon, 10 Nov 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="12xNgsha"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82690314B70;
	Mon, 10 Nov 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789059; cv=fail; b=e3pnVGTX8R5CUyaijoYOaCFHz5yzhsCwlm2EFeZHuk4oF6ZisLfA9/n+EirSf0ywnNwx50Gt7yLymdzO7b5yZ+rTuGD8NH6kZe6O4aanYMwJs3TcBnqs99As6qY9G0Lpy3/6Bcj5e+oeY63c6orXrqydlQzkmbe+qW24Vb296Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789059; c=relaxed/simple;
	bh=wxr+eL8ApVKSOnYutPppPygFKTql1S6k8WbZbjkQaEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuVWpLua2R+eM2ftE6OrWU111B2ICZxk4KhPmFD3ybowWqkEvzkcyt5D2GhEjDGHSkNmh53SeOnG22x7ZH7ChYp+eLDcmHl/F2NLLEisv7s9qHnCuOgglAOfqKENyR4DnmotmkE9u8fGq8/bTSKkqWika+gEa+a1qvm8fLuf/l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=12xNgsha; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id8vXPrVMiyAL38ystGLlvjPAiDrYwZVIMEvNfGKGsRzaYY6fwePZJcelLDEkb2bmf5QybUphtcWKp2l24Jcarwow395CAyxai5Vn+gr30XHsnq1Tj3dHB5dQQjZ7gTgnG9cc2+8G6LaYzgSZaJ7AL+hNXHFusxhi+NznyLdgNBVe4TgVCtCJfXfC8LmYgoMmqpkEdNHxgLeCA7MR0mDT0eUkLbABl5/ItBW7C58TcsKzHGYJdoA0CQUsm1a6s0fque2jMsfoSrTjRuWbWtUUTZDDgD3WXZRZebUmCHhxed/9/LV7eQ7tuGwOwFSEYVNkxp9sa2jzHgv7J7cuTDm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIt9OF8ipb9hEB9W43b2n8lzpDfJL0CzG3hc534tVF4=;
 b=Qg0mrou+ep28zU/Bvp5oLeU5K6kS3gjp1VYPgWmo3UeJ5I1x+XWFMUCWFsq8/LQTHFSXIeoW9w2uksmT8yAHTzT/REmAvsZnAUFYUEVvXu8YtlMw+62QOuZ+SavFzCHkh6TRiBx3FSDomxySSLencaDNb0NeNYhMYtLxowMczscY9Dngtjt4ZbYIh95f+HIgSsa7V+sYESMg40q4ocP23dOkCPiGek4WIIGKzUSn0nk1voyBVoFjHGY3gTD4mKlatNPXIqANFlo7QBXs0STpURuppNR0ibJwV+KQLWU3a0qSEM6iqJ218qkHBPpZXyf2x8QA9hggATWe4H2BzpfrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIt9OF8ipb9hEB9W43b2n8lzpDfJL0CzG3hc534tVF4=;
 b=12xNgshafVdeF8xBPIZU76Sp31CHpmnQqwamyzvPSyiaL+l0HS45K+9dOswUTmolf5IapbBGs2Ltre3vQ9ptheVNiuSOvohHgSqwxUCZopVFe2P24obIK6DICpYLko5Wo4qNS5LbHyQNiBGRlEx9uUTB5r77BZ6LvydXaxepZO0=
Received: from PH8P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::25)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:34 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::ac) by PH8P220CA0005.outlook.office365.com
 (2603:10b6:510:345::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:19 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:19 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:18 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v20 09/22] cxl: Prepare memdev creation for type2
Date: Mon, 10 Nov 2025 15:36:44 +0000
Message-ID: <20251110153657.2706192-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: d01d8df3-ecc2-4a88-b935-08de206f1195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f2ttyAmk8uuPJ9AXqTiHWRyRRHPtMLtRRiBYZ6PGQlI4JCBkEXJ4cIdjK1t0?=
 =?us-ascii?Q?5hyAz4nNR7pOQ2bGLpCI/UDruKOS7YUT327M2IILKlM9UvROEGgtE4HjJq2Q?=
 =?us-ascii?Q?95Z1kP9F9vSb6ByW6m+P7w6X0F1i60isJS6xhfwzEX7GUV1iRwgZvQfaT+6F?=
 =?us-ascii?Q?2XHnbtf0LTt5TpeFkPg8bE+Dh5WcNHQ+xTyxbbf0ZKj2MNnFzvxt5VljNtUx?=
 =?us-ascii?Q?lZCFwUaKA7fNfYS9ne7ENI9hDwJNp5rv05B2OTQw4ch+zdgbX0RSHWCYLAH0?=
 =?us-ascii?Q?L3x8wlVJvoFP7a1tIGdV1PpmaDbVmwkfS+Q9ACq4yRSAh7x188e5kev5Qe4E?=
 =?us-ascii?Q?MZZZSgEz9QUEehCQvk8mzpxKSzM3fc7DUPT1H40wqFwuFqjUqnmb/N4p6qUb?=
 =?us-ascii?Q?Jc81ZSPJUMjJhc1dvrYW38UxCj7acetMRwcVX3AxGWqEbT5a4gBP6HuhLbcZ?=
 =?us-ascii?Q?j+8uiz9TZCvvbgAzC+lKaLOMwcBKP2nuj8yKLc7wjzgDhj//uueoptv5LDXe?=
 =?us-ascii?Q?CFSBYDfyDIWtdo71LMCYBGIWSc1Hpg9SPZRBeSB0mcnSpY6r3b7eWfLhX89V?=
 =?us-ascii?Q?II1flKy8xPxfH081kLzKCji0NDPErXKbMUN/It3FegmgRZkLUZ/pJ9S8kwsr?=
 =?us-ascii?Q?pE2vH2mWzFrAmq6MXp/1k8PpX0WoQF+YQHkOYpVrdpB69msFbgun0LRDOZ1X?=
 =?us-ascii?Q?vmxDcUlTNsn7ROePbQOspgbgCQix4NYjt39/nsSEJ49uFwcDT5fTP7wHKH7Y?=
 =?us-ascii?Q?StDvOjav8qx0n7NQAYd8UVH3y2ORYBzMaZmoormTJj3uvrzP0VtHSOOAoLRS?=
 =?us-ascii?Q?KuOR6sQ31LWYQRc4Oed+/mTr/u1CzVyJuj8dnJ+eGnGTkZj2b9meizqvmWy6?=
 =?us-ascii?Q?pkD/ZAQ/qXlswpWD+HkdxwE+dILhRIbwVT3ukP4si+JDg8vBbs82IFeNIJJM?=
 =?us-ascii?Q?bqpU+buzdPJFnUOs5ASf3nyvuOFEqFzvDMvgbU1NIbB222HGdaaOsNYQdFOc?=
 =?us-ascii?Q?42gIwce9DWsDzGOZvzHChS5/RvAgnQfMHJ0y2B0CJS8Pet+r/XHy2RID5QcU?=
 =?us-ascii?Q?EQZPdZX1HLdNitcIxOOrzkrZdZbp+0aaddc4bUBbaRFzIfXQq3MB9tTDXPHR?=
 =?us-ascii?Q?nR7MV+9NodLAH2IIHiMK1k7WRrIQZaOK9loQmKxWlQiW/9SulvxeGnL+CawU?=
 =?us-ascii?Q?sF4cxa5lNAQdGF+h6JemIyhXkgJVOvqGEM+sl8IoBDysV1+BWxZ0oGVo9k/m?=
 =?us-ascii?Q?myTO6zz2lzXjiE8KJ/czZ4/Sn8ERN81W+g2kYPZfc2tSteKNNj9DocWmnuX1?=
 =?us-ascii?Q?4y9GYcgSaIbjmt/5W5xMoxy8AdGAqdoMpNfcMhdhCffkS7iViCssZPtkhGUF?=
 =?us-ascii?Q?BwpjWU/BD0M6VXZCPy+G0wOS9girNPzuV1IOJhxlMU7xh+ksKD15enQcG/mk?=
 =?us-ascii?Q?gOSA9L5Yy4w5gQ1GT+5Tx+wdzfMY4V2MD40YzsLfL1wOiw6n0UtjFFsFFaIA?=
 =?us-ascii?Q?gfXxbPJlOFs8YowwCdNLddhVszAZTQoNeOveOK96dtNcfa/diOKJQcrdIOFj?=
 =?us-ascii?Q?Lupc6Gdj7ksc2EhFoHo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:34.1006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d01d8df3-ecc2-4a88-b935-08de206f1195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

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
 drivers/cxl/cxlmem.h      |  7 ------
 drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
 include/cxl/cxl.h         |  7 ++++++
 4 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index ea76109280f0..9de2ecb2abdc 100644
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
@@ -578,9 +579,16 @@ static const struct device_type cxl_memdev_type = {
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
 
@@ -1162,7 +1170,10 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
index 3409ad35219a..918784edd23c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -35,10 +35,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_memdev_ops {
-	int (*probe)(struct cxl_memdev *cxlmd);
-};
-
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -102,9 +98,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_ops *ops);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ebe17fb6bb82..d91d08d25bc4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -66,6 +66,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
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
@@ -93,12 +113,7 @@ static int cxl_mem_probe(struct device *dev)
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
@@ -243,16 +258,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
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


