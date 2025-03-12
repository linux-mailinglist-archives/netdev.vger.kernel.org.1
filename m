Return-Path: <netdev+bounces-174156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BECA5D9F3
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC625176601
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3E23E235;
	Wed, 12 Mar 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ezrKFhcx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE521E3DFC;
	Wed, 12 Mar 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773269; cv=fail; b=i2y+TObGGb4sjYFPEQLb3Ub+oUTTo1vCDNMmose67wrD8bspAPecQI7a5UKxe1HzzL1wUpatFUmDF4BpKQ9a955y9Kvj1Hlp/vLPG7/heRAJwfR4rBHksKd59KtbBPo6ncmTVgWbFn/maX+t8NWmkCaKClBIps3n3/cK3TFyw28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773269; c=relaxed/simple;
	bh=Qf7SII3/mw/vQQSVYf2kkzrmEOXkrftKtLsMcVXa6QE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1bs51+VLV7GdT63U5Oj7UzRRhni4T7+f3b2ab+tZH1p3S2jTHgc+rsDHTxRO0YjYaSAbTn/iOw3d43RTD0nInzY2Rr0P9XXEknB1Xsd9aBtwnfgfyncn4mCIdgr32INHvhP9s7RLFXWn+mVp1gSYcWmjnP8fBklwhwwIJ6e+K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ezrKFhcx; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytSGjIioluyicPzPvfqcemBsUaQaiA9osGpuCoWGqt7fD9PZanfidMciki432t7peA1s8wCTZ1EEV19BMukwrsGIUSNdXRBQ01xy8ebMnBoMUamXeHOERN2x3DmOnPXPR+liC8k6K2mbypJlrOHnzAZuEhDlhO8sP7i5kps/ihoX+a+UTOmPYz7uCRn3Ac8mVWtPwMdjrfe9mvtsN79lFXXbEhVYt8NSfmyaA+K346oRoZSMpz04WtQJ4gfdAIY+V7M9Iesw0S1x8uKH4OMlqM+DT2qKIqDRSa0dlplrOCG415yo4vlPFwX1Bg63UWEJgt70D+be1P/1YSmZ6GoD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf2IWdn4X6HrxMdaqjUD10ceYgbLaD0YleQzQU77vow=;
 b=LxrcmKee+Y5EOlQj8IQcuIPWit/4nh0uKSrAScFsxnd7wnUqOq+jDvqdQ4den/pUF5S2QqTZQmaRM41Txz0BmGXoDgy7bVwto1rXxxfGj6H102on/7s4MyTaJBofClXFjzdylSmH+p2N7HVo0tWMXv/SkOfyAAhlALUG3EJhawC2knC0duw1HJzeKqNlwyEJgu4xDNslmPhtQnkeJgfOBVZbeJ0NeDuLD1YeFigzHPsyxCHmhNY0JdnYmpKVSSNvyTHVclZcNjsMRfON6fI4B631CEQsDu/+1vc/QLl3xh2wvfKEYc6Nnmrxm4F0rJEXqaZmgi8FTDbjO6psyavGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf2IWdn4X6HrxMdaqjUD10ceYgbLaD0YleQzQU77vow=;
 b=ezrKFhcxsar/uNihrIv00NKwE2lOOX4HKKS6uxTUAlHjiEcVHBDv9e65iZNw1ipkGMeD9E09syAFBeFD2LDVsR+onaz7WjwJjOZOirPCCaIEoHEIeSYZLxuz6n2qmXPGMJRUrt92KWuLi1rDPR8NovOfbjFSbjLRZPAfNdqiEfg=
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:54:23 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::6d) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Wed,
 12 Mar 2025 09:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 09:54:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 04:54:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 04:54:20 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Mar 2025 04:54:16 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net-next V2 1/2] dt-bindings: net: xlnx,axi-ethernet: Modify descriptions and phy-mode value to support 2500base-X only configuration
Date: Wed, 12 Mar 2025 15:24:10 +0530
Message-ID: <20250312095411.1392379-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312095411.1392379-1-suraj.gupta2@amd.com>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ad9894-b4ba-452c-6a00-08dd614bdd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q6KDG+CBtNgLfMMdulq7YIqPnisvZ4OMNyA+RHGsp7LFeID+R8FnGobTdNsp?=
 =?us-ascii?Q?pCfOPpR1Pme91M0u3dBW8F59sRUwLZkKNdjOad4VUGFh9qG25pzDoItWr5Ta?=
 =?us-ascii?Q?hQtFCGq3Wbwv+wHZjFW4TpSLlmHvcGSbc9AhdWg/cmdGWWrIXVzuU2O2Umxk?=
 =?us-ascii?Q?bsPZK6CHK8sZXXkyjYRauesYNvYiLEYba0owsU33ongvAk1zOlHBd1GtRaAp?=
 =?us-ascii?Q?UBnKjQSDjr0t5JagHCOSih+EidyCe2V8I92GoL6hwvv+5FVPmZp2j/8MrwI3?=
 =?us-ascii?Q?W9actpJcjqDYnwvBP+J+9y05dof/YE30PbWeSHo7tPZFjqRBbmx/wR6y1Mhx?=
 =?us-ascii?Q?0Jhnf2NheiK6TUze5zq9HanmOJOZUUJvlDz8YpkKply8sjBcTW7poTiQYdcM?=
 =?us-ascii?Q?MqWBoTL2tMdYJPmc1naF9SF8fF5kERciTdanHKcYnS5v6y2ZupugUeZrocmf?=
 =?us-ascii?Q?GDnAT+Emks53WMJNznjE/joXjxnm+Iu6OiD0dQZ6rUbS7cOLwScsWUY4uuNw?=
 =?us-ascii?Q?bT3BN7nxci6dV5Ut4s3ZZJbq0+InKOMmGbNy/cKGNjK4+C8CH7jkk3USGM93?=
 =?us-ascii?Q?4QAe0d7ALVyjeZNSPSf2H/6NU1rBgJaTrZYKrFIqkb/n0C/baBYoBBJ5+8XB?=
 =?us-ascii?Q?JSV+8Z9lVcuBtLYtLD0m7e9fVaedcrgjefQl72iKnhmjN9sjGnoemucsow2a?=
 =?us-ascii?Q?vEpKvGdNzqsRyp52+F4Ju8Do6PO4XbUcMKWwtUo7e89dfv6LH3Y0j6tF53HN?=
 =?us-ascii?Q?x9tvwWrbDsKR/xgRlfK1yWI1B3Qc9trMoGZJsn21AJyjrG1S0MsMoNUyJOez?=
 =?us-ascii?Q?Ll5aMYDxBfbXr5jJhEKQwSgRoyyLGVV4Oze05ewWe0OOs4zyiGWZ8mPy65E+?=
 =?us-ascii?Q?TJOSKXHRIXckFobIeav/YBbrs1+SK29a2vbGyGYDMJTHQ6ImKI4ga2qVeNtq?=
 =?us-ascii?Q?VAS5TOHekZ0Ln3wYh9GO/M9G4OCYs5UhdWyCXcZq/m/ydQKlAg8P8avhVnh6?=
 =?us-ascii?Q?7I4slmnOrPZRKe4RM4nwE7dsQcQYUDc1/R7REh3yOdbmtZXdPOrb1JaPi0eZ?=
 =?us-ascii?Q?Bk9sy+UEYbvvipOZJ4amrY1IWtiUKBVdqTQq4NGDX7GQbpG6eQi6urItjbk8?=
 =?us-ascii?Q?OlbboFrtZYLmnk42hWiK4HmDMvbvTez7zUfW6PFPgkeEP/kzh2fFNm6PUSwS?=
 =?us-ascii?Q?59rmM9duncLzoXo+z37Pt30RXftO/8iBPNIlhZrL12o7LN0I5tkZy7Rrq/X8?=
 =?us-ascii?Q?1pRL1a8aet3T/ZbN6Gcw5ULWlu2YVB6/TiMDyp05BZ0DH8hfurV5fc4C3L0S?=
 =?us-ascii?Q?ca05TOFHfph3MhyylWdZ/yapH0pS04D1oYnpsVxoMszjIoU3UaFLJNUd/LS+?=
 =?us-ascii?Q?pbuN2R/ameqti7gGSJVcSfY+liDjZFaPcgUA9vmaM31BXxKEQkr+37A0qkjq?=
 =?us-ascii?Q?WueQR/tobe1eaC5KiMyN8PWuK0I9iGL7I/nBeq2XQ1UtDbHgFdzrBgAo9NYZ?=
 =?us-ascii?Q?+qvUa8OTWTTJQZU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:54:22.3670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ad9894-b4ba-452c-6a00-08dd614bdd97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036

AXI 1G/2.5G Ethernet subsystem supports 1G and 2.5G speeds. Modify
existing binding description, pcs-handle description and add
2500base-x in phy-mode for 2500base-X only configuration.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 .../devicetree/bindings/net/xlnx,axi-ethernet.yaml       | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index fb02e579463c..977f55b98f31 100644
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
@@ -118,8 +121,8 @@ properties:
     type: object
 
   pcs-handle:
-    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000Base-X
-      modes, where "pcs-handle" should be used to point to the PCS/PMA PHY,
+    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000base-x/
+      2500base-x modes, where "pcs-handle" should be used to point to the PCS/PMA PHY,
       and "phy-handle" should point to an external PHY if exists.
     maxItems: 1
 
-- 
2.25.1


