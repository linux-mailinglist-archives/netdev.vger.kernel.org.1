Return-Path: <netdev+bounces-240135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53301C70C92
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB3CA4E126E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9F366DC3;
	Wed, 19 Nov 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="erXGx4Z9"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783034D3BE;
	Wed, 19 Nov 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580186; cv=fail; b=UKjLKrOh+ORwtEQWf9CyJGMRMfElwtjli0xQfDfNEA2HJrUZY4AJCClS7CEqAfV3Ahy0Ouxu+SCAEbLLkeLvBa8AwYId6rtoZTKpde43FRiRnaW9HWu4UYTT2d2xcH5eeQFP8PVdXP7sCvdo4D6gSvt7pTBqkuyl6Z2GGcaQF6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580186; c=relaxed/simple;
	bh=4mlMbcV2Tz26Giv9IqvyJfF3W+URym90OuIWBJ3HXAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/QdEYJ8Jn0RLK2Vm7ic9147SOS75HOQ83PwOGWTMFR/GHjtle9GgYs4USO2y+c6Akk3jUxVOyDVrDb69yXIlkw9x3MXdiIj+7/Kz6IAXK+xdeL36KlAVw4KRcVgypCcC8Tbe+y4OJ88ttpwDEO94FFDHpVbdRDlH3V0U2SAmtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=erXGx4Z9; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkDo24qrZj/8pzCz8J3ucGfaNgntRlgr2MNIzllHrQFr7No9b4p+29F37HIxNrRmFN/eN9qkXPEC3Hi/b7SFzeJw0VDHoWWme4xr6KdBhMy6yXfEKIbVnLcLC0Iiws7lD9hQ9NGIHnSZ07fOw7MjjSy8qy8ZVEVgCd600kR9E+tK+3Tr8kNzd5pRs8WpOrxiGgvPLTmYwr0f3J28Lwl+NA6KAJkE8iWpESTIG1mwrSJ2ErPGB6UM3LFC3tuluM8gKQNJlL0TvvDZ+P6Q1iRKmIVuwKh84yTtDtSyIc+qerj4Dr9uKlH2MT4a2VlfV8jJVK+SZtlNwzsFWhPbY+I2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuFdV6tB+uaM5yyKltMo8IpMiBSrqcFYDu1VxlNYqV4=;
 b=uZ88mkwSQgdOlzE+hPWub5zpmfsN2wfHgofWLD1DY7zcVRozwzOL/60bzDr7s+NtYkosSju9dZMZ/GLcjfo0LpgtNn57EHF5nHusFreiWvqHhzJq8Fs56m5XVb1Sit62GWKSpK8rHOztcoKjh109Sulm9ScHDYbj2X8nkZVxpMrDiwj1SVBuoim9oR/EEnOpaKav4/+264UaOszq00sj3n5ITHXhtaMtMjfUvMO8Fo5k9jiCWEswbo+yy9YjHpLinbRcbHtklAz7NrTjRAZI2tkCHcakZoz9hrZq2XqcXKTBoBGWILXKkVIh6BNJe2KiBq/XsHqM9j5rUMvKrIdCHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuFdV6tB+uaM5yyKltMo8IpMiBSrqcFYDu1VxlNYqV4=;
 b=erXGx4Z98sEn2y3m8VB/wZCZkmKmtZ6KjUcD7DmsgHdvZhSKIOylp5bF09PoC9EwllZuqs8d0kylf/7hGfkpCYTYsdV9+nPefAg1N43tkDeY2+Z6mdXLMm5VxsP9riAv4/HgWWoNppAiAvhgPqyzkuQFxKRWZUDfoxJ1/VGbI/Y=
Received: from SJ0PR13CA0203.namprd13.prod.outlook.com (2603:10b6:a03:2c3::28)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:22:53 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::9e) by SJ0PR13CA0203.outlook.office365.com
 (2603:10b6:a03:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:22:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:52 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:50 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v21 05/23] cxl: Add type2 device basic support
Date: Wed, 19 Nov 2025 19:22:18 +0000
Message-ID: <20251119192236.2527305-6-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f4fcc4-b2dd-431c-3242-08de27a1092a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BRdiOp84s2IVnQrofQatzsN0VSX5n9POcLfCxoiwonnxHUMeYteNTx6qQvJl?=
 =?us-ascii?Q?hvAtnRG6dyZKbLC53paoP82aqvOuLhOXmGWzLkc5g7FfhYnU7EUCpEmXjpjA?=
 =?us-ascii?Q?1aDtx4S9D8VYHczlmpaFO8KuhwMp5BheBQYTg6DdprGuimNyD8WJa40y+ZqU?=
 =?us-ascii?Q?Kot8vLCX1mI304aLTbqE9DjN8A6Hk/sWu3DP7GTVPpv5f+dYt4J+O9rjFjIr?=
 =?us-ascii?Q?1MsLlXpP/RD5BIxIiagZ95iP7CFPqqrvxZcOkDY4t8Lg09aZxGM2ce082j2Z?=
 =?us-ascii?Q?nC5m7mM2raKz3c241ysNwBTRNOvuaYdtqyn3JG887An3AZaeX8b9Wzb91af7?=
 =?us-ascii?Q?IzVi33vbTgxetdWigYs34YeDXmp3p/d9Pbzb5o/u1LoDKycZXbF7K8i+Nq/+?=
 =?us-ascii?Q?fB0RF+NbS5NDA7TYhEP9aCKObqpzCgqqkqrDOW58x7xoL5e3btL3bZgbA0lK?=
 =?us-ascii?Q?K/iN3wIA44ydMJvdPojj7lPRzZKxXgaUK1CKvu6AFWP1loCXzVsnvKIuPRWE?=
 =?us-ascii?Q?3yCUQfC4dU0k1M88MXnuX9Hm4mAG3VbEhxnI/fRwChziDEDaSydTV/WreFMo?=
 =?us-ascii?Q?5UUi8UZaAqvc53KZAMSZPq8+UM0IHqG8tUMkj2DuwVP6qa5emQmzxozNIcAR?=
 =?us-ascii?Q?id+/1Ps1SL4hkuMOywRQYjWCWasnKJuygcSS1CdtpXzeyqCKDcPxD+pO12RP?=
 =?us-ascii?Q?0i15rNPRP5HxuQxGyXogQyKwrqlkNOn9OzZGj9LucLb3mpPppCOcuO4eKHmJ?=
 =?us-ascii?Q?xVQ3rwpXiifR99bCKwQ5cwl9fzwGGihTXWdxO0/inCVWsQIopftvLCzBvfml?=
 =?us-ascii?Q?VgUmlkSWw5Qwdq6ndAUfXBAa62pkjFYQDfprgkCOthtvGSCPyWqS+Wo1EJ7e?=
 =?us-ascii?Q?QedBFc93B5oiDPs3EsdGnSErErIpko3tGbTM07ac5342WSHmqfWLvMPwxXgm?=
 =?us-ascii?Q?4rgVy1nHkt9jaan/K6CZDlNqyLovOle+HFjnKxwx3RiOeXfUGFZcqNCm7mFV?=
 =?us-ascii?Q?veSnaZ4jO5sXv+i0WO4Xe8IrDIt6zadNCa+eaG+X5zBFve8GsxVX0aYt1Wcs?=
 =?us-ascii?Q?Wo0ANq7zPI2Ho6TPQ44UtjQn2UCnuic3EVpwlUbUoxP4WCdkU2K7/RB+k/ma?=
 =?us-ascii?Q?bPvc5BAWzPnih4/c7NeGF4trDyJYxGY8rhHxQ8RehMSDX3HSRGfGsQyMa+9U?=
 =?us-ascii?Q?UiYiK3X0NHOr8wK7uOIJNSu1KTwNVdfPMbqDBR6a+CvY+259A3A3EckwAz8s?=
 =?us-ascii?Q?1py0IaR7d98yAO6dnjEDpU4eP4Hvch/HdlI5jSxX87yo9SMxr3jJ8wTrxnSl?=
 =?us-ascii?Q?YThpzGTG9DLIHCuwWCPsb+wZfpmD0/pXy6KAJPkRZ3tY+5/Te769tzZuI7A5?=
 =?us-ascii?Q?cf5UMylB+fC/ILF/szEvCcjG0nQ81WsWR12f/4znsMGUrx65E4FkhCNKpHd+?=
 =?us-ascii?Q?KyVjNbyIF3sZm6hNp++s6EIajN4Q9iuKbs1NwH1iy/IW1+moYfR/uz1DTAMj?=
 =?us-ascii?Q?znvCaYrTUw5tFABqQuIR8+o9UdU4Kgu5M3WzAo+yoWPJsFC/7LeKEHIRcmUB?=
 =?us-ascii?Q?Yjkti3HpSPMM4JySfs4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:22:52.8834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f4fcc4-b2dd-431c-3242-08de27a1092a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527

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
 drivers/cxl/core/pci_drv.c   |  15 +--
 drivers/cxl/cxl.h            |  97 +--------------
 drivers/cxl/cxlmem.h         |  87 +-------------
 include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |   3 +-
 7 files changed, 276 insertions(+), 196 deletions(-)
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
index 5e8af91c921e..dd10f17eb6ad 100644
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
 int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
index f43590062efd..18ed819d847d 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -12,6 +12,7 @@
 #include <linux/aer.h>
 #include <linux/io.h>
 #include <cxl/mailbox.h>
+#include <cxl/cxl.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
@@ -912,6 +913,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int rc, pmu_count;
 	unsigned int i;
 	bool irq_avail;
+	u16 dvsec;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -925,19 +927,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
index e55f52a5598d..ceeda8796cba 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -9,6 +9,7 @@
 #include <linux/node.h>
 #include <cxl/event.h>
 #include <cxl/mailbox.h>
+#include <cxl/cxl.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -112,8 +113,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
-#define CXL_NR_PARTITIONS_MAX 2
-
 struct cxl_dpa_info {
 	u64 size;
 	struct cxl_dpa_part_info {
@@ -372,87 +371,6 @@ struct cxl_security_state {
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
@@ -857,7 +775,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
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


