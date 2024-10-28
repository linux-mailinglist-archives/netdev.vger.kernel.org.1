Return-Path: <netdev+bounces-139703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42E9B3DED
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E1D1C221FF
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26781F4FB4;
	Mon, 28 Oct 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="Oevf2PXT";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="Sw1RPfZh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000e8d01.pphosted.com (mx0a-000e8d01.pphosted.com [148.163.147.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300A1F4272;
	Mon, 28 Oct 2024 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155302; cv=fail; b=cgL8eTiJE9UwBTRCH+nrtvbJ2eCfGWVUEBhD/USKCF8jMUyYtXfSe9D5JS4aG3a/D5jFihW/lnyPNY1A5IA/ThiPMHc6Vv3MAGva5KCor8QUI+p9jM49jc9z4Q/Z/XW6PBEQ0R21R4G2WWv9efIQuAndW8H4qfOTBsjnKlkpW6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155302; c=relaxed/simple;
	bh=yeHoSaZqP9V6AwYehPJvZGRDnQO6U/RlmHiXAAC11Gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cB3qrbFR1CFcE2AaFukftNn2S1Y8elmAY9U+bwYbpRjqoXmilWepb+oSF0MYyDYBxSjkRtUgPKWUH7RMK0RxAEeY7zT1EoG/SqzFcQo4fA8ApnlOU89Cq5WxH2NWMBg3a+pLtU9ioL/Z4N8GFiIPu6QKxK4db/YQxTb0rhQxEz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=Oevf2PXT; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=Sw1RPfZh; arc=fail smtp.client-ip=148.163.147.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Received: from pps.filterd (m0136172.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SMPudO027275;
	Mon, 28 Oct 2024 15:35:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=j3od8
	AwGrO4pUkZLbshaT/aM4CBJkImUJRU7LkqAGro=; b=Oevf2PXTgSgDmZBm/czoE
	1R/pPfkVBm3X/jG66s+4+e6262Dtne+HqK4esvbjusKdmSSQEytNZdxWXyoQZ8HY
	uSF4IcWsBd4ck0XUPECxAgDGmLEmnvmwzhfPY4GfblBkXf1oLdRAhsvxbjHkwnlT
	itasnvsSGZT6egsFFwFElWJWAP5l+3cCSTY4LYKUYnMPx9yzjJxyQU+vGmKjHlwU
	eATtcTStYlMS0NbbEd3pDq+pyViwjE7OqY/r09kuiy+tXUkoKTI1AWFguTVlCcvm
	7Uc3lnSoJXu6OC4VFuXyQxdh+Ccyh0Es/0Eck05mBmnUh21FX6Gf63yIleNmIJIb
	A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 42jgerr57w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 15:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcaBtFnpfp62utsz1a5B9DM5o5VnOFkUS3WrpN4qEYkVMGR639dvJU/+IAglwMVHydesEq8tRjxADH3utmx77WYAjHKs7KMzpbSvxaZwilwqlaD9CWP86CV3dUaMiq3HYZHwKeOr4Bd+IBfhKl3lRJ/6roRnc2SWqtrork3283SkiBKpqe61FuqHxsQfjey6XQ06sBm6WA4q31PwGmRnPGpafiPF7/aXOP04dN2Zz4lo7R8hz+jqa/1K+UbQtPScEqcT5iCc6coEgJsBlwS7tdU2Q9B1RDMWiHA1V7oib3UXzMNP8uDRugXFgY/bvD1cB07WqH2AFdLgwsdUUthEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3od8AwGrO4pUkZLbshaT/aM4CBJkImUJRU7LkqAGro=;
 b=OIlcapyTV4YD+BquE7XqkdUz7FA6F59FosUeGLhbBzmd2TEPlc723qzEoJ49oLe+zk1hub9rO2hhPTJu/JIZ/QI8oR6sJ8W4KSo6UE3LlcV/g4K44PPS7RiItkhT3Sv1AfcmOH+SROlQL4Te7w7xycK9mcgeDrKvzYJl1msSSlskIVSaUGRH9KzUwYMXv5XpZ3T4ilUY7+7xAh6ZCb9JgTBQyWmZlXoRQUXJ0gZPcZNfTyq3a/XmZj7SLDVmDFIW3XzD5EFWdV4w9UrZGqsweR/+ESgZ3yhDmRZeO+CFt8rejYdqx1BZNPGLVfhfRcOnjmbCOJgCt+7kyUDjE9MQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3od8AwGrO4pUkZLbshaT/aM4CBJkImUJRU7LkqAGro=;
 b=Sw1RPfZhzIliWHCmlrrEDi5gflkzGGv7xr1E1FEOEqUbUiOk/E5fAgxSl8ckgZDDRnYiPJ49GHPY15fJ7suN3h0kzOZdlKRI9MEszA11mKUPPjQpQPlfg1sqXjrqfy15K40LZzNrt7KxqONg2yN65LACn2tWAuW33PNWJqZrn3b+3x/jpXSwauksKjjONyreLiKcfIr8NXFAJSs6e4QRjrcWH5wDEAySi4wOTzx9jHB5VOoJ4cuLG52Des5rIHiZMe8GAShJhj0zCMU0fS6y0E5TANQr8uCdnBHfjeiozh/V6pAymr1prUg+V0VffPyjivS1LtXn/lO9v/iH/ge8Ow==
Received: from CH0PR03CA0413.namprd03.prod.outlook.com (2603:10b6:610:11b::11)
 by MN0PR22MB3668.namprd22.prod.outlook.com (2603:10b6:208:37b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 22:35:14 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::9e) by CH0PR03CA0413.outlook.office365.com
 (2603:10b6:610:11b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 22:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 22:35:14 +0000
Received: from pig.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.24) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 28 Oct 2024 15:35:10 -0700
From: Robert Joslyn <robert_joslyn@selinc.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <lee@kernel.org>, Robert Joslyn <robert_joslyn@selinc.com>
Subject: [RFC PATCH 1/2] mfd: Add SEL PCI Virtual Multifunction (PVMF) support
Date: Mon, 28 Oct 2024 15:35:07 -0700
Message-ID: <20241028223509.935-2-robert_joslyn@selinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028223509.935-1-robert_joslyn@selinc.com>
References: <20241028223509.935-1-robert_joslyn@selinc.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|MN0PR22MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb1f027-8450-4c07-bcd3-08dcf7a0ca90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBmfn1sV3d8+5lIfsgJcBYNGwFkNRHvqxOFdDcyJFQ3h0YLLBYDHOcQbu74r?=
 =?us-ascii?Q?w52p5v0HOx+eUfTfmM8mmEekU7ToVsl7oFpza3VgqIRr8foL5xneQGTK2cCZ?=
 =?us-ascii?Q?iAOoPKVdkgysp5DfYWRvn+SlHyC4L2r80X+QFIES6UQendqDuimRDiw7zoQX?=
 =?us-ascii?Q?fMaZGBLYArCZ8Gtqw2Omof1LAZ0V7H1kZ+AI+oY/zGNSqA7cpwFCyBEr1ojL?=
 =?us-ascii?Q?Aa7xjNxc0UqB7DEkx4E5HUEO7j2gHoLXRvh9CgXToxClCu4UZCstlaBbA4tv?=
 =?us-ascii?Q?tuFO2ftKIHtXwa1JyPLRvxm0ut013OUs3DfOjEdFaYZpF6XOyikw3Qtsx4Y4?=
 =?us-ascii?Q?4nEoPv6gYyhNOhQCwVtvJV9pTl5v1lAaneY9hNwmTXENtmCBag7KAb5QCgqd?=
 =?us-ascii?Q?8D3OPMeVOoYH7JsIL7mldTTTDyno4C3j1TwOOONH1186YpLm0NzO2TH0R2Eh?=
 =?us-ascii?Q?DZzAVTkInvSin/z8izBidjSqhtfnGHTQEcJXzjN4JyvnTRrJNONUMyu1Xn5l?=
 =?us-ascii?Q?3qnu4nli6XjCnDG4ftSzl+1Nmz8pEfoBoc7eZwe6D/T2SmGeoZ/O37yROHfA?=
 =?us-ascii?Q?B1/se/tpo+7fRfuYPPKNLei8ue6j6fJg8fj1VLLDX9bhxUD0X6II+E/HqFiE?=
 =?us-ascii?Q?NSFg3XEoZudXmoK5XKjyCJbesqmd0tKGcx0xQQIJrSVyUPCcFQABCNMyrB1d?=
 =?us-ascii?Q?yRqupU5dQIPNaPmo36v5knXOkcP4fHX8LTh+aT96FBfTeP3k3wOzINgxJev1?=
 =?us-ascii?Q?Kaeua+xA6+aZ5YqF8BiuUB8BFVX/HsI1qWMkO6Y/8QvBx+J/jlhoyXad4pB4?=
 =?us-ascii?Q?toxRrVxL6zP1P7lANYFdSJXXFfOgczXi9iJj/KXeMQ+m50958oMJ+kGC/REf?=
 =?us-ascii?Q?+o/3nvMKbwox+Bz826CEoVF8+xF9VTmOhPstP31bK0hYZQ7y0hHk1bu6lOWD?=
 =?us-ascii?Q?mwYmT0E1icDgTmZYyvbwfXCmoU+w575s2PQ2wDoV8A2khNmZrcGFLGmsJ6mF?=
 =?us-ascii?Q?rC5VPDX92kXodT1u6lYfDT8t8CSkPX4Va1OPiT2DIIxB2f+GohNbUKu1AxJv?=
 =?us-ascii?Q?B5xZbxtRKvrqjWO6Ibr0ahnNq4eRdMWtFGm/x/lHxFEpM6Z1j7WgHFL0NcDc?=
 =?us-ascii?Q?Wkny9dUwrsw+sUZajFT6OPsr5fVFChYI22a21mQ3i9QFvdjE1SAs7Sezvt1T?=
 =?us-ascii?Q?UL6T1d+jMHd13UefykvGDcGPFi39+HUKwXqlevXw4kgf/TfKAQ6tl2UGZDSv?=
 =?us-ascii?Q?qloB/v3y4XDk8hoeXTWSjX7SBKGe7456T7mtOnEAcf1bl3YCIUagEUMcptMG?=
 =?us-ascii?Q?GfdJ7h7fb+KeOExR1gwFwCvjN02j3ifH0byvqcjiCWpXAQx4x6Mca5707pvP?=
 =?us-ascii?Q?vSUeTs5xheYPROGlw6z4/RCQ8V61mUyE3FjOt+TrBr++5/rtOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:74.117.212.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:email.selinc.com;PTR:wpul-exchange1.selinc.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 22:35:14.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb1f027-8450-4c07-bcd3-08dcf7a0ca90
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec;Ip=[74.117.212.83];Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB3668
X-Proofpoint-ORIG-GUID: fHv4Mdj3QcR1Laoc_WtDqNMoAkHG5Mft
X-Proofpoint-GUID: fHv4Mdj3QcR1Laoc_WtDqNMoAkHG5Mft
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280177

Add support for SEL FPGA based PCIe devices. These expose a single PCI
BAR with multiple IP cores for various functions, such as serial ports,
ethernet, and time (PTP/IRIG). This initial driver supports Ethernet on
the SEL-3350 mainboard, SEL-3390E4 ethernet card, and SEL-3390T ethernet
and time card.

Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>
---
 MAINTAINERS                |   8 +
 drivers/mfd/Kconfig        |  16 ++
 drivers/mfd/Makefile       |   3 +
 drivers/mfd/selpvmf-core.c | 482 +++++++++++++++++++++++++++++++++++++
 drivers/mfd/selpvmf-cvp.c  | 431 +++++++++++++++++++++++++++++++++
 drivers/mfd/selpvmf-cvp.h  |  18 ++
 6 files changed, 958 insertions(+)
 create mode 100644 drivers/mfd/selpvmf-core.c
 create mode 100644 drivers/mfd/selpvmf-cvp.c
 create mode 100644 drivers/mfd/selpvmf-cvp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a27407950242..4a24b3be8aa5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20730,6 +20730,14 @@ F:	tools/testing/selftests/lsm/
 X:	security/selinux/
 K:	\bsecurity_[a-z_0-9]\+\b
 
+SEL DRIVERS
+M:	Robert Joslyn <robert_joslyn@selinc.com>
+S:	Supported
+B:	mailto:opensource@selinc.com
+F:	drivers/mfd/selpvmf-*
+F:	drivers/platform/x86/sel3350-platform.c
+F:	include/linux/mfd/selpvmf.h
+
 SELINUX SECURITY MODULE
 M:	Paul Moore <paul@paul-moore.com>
 M:	Stephen Smalley <stephen.smalley.work@gmail.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f9325bcce1b9..77e2ce3db505 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2402,5 +2402,21 @@ config MFD_RSMU_SPI
 	  Additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_SELPVMF
+	tristate "SEL PVMF Support"
+	help
+	  Support for SEL PCI virtual multifunction (PVMF) devcies utilizing
+	  an FPGA based PCIe interface, including:
+	    * SEL-3350
+	    * SEL-3390E4
+	    * SEL-3390T
+
+	  This driver provides common support for accessing the device.
+	  Additional drivers must be enabled in order to use the functionality
+	  of the device.
+
+	  This driver can be built as a module. If built as a module it will be
+	  called "selpvmf".
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2a9f91e81af8..198e43ef7a51 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -289,3 +289,6 @@ obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
 
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
+
+selpvmf-objs			:= selpvmf-core.o selpvmf-cvp.o
+obj-$(CONFIG_MFD_SELPVMF)	+= selpvmf.o
diff --git a/drivers/mfd/selpvmf-core.c b/drivers/mfd/selpvmf-core.c
new file mode 100644
index 000000000000..ec3e65fe8064
--- /dev/null
+++ b/drivers/mfd/selpvmf-core.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2017 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/property.h>
+#include <linux/mfd/core.h>
+
+#include "selpvmf-cvp.h"
+
+#define PCI_VENDOR_ID_SEL	0x1aa9
+#define PCI_DEVICE_ID_B1190	0x0014 /* SEL-3390T */
+#define PCI_DEVICE_ID_B2093	0x0015 /* SEL-3350 mainboard */
+#define PCI_DEVICE_ID_B2077	0x0018 /* SEL-3390E4 */
+#define PCI_DEVICE_ID_B2091	0x0019 /* SEL-2241-2 */
+
+#define B1190_NUM_ETHERNET 2
+#define B2077_NUM_ETHERNET 4
+#define B2091_NUM_ETHERNET 5
+#define B2093_NUM_ETHERNET 5
+#define SELETH_NUM_RESOURCES 4
+
+#define SELETH_LEN	0x1000
+
+static bool skipcvp;
+module_param(skipcvp, bool, 0644);
+MODULE_PARM_DESC(skipcvp, "Skip firmware load via CvP.");
+
+/**
+ * sel_create_cell() - Create an MFD cell and add it to the device.
+ * @pdev: The PCI device to operate on
+ * @name: MFD cell name
+ * @start: Start address of memory resource
+ * @length: Length of memory resource
+ * @msix_start: MSIX vector number to start from.
+ * @resources: Pointer to resources to add to the cell.
+ * @num_resources: Number of resources. The first resource is assumed to
+ *                 be memory, all other resources are IRQs.
+ */
+static int sel_create_cell(struct pci_dev *pdev,
+			   const char *name,
+			   unsigned int start,
+			   unsigned int length,
+			   unsigned int msix_start,
+			   struct resource *resources,
+			   unsigned int num_resources)
+{
+	struct mfd_cell cell;
+	unsigned int msix;
+	int rc;
+	int i;
+
+	if (!resources || num_resources < 1)
+		return -EINVAL;
+
+	/* If MSI-X is enabled, assume we're using it and start at the
+	 * provided vector number and iterate through the interrupts
+	 * when adding IRQ resources. Otherwise leave the interrupt
+	 * index at zero for legacy IRQs.
+	 */
+	if (pdev->msix_enabled)
+		msix = msix_start;
+	else
+		msix = 0;
+
+	/* First resource is always a memory resource */
+	resources[0].start = start;
+	resources[0].end = start + length - 1;
+	resources[0].flags = IORESOURCE_MEM;
+
+	/* Any additional resources are IRQs */
+	for (i = 1; i < num_resources; i++) {
+		resources[i].start = pci_irq_vector(pdev, msix);
+		resources[i].end = pci_irq_vector(pdev, msix);
+		resources[i].flags = IORESOURCE_IRQ;
+		if (pdev->msix_enabled)
+			msix++;
+	}
+
+	cell.name = name;
+	cell.num_resources = num_resources;
+	cell.resources = resources;
+
+	rc = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell,
+			     1, NULL, 0, NULL);
+
+	return rc;
+}
+
+/**
+ * create_eth_cell - Create and add an MFD cell for an selnet component
+ *
+ * @pdev: PCI device
+ * @offset: Offset from BAR 0 of the component
+ * @msix_num: Starting MSI-X vector number
+ */
+static int create_eth_cell(struct pci_dev *pdev,
+			   unsigned int offset,
+			   unsigned int msix_num)
+{
+	struct resource resources[SELETH_NUM_RESOURCES] = {0};
+
+	return sel_create_cell(pdev,
+			       "selpcimac",
+			       pdev->resource[0].start + offset,
+			       SELETH_LEN,
+			       msix_num,
+			       resources,
+			       SELETH_NUM_RESOURCES);
+}
+
+/**
+ * b1190_alloc_mfd_cells - Allocate and initialize MFD cell descriptions
+ *
+ * @pdev: PCI device for the b1190
+ *
+ * +----------------------------------------+
+ * |          | Resources |     Address     |
+ * |  Device  | Mem | IRQ | Start  | Length |
+ * |----------+-----+-----+--------+--------|
+ * | Ethernet |  1  |  3  | 0x0000 | 0x1000 |
+ * | Ethernet |  1  |  3  | 0x1000 | 0x1000 |
+ * | seltime  |  1  |  1  | 0x3000 | 0x1000 |
+ * | upgrades |  1  |  0  | 0x4000 | 0x4000 |
+ * +----------------------------------------+
+ */
+static int b1190_alloc_mfd_cells(struct pci_dev *pdev)
+{
+	unsigned int offset;
+	int rc;
+	int i;
+
+	/* Ethernet */
+	offset = 0x0000;
+	for (i = 0; i < B1190_NUM_ETHERNET; i++) {
+		rc = create_eth_cell(pdev, offset, i * 3);
+		if (rc)
+			goto out_fail;
+		offset += SELETH_LEN;
+	}
+
+out_fail:
+	return rc;
+}
+
+/**
+ * b2077_alloc_mfd_cells - Allocate and initialize MFD cell descriptions
+ *
+ * @pdev: PCI device for the b2077
+ *
+ * +----------------------------------------+
+ * |          | Resources |     Address     |
+ * |  Device  | Mem | IRQ | Start  | Length |
+ * |----------+-----+-----+--------+--------|
+ * | Ethernet |  1  |  3  | 0x0000 | 0x1000 |
+ * | Ethernet |  1  |  3  | 0x1000 | 0x1000 |
+ * | Ethernet |  1  |  3  | 0x2000 | 0x1000 |
+ * | Ethernet |  1  |  3  | 0x3000 | 0x1000 |
+ * | upgrades |  1  |  0  | 0x8000 | 0x4000 |
+ * | seltime  |  1  |  1  | 0xc000 | 0x1000 |
+ * +----------------------------------------+
+ */
+static int b2077_alloc_mfd_cells(struct pci_dev *pdev)
+{
+	unsigned int offset;
+	int rc;
+	int i;
+
+	/* Ethernet */
+	offset = 0x0000;
+	for (i = 0; i < B2077_NUM_ETHERNET; i++) {
+		rc = create_eth_cell(pdev, offset, i * 3);
+		if (rc)
+			goto out_fail;
+		offset += SELETH_LEN;
+	}
+
+out_fail:
+	return rc;
+}
+
+/*
+ * b2091_alloc_mfd_cells - Allocate and initialize MFD cell descriptions
+ *
+ * @pdev: PCI device for the b2091
+ *
+ * +------------------------------------------+
+ * |            | Resources |     Address     |
+ * |   Device   | Mem | IRQ | Start  | Length |
+ * |------------+-----+-----+--------+--------|
+ * | Ethernet   |  1  |  3  | 0x0000 | 0x1000 |
+ * | Ethernet   |  1  |  3  | 0x1000 | 0x1000 |
+ * | Ethernet   |  1  |  3  | 0x2000 | 0x1000 |
+ * | Ethernet   |  1  |  3  | 0x3000 | 0x1000 |
+ * | Ethernet   |  1  |  3  | 0x4000 | 0x1000 |
+ * | upgrades   |  1  |  0  | 0x8000 | 0x4000 |
+ * | seltime    |  1  |  1  | 0xc000 | 0x1000 |
+ * | multiuart  |  1  |  1  | 0xf000 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf100 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf200 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf300 | 0x0100 |
+ * +------------------------------------------+
+ */
+static int b2091_alloc_mfd_cells(struct pci_dev *pdev)
+{
+	unsigned int offset;
+	int rc;
+	int i;
+
+	/* Ethernet */
+	offset = 0x0000;
+	for (i = 0; i < B2091_NUM_ETHERNET; i++) {
+		rc = create_eth_cell(pdev, offset, i * 3);
+		if (rc)
+			goto out_fail;
+		offset += SELETH_LEN;
+	}
+
+out_fail:
+	return rc;
+}
+
+/**
+ * b2093_alloc_mfd_cells - Allocate and initialize MFD cell descriptions
+ *
+ * @pdev: PCI device for the b2093
+ *
+ * +------------------------------------------+
+ * |            | Resources |     Address     |
+ * |   Device   | Mem | IRQ | Start  | Length |
+ * |------------+-----+-----+--------+--------|
+ * | Ethernet   |  1  |  3  | 0x0000 | 0x1000 |
+ * | Ethernet   |  1  |  3  | 0x1000 | 0x1000 |
+ * | Ethernet   |  1  |  3  | 0x2000 | 0x1000 |
+ * | Ethernet   |  1  |  3  | 0x3000 | 0x1000 |
+ * | Ethernet   |  1  |  3  | 0x4000 | 0x1000 |
+ * | upgrades   |  1  |  0  | 0x8000 | 0x4000 |
+ * | seltime    |  1  |  1  | 0xc000 | 0x1000 |
+ * | contact IO |  1  |  0  | 0xe000 | 0x1000 |
+ * | multiuart  |  1  |  1  | 0xf000 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf100 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf200 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf300 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf400 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf500 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf600 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf700 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf800 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xf900 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xfa00 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xfb00 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xfc00 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xfd00 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xfe00 | 0x0100 |
+ * | multiuart  |  1  |  1  | 0xff00 | 0x0100 |
+ * +------------------------------------------+
+ */
+static int b2093_alloc_mfd_cells(struct pci_dev *pdev)
+{
+	unsigned int offset;
+	int rc;
+	int i;
+
+	/* Ethernet */
+	offset = 0x0000;
+	for (i = 0; i < B2093_NUM_ETHERNET; i++) {
+		rc = create_eth_cell(pdev, offset, i * 3);
+		if (rc)
+			goto out_fail;
+		offset += SELETH_LEN;
+	}
+
+out_fail:
+	return rc;
+}
+
+/*
+ * selpvmf_probe() - Probe function for the device.
+ *
+ * @pdev: PCI device being probed.
+ * @ent: Entry in the pci_tbl for the device.
+ *
+ * Return: 0 for success, otherwise the appropriate negative error code
+ */
+static int selpvmf_probe(struct pci_dev *pdev, struct pci_device_id const *ent)
+{
+	typedef int (*alloc_fn_t)(struct pci_dev *pdev);
+	alloc_fn_t alloc_fn = (alloc_fn_t)ent->driver_data;
+	u16 cvp_capable;
+	int num_msix;
+	int rc = 0;
+
+	rc = pcim_enable_device(pdev);
+	if (rc != 0)
+		return rc;
+
+	/* Perform CvP program if necessary */
+	cvp_capable = pci_find_ext_capability(pdev, CVP_CAPABILITY_ID);
+	if (!skipcvp && cvp_capable) {
+		rc = cvp_start(pdev);
+		if (rc != 0) {
+			dev_err(&pdev->dev, "Error: CvP failed: 0x%x\n", rc);
+			goto out_disable;
+		}
+		dev_info(&pdev->dev, "CvP Successful!\n");
+	}
+
+	pci_set_master(pdev);
+
+	/* Only MSI-X and legacy interrupts are supported. Try to get
+	 * MSI-X, if we don't get them all, fall back to legacy.
+	 */
+	num_msix = pci_msix_vec_count(pdev);
+	rc = pci_alloc_irq_vectors(pdev, num_msix, num_msix, PCI_IRQ_MSIX);
+	if (rc != num_msix) {
+		dev_warn(&pdev->dev,
+			 "Failed to get MSI-X, falling back to legacy\n");
+		rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
+		if (rc != 1) {
+			rc = -ENOSPC;
+			goto out_disable;
+		}
+	}
+
+	rc = alloc_fn(pdev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "ERROR: Failed to add child cells\n");
+		goto out_free_irq;
+	}
+
+	dev_info(&pdev->dev, "Successfully added new devices\n");
+	return 0;
+
+out_free_irq:
+	pci_free_irq_vectors(pdev);
+out_disable:
+	pci_clear_master(pdev);
+	return rc;
+}
+
+/*
+ * selpvmf_remove - Remove a selpvmf enabled PCI device from the system
+ *
+ * @pdev: PCI device to be removed
+ */
+static void selpvmf_remove(struct pci_dev *pdev)
+{
+	mfd_remove_devices(&pdev->dev);
+	pci_free_irq_vectors(pdev);
+	pci_clear_master(pdev);
+}
+
+/*
+ * selpvmf_shutdown() - Tears down a selpvmf card.
+ *
+ * @pdev: Pointer to the device structure describing the port.
+ */
+static void selpvmf_shutdown(struct pci_dev *pdev)
+{
+	mfd_remove_devices(&pdev->dev);
+}
+
+/*
+ * selpvmf_suspend - Suspend the device in preparation for entering a
+ * a low power state.
+ *
+ * @dev: Pointer to the device structure describing the port.
+ *
+ * Return: This function always indicates success.
+ *
+ * Most of the work should be handled by the child devices of this
+ * driver. There is no specific action necessary by the card, so when
+ * the child devices are done suspending, just do a generic PCI saving
+ * of state.
+ */
+static int selpvmf_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+/*
+ * selpvmf_resume() - Resume a selpvmf device that has previously been
+ * suspended
+ *
+ * @dev: Pointer to the device structure describing the port.
+ *
+ * Return: This function always indicates success.
+ */
+static int selpvmf_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 cvp_capable;
+	int rc;
+
+	/* Turn the card on by requesting a transition to D0 before
+	 * restoring the PCI device state and enabling the UARTs
+	 */
+	pci_set_power_state(pdev, PCI_D0);
+
+	/* Restore so we can do IOMEM based CvP */
+	pci_restore_state(pdev);
+
+	rc = pcim_enable_device(pdev);
+	if (rc != 0) {
+		/* We are not really supposed to return an error from this
+		 * function, so if the enable fails, just print some info
+		 * to aid in troubleshooting.
+		 */
+		dev_err(&pdev->dev,
+			"Unable to enable the device. Continuing anyway\n");
+	}
+
+	/* Perform CvP program if necessary */
+	cvp_capable = pci_find_ext_capability(pdev, CVP_CAPABILITY_ID);
+	if (!skipcvp && cvp_capable) {
+		pci_save_state(pdev);
+
+		rc = cvp_start(pdev);
+		if (rc != 0) {
+			dev_err(&pdev->dev,
+				"Error: CvP failed (resume): 0x%x\n", rc);
+		}
+		dev_info(&pdev->dev, "CvP done (resume): 0x%x\n", rc);
+
+		pci_restore_state(pdev);
+	}
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops selpvmf_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(selpvmf_suspend, selpvmf_resume)
+};
+
+static struct pci_device_id selpvmf_pci_tbl[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_SEL, PCI_DEVICE_ID_B1190),
+		.driver_data = (kernel_ulong_t)b1190_alloc_mfd_cells,
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_SEL, PCI_DEVICE_ID_B2077),
+		.driver_data = (kernel_ulong_t)b2077_alloc_mfd_cells,
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_SEL, PCI_DEVICE_ID_B2091),
+		.driver_data = (kernel_ulong_t)b2091_alloc_mfd_cells,
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_SEL, PCI_DEVICE_ID_B2093),
+		.driver_data = (kernel_ulong_t)b2093_alloc_mfd_cells,
+	},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, selpvmf_pci_tbl);
+
+static struct pci_driver selpvmf_driver = {
+	.name		= "selpvmf",
+	.id_table	= selpvmf_pci_tbl,
+	.probe		= selpvmf_probe,
+	.remove		= selpvmf_remove,
+	.shutdown	= selpvmf_shutdown,
+	.driver.pm	= pm_ptr(&selpvmf_pm_ops),
+};
+module_pci_driver(selpvmf_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Schweitzer Engineering Laboratories, Inc.");
+MODULE_DESCRIPTION("Multi function driver for enumerating multiple device drivers for a single PCI resource");
+MODULE_DEVICE_TABLE(pci, selpvmf_pci_tbl);
+MODULE_FIRMWARE("sel/1AA9_0014_01.cvp");
+MODULE_FIRMWARE("sel/1AA9_0015_01.cvp");
+MODULE_FIRMWARE("sel/1AA9_0018_01.cvp");
diff --git a/drivers/mfd/selpvmf-cvp.c b/drivers/mfd/selpvmf-cvp.c
new file mode 100644
index 000000000000..e119cce83d7c
--- /dev/null
+++ b/drivers/mfd/selpvmf-cvp.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
+/*
+ * Copyright 2017 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ *
+ * Support for Configuration via Protocol (CvP) on SEL devices using
+ * Altera FPGAs.
+ */
+
+#include <linux/firmware.h>
+#include <linux/pci.h>
+#include <linux/sched.h>
+
+#include "selpvmf-cvp.h"
+
+#define MIN_WAIT 2 /* number of jiffies for unit wait period */
+#define US_PER_JIFFY  (1000000 / HZ) /* number of microseconds per jiffy */
+#define CVP_WAIT_TIMEOUT 1000000 /* Wait timeout in microseconds */
+#define BYTES_PER_DWORD	4
+#define CORE_FIRMWARE_FILE_BASEDIR "sel/"
+#define CORE_FIRMWARE_FILE_EXT ".cvp"
+
+#define CVP_STATUS_OFFSET	0x0000001C
+#define CVP_CONFIG_READY	BIT(18)
+#define CVP_CONFIG_ERROR	BIT(19)
+#define CVP_EN			BIT(20)
+#define USERMODE		BIT(21)
+#define PLD_CLK_IN_USE		BIT(24)
+
+#define CVP_MODE_CONTROL_OFFSET		0x00000020
+#define CVP_MODE			BIT(0)
+#define HIP_CLK_SEL			BIT(1)
+#define CVP_NUMCLKS_MASK		GENMASK(15, 8)
+#define CVP_NUMCLKS_UNCMPRSSD_UNENCRYPT	BIT(8)
+#define CVP_NUMCLKS_COMPRESSED		BIT(11)
+#define CVP_NUMCLKS_ENCRYPTED		BIT(10)
+
+#define CVP_DATA_OFFSET	0x00000028
+
+#define CVP_PROGRAMMING_CTRL_OFFSET	0x0000002C
+#define CVP_CONFIG			BIT(0)
+#define START_XFER			BIT(1)
+
+#define CVP_UNCORRECTABLE_IE_STATUS_OFFSET	0x00000034
+#define CVP_CONFIG_ERROR_LATCHED		BIT(5)
+
+struct cvp_state {
+	int offset;
+	struct firmware const *fw;
+	struct pci_dev *pdev;
+	uint32_t __iomem *bar;
+};
+
+/**
+ * cvp_set_bit() - Sets the bit requested to 1
+ *
+ * @state: Initialized CvP State structure
+ * @offset: The pci capability offset to read the value from
+ * @bit: The bit to read at the pci config space offset
+ */
+static void cvp_set_bit(struct cvp_state *state, uint32_t offset, uint32_t bit)
+{
+	uint32_t reg;
+
+	pci_read_config_dword(state->pdev, state->offset + offset, &reg);
+	reg |= bit;
+	pci_write_config_dword(state->pdev, state->offset + offset, reg);
+}
+
+/**
+ * cvp_clear_bit() - Sets the bit requested to 0
+ *
+ * @state: Initialized CvP State structure
+ * @offset: The pci capability offset to read the value from
+ * @bit: The bit to read at the pci config space offset
+ */
+static void cvp_clear_bit(struct cvp_state *state, uint32_t offset, uint32_t bit)
+{
+	uint32_t reg;
+
+	pci_read_config_dword(state->pdev, state->offset + offset, &reg);
+	reg &= ~(bit);
+	pci_write_config_dword(state->pdev, state->offset + offset, reg);
+}
+
+/**
+ * cvp_read_bit() - Reads the requested bit to determine its state
+ *
+ * @state: Initialized CvP State structure
+ * @offset: The pci capability offset to read the value from
+ * @bit: The bit to read at the pci config space offset
+ *
+ * Return: 1 if the bit is set, 0 if not
+ */
+static int cvp_read_bit(struct cvp_state *state, uint32_t offset, uint32_t bit)
+{
+	uint32_t reg;
+
+	pci_read_config_dword(state->pdev, state->offset + offset, &reg);
+	return ((reg & bit) == 0) ? 0 : 1;
+}
+
+/**
+ * cvp_wait_for_bit() - Reads the requested bit and spins until it
+ * becomes the value requested
+ *
+ * This request will also timeout at the ns value requested by the caller
+ *
+ * @state: Initialized CvP State structure
+ * @offset: The pci capability offset to read the value from
+ * @bit: The bit to read at the pci config space offset
+ * @value: The value the bit needs to be set to in order to return
+ *
+ * Return: 1 if the bit_val became the value requested during the timeout
+ * period. 0 if a timeout occurred.
+ */
+static int cvp_wait_for_bit(struct cvp_state *state,
+			    uint32_t offset,
+			    uint32_t bit,
+			    uint32_t value)
+{
+	uint8_t bit_val;
+	uint32_t n_wait_loops = 1;
+
+	if (CVP_WAIT_TIMEOUT > (US_PER_JIFFY * MIN_WAIT)) {
+		n_wait_loops = (CVP_WAIT_TIMEOUT + (US_PER_JIFFY * MIN_WAIT) - 1) /
+			       (US_PER_JIFFY * MIN_WAIT);
+	}
+
+	DECLARE_WAIT_QUEUE_HEAD(cvp_wq);
+
+	bit_val = cvp_read_bit(state, offset, bit);
+
+	while ((bit_val != value) && (n_wait_loops != 0)) {
+		wait_event_timeout(cvp_wq, 0, MIN_WAIT);
+		bit_val = cvp_read_bit(state, offset, bit);
+		--n_wait_loops;
+	}
+
+	return bit_val == value;
+}
+
+/**
+ * perform_244_dummy_writes() - Performs 244 dummy writes to the hard IP
+ * to clear the CvP state machine.
+ *
+ * @state: Initialized CvP State structure
+ */
+static void perform_244_dummy_writes(struct cvp_state *state)
+{
+	for (int i = 0; i < 244; i++)
+		iowrite32(0xFFFFFFFF, state->bar);
+}
+
+/**
+ * set_numclks() - Updates the CVP_NUMCLKS value in the mode control register
+ *
+ * @state: Initialized CvP State structure
+ * @value: The value to set CVP_NUMCLKS to
+ */
+static void set_numclks(struct cvp_state *state, uint32_t value)
+{
+	uint32_t reg;
+
+	pci_read_config_dword(state->pdev,
+			      state->offset + CVP_MODE_CONTROL_OFFSET,
+			      &reg);
+	reg &= ~(CVP_NUMCLKS_MASK);
+	reg |= (value & CVP_NUMCLKS_MASK);
+	pci_write_config_dword(state->pdev,
+			       state->offset + CVP_MODE_CONTROL_OFFSET,
+			       reg);
+}
+
+/**
+ * cvp_teardown() - Removes the PCI device from its ready to program state
+ *
+ * @state: Initialized CvP State structure
+ *
+ * Return: 0 for success, negative error code if not
+ */
+static int cvp_teardown(struct cvp_state *state)
+{
+	int status = 0;
+	uint32_t bit_val;
+
+	cvp_clear_bit(state, CVP_PROGRAMMING_CTRL_OFFSET, START_XFER);
+	cvp_clear_bit(state, CVP_PROGRAMMING_CTRL_OFFSET, CVP_CONFIG);
+	set_numclks(state, CVP_NUMCLKS_UNCMPRSSD_UNENCRYPT);
+	perform_244_dummy_writes(state);
+
+	if (!cvp_wait_for_bit(state, CVP_STATUS_OFFSET, CVP_CONFIG_READY, 0)) {
+		status = -1;
+		goto exit;
+	}
+
+	bit_val = cvp_read_bit(state,
+			       CVP_UNCORRECTABLE_IE_STATUS_OFFSET,
+			       CVP_CONFIG_ERROR_LATCHED);
+
+	if (bit_val == 1) {
+		cvp_set_bit(state,
+			    CVP_UNCORRECTABLE_IE_STATUS_OFFSET,
+			    CVP_CONFIG_ERROR_LATCHED);
+	}
+
+	cvp_clear_bit(state, CVP_MODE_CONTROL_OFFSET, CVP_MODE);
+	cvp_clear_bit(state, CVP_MODE_CONTROL_OFFSET, HIP_CLK_SEL);
+
+	if (bit_val == 0) {
+		if (!cvp_wait_for_bit(state, CVP_STATUS_OFFSET,
+				      PLD_CLK_IN_USE, 1) ||
+		    !cvp_wait_for_bit(state, CVP_STATUS_OFFSET, USERMODE, 1)) {
+			status = -1;
+		}
+	}
+
+exit:
+	return status;
+}
+
+/**
+ * cvp_program() - Performs the FPGA programming via CvP
+ *
+ * @state: Initialized CvP State structure
+ *
+ * Return: 0 for success, negative error code if not
+ */
+static int cvp_program(struct cvp_state *state)
+{
+	int status = 0;
+	int i;
+
+	uint32_t *firmware_ptr;
+	uint32_t dword_size;
+
+	set_numclks(state, CVP_NUMCLKS_COMPRESSED);
+
+	/*
+	 * The file_read_data function returns a size in bytes,
+	 * cvp_set_reg requires a write of a single dword. Therefore
+	 * calculate a dword size.
+	 */
+	dword_size = (state->fw->size / BYTES_PER_DWORD);
+	if ((state->fw->size % BYTES_PER_DWORD) != 0)
+		dword_size++;
+
+	firmware_ptr = (uint32_t *)state->fw->data;
+	for (i = 0; i < dword_size; i++)
+		iowrite32(firmware_ptr[i], state->bar);
+
+	/* Check if any errors happened during the CvP process */
+	if (cvp_read_bit(state,	CVP_STATUS_OFFSET, CVP_CONFIG_ERROR) == 1)
+		status = -1;
+
+	return status;
+}
+
+/**
+ * cvp_setup() - Performs the CvP setup logic readying the pci device for
+ * programming
+ *
+ * @state: Initialized CvP State structure
+ *
+ * Return: 0 for success, negative error code if not
+ */
+static int cvp_setup(struct cvp_state *state)
+{
+	int status = 0;
+
+	/*
+	 * Make sure the hardware isn't in a state where a previous CvP
+	 * failed. If it did, run teardown to put it back in a pristine
+	 * state.
+	 */
+	if (cvp_read_bit(state, CVP_MODE_CONTROL_OFFSET, CVP_MODE) != 0)
+		cvp_teardown(state);
+
+	cvp_set_bit(state, CVP_MODE_CONTROL_OFFSET, HIP_CLK_SEL);
+	cvp_set_bit(state, CVP_MODE_CONTROL_OFFSET, CVP_MODE);
+	set_numclks(state, CVP_NUMCLKS_UNCMPRSSD_UNENCRYPT);
+	perform_244_dummy_writes(state);
+	cvp_set_bit(state, CVP_PROGRAMMING_CTRL_OFFSET, CVP_CONFIG);
+	if (!cvp_wait_for_bit(state, CVP_STATUS_OFFSET, CVP_CONFIG_READY, 1)) {
+		status = -1;
+		/*
+		 * This may fail, but try to put it back.  Note that we
+		 * aren't waiting for clocks to stabilize after doing
+		 * this, so the device isn't going to be usable.  We are
+		 * assuming the driver is going to bail.
+		 */
+		cvp_clear_bit(state, CVP_MODE_CONTROL_OFFSET, CVP_MODE);
+		cvp_clear_bit(state, CVP_MODE_CONTROL_OFFSET, HIP_CLK_SEL);
+		goto exit;
+	}
+
+	set_numclks(state, CVP_NUMCLKS_UNCMPRSSD_UNENCRYPT);
+	perform_244_dummy_writes(state);
+	cvp_set_bit(state, CVP_PROGRAMMING_CTRL_OFFSET, START_XFER);
+
+exit:
+	return status;
+}
+
+/**
+ * cvp_init() - Initialize the CvP state machine.
+ *
+ * @pdev: Pointer to the pci_device structure containing information
+ *        about the device being initialized
+ * @state: Caller allocated CvP state structure to be initialized.
+ *
+ * Return: 0 if the state was initialized successfully and CvP can be
+ *    executed.  A non-zero exit code will indicate an appropriate error.
+ *
+ *    If the function returns 0, the caller should call cvp_exit to
+ *    cleanup.
+ */
+static int cvp_init(struct pci_dev *pdev, struct cvp_state *state)
+{
+	int status = 0;
+	int value;
+	char filepath[512];
+
+	state->pdev = pdev;
+	state->fw = NULL;
+	state->bar = NULL;
+
+	state->offset = pci_find_ext_capability(pdev, CVP_CAPABILITY_ID);
+	if (!state->offset) {
+		dev_warn(&pdev->dev,
+			 "Device requests CvP but indicating not capable\n");
+		status = -ENODEV;
+		goto exit;
+	}
+
+	value = cvp_read_bit(state, CVP_STATUS_OFFSET, CVP_EN);
+	if (value == 0) {
+		dev_err(&pdev->dev, "CvP not enabled in device\n");
+		status = -ENODEV;
+		goto exit;
+	}
+
+	/*
+	 * BAR 0 will always exist and will always be mmio so we can do
+	 * memory transactions to speed up CvP. Make sure to not map
+	 * more than our first resource. CvP will write to only the
+	 * first address that is mapped so a mapping size of 4 bytes
+	 * should do.
+	 */
+	state->bar = pci_iomap(pdev, 0, 4);
+	if (!state->bar) {
+		dev_err(&pdev->dev, "Memory BAR not available\n");
+		status = -ENODEV;
+		goto exit;
+	}
+
+	/* Create the filepath to request firmware from */
+	snprintf(filepath,
+		 512,
+		 "%s%04X_%04X_%02x%s",
+		 CORE_FIRMWARE_FILE_BASEDIR,
+		 pdev->vendor,
+		 pdev->device,
+		 pdev->revision,
+		 CORE_FIRMWARE_FILE_EXT);
+
+	if (request_firmware(&state->fw, filepath, &pdev->dev)) {
+		dev_err(&pdev->dev,
+			"Error: The driver failed to find a core image for this device at: %s\n",
+			filepath);
+		iounmap(state->bar);
+		state->bar = NULL;
+		status = -ENOENT;
+	}
+
+exit:
+	return status;
+}
+
+/**
+ * cvp_exit() - Cleanup CvP resources
+ *
+ * @state: Initialized CvP state to cleanup.
+ */
+static void cvp_exit(struct cvp_state *state)
+{
+	if (state->fw)
+		release_firmware(state->fw);
+	if (state->bar) {
+		iounmap(state->bar);
+		state->bar = NULL;
+	}
+}
+
+/**
+ * cvp_start() - Public facing function to kick off FPGA programming via CvP
+ *
+ * @pdev: Pointer to the pci_device structure containing information about the
+ *        device being initialized
+ *
+ * Return: 0 for success, otherwise the appropriate negative error code
+ */
+int cvp_start(struct pci_dev *pdev)
+{
+	int status = 0;
+	struct cvp_state state;
+
+	dev_info(&pdev->dev, "Loading device firmware. AER errors may occur during the loading process.\n");
+
+	status = cvp_init(pdev, &state);
+	if (status != 0)
+		goto exit;
+
+	status = cvp_setup(&state);
+	if (status != 0)
+		goto exit;
+
+	/*
+	 * If setup succeeded we need to perform the cvp teardown
+	 * regardless of whether or not the program was successful
+	 */
+	if (cvp_program(&state) != 0)
+		status = -1;
+	if (cvp_teardown(&state) != 0)
+		status = -1;
+
+exit:
+	cvp_exit(&state);
+	return status;
+}
diff --git a/drivers/mfd/selpvmf-cvp.h b/drivers/mfd/selpvmf-cvp.h
new file mode 100644
index 000000000000..32de3b9e9884
--- /dev/null
+++ b/drivers/mfd/selpvmf-cvp.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright 2017 Schweitzer Engineering Laboratories, Inc.
+ * 2350 NE Hopkins Court, Pullman, WA 99163 USA
+ * SEL Open Source <opensource@selinc.com>
+ */
+
+#ifndef _SELPVMF_CVP_H
+#define _SELPVMF_CVP_H
+
+#include <linux/pci.h>
+
+/* Define for CvP in PCI config space */
+#define CVP_CAPABILITY_ID	0x0000000B
+
+int cvp_start(struct pci_dev *pdev);
+
+#endif /* _SELPVMF_CVP_H */
-- 
2.45.2


