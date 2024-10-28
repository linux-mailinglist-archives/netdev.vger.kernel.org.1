Return-Path: <netdev+bounces-139702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C2A9B3DEB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8134B212D1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCA1D88D7;
	Mon, 28 Oct 2024 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="cMDiXmsT";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="ERQzkoal"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000e8d01.pphosted.com (mx0a-000e8d01.pphosted.com [148.163.147.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF79524C;
	Mon, 28 Oct 2024 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155296; cv=fail; b=LQo2263cDTFYgon4NqfSPXaek3JJZ6hxNEpdxpG2fbTZFnRxEJi67uh4w9gItDI+F/4LsrfKfW8CUIaQ8K6KBYPRDL7yGNQULbOljVZ3SX/5yb7p1yu3I75youMN0rcIMUXMA0eqXO2wD77axxQl9czHLDlxK/fHNbQUIEs8yvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155296; c=relaxed/simple;
	bh=XvQgslTuBTWT+/194cfGXdU/2zDEeSLaGy8deFCuOW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mnWczBgkiJmL2vi4ndiQ4GXfV2sI12Bb6TbqAsM6+W1Bg5zRYsBf8ehddm0Wg1/50l9YZrvnUKzb4ryhuUnXbZtsLUZ62EuVweo8l+eoyTGrcior+OqPfOsZALrllDmZfU/Q5ac2IDt1v4noE2abBz9ayfGQJduTdTbMNGbCo7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=cMDiXmsT; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=ERQzkoal; arc=fail smtp.client-ip=148.163.147.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Received: from pps.filterd (m0136171.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SLBpHR002399;
	Mon, 28 Oct 2024 15:35:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=sel1; bh=luiO4oqSSaPt0GT+rwrrTZXKSAe
	YZjJZZxVUPUD9DDc=; b=cMDiXmsT29ECvvyVGM0YUaQlXSIc2j5g10VuZ3riSG5
	XzFiZPCcKZQlagv6aefu9/MYdgXJDSP+Z3r9vUjhFVCzr1oNVpToXU4A4gTsULtQ
	wslpbSgriopozYDTGQuzhr+hBjQcJvcV/duYOeQHI+E5Vp/8hV6fLHWr00pPU1NH
	u598Q3dc4COWgY9oeFk0EVgLzjxbyLd6wOMrapw58c2GmIF6qH94xpM8hbUa4yQb
	q6MSVr05nJs6rrT22R8KbjJAHYrl7gcxNJFUcaY0g6AiZr77RPs9evcjU5K3iewq
	TEDgnrUpBguyKiqVnVD8EComlZNho6fK1ilFz+bCtJw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 42gxbu1hkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 15:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTfJvH9t/co18lJzAFupNFcGR5wLZyzmlHDdf4UMgWp1N6CDtR9vmNyHdd21g1na32WamPTWl5nL2STCOHpKYXbhZQxGd40Nt4eb6CjFyQv2rTeKkR1u+2cavvukfxIE3Y245w9P7uADzeB6dT4ZjG6By65c9AIAzYkpsZNJjBzt8LliIKoXl2jUZVeCsXc8IS8mbBLgxyVS92vgbBFjK98RuPBudhyOPKbGN9bPPrdbDrOziiek5EoQxD5XbksKxZnAqG2KXfDwiKwn97NhcCvvcpI4FCy8A9DbgxbeTIzJbGWBAM6EYU1xbtbgv+TV6F9BEPUz3Ht1woakpCqaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luiO4oqSSaPt0GT+rwrrTZXKSAeYZjJZZxVUPUD9DDc=;
 b=eV6kV356AETE4+y/bV6dXDvbb3KF9cTbNEmbRSb/8J2qB78CaTOoA6T14iLaSRItkwE/AghCaGLfCJ/nIwhiJx92zlWFjDP0Jwxo3iXBesipkzMZbGG/Qz366XkyIvyK5HABpnJLGk8Z5LFv1WYHGWvmflmFNMgRMEkNNwKmkh4Ce6oSSuTefOe8ATDo3V3kOq7T2K+SyBttOSeNRpzrHy0xKUHQtbWv3EVfnvCDaWgNuJfsLGmzj022mxdeWw7lGBXUCmPl+ktOxWel3ySI5//r2cITWAai09zPb7iUaD09y8lWhwwxLgOv4xBvTpKWEFCVG6AWf/HcCcztNJRkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luiO4oqSSaPt0GT+rwrrTZXKSAeYZjJZZxVUPUD9DDc=;
 b=ERQzkoalbY0+b+lhLSHPoo508Bnr6WXz3Y4CMLYAJSoV3kyty/svQL2NnJFAxLQO1jydoXWF4cbfr1kVLUk4FCZlj6vGI5Z5TR0H2I8RDYIr9Gd9fFq/sK3gdy7kyjK/Z/vyHsT8SVTZCih596rMTmaPpVE9HBU3F/MoxZ7LvqTYoSA0lxfVl4Yw7N0ZI755LuiycC652TwJsrOw7lIhQnxTgBDSFCULZGnNzJFxw02oOgBKxq9s/EZq+GKjC3garxDuxJ1DsS+dON4e0g7hBPoy7kgN/soeDeznn8NJzpz3vJhzGioSgYA8t4z5ljQXcLiHvmDqJQf7b8e26BUb2g==
Received: from CH0PR03CA0405.namprd03.prod.outlook.com (2603:10b6:610:11b::15)
 by SA1PR22MB3972.namprd22.prod.outlook.com (2603:10b6:806:327::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 22:35:11 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::d1) by CH0PR03CA0405.outlook.office365.com
 (2603:10b6:610:11b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 22:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 22:35:10 +0000
Received: from pig.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.24) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 28 Oct 2024 15:35:10 -0700
From: Robert Joslyn <robert_joslyn@selinc.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <lee@kernel.org>, Robert Joslyn <robert_joslyn@selinc.com>
Subject: [RFC PATCH 0/2] Add SEL Ethernet Support
Date: Mon, 28 Oct 2024 15:35:06 -0700
Message-ID: <20241028223509.935-1-robert_joslyn@selinc.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SA1PR22MB3972:EE_
X-MS-Office365-Filtering-Correlation-Id: 467c7ae8-739c-4d67-381c-08dcf7a0c865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oFL9lDkcn0QZsoyC2RF7Gho3GPpNePacgRYrys+kfyQJjsEZtNORphht+uCY?=
 =?us-ascii?Q?DrbQ7ahvI17hFLFcRt+Pj7yG1wqfXJAiFIyZQiu2rwLWj7S2BKCpBuQkw38i?=
 =?us-ascii?Q?AUr7qvaoYhMottUizcvTA4Gov/cu0FRi2xkaTcHBkEneJZm62SoJ2PEqa7jb?=
 =?us-ascii?Q?+W3tRcamDiIAKciuaOl9thdKuVxATkY0XapMXUpXO0mPXxNjAZf6n0OzxMiI?=
 =?us-ascii?Q?t5Xvavk17oU3+bvbB5Hk3aOZ+YUy1JEcP1M2lUyO7PTdo5EXrdbtTECgJaGv?=
 =?us-ascii?Q?+EuoYB+EaYQy773LwtOUXBcZnAM2h7bY6Zpm9vv43WtompB4WezrabpCCZOX?=
 =?us-ascii?Q?K7z/o+hHryH3YPHTOdqHYjlSHoG9Eb0AnI0ruvInWVCXJDwr92SX8tRl79S2?=
 =?us-ascii?Q?gY9EiunqX6WJZrM/+Vrwc0Dz0BjM9N4CbbuM3lmkimAC9jsallRFD3I3vpKg?=
 =?us-ascii?Q?3O7+j62fOJLzzI/1xhUXfiTvvLiun8K4za6dKjaj95PRYPo3OXuMg9SP2xDG?=
 =?us-ascii?Q?vzvHlpRofmIbPpxlu/W9LPoN+PDfQmJwRDZEuKNaO68bFJNtehJo4lyGUVh9?=
 =?us-ascii?Q?fXZ0KRrw23C2JD+JmDl+0/hpQEcHGlkqmaQhxxgdU0rPXEBVvxqfQruNIx4c?=
 =?us-ascii?Q?lhkmm0uh/OyB2kHdPjmQpOCMfCbOBACJsYwlx5snhN+e38yNnEMJXlJA+FDy?=
 =?us-ascii?Q?ayMZKuXLQqAGOBaPKOQSyGAmpOz4MN/mkYPtM8or8IuqRKbtYMSDVlIvUHAJ?=
 =?us-ascii?Q?JNjw2hRiq7/vhNdIYAUYqJ/LTQnVl5gXoYrJ8Cg2cqnqgXR0srJHPbmHfKYV?=
 =?us-ascii?Q?WxXhf8vnIClyn2dzfjv/2+oXLIyGhU2n2uR0EJtY2YxgFQSFkyw6mNChdbdz?=
 =?us-ascii?Q?2tN8niXBY50YoaocpKUCqIhlYgGDK4y3b3WlakvcKIu+rc520x5F4rMq9M14?=
 =?us-ascii?Q?OH9j8e3BIHqVHBP/1QxwgGkmmTFm19VbG/EheIaKi8gLY5HqiCz54biVV0Y+?=
 =?us-ascii?Q?u7xi4S594ZFRJ4cdtbSH1/Hd7Cv8k3bkZNWPNis8weepaLcnQMkkqBqqHnsE?=
 =?us-ascii?Q?gFdUaYXYUK299Hpt6bI5OPP6jnMTLUuPmeF3MGV2GnqnAGarUb69cBESO2O1?=
 =?us-ascii?Q?q8kE55vXh9xbXdEQWTwIcjKYMFt3DQjjmR7m3VuisSY5SyfYH2lf2GgRIq49?=
 =?us-ascii?Q?YIntYo677f3M7vKp24Gy37hMkbclC/Mr/acqOISM+0Z433LmRWGZ0DYFJJAC?=
 =?us-ascii?Q?6liYZ4oAv+TJpjtbi721crZrkzjqgzylxBfDmdoMr6fHMqr6dAyK+kfWiTqP?=
 =?us-ascii?Q?F4rh6/viiGUrJ/OcUPN532wCz/mgFk9XxX44O514Bkibaq46hwfPpAhiT7+B?=
 =?us-ascii?Q?8XH77jXtTXetH/QPMTjmvo2zKcOiu2JxDLFNphrlcsjdXFDDaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:74.117.212.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:email.selinc.com;PTR:wpul-exchange1.selinc.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 22:35:10.7422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467c7ae8-739c-4d67-381c-08dcf7a0c865
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec;Ip=[74.117.212.83];Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB3972
X-Proofpoint-ORIG-GUID: b2K2wc52pBrClOKJTzVHky2sFd17dVoH
X-Proofpoint-GUID: b2K2wc52pBrClOKJTzVHky2sFd17dVoH
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280176

This patch series adds initial support for Ethernet on SEL hardware,
including the SEL-3350, SEL-3390E4, and SEL-3390T. We've been
maintaining these drivers out of tree for years and this is our first
attempt at submitting such drivers to mainline. Because of that, I
expect there's room for improvement and have marked this as RFC.

This is implemented in an FPGA running multiple RTL blocks for various
functionality, such as Ethernet and serial ports, exposed over a single
PCIe BAR. The drivers are implemented as a top level MFD driver that
attaches to the PCIe device and enumerates the child drivers necessary
to provide the functionality of the device. Only Ethernet is part of
this patch set, but we intend to submit subsequent drivers for the
additional functionality within the FPGA.

Is MFD still the right framework to use or is Aux Bus a better fit? At
the time these drivers were first written Aux Bus didn't exist, but if
that's the preferred way to go it can be reworked.

PVMF contains an implementation of Configuration via Protocol (CvP),
a method of loading firmware into Altera FPGAs when the driver loads. An
implementation of this does exist in the FPGA manager code, but it's
doesn't appear to expose that functionality in a way we can use:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/altera-cvp.c?h=v6.12-rc5
Should we explore creating a common CvP driver that can be shared?

Presently the Ethernet driver does not use phylib, all phy handling is
done internal to the driver. Most of the phys we use already have
in-tree drivers, so assuming any quirks can be dealt with, it should be
possible for us to integrate with phylib. Is integration with phylib
required before the driver can be accepted? If so, what is a good driver
to use as a reference for us to follow?

I've sent this to both linux-kernel and netdev lists since this touches
MFD and net. Is that the best way to review patches across multiple
subsystems? This series is based on the v6.12-rc5 tag in Linus' tree to
provide consistency between the MFD and net subsystems. When submitting
for inclusion and not just RFC, should it be two separate requests, one
based on the MFD tree and one based on net-next? I'm not sure the best
way to coordinate between the two trees.

Suggestions on improvements to the code or how we're submitting this are
appreciated.

Robert Joslyn (2):
  mfd: Add SEL PCI Virtual Multifunction (PVMF) support
  net: selpcimac: Add driver for SEL PCIe network adapter

 MAINTAINERS                                  |   9 +
 drivers/mfd/Kconfig                          |  16 +
 drivers/mfd/Makefile                         |   3 +
 drivers/mfd/selpvmf-core.c                   | 482 ++++++++++
 drivers/mfd/selpvmf-cvp.c                    | 431 +++++++++
 drivers/mfd/selpvmf-cvp.h                    |  18 +
 drivers/net/ethernet/Kconfig                 |   1 +
 drivers/net/ethernet/Makefile                |   1 +
 drivers/net/ethernet/sel/Kconfig             |  31 +
 drivers/net/ethernet/sel/Makefile            |  22 +
 drivers/net/ethernet/sel/ethtool.c           | 404 ++++++++
 drivers/net/ethernet/sel/ethtool.h           |  17 +
 drivers/net/ethernet/sel/hw_interface.c      | 410 ++++++++
 drivers/net/ethernet/sel/hw_interface.h      |  46 +
 drivers/net/ethernet/sel/mac_main.c          | 155 +++
 drivers/net/ethernet/sel/mdio.c              | 166 ++++
 drivers/net/ethernet/sel/mdio.h              |  15 +
 drivers/net/ethernet/sel/mii.c               | 422 +++++++++
 drivers/net/ethernet/sel/mii.h               |  21 +
 drivers/net/ethernet/sel/mii_interface.c     | 133 +++
 drivers/net/ethernet/sel/mii_interface.h     |  23 +
 drivers/net/ethernet/sel/netdev.c            | 946 +++++++++++++++++++
 drivers/net/ethernet/sel/netdev.h            |  24 +
 drivers/net/ethernet/sel/netdev_isr.c        | 245 +++++
 drivers/net/ethernet/sel/netdev_isr.h        |  20 +
 drivers/net/ethernet/sel/netdev_rx.c         | 785 +++++++++++++++
 drivers/net/ethernet/sel/netdev_rx.h         |  17 +
 drivers/net/ethernet/sel/netdev_tx.c         | 647 +++++++++++++
 drivers/net/ethernet/sel/netdev_tx.h         |  22 +
 drivers/net/ethernet/sel/pci_mac.h           | 290 ++++++
 drivers/net/ethernet/sel/pci_mac_hw_regs.h   | 370 ++++++++
 drivers/net/ethernet/sel/pci_mac_sysfs.c     | 642 +++++++++++++
 drivers/net/ethernet/sel/pci_mac_sysfs.h     |  14 +
 drivers/net/ethernet/sel/sel_pci_mac_ioctl.h |  25 +
 drivers/net/ethernet/sel/sel_phy.h           |  91 ++
 drivers/net/ethernet/sel/sel_phy_broadcom.c  | 316 +++++++
 drivers/net/ethernet/sel/sel_phy_broadcom.h  |  15 +
 drivers/net/ethernet/sel/sel_phy_marvell.c   | 458 +++++++++
 drivers/net/ethernet/sel/sel_phy_marvell.h   |  15 +
 drivers/net/ethernet/sel/sel_phy_ti.c        | 419 ++++++++
 drivers/net/ethernet/sel/sel_phy_ti.h        |  14 +
 drivers/net/ethernet/sel/sel_soft_phy.c      |  98 ++
 drivers/net/ethernet/sel/sel_soft_phy.h      |  15 +
 drivers/net/ethernet/sel/semaphore.h         |  85 ++
 drivers/net/ethernet/sel/sfp.c               | 615 ++++++++++++
 drivers/net/ethernet/sel/sfp.h               |  61 ++
 46 files changed, 9075 insertions(+)
 create mode 100644 drivers/mfd/selpvmf-core.c
 create mode 100644 drivers/mfd/selpvmf-cvp.c
 create mode 100644 drivers/mfd/selpvmf-cvp.h
 create mode 100644 drivers/net/ethernet/sel/Kconfig
 create mode 100644 drivers/net/ethernet/sel/Makefile
 create mode 100644 drivers/net/ethernet/sel/ethtool.c
 create mode 100644 drivers/net/ethernet/sel/ethtool.h
 create mode 100644 drivers/net/ethernet/sel/hw_interface.c
 create mode 100644 drivers/net/ethernet/sel/hw_interface.h
 create mode 100644 drivers/net/ethernet/sel/mac_main.c
 create mode 100644 drivers/net/ethernet/sel/mdio.c
 create mode 100644 drivers/net/ethernet/sel/mdio.h
 create mode 100644 drivers/net/ethernet/sel/mii.c
 create mode 100644 drivers/net/ethernet/sel/mii.h
 create mode 100644 drivers/net/ethernet/sel/mii_interface.c
 create mode 100644 drivers/net/ethernet/sel/mii_interface.h
 create mode 100644 drivers/net/ethernet/sel/netdev.c
 create mode 100644 drivers/net/ethernet/sel/netdev.h
 create mode 100644 drivers/net/ethernet/sel/netdev_isr.c
 create mode 100644 drivers/net/ethernet/sel/netdev_isr.h
 create mode 100644 drivers/net/ethernet/sel/netdev_rx.c
 create mode 100644 drivers/net/ethernet/sel/netdev_rx.h
 create mode 100644 drivers/net/ethernet/sel/netdev_tx.c
 create mode 100644 drivers/net/ethernet/sel/netdev_tx.h
 create mode 100644 drivers/net/ethernet/sel/pci_mac.h
 create mode 100644 drivers/net/ethernet/sel/pci_mac_hw_regs.h
 create mode 100644 drivers/net/ethernet/sel/pci_mac_sysfs.c
 create mode 100644 drivers/net/ethernet/sel/pci_mac_sysfs.h
 create mode 100644 drivers/net/ethernet/sel/sel_pci_mac_ioctl.h
 create mode 100644 drivers/net/ethernet/sel/sel_phy.h
 create mode 100644 drivers/net/ethernet/sel/sel_phy_broadcom.c
 create mode 100644 drivers/net/ethernet/sel/sel_phy_broadcom.h
 create mode 100644 drivers/net/ethernet/sel/sel_phy_marvell.c
 create mode 100644 drivers/net/ethernet/sel/sel_phy_marvell.h
 create mode 100644 drivers/net/ethernet/sel/sel_phy_ti.c
 create mode 100644 drivers/net/ethernet/sel/sel_phy_ti.h
 create mode 100644 drivers/net/ethernet/sel/sel_soft_phy.c
 create mode 100644 drivers/net/ethernet/sel/sel_soft_phy.h
 create mode 100644 drivers/net/ethernet/sel/semaphore.h
 create mode 100644 drivers/net/ethernet/sel/sfp.c
 create mode 100644 drivers/net/ethernet/sel/sfp.h

-- 
2.45.2


