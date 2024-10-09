Return-Path: <netdev+bounces-133806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B409971A5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E601F29989
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59291D356C;
	Wed,  9 Oct 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Mg1zqKT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A31AD3E0;
	Wed,  9 Oct 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491328; cv=fail; b=UXTGofJAFsn6n3Q9j6h/09Zbv8ppezV0QflL3NNrkxoHFwOhTsm8CIlCKwafgzji+mFLTiRNfsSCpSA9R4el/uDaultAxtf0QZlPf4MXoGw/2Mbs3l/EGBzThzTvotTRqnBm2kxh8DbLnzY+fRO390MaGKXnQbnIR8dA7CsaS14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491328; c=relaxed/simple;
	bh=2rhHf69beSXJDYBg5dOIfrOus36z/Wt0ZuQjojzCLGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTmFV/8FBpejhUs4WWp8BYXg5U9F1NuwA7FSokO93/D5cVn7Ae00dY+ZMFKxmtacFGCbKm6O77JbczywWcIF9sV4wVynA2HnMRWnQU6bf8tRKzUyAE3DqlT+rGFXs3P9QMAyNVJejKUAOjbeCYBWbGwOpsCnSq0CKoJjs1olpck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Mg1zqKT; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCDZYe8dDB+ZZBl5aoWLrkzc/4mZa/I3WE/08iMZpx1xsa4yQbFXXDHmMWtHtQgsFPcVyGGDAv1p2MGHfIzOsp7VKm2X7i/p1Qy5XiuSSC6WUoMpzsXwL3EtKvWSok7pC4oPifL68pVJoV5ZSlOzTlFiWN+ouzru9L1gscXbfqQBjk6u597BUkJeXVQj+1z2UZwMEiLc8BO5p1rIWsnIgbgCcurgxV6/lv/SY1zUXS0BWpOGOYPSnFULDGbsJIlyeagbtsMylVxS5ElGkbF7S4xG+qUvhvT+PDrYSqdG5cxRUnEXdNyK5LwLhxiCaOMfzKEPV9Aj9/nUrwpkT2DCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkiELzrJ0JFr0cg2Z5GT/WSW2AaA7Dh22q/++dvO1z4=;
 b=MsfRyMiznSxQJEins3R5py5KaKkezMScH9yzI1EUvKrkwflcFZf/n6wR1NqNvK4FSQLAjpWiaoCGpF70p+StLMc9BUxk6zlNJ72BwAm3dxvS7yYHyDUgjdwuQt+48bKMEODxunrhdUxqahAre11LJqlRS6CIIAdmuagtETb8DQWd/RaO+89PBNtfsVikdwG9fpMdPeNDAcmG6AWmihWwExQM5/FuujB70CoD+iVzcWBJP2bBBfL5sk3u9kMF0MlfNKJkjSIAmGF4vUlJkeJamzilfwHEt0xY2d4T7S8/BYcYxbuQ/JiIAsCXjbsbyUBSqUPF62a5pK/2kQfaToGW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkiELzrJ0JFr0cg2Z5GT/WSW2AaA7Dh22q/++dvO1z4=;
 b=4Mg1zqKTXEMIO3aacEDZ9GIDpADVBJrJZ43ejjjtEtv9sVSE1tet6hyluq4YSvqH6LD4gMXpwq09nVjNOjHxSGZy+HqxML7SuOQK5sqzQeJPndSGnI9tq7PZopzSgpiAcF1MtTLemfUe8N9EaMzJlbZrtWGcesTvoiecVeD7q7w=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:28:38 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::9c) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:28:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 11:28:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 11:28:36 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 11:28:32 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Abin Joseph <abin.joseph@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v3 1/3] dt-bindings: net: emaclite: Add clock support
Date: Wed, 9 Oct 2024 21:58:21 +0530
Message-ID: <1728491303-1456171-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 15df0581-d290-47b7-f6e2-08dce87f6dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TvIHOZ/jpvFtb+Y9yfFXpdziocdOq/sek4Vc0mjAJXwW7RABvbUdYCQWZOIC?=
 =?us-ascii?Q?RJRN6b0yBVJMxLecckfBWj8umQCgcP9UgYX7ENsObuWnpFz+snKlsmQiEyGe?=
 =?us-ascii?Q?IjoyYUOZ2mWnfhHiWSalC87TNsQzDSbX/mOWOAXK4Kj45WsNebJjfhNtTxbw?=
 =?us-ascii?Q?srTBscA6tMSGXP7cOTiMPsWIv+HWWCdxIpefVVr3C4Pd/ve6bGYhuJBszxHu?=
 =?us-ascii?Q?sHqngAtZZC4RkVd10Czg1EEP/tVTSVEyb+DBgedzWDYt0ThXTcfv9hPv39aV?=
 =?us-ascii?Q?irTqEHew6efKU1Uys99yGs4UQlQDA4KBl3Ylyr5R9n0BHA9gwx7mTsC0+9uA?=
 =?us-ascii?Q?6NKyB8UPl7ut/EGNeI+T+NN39od+rSP0otRpZGKv3vy7ar/S4A0OqkGKhas/?=
 =?us-ascii?Q?7UMFzzE8RXMD+VN7C8NNtcHBCUIbCL76eVySliB/x15xvuV+ESSAVANWMeJH?=
 =?us-ascii?Q?TxirxQbbhQDak1kWAdHjLJZiwc+auhliMIfohp+Va4gI/OhitbfK52zjCoMN?=
 =?us-ascii?Q?UIaDEww/B0E5sdDFQR1CMIBm6yao53NSFgnpBdYk0r5AnTNN+2OJXuoEKZjN?=
 =?us-ascii?Q?GljJCuM4aSVviCkQDw73ikixVYdH8HuclvBVm7HuFViwA12vUlzp+NTyogKR?=
 =?us-ascii?Q?MKiiCnJ53euDBy2IpDxzYlY09IeOrE9YNAYfDOdbRuVzO078EIRtrFYxxBu0?=
 =?us-ascii?Q?0pzAez4IUw6U/XfQFK6C3E83vRWHN44aUyindtXmWIMeOJMGq/7WCxWsxWYk?=
 =?us-ascii?Q?ajjdNJV9100L5Gppnc+o0rffc+gYz/fruK24M/1mQ15bYd/EKuGGizB7Wk1h?=
 =?us-ascii?Q?vv+Sznkr/7Ti932fUE5KvzdMu98zYlB88JUhyPKohF3IwqY2kOtXoLObK3QS?=
 =?us-ascii?Q?QGCE0ZVJ0rgrhj5nB9Lqap/LSj4rmNvNR5wRXNMnmmX4VnKsWpGYhTPkEmAb?=
 =?us-ascii?Q?aa2/1mPMMJ+2xc92BLYos8LXCdnLAMFXlp+1k3tD21NnRxdv0kDJyfPMJdPL?=
 =?us-ascii?Q?c7OdZGb8tc9omSKzXi7T1jBj75uA9bwqvjeuQtb5tY29ZtuPH179EEUOE7iM?=
 =?us-ascii?Q?yx8ujeKRwRq5WnfvdTLepCrgkcf57FZ1Ow2gKf0OjYbvC7+pNZ2qW2/onrZk?=
 =?us-ascii?Q?kvZ6BlLn7NJLreGHGc8XuRFW8+5uQhRNxsBOCzqwupRznjxuBCB6p8XBuD0k?=
 =?us-ascii?Q?LxM3rKPTmsUxfNtiXK2IFq4gjRk+FMJvr2HIBY3vBlPh6bF2TrJmtKJpOnjF?=
 =?us-ascii?Q?GDXYowoOGtrcOdzNe7JXG4Sg725lQ0cgKklefzQz8rf5+SRJ2o//AisCfbuA?=
 =?us-ascii?Q?jiJ+Ns+6cU9SIi3pNk+Xd0eHJ/rQKDPlmgQFt/RU/7/H6aRwANF7Z32yNZG4?=
 =?us-ascii?Q?3VMvgwexBzpeT28kzNaKMxkG/OoY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:28:38.1436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15df0581-d290-47b7-f6e2-08dce87f6dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584

From: Abin Joseph <abin.joseph@amd.com>

Add s_axi_aclk AXI4 clock support. Traditionally this IP was used on
microblaze platforms which had fixed clocks enabled all the time. But
since its a PL IP, it can also be used on SoC platforms like Zynq
UltraScale+ MPSoC which combines processing system (PS) and user
programmable logic (PL) into the same device. On these platforms instead
of fixed enabled clocks it is mandatory to explicitly enable IP clocks
for proper functionality.

So make clock a required property and also define max supported clock
constraints.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes for v3:
- Add Conor acked-by tag.

Changes for v2:
- Make clocks as required property.
---
 Documentation/devicetree/bindings/net/xlnx,emaclite.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
index 92d8ade988f6..e16384aff557 100644
--- a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
@@ -29,6 +29,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   phy-handle: true
 
   local-mac-address: true
@@ -45,6 +48,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - clocks
   - phy-handle
 
 additionalProperties: false
@@ -56,6 +60,7 @@ examples:
         reg = <0x40e00000 0x10000>;
         interrupt-parent = <&axi_intc_1>;
         interrupts = <1>;
+        clocks = <&dummy>;
         local-mac-address = [00 00 00 00 00 00];
         phy-handle = <&phy0>;
         xlnx,rx-ping-pong;
-- 
2.34.1


