Return-Path: <netdev+bounces-152280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76B9F3578
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C8167EB4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF71531C2;
	Mon, 16 Dec 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JaenAhkE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BC14AD1A;
	Mon, 16 Dec 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365465; cv=fail; b=TLIoLih/KpAMR7EuFBHxAsIeICIDECoELE6hLx9SoWZ4fZZmPoflKonURpR4LmMr0TQMSwRIBh01OL5l6FECseLgTtLlBeWljm+ul0xkBSF9xhTyKkLj3Ba9Hy/SgbXHuaL1T+peQdbdq8uWQxFRFhpDZ5Roabr42PeEIR1Qrmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365465; c=relaxed/simple;
	bh=b+ncon31KBDEWMYBEYf5OcsNxwmQNf/HzjYVw6IXrkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5XoDmbrdU69wAMD+OwKL4kOL8en0RHo6pwVPbFZQ+83xQSNoC1Xbp+sakedZiJgJ6wTbBcR2Jk2XYcE7hfBOUtjWstRMPsxRHVbj1U0wgnpdPs3wENcFEpcVcNZIsL409aWYBNw4OCkhAQ5EIDRdgQWHhJ03tVXQwO/hY58G2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JaenAhkE; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFpuprK5PQhILgqM8MCiDyMXB+y8E0fgoeUbEihkC6ohjgbyAtuGZCppy+qvjql8R9AuEF6s4jQGtlnoggBQ/Gh6auZgo7qEuO2ZTSEzpYCvFelUDHWLv4an2d0gbliynXICseOQDsRF2TehdAjUHSRyOt/XtlnPZRF3GazPu415RxD9fCwSXyUbTWRQkxXgKU1x8KzCFvOu3+Cb/UZn7oGx79gRhWGP3EIA5ZBr6k60E/dZexqy3zdbPRGQSgEoUtIDcK77QzPTAyfY8Btz34HwfwRkHl+HVVYUgaBOaV+h/Gpe01QtQE4XOjHZGMa3otCACDCGOP/p5gY+0yM/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2oxNpdxZhAP5K1DpAtLmwgbbi5d2tLbdxpKdyzAZj4=;
 b=ilpxaY2vgifTwAaeHwPpbsjKJ6VisAzu3oVT5Rt1Iimtm35D5v6E5cWvyGTU4ftLtyoY3tGhZn2pnvshvLL8XesZ/A9H8BHgLF+0C3tynCWtmzTa+yAnnRHIGpJLyoiafk9udSXwehvyO8sny4MLY7lyrlcSKIMJiuBzRnMQcrdZkWGVczRSXju6lAXV2ywU8Bo7VFaU1zBnPpO6U/6eug0Hk4RtqepwtcpZdaJ/dGvB1GKILKFoBFhE7r/WTkp8yx6sdjtLmKvzjwtsboLls3HGeSuV3Ys0q9XJwfQRtb0ftNt4ITOlcpZ8iRAMIrKJ8BPfgM7NEMedHOaYxRyjaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2oxNpdxZhAP5K1DpAtLmwgbbi5d2tLbdxpKdyzAZj4=;
 b=JaenAhkEXct9v5TrO4SGmNeiSi2ye+Fx4Z4kGNC7LNMu7bANUIEhYB6tWPdCaCCGAZ5G52wYFtp+yLAHotjFzcmvPs6BuqAbsAoBIqoluqhilhtDD/VfqGyiZQUupNwxY/okz2TIWXz9dilMJ3QPYbJ+tPgK3X29+TKYGj8WkDo=
Received: from CH0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:610:b1::8)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:10:57 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::4a) by CH0PR13CA0003.outlook.office365.com
 (2603:10b6:610:b1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:10:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:56 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:10:54 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 03/27] cxl: add capabilities field to cxl_dev_state and cxl_port
Date: Mon, 16 Dec 2024 16:10:18 +0000
Message-ID: <20241216161042.42108-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea4bbe2-2051-425f-e5df-08dd1dec398a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NpFIawE3h8T2UESIl8572sR/GwEHGgjdi2juQi3bOO5lhp0dprxU5rDU3M1n?=
 =?us-ascii?Q?tXE8YF+b2WSfTruhw0p4wXV2mQ2kJu8xfGFC/IVfdaaDH1PyKWG21tdytfmI?=
 =?us-ascii?Q?2Eaj/4YYugtBe957+G5viUnK9HdGKX1Phwns2nLhjwf1maifH/EFbJqzmod7?=
 =?us-ascii?Q?gJb8WVZ6rA40zmz1u5r0Lm16sBVIoZJfOycEqOjDDr/gEEtP+aPRmui1xaLW?=
 =?us-ascii?Q?iWEO5TVB2UBuHBPghQUWA+dnG+pTk/RbJebI1YC6aSbajmMAmJaDDqUl0Awy?=
 =?us-ascii?Q?30PkdemfIKPYv483NSUyU1QH3dp8kcmG0ENjv9wcjXWgKyEFIWrtr+gxuVer?=
 =?us-ascii?Q?FEfZDwrohgWnHN0tocToS+xtfzi3JNdXsBX2z2ZiEKWkq/OzKl3KFBVVh+RA?=
 =?us-ascii?Q?2sTP1MUfoLH9qLUGcvVX9m2NBoNWSBFYRDzkZeUuEqtO30kQV4Tqwz5k87Nw?=
 =?us-ascii?Q?lsfOKVixKhyG0QKspSDnpC9OTdEw8PYqDgaJRGL4cpN39O8E50O5AS9FBC3D?=
 =?us-ascii?Q?7oz0Qc6Xqhhtict0yduCj1KjYW8xGspD+mP/cFIRvQIEM7SGbpEji7s1CsgI?=
 =?us-ascii?Q?ejSoIjsZV6T3gCaI97Ypz2wjq0X/Aaf0gyONbHo4AFuK7XKfnm5KUh0Ou1rg?=
 =?us-ascii?Q?TQIaj6oGi8MyvE3QBnLRBzacuVw7T9UfKi6VCf0Q3v0SlcSr1vEWhIhGQOCV?=
 =?us-ascii?Q?ncSLJXnpJqIVUp0ac2caVMsMqFfA9YTJN0fqMp5Essxrwya76hxhVt7nTQw7?=
 =?us-ascii?Q?3xHqhR/Q3Fqdoqayw1bR2O5PbCjOvkzlEn4JDRWh8pHuYuBa2Au5NWXBNm9B?=
 =?us-ascii?Q?n4Mdf1p4v1E/H7HZgE+0ojZovJrPRJ2k4EHUMSC77cIAqpG9SqBBeI8ySiMu?=
 =?us-ascii?Q?nF+fmS7OXwwVyKgy2CDVMUTsMjafTKY9OM88vtK9EAsJO1vjCh9wqFcyrBiE?=
 =?us-ascii?Q?+448IoFik2W+TMw0ArEg77ChjwzdQ9/pe8BhKROEKY3aIHgYXUUHNeGBcWQ+?=
 =?us-ascii?Q?O2NEKCW56+Xu5lrZznYKGk/mjXLEn7iJTdjnYRY3u+EVhAi8dfFIsLGltETv?=
 =?us-ascii?Q?vFTiGujD4K4NMqlQq617CGmxPIVwQW5Udux4BWZDRRUpYde1lpthLtHihlFN?=
 =?us-ascii?Q?qjsYIIKbSKH9ofdTLUcvtNSijTZ9sDdlKKPUoezfuZYUNq2ebDgHQJV04IpK?=
 =?us-ascii?Q?Aac6V9ODaM3joBX5fV+ElcuIM5zE8cdzCugJ+znERgud+fsqZCQECPVQNN8k?=
 =?us-ascii?Q?WWanSDVHIftfgQP95yPvVt7V7g/iWuYzmbtNw278bYO1CoIqcW/SEr3pelNH?=
 =?us-ascii?Q?LBZHBskHMm1aqQIV/xnjxZ5/FgSM8POgNsyilQW3GvBZ8nt5LgvztM1Rg+xY?=
 =?us-ascii?Q?S062abHpRHG93090CJWgzQFXKoY1/lZcZzOWbOyG2IoCSGLta9uDytEX1CTv?=
 =?us-ascii?Q?yjoWCU2+aMIdkqxYQFS1p57tvgD2NacHE4wuekKNEZvAdcHZANoSktTPigUH?=
 =?us-ascii?Q?egbb6trsM3oYLY6QdQnYNTlgkA/fCAeivqQc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:10:57.0432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea4bbe2-2051-425f-e5df-08dd1dec398a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

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
index 59cb35b40c7e..ac3a27c6e442 100644
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
+			*caps |= BIT(CXL_DEV_CAP_HDM);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -91,6 +95,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			*caps |= BIT(CXL_DEV_CAP_RAS);
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
+			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
 			rmap = &map->mbox;
+			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
@@ -157,6 +165,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
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
index f6015f24ad38..22e787748d79 100644
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
index 19e5d883557a..f656fcd4945f 100644
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
 struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
 
 void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
-- 
2.17.1


