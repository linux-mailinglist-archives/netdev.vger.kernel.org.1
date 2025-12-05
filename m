Return-Path: <netdev+bounces-243788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA5CA7779
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96070302CB4A
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C132F762;
	Fri,  5 Dec 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PpCaq2YC"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B581301481;
	Fri,  5 Dec 2025 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935601; cv=fail; b=DQ7cWHsPDVr8C39jjk1OKGfH02vAZHXTUCq0sqENzHhA9YQe46g7WMOvKVacl0Mp1RBHd+iXQwDphU+RQ73ixrOOCcg/htoSoDHlipw5xpZ46IttaZNCJ2G3715RFF/zmeBxgP9yzJX687QbR0zl1xszUqtYschiRdg3b8+wEAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935601; c=relaxed/simple;
	bh=tH38BlOQNqC5E1GGtOfXi5j31GQl0gTnLTxGVzqvbXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDrQ5E+Bzfe3umOpRuzRDL0bl1m1zNcdyATyrAA9TwujcdGegL6VGc+Yhaq2dGJVkSVc9otptg70vqlIXnumUMxOMoFsMf4OytBzmty9EMLUyskXRHTusEipW+dE7npK5/+RsHxMwRNgjBM4uYdQJb7ik4VUHku7UhPX7Q1EcLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PpCaq2YC; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2yZNZ1PGsm9eyk+9PNRL0UQV4P+LirOi/ZekdKgc2D8EgYG891VXUPZGK3tG28RnbcQsVOWsl0CJilUbFBuhcObiwh+1hjzsQqxo+Sfs7H/p5Bmv7awF5D6U4LVse80lN+hpWu4cHv8RU2DPc6zUzrhiCqXl/aqfVcDq4XfRAGTBZv9p97t/G4oBK43I1R9INmTlfzZ5DTiOe6nFHGZXLKm7dlSgBq7qbA/TF/eDoKNEccNTl0No8IpT9ER+uVYsUsreMutY3yPqtM1CYdsmJL/25A54CNwQ4Fb44rqCA+kWSaVyPCDUWtejFaxc1SzapPsROhEIPVGF4tk7O34Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYyTpOZ/8j21PXfG/kXD5SAlacJ+ij1UUv4EunN3M+g=;
 b=qdxJsP3PUTi+n/V1yJ+SKwsBLy+6vb1mRZB8cMiRC38bpLOAowwTVDUO8Q9t1slykjNMuiyaqrAmSsjsTHUW7zBYjCOc7UKemSWz9iRigbFKo9jC3EP1unI+UgEguf4t83F0z5lN+Jk+kn+R6l9hBlvvZNP4MlaE9q3nleIXqmZ84itVESdI6a+viQMPtn2K1kNNvtAqUkZTsyV+1IjRW5NCQHZ0u4RqhJpt/oy+LHvkU311FZ6KQWH1weJJmBNgtm946APOASqAIBS4IPxlYucDGH6bO3XtHiKalzaoUhkAjmaZRrZe2AZwFCEEzA3uQiy9yngqgWPMoK+HTiTXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYyTpOZ/8j21PXfG/kXD5SAlacJ+ij1UUv4EunN3M+g=;
 b=PpCaq2YC0h+QU5sWGwwgVu/hQup2eg9Q4lBBl6OfwldLg4hldsJgYPCD+IFigDnwmAq6SqCl/USjV+MVclkaTJi8u3BSf6olSTDKqoaFjd2uGzT9ET6SUHYCbhJ98M10YE6AOE4GO25Rwd5CC1wnGJFsM/QDTZpmdx6aXBG6c3g=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:12 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::74) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 11:53:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:11 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 03:53:11 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:09 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v22 09/25] cxl: Prepare memdev creation for type2
Date: Fri, 5 Dec 2025 11:52:32 +0000
Message-ID: <20251205115248.772945-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2e2788-3d64-40ba-8f4e-08de33f4de27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dIryHC08HOcvMyC4q7vO5Jo9i5M2uVeiZjuZXvRn9mJObWg8w/KhWzGw/u9e?=
 =?us-ascii?Q?5ykabgBC6ZFRb9yUFK2uSVD0PiPtYGgoE1ZC/5uw5Vi3WrGpfSe5yxuFAfWJ?=
 =?us-ascii?Q?m6ZwEum7VfrvJ0MKqT4jLmGHxP7JnomxmUb8ZPXFviW/MXRX+UCXhY8AgxOp?=
 =?us-ascii?Q?Gw0KeB/cdi6P2YvysUKVHXbigoMj+tN3jg86d2PdF2FeN63L9Qsr4iREAlfb?=
 =?us-ascii?Q?h7mVRVCnYhCAto0uaNXzBpTrhtKjukLAs0OOmE/xptEiHJubIZb3Nc5kl8mI?=
 =?us-ascii?Q?eUoOgQUk/+2aIqt2BPMMuTRVGIpb78pmyja/PM187pqrDM/CTKe4rIrfinWi?=
 =?us-ascii?Q?ZIOKKiXkZdRF3v7f/UATVpx7Ob3XIhKwVIxhumB1jw7EJ3EM3lb5VxE1KvnW?=
 =?us-ascii?Q?S9u35VRFXNtZPZxgz2BGNH10NL3TZjUDJ4xq3qf0CCYD3+8f6bUt8ZTx8upw?=
 =?us-ascii?Q?kgKhVd6QGNCUEXrlgbdrYRo+54zChhU6kT54RBhw+JyuHBmCaKYKOi+W9/8K?=
 =?us-ascii?Q?hx9QUZ69+CMgJb/L91Bomjp9U8TWTzlL+fu+4twLr9q2nYEeBQjdZhLjutvE?=
 =?us-ascii?Q?HTV+pv9+NePE8VlcGkJ3VZs96ifDBwoIcjcgfmVL++BWDQZkKdvKzDq1GUQ3?=
 =?us-ascii?Q?e/CO2mIkfN12HxbsS+E/zxeQ+jP2H3bPLOjH94dY7eKbrUY6hLeP4ThKFVIJ?=
 =?us-ascii?Q?N+4flkiiwZU4HYeeEItD6eC8xbEWjCmUN2tKRDjy2AfKAj6KMQ/kjrRYWD/r?=
 =?us-ascii?Q?HB9oVLB49gwOiVKxyFBRF1JMyVsWXZbT3gQYLRKhtBxq5fpwXw07dXh++arn?=
 =?us-ascii?Q?RI11S++7lBg/MgBK+Gp+KbskI1OszRNdQ4Zox4DKYFyDD87dus4pQAn4tEYS?=
 =?us-ascii?Q?H0UFjiwwd2Of5RAB0xEWnJDiOPFHKW+FXKfxrC2ekiF8VT0Rgutu5TOfXkct?=
 =?us-ascii?Q?zEoCFAjGSls22Ga+EqBxh0tuvU81UtAPUqf/hvm58QPEP/l2TZua32r5O9rL?=
 =?us-ascii?Q?26TiNEplykNGVv64JRLCzmAO0BTk5lok0vW5LsZ0lSlwOQprT2+vWeCkePjH?=
 =?us-ascii?Q?yJzW0YnLsVriyEMzHwRNh1gWTeC0TBgCF5wLaEr3GawgbQo/YFzynIWQ8UTE?=
 =?us-ascii?Q?5BrxUovvy+7gVBVypQ1eeVoem4f+VLZMhYek4kyfvzC+k6/7x+2+kAwJEUSS?=
 =?us-ascii?Q?LfsF/uxMWBB9LwekaWzXNYynGIdhQkJE3z3ZaPqoVIzsgFVTVYnmd9oJ1frx?=
 =?us-ascii?Q?DreIxFtXsjL4Utcfcw6ML3ilzMsOar47tDM3CNKQYQyL+0n9lt8TXMGYa8lp?=
 =?us-ascii?Q?i0nci3/BzmJiUktN0sj7uc4h+EZ88yl9s5Pzvbfcw56FXyC+LOuapwqZ0Kem?=
 =?us-ascii?Q?XJSJ3GDIiuO1Wq/0rOFPocc38Ln5VslSvXFnqdYbSk7mQ7ykTxHl7PPKWy5z?=
 =?us-ascii?Q?Wg18sqCMclQboioJxg8jY/XF5CU9njXlAvPMdzWQpxdncGZ1hzeL8aZhgXFH?=
 =?us-ascii?Q?12vCNcobIjBQxdcJJLvvN5rpKsbBNhj2a7McEb5AAdJx4v6oHlvCxEH0/+aJ?=
 =?us-ascii?Q?7ihDQMJurUItI2/Scno=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:12.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2e2788-3d64-40ba-8f4e-08de33f4de27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

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
index e5def6f08f1c..2d4828831ce1 100644
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
 
@@ -1166,7 +1174,10 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
index 05f4cb5aaed0..1eaf4e57554e 100644
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
index b36d8bb812a3..6d0f2f0b332a 100644
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
@@ -236,16 +251,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
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


