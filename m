Return-Path: <netdev+bounces-163722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E0A2B6F0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7C73A6437
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596D64A1E;
	Fri,  7 Feb 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vo/qpcRW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFA17E4
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886814; cv=fail; b=EAEr+FJdNrPVW2emPlaUFxjMVQt57nVqkFZYIGjUdHFt6ZH2nGLDs+6tgeKEO6TCPr0RnFIhaRHp5s8Zsz/7sw72WiF0FZRstnZCY8zv288Mv1+7rXJGxJ0HWcnMp4YDFJaYzVfKpt+PIEc//pa88lk6bZA4YecvpIJ3+KHB/ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886814; c=relaxed/simple;
	bh=/KxRB6UXqZaHZKgULQ91Q7s33mQ4R3a9ObJrKZJYWQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgid2o4/ZISo6DIWmeESZLs+Mf/QvdtxPmKmJAV/Wl1m+UaWZ5bxYKBfoflqo/lwJAVPUnhGW54wCjMBF7rlrx98bf9C4z+toq8tsJyG7hkZhrRiiZsTebUaydB0wwtLcDbZXae4j6YYt/WMnPQg3qcyA4IM4cqseMTdDL/j0gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vo/qpcRW; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEKauC8xK6Y14y8VXghqX3FgfeAaZx1QfMwAztvbzxhyLOG9O+erc0+OyCtSEwLuD5I1dEB32D7pmZOiCUTho+aXUlYRJlnLR4PI8lZegEcTL/4yI8WAxXNFeb0yJYmFFM8mQdnkeDK4rruJRAGchazaXyoHV3Otvecf8QXtOq6ADZdaNLIWVNWZxA+TMFUHg31+8SDRW8V5Zdv65Vfsk+c9zcOQ8oMbNR4LkKWvwsLCBOlHrC/BS7oRyhaSupOGCxtwcF0SfgPe7NJilp08ckOyQrc1K2ZfYNV6uL7pdic1HsI+6eusOSBek2AoCHsUT+CsObQ0o8e0GwsAD4uLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4WhO94JiR0iO2Mz1oME43tTPFj9geWkbLwkXZslgp8=;
 b=I1r/f8acNzct2c1aTR5dQls+Fdnq91h2yrje6/sDk+FTHHt9H/l4zYXpgBShHcfCF4v8dEbF/UiteqAplWpbcCn5Jvd5RsJRXfatlfQFRHQ3oDacpTupyH/+qE9EWdiyC8DROGqipR2SDFDT0/b3JdQcsiI/WQUloXJf2fEQMAvcZIx8QB1qYj3BPEPcJuoTxQvms8b7Xv7xDXu51FX2h2Bhe5uX5LcsjaVzYTdkPDWQfEEFm1cYZh1Ri5+LXvakjp9dXrhAyxaMN2JZy6OrhLXFiYDwX8tciqp344gGixH0AO3/BG1jFq1+1eIBzdPtQslUaFagMp3f6kl1jD5LxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4WhO94JiR0iO2Mz1oME43tTPFj9geWkbLwkXZslgp8=;
 b=vo/qpcRWKuXHuEJ0nEq9Ktd94pmM68zMzVBBgRHalD7J46p/espGVGaBYDYAT3Ynzg26eLxpxvuKCBPdj/n8HkU//n1zOSPEMXtn5sduGBvwCs7EeZ2FAoRffad2accBlL23rYdLnG4p2nILWr4n+Vp7mTPMoMOI0AC09gezMIk=
Received: from MW4PR04CA0175.namprd04.prod.outlook.com (2603:10b6:303:85::30)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:06:50 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::ed) by MW4PR04CA0175.outlook.office365.com
 (2603:10b6:303:85::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Fri,
 7 Feb 2025 00:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 00:06:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 18:06:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 18:06:48 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Feb 2025 18:06:47 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 4/4] sfc: document devlink flash support
Date: Fri, 7 Feb 2025 00:06:04 +0000
Message-ID: <dc22910e30482cc4b4e35a9e45621c653ea000bf.1738881614.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1738881614.git.ecree.xilinx@gmail.com>
References: <cover.1738881614.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 319676bb-9843-4eeb-8de9-08dd470b519c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gEbvGOjFmYuvDw+iyI2i+HU2L15NwYTDw3frqiVPrNZrkjYE+1ioslCtWRy7?=
 =?us-ascii?Q?dMrAtXTXTmMAeWuRKVdaW2wbMExXdSxY9GTxv/aFg3g1Uvmjqmph1i6CPb08?=
 =?us-ascii?Q?NWYFabvQW1JF3B6q2Wi85a6bgcVYO3FD2frxekyc9j7BrBBk+AtbdMjd4cTo?=
 =?us-ascii?Q?EIw7K+9rBAWaZIOt+Tu62vBOJldBpg1V62W1Y2R6fWIYDtgGrU3W+Vc8Izk1?=
 =?us-ascii?Q?eQk6RDZYwWtwAum/Y4jfZ3R0Sm6Nx02++Rt2vxDce39RCZIj3koENTgHlnHO?=
 =?us-ascii?Q?bpCr5/f1wQ3/0R5VkseIvjtxWitYNduO16jj9NQX7Hs0KKgLm3mWd1COB/+V?=
 =?us-ascii?Q?k4GBurzqLckKuTdZBm0/bhWF1yrKQ5bR2adGbgAXR3ncWLiooINorpbDji/4?=
 =?us-ascii?Q?6nBvYWh2gn8b1QY0qKgkofijCrVEQWMqqM19DC9XZz+jfFWwP+hRg5vfXIkf?=
 =?us-ascii?Q?N3Rh3eLRiuRzksYxoGIrOzdgHdpR5Z1p4RzF5KR9TrDT6wX1NVgaiynnp2lG?=
 =?us-ascii?Q?WzLBSgmmphjUzEL7AoMqCpFoI9hfzNIymduEyU8gXdXxzTNAZ4KzUJDkcqrN?=
 =?us-ascii?Q?OHsuULgDzNSaC2QE9Y/7kRQ26jCflURv9hjD8oChcRd/9J+WoB3x+SthF0QD?=
 =?us-ascii?Q?dGro99C4Sj7i6oTUAeBL9Pec8sKcddBJVGaGkiZ0N9UJRioFzfT3/4E751Tk?=
 =?us-ascii?Q?KFZS2qdV/M2n1mgZItJANHhD9yMUOZWwNqaRjFgmMTOJpU7h1bkguDK1yaK6?=
 =?us-ascii?Q?TiP11AZfr3Nc66wdNWYrfiNCQ/D9WEonD5/m2coqt9q0tp3fM0c6Qdi267hS?=
 =?us-ascii?Q?U7lK+7gGOecl7vzxePgD+ftk/jvRIzOjIzF8C4pen1Mi/RkGq1j+5s3BlyDg?=
 =?us-ascii?Q?7l9XDE2thDxRZFYZMN3BwVWEm62sRdpxHHfhczXa0BfSo5qdLa7zeXM5g7Uc?=
 =?us-ascii?Q?1ifLQOHvRmVwJ0EuP02QS7fzzxU9WHwfFcpV/lCna1vd3GBdvznxNZSv7yPe?=
 =?us-ascii?Q?ZkJIgNpURXRQnQzfBJl5teEUEdeBLw9pJIQkfKsQmmXBjmDxtRLfvcLQ9hBA?=
 =?us-ascii?Q?2e2uip14kQsfICrIQ/sTetKqvITU3iIH9jb2WfHL8p2wdcit3pXT+CCRuBOW?=
 =?us-ascii?Q?HpkzmWZHNWDSzPS7pWnu+Q/cjOL7jVy7+HWr6ICkqQLPww5rtemApQqHjL1+?=
 =?us-ascii?Q?uNKS0rJhPSvPf2VFGCFMmxFWxF4vkhPioRGmRVgm2QLyYxlHkUgQ2BL+DThD?=
 =?us-ascii?Q?eoQJvwXCACEzoTQFYtmr9Pfw7MhBslC3hcm5WnDUadV9CrkHgouJ8NKTPtAP?=
 =?us-ascii?Q?4uOd1hZ5Pr9HfrQgWZ3xaSbJ1RhHZFq12DRsMp33+m0zWcZGVp1lmeAiRDbn?=
 =?us-ascii?Q?avrFnPsmt/gcjIfOy8sHRJ21ZPA3k4e9j/wV/ycIJyuNYEnaHhMeO8/7KGnl?=
 =?us-ascii?Q?G+I3rFwGCeI0s7EvTIjRIgIDwGKWFURP/573tpDPKmcreLjcGYP2V+CRnFGs?=
 =?us-ascii?Q?VhLTCPhzm6nEbbc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:06:49.4342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319676bb-9843-4eeb-8de9-08dd470b519c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502

From: Edward Cree <ecree.xilinx@gmail.com>

Update the information in sfc's devlink documentation including
 support for firmware update with devlink flash.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 Documentation/networking/devlink/sfc.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/sfc.rst b/Documentation/networking/devlink/sfc.rst
index db64a1bd9733..0398d59ea184 100644
--- a/Documentation/networking/devlink/sfc.rst
+++ b/Documentation/networking/devlink/sfc.rst
@@ -5,7 +5,7 @@ sfc devlink support
 ===================
 
 This document describes the devlink features implemented by the ``sfc``
-device driver for the ef100 device.
+device driver for the ef10 and ef100 devices.
 
 Info versions
 =============
@@ -18,6 +18,10 @@ The ``sfc`` driver reports the following versions
    * - Name
      - Type
      - Description
+   * - ``fw.bundle_id``
+     - stored
+     - Version of the firmware "bundle" image that was last used to update
+       multiple components.
    * - ``fw.mgmt.suc``
      - running
      - For boards where the management function is split between multiple
@@ -55,3 +59,13 @@ The ``sfc`` driver reports the following versions
    * - ``fw.uefi``
      - running
      - UEFI driver version (No UNDI support).
+
+Flash Update
+============
+
+The ``sfc`` driver implements support for flash update using the
+``devlink-flash`` interface. It supports updating the device flash using a
+combined flash image ("bundle") that contains multiple components (on ef10,
+typically ``fw.mgmt``, ``fw.app``, ``fw.exprom`` and ``fw.uefi``).
+
+The driver does not support any overwrite mask flags.

