Return-Path: <netdev+bounces-163052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0285EA29433
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB67A2536
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1031953A9;
	Wed,  5 Feb 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WDD3tZy8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51516198E77;
	Wed,  5 Feb 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768827; cv=fail; b=EcSwXOFRa7y0JlT7Qm1eBbfhMz3DdB73Y+x2tqnHlCyZaCv9h0XsogoYkdz4oCBFajagB7pDOb8DNYiw+3Q/mcIE2Ylc++ALqNR+ve7ikcs1zeiITng9/wBZl7dce/aquvYkhRpn3EIQCUv5vHKMyPCpRTVGqSVnzkX1yv5uNp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768827; c=relaxed/simple;
	bh=fm5xgeLCgUGYMMT7HSPrZp0cbFWth9UYL3TF96Fnrxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8R51pUj3DKSFu3t0gFnJR3q2HBoRuG3qML0y4JiyWMDwaZJ3vGmMxLmlAkIOMSJIILSZWpt9nGqWxFGNC2S/3E4Y1VQspz48d13WbAPqSVNqQWyvumtLX2ZPotUZ88/Kg0ZMFMk6uq5izWLmZ3FFIhY6p9Ip0J8KWyMGqKpjYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WDD3tZy8; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nabKFKfXVSfrgdwC2rVqNa99bfooXLiVxAtOrE33t5H5zqrRB1B/Rs37NxgEW6+RjlwftY8pvNk6B7t9oEVW41uwZA7lp/X/sn94YzDbSP3M1pQC5PnNx0Vg+zsONUWM1VOP1H7zvkd5cRRszM2+UTVMZXFHCbWnOoLNsZpreQMYgJ+Wk1XhLgqBHG/6WQMEBPQKpvzuNaOCnapplZVFOE+5WvB+SrYeErHOt9+P3fawcEoPr/pzWQazwCdGiOy/Opugbh2uTEG8gUqPuYWqmp4G8kmXU/M4kwDjoJ00OkrjVMEOu1MuHUNVesI3LkQOp4XB6FmeoxCLX9K/0UzzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVgOLb76Bo9ptB0U5Mxw02penz1N6V2haeRigeCBUdI=;
 b=Cz83CZ0rNG7sChOO90wgfbmplSqsYw0ttMLEyLcSKIgfjKprEgzwlQDmlRllQgZn7t0Y9HGHE5eNPRYzUcB0yCn5EL8I+SXQw0rYXZOGMBkvsHUpCZa2TI+PsdDEsKIo+s2XZ4CU8OzCvDZTZS8VS41FLzz7epeJDjiBOgFbFtGin6Cy9SS9TyzkjyiAT3cRusyrUSt/DsE48w5pR+GkuVb0swJUtlh2oSifw7rayC2LgDm1J5Be6pMbdNl6LX3VHEE38D7kr6wolmHZVVxbLxFHrfHQ5i7n/p+SkMZAq/zn3RhMMEL8YK1wKaVKKitJvLn+SgQJNzRT96MbIvR1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVgOLb76Bo9ptB0U5Mxw02penz1N6V2haeRigeCBUdI=;
 b=WDD3tZy8+KX3vns5fvoglTFjNcGLKcLTyGHVg3UcvfldjZG7TT64Wd0TL6+eCCFb+Ktzw5L2PuCTH01/9s3PqYsWkgLrzsb8oY+zWkN90qQfQ9INIdXhoAKrR6GmMBMsTfcNvXEnx8QIHP9g1tkKnBTgH7A9hxR8HvK+jyYEER8=
Received: from DM5PR07CA0104.namprd07.prod.outlook.com (2603:10b6:4:ae::33) by
 DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Wed, 5 Feb 2025 15:20:15 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::8d) by DM5PR07CA0104.outlook.office365.com
 (2603:10b6:4:ae::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 5 Feb 2025 15:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:14 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:13 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 12/26] cxl: prepare memdev creation for type2
Date: Wed, 5 Feb 2025 15:19:36 +0000
Message-ID: <20250205151950.25268-13-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: cde86b4a-9757-4f63-5404-08dd45f897e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQXOpSviz9069SuplOwaCr7I/Wi0M2saKHqWT2tn4KsTbkTuER737zIz1Viy?=
 =?us-ascii?Q?h0QZlYjPr2oPjLi5KlLDcgRoZmdA5rpzvNmrgddZ1BrO6+4FuiG/gRYchXyO?=
 =?us-ascii?Q?Kct4VcIgqaz9K7pnMYisII0hYQZZ3PpBxAzTYBUptwKe9aJXZsuEfEzdcyej?=
 =?us-ascii?Q?LYqfHrPDn+mooqZofsQaNyA1/Viv7ORW4dnyb2hrBtPYW0JDl5Ad8UXAU32V?=
 =?us-ascii?Q?2T+iJDu1YfBMfJyhuBkaXe+1ZKpt2d2Sxf+pJXoq0l646KAWSwlEmjVaFhvq?=
 =?us-ascii?Q?b/dCb5B6IWlflXjpXRwE0gDuQatZixA09eGnbhPfqKV6zqztE3Bg88JLFsKC?=
 =?us-ascii?Q?ab8OE2AwR0BMRaGrizlGHo+f+E7Nfih/T+S1hh6URFdQcTg89QabZtreU9eZ?=
 =?us-ascii?Q?9W4QCWstBZhX745JsRazT+AVmWlQd+2CbZBj7Oijxa2McPavWdmVXYXpn2Ks?=
 =?us-ascii?Q?S+6BzVpU4rnW0dmtQm2w9eXbnWpMARwVgx7KdL63l/S6ke+dHcVjLJQJgX1Z?=
 =?us-ascii?Q?HUn2rPUud92S8sDLW4x35MWcO5l9Np3N/hBwt3aNTYglCHEvvAKJvY3KON8y?=
 =?us-ascii?Q?sz8sLWmk5El7WOVWspUH0XISnVej5aRGkP137cWQhdsRT46U9rre/aoPnfR9?=
 =?us-ascii?Q?UGpoVbb7+X9fxuFNnA/bes00/KkI1wg2USvOTVIS5jKWzwjOW79jW56ky+Yo?=
 =?us-ascii?Q?HetUGtl0Wt9qu1IiYs2Y/VeE5agZ+9SSgTpKdyFuIqqRkM3xo7tCo/Bf28s1?=
 =?us-ascii?Q?SwQUEJsWGyCTcYaRBqzwZrArtyK5mngOrKuz0yR9D2F53UwS5pC+A3FrZ0yt?=
 =?us-ascii?Q?dG6uumm0ydxYr4ZDjKDLjBrMzQKTYGfkIcPXyXb1vsEUMRJQSqzZlu4APlyp?=
 =?us-ascii?Q?uGqa9WGyVdlXGO5Yl4kEgxALLIHOEFTXAjeamFRYYy0fMaLKp8SutJfN+wPU?=
 =?us-ascii?Q?KktveBChKfUKJyBxj9Xcobe8SoFHzbVNWWPCU9sjSONmCVDTT6q2RyZBnOB6?=
 =?us-ascii?Q?W8YGsYVEEzjMD38bX1oPHOiTZDQOpvWNHau9r/6DCEU/WfkIZX1PESTmbwHj?=
 =?us-ascii?Q?pfR/4SHf0BRV8B8y+IxhoPScV+xUqTQTjHX5A5M/tJaSFVbU3/LNRg5xAE4u?=
 =?us-ascii?Q?1QGkWUHDbXCbLrr8UgdBcLqH1w/0kvZnILxhyp6GI9ueEnztzAubQN5zijQa?=
 =?us-ascii?Q?TDht+2gYoFNkRpqXvKJLzLYCRmC3IHtAAN+6rej14wuSndP3CrtqUxk9yBIS?=
 =?us-ascii?Q?7huciejs27Khc/thqmVeAfrUhDm+fBuq/wbjC9NxXqOXhsBcZwpUfUzJ0JY6?=
 =?us-ascii?Q?IXHxC7d9j1uPdYlFciurSYlXBksBWCVr54LOsNipJOPb5Rz/sJ3PcVHIkar+?=
 =?us-ascii?Q?jiAMaQ1kzOKv8h52V0VUcjdPHvys08nQtxaB0dx9XDezO6CjZh6WaEIU/6io?=
 =?us-ascii?Q?1lnuH8efoEgbIF1+nyq4SuBhcq06KKv9k37mssSeyfESbcXMlAQTgZt+VZW7?=
 =?us-ascii?Q?z/vdCN+ujNPOsWE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:15.7979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde86b4a-9757-4f63-5404-08dd45f897e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accesible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 17 ++++++++++++++---
 drivers/cxl/cxlmem.h      |  5 ++---
 drivers/cxl/pci.c         |  2 +-
 include/cxl/cxl.h         |  2 ++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 7113a51b3a93..9a414980b550 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -562,9 +562,16 @@ static const struct device_type cxl_memdev_type = {
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
 
@@ -691,7 +698,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
 
@@ -1069,8 +1079,9 @@ static const struct file_operations cxl_memdev_fops = {
 };
 
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+				       struct cxl_memdev_state *cxlmds)
 {
+	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
 	struct cdev *cdev;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a5994061780c..760f7e16a6a4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -88,8 +88,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
@@ -514,7 +512,8 @@ struct cxl_memdev_state {
 static inline struct cxl_memdev_state *
 to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 {
-	if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
+	if (cxlds->type != CXL_DEVTYPE_CLASSMEM &&
+	    cxlds->type != CXL_DEVTYPE_DEVMEM)
 		return NULL;
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bcfa3d86c37b..485e60f60288 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -959,7 +959,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, mds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index ec56a82966c0..592aa5e75bc2 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -78,4 +78,6 @@ void cxl_set_media_ready(struct cxl_memdev_state *mds);
 void cxl_dev_state_setup(struct cxl_memdev_state *mds, struct mds_info *info);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
 int cxl_dpa_setup(struct cxl_memdev_state *cxlmds, const struct cxl_dpa_info *info);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_memdev_state *cxlmds);
 #endif
-- 
2.17.1


