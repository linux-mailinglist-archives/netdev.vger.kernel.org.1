Return-Path: <netdev+bounces-164686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E167CA2EB0A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC517A2757
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746031E0DAF;
	Mon, 10 Feb 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VjD6zdJ2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8EB1DF97A
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186843; cv=fail; b=ZQRNVOAkqxohvjAPe/S8teR1MrYYlpFZiZsq/WRqEh0gWtqDi3hiBG0D9Onige+emwIxuREuBccCOlPL/rL0DEr6ZxRiUDZNqn1nlTtZTKV1nA2PTgWS6nEg28/MCPkBAskE3DshFEl8uGb4n5if8C10B5tsGXDPx44ImTvU6tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186843; c=relaxed/simple;
	bh=u0EvXHaykU/ducp7Do9Ex173KhmX/BCt+N2Xl/+Mw4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hR5VaBpWPINeyJr05BJnKuKSGlpcegXWySi4sjWoGo/6RMhs9tzOb32hOVkX0GEWVmXWGQIpSRpfi7JZwN5Tlt43LkQ1ZC3gmUQUhDymetWtXd8QEHQIh3zXGPSoPSmKwV/k0PU/dx3YP/qW1W6s8X50/9Ze6P6wu4NqIaOuahg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VjD6zdJ2; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKUV0o7bQhvJkub9aTrQqUyDUeaEIp/+mi3Xyx2t9KCfRNEswjwPWTwdHDe9pwHz2hvMhpY6g/sWrDW4sWZYB0H7YKUQC22TzNOpEao/oI3l3DnJlBL1UMiCCC/GQAMACbg+sph60mFvg5iC+MSOvcV49v12p2TXRLJwTV+q9Gb7YEOLSUO9jKH1hiZqS4T2aq1o9XrUwtZq9IlMHBMhnQ0Ehs83PyHTSH/l10qCVayb5zv0HWn8FZLzAQBFPyAR6IoOy/GvqZZ+H4RN37FfoGeFZuQfMdduwC72WnPoCgqkeJJF2OVdy6eTrYxzFs6uPUpKOZH/PbYY4sHclh+Gyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDIjyo1uepWMM7Clh9zoylMDWxeLI4v5d9k0E+RlHeg=;
 b=RWZP3V18B1RMayptqfA1GD80265pQGAF8y/lVB13OtvJ6LA9fz0aXyKnfGOJ3F2HYQAzlAOMHkR7RiodhK/zfSvFZAOs/XPst4kojCWGUObEZ0XqyhIDepgXfqPjf+i4+hUk+FSA1LuvqI8K5R4c8ZLNbl1VdR5OLWGltxBeMyDuDkiGBIy6H75kGnMZvJhmDOSgE6JBq3XmELHxjWZ+q3m0DgsaYC5hg0/HjyqYGlHmL/5q0fDNa1IyidOkpOpcETwkFDPuyxy93jxip4WvdtQox2PvMblfW6YMGtsT9ztLb3a401YKWiCzjGnRV96OM7yDnuXEeQz7Vizj3ZIv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDIjyo1uepWMM7Clh9zoylMDWxeLI4v5d9k0E+RlHeg=;
 b=VjD6zdJ2tqHKeb7vcFbQqhGWWToCZ9Z3lQ2aJ38zUCnjaivuNNb4QBmpqwDQnlTlnmkKR5eIYB4SGXVgqMS5XrhwYdadmZEe5ZBDd18tUVhiitUJU3k+CUPt/j0RXPmHo+8WaXcIjfPOFk7YMDTaUxkthIAnKrjzQ+he6STyDOs=
Received: from SJ0PR13CA0185.namprd13.prod.outlook.com (2603:10b6:a03:2c3::10)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 11:27:18 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e9) by SJ0PR13CA0185.outlook.office365.com
 (2603:10b6:a03:2c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Mon,
 10 Feb 2025 11:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 11:27:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 05:27:16 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Feb 2025 05:27:15 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/4] sfc: document devlink flash support
Date: Mon, 10 Feb 2025 11:25:45 +0000
Message-ID: <3476b0ef04a0944f03e0b771ec8ed1a9c70db4dc.1739186253.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739186252.git.ecree.xilinx@gmail.com>
References: <cover.1739186252.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: f0affc50-1933-4315-e20c-08dd49c5e0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SZ4FdU+HSQSRG3oJ8GRWcd9OOM2z/BpOEQg4TS/n/cfhdnmjDfuKI1XJTjhi?=
 =?us-ascii?Q?U+G3FlwynbFNFQYoIWoks4tu5hsI53lzmfl4cPqEOAnYaX4qoP7mQ7ATtxzm?=
 =?us-ascii?Q?VJL5T6xWuXMKhGYsVT6jENAds2Ttz51DNDVRpEdoQEAd+IK9E8DArQk0mvpe?=
 =?us-ascii?Q?T/PE9/OOHRoo1/RRci3ngL4M3UnUXSdrHLN/of4YdpzHBe500erVAzycZMXu?=
 =?us-ascii?Q?TJkLEbjYViZ5SJyQzF9hY/n2FG4IQb+nmKCkqBvsdqop5QYsouiduLyng5fC?=
 =?us-ascii?Q?TarEm451GR+SZpQkON7Yjht5tCOYzDE22XNzCu/FmvJQ61LL2NzLhMtRGHCq?=
 =?us-ascii?Q?ziDGRRvm0VYDCsTrw9QTr4GfV4D9Gt6o/25P6iCtdBal/CC3LGwsXfJ9IV9w?=
 =?us-ascii?Q?uL0Qy4pKSWTlAAlG5u9H/BbYauL/minf+ztjpFcGVyU/0sE2ebgtcF1GbZLW?=
 =?us-ascii?Q?ntqvJaHUtu+MgeS+4Gk6nebQZeghhpms5FhCufEHKyE1EN+v5M6HuUoJObr1?=
 =?us-ascii?Q?sSuokGRujZYxNi0IOXi0DObo/PpWyTksH5+1pwcvBziFk1rWJWMjyGOJIGfG?=
 =?us-ascii?Q?9snispboOk5X+Wp23/jO11sMd1Bd7qPws5muBTw/6ZfdjtEsOM1N0zMGHTsG?=
 =?us-ascii?Q?Cmkl/5qV0H97LjyEcqaxBnvHcJQPW/xqs7i0KGvaTDL0xTcGyYnn9gmfGDLs?=
 =?us-ascii?Q?G1ZKt0anil56IpJ48D1QG3Oe5CKv1wV/P9Dsz861EuP1qjG89ATJFMhvi36Y?=
 =?us-ascii?Q?O7B3qg85Z2u50+w1xfgy6oYcU3nSXbXgd0boAqn00T4IJP78RXrG5toI9+n8?=
 =?us-ascii?Q?Kv82xK6EpoA2wKm07OfS8Lhu6qhvhpBa5UOoFT/tY+XlP8BqxkBQ8h0hMs8Q?=
 =?us-ascii?Q?SJIcpQSA2xcbVOYt7YhlzPEwiXxEROJq2SVudWlyrdroZlxgm4Ed/F+KRtVF?=
 =?us-ascii?Q?6KMsHdJiQXCndujBufA3u2zcbOhGdXXy3jx38WR3GE/NJlG0uIVA4UihMHT7?=
 =?us-ascii?Q?AY6C/62SlwtADakeIC6LVGhsZcjxL4T5IPkC502XM05JM8eJ68lojF/XVTsS?=
 =?us-ascii?Q?bDiIAYGefSYJ1SUzwG2N0iezh40lh7chSHRnNAoyFC864QgfSh7nSh+/mT/A?=
 =?us-ascii?Q?BeNlbqQuLUc0zBch+GbXEIME/qyuqEYlXWwr4zwuyT5FE2xP3YGPp5kGtOL4?=
 =?us-ascii?Q?3l/zaDp/q9vVvJYIdRiLA4pwjtKTPsRI2m5fdyi3SOEBL5mcmI8F/r3f12bm?=
 =?us-ascii?Q?IcibpVlVZnkhvJVOzpyPKLhU25Qxrrz6DfOgfMxxMS2JI5iNNLAWeb5Cp1Gd?=
 =?us-ascii?Q?R/g+53aYy8MM7NkvdPd5vXOUVz3tfls4KpUgFv+ILUArVdPNsurHKkBIi7eG?=
 =?us-ascii?Q?AdTZf+33taOR2X8PwEtMePHQi83K0r+K+IR9T040xxxf6QakfkiGJuyhc6GM?=
 =?us-ascii?Q?lRmvIECgMzgD1LOY/B6O374wFGUoeCbomLOAbM7kD34SzYnrOVkqbsYGNoZT?=
 =?us-ascii?Q?hD6d9mESuHdqnhI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:27:18.2579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0affc50-1933-4315-e20c-08dd49c5e0b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

From: Edward Cree <ecree.xilinx@gmail.com>

Update the information in sfc's devlink documentation including
 support for firmware update with devlink flash.
Also update the help text for CONFIG_SFC_MTD, as it is no longer
 strictly required for firmware updates.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 Documentation/networking/devlink/sfc.rst | 16 +++++++++++++++-
 drivers/net/ethernet/sfc/Kconfig         |  5 +++--
 2 files changed, 18 insertions(+), 3 deletions(-)

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
diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 3eb55dcfa8a6..c4c43434f314 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -38,8 +38,9 @@ config SFC_MTD
 	default y
 	help
 	  This exposes the on-board flash and/or EEPROM as MTD devices
-	  (e.g. /dev/mtd1).  This is required to update the firmware or
-	  the boot configuration under Linux.
+	  (e.g. /dev/mtd1).  This is required to update the boot
+	  configuration under Linux, or use some older userland tools to
+	  update the firmware.
 config SFC_MCDI_MON
 	bool "Solarflare SFC9100-family hwmon support"
 	depends on SFC && HWMON && !(SFC=y && HWMON=m)

