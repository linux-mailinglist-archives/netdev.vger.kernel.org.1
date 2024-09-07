Return-Path: <netdev+bounces-126211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D166E9700CB
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C211F22C31
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88D14A619;
	Sat,  7 Sep 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dHqVnCmV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBAA14D2A3;
	Sat,  7 Sep 2024 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697172; cv=fail; b=PyvADm6u30b7gAXc1dGuLTtJ60HQhmmnP4RqsB15ikCc0pFzNxRWQ9LN7hJK9pFGkDy5Lvvk68R8GQudI1xZR6bNsRZRzXTqNMFbMOp+UTskAp0OZYNhaBdKbZ99QYt+MokFCOLeRcKGe1RjC6p4h4ZxxSOxWavYVVikX5qgH1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697172; c=relaxed/simple;
	bh=Had/Wf+ENyHWkWUkvIAsRI/aCTIvij1E+ZIoTMuIgdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HynWvnRIkVnAMp7rTUQJ/ZXBGIyqHMDZYHOq1Vo8VcD5RUKnXcKgbJ5EFYi5uDyNs8WZP5O4losnP/MLMkk/yeqA2zXZ7ACD2sFF2MY0U1jDkvzAWxJWmCaJ8t8o7su3t4AYN8NgmzSvuCq28xwRXmMtz31571BNybwlzm183mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dHqVnCmV; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0eW/0eYnvmGS0vRkttQ47YqvYfyMyFxpnOON+yDn3bZROncBg7otyt10MIhiDgfVtQqzVVg1TgJQX4IqoXgMsp9+uENaYzdwi8oSWhkMsw3kSezIPQ7ijUlWG3Xra0cYyXmZ+Uoojx27XiubdjrfPdgWYuE3AqWb5nqbR7nbuajGj717bdZ6laK1PyoOf/G4jwVC8xZs0uxKPUjtmuP8Fg/YlrOwDhNjQFp/Yub4QA0mH0d5XHLchEzajaUhSSsoQAd3ZXA5aiSDFafeYd940d1vyUdYmFOmchN+0egTCR7ApS1XJDD+xprGvB6rkORNd+EO5VuUnfkAG5Pmm1fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icX+T0gf6CCWs6YLnKH6hf7VYe2ePjG0Nllz+CMgvQ0=;
 b=AGeaM1B9SW1uAttCo8DX0kWTT3jLV55JG4rLPrfpVvusgHbBsc1sFkH5123DYzqaf5VE6mFEz2Zyz5Y2kMnjTl2PK+RgxoPMR5EeTiW/+HUvhhDRZJUhtC/VQ//6lP9/MkEQxobSUEljMx2Veh7Dd3dwtUutMGXgv8SkRaAFK6AwQW9YY8DZGq5SmtCbyfoLZDPFvF6KHDPFGLIBbTy1nQVGN0hU7ILuMCk/REmo19pDbgbZsjz3SF0/U7wf1ABUezTGGMZkHJsEivbjeSPhTJHAsRoE+metyny53JDijS45oEfjtezBHMNoAjm4b/AN1SgiTO7iECkz+YoMt5aS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icX+T0gf6CCWs6YLnKH6hf7VYe2ePjG0Nllz+CMgvQ0=;
 b=dHqVnCmVYRwuoBj9AOUPBXyDUs2Nj5DdgpoNbLVyMzGly1ngu4fmnCiKC2EXLBqhbalkGm8nCL9NfI5k5XLJQDgav7oODtE7kP/gmB1ueZtRh6RMwgkZBBZ0CcXw8iCzdbxGX17mJvwjjhrwa8sifMfmMyPlNil2k1l5kk4yP/k=
Received: from SJ0PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:33f::17)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 7 Sep
 2024 08:19:23 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::93) by SJ0PR05CA0042.outlook.office365.com
 (2603:10b6:a03:33f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:21 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:20 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 02/20] cxl: add capabilities field to cxl_dev_state and cxl_port
Date: Sat, 7 Sep 2024 09:18:18 +0100
Message-ID: <20240907081836.5801-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e1ace7-d71e-4cd4-1c61-08dccf15c775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+bdHE4IwwqRUO/46Fd4h2BS6+exefB27mFeXortLL7JoGBSyKRrJJgPoc+s?=
 =?us-ascii?Q?x+uUaXAJiMBa1THnJlKKltV5IqhveBCOBMCVwCJwhvDJ7jDt1v0qmbFtu1TZ?=
 =?us-ascii?Q?yqvX1iOe5oGntz4bQp8I7hiLkxymP7gEcIegj7w3eYpUBlKH+JWN7GVCok55?=
 =?us-ascii?Q?MkbyocSYO/AZCQlYtBmxyewtBqpKadXGWLfqxFn12JcpzuGvIJg5eHDXiPCh?=
 =?us-ascii?Q?k+yQWDdigONli4QyLCz3HTWk+QaNVF2tkfIFLGMAtzWF7v15+uhWfdj3A3S1?=
 =?us-ascii?Q?krgfdBXMYpSAQfzxpwY/l2boko4jVqVocOuVQdEQeoNPyhix8tQvm2cHziMV?=
 =?us-ascii?Q?rGUJD7PS6izU2uoNPNAHwnUWAtZux379mtrV8YTdvABTYU1cxLDF69JjDueR?=
 =?us-ascii?Q?/PXJ9AO8UCVG6T8ZyP3+98hTT/JuC/hI3w/A6Mwsdje7GsF/TU9JbcWk7N5Z?=
 =?us-ascii?Q?23z4aJH7eM4hxvPHB/XbaLgu09U6c8SKmhV/usjaNJavNGoL+jeEcwPMr5N9?=
 =?us-ascii?Q?b6Xt9knXFrDSUWja44p070WTTROfAigz8YhTZ5A+8ypGNhhmaz14WMKY4kVl?=
 =?us-ascii?Q?7ypdAbL4Yb5jJr1l3MLEW2WA/yeR7LBkpAg39oWosPaqIqcCgt3Fb9glnRGp?=
 =?us-ascii?Q?+5QsUclCbNXZTr5ky20lrNvLOUdAZ9WoDC1ejdMln0fqdFF29qvx/KxmEiQ6?=
 =?us-ascii?Q?Hi06sGTCfFI1Pp4EHfPz4r2QBLgGn2Pe9rFCL3P+VYP2JTWfZP2xpe6SQsQw?=
 =?us-ascii?Q?MZHzWNdjboJ5jL9EcOSZEs1QPVAWw1Hu7zoMHSigA45+n2Fs6RfJcLnbP/QI?=
 =?us-ascii?Q?nEjN8uDIr2lD1CcGLkXVR31tLzTMYLDjDdkPetRPKZeWVL3Ye9kS3/rfQkFH?=
 =?us-ascii?Q?Ufd/qzbbc9Ua/+Q2d5K9LsUo3+Lixbqaou4DcIm9DwBKfjbZtXkavtrupXEn?=
 =?us-ascii?Q?9Z7hGOg3Q/L6bO7+PIw7l6EhOr5UjEwqMWcQ/wTaPl27LI6YVAaagU+jwe4f?=
 =?us-ascii?Q?ykliCicroi62goOPCJR4bChuvgmvx+5m9T/n5J1hS5A/SxfAQpZ1KMQpATeI?=
 =?us-ascii?Q?Bm2NswXahk4NDwGSis5Z5eEfjwZ9exeFF4EbmndI3sQx9YvUnpajVrpgm3Kd?=
 =?us-ascii?Q?nqlg46exuVOmFzeTJEOwBM/JdHwg9P4PKZMFALB1kRV07X0l9/W7RT4WuGrx?=
 =?us-ascii?Q?zMBTT3qm0nhvFTyWDbKduZmJHsJ1A8SIZ37j76XubwwHaKLqW17uKMSsf/jH?=
 =?us-ascii?Q?32F2hDfhVr6z7subJoaCx1Acq4W9cy/s9Mvm0AyC4Jpr7/18eZWiAW3SJfjv?=
 =?us-ascii?Q?4GyGG1NHfce+P2AtVAriLxsiZLwmeSDhLSAtQ4SWWXiCQ8nImx9lUKkJnB30?=
 =?us-ascii?Q?Ihh+1ROrOoOhST64zyhwDiXgp+aD/IMoPYeI2UtmTwPl17BAPFq+6Yvydry6?=
 =?us-ascii?Q?ZNeQFG0PY9584EVn/3W9rlJg7nhKrytq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:22.5652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e1ace7-d71e-4cd4-1c61-08dccf15c775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

From: Alejandro Lucero <alucerop@amd.com>

Type2 devices have some Type3 functionalities as optional like an mbox
or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
implements.

Add a new field for keeping device capabilities as discovered during
initialization.

Add same field to cxl_port which for an endpoint will use those
capabilities discovered previously, and which will be initialized when
calling cxl_port_setup_regs for no endpoints.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/port.c |  9 +++++----
 drivers/cxl/core/regs.c | 20 +++++++++++++-------
 drivers/cxl/cxl.h       |  8 +++++---
 drivers/cxl/cxlmem.h    |  2 ++
 drivers/cxl/pci.c       |  9 +++++----
 include/linux/cxl/cxl.h | 30 ++++++++++++++++++++++++++++++
 6 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..39b20ddd0296 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 }
 
 static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
-			       resource_size_t component_reg_phys)
+			       resource_size_t component_reg_phys, u32 *caps)
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
+				   component_reg_phys, &port->capabilities);
 }
 
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
@@ -789,7 +789,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	 * NULL.
 	 */
 	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
-				 component_reg_phys);
+				 component_reg_phys, &dport->port->capabilities);
 	dport->reg_map.host = host;
 	return rc;
 }
@@ -858,6 +858,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 		port->reg_map = cxlds->reg_map;
 		port->reg_map.host = &port->dev;
 		cxlmd->endpoint = port;
+		port->capabilities = cxlds->capabilities;
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e1082e749c69..8b8abcadcb93 100644
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
@@ -36,7 +37,7 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map, u32 *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -84,6 +85,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			*caps |= BIT(CXL_DEV_CAP_HDM);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -91,6 +93,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			*caps |= BIT(CXL_DEV_CAP_RAS);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -117,7 +120,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
  * Probe for device register information and return it in map object.
  */
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
+			   struct cxl_device_reg_map *map, u32 *caps)
 {
 	int cap, cap_count;
 	u64 cap_array;
@@ -146,10 +149,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
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
@@ -157,6 +162,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -421,7 +427,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -431,12 +437,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
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
@@ -455,7 +461,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, u32 *caps)
 {
 	int rc;
 
@@ -463,7 +469,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..07c153aa3d77 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -284,9 +284,9 @@ struct cxl_register_map {
 };
 
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map);
+			      struct cxl_component_reg_map *map, u32 *caps);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map);
+			   struct cxl_device_reg_map *map, u32 *caps);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -300,7 +300,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map, u32 *caps);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
@@ -600,6 +600,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @capabilities: those capabilities as defined in device mapped registers
  */
 struct cxl_port {
 	struct device dev;
@@ -623,6 +624,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	u32 capabilities;
 };
 
 /**
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..37c043100300 100644
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
+	u32 capabilities;
 };
 
 /**
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 742a7b2a1be5..58f325019886 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -503,7 +503,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
+			      struct cxl_register_map *map, u32 *caps)
 {
 	int rc;
 
@@ -520,7 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	if (rc)
 		return rc;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
@@ -827,7 +827,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		cxl_set_dvsec(cxlds, dvsec);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				&cxlds->capabilities);
 	if (rc)
 		return rc;
 
@@ -840,7 +841,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+				&cxlds->reg_map, &cxlds->capabilities);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index e78eefa82123..930b1b9c1d6a 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -12,6 +12,36 @@ enum cxl_resource {
 	CXL_ACCEL_RES_PMEM,
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
+};
+
 struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
 
 void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
-- 
2.17.1


