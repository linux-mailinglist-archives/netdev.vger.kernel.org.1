Return-Path: <netdev+bounces-150336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD679E9E88
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD8C281D2A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD419AA72;
	Mon,  9 Dec 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tnlAWU9g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B2199244;
	Mon,  9 Dec 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770492; cv=fail; b=Al0YHxCm/gXwbphNQvC4nJRCvrYZFCtH79bDdN5PbmaCGYFCbmUuMoxpCD2eUTZqFkSupKg2mS60h8PMUD2NbsoH1DZYpCGkaMk7MzYMkl2Cg07EnsHG9vkUS9gSSoV2SG/g5bz/QClbwKPmGSgfVXQ13udScSZ3nHxUQJv5Bi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770492; c=relaxed/simple;
	bh=b+ncon31KBDEWMYBEYf5OcsNxwmQNf/HzjYVw6IXrkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkzhk4p9GnAcbgTokh4uegHyDgLdWLMBbd87rtrcEekhm/UkZ+2rykC2v0Qj6uU+65VZLRrDYNthzA6CFa+VCd6gCizcOTonCrT1shJZQgAEoceqKEFWWCLliTiU94O+4x0/Wwirxyd3IjLkJ58J1fNKlxv8IeV697Rmgrut5dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tnlAWU9g; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=splvsmMASPBnTpGLOorBfSp57+1PdIMHI6DM/16OA9bN1f5cbUU+zXs/30fr8DKM9AQYcvJN/EihrQzwfpjGIpJ+J2tmzjkdZfbmm7J5vKY9HktziCAAf2u02xl+iYVIjqxwbJ7I3QyrsbFFYr/wPdaYzpZcVcWBEPq6ODOIQrDPqr5OdLpLUnDxRkpKnAbJmT/bcsNv26Dhoq2nexVSghSFTgS6xGBGCdSMglTcxwvNnfxZQC0h/DvgIRfB3cvR2DLZeAAOv2mJpXi6h4G/zbYYii8L0R3K9Q3rwE3R6w5I7OSfVEyN7j6RJ47H80nmrz8/E96a3cQw8gWBKaMwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2oxNpdxZhAP5K1DpAtLmwgbbi5d2tLbdxpKdyzAZj4=;
 b=h9CYWAFFCGurZg8wQEqllIhhoUC57rZe/hKKrA2099hRB1rs79Mut+IUYSkiax0z52ssbNPlEc5klYsZJ/nHrMvA2r9CSWXJWBfl0yys2B19B2PM7b3FJT5x7oVLKBBt7jbZ4GsFzHyZIoJruJ+n3sSSHW8qVzPgDLuw/hV3/oI25P8+4zUNl7qAYQ9jmwvlZLuUwtZgUM1TG3dfbVM5P+yyxTzx/PZ8j0QPRjsN0/+pCDqP9qbagEbhVjpr3iM/DpBjlYoEVXcPgY7oUCUmry19RLq7+04MLzm/jb1D3tHL8p4IkvkuAvhSlb4ewk1PvGSnsVaSEZG9ag6l2uCfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2oxNpdxZhAP5K1DpAtLmwgbbi5d2tLbdxpKdyzAZj4=;
 b=tnlAWU9grYpV43vSvpUrUFWs7NrWKDAct/jqPA5bOgT0rSLX3YJhHSyoyONT1WB9+VcbZD22MOjFfNpiuuSLzE4pZLb9ys3m5KJtf+7lK9evvFlBwfOiuYP24L6F5pEI4+MH/PHLdY3d2896YRPG/NrHd9fJDeV3ipmVah5NYkM=
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 18:54:43 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::e6) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Mon,
 9 Dec 2024 18:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:42 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:41 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 03/28] cxl: add capabilities field to cxl_dev_state and cxl_port
Date: Mon, 9 Dec 2024 18:54:04 +0000
Message-ID: <20241209185429.54054-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e6580e-6443-48b2-9ef6-08dd1882f184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0VbTaf9xRJSqBpYNgSAH7hMTa8CMfTl+4Ui8tK8osWyDHTsnNCnsxAKeBEYk?=
 =?us-ascii?Q?mTGXRrGAcLsOMpTM5/PmZxn6lHVIt2J+Pjp2sXwrpTMdGhqg/7v4gxmeSx9y?=
 =?us-ascii?Q?8ariJDUqWVIyM5pIBy45LcX1ZZgH+E+YNqTmokuhHYhIpRXdSH5A+PAD3ZP0?=
 =?us-ascii?Q?9wJOd3HQJ3tRvgBo49koLyGyywilZRzigf4VT4GgBXsWc0izLj62vKmz8yE7?=
 =?us-ascii?Q?FvAi1gzg7z7HtNQTtLZeAYqDTlLl0GZt1B06/1wT1hr5/McUBu7ApXgox3Wg?=
 =?us-ascii?Q?nzEPTvAL8O3xvALkwFkJNbW+Zpf2aH5/y570jaO2lvvz2olQ1Yf3YN0VqG/n?=
 =?us-ascii?Q?9UGvojl/ut2XT2Fd6fjf5RJ5fsmiy9OWOoOe3C+Q4osUtMUqXnfzgj0DieEr?=
 =?us-ascii?Q?qXhT0IX4a2kZtO34FIDa0MwQ1e/5o5vpu400Y0CQ2vDNCI+p9XK63SKwGxlE?=
 =?us-ascii?Q?7Wl1cgYn5OeLAngar7FszjY927lkRbzl7WmWxI3UMDgeRU9ahDTATqjWLUKg?=
 =?us-ascii?Q?X0SJGpzou2TdFsvuVhcYVvh1yUr8Uc6YSTWZALKeiebD7I/IhEl2cmTNe23z?=
 =?us-ascii?Q?fiVfQFAQ2OloQRno/hxAzBxIqEcOthwgP5XT38azIbb3HTdLoAZF6/o7QmSO?=
 =?us-ascii?Q?t8W47OOmkcIGf1mcVgidOtAGzesyz1i+xHz1MnZJ97Jlks4YjzyUYmu83L3h?=
 =?us-ascii?Q?XR3O8XYfR/oCoeIL/XOSNsGb9+glmFDreV3SSuZ6wDH76J++r+CbIvmgtH+i?=
 =?us-ascii?Q?Nem/SJB2GgQ/9/JQ82mfvQFGD1t4qFgs9JJsSChcjmal2oflQJUet/t6TXnG?=
 =?us-ascii?Q?BEsiqhpIzIbqB6Q0PtZv+UGjFNgi+J0HEqX4L2UvugG1DPUy4FKTxidsoHIL?=
 =?us-ascii?Q?VTW1c5+KgO7ycHDrZuWTx7eVxA99iac1LpgotJVAtbCRtDKs+toK8R4X/XhU?=
 =?us-ascii?Q?FrTgHLeiprw2+jW4OxKXVgXVLz2NEDmzx4np/Qc04VGSU6DhdHO8A7CYSYHQ?=
 =?us-ascii?Q?yqL4Gh8sdoPQQEjDCMZT5eZuCr3ol1oQaANJMquyW1bzG/zayw/ve+NHGEt7?=
 =?us-ascii?Q?ttrqKoN8MCkGxe83A/6tCgwUv5dXnmXyzKoEtBKq1uhjAw+9GyQ8E/cfOgx7?=
 =?us-ascii?Q?cAZiaMfLrE1Ppy9pQTj5CMGS+cRbG2C1XLetR0Z4skh1+2KdhcJ2Wx+qGNU5?=
 =?us-ascii?Q?cMy78mp5/aULX3lBJuiDFVihwew8l3mqCmZ5DWfvvyAAiDn4ftzg8WwwPMpB?=
 =?us-ascii?Q?ikAfP3XwtMt95IB/kyqh4TEysn3yNXhTTLcQbzLFzMDl7bPsoKYJq1ZNLJT9?=
 =?us-ascii?Q?B1gHywwLw3+ZoFuun0dmBEvXZrN31JigWbHS9mAwouecUMzU3qbr7rjljnZ0?=
 =?us-ascii?Q?AQHLR8fBnis0VA2v0/02a1ccyNM1EhxGsSTmriacg3bLo6ERBTht2lp8DPPj?=
 =?us-ascii?Q?Iue0DvF/UlG1LcVo2yoXkix8u3NrR5vjDwxxYCpNhxNPb7+ZT6vjAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:43.2668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e6580e-6443-48b2-9ef6-08dd1882f184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273

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


