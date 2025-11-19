Return-Path: <netdev+bounces-240152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2632BC70CB0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DE3E229B4B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A53373752;
	Wed, 19 Nov 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vBoo2IJj"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177A36C0D8;
	Wed, 19 Nov 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580214; cv=fail; b=btneqtu8mQ02BX2MCipiTZVVL1WuVpk6N0Hym4Y1FjqrnfbQkLZACiRmBkNNE5dJgH3cfzJ+dHGxZH1I2fj76zxQL9Vy0T1fRDeTRjvfoorxiNstevYEk3/ZmNIwcBXyc8jVLLHviJ+prV7LEFB1nohBDaW/kK7Yg5FgPtbBlpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580214; c=relaxed/simple;
	bh=yLoqKTRe0J0XrtIdhI5heOCWjeyKYTVZ5bXS93denRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miyGf/FH1VylIlqX1m7uTcq60xEJVvxklDLhTLDBG3TGuE3T9H3sA+8uVncJMiKnCYSu/GgBvIf8kGIVB4rttG5K88enflAJ+xSmlciDxz3k6z65Nrk73SmiVXRTmYY08+oLJbutG02yU/hDDKeeQm5mMp0w3Fd6mNUfqg5rNzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vBoo2IJj; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxklYbNN+jARkgcbcf4K9CSazA/vOrPKl5g3RH5rbJNKE9M8088NvOc/NkI54WdIxK5da0YL3Tn2SJlhIDTUhEEaGxyogOUkCOPXMHFtlhKopWc+ODJDbtw8IPmMmHnizFo8gjuKMYHTKYeUOkNEFJEMjUf9KaMr6YjzE5LNkby5N3m2BlUgVUM94wCP+nvIOHhI7tQItYV8djcbD6DNbwxUWzDTCfnbYFI64+oQuI3XzYI7aWNNHNsvbrOMuZ9V/tefenkjkhBErqpXyEao5Ly2K19TwHl8uJ88EBBJZc+9QH2KT4iTB2sv6JKYhiLBXoI5C9ASDzRMqx04/ZHGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvZqAZYiGvgDjsTupfJZBbAWgg7Fw6Db7ge7BtaJLik=;
 b=M6aPfbBJUPURjLTN6eN0t8IrB+xXPfCrm5E5cWI/1KxkrN9wT/DEvYXUhggQSDGVdVH1MgDHwQxTLi4WQ5gPTo61TUUJKEYfh+6gXzAV3HnZ2udeOnQIM1P91FtOpEk8cpeC5gsyladQeZ1VMDd8sIlvN4BSmpjG/H5ZsYCy67jyQVGSJu0Xi0Nz7Tocqb4oFkc30KCW0TwMd4JuaWX4T3GtQ4h4ZFdmfe2PhkIjFKNVf+onCANS0LqLW+4bIu5EqLAaiHCbZlphefMkCULb4T80pr+pQP2s1vj5wJXsYbxIS8qhUkhVZW5UvX50RAeyRQ5OHjbFIhiOd3rL9bK+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvZqAZYiGvgDjsTupfJZBbAWgg7Fw6Db7ge7BtaJLik=;
 b=vBoo2IJjTAXOb1nxNhfR3l4kieVFx6+2qr8PTUF2s1Oc93exz1ie6xP1VyTOd28HJCDHH/C/cRg0ZowrBt1jgKEqqA5DcNt46woCcTRigTbc5rW3qrABKgpxmnlycb42/7T/uMqp+k1RZ0VbXFzEuFLSu5SYbMi0UINeK51t6oA=
Received: from BN0PR04CA0178.namprd04.prod.outlook.com (2603:10b6:408:eb::33)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:06 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::84) by BN0PR04CA0178.outlook.office365.com
 (2603:10b6:408:eb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:01 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:01 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:59 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v21 10/23] cxl: Prepare memdev creation for type2
Date: Wed, 19 Nov 2025 19:22:23 +0000
Message-ID: <20251119192236.2527305-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: ae74d590-484d-4fbd-be74-08de27a10e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sL4coldrbLveUhbxifu13JKYKD1gZ3tl1Tee5yKsFxfgSQT9+XP7JGPPItis?=
 =?us-ascii?Q?QSbceWFEEM6U60dE3g9QdYOfrAjJhCA2KhbnMDhI1C+WlslOx6o5aE2OAMbu?=
 =?us-ascii?Q?I2simqRpfZ82j+DgqwaAW+DGRfQ8yP+2EOLyAuL2hbtiT8peRcaPpRUH0b6T?=
 =?us-ascii?Q?3BUDnF2VEgzoWYkTOjML98dMDAKDf3+VJInhKTTtL9iy9fkX7QZVuRtnuDmt?=
 =?us-ascii?Q?FkY69L1hz4nuCwJhLDRSYHWhX8nWzM5lfBRw4JgiAdzBbp71I1GLOuCyeSvB?=
 =?us-ascii?Q?XpGnZeOZBRN+ObyWWTiY9i3ibudLo/kfKdn8DolxYFtujkOw0GE+6QlFAi17?=
 =?us-ascii?Q?gXn+I83+IvoSW5UaP3p+by9suFVUoyYxoSRyVM4CHKxRBnO0orzrE/bhJeIq?=
 =?us-ascii?Q?TVErQUpJ5brlmo2tkcZGuX/RBDE3fXKqxzSVZf04JjjlB5g5f8iqKJH/javO?=
 =?us-ascii?Q?fjwZvY4jZJCptC+9MuduVuTOiIw4kAUqtINt/YBuNUEnchS25WreRfx3t3Qv?=
 =?us-ascii?Q?sHu3ZjPIgZNp0Xx17POhF40VOO33jAtzjfhu0Do9bFg0v0Lo4SCsLnLFCklB?=
 =?us-ascii?Q?ysCpsOf4WkLVsBYP1rvzedDqe5QtIRJsoyJO0dFWKXEy98YnoAz8/9lll1YV?=
 =?us-ascii?Q?jxAcjnz1Mka+8HhNUzTA579UuAMPfmbe8OXeRSpuKI/xigJcY2M0TA4wn6df?=
 =?us-ascii?Q?hQFIh+pUr3RMwtL2yvxew68vlLASGFfTUzHtQRGDcACyWN+8es2DYnHyaic8?=
 =?us-ascii?Q?3XDo+ohDrO5tWUTCCPocAQLod1bCxESTVigzxVH3YyvVpLCnDxT1HOj2ih5I?=
 =?us-ascii?Q?+ZqozDsrvAhiDZ6Lo68Adi+7WtR6Q/ySsdMZu/BDMVEGE7h80R15eDe/2RR/?=
 =?us-ascii?Q?ugunCzrQ/6iLJyriG4VXrT57XTiomKVUc7r6KmtIm/0JpfTR8gKMyGamA3yO?=
 =?us-ascii?Q?AilGfZoe+6fiZAkpnqr2c01W9qhWonRy4Vi4D78vYIjBwlOPJGoJZR2JQwi3?=
 =?us-ascii?Q?cdkJ4z12LbvOpC08yX6Mhx3OqIfNocJcP1ZZ3RaLPCI7s82QbwNceCanPW2f?=
 =?us-ascii?Q?0qGSs5cDAC3LZ4Ao3OweFn7kqncj3XgP9m/xsS1Zi5/jmYZDlQh6kBb3aF7Z?=
 =?us-ascii?Q?qSFmKZGkt3z5usghQGBNQ+fLmhIoSWYKT61AmskVDH0kPHDg11/MgtJARVI9?=
 =?us-ascii?Q?i5qyzehS5V/oYSKhPn1YFJ889sOwd+SDLDvfz+OCm0xnma7OgW9jB+ZiyoLO?=
 =?us-ascii?Q?NjsWeW1ypnqnjpVGRLsRbh+N7clIugGI39FM7CxJKLiYx0kNISPyHbrfiykz?=
 =?us-ascii?Q?GpdGETGDsneoT1aVYG7koIISFvYqY8pE/wkMiQlkafdx40ZKNE68g12Y3++s?=
 =?us-ascii?Q?S2zDg8hYRZxag0TMXKHvJQOs3rOODRYSjVaZy1ywCG4pXNTRjxvT6bHkGlll?=
 =?us-ascii?Q?yeV4ia5JnMLVbv5U2trLPHFdtCPksNpDysMMh2C/Z2U5yxZKkZmPuE5kKbbN?=
 =?us-ascii?Q?HFuI1IOdMHNfgvKCTV7Hjr+QrGg0PMRKi/zxXpFdrda2Jsb27Hg5dDR+MTI6?=
 =?us-ascii?Q?rLC5TaCllOUClz0sLxo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:02.0051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae74d590-484d-4fbd-be74-08de27a10e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

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
index b995eb991cdd..759f3a4fc2a9 100644
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
 
@@ -1161,7 +1169,10 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
index ceeda8796cba..9e5da2f20753 100644
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
index b57bc6f38e64..47dcab76801f 100644
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
@@ -248,16 +263,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
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


