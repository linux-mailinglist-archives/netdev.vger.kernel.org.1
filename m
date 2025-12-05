Return-Path: <netdev+bounces-243785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F8CA7782
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A951E307DF32
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174F632F74F;
	Fri,  5 Dec 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="09VXiejS"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27432826E;
	Fri,  5 Dec 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935599; cv=fail; b=XBUnLmPX8dOWGAmrbBDS5wOxZzENMRl27pBhLD4zR4GGcrVTodwOVBewRRvvSxpTb/Aipl9CX0OQ0oSNpRjRSOskRQULu2cI4Leg2VS0SYdmUTTr9DkPuckSt9HeJKamnq9yxrweeDFdjlod13Qo+Sbbna/+vHAuslq17L1VZ8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935599; c=relaxed/simple;
	bh=/gGOVcKc2pzZplCDxQIpya/O09bAHlyiQ60TPyl0+c8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvWBRJWNGwf7xGi5Jk/inKbIvIgvRhijC+p79GXQJjxH8AhADwv2RNkEWx0lwOiadPxGGQULPurdgOHjBbfUUczT29lHigzdDv8391eEU3cN9kZJcUZhOOy7nuXAY65qIofx/D/qDusKfduOGRO2yBom8njeHeJdrJD/QPFDgUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=09VXiejS; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXKLPJjnfPvCW/+JC+yToJzcUPZj3WEXZtPud6t9zrPuSYpbpRkto5+yEZ4j6dpiMHKzTCE75HcxOJsDxf4rUIxBlVfgn6vkoG+cgSqB4vVksnZPO81E8Th/LfskifK2Pp143z28YztacV8jd+RTdFHad8ltFmq1jKz1IFwk0+c7J8Qqtc0rL0FM+/biSI/M84/y4oCpkAAKvE5Kd3j/u4of0wGIMe3drpIYLBvWfzVKeBiPkkPtHxMs67AbAB8XyBROWoN734bUKQX1JaVENGP5lSSTKIpBPEXcXJ8J3lu/Kv71kzh4I1XfqPSepbocsebFtnK3Mi5AEdk1qySmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOF2ruIeFsxyTsFkX7SWw//FDBZ8L3v6UadmS/RrdMM=;
 b=nnlR8gEO0gYVWBeyzfqWHhsZgcAq+WprffnqfehU267Vvkkrgk2Hw4iAzE60YymDdXWQTnd5OsF/3wre98Gg0qxnfM8d8L2mxCgCKPPE6gYqXPizYeR/E8FEiSQZw0YBOLnqocYEn43Xcyk/Gqu6laC++Y9n37re7v8D4kKM1hgM2tFR7spc6rw3GtPfVrya1Gn0OlXmFHtb32gcLTMDr1MHgk4wDp/4ul57Ih4v9VywSVqw92GbC2WnvuVBtfl0MehEys32Xl3SHRe1ipUPrZmW6/4P+8UQkCa89D4/j5RrxWruEh5Hd032c/niWQacfcOX7+oyn1t+cNw5wudHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOF2ruIeFsxyTsFkX7SWw//FDBZ8L3v6UadmS/RrdMM=;
 b=09VXiejSZX6J7r+aPmeLVDVVT3EVBn7eptz2+X2sDfZFW+bF4GsPrqxedmN4IdDuKISf8W+6EVDUBBu+rswMw6JXf5vDIWQwf5Ns8qZJeT2lQQu57Hy9CijJzRuhMwwYxmZLNNk1tSY0PNkudf9EmYUFM7S6BxcJYtku3uJm6LA=
Received: from BY3PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:39a::32)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:04 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::78) by BY3PR03CA0027.outlook.office365.com
 (2603:10b6:a03:39a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 11:53:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:02 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:01 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v22 04/25] cxl: Add type2 device basic support
Date: Fri, 5 Dec 2025 11:52:27 +0000
Message-ID: <20251205115248.772945-5-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 841e3797-06c7-4254-3b7a-08de33f4d95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wBoDmBRHM9Wk1vozNjsiDqzwqG3simH1QuIGgz0daObO/Yt9vtba3Nyk5FUV?=
 =?us-ascii?Q?8MfyhZca2OCoYu1jv8H1toRdl6tus8xLrRXbUnnEAbl+eqxFEN5Nxh+ZT3tY?=
 =?us-ascii?Q?gcnzeXTXOEqL2T15pCElJeqXm1QT+tUMhgUgLMAB8dGZpXPGmsfPtMfMQW42?=
 =?us-ascii?Q?D22mPs1HSURm/eovN/kJTeRqVThff08AEp8CP4O61hvfzBqR8FcKaOSzubPA?=
 =?us-ascii?Q?k+qzuetF4ye/3/IGes18HngbInY5JhSR3djyIsHmHlRlvI3lf3HPU7hjEy8I?=
 =?us-ascii?Q?P5FnUD5yOzs4XaI9+GLVGZFT4dtwtEaM/Wk8ZzhhXb9nG36I9NMEKmjHcQdH?=
 =?us-ascii?Q?bhm8hCPcPjO7ExB4IYdZwY9/IElFyMWxr6/1kmmMJNS6TxMR1y5bQAO5oawP?=
 =?us-ascii?Q?qbLhK4v900uQLj1rd8cUekattP5RN7sdrSiymeUm839xYVx2immRUhgJSQ36?=
 =?us-ascii?Q?FYp6Zdc+6n8T9yPSTNS3wwrQk9SzWhvW3i8qbKLYELJiVBtwxRNT5APeqjfK?=
 =?us-ascii?Q?e+40Cj7Hyc5X7jUv2uhkX55QYE/DL4cS1wA+NgdxAH3t9C19jcfi7GZ3qnqA?=
 =?us-ascii?Q?RSLGs+0CiRFkVLHgX7GI/nSJLNcAuPk+xsZ3NZ3n8wrJySSLKTAHb3RC2Rzq?=
 =?us-ascii?Q?X0g0VpAieuhgN7q01dYF/b+AgfQlCMmk67DT0+ACzZ8YeBisJbePUrnhc43L?=
 =?us-ascii?Q?P6cZ27h5PqvBolJI+pi1k+eHzqcsk5Gs3z8CwMgHkiMI3f9ralU1UtLRkqdW?=
 =?us-ascii?Q?Oo1ucSmbyOhgsgxyBBkSEggGo2PF1ZVpFZMk5bgOZmpBjvXp38a19LMP1M/U?=
 =?us-ascii?Q?VUVGzaoEPlNeRwJYd0y+/Vqw3LeBy3KkmHCOFqwnraVhxN4NVt48CpyuShId?=
 =?us-ascii?Q?E7fAhTs1KOiBeD6jmwVsrZJGIyWofZdePtMIXmsuvWqghYq9rCPd0gHbmtMO?=
 =?us-ascii?Q?R4SVKiswJF6RhJHEJjUkKVT3fQ+i56qnkZwIcCmgc8Aen48cj9cSw4IwjVVb?=
 =?us-ascii?Q?VCMy0oHJrXVVXDsnBqEU0Mdy/ZtOlfQi+T25ovSCEfmQrKnQIzBW6MuMOgf1?=
 =?us-ascii?Q?gYHF8D3q9i7E7dcv/ViaT7oq4WYDtkLgWChBLczGVisKoWZ8IVDPgRHyBcHY?=
 =?us-ascii?Q?qFyQplGER70HTjPrh8FwdHrIgy73A+XKR+cZz/Le7w5+XDoyhiiR3OQImC2P?=
 =?us-ascii?Q?dLZmM/8H/WfSngZfZUZEZ6DnbhBGKHkZVqGSBbDAkz49qFMCcbf/DXNx4ika?=
 =?us-ascii?Q?2GdAkr4xRSjjAt6fLrhi+bvDCWhf/XeiwLkIzq/c9gYo4bnexaxyGJRTIPNY?=
 =?us-ascii?Q?Xoi6tM35++7g264pTXsJz53iWI4q/Fe8HDM1/LfNGArHPuLtij1S0DLujvFu?=
 =?us-ascii?Q?DqYrAxis+kWBWWKlSvI1C/x0UM09558GnwmqxhVa3nxKD/2YitrcSOruoPpz?=
 =?us-ascii?Q?9KeaBPaUVT7vZtMk7HqwyWtHFHG33q+kK9LahC59h8hZeNniS+SyrpRsSqYw?=
 =?us-ascii?Q?EoRK3qMF8AOeafryRNvnNfjxlthLrIu7uTbcZcs49M6NpzlPzEKpgCBfERIg?=
 =?us-ascii?Q?gE79l8OPWd37OFj/4pc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:04.4182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841e3797-06c7-4254-3b7a-08de33f4d95c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

From: Alejandro Lucero <alucerop@amd.com>

Differentiate CXL memory expanders (type 3) from CXL device accelerators
(type 2) with a new function for initializing cxl_dev_state and a macro
for helping accel drivers to embed cxl_dev_state inside a private
struct.

Move structs to include/cxl as the size of the accel driver private
struct embedding cxl_dev_state needs to know the size of this struct.

Use same new initialization with the type3 pci driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/mbox.c      |  12 +-
 drivers/cxl/core/memdev.c    |  32 +++++
 drivers/cxl/core/pci_drv.c   |  14 +--
 drivers/cxl/cxl.h            |  97 +--------------
 drivers/cxl/cxlmem.h         |  86 +------------
 include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |   3 +-
 7 files changed, 274 insertions(+), 196 deletions(-)
 create mode 100644 include/cxl/cxl.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fa6dd0c94656..bee84d0101d1 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1514,23 +1514,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
 
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec)
 {
 	struct cxl_memdev_state *mds;
 	int rc;
 
-	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
+	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
+					dvsec, struct cxl_memdev_state, cxlds,
+					true);
 	if (!mds) {
 		dev_err(dev, "No memory available\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
 	mutex_init(&mds->event.log_lock);
-	mds->cxlds.dev = dev;
-	mds->cxlds.reg_map.host = dev;
-	mds->cxlds.cxl_mbox.host = dev;
-	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
-	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
 	if (rc == -EOPNOTSUPP)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index fd64f558c8fd..1dd6f0294030 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -649,6 +649,38 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
+static void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
+			       enum cxl_devtype type, u64 serial, u16 dvsec,
+			       bool has_mbox)
+{
+	*cxlds = (struct cxl_dev_state) {
+		.dev = dev,
+		.type = type,
+		.serial = serial,
+		.cxl_dvsec = dvsec,
+		.reg_map.host = dev,
+		.reg_map.resource = CXL_RESOURCE_NONE,
+	};
+
+	if (has_mbox)
+		cxlds->cxl_mbox.host = dev;
+}
+
+struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
+						 enum cxl_devtype type,
+						 u64 serial, u16 dvsec,
+						 size_t size, bool has_mbox)
+{
+	struct cxl_dev_state *cxlds = devm_kzalloc(dev, size, GFP_KERNEL);
+
+	if (!cxlds)
+		return NULL;
+
+	cxl_dev_state_init(cxlds, dev, type, serial, dvsec, has_mbox);
+	return cxlds;
+}
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_dev_state_create, "CXL");
+
 struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
 						struct cxl_memdev *cxlmd)
 {
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
index f43590062efd..b4b8350ba44d 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -912,6 +912,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int rc, pmu_count;
 	unsigned int i;
 	bool irq_avail;
+	u16 dvsec;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -925,19 +926,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 	pci_set_master(pdev);
 
-	mds = cxl_memdev_state_create(&pdev->dev);
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		pci_warn(pdev, "Device DVSEC not present, skip CXL.mem init\n");
+
+	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
 	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->rcd = is_cxl_restricted(pdev);
-	cxlds->serial = pci_get_dsn(pdev);
-	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
-	if (!cxlds->cxl_dvsec)
-		dev_warn(&pdev->dev,
-			 "Device DVSEC not present, skip CXL.mem init\n");
 
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b7654d40dc9e..1517250b0ec2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <linux/io.h>
 #include <linux/range.h>
+#include <cxl/cxl.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -201,97 +202,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-/*
- * Using struct_group() allows for per register-block-type helper routines,
- * without requiring block-type agnostic code to include the prefix.
- */
-struct cxl_regs {
-	/*
-	 * Common set of CXL Component register block base pointers
-	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
-	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
-	 */
-	struct_group_tagged(cxl_component_regs, component,
-		void __iomem *hdm_decoder;
-		void __iomem *ras;
-	);
-	/*
-	 * Common set of CXL Device register block base pointers
-	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
-	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
-	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
-	 */
-	struct_group_tagged(cxl_device_regs, device_regs,
-		void __iomem *status, *mbox, *memdev;
-	);
-
-	struct_group_tagged(cxl_pmu_regs, pmu_regs,
-		void __iomem *pmu;
-	);
-
-	/*
-	 * RCH downstream port specific RAS register
-	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
-	 */
-	struct_group_tagged(cxl_rch_regs, rch_regs,
-		void __iomem *dport_aer;
-	);
-
-	/*
-	 * RCD upstream port specific PCIe cap register
-	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
-	 */
-	struct_group_tagged(cxl_rcd_regs, rcd_regs,
-		void __iomem *rcd_pcie_cap;
-	);
-};
-
-struct cxl_reg_map {
-	bool valid;
-	int id;
-	unsigned long offset;
-	unsigned long size;
-};
-
-struct cxl_component_reg_map {
-	struct cxl_reg_map hdm_decoder;
-	struct cxl_reg_map ras;
-};
-
-struct cxl_device_reg_map {
-	struct cxl_reg_map status;
-	struct cxl_reg_map mbox;
-	struct cxl_reg_map memdev;
-};
-
-struct cxl_pmu_reg_map {
-	struct cxl_reg_map pmu;
-};
-
-/**
- * struct cxl_register_map - DVSEC harvested register block mapping parameters
- * @host: device for devm operations and logging
- * @base: virtual base of the register-block-BAR + @block_offset
- * @resource: physical resource base of the register block
- * @max_size: maximum mapping size to perform register search
- * @reg_type: see enum cxl_regloc_type
- * @component_map: cxl_reg_map for component registers
- * @device_map: cxl_reg_maps for device registers
- * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
- */
-struct cxl_register_map {
-	struct device *host;
-	void __iomem *base;
-	resource_size_t resource;
-	resource_size_t max_size;
-	u8 reg_type;
-	union {
-		struct cxl_component_reg_map component_map;
-		struct cxl_device_reg_map device_map;
-		struct cxl_pmu_reg_map pmu_map;
-	};
-};
-
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
@@ -497,11 +407,6 @@ struct cxl_region_params {
 	resource_size_t cache_size;
 };
 
-enum cxl_partition_mode {
-	CXL_PARTMODE_RAM,
-	CXL_PARTMODE_PMEM,
-};
-
 /*
  * Indicate whether this region has been assembled by autodetection or
  * userspace assembly. Prevent endpoint decoders outside of automatic
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 63b1957fddda..05f4cb5aaed0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -113,8 +113,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
-#define CXL_NR_PARTITIONS_MAX 2
-
 struct cxl_dpa_info {
 	u64 size;
 	struct cxl_dpa_part_info {
@@ -373,87 +371,6 @@ struct cxl_security_state {
 	struct kernfs_node *sanitize_node;
 };
 
-/*
- * enum cxl_devtype - delineate type-2 from a generic type-3 device
- * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
- *			 HDM-DB, no requirement that this device implements a
- *			 mailbox, or other memory-device-standard manageability
- *			 flows.
- * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
- *			   HDM-H and class-mandatory memory device registers
- */
-enum cxl_devtype {
-	CXL_DEVTYPE_DEVMEM,
-	CXL_DEVTYPE_CLASSMEM,
-};
-
-/**
- * struct cxl_dpa_perf - DPA performance property entry
- * @dpa_range: range for DPA address
- * @coord: QoS performance data (i.e. latency, bandwidth)
- * @cdat_coord: raw QoS performance data from CDAT
- * @qos_class: QoS Class cookies
- */
-struct cxl_dpa_perf {
-	struct range dpa_range;
-	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
-	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
-	int qos_class;
-};
-
-/**
- * struct cxl_dpa_partition - DPA partition descriptor
- * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
- * @perf: performance attributes of the partition from CDAT
- * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
- */
-struct cxl_dpa_partition {
-	struct resource res;
-	struct cxl_dpa_perf perf;
-	enum cxl_partition_mode mode;
-};
-
-/**
- * struct cxl_dev_state - The driver device state
- *
- * cxl_dev_state represents the CXL driver/device state.  It provides an
- * interface to mailbox commands as well as some cached data about the device.
- * Currently only memory devices are represented.
- *
- * @dev: The device associated with this CXL state
- * @cxlmd: The device representing the CXL.mem capabilities of @dev
- * @reg_map: component and ras register mapping parameters
- * @regs: Parsed register blocks
- * @cxl_dvsec: Offset to the PCIe device DVSEC
- * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
- * @media_ready: Indicate whether the device media is usable
- * @dpa_res: Overall DPA resource tree for the device
- * @part: DPA partition array
- * @nr_partitions: Number of DPA partitions
- * @serial: PCIe Device Serial Number
- * @type: Generic Memory Class device or Vendor Specific Memory device
- * @cxl_mbox: CXL mailbox context
- * @cxlfs: CXL features context
- */
-struct cxl_dev_state {
-	struct device *dev;
-	struct cxl_memdev *cxlmd;
-	struct cxl_register_map reg_map;
-	struct cxl_regs regs;
-	int cxl_dvsec;
-	bool rcd;
-	bool media_ready;
-	struct resource dpa_res;
-	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-	unsigned int nr_partitions;
-	u64 serial;
-	enum cxl_devtype type;
-	struct cxl_mailbox cxl_mbox;
-#ifdef CONFIG_CXL_FEATURES
-	struct cxl_features_state *cxlfs;
-#endif
-};
-
 static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
 {
 	/*
@@ -858,7 +775,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
-struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
+struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
+						 u16 dvsec);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
new file mode 100644
index 000000000000..13d448686189
--- /dev/null
+++ b/include/cxl/cxl.h
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 Intel Corporation. */
+/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
+
+#ifndef __CXL_CXL_H__
+#define __CXL_CXL_H__
+
+#include <linux/node.h>
+#include <linux/ioport.h>
+#include <cxl/mailbox.h>
+
+/**
+ * enum cxl_devtype - delineate type-2 from a generic type-3 device
+ * @CXL_DEVTYPE_DEVMEM: Vendor specific CXL Type-2 device implementing HDM-D or
+ *			 HDM-DB, no requirement that this device implements a
+ *			 mailbox, or other memory-device-standard manageability
+ *			 flows.
+ * @CXL_DEVTYPE_CLASSMEM: Common class definition of a CXL Type-3 device with
+ *			   HDM-H and class-mandatory memory device registers
+ */
+enum cxl_devtype {
+	CXL_DEVTYPE_DEVMEM,
+	CXL_DEVTYPE_CLASSMEM,
+};
+
+struct device;
+
+/*
+ * Using struct_group() allows for per register-block-type helper routines,
+ * without requiring block-type agnostic code to include the prefix.
+ */
+struct cxl_regs {
+	/*
+	 * Common set of CXL Component register block base pointers
+	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
+	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 */
+	struct_group_tagged(cxl_component_regs, component,
+		void __iomem *hdm_decoder;
+		void __iomem *ras;
+	);
+	/*
+	 * Common set of CXL Device register block base pointers
+	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
+	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
+	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
+	 */
+	struct_group_tagged(cxl_device_regs, device_regs,
+		void __iomem *status, *mbox, *memdev;
+	);
+
+	struct_group_tagged(cxl_pmu_regs, pmu_regs,
+		void __iomem *pmu;
+	);
+
+	/*
+	 * RCH downstream port specific RAS register
+	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *dport_aer;
+	);
+
+	/*
+	 * RCD upstream port specific PCIe cap register
+	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rcd_regs, rcd_regs,
+		void __iomem *rcd_pcie_cap;
+	);
+};
+
+struct cxl_reg_map {
+	bool valid;
+	int id;
+	unsigned long offset;
+	unsigned long size;
+};
+
+struct cxl_component_reg_map {
+	struct cxl_reg_map hdm_decoder;
+	struct cxl_reg_map ras;
+};
+
+struct cxl_device_reg_map {
+	struct cxl_reg_map status;
+	struct cxl_reg_map mbox;
+	struct cxl_reg_map memdev;
+};
+
+struct cxl_pmu_reg_map {
+	struct cxl_reg_map pmu;
+};
+
+/**
+ * struct cxl_register_map - DVSEC harvested register block mapping parameters
+ * @host: device for devm operations and logging
+ * @base: virtual base of the register-block-BAR + @block_offset
+ * @resource: physical resource base of the register block
+ * @max_size: maximum mapping size to perform register search
+ * @reg_type: see enum cxl_regloc_type
+ * @component_map: cxl_reg_map for component registers
+ * @device_map: cxl_reg_maps for device registers
+ * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
+ */
+struct cxl_register_map {
+	struct device *host;
+	void __iomem *base;
+	resource_size_t resource;
+	resource_size_t max_size;
+	u8 reg_type;
+	union {
+		struct cxl_component_reg_map component_map;
+		struct cxl_device_reg_map device_map;
+		struct cxl_pmu_reg_map pmu_map;
+	};
+};
+
+/**
+ * struct cxl_dpa_perf - DPA performance property entry
+ * @dpa_range: range for DPA address
+ * @coord: QoS performance data (i.e. latency, bandwidth)
+ * @cdat_coord: raw QoS performance data from CDAT
+ * @qos_class: QoS Class cookies
+ */
+struct cxl_dpa_perf {
+	struct range dpa_range;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
+	int qos_class;
+};
+
+enum cxl_partition_mode {
+	CXL_PARTMODE_RAM,
+	CXL_PARTMODE_PMEM,
+};
+
+/**
+ * struct cxl_dpa_partition - DPA partition descriptor
+ * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
+ * @perf: performance attributes of the partition from CDAT
+ * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
+ */
+struct cxl_dpa_partition {
+	struct resource res;
+	struct cxl_dpa_perf perf;
+	enum cxl_partition_mode mode;
+};
+
+#define CXL_NR_PARTITIONS_MAX 2
+
+/**
+ * struct cxl_dev_state - The driver device state
+ *
+ * cxl_dev_state represents the CXL driver/device state.  It provides an
+ * interface to mailbox commands as well as some cached data about the device.
+ * Currently only memory devices are represented.
+ *
+ * @dev: The device associated with this CXL state
+ * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @reg_map: component and ras register mapping parameters
+ * @regs: Parsed register blocks
+ * @cxl_dvsec: Offset to the PCIe device DVSEC
+ * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @media_ready: Indicate whether the device media is usable
+ * @dpa_res: Overall DPA resource tree for the device
+ * @part: DPA partition array
+ * @nr_partitions: Number of DPA partitions
+ * @serial: PCIe Device Serial Number
+ * @type: Generic Memory Class device or Vendor Specific Memory device
+ * @cxl_mbox: CXL mailbox context
+ * @cxlfs: CXL features context
+ */
+struct cxl_dev_state {
+	/* public for Type2 drivers */
+	struct device *dev;
+	struct cxl_memdev *cxlmd;
+
+	/* private for Type2 drivers */
+	struct cxl_register_map reg_map;
+	struct cxl_regs regs;
+	int cxl_dvsec;
+	bool rcd;
+	bool media_ready;
+	struct resource dpa_res;
+	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
+	unsigned int nr_partitions;
+	u64 serial;
+	enum cxl_devtype type;
+	struct cxl_mailbox cxl_mbox;
+#ifdef CONFIG_CXL_FEATURES
+	struct cxl_features_state *cxlfs;
+#endif
+};
+
+struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
+						 enum cxl_devtype type,
+						 u64 serial, u16 dvsec,
+						 size_t size, bool has_mbox);
+
+/**
+ * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
+ * driver specific struct.
+ *
+ * @parent: device behind the request
+ * @type: CXL device type
+ * @serial: device identification
+ * @dvsec: dvsec capability offset
+ * @drv_struct: driver struct embedding a cxl_dev_state struct
+ * @member: drv_struct member as cxl_dev_state
+ * @mbox: true if mailbox supported
+ *
+ * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
+ * struct initialized.
+ *
+ * Introduced for Type2 driver support.
+ */
+#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
+	({										\
+		static_assert(__same_type(struct cxl_dev_state,				\
+			      ((drv_struct *)NULL)->member));				\
+		static_assert(offsetof(drv_struct, member) == 0);			\
+		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
+						      sizeof(drv_struct), mbox);	\
+	})
+#endif /* __CXL_CXL_H__ */
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 33d06ec5a4b9..6fbe0af3e8f8 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1717,7 +1717,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mds = cxl_memdev_state_create(dev);
+	mds = cxl_memdev_state_create(dev, pdev->id + 1, 0);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 
@@ -1733,7 +1733,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
 
-	cxlds->serial = pdev->id + 1;
 	if (is_rcd(pdev))
 		cxlds->rcd = true;
 
-- 
2.34.1


