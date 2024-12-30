Return-Path: <netdev+bounces-154571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA399FEB14
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F5C3A282C
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E982F1993A3;
	Mon, 30 Dec 2024 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j2HVYy9z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486019CD0B;
	Mon, 30 Dec 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595108; cv=fail; b=SJWbtyhFeCjmZ0veWwR1/xmtjGP+o2mJ8iqYwJ6K9ULNO1WHZKZwS7Ap9vpC4VEFA1YlBn7alfS8C0HXVDmCXIAgMrAxi+1rpgYxwrXRpVTaus59Yon/HfpyaUSWpk4r8at5MK2XbO6zc+awwNkXQ0/SAV2RoQfwlg+TlSfCYI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595108; c=relaxed/simple;
	bh=PQK4vmLZjcaYTqVI+bsdC7vMOv+lqDHnkGEE3BxmUW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3RpQjy/ab32GcZ3LN6L80GWbmZiRBHoOMw/KC2RpENdGR+ou0LcwEz7Oac4yEpG5zRQzyKmkghVWPyY+Hx1UCfnqyZFeV5z59ps+8C/rsyLdvzkSCgtYbV4lfAxRHr6vdzwtY879KPhWi6TPujC2fTSLE6qfTRNPfXBjVp58vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j2HVYy9z; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bflolAmhjfIbTvhWnsvkLyz+JCErh099U+uWb5XX7U+1H/hz56KCu9Vxcz5T4ca5ZamIj1a2vx4Nf/pERLlieMI3+/p2fhPcdUQK8DWQgwPt6sT8rVsvqUtL81PoSzlhck47FawfQKZQ5BPhm8gsE8D6/WQg86nw0bu8JigTyVXmeAjNNUhkXou18TjGrhRCTUpaae1ziuxDKdZI0HgjoXlnP3vZ3LMZPr4OIgekbCOusKQHX2K3iXwtfEqskhwzBzigfbL5rGSPgGzhJlOrSz979PVySdmXsFpU9cl/ROfAdpsf6gqbgjkcSbHfPo9llhK8EBF4O2x+RAQ6XimwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhR40bsqX41evV895cjKHVf6fGH/D0Rn3I8npRP76LY=;
 b=DKspJo/70nNN1QJsi558feLbNnr/GCTgZL5FBgaB1yRe39k/DrrLx9slkVG9LYByqI1TMPnH6RgIItWzSCUhGuaZyIqqk370T1lkuCZTLD7Fdwgm65dfAGUB/uLI3cEW6hHrPbLYDCqAw7GVZMIDVWrZb1pA1Uiz0WHL3oPv4JGsI2Lr7PpIFAQiOSsDESA9xkDGxkUEr43/4ha6/l1HLjTo9oPetJ3hXpkjdLNPjkCC5JifbRiAUrzyJbBSvBjmMxFWhLIAZ8n8QJt/aodvOu+K37g17+zteARLGakDMj3BfsIwW7QuNT1YYNdM6bmUlqEiqUA9j7TM8EkH7PFB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhR40bsqX41evV895cjKHVf6fGH/D0Rn3I8npRP76LY=;
 b=j2HVYy9zlXzWMg3Sw7wW6f4oxPO7F2SSIwWQ7dnYrvn5+qa1RSICe4KDyqA+KD2SU+jvklP6r2gGJ3b3gs8hChCZeD/h3AltWgzkTAX/Q2Syt4D79oRpJ68gStYObfbRkWGmB4HhZ+MA+Mz86Vk+a4qq8yfNaj1LZZVO//UffL8=
Received: from BYAPR08CA0035.namprd08.prod.outlook.com (2603:10b6:a03:100::48)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:44:59 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::3d) by BYAPR08CA0035.outlook.office365.com
 (2603:10b6:a03:100::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.17 via Frontend Transport; Mon,
 30 Dec 2024 21:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:44:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:44:58 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:44:57 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 03/27] cxl: add capabilities field to cxl_dev_state and cxl_port
Date: Mon, 30 Dec 2024 21:44:21 +0000
Message-ID: <20241230214445.27602-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: f20a7e5d-f496-451b-7344-08dd291b3559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abY7G2XptjD2VldHRFX6VCUGffiYfSr7dFXvPm5e/2I4rO3gfDLkhI8I407b?=
 =?us-ascii?Q?shqu5fcA4NDAjqUtq+4lkRKkAVSIlts80B/wPhN7C8olu5Ps5cK9EmVmo162?=
 =?us-ascii?Q?T+kLRvHPC+kYVoLuKZuG45PE35buRrM3MnUYNgzeLGdQOWq+p1JmSbF1VFHO?=
 =?us-ascii?Q?j0IszDJEaFYK+ZYFo7WpJOfwFp/MHPKpAiPXziQUj861vpz45ULmiLyKcBBT?=
 =?us-ascii?Q?Nz5nQDONCa2yScD8ZkEVD4QfX72d600CXuqtviFhhMxKHbE1nQJqGBXNOl7D?=
 =?us-ascii?Q?6AL07525BkYfaHfuzIag154lZKH8PNrO1HkEc3yfjLv7VLBxcLLEPz0pijLd?=
 =?us-ascii?Q?g2qF8bLM0P4+HZoeAxyU1/LT1PAG+XmGGJ6DlpL8ITGZKSxRhDZMc9XswHpV?=
 =?us-ascii?Q?AgpT9oioPzbeORD3fWzH7FM96+5kLaCFG3T2MmkDBmvaErqDjGqqoRslDer1?=
 =?us-ascii?Q?nX3ucVFndKVRaMNUXexpWFg6lrzOVFRFWHD3P/7yTyqmOpHGnrmuLV1pqgdX?=
 =?us-ascii?Q?/TAr90mjUezfeKj4mwXze1KofbFbYKLXyn32wiThJ7w+Pi2mVUnwAA6ljmcO?=
 =?us-ascii?Q?2xRDHYunmGcVJKCglRIaaOoi5Zuks+0/G0DdOVLgpWQfgoPyh7B21NQOJavG?=
 =?us-ascii?Q?S0D4HxdHxw4p4MR8YWh0zG7iiGBtuVHtOGAriF18APolO/bCu4QSsJExfFdQ?=
 =?us-ascii?Q?6zduxzpTSgaTo8CFvF8EtInqpf1yyhg/+9GBY/8ihLYG/o7E1m0/X4WnF1Aw?=
 =?us-ascii?Q?Ptsex0pOp0rlZv/yClidpe5OIAYe9Nf5QjllCPOmv5uB7cLEtiMseGuP4omF?=
 =?us-ascii?Q?7O/kUxvqBi+qkTx2co6eIx5S3tIOWK00b/DFRqyp6ptPpiarKIpy153NKkaM?=
 =?us-ascii?Q?0h5VfBJsYyGz2+vT1XFdT4FXEo691qS/RfCImGWG2ps7pbGc3QvLDTaIK57s?=
 =?us-ascii?Q?BwBLHjZBj/rKxfOoMv4PqbsHYdGCqBhQMZ9mu14KpSpjgC0nZkOC8vWzc+5b?=
 =?us-ascii?Q?7964ZMDl+hLHZOV/OTTc1h2/SqwD2dzK2t6Ti+KarvbQuL9BtkWKVKOdz6VG?=
 =?us-ascii?Q?QvhdOA9AFAfqPQBB0j0v34VGMHTCShaN+/uP90zpmDMPQow5X0cGqXOL7vW6?=
 =?us-ascii?Q?IP0B4N7L9G54Bc1HhjhCvrXjTSuRTm4mK33VBZasXVs4FyKvzEKOw+QzJ3RU?=
 =?us-ascii?Q?kCyCMLaW/m5MBsmau5ssQfl7yVLvvpSwcW3RVTbtD95dzHbDuRcwcKn0CWXZ?=
 =?us-ascii?Q?Cx55/pcz8n8R7TojdZmaEb9pSbwznBYg1J1oGgyQqu61BVv+JfADXDfk+xra?=
 =?us-ascii?Q?cRiZw0O0+ayoF9UHLE6/QBjBZXsl54sYp5dsbr8WkXLJpBEUm2QvbfkqqqYN?=
 =?us-ascii?Q?lim4muDjK3Cp52V0nkcRDuW4S+fAyvjcTE1P72FfUoAG94riFTKLl7/hK3LY?=
 =?us-ascii?Q?OA/UyUMwiU5spNnm5DdGq2TU56+ndifqIch8+j3ZJnFyA5FFScOvGCxZMMuN?=
 =?us-ascii?Q?mFfPskyh2r9yMsE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:44:59.0513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f20a7e5d-f496-451b-7344-08dd291b3559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

From: Alejandro Lucero <alucerop@amd.com>

Type2 devices have some Type3 functionalities as optional like an mbox
or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
implements.

Add a new field to cxl_dev_state for keeping device capabilities as
discovered during initialization. Add same field to cxl_port as registers
discovery is also used during port initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/port.c | 11 +++++++----
 drivers/cxl/core/regs.c | 23 ++++++++++++++++-------
 drivers/cxl/cxl.h       |  9 ++++++---
 drivers/cxl/cxlmem.h    |  2 ++
 drivers/cxl/pci.c       | 10 ++++++----
 include/cxl/cxl.h       | 19 +++++++++++++++++++
 6 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..831bc35c2083 100644
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
@@ -851,6 +852,8 @@ static int cxl_port_add(struct cxl_port *port,
 		port->reg_map = cxlds->reg_map;
 		port->reg_map.host = &port->dev;
 		cxlmd->endpoint = port;
+		bitmap_copy(port->capabilities, cxlds->capabilities,
+			    CXL_MAX_CAPS);
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 59cb35b40c7e..144ae9eb6253 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
@@ -29,6 +30,7 @@
  * @dev: Host device of the @base mapping
  * @base: Mapping containing the HDM Decoder Capability Header
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * See CXL 2.0 8.2.4 Component Register Layout and Definition
  * See CXL 2.0 8.2.5.5 CXL Device Register Interface
@@ -36,7 +38,8 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map,
+			      unsigned long *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -84,6 +87,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			set_bit(CXL_DEV_CAP_HDM, caps);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -91,6 +95,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			set_bit(CXL_DEV_CAP_RAS, caps);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -113,11 +118,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
  * @dev: Host device of the @base mapping
  * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * Probe for device register information and return it in map object.
  */
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
+			   struct cxl_device_reg_map *map, unsigned long *caps)
 {
 	int cap, cap_count;
 	u64 cap_array;
@@ -146,10 +152,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
 			rmap = &map->status;
+			set_bit(CXL_DEV_CAP_DEV_STATUS, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
 			rmap = &map->mbox;
+			set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
@@ -157,6 +165,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			set_bit(CXL_DEV_CAP_MEMDEV, caps);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -421,7 +430,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -431,12 +440,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
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
@@ -455,7 +464,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -463,7 +472,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fdac3ddb8635..a662b1b88408 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -4,6 +4,7 @@
 #ifndef __CXL_H__
 #define __CXL_H__
 
+#include <cxl/cxl.h>
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/notifier.h>
@@ -292,9 +293,9 @@ struct cxl_register_map {
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
@@ -308,7 +309,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
@@ -609,6 +610,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @capabilities: those capabilities as defined in device mapped registers
  */
 struct cxl_port {
 	struct device dev;
@@ -632,6 +634,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
 };
 
 /**
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..4c1c53c29544 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -428,6 +428,7 @@ struct cxl_dpa_perf {
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  * @cxl_mbox: CXL mailbox context
+ * @capabilities: those capabilities as defined in device mapped registers
  */
 struct cxl_dev_state {
 	struct device *dev;
@@ -443,6 +444,7 @@ struct cxl_dev_state {
 	u64 serial;
 	enum cxl_devtype type;
 	struct cxl_mailbox cxl_mbox;
+	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
 };
 
 static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 36098e2b4235..dbc1cd9bec09 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -504,7 +504,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
+			      struct cxl_register_map *map,
+			      unsigned long *caps)
 {
 	int rc;
 
@@ -534,7 +535,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		return rc;
 	}
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
@@ -938,7 +939,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxl_set_dvsec(cxlds, dvsec);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
 	if (rc)
 		return rc;
 
@@ -951,7 +953,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+				&cxlds->reg_map, cxlds->capabilities);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index aa4480d49e48..c5e4b6233baa 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -12,6 +12,25 @@ enum cxl_resource {
 	CXL_RES_PMEM,
 };
 
+/* Capabilities as defined for:
+ *
+ *	Component Registers (Table 8-22 CXL 3.1 specification)
+ *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
+ *
+ * and currently being used for kernel CXL support.
+ */
+
+enum cxl_dev_cap {
+	/* capabilities from Component Registers */
+	CXL_DEV_CAP_RAS,
+	CXL_DEV_CAP_HDM,
+	/* capabilities from Device Registers */
+	CXL_DEV_CAP_DEV_STATUS,
+	CXL_DEV_CAP_MAILBOX_PRIMARY,
+	CXL_DEV_CAP_MEMDEV,
+	CXL_MAX_CAPS = 64
+};
+
 struct cxl_dev_state;
 struct device;
 
-- 
2.17.1


