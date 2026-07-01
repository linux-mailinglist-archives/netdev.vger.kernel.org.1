Return-Path: <netdev+bounces-303582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vw9BHGzvRGo73goAu9opvQ
	(envelope-from <netdev+bounces-303582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:43:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8E06EC513
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:43:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="NVFjqLy/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303582-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303582-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B11B830325AD
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CD3F1AB1;
	Wed,  1 Jul 2026 10:41:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D817367B88
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:41:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902496; cv=fail; b=RznVaXWAZYRmSr8xfi5dGWmCXRzjjBem1elQrocjJQvVOsj9JEBUN5YZcaVAj3TJrkgYp0FU0JU85H50f6jLru1SqjEcy51P7xkoOLd91f4RORaEqS90xNun4EvkSPSSfgsYKVXvWAEFhTdq0fIYzP0nZNK3PadH9aZv/bEub64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902496; c=relaxed/simple;
	bh=dg5mIJwjeyR4RxqP5LYjmslIRyFMHIJhMuh2p10OtPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upOK9wxOtU/0OTFYTvOY5lgReANTm00vp8XwqMAzNelo1EFaBj8L2GXAPAHSx9jhy5NK/LrkxbVFJ8t2Gm1OXkK7PFMqCDnXhsyP4Rj2zYBOd5yTfQ2R+GEPFDFYmqg+QhEyfMIc3m6EPSpsveyXoIaKV4bzMWNHPSLOdKE+ZDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NVFjqLy/; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZF2YtyxzukJXmFRMKqraqLgjwvnxDF/UEOqHZThjClu4wJBMxc2dsW8tC+zmUfP2+TmM0tVOhFrfRXsq+yw4XkVx7Z0/9t1wllckG/ph9gZbYIjOoXA/QpHxzmSTQA62XIowXF/rvcCa95CL7pEj3PpDwi8isu35Nxqm472RD3hAyHp+5Rms7F079q2i/SAy9sguSu2WG88Dc6gg2qVvNTns/8EquLrospRdiyQ45pOnGzkjvKfYFyObWpngnXtSiYlGjFQ5efTpQz7JDY7FthBuGuLKGnZXjc8XkRR+ebsM3yyD0YRJGCWV0CesiY5k4cbrVSff4SAdNZchUvRDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWbxU/Y7B+yIjQnn2ZNY9Ut2OPJgGFb1LtDCZKcMeWs=;
 b=bfRiI0naZSiZsqghXXRwbBBWz4vzPViQ52zKpbgoZvJsn2JuWjeOmHMFd63SySWRTP5R099pePY/y+WmeLcY98XRcMmOh+oVu+QWm0Mn/WR2CnaapY8YqKu37JDC7a/W4grW5ZwE/RaqWKk+d9sqItdAODWl2q4ZwNOWoJUw/Eqy4QkzeOxJ0S/vPlcfgYEN7ALWlckFAyR9bu57WdUOQQBBPd3M1iGZyy2cgJFlwFJmSSKocWIyIe18gIqRy+3D1dJUWPzJooSi8hCeZL/jF3BlZFHJl6i5VNxJFL8WDE/pi/Kxrt35eZehVMhfM8jU2Tv7DqATmhMoU3dNvj+5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWbxU/Y7B+yIjQnn2ZNY9Ut2OPJgGFb1LtDCZKcMeWs=;
 b=NVFjqLy/adw7mQ33DtpteWPodiwvmgCmapG0z0Hs9GtfL8EA0ZSHqHdrWWqt75omsMXR3ooPl++NiuDNvfkJ5WK2dH3MC/SO7EmRD1/C8qApZadt19VzKzx7ha+4QvH3NY3AiPL3xSORPyZ9ptWgPUn5PogsOKw+YknGuS+ZV4g=
Received: from SA1P222CA0166.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::10)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:41:30 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::21) by SA1P222CA0166.outlook.office365.com
 (2603:10b6:806:3c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 10:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:41:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:41:29 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:41:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: [PATCH net 1/7] cxl: Support Type2 cxl regs mapping
Date: Wed, 1 Jul 2026 12:37:59 +0100
Message-ID: <20260701113805.14072-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
References: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4278d3-881d-4297-5542-08ded75d4fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|6133799003|56012099006|11063799006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	/A2Wt40g2CaXgAJaHQPgxAgkUaeBhqXXez1zMCr4caVyQUe7X1BVnegJ9aGK+i+LhUFy8BgZxwHCT+sy9h8HEofGd0ij9YOIsSohL7iTP1NYZKBE2pm4k/H29/E5kB445+WRkPDaL20v9ZsQsMU3tHvHsGWkoyMeIeVszKpdHFgnuhDZuw6Qs49qQ8/0YqLUJhbYRlPi6YE41fElQUzKZGkzfFJcBvfM1g1AHHzriDXoOF8jWCoyvXq6SQzMvK+D2Y2flNBI6n2V/BoQQYGQp0gokcHCLb5o7i5w91U81YuDI/rIwy70JGydxPHC2iTbbScOy5VkBJ6U41n7wf+aCpDt8KdJ/uJFGX09QuEGxV/zhRxOu2tRvIH/R6ysqYxrsLYflDTQ9rl7t2lNLfHLB8WmtpANj9nmFa/2B5gt47DwsyOc59ZqxgK3nqF3TdZgaK+zUjqW23Tt6PQuRnx8VPV9XRLSmx9Pb5WUhVC2D+bNFFRVVRcTN2rWU+8dCofk1/MVJ5roIlT+T7NLFqpFLBVOO8vV6JOJ8ArOQGTWGLjPCWvUoHkcNFiMoj9oIbcB+54r2FoR/Mzr0GhGYEAecOnpV1YXYWWIDWhMvK/bda0jLTBDVLSxDJj44apkgJ/LbCDv2HUeCWDc/rkOsEd3ri7WvFVf4OqB/xn7JgvIjbU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+5vGW9gE848SWrh8h8Uye6O26LrOTMGiUxnzZikHU4/yIt/yTQRzVY0LxTZLvE4RdUoopiSoCUFO+8atwQ5fApAditvAMVSrU9XUB0ktyLvNb1zvtuMzUyNbcIsUmXvCdsZu7aSCh19YHHrhyWO0b6RZoadOWBX5h0ufYevnTNSATvkxhzD5+GkpbDJp00RPZ360ZpEdOLU2lwrQccpI8N6G8WrRhLN+++ESNuoEC0/pQjYXoVrZLl7M+b2oIuSx8kkMi/OQS1kGUD6TDImcJs88u0oTENra4Da5/Mc8YJP4Ezu37efoLeD8CeVQpYyyQ4MNuOdtT0njqVK6dO50T1Z/x2w/QFNPjk9Ar5hun33rEbVKIJmbjc5f343altJ6cXgS5IsIQTDGAl1TJF8wzOXc3Q+Ahc8wrEVD9FrEr3uA1jsmR3x0//64q3iIdb5D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:41:30.4003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4278d3-881d-4297-5542-08ded75d4fd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303582-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,m:dan.j.williams@intel.com,m:Jonathan.Cameron@huawei.com,m:benjamin.cheatham@amd.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,huawei.com,gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC8E06EC513

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device registers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://patch.msgid.link/20260629183727.51502-2-alejandro.lucero-palau@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c  |  1 +
 drivers/cxl/core/port.c |  1 +
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxlpci.h    | 12 ------------
 drivers/cxl/pci.c       |  1 +
 include/cxl/pci.h       | 22 ++++++++++++++++++++++
 6 files changed, 26 insertions(+), 12 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4338fd7e01b..9d807c1a002c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..cb633e19151b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/node.h>
 #include <cxl/einj.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..20c2d9fbcfe7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b826eb53cf7b..110ec9c44f09 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,16 +13,6 @@
  */
 #define CXL_PCI_DEFAULT_MAX_VECTORS 16
 
-/* Register Block Identifier (RBI) */
-enum cxl_regloc_type {
-	CXL_REGLOC_RBI_EMPTY = 0,
-	CXL_REGLOC_RBI_COMPONENT,
-	CXL_REGLOC_RBI_VIRT,
-	CXL_REGLOC_RBI_MEMDEV,
-	CXL_REGLOC_RBI_PMU,
-	CXL_REGLOC_RBI_TYPES
-};
-
 /*
  * Table Access DOE, CDAT Read Entry Response
  *
@@ -112,6 +102,4 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 #endif
 
-int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..bb892dbfdd6d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..3e0000015871
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_CXL_PCI_H__
+#define __CXL_CXL_PCI_H__
+
+/* Register Block Identifier (RBI) */
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_PMU,
+	CXL_REGLOC_RBI_TYPES
+};
+
+struct cxl_register_map;
+struct pci_dev;
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
+#endif
-- 
2.34.1


