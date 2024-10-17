Return-Path: <netdev+bounces-136663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D549A29BC
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4456C1F21AA7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D8C1E3DED;
	Thu, 17 Oct 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n2cPw+4d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6EC1E1C0D;
	Thu, 17 Oct 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184002; cv=fail; b=Z5PZ2qADWf/LoYXuApW7W5BNIupLyI/mCrYpDPqYy6N7xp7bshxuoRbAcWyU6u0ywWv9rRCSnyUhHY/8NfX9Ibqgb2BLjOQSTLvDNQsVt5J6byM8Smj1vCy9vAeRZDojtA3TjfwWa7C7ZjijCMQxk8MGeoKpo6RzEOB1CN94wss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184002; c=relaxed/simple;
	bh=dwTBywesV/6UiHEGDeeGtq4cd77AZsxACt4ssmcUJpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8MRzyANlVdmX+JuoJ6/kx1NV+sFTbJC7+9memEifsIN2Iqc9jxspXFRD59SbDt5ulu+yNPK4/oijBM46DD6u7fVqaXGm2l6k7zdH99g4xtwcriEBsSqH3KwP+IoMctEXuA1PsFwmcQGL8/X3F369d4O6uG6vmNujHqkoDFLTLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n2cPw+4d; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqN7e8IKA8wzRokoIckw6sfbWZn93yZ6gfsI9QHI/CFcmQfNLxQrSON+r9IGcjSwhCIe6RfI3GWXAorr1CK6zoMx9Y2OD4WjAEHF/s+yMG1NBBOT2Djysy4pgUJAats/T5j1N/c8Fjk9YDFIUYSx2DMFeb4RLgy7NHsIFVyDkOQl/V+PTn0gg8WItR4QFy84ZgtAnPzHBygZSNV/pjh0nFRISbtCmLexHPvuhhBZb+KqU0eaOowXwT76swmD2PUaILZgsc7dou3wziiy5+S0DweQfwKrf3k7Wse22SnS4InXpX4Il+0pciTQkD1d6uvctImQZzmvXNGQDSEkUrM03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OQZVZe0uMVuVeyDjpRscgUEhmMmdLSKpY3YAULadh0=;
 b=zPFkLwR0Lk2EGxx7iRUbSF2JYSEIrGjYHe4erG/eTrX8/HKzJ8pihAa2z5lBWxnByfQ8GiBt7U090fx/VEK0rjEUby+A6IaBknI214JND2migcXJSEhRpmd+cyoUPOMgZFatVzYrjBn/xbFtPmtTKK4w227O03ghT1pzyPPthXkjjp9s7mRTvxlHY76NhBDIaxCz8BMIFWyM43H8RMMNjriEk6A7RLunIxVGEzJffkIOD38AxoaR76EjwPtIb8EuC+hVkxXexBoKtI8t14KOWuNZcKKSl2zN8byfYqTTo3uzpl0tf/DixArGGQhowthiOvEkkRdERG7Lzb69LtnIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OQZVZe0uMVuVeyDjpRscgUEhmMmdLSKpY3YAULadh0=;
 b=n2cPw+4dc0kug47Ozj5yTImHqlr0iV4cCmvJrzFEyEx1afwbxvyIj4LXpJWcGdNPGUWrnm3+JKwOpdJERnpSAz7utKaBFqjziEca6pV4z7k7EAXGHAc6YkSX1oNlqkAp6+vbH/AKYxRs7DF1mTKjdBN8Yv8Y2ng6PJbZIbmDAlc=
Received: from MN0P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::10)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Thu, 17 Oct
 2024 16:53:16 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::aa) by MN0P223CA0023.outlook.office365.com
 (2603:10b6:208:52b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:16 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:14 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 03/26] cxl: add capabilities field to cxl_dev_state and cxl_port
Date: Thu, 17 Oct 2024 17:52:02 +0100
Message-ID: <20241017165225.21206-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 833cc8d7-607a-4dfe-dcd8-08dceecc3290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOZx0M/9B2VsajGcmRQrICv3BBuuzvSChhA3gzG7Uy47R3tGHMO4yAJLfVIQ?=
 =?us-ascii?Q?sC4MYavFDU8tDwC/DkOWOvmFViLYhpztbgw+394wgnktmIgP/TZXJLLA9P+u?=
 =?us-ascii?Q?zaz7o9+nOfNmBC/Cn3M7YmtBweXG6Va00xMuRqZcd7CWbM3z3ts3As2EnmS3?=
 =?us-ascii?Q?gpcp7CN5vNniZEbliOWYMnCdw3+n7f9JpxV1uqGYAjrk0hUNP1uWqlY5U4XS?=
 =?us-ascii?Q?WJiOBZGIWKNCNG+SdShmv8w1/f3fbUL7WSNEeZ6BGHBtT1E/fZY81UtKjOaM?=
 =?us-ascii?Q?3fUte72JKKJdbgYMZPSemIaE231XUDkPFbKeo33rc6LSeGNCb9QLaVE035Bj?=
 =?us-ascii?Q?pMgRPdx8MicrEPXyCaZPgv2zgrG/L7Q7gEY9dH+JX29BgBbCmDVTdZu+ME8Z?=
 =?us-ascii?Q?LLlT6wTDkUB3s3oHInG7m1jqDeowrT2kt2sswPxjH5pSbXaJsb1SmLIPtf7f?=
 =?us-ascii?Q?0YIfjjOuFncdenH8crJDrOjI4NJ+BayNl2OtCKfQX/6EIEGhowhjPxi0lJIq?=
 =?us-ascii?Q?UYEbF6Gi8eulXxAGrwvpCojoUBEOPGppyyPzntsnMEi5LAVKCWETj3XclebY?=
 =?us-ascii?Q?z60SddjpEPUDQ3ZD6PM8I/grhqaV2y/oAmYVkb+a1SaCtGcFhgI4NR0UB+xa?=
 =?us-ascii?Q?qDXVl0PElbUZ/7NCyVYE6jhspHdtrz7pBfWZSExYFpktnAlA7Fv9H1F5FoVw?=
 =?us-ascii?Q?bK3UpzTqjWRp7bG7dIQEO36/aC2cUKobMQaW+UKU8P7wkGlTqFQRlWWFF9W2?=
 =?us-ascii?Q?6MGLku1fYHUwc26yMDYGJnc6DXc/SvVchL09C4r82+n2H45eLkwJ0GmNYlWf?=
 =?us-ascii?Q?MSg+X7utANgtJJJV/aYoozTz7iLUgYelJ8VzsYDCjxtFNo8odbeyvO9Lq8/Z?=
 =?us-ascii?Q?QocZ3r9Kdg6QQWPxEowu7ulCTj8RE5p6BwL1k+u/lDjR95jqbE1rfRWlqi+u?=
 =?us-ascii?Q?od3dSpTO+p8VkQh7bz2Ne8kgWuuwISsrStlFz3iCJ4NziWJj416CVJ0lVYFR?=
 =?us-ascii?Q?8MVlCmBLMZU5pP7RpxOgaGH8qUNgv3Jw1+QSyz8fANpNedBpdgzvzQPUIOvk?=
 =?us-ascii?Q?G/oK9qjMJRCmYLeMReY7eWBOGXcITOC8koSju9x7Czl7mAfK4VeXXXMz79NM?=
 =?us-ascii?Q?vnS0km8yvnVEdRrIRgL0s73A1cyheKRAt8GyhABKvJa5HtYWDLrBEFQyiAQb?=
 =?us-ascii?Q?LI5LrNyViDIY7CGTMXAsdEcLVKAatmKr9YJxtkpcA2D0Kdi5uh1iPHlGzkmk?=
 =?us-ascii?Q?0Hok1egCsFoR4w9oDY6IQrKL+aDqpCb6O63Cqj+ptgIjNGV6NpuSndqey5O3?=
 =?us-ascii?Q?tVVfTlIRxfthP9EOjc6EAG4qnN0ldkXKUf3gKJCPFq8WZDQ76hAMW1sdaQ6H?=
 =?us-ascii?Q?+aEU4rWEUGFegB2LkWAXJ/LW2UK2H5TzEjOHO9u74YrwsWEcQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:16.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 833cc8d7-607a-4dfe-dcd8-08dceecc3290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

From: Alejandro Lucero <alucerop@amd.com>

Type2 devices have some Type3 functionalities as optional like an mbox
or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
implements.

Add a new field to cxl_dev_state for keeping device capabilities as
discovered during initialization. Add same field to cxl_port as registers
discovery is also used during port initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/port.c | 11 +++++++----
 drivers/cxl/core/regs.c | 21 ++++++++++++++-------
 drivers/cxl/cxl.h       |  9 ++++++---
 drivers/cxl/cxlmem.h    |  2 ++
 drivers/cxl/pci.c       | 10 ++++++----
 include/linux/cxl/cxl.h | 31 +++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..7b859b79d59d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 }
 
 static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
-			       resource_size_t component_reg_phys)
+			       resource_size_t component_reg_phys, unsigned long *caps)
 {
 	*map = (struct cxl_register_map) {
 		.host = host,
@@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
 	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
 	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_port_setup_regs(struct cxl_port *port,
@@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 	if (dev_is_platform(port->uport_dev))
 		return 0;
 	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
-				   component_reg_phys);
+				   component_reg_phys, port->capabilities);
 }
 
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
@@ -789,7 +789,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	 * NULL.
 	 */
 	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
-				 component_reg_phys);
+				 component_reg_phys,
+				 dport->port->capabilities);
 	dport->reg_map.host = host;
 	return rc;
 }
@@ -858,6 +859,8 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 		port->reg_map = cxlds->reg_map;
 		port->reg_map.host = &port->dev;
 		cxlmd->endpoint = port;
+		bitmap_copy(port->capabilities, cxlds->capabilities,
+			    CXL_MAX_CAPS);
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e1082e749c69..9d63a2adfd42 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/cxl/cxl.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
@@ -36,7 +37,8 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map,
+			      unsigned long *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -84,6 +86,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			*caps |= BIT(CXL_DEV_CAP_HDM);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -91,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			*caps |= BIT(CXL_DEV_CAP_RAS);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -117,7 +121,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
  * Probe for device register information and return it in map object.
  */
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
+			   struct cxl_device_reg_map *map, unsigned long *caps)
 {
 	int cap, cap_count;
 	u64 cap_array;
@@ -146,10 +150,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
 			rmap = &map->status;
+			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
 			rmap = &map->mbox;
+			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
@@ -157,6 +163,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -421,7 +428,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -431,12 +438,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(host, base, comp_map);
+		cxl_probe_component_regs(host, base, comp_map, caps);
 		dev_dbg(host, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(host, base, dev_map);
+		cxl_probe_device_regs(host, base, dev_map, caps);
 		if (!dev_map->status.valid || !dev_map->mbox.valid ||
 		    !dev_map->memdev.valid) {
 			dev_err(host, "registers not found: %s%s%s\n",
@@ -455,7 +462,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -463,7 +470,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..a7c242a19b62 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/notifier.h>
 #include <linux/bitops.h>
+#include <linux/cxl/cxl.h>
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
@@ -284,9 +285,9 @@ struct cxl_register_map {
 };
 
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map);
+			      struct cxl_component_reg_map *map, unsigned long *caps);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map);
+			   struct cxl_device_reg_map *map, unsigned long *caps);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -300,7 +301,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
@@ -600,6 +601,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @capabilities: those capabilities as defined in device mapped registers
  */
 struct cxl_port {
 	struct device dev;
@@ -623,6 +625,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
 };
 
 /**
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..68d28eab3696 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -424,6 +424,7 @@ struct cxl_dpa_perf {
  * @ram_res: Active Volatile memory capacity configuration
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
+ * @capabilities: those capabilities as defined in device mapped registers
  */
 struct cxl_dev_state {
 	struct device *dev;
@@ -438,6 +439,7 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	u64 serial;
 	enum cxl_devtype type;
+	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
 };
 
 /**
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 246930932ea6..6cd7ab117f80 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -503,7 +503,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
+			      struct cxl_register_map *map,
+			      unsigned long *caps)
 {
 	int rc;
 
@@ -520,7 +521,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	if (rc)
 		return rc;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
@@ -827,7 +828,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxl_set_dvsec(cxlds, dvsec);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
 	if (rc)
 		return rc;
 
@@ -840,7 +842,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+				&cxlds->reg_map, cxlds->capabilities);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index c06ca750168f..4a4f75a86018 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -12,6 +12,37 @@ enum cxl_resource {
 	CXL_RES_PMEM,
 };
 
+/* Capabilities as defined for:
+ *
+ *	Component Registers (Table 8-22 CXL 3.0 specification)
+ *	Device Registers (8.2.8.2.1 CXL 3.0 specification)
+ */
+
+enum cxl_dev_cap {
+	/* capabilities from Component Registers */
+	CXL_DEV_CAP_RAS,
+	CXL_DEV_CAP_SEC,
+	CXL_DEV_CAP_LINK,
+	CXL_DEV_CAP_HDM,
+	CXL_DEV_CAP_SEC_EXT,
+	CXL_DEV_CAP_IDE,
+	CXL_DEV_CAP_SNOOP_FILTER,
+	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
+	CXL_DEV_CAP_CACHEMEM_EXT,
+	CXL_DEV_CAP_BI_ROUTE_TABLE,
+	CXL_DEV_CAP_BI_DECODER,
+	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
+	CXL_DEV_CAP_CACHEID_DECODER,
+	CXL_DEV_CAP_HDM_EXT,
+	CXL_DEV_CAP_METADATA_EXT,
+	/* capabilities from Device Registers */
+	CXL_DEV_CAP_DEV_STATUS,
+	CXL_DEV_CAP_MAILBOX_PRIMARY,
+	CXL_DEV_CAP_MAILBOX_SECONDARY,
+	CXL_DEV_CAP_MEMDEV,
+	CXL_MAX_CAPS,
+};
+
 struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
 
 void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
-- 
2.17.1


