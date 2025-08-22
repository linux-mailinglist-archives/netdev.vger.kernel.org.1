Return-Path: <netdev+bounces-215965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 693AAB31293
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5150A189F87C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C312ED85E;
	Fri, 22 Aug 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="4W//VQk2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244C2D7DC3;
	Fri, 22 Aug 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853723; cv=fail; b=a8m2yLQbJZWXZLS89jbqBfud3q7vhhvjZoCcvl0CqZ2C1oPzHywakC2QITA6mfZY8AtMemRKyNN3eJB1Oc+hfIkLLWZtWDvHA9w8017C6BivvBQz+xCwmEJeujfG+3dlhDRFr11v6uPGzSuYwOMNfNlQdfNwIl11xnQlPB1AdP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853723; c=relaxed/simple;
	bh=mNoYOSHwFQGLTt9ZiR8NWFv0f3U4FzGz1d3Arnza9G0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNZU9hxU0Nv8jYGsaPB1/9Cdgiv2iPdt7OL7mXtdWesTqYBi0TnBLngTRGhlC+ivVev+fOlPSvGIGHeYqIzyo87+rCb+xpbY5G2Hf0yltt9502qKmlhuLYjMeY4MVjKQGUG6OH0QjIVbJEHDzC0frNqo5UXbREpkjZVDv2zB76k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=4W//VQk2; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHDD/j8LUV+v4HPbH5IOIpyUH4sprR3dDSBHpFpfsj7GyBGZ4gqi40rZSgXRlC8n2wx8yqwETTFqT7Zf7mQQdH+QPLF446SrfplA8uaReiadSYakUEYtZa+eYO0YJ94Q/Rq4cdNQuuOCayRjG+0rdl2qh9HrRWwrgRWNqTctDlVjQISoH73ycZRnpF3znQj+lYd9ktTQJNzkZe3jvq/cSoQX38lAgrPn0UblhB0lKG2xCyGW0dVkkaalfIAXtEYVNmcaZ/U9o2nPZ8ed0uPfWP6uj02lB6wTL/BQY9FitbJogNiZlgNvf8WnGAdUAj3y4H8ZwKXcB5ssZMwouFvUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmJ8Kqe0Rh+aqI+QPDTgCCg9sII2ulGL7BXFwe1OJ/4=;
 b=ET4yWIc2AvMwvDxtNYlDLLxwMZT+hEoYVvmCB/oU+HkWmX+oT70Xs3NAw13hJJhObupMM83bboCl3GY1yNmp0AT5vvw3680fnK+kQ66RjYBGlveljGk1K+l8DXyENt5wMiLhx3sP/kgGudPtY5drsrmSiYakxFuJK4beLIo2Ghb20Dv/Pe5CvWNEjjvJOrNVyiZzaDfvWJsjuSw9erll2uH+UELpkPkm2XMGfsFAWDAkdlhQiJ+TERTb9qJ/oBQh+njVa6Q34IJrFfEici7xHaJQB0Ft4XpILzoQ+jHiTJBgv6CwdVPaPkmVJvi8wdHah3h4IghYBelSSAl+BxL3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmJ8Kqe0Rh+aqI+QPDTgCCg9sII2ulGL7BXFwe1OJ/4=;
 b=4W//VQk2iC0Kq5gF58j8sGY8ti0dywTttELb2PaL7AK567eJ2lJiWPTNiHGiOF1hjHi7wRBtplfF9TRr9rmyKygFBt/yslPHJKhJJIBWlI6tdYNEj5fyeGvX8li2B+FnmlzuzDa5oUXJY+kBrYDVhsKmP+CHlltpXQXY4I2t9FvHLa3ofPW4kQD8RuP6xNxtBXRECSM10yLvsp8SYVrg3NXgyKkIzX5EbaRFx2Gw2emjZmf+DbN6wUqdDILw+NesPUKVn6cyn9WGYyNXgNawNLFYNbJrzaWVeZT2xbqIAE8E2ceSN7W+0oeXBLY3CzZ3mcjQ1aIWKYX04lC6bakrQQ==
Received: from LV3P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::12)
 by DS1PR19MB8620.namprd19.prod.outlook.com (2603:10b6:8:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 09:08:35 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::9f) by LV3P220CA0011.outlook.office365.com
 (2603:10b6:408:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 09:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 09:08:33 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.55; Fri, 22 Aug 2025
 02:08:29 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next 1/2] net: maxlinear: Add build support for MxL SoC
Date: Fri, 22 Aug 2025 17:08:08 +0800
Message-ID: <20250822090809.1464232-2-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822090809.1464232-1-jchng@maxlinear.com>
References: <20250822090809.1464232-1-jchng@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS1PR19MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a9b8ed-c6da-4ee9-d82b-08dde15b78b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQtsVOv4kQi2v/44LwYZwX1PXixF1D6gZa5rQOoo6iZRugINN45y24Zc1GuX?=
 =?us-ascii?Q?ijMKUOujb/bzgjN6F2fzfEwptqxD2xNLzv0atpXRbf+0PN3EhLyIhaSf8Lmc?=
 =?us-ascii?Q?nmm5pXZCKdpgvZoqWqofQage+jEMgcapE++qfjPIwLhQAHnDMu7AQvNBxW9B?=
 =?us-ascii?Q?+qlXW2q1XegdRHvIiT4Lckj1NMkvQ3/UL3R+U4N0XqV7WluCoqopzwNz6HMg?=
 =?us-ascii?Q?aYvOH6hSoGbuOfZ6AXUGontHydreoVHN8/mWXmumoF9Z/jxg1oE6833LfKNd?=
 =?us-ascii?Q?qjcufS7ibX1an8NjWbn5XdxiTSwsDtkugDBLvzePrANPmVMc2aFX1iZ4YbE+?=
 =?us-ascii?Q?A7kSSHPPqHR45CggPQf3mrKnpvKrfVmF3Chq56CP5z+JQ0ZOrLS8qVOJxBzS?=
 =?us-ascii?Q?tn4k9/2QF5aXsHbTv5QskWAeFO1laiCx6lPUTKqquICMCVtwRkxYcN5sMcbb?=
 =?us-ascii?Q?Zrsg9z7ni8rL2Tej1k9XYNe0ZBj5dWUqDtq4Va0af2LYvcRQpBU+iOoh7YRB?=
 =?us-ascii?Q?Fs9SNssxARiUwfF9f8pNrsZHXVBfV6+6S8+EBCvIW5mAoHvnCmxoiD+umeOb?=
 =?us-ascii?Q?5Pkk+UfQEG/J5JTZIXbPB1QTcoMewIFapzG3NK7wOkvZ34SdBSjJzrnFYOyx?=
 =?us-ascii?Q?hGRABBFhkjujdu9MuIbcupDXf7OnxJxmR+TSKE6TcZqltyFMN3wavh51u07I?=
 =?us-ascii?Q?NsXWZaglRxWqG70T8gFndmAYNdHvVHGMx541azF6vF1pg5sV0a2JAZFsj82p?=
 =?us-ascii?Q?jPbJ/aQjmb4s7QYckBk2P8vHORU9C10IzfMsOT8+vxVkSEwb8XLmePKu746h?=
 =?us-ascii?Q?boVDT3U5++7URwxknqf3n9ZfYrCB3/lViFZ5yDaiJlgTxe1MAVGMv+9CJvjO?=
 =?us-ascii?Q?gb0jOc2teLWyoGjMmFB0TGOmJrNVD+aTX0ebAl7lReZBvK2nfRTLUAED8ING?=
 =?us-ascii?Q?LuxfOFlCakslI/82+pvp/OWQUcNn+wqpP/YghZ2Gs7uzacMSi5lgfwCFB+DZ?=
 =?us-ascii?Q?izl+16aMsQ4iNxpAnV2CMX6GsEsyPlBSozF1GhbYCe0sCsSU8y+EPC4br3oh?=
 =?us-ascii?Q?GqShehknh8YCOT6UWciz3Xnn+nkomid/s4sQGufic7gRzPy2Fcw0LPCpEOT5?=
 =?us-ascii?Q?3L1NfIEZmdQg8YbGsf+Kp9EKZqHWzTHhmx41mNSoWvfXHb+DLpFaVx6vN9wZ?=
 =?us-ascii?Q?WwQ5NWxZ+EHlcDkz9/5LCROakRw2GNk80uXm1mhJ2a9X8diybHd8CaJRXWl4?=
 =?us-ascii?Q?YevNRD9LPF8ZQPDzUjwBQXkZ4zvJkXXO6dmLNcpkgoVgvJ7dDKeL/XOCOXdV?=
 =?us-ascii?Q?D3q3kOqhT5f5eKkij6wr639zUH/Yd4c9jSDrVgksFtwuQX2Uhgn/Qy8A+FUe?=
 =?us-ascii?Q?2gcaYmRUtNLC/itwMbap8JKBIyUmHr2AC2rGSkGaxenthjIL+efd1BHYZNsQ?=
 =?us-ascii?Q?q5mpNOEbGNR5QsTB0LHKK07/c/9J4JRC?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:08:33.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a9b8ed-c6da-4ee9-d82b-08dde15b78b8
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR19MB8620

Add build infrastructure for MxL network driver.
Ethernet driver to initialize and create network devices.

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/maxlinear/mxl.rst |  72 ++++++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/maxlinear/Kconfig        |  15 ++
 drivers/net/ethernet/maxlinear/Makefile       |   6 +
 drivers/net/ethernet/maxlinear/mxl_eth.c      | 205 ++++++++++++++++++
 8 files changed, 308 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
 create mode 100644 drivers/net/ethernet/maxlinear/Kconfig
 create mode 100644 drivers/net/ethernet/maxlinear/Makefile
 create mode 100644 drivers/net/ethernet/maxlinear/mxl_eth.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 0b0a3eef6aae..91820ddc6e7b 100644
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
index 000000000000..7d1a8e415a4a
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
@@ -0,0 +1,72 @@
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
+Driver Location
+===============
+
+The driver source code is located in the kernel tree at:
+  drivers/net/ethernet/maxlinear/
+
+Interfaces are created as standard Linux `net_device` interfaces:
+
+- eth0, eth1 (up to 2)
+- Multiqueue support (e.g., eth0 has multiple TX/RX queues)
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
index bce96dd254b8..9164ba07a9c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15101,6 +15101,13 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-maxiradio*
 
+MAXLINEAR ETHERNET DRIVER
+M:	Jack Ping Chng <jchng@maxlinear.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/ethernet/maxlinear/*
+F:	drivers/net/ethernet/maxlinear/
+
 MAXLINEAR ETHERNET PHY DRIVER
 M:	Xu Liang <lxu@maxlinear.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7..94d0bb98351a 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -33,6 +33,7 @@ source "drivers/net/ethernet/aquantia/Kconfig"
 source "drivers/net/ethernet/arc/Kconfig"
 source "drivers/net/ethernet/asix/Kconfig"
 source "drivers/net/ethernet/atheros/Kconfig"
+source "drivers/net/ethernet/maxlinear/Kconfig"
 
 config CX_ECAT
 	tristate "Beckhoff CX5020 EtherCAT master support"
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
index 000000000000..48ba1bff923d
--- /dev/null
+++ b/drivers/net/ethernet/maxlinear/mxl_eth.c
@@ -0,0 +1,205 @@
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
+static const char * const clk_names = "ethif";
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
+	snprintf(ndev->name, IFNAMSIZ, "eth%%d");
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
+static void mxl_eth_cleanup(struct mxl_eth_drvdata *pdata)
+{
+	int i;
+
+	for (i = 0; i < MXL_NUM_PORT && pdata->ndevs[i]; i++) {
+		unregister_netdev(pdata->ndevs[i]);
+		pdata->ndevs[i] = NULL;
+	}
+
+	if (!IS_ERR(pdata->clks))
+		clk_disable_unprepare(pdata->clks);
+}
+
+static int mxl_eth_probe(struct platform_device *pdev)
+{
+	struct mxl_eth_drvdata *pdata;
+	struct reset_control *rst;
+	struct net_device *ndev;
+	struct device_node *np;
+	int ret, i;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->clks = devm_clk_get(&pdev->dev, clk_names);
+	if (IS_ERR(pdata->clks)) {
+		dev_err(&pdev->dev, "failed to get %s\n", clk_names);
+		return PTR_ERR(pdata->clks);
+	}
+
+	ret = clk_prepare_enable(pdata->clks);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable %s\n", clk_names);
+		return ret;
+	}
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
+	platform_set_drvdata(pdev, pdata);
+
+	i = 0;
+	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		if (!of_device_is_compatible(np, "mxl,eth-mac"))
+			continue;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		ret = mxl_eth_create_ndev(pdev, np, &ndev);
+		if (ret)
+			goto err_cleanup;
+
+		pdata->ndevs[i++] = ndev;
+		if (i >= MXL_NUM_PORT)
+			break;
+	}
+
+	return 0;
+
+err_cleanup:
+	mxl_eth_cleanup(pdata);
+	return ret;
+}
+
+static void mxl_eth_remove(struct platform_device *pdev)
+{
+	struct mxl_eth_drvdata *pdata = platform_get_drvdata(pdev);
+
+	mxl_eth_cleanup(pdata);
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


