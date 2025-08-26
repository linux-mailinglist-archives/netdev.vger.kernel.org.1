Return-Path: <netdev+bounces-216782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB9B3521B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 305AC4E2C0D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519B32D0629;
	Tue, 26 Aug 2025 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="qzKs8fYs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F532D12EA;
	Tue, 26 Aug 2025 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177881; cv=fail; b=jjC8PUPoaQ/03G2oWC8fkZncruJmLHnjKgyTbM7nGB0SR4XHEyKyKJaieYsy1ZoxZTuTNlOE7sLRaC5iQR2kTfmi48nyewQPt8yPvFenvoffp7+gXhtuzXb5EKjsVb17dmbxP8oi0hnoihWOFEYgRbR6NRsLyTe6aoZubDkpnSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177881; c=relaxed/simple;
	bh=qF9JKZmOt6dU3pi72/nD6CVkIA6YWlDgmkYTKEku7kU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF9OtilMRBrhlexgNyV/hE6ZTwL4doQiXgKT5/UbFFWcqxufeNtz//QGykGGY4tjjO9S3kMpDsgtQ1z1FlQPXQH+nC5c3NJkRXXvz06qgPMgf8EXAxb0jUWEmL4HIyQ3kuI945Hxsa0omI1S8bWb7P2sSHEK4lvAnqrAfiBxB6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=qzKs8fYs; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSbVbMI1PgWEsydZoBsASGKvirOILsDbPrM/kSdHw2MGUd8T6E8Zuc06e0Ry5mGT3tAPCwFWiJI+zTauaGsCTGukKNurrUtv71xo0TK6dVCDzLnnPYpf01k2XonkSrHcXmQc5KERlxtW3MzSVK2bn0lJC9CjHyLetz/4CgLkt9QcbCXROdhS/Z5UpAImknxSZdEWBrRrMxkgDk9IGWjh8E55YJR7MDn0bA1KvGny4AOIZDpA/zneO4iC4E2pdXHbE9wysjvd/0vupn9BA5ZQnACcKKj5fc4OLkHTxX6JreQEzHycTqDmYEV3ic0upYnsAWdlZ6/aDtSdQA37OOzyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkfTORRK5LzpWtAxI947VMnrkQACL27YM6DH1tHEh7Q=;
 b=VCPqd9LVgy8QeXmWkXYoX3KRrMdfd5LJ/yHSkFLdDhrvr6HXxXpioJ+SliYHxCA+jbqKkH9G83dIS2M5F/qSWnwg2gEgfri6uu3lomJdXCFDWS3IkoLF3pDR91K+7SiTn4zMLhg4ilyvwcY144t7gAwrCPxDVKhP6M3doivnWpJK57pR42vX4EiZoc2coBfufB+IJOdjdYUpJbKPS2se5r1dizAGiLAKePhRxvCHgeI8XpqAbr3ydhWoGjPIW2mql2hEnEScCHhmewCg0EHUW27tJYoEZc4fvIIcNE9J4dj08pNHWGGQXZMp47JL5f1sPz0K/tq4lvE7jW9R6p4cHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.92) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkfTORRK5LzpWtAxI947VMnrkQACL27YM6DH1tHEh7Q=;
 b=qzKs8fYsLuFyFe0C6Xl+rYzm6kQOEtMYLiue6CwBW4czbuDDVYURzeffB41CRche8sNbqH+7QdtCTmsOkXWcVYYMZ0eOhgVaAoqoZI+HZTTa4Hx8I3YpmC49BIznPZmuloM9G+RBsl5g7UDTJ+8OosFH69gENLtFkP7xvdShmD0ZdVeS6QcVgCPDCgnMIPZpxipRxV+xxemdUVeCsHXVFGWyPsVXD/jrhYAlN1oysRz3oZJ58YqymhfEyCCdW5ZcCjkERBq1kGAnfHOOOFP8WhdxDX5WFU4NExc+BS38/kZ/2hrbbhCXet18f5lWT2HVxNPel/zj01PmE00MQ4/9dQ==
Received: from CH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::10)
 by BY3PR19MB5122.namprd19.prod.outlook.com (2603:10b6:a03:365::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Tue, 26 Aug
 2025 03:11:10 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::d2) by CH0P220CA0004.outlook.office365.com
 (2603:10b6:610:ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Tue,
 26 Aug 2025 03:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.92)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.92 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.92; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.92) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 03:11:09 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.31) with Microsoft SMTP Server id 15.2.1544.25; Mon, 25 Aug 2025
 20:11:05 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next v2 2/2] net: maxlinear: Add support for MxL LGM SoC
Date: Tue, 26 Aug 2025 11:10:44 +0800
Message-ID: <20250826031044.563778-3-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826031044.563778-1-jchng@maxlinear.com>
References: <20250826031044.563778-1-jchng@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|BY3PR19MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 16643526-6eb7-4b01-9cc9-08dde44e34c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4N3btu5dYCjuWf82slLsgE/1+4uODIP4lApNJRoHeZXVvQ9lM/ackPL0sOAb?=
 =?us-ascii?Q?iaOB4+XhN4O3qsr7M+bRVZ8wQtqXp7qVrTLhqKz82yYIWb/CRPARIEwf6dF5?=
 =?us-ascii?Q?VyZzIamT0W/o7MChaMz+e0ok5jACBWtY7TJmHj/TEs3qN2X7Fo/w1K5VFEc4?=
 =?us-ascii?Q?6ktJXtlcfg8v8g7SWdFXR7UJmPbj9/t8prUV+lKWexYzaNdO1b2sz4QaHKkD?=
 =?us-ascii?Q?SJSd5bTT9Buc6ZelfvmhqRxtD9tBU3u1mKJc90gZ4TjYkqqAadbG37a+0Jrg?=
 =?us-ascii?Q?N85pysjUrvjoy/epwsX9+Q+PpTVXca/ONTVTvLoKd04KNAVbZiZMJIztojJ6?=
 =?us-ascii?Q?qtg3gBm8yLXJIRx9vmtQKy2wr/SlGmba+IJRrPvThr/WoJ7lZpfzyV5KYpj8?=
 =?us-ascii?Q?xkaFwuBZXamKa0Y/aJh6UHm7XhcAMBKMCWK3AgMgEu1A1e17isQkXrjokUS2?=
 =?us-ascii?Q?3j9K6ouJKmyw0qw8eVvEhxzLWVGGQXeCKBIg/HmQVVKR16363hhGn7kHHtPk?=
 =?us-ascii?Q?5WIjvMLV60fo0C7TMwdiKH1dpOUidQoOCusfMUEBYHuVkJu0ZD8m/4EO+j0a?=
 =?us-ascii?Q?PeM4fmjjYQPq/fK2fkYDOK7GtmU7xPlXHw879Pw0bl26geg22z826ciuQATx?=
 =?us-ascii?Q?Gw7AkG/sNmkuYgYQbUUZVcXL596vxLx5glRuosmh4biwwyt43n0Ur0oEtnBG?=
 =?us-ascii?Q?K6mh99Q3ZZxvtg1XKj2cVoyxNHB6xPCD26Gw+oVYE+8GeTWYwyyy/W8v2uVy?=
 =?us-ascii?Q?E8IAN0fxcv4H0xlqCVWX5DLtN2EDDsyx0Hz9qtv7iV611VhPekyYKDkNRii2?=
 =?us-ascii?Q?nWg/0mm5pDqTprY8EruJwlj3M5HfliW3XIC+v3QjstMghn3zK+hVKxsjNoNE?=
 =?us-ascii?Q?iI5afUGAKiDdBZkttvK/wDAmxlgZiwQrZETzmZV5DJmBTrW0CepiNZt296XJ?=
 =?us-ascii?Q?vI0M5jKSlV8s0iFSakaJPQAy9zquRz4TafWZgxY9VO8MIjx49tuX6ry5dg0e?=
 =?us-ascii?Q?jXIqe8S8N0uHyZ3QICatC9lhLj2ZjzGobUmPs2j89Qbi8E+1dPYXnFXaAfb5?=
 =?us-ascii?Q?tzZyJ03Z7/BVTyOxmlRH1IIT3Hc0veekOM0qarwbj8d3UwEdCUxNTNO5QC+O?=
 =?us-ascii?Q?dBBQ3q/2lg+ts9bryMBWPcBz3bvZYhFpEODrL4ukNhdq55rdsehHcjaPhtZL?=
 =?us-ascii?Q?YgtvJnhXCFaB6MbIEByJFTseA8J1xMQfC7fETKdYKlDRyYopp7FhF6Yq43O0?=
 =?us-ascii?Q?PQK0Bgt9nKXzRA+R1LA2CbDCuy/Or0Ssf0GqU5uruJ4sJmcMybCD+A6b2eu6?=
 =?us-ascii?Q?Mwcg5mFlPOASgW4FtmLIyAYGoVJUxiGwmKkaf9789Ht9MkMWefh1nEQdZdHw?=
 =?us-ascii?Q?LjEGeTq3DDr74NiW/2zDAL6zAESEq4cnUKa9qkO3m8XB83sv5VdzHvIgBvRt?=
 =?us-ascii?Q?MWcvtGQnOk2KqDuXBPK/iEM+Rf4Mi5eex3SQB0JIpp5iD12A7f33tQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.92;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-92.static.ctl.one;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:11:09.9095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16643526-6eb7-4b01-9cc9-08dde44e34c3
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.92];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5122

Introduce the build system integration and initial implementation for the
MaxLinear LGM SoC Ethernet driver. This patch adds Kconfig and Makefile
entries, the main driver source file, and documentation.

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/maxlinear/mxl.rst |  61 ++++++
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/maxlinear/Kconfig        |  15 ++
 drivers/net/ethernet/maxlinear/Makefile       |   6 +
 drivers/net/ethernet/maxlinear/mxl_eth.c      | 189 ++++++++++++++++++
 8 files changed, 282 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
 create mode 100644 drivers/net/ethernet/maxlinear/Kconfig
 create mode 100644 drivers/net/ethernet/maxlinear/Makefile
 create mode 100644 drivers/net/ethernet/maxlinear/mxl_eth.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 40ac552641a3..13d3cbc96e87 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -44,6 +44,7 @@ Contents:
    marvell/octeontx2
    marvell/octeon_ep
    marvell/octeon_ep_vf
+   maxlinear/mxl
    mellanox/mlx5/index
    meta/fbnic
    microsoft/netvsc
diff --git a/Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst b/Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
new file mode 100644
index 000000000000..7954c47347e7
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================
+MaxLinear Multi-MAC Network Processor (NP)
+===============================================
+
+Copyright(c) 2025 MaxLinear, Inc.
+
+Overview
+========
+
+This document describes the Linux driver for the MaxLinear Network Processor
+(NP), a high-performance controller supporting multiple MACs and
+advanced packet processing capabilities.
+
+The MaxLinear Network processor integrates programmable hardware accelerators
+for tasks such as Layer 2, 3, 4 forwarding, flow steering, and traffic shaping.
+It is designed to operate in high-throughput applications, including data
+center switching, virtualized environments, and telco infrastructure.
+
+Key Features
+============
+
+- Support for up to 4 independent 10 Gbit/s MAC interfaces
+- Full-duplex 10G operation
+- Multiqueue support for parallel RX/TX paths (per MAC)
+
+Supported Devices
+=================
+
+The driver supports the following MaxLinear NPU family devices:
+- MaxLinear LGM
+
+Each device supports multiple MACs and high-performance data pipelines managed
+through internal firmware and programmable engines.
+
+Kernel Configuration
+====================
+
+The driver is located in the menu structure at:
+
+  -> Device Drivers
+    -> Network device support
+      -> Ethernet driver support
+        -> MaxLinear NPU Ethernet driver
+
+Or set in your kernel config:
+  CONFIG_NET_VENDOR_MAXLINEAR=y
+  CONFIG_MAXLINEAR_ETH=y
+
+Maintainers
+===========
+
+See the MAINTAINERS file:
+
+    MAXLINEAR ETHERNET DRIVER
+    M: Jack Ping Chng <jchng@maxlinear.com>
+    L: netdev@vger.kernel.org
+    S: Supported
+    F: drivers/net/ethernet/maxlinear/
+
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..e4765bd73615 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15102,6 +15102,14 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-maxiradio*
 
+MAXLINEAR ETHERNET DRIVER
+M:	Jack Ping Chng <jchng@maxlinear.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
+F:	Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
+F:	drivers/net/ethernet/maxlinear/mxl_eth.c
+
 MAXLINEAR ETHERNET PHY DRIVER
 M:	Xu Liang <lxu@maxlinear.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7..3e94ff7922c8 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -121,6 +121,7 @@ config LANTIQ_XRX200
 source "drivers/net/ethernet/adi/Kconfig"
 source "drivers/net/ethernet/litex/Kconfig"
 source "drivers/net/ethernet/marvell/Kconfig"
+source "drivers/net/ethernet/maxlinear/Kconfig"
 source "drivers/net/ethernet/mediatek/Kconfig"
 source "drivers/net/ethernet/mellanox/Kconfig"
 source "drivers/net/ethernet/meta/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 67182339469a..760d598df197 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
 obj-$(CONFIG_LANTIQ_XRX200) += lantiq_xrx200.o
 obj-$(CONFIG_NET_VENDOR_LITEX) += litex/
 obj-$(CONFIG_NET_VENDOR_MARVELL) += marvell/
+obj-$(CONFIG_NET_VENDOR_MAXLINEAR) += maxlinear/
 obj-$(CONFIG_NET_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_NET_VENDOR_MELLANOX) += mellanox/
 obj-$(CONFIG_NET_VENDOR_META) += meta/
diff --git a/drivers/net/ethernet/maxlinear/Kconfig b/drivers/net/ethernet/maxlinear/Kconfig
new file mode 100644
index 000000000000..b88cdd9675fb
--- /dev/null
+++ b/drivers/net/ethernet/maxlinear/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_VENDOR_MAXLINEAR
+	bool "MaxLinear devices"
+	help
+	  If you have a MaxLinear SoC with ethernet, say Y.
+
+if NET_VENDOR_MAXLINEAR
+
+config MXL_NPU
+	tristate "MaxLinear NPU Ethernet driver"
+	help
+	  This driver supports the MaxLinear NPU Ethernet.
+
+endif #NET_VENDOR_MAXLINEAR
+
diff --git a/drivers/net/ethernet/maxlinear/Makefile b/drivers/net/ethernet/maxlinear/Makefile
new file mode 100644
index 000000000000..0577b325494c
--- /dev/null
+++ b/drivers/net/ethernet/maxlinear/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the MaxLinear network device drivers.
+#
+
+obj-$(CONFIG_MXL_NPU) += mxl_eth.o
diff --git a/drivers/net/ethernet/maxlinear/mxl_eth.c b/drivers/net/ethernet/maxlinear/mxl_eth.c
new file mode 100644
index 000000000000..093ad9b27a81
--- /dev/null
+++ b/drivers/net/ethernet/maxlinear/mxl_eth.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025  MaxLinear, Inc.
+ */
+#include <linux/clk.h>
+#include <linux/etherdevice.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#define ETH_TX_TIMEOUT		(10 * HZ)
+#define MXL_NUM_TX_RING		8
+#define MXL_NUM_RX_RING		8
+#define MXL_NUM_PORT		2
+
+struct mxl_eth_drvdata {
+	struct net_device *ndevs[MXL_NUM_PORT];
+	struct clk *clks;
+};
+
+struct eth_priv {
+	struct platform_device *pdev;
+	struct device_node *np;
+};
+
+static int mxl_eth_open(struct net_device *ndev)
+{
+	netif_carrier_on(ndev);
+	netif_start_queue(ndev);
+	return 0;
+}
+
+static int mxl_eth_stop(struct net_device *ndev)
+{
+	netif_stop_queue(ndev);
+	netif_carrier_off(ndev);
+	return 0;
+}
+
+static int mxl_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	dev_kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mxl_eth_netdev_ops = {
+	.ndo_open       = mxl_eth_open,
+	.ndo_stop       = mxl_eth_stop,
+	.ndo_start_xmit = mxl_eth_start_xmit,
+};
+
+static int mxl_eth_create_ndev(struct platform_device *pdev,
+			       struct device_node *np,
+			       struct net_device **ndev_out)
+{
+	struct net_device *ndev;
+	struct eth_priv *priv;
+	int ret;
+
+	ndev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct eth_priv),
+				       MXL_NUM_TX_RING, MXL_NUM_RX_RING);
+	if (!ndev) {
+		dev_err(&pdev->dev, "alloc_etherdev_mq failed\n");
+		return -ENOMEM;
+	}
+
+	ndev->netdev_ops = &mxl_eth_netdev_ops;
+	ndev->watchdog_timeo = ETH_TX_TIMEOUT;
+	ndev->max_mtu = ETH_FRAME_LEN;
+	ndev->min_mtu = ETH_MIN_MTU;
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+
+	priv = netdev_priv(ndev);
+	priv->pdev = pdev;
+	priv->np = np;
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register net device\n");
+		return ret;
+	}
+
+	*ndev_out = ndev;
+	return 0;
+}
+
+static void mxl_eth_cleanup(struct mxl_eth_drvdata *drvdata)
+{
+	int i;
+
+	for (i = 0; i < MXL_NUM_PORT && drvdata->ndevs[i]; i++) {
+		unregister_netdev(drvdata->ndevs[i]);
+		drvdata->ndevs[i] = NULL;
+	}
+}
+
+static int mxl_eth_probe(struct platform_device *pdev)
+{
+	struct mxl_eth_drvdata *drvdata;
+	struct reset_control *rst;
+	struct net_device *ndev;
+	struct device_node *np;
+	int ret, i;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->clks = devm_clk_get_enabled(&pdev->dev, "ethif");
+	if (IS_ERR(drvdata->clks))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->clks),
+				     "failed to get/enable clock\n");
+
+	rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(rst)) {
+		dev_err(&pdev->dev,
+			"failed to get optional reset control: %ld\n",
+			PTR_ERR(rst));
+		ret = PTR_ERR(rst);
+		goto err_cleanup;
+	}
+
+	if (rst) {
+		ret = reset_control_assert(rst);
+		if (ret)
+			goto err_cleanup;
+
+		udelay(1);
+
+		ret = reset_control_deassert(rst);
+		if (ret)
+			goto err_cleanup;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+
+	i = 0;
+	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		if (!of_device_is_compatible(np, "mxl,eth-mac"))
+			continue;
+
+		ret = mxl_eth_create_ndev(pdev, np, &ndev);
+		if (ret)
+			goto err_cleanup;
+
+		drvdata->ndevs[i++] = ndev;
+		if (i >= MXL_NUM_PORT)
+			break;
+	}
+
+	return 0;
+
+err_cleanup:
+	mxl_eth_cleanup(drvdata);
+	return ret;
+}
+
+static void mxl_eth_remove(struct platform_device *pdev)
+{
+	struct mxl_eth_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	mxl_eth_cleanup(drvdata);
+}
+
+/* Device Tree match table */
+static const struct of_device_id mxl_eth_of_match[] = {
+	{ .compatible = "mxl,lgm-eth" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxl_eth_of_match);
+
+/* Platform driver struct */
+static struct platform_driver mxl_eth_drv = {
+	.probe    = mxl_eth_probe,
+	.remove   = mxl_eth_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = mxl_eth_of_match,
+	},
+};
+
+module_platform_driver(mxl_eth_drv);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Ethernet driver for MxL SoC");
-- 
2.34.1


