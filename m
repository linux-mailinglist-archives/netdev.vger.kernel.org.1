Return-Path: <netdev+bounces-145763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD819D0ABA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E64B2193D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EFE14F9F4;
	Mon, 18 Nov 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tcZLGEj8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729F13D518;
	Mon, 18 Nov 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917923; cv=fail; b=qPnSx8aXZ4tTm3T3gG3Xv5gCndvCaRPLLBghFzFysudFq2e8OzZS3M6diYW1bLn/YwfB8maNiapUjyB8vFE/5jreKnJm7CWI0uT/b6fl6fSQoBlfsWMWJ/b4Ig7+66JeHRvVC3nmStVatmn07iwNwk1ZMh8sbLt6zgyRuwvoUQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917923; c=relaxed/simple;
	bh=wNnzCOpoVmv9HIR2WTdZQID8z9/KgyydyOPMOKdf7z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfEO+NSr+BmGrF0hCxkrMDuByY/NEi6yzuD7eNHWXu9t+rWnTj8EkO+4JYqRNF6gZVYfjCr3hRwmXlp1XTkuRY0uHKeZ6EiCPUooJN1bbgJEmyM3YbZoJ6Vy5UUbfWCIWg0qjGY6NM4yz+Hqsg2WagWgUDrrBpriqNhwOotkCrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tcZLGEj8; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEYTi9ZbhzsDs+hZBClyF7Ephg7xYNiMf/h1dytqL1PEmhZZM2InCFZFQAn3BnZpKSe4a7r5r6TlvpwOEbo0q2HdEMY7uDSVpl4lrLLrAaAstqQXqw72RodHKSTUBhyHluO9iUywXItg5OSLBs38wuDhiO4Jfk0vjczzhh0ceHMIGhcEzLOV/YV9cdLgSkTu2ocH22Nm0brzV1720LiWhch/boCQrxN3uIgIvLvpEwmoM5aYHufSwUkETmfgmaij4ktzL38V6SA6FSqoDs4M89YABq3b0xJE6680oGFdTAkmllgIIJiSW+8VuZhtKjOs8gBjjRTAawSloc7ug3FgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMdGsiYuOlEb0IJtXA3t9I03AQf7+ILNVHVjfPUi51w=;
 b=fd3QxVfzjYCmA/ykR8pgKWn8MQk/Foiv3p9q3MCMGBEMG93w49k8H4nbnXJv1LqmcmkoOt23+q1V6SDDkZec6f+OwYqblahhDYG9XSsatiZ+m6yLnA5IERmuvb3PzS7zywHjSbJYoLG5+FmI7H4MGyPrSMRxYayRuBTrZztMDJC/fOINuylr0TwIy39IFUEo9eDJG+92IBaffw1gknMXcswOYQARGJGjjliSfpI6B4twrDQUOcKofkxiILGQOSkq3tFiS+cHfIk679fPEiGFbIl/PN/sEeHv9wKSy1YVtxXG/v9AuFm42oHW1RHkfPqy8ZgCioFiepckzd6zoGwqUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMdGsiYuOlEb0IJtXA3t9I03AQf7+ILNVHVjfPUi51w=;
 b=tcZLGEj8mgHyfrQPA/a/LJLd5Q/WutZjNptN5E8a1mXS8CucZr7ZA69Vi8n2XB9Q7c86XTdJHdwHGTyW/2IMMQqTafjdGPmlN8UJdgd02W+h1x6WwCwth1prv7L2LbB+z+mpRLgG7NKrDlWe20gsgHWqwfjbFPMHrTVVqYJwslk=
Received: from CH5P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::12)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 08:18:36 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::67) by CH5P222CA0020.outlook.office365.com
 (2603:10b6:610:1ee::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 08:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 08:18:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 02:18:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 02:18:30 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 02:18:27 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Add bindings for AXI 2.5G MAC
Date: Mon, 18 Nov 2024 13:48:21 +0530
Message-ID: <20241118081822.19383-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118081822.19383-1-suraj.gupta2@amd.com>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9e3946-b2c2-4ddb-c370-08dd07a99952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RVuHH0wKIgE0CIfdDkV6Ufki9A0MdAjpigv1hm7YJBW/3I1UVRs1y6dTSkTU?=
 =?us-ascii?Q?pJE2sGTxqTSAp3ow6ozEtYhkOojnh0mSVP3n9qB84Vt4wdBjzhgI9gi5xTjv?=
 =?us-ascii?Q?SC8c629W8uPTPb0TTKgNSQbZ/9EE3YubkaY00uo/XbLG0jEdZZDsJnyHi/wu?=
 =?us-ascii?Q?MPODvv2O0Dvi22DXcqUEcxiNE+QqM5YrQHhNAxBzLQg7toqBbRwCzFf14IPj?=
 =?us-ascii?Q?1VDMFXuy1kMG9hj8sAqvAdTY2UTzbgYlgSmibTzFGEXeOPmpVWI2PawJr+gX?=
 =?us-ascii?Q?y5YTG2/7SVotLHay3FdUPDasWLArQcEl2pGNdIncXBPMjSHd1OlHHYr7mBdt?=
 =?us-ascii?Q?jF4HXJ5InseLYaGdy9xI1GLTWvwX/XLCx8ZOWJQrTczwJnUUW8EhxBo4+bb9?=
 =?us-ascii?Q?0gtV8MN3GxomFlBf68sTDj6mlvLea/8IbSbeYVjlSU+KstXFJMHIvPgwIvK3?=
 =?us-ascii?Q?F9ypHwM5CINIiZgosRuZCLpTua1qa16NjsQnPbygPy6AhI0bgDtGR8Vx08Gk?=
 =?us-ascii?Q?ugBvxOjk1TzkUSW0EusFCkoIvCwkt+ANqjvw4fbQpOgvelJRFyEY66u3jVm4?=
 =?us-ascii?Q?u9Do87Nkizf3X1Ju/0NXfx+WwO9XHzYEIqLMUm1tB97s+10Yk+MhuXLPdsMT?=
 =?us-ascii?Q?ry77iWk3908VQTA3tOP+y9JmrjisEiqitH2RJyhkQ4Oxo+Wp8PyWtSwlUZlk?=
 =?us-ascii?Q?fJqCUWHIHaMpf9SiqFstz2d5kZuzl9El/pC4HpMhA4/dXwXL6mxdXV4hWbO9?=
 =?us-ascii?Q?iZqcls3q1DwqUuX1kWSw3Fki3q6SqPerKxjBJICwoMOwfTqdsUmryLppz7UJ?=
 =?us-ascii?Q?GnyqSjU3rixsrMCVjvNSYYklSXKWQySaC/GfU+/zkeeT56/PNsoO0/iCzI8m?=
 =?us-ascii?Q?Z+lSsO0s6mgAhvkEpbv5ciimgk+Ud62WHYrBlSBRov/xHGkvUzpHyYsz7v01?=
 =?us-ascii?Q?3MoTIXuqvpFS4UgRhGjixeTuBrrrTp+yONU5AfEs13OTyxhWkkOj4mYLKh6g?=
 =?us-ascii?Q?P5GpxKJgyLtafv1OCe2XV3daDpn2oCS/tLxfPQijp/Ca8xpGdtC2Zk5iTwzk?=
 =?us-ascii?Q?g9z0DUC/whj3IxdMsRGmUGLEbJrLh2Va4qTYIoYhigeDzvMkwFGNJfPdBsPo?=
 =?us-ascii?Q?7LixQnTjUA/bC5PwUv94yi5HvwzXaLtZDU1n7ow1yo+q7en9fFrRCXXF7Qic?=
 =?us-ascii?Q?ugDK3baiZ1b75SUJB9bRQFExeDC2ZHo/qvyCJqquDph+ks4dyhjpIx9ucyTV?=
 =?us-ascii?Q?COSfcmNFZht34E4xvkod7o77WB9ODhDX8mtcNvRQztBZaPd5IZGVtIIDnT0+?=
 =?us-ascii?Q?teswg9SUaxoLvhR7uVm9DHCFQN1+/hx11YJUpI8pnEU+CrV6iU8s9rpL/qOU?=
 =?us-ascii?Q?Whk33qWjJAjX83PQHhK5BX6GYQYEqz3xrk2K4UVTZYqMyAQjag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:18:35.8902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9e3946-b2c2-4ddb-c370-08dd07a99952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

AXI 1G/2.5G Ethernet subsystem supports 1G and 2.5G speeds. "max-speed"
property is used to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
max-speed is made a required property, and it breaks DT ABI but driver
implementation ensures backward compatibility and assumes 1G when this
property is absent.
Modify existing bindings description for 2.5G MAC.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 .../bindings/net/xlnx,axi-ethernet.yaml       | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index fb02e579463c..69e84e2e2b63 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -9,10 +9,12 @@ title: AXI 1G/2.5G Ethernet Subsystem
 description: |
   Also called  AXI 1G/2.5G Ethernet Subsystem, the xilinx axi ethernet IP core
   provides connectivity to an external ethernet PHY supporting different
-  interfaces: MII, GMII, RGMII, SGMII, 1000BaseX. It also includes two
+  interfaces: MII, GMII, RGMII, SGMII, 1000BaseX and 2500BaseX. It also includes two
   segments of memory for buffering TX and RX, as well as the capability of
   offloading TX/RX checksum calculation off the processor.
 
+  AXI 2.5G MAC is incremental speed upgrade of AXI 1G and supports 2.5G speed.
+
   Management configuration is done through the AXI interface, while payload is
   sent and received through means of an AXI DMA controller. This driver
   includes the DMA driver code, so this driver is incompatible with AXI DMA
@@ -62,6 +64,7 @@ properties:
       - rgmii
       - sgmii
       - 1000base-x
+      - 2500base-x
 
   xlnx,phy-type:
     description:
@@ -118,9 +121,9 @@ properties:
     type: object
 
   pcs-handle:
-    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000Base-X
-      modes, where "pcs-handle" should be used to point to the PCS/PMA PHY,
-      and "phy-handle" should point to an external PHY if exists.
+    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000base-x/
+      2500base-x modes, where "pcs-handle" should be used to point to the
+      PCS/PMA PHY, and "phy-handle" should point to an external PHY if exists.
     maxItems: 1
 
   dmas:
@@ -137,12 +140,17 @@ properties:
     minItems: 2
     maxItems: 32
 
+  max-speed:
+    description:
+      Indicates max MAC rate. 1G and 2.5G MACs of AXI 1G/2.5G IP are distinguished using it.
+
 required:
   - compatible
   - interrupts
   - reg
   - xlnx,rxmem
   - phy-handle
+  - max-speed
 
 allOf:
   - $ref: /schemas/net/ethernet-controller.yaml#
@@ -164,6 +172,7 @@ examples:
         xlnx,rxmem = <0x800>;
         xlnx,txcsum = <0x2>;
         phy-handle = <&phy0>;
+        max-speed = <1000>;
 
         mdio {
             #address-cells = <1>;
@@ -188,6 +197,7 @@ examples:
         xlnx,txcsum = <0x2>;
         phy-handle = <&phy1>;
         axistream-connected = <&dma>;
+        max-speed = <1000>;
 
         mdio {
             #address-cells = <1>;
@@ -198,3 +208,29 @@ examples:
             };
         };
     };
+
+# AXI 2.5G MAC
+  - |
+    axi_ethernet_eth2: ethernet@a4000000 {
+        compatible = "xlnx,axi-ethernet-1.00.a";
+        interrupts = <0>;
+        clock-names = "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
+        clocks = <&axi_clk>, <&axi_clk>, <&pl_enet_ref_clk>, <&mgt_clk>;
+        phy-mode = "2500base-x";
+        reg = <0x40000000 0x40000>;
+        xlnx,rxcsum = <0x2>;
+        xlnx,rxmem = <0x800>;
+        xlnx,txcsum = <0x2>;
+        phy-handle = <&phy1>;
+        axistream-connected = <&dma>;
+        max-speed = <2500>;
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            phy2: ethernet-phy@1 {
+                device_type = "ethernet-phy";
+                reg = <1>;
+            };
+        };
+    };
-- 
2.25.1


