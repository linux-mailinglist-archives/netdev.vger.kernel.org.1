Return-Path: <netdev+bounces-163046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E422A2949F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5401893CBD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5F19259E;
	Wed,  5 Feb 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b1bZddQ2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C37165F16;
	Wed,  5 Feb 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768818; cv=fail; b=CwafXZ5O1rE20fuysKNenaFisCnFk6L1r6a0/Svq7g9wU1tdHFUgLdcDapwsWjkWPhVQTEhwB62Fi80Q7sEbqy16Cb6VFjma8/i+exeAZuyjWRhuHnPrubx4Wv1HFYBAHBld657TigEg/Q7FrSdDGj3j+ilHUymn4/aA8jgM8GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768818; c=relaxed/simple;
	bh=RmaDx+8Cp6IAWnJ7uRdUDu/st6P8gEfvwcA9T4EvxiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eN+Wg/3AS6Gh1drVhx5TmuQUJsTcOi3DDNkvSwo3/wZipW4u89f4JqaReogBw+ZcQAC8CJiKXyQ7TaW57x25EyZ3o1gxwFuKeJtKqVO8hHYMBFqjhRWsVAMK2mWghr7UMTMg4omgSoJQec077545T+vXx0k2wublnmxrQXQYu5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b1bZddQ2; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWvHmEtTQbj6o5sV1vq/48K12y5Gzoqn0ub+fNhCA44KJZvanIMcYMCnY/80BaPkOzuTw87AsXBlWSij8GL8Rr3cN8u0fbrhuNWJ+9IWm/CVUfSGzG9qOiAYMD1D3ENTB4o7UNQXQgOd809utwe5VQ7ZgVKLXCw5i61y13VLOKKVdazdE3Z/tS4dSBUbkqk72MuTQ3nVG26UhJOlwCTTmXfpVd3aDVbVvjrXsDhPegUzY+032m8LYIXPpT2FF3S5t25hWNguhlWOCjXEjOYJfjpHQ/jg2C1lKGCMbUA479B7qGsUNXZrfzhMnqyUcQM4N+LY4BP4npb28AM50j0GWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FicCpRAUbiiU6kEYIW8YsHfJbgToCsyeqmsLMIQ3jZk=;
 b=jCVvZrdt1GBpALEE+AuytxpagneVCuit8CaFe75dBvlw68WKY7iADnFIxWF8oYt5zN7ksvlD2MzDPLdYE9SdawkW8tAJFyn87Z2a3IcZv5EP7ICEv5PYVKe7GCWY2+eJv+h+bvh7ZhJBw5pdbqsABRm+OYPMBDbxOyRenRR8aJdu+ncHCmKXbFf2JXm4r6Svv3K66IRRO9uqZOH3vWln24C87XhFqfYx1nWvIMF0JEA6nQVwnGGqC7aBOGPJXD8h2OToxHdcs6zo44MFrCoNMuulZdP+StP73A9CSmdWlzXRD/Zoqde1w3fRmynD9Ip1fZBiCl4rigvOZ4CRg3Uzww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FicCpRAUbiiU6kEYIW8YsHfJbgToCsyeqmsLMIQ3jZk=;
 b=b1bZddQ2AQ7DGE2PICrkgGV6+/9pVgy52QAYeX4tj8//Kgi3l69NjZEzCHltvzHf1VIHtIDqZVwV/vsCoZSaZQySNbueFV/HY+Ll9l6S8qd9ZutPXK/z3ElA+nDrnUrYk98V0nHvwHzU7iWAhAGIUWj+NfoRT7fcyyfMVqS9JUs=
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 15:20:13 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::c0) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:12 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:11 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 10/26] cxl: modify dpa setup process for supporting type2
Date: Wed, 5 Feb 2025 15:19:34 +0000
Message-ID: <20250205151950.25268-11-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc7fb82-c19b-4e88-82b5-08dd45f8963c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8wUyzjBVphDuYS9Mla7oiH5bKn0aq600oGqObttuimvoTK5upSEGuVGyzJ6U?=
 =?us-ascii?Q?ak3kjPSP2rbYqMM2aNrrC4wPJiCDe8AQaN8EvI/ycnC+tWcsHWAgLX2GLJWT?=
 =?us-ascii?Q?k6XuiW5OUv86AIZftboBKsmQ/wdX4kApRafmYwG4cCNVpqILdr3H9kmjsmVb?=
 =?us-ascii?Q?uY+yWInkkMc68ElZTH5C9OKgac+PJV0lLYYWOn9yZe2lURo9IQsPq/qUyS1d?=
 =?us-ascii?Q?bxl43C84g1CIEFooREl6jAlhNDcMwUTOQ4m+eq4JOp3ZGYtVm1P8b2ikk3sS?=
 =?us-ascii?Q?XuFXTHRtsYr0IlOxkAEGZ2H2jcCMebl/pazS5J6i/2YJx7tIF0uB4fayzWSH?=
 =?us-ascii?Q?u3loGOYNp5D78spkRKlIewQr7NJFAnNNlN2l6wnuUuwh/RMsy9/0RYNRRzxQ?=
 =?us-ascii?Q?SO+7bPSn5qLgQ7udQnOG5mYEr/2H0B3HN42tXNreQ0yY3FxjSfdY/SvpNKf7?=
 =?us-ascii?Q?9o+HqAjsRpG33pWbsByxeEkZRvPzPg2Qy+2pELUvqbeSCDBmiGDpU9kwYQEX?=
 =?us-ascii?Q?E18og26/pEqsi2qamfNGZDIOXBhvJMdpKG+xfk6J8nBwbM4ElzAprBXCnB8w?=
 =?us-ascii?Q?rfg5kAy8rDZVlRifnHuDYA/ZhIyk9CNmzjHxH8w5l4owPz4t6JpRrnDlkFPh?=
 =?us-ascii?Q?UK28+hGGuG3oJToC9U13i8GivLTSa0CVGnK7VWTnOLRddab30XZEIf49Z7Pp?=
 =?us-ascii?Q?7o+a2amdEZkGNFM6Fd35I8v3P8+Iz9kdt8TCNmAf+juUiqPyXWduAM8SpJ91?=
 =?us-ascii?Q?WZeNQLpnAIQSnl9bqTjG8Li7ebvsM0geAbqDjFBbWrgohPJcqZkJhTdEEa/b?=
 =?us-ascii?Q?SBZ+ZLgyvgdn6ZExx7dfukVjbz2aSCJIIRN0rRui2aYDpAZeptKUZdHEyQaj?=
 =?us-ascii?Q?JfbjgDslki0eDUYQ5FuO97vcmD0xRjvsUEB0/fcBZwugb1Je8dwxZ/KOnADF?=
 =?us-ascii?Q?EPCk7XVNv8EkMdzWkd2XMf1A+6g99k2aD6Ia8P+18Xr6JmQpPBizCWvJ8YVE?=
 =?us-ascii?Q?wbpIX4Nyoa81lm3sCIXdyMyoG4UeWfTkA3M2omoAI0S86v+o7DSh5b1YIrGQ?=
 =?us-ascii?Q?VShMkjqeIrzzPFm+Vq9XtGZuu5YqyYwiYECIdpEZIgMr8Zwef0rg9/vmM5Yh?=
 =?us-ascii?Q?JXOg0X4bqbPP8kvN0f2UYhJhpPzp4o3+rkcUfLSaWF5FhdEKYJwpTMfyis2a?=
 =?us-ascii?Q?+jnKK7d7LdrT4YzdSsT6dDbQNiatn9jhvWRGzQDc+ZFR/USFLN0oFWADWlvz?=
 =?us-ascii?Q?feCpeRRuzTLULyxLY9cKzwbroQkx/Fm4dXc+a7YO1xaTnhU5Lz1yAbB6aRYZ?=
 =?us-ascii?Q?WbJSLWgBDouQnq5R5KQoWqcYEX4RvFIakqps1X0+S9AKs68Ax6hMDjTDRz5r?=
 =?us-ascii?Q?sNtnXtqj14BtJLvWsxtMuUilf4FmsVoeU0H6K+05fFjkgs3KP/BbJtVS6ivZ?=
 =?us-ascii?Q?mVFwhDDFsALYCaYJrnzlzKgoCV4RmpwE+2Kssj6bLh3qLlALn4qA64e5ZUf4?=
 =?us-ascii?Q?+X/QTHth8hlx+GI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:13.0138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc7fb82-c19b-4e88-82b5-08dd45f8963c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789

From: Alejandro Lucero <alucerop@amd.com>

Accel drivers allocate a memdev state struct but only able to use it
through the accel driver API for initialization and setup.

Modify current dpa setup by drivers for realying on memdev state instead
of dev state.

Allow accel drivers to use dpa structs and functions.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c |  4 +++-
 drivers/cxl/cxl.h      |  6 +-----
 drivers/cxl/cxlmem.h   | 14 --------------
 drivers/cxl/pci.c      |  2 +-
 include/cxl/cxl.h      | 19 +++++++++++++++++++
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d705dec1471e..af025da81fa2 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -467,8 +467,10 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
 }
 
 /* if this fails the caller must destroy @cxlds, there is no recovery */
-int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
+int cxl_dpa_setup(struct cxl_memdev_state *cxlmds,
+		  const struct cxl_dpa_info *info)
 {
+	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
 	struct device *dev = cxlds->dev;
 
 	guard(rwsem_write)(&cxl_dpa_rwsem);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 27d1dc48611c..3faba6c9dbfb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <cxl/cxl.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -478,11 +479,6 @@ struct cxl_region_params {
 	int nr_targets;
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
index ab8c23009b9d..a5994061780c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -98,19 +98,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
-#define CXL_NR_PARTITIONS_MAX 2
-
-struct cxl_dpa_info {
-	u64 size;
-	struct cxl_dpa_part_info {
-		struct range range;
-		enum cxl_partition_mode mode;
-	} part[CXL_NR_PARTITIONS_MAX];
-	int nr_partitions;
-};
-
-int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
-
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)
 {
@@ -841,7 +828,6 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
-int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 						 u16 dvsec, enum cxl_devtype type);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5fe5f7ff4fb1..bcfa3d86c37b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -955,7 +955,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_dpa_setup(cxlds, &range_info);
+	rc = cxl_dpa_setup(mds, &range_info);
 	if (rc)
 		return rc;
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1b2224ee1d5b..ec56a82966c0 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -49,6 +49,23 @@ struct mds_info {
 	u64 persistent_only_bytes;
 };
 
+enum cxl_partition_mode {
+	CXL_PARTMODE_NONE,
+	CXL_PARTMODE_RAM,
+	CXL_PARTMODE_PMEM,
+};
+
+#define CXL_NR_PARTITIONS_MAX 2
+
+struct cxl_dpa_info {
+	u64 size;
+	struct cxl_dpa_part_info {
+		struct range range;
+		enum cxl_partition_mode mode;
+	} part[CXL_NR_PARTITIONS_MAX];
+	int nr_partitions;
+};
+
 struct device;
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 					   u16 dvsec, enum cxl_devtype type);
@@ -59,4 +76,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_memdev_state *cxlm
 int cxl_await_media_ready(struct cxl_memdev_state *mds);
 void cxl_set_media_ready(struct cxl_memdev_state *mds);
 void cxl_dev_state_setup(struct cxl_memdev_state *mds, struct mds_info *info);
+int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
+int cxl_dpa_setup(struct cxl_memdev_state *cxlmds, const struct cxl_dpa_info *info);
 #endif
-- 
2.17.1


