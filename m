Return-Path: <netdev+bounces-218268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDAB3BBA2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01C1A223AD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0631A055;
	Fri, 29 Aug 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="3Zn/eAjj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1C1D61BB;
	Fri, 29 Aug 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471764; cv=fail; b=ssfjNk9ATOgkSiALgWQuaigT1e9Uv7epw5h96WB7r8o6ilXSgAROo+6fU5y2XPEI3M88owZhzMslqzcd9K6AQTDlXiMIBD8H/dQQyEx/esvDE194I+2qRMlWA+WIqSMKTLNor0ZPB9d9Re1uNkAUTbLdIDzhBppxj8VQXP03KIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471764; c=relaxed/simple;
	bh=dH/aH+GTykPiHX1JrWawjOz3PN1SJsWGDNWu+ae6kQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPDCxKWtSWGyS6nN1UylT1/JfNZI2QY3JNAMX3sK8g6x9BMiRe82IbNxFPUeED/EJxD1UP1z8YnLw3pleAMgJxgTpAIBJZWT7xvju4CzKd9MP+aU1ze2vN3WA+P/+SKjVhgjq4azFZVsMpNV22us1ImjLvlv7AVP36Y1tmfwhrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=3Zn/eAjj; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNY2/4lyGm0QQjXx95SOhHSNg+Z4dNqqq5syZsIc3nvTMpeD8a/w+M+ElFxlOQzSVI8LQz5SWswybsdUS8hoiN/DKNSlL5YXerV8r4vQlF1xmnf8fI6lizxNCUzBL11ze7t/wI1OvNsQ4QDZA8py+4zl2vAAVIqRPvO5cNY7LtLMxSfNqK0UysNsB3xzvvdMKuanGJa+17E6vQkqqHcV8X8QKg6cYkOMGSqUhrkh0SEUK/bPA3Ug3pANPLvqqE8j1HC15ik5AFHJBNw9RoDXf10xxN9L6CXmirrpcXrxccizI2EJMSgj1HIYRBz0qG7soQNVm+LfhrR6/VczIX0GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LEXzeH6T/ypsw3Vct8KhVQDb4RmsP3Mp4nxGAJiIVY=;
 b=zHwE3kDX+mocznSYtXtT6/dQ9eTilUU6tEHINMoyvnPhM++I+J5DDieLeg76Jnjf+45izFqtJlU3VhwNtPMsJI9NiKnwXaqylk5ObG97NHaZln+Yq+0/W+qPLC27ZwTCRETyXwhDDDX32gQdAB8S6Dfo2tNDTRXXO3whOICKg6c1sNUqN/m/uTQShd8/LpKV8XPK0iCyybNLT+IBNi/d4w3auMhQu7CBF7+9nLz6TBHQBS1pDBRQpgqfZVQah0pXCL6J/vhY+GEY1i0v8WycNGNnXrluqACk+P8zmnDNhyX3bz5FCiUFORH1VTQI6we1OAnTQxxb3FgCYpJ30FH7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.92) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LEXzeH6T/ypsw3Vct8KhVQDb4RmsP3Mp4nxGAJiIVY=;
 b=3Zn/eAjj/tY2ed8vVXcXIQrMAoJolJdJvhhGIxKJu6zYlN+NNycgp5biV+c2mKXflGoTdntbM5EIvlLmXPdwyRgYjBwgBAFgQaQtl+/uXVibWmvLe2xGD/hpi6nzsu3uaC/QNPN+xKWqv5pjzoazbtRhoGQqaeToJoEQ4D8te/FLkS+uu+DqhZsmihya4yw5tZ2z/CwrD/YxhCtoY4NdBkli2xcYEWp55LwcjMds6DoApovKuelVfAmLTHR+KlsAcacnisIFha0rjS5PUnEyl6Yeqvc5kDfaDTegCEic5Z1ulu4kxnshD9+w5GcAsp5UCKt5KtDjTG2if2shdHbU9g==
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by BLAPR19MB4563.namprd19.prod.outlook.com (2603:10b6:208:293::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 12:49:09 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::78) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 12:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.92)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.92 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.92; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.92) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 12:49:08 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.31) with Microsoft SMTP Server id 15.2.1544.25; Fri, 29 Aug 2025
 05:49:03 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM SoC
Date: Fri, 29 Aug 2025 20:48:43 +0800
Message-ID: <20250829124843.881786-3-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829124843.881786-1-jchng@maxlinear.com>
References: <20250829124843.881786-1-jchng@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|BLAPR19MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: a56c7c54-4601-4988-5800-08dde6fa7208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwblW/i5vn/lxTl1Ojte6T3DG9FbLfGHCygA29Sx7C5YriLUSH7d+mO1S4JY?=
 =?us-ascii?Q?AISb0yKJILJp+mBfk1uDvTTEba2391kXglFawd6z3+7ST5kTYc3YMs3cYGvi?=
 =?us-ascii?Q?FRcXiGLt2Y9ugMAZI+lPwlwMuXm8J1/0ati/5JLIVv4AhdwMMAT0wp3onamo?=
 =?us-ascii?Q?rj7VLJ3XAm3ZcStuTFlTL6feamIE5k+fxVx6Je5euSB3+c5XGaHIk/VVla0w?=
 =?us-ascii?Q?DY41ZSTP+r7Ekpn82SdMX6LglPD76IBsCNxDBbUpiepUdAASqxjxA7VByZOy?=
 =?us-ascii?Q?uMLvtq/QF65N80mql8BI4FnHcWxXFylyJooQfZtdl+/Dow7eg9JmFlnHJdxX?=
 =?us-ascii?Q?L9ivJKhVbrKYzE7RgC8geJe9G9Jv22Fkuhm9FRVSq4kgt9WApwEAesFLgbXg?=
 =?us-ascii?Q?Dsw7ns8+KUg7utGfhos556HHpkkjwhQikYpNpznS2te+l6WASQPYkrEzqsgU?=
 =?us-ascii?Q?ukGVm0o25bYB955gpHx5DFmI6i8vpiKGLmP++xH3psDhT11lqaIq9DUsthxn?=
 =?us-ascii?Q?SGHtj83CMTlBQk+he86gTzfbveMp6BvHWO+/yGoWB9RTRNLaYWrg3m8R7id0?=
 =?us-ascii?Q?uTZnDnx/Ly7M7A88/ACatGcrkWrFtHiSgAwivt02dRlKXYC/0rLHrAqh7xtI?=
 =?us-ascii?Q?J5gJEVjSzmvSkVe3MztlK43euySMeZbSByZDNDlRp38axP2Q7eWsYwH/oZ3a?=
 =?us-ascii?Q?STTJG0vMYg/4P4ytwcy2qxc16TMKuwVLaNNFknYrDnBPl4n0b1QJuUGLK8aY?=
 =?us-ascii?Q?0rfb9aa00njmbmn5HFicFalUr7tqShHb3/hf0qP35fkEdupAgeOrmBUWPd5V?=
 =?us-ascii?Q?nP8WUesoAM/3O6y88+gvfJZFxN9/98QdPaPGPvDZSksXCYOXhcMS/1lC9Iau?=
 =?us-ascii?Q?aJIZvssaBhhrKaG+p+/LpN7T1LdKim2Fr64jSi4Dvc3FAKUjtJ56fQl7Rg73?=
 =?us-ascii?Q?VevNJNRMyF1TOKuKS2fN6KeFBkVfCS2j1EsDvON3tI/QTua1Zxc2RX/H7bF4?=
 =?us-ascii?Q?B6UJBao+TpgSeEpKv26SXLyip1ENDidWoYY0uPrFdmdfufX+e7/bapail0yK?=
 =?us-ascii?Q?DgGjNBwxkYiy+2CbR7qjuDha/NR6YgoWWWQqrPy9gHMY72S2yk5Dft9Mnlpr?=
 =?us-ascii?Q?RerTe32w89MAxM+PelNZDT4LRQRrLb5DTKLpsabC6q2uykI3SZ0uTrVxE8GH?=
 =?us-ascii?Q?NnurzNhI4nT+w1FGxrxOg0GnDTmPcboMubRqxcx3WMc401Bmauvepv7thRk1?=
 =?us-ascii?Q?1p2wNvkjMwzjMGsevqWA8y5AzLyOaPDsbIJF4lJPTAPjMQc8s8u01/rbtllt?=
 =?us-ascii?Q?j2xTfzgIoWXpkCMStD1uDIOU2yrww7I/4pan1W79AjTnLBlAdNFRHuX0SS2s?=
 =?us-ascii?Q?sgEEA1uZvyK2CGPnblUsYd/y4dVrPabO7b/CyEtDH0v3oSj4crG/HF0bD7hA?=
 =?us-ascii?Q?TmPHOlMbSg5eprsg2Ca5OEw/tuqTlMcAq0y8lk2FqgKiZ/MNr4+Fdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.92;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-92.static.ctl.one;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 12:49:08.5042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a56c7c54-4601-4988-5800-08dde6fa7208
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.92];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4563

Add mxl_eth driver to introduce the initial implementation of ethernet
support for Maxlinear LGM SoC.
LGM SoC has a multi port MAC controller to interface with the PHY. It also
has a master MDIO interface to control the external MDIO configured
devices.

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/maxlinear/mxl.rst |  49 +++++
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/maxlinear/Kconfig        |  15 ++
 drivers/net/ethernet/maxlinear/Makefile       |   6 +
 drivers/net/ethernet/maxlinear/mxl_eth.c      | 202 ++++++++++++++++++
 8 files changed, 283 insertions(+)
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
index 000000000000..cb25b9da2579
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
@@ -0,0 +1,49 @@
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
+It is designed to operate in high-throughput applications.
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
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..d1475db89d86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15102,6 +15102,14 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-maxiradio*
 
+MAXLINEAR ETHERNET DRIVER
+M:	Jack Ping Chng <jchng@maxlinear.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/maxlinear,lgm-eth.yaml
+F:	Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
+F:	drivers/net/ethernet/maxlinear/
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
index 000000000000..036a800efe18
--- /dev/null
+++ b/drivers/net/ethernet/maxlinear/mxl_eth.c
@@ -0,0 +1,202 @@
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
+#define MXL_NUM_PORT		4
+
+struct mxl_eth_drvdata {
+	struct net_device *ndevs[MXL_NUM_PORT];
+	void __iomem *port_base;
+	void __iomem *ctrl_base;
+	struct clk *clks;
+};
+
+struct eth_priv {
+	struct platform_device *pdev;
+	struct device_node *np;
+	int port_id;
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
+	if (of_property_read_u32(np, "reg", &priv->port_id) < 0) {
+		dev_err(&pdev->dev, "failed to get port id\n");
+		return -EINVAL;
+	}
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
+	struct device_node *eth_np, *np;
+	struct reset_control *rst;
+	int ret, i = 0;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->port_base =
+		devm_platform_ioremap_resource_byname(pdev, "port");
+	if (IS_ERR(drvdata->port_base))
+		return PTR_ERR(drvdata->port_base);
+
+	drvdata->ctrl_base =
+		devm_platform_ioremap_resource_byname(pdev, "ctrl");
+	if (IS_ERR(drvdata->ctrl_base))
+		return PTR_ERR(drvdata->ctrl_base);
+
+	drvdata->clks = devm_clk_get_enabled(&pdev->dev, "ethif");
+	if (IS_ERR(drvdata->clks))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->clks),
+				     "failed to get/enable clock\n");
+
+	rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
+				     "failed to get reset control\n");
+
+	reset_control_assert(rst);
+	udelay(1);
+	reset_control_deassert(rst);
+
+	platform_set_drvdata(pdev, drvdata);
+
+	eth_np = of_get_child_by_name(pdev->dev.of_node, "ethernet-ports");
+	if (!eth_np)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "no ethernet-ports node found!\n");
+
+	for_each_available_child_of_node(eth_np, np) {
+		ret = mxl_eth_create_ndev(pdev, np, &drvdata->ndevs[i++]);
+		if (ret) {
+			of_node_put(np);
+			goto err_cleanup;
+		}
+
+		if (i >= MXL_NUM_PORT) {
+			of_node_put(np);
+			break;
+		}
+	}
+
+	if (!i)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "no valid ethernet port\n");
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
+	{ .compatible = "maxlinear,lgm-eth" },
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


